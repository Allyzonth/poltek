USE `politeknik_surabaya_cms`;

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO `site_settings` (`id`, `setting_key`, `setting_value`, `setting_group`, `input_type`, `is_public`, `sort_order`) VALUES
(1, 'social_facebook', '', 'sosial', 'url', 1, 1),
(2, 'social_instagram', '', 'sosial', 'url', 1, 2),
(3, 'social_youtube', '', 'sosial', 'url', 1, 3),
(4, 'footer_copyright', '© {year} Politeknik Surabaya (Dharma Bakti). Hak Cipta Dilindungi.', 'footer', 'text', 1, 1),
(5, 'seo_default_description', NULL, 'seo', 'textarea', 1, 1),
(6, 'seo_robots', 'index, follow', 'seo', 'text', 1, 2),
(7, 'maintenance_mode', '0', 'teknis', 'boolean', 0, 1),
(8, 'site_timezone', 'Asia/Jakarta', 'teknis', 'text', 0, 2);

INSERT INTO `media` (`id`, `file_name`, `original_name`, `file_path`, `mime_type`, `extension`, `file_size`, `width`, `height`, `title`, `alt_text`, `caption`, `checksum_sha256`, `is_public`) VALUES
(1, 'laboratorium-komputasi.jpg', 'laboratorium-komputasi.jpg', 'assets/images/laboratorium-komputasi.jpg', 'image/jpeg', 'jpg', NULL, NULL, NULL, 'Laboratorium Komputasi', 'Laboratorium Komputasi', 'Dokumentasi fasilitas laboratorium komputasi.', NULL, 1),
(2, 'pendidikan-vokasi.jpg', 'pendidikan-vokasi.jpg', 'assets/images/pendidikan-vokasi.jpg', 'image/jpeg', 'jpg', NULL, NULL, NULL, 'Pendidikan Vokasi', 'Pendidikan Vokasi', 'Dokumentasi kegiatan pendidikan vokasi.', NULL, 1),
(3, 'visitasi-ban-pt.jpg', 'visitasi-ban-pt.jpg', 'assets/images/visitasi-ban-pt.jpg', 'image/jpeg', 'jpg', NULL, NULL, NULL, 'Visitasi BAN-PT', 'Visitasi BAN-PT', 'Dokumentasi kegiatan visitasi asesor BAN-PT.', NULL, 1),
(4, 'be-the-best-in-digital-era.jpg', 'be-the-best-in-digital-era.jpg', 'assets/images/be-the-best-in-digital-era.jpg', 'image/jpeg', 'jpg', NULL, NULL, NULL, 'Be the Best in Digital Era', 'Be the Best in Digital Era', 'Dokumentasi kegiatan bertema transformasi digital.', NULL, 1),
(5, 'beasiswa-dosen.jpg', 'beasiswa-dosen.jpg', 'assets/images/beasiswa-dosen.jpg', 'image/jpeg', 'jpg', NULL, NULL, NULL, 'Beasiswa Dosen', 'Beasiswa Dosen', 'Dokumentasi program pengembangan dosen.', NULL, 1),
(6, 'logo-politeknik-surabaya.jpg', 'logo-politeknik-surabaya.jpg', 'assets/logo/logo-politeknik-surabaya.jpg', 'image/jpeg', 'jpg', NULL, NULL, NULL, 'Logo Politeknik Surabaya', 'Logo Politeknik Surabaya', NULL, NULL, 1);

INSERT INTO `institution_profile` (`id`, `profile_key`, `legal_name`, `short_name`, `tagline`, `description`, `vision`, `address`, `phone`, `fax`, `whatsapp`, `email`, `website`, `npsn`, `sk_number`, `established_year`, `logo_media_id`) VALUES
(1, 'main', NULL, 'Politeknik Surabaya', 'Dharma Bakti', 'Institusi pendidikan tinggi vokasi yang berkomitmen melahirkan lulusan berdaya saing global, terampil, dan adaptif terhadap transformasi teknologi digital.', NULL, 'Jl. Kaliwaron 58-60 Surabaya, Jawa Timur, Indonesia', '(031) 8433224-25', '(031) 8432050', NULL, 'info@dharmabakti.ac.id', NULL, NULL, NULL, NULL, 6);

