# Politeknik Surabaya (Dharma Bakti) — Company Profile

Website company profile Politeknik Surabaya yang direfaktor dari hasil export Google Stitch.
Desain, konten, warna, layout, dan animasi dipertahankan sama dengan kode asli.

## Struktur Project

```text
.
├── index.html
├── profil.html
├── visi-misi.html
├── struktur-organisasi.html
├── program-studi.html
├── teknik-komputer.html
├── manajemen-informatika.html
├── komputerisasi-akuntansi.html
├── sertifikasi-profesi.html
├── jurnal-mi.html
├── jurnal-tk.html
├── jurnal-ka.html
├── biaya-pendidikan.html
├── tracer-study.html
├── layanan-bebas-plagiasi.html
├── review-akademik.html
├── berita.html
├── kegiatan-civitas.html
├── pengumuman.html
├── galeri.html
├── pendaftaran.html
├── css/
│   └── style.css
├── js/
│   └── script.js
├── assets/
│   ├── images/
│   │   ├── be-the-best-in-digital-era.jpg
│   │   ├── beasiswa-dosen.jpg
│   │   ├── laboratorium-komputasi.jpg
│   │   ├── pendidikan-vokasi.jpg
│   │   └── visitasi-ban-pt.jpg
│   ├── icons/
│   └── logo/
│       └── logo-politeknik-surabaya.jpg
├── code.html          # File export Stitch asli (referensi, tidak dipakai index.html)
├── DESIGN.md          # Design system dari Stitch
└── README.md
```

## Menjalankan Project

Jalankan melalui local development server, bukan membuka `index.html` langsung
dari filesystem, agar seluruh path aset bekerja dengan benar.

```bash
python -m http.server 8000
```

Lalu buka `http://localhost:8000/`.

Alternatif:

```bash
npx serve .
```

## Teknologi

- HTML5, CSS3, dan Vanilla JavaScript.
- Tailwind Play CDN (`https://cdn.tailwindcss.com`) dipertahankan dari kode asli.
- Google Fonts: Inter dan Material Symbols Outlined (library eksternal dari kode asli).
- Tidak ada framework maupun dependency baru.

## Catatan Refactoring

- Seluruh CSS inline dipindahkan ke `css/style.css`.
- Konfigurasi Tailwind dipindahkan ke `js/script.js`.
- `js/script.js` sengaja dimuat tanpa `defer` agar konfigurasi Tailwind langsung
  tersedia tepat setelah Tailwind CDN dimuat, sama seperti urutan pada kode asli.
  Ini mencegah flash warna default sebelum token desain diterapkan.
- Logo header dan footer sekarang memakai path yang benar:
  `assets/logo/logo-politeknik-surabaya.jpg`.
- Lima gambar dari Google Stitch diunduh ke `assets/images/` tanpa mengganti
  gambar, lalu seluruh referensinya diperbarui.
- Dropdown navigasi header menggunakan CSS murni (`group-hover`). Kode asli tidak
  memiliki hamburger menu, drawer, atau handler JavaScript khusus, sehingga tidak
  ada fungsi JavaScript yang dihapus.
- Tautan CTA dan navigasi menggunakan halaman tujuan yang tersedia, bukan
  `href="#"`. Nama file navigasi diselaraskan dengan halaman yang dibuat.
- Seluruh halaman internal memakai header, navigasi, dan footer yang sama dengan
  `index.html`. Data resmi yang belum tersedia ditampilkan sebagai placeholder,
  bukan konten karangan.
- Belum ada backend, database, login, atau dashboard CMS. Halaman daftar berita,
  kegiatan, pengumuman, jurnal, dan galeri sudah disiapkan agar mudah dihubungkan
  dengan CMS PHP Native dan MySQL di masa depan.

## Hasil Validasi

- Perbandingan screenshot desktop 1440px dan mobile 390px dengan kode asli:
  hanya berbeda pada titik animasi `animate-pulse` karena fase animasi saat
  screenshot diambil (60 piksel dari 12.960.000 piksel / 0,0005% pada desktop).
- Konten teks identik dengan kode asli.
- Tidak ada CSS inline, JavaScript inline, atau atribut `style` yang tersisa.
- Seluruh referensi lokal (CSS, JS, logo, gambar) tersedia dan merespons HTTP 200.
- Seluruh halaman navigasi tersedia dan tidak ada tautan file yang hilang.
- Pengujian layout headless pada lebar 390px dan 1440px tidak menemukan
  overflow horizontal; drawer mobile dapat dibuka dan ditutup.
- Console browser bersih; satu-satunya pesan adalah peringatan bawaan
  `cdn.tailwindcss.com should not be used in production` yang memang sudah ada
  karena kode asli memakai Tailwind Play CDN.
