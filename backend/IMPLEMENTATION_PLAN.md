# Rencana Implementasi Backend CMS Politeknik Surabaya

Dokumen ini adalah rencana kerja Tahap 1. **Belum ada kode PHP, eksekusi SQL, atau perubahan frontend/database.** Implementasi menunggu persetujuan.

## 1. Tujuan dan Batasan

Tujuan: menyediakan CMS PHP Native + MySQL untuk mengelola konten 21 halaman yang sudah ada tanpa mengubah layout, CSS, atau JavaScript frontend.

Batasan yang mengikat seluruh rencana:

- Frontend HTML/CSS/JS tidak diubah pada tahap ini.
- Tidak menjalankan SQL dan tidak membuat/mengubah database MySQL.
- Tidak ada akun admin bawaan atau password hardcoded.
- Tidak mengarang data resmi kampus.
- Struktur 27 tabel tidak diubah tanpa persetujuan terpisah.
- Implementasi dilakukan bertahap; setiap tahap berhenti di gate persetujuan.
- Admin hanya boleh mengubah **konten terstruktur**, bukan template, class, style, script, atau struktur navigasi.

## 2. Ringkasan Audit

### Database

- 27 tabel, 32 foreign key, 91 objek index, 32 unique key; relasi mengikuti `database/ERD.md`.
- Relasi many-to-many publikasi: `posts` ↔ `post_channels` ↔ `channels`.
- `post_categories` dipertahankan sebagai taksonomi opsional `posts.category_id`.
- `programs.page_id` unik dan nullable ke `pages.id`; halaman 6, 7, 8 sudah dipetakan ke tiga program.
- Media memakai kombinasi `RESTRICT` dan `SET NULL`; penghapusan media harus menangani konflik FK.
- Belum ada tabel audit log, login attempt, atau password reset. Rencana ini **tidak menambah tabel**; gunakan file log dan rate limiter berbasis file.

### Frontend

- 21 halaman HTML statis (di luar `code.html`), satu halaman biaya memakai tabel HTML.
- Tidak ada `<form>` publik di seluruh halaman. Pendaftaran, tracer study, dan layanan lain hanya menampilkan informasi.
- `js/script.js` hanya menangani navigasi, dropdown, drawer mobile, penanda halaman aktif, dan tombol kembali ke atas. Tidak ada pengambilan data atau render konten dinamis.
- Belum ada placeholder konten yang terhubung ke API. Karena itu, perubahan konten di CMS **belum otomatis tampil di frontend** sampai tahap integrasi disetujui.
- Banyak area masih placeholder eksplisit di HTML (sejarah, visi resmi, pimpinan, akreditasi, biaya, identitas jurnal). CMS harus menjaga status placeholder, bukan mengisinya dengan data karangan.

Implikasi: backend tahap pertama adalah **CMS admin + API baca-only**. Integrasi ke halaman publik adalah tahap terpisah agar tidak merombak frontend.

## 3. Prinsip Arsitektur

1. **PHP Native, tanpa framework.** Composer hanya untuk autoload PSR-4 dan dependensi kecil (`vlucas/phpdotenv`), serta PHPUnit untuk pengujian.
2. **Satu front controller** di `backend/public/index.php`; seluruh request melewati router dan middleware.
3. **PDO + prepared statements** untuk semua query; tidak ada string SQL yang menyisipkan input.
4. **Service layer** memegang aturan bisnis dan transaksi; controller hanya memvalidasi request dan membentuk respons.
5. **Repository layer** memegang query per agregat (posts, programs, media, dan seterusnya).
6. **Admin UI server-rendered** (form + POST/Redirect/GET). API JSON memakai service layer yang sama, sehingga tidak ada logika ganda.
7. **Konten terstruktur, bukan HTML bebas.** Tidak ada editor template, CSS, atau JavaScript.
8. **Fail closed:** route admin wajib autentikasi, mutasi wajib CSRF, input tidak dikenal ditolak, upload tidak valid ditolak.
9. **Tidak ada perubahan skema.** Jika suatu kebutuhan tidak dapat dipenuhi 27 tabel, dicatat sebagai keputusan tertunda.

## 4. Rencana Struktur Folder

```text
backend/
├── public/                        # document root satu-satunya
│   ├── index.php                  # front controller
│   ├── .htaccess                  # rewrite ke index.php, blokir dotfile
│   └── assets/admin/              # CSS/JS admin (terpisah dari frontend)
├── app/
│   ├── Core/
│   │   ├── App.php                # bootstrap
│   │   ├── Router.php
│   │   ├── Request.php
│   │   ├── Response.php
│   │   ├── Database.php           # PDO singleton
│   │   ├── Session.php
│   │   ├── Auth.php
│   │   ├── Csrf.php
│   │   ├── Validator.php
│   │   ├── Config.php
│   │   ├── Logger.php
│   │   ├── View.php
│   │   └── HttpException.php
│   ├── Http/Middleware/
│   │   ├── SecurityHeaders.php
│   │   ├── RequireAuth.php
│   │   ├── RequireRole.php
│   │   ├── VerifyCsrf.php
│   │   └── RateLimit.php
│   ├── Controllers/
│   │   ├── Admin/                 # Auth, Dashboard, Users, Settings, Media,
│   │   │                          # Pages, Institution, Programs, Posts,
│   │   │                          # Services, Journals, Tuition, Gallery
│   │   └── Public/                # Site, Pages, Posts, Programs, Services,
│   │                              # Journals, Gallery, Tuition, Media, Health
│   ├── Repositories/              # satu repository per agregat
│   ├── Services/                  # aturan bisnis + transaksi
│   └── Support/
│       ├── Env.php
│       ├── Slug.php
│       ├── Text.php               # escape/paragraf, tanpa HTML bebas
│       ├── UploadedFile.php
│       ├── ImageProcessor.php
│       └── MediaPath.php          # resolusi media baru + aset legacy
├── config/
│   ├── app.php
│   ├── database.php
│   ├── security.php
│   ├── uploads.php
│   └── content.php                # allowlist section key/type & field per modul
├── routes/
│   ├── admin.php
│   └── public.php
├── resources/views/admin/
│   ├── layouts/
│   ├── partials/
│   └── modules/
├── storage/
│   ├── logs/
│   ├── sessions/
│   ├── cache/
│   └── media/                     # upload baru, di luar document root
├── bin/
│   ├── create-admin.php           # interaktif, tanpa password di source
│   └── reset-password.php
├── tests/
│   ├── Unit/
│   └── Feature/
├── .env.example
├── .gitignore
├── composer.json
└── README.md
```

