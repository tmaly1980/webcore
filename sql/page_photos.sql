CREATE TABLE `webcore_page_photos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `site_id` int(10) unsigned DEFAULT NULL,
  `caption` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  /*
  `crop_x` int(10) unsigned DEFAULT NULL,
  `crop_y` int(10) unsigned DEFAULT NULL,
  `crop_h` int(10) unsigned DEFAULT NULL,
  `crop_w` int(10) unsigned DEFAULT NULL,
  */
  PRIMARY KEY (`id`)
);