INSERT INTO `pages` (`id`, `slug`, `title`, `file_name`, `nav_section`, `nav_path`, `meta_title`, `meta_description`, `is_published`, `sort_order`) VALUES
(1, 'beranda', 'Politeknik Surabaya (Dharma Bakti)', 'index.html', 'beranda', 'beranda', NULL, NULL, 1, 1),
(2, 'tentang-kami', 'Profil Institusi', 'profil.html', 'profil', 'tentang-kami', NULL, NULL, 1, 2),
(3, 'visi-dan-misi', 'Visi dan Misi', 'visi-misi.html', 'profil', 'visi-dan-misi', NULL, NULL, 1, 3),
(4, 'struktur-organisasi', 'Struktur Organisasi', 'struktur-organisasi.html', 'profil', 'struktur-organisasi', NULL, NULL, 1, 4),
(5, 'program-studi', 'Program Studi', 'program-studi.html', 'akademik', 'program-studi', NULL, NULL, 1, 5),
(6, 'teknik-komputer', 'Teknik Komputer (D3)', 'teknik-komputer.html', 'akademik', 'teknik-komputer', NULL, NULL, 1, 6),
(7, 'manajemen-informatika', 'Manajemen Informatika', 'manajemen-informatika.html', 'akademik', 'manajemen-informatika', NULL, NULL, 1, 7),
(8, 'komputerisasi-akuntansi', 'Komputerisasi Akuntansi', 'komputerisasi-akuntansi.html', 'akademik', 'komputerisasi-akuntansi', NULL, NULL, 1, 8),
(9, 'sertifikasi', 'Sertifikasi Profesi', 'sertifikasi-profesi.html', 'akademik', 'sertifikasi', NULL, NULL, 1, 9),
(10, 'jurnal-mi', 'Jurnal Manajemen Informatika', 'jurnal-mi.html', 'akademik', 'jurnal-mi', NULL, NULL, 1, 10),
(11, 'jurnal-tk', 'Jurnal Teknik Komputer', 'jurnal-tk.html', 'akademik', 'jurnal-tk', NULL, NULL, 1, 11),
(12, 'jurnal-ka', 'Jurnal Komputerisasi Akuntansi', 'jurnal-ka.html', 'akademik', 'jurnal-ka', NULL, NULL, 1, 12),
(13, 'biaya-pendidikan', 'Biaya Pendidikan', 'biaya-pendidikan.html', 'akademik', 'biaya-pendidikan', NULL, NULL, 1, 13),
(14, 'tracer-study', 'Tracer Study', 'tracer-study.html', 'layanan', 'tracer-study', NULL, NULL, 1, 14),
(15, 'plagiasi', 'Layanan Bebas Plagiasi', 'layanan-bebas-plagiasi.html', 'layanan', 'plagiasi', NULL, NULL, 1, 15),
(16, 'review', 'Review Akademik', 'review-akademik.html', 'layanan', 'review', NULL, NULL, 1, 16),
(17, 'berita-kampus', 'Berita Kampus', 'berita.html', 'berita', 'berita-kampus', NULL, NULL, 1, 17),
(18, 'kegiatan', 'Kegiatan Civitas', 'kegiatan-civitas.html', 'berita', 'kegiatan', NULL, NULL, 1, 18),
(19, 'pengumuman', 'Pengumuman', 'pengumuman.html', 'berita', 'pengumuman', NULL, NULL, 1, 19),
(20, 'galeri-foto', 'Galeri Foto', 'galeri.html', 'galeri', 'galeri-foto', NULL, NULL, 1, 20),
(21, 'pendaftaran', 'Pendaftaran', 'pendaftaran.html', 'pendaftaran', 'pendaftaran', NULL, NULL, 1, 21);

INSERT INTO `channels` (`id`, `slug`, `name`, `description`, `page_id`, `is_active`, `sort_order`) VALUES
(1, 'berita', 'Berita Kampus', NULL, 17, 1, 1),
(2, 'kegiatan', 'Kegiatan Civitas', NULL, 18, 1, 2),
(3, 'pengumuman', 'Pengumuman', NULL, 19, 1, 3);

INSERT INTO `programs` (`id`, `code`, `slug`, `name`, `short_name`, `page_id`, `degree_level`, `accreditation`, `duration_semesters`, `description`, `is_featured`, `status`, `sort_order`) VALUES
(1, 'TK', 'teknik-komputer', 'Teknik Komputer', 'Teknik Komputer', 6, 'D3', NULL, NULL, 'Pelajari arsitektur jaringan komputer, rekayasa perangkat keras, mikrokontroler, sistem kontrol otomatis, dan implementasi teknologi robotik industri.', 1, 'published', 1),
(2, 'MI', 'manajemen-informatika', 'Manajemen Informatika', 'Manajemen Informatika', 7, 'D3', NULL, NULL, 'Kembangkan kemampuan rekayasa pemrograman, analisis dan perancangan sistem informasi, tata kelola basis data enterprise, dan arsitektur aplikasi berbasis cloud.', 1, 'published', 2),
(3, 'KA', 'komputerisasi-akuntansi', 'Komputerisasi Akuntansi', 'Komputerisasi Akuntansi', 8, 'D3', NULL, NULL, 'Padukan prinsip akuntansi komprehensif dengan sistem informasi keuangan digital, perpajakan terotomasi, audit teknologi informasi, dan analisis finansial korporat.', 1, 'published', 3);

