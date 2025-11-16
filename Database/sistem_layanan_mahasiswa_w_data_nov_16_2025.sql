/*
 Navicat Premium Dump SQL

 Source Server         : project bertahan hidup
 Source Server Type    : MariaDB
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : sistem_layanan_mahasiswa

 Target Server Type    : MariaDB
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 16/11/2025 19:05:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_auth
-- ----------------------------
DROP TABLE IF EXISTS `account_auth`;
CREATE TABLE `account_auth`  (
  `id_account_auth` bigint(255) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `no_hp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_account_auth`) USING BTREE,
  UNIQUE INDEX `id_acc_emil37`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account_auth
-- ----------------------------
INSERT INTO `account_auth` VALUES (1, 'gamet@qiuqiu.sh', '083830560001', '1234', 'mahasiswa');
INSERT INTO `account_auth` VALUES (2, 'sanqiu119@mail.eh', '085672381928', '1234', 'mahasiswa');
INSERT INTO `account_auth` VALUES (3, 'ronggi@mail.id', '081234567890', 'manok', 'mahasiswa');
INSERT INTO `account_auth` VALUES (4, 'admin1@mail.co', '080000000001', '123', 'admin');
INSERT INTO `account_auth` VALUES (5, 'wakwie1@mail.id', '081234567891', '1234', 'admin');
INSERT INTO `account_auth` VALUES (6, 'alviandika93@gmail.com', '0971223313', 'dikagab=nteng', 'mahasiswa');
INSERT INTO `account_auth` VALUES (7, 'abby@gmail.com', '081233224', 'abbyganteng', 'mahasiswa');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id_admin` int(11) NOT NULL AUTO_INCREMENT,
  `id_account_auth` bigint(20) NULL DEFAULT NULL,
  `access_level` enum('admin','kaprodi') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'admin',
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_admin`) USING BTREE,
  UNIQUE INDEX `id_account_auth_cc183`(`id_account_auth`) USING BTREE,
  CONSTRAINT `id_account_auth_vc3920` FOREIGN KEY (`id_account_auth`) REFERENCES `account_auth` (`id_account_auth`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 4, 'admin', 'abby');
INSERT INTO `admin` VALUES (2, 5, 'admin', 'wak cnil ajaw');

-- ----------------------------
-- Table structure for beasiswa_karir
-- ----------------------------
DROP TABLE IF EXISTS `beasiswa_karir`;
CREATE TABLE `beasiswa_karir`  (
  `id_item` int(11) NOT NULL AUTO_INCREMENT,
  `jenis` enum('Beasiswa','Karir') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kejuruan` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `penyedia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `lokasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deadline` date NULL DEFAULT NULL,
  `tanggal_upload` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_admin` int(11) NULL DEFAULT NULL,
  `code_banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `limit_daftar` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id_item`) USING BTREE,
  INDEX `id_admin`(`id_admin`) USING BTREE,
  CONSTRAINT `beasiswa_karir_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of beasiswa_karir
-- ----------------------------
INSERT INTO `beasiswa_karir` VALUES (1, 'Karir', 'teknik sihir', 'Ngoding/RGB', 'PT cs Latex', 'jalan ron, rt 1, rw 2, gresik, underground', 'membuka lowongan untuk ngoret - ngoret dinding, yak kek gitu', 'http://localhost:3000/link', '2025-10-30', '2025-10-16 08:11:14', 1, 'mcsskfeifmeifoaskamkaf12rfff.jpg', 'eeeee.jpg', 5);
INSERT INTO `beasiswa_karir` VALUES (2, 'Beasiswa', 'all', 'Beasiswa MBG', 'PT monokotil', 'jalan ron, rt 1, rw 2, gresik, foreground', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 'http://localhost:3000/link', '2025-10-24', '2025-10-16 09:28:02', 1, 'xmskxoasdfofefeofnefefeiofap3298140wmd.jpg', 'eeeee.jpg', 5);
INSERT INTO `beasiswa_karir` VALUES (3, 'Beasiswa', 'all', 'Analys/crypt', 'ARC arcedia', 'jalan ron, rt 1, rw 2, gresik, background', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 'http://localhost:3000/link', '2025-10-30', '2025-10-23 22:51:41', 1, 'sdmnasx3rin3nmfekfmldsapeirt4rvcr.jpg', 'eeeee.jpg', 1);
INSERT INTO `beasiswa_karir` VALUES (4, 'Beasiswa', 'all', 'miner/btc', 'ARC arcedia', NULL, NULL, NULL, '2025-10-30', '2025-10-23 22:55:19', 1, 'sdmnasx3rin3nmr5yrwe423tghfekfmldsapeirt4dgsrvcr.jpg', 'eeeee.jpg', 3);

-- ----------------------------
-- Table structure for favorit
-- ----------------------------
DROP TABLE IF EXISTS `favorit`;
CREATE TABLE `favorit`  (
  `id_favorit` int(11) NOT NULL AUTO_INCREMENT,
  `id_mahasiswa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `id_item` int(11) NULL DEFAULT NULL,
  `tanggal_disimpan` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_favorit`) USING BTREE,
  UNIQUE INDEX `id_mahasAc12`(`id_mahasiswa`) USING BTREE,
  INDEX `id_item`(`id_item`) USING BTREE,
  CONSTRAINT `favorit_ibfk_2` FOREIGN KEY (`id_item`) REFERENCES `beasiswa_karir` (`id_item`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `id_mahas_bz382` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`nim`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favorit
-- ----------------------------

-- ----------------------------
-- Table structure for feedback_pengaduan
-- ----------------------------
DROP TABLE IF EXISTS `feedback_pengaduan`;
CREATE TABLE `feedback_pengaduan`  (
  `id_feedback` int(11) NOT NULL AUTO_INCREMENT,
  `id_pengaduan` int(11) NULL DEFAULT NULL,
  `id_admin` int(11) NULL DEFAULT NULL,
  `tanggal_feedback` timestamp NOT NULL DEFAULT current_timestamp(),
  `respons` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_feedback`) USING BTREE,
  INDEX `id_pengaduan`(`id_pengaduan`) USING BTREE,
  INDEX `id_admin`(`id_admin`) USING BTREE,
  CONSTRAINT `feedback_pengaduan_ibfk_1` FOREIGN KEY (`id_pengaduan`) REFERENCES `pengaduan` (`id_pengaduan`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `feedback_pengaduan_ibfk_2` FOREIGN KEY (`id_admin`) REFERENCES `admin` (`id_admin`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback_pengaduan
-- ----------------------------

-- ----------------------------
-- Table structure for kaprodi
-- ----------------------------
DROP TABLE IF EXISTS `kaprodi`;
CREATE TABLE `kaprodi`  (
  `id_kaprodi` bigint(50) NOT NULL AUTO_INCREMENT,
  `id_account_auth` bigint(255) NOT NULL,
  `nama` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kepala_prodi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_kaprodi`) USING BTREE,
  UNIQUE INDEX `id_account_auth_nb34`(`id_account_auth`) USING BTREE,
  CONSTRAINT `id_account_auth_bn55` FOREIGN KEY (`id_account_auth`) REFERENCES `account_auth` (`id_account_auth`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kaprodi
-- ----------------------------

-- ----------------------------
-- Table structure for log_akses
-- ----------------------------
DROP TABLE IF EXISTS `log_akses`;
CREATE TABLE `log_akses`  (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NULL DEFAULT NULL,
  `role` enum('mahasiswa','admin','kaprodi') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `aktivitas` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_log`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log_akses
-- ----------------------------

-- ----------------------------
-- Table structure for mahasiswa
-- ----------------------------
DROP TABLE IF EXISTS `mahasiswa`;
CREATE TABLE `mahasiswa`  (
  `nim` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_account_auth` bigint(255) NULL DEFAULT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `jurusan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tahun_masuk` year NULL DEFAULT NULL,
  PRIMARY KEY (`nim`) USING BTREE,
  INDEX `id_acc_auth120`(`id_account_auth`) USING BTREE,
  CONSTRAINT `id_acc_authbr32` FOREIGN KEY (`id_account_auth`) REFERENCES `account_auth` (`id_account_auth`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mahasiswa
-- ----------------------------
INSERT INTO `mahasiswa` VALUES ('230602009', 3, 'baihaqi el qowalsqi', 'Teknik Informatika', '1', 2025);
INSERT INTO `mahasiswa` VALUES ('230602010', 1, 'Jordan alexander dolphin', 'teknik pertarungan', '1', 2023);
INSERT INTO `mahasiswa` VALUES ('230602016', 2, 'Sandor de veron', 'teknik sihir', '1', 2025);
INSERT INTO `mahasiswa` VALUES ('230602057', 7, 'abby', 'informatika', '1', 2025);
INSERT INTO `mahasiswa` VALUES ('230602069', 6, 'alvian ramandika', 'informatika', '1', 2025);

-- ----------------------------
-- Table structure for pendaftar_beasiswa
-- ----------------------------
DROP TABLE IF EXISTS `pendaftar_beasiswa`;
CREATE TABLE `pendaftar_beasiswa`  (
  `id_pendaftar_beasiswa` bigint(255) NOT NULL AUTO_INCREMENT,
  `id_mahasiswa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `id_beasiswa` int(11) NULL DEFAULT NULL,
  `code_beasiswa_ktm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_beasiswa_transkrip_nilai_terbaru` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_beasiswa_rekomendasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_beasiswa_krs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_pendaftar_beasiswa`) USING BTREE,
  INDEX `id_mahasn2384`(`id_mahasiswa`) USING BTREE,
  INDEX `id_item_bsw3n93`(`id_beasiswa`) USING BTREE,
  CONSTRAINT `id_item_bsw38nd` FOREIGN KEY (`id_beasiswa`) REFERENCES `beasiswa_karir` (`id_item`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `id_mahsN2rn3` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`nim`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pendaftar_beasiswa
-- ----------------------------
INSERT INTO `pendaftar_beasiswa` VALUES (18, '230602010', 3, '10672e', 'acaf62', '9aeb19', '75dffa');

-- ----------------------------
-- Table structure for pendaftar_karir
-- ----------------------------
DROP TABLE IF EXISTS `pendaftar_karir`;
CREATE TABLE `pendaftar_karir`  (
  `id_pendaftar_karir` int(11) NOT NULL AUTO_INCREMENT,
  `id_mahasiswa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `id_karir` int(11) NULL DEFAULT NULL,
  `code_karir_cv` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_karir_surat_lamaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_karir_portofolio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `code_karir_sertif_pendukung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_pendaftar_karir`) USING BTREE,
  INDEX `id_karirbs21`(`id_karir`) USING BTREE,
  INDEX `id_mahasiswaNsjf322`(`id_mahasiswa`) USING BTREE,
  CONSTRAINT `id_karir_dnme231` FOREIGN KEY (`id_karir`) REFERENCES `beasiswa_karir` (`id_item`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `id_mahas_sid3214` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`nim`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pendaftar_karir
-- ----------------------------

-- ----------------------------
-- Table structure for pengaduan
-- ----------------------------
DROP TABLE IF EXISTS `pengaduan`;
CREATE TABLE `pengaduan`  (
  `id_pengaduan` int(11) NOT NULL AUTO_INCREMENT,
  `id_mahasiswa` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `isAnonim` tinyint(4) NULL DEFAULT NULL,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kategori` enum('Fasilitas','Akademik','Keuangan','Lainnya') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_pengajuan` date NULL DEFAULT curdate(),
  `status` enum('Baru','Diproses','Selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Baru',
  PRIMARY KEY (`id_pengaduan`) USING BTREE,
  INDEX `id_mahas2184`(`id_mahasiswa`) USING BTREE,
  CONSTRAINT `id_mahas_ab54` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`nim`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pengaduan
-- ----------------------------
INSERT INTO `pengaduan` VALUES (1, '230602010', 0, 'dilorong ada yang jualan kecubung', 'Lainnya', 'jadi gini cuy, tadi gw digebukin gegara nyenggol mobil, nah dia ngadu', '2025-10-15', 'Baru');
INSERT INTO `pengaduan` VALUES (2, '230602016', 0, '', 'Fasilitas', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '2025-10-16', 'Baru');
INSERT INTO `pengaduan` VALUES (3, '230602016', 0, '', 'Fasilitas', 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', '2025-10-16', 'Baru');
INSERT INTO `pengaduan` VALUES (4, '230602010', 1, '', 'Fasilitas', 'Fasilitas di kampus kureng, padahal dah bayar ukt mahal.', '2025-10-23', 'Baru');
INSERT INTO `pengaduan` VALUES (5, '230602010', 0, '', 'Akademik', 'xeied ekefko mmmm osl 5555.', '2025-10-23', 'Baru');
INSERT INTO `pengaduan` VALUES (6, '230602010', 1, '', 'Akademik', 'jadi gini gan, Η Γεννήτρια Τυχαίων Λέξεων είναι ένα εργαλείο που σας βοηθά να δημιουργήσετε μια λίστα με τυχαίες λέξεις. Υπάρχουν πολλοί λόγοι για τους οποίους κάποιος μπορεί να ενδιαφέρεται να το κάνει αυτό..', '2025-10-24', 'Baru');

-- ----------------------------
-- Table structure for petugas
-- ----------------------------
DROP TABLE IF EXISTS `petugas`;
CREATE TABLE `petugas`  (
  `id_petugas` bigint(40) NULL DEFAULT NULL,
  `id_account_auth` bigint(20) NULL DEFAULT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `prodi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  UNIQUE INDEX `id_account_auth_zc73`(`id_account_auth`) USING BTREE,
  CONSTRAINT `id_account_auth_bv732` FOREIGN KEY (`id_account_auth`) REFERENCES `account_auth` (`id_account_auth`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of petugas
-- ----------------------------

-- ----------------------------
-- Table structure for riwayat_mahasiswa
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_mahasiswa`;
CREATE TABLE `riwayat_mahasiswa`  (
  `id_riwayat_mahasiswa` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_mahasiswa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kategori_aktivitas` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `judul_aktivitas` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `deskripsi_aktivitas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `waktu_aktivitas` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_riwayat_mahasiswa`) USING BTREE,
  INDEX `idm_lavel39rn`(`id_mahasiswa`) USING BTREE,
  CONSTRAINT `idm_le_mof9310` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`nim`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of riwayat_mahasiswa
-- ----------------------------
INSERT INTO `riwayat_mahasiswa` VALUES (1, '230602010', 'pengaduan', 'mengadukan aktivias kotor', 'ξαδι ταδι σαυα μελιηατ αδα μαηασισςα λαγι ενα ενα δι ποξοκαν πακ, ταθνυα ηανυθ νγθλθμ χοντολ', '2025-11-14 01:52:21');
INSERT INTO `riwayat_mahasiswa` VALUES (2, '230602010', 'pengaduan', 'melihat kejanggalan mas eki dan dani', 'σεξθξθρνυα υα πακ, συ κθρανγ ταθ, ταπι ταθ ταθ νιη υα, δθη γακ ταθ λαγι λαη ποκοκνυα', '2025-11-14 01:58:26');

-- ----------------------------
-- Table structure for session_auth
-- ----------------------------
DROP TABLE IF EXISTS `session_auth`;
CREATE TABLE `session_auth`  (
  `id_session` int(255) NOT NULL AUTO_INCREMENT,
  `id_account_auth` bigint(255) NOT NULL,
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_session`) USING BTREE,
  UNIQUE INDEX `id_account_auth_foreigncdb321`(`id_account_auth`) USING BTREE,
  CONSTRAINT `id_account_auth_sc283` FOREIGN KEY (`id_account_auth`) REFERENCES `account_auth` (`id_account_auth`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of session_auth
-- ----------------------------
INSERT INTO `session_auth` VALUES (21, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF9hdXRoIjoxLCJ1c2VybmFtZSI6IkpvcmRhbiBhbGV4YW5kZXIgZG9scGhpbiIsImlkX2FjY291bnQiOiIyMzA2MDIwMTAiLCJpYXQiOjE3NjMwNTczMzIsImV4cCI6MTc2MzY2MjEzMn0.hF4yVo8WMLcqZsEsu4Arn-gqsd67wVGLfwbbk5gSqVw');
INSERT INTO `session_auth` VALUES (24, 5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF9hdXRoIjo1LCJ1c2VybmFtZSI6IndhayBjbmlsIGFqYXciLCJpZF9hY2NvdW50IjoyLCJpYXQiOjE3NjE5MTgyNzIsImV4cCI6MTc2MjUyMzA3Mn0.xiKGMLUy1xgJ_A85fFUQxXaVcEq-8IzTvm_7Wx-G3pk');

-- ----------------------------
-- Table structure for unused_mahasiswa_beasiswa
-- ----------------------------
DROP TABLE IF EXISTS `unused_mahasiswa_beasiswa`;
CREATE TABLE `unused_mahasiswa_beasiswa`  (
  `id_beasiswa` bigint(30) NOT NULL AUTO_INCREMENT,
  `penyedia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_buka` datetime NULL DEFAULT NULL,
  `tanggal_tutup` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id_beasiswa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unused_mahasiswa_beasiswa
-- ----------------------------

-- ----------------------------
-- Table structure for unused_mahasiswa_karir
-- ----------------------------
DROP TABLE IF EXISTS `unused_mahasiswa_karir`;
CREATE TABLE `unused_mahasiswa_karir`  (
  `id_karir` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipe_pekerjaan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `pt_penyedia` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_buka` datetime NULL DEFAULT NULL,
  `tanggal_tutup` datetime NULL DEFAULT NULL,
  `judul` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `lokasi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_karir`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unused_mahasiswa_karir
-- ----------------------------
INSERT INTO `unused_mahasiswa_karir` VALUES (1, 'programer', 'PT to love to', '2025-10-16 07:54:24', '2025-10-31 07:54:32', NULL, NULL);

-- ----------------------------
-- View structure for all_account
-- ----------------------------
DROP VIEW IF EXISTS `all_account`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `all_account` AS SELECT act.id_account_auth, mhs.nama FROM account_auth act LEFT JOIN mahasiswa mhs ON act.id_account_auth = mhs.id_account_auth ;

-- ----------------------------
-- Procedure structure for app_registration_adminstrator
-- ----------------------------
DROP PROCEDURE IF EXISTS `app_registration_adminstrator`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `app_registration_adminstrator`(IN opsi BOOL, IN Snama VARCHAR(255), IN Sakses_level VARCHAR(255), IN SphoneNum VARCHAR(255), IN Semail VARCHAR(255), IN Spassword VARCHAR(255))
BEGIN
  -- 1 untuk admin
  -- 2 untuk kaprodi
  
  IF opsi = 1 THEN
    INSERT INTO account_auth (email, no_hp, password, role) VALUES (Semail, SphoneNum, Spassword, 'admin');
    
    INSERT INTO admin (id_account_auth, nama, access_level) VALUES (LAST_INSERT_ID(), Snama, Sakses_level);
  ELSEIF opsi = 2 THEN
    SELECT CONCAT("belum bisa");
  ELSE
    SELECT CONCAT("keluar tanpa error");
  END IF;
  
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for app_registration_mahasiswa
-- ----------------------------
DROP PROCEDURE IF EXISTS `app_registration_mahasiswa`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `app_registration_mahasiswa`(IN opsi BOOL, IN Snama VARCHAR(255), IN Snim VARCHAR(255), IN Sprodi VARCHAR(255), IN SphoneNum VARCHAR(255), IN Semail VARCHAR(255), IN Spassword VARCHAR(255))
BEGIN
  
  DECLARE U_QUID VARCHAR(255);
  
  set U_QUID = CONCAT('user', ((SELECT nim FROM mahasiswa ORDER BY nim desc LIMIT 1) + 1));
  
  IF opsi = 1 THEN
    INSERT INTO account_auth (email, no_hp, password, role) VALUES (Semail, SphoneNum, Spassword, 'mahasiswa');
    INSERT INTO mahasiswa (nim, id_account_auth, nama, jurusan, status, tahun_masuk) VALUES (Snim, LAST_INSERT_ID(), Snama, Sprodi, '1', YEAR(CURDATE()));
--     SELECT * FROM mahasiswa;
  ELSEIF opsi = 2 THEN
    SELECT CONCAT("belum bisa");
  ELSE
    SELECT CONCAT("keluar tanpa error");
  END IF;
  
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for auth_search_by_account_uniq
-- ----------------------------
DROP PROCEDURE IF EXISTS `auth_search_by_account_uniq`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `auth_search_by_account_uniq`(IN p_unique_id VARCHAR(50),
    IN p_password VARCHAR(100))
BEGIN

  DECLARE c_mahasiswa_count INT;

  SELECT COUNT(*) into c_mahasiswa_count FROM mahasiswa mhs JOIN account_auth act WHERE mhs.nim =    p_unique_id AND act.password = p_password;


  IF c_mahasiswa_count > 0 THEN
    SELECT act.role, mhs.nim as id_account, mhs.nama as username, act.id_account_auth as id_auth, act.email, act.password FROM mahasiswa mhs JOIN account_auth act ON mhs.id_account_auth = act.id_account_auth WHERE mhs.nim = p_unique_id AND act.password = p_password;
  ELSE
    SELECT 'nim atau password salah' as status;
  END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for auth_search_by_niuq
-- ----------------------------
DROP PROCEDURE IF EXISTS `auth_search_by_niuq`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `auth_search_by_niuq`(IN p_unique_id VARCHAR(50),
    IN p_email VARCHAR(100))
BEGIN
    DECLARE v_count_mahas INT;
    DECLARE v_count_dosen INT DEFAULT 0;

    -- Jika email NULL, berarti login pakai unique_id
    IF p_email IS NULL THEN
        SELECT COUNT(*) INTO v_count_mahas 
        FROM mahasiswa WHERE nim = p_unique_id;

--         SELECT COUNT(*) INTO v_count_dosen 
--         FROM dosen WHERE unique_id = p_unique_id;

        IF v_count_mahas > 0 THEN
            SELECT 'mahasiswa' AS tipe_user, mhs.nim, mhs.nama, act.email, act.password, act.role
            FROM mahasiswa mhs JOIN account_auth act ON mhs.nim = act.id_mahasiswa WHERE mhs.nim = p_unique_id;
        ELSEIF v_count_dosen > 0 THEN
            SELECT 'kaprodi' AS tipe_user, id, unique_id, email, nama, password
            FROM dosen WHERE unique_id = p_unique_id;
        ELSE
            SELECT 'not_found' AS status;
        END IF;

    -- Jika unique_id NULL, berarti login pakai email
    ELSEIF p_unique_id IS NULL THEN
        SELECT COUNT(*) INTO v_count_mahas 
        FROM mahasiswa WHERE email = p_email;

        SELECT COUNT(*) INTO v_count_dosen 
        FROM dosen WHERE email = p_email;

        IF v_count_mahas > 0 THEN
            SELECT 'mahasiswa' AS tipe_user, id, unique_id, email, nama, password
            FROM mahasiswa WHERE email = p_email;
        ELSEIF v_count_dosen > 0 THEN
            SELECT 'dosen' AS tipe_user, id, unique_id, email, nama, password
            FROM dosen WHERE email = p_email;
        ELSE
            SELECT 'not_found' AS status;
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for calculate_date_limit
-- ----------------------------
DROP FUNCTION IF EXISTS `calculate_date_limit`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_date_limit`(dateStart date, intervalDay INT) RETURNS date
BEGIN
  RETURN DATE_ADD(dateStart, INTERVAL intervalDay DAY);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for check_is_registered_beasiswa
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_is_registered_beasiswa`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_is_registered_beasiswa`(IN Sitem INT, IN Snim VARCHAR(255))
BEGIN
  #Routine body goes here...
  DECLARE v_count_item int;
  DECLARE is_registered TINYINT;
  
  SELECT COUNT(*) INTO v_count_item from pendaftar_beasiswa WHERE id_mahasiswa = Snim AND id_beasiswa = Sitem;
  
  IF v_count_item >= 1 THEN
    set is_registered = 1;
  ELSE
    set is_registered = 0;
  END IF;
  
  SELECT is_registered;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for check_is_registered_karir
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_is_registered_karir`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_is_registered_karir`(IN Sitem INT, IN Snim VARCHAR(255))
BEGIN
  #Routine body goes here...
  DECLARE v_count_item int;
  DECLARE is_registered TINYINT;
  
  SELECT COUNT(*) INTO v_count_item from pendaftar_karir WHERE id_mahasiswa = Snim AND id_karir = Sitem;
  
  IF v_count_item >= 1 THEN
    set is_registered = 1;
  ELSE
    set is_registered = 0;
  END IF;
  
  SELECT is_registered;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for check_limit_daftar_beasiswa
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_limit_daftar_beasiswa`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_limit_daftar_beasiswa`(IN Sitem INT)
BEGIN
  #Routine body goes here...
  DECLARE v_count_item int;
  DECLARE v_count_limiter BIGINT;
  DECLARE kuota_tersisa BIGINT;
  
  SELECT COUNT(*) INTO v_count_item from pendaftar_beasiswa WHERE id_beasiswa = Sitem;
  SELECT bk.limit_daftar INTO v_count_limiter from beasiswa_karir bk WHERE id_item = Sitem;
  
  set kuota_tersisa = v_count_limiter - v_count_item;
  
  SELECT kuota_tersisa;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for check_limit_daftar_karir
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_limit_daftar_karir`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_limit_daftar_karir`(IN Sitem INT)
BEGIN
  #Routine body goes here...
  DECLARE v_count_item int;
  DECLARE v_count_limiter BIGINT;
  DECLARE kuota_tersisa BIGINT;
  
  SELECT COUNT(*) INTO v_count_item from pendaftar_karir WHERE id_karir = Sitem;
  SELECT bk.limit_daftar INTO v_count_limiter from beasiswa_karir bk WHERE id_item = Sitem;
  
  set kuota_tersisa = v_count_limiter - v_count_item;
  
  SELECT kuota_tersisa;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for check_session_by_ref_token
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_session_by_ref_token`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_session_by_ref_token`(IN role VARCHAR(30), IN Srefresh VARCHAR(255))
BEGIN
  #Routine body goes here...
  DECLARE v_code_id VARCHAR (255);
  DECLARE v_id_act INT(20);
  DECLARE v_name VARCHAR (255);
  
  IF role = "mahasiswa" THEN
    SELECT mhs.nim as id_account, mhs.nama as username, act.id_account_auth as id_auth FROM session_auth act JOIN mahasiswa mhs ON mhs.id_account_auth = act.id_account_auth WHERE refresh_token = Srefresh;
  ELSE
    SELECT CONCAT("tambahin fungsi untuk kap, admin, petugas");
  END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for check_usedable_email
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_usedable_email`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_usedable_email`(IN emailC VARCHAR(255), OUT status BOOL)
BEGIN

DECLARE message VARCHAR(255) DEFAULT "hello";
DECLARE test_objek VARCHAR (255);

  SELECT email INTO test_objek FROM account_auth WHERE email = emailC;
  
  IF(test_objek = emailC) THEN
    set status = false;
  ELSE
    set status = true;
  END IF;
  
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for check_usedable_phone_num
-- ----------------------------
DROP PROCEDURE IF EXISTS `check_usedable_phone_num`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_usedable_phone_num`(IN phoneC VARCHAR(255), OUT status BOOL)
BEGIN

DECLARE message VARCHAR(255) DEFAULT "hello";
DECLARE test_objek VARCHAR (255);

  SELECT no_hp INTO test_objek FROM account_auth WHERE no_hp = phoneC;
  
  IF(test_objek = phoneC) THEN
    set status = false;
  ELSE
    set status = true;
  END IF;
  
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for count_mahasiswa_dashboard
-- ----------------------------
DROP PROCEDURE IF EXISTS `count_mahasiswa_dashboard`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_mahasiswa_dashboard`(IN Snim VARCHAR(255), OUT Qpengaduan int, OUT Qbeasiswa INT, OUT Qkarir INT)
BEGIN
  DECLARE v_karir INT;

  SELECT COUNT(*) INTO Qkarir FROM beasiswa_karir bk WHERE bk.jenis = 'karir';
  SELECT COUNT(*) INTO Qbeasiswa FROM beasiswa_karir bk WHERE bk.jenis = 'beasiswa';
  
  
  IF (SELECT COUNT(*) from pengaduan WHERE id_mahasiswa = Snim) > 0 THEN
    SELECT COUNT(*) INTO Qpengaduan FROM pengaduan;
  ELSE
    set Qpengaduan = 0;
  END IF;
  
  
--   SELECT CONCAT('ini total karir: ', v_karir);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for get_mahasiswa_dashboard_karir
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_mahasiswa_dashboard_karir`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_mahasiswa_dashboard_karir`(IN Snim VARCHAR(255))
BEGIN
  #Routine body goes here...
    DECLARE done INT DEFAULT FALSE;
--     DECLARE id_item INT;
--     DECLARE id_admin INT;
    DECLARE jenis ENUM('beasiswa','karir');
    DECLARE judul VARCHAR(255);
    DECLARE kejuruan VARCHAR(25);
    DECLARE deskripsi TEXT;
    DECLARE link VARCHAR(255);
    DECLARE penyedia VARCHAR(255);
    DECLARE lokasi VARCHAR(255);
    DECLARE tanggal_buka DATE;
    DECLARE tanggal_tutup DATE;

    DECLARE cur CURSOR FOR 
        SELECT 
            bk.jenis,
            bk.judul,
            bk.kejuruan,
            bk.deskripsi,
            bk.link,
            bk.penyedia,
            bk.lokasi,
            bk.tanggal_upload,
            bk.deadline
        FROM beasiswa_karir bk
        WHERE bk.kejuruan = 'teknik sihir' AND CURDATE() <= bk.deadline;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO jenis, judul, kejuruan, deskripsi, link, penyedia, lokasi, tanggal_buka, tanggal_tutup;
        IF done THEN
            LEAVE read_loop;
        END IF;

        
        SELECT jenis, judul, kejuruan, deskripsi, link, penyedia, lokasi, tanggal_buka, tanggal_tutup;
    END LOOP;

    CLOSE cur;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
