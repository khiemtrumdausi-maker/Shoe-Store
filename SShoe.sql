CREATE DATABASE  IF NOT EXISTS `shoe_store_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shoe_store_db`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: shoe_store_db
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `BrandID` int NOT NULL AUTO_INCREMENT,
  `BrandName` varchar(50) NOT NULL,
  PRIMARY KEY (`BrandID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Nike'),(2,'Adidas'),(3,'Puma'),(4,'Biti\'s'),(5,'Salomon'),(6,'The North Face'),(7,'Charles & Keith'),(8,'Vascara'),(9,'Dr. Martens'),(10,'LaForce');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `CartID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `VariantID` int DEFAULT NULL,
  `Quantity` int DEFAULT '1',
  PRIMARY KEY (`CartID`),
  KEY `UserID` (`UserID`),
  KEY `VariantID` (`VariantID`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`VariantID`) REFERENCES `shoevariants` (`VariantID`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (32,2,8,1),(33,2,4,1),(37,3,9,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(50) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Giày Sneaker'),(2,'Giày Chạy bộ'),(3,'Giày Bóng rổ'),(4,'Giày Tập luyện'),(5,'Giày Đá bóng'),(6,'Sandal & Dép'),(7,'Giày Boot (Bốt)'),(8,'Giày đế xuồng'),(9,'Giày Sục (Mule)');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genders`
--

DROP TABLE IF EXISTS `genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genders` (
  `GenderID` int NOT NULL AUTO_INCREMENT,
  `GenderName` varchar(20) NOT NULL,
  PRIMARY KEY (`GenderID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genders`
--

LOCK TABLES `genders` WRITE;
/*!40000 ALTER TABLE `genders` DISABLE KEYS */;
INSERT INTO `genders` VALUES (1,'Nam'),(2,'Nữ'),(3,'Unisex');
/*!40000 ALTER TABLE `genders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `NotiID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `Message` text NOT NULL,
  `IsRead` bit(1) DEFAULT b'0',
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`NotiID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,2,'Đơn hàng #LUMA13 đã chuyển sang: Đang giao',_binary '\0','2026-04-05 17:47:16'),(2,2,'Đơn hàng #LUMA12 đã chuyển sang: Đang giao',_binary '\0','2026-04-05 17:47:19'),(3,2,'Đơn hàng #LUMA15 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 03:09:27'),(4,2,'Đơn hàng #LUMA14 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 08:22:20'),(5,2,'Đơn hàng #LUMA20 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 09:55:56'),(6,2,'Đơn hàng #LUMA18 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 10:19:59'),(7,2,'Đơn hàng #LUMA17 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 11:05:43'),(8,2,'Đơn hàng #LUMA16 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 11:06:28'),(9,2,'Đơn hàng #LUMA10 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 11:23:11'),(10,1,'KHÁCH HÀNG: Có đơn hàng mới #LUMA23 đang chờ xác nhận!',_binary '\0','2026-04-14 11:31:22'),(11,1,'KHÁCH HÀNG: Có đơn hàng mới #LUMA24 đang chờ xác nhận!',_binary '\0','2026-04-14 11:33:05'),(12,3,'Đơn hàng #LUMA24 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 11:33:37'),(13,1,'KHÁCH HÀNG: Có đơn hàng mới #LUMA25 đang chờ duyệt!',_binary '\0','2026-04-14 11:44:37'),(14,3,'Đơn hàng #LUMA25 đã chuyển sang: Đang giao',_binary '\0','2026-04-14 11:45:07'),(15,1,'HỆ THỐNG: Đơn hàng #LUMA25 đã được cập nhật trạng thái: Đang giao',_binary '\0','2026-04-14 11:45:07'),(16,1,'HỆ THỐNG: Đơn hàng #LUMA25 khách đã xác nhận nhận hàng thành công!',_binary '\0','2026-04-14 11:45:18'),(17,1,'KHÁCH HÀNG: Có đơn hàng mới #LUMA26 đang chờ duyệt!',_binary '\0','2026-04-14 11:45:54'),(18,1,'KHÁCH HÀNG: Có đơn hàng mới #LUMA27 đang chờ duyệt!',_binary '\0','2026-04-14 11:48:14'),(19,1,'HỆ THỐNG: Đơn hàng #LUMA27 đã bị hủy!',_binary '\0','2026-04-14 11:48:43'),(20,1,'KHÁCH HÀNG: Có đơn hàng mới #LUMA28 đang chờ duyệt!',_binary '\0','2026-04-14 11:49:30');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `OrderDetailID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `VariantID` int DEFAULT NULL,
  `Quantity` int NOT NULL,
  `UnitPrice` decimal(15,2) NOT NULL,
  PRIMARY KEY (`OrderDetailID`),
  KEY `OrderID` (`OrderID`),
  KEY `VariantID` (`VariantID`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`VariantID`) REFERENCES `shoevariants` (`VariantID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,3,8,2,950000.00),(2,3,1,1,3200000.00),(3,4,7,2,950000.00),(4,5,5,1,3850000.00),(5,6,1,2,3200000.00),(6,7,1,2,3200000.00),(7,9,1,2,3200000.00),(8,10,7,1,950000.00),(9,11,1,4,3200000.00),(10,12,2,2,3200000.00),(11,13,2,2,3200000.00),(12,14,2,2,3200000.00),(13,15,9,1,3200000.00),(14,16,8,2,950000.00),(15,17,9,1,3200000.00),(16,17,4,1,3850000.00),(17,18,4,1,3850000.00),(18,19,6,1,3850000.00),(19,20,7,1,950000.00),(20,21,2,1,3200000.00),(21,21,4,1,3850000.00),(22,22,3,1,3200000.00),(23,23,5,1,3850000.00),(24,24,9,1,3200000.00),(25,25,2,1,3200000.00),(26,26,7,1,950000.00),(27,27,9,1,3200000.00),(28,28,9,1,3200000.00);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `OrderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `TotalAmount` decimal(15,2) DEFAULT NULL,
  `ShippingPhone` varchar(15) NOT NULL,
  `ShippingAddress` varchar(255) NOT NULL,
  `Status` enum('Chờ xác nhận','Đã thanh toán','Đang giao','Hoàn thành','Đã hủy') DEFAULT 'Chờ xác nhận',
  PRIMARY KEY (`OrderID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2026-04-04 18:25:21',2000000.00,'0912345678','Hà Nội','Đã hủy'),(2,1,'2026-04-04 18:25:21',1500000.00,'0988888888','PTIT','Đang giao'),(3,2,'2026-04-05 14:36:50',5100000.00,'0325458936','Ao Sen','Hoàn thành'),(4,2,'2026-04-05 14:37:28',1900000.00,'0325458936','Ao Sen','Chờ xác nhận'),(5,2,'2026-04-05 14:37:39',3850000.00,'0325458936','Ao Sen','Chờ xác nhận'),(6,2,'2026-04-05 15:57:43',6400000.00,'0325458936','Ao Sen','Chờ xác nhận'),(7,2,'2026-04-05 16:21:43',6400000.00,'0325458936','Ao Sen','Chờ xác nhận'),(8,2,'2026-04-05 16:21:56',0.00,'0325458936','Ao Sen','Hoàn thành'),(9,2,'2026-04-05 16:26:12',6400000.00,'0325458936','Ao Sen','Chờ xác nhận'),(10,2,'2026-04-05 16:27:09',950000.00,'0325458936','Ao Sen','Đang giao'),(11,2,'2026-04-05 16:36:11',12800000.00,'0325458936','Ao Sen','Chờ xác nhận'),(12,2,'2026-04-05 17:27:04',6400000.00,'0325458936','Ao Sen','Hoàn thành'),(13,2,'2026-04-05 17:38:21',6400000.00,'0325458936','Ao Sen','Hoàn thành'),(14,2,'2026-04-06 17:05:56',6400000.00,'0325458936','Ao Sen','Đang giao'),(15,2,'2026-04-14 01:38:26',3200000.00,'0325458936','Ao Sen','Hoàn thành'),(16,2,'2026-04-14 08:25:39',1900000.00,'0325458936','Ao Sen','Đang giao'),(17,2,'2026-04-14 08:49:16',7050000.00,'0325458936','Ao Sen','Đang giao'),(18,2,'2026-04-14 08:51:22',3850000.00,'0325458936','Ao Sen','Đang giao'),(19,2,'2026-04-14 08:56:03',3850000.00,'0325458936','Ao Sen','Đã hủy'),(20,2,'2026-04-14 08:59:49',950000.00,'0325458936','Ao Sen','Hoàn thành'),(21,2,'2026-04-14 11:23:25',7050000.00,'0325458936','Ao Sen','Chờ xác nhận'),(22,2,'2026-04-14 11:24:07',3200000.00,'0325458936','Ao Sen','Chờ xác nhận'),(23,2,'2026-04-14 11:31:22',3850000.00,'0325458936','Ao Sen','Chờ xác nhận'),(24,3,'2026-04-14 11:33:05',3200000.00,'0123456789','Ao Sen','Hoàn thành'),(25,3,'2026-04-14 11:44:37',3200000.00,'0123456789','Ao Sen','Hoàn thành'),(26,3,'2026-04-14 11:45:54',950000.00,'0123456789','Ao Sen','Đã hủy'),(27,3,'2026-04-14 11:48:14',3200000.00,'0123456789','Ao Sen','Đã hủy'),(28,3,'2026-04-14 11:49:30',3200000.00,'0123456789','Ao Sen','Chờ xác nhận');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `PaymentMethod` enum('Tiền mặt','Chuyển khoản') NOT NULL,
  `Amount` decimal(15,2) NOT NULL,
  `PaymentDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `PaymentStatus` enum('Chưa thanh toán','Đã thanh toán') DEFAULT 'Chưa thanh toán',
  PRIMARY KEY (`PaymentID`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,3,'Tiền mặt',5100000.00,'2026-04-05 14:36:50','Đã thanh toán'),(2,4,'Chuyển khoản',1900000.00,'2026-04-05 14:37:28','Chưa thanh toán'),(3,5,'Tiền mặt',3850000.00,'2026-04-05 14:37:39','Chưa thanh toán'),(4,6,'Tiền mặt',6400000.00,'2026-04-05 15:57:43','Chưa thanh toán'),(5,7,'Tiền mặt',6400000.00,'2026-04-05 16:21:43','Chưa thanh toán'),(6,8,'Chuyển khoản',0.00,'2026-04-14 01:32:27','Đã thanh toán'),(7,9,'Tiền mặt',6400000.00,'2026-04-05 16:26:12','Chưa thanh toán'),(8,10,'Chuyển khoản',950000.00,'2026-04-05 16:27:09','Chưa thanh toán'),(9,11,'Tiền mặt',12800000.00,'2026-04-05 16:36:11','Chưa thanh toán'),(10,12,'Tiền mặt',6400000.00,'2026-04-14 01:03:19','Đã thanh toán'),(11,13,'Tiền mặt',6400000.00,'2026-04-14 00:59:51','Đã thanh toán'),(12,14,'Tiền mặt',6400000.00,'2026-04-06 17:05:56','Chưa thanh toán'),(13,15,'Tiền mặt',3200000.00,'2026-04-14 01:38:26','Đã thanh toán'),(14,16,'Tiền mặt',1900000.00,'2026-04-14 08:25:39','Chưa thanh toán'),(15,17,'Tiền mặt',7050000.00,'2026-04-14 08:49:16','Chưa thanh toán'),(16,18,'Tiền mặt',3850000.00,'2026-04-14 08:51:22','Chưa thanh toán'),(17,19,'Tiền mặt',3850000.00,'2026-04-14 08:56:03','Chưa thanh toán'),(18,20,'Tiền mặt',950000.00,'2026-04-14 08:59:49','Đã thanh toán'),(19,21,'Tiền mặt',7050000.00,'2026-04-14 11:23:25','Chưa thanh toán'),(20,22,'Tiền mặt',3200000.00,'2026-04-14 11:24:07','Chưa thanh toán'),(21,23,'Tiền mặt',3850000.00,'2026-04-14 11:31:22','Chưa thanh toán'),(22,24,'Tiền mặt',3200000.00,'2026-04-14 11:33:05','Đã thanh toán'),(23,25,'Tiền mặt',3200000.00,'2026-04-14 11:44:37','Đã thanh toán'),(24,26,'Tiền mặt',950000.00,'2026-04-14 11:45:54','Chưa thanh toán'),(25,27,'Tiền mặt',3200000.00,'2026-04-14 11:48:14','Chưa thanh toán'),(26,28,'Tiền mặt',3200000.00,'2026-04-14 11:49:30','Chưa thanh toán');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoes`
--

DROP TABLE IF EXISTS `shoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoes` (
  `ShoeID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `Price` decimal(15,2) NOT NULL,
  `DiscountPrice` decimal(15,2) DEFAULT '0.00',
  `Description` text,
  `GenderID` int DEFAULT NULL,
  `BrandID` int DEFAULT NULL,
  `CategoryID` int DEFAULT NULL,
  PRIMARY KEY (`ShoeID`),
  KEY `GenderID` (`GenderID`),
  KEY `BrandID` (`BrandID`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `shoes_ibfk_1` FOREIGN KEY (`GenderID`) REFERENCES `genders` (`GenderID`),
  CONSTRAINT `shoes_ibfk_2` FOREIGN KEY (`BrandID`) REFERENCES `brands` (`BrandID`),
  CONSTRAINT `shoes_ibfk_3` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoes`
--

LOCK TABLES `shoes` WRITE;
/*!40000 ALTER TABLE `shoes` DISABLE KEYS */;
INSERT INTO `shoes` VALUES (1,'Nike Air Jordan 1 Low','images/nike_jordan_grey.jpg',3500000.00,3200000.00,'Mô tả mới cập nhật',1,1,1),(2,'Adidas Ultraboost 22','images/s2.jpg',4500000.00,3850000.00,'Mô tả mới cập nhật',1,2,2),(3,'Bitis Hunter Street','images/s3.jpg',950000.00,950000.00,'Mô tả mới cập nhật',1,1,1);
/*!40000 ALTER TABLE `shoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shoevariants`
--

DROP TABLE IF EXISTS `shoevariants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoevariants` (
  `VariantID` int NOT NULL AUTO_INCREMENT,
  `ShoeID` int DEFAULT NULL,
  `Size` int NOT NULL,
  `StockQuantity` int DEFAULT '0',
  PRIMARY KEY (`VariantID`),
  KEY `ShoeID` (`ShoeID`),
  CONSTRAINT `shoevariants_ibfk_1` FOREIGN KEY (`ShoeID`) REFERENCES `shoes` (`ShoeID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoevariants`
--

LOCK TABLES `shoevariants` WRITE;
/*!40000 ALTER TABLE `shoevariants` DISABLE KEYS */;
INSERT INTO `shoevariants` VALUES (1,1,40,49),(2,1,41,10),(3,1,42,9),(4,2,40,17),(5,2,41,18),(6,2,42,19),(7,3,39,10),(8,3,40,10),(9,1,40,95);
/*!40000 ALTER TABLE `shoevariants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Role` enum('Admin','Customer') DEFAULT 'Customer',
  `Status` int DEFAULT '1',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Nguyen Van Khiem','khiem@admin.com','123456','0987654321','PTIT Ha Noi','Admin',1),(2,'Nguyễn Văn Khiêm','khiem@customer','123456','0325458936','Ao Sen','Customer',1),(3,'Hoàng Kiên','customer@gmail.com','123456','0123456789','Ao Sen','Customer',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-14 12:29:29