INSERT INTO `program_tags` (`id`, `program_id`, `tag`, `sort_order`) VALUES
(1, 1, 'Jaringan Komputer', 1),
(2, 1, 'Perangkat Keras', 2),
(3, 1, 'Sistem Kontrol', 3),
(4, 1, 'IoT & Sensor', 4),
(5, 2, 'Pemrograman Web', 1),
(6, 2, 'Basis Data', 2),
(7, 2, 'Sistem Informasi', 3),
(8, 2, 'Software Eng.', 4),
(9, 3, 'Sistem Akuntansi', 1),
(10, 3, 'Financial Tech', 2),
(11, 3, 'Database Keuangan', 3),
(12, 3, 'Audit TI', 4);

INSERT INTO `services` (`id`, `slug`, `name`, `description`, `icon`, `page_id`, `status`, `sort_order`) VALUES
(1, 'sertifikasi-profesi', 'Sertifikasi Profesi', 'Informasi rinci layanan sertifikasi profesi belum tersedia dan akan dikelola melalui CMS.', NULL, 9, 'draft', 1),
(2, 'tracer-study', 'Tracer Study', 'Informasi rinci layanan tracer study belum tersedia dan akan dikelola melalui CMS.', NULL, 14, 'draft', 2),
(3, 'layanan-bebas-plagiasi', 'Layanan Bebas Plagiasi', 'Informasi rinci layanan bebas plagiasi belum tersedia dan akan dikelola melalui CMS.', NULL, 15, 'draft', 3),
(4, 'review-akademik', 'Review Akademik', 'Informasi rinci layanan review akademik belum tersedia dan akan dikelola melalui CMS.', NULL, 16, 'draft', 4),
(5, 'pendaftaran', 'Pendaftaran', 'Informasi rinci layanan pendaftaran belum tersedia dan akan dikelola melalui CMS.', NULL, 21, 'draft', 5);

INSERT INTO `journals` (`id`, `program_id`, `name`, `slug`, `abbreviation`, `issn`, `eissn`, `description`, `website_url`, `cover_media_id`, `status`) VALUES
(1, 1, 'Jurnal Program Studi Teknik Komputer (placeholder)', 'jurnal-teknik-komputer', NULL, NULL, NULL, 'Identitas resmi jurnal belum tersedia dan harus diverifikasi melalui kanal resmi kampus.', NULL, NULL, 'draft'),
(2, 2, 'Jurnal Program Studi Manajemen Informatika (placeholder)', 'jurnal-manajemen-informatika', NULL, NULL, NULL, 'Identitas resmi jurnal belum tersedia dan harus diverifikasi melalui kanal resmi kampus.', NULL, NULL, 'draft'),
(3, 3, 'Jurnal Program Studi Komputerisasi Akuntansi (placeholder)', 'jurnal-komputerisasi-akuntansi', NULL, NULL, NULL, 'Identitas resmi jurnal belum tersedia dan harus diverifikasi melalui kanal resmi kampus.', NULL, NULL, 'draft');

INSERT INTO `gallery_items` (`id`, `media_id`, `title`, `description`, `album_name`, `is_published`, `sort_order`, `published_at`) VALUES
(1, 1, 'Laboratorium Komputasi', 'Dokumentasi fasilitas laboratorium komputasi.', 'Galeri Foto', 0, 1, NULL),
(2, 2, 'Pendidikan Vokasi', 'Dokumentasi kegiatan pendidikan vokasi.', 'Galeri Foto', 0, 2, NULL),
(3, 3, 'Visitasi BAN-PT', 'Dokumentasi kegiatan visitasi asesor BAN-PT.', 'Galeri Foto', 0, 3, NULL),
(4, 4, 'Be the Best in Digital Era', 'Dokumentasi kegiatan bertema transformasi digital.', 'Galeri Foto', 0, 4, NULL),
(5, 5, 'Beasiswa Dosen', 'Dokumentasi program pengembangan dosen.', 'Galeri Foto', 0, 5, NULL);
