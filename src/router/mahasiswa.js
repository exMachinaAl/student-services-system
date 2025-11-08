const express = require("express");
const router = express.Router();
const fs = require("fs/promises");

const db = require("../utility/mysql");
const query = require("../utility/query");
const { upload } = require("../utility/multer");


router.get("/profile", async (req, res) => {
  res.json({ username: req.user.username, nim: req.user.id_account });
})

router.get("/dashboard", async (req, res) => {
  // const nim = req.user.id_account;

  const [roews] = await db.query(
    "call count_mahasiswa_dashboard(?, @Qpengaduan, @Qbeasiswa, @Qkarir)",
    [req.user.id_account]
  );

  if (roews.length <= 0) {
    return res.status(401).json({ error: "Data tidak ditemukan" });
  }

  const [countDataDashboard] = await db.query(
    "select @Qpengaduan as totalPengaduan, @Qbeasiswa as totalBeasiswa, @Qkarir as totalKarir"
  );

  const Mbss1 = await db.query(query.getBeasiswaKarirShowOnly, ["Beasiswa", 4]);
  const Mkrr1 = await db.query(query.getBeasiswaKarirShowOnly, ["Karir", 4]);

  const beasiswaTersedia = attachImageURL({ beasiswa: Mbss1[0] });
  const karirTersedia = attachImageURL({ karir: Mkrr1[0] });

  const Mtpo1 = await db.query(query.getPengaduanTopByNim, [
    req.user.id_account,
    3,
  ]);
  // console.log(Mtpo1);

  const topPengaduan = attachDate({ pengaduan: Mtpo1[0] });

  // const imageUrl = files.map(f => ({
  //   url: `/uploads/${f.category}/${f.filename}`
  // }));

  res.json({
    user: req.user.username,
    message: `berhasil;`,
    dashboardCount: countDataDashboard[0],
    beasiswa: beasiswaTersedia.beasiswa,
    karir: karirTersedia.karir,
    pengaduan: topPengaduan.pengaduan,
  });
});

function attachImageURL(categories, basePath = "/uploads") {
  const result = {};

  for (const [key, arr] of Object.entries(categories)) {
    result[key] = arr.map((item) => ({
      ...item,
      logoUrl: item.code_logo ? `${basePath}/${key}/${item.code_logo}` : null,
      bannerUrl: item.code_banner
        ? `${basePath}/${key}/${item.code_banner}`
        : null,
    }));
  }

  return result;
}

function attachDate(rawDate) {
  const result = {};

  for (const [key, arr] of Object.entries(rawDate)) {
    result[key] = arr.map((item) => ({
      ...item,
      tanggal_pengajuan: item.tanggal_pengajuan
        ? new Date(item.tanggal_pengajuan).toLocaleDateString("id-ID", {
            day: "2-digit",
            month: "long",
            year: "numeric",
          })
        : null,
    }));
  }
  return result;
}

router.post("/pengaduan", async (req, res) => {
  let { isAnonim, nama, nim, kategori, deskripsi } = req.body;

  // get data mahas from auth
  nama = req.user.username;
  nim = req.user.id_account;

  if (isAnonim === undefined || !kategori || !deskripsi) {
    return res.json({ message: "Semua field wajib diisi." });
  }

  if (isAnonim) isAnonim = 1;

  const [rows] = await db.query(
    "INSERT INTO pengaduan (isAnonim, id_mahasiswa, kategori, deskripsi) VALUES (?, ?, ?, ?)",
    [isAnonim, nim, kategori, deskripsi]
  );

  if (rows.affectedRows <= 0) {
    return res.status(500).json({ error: "Gagal mengirim pengaduan." });
  }

  if (isAnonim) {
    return res.json({ message: "Pengaduan berhasil dikirim secara anonim." });
  }

  res.json({ message: "Pengaduan berhasil dikirim." });
});

