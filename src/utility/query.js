module.exports = {

    // auth
    deleteSessionByNIUQ: "delete from session_mahasiswa WHERE NIM = ? OR NIP = ?",
    findUserAccountByNiUQ: "call auth_search_by_account_uniq(?,?)",
    findSessionByAccountId: "SELECT * FROM session_auth WHERE id_account_auth = ?",
    checkSessionByRefreshToken: "CALL check_session_by_ref_token(?, ?)",


    //dashboard
    getCountAllPengajuanByNim: "SELECT COUNT(id_pengaduan) as total FROM pengaduan WHERE id_mahasiswa = ?",
    getBeasiswaKarirShowOnly: "SELECT * FROM beasiswa_karir WHERE deadline >= CURRENT_DATE AND jenis = ? LIMIT ?;",
    getPengaduanTopByNim: "SELECT tanggal_pengajuan, judul, status, deskripsi FROM pengaduan WHERE id_mahasiswa = ? ORDER BY tanggal_pengajuan DESC LIMIT ?;" 
};