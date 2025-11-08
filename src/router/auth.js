const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const crypto = require("crypto");

// Fungsi untuk buat ID unik pendek
function generateShortId(length = 6) {
  return crypto.randomBytes(length).toString("hex").slice(0, length);
}

const db = require("../utility/mysql");
const query = require("../utility/query");

const ACCESS_SECRET = process.env.JWT_SECRET;
const SECRET_REFRESH = process.env.JWT_SECRET_REFRESH;

router.post("/login/:role", async (req, res) => {
  const { username, password } = req.body;
  const role = req.params.role;

  const user = username;
  if (!user || !password) {
    return res.json({ message: "Semua field wajib diisi." });
  }

  switch (role) {
    case "mahasiswa": {
      // Regex sederhana
      const isEmail = user.includes("@");
      const isNim = /^\d+$/.test(user);

      if (isEmail) {
        const [rows] = await db.query(query.findUserAccountByNiUQ, [
          user,
          password,
        ]);

        if (rows.length <= 0) {
          return res.status(401).json({ error: "Login gagal" });
        }
        const userDb = rows[0][0];

        const accessToken = generateAccessToken(userDb);
        const refreshToken = generateRefreshToken(userDb);

        const [rowsDetch] = await db.query(
          "SELECT * FROM session_auth WHERE id_account_auth = ?",
          [userDb.id_auth]
        );

        if (rowsDetch.length <= 0) {
          const [rows1] = await db.query(
            "INSERT INTO session_auth (id_account_auth, refresh_token) VALUES (?, ?)",
            [userDb.id_auth, refreshToken]
          );
        } else {
          const [rows2] = await db.query(
            "UPDATE session_auth set refresh_token = ? WHERE id_account_auth = ?",
            [refreshToken, userDb.id_account]
          );
        }

        // kirim via cookie HttpOnly
        res.cookie("refreshToken", refreshToken, {
          httpOnly: true,
          secure: true, // set true kalau pakai https
          sameSite: "strict",
        });

        return res.json({ accessToken, message: "sukseed dengan email" });
      }

      if (isNim) {
        console.log("Input adalah nim:", user);

        const [rows] = await db.query(query.findUserAccountByNiUQ, [
          user,
          password,
        ]);
        // console.log("output db err1:", rows);

        if (rows.length <= 0) {
          return res.status(401).json({ error: "Login gagal" });
        }
        const userDb = rows[0][0];

        // untuk mendapatakan OUT dari procedure
        // const [status] = await db.query("call check_usedable_email(?, @dataOut)", [
        //   user,
        // ]);
        // const [statuslvl] = await db.query("select @dataOut as data");

        // console.log(statuslvl[0]?.data);

        const accessToken = generateAccessToken(userDb);
        const refreshToken = generateRefreshToken(userDb);

        // console.log("userDb.id_auth:", userDb);

        const [rowsDetch] = await db.query(
          "SELECT * FROM session_auth WHERE id_account_auth = ?",
          [userDb.id_auth]
        );

        if (rowsDetch.length <= 0) {
          // console.log("rows:", rows);
          // console.log("userDb:", userDb);
          // console.log("userDb.id_auth:", userDb.id_auth);
          const [rows1] = await db.query(
            "INSERT INTO session_auth (id_account_auth, refresh_token) VALUES (?, ?)",
            [userDb.id_auth, refreshToken]
          );
        } else {
          const [rows2] = await db.query(
            "UPDATE session_auth set refresh_token = ? WHERE id_account_auth = ?",
            [refreshToken, userDb.id_auth]
          );
        }

        // set nim for mahas after login
        res.cookie("idAccount", userDb.id_account, {
          httpOnly: true,
          secure: true, // set true kalau pakai https
          sameSite: "strict",
        });

        // kirim via cookie HttpOnly
        res.cookie("refreshToken", refreshToken, {
          httpOnly: true,
          secure: true, // set true kalau pakai https
          sameSite: "strict",
        });

        return res.json({ accessToken, message: "sukseed dengan nim" });
      }
      console.log("Input bukan email atau nim:", user);
      res.json({
        message: "anda seharusnya memasukkan email atau nomor-telepon",
        status: false,
      });
    }
      break;
    case "admin": {
      // Regex sederhana
      const isEmail = user.includes("@");
      const isPhoneNum = /^\d+$/.test(user);

      if (isEmail) {
        const [rows] = await db.query("select am.id_admin as id_account, act.id_account_auth as id_auth, am.nama as username from account_auth act JOIN admin am on act.id_account_auth = am.id_account_auth where email = ? AND password = ?", [
          user,
          password,
        ]);

        if (rows.length <= 0) {
          return res.status(401).json({ error: "Login gagal" });
        }
        const userDb = rows[0][0];

        const accessToken = generateAccessToken(userDb);
        const refreshToken = generateRefreshToken(userDb);

        const [rowsDetch] = await db.query(
          "SELECT * FROM session_auth WHERE id_account_auth = ?",
          [userDb.id_auth]
        );

        if (rowsDetch.length <= 0) {
          const [rows1] = await db.query(
            "INSERT INTO session_auth (id_account_auth, refresh_token) VALUES (?, ?)",
            [userDb.id_auth, refreshToken]
          );
        } else {
          const [rows2] = await db.query(
            "UPDATE session_auth set refresh_token = ? WHERE id_account_auth = ?",
            [refreshToken, userDb.id_account]
          );
        }

        // kirim via cookie HttpOnly
        res.cookie("refreshToken", refreshToken, {
          httpOnly: true,
          secure: true, // set true kalau pakai https
          sameSite: "strict",
        });

        return res.json({ accessToken, message: "sukseed dengan email" });
      }

      if (isPhoneNum) {
        console.log("Input adalah nomor:", user);

        const [rows] = await db.query("select am.id_admin as id_account, act.id_account_auth as id_auth, am.nama as username from account_auth act JOIN admin am on act.id_account_auth = am.id_account_auth where act.no_hp = ? AND act.password = ?", [
          user,
          password,
        ]);
        console.log("output db err1:", rows);

        if (rows.length <= 0) {
          return res.status(401).json({ error: "Login gagal" });
        }
        const userDb = rows[0];

        // untuk mendapatakan OUT dari procedure
        // const [status] = await db.query("call check_usedable_email(?, @dataOut)", [
        //   user,
        // ]);
        // const [statuslvl] = await db.query("select @dataOut as data");

        // console.log(statuslvl[0]?.data);

        const accessToken = generateAccessToken(userDb);
        const refreshToken = generateRefreshToken(userDb);

        // console.log("userDb.id_auth:", userDb);

        const [rowsDetch] = await db.query(
          "SELECT * FROM session_auth WHERE id_account_auth = ?",
          [userDb.id_auth]
        );

        if (rowsDetch.length <= 0) {
          // console.log("rows:", rows);
          // console.log("userDb:", userDb);
          // console.log("userDb.id_auth:", userDb.id_auth);
          const [rows1] = await db.query(
            "INSERT INTO session_auth (id_account_auth, refresh_token) VALUES (?, ?)",
            [userDb.id_auth, refreshToken]
          );
        } else {
          const [rows2] = await db.query(
            "UPDATE session_auth set refresh_token = ? WHERE id_account_auth = ?",
            [refreshToken, userDb.id_auth]
          );
        }

        // set nim for mahas after login
        res.cookie("idAccount", userDb.id_account, {
          httpOnly: true,
          secure: true, // set true kalau pakai https
          sameSite: "strict",
        });

        // kirim via cookie HttpOnly
        res.cookie("refreshToken", refreshToken, {
          httpOnly: true,
          secure: true, // set true kalau pakai https
          sameSite: "strict",
        });

        return res.json({ accessToken, message: "sukseed dengan nomor" });
      }
      console.log("Input bukan email atau nomor:", user);
      res.json({
        message: "anda seharusnya memasukkan email atau nomor-telepon",
        status: false,
      });
    }
      return;
    default:
      return res.status(400).json({ error: "Role tidak valid" });
  }
});

