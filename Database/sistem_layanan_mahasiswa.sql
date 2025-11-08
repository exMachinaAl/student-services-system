
-- Database: sistem_layanan_mahasiswa

CREATE DATABASE IF NOT EXISTS sistem_layanan_mahasiswa;
USE sistem_layanan_mahasiswa;

-- Tabel Mahasiswa
CREATE TABLE mahasiswa (
    id_mahasiswa INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(20) UNIQUE NOT NULL,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    jurusan VARCHAR(100),
    tahun_masuk YEAR
);

-- Tabel Admin / Kaprodi
CREATE TABLE admin (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','kaprodi') DEFAULT 'admin',
    nama VARCHAR(100)
);

-- Tabel Pengaduan
CREATE TABLE pengaduan (
    id_pengaduan INT AUTO_INCREMENT PRIMARY KEY,
    id_mahasiswa INT,
    judul VARCHAR(255) NOT NULL,
    kategori ENUM('Fasilitas','Akademik','Keuangan','Lainnya') NOT NULL,
    deskripsi TEXT,
    tanggal_pengajuan DATE DEFAULT CURRENT_DATE,
    status ENUM('Baru','Diproses','Selesai') DEFAULT 'Baru',
    FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa)
);

-- Tabel Feedback Admin untuk Pengaduan
CREATE TABLE feedback_pengaduan (
    id_feedback INT AUTO_INCREMENT PRIMARY KEY,
    id_pengaduan INT,
    id_admin INT,
    tanggal_feedback TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    respons TEXT,
    FOREIGN KEY (id_pengaduan) REFERENCES pengaduan(id_pengaduan),
    FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
);

-- Tabel Beasiswa & Karir
CREATE TABLE beasiswa_karir (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    jenis ENUM('Beasiswa','Karir') NOT NULL,
    judul VARCHAR(255) NOT NULL,
    penyedia VARCHAR(255),
    lokasi VARCHAR(255),
    deskripsi TEXT,
    link VARCHAR(255),
    deadline DATE,
    tanggal_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_admin INT,
    FOREIGN KEY (id_admin) REFERENCES admin(id_admin)
);

-- Tabel Favorit Mahasiswa (Bookmark Beasiswa & Karir)
CREATE TABLE favorit (
    id_favorit INT AUTO_INCREMENT PRIMARY KEY,
    id_mahasiswa INT,
    id_item INT,
    tanggal_disimpan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa),
    FOREIGN KEY (id_item) REFERENCES beasiswa_karir(id_item)
);

-- Tabel Riwayat Akses / Log
CREATE TABLE log_akses (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    role ENUM('mahasiswa','admin','kaprodi'),
    aktivitas VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
