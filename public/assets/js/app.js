
// Simple front-end behavior for demo UI (no backend).
// Stores sample data in localStorage and demonstrates interactions.

const sample = {
  complaints: [
    {id:1,title:'Perpustakaan tutup lebih awal',date:'2025-04-20',status:'Dikirim'},
    {id:2,title:'Keterlambatan bayar SPP',date:'2025-03-12',status:'Diproses'},
    {id:3,title:'Gangguan jaringan WiFi',date:'2025-02-15',status:'Selesai'}
  ],
  postings: [
    {id:1,type:'scholarship',title:'Beasiswa Cendekia Indonesia',provider:'Kemdikbudristek',deadline:'2025-05-25'},
    {id:2,type:'scholarship',title:'Beasiswa Unggulan',provider:'Univ. Contoh',deadline:'2025-06-01'},
    {id:3,type:'career',title:'Magang PT. ABC',provider:'PT. ABC',deadline:'2025-06-10'},
    {id:4,type:'career',title:'Magang PT. DEF',provider:'PT. DEF',deadline:'2025-05-18'}
  ]
};

function ensureData(){
  if(!localStorage.getItem('kampus_data')){
    localStorage.setItem('kampus_data', JSON.stringify(sample));
  }
}

function getData(){ return JSON.parse(localStorage.getItem('kampus_data') || '{}'); }
function saveData(d){ localStorage.setItem('kampus_data', JSON.stringify(d)); }

document.addEventListener('DOMContentLoaded', ()=>{
  ensureData();
  const path = window.location.pathname.split('/').pop();
  if(path === '' || path === 'index.html') initAuth();
  if(path === 'dashboard.html') renderDashboard();
  if(path === 'pengaduan.html') initPengaduan();
  if(path === 'beasiswa.html') renderPostings();
  if(path === 'riwayat.html') renderRiwayat();
  if(path === 'admin_dashboard.html') renderAdmin();
  if(path === 'kaprodi_dashboard.html') ; // static charts placeholders
});

/* AUTH PAGE */
function initAuth(){
  document.getElementById('btn-register').addEventListener('click', ()=>{
    alert('Demo: data pendaftaran disimpan di localStorage (demo only).');
    // Collect and store minimally
    const d = getData();
    const users = d.users || [];
    const email = document.getElementById('reg-email').value || ('student'+Date.now()+'@demo');
    users.push({id:Date.now(),name:document.getElementById('reg-name').value,email});
    d.users = users;
    saveData(d);
    alert('Akun terdaftar (demo). Silakan klik Masuk.');
  });

  document.getElementById('btn-login').addEventListener('click', ()=>{
    alert('Demo login: akan diarahkan ke dashboard.');
    window.location.href = 'dashboard.html';
  });
}

/* DASHBOARD */
function renderDashboard(){
  const d = getData();
  const list = d.complaints || [];
  const ul = document.getElementById('recent-complaints');
  if(!ul) return;
  ul.innerHTML = '';
  list.slice(0,3).forEach(c=>{
    const li = document.createElement('li');
    li.innerHTML = `<strong>${c.title}</strong><div class="muted">${c.date} • <span style="color:${statusColor(c.status)}">${c.status}</span></div>`;
    ul.appendChild(li);
  });
}

/* PENGADUAN */
function initPengaduan(){
  document.getElementById('btn-submit').addEventListener('click', ()=>{
    const judul = document.getElementById('p-judul').value.trim();
    const kategori = document.getElementById('p-kategori').value;
    const deskripsi = document.getElementById('p-deskripsi').value.trim();
    if(!judul || !deskripsi){ alert('Judul dan deskripsi wajib diisi.'); return; }
    const d = getData();
    d.complaints = d.complaints || [];
    const newId = Date.now();
    d.complaints.unshift({id:newId,title:judul,date:new Date().toISOString().slice(0,10),status:'Dikirim',category:kategori,description:deskripsi});
    saveData(d);
    alert('Pengaduan berhasil dikirim (demo).');
    window.location.href = 'riwayat.html';
  });

  document.getElementById('btn-cancel').addEventListener('click', ()=> window.location.href='dashboard.html');
}