Catatan:

- Document root produksi/lokal harus `backend/public`, bukan root proyek.
- `storage/` dan `.env` tidak boleh dapat diakses lewat URL.
- Aset frontend yang sudah ada tetap di root proyek; backend tidak menyalin atau mengubahnya.
- Admin CSS/JS berada di `backend/public/assets/admin/`, terpisah dari `css/style.css` dan `js/script.js` frontend.

## 5. Konfigurasi dan Environment

Kredensial tidak ditulis di source. `.env.example` hanya berisi placeholder; `.env` asli masuk `.gitignore`.

| Key | Contoh | Fungsi |
|---|---|---|
| `APP_ENV` | `local` / `production` | Mode aplikasi |
| `APP_DEBUG` | `false` | Tampilkan detail error hanya di lokal |
| `APP_URL` | `http://localhost:8001` | Base URL admin/API |
| `APP_TIMEZONE` | `Asia/Jakarta` | Zona waktu aplikasi dan penyimpanan tanggal |
| `SESSION_NAME` | `ps_cms_sid` | Nama cookie session |
| `SESSION_IDLE_MINUTES` | `30` | Batas idle |
| `SESSION_ABSOLUTE_HOURS` | `8` | Batas umur session |
| `SESSION_COOKIE_SECURE` | `false` lokal / `true` HTTPS | Flag cookie |
| `DB_HOST` | `127.0.0.1` | Host MySQL |
| `DB_PORT` | `3306` | Port MySQL |
| `DB_NAME` | `politeknik_surabaya_cms` | Nama schema |
| `DB_USER` | `cms_app` | User MySQL terbatas |
| `DB_PASS` | *(placeholder)* | Password MySQL |
| `DB_CHARSET` | `utf8mb4` | Charset koneksi |
| `UPLOAD_DIR` | `storage/media` | Direktori upload |
| `UPLOAD_MAX_IMAGE_MB` | `5` | Batas gambar |
| `UPLOAD_MAX_DOC_MB` | `10` | Batas PDF |
| `MEDIA_PUBLIC_PREFIX` | `/media` | Route penyajian media |
| `LOG_DIR` | `storage/logs` | Direktori log |

Pemuatan konfigurasi:

1. `Env` membaca `.env` sekali, tidak pernah menimpa environment nyata.
2. `Config` memetakan nilai ke array bertipe; nilai wajib yang kosong membuat aplikasi berhenti dengan pesan aman.
3. Tidak ada fallback password database di kode.
4. `APP_DEBUG=false` di produksi; error detail hanya ke log.

Rekomendasi user MySQL: hak `SELECT, INSERT, UPDATE, DELETE` pada schema CMS saja. Tidak memakai `root` untuk aplikasi.

## 6. Lapisan Database (PDO)

Konfigurasi PDO:

- DSN: `mysql:host={host};port={port};dbname={name};charset=utf8mb4`.
- `ATTR_ERRMODE = ERRMODE_EXCEPTION`.
- `ATTR_DEFAULT_FETCH_MODE = FETCH_ASSOC`.
- `ATTR_EMULATE_PREPARES = false`.
- `ATTR_STRINGIFY_FETCHES = false`.
- Timeout koneksi wajar (5 detik) dan `SET time_zone` sesuai `APP_TIMEZONE`.

Aturan akses data:

