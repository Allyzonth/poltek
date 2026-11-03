USE `politeknik_surabaya_cms`;

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE INDEX `idx_site_settings_group_sort` ON `site_settings` (`setting_group`, `sort_order`);
CREATE INDEX `idx_media_mime_type` ON `media` (`mime_type`);
CREATE INDEX `idx_media_uploaded_by` ON `media` (`uploaded_by`);
CREATE INDEX `idx_pages_nav_section_sort` ON `pages` (`nav_section`, `sort_order`);
CREATE INDEX `idx_page_sections_page_published_sort` ON `page_sections` (`page_id`, `is_published`, `sort_order`);
CREATE INDEX `idx_page_sections_media_id` ON `page_sections` (`media_id`);
CREATE INDEX `idx_institution_profile_logo_media_id` ON `institution_profile` (`logo_media_id`);
CREATE INDEX `idx_missions_profile_sort` ON `missions` (`institution_profile_id`, `sort_order`);
CREATE INDEX `idx_goals_profile_sort` ON `goals` (`institution_profile_id`, `sort_order`);
CREATE INDEX `idx_org_units_parent_id` ON `org_units` (`parent_id`);
CREATE INDEX `idx_org_members_unit_sort` ON `org_members` (`org_unit_id`, `sort_order`);
CREATE INDEX `idx_org_members_photo_media_id` ON `org_members` (`photo_media_id`);
CREATE INDEX `idx_programs_status_sort` ON `programs` (`status`, `sort_order`);
CREATE INDEX `idx_program_items_program_type_sort` ON `program_items` (`program_id`, `item_type`, `sort_order`);
CREATE INDEX `idx_program_media_media_id` ON `program_media` (`media_id`);
CREATE INDEX `idx_channels_active_sort` ON `channels` (`is_active`, `sort_order`);
CREATE INDEX `idx_posts_status_published_at` ON `posts` (`status`, `published_at`);
CREATE INDEX `idx_posts_category_id` ON `posts` (`category_id`);
CREATE INDEX `idx_posts_author_admin_id` ON `posts` (`author_admin_id`);
CREATE INDEX `idx_posts_cover_media_id` ON `posts` (`cover_media_id`);
CREATE INDEX `idx_post_channels_channel_id` ON `post_channels` (`channel_id`);
CREATE INDEX `idx_services_status_sort` ON `services` (`status`, `sort_order`);
CREATE INDEX `idx_service_items_service_sort` ON `service_items` (`service_id`, `sort_order`);
CREATE INDEX `idx_service_documents_media_id` ON `service_documents` (`media_id`);
CREATE INDEX `idx_journals_program_id` ON `journals` (`program_id`);
CREATE INDEX `idx_journals_status` ON `journals` (`status`);
CREATE INDEX `idx_journals_cover_media_id` ON `journals` (`cover_media_id`);
CREATE INDEX `idx_journal_articles_journal_status_date` ON `journal_articles` (`journal_id`, `status`, `published_at`);
CREATE INDEX `idx_journal_articles_pdf_media_id` ON `journal_articles` (`pdf_media_id`);
CREATE INDEX `idx_journal_documents_media_id` ON `journal_documents` (`media_id`);
CREATE INDEX `idx_tuition_periods_status_active` ON `tuition_periods` (`status`, `is_active`);
CREATE INDEX `idx_gallery_items_album_sort` ON `gallery_items` (`album_name`, `sort_order`);

ALTER TABLE `media`
  ADD CONSTRAINT `fk_media_uploaded_by` FOREIGN KEY (`uploaded_by`) REFERENCES `admin_users` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `page_sections`
  ADD CONSTRAINT `fk_page_sections_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT `fk_page_sections_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `institution_profile`
  ADD CONSTRAINT `fk_institution_profile_logo_media_id` FOREIGN KEY (`logo_media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `missions`
  ADD CONSTRAINT `fk_missions_institution_profile_id` FOREIGN KEY (`institution_profile_id`) REFERENCES `institution_profile` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `goals`
  ADD CONSTRAINT `fk_goals_institution_profile_id` FOREIGN KEY (`institution_profile_id`) REFERENCES `institution_profile` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `org_units`
  ADD CONSTRAINT `fk_org_units_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `org_units` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `org_members`
  ADD CONSTRAINT `fk_org_members_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `org_units` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_org_members_photo_media_id` FOREIGN KEY (`photo_media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `program_tags`
  ADD CONSTRAINT `fk_program_tags_program_id` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `program_items`
  ADD CONSTRAINT `fk_program_items_program_id` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `program_media`
  ADD CONSTRAINT `fk_program_media_program_id` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT `fk_program_media_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE `programs`
  ADD CONSTRAINT `fk_programs_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `channels`
  ADD CONSTRAINT `fk_channels_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `posts`
  ADD CONSTRAINT `fk_posts_category_id` FOREIGN KEY (`category_id`) REFERENCES `post_categories` (`id`) ON UPDATE CASCADE ON DELETE SET NULL,
  ADD CONSTRAINT `fk_posts_author_admin_id` FOREIGN KEY (`author_admin_id`) REFERENCES `admin_users` (`id`) ON UPDATE CASCADE ON DELETE SET NULL,
  ADD CONSTRAINT `fk_posts_cover_media_id` FOREIGN KEY (`cover_media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `post_channels`
  ADD CONSTRAINT `fk_post_channels_post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT `fk_post_channels_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE `services`
  ADD CONSTRAINT `fk_services_page_id` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `service_items`
  ADD CONSTRAINT `fk_service_items_service_id` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `service_documents`
  ADD CONSTRAINT `fk_service_documents_service_id` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT `fk_service_documents_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE `journals`
  ADD CONSTRAINT `fk_journals_program_id` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_journals_cover_media_id` FOREIGN KEY (`cover_media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `journal_articles`
  ADD CONSTRAINT `fk_journal_articles_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT `fk_journal_articles_pdf_media_id` FOREIGN KEY (`pdf_media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `journal_documents`
  ADD CONSTRAINT `fk_journal_documents_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  ADD CONSTRAINT `fk_journal_documents_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE `tuition_components`
  ADD CONSTRAINT `fk_tuition_components_tuition_period_id` FOREIGN KEY (`tuition_period_id`) REFERENCES `tuition_periods` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `gallery_items`
  ADD CONSTRAINT `fk_gallery_items_media_id` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;
