-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: cinepucp
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `movieprojections`
--

DROP TABLE IF EXISTS `movieprojections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movieprojections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movieId` int DEFAULT NULL,
  `roomId` int DEFAULT NULL,
  `projectionDate` datetime NOT NULL,
  `availableSeats` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movieId` (`movieId`),
  KEY `roomId` (`roomId`),
  CONSTRAINT `movieprojections_ibfk_1` FOREIGN KEY (`movieId`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `movieprojections_ibfk_2` FOREIGN KEY (`roomId`) REFERENCES `rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movieprojections`
--

LOCK TABLES `movieprojections` WRITE;
/*!40000 ALTER TABLE `movieprojections` DISABLE KEYS */;
/*!40000 ALTER TABLE `movieprojections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text,
  `duration` int NOT NULL,
  `releaseDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `movieProjectionId` int DEFAULT NULL,
  `roomSeatId` int DEFAULT NULL,
  `startDatetime` datetime NOT NULL,
  `endDatetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `movieProjectionId` (`movieProjectionId`),
  KEY `roomSeatId` (`roomSeatId`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`movieProjectionId`) REFERENCES `movieprojections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reservations_ibfk_3` FOREIGN KEY (`roomSeatId`) REFERENCES `roomseats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (4,'ADMIN'),(6,'CLIENTE'),(5,'GERENTE');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomseats`
--

DROP TABLE IF EXISTS `roomseats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomseats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roomId` int DEFAULT NULL,
  `seatNumber` varchar(10) NOT NULL,
  `rowNumber` char(2) NOT NULL,
  `isAvailable` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `roomId` (`roomId`),
  CONSTRAINT `roomseats_ibfk_1` FOREIGN KEY (`roomId`) REFERENCES `rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomseats`
--