1. Semua nilai user memakai parameter posisi/bernama.
2. Nama tabel dan kolom berasal dari allowlist kode, bukan input.
3. `ORDER BY` memakai peta allowlist per endpoint.
4. Pencarian memakai `LIKE` dengan escape `%`, `_`, dan `\`.
5. Pagination `page`/`per_page`, batas `per_page` 1–100.
6. Transaksi untuk operasi multi-tabel:
   - post + `post_channels`,
   - program + tag + media + cover,
   - service/journal + item/document,
   - tuition period + component,
   - reorder `sort_order`.
7. Konflik unique (`1062`) dipetakan ke HTTP 409 dengan nama field.
8. Konflik FK `RESTRICT` (`1451`/`1452`) dipetakan ke HTTP 409/422 dengan pesan yang dapat ditindaklanjuti.
9. Tidak ada `SELECT *` pada respons API; kolom dipilih eksplisit. `password_hash` tidak pernah masuk respons.
10. Boolean MySQL (`TINYINT(1)`) dikonversi ke boolean JSON; `DECIMAL` dikirim sebagai string agar tidak kehilangan presisi.

Repository awal: `AdminUserRepository`, `SettingRepository`, `MediaRepository`, `PageRepository`, `PageSectionRepository`, `InstitutionRepository`, `OrganizationRepository`, `ProgramRepository`, `PostRepository`, `ServiceRepository`, `JournalRepository`, `TuitionRepository`, `GalleryRepository`.

## 7. Autentikasi dan Session

### Alur login

1. `GET /admin/login` memulai session, membuat CSRF token, menampilkan form.
2. `POST /admin/login` memverifikasi CSRF, rate limit, lalu mencari user berdasarkan `username` **atau** `email`.
3. Jika user tidak ada, tetap jalankan `password_verify` terhadap dummy hash agar waktu respons mirip.
4. Hanya `status = 'active'` yang boleh login.
5. `password_verify` gagal → pesan generik "Kredensial tidak valid" (tidak membedakan username/email/password).
6. Berhasil:
   - `password_needs_rehash` → perbarui hash,
   - `session_regenerate_id(true)`,
   - simpan `admin_id`, `role`, `last_activity`, `csrf_token` baru,
   - perbarui `admin_users.last_login_at`,
   - catat audit log,
   - redirect ke dashboard.
7. `POST /admin/logout` wajib CSRF; hapus session dan cookie, lalu redirect login.

### Aturan session

- Nama cookie dari environment; `HttpOnly`, `SameSite=Lax`, `Secure` bila HTTPS.
- `session.use_strict_mode=1`, `use_only_cookies=1`.
- Simpan session di `storage/sessions`, bukan direktori default yang dapat dibaca publik.
- Idle timeout 30 menit; absolute timeout 8 jam.
- Regenerasi ID saat login dan saat perubahan role/password sendiri.
- Perubahan role oleh super admin mencabut session user tersebut (simpan `session_version` di session dan bandingkan dengan waktu update user; tanpa tabel tambahan, gunakan `updated_at` user).
- Tidak ada "remember me".

### Pembuatan akun pertama

`php bin/create-admin.php`:

- Meminta username, email, display name, password, dan konfirmasi secara interaktif.
- Input password tidak ditampilkan dan tidak masuk shell history.
- Validasi panjang 12–128 karakter, tidak sama dengan username/email.
- Hash memakai `PASSWORD_ARGON2ID` bila tersedia, jika tidak `PASSWORD_DEFAULT`.
- Role awal `super_admin`, status `active`.
- Tidak ada password default dan tidak ada seed admin di SQL.

`bin/reset-password.php` disediakan untuk pemulihan lokal oleh operator, bukan endpoint publik.

## 8. Otorisasi Berdasarkan Role

| Area | super_admin | admin | editor |
|---|---|---|---|
| Dashboard | lihat | lihat | lihat |
| Admin users | CRUD | — | — |
| Site settings `teknis` | ubah | — | — |
| Site settings `sosial`/`footer`/`seo` | ubah | ubah | lihat |
| Institution profile, missions, goals | ubah | ubah | lihat |
| Organisasi (`org_units`, `org_members`) | ubah | ubah | lihat |
| Pages registry & meta | ubah meta saja | ubah meta saja | lihat |
| Page sections | ubah | ubah | lihat |
| Programs/tags/items/media | CRUD + publish | CRUD + publish | buat/ubah draft, tanpa publish/delete |
| Posts/categories/channels/pivot | CRUD + publish | CRUD + publish | buat/ubah draft milik sendiri, tanpa publish/delete |
| Services/items/documents | CRUD + publish | CRUD + publish | buat/ubah draft, tanpa publish/delete |
| Journals/articles/documents | CRUD + publish | CRUD + publish | buat/ubah draft, tanpa publish/delete |
| Tuition periods/components | CRUD + aktivasi | CRUD + aktivasi | lihat |
| Gallery | CRUD + publish | CRUD + publish | unggah/ubah draft, tanpa publish/delete |
| Media | unggah/ubah/hapus | unggah/ubah/hapus | unggah/ubah metadata milik sendiri |
| Audit log | lihat | lihat | — |

Aturan tambahan:

- Editor hanya dapat mengubah post berstatus `draft` yang `author_admin_id`-nya dirinya; admin dapat mengubah semua.
- Editor tidak dapat mengubah status menjadi `published`/`archived`.
- Super admin tidak dapat menurunkan role atau menonaktifkan dirinya sendiri, dan tidak dapat menghapus super admin terakhir.
- Setiap route memakai middleware `RequireAuth` + `RequireRole`; tidak ada pengecekan role yang hanya disembunyikan di UI.

## 9. Keamanan

### CSRF

- Token 32 byte acak per session, disimpan di session, dirotasi saat login/logout.
- Semua `POST`, `PUT`, `PATCH`, `DELETE` wajib menyertakan `X-CSRF-Token` (API) atau `_token` (form).
- Perbandingan `hash_equals`.
- Token tidak sah → HTTP 419 tanpa menjalankan aksi.
- Login tetap memakai token untuk mencegah login CSRF.
- Selain token, verifikasi `Origin`/`Referer` untuk request same-origin.

### Validasi input

- Hanya field yang terdaftar yang diterima; field tak dikenal → 422.
- Tipe, panjang, enum, rentang angka, tanggal, email, URL, dan slug divalidasi di server.
- Slug: `^[a-z0-9]+(?:-[a-z0-9]+)*$`, maksimal 190 karakter, unik.
- URL hanya `http`/`https`; email memakai `FILTER_VALIDATE_EMAIL`.
- Nominal biaya non-negatif, maksimal `DECIMAL(15,2)`; `currency` tiga huruf kapital.
- `sort_order` 0–32767; ID relasi harus ada dan boleh dipetakan.
- Body teks dibatasi (misalnya 50.000 karakter) walau kolom `LONGTEXT`.
- Semua pesan validasi dikembalikan per field (422) tanpa membocorkan query.

### XSS dan integritas tampilan

- Output selalu di-escape dengan `htmlspecialchars(..., ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8')`.
- Tidak ada penyimpanan HTML bebas dari admin. Body/description disimpan sebagai teks; paragraf dibentuk dari baris kosong saat render.
- Tidak ada input untuk `<style>`, `<script>`, class Tailwind, atau atribut HTML.
- Media hanya gambar/PDF; SVG, HTML, JS, dan file executable ditolak.
- Admin tidak dapat mengubah template, CSS, JS, nav, atau `file_name` halaman.
- CSP admin: `default-src 'self'; img-src 'self' data:; style-src 'self'; script-src 'self'; frame-ancestors 'none'; base-uri 'self'; form-action 'self'`.
- Header tambahan: `X-Content-Type-Options: nosniff`, `Referrer-Policy: strict-origin-when-cross-origin`, `Permissions-Policy` minimal, HSTS saat HTTPS.

### Upload media

- Allowlist: `image/jpeg`, `image/png`, `image/webp`, `application/pdf`.
- Verifikasi MIME dengan `finfo_file`, ekstensi allowlist, dan magic bytes; bukan hanya `Content-Type` klien.
- Gambar diperiksa dengan `getimagesize` dan di-decode; maksimal 6000×6000 piksel.
- Gambar di-re-encode (GD) untuk membuang metadata/EXIF dan mencegah payload tersembunyi.
- Nama file acak 32 hex + ekstensi kanonik; nama asli hanya disimpan sebagai metadata.
- Ukuran: gambar maksimal 5 MB, PDF maksimal 10 MB.
- PDF diverifikasi header `%PDF-` dan disajikan sebagai attachment.
- File disimpan di `storage/media/YYYY/MM/`, di luar document root; permission direktori 0750, file 0640.
- Penyajian lewat route `/media/{id}` yang memeriksa `is_public`; tidak ada path dari user.
- `alt_text` wajib untuk gambar yang ditampilkan; panjang maksimal 255.
- `checksum_sha256`, `file_size`, `width`, `height`, `mime_type`, dan `extension` diisi server.
- Media legacy `assets/images/*` dan `assets/logo/*` tetap dapat disajikan lewat pemetaan path allowlist; tidak dipindahkan, tidak diganti, dan tidak dihapus fisiknya dari CMS. Record legacy hanya dapat diubah metadatanya.

### Rate limiting dan audit

- Login: 5 percobaan gagal / 15 menit per kombinasi IP + identifier.
- Mutasi admin: 120 request / menit per user.
- Upload: 30 file / jam per user.
- Penyimpanan hitungan di `storage/cache/` (file + lock); tidak menambah tabel.
- Audit log JSON lines di `storage/logs/audit-YYYY-MM-DD.log`: waktu, request id, aktor, role, IP, method, path, aksi, entity, entity id, status. Tidak mencatat password, token, atau isi body sensitif.
- Rotasi/retensi log minimal 90 hari; log tidak dapat diakses lewat web.

### Penanganan error

- Produksi: pesan generik + `request_id`; detail hanya di log.
- 404/405/415/422/429/500 konsisten untuk API.
- Tidak menampilkan stack trace, DSN, atau nama tabel internal ke pengguna.
- Exception tak tertangani → 500 dan log; transaksi di-rollback.

## 10. Aturan Konten agar Layout Tidak Dapat Diubah Admin

1. **Pages bersifat registry tetap (21 baris).** Tidak ada endpoint membuat/menghapus halaman.
2. Kolom struktural `pages.slug`, `file_name`, `nav_section`, `nav_path`, dan `sort_order` **read-only** di CMS. Hanya `title`, `meta_title`, `meta_description`, dan `is_published` yang dapat diubah.
3. `page_sections` memakai **registry section key tetap** per halaman. Key/tipe di luar registry ditolak; admin tidak dapat menambah section baru. `sort_order` hanya mengubah urutan konten dalam slot yang sudah ada.
4. `body` hanya teks; tidak ada HTML, CSS, JavaScript, iframe, atau embed.
5. `content_json` hanya dipakai untuk section key yang terdaftar, dengan skema tetap (misalnya daftar `title`, `description`, `icon`). Jumlah item, field, dan tipe divalidasi; tidak ada HTML di dalam JSON. `icon` hanya nama Material Symbols yang cocok dengan pola aman, misalnya `^[a-z0-9_]+$`.
6. `programs.page_id` hanya boleh memilih halaman yang tersedia; tidak dapat membuat halaman baru. Unique index mencegah dua program memakai halaman yang sama. Aplikasi juga menolak halaman yang sudah dipakai channel/layanan atau berada di luar kelompok akademik.
7. `services.page_id` hanya boleh memilih halaman layanan yang belum dipakai program/channel dan sesuai dengan registry halaman; `channels.page_id` tidak dapat diubah dari CMS.
8. Menu, breadcrumb, footer, dan CTA link mengikuti struktur frontend; admin tidak mengedit path navigasi.
9. `site_settings` hanya 8 key yang ada. Tidak ada key untuk CSS/JS/HTML atau template. `maintenance_mode` hanya memengaruhi API/renderer, bukan halaman statis saat ini.
10. `footer_copyright` hanya teks; token `{year}` dipertahankan dan diganti saat render.
11. Semua media melalui library media; tidak ada upload tema, font, atau file kode.
12. Preview admin memakai escaping yang sama dengan output publik.

## 11. Rancangan API

### Konvensi

- Base path: `/api/v1`.
- Format: JSON UTF-8; upload memakai `multipart/form-data`.
- Autentikasi admin: cookie session; mutasi wajib `X-CSRF-Token`.
- Publik: GET tanpa autentikasi, hanya data terbit/publik.
- Sukses: `{ "data": ..., "meta": ... }`.
- Error: `{ "error": { "code": "...", "message": "...", "fields": { ... } }, "request_id": "..." }`.
- Status: 200, 201, 204, 400, 401, 403, 404, 405, 409, 413, 415, 419, 422, 429, 500.
- ID berupa integer; tanggal ISO-8601; boolean JSON asli; `DECIMAL` sebagai string.
- Pagination: `page`, `per_page` (maksimal 100), `meta.total`, `meta.page`, `meta.per_page`, `meta.last_page`.

### Endpoint autentikasi

| Method | Path | Akses | Fungsi |
|---|---|---|---|
| GET | `/api/v1/auth/csrf` | publik | Ambil token CSRF untuk session |
| POST | `/api/v1/auth/login` | publik | Login username/email + password |
| POST | `/api/v1/auth/logout` | auth + CSRF | Logout |
| GET | `/api/v1/auth/me` | auth | Profil admin aktif |
| POST | `/api/v1/auth/password` | auth + CSRF | Ganti password sendiri |

### Endpoint admin

| Method | Path | Role | Fungsi |
|---|---|---|---|
| GET | `/api/v1/admin/dashboard` | semua | Statistik ringkas + aktivitas terbaru |
| GET | `/api/v1/admin/users` | super_admin | Daftar admin |
| POST | `/api/v1/admin/users` | super_admin | Buat admin |
| GET | `/api/v1/admin/users/{id}` | super_admin | Detail admin |
| PATCH | `/api/v1/admin/users/{id}` | super_admin | Ubah nama/role/status |
| POST | `/api/v1/admin/users/{id}/password` | super_admin | Set password baru |
| DELETE | `/api/v1/admin/users/{id}` | super_admin | Hapus admin (dengan pengaman) |
| GET | `/api/v1/admin/settings` | admin+ | Daftar setting |
| PATCH | `/api/v1/admin/settings` | admin+ / super_admin untuk `teknis` | Ubah setting allowlist |
| GET | `/api/v1/admin/media` | semua | Daftar/cari media |
| POST | `/api/v1/admin/media` | editor+ | Upload media |
| GET | `/api/v1/admin/media/{id}` | semua | Detail media |
| PATCH | `/api/v1/admin/media/{id}` | editor+ | Ubah judul/alt/caption/is_public |
| DELETE | `/api/v1/admin/media/{id}` | admin+ | Hapus media bila tidak direferensikan |
| GET | `/api/v1/admin/pages` | semua | Registry 21 halaman |
| PATCH | `/api/v1/admin/pages/{id}` | admin+ | Ubah title/meta/is_published |
| GET | `/api/v1/admin/pages/{id}/sections` | semua | Section halaman |
| PUT | `/api/v1/admin/pages/{id}/sections/{key}` | admin+ | Upsert section sesuai registry |
| PATCH | `/api/v1/admin/pages/{id}/sections/order` | admin+ | Urutkan section |
| GET | `/api/v1/admin/institution` | semua | Profil institusi |
| PATCH | `/api/v1/admin/institution` | admin+ | Ubah profil institusi |
| GET/POST | `/api/v1/admin/missions` | semua / admin+ | Daftar / tambah misi |
| PATCH/DELETE | `/api/v1/admin/missions/{id}` | admin+ | Ubah / hapus misi |
| GET/POST | `/api/v1/admin/goals` | semua / admin+ | Daftar / tambah tujuan |
| PATCH/DELETE | `/api/v1/admin/goals/{id}` | admin+ | Ubah / hapus tujuan |
| GET/POST | `/api/v1/admin/org-units` | semua / admin+ | Unit organisasi |
| PATCH/DELETE | `/api/v1/admin/org-units/{id}` | admin+ | Ubah / hapus unit |
| GET/POST | `/api/v1/admin/org-members` | semua / admin+ | Anggota organisasi |
| PATCH/DELETE | `/api/v1/admin/org-members/{id}` | admin+ | Ubah / hapus anggota |
| GET/POST | `/api/v1/admin/programs` | semua / editor+ | Daftar / buat program (draft) |
| GET/PATCH | `/api/v1/admin/programs/{id}` | semua / editor+ | Detail / ubah program |
| DELETE | `/api/v1/admin/programs/{id}` | admin+ | Hapus program |
| PUT | `/api/v1/admin/programs/{id}/tags` | editor+ | Sinkronisasi tag |
| GET/POST | `/api/v1/admin/programs/{id}/items` | semua / editor+ | Item program |
| PATCH/DELETE | `/api/v1/admin/programs/{id}/items/{itemId}` | editor+ / admin+ | Ubah / hapus item |
| GET/POST | `/api/v1/admin/programs/{id}/media` | semua / editor+ | Media program |
| DELETE | `/api/v1/admin/programs/{id}/media/{mediaId}` | editor+ | Lepas media |
| PUT | `/api/v1/admin/programs/{id}/cover` | admin+ | Tetapkan cover |
| GET/POST | `/api/v1/admin/posts` | semua / editor+ | Daftar / buat post (draft) |
| GET/PATCH | `/api/v1/admin/posts/{id}` | semua / editor+ | Detail / ubah post |
| DELETE | `/api/v1/admin/posts/{id}` | admin+ | Hapus post |
| PUT | `/api/v1/admin/posts/{id}/channels` | editor+ | Sinkronisasi pivot channel |
| POST | `/api/v1/admin/posts/{id}/publish` | admin+ | Terbitkan |
| POST | `/api/v1/admin/posts/{id}/archive` | admin+ | Arsipkan |
| GET/POST | `/api/v1/admin/post-categories` | semua / admin+ | Kategori |
| PATCH/DELETE | `/api/v1/admin/post-categories/{id}` | admin+ | Ubah / hapus kategori |
| GET | `/api/v1/admin/channels` | semua | Daftar channel |
| PATCH | `/api/v1/admin/channels/{id}` | admin+ | Ubah nama/deskripsi/aktif/urutan |
| GET/POST | `/api/v1/admin/services` | semua / editor+ | Layanan |
| GET/PATCH/DELETE | `/api/v1/admin/services/{id}` | semua / editor+ / admin+ | Detail / ubah / hapus |
| GET/POST | `/api/v1/admin/services/{id}/items` | semua / editor+ | Item layanan |
| PATCH/DELETE | `/api/v1/admin/services/{id}/items/{itemId}` | editor+ / admin+ | Ubah / hapus item |
| GET/POST | `/api/v1/admin/services/{id}/documents` | semua / editor+ | Dokumen layanan |
| DELETE | `/api/v1/admin/services/{id}/documents/{docId}` | editor+ | Lepas dokumen |
| GET/POST | `/api/v1/admin/journals` | semua / editor+ | Jurnal |
| GET/PATCH/DELETE | `/api/v1/admin/journals/{id}` | semua / editor+ / admin+ | Detail / ubah / hapus |
| GET/POST | `/api/v1/admin/journals/{id}/articles` | semua / editor+ | Artikel jurnal |
| PATCH/DELETE | `/api/v1/admin/journals/{id}/articles/{articleId}` | editor+ / admin+ | Ubah / hapus artikel |
| GET/POST | `/api/v1/admin/journals/{id}/documents` | semua / editor+ | Dokumen jurnal |
| DELETE | `/api/v1/admin/journals/{id}/documents/{docId}` | editor+ | Lepas dokumen |
| GET/POST | `/api/v1/admin/tuition-periods` | semua / admin+ | Periode biaya |
| PATCH/DELETE | `/api/v1/admin/tuition-periods/{id}` | admin+ | Ubah / hapus periode |
| POST | `/api/v1/admin/tuition-periods/{id}/activate` | admin+ | Aktifkan satu periode |
| GET/POST | `/api/v1/admin/tuition-periods/{id}/components` | semua / admin+ | Komponen biaya |
| PATCH/DELETE | `/api/v1/admin/tuition-periods/{id}/components/{componentId}` | admin+ | Ubah / hapus komponen |
| GET/POST | `/api/v1/admin/gallery` | semua / editor+ | Item galeri |
| PATCH/DELETE | `/api/v1/admin/gallery/{id}` | editor+ / admin+ | Ubah / hapus item |
| POST | `/api/v1/admin/gallery/{id}/publish` | admin+ | Terbitkan item |
| GET | `/api/v1/admin/audit-log` | admin+ | Baca log audit (read-only) |

Catatan: endpoint `PATCH` untuk editor tetap dipaksa server agar tidak dapat mengubah status publish/arsip atau field struktural.

### Endpoint publik (baca-only)

| Method | Path | Fungsi |
|---|---|---|
| GET | `/api/v1/public/site` | Profil institusi, setting publik, registry halaman |
| GET | `/api/v1/public/pages/{slug}` | Halaman + section terbit |
| GET | `/api/v1/public/programs` | Program `published`, filter `featured` |
| GET | `/api/v1/public/programs/{slug}` | Program + tag + item + media |
| GET | `/api/v1/public/posts` | Post `published`, filter `channel`, `category`, `featured`, pagination |
| GET | `/api/v1/public/posts/{slug}` | Detail post + channel + kategori + cover |
| GET | `/api/v1/public/services/{slug}` | Layanan `published` + item + dokumen publik |
| GET | `/api/v1/public/journals` | Jurnal `published` |
| GET | `/api/v1/public/journals/{slug}` | Identitas + dokumen + artikel terbaru |
| GET | `/api/v1/public/journals/{slug}/articles` | Artikel `published`, pagination |
| GET | `/api/v1/public/gallery` | Item galeri terbit, filter album |
| GET | `/api/v1/public/tuition` | Periode aktif + komponen aktif |
| GET | `/media/{id}` | File media publik (binary, di luar base `/api/v1`) |
| GET | `/health` | Status aplikasi tanpa detail sensitif |

Aturan publik:

- Hanya `status = published`/`is_published = 1` dan `published_at <= NOW()`.
- Channel/kategori harus aktif.
- Media harus `is_public = 1`.
- Field internal tidak dikirim: `password_hash`, `uploaded_by`, `author_admin_id`, kolom audit.
- Tidak ada endpoint publik untuk menulis data.
- Endpoint `/health` tidak membocorkan versi, kredensial, atau struktur tabel.

## 12. Pemetaan Modul CMS ke Tabel

| Modul | Tabel | Akses CMS | Catatan |
|---|---|---|---|
| Autentikasi & admin | `admin_users` | CRUD super_admin | Hash password, role, status |
| Pengaturan situs | `site_settings` | Ubah allowlist | 8 key; `teknis` hanya super_admin |
| Media library | `media` | Upload/ubah/hapus | File di luar docroot; cek referensi |
| Registry halaman | `pages` | Meta saja | 21 baris tetap; kolom struktur read-only |
| Section halaman | `page_sections` | Upsert terbatas | Registry key/type tetap |
| Identitas institusi | `institution_profile` | Ubah admin+ | `profile_key` read-only |
| Misi | `missions` | CRUD admin+ | Urutan dan status aktif |
| Tujuan | `goals` | CRUD admin+ | Urutan dan status aktif |
| Unit organisasi | `org_units` | CRUD admin+ | Self-reference `parent_id` |
| Anggota organisasi | `org_members` | CRUD admin+ | Foto dari media |
| Program studi | `programs` | CRUD + publish | `page_id` unik dan opsional |
| Tag program | `program_tags` | Sinkronisasi | Unik per program |
| Item program | `program_items` | CRUD | Tipe allowlist |
| Media program | `program_media` | Attach/detach/cover | Satu cover per program |
| Kategori publikasi | `post_categories` | CRUD admin+ | Taksonomi opsional |
| Channel publikasi | `channels` | Ubah terbatas | `page_id` tetap agar navigasi aman |
| Publikasi | `posts` | CRUD + publish | Status draft/published/archived |
| Pivot publikasi | `post_channels` | Sinkronisasi | Banyak-ke-banyak |
| Layanan | `services` | CRUD + publish | Satu layanan per halaman |
| Item layanan | `service_items` | CRUD | Kartu informasi layanan |
| Dokumen layanan | `service_documents` | Attach/detach | Media PDF |
| Jurnal | `journals` | CRUD + publish | Identitas resmi boleh NULL |
| Artikel jurnal | `journal_articles` | CRUD + publish | DOI/PDF opsional |
| Dokumen jurnal | `journal_documents` | Attach/detach | Panduan/formulir |
| Periode biaya | `tuition_periods` | CRUD + aktivasi | Hanya satu aktif (aturan aplikasi) |
| Komponen biaya | `tuition_components` | CRUD | Nominal boleh NULL |
| Galeri | `gallery_items` | CRUD + publish | Album dari `album_name` |

Tidak ada tabel baru. Tabel yang saat ini kosong tetap kosong sampai admin mengisi; CMS tidak melakukan seeding data resmi.

## 13. Pemetaan 21 Halaman ke Modul dan Section

Registry section hanya untuk halaman yang membutuhkan konten editorial di luar modul data. Key final ditetapkan di `config/content.php` sebelum implementasi modul.

| # | File | Konten yang dikelola | Sumber data | Section key yang diusulkan |
|---:|---|---|---|---|
| 1 | `index.html` | Hero, kartu nilai, tentang, pengantar program, berita, tautan cepat, CTA | `page_sections`, `programs`, `posts`, `media`, `institution_profile`, `site_settings` | `hero`, `value_cards`, `about`, `programs_intro`, `news_intro`, `quick_links`, `cta` |
| 2 | `profil.html` | Hero, gambaran umum, sejarah, identitas, kontak, foto pendukung | `page_sections`, `institution_profile`, `media` | `hero`, `overview`, `history`, `contact`, `supporting_photos` |
| 3 | `visi-misi.html` | Visi, misi, tujuan, arah program | `institution_profile.vision`, `missions`, `goals`, `programs` | `hero` |
| 4 | `struktur-organisasi.html` | Bagan unit, pimpinan, anggota, uraian tugas | `org_units`, `org_members`, `media` | `hero` |
| 5 | `program-studi.html` | Pengantar akademik, kartu 3 program, catatan | `programs`, `program_tags`, `program_media`, `page_sections` | `hero`, `intro`, `note` |
| 6 | `teknik-komputer.html` | Gambaran umum, tujuan, kompetensi, prospek, gambar, CTA | `programs`, `program_items`, `program_tags`, `program_media` | `hero`, `cta` |
| 7 | `manajemen-informatika.html` | Sama seperti #6 | idem | idem |
| 8 | `komputerisasi-akuntansi.html` | Sama seperti #6 | idem | idem |
| 9 | `sertifikasi-profesi.html` | Enam kartu informasi, konten resmi, CTA | `services`, `service_items`, `service_documents`, `page_sections` | `hero`, `official_content`, `cta` |
| 10 | `jurnal-mi.html` | Identitas jurnal, fokus, dewan redaksi, artikel, panduan | `journals`, `journal_articles`, `journal_documents`, `media` | `hero`, `contributor_note` |
| 11 | `jurnal-tk.html` | Sama seperti #10 | idem | idem |
| 12 | `jurnal-ka.html` | Sama seperti #10 | idem | idem |
| 13 | `biaya-pendidikan.html` | Catatan nominal, tabel komponen, sumber/pembaruan | `tuition_periods`, `tuition_components`, `page_sections` | `hero`, `source_note`, `cta` |
| 14 | `tracer-study.html` | Enam kartu layanan, konten resmi, CTA | `services`, `service_items`, `service_documents`, `page_sections` | `hero`, `official_content`, `cta` |
| 15 | `layanan-bebas-plagiasi.html` | Enam kartu layanan, konten resmi, CTA | idem | idem |
| 16 | `review-akademik.html` | Enam kartu layanan, konten resmi, CTA | idem | idem |
| 17 | `berita.html` | Post unggulan, kabar terbaru, preview kegiatan/pengumuman | `posts`, `post_channels`, `channels`, `post_categories`, `media` | `hero`, `cta` |
| 18 | `kegiatan-civitas.html` | Daftar post channel kegiatan | `posts`, `post_channels`, `channels`, `media` | `hero`, `cta` |
| 19 | `pengumuman.html` | Daftar post channel pengumuman | idem | `hero`, `cta` |
| 20 | `galeri.html` | Grid galeri per album | `gallery_items`, `media` | `hero`, `cta` |
| 21 | `pendaftaran.html` | Enam kartu PMB, kontak resmi, CTA | `services`, `service_items`, `institution_profile`, `page_sections` | `hero`, `official_content`, `cta` |

Catatan pemetaan:

- Konten yang belum punya kolom khusus (jam layanan, sejarah, catatan sumber biaya, konten resmi layanan) ditempatkan di `page_sections` dengan key tetap. Tidak ada perubahan skema.
- Fokus & ruang lingkup jurnal memakai `journals.description`; dewan redaksi memakai `journals.editorial_board`; panduan penulis memakai `journal_documents`.
- "Jenjang yang diselenggarakan" diturunkan dari `programs.degree_level`, bukan field baru.
- Data pimpinan tidak diisi sampai ada sumber resmi; `NULL`/kosong ditampilkan sebagai placeholder.

## 14. Alur Kerja Admin

1. Login → dashboard menampilkan jumlah draft, publikasi terbaru, media, dan peringatan konflik.
2. Pilih modul → daftar dengan filter status/channel/kategori dan pagination.
3. Buat/ubah konten dalam form terstruktur; validasi server menampilkan error per field.
4. Unggah media lewat library; pilih media yang sudah ada atau upload baru.
5. Simpan sebagai draft; editor dapat melanjutkan draft miliknya.
6. Admin meninjau lalu menerbitkan; `published_at` diisi bila kosong.
7. Setiap mutasi dicatat di audit log dan memakai transaksi bila menyentuh beberapa tabel.
8. Penghapusan:
   - media yang masih direferensikan → 409 dan daftar referensi,
   - program yang masih punya jurnal → 409,
   - unit yang masih punya anggota → 409,
   - channel yang masih punya post → 409,
   - halaman tidak dapat dihapus.
9. Pengaturan dan akun admin hanya untuk role yang berhak.

## 15. Strategi Integrasi Frontend (Tahap Terpisah)

Karena frontend tidak boleh dirombak, tahap ini tidak menyentuh HTML/CSS/JS. API publik disiapkan agar integrasi nanti tidak mengubah desain.

Opsi integrasi yang akan diajukan terpisah:

1. **Rekomendasi: template PHP 1:1 dari HTML yang ada.** Markup, class, dan struktur dipertahankan; hanya nilai teks/gambar diganti dari service. URL dan SEO tetap server-rendered tanpa JavaScript. Perlu persetujuan karena menambah lapisan PHP pada halaman publik dan mengubah cara penyajian, bukan desain.
2. **Hydration JavaScript minimal.** Halaman HTML tetap; JS mengambil API publik dan mengganti teks/gambar. Perlu perubahan `js/script.js` atau file baru, sehingga menunggu persetujuan.
3. **Static generation.** Konten diekspor menjadi HTML dengan template yang sama secara berkala. Tidak ada perubahan runtime frontend, tetapi publikasi tidak real-time.

Sampai salah satu disetujui, CMS hanya mengelola data dan API; halaman publik tetap seperti sekarang.

## 16. Tahapan Implementasi

### Tahap 0 — Persiapan (tanpa kode aplikasi)

- Konfirmasi dokumen ini.
- User membuat/import database dari `database/` (tidak dijalankan oleh agen).
- Siapkan user MySQL terbatas, `.env`, document root `backend/public`, ekstensi PHP.
- Putuskan opsi integrasi frontend dan penyimpanan media.

Gate: persetujuan tertulis untuk mulai Tahap 1.

### Tahap 1 — Fondasi

- Skeleton folder, Composer autoload, `.env.example`, config.
- Front controller, router, request/response, error handler, security headers.
- PDO, koneksi, health check, logging dasar.
- Layout admin minimal dan halaman login kosong (belum autentikasi).

Gate: review struktur dan konfigurasi.

### Tahap 2 — Autentikasi, session, role, CSRF

- Login/logout, session hardening, rate limit login.
- Middleware auth/role/CSRF.
- CLI pembuat admin pertama dan reset password.
- Manajemen `admin_users` untuk super_admin.
- Audit log dasar.

Gate: uji login, session fixation, CSRF, dan matriks role.

### Tahap 3 — Media library

- Upload gambar/PDF, validasi, re-encode, metadata, penyajian `/media/{id}`.
- Daftar/cari/ubah/hapus dengan penanganan referensi FK.
- Dukungan aset legacy.

Gate: uji upload berbahaya, path traversal, dan penghapusan media terpakai.

### Tahap 4 — Halaman, setting, institusi

- Registry pages read-only, meta, section registry.
- Site settings allowlist.
- Profil institusi, visi, misi, tujuan.
- Organisasi dan anggota.

Gate: pastikan tidak ada field yang dapat mengubah layout/nav.

### Tahap 5 — Program studi

- Program, tag, item, media, cover, pemetaan halaman.
- Validasi unique `page_id` dan cover.

Gate: uji CRUD, publish, dan konflik relasi.

### Tahap 6 — Publikasi

- Kategori, channel, post, pivot many-to-many, cover, publish/archive.
- Filter channel/kategori dan unggulan.

Gate: uji pivot, status, dan tampilan data publik.

### Tahap 7 — Layanan

- Layanan, item, dokumen, publish.

Gate: uji kartu layanan dan dokumen.

### Tahap 8 — Jurnal

- Jurnal, artikel, dokumen, publish, PDF.

Gate: uji identitas NULL, DOI unik, dan unduhan.

### Tahap 9 — Biaya dan galeri

- Periode/komponen biaya, aktivasi tunggal, label nominal.
- Galeri, album, publish.

Gate: uji aturan satu periode aktif dan media galeri.

### Tahap 10 — Dashboard, API publik, pengerasan

- Dashboard statistik, audit log viewer.
- API publik read-only dan kontrak respons.
- Security review, rate limit, header, dokumentasi.
- Uji regresi dan dokumentasi operasional.

Gate: persetujuan sebelum integrasi frontend.

## 17. Pengujian dan Kriteria Selesai

### Unit

- Validator tipe/enum/rentang/slug/email/URL.
- Escape teks dan pembentukan paragraf.
- CSRF token dan perbandingan.
- Upload: MIME spoofing, ekstensi ganda, file terlalu besar, gambar rusak, PDF palsu.
- Role matrix dan aturan ownership.

### Feature/API

- Login valid/invalid/nonaktif/rate limited; session fixation; logout.
- CSRF hilang/salah pada semua mutasi.
- CRUD setiap modul + pagination + filter.
- Konflik unique, FK `RESTRICT`, dan rollback transaksi.
- Sinkronisasi `post_channels` (tambah/hapus) tanpa duplikasi.
- Satu cover per program.
- Hanya satu periode biaya aktif.
- Publik hanya melihat data terbit; draft tidak bocor.
- Field terlarang (status, role, `file_name`, `nav_path`) ditolak/diabaikan untuk role yang tidak berhak.
- Path traversal media dan akses media nonpublik ditolak.
- XSS: payload pada judul/body/alt tampil sebagai teks.
- SQL injection: payload pada filter/urut/pencarian tidak mengubah query.

### Statis dan operasional

- `php -l` untuk seluruh file.
- `composer validate`.
- Tidak ada kredensial di source; `.env` tidak masuk repository.
- Document root hanya `backend/public`; `storage/` tidak dapat diakses langsung.
- Log tidak memuat password/token.
- Backup database sebelum uji integrasi.

### Kriteria selesai Tahap 1–10

- 21 halaman terpetakan dan kontennya dapat dikelola tanpa field layout.
- 27 tabel terpakai sesuai peta modul; tidak ada perubahan skema.
- Tidak ada endpoint publik yang menulis data.
- Tidak ada password default/hardcoded.
- Tidak ada perubahan pada file frontend.
- Seluruh temuan keamanan kritis tertutup sebelum integrasi.

## 18. Keputusan yang Menunggu Persetujuan

1. **Integrasi frontend**: template PHP 1:1, hydration JS, atau static generation. Rekomendasi: template PHP 1:1 pada tahap terpisah.
2. **Penyimpanan media**: di luar document root + route `/media/{id}` (rekomendasi) atau `public/uploads` dengan proteksi tambahan.
3. **Admin UI**: server-rendered form (rekomendasi) atau API-driven vanilla JS.
4. **Field yang belum ada di skema**: jam layanan, sejarah, catatan biaya, kontak PMB, fokus jurnal. Rencana memakai `page_sections`/kolom yang ada; perubahan skema tidak dilakukan tanpa persetujuan.
5. **Audit log dan rate limit**: file-based (rekomendasi, tanpa ubah skema) atau tabel baru (butuh persetujuan).
6. **Kebijakan password**: minimal 12 karakter, tanpa reset via email. Pemulihan lewat CLI/admin.
7. **Deployment**: Apache virtual host ke `backend/public` atau `php -S localhost:8001 -t backend/public`.

## 19. Checklist Sebelum Coding

- [ ] Dokumen ini disetujui.
- [ ] Opsi integrasi frontend dan penyimpanan media dipilih.
- [ ] Database sudah diimpor oleh user dan 27 tabel terverifikasi.
- [ ] User MySQL terbatas dan `.env` sudah diisi (tidak dibagikan ke agen).
- [ ] Ekstensi PHP tersedia: `pdo_mysql`, `mbstring`, `fileinfo`, `gd`, `openssl`, `json`.
- [ ] Composer tersedia dan `composer install` disetujui.
- [ ] Document root diarahkan ke `backend/public`.
- [ ] Tidak ada file frontend yang akan diubah.
- [ ] Rencana pengujian dan database uji disiapkan.

Setelah checklist ini dan persetujuan tahap, implementasi dimulai dari Tahap 1 tanpa melompat ke modul CMS.
