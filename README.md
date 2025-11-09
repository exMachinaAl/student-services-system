# 📘 Student System service — Backend API

> sistem backend yang menangani permintaan pengaduan, pengelolaan beasiswa dan karir , serta mengelola jangka waktu dari batas yang ditentukan projek bekerja sesuai permintaan client dan komposisi projek ada di docs dari projek

![Node](https://img.shields.io/badge/Node.js-18-green)
![Express](https://img.shields.io/badge/Express.js-4.x-black)
![MySQL](https://img.shields.io/badge/MySQL-Database-blue)
![JWT](https://img.shields.io/badge/Auth-JWT-orange)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## 📑 Daftar Isi
- [📘 Student System service — Backend API](#-student-system-service--backend-api)
  - [📑 Daftar Isi](#-daftar-isi)
  - [✅ Fitur](#-fitur)
  - [🖼 Preview](#-preview)
  - [🛠 Tech Stack](#-tech-stack)
  - [Unique Api](#unique-api)
    - [Api rotation auth](#api-rotation-auth)
  - [Fetch Api](#fetch-api)
  - [📦 Instalasi](#-instalasi)
    - [1. Clone repository](#1-clone-repository)
    - [2. install module](#2-install-module)
    - [3. use dev runner for develope, or use thread mode for full run (not work)](#3-use-dev-runner-for-develope-or-use-thread-mode-for-full-run-not-work)

---

## ✅ Fitur
- ✅ Login & Register (JWT)  
- ✅ Refresh Token  
- ✅ Validasi Token Middleware  
- ✅ Protected route with token
- ✅ Role User (Admin & Mahasiswa)  
- Admin
  - ✅ memasukkan data karir dan beasiswa tersedia
  - ✅ mengelola data mahasiswa yang terdaftar karir&beasis
  - ✅ menentukan dan menyetujui pengaduan mahas
  - ❌ mengirim pesan pribadi ke mahas
- Mahasiswa
  - ✅ melihat daftar beasiwa dan karir
  - ✅ mendaftarkan diri ke beasis&karir
  - ❌ mencari beasiswa dengan query
  - ✅ menggunakan fitur pengaduan
  - ✅ menjadi anonim saat pengaduan
  - ✅ melihat status pengaduan
  - ❌ baku hantam dengan kaprodi
- ✅ Response JSON Nested

---

## 🖼 Preview

<details>
  <summary>📌 Klik untuk membuka preview gambar</summary>

  ![Login/Registrasi | mahas](https://raw.githubusercontent.com/exMachinaAl/student-services-system/main/docs/api_mhs/api-login-regis-mhs.png)
  ![dashboard | mahas]([link-gambar-di-sini.png](https://raw.githubusercontent.com/exMachinaAl/student-services-system/main/docs/api_mhs/api-dashboard-mhs.png))
  ![pengaduan | mahas]([link-gambar-di-sini.png](https://raw.githubusercontent.com/exMachinaAl/student-services-system/main/docs/api_mhs/api-pengaduan-mhs.png))
  ![beasiswa | mahas]([link-gambar-di-sini.png](https://raw.githubusercontent.com/exMachinaAl/student-services-system/main/docs/api_mhs/api-beasiswa-info-mhs.png))
  ![karir | mahas](https://raw.githubusercontent.com/exMachinaAl/student-services-system/main/docs/api_mhs/api-karir-detail-mhs.png)

</details>

---

## 🛠 Tech Stack
- **Node.js**
- **Express.js**
- **MySQL**
- **JWT (Access & Refresh Token)**
- **dotenv**
- **bcrypt**

---

## Unique Api
### Api rotation auth
- React Client
  - [lihat penggunaan rotasi token](https://github.com/exMachinaAl/student-services-system/blob/main/docs/FClient/React/exUse.jsx#L23-L426)


---

## Fetch Api
<details>
  <summary>
    HTML vanilla
  </summary>

    
  ```js
  <script>
  fetch("https://<ip-server>:3000/api/sign/login/:role", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      email: "al@mail.com",
      password: "123456"
    })
  })
    .then(r => r.json())
    .then(console.log);
  </script>
  ```

</details>


<details>
  <summary>
    React Js
  </summary>

  ```js
  import axios from "axios";

  const res = await axios.post("https://<ip-server>:3000/api/sign/login/:role", {
    email: "al@mail.com",
    password: "123456"
  });

  console.log(res.data);
  ```
  
</details>


<details>
  <summary>
    CURL
  </summary>

  ```bash
  curl -X POST https://<ip-server>:3000/api/sign/login/:role \
  -H "Content-Type: application/json" \
  -d '{"email":"al@mail.com","password":"123456"}'
  ```
</details>

---

## 📦 Instalasi

### 1. Clone repository
```bash
git clone https://github.com/<username>/<repo>.git
cd <repo>
```
### 2. install module
```bash
npm install
```
### 3. use dev runner for develope, or use thread mode for full run (not work)
```bash
// normal case because is still develope
npm run dev

// nah, not work, or you can fix it
npm start
```

---































<!-- # 🚀 Nama Project

> Deskripsi singkat project kamu dalam 1–2 kalimat. Jelaskan tujuan dan manfaatnya.

---

## 📑 Daftar Isi
- [🚀 Nama Project](#-nama-project)
  - [📑 Daftar Isi](#-daftar-isi)
  - [✨ Fitur](#-fitur)
  - [🖼 Preview](#-preview)
- [API Overview](#api-overview)
- [Dokumentasi Lengkap](#dokumentasi-lengkap)
- [Endpoints Utama](#endpoints-utama)
  - [📦 Instalasi](#-instalasi)
    - [**1. Clone Repo**](#1-clone-repo)

---

## ✨ Fitur

| Fitur | Status | Keterangan |
|-------|--------|------------|
| Login JWT | ✅ | Selesai |
| Refresh Token | ✅ | Stabil |
| Admin Panel | 🔧 | Proses |
| API Gateway | ❌ | Belum dibuat |

---

## 🖼 Preview
Atau link langsung:

```md
[Lihat server.js](./src/server.js)
```
[Lihat fungsi login](https://github.com/username/repo/blob/main/src/controllers/auth.js#L20-L40)
## 🔗 Shortcut File Penting
- Server utama → [server.js](./server.js)
- Konfigurasi database → [db.js](./src/config/db.js)
- Route Auth → [auth.js](./src/routes/auth.js)
- Controller Login → [auth.controller.js](./src/controllers/auth.controller.js)
<details>
  <summary>📌 Klik untuk membuka preview</summary>

  <img src="./images/preview.png" width="600" />
<details>
  <summary>📌 Klik untuk melihat gambar</summary>

  ![preview](link-gambar-di-sini)

</details>

---

# API Overview

Base URL:
- Local: http://localhost:3000/api
- Server: https://api.domain.com

# Dokumentasi Lengkap
Swagger: https://api.domain.com/api-docs

# Endpoints Utama
| Method | Endpoint       | Deskripsi            |
|--------|----------------|----------------------|
| GET    | /users         | Ambil semua user     |
| POST   | /auth/login    | Login user           |
| GET    | /stats         | Statistik sistem     |

---

## 📦 Instalasi

### **1. Clone Repo**
```bash
git clone https://github.com/username/repo.git
cd repo -->
