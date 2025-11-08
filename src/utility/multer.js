const multer = require("multer");
const path = require("path");
const fs = require("fs");

const { generateShortId } = require("../router/auth");

// Setup storage multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const category = req.body.category || "uncategorized";
    const dir = `uploads/${category}`;
    // Buat folder kalau belum ada
    fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const category = req.body.category || "file";
    const fileHead = req.body.fileHead || "fileHead";
    const ext = path.extname(file.originalname);
    const uniqueCode = generateShortId(6);
    const filename = `${fileHead}-${uniqueCode}${ext}`;
    cb(null, filename);
  },
});

const upload = multer({
  storage,
  limits: { fileSize: 10 * 1024 * 1024 },
  fileFilter: (req, file, cb) => {
    const allowedTypes = /jpeg|jpg|png|webp|pdf|zip/;
    const ext = path.extname(file.originalname).toLowerCase();
    const mime = file.mimetype.toLowerCase();

    if (allowedTypes.test(ext) && allowedTypes.test(mime)) {
      cb(null, true);
    } else {
      cb(new Error("Tipe file tidak diperbolehkan."));
    }
  }
});

module.exports = {
    upload
}