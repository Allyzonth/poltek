# Database CMS Politeknik Surabaya

Tahap ini hanya menyiapkan file SQL dan dokumentasi. Tidak ada eksekusi SQL, pembuatan database, perubahan database MySQL, atau perubahan file frontend.

## Ruang Lingkup

- Database: `politeknik_surabaya_cms`
- Engine: InnoDB
- Character set: `utf8mb4`
- Collation: `utf8mb4_unicode_ci`
- Total tabel: 27
- Total foreign key: 32
- Total index: 91 (27 primary key, 32 unique key, dan 32 index tambahan)
- Backend target: PHP Native + MySQL
- Frontend tidak diubah

## Prasyarat

- MySQL 8.0 atau lebih baru disarankan.
- MySQL 5.7.9 atau lebih baru dapat digunakan karena row format InnoDB default sudah `DYNAMIC`; tipe `JSON` dan generated column tersedia sejak 5.7.8.
- MySQL 5.7.8 berisiko gagal saat membuat unique index `media.file_path` dan `journal_articles.doi` karena batas 767 byte pada row format `COMPACT`. Jika memakai versi tersebut, set `innodb_default_row_format=DYNAMIC` sebelum menjalankan file 02.
- MySQL Workbench sudah terhubung ke server MySQL.

## File SQL

| Urutan | File | Fungsi |
| --- | --- | --- |
| 1 | `01_create_database.sql` | Membuat database dan memilih schema. Tidak menghapus database yang sudah ada. |
| 2 | `02_create_tables.sql` | Membuat 27 tabel beserta primary key dan unique constraint. |
| 3 | `03_foreign_keys_indexes.sql` | Membuat index tambahan lalu menambahkan foreign key. |
| 4 | `04_initial_data.sql` | Mengisi data awal teknis dan placeholder. |

Jalankan file secara berurutan pada koneksi MySQL yang sama. File 02, 03, dan 04 sudah memakai `USE politeknik_surabaya_cms`, tetapi database harus dibuat melalui file 01 terlebih dahulu.

## Urutan Eksekusi di MySQL Workbench

1. Buka MySQL Workbench dan hubungkan ke server MySQL.
2. Pilih **File > Open SQL Script**, buka `database/01_create_database.sql`.
3. Jalankan seluruh script dengan tombol **Execute**.
4. Di panel **Schemas**, klik **Refresh**. Schema `politeknik_surabaya_cms` akan muncul.
5. Klik kanan schema tersebut dan pilih **Set as Default Schema**.
6. Buka `database/02_create_tables.sql`, lalu jalankan seluruh script.
7. Buka `database/03_foreign_keys_indexes.sql`, lalu jalankan seluruh script.
8. Buka `database/04_initial_data.sql`, lalu jalankan seluruh script.
9. Verifikasi hasil dengan query di bagian **Verifikasi**.

Jangan menjalankan file 03 atau 04 sebelum file sebelumnya selesai tanpa error.

## Kelompok Tabel

| Kelompok | Tabel |
| --- | --- |
| Fondasi | `admin_users`, `site_settings`, `media`, `pages`, `page_sections` |
| Institusi dan organisasi | `institution_profile`, `missions`, `goals`, `org_units`, `org_members` |
| Program studi | `programs`, `program_tags`, `program_items`, `program_media` |
| Publikasi | `posts`, `post_categories`, `channels`, `post_channels` (pivot) |
| Layanan | `services`, `service_items`, `service_documents` |
| Jurnal | `journals`, `journal_articles`, `journal_documents` |
| Biaya | `tuition_periods`, `tuition_components` |
| Galeri | `gallery_items` |

## Aturan Relasi dan Penghapusan

- Konten anak seperti section halaman, tag program, item layanan, artikel jurnal, dan komponen biaya memakai `ON DELETE CASCADE` ketika induknya dihapus.
- Media yang masih dipakai oleh program, layanan, jurnal, atau galeri memakai `ON DELETE RESTRICT`, sehingga file media tidak bisa dihapus selama masih direferensikan.
- Media opsional seperti logo, cover berita, foto anggota, dan PDF artikel memakai `ON DELETE SET NULL`.
- Relasi `post_channels` adalah pivot many-to-many. Baris pivot ikut terhapus saat post dihapus, tetapi channel yang masih memiliki post memakai `ON DELETE RESTRICT`.
- Program tidak dapat dihapus selama masih direferensikan oleh jurnal (`ON DELETE RESTRICT`).
- `programs.page_id` bersifat nullable dan unik. Satu halaman hanya boleh dipetakan ke satu program, tetapi program tanpa halaman tetap valid. Jika halaman dihapus, `programs.page_id` menjadi `NULL`.
- Unit organisasi tidak dapat dihapus selama masih memiliki anggota (`ON DELETE RESTRICT`).
- Admin yang dihapus tidak menghapus media; kolom `media.uploaded_by` menjadi `NULL`.
- `program_media` memakai generated column `cover_program_id` dengan unique index agar setiap program hanya memiliki satu media berperan `cover`.
- Halaman yang dihapus akan membuat relasi kanal, layanan, atau program menjadi `NULL`.

## Kolom Identitas dan Relasi Tambahan

- `institution_profile.fax` menyimpan nomor fax institusi. Nilainya diisi dari nomor fax yang tampil pada halaman kontak frontend.
- `institution_profile.vision` disediakan untuk pernyataan visi resmi. Kolom ini dibiarkan `NULL` karena belum ada rumusan visi resmi yang terverifikasi.
- `programs.page_id` menghubungkan program studi ke halaman rilisnya. Relasi ini memakai unique index dan `ON DELETE SET NULL`.
- `programs.accreditation` disediakan untuk status akreditasi program. Kolom ini dibiarkan `NULL` sampai ada sumber resmi.
- `journals.publisher`, `journals.publication_frequency`, `journals.editorial_board`, dan `journals.contact_email` disediakan untuk identitas jurnal. Semua kolom dibiarkan `NULL` karena identitas resmi belum tersedia.

