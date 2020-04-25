-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: ntic
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `absence`
--

DROP TABLE IF EXISTS `absence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `absence` (
  `numero_absence` int(11) NOT NULL AUTO_INCREMENT,
  `code_seance` varchar(10) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  PRIMARY KEY (`numero_absence`),
  KEY `code_seance` (`code_seance`),
  KEY `id_etudiant` (`id_etudiant`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `absence`
--

LOCK TABLES `absence` WRITE;
/*!40000 ALTER TABLE `absence` DISABLE KEYS */;
/*!40000 ALTER TABLE `absence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `date_nomination` date NOT NULL,
  PRIMARY KEY (`id_admin`),
  KEY `id_admin` (`id_admin`),
  CONSTRAINT `id_admin` FOREIGN KEY (`id_admin`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chefdepartement`
--

DROP TABLE IF EXISTS `chefdepartement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chefdepartement` (
  `id_chef_departement` int(11) NOT NULL,
  `date_nomination` date NOT NULL,
  PRIMARY KEY (`id_chef_departement`),
  KEY `id_chef_departement` (`id_chef_departement`),
  CONSTRAINT `id_chef_departement` FOREIGN KEY (`id_chef_departement`) REFERENCES `enseignant` (`id_enseignant`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chefdepartement`
--

LOCK TABLES `chefdepartement` WRITE;
/*!40000 ALTER TABLE `chefdepartement` DISABLE KEYS */;
/*!40000 ALTER TABLE `chefdepartement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `congeacademique`
--

DROP TABLE IF EXISTS `congeacademique`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `congeacademique` (
  `numero_conge_academique` int(11) NOT NULL AUTO_INCREMENT,
  `id_etudiant` int(11) NOT NULL,
  `fichier` blob NOT NULL,
  `etat` enum('valide','refuse','nonTraite') NOT NULL,
  PRIMARY KEY (`numero_conge_academique`),
  KEY `idetudiant` (`id_etudiant`),
  CONSTRAINT `idetudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `congeacademique`
--

LOCK TABLES `congeacademique` WRITE;
/*!40000 ALTER TABLE `congeacademique` DISABLE KEYS */;
/*!40000 ALTER TABLE `congeacademique` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departement`
--

DROP TABLE IF EXISTS `departement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departement` (
  `code_departement` enum('MI','TLSI','IFA') NOT NULL,
  `id_chef_departement` int(11) NOT NULL,
  PRIMARY KEY (`code_departement`),
  KEY `id_chefdepartement` (`id_chef_departement`),
  CONSTRAINT `id_chefdepartement` FOREIGN KEY (`id_chef_departement`) REFERENCES `chefdepartement` (`id_chef_departement`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departement`
--

LOCK TABLES `departement` WRITE;
/*!40000 ALTER TABLE `departement` DISABLE KEYS */;
INSERT INTO `departement` VALUES ('MI',1),('TLSI',2),('IFA',3);
/*!40000 ALTER TABLE `departement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emploiedutemps`
--

DROP TABLE IF EXISTS `emploiedutemps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emploiedutemps` (
  `numero_emploi` int(11) NOT NULL AUTO_INCREMENT,
  `id_chef_departement` int(11) NOT NULL,
  `emploi` blob NOT NULL,
  `specialite` varchar(10) NOT NULL,
  PRIMARY KEY (`numero_emploi`),
  KEY `idchefdepartement` (`id_chef_departement`),
  CONSTRAINT `idchefdepartement` FOREIGN KEY (`id_chef_departement`) REFERENCES `chefdepartement` (`id_chef_departement`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emploiedutemps`
--

LOCK TABLES `emploiedutemps` WRITE;
/*!40000 ALTER TABLE `emploiedutemps` DISABLE KEYS */;
/*!40000 ALTER TABLE `emploiedutemps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enseignant`
--

DROP TABLE IF EXISTS `enseignant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enseignant` (
  `id_enseignant` int(11) NOT NULL,
  `grade` varchar(20) NOT NULL,
  PRIMARY KEY (`id_enseignant`),
  KEY `id_enseignant` (`id_enseignant`),
  CONSTRAINT `id_enseignant` FOREIGN KEY (`id_enseignant`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enseignant`
--

LOCK TABLES `enseignant` WRITE;
/*!40000 ALTER TABLE `enseignant` DISABLE KEYS */;
INSERT INTO `enseignant` VALUES (2,'Ungrade'),(3,'ungrade');
/*!40000 ALTER TABLE `enseignant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enseignement`
--

DROP TABLE IF EXISTS `enseignement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enseignement` (
  `code_module` varchar(10) NOT NULL,
  `id_enseignant` int(11) NOT NULL,
  PRIMARY KEY (`code_module`,`id_enseignant`),
  KEY `code_module` (`code_module`),
  KEY `id_enseignant` (`id_enseignant`),
  CONSTRAINT `codemodule` FOREIGN KEY (`code_module`) REFERENCES `module` (`code_module`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `idenseignant` FOREIGN KEY (`id_enseignant`) REFERENCES `enseignant` (`id_enseignant`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enseignement`
--

LOCK TABLES `enseignement` WRITE;
/*!40000 ALTER TABLE `enseignement` DISABLE KEYS */;
/*!40000 ALTER TABLE `enseignement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiant` (
  `id_etudiant` int(11) NOT NULL,
  `annee` enum('L1','L2','L3','M1','M2') NOT NULL,
  `specialite` enum('MI','GL','SI','TI','SCI','STIC','STIW','RSD') NOT NULL,
  `section` int(11) NOT NULL,
  `groupe` int(11) NOT NULL,
  `etat` enum('actif','bloque') NOT NULL,
  PRIMARY KEY (`id_etudiant`),
  KEY `id_etudiant` (`id_etudiant`),
  CONSTRAINT `id_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiant`
--

LOCK TABLES `etudiant` WRITE;
/*!40000 ALTER TABLE `etudiant` DISABLE KEYS */;
INSERT INTO `etudiant` VALUES (1,'L3','GL',1,3,'actif');
/*!40000 ALTER TABLE `etudiant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `justification`
--

DROP TABLE IF EXISTS `justification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `justification` (
  `numero_justification` int(11) NOT NULL AUTO_INCREMENT,
  `numero_absence` int(11) NOT NULL,
  `fichier` blob NOT NULL,
  `date_justification` date NOT NULL,
  `etat` enum('valide','refuse','nonTraite') NOT NULL,
  PRIMARY KEY (`numero_justification`),
  KEY `numero_absence` (`numero_absence`),
  CONSTRAINT `numero_absence` FOREIGN KEY (`numero_absence`) REFERENCES `absence` (`numero_absence`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `justification`
--

LOCK TABLES `justification` WRITE;
/*!40000 ALTER TABLE `justification` DISABLE KEYS */;
/*!40000 ALTER TABLE `justification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `module` (
  `code_module` varchar(10) NOT NULL,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`code_module`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `numero_notification` int(11) NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `permission_etudiant` tinyint(1) NOT NULL,
  `code_seance_supp` varchar(10) NOT NULL,
  PRIMARY KEY (`numero_notification`),
  KEY `code_seance_supp` (`code_seance_supp`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`code_seance_supp`) REFERENCES `seancesupp` (`code_seance_supp`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsableformation`
--

DROP TABLE IF EXISTS `responsableformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsableformation` (
  `id_responsable` int(11) NOT NULL,
  `date_nomination` date NOT NULL,
  PRIMARY KEY (`id_responsable`),
  KEY `id_responsable` (`id_responsable`),
  CONSTRAINT `id_responsable` FOREIGN KEY (`id_responsable`) REFERENCES `enseignant` (`id_enseignant`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsableformation`
--

LOCK TABLES `responsableformation` WRITE;
/*!40000 ALTER TABLE `responsableformation` DISABLE KEYS */;
/*!40000 ALTER TABLE `responsableformation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seance`
--

DROP TABLE IF EXISTS `seance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seance` (
  `code_seance` varchar(10) NOT NULL,
  `section` int(11) NOT NULL,
  `groupe` int(11) NOT NULL,
  `date` date NOT NULL,
  `etat_s├®ance` enum('valide','refuse','nonTraite') NOT NULL,
  `code_module` varchar(10) NOT NULL,
  PRIMARY KEY (`code_seance`),
  KEY `code_module` (`code_module`),
  CONSTRAINT `code_module` FOREIGN KEY (`code_module`) REFERENCES `module` (`code_module`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seance`
--

LOCK TABLES `seance` WRITE;
/*!40000 ALTER TABLE `seance` DISABLE KEYS */;
/*!40000 ALTER TABLE `seance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seancesupp`
--

DROP TABLE IF EXISTS `seancesupp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seancesupp` (
  `code_seance_supp` varchar(10) NOT NULL,
  `etat_supp` enum('valide','refuse','nonTraite') NOT NULL,
  `numero_notification` int(11) NOT NULL,
  PRIMARY KEY (`code_seance_supp`),
  KEY `numero_notification` (`numero_notification`),
  KEY `code_seance_supp` (`code_seance_supp`),
  CONSTRAINT `code_seance_supp` FOREIGN KEY (`code_seance_supp`) REFERENCES `seance` (`code_seance`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `numero_notification` FOREIGN KEY (`numero_notification`) REFERENCES `notification` (`numero_notification`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seancesupp`
--

LOCK TABLES `seancesupp` WRITE;
/*!40000 ALTER TABLE `seancesupp` DISABLE KEYS */;
/*!40000 ALTER TABLE `seancesupp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id_utilisateur` int(11) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_utilisateur`),
  CONSTRAINT `id_utilsiateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (2,'c4cc6dk5122cidcnf37a1ek68jeglecheheb'),(3,'27a1d8849c5dh39j4kdin5e35lkgblakhdara');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilisateur` (
  `id_utilisateur` int(11) NOT NULL,
  `user` varchar(20) NOT NULL,
  `pass` varchar(20) NOT NULL COMMENT '				',
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `adresse` varchar(60) NOT NULL,
  `date_n` date NOT NULL,
  `email` varchar(40) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `type_utilisateur` enum('etudiant','enseignant','admin','chefDepartement','responsableFormation') NOT NULL,
  `code_departement` enum('MI','TLSI','IFA','undefined') NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  KEY `code_departement` (`code_departement`),
  CONSTRAINT `code_departement` FOREIGN KEY (`code_departement`) REFERENCES `departement` (`code_departement`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'zak1','123456','Djebbes','Zakaria','Khroub','2000-03-24','orochi255@hotmail.fr','012354568','etudiant','TLSI'),(2,'lecheheb','247365','Lecheheb','Nassim','Constantine','1987-02-15','Lecheheb.nassim@gmail.com','0123456789','enseignant','TLSI'),(3,'lakhdara','123456','Lakhdara','Zakaria','Constantine','1987-01-31','Lakhdara.zakaria@gmail.com','0123456789','enseignant','TLSI');
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-26  0:50:18
