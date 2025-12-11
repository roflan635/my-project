-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sud
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id_c` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  `parent_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Technology','None'),(2,'Programming','1'),(3,'Lifestyle','None'),(4,'Science','None'),(5,'Web Development','2');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_has_content`
--

DROP TABLE IF EXISTS `categories_has_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories_has_content` (
  `categories_id_c` int NOT NULL,
  `content_id_cont` int NOT NULL,
  PRIMARY KEY (`categories_id_c`,`content_id_cont`),
  KEY `fk_categories_has_content_content1_idx` (`content_id_cont`),
  KEY `fk_categories_has_content_categories1_idx` (`categories_id_c`),
  CONSTRAINT `fk_categories_has_content_categories1` FOREIGN KEY (`categories_id_c`) REFERENCES `categories` (`id_c`),
  CONSTRAINT `fk_categories_has_content_content1` FOREIGN KEY (`content_id_cont`) REFERENCES `content` (`id_cont`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_has_content`
--

LOCK TABLES `categories_has_content` WRITE;
/*!40000 ALTER TABLE `categories_has_content` DISABLE KEYS */;
INSERT INTO `categories_has_content` VALUES (2,1),(3,2),(2,3),(5,3),(4,4);
/*!40000 ALTER TABLE `categories_has_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `id_cont` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `slug` varchar(45) NOT NULL,
  `excerpt` varchar(45) NOT NULL,
  `content_body` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL COMMENT 'Черновик, Опубликован, В архиве',
  `published_at` time NOT NULL,
  `user_id_us` int NOT NULL,
  PRIMARY KEY (`id_cont`),
  KEY `fk_content_user1_idx` (`user_id_us`),
  CONSTRAINT `fk_content_user1` FOREIGN KEY (`user_id_us`) REFERENCES `user` (`id_us`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='																																																																																		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,'Introduction to Python','introduction-to-python','Learn Python basics from scratch','Python is a versatile programming language ','published','10:30:00',1),(2,'Healthy Morning Routine','healthy-morning-routine','Start your day right with these tips','Круто','draft','09:15:00',2),(3,'Web Development Trends 2024','web-dev-trends-2024','Latest trends in web development','React and Vue are dominating for backend...','published','14:45:00',1),(4,'Quantum Computing Basics','quantum-computing-basics','Understanding quantum mechanics in computing','Quantum cto perform complex calculations...','published','11:20:00',3),(5,'Best Laptops for Developers 2024','best-laptops-developers-2024','Top laptop choices for programming','We price of the latest developer laptops...','pending','16:10:00',2);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_types`
--

DROP TABLE IF EXISTS `content_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_types` (
  `id_ct` int NOT NULL AUTO_INCREMENT,
  `cotent_name` varchar(45) NOT NULL,
  `content_id_cont` int NOT NULL,
  PRIMARY KEY (`id_ct`),
  KEY `fk_content_types_content1_idx` (`content_id_cont`),
  CONSTRAINT `fk_content_types_content1` FOREIGN KEY (`content_id_cont`) REFERENCES `content` (`id_cont`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_types`
--

LOCK TABLES `content_types` WRITE;
/*!40000 ALTER TABLE `content_types` DISABLE KEYS */;
INSERT INTO `content_types` VALUES (1,'Article',1),(2,'Blog Post',2),(3,'News',3),(4,'Tutorial',4),(5,'Review',5);
/*!40000 ALTER TABLE `content_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id_r` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_r`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Администратор'),(2,'Модератор'),(3,'Редактор'),(4,'Пользователь'),(5,'Гость');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permission` (
  `id_p` int NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(20) NOT NULL,
  `role_id_r` int NOT NULL,
  PRIMARY KEY (`id_p`),
  KEY `fk_role_permission_role1_idx` (`role_id_r`),
  CONSTRAINT `fk_role_permission_role1` FOREIGN KEY (`role_id_r`) REFERENCES `role` (`id_r`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,'Модерация контента',2),(2,'Создание контента',3),(3,'Комментирование',4),(4,'Просмотр контента',5),(5,'Ограниченный доступ',5);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id_s` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id_s`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Активный'),(2,'Неактивный'),(3,'Заблокирован'),(4,'Удален');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id_t` int NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_t`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'python'),(2,'programming'),(3,'health'),(4,'web'),(5,'tutorial'),(6,'science'),(7,'technology'),(8,'lifestyle');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_has_content`
--

DROP TABLE IF EXISTS `tags_has_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags_has_content` (
  `tags_id_t` int NOT NULL,
  `content_id_cont` int NOT NULL,
  PRIMARY KEY (`tags_id_t`,`content_id_cont`),
  KEY `fk_tags_has_content_content1_idx` (`content_id_cont`),
  KEY `fk_tags_has_content_tags1_idx` (`tags_id_t`),
  CONSTRAINT `fk_tags_has_content_content1` FOREIGN KEY (`content_id_cont`) REFERENCES `content` (`id_cont`),
  CONSTRAINT `fk_tags_has_content_tags1` FOREIGN KEY (`tags_id_t`) REFERENCES `tags` (`id_t`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_has_content`
--

LOCK TABLES `tags_has_content` WRITE;
/*!40000 ALTER TABLE `tags_has_content` DISABLE KEYS */;
INSERT INTO `tags_has_content` VALUES (1,1),(2,1),(5,1),(3,2),(8,2),(2,3),(4,3),(7,3),(6,4),(7,5);
/*!40000 ALTER TABLE `tags_has_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_us` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(20) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `phone_number` varchar(11) NOT NULL,
  `birthday` date DEFAULT NULL,
  `status_id_s` int NOT NULL,
  PRIMARY KEY (`id_us`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `fk_user_status1_idx` (`status_id_s`),
  CONSTRAINT `fk_user_status1` FOREIGN KEY (`status_id_s`) REFERENCES `status` (`id_s`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin_sys','admin@system.com','AdminPass123','2020-01-15 09:00:00','79161111111','1985-05-20',2),(2,'moderator99','moderator@system.com','ModPass456','2020-02-20 10:15:00','79162222222','1990-08-15',2),(3,'content_editor','editor@system.com','EditPass789','2020-03-10 11:30:00','79163333333','1992-03-10',1),(4,'ivan_petrov','newgmail@mail.ru','User1Pass','2020-04-05 12:45:00','79164444444','1995-07-25',1),(5,'alex_kuznetsov','user3@mail.ru','User3Pass','2020-06-18 14:10:00','79166666666','2000-01-15',1),(6,'anna_smirnova','user4@mail.ru','User4Pass','2020-07-22 15:30:00','79167777777','1988-09-05',3),(7,'dmitry_ivanov','user5@mail.ru','User5Pass','2020-08-30 16:45:00','79168888888','1993-04-18',1),(8,'guest_alexey','guest1@mail.ru','Guest1Pass','2020-09-10 17:20:00','79169999999','2002-06-22',4),(10,'sidorova_mary','sidorovam@yandex.com','User2Pass',NULL,'79165555555','1998-11-30',2),(11,'bebebe','aasfdafn@system.com','AasdnPaqw3','2020-01-15 09:00:00','79161321111','1989-05-20',2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_role`
--

DROP TABLE IF EXISTS `user_has_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_has_role` (
  `user_id_us` int NOT NULL,
  `role_id_r` int NOT NULL,
  PRIMARY KEY (`user_id_us`,`role_id_r`),
  KEY `fk_user_has_role_role1_idx` (`role_id_r`),
  KEY `fk_user_has_role_user1_idx` (`user_id_us`),
  CONSTRAINT `fk_user_has_role_role1` FOREIGN KEY (`role_id_r`) REFERENCES `role` (`id_r`),
  CONSTRAINT `fk_user_has_role_user1` FOREIGN KEY (`user_id_us`) REFERENCES `user` (`id_us`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_role`
--

LOCK TABLES `user_has_role` WRITE;
/*!40000 ALTER TABLE `user_has_role` DISABLE KEYS */;
INSERT INTO `user_has_role` VALUES (1,1),(2,2),(3,3),(1,4),(4,4),(5,4),(6,4),(7,4),(8,4);
/*!40000 ALTER TABLE `user_has_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_user_permissions`
--

DROP TABLE IF EXISTS `v_user_permissions`;
/*!50001 DROP VIEW IF EXISTS `v_user_permissions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_permissions` AS SELECT 
 1 AS `Активный пользователь`,
 1 AS `Профиль прав`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_user_permissions`
--

/*!50001 DROP VIEW IF EXISTS `v_user_permissions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_permissions` AS select `u`.`username` AS `Активный пользователь`,group_concat(`rp`.`permission_name` separator ' | ') AS `Профиль прав` from ((((`user` `u` join `user_has_role` `uhr` on((`u`.`id_us` = `uhr`.`user_id_us`))) join `role` `r` on((`r`.`id_r` = `uhr`.`role_id_r`))) join `status` `s` on((`s`.`id_s` = `u`.`status_id_s`))) join `role_permission` `rp` on((`r`.`id_r` = `rp`.`role_id_r`))) where (`s`.`status_name` = 'Активный') group by `u`.`username` */;
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

-- Dump completed on 2025-12-11 14:53:18