## Data Awal

Data awal yang disediakan:

- 21 registry halaman website.
- 3 program studi D3 beserta 12 tag teknis, masing-masing dipetakan ke halaman 6, 7, dan 8.
- 5 jenis layanan placeholder berstatus `draft`.
- 3 channel publikasi: berita, kegiatan, dan pengumuman.
- 3 data jurnal berstatus `draft` dengan identitas resmi sebagai placeholder; kolom penerbit, frekuensi terbit, dewan editor, dan email kontak dibiarkan `NULL`.
- 6 media: 5 gambar konten dan 1 logo.
- 5 item galeri yang belum dipublikasikan.
- 1 profil institusi, termasuk nomor fax dari halaman kontak frontend; kolom `vision` dibiarkan `NULL`.
- 8 site settings untuk sosial, footer, SEO, dan teknis.

Identitas dan kontak institusi hanya disimpan di `institution_profile`. `site_settings` tidak menduplikasi nama, deskripsi, alamat, telepon, email, atau WhatsApp institusi. Nilai `footer_copyright` memakai placeholder `{year}` yang harus diganti tahun berjalan saat runtime.

Data kontak dan teks umum berasal dari halaman frontend yang sudah ada. Fakta resmi yang belum terverifikasi dibiarkan `NULL` atau memakai placeholder eksplisit. Tidak ada nominal biaya, akreditasi, pernyataan visi, nama pejabat, atau identitas jurnal resmi (penerbit, frekuensi terbit, dewan editor, email kontak) yang dikarang.

Tabel berikut sengaja tidak diisi:

`admin_users`, `page_sections`, `missions`, `goals`, `org_units`, `org_members`, `program_items`, `program_media`, `post_categories`, `posts`, `post_channels`, `service_items`, `service_documents`, `journal_articles`, `journal_documents`, `tuition_periods`, `tuition_components`.

## Akun Admin

Tidak ada akun admin yang di-seed dan tidak ada password hardcoded. Saat tahap PHP dimulai, buat akun pertama menggunakan `password_hash()` dari PHP, lalu simpan hash tersebut ke kolom `admin_users.password_hash`. Jangan menyimpan password plaintext.

## Verifikasi

Jalankan query berikut setelah seluruh script selesai:

```sql
USE `politeknik_surabaya_cms`;

SHOW TABLES;

SELECT COUNT(*) AS total_pages FROM `pages`;
SELECT COUNT(*) AS total_programs FROM `programs`;
SELECT COUNT(*) AS total_services FROM `services`;
SELECT COUNT(*) AS total_services_draft FROM `services` WHERE `status` = 'draft';
SELECT COUNT(*) AS total_channels FROM `channels`;
SELECT COUNT(*) AS total_post_channels FROM `post_channels`;
SELECT COUNT(*) AS total_journals FROM `journals`;
SELECT COUNT(*) AS total_media FROM `media`;
SELECT COUNT(*) AS total_site_settings FROM `site_settings`;
SELECT COUNT(*) AS total_gallery_published FROM `gallery_items` WHERE `is_published` = 1;

SELECT COUNT(*) AS total_foreign_keys
FROM `information_schema`.`TABLE_CONSTRAINTS`
WHERE `CONSTRAINT_SCHEMA` = 'politeknik_surabaya_cms'
  AND `CONSTRAINT_TYPE` = 'FOREIGN KEY';

SELECT COUNT(DISTINCT `TABLE_NAME`, `INDEX_NAME`) AS total_indexes
FROM `information_schema`.`STATISTICS`
WHERE `TABLE_SCHEMA` = 'politeknik_surabaya_cms';
```

Hasil yang diharapkan:

- `SHOW TABLES` menampilkan 27 tabel.
- `total_pages` = 21.
- `total_programs` = 3.
- `total_services` = 5.
- `total_services_draft` = 5.
- `total_channels` = 3.
- `total_post_channels` = 0.
- `total_journals` = 3.
- `total_media` = 6.
- `total_site_settings` = 8.
- `total_gallery_published` = 0.
- `total_foreign_keys` = 32.
- `total_indexes` = 91.

## Catatan Eksekusi

- Script menggunakan `CREATE TABLE IF NOT EXISTS`, tetapi index dan foreign key pada file 03 tidak idempotent. Jalankan file 03 satu kali pada schema yang baru dibuat.
- Revisi ini menambah kolom identitas institusi (`fax`, `vision`), relasi `programs.page_id`, kolom `programs.accreditation`, serta kolom identitas jurnal. File 02 memakai `CREATE TABLE IF NOT EXISTS`, sehingga schema lama tidak akan menerima kolom baru secara otomatis. Jalankan pada schema baru; schema lama harus dibuat ulang secara manual.
- File 04 memakai ID eksplisit. Jangan jalankan dua kali tanpa mengosongkan atau membuat ulang schema terlebih dahulu.
- Tidak ada perintah `DROP`, `TRUNCATE`, atau `DELETE` di dalam file SQL.
- Jika ingin mengulang dari awal, lakukan reset database secara manual di MySQL Workbench di luar file SQL ini.
- Jika file 03 gagal karena index sudah ada, schema kemungkinan sudah pernah menjalankan file 03. Periksa kondisi schema sebelum mengulang.