LOCK TABLES `roomseats` WRITE;
/*!40000 ALTER TABLE `roomseats` DISABLE KEYS */;
/*!40000 ALTER TABLE `roomseats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session`
--

DROP TABLE IF EXISTS `spring_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint NOT NULL,
  `LAST_ACCESS_TIME` bigint NOT NULL,
  `MAX_INACTIVE_INTERVAL` int NOT NULL,
  `EXPIRY_TIME` bigint NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session`
--

LOCK TABLES `spring_session` WRITE;
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
INSERT INTO `spring_session` VALUES ('86758817-79ae-4c6b-ad61-7eacdc0bcd3d','6fb69583-74f2-4470-8814-c05884fd88e0',1728524590647,1728524596037,1800,1728526396037,NULL);
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session_attributes`
--

DROP TABLE IF EXISTS `spring_session_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session_attributes`
--

LOCK TABLES `spring_session_attributes` WRITE;
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
INSERT INTO `spring_session_attributes` VALUES ('86758817-79ae-4c6b-ad61-7eacdc0bcd3d','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '¬\í\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\ï·\È/¢û\Õ\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$08a7fe2a-82d2-48db-a765-818705358117'),('86758817-79ae-4c6b-ad61-7eacdc0bcd3d','SPRING_SECURITY_LAST_EXCEPTION',_binary '¬\í\0sr\0Corg.springframework.security.authentication.BadCredentialsException&Nüd®]\0\0xr\09org.springframework.security.core.AuthenticationExceptionQ0\âgT\0\0xr\0\Zjava.lang.RuntimeExceptionž_G\n4ƒ\å\0\0xr\0java.lang.Exception\Ðý>\Z;\Ä\0\0xr\0java.lang.Throwable\Õ\Æ5\'9w¸\Ë\0L\0causet\0Ljava/lang/Throwable;L\0\rdetailMessaget\0Ljava/lang/String;[\0\nstackTracet\0[Ljava/lang/StackTraceElement;L\0suppressedExceptionst\0Ljava/util/List;xpq\0~\0	t\0Bad credentialsur\0[Ljava.lang.StackTraceElement;F*<<ý\"9\0\0xp\0\0\0Gsr\0java.lang.StackTraceElementa	Åš&6Ý…\0B\0formatI\0\nlineNumberL\0classLoaderNameq\0~\0L\0declaringClassq\0~\0L\0fileNameq\0~\0L\0\nmethodNameq\0~\0L\0\nmoduleNameq\0~\0L\0\rmoduleVersionq\0~\0xp\0\0\0t\0appt\0Yorg.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvidert\0.AbstractUserDetailsAuthenticationProvider.javat\0authenticateppsq\0~\0\r\0\0\0¶q\0~\0t\0;org.springframework.security.authentication.ProviderManagert\0ProviderManager.javaq\0~\0ppsq\0~\0\r\0\0\0\Éq\0~\0q\0~\0q\0~\0q\0~\0ppsq\0~\0\r\0\0\0Uq\0~\0t\0Torg.springframework.security.web.authentication.UsernamePasswordAuthenticationFiltert\0)UsernamePasswordAuthenticationFilter.javat\0attemptAuthenticationppsq\0~\0\r\0\0\0\çq\0~\0t\0Vorg.springframework.security.web.authentication.AbstractAuthenticationProcessingFiltert\0+AbstractAuthenticationProcessingFilter.javat\0doFilterppsq\0~\0\r\0\0\0\Ýq\0~\0q\0~\0q\0~\0q\0~\0ppsq\0~\0\r\0\0vq\0~\0t\0Dorg.springframework.security.web.FilterChainProxy$VirtualFilterChaint\0FilterChainProxy.javaq\0~\0ppsq\0~\0\r\0\0\0kq\0~\0t\0Corg.springframework.security.web.authentication.logout.LogoutFiltert\0LogoutFilter.javaq\0~\0ppsq\0~\0\r\0\0\0]q\0~\0q\0~\0$q\0~\0%q\0~\0ppsq\0~\0\r\0\0vq\0~\0q\0~\0!q\0~\0\"q\0~\0ppsq\0~\0\r\0\0\0ƒq\0~\0t\00org.springframework.security.web.csrf.CsrfFiltert\0CsrfFilter.javat\0doFilterInternalppsq\0~\0\r\0\0\0tq\0~\0t\03org.springframework.web.filter.OncePerRequestFiltert\0OncePerRequestFilter.javaq\0~\0ppsq\0~\0\r\0\0vq\0~\0q\0~\0!q\0~\0\"q\0~\0ppsq\0~\0\r\0\0\0Zq\0~\0t\0:org.springframework.security.web.header.HeaderWriterFiltert\0HeaderWriterFilter.javat\0doHeadersAfterppsq\0~\0\r\0\0\0Kq\0~\0q\0~\01q\0~\02q\0~\0+ppsq\0~\0\r\0\0\0tq\0~\0q\0~\0-q\0~\0.q\0~\0ppsq\0~\0\r\0\0vq\0~\0q\0~\0!q\0~\0\"q\0~\0ppsq\0~\0\r\0\0\0Rq\0~\0t\0Dorg.springframework.security.web.context.SecurityContextHolderFiltert\0 SecurityContextHolderFilter.javaq\0~\0ppsq\0~\0\r\0\0\0Eq\0~\0q\0~\08q\0~\09q\0~\0ppsq\0~\0\r\0\0vq\0~\0q\0~\0!q\0~\0\"q\0~\0ppsq\0~\0\r\0\0\0>q\0~\0t\0Worg.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFiltert\0%WebAsyncManagerIntegrationFilter.javaq\0~\0+ppsq\0~\0\r\0\0\0tq\0~\0q\0~\0-q\0~\0.q\0~\0ppsq\0~\0\r\0\0vq\0~\0q\0~\0!q\0~\0\"q\0~\0ppsq\0~\0\r\0\0\0*q\0~\0t\0?org.springframework.security.web.session.DisableEncodeUrlFiltert\0DisableEncodeUrlFilter.javaq\0~\0+ppsq\0~\0\r\0\0\0tq\0~\0q\0~\0-q\0~\0.q\0~\0ppsq\0~\0\r\0\0vq\0~\0q\0~\0!q\0~\0\"q\0~\0ppsq\0~\0\r\0\0\0\éq\0~\0t\01org.springframework.security.web.FilterChainProxyq\0~\0\"q\0~\0+ppsq\0~\0\r\0\0\0¿q\0~\0q\0~\0Gq\0~\0\"q\0~\0ppsq\0~\0\r\0\0\0qq\0~\0t\0Aorg.springframework.web.filter.CompositeFilter$VirtualFilterChaint\0CompositeFilter.javaq\0~\0ppsq\0~\0\r\0\0\0\Ãq\0~\0t\0Borg.springframework.web.servlet.handler.HandlerMappingIntrospectort\0HandlerMappingIntrospector.javat\0\Zlambda$createCacheFilter$3ppsq\0~\0\r\0\0\0qq\0~\0q\0~\0Jq\0~\0Kq\0~\0ppsq\0~\0\r\0\0\0Jq\0~\0t\0.org.springframework.web.filter.CompositeFilterq\0~\0Kq\0~\0ppsq\0~\0\r\0\0\0\æq\0~\0t\0vorg.springframework.security.config.annotation.web.configuration.WebMvcSecurityConfiguration$CompositeFilterChainProxyt\0 WebMvcSecurityConfiguration.javaq\0~\0ppsq\0~\0\r\0\0`q\0~\0t\04org.springframework.web.filter.DelegatingFilterProxyt\0\ZDelegatingFilterProxy.javat\0invokeDelegateppsq\0~\0\r\0\0q\0~\0q\0~\0Wq\0~\0Xq\0~\0ppsq\0~\0\r\0\0\0¤q\0~\0t\0/org.apache.catalina.core.ApplicationFilterChaint\0ApplicationFilterChain.javat\0internalDoFilterppsq\0~\0\r\0\0\0Œq\0~\0q\0~\0\\q\0~\0]q\0~\0ppsq\0~\0\r\0\0\0dq\0~\0t\03org.springframework.web.filter.RequestContextFiltert\0RequestContextFilter.javaq\0~\0+ppsq\0~\0\r\0\0\0tq\0~\0q\0~\0-q\0~\0.q\0~\0ppsq\0~\0\r\0\0\0¤q\0~\0q\0~\0\\q\0~\0]q\0~\0^ppsq\0~\0\r\0\0\0Œq\0~\0q\0~\0\\q\0~\0]q\0~\0ppsq\0~\0\r\0\0\0]q\0~\0t\00org.springframework.web.filter.FormContentFiltert\0FormContentFilter.javaq\0~\0+ppsq\0~\0\r\0\0\0tq\0~\0q\0~\0-q\0~\0.q\0~\0ppsq\0~\0\r\0\0\0¤q\0~\0q\0~\0\\q\0~\0]q\0~\0^ppsq\0~\0\r\0\0\0Œq\0~\0q\0~\0\\q\0~\0]q\0~\0ppsq\0~\0\r\0\0\0Žq\0~\0t\0<org.springframework.session.web.http.SessionRepositoryFiltert\0SessionRepositoryFilter.javaq\0~\0+ppsq\0~\0\r\0\0\0Rq\0~\0t\09org.springframework.session.web.http.OncePerRequestFilterq\0~\0.q\0~\0ppsq\0~\0\r\0\0`q\0~\0q\0~\0Wq\0~\0Xq\0~\0Yppsq\0~\0\r\0\0q\0~\0q\0~\0Wq\0~\0Xq\0~\0ppsq\0~\0\r\0\0\0¤q\0~\0q\0~\0\\q\0~\0]q\0~\0^ppsq\0~\0\r\0\0\0Œq\0~\0q\0~\0\\q\0~\0]q\0~\0ppsq\0~\0\r\0\0\0\Éq\0~\0t\06org.springframework.web.filter.CharacterEncodingFiltert\0CharacterEncodingFilter.javaq\0~\0+ppsq\0~\0\r\0\0\0tq\0~\0q\0~\0-q\0~\0.q\0~\0ppsq\0~\0\r\0\0\0¤q\0~\0q\0~\0\\q\0~\0]q\0~\0^ppsq\0~\0\r\0\0\0Œq\0~\0q\0~\0\\q\0~\0]q\0~\0ppsq\0~\0\r\0\0\0§q\0~\0t\0-org.apache.catalina.core.StandardWrapperValvet\0StandardWrapperValve.javat\0invokeppsq\0~\0\r\0\0\0Zq\0~\0t\0-org.apache.catalina.core.StandardContextValvet\0StandardContextValve.javaq\0~\0~ppsq\0~\0\r\0\0\ãq\0~\0t\03org.apache.catalina.authenticator.AuthenticatorBaset\0AuthenticatorBase.javaq\0~\0~ppsq\0~\0\r\0\0\0sq\0~\0t\0*org.apache.catalina.core.StandardHostValvet\0StandardHostValve.javaq\0~\0~ppsq\0~\0\r\0\0\0]q\0~\0t\0+org.apache.catalina.valves.ErrorReportValvet\0ErrorReportValve.javaq\0~\0~ppsq\0~\0\r\0\0\0Jq\0~\0t\0,org.apache.catalina.core.StandardEngineValvet\0StandardEngineValve.javaq\0~\0~ppsq\0~\0\r\0\0Xq\0~\0t\0+org.apache.catalina.connector.CoyoteAdaptert\0CoyoteAdapter.javat\0serviceppsq\0~\0\r\0\0€q\0~\0t\0(org.apache.coyote.http11.Http11Processort\0Http11Processor.javaq\0~\0‘ppsq\0~\0\r\0\0\0?q\0~\0t\0(org.apache.coyote.AbstractProcessorLightt\0AbstractProcessorLight.javat\0processppsq\0~\0\r\0\0‰q\0~\0t\04org.apache.coyote.AbstractProtocol$ConnectionHandlert\0AbstractProtocol.javaq\0~\0˜ppsq\0~\0\r\0\0\Íq\0~\0t\06org.apache.tomcat.util.net.NioEndpoint$SocketProcessort\0NioEndpoint.javat\0doRunppsq\0~\0\r\0\0\04q\0~\0t\0.org.apache.tomcat.util.net.SocketProcessorBaset\0SocketProcessorBase.javat\0runppsq\0~\0\r\0\0¦q\0~\0t\01org.apache.tomcat.util.threads.ThreadPoolExecutort\0ThreadPoolExecutor.javat\0	runWorkerppsq\0~\0\r\0\0“q\0~\0t\08org.apache.tomcat.util.threads.ThreadPoolExecutor$Workerq\0~\0¦q\0~\0£ppsq\0~\0\r\0\0\0?q\0~\0t\0:org.apache.tomcat.util.threads.TaskThread$WrappingRunnablet\0TaskThread.javaq\0~\0£ppsq\0~\0\r\0\0\'pt\0java.lang.Threadt\0Thread.javaq\0~\0£t\0	java.baset\023sr\0java.util.Collections$EmptyListz¸´<§ž\Þ\0\0xpx');
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roleId` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'pedro@gmail.com','pedro123',4,'Pedro'),(5,'maria@gmail.com','maria123',5,'MarÃ­a'),(6,'juan@gmail.com','juan123',6,'Juan');
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

-- Dump completed on 2024-10-09 20:57:00
