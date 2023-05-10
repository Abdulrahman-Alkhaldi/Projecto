CREATE DATABASE  IF NOT EXISTS `chatgbt` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chatgbt`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: chatgbt
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_user`
--

DROP TABLE IF EXISTS `account_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `account_user_email_0bd7c421_uniq` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_user`
--

LOCK TABLES `account_user` WRITE;
/*!40000 ALTER TABLE `account_user` DISABLE KEYS */;
INSERT INTO `account_user` VALUES (1,'pbkdf2_sha256$600000$cMpqUgoxlQSJPCkU2NG60x$PaoLlWtEq3OBq43UujVVs7j4MJb44/+cWRQbuqI8jIk=','2023-05-10 23:09:28.340789',1,'admin','','','admin@admin.com',1,1,'2023-05-10 23:09:13.642055'),(2,'pbkdf2_sha256$600000$TWJ3JD4tUMb0aV9Vz9iRaV$Y8PZUys9+szuDsjxvqOdVo1ToghkkKhGXkz2lBnuwGs=',NULL,0,'user1','abdo','alkhaldi','abdo@user1.com',0,1,'2023-05-10 23:10:48.000000'),(3,'pbkdf2_sha256$600000$h6xw3mXlyNPLWTySirEDgN$QwAruEC3KZvzXU7Q+IDAfu7CotpYeVEoqSGj+ISkTms=',NULL,0,'user2','taloobi','alrefai','taloobi@user2.com',0,1,'2023-05-10 23:11:34.384618');
/*!40000 ALTER TABLE `account_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_user_groups`
--

DROP TABLE IF EXISTS `account_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_user_groups_user_id_group_id_4d09af3e_uniq` (`user_id`,`group_id`),
  KEY `account_user_groups_group_id_6c71f749_fk_auth_group_id` (`group_id`),
  CONSTRAINT `account_user_groups_group_id_6c71f749_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `account_user_groups_user_id_14345e7b_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_user_groups`
--

LOCK TABLES `account_user_groups` WRITE;
/*!40000 ALTER TABLE `account_user_groups` DISABLE KEYS */;
INSERT INTO `account_user_groups` VALUES (1,2,1);
/*!40000 ALTER TABLE `account_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_user_user_permissions`
--

DROP TABLE IF EXISTS `account_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_user_user_permis_user_id_permission_id_48bdd28b_uniq` (`user_id`,`permission_id`),
  KEY `account_user_user_pe_permission_id_66c44191_fk_auth_perm` (`permission_id`),
  CONSTRAINT `account_user_user_pe_permission_id_66c44191_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `account_user_user_pe_user_id_cc42d270_fk_account_u` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_user_user_permissions`
--

LOCK TABLES `account_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `account_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'moderator');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add message',6,'add_message'),(22,'Can change message',6,'change_message'),(23,'Can delete message',6,'delete_message'),(24,'Can view message',6,'view_message'),(25,'Can unsend message',6,'unsend_message'),(26,'Can add user',7,'add_user'),(27,'Can change user',7,'change_user'),(28,'Can delete user',7,'delete_user'),(29,'Can view user',7,'view_user'),(30,'Can add user settings',8,'add_usersettings'),(31,'Can change user settings',8,'change_usersettings'),(32,'Can delete user settings',8,'delete_usersettings'),(33,'Can view user settings',8,'view_usersettings'),(34,'Can add reported content',9,'add_reportedcontent'),(35,'Can change reported content',9,'change_reportedcontent'),(36,'Can delete reported content',9,'delete_reportedcontent'),(37,'Can view reported content',9,'view_reportedcontent'),(38,'Can add attachment',10,'add_attachment'),(39,'Can change attachment',10,'change_attachment'),(40,'Can delete attachment',10,'delete_attachment'),(41,'Can view attachment',10,'view_attachment'),(42,'Can add user',11,'add_user'),(43,'Can change user',11,'change_user'),(44,'Can delete user',11,'delete_user'),(45,'Can view user',11,'view_user');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_attachment`
--

DROP TABLE IF EXISTS `backend_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_attachment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `message_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `backend_attachment_message_id_975cb26d_fk_backend_message_id` (`message_id`),
  CONSTRAINT `backend_attachment_message_id_975cb26d_fk_backend_message_id` FOREIGN KEY (`message_id`) REFERENCES `backend_message` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_attachment`
--

LOCK TABLES `backend_attachment` WRITE;
/*!40000 ALTER TABLE `backend_attachment` DISABLE KEYS */;
INSERT INTO `backend_attachment` VALUES (1,'attachments/example2_tUUzQxL.jpg',1),(2,'attachments/example_Tzv7k1W.jpg',2);
/*!40000 ALTER TABLE `backend_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_message`
--

DROP TABLE IF EXISTS `backend_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backend_message_user_id_c98999d9_fk_backend_user_id` (`user_id`),
  CONSTRAINT `backend_message_user_id_c98999d9_fk_backend_user_id` FOREIGN KEY (`user_id`) REFERENCES `backend_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_message`
--

LOCK TABLES `backend_message` WRITE;
/*!40000 ALTER TABLE `backend_message` DISABLE KEYS */;
INSERT INTO `backend_message` VALUES (1,'Hello taloobi','2023-05-10 23:13:27.671213',2),(2,'omg is that mohammed???!!','2023-05-10 23:14:35.677020',3),(3,'hahahaha','2023-05-10 23:15:30.904632',2),(4,'we gotta study dsp :)))))','2023-05-10 23:16:10.462347',3);
/*!40000 ALTER TABLE `backend_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_reportedcontent`
--

DROP TABLE IF EXISTS `backend_reportedcontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_reportedcontent` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) NOT NULL,
  `status` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `message_id` bigint NOT NULL,
  `reported_by_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `backend_reportedcontent_reported_by_id_message_id_f6623333_uniq` (`reported_by_id`,`message_id`),
  KEY `backend_reportedcont_message_id_cc72646c_fk_backend_m` (`message_id`),
  CONSTRAINT `backend_reportedcont_message_id_cc72646c_fk_backend_m` FOREIGN KEY (`message_id`) REFERENCES `backend_message` (`id`),
  CONSTRAINT `backend_reportedcont_reported_by_id_0f1dd2dd_fk_backend_u` FOREIGN KEY (`reported_by_id`) REFERENCES `backend_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_reportedcontent`
--

LOCK TABLES `backend_reportedcontent` WRITE;
/*!40000 ALTER TABLE `backend_reportedcontent` DISABLE KEYS */;
INSERT INTO `backend_reportedcontent` VALUES (1,'sending picture of mohammed without consent','pending','2023-05-10 23:15:14.979857',2,2),(2,'triggering my PTSD','pending','2023-05-10 23:16:45.703907',4,2);
/*!40000 ALTER TABLE `backend_reportedcontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_user`
--

DROP TABLE IF EXISTS `backend_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `backend_user_user_id_7d5c22b8_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_user`
--

LOCK TABLES `backend_user` WRITE;
/*!40000 ALTER TABLE `backend_user` DISABLE KEYS */;
INSERT INTO `backend_user` VALUES (1,'2023-05-10 23:09:13.958364',1),(2,'2023-05-10 23:10:49.249326',2),(3,'2023-05-10 23:11:34.700864',3);
/*!40000 ALTER TABLE `backend_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_usersettings`
--

DROP TABLE IF EXISTS `backend_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_usersettings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `theme` varchar(5) NOT NULL,
  `notifications` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `backend_usersettings_user_id_b2cb9315_fk_backend_user_id` FOREIGN KEY (`user_id`) REFERENCES `backend_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_usersettings`
--

LOCK TABLES `backend_usersettings` WRITE;
/*!40000 ALTER TABLE `backend_usersettings` DISABLE KEYS */;
INSERT INTO `backend_usersettings` VALUES (1,'dark',1,1),(2,'dark',1,2),(3,'dark',1,3);
/*!40000 ALTER TABLE `backend_usersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_account_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_account_user_id` FOREIGN KEY (`user_id`) REFERENCES `account_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-05-10 23:10:49.251320','2','abdo alkhaldi',1,'[{\"added\": {}}]',11,1),(2,'2023-05-10 23:11:34.702545','3','taloobi alrefai',1,'[{\"added\": {}}]',11,1),(3,'2023-05-10 23:11:51.689451','1','moderator',1,'[{\"added\": {}}]',3,1),(4,'2023-05-10 23:12:01.372772','2','abdo alkhaldi',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',11,1),(5,'2023-05-10 23:13:27.677198','1','sent by abdo alkhaldi at 2023-05-10 23:13:27',1,'[{\"added\": {}}, {\"added\": {\"name\": \"attachment\", \"object\": \"abdo alkhaldi sent an attachment at 2023-05-10 23:13:27\"}}]',6,1),(6,'2023-05-10 23:14:35.686994','2','sent by taloobi alrefai at 2023-05-10 23:14:35',1,'[{\"added\": {}}, {\"added\": {\"name\": \"attachment\", \"object\": \"taloobi alrefai sent an attachment at 2023-05-10 23:14:35\"}}]',6,1),(7,'2023-05-10 23:15:14.981241','1','abdo alkhaldi reported a message for sending picture of mohammed without consent',1,'[{\"added\": {}}]',9,1),(8,'2023-05-10 23:15:30.905605','3','sent by abdo alkhaldi at 2023-05-10 23:15:30',1,'[{\"added\": {}}]',6,1),(9,'2023-05-10 23:16:10.465340','4','sent by taloobi alrefai at 2023-05-10 23:16:10',1,'[{\"added\": {}}]',6,1),(10,'2023-05-10 23:16:45.705902','2','abdo alkhaldi reported a message for triggering my PTSD',1,'[{\"added\": {}}]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (11,'account','user'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(10,'backend','attachment'),(6,'backend','message'),(9,'backend','reportedcontent'),(7,'backend','user'),(8,'backend','usersettings'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-05-10 23:06:18.244799'),(2,'contenttypes','0002_remove_content_type_name','2023-05-10 23:06:18.279145'),(3,'auth','0001_initial','2023-05-10 23:06:18.413091'),(4,'auth','0002_alter_permission_name_max_length','2023-05-10 23:06:18.443057'),(5,'auth','0003_alter_user_email_max_length','2023-05-10 23:06:18.449043'),(6,'auth','0004_alter_user_username_opts','2023-05-10 23:06:18.455025'),(7,'auth','0005_alter_user_last_login_null','2023-05-10 23:06:18.459472'),(8,'auth','0006_require_contenttypes_0002','2023-05-10 23:06:18.463461'),(9,'auth','0007_alter_validators_add_error_messages','2023-05-10 23:06:18.468607'),(10,'auth','0008_alter_user_username_max_length','2023-05-10 23:06:18.474591'),(11,'auth','0009_alter_user_last_name_max_length','2023-05-10 23:06:18.480575'),(12,'auth','0010_alter_group_name_max_length','2023-05-10 23:06:18.492593'),(13,'auth','0011_update_proxy_permissions','2023-05-10 23:06:18.499576'),(14,'auth','0012_alter_user_first_name_max_length','2023-05-10 23:06:18.504561'),(15,'account','0001_initial','2023-05-10 23:06:18.644503'),(16,'account','0002_alter_user_email_alter_user_first_name_and_more','2023-05-10 23:06:18.725042'),(17,'admin','0001_initial','2023-05-10 23:06:18.790206'),(18,'admin','0002_logentry_remove_auto_add','2023-05-10 23:06:18.797205'),(19,'admin','0003_logentry_add_action_flag_choices','2023-05-10 23:06:18.804185'),(20,'backend','0001_initial','2023-05-10 23:06:19.003829'),(21,'backend','0002_alter_usersettings_options_and_more','2023-05-10 23:06:19.101061'),(22,'backend','0003_user_user','2023-05-10 23:06:19.149927'),(23,'backend','0004_alter_message_options','2023-05-10 23:06:19.156910'),(24,'backend','0005_remove_user_email_remove_user_first_name_and_more','2023-05-10 23:06:19.219572'),(25,'backend','0006_alter_user_user','2023-05-10 23:06:19.230563'),(26,'backend','0007_alter_user_user','2023-05-10 23:06:19.240177'),(27,'sessions','0001_initial','2023-05-10 23:06:19.262550');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('e8de9zksgng3o0i2uw18xerz6j69b6wq','.eJxVzMEOwiAQBNB_4WzIFhZaPHrvN5AtLFI1kJT2ZPx326QHvc68mbfwtK3Zb40XP0dxFZ24_GYThSeXo4gPKvcqQy3rMk_yIPJsmxxr5NfttH8HmVre185q65xmADKYKCCgsqqfOPW9NugUDIaDMwS4o50mDY6NBhxSZ-MgPl-vJjZq:1pwsw4:JQ0CnVIReO8xqvu_fgoD_e2KKS_rdsiA8MLeroTs39M','2023-05-24 23:09:28.343781');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-11  2:23:41