router.post("/refreshtoken/:role", async (req, res) => {
  const refreshToken = req.cookies.refreshToken;
  const role = req.params.role;

  if (!refreshToken) return res.sendStatus(401);

  // cek apakah refreshToken ada di DB
  //   const stored = refreshTokens.find((rt) => rt.token === refreshToken);
  // console.log("[refreshToken old]: ", refreshToken);
  // console.log(" ");
  const [rowsDetch] = await db.query(query.checkSessionByRefreshToken, [
    role,
    refreshToken,
  ]);
  if (rowsDetch.length <= 0) return res.sendStatus(403);

  // verifikasi token
  let userVerivied;
  jwt.verify(refreshToken, SECRET_REFRESH, async (err, user) => {
    if (err) return res.sendStatus(403);

    userVerivied = user;
  });
  // buat access token baru
  const accessToken = generateAccessToken(userVerivied);

  // ROTASI refresh token → buat baru, simpan, hapus yang lama
  const newRefreshToken = generateRefreshToken(userVerivied);
  // console.log("[refreshToken New]: ", newRefreshToken);

  const [rows2] = await db.query(
    "UPDATE session_auth set refresh_token = ? WHERE id_account_auth = ?",
    [newRefreshToken, userVerivied.id_auth]
  );

  // console.log("userVericied :", userVerivied);

  // console.log("rows2:", rows2);
  // refreshTokens = refreshTokens.filter((rt) => rt.token !== refreshToken);
  // refreshTokens.push({ token: newRefreshToken, userId: user.id });

  res.cookie("refreshToken", newRefreshToken, {
    httpOnly: true,
    secure: true,
    sameSite: "strict",
  });

  res.json({ accessToken });
});

// ------------------ Logout ------------------
router.post("/logout", async (req, res) => {
  const refreshToken = req.cookies.refreshToken;

  const [rows2] = await db.query(
    "delete from session_auth WHERE refresh_token = ?",
    [refreshToken]
  );
  //   refreshTokens = refreshTokens.filter((rt) => rt.token !== refreshToken);
  res.clearCookie("refreshToken");
  res.clearCookie("idAccount");
  res.sendStatus(204);
});

