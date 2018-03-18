-- MySQL dump 10.15  Distrib 10.0.34-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: librivox_catalog
-- ------------------------------------------------------
-- Server version	10.0.34-MariaDB-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author_pseudonyms`
--

DROP TABLE IF EXISTS `author_pseudonyms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author_pseudonyms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1494 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) NOT NULL,
  `psuedo_first_name` varchar(55) DEFAULT NULL,
  `psuedo_last_name` varchar(55) DEFAULT NULL,
  `author_url` text,
  `other_url` text,
  `image_url` text,
  `dob` varchar(10) DEFAULT NULL,
  `dod` varchar(10) DEFAULT NULL,
  `name_hash` varchar(32) DEFAULT NULL,
  `confirmed` int(1) NOT NULL DEFAULT '0',
  `linked_to` int(11) NOT NULL DEFAULT '0',
  `blurb` text,
  `meta_complete` int(4) NOT NULL DEFAULT '0',
  `meta_in_progress` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13150 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ci_sessions`
--

DROP TABLE IF EXISTS `ci_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feeds`
--

DROP TABLE IF EXISTS `feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feeds` (
  `basemp3url` char(255) NOT NULL,
  `rssurl` char(255) NOT NULL,
  UNIQUE KEY `bm3u` (`basemp3url`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `file_number` int(3) NOT NULL,
  `key` varchar(40) NOT NULL,
  `value` text,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_generators`
--

DROP TABLE IF EXISTS `form_generators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_generators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_code` varchar(8) NOT NULL,
  `lang_select` varchar(25) NOT NULL DEFAULT 'english',
  `recorded_language` varchar(55) NOT NULL,
  `recorded_language_other` varchar(55) DEFAULT NULL,
  `author_list` text,
  `new_author_list` text,
  `trans_list` text,
  `new_trans_list` text,
  `project_type` varchar(55) NOT NULL,
  `title` text NOT NULL,
  `brief_summary` text NOT NULL,
  `brief_summary_by` varchar(55) NOT NULL,
  `link_to_text` varchar(255) NOT NULL,
  `link_to_auth` varchar(255) NOT NULL,
  `link_to_book` varchar(255) NOT NULL,
  `pub_year` int(4) NOT NULL,
  `edition_year` int(4) DEFAULT NULL,
  `expected_completion_day` int(2) NOT NULL,
  `expected_completion_month` int(2) NOT NULL,
  `expected_completion_year` int(4) NOT NULL,
  `proof_level` varchar(55) NOT NULL,
  `num_sections` int(3) NOT NULL,
  `has_preface` tinyint(1) NOT NULL,
  `is_compilation` tinyint(1) NOT NULL DEFAULT '0',
  `genres` text,
  `list_keywords` text NOT NULL,
  `forum_name` varchar(55) DEFAULT NULL,
  `soloist_name` varchar(55) DEFAULT NULL,
  `soloist_link` varchar(255) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_code` (`project_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5730 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_generators_authors`
--

DROP TABLE IF EXISTS `form_generators_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_generators_authors` (
  `auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_first_name` varchar(55) DEFAULT NULL,
  `auth_last_name` varchar(55) DEFAULT NULL,
  `auth_yob` int(4) DEFAULT NULL,
  `auth_yod` int(4) DEFAULT NULL,
  `link_to_auth` varchar(55) DEFAULT NULL,
  PRIMARY KEY (`auth_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2732 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(55) NOT NULL,
  `lineage` text NOT NULL,
  `deep` int(3) NOT NULL DEFAULT '0',
  `archive` varchar(55) DEFAULT NULL,
  `meta_complete` int(4) NOT NULL DEFAULT '0',
  `meta_in_progress` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_projects`
--

DROP TABLE IF EXISTS `group_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_projects` (
  `group_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=603 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `keywords`
--

DROP TABLE IF EXISTS `keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17189 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(55) NOT NULL,
  `native` varchar(55) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(12) NOT NULL,
  `common` tinyint(1) NOT NULL DEFAULT '0',
  `two_letter_code` char(2) DEFAULT NULL,
  `three_letter_code` char(3) DEFAULT NULL,
  `meta_complete` int(4) NOT NULL DEFAULT '0',
  `meta_in_progress` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_attempts` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_authors`
--

DROP TABLE IF EXISTS `project_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_authors` (
  `project_id` int(11) NOT NULL DEFAULT '0',
  `author_id` int(11) NOT NULL DEFAULT '0',
  `type` varchar(15) NOT NULL DEFAULT '',
  UNIQUE KEY `unq_key` (`project_id`,`author_id`,`type`),
  KEY `project_id_indx` (`project_id`),
  KEY `author_id_indx` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_categories`
--

DROP TABLE IF EXISTS `project_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_categories` (
  `category_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_genres`
--

DROP TABLE IF EXISTS `project_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_genres` (
  `project_id` int(11) NOT NULL DEFAULT '0',
  `genre_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`,`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_keywords`
--

DROP TABLE IF EXISTS `project_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_keywords` (
  `project_id` int(11) NOT NULL DEFAULT '0',
  `keyword_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`,`keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `project_readers`
--

DROP TABLE IF EXISTS `project_readers`;
/*!50001 DROP VIEW IF EXISTS `project_readers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `project_readers` (
  `reader_id` tinyint NOT NULL,
  `display_name` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `project_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `project_urls`
--

DROP TABLE IF EXISTS `project_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `label` varchar(55) NOT NULL,
  `order` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18553 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) DEFAULT '0',
  `person_bc_id` int(11) DEFAULT '0',
  `person_altbc_id` int(11) DEFAULT '0',
  `person_mc_id` int(11) DEFAULT '0',
  `person_pl_id` int(11) DEFAULT '0',
  `title_prefix` varchar(55) DEFAULT NULL,
  `title` text,
  `description` text,
  `project_type` varchar(55) DEFAULT NULL,
  `is_compilation` int(1) NOT NULL DEFAULT '0',
  `num_sections` int(11) DEFAULT '0',
  `has_preface` tinyint(1) DEFAULT '0',
  `date_target` date DEFAULT NULL,
  `date_catalog` date DEFAULT NULL,
  `status` varchar(55) DEFAULT NULL,
  `url_text_source` text,
  `url_project` text,
  `date_begin` date DEFAULT NULL,
  `copyright_year` int(4) DEFAULT NULL,
  `copyright_check` tinyint(1) NOT NULL DEFAULT '0',
  `url_librivox` text,
  `url_forum` text,
  `url_iarchive` text,
  `notes` text,
  `validator_dir` varchar(55) DEFAULT NULL,
  `totaltime` varchar(12) DEFAULT NULL,
  `zip_url` text,
  `zip_size` text,
  `coverart_pdf` text,
  `coverart_jpg` text,
  `coverart_thumbnail` text,
  PRIMARY KEY (`id`),
  KEY `language_id_indx` (`language_id`),
  KEY `status_indx` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=12601 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_extra_coverart`
--

DROP TABLE IF EXISTS `projects_extra_coverart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects_extra_coverart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `coverart_pdf` text,
  `coverart_jpg` text,
  `coverart_thumbnail` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `readers`
--

DROP TABLE IF EXISTS `readers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `readers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `section_number` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_table`
--

DROP TABLE IF EXISTS `search_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_field` varchar(255) NOT NULL,
  `source_table` varchar(255) NOT NULL,
  `source_id` int(11) NOT NULL,
  `section_language_id` int(11) DEFAULT NULL,
  `section_author_id` int(11) DEFAULT NULL,
  `section_reader_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51453 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `section_readers`
--

DROP TABLE IF EXISTS `section_readers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_readers` (
  `reader_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  PRIMARY KEY (`reader_id`,`section_id`),
  KEY `reader_id` (`reader_id`),
  KEY `section_id` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `section_status_count`
--

DROP TABLE IF EXISTS `section_status_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_status_count` (
  `project_id` int(11) NOT NULL,
  `status` varchar(55) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `section_number` int(11) DEFAULT '1',
  `title` text,
  `listen_url` text,
  `source` text,
  `author_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `status` varchar(55) DEFAULT 'Open',
  `word_count` int(11) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `playtime` int(11) DEFAULT NULL,
  `migrated_time` varchar(20) NOT NULL,
  `notes` text,
  `mp3_64_url` text,
  `mp3_64_size` text,
  `mp3_128_url` text,
  `mp3_128_size` text,
  `ogg_url` text,
  `ogg_size` text,
  PRIMARY KEY (`id`),
  KEY `proj_sec` (`project_id`,`section_number`)
) ENGINE=InnoDB AUTO_INCREMENT=423028 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total_projects` int(11) NOT NULL,
  `projects_last_month` int(11) NOT NULL,
  `non_english_projects` int(11) NOT NULL,
  `number_languages` int(11) NOT NULL,
  `number_readers` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1626 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` int(10) unsigned DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(80) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `max_projects` int(3) NOT NULL,
  `agreement` tinyint(1) NOT NULL DEFAULT '0',
  `display_name` varchar(50) DEFAULT NULL,
  `forum_name` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `display_name_indx` (`display_name`),
  KEY `username_indx` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12146 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25713 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `project_readers`
--

/*!50001 DROP TABLE IF EXISTS `project_readers`*/;
/*!50001 DROP VIEW IF EXISTS `project_readers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`catalog`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `project_readers` AS select distinct `u`.`id` AS `reader_id`,`u`.`display_name` AS `display_name`,`u`.`username` AS `username`,`s`.`project_id` AS `project_id` from ((`users` `u` join `section_readers` `sr` on((`u`.`id` = `sr`.`reader_id`))) join `sections` `s` on((`s`.`id` = `sr`.`section_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-18 20:47:33