/* BEASISWA & KARIR */
function renderPostings(){
  const d = getData();
  const posts = d.postings || [];
  const grid = document.getElementById('posting-grid');
  if(!grid) return;
  grid.innerHTML = '';
  posts.forEach(p=>{
    const card = document.createElement('div');
    card.className = 'card';
    card.innerHTML = `
      <div style="display:flex;justify-content:space-between;align-items:start">
        <div><strong>${p.title}</strong><div class="muted">${p.provider || ''}</div></div>
        <button class="btn btn-ghost" data-id="${p.id}" onclick="toggleBookmark(${p.id})">☆</button>
      </div>
      <div style="margin-top:12px"><span class="muted">Batas Waktu:</span> <strong style="background:var(--accent);padding:4px 8px;border-radius:6px">${p.deadline}</strong></div>
      <div style="margin-top:10px"><a class="btn btn-primary" href="#">Lihat Selengkapnya</a></div>
    `;
    grid.appendChild(card);
  });
  // tabs & search
  document.querySelectorAll('.tab').forEach(t=> t.addEventListener('click', (ev)=>{
    document.querySelectorAll('.tab').forEach(x=>x.classList.remove('active'));
    ev.target.classList.add('active');
    // filter by type: not implemented in demo; this is UI only
  }));
}

/* RIWAYAT & FAVORITES */
function renderRiwayat(){
  const d = getData();
  const list = d.complaints || [];
  const tbody = document.getElementById('riwayat-table');
  tbody.innerHTML = '';
  list.forEach(c=>{
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>${c.title}</td><td>${c.date}</td><td><span style="color:${statusColor(c.status)}">${c.status}</span></td><td><a class="btn btn-ghost" href="#" onclick="viewDetail(${c.id})">Lihat Detail</a></td>`;
    tbody.appendChild(tr);
  });

  // favorites
  const favGrid = document.getElementById('favorites-grid');
  favGrid.innerHTML='';
  const bookmarks = JSON.parse(localStorage.getItem('kampus_bookmarks')||'[]');
  const posts = d.postings || [];
  bookmarks.forEach(id => {
    const p = posts.find(x=>x.id===id);
    if(!p) return;
    const card = document.createElement('div'); card.className='card';
    card.innerHTML = `<strong>${p.title}</strong><div class="muted">${p.provider}</div><div style="margin-top:8px"><button class="btn btn-primary" onclick="removeBookmark(${p.id})">Hapus</button></div>`;
    favGrid.appendChild(card);
  });
}

/* ADMIN */
function renderAdmin(){
  const d = getData();
  const tbody = document.getElementById('admin-complaints');
  tbody.innerHTML = '';
  (d.complaints||[]).forEach(c=>{
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>${c.title}</td><td>${c.date}</td><td>${c.status}</td><td><button class="btn btn-primary" onclick="editComplaint(${c.id})">Edit</button></td>`;
    tbody.appendChild(tr);
  });

  const t2 = document.getElementById('admin-postings');
  t2.innerHTML='';
  (d.postings||[]).forEach(p=>{
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>${p.title}</td><td><a href="#">${p.provider}</a></td><td>${p.deadline||'-'}</td>`;
    t2.appendChild(tr);
  });
}

/* helpers */
function statusColor(s){
  if(!s) return '#666';
  if(s.toLowerCase().includes('selesai')) return '#4caf50';
  if(s.toLowerCase().includes('diproses')) return '#f6c23e';
  return '#ff7b7b';
}

/* bookmarking */
function toggleBookmark(id){
  let b = JSON.parse(localStorage.getItem('kampus_bookmarks')||'[]');
  if(b.includes(id)){
    b = b.filter(x=>x!==id);
  } else b.push(id);
  localStorage.setItem('kampus_bookmarks', JSON.stringify(b));
  alert('Bookmark diperbarui (demo).');
  renderPostings();
}
function removeBookmark(id){ let b=JSON.parse(localStorage.getItem('kampus_bookmarks')||'[]'); b=b.filter(x=>x!==id); localStorage.setItem('kampus_bookmarks', JSON.stringify(b)); renderRiwayat(); alert('Dihapus dari favorit.'); }

/* misc */
function viewDetail(id){ alert('Detail pengaduan (demo). ID: '+id); }
function editComplaint(id){ alert('Form edit pengaduan (admin) - demo. ID: '+id); }
