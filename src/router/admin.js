const express = require("express");
const router = express.Router();
const db = require("../utility/mysql");

router.get("/dashboard", async (req, res) => {
  // const { idAdmin } = req.body;
  const idAdmin = req.user.id_account_auth;

  const rowsAdminDt = await db.query(
    "SELECT * FROM admin WHERE id_admin = ?",
    [idAdmin]
  );

  const rowsMhsDT = await db.query(
    "SELECT * FROM mahasiswa"
  );

  const rowsBeasiswaDT = await db.query(
    "SELECT * FROM beasiswa_karir where jenis = 'beasiswa'"
  );

  const rowsKarirDT = await db.query(
    "SELECT * FROM beasiswa_karir where jenis = 'karir'"
  );

  const rowsPengaduanDT = await db.query(
    "SELECT * FROM pengaduan"
  );

  const adminData = rowsAdminDt[0];

  const totalMahasiswa = rowsMhsDT[0].length;
  const totalBeasiswa = rowsBeasiswaDT[0].length;
  const totalKarir = rowsKarirDT[0].length;
  const totalPengaduan = rowsPengaduanDT[0].length;

  console.log("total mahas: ", totalMahasiswa);
  console.log("mhsRows: ", rowsMhsDT);

  const fullData = {
    adminName: adminData.nama,
    accessLevel: adminData.access_level,
    totalDashboard: {
      mahasiswa: totalMahasiswa,
      beasiswa: totalBeasiswa,
      karir: totalKarir,
      pengaduan: totalPengaduan
    }
  }

  res.json({ message: `Dashboard data for admin ID: ${adminData.id_account}` , data: fullData });
});

module.exports = {
    router
}