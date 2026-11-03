USE `politeknik_surabaya_cms`;

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `admin_users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(80) NOT NULL,
  `email` VARCHAR(190) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `display_name` VARCHAR(150) NOT NULL,
  `role` ENUM('super_admin', 'admin', 'editor') NOT NULL DEFAULT 'editor',
  `status` ENUM('active', 'inactive', 'suspended') NOT NULL DEFAULT 'active',
  `last_login_at` DATETIME NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_admin_users_username` (`username`),
  UNIQUE KEY `uq_admin_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `site_settings` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `setting_key` VARCHAR(120) NOT NULL,
  `setting_value` LONGTEXT NULL,
  `setting_group` VARCHAR(80) NOT NULL DEFAULT 'general',
  `input_type` ENUM('text', 'textarea', 'url', 'email', 'phone', 'image', 'boolean', 'number', 'json') NOT NULL DEFAULT 'text',
  `is_public` TINYINT(1) NOT NULL DEFAULT 1,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_site_settings_setting_key` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `media` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_name` VARCHAR(255) NOT NULL,
  `original_name` VARCHAR(255) NULL,
  `file_path` VARCHAR(500) NOT NULL,
  `mime_type` VARCHAR(150) NOT NULL,
  `extension` VARCHAR(20) NULL,
  `file_size` BIGINT UNSIGNED NULL,
  `width` INT UNSIGNED NULL,
  `height` INT UNSIGNED NULL,
  `title` VARCHAR(255) NULL,
  `alt_text` VARCHAR(255) NULL,
  `caption` TEXT NULL,
  `checksum_sha256` CHAR(64) NULL,
  `is_public` TINYINT(1) NOT NULL DEFAULT 1,
  `uploaded_by` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_media_file_path` (`file_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `pages` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(190) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `file_name` VARCHAR(190) NOT NULL,
  `nav_section` VARCHAR(80) NULL,
  `nav_path` VARCHAR(100) NULL,
  `meta_title` VARCHAR(255) NULL,
  `meta_description` VARCHAR(320) NULL,
  `is_published` TINYINT(1) NOT NULL DEFAULT 1,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_pages_slug` (`slug`),
  UNIQUE KEY `uq_pages_file_name` (`file_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `page_sections` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `page_id` BIGINT UNSIGNED NOT NULL,
  `section_key` VARCHAR(120) NOT NULL,
  `section_type` ENUM('hero', 'text', 'features', 'list', 'cta', 'gallery', 'contact', 'custom') NOT NULL DEFAULT 'text',
  `heading` VARCHAR(255) NULL,
  `subheading` VARCHAR(255) NULL,
  `body` LONGTEXT NULL,
  `content_json` JSON NULL,
  `media_id` BIGINT UNSIGNED NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_published` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_page_sections_page_section` (`page_id`, `section_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `institution_profile` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `profile_key` VARCHAR(50) NOT NULL DEFAULT 'main',
  `legal_name` VARCHAR(255) NULL,
  `short_name` VARCHAR(150) NOT NULL,
  `tagline` VARCHAR(255) NULL,
  `description` LONGTEXT NULL,
  `vision` TEXT NULL,
  `address` TEXT NULL,
  `phone` VARCHAR(50) NULL,
  `fax` VARCHAR(50) NULL,
  `whatsapp` VARCHAR(50) NULL,
  `email` VARCHAR(190) NULL,
  `website` VARCHAR(255) NULL,
  `npsn` VARCHAR(30) NULL,
  `sk_number` VARCHAR(100) NULL,
  `established_year` SMALLINT UNSIGNED NULL,
  `logo_media_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_institution_profile_profile_key` (`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `missions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `institution_profile_id` BIGINT UNSIGNED NOT NULL,
  `mission_text` TEXT NOT NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `goals` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `institution_profile_id` BIGINT UNSIGNED NOT NULL,
  `goal_text` TEXT NOT NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `org_units` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` BIGINT UNSIGNED NULL,
  `slug` VARCHAR(190) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `unit_type` ENUM('management', 'academic', 'support', 'program', 'other') NOT NULL DEFAULT 'other',
  `description` TEXT NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_org_units_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `org_members` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `org_unit_id` BIGINT UNSIGNED NOT NULL,
  `full_name` VARCHAR(150) NOT NULL,
  `position_title` VARCHAR(150) NOT NULL,
  `photo_media_id` BIGINT UNSIGNED NULL,
  `email` VARCHAR(190) NULL,
  `phone` VARCHAR(50) NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `programs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(30) NOT NULL,
  `slug` VARCHAR(190) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `short_name` VARCHAR(100) NULL,
  `page_id` BIGINT UNSIGNED NULL,
  `degree_level` ENUM('D3', 'D4', 'S1', 'S2', 'S3') NULL,
  `accreditation` VARCHAR(150) NULL,
  `duration_semesters` TINYINT UNSIGNED NULL,
  `description` TEXT NULL,
  `is_featured` TINYINT(1) NOT NULL DEFAULT 0,
  `status` ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_programs_code` (`code`),
  UNIQUE KEY `uq_programs_slug` (`slug`),
  UNIQUE KEY `uq_programs_page_id` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `program_tags` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `program_id` BIGINT UNSIGNED NOT NULL,
  `tag` VARCHAR(100) NOT NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_program_tags_program_tag` (`program_id`, `tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `program_items` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `program_id` BIGINT UNSIGNED NOT NULL,
  `item_type` ENUM('overview', 'highlight', 'curriculum', 'facility', 'career', 'vision', 'mission', 'goal', 'document', 'other') NOT NULL DEFAULT 'other',
  `title` VARCHAR(200) NOT NULL,
  `body` LONGTEXT NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_published` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `program_media` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `program_id` BIGINT UNSIGNED NOT NULL,
  `media_id` BIGINT UNSIGNED NOT NULL,
  `media_role` ENUM('cover', 'gallery', 'document') NOT NULL DEFAULT 'gallery',
  `cover_program_id` BIGINT UNSIGNED GENERATED ALWAYS AS (
    CASE WHEN `media_role` = 'cover' THEN `program_id` ELSE NULL END
  ) STORED,
  `caption` VARCHAR(255) NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_program_media_cover_program_id` (`cover_program_id`),
  UNIQUE KEY `uq_program_media_program_media_role` (`program_id`, `media_id`, `media_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `post_categories` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(190) NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  `description` TEXT NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_post_categories_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `channels` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(190) NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  `description` TEXT NULL,
  `page_id` BIGINT UNSIGNED NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_channels_slug` (`slug`),
  UNIQUE KEY `uq_channels_page_id` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `posts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` BIGINT UNSIGNED NULL,
  `author_admin_id` BIGINT UNSIGNED NULL,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(190) NOT NULL,
  `excerpt` TEXT NULL,
  `body` LONGTEXT NULL,
  `cover_media_id` BIGINT UNSIGNED NULL,
  `status` ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
  `is_featured` TINYINT(1) NOT NULL DEFAULT 0,
  `published_at` DATETIME NULL,
  `meta_title` VARCHAR(255) NULL,
  `meta_description` VARCHAR(320) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_posts_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `post_channels` (
  `post_id` BIGINT UNSIGNED NOT NULL,
  `channel_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`, `channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `services` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(190) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `icon` VARCHAR(100) NULL,
  `page_id` BIGINT UNSIGNED NULL,
  `status` ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_services_slug` (`slug`),
  UNIQUE KEY `uq_services_page_id` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `service_items` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `service_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `icon` VARCHAR(100) NULL,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_service_items_service_title` (`service_id`, `title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `service_documents` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `service_id` BIGINT UNSIGNED NOT NULL,
  `media_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `document_type` ENUM('form', 'guide', 'regulation', 'report', 'other') NOT NULL DEFAULT 'other',
  `is_public` TINYINT(1) NOT NULL DEFAULT 1,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_service_documents_service_media` (`service_id`, `media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `journals` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `program_id` BIGINT UNSIGNED NULL,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(190) NOT NULL,
  `abbreviation` VARCHAR(50) NULL,
  `issn` VARCHAR(30) NULL,
  `eissn` VARCHAR(30) NULL,
  `publisher` VARCHAR(190) NULL,
  `publication_frequency` VARCHAR(100) NULL,
  `description` LONGTEXT NULL,
  `editorial_board` TEXT NULL,
  `website_url` VARCHAR(255) NULL,
  `contact_email` VARCHAR(190) NULL,
  `cover_media_id` BIGINT UNSIGNED NULL,
  `status` ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_journals_slug` (`slug`),
  UNIQUE KEY `uq_journals_issn` (`issn`),
  UNIQUE KEY `uq_journals_eissn` (`eissn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `journal_articles` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `journal_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(190) NOT NULL,
  `authors` TEXT NULL,
  `abstract` LONGTEXT NULL,
  `keywords` VARCHAR(500) NULL,
  `volume` VARCHAR(30) NULL,
  `issue` VARCHAR(30) NULL,
  `page_start` INT UNSIGNED NULL,
  `page_end` INT UNSIGNED NULL,
  `published_at` DATE NULL,
  `doi` VARCHAR(255) NULL,
  `pdf_media_id` BIGINT UNSIGNED NULL,
  `status` ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_journal_articles_journal_slug` (`journal_id`, `slug`),
  UNIQUE KEY `uq_journal_articles_doi` (`doi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `journal_documents` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `journal_id` BIGINT UNSIGNED NOT NULL,
  `media_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `document_type` ENUM('form', 'guide', 'regulation', 'report', 'other') NOT NULL DEFAULT 'other',
  `is_public` TINYINT(1) NOT NULL DEFAULT 1,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_journal_documents_journal_media` (`journal_id`, `media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tuition_periods` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `academic_year` VARCHAR(20) NOT NULL,
  `term` ENUM('ganjil', 'genap', 'antara') NOT NULL,
  `name` VARCHAR(120) NULL,
  `status` ENUM('draft', 'published', 'archived') NOT NULL DEFAULT 'draft',
  `is_active` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tuition_periods_year_term` (`academic_year`, `term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `tuition_components` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tuition_period_id` BIGINT UNSIGNED NOT NULL,
  `component_code` VARCHAR(50) NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  `description` TEXT NULL,
  `amount` DECIMAL(15, 2) NULL,
  `currency` CHAR(3) NOT NULL DEFAULT 'IDR',
  `amount_label` VARCHAR(150) NOT NULL DEFAULT 'Belum tersedia',
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tuition_components_period_code` (`tuition_period_id`, `component_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `gallery_items` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_id` BIGINT UNSIGNED NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `album_name` VARCHAR(120) NOT NULL DEFAULT 'Galeri Foto',
  `is_published` TINYINT(1) NOT NULL DEFAULT 1,
  `sort_order` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `published_at` DATETIME NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_gallery_items_media_album` (`media_id`, `album_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