router.get("/beasiswa-detail", async (req, res) => {
  const { id_beasiswa } = req.query;

  const rowsBeasiswa = await db.query(
    "SELECT * FROM beasiswa_karir WHERE id_item = ? AND jenis = 'Beasiswa'",
    [id_beasiswa]
  );

  const rowsLimitKuotaBeasiswa = await db.query(
    "call check_limit_daftar_beasiswa(?)",
    [id_beasiswa]
  );

  // console.log("isisan: ", rowsBeasiswa)
  // console.log("length: ", rowsBeasiswa[0].length)
  if (rowsBeasiswa[0].length <= 0) {
    return res.status(404).json({ message: "Beasiswa tidak ditemukan." });
  }

  const item = rowsBeasiswa[0][0];
  const kuotaInfo = rowsLimitKuotaBeasiswa[0][0][0]?.kuota_tersisa;
  // console.log(rowsLimitKuotaBeasiswa)

  const tanggal_upload = dbDate2IndoDate(item?.tanggal_upload)
  const deadline = dbDate2IndoDate(item?.deadline)

  const dataBeasiswaNormalize = {
    ...item,
    tanggal_upload,
    deadline,
    logoUrl: item?.code_logo ? `uploads/beasiswa/${item.code_logo}` : null,
    bannerUrl: item?.code_banner ? `uploads/beasiswa/${item.code_banner}` : null,
    kuotaTersisa: kuotaInfo,
  };

  res.json({
    dataBeasiswaNormalize,
  });
});

function dbDate2IndoDate(dbDate) {
  return new Date(dbDate).toLocaleDateString("id-ID", {
    day: "2-digit",
    month: "long",
    year: "numeric",
  });
}

router.post(
  "/beasiswa-daftar",
  upload.fields([
    { name: "ktm", maxCount: 1 },
    { name: "transkrip_nilai", maxCount: 1 },
    { name: "krs", maxCount: 1 },
    { name: "surat_rekomendasi", maxCount: 1 },
  ]),
  async (req, res) => {
    try {
      const data = req.body;
      const files = req.files;

      const { idBeasiswa, nama, nim, prodi, semester, ipk } = data;

      const Vnim = req.user.id_account;

      // if (!nama || !nim || !prodi || !semester || !ipk) {
      //   return res.json({ message: "Semua field wajib diisi." });
      // }

      if (Vnim !== nim) {
        await removeInvalidFile(req);
        return res.json({
          message:
            "NIM tidak sesuai dengan data akun dan dilarang mendaftarkan orang lain.",
        });
      }

      const ktmFile =
        files.ktm?.[0]?.filename.split("-")[3].split(".")[0] || null;
      const transkripNil =
        files.transkrip_nilai?.[0]?.filename.split("-")[3].split(".")[0] ||
        null;
      const krsFile =
        files.krs?.[0]?.filename.split("-")[3].split(".")[0] || null;
      const rekomendasiFile =
        files.surat_rekomendasi?.[0]?.filename.split("-")[3].split(".")[0] ||
        null;

      const [mhsValidationRGST] = await db.query(
        "call check_is_registered_beasiswa(? , ?)",
        [idBeasiswa, nim]
      );

      const [mhsValidationLimit] = await db.query(
        "call check_limit_daftar_beasiswa(?)",
        [idBeasiswa]
      );

      if (mhsValidationRGST[0][0].is_registered >= 1) {
        await removeInvalidFile(req);
        return res.json({
          message:
            "Pendaftaran beasiswa gagal. Anda sudah pernah mendaftar beasiswa ini.",
          status: 0,
        });
      }

      if (mhsValidationLimit[0][0].kuota_tersisa <= 0) {
        await removeInvalidFile(req);
        return res.json({
          message: "Pendaftaran beasiswa gagal. Kuota pendaftaran telah penuh.",
          status: 0,
        });
      }

      const [rows] = await db.query(
        "INSERT INTO pendaftar_beasiswa (id_mahasiswa, id_beasiswa, code_beasiswa_ktm, code_beasiswa_transkrip_nilai_terbaru, code_beasiswa_rekomendasi, code_beasiswa_krs) VALUES (?, ?, ?, ?, ?, ?)",
        [nim, idBeasiswa, ktmFile, transkripNil, rekomendasiFile, krsFile]
      );

      res.json({ message: "Pendaftaran beasiswa berhasil." });
    } catch (error) {
      console.error("Error during beasiswa registration:", error);
      await removeInvalidFile(req);
      res.status(500).json({ message: "Internal server error." });
    }
  }
);

router.get("/karir-detail", async (req, res) => {
  const { id_karir } = req.query;

  const rowsBeasiswaKarir = await db.query(
    "SELECT * FROM beasiswa_karir WHERE id_item = ? AND jenis = 'Karir'",
    [id_karir]
  );

  const rowsLimitKuotaKarir = await db.query(
    "call check_limit_daftar_karir(?)",
    [id_karir]
  );

  // console.log("isisan: ", rowsBeasiswaKarir)
  // console.log("length: ", rowsBeasiswaKarir[0].length)
  if (rowsBeasiswaKarir[0].length <= 0) {
    return res.status(404).json({ message: "karir tidak ditemukan." });
  }

  const item = rowsBeasiswaKarir[0][0];
  const kuotaInfo = rowsLimitKuotaKarir[0][0][0]?.kuota_tersisa;
  // console.log(rowsLimitKuotaBeasiswa)

  const tanggal_upload = dbDate2IndoDate(item?.tanggal_upload)
  const deadline = dbDate2IndoDate(item?.deadline)

  const dataKarirNormalize = {
    ...item,
    tanggal_upload,
    deadline,
    logoUrl: item?.code_logo ? `uploads/karir/${item.code_logo}` : null,
    bannerUrl: item?.code_banner ? `uploads/karir/${item.code_banner}` : null,
    kuotaTersisa: kuotaInfo,
  };

  res.json({
    dataKarirNormalize,
  });
});

router.post(
  "/karir-daftar",
  upload.fields([
    { name: "CVResume", maxCount: 1 },
    { name: "suratLamar", maxCount: 1 },
    { name: "portofolio", maxCount: 1 },
    { name: "sertifPendukung", maxCount: 1 },
  ]),
  async (req, res) => {
    try {
      const data = req.body;
      const files = req.files;

      const { idKarir, nama, nim, prodi, semester, ipk } = data;

      const Vnim = req.user.id_account;

      // if (!nama || !nim || !prodi || !semester || !ipk) {
      //   return res.json({ message: "Semua field wajib diisi." });
      // }

      if (Vnim !== nim) {
        await removeInvalidFile(req);
        return res.json({
          message:
            "NIM tidak sesuai dengan data akun dan dilarang mendaftarkan orang lain.",
        });
      }

      const CVResume =
        files.CVResume?.[0]?.filename.split("-")[3].split(".")[0] || null;
      const suratLamar =
        files.suratLamar?.[0]?.filename.split("-")[3].split(".")[0] || null;
      const portofolio =
        files.portofolio?.[0]?.filename.split("-")[3].split(".")[0] || null;
      const sertifPendukung =
        files.sertifPendukung?.[0]?.filename.split("-")[3].split(".")[0] ||
        null;

      const [mhsValidationRGST] = await db.query(
        "call check_is_registered_karir(? , ?)",
        [idKarir, nim]
      );

      const [mhsValidationLimit] = await db.query(
        "call check_limit_daftar_karir(?)",
        [idKarir]
      );

      if (mhsValidationRGST[0][0].is_registered >= 1) {
        await removeInvalidFile(req);
        return res.json({
          message:
            "Pendaftaran karir gagal. Anda sudah pernah mendaftar karir ini.",
          status: 0,
        });
      }

      if (mhsValidationLimit[0][0].kuota_tersisa <= 0) {
        await removeInvalidFile(req);
        return res.json({
          message: "Pendaftaran karir gagal. Kuota pendaftaran telah penuh.",
          status: 0,
        });
      }

      const [rows] = await db.query(
        "INSERT INTO pendaftar_karir (id_mahasiswa, id_karir, code_karir_cv, code_karir_surat_lamaran, code_karir_portofolio, code_karir_sertif_pendukung) VALUES (?, ?, ?, ?, ?, ?)",
        [nim, idKarir, CVResume, suratLamar, portofolio, sertifPendukung]
      );

      res.json({ message: "Pendaftaran karir berhasil." });
    } catch (error) {
      console.error("Error during karir registration:", error);
      await removeInvalidFile(req);
      res.status(500).json({ message: "Internal server error." });
    }
  }
);

/* 
  Utility for authentication mahasiswa
*/
async function removeInvalidFile(req) {
  const files = [];

  if (req.file) files.push(req.file); // single upload
  if (req.files) {
    for (const field in req.files) {
      files.push(...req.files[field]);
    }
  }

  for (const file of files) {
    try {
      await fs.unlink(file.path);
    } catch (err) {
      console.warn("Gagal hapus file:", file.path);
    }
  }
}

module.exports = { router };