router.post("/register/:role", async (req, res) => {
  const dataRegistration = req.body;
  const role = req.params.role;

  // let nama, nim, programStudi, phoneNumber, email, password;
  // let aksesLevel;

  switch (role) {
    case "mahasiswa": {
      const { nama, nim, programStudi, phoneNumber, email, password } =
        dataRegistration;

      if (
        !nama ||
        !password ||
        !nim ||
        !programStudi ||
        !phoneNumber ||
        !email
      ) {
        return res.json({ message: "Semua field wajib diisi." });
      }

      // untuk mendapatakan OUT dari procedure
      await db.query("call check_usedable_email(?, @dataOut)", [email]);
      const [statuslvlEmail] = await db.query("select @dataOut as data");

      await db.query("call check_usedable_phone_num(?, @dataOut)", [
        phoneNumber,
      ]);
      const [statuslvlPhone] = await db.query("select @dataOut as data");

      // console.log('[email]', statuslvlEmail[0]?.data);
      // console.log('[phone]', statuslvlPhone[0]?.data);

      const isEmailUsed = statuslvlEmail[0]?.data == 0;
      const isPhoneUsed = statuslvlPhone[0]?.data == 0;

      if (isEmailUsed || isPhoneUsed) {
        // res.sendStatus(403);
        return res.status(401).json({
          message: "email, nim atau nomor sudah digunakan",
          status: false,
        });
      }
      //teast node
      // return res.json({ message: "test node", status: true });

      const [resultH] = await db.query(
        "call app_registration_mahasiswa(?,?,?,?,?,?,?)",
        [1, nama, nim, programStudi, phoneNumber, email, password]
      );

      if (resultH.affectedRows > 0) {
        return res.json({ message: "pendaftaran berhasil", status: true });
      }

      res.json({
        message: "something is wrong, [Register]",
        status: false,
      });
    }
      break;
    case "admin": {
      let { phoneNumber, email, password, nama, aksesLevel,  } =
        dataRegistration;

      //critical field set for testing
      aksesLevel = aksesLevel || "admin";

      if (
        !nama ||
        !password ||
        !email ||
        !aksesLevel ||
        !phoneNumber
      ) {
        return res.json({ message: "Semua field wajib diisi." });
      }

      // untuk mendapatakan OUT dari procedure
      await db.query("call check_usedable_email(?, @dataOut)", [email]);
      const [statuslvlEmail] = await db.query("select @dataOut as data");

      await db.query("call check_usedable_phone_num(?, @dataOut)", [
        phoneNumber,
      ]);
      const [statuslvlPhone] = await db.query("select @dataOut as data");

      // console.log('[email]', statuslvlEmail[0]?.data);
      // console.log('[phone]', statuslvlPhone[0]?.data);

      const isEmailUsed = statuslvlEmail[0]?.data == 0;
      const isPhoneUsed = statuslvlPhone[0]?.data == 0;

      if (isEmailUsed || isPhoneUsed) {
        return res.json({
          message: "email atau nomor sudah digunakan",
          status: false,
        });
      }
      //teast node
      // return res.json({ message: "test node", status: true });

      const [resultHA] = await db.query(
        "call app_registration_adminstrator(?,?,?,?,?,?)",
        [1, nama, aksesLevel, phoneNumber, email, password]
      );

      if (resultHA.affectedRows > 0) {
        return res.json({ message: "pendaftaran berhasil", status: true });
      }

      res.json({
        message: "something is wrong, [Register]",
        status: false,
      });
    }
      break;
    default:
      return res.status(400).json({ error: "Role tidak valid" });
  }

  // return res.json({ message: "Format tidak valid. Masukkan email atau nomor telepon." });
});

router.get("/authentication", authenticationToken, (req, res) => {
  console.log("req.user:", req.user);
  res.json({ message: "Autentikasi berhasil", user: req.user });
});

function generateAccessToken(user) {
  ////!!! tolong segera diubah ke versi global akses token tokennya jika tidak yang terjadi akan collapse ni server
  return jwt.sign(
    {
      id_auth: user.id_auth,
      username: user.username,
      id_account: user.id_account,
    },
    ACCESS_SECRET,
    {
      // expiresIn: "15m", // access token standar
      // expiresIn: "15s", // access token pendek, main function
      expiresIn: "1d", // access token pendek, main function
    }
  );
}

function generateRefreshToken(user) {
  return jwt.sign(
    {
      id_auth: user.id_auth,
      username: user.username,
      id_account: user.id_account,
    },
    SECRET_REFRESH,
    {
      expiresIn: "7d", // refresh token panjang
    }
  );
}

function authenticationToken(req, res, next) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1]; // ambil token setelah "Bearer"

  if (!token) return res.sendStatus(401);

  jwt.verify(token, ACCESS_SECRET, (err, user) => {
    if (err) return res.sendStatus(403); // token tidak valid

    // console.log("isi dari [user] di token:", user);
    req.user = user; // tempelkan info user di request
    next();
  });
}

module.exports = {
  router,
  generateAccessToken,
  authenticationToken,
  generateRefreshToken,
  generateShortId,
};
