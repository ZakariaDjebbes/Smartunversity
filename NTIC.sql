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
  `code_seance` varchar(10) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `numero_absence` int(11) NOT NULL AUTO_INCREMENT,
  `date_absence` date DEFAULT NULL,
  PRIMARY KEY (`numero_absence`),
  KEY `fk_Seance_has_Etudiant_Seance` (`code_seance`),
  KEY `fk_Seance_has_Etudiant_Etudiant` (`id_etudiant`),
  CONSTRAINT `fk_Seance_has_Etudiant_Etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Seance_has_Etudiant_Seance` FOREIGN KEY (`code_seance`) REFERENCES `seance` (`code_seance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `absence`
--

LOCK TABLES `absence` WRITE;
/*!40000 ALTER TABLE `absence` DISABLE KEYS */;
INSERT INTO `absence` VALUES ('2',15,57,'2020-05-07'),('2',15,58,'2020-05-07'),('2',15,59,'2020-05-07'),('2',14,60,'2020-05-07'),('2',14,61,'2020-05-07'),('2',12,62,'2020-05-22'),('2',14,63,'2020-05-22'),('2',15,64,'2020-05-22');
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
  `date_nomination` date DEFAULT NULL,
  PRIMARY KEY (`id_admin`),
  KEY `fk_Admin_Utilisateur` (`id_admin`),
  CONSTRAINT `fk_Admin_Utilisateur` FOREIGN KEY (`id_admin`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE
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
-- Table structure for table `changementseance`
--

DROP TABLE IF EXISTS `changementseance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changementseance` (
  `code_seance` varchar(10) NOT NULL,
  `nouveau_jour` enum('dimanche','lundi','mardi','mercredi','jeudi') NOT NULL,
  `nouvelle_heure` enum('8:30','10:00','11:30','13:00','14:30') NOT NULL,
  `etat_demande` enum('valide','refuse','nonTraite') NOT NULL DEFAULT 'nonTraite',
  PRIMARY KEY (`code_seance`),
  CONSTRAINT `code_seance_demande_fk` FOREIGN KEY (`code_seance`) REFERENCES `seance` (`code_seance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changementseance`
--

LOCK TABLES `changementseance` WRITE;
/*!40000 ALTER TABLE `changementseance` DISABLE KEYS */;
INSERT INTO `changementseance` VALUES ('3','mercredi','8:30','nonTraite'),('4','lundi','11:30','nonTraite');
/*!40000 ALTER TABLE `changementseance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chefdepartement`
--

DROP TABLE IF EXISTS `chefdepartement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chefdepartement` (
  `id_chef_departement` int(11) NOT NULL,
  `date_nomination` date DEFAULT NULL,
  PRIMARY KEY (`id_chef_departement`),
  KEY `fk_ChefDepartement_Enseignant` (`id_chef_departement`),
  CONSTRAINT `fk_ChefDepartement_Enseignant` FOREIGN KEY (`id_chef_departement`) REFERENCES `enseignant` (`id_enseignant`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `id_etudiant` int(11) DEFAULT NULL,
  `fichier` blob NOT NULL,
  `etat` enum('valide','refuse','nonTraite') NOT NULL,
  PRIMARY KEY (`numero_conge_academique`),
  KEY `fk_CongeAcademique_Etudiant` (`id_etudiant`),
  CONSTRAINT `fk_CongeAcademique_Etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `id_chef_departement` int(11) DEFAULT NULL,
  PRIMARY KEY (`code_departement`),
  KEY `fk_Departement_ChefDepartement` (`id_chef_departement`),
  CONSTRAINT `fk_Departement_ChefDepartement` FOREIGN KEY (`id_chef_departement`) REFERENCES `chefdepartement` (`id_chef_departement`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departement`
--

LOCK TABLES `departement` WRITE;
/*!40000 ALTER TABLE `departement` DISABLE KEYS */;
INSERT INTO `departement` VALUES ('MI',NULL),('TLSI',NULL),('IFA',NULL);
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
  `emploi` blob NOT NULL,
  `specialite` varchar(10) NOT NULL,
  `id_chef_departement` int(11) DEFAULT NULL,
  PRIMARY KEY (`numero_emploi`),
  KEY `fk_EmploieDuTemps_ChefDepartement` (`id_chef_departement`),
  CONSTRAINT `fk_EmploieDuTemps_ChefDepartement` FOREIGN KEY (`id_chef_departement`) REFERENCES `chefdepartement` (`id_chef_departement`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `grade` varchar(20) DEFAULT NULL,
  `code_departement` enum('MI','TLSI','IFA') DEFAULT NULL,
  PRIMARY KEY (`id_enseignant`),
  KEY `fk_Enseignant_Utilisateur` (`id_enseignant`),
  KEY `fk_Enseignant_Departement` (`code_departement`),
  CONSTRAINT `fk_Enseignant_Departement` FOREIGN KEY (`code_departement`) REFERENCES `departement` (`code_departement`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Enseignant_Utilisateur` FOREIGN KEY (`id_enseignant`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enseignant`
--

LOCK TABLES `enseignant` WRITE;
/*!40000 ALTER TABLE `enseignant` DISABLE KEYS */;
INSERT INTO `enseignant` VALUES (1,'Professeur','TLSI'),(2,'Professeur','TLSI');
/*!40000 ALTER TABLE `enseignant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enseignement`
--

DROP TABLE IF EXISTS `enseignement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enseignement` (
  `id_enseignant` int(11) NOT NULL,
  `code_seance` varchar(10) NOT NULL,
  PRIMARY KEY (`id_enseignant`,`code_seance`),
  KEY `code_seance_fk2` (`code_seance`),
  CONSTRAINT `code_seance_fk2` FOREIGN KEY (`code_seance`) REFERENCES `seance` (`code_seance`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_enseignant_fk2` FOREIGN KEY (`id_enseignant`) REFERENCES `enseignant` (`id_enseignant`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enseignement`
--

LOCK TABLES `enseignement` WRITE;
/*!40000 ALTER TABLE `enseignement` DISABLE KEYS */;
INSERT INTO `enseignement` VALUES (2,'1'),(1,'2'),(2,'2'),(1,'3'),(1,'4'),(1,'5');
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
  `code_departement` enum('MI','TLSI','IFA') DEFAULT NULL,
  PRIMARY KEY (`id_etudiant`),
  KEY `fk_Etudiant_Utilisateur` (`id_etudiant`),
  KEY `fk_Etudiant_Departement` (`code_departement`),
  CONSTRAINT `fk_Etudiant_Departement` FOREIGN KEY (`code_departement`) REFERENCES `departement` (`code_departement`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Etudiant_Utilisateur` FOREIGN KEY (`id_etudiant`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiant`
--

LOCK TABLES `etudiant` WRITE;
/*!40000 ALTER TABLE `etudiant` DISABLE KEYS */;
INSERT INTO `etudiant` VALUES (3,'L2','MI',1,1,'actif','MI'),(4,'L2','MI',1,2,'actif','MI'),(5,'L2','MI',4,16,'actif','MI'),(6,'M2','GL',1,1,'actif','TLSI'),(7,'M2','RSD',1,2,'actif','IFA'),(8,'M1','STIC',1,3,'actif','IFA'),(9,'L3','GL',1,1,'actif','TLSI'),(10,'L3','SI',1,2,'actif','TLSI'),(11,'L1','MI',1,2,'actif','MI'),(12,'L2','MI',3,12,'actif','MI'),(13,'L3','GL',1,3,'actif','TLSI'),(14,'L2','MI',3,12,'actif','MI'),(15,'L2','MI',3,12,'actif','MI'),(16,'L2','MI',2,9,'actif','MI'),(17,'M1','GL',1,1,'actif','TLSI'),(18,'L2','MI',1,1,'actif','MI'),(19,'L2','MI',1,1,'actif','MI'),(20,'L3','GL',1,1,'actif','TLSI');
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
  PRIMARY KEY (`numero_justification`,`numero_absence`),
  KEY `fk_Justification_Absence` (`numero_absence`),
  CONSTRAINT `fk_Justification_Absence` FOREIGN KEY (`numero_absence`) REFERENCES `absence` (`numero_absence`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `justification`
--

LOCK TABLES `justification` WRITE;
/*!40000 ALTER TABLE `justification` DISABLE KEYS */;
INSERT INTO `justification` VALUES (3,59,_binary '�\��\�\0JFIF\0\0H\0H\0\0�\�\0C\0			\n\n\n\n\n\n	\n\n\n�\�\0C\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n��\000\"\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0H\0\n\0\0	!1\nA\"a#2Qq�4��$BR%3Sbr���\�D���c�����\�\0\0\0\0\0\0\0\0\0\0\0	�\�\0;\0\0\0\0\0\0!1AQq�a���\"2r\�#BR�\��Sb5���\�\0\0\0?\0��R�E�����\0�)@)JP\nR�>\�م<J��\\��kd�:\�7\�\\�\�m4�:z~<5n�f�\�8�\0�7e/p>A0��\�\�g����f&���\�]���2\�_3cjor����W�\�\��\0-{7e5\�\�\�{x˼�~T{��\n�N�>���\�\�\�?Ֆ\�e5�\��\�`�*q\�\0�\� -<��2�\'��\�n�:_\��=�\�\�7��T	$�\�\\k<�{s,�%?��֤\�xJ�T\�L\�bx�E\�/h�;@��\'N\�޿|���[]�\�\�g�6�m\r\�ƣ�����㩡\\T!�\��f6�TV\�\�\�m�\��+�\\g�s\��h�>�d\�As��?B`^��\��QġQ��_�\��[�|)m�?S7/<�\n�\�\��\�ܩM؅�������ۏ�a�С\�Ω5~]\�cOc-q\�\�\�ar@���0\�L�m�b�\�ֹ>�J���$J�\0?_�+�=�&���ڣMQ\'��\�n<�vrW\�\�rOD4_�\�������\�\�\�\�yE\��\0%\�\�_�G���e�+~\Z\�(\�\�jޑ�\��>G���\�h2\�\�7�\rw\�|]\�;��?�H\�\��2}��j\�\�\�|g?�l�/����c��K�J\�\��hz�\�X�#��\0x��\�?���nj[�<{\Zx\�\Z��-�D\�z*M\'c\�\'v�������QH\�累�]8�\\mn�\�}GjJǒ[�t\�q�U	2rW��I\��\�\�\��{i$\�.�u<��r[!��FV\0���kC\'����^*\�C˟z�\�R�YP0?�k[>�ȟm^y���O�6�z%R2f��%�O�M��k�+�,\�-d�h���J�Y{A�\n����m�z\�;�LD�}�\�m9�C\�cK\�\�r��G\�\��b?�:������M�Ԇ\�P􉼹\r1r�O�\�\�o���\"N8�%�_\�5�\�U�\�Q\�\���}�0\��R;�N�˿\�o�kO�$r=��_���\��\�Z�\�-\��m\r\�\���SU\�I�\�?�\0����\�\��5�^\�\�fzi\�ؕ�\�\�/;U\�\�{�I\�&l�]\�T_�)JVj)JP\nR���\0�)@)JP\nR���<{��x<�C�o�s\�\�\�\�m)��ƥ�\�\�3O\�\���+��\�c1��<�2�\�c�4���\0W\�j�ri�i���d�Q\Z�\�WR!\��8���\�_�V}�uC��!�4\�W�KY\�Q�\�\�q�ʯ�3\�?\�\�A#\��!#�����6\�\�y{�[�7\"\�\'�۫K�m��\��\�y����6�8f��\\4��ҺNZi�,�8\�|�?j�\�J8TD@`\0\0T\�ׅ�*$�Z����j\�\�}��s\��$�MK\"�����{9�7\��\0\�\�\�wJ��\�����\0\�v��+����Se�\��&5�\0�)�ԎC�\�+,}�6���HbE\n�\Z�\0\0q�+\�*O��\��}�֧TԴԌ\�D\�jw�y\��AT�	�#��\�NI�:!��aJ:W�\�\nR���\�\�\'h�Jm�oN5��\�mMb\�{\�\��g�+�2[+✇�Ԣ��$��\�w�\�\�\�h��\�\�\�#ֻ��1˄\��L��\�\�\�\�K۹B�\�\�\�:\�ʖ�A�\�`�\�ӧ^\�]:\�z�\�V��NA},�6\�\�\�UA�\�\� O�2r>\�]J�FV4�ߍ�\�Χ7w=��/�.�Է\�w�\�\�d�i�\0T*$j\"*���\0͝�;�uڏ��}\�\�[��\�ߘ\������e�\�J\��o�>�\�\��\0�lO�#I�u�V\�/�N�{�t\�\�S�\�Z/�9��Xۏ�\�^��-�\�@�Nd\�}ʺ�t,��sM\0�)@\�\�P�=\�)@zYLN37e&;)aͼ\�RXf@\�\�GH>\�\�Q�\0\�ӯ\�\�R\�w��Z\�\�v��3�����6y?�[\"UT|�\�b�<�*�\�\��?\�\\�y��-M%5[;2��\�ˈ�Xv�*-Ӻ7\'Լ\�b�B�}lv\�균}Tp\�\�$�nX�[��|}\�7��܀O� G�\'ďz�~^_��v�\�\�\r�zV�Cn6�\�f��7�ܥ�O�x\�a�P�\��麋a}�]�\"��\"\�\�6\��\�ϕ�&\�i�#\�ё�<�,f\ru\�\�%/\�\�ӗ���(�Ne�9RH�*�����r!ι௿5\�f�y�5��\�Z�u�\�X\\=�\�\�C5��J�r#�\�\�AH\�^�\�C\�\�j\�IG,SƒF��\�T8�)_���\0�)@)JP\nR�?�h�ɮHR=��ɬ\�ЗB;\�\�{`\�\r�ǈ`�V}C���ck��-��\��\�>\�\"\�\��˖e��#�3U؆�\�t��P���\�\�ؙ��\�>{������=\�\�\�\�\�7\�\�/{��9K\\u� =\�̀N%\�\�X���T؋��gޞ;xi��X\�DԺ�\�\�&[Zd�J9�d\��\Z~T\�\�\�\�\��t���6�\r�\�\�k��I�\����-p�\��\�����	\0{�s��>\�ެ�5�{�\'jO$\��8oI�\\�c\n�RQ9c�MYlW����x��\0��*HS��\0�)@)J\�N�]�v���\��\0v�\�X\�]\�\�\�.\�;G�\�Q\�FyQ��\nC%��>)\�y\�J)\n�I�]�v���\��\0v�\�X\�]\�\�\�.\�;G�\�Q\�FyQ��\nC%��>)\�y\�J)\n�IK�\�}�s��\�\�o\��\�\�\�M�5-�]\�s9)<��C\�\0�DU\n�\Z�����*�\���\�\�\�\�\�~u\���՚����9���RM!�\0¢*�D�@DEUP@@)JP;\�úwQ]����ޝ��k�-��\�Z\�ˆ[-Ad�O��\�̜��pF\��24����\�ӧ^\�]:\�z�\�V��NA},�6\�\�opת�\�ew\'ә9r��]#+\Z6V\���\�ԇjΣ\�7�cn\�\�b2rEk��5\�\�,��oh�\0}9\�ɌS�-1�dw���\�+\��kqd\���\�;�6�\�i�\�x+\\�\�\�Mf-�8\�4K\'\�\�b�s\'��/\'�����()J\\2��\�k�P\ZQ\�����\�]k\\5�\ZOr`�\��쭇eG\r\�c�^?`\�\'ĕ\Z�=J�ͽ=#n\�Kd�\�Fφ\�c���Cw	$%\�|K�xa�H��\�|�\�\�n�\�%����;,�6J�i�Wi\n��U�*O�M��\0~\�*�\�oX~\Z���\'fO%\�\�\�]�1\��\�\�\�*�,�������\�SÁU\�\�>ƃ�=�\0���\�\�\�{z\�\�ݒ\�\� �\�\�b��\�\�\�+jI	q�9S�O�\n��Jı㊭f�Jy9%M�w�\�Ew�e]#\��3EMh��R��g�R���\�\�P�O\��ހ0�\�t��\�\��T\�F��\�\����\��x\�8\�\�sq#��4Q�\�\��\�\�Z�vM\�`�x��t��MD\�Uv\"!�}$���}io~\'a�S\�y<��\�\�\��\�کK��\0�D��ՉUPY�4�\�v\�v�\�|~\�\�u��常\�9�\�\�+xT�B>\�S�@QϹ8\�\'m-1\�çXp�k{k\�{�\�;\�i��\�o\�k|�0�e�1w\�y����\0#�V��6\���?Q\�I\�\�p����Q�nKGH\�JH\�V_�S�/w\�~\�O�T��E)JJR�R����\�\�iM��\�\�ƱԻͩ�]�v�y�����%~�Ke`|S��Rd�0�\�\�iM��\�\�ƱԻͩ�]�v�y�����%~�Ke`|S��Rd�:�\��\�\�S{��ߍ�חڛVj[\�\�\�rRyI4�\�\0\n��5U@U\07\�}�s��\�\�o\��\�\�\�M�5-�]\�s9)<��C\�\0�DU\n�\Z�����*�>:�R���y`�k��\�\�&�IX\�E嘓�\0�@ �k�\�\�\�&�I*F�\�bO\0\0>MX\�\�\��p\�\�8p}~u��\�\�;\�\�\��6����6�\�\rG�?�0��>�O�\r��\�\�_�!d\�r,w\�}�\�HA]6��G{|\�f�#�٘z\�&�R���()JJR�R��5۸�n��\�%�W;a� KՊ�Ɣ\�\�ۆ�\�]�\�0��$\\�\�����f��\�v�Eތ\�\�on�lns?�-\r\�\'�N\� z�8�p\�!YYE����ڴ��l7p=��5�1�A�ZJ\�[�)\��x\�K	X�xK\�\�$�	�!K��\�쭸E\�bO\�O4\�ρv\�I\�\��h+]�$���*\�N\�)ԭY$�Ms��\�׷�\�\�t\�f�M\�<UŎCu%���\�-��F\�^7F\0�+>\��+\�s\�U��Z�)\�0\��\\\�u��R��\�)JP�\�M_\�y\�\���\��\�/,�I%�n\�\��\0hAI/�>�r�x\�>\�D�\"Q\�]��\��\�\��b\�x�\�<���\�\�\���\�yF���f+}�r��V�\�z_��͆�\���,1ػ8�l,�\"	ơ4Q쪪\0\0|S<-jl�Z�R|���9�O��\�Tɇ蟓ޙȩ���\�w3�\0��\0|\nR��)JJR�R�=��\�\�wi\�m�\�\�1��{�.=�L\�\�<-ʌ��S\�\�>�\\����\�+��\��\�]�6����\�\�Ro6��v\�\�=\��\�3ʌ��R-Ձ�NC\�\�QHU�H\�_��ﻝM\�\�{~7\�^_jmY�o�\�3�\�I\�$\�`\0*\"�TH\�DUUT\�\�]\�\�N��C7�[ٮ�:�Uj;��\�f��\�2��?�TQ@TP@P\0�ZJR�R�巂k��\�\�&�I,q��\�\��\0\�\�x&��-�\�g�Fh��x\0�y�}8�N[����Bɮ\�X\��o���mH\r�\�m�}�\�\�\��3~ہ\�\��p\�\�0}~u�My\"\�}��}����Ԁ\�\�\�\�\�\��ᣈ�\0��f��	���()JJ������\�\�W�,�R]Hj�\�c\�y���ek�\��Rc����\�#pI\'�E\�UU�VJ\�\�s\�5\'q�הz�\���rl�࿰�O/��\�\�\������}_~`A@[~��{y�\�Ϲ�NXΣ�q\�߈��\�\�\�_\�o%�\�`�^A9Y��*�\�v��()J\\2�\'\�\\Ҁ����-�\0�p-���i=\�V��ai\�\�$9 �-\��|���\�\�c\'��\\7r6�I\�\��Ò\�g1\�X\�\�.W�緕\nH��b*�\�ź+\�]�U�v:�͋�O\�\�L�\��?+7�\' \0]xh����\��5\�)���|.\�ܿ\�\�m\�\�Q-���\�\Zg\Z���\0m�\�`�P�}\�*t�\�p�q\���<V\�v�\�\�u�\��ڼՊϦ�Ns��r�al\�L\'��V��RG\�g���S�&\�r\�i\�\�zk\r�{�\�cj�zn\�M\��\�	\�;��\ry��\�\�WnI�9��c\�X-Y?\�\�\��17�T��\� ?��x?Ҽ��X\�\�il�#�Ɗ8\0\n�r<��󫖖�:Zv\�͍L�\�+�\��\0x�\�P��G+���tL��R��A��()Q\�\�{��\�v�\�\�\�ͽ��7�R\�\��ƙ��\�\�\�ܨ\�_�<�@�\�\�\�i�H\"���\������\�6\�m\��K�ڗϦ4̏\�\�FJ�)\�bN.CL\�@\�\�js��ɺ=B\�w{7�\\\�5.�ԙ�\�\��y\�u3}\�\�T\0Q@TUUP@\r\�\�M\�\�ts�ٽz\�!�uV�\�=\�o7��\�k��\�~ʠ\0�������\0�zJR�R�巷�\�d�����Fh��1<\0\0�4\�	��[kh�I$`�ƪK3�\0�V<�q>�Hv\�\�\�_:!dג,w�}�\�H]4����6��#��#�ٛ�\�N\'Ӊ�[\���\�\�D,��E��o��\'\0+���\�\�\�F\�7\�٣��\0��f��	���()JX7�/pN��kt\�\�G�M�\\}�0a�֥Z�;~\�LvV��<\�n	$𨡝ʢ�pN\��9v\�\�\�)ԏR:��\�N`\�\�\n��v��1\�ZFH�$�¢�weEf\�}\��\0�\�\�}F]o��\��\0	��[h\�ep\�a��K!�<\�n���Ұʋh��s��{�uu�\�\��.>\�Im�tm�\�5���-Ȇ x�V�rJ�{*,q��Ҕ\�v\�\�o\�ok�m7\�a2���ǅ��\���\�j\0ܘ&�^X\�0�c\�\�Y\�\��\�ӸgN�\�:r\�uӆ��E��gpwl���\n�wQ�|y0\�dR���Ty��\�\�ߨ\�\�=F\�o\�\�e�{;�}_�/\'e�\�6�0L>.���`DǑʳ��v\�V	\�\�\�3�N\�9c:�\�S~\"\�\��3�+�U��߅K;��>��r�)WBU��\�@)JP\nR�G\�Q�Dg�ޏ\�}4v$M����\�)�9y�l^\��UT�\�\�@�{�H�����S5�\�\�E\�+i��P�WL��Da\�+\�A�\ryk)�YL���\�n�\�\�^\�@�nE\�Ӫf�8=\�\�\��Y���H�]u��v&y\r\�\�\�I\��1�\�\�������\��G<��\� }<\�\�Z���[�=\�\�\rt�dj9:�`�#�\�S���t�t?O\Z��\��?\��\\e���\�\�fYK��yܴ\�\�\��t5�\\6SQe\�0K7�����\�\�\�1\�K+�UQ��@��m��6;\�oM�+c4\�J��gN\�\�z��z\�`<��ӿ���,MJ0���t\�\�\��_�P�\�8�hp�6�\�\'N\�\���_�\�dn\�\��O�U�q��)@)JP�f\�!���\�eM�\�\�\�%�\�d6�!d�og�$\�x\�\�1�\��K\�\�F=oj{>��&CW\��~B|�#sgV6��ܰ�d�D\�\n#\��\0��\"(1����X7�o�����\�黩\r/��}\�3\��6�V�\0|�\�m$ �H��A\�]K#�Ve Q֕�]ϻauڳ�˭�\�|g\��\�~�ƍ\�VV\�:��0h�\�\�E\�VX	-\�\�\�\��\�@)JP\n\�>\�]Yt�\�op\�%��jm$z�Kړ\r�Yզ�\�\�\�\�\��.}x�Y<�X\�I)\�\�P\�њ\�I\�6�\�k\��ls8L͔W���.\�g����C\�,R!*\�\�A\Z\�?O�\���mj\�>�z�\�_fv/5}�)4�\Z2\�F宭\�r\�j\�KMn�\��,c\�\�&�ƌ\�ZOq��3_hKc��\�l��\�e�wK=�崊9b�	WFR`x \��)JXc���:v\�\�Ӿ_�^�ur\�\�\���, �{\�\�\�)1YZDH�f\�\�UP\�\�Q�=vu\�ӷn����J�\'��\�/�aao\����\�Rb����\�\��\'�\�UP\�\�Q�B��wU\�+�Q3\�&�\�6;�i-�>���g��Y3\��\�\��*e��\�0\0D�4\�\�\��\0�\�L\�\��\�e�\�Z4�\�#FAt^\�N\�\�!�\���U���Ұ��\Z&�R���\0�)@l�k\�\��@v�\�^\�6S%-\�2w�\�Y\��\�Y\�,xnZ	}�I�h�\nZ\'<�U�\�=�\�ӯq��q=Jt٫E�\' ��Kqⷸk\�Pe���\�̜��WR�����+g{XwN\�+�QV�Ӳ�\���1\�\�]yp\�e�,���߀}9��1Nh؟fF�7\���-\�_^�:�\Z\�\�ԧM��_\�r\�d��+{��U[+��>�\�\���u*\�YX\�JR�R��\"\�\�Y�zC�����W;\��jc��6��%���$s+��\�P�O5l��:z\��Q\�\�\�\�]��s˝\�W	��G\";\�_R\�O�N�7�j�O��\�4l��C+���\�\�$5�2lzy�\��\�8�nXfKl��@\�_K���\�\��k\�\�\�\�\�_���y��\�\�\�\�Q,Q�S\�\�\�G��h��\"\�{�*�T�\�\�R���2ۇ8\r%i��\�\�\�\�ܙ=��\�\��\0Nju\�\�\�Hp�	���ʫᨥ��vu\��:/\�\Zޫ�}P攥I\�DR���{�?G;Զ�\�v�\�	�\�-\�Gm/��\'!\�\�������\�\�)_YՒ?&P���\0�)@`\�\����r\�UӞS�����\�\�|͇\�\�[��R#����\�*�Au,��\�#��\0l�{Vuu�;\��^:\�ԸѺ\�\�ݖ\�P؆\0M<�J��\�%�b=\�\Z9\�5�{�v�\�ϹONYN���\�\�\�w\��|Ţ�\�\�\�\�NU\�*\�Y23)����\�ڳ��ԛ�&\�\�%oq�}���0�\�h�z�\�>�\�\n��\�KFX{�2H�\�@)JP\n�\�\�\�\�ݶ�m�L=Of/�;������{�q#r\�V\�9g�f%��_pI�1\�\�E�(�h\�e��Ic5��Զ9�f\�+\�F_t�\�\�[H�\�)�te ��\rb��:\�\�۷WN\�~�z�\��\�\�Ұ���{\�\�\�)1YZDH�f�\�*�gr��µ�~��\�\�\�.�q��i�\�b{�^=\�L���!�\�\�\�uV�W��eP\�eB\�Yu���u^���u>�o-�c�\�\�C\�;�{,�0>+\��\�\�Y\�\r#\0\0TH\�@\�;��݃����yo��\�4��DYܳ\�`,���^x�g2\�@i\0�G\Zj�)@)JP\nR�2v�\�^�߯��8v�3\�m�\�#\��y��|9�?\�~\��>���???\�@a�R������;�uڏ��}\�\�[��\�ߘ\������e�\�J\��o�>�\�\��\0�lO�#I\�۠��:u\�5Ӯ\'�N�5h�\�\�\�\�cn<V�\rz��Wq}9���*\�Uв2��el\�k\�\�Ev�\�*\�zvV���\�;}k��.l���>���2r\�)�-\�\�\�F\�]~���\�ӧ^\�]:\�z�\�V��NA},�6\�\�opת�\�ew\'ә9r��]#+\�@(IƔ�<W,�4l9�R8���D\��\�߸\�\�6�+H�\\�lH�*Z\��y/�\n���ի@\��}\���\�]1\���\�{[E�\rI�\�WT\�Ը���3�>�\�/�QQlWIn��ک稽��.ΡƮ�U�fb�V\�O\�mҟ�Q\��a\�mӒ\�\�\\θLxb=\�+[H�O\�<��\�\Z��pk@~�,2\��d\�\�����2\���\�\�\�\���o�<���\�kfbGl����i&���\�Wȩ\�2D�9�+A;\�w\�\�>қC�\�Ӎc�w�SX�h\��yGe\�FJ�)�\����!\�u(�*\�${B;\�w\�\�>қC�\�Ӎc�w�SX�h\��yGe\�FJ�)�\����!\�u(�*\�$u1\��\0\�>�7�7\��nCP\�\rC�7�\\\��ߵ�_o8�\0���**��\n�\��\�\�u7��\��ߝy}��f��k�\�g%\'��H}�\0p���Q#PUTP\�P@�p��\�w�@}}k���c�\�\��\�N\0Ԋ\0X\�/dc\�}�\�\�{+[�<\�U �[i�\�\�V�H\�2:7X{��<Վ��O�\�-��\�_Z\�c\�q�v;}�YI�\Z�G�\�}��\�c��\0��V>�p&���\0�)@a���\�۸�N\�~���\�+�\�dWհ��*^\�\�UH��\�R�2r}�*\�Y2;)�Wu^\�]Ev�\�&}�\�K\�E��\�\Z\�\�ْ\�?d���O�:y(�KF\�Y\Z9\�u�z\�\�O�n\�;e�k\�WH�G\r�_V\��\0�{��U\"+\�IH>�\�\��\�)dp\�\�\n4Ҷ���j���Ou>\�o%���\"\�\�h�ogl\�e��V\�y\'ҝ<�K%�b,���\���\0�)@)JP\nR�;\���|uor][g\�\�S�{\�6\�\�o�e-\rƳ���k[v2Z��\\/� \���x@}>O��\�K�l��\�s}�ؼ-�\�塸\�w�\rknÆKU`Vk��$�>~o\r�b\����j�\�C�5\�+��\�\ZLb\��\��\���/\�~\�\��}?\�\�Ǐ��\�\�\���\�Ic4�\�V8l&\�+,N\'j�[\�\�ơ#�(\�DU\0�v\�V��?��Tv\�\�W�S����\�\�fb���@Z{�q#p��\�͘��\�*H�S\�\��E=_�Wi-/���GCk�9c�\�e\�e�\�\�V�=�弊RHe��WFRAR �Uo��>��QۗT\��M\�\��1��{\�n�T��\Z.\�F\�m\�c\�=�1\�rT��\��\�)\�JP\nR�\���\�\�Wj>����eo\��\0~c�ֺ*�\�\�PY+\�\0�s\',b�ѱ>̍$oon���\�׸\�N���:lբ�\0�_K%���[\�5\�2\�]\�	�\�NGܫ�WB\�\�ƍ����;�uڏ��}\�\�[��\�ߘ\������e�\�J\��o�>�\�\��\0�lO�#I�u�V\�/�N�{�t\�\�S�\�Z/�9��Xۏ�\�^��-�\�@�Nd\�}ʺ�t,��sM�>H�\�\�\�g�ۍ�\�ċ�\�\�8��us(?�q�\�K\�`O}�6���\"\��|\�/�98\�\�\�\��9�����Z\�\�#I-R�v~�\0E�n�\�\�M�\"tr*s\'�=ض\���\�f�x{�s�6^��\0o����kJ~�ܫ\�;Q\�H�����O\�-x�\0�ƷX?�z��~,��z\Z<a\��\�[\�\�\�_�\0Қ\r\�+�N\���\���\�Xj]\�\�\�.\�;G<�Q\�FyQ��\nC%��>)\�y\�J)\n�IK�\�}�s��\�\�o\��\�\�\�M�5-�]\�s9)<��C\�\0�DU\n�\Z�����*�-�\�+��\�wk\�\�&�[5�\�j��Gk�\�;\�\�,1�\�Ag�f\'\��/�uZH\�~�\�F\��ǻ\�\�ߍ��f��kL\�#��\�8 �9WFR��)(\�\�\�J�\'\�G��)@+\��\�̗6�4oGFᔃ\� ��^*P@�q>�\�w�@�}kuMw\Z\�c�ۃ����\0\�c����/�9O��ec\�pg�ʠD\�k2\\[J\�$l\Z7F\�\��>�}8�Q\�;��.��\�Ǯ\�X\�v�p��\0.�Q\�\�a{#kR\�=�����	��)@)JPg�\��v\�)Ӷ_���t�\�p\��l/\�\n��{\�R\"����\�L��~\n��G�\�j\�W�_Q=����f��\�\�p9�\�C\�k;fK,���k\�>�\�\�X	-Adx\�{z�\�\�_Nݺ�v\��+Ԟ�\\n������\�\�/YI�\�\�\"G�3��!UC;�Df\n\�\�S��\�Dϼ�\�|q\�sKo��E�\�=�ɘ\�Vw�S,\���\08\�\r^�)@)JP\nR��}=�\0O��\�M�,��\�w}�ؼ5���塸\�w1?\rknÆKU`Vk��$�>~o\r�4n�\�{s���@\�6e�\'��X-\�\�\�P�\�h�*����\����Aڳ�֭�釩\�\��gb�W�җ�Oq�.e~Z\�\�G,��Ĵ\�\�\�	2\�<�\�kL\�\�e��Ic5��Զ9�f\�+\�F_t�\�\�[H�\�)�te ��\r\�R��\�\�\�#����\�hms�\�s\\���ylVN\�g����JI��*\�\�H*A+��U��O\�\�\�=�uM\�T�,\�o����\�\�\�|\�\�W7o;Y\�وXn����>~4T\��5v�\���\0J\�6�\�v9�.^\�[<�+%j�\�\�[ȅ$�X\�te$ �V\�S\�\�\�]�uU\�T�-ao���\�\�\�KOq�\�$n\�v<�\�3�\�7%IH|�`\"���\0�)@l\�k\�\�Ev�\�*\�zvV���\�;}k��.l���>���2r\�)�-\�\�\�F��\�/�N�{�t\�\�S�\�Z/�9��Xۂ�{��U[+��>�\�\���u*\�YX\�\'��k����o��-`l0�;�k�o-�����1��ǩ3�\�(\r#H��\�/���{r�\�鯦\�$,18��rY+��{��e[۹@�\���E\n�T�<������\�#\�P\�\��?P\�g�7�\��\0�[�\�+A~��\�\�v\�\�6$��\0hjL�^G/�\�k���\�s�*Kpk�go�o�\��l�+�필�/\��n�\�[�\�\�7O/��\�[�\0梛\�P\�x�1n6\�Kp^\\6�L�R߹դH\�<�d?̚��<�����$�D���i*�\�x\�\'ȫ\�rT�9�\�\�\�h��m	Ժqlt\��i�]�^\�c�\�ߕ�٘�\�\�\�i#�)[BP\�}�#wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�Hd\��9WFR��)(\�\�\�J�\'\�\��\Z\�v��:�N-��\�m5bˣ��\�\�\�c�\��\�3\���غ��$rT\�}�#wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�Hd\��9WFR��)(\�\�\�J�$��)@+\�\�ֳ�ʹ���h\�Fᕁ\�G�\�T�,��\�}Gpo�8>�:�\�\���#�\�\��\�O\�\�E\0,v�1��ㅎS�#\�X�\�\��\�ֳ�ʹ���h\�Fᔃ\� ��V=�p���7�\�\�\'_:\�cב�v[}�99�]J��\��F��\���G��\�3�7U�z\�믧n\�];e��\�OX.7�_J\�\�\�\�\�s��\�ei#ՙ�O����ʢ3]�u�\�۫�l�R�I\�\�\�q\�\�XX[��\�b�����\"$z�?�\�rT3�TFaP�\�\�z�\��\�L�ɼ�͎�c�K}�,\�Y\�L���<z����g 4�\0Q#�\0wT\�\�Wv�g\�M\�lv\�[\�}gr\�e��f\�y\�՝�T\�9�`\0\n�i�ԥ\0�)@)JP\nR��;\�����wm�[g\�Sً\�\�\�毿e/\�\�F\\Hܵպ�Y\�Y�i�\�\�e�y��\�cJ�\�3Yi=\�\�X\�}�u-�g�����\�\�,���\�(x\�D%]H!�\��]�UG\�����wm�[g\�Sً\�\�\�毿e/\�\�F\\Hܵպ�Y\�Y�i�\�\�e�y��֘њ\�I\�6�\�k\��ls8<͔W���.\�g����C\�,R!*\�\�A\Z��)@+�\�\�GK\��+�\�\�\�M\�\�0��)l򸬝�\�oyo\"��)cpUє�T�<WiJ�P�\�۪{qj�ީzZ\�_f631}\�Ͳ�Oq�\�%n\�v<�\�3�\�7%IH|�h���j�#��J\�6�\�v9�.^\�[<�\'\'j�\�\�[ȥ$�X\�te$ �	VϨK\�\�\�=��U\�T\�,\�o���\�\�\��\�E\�H\�-�\�yg�f!a�nJ�\"���<�EUl\�k\�Ew[\�*\�evZ�\�alw\Z\�Z\�[3Yi�&b=G\�Rg\�P\ZF\�Qd�8\�c\�è�\�E[\�\�\�-��\�Z\�[\�vk-?d\�G��q\�L�0�\0CH���,�%��\n\�3�Nܝ;bzk\�IM���,��V�\�޲�-\�ܠRg�`��Q���tӧnN��=5�٤��&�}\\�J\�+^\�oY@��\�P�3���TP��QUFi�(�9?j���\'4�\�\��k\'%��~9�\�\��_����%b8 \�A}X�%�\�\�\�G/\�\�g�9i�\��*O�\0X\�#Z�\��U\�\�ğh��՘����Dr�nk��M��\�L8N�7/i��\n\��%k��	\�\�\�\\����\���\0�N��	�W^\�[\�\�ܗl5M\�\�Ee�\�`d\0n�|�l�G��H_����\�|\�x0�BKlF筪�㬘\��\�\�~9uB\'\�3Z\�暗\�\�)J���\�\�\�h��m	Ժqlt\��i�]�^\�c�\�ߕ�٘�\�\�\�i#�)@P\�}�#wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�Hd\��9WFR��)(\�\�\�J�\'\�\��\Z\�v��:�N-��\�m5bˣ��\�\�\�c�\��\�3\���غ��$rT\�}�#wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�Hd\��9WFR��)(\�\�\�J�$��)@+\�o<ֳ-ʹ���h\�V!��\�G��(\�է_}`u\�4����\�5��D\�c\�i�\�ʼ[@����\�\�\'���\�,�\�\�\�8\�t�\0�)@)J�\�\�\��ս\�um�S�Na\�\�����\\�7\Z\�\�6\�m\�p\�j�\n\�p�\�g\�\�\�\�\�9�\�\�\�\�\�}�\�!�\�{-h�\�\�e1\�\�5%\��6^�2�?�����SޣE�=ջUu\����oy,NG�in4>���d�\�\�+伓\�N�J%��ѱG�G�.�њOnt�3@\�5c�\�al��\�\�qv����j8��\0TEP\0P8\0V/뻡>���t\�鯩]\"�6E}[��\��T��m% �S\'\'߂���\�#��(\�J\�꽪��\�=\�L�9��?\�8�Kq�5���%�~\�X%\�Jt�Q,��� �4r>�P\nR���?\�)�=��v?��r�ڃa���\�@��\�J��\��ۖ%��>M$c\��I����v�\0_\�\�\���\�\�MY�\�\�\���W\�\\\�*\�g����CG,r)!����\�y��\0}@:ߵ���\��<�C=��쇕ͪ��\�H\\\�ܽ��K@\�KMl��\�,c\��Y�S�ہ�7_C\�w/m5f?=��\������U\�\�m{m\"��X\�RC+)@wT�(uz�Hi]�\�\�-\r��ݎc���\�-�\�ڬ����)I\"�7]IH �k����>蟦>���lJ;Qc��\�\�O}=����\�\�Jܴ�M+4�0(�ؕDD*�2\�)@)JPr�\0�Tv宦\�wJm��\�\��\�q\�*+�\�\\]\\\�]H�N�aS\�q2CI!�\�\�\�U;�o�u\�uw:;�V\�MW>?\"?*��@Y\�\��$\n�\0\�5œ�v\�{�\�Y{�>Z]]�]U�\�z�Rsa�9M?��\�\�/^\��\�\�;�I\�<4R�F�`��n������p\�[馥Ck��\��\0�7>�\�/�\0��\�}��U���\��\\z�:ߧ�SҦ!\�y���\0�\�\�\�98\�\�\�ȣ\�\�p�3����XF�\�պ\�\�\�\�?�l{D\�\�W\��n��n�\�;\�v�%ȕjS��\�*\�8�R���}�\Z\�v��:�N-��\�m5bˣ��\�\�\�c�\��\�3\���غ��$ro\�(\n\Zo\�\�n\�L���\�}�\�W\�kVi�\�\�\�1�\��\�G*\�\�U\�E%YIV�u[���c��\�ͳ��tŽ��ލ/�q�ug�r�N1�\�{���>\�\�;^U��J�\�&\�n�O[��\�=\�\�\�\r5��\�A\�xL�>Z̿c�e �WRUՕ��`H/JR�R���J/\�\�\�Rw1װ�!Ԗ#�ح?{�a\��\��7ᬭ\�\�l�=\����2$�h@�~��\�Ww$ն}Ou;��\�lV\Z��Qr\�\�k;�ۆ��a\�%��+5\���Q�?7�\�\Z7Fi=�\�X\��tՎ	���\��\�ڬ�v�H\�4Q@@\�M�4�\�\�,f�\�:j\�\r�\�YEe�\�\�-V{;x\�$qG\Z\0���\0�\0\0�ڀR��0\�]\�	�\�\�S�l�M}J\�\�\�+\�\�_�/p���E{i)ҙ9>�e,��\�+��j���Ou>\�o%�\�\�r-,�#[\�\�2Yg앇\�^I��O%�Ih؂#G#\�n�Oq���N\�_�\�Q�]fY\�C�a��#6����\�M7$1��72~[w�|�c�\ny��Fe Q\��\�å�&�\�}K�6�p�Wi�^v\�\��S%�\�\�\�+,W^���Q��{���f�R��\'?O\�\��;ak�~�:�\�\�3\��\�y]Z���:B\�F�\�\�k\�Zc\�5������S\�f�jP\�\�\��\����;��z�\�=��\����ٜU\�\�m{m\"�Icu$2��A\�\�l>�~��\�\�u?Dz3C\�5\�\�\\[͒\�\\\��A\���n\��\0(I\�\rh=\�vic\0�\�\�@)JP\nR������\�ҿG����ױ�.M\�I�2io]};h�\0\�;Ŀ檝\�,�\��M+;�\�ǒI�$�\�k~���\�	�4?G\�{%\�>v����8\�ᅤ\�n�>\�$\�#�\0޵\n9�\�V$թ\nlby�\��\�8um�fK���N\�_Ku\'�\�pO�l\�hβS����\�\�\�\Zo*\��]��K�@f?�R�S�>kYO�S�\�5����\r��Z��m�\�M~�Oo�3l�V��ޅ\�,\�\�㼶�<r�h\�O ���0 �h�\��\��\0���(\�\�=Y�\Z�mLX<��^e�\�W��\���\��e�\�		����>\�JZ�US�V\�rf~h\�\��X~�5��2|nV�\�)\�)J���JR�Tx�\�\�C�\�\�v��oc\�\�\�\�X�M1�\�Os�,1�\�G-$�r�ZbG(΍!Ԡ(W�{7�==n�we7�Cd4֪\�Y�\�\�2��Mk2��ٔ�]IWVVRU�?/V\�\�؇k��\�sn\�Ǐ\�[ݦ�\�cSȞ\�!^XcoʎZ\"I�\�\�,ĎQ�\Z�;ǳ{�\�\�\�\�vSz�6CMj�5�{,\�)�ֳ/\���H!�ԕuee%X\�ҕ\'?O�\���;�k�~�z�\�\�p;�\�qst���\���汳b�)3\\�\��\��<�O\�\�����k�~���\�\�0;��\�\�\�<��\��1�\rcf�\�`Vg�_\���3\�y46�\���\�;Q�1[k��O�\��|V8l6*\�`����B\�q�UT\0\0�\�\���ڍ�\�M�\�x���\�\�\�a�V����j8��@\n��\0wT��\0�+�\���Km��\�\�s�\�p�\\=���\\�J\�`����K\�,�9\n��	,H\0@5v�\��KduƹԖ8|.\"\�[̮W%t�[\�\�ƥ\�Y�DU�$\05V�\0�O\�\�=\�uE\�K=,f\�p���\�\�\�CAq�.#~V\�u<2Y�\0\�[��\�<�>�_�OT�\Z\�7�,����\�\�f\"�����\�Z\\Fܭ\�\�xd�V��n%�yx$1Q@)JP\nR��;�Ol��;��g����=���ί\�׶\�\�\Zv��y�\�\�ۆ\�iXp8UwGl�\�=FwM\�6\�a6�{;�_��m٬4\�n�Ǜ�#�Ұ\�p�\��\�\�\�˧>\�8\�:q\�\�L�\�߉�ۥV�\�_�K˩\0N\�pp��T@@��;yt\�\�C�gN=8i�\�\�[�>w;t�\��\��Iyu \�ێ�5\n����JJR�R��?*y�|W��\�\���\"\�5��K{[H\Z[�\�p�\Z($�\�\0\0�O�t��\����\�n�:?m�\�Q�\���\'\�\��j\�\��ed�ߎD\�G�W�����Ε\�\r\��T\�+\�\�7H\�NI�z&jC/s.�nz\�\�CX\�7>[��\�\�I\����\�	\�������\�\�0�G�W? �T\�D精һk�3��\�k��Z���2lmF�D8�)X\r��ݭ�\�\�v�\0\�\���qq&�\��ָ\�yo\�c\�a\�\"�\�HX,�\��)\�\�h�#�p\Z\�K\����\�A�\�Y\�ua{k(x�!�C��\�ٕ����\�=�<T\�}7}\�l�zn.�7�<W+�Ygۻ\��\0\�Z\0^KO��_�\��\�䣁�\�k�D�\0\�ʺ�\�\�é\�Z}�.��K�3{)kw;��\�D�Ҁ�9\�\Z�N@�()JQ\�\�w�\�wa\�\�\�=�����Mc\�4Ƨ�<!\�B��\�ߕ�D�\�\��hY��:4�R��f/�k�����\�e�\�\�|�\�\�\�\�	,56;#[_\�K��\�Z0����.Е*�aff/�6�o�>\�h|N\�m��\�\�t��\r��Xm���P�\�\Z(UT\0\0�\���\0�+�\���K\���\�k�q�\�p�\\E���l�N\�`����K\�,�9\n��	,H\0h�պW@il��\�\Z�\��\�\�Ky�\�\�\�{;xԼ�K#�����b@\0Ul��>�=S\�kU^��\�\�n�\0���\�.�\�4\Z\�\�6\�n\'S\�%��\r\r�pX�,�\��!\�\����Oq�U{\�\�K9�\�>\�b/���_(.5�\�m\�\�N��K5`\Zv\�Y��C4��\0�)@+c�d�\�\�?�oQv{��cogK�[�\�m\�\�i\�\�4�ǜ�\�G!�a�\�C�{ݬ{Xu\�o��}�\�ka��1\�k]kyl\�e�왈��=I��@iuE�D��A}t\�ۓ�\\OM}6i!a�ǏW%��\n׹�\�P%���\�L�#\�* TUP�\�ӷ�N}�:q\�t\�ӆ��=��\�s�J���*��R\0<��\�(\�cP��*�Yڔ��()JO�WB�\��\n�\�m\�қQ�3��3pc�\�<l\�\�K��\�-\��\�\��U\'�UY��u��:�\�P\�\�vI\�\�I\'ദ.f�\0���ь�Hܴ��#ԕ��\�	����\�g�\���ڃՎ��7�\�O\�Yxxq���\�Yx�+\ZsϨ��j��E\�\�\��X\�\�n\���\0ch\0���oլ\�I(\�v��\��\0oNg�8�)P�)J��+�\�:�R\�MS�\��79s�\�a\�b�\�\�,\�)-�\�n$F�ʺ\�p<�� �O��\�s�m0\�U:)S6�d����h>\�k��N\�\���6\�z�M�Vz\��\�\�\'\�\�%��f\n\�?\�`\�\���;q����R>���\��7��;%�6�<{�]\�\�I�\�ڱK[�y\��\�HVRT�4t׎\�w\0\�k\r\�\���\r\��o�03\�\r\�&�(/�|�~U�Ԃ8�ΰ^[p�\�ȿ�\�4\��8?Kz2��\�5��nt�.��b�\�^\�Ӟv��)RB��()JJR�R�\�\�\�_���\�k�s�,p�\\=���\\�N\�`����K\�,�9\n��	,H\0h�\�\�[o��K\\\�Ic�\�\�\�e�\�erwK���j^I��\�TEPIb@\0Ul����=U\�sT\���\�\�j���{\�.��h.5�\�m\�\�Χ�KE`\Zv\�Y��B����-S\�sU^��\�\�j��x{\�.��h.5�\�m\�\�Χ�KE`\Zv\�Y��CT��\0�)@+g{X��\�+�\�QV�+�\�\�`c�ֺ\��ٚ\�O\�3\�?z�?\"�\�0>\�$�\�c\�è�\�}E[\�\�X-��\�Z\�[\�fk-?d\�G��q\�L�0�\0CH���,�%��\n\�3�Nܝ;bzk\�IM���,��V�\�޲�-\�ܠRg�`��Q���tӧnN��=5�٤��&�}\\�J\�+^\�oY@��\�P�3���TP��QUFi�()JJR�R��?���y��*\�G\��\��`_\r�2PO�Z�\�[m)`xsd�q%��}�\"\����W��\�\�\�\�6��f\�\�\�~��/�W�\�����p�[\�B��א\�K��{32#Vo����o��\�\�\��\�6\�g3���6p�};h�\�Ā���I,\�\�3�6�%�5�E�N?b\�\��g\�\�\�+[�$k���~\�\�\��\�\��Z�5y�5V\��\0#���\����V�[���<�\�Iff$�}\�$ק\\�I���\�\�Ud�W.jwTQ\�i$MH��+\�R���(}�x\�\�Y��.�7��\��\�\��\�߬\�N��\�\�r0�\�چ\�\� �\�ܤ�y#�\�\�S���\�\�e�y)\�I#\\�\ru\�\�Cy�}c�2T]\�ZӠ�\���\�9�uH�\�z\�E���91J����\�\� ��\�rG�T���w��\�\�\�͆\�O�\�Z0K�Y9k\\�� ��\�`�$M���*@e*ʬ,C\�O�N�\�4\�xLm\�i�il��\�y+�2�\�\��������\�j��k2\��\�ĎE\�ח\�\�&h�烪WFՒ�W<��;�\��|M�� �A�H\�`R���(j?z�\�\Z\�\�B�ޚ�\�zr:;9���x��\���\0\�;��,�\�\�7#�ND�O��n)@P\�}�wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�HdA��)WI�tee%X�\�p�]�v��VНK�\�L\�6��e\�\�\�\���1\�m�PY홉�~�\�]AV�9*a����2n\�{a�\�A\�i�Y�o\�\�3�\�\�\�$2pA��)WI�tee%X\�R�����{Xu\�o��}�\�ka��1\�k]kyl\�e�왈��=I��@iuE�Dv�\�a\�Wu����We�\r��\�q�u�\�5���f#\�~8�&~E\0!�`}\�I\�\�tӧnN��=5�٤��&�}\\�J\�+^\�oY@��\�P�3���TP��QU@��\�ӷ\'N؞��l\�B\�`��K%p�s7��K{w(ԙ�G\�*(T@���4Ҕ��\0�)�\�JWʣɏ��\0x\�\��\0Z\�~\�\�Ƕ+�n\�>�\�\�\�fo�\�\�:R\�ey[�>|\"RAyH�@G\�3*62\�ރ`�}\�.tV\�\rY�7�\����\�\�̰\�f��y�#�!\��\��\�^��:�\�~�wo#��\�\�\�2/�f\�a��R\��\"�9<(��Ėfc�_ⷵc�{Ry\'>�\�\�ю�n�v\�W�c�M|�\�\��W�\��\�\�;{:\�\�\�\�\�\�\�Ж\�a\�b�V\�\�\�j	)o\n�xQ\�%�,\�KI�K\��\�){��Ia\�?Z\�4���.j�p[m�V�&RR1$D؈��+\��()JJR�R��9 �\��\�Kj�O��%��\�z���\�\\%\�;\'��hg��O*�\��������~_�r���\�ֹX\�\�T\�<TıJ\�V��E֊M\'l�����پ\�3�\"��X\�%���5����1\�/\�\�\Z�\�<�\���\r%���\�i\�MY�u�[\�c�\�\�$\�\�U\�Еu#\�H5N�G\��\�\�[пs\��\�$�\�\�nךr[�S#�3L\�\�y�\�T\�$?��$�\�\���ڱT�\"GW�8\�\�\�\�}�*j\�>���Ǯ��~U�Ww-��P���4\'�\�Ҵ��\0�?�ު�\0	�w/.v\�V\�?�uE\��\ny\�\�m\�@Q�x\nk|lo\��P�݅\�K�d�6\�~?z�\�USճ��\�\�r�\��y\��KOp�ѹ?�j^K�z)\��\0:S�\�ҽ&�R���}�\Z\�v��:�N-��\�m5bˣ��\�\�\�c�\��\�3\���غ��$ro\�(\n\Zo\�\�n\�L���\�}�\�W\�kVi�\�\�\�1�\��\�G*\�\�U\�E%YIV\�\�\�=�z�\�\�U�\�쭁�\�X\�5����f�\��L\�z�\��\�\��4���\�\"YӼ�b��;�\�\�nZ�\0-�\�\�	�,&\�ZcD\��^�2Y]\�?\�>X4RT����\�_A�:v\�\�\�\�_M�HXbq\�\�\�WZ�3z\���r�=I�\�}���D\n��\0t\�gN��:v\��\�\�f���rY+��{��e[۹@�\�\�>�QB�EU����()�\�\��\0ƀ\��}�<W\���5\�\�2\�\�%����V\��yg�@��%�>�\�ɨ�\�{\�)\�릏\�i��m\�\�P� �O\�*\�`�\�\�\�\��K\�>5娫��gjg#P\�\�p\�\�T�\�#��jNk�:��\Z�p�6\�i[\�s����\�\�3_\���y�Q��P�\��\�F�-��\�nߒ̾��\rǼ��\�~��A\�\'\�בG<��;z\�\�;\�o^��\�w\�p%8��2\���+\�e�\�a�>��H�d.�\�y\�0?>\�qP{�)�l\�\�\�;ח�0�譮em�RIZF�+W�\�\�|��\�o9�Թ��I��7Y��\�\�^\�\�\�4\�\\J\�\�#�,\�ĒX�I>�\�y\�W\�%���s��\\\�\�(��\�8\�$M���+\�R���()JJR�R���()J\0~~8��\�\�\\�}�ݙo��x\�=N�{�Q�\0h\�\�|�!x�\'ߚֲy�&�䷱��UTR����\�j.\�+E��`���5w9\�BrzX��6+W�Ֆ\�etu\�x��\���<{�\�\�\�\�Uf?�H�\���\��Sxd\�\�V�i�L�i \�\�#y\�\�sır$��\0\�uS�UH\��簿�\�\�Œ\�_Mms�\�	J<l>X{����R\�\�ȲI��O(�G\�\�+ܲZ\�t]\��7�u��r�9�\�6V�W\���*�\�۸\�O�:�mG{g����\\�%���bF�De\�\�\�m�\�}T]\\\�V8wSa�N�DP�\�\�dԗiן\�~� �[%O�6�,�\n�\�\��\0�\���\�L\�(\��~\��Ƿ�\0�\�$TKm\�\�s��(P\�\�Kz�\�?\��N\�\"�\09��#�VX\�}M]��`\�ָ\�~��q�\0�;\�ɗ�\\��T�!z2ǔN\�J	:&i♒ Ho�\�\�\�Z1���;X^�7�璲\'\�O�2��\0��j�\�~�\�\�6M��\�\�x��3(��\0\�Z\��J�,�\�|P\��H\�\���3�푽\\�9�\'�o�\05�����1�+��\\|=7\�\���Y�&\��W�)`�6��]W�q��Qe\���\0?G�5���Ti�T�6T�1Ǖ�\�:	:�I\�\�<�\��\0\�_�f�$�\�@�\0��P-�\�T\�X��%�kvGC\�ȥRL�\\\�f��V\nr?T#��I\��\�\���i\"\�.��<V����WC�\�-��\�_��_�5��\�cO�7/,�Iͧ\��W=�Y{\�5�O�d��z\�\�7��D�}�ߝ7�}8�\�\��\"�\�a��;t�S�\"1�\�\�\�ڝ4n4�H�3�\�\�*Y#\�\Z�͍�?i\�����\rB=\�\���R^^\�I<ҹye�\�3�<�I�$�\0\Z�r\0���ŵ�j��\���=�0ݽRK���ɻ\�o�k^�lX]\�z\�\�yl��wn\�\�S�\����Щ&~�i�Fb+^��\�\�$����*3=L�/\�J\�r����\�i�Ӥ�6&\�\'�8�)XM��)@)JP\nR����\�','2020-03-20','nonTraite'),(4,60,_binary '�\��\�\0JFIF\0\0H\0H\0\0�\�\0C\0			\n\n\n\n\n\n	\n\n\n�\�\0C\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n��\000\"\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0H\0\n\0\0	!1\nA\"a#2Qq�4��$BR%3Sbr���\�D���c�����\�\0\0\0\0\0\0\0\0\0\0\0	�\�\0;\0\0\0\0\0\0!1AQq�a���\"2r\�#BR�\��Sb5���\�\0\0\0?\0��R�E�����\0�)@)JP\nR�>\�م<J��\\��kd�:\�7\�\\�\�m4�:z~<5n�f�\�8�\0�7e/p>A0��\�\�g����f&���\�]���2\�_3cjor����W�\�\��\0-{7e5\�\�\�{x˼�~T{��\n�N�>���\�\�\�?Ֆ\�e5�\��\�`�*q\�\0�\� -<��2�\'��\�n�:_\��=�\�\�7��T	$�\�\\k<�{s,�%?��֤\�xJ�T\�L\�bx�E\�/h�;@��\'N\�޿|���[]�\�\�g�6�m\r\�ƣ�����㩡\\T!�\��f6�TV\�\�\�m�\��+�\\g�s\��h�>�d\�As��?B`^��\��QġQ��_�\��[�|)m�?S7/<�\n�\�\��\�ܩM؅�������ۏ�a�С\�Ω5~]\�cOc-q\�\�\�ar@���0\�L�m�b�\�ֹ>�J���$J�\0?_�+�=�&���ڣMQ\'��\�n<�vrW\�\�rOD4_�\�������\�\�\�\�yE\��\0%\�\�_�G���e�+~\Z\�(\�\�jޑ�\��>G���\�h2\�\�7�\rw\�|]\�;��?�H\�\��2}��j\�\�\�|g?�l�/����c��K�J\�\��hz�\�X�#��\0x��\�?���nj[�<{\Zx\�\Z��-�D\�z*M\'c\�\'v�������QH\�累�]8�\\mn�\�}GjJǒ[�t\�q�U	2rW��I\��\�\�\��{i$\�.�u<��r[!��FV\0���kC\'����^*\�C˟z�\�R�YP0?�k[>�ȟm^y���O�6�z%R2f��%�O�M��k�+�,\�-d�h���J�Y{A�\n����m�z\�;�LD�}�\�m9�C\�cK\�\�r��G\�\��b?�:������M�Ԇ\�P􉼹\r1r�O�\�\�o���\"N8�%�_\�5�\�U�\�Q\�\���}�0\��R;�N�˿\�o�kO�$r=��_���\��\�Z�\�-\��m\r\�\���SU\�I�\�?�\0����\�\��5�^\�\�fzi\�ؕ�\�\�/;U\�\�{�I\�&l�]\�T_�)JVj)JP\nR���\0�)@)JP\nR���<{��x<�C�o�s\�\�\�\�m)��ƥ�\�\�3O\�\���+��\�c1��<�2�\�c�4���\0W\�j�ri�i���d�Q\Z�\�WR!\��8���\�_�V}�uC��!�4\�W�KY\�Q�\�\�q�ʯ�3\�?\�\�A#\��!#�����6\�\�y{�[�7\"\�\'�۫K�m��\��\�y����6�8f��\\4��ҺNZi�,�8\�|�?j�\�J8TD@`\0\0T\�ׅ�*$�Z����j\�\�}��s\��$�MK\"�����{9�7\��\0\�\�\�wJ��\�����\0\�v��+����Se�\��&5�\0�)�ԎC�\�+,}�6���HbE\n�\Z�\0\0q�+\�*O��\��}�֧TԴԌ\�D\�jw�y\��AT�	�#��\�NI�:!��aJ:W�\�\nR���\�\�\'h�Jm�oN5��\�mMb\�{\�\��g�+�2[+✇�Ԣ��$��\�w�\�\�\�h��\�\�\�#ֻ��1˄\��L��\�\�\�\�K۹B�\�\�\�:\�ʖ�A�\�`�\�ӧ^\�]:\�z�\�V��NA},�6\�\�\�UA�\�\� O�2r>\�]J�FV4�ߍ�\�Χ7w=��/�.�Է\�w�\�\�d�i�\0T*$j\"*���\0͝�;�uڏ��}\�\�[��\�ߘ\������e�\�J\��o�>�\�\��\0�lO�#I�u�V\�/�N�{�t\�\�S�\�Z/�9��Xۏ�\�^��-�\�@�Nd\�}ʺ�t,��sM\0�)@\�\�P�=\�)@zYLN37e&;)aͼ\�RXf@\�\�GH>\�\�Q�\0\�ӯ\�\�R\�w��Z\�\�v��3�����6y?�[\"UT|�\�b�<�*�\�\��?\�\\�y��-M%5[;2��\�ˈ�Xv�*-Ӻ7\'Լ\�b�B�}lv\�균}Tp\�\�$�nX�[��|}\�7��܀O� G�\'ďz�~^_��v�\�\�\r�zV�Cn6�\�f��7�ܥ�O�x\�a�P�\��麋a}�]�\"��\"\�\�6\��\�ϕ�&\�i�#\�ё�<�,f\ru\�\�%/\�\�ӗ���(�Ne�9RH�*�����r!ι௿5\�f�y�5��\�Z�u�\�X\\=�\�\�C5��J�r#�\�\�AH\�^�\�C\�\�j\�IG,SƒF��\�T8�)_���\0�)@)JP\nR�?�h�ɮHR=��ɬ\�ЗB;\�\�{`\�\r�ǈ`�V}C���ck��-��\��\�>\�\"\�\��˖e��#�3U؆�\�t��P���\�\�ؙ��\�>{������=\�\�\�\�\�7\�\�/{��9K\\u� =\�̀N%\�\�X���T؋��gޞ;xi��X\�DԺ�\�\�&[Zd�J9�d\��\Z~T\�\�\�\�\��t���6�\r�\�\�k��I�\����-p�\��\�����	\0{�s��>\�ެ�5�{�\'jO$\��8oI�\\�c\n�RQ9c�MYlW����x��\0��*HS��\0�)@)J\�N�]�v���\��\0v�\�X\�]\�\�\�.\�;G�\�Q\�FyQ��\nC%��>)\�y\�J)\n�I�]�v���\��\0v�\�X\�]\�\�\�.\�;G�\�Q\�FyQ��\nC%��>)\�y\�J)\n�IK�\�}�s��\�\�o\��\�\�\�M�5-�]\�s9)<��C\�\0�DU\n�\Z�����*�\���\�\�\�\�\�~u\���՚����9���RM!�\0¢*�D�@DEUP@@)JP;\�úwQ]����ޝ��k�-��\�Z\�ˆ[-Ad�O��\�̜��pF\��24����\�ӧ^\�]:\�z�\�V��NA},�6\�\�opת�\�ew\'ә9r��]#+\Z6V\���\�ԇjΣ\�7�cn\�\�b2rEk��5\�\�,��oh�\0}9\�ɌS�-1�dw���\�+\��kqd\���\�;�6�\�i�\�x+\\�\�\�Mf-�8\�4K\'\�\�b�s\'��/\'�����()J\\2��\�k�P\ZQ\�����\�]k\\5�\ZOr`�\��쭇eG\r\�c�^?`\�\'ĕ\Z�=J�ͽ=#n\�Kd�\�Fφ\�c���Cw	$%\�|K�xa�H��\�|�\�\�n�\�%����;,�6J�i�Wi\n��U�*O�M��\0~\�*�\�oX~\Z���\'fO%\�\�\�]�1\��\�\�\�*�,�������\�SÁU\�\�>ƃ�=�\0���\�\�\�{z\�\�ݒ\�\� �\�\�b��\�\�\�+jI	q�9S�O�\n��Jı㊭f�Jy9%M�w�\�Ew�e]#\��3EMh��R��g�R���\�\�P�O\��ހ0�\�t��\�\��T\�F��\�\����\��x\�8\�\�sq#��4Q�\�\��\�\�Z�vM\�`�x��t��MD\�Uv\"!�}$���}io~\'a�S\�y<��\�\�\��\�کK��\0�D��ՉUPY�4�\�v\�v�\�|~\�\�u��常\�9�\�\�+xT�B>\�S�@QϹ8\�\'m-1\�çXp�k{k\�{�\�;\�i��\�o\�k|�0�e�1w\�y����\0#�V��6\���?Q\�I\�\�p����Q�nKGH\�JH\�V_�S�/w\�~\�O�T��E)JJR�R����\�\�iM��\�\�ƱԻͩ�]�v�y�����%~�Ke`|S��Rd�0�\�\�iM��\�\�ƱԻͩ�]�v�y�����%~�Ke`|S��Rd�:�\��\�\�S{��ߍ�חڛVj[\�\�\�rRyI4�\�\0\n��5U@U\07\�}�s��\�\�o\��\�\�\�M�5-�]\�s9)<��C\�\0�DU\n�\Z�����*�>:�R���y`�k��\�\�&�IX\�E嘓�\0�@ �k�\�\�\�&�I*F�\�bO\0\0>MX\�\�\��p\�\�8p}~u��\�\�;\�\�\��6����6�\�\rG�?�0��>�O�\r��\�\�_�!d\�r,w\�}�\�HA]6��G{|\�f�#�٘z\�&�R���()JJR�R��5۸�n��\�%�W;a� KՊ�Ɣ\�\�ۆ�\�]�\�0��$\\�\�����f��\�v�Eތ\�\�on�lns?�-\r\�\'�N\� z�8�p\�!YYE����ڴ��l7p=��5�1�A�ZJ\�[�)\��x\�K	X�xK\�\�$�	�!K��\�쭸E\�bO\�O4\�ρv\�I\�\��h+]�$���*\�N\�)ԭY$�Ms��\�׷�\�\�t\�f�M\�<UŎCu%���\�-��F\�^7F\0�+>\��+\�s\�U��Z�)\�0\��\\\�u��R��\�)JP�\�M_\�y\�\���\��\�/,�I%�n\�\��\0hAI/�>�r�x\�>\�D�\"Q\�]��\��\�\��b\�x�\�<���\�\�\���\�yF���f+}�r��V�\�z_��͆�\���,1ػ8�l,�\"	ơ4Q쪪\0\0|S<-jl�Z�R|���9�O��\�Tɇ蟓ޙȩ���\�w3�\0��\0|\nR��)JJR�R�=��\�\�wi\�m�\�\�1��{�.=�L\�\�<-ʌ��S\�\�>�\\����\�+��\��\�]�6����\�\�Ro6��v\�\�=\��\�3ʌ��R-Ձ�NC\�\�QHU�H\�_��ﻝM\�\�{~7\�^_jmY�o�\�3�\�I\�$\�`\0*\"�TH\�DUUT\�\�]\�\�N��C7�[ٮ�:�Uj;��\�f��\�2��?�TQ@TP@P\0�ZJR�R�巂k��\�\�&�I,q��\�\��\0\�\�x&��-�\�g�Fh��x\0�y�}8�N[����Bɮ\�X\��o���mH\r�\�m�}�\�\�\��3~ہ\�\��p\�\�0}~u�My\"\�}��}����Ԁ\�\�\�\�\�\��ᣈ�\0��f��	���()JJ������\�\�W�,�R]Hj�\�c\�y���ek�\��Rc����\�#pI\'�E\�UU�VJ\�\�s\�5\'q�הz�\���rl�࿰�O/��\�\�\������}_~`A@[~��{y�\�Ϲ�NXΣ�q\�߈��\�\�\�_\�o%�\�`�^A9Y��*�\�v��()J\\2�\'\�\\Ҁ����-�\0�p-���i=\�V��ai\�\�$9 �-\��|���\�\�c\'��\\7r6�I\�\��Ò\�g1\�X\�\�.W�緕\nH��b*�\�ź+\�]�U�v:�͋�O\�\�L�\��?+7�\' \0]xh����\��5\�)���|.\�ܿ\�\�m\�\�Q-���\�\Zg\Z���\0m�\�`�P�}\�*t�\�p�q\���<V\�v�\�\�u�\��ڼՊϦ�Ns��r�al\�L\'��V��RG\�g���S�&\�r\�i\�\�zk\r�{�\�cj�zn\�M\��\�	\�;��\ry��\�\�WnI�9��c\�X-Y?\�\�\��17�T��\� ?��x?Ҽ��X\�\�il�#�Ɗ8\0\n�r<��󫖖�:Zv\�͍L�\�+�\��\0x�\�P��G+���tL��R��A��()Q\�\�{��\�v�\�\�\�ͽ��7�R\�\��ƙ��\�\�\�ܨ\�_�<�@�\�\�\�i�H\"���\������\�6\�m\��K�ڗϦ4̏\�\�FJ�)\�bN.CL\�@\�\�js��ɺ=B\�w{7�\\\�5.�ԙ�\�\��y\�u3}\�\�T\0Q@TUUP@\r\�\�M\�\�ts�ٽz\�!�uV�\�=\�o7��\�k��\�~ʠ\0�������\0�zJR�R�巷�\�d�����Fh��1<\0\0�4\�	��[kh�I$`�ƪK3�\0�V<�q>�Hv\�\�\�_:!dג,w�}�\�H]4����6��#��#�ٛ�\�N\'Ӊ�[\���\�\�D,��E��o��\'\0+���\�\�\�F\�7\�٣��\0��f��	���()JX7�/pN��kt\�\�G�M�\\}�0a�֥Z�;~\�LvV��<\�n	$𨡝ʢ�pN\��9v\�\�\�)ԏR:��\�N`\�\�\n��v��1\�ZFH�$�¢�weEf\�}\��\0�\�\�}F]o��\��\0	��[h\�ep\�a��K!�<\�n���Ұʋh��s��{�uu�\�\��.>\�Im�tm�\�5���-Ȇ x�V�rJ�{*,q��Ҕ\�v\�\�o\�ok�m7\�a2���ǅ��\���\�j\0ܘ&�^X\�0�c\�\�Y\�\��\�ӸgN�\�:r\�uӆ��E��gpwl���\n�wQ�|y0\�dR���Ty��\�\�ߨ\�\�=F\�o\�\�e�{;�}_�/\'e�\�6�0L>.���`DǑʳ��v\�V	\�\�\�3�N\�9c:�\�S~\"\�\��3�+�U��߅K;��>��r�)WBU��\�@)JP\nR�G\�Q�Dg�ޏ\�}4v$M����\�)�9y�l^\��UT�\�\�@�{�H�����S5�\�\�E\�+i��P�WL��Da\�+\�A�\ryk)�YL���\�n�\�\�^\�@�nE\�Ӫf�8=\�\�\��Y���H�]u��v&y\r\�\�\�I\��1�\�\�������\��G<��\� }<\�\�Z���[�=\�\�\rt�dj9:�`�#�\�S���t�t?O\Z��\��?\��\\e���\�\�fYK��yܴ\�\�\��t5�\\6SQe\�0K7�����\�\�\�1\�K+�UQ��@��m��6;\�oM�+c4\�J��gN\�\�z��z\�`<��ӿ���,MJ0���t\�\�\��_�P�\�8�hp�6�\�\'N\�\���_�\�dn\�\��O�U�q��)@)JP�f\�!���\�eM�\�\�\�%�\�d6�!d�og�$\�x\�\�1�\��K\�\�F=oj{>��&CW\��~B|�#sgV6��ܰ�d�D\�\n#\��\0��\"(1����X7�o�����\�黩\r/��}\�3\��6�V�\0|�\�m$ �H��A\�]K#�Ve Q֕�]ϻauڳ�˭�\�|g\��\�~�ƍ\�VV\�:��0h�\�\�E\�VX	-\�\�\�\��\�@)JP\n\�>\�]Yt�\�op\�%��jm$z�Kړ\r�Yզ�\�\�\�\�\��.}x�Y<�X\�I)\�\�P\�њ\�I\�6�\�k\��ls8L͔W���.\�g����C\�,R!*\�\�A\Z\�?O�\���mj\�>�z�\�_fv/5}�)4�\Z2\�F宭\�r\�j\�KMn�\��,c\�\�&�ƌ\�ZOq��3_hKc��\�l��\�e�wK=�崊9b�	WFR`x \��)JXc���:v\�\�Ӿ_�^�ur\�\�\���, �{\�\�\�)1YZDH�f\�\�UP\�\�Q�=vu\�ӷn����J�\'��\�/�aao\����\�Rb����\�\��\'�\�UP\�\�Q�B��wU\�+�Q3\�&�\�6;�i-�>���g��Y3\��\�\��*e��\�0\0D�4\�\�\��\0�\�L\�\��\�e�\�Z4�\�#FAt^\�N\�\�!�\���U���Ұ��\Z&�R���\0�)@l�k\�\��@v�\�^\�6S%-\�2w�\�Y\��\�Y\�,xnZ	}�I�h�\nZ\'<�U�\�=�\�ӯq��q=Jt٫E�\' ��Kqⷸk\�Pe���\�̜��WR�����+g{XwN\�+�QV�Ӳ�\���1\�\�]yp\�e�,���߀}9��1Nh؟fF�7\���-\�_^�:�\Z\�\�ԧM��_\�r\�d��+{��U[+��>�\�\���u*\�YX\�JR�R��\"\�\�Y�zC�����W;\��jc��6��%���$s+��\�P�O5l��:z\��Q\�\�\�\�]��s˝\�W	��G\";\�_R\�O�N�7�j�O��\�4l��C+���\�\�$5�2lzy�\��\�8�nXfKl��@\�_K���\�\��k\�\�\�\�\�_���y��\�\�\�\�Q,Q�S\�\�\�G��h��\"\�{�*�T�\�\�R���2ۇ8\r%i��\�\�\�\�ܙ=��\�\��\0Nju\�\�\�Hp�	���ʫᨥ��vu\��:/\�\Zޫ�}P攥I\�DR���{�?G;Զ�\�v�\�	�\�-\�Gm/��\'!\�\�������\�\�)_YՒ?&P���\0�)@`\�\����r\�UӞS�����\�\�|͇\�\�[��R#����\�*�Au,��\�#��\0l�{Vuu�;\��^:\�ԸѺ\�\�ݖ\�P؆\0M<�J��\�%�b=\�\Z9\�5�{�v�\�ϹONYN���\�\�\�w\��|Ţ�\�\�\�\�NU\�*\�Y23)����\�ڳ��ԛ�&\�\�%oq�}���0�\�h�z�\�>�\�\n��\�KFX{�2H�\�@)JP\n�\�\�\�\�ݶ�m�L=Of/�;������{�q#r\�V\�9g�f%��_pI�1\�\�E�(�h\�e��Ic5��Զ9�f\�+\�F_t�\�\�[H�\�)�te ��\rb��:\�\�۷WN\�~�z�\��\�\�Ұ���{\�\�\�)1YZDH�f�\�*�gr��µ�~��\�\�\�.�q��i�\�b{�^=\�L���!�\�\�\�uV�W��eP\�eB\�Yu���u^���u>�o-�c�\�\�C\�;�{,�0>+\��\�\�Y\�\r#\0\0TH\�@\�;��݃����yo��\�4��DYܳ\�`,���^x�g2\�@i\0�G\Zj�)@)JP\nR�2v�\�^�߯��8v�3\�m�\�#\��y��|9�?\�~\��>���???\�@a�R������;�uڏ��}\�\�[��\�ߘ\������e�\�J\��o�>�\�\��\0�lO�#I\�۠��:u\�5Ӯ\'�N�5h�\�\�\�\�cn<V�\rz��Wq}9���*\�Uв2��el\�k\�\�Ev�\�*\�zvV���\�;}k��.l���>���2r\�)�-\�\�\�F\�]~���\�ӧ^\�]:\�z�\�V��NA},�6\�\�opת�\�ew\'ә9r��]#+\�@(IƔ�<W,�4l9�R8���D\��\�߸\�\�6�+H�\\�lH�*Z\��y/�\n���ի@\��}\���\�]1\���\�{[E�\rI�\�WT\�Ը���3�>�\�/�QQlWIn��ک稽��.ΡƮ�U�fb�V\�O\�mҟ�Q\��a\�mӒ\�\�\\θLxb=\�+[H�O\�<��\�\Z��pk@~�,2\��d\�\�����2\���\�\�\�\���o�<���\�kfbGl����i&���\�Wȩ\�2D�9�+A;\�w\�\�>қC�\�Ӎc�w�SX�h\��yGe\�FJ�)�\����!\�u(�*\�${B;\�w\�\�>қC�\�Ӎc�w�SX�h\��yGe\�FJ�)�\����!\�u(�*\�$u1\��\0\�>�7�7\��nCP\�\rC�7�\\\��ߵ�_o8�\0���**��\n�\��\�\�u7��\��ߝy}��f��k�\�g%\'��H}�\0p���Q#PUTP\�P@�p��\�w�@}}k���c�\�\��\�N\0Ԋ\0X\�/dc\�}�\�\�{+[�<\�U �[i�\�\�V�H\�2:7X{��<Վ��O�\�-��\�_Z\�c\�q�v;}�YI�\Z�G�\�}��\�c��\0��V>�p&���\0�)@a���\�۸�N\�~���\�+�\�dWհ��*^\�\�UH��\�R�2r}�*\�Y2;)�Wu^\�]Ev�\�&}�\�K\�E��\�\Z\�\�ْ\�?d���O�:y(�KF\�Y\Z9\�u�z\�\�O�n\�;e�k\�WH�G\r�_V\��\0�{��U\"+\�IH>�\�\��\�)dp\�\�\n4Ҷ���j���Ou>\�o%���\"\�\�h�ogl\�e��V\�y\'ҝ<�K%�b,���\���\0�)@)JP\nR�;\���|uor][g\�\�S�{\�6\�\�o�e-\rƳ���k[v2Z��\\/� \���x@}>O��\�K�l��\�s}�ؼ-�\�塸\�w�\rknÆKU`Vk��$�>~o\r�b\����j�\�C�5\�+��\�\ZLb\��\��\���/\�~\�\��}?\�\�Ǐ��\�\�\���\�Ic4�\�V8l&\�+,N\'j�[\�\�ơ#�(\�DU\0�v\�V��?��Tv\�\�W�S����\�\�fb���@Z{�q#p��\�͘��\�*H�S\�\��E=_�Wi-/���GCk�9c�\�e\�e�\�\�V�=�弊RHe��WFRAR �Uo��>��QۗT\��M\�\��1��{\�n�T��\Z.\�F\�m\�c\�=�1\�rT��\��\�)\�JP\nR�\���\�\�Wj>����eo\��\0~c�ֺ*�\�\�PY+\�\0�s\',b�ѱ>̍$oon���\�׸\�N���:lբ�\0�_K%���[\�5\�2\�]\�	�\�NGܫ�WB\�\�ƍ����;�uڏ��}\�\�[��\�ߘ\������e�\�J\��o�>�\�\��\0�lO�#I�u�V\�/�N�{�t\�\�S�\�Z/�9��Xۏ�\�^��-�\�@�Nd\�}ʺ�t,��sM�>H�\�\�\�g�ۍ�\�ċ�\�\�8��us(?�q�\�K\�`O}�6���\"\��|\�/�98\�\�\�\��9�����Z\�\�#I-R�v~�\0E�n�\�\�M�\"tr*s\'�=ض\���\�f�x{�s�6^��\0o����kJ~�ܫ\�;Q\�H�����O\�-x�\0�ƷX?�z��~,��z\Z<a\��\�[\�\�\�_�\0Қ\r\�+�N\���\���\�Xj]\�\�\�.\�;G<�Q\�FyQ��\nC%��>)\�y\�J)\n�IK�\�}�s��\�\�o\��\�\�\�M�5-�]\�s9)<��C\�\0�DU\n�\Z�����*�-�\�+��\�wk\�\�&�[5�\�j��Gk�\�;\�\�,1�\�Ag�f\'\��/�uZH\�~�\�F\��ǻ\�\�ߍ��f��kL\�#��\�8 �9WFR��)(\�\�\�J�\'\�G��)@+\��\�̗6�4oGFᔃ\� ��^*P@�q>�\�w�@�}kuMw\Z\�c�ۃ����\0\�c����/�9O��ec\�pg�ʠD\�k2\\[J\�$l\Z7F\�\��>�}8�Q\�;��.��\�Ǯ\�X\�v�p��\0.�Q\�\�a{#kR\�=�����	��)@)JPg�\��v\�)Ӷ_���t�\�p\��l/\�\n��{\�R\"����\�L��~\n��G�\�j\�W�_Q=����f��\�\�p9�\�C\�k;fK,���k\�>�\�\�X	-Adx\�{z�\�\�_Nݺ�v\��+Ԟ�\\n������\�\�/YI�\�\�\"G�3��!UC;�Df\n\�\�S��\�Dϼ�\�|q\�sKo��E�\�=�ɘ\�Vw�S,\���\08\�\r^�)@)JP\nR��}=�\0O��\�M�,��\�w}�ؼ5���塸\�w1?\rknÆKU`Vk��$�>~o\r�4n�\�{s���@\�6e�\'��X-\�\�\�P�\�h�*����\����Aڳ�֭�釩\�\��gb�W�җ�Oq�.e~Z\�\�G,��Ĵ\�\�\�	2\�<�\�kL\�\�e��Ic5��Զ9�f\�+\�F_t�\�\�[H�\�)�te ��\r\�R��\�\�\�#����\�hms�\�s\\���ylVN\�g����JI��*\�\�H*A+��U��O\�\�\�=�uM\�T�,\�o����\�\�\�|\�\�W7o;Y\�وXn����>~4T\��5v�\���\0J\�6�\�v9�.^\�[<�+%j�\�\�[ȅ$�X\�te$ �V\�S\�\�\�]�uU\�T�-ao���\�\�\�KOq�\�$n\�v<�\�3�\�7%IH|�`\"���\0�)@l\�k\�\�Ev�\�*\�zvV���\�;}k��.l���>���2r\�)�-\�\�\�F��\�/�N�{�t\�\�S�\�Z/�9��Xۂ�{��U[+��>�\�\���u*\�YX\�\'��k����o��-`l0�;�k�o-�����1��ǩ3�\�(\r#H��\�/���{r�\�鯦\�$,18��rY+��{��e[۹@�\���E\n�T�<������\�#\�P\�\��?P\�g�7�\��\0�[�\�+A~��\�\�v\�\�6$��\0hjL�^G/�\�k���\�s�*Kpk�go�o�\��l�+�필�/\��n�\�[�\�\�7O/��\�[�\0梛\�P\�x�1n6\�Kp^\\6�L�R߹դH\�<�d?̚��<�����$�D���i*�\�x\�\'ȫ\�rT�9�\�\�\�h��m	Ժqlt\��i�]�^\�c�\�ߕ�٘�\�\�\�i#�)[BP\�}�#wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�Hd\��9WFR��)(\�\�\�J�\'\�\��\Z\�v��:�N-��\�m5bˣ��\�\�\�c�\��\�3\���غ��$rT\�}�#wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�Hd\��9WFR��)(\�\�\�J�$��)@+\�\�ֳ�ʹ���h\�Fᕁ\�G�\�T�,��\�}Gpo�8>�:�\�\���#�\�\��\�O\�\�E\0,v�1��ㅎS�#\�X�\�\��\�ֳ�ʹ���h\�Fᔃ\� ��V=�p���7�\�\�\'_:\�cב�v[}�99�]J��\��F��\���G��\�3�7U�z\�믧n\�];e��\�OX.7�_J\�\�\�\�\�s��\�ei#ՙ�O����ʢ3]�u�\�۫�l�R�I\�\�\�q\�\�XX[��\�b�����\"$z�?�\�rT3�TFaP�\�\�z�\��\�L�ɼ�͎�c�K}�,\�Y\�L���<z����g 4�\0Q#�\0wT\�\�Wv�g\�M\�lv\�[\�}gr\�e��f\�y\�՝�T\�9�`\0\n�i�ԥ\0�)@)JP\nR��;\�����wm�[g\�Sً\�\�\�毿e/\�\�F\\Hܵպ�Y\�Y�i�\�\�e�y��\�cJ�\�3Yi=\�\�X\�}�u-�g�����\�\�,���\�(x\�D%]H!�\��]�UG\�����wm�[g\�Sً\�\�\�毿e/\�\�F\\Hܵպ�Y\�Y�i�\�\�e�y��֘њ\�I\�6�\�k\��ls8<͔W���.\�g����C\�,R!*\�\�A\Z��)@+�\�\�GK\��+�\�\�\�M\�\�0��)l򸬝�\�oyo\"��)cpUє�T�<WiJ�P�\�۪{qj�ީzZ\�_f631}\�Ͳ�Oq�\�%n\�v<�\�3�\�7%IH|�h���j�#��J\�6�\�v9�.^\�[<�\'\'j�\�\�[ȥ$�X\�te$ �	VϨK\�\�\�=��U\�T\�,\�o���\�\�\��\�E\�H\�-�\�yg�f!a�nJ�\"���<�EUl\�k\�Ew[\�*\�evZ�\�alw\Z\�Z\�[3Yi�&b=G\�Rg\�P\ZF\�Qd�8\�c\�è�\�E[\�\�\�-��\�Z\�[\�vk-?d\�G��q\�L�0�\0CH���,�%��\n\�3�Nܝ;bzk\�IM���,��V�\�޲�-\�ܠRg�`��Q���tӧnN��=5�٤��&�}\\�J\�+^\�oY@��\�P�3���TP��QUFi�(�9?j���\'4�\�\��k\'%��~9�\�\��_����%b8 \�A}X�%�\�\�\�G/\�\�g�9i�\��*O�\0X\�#Z�\��U\�\�ğh��՘����Dr�nk��M��\�L8N�7/i��\n\��%k��	\�\�\�\\����\���\0�N��	�W^\�[\�\�ܗl5M\�\�Ee�\�`d\0n�|�l�G��H_����\�|\�x0�BKlF筪�㬘\��\�\�~9uB\'\�3Z\�暗\�\�)J���\�\�\�h��m	Ժqlt\��i�]�^\�c�\�ߕ�٘�\�\�\�i#�)@P\�}�#wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�Hd\��9WFR��)(\�\�\�J�\'\�\��\Z\�v��:�N-��\�m5bˣ��\�\�\�c�\��\�3\���غ��$rT\�}�#wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�Hd\��9WFR��)(\�\�\�J�$��)@+\�o<ֳ-ʹ���h\�V!��\�G��(\�է_}`u\�4����\�5��D\�c\�i�\�ʼ[@����\�\�\'���\�,�\�\�\�8\�t�\0�)@)J�\�\�\��ս\�um�S�Na\�\�����\\�7\Z\�\�6\�m\�p\�j�\n\�p�\�g\�\�\�\�\�9�\�\�\�\�\�}�\�!�\�{-h�\�\�e1\�\�5%\��6^�2�?�����SޣE�=ջUu\����oy,NG�in4>���d�\�\�+伓\�N�J%��ѱG�G�.�њOnt�3@\�5c�\�al��\�\�qv����j8��\0TEP\0P8\0V/뻡>���t\�鯩]\"�6E}[��\��T��m% �S\'\'߂���\�#��(\�J\�꽪��\�=\�L�9��?\�8�Kq�5���%�~\�X%\�Jt�Q,��� �4r>�P\nR���?\�)�=��v?��r�ڃa���\�@��\�J��\��ۖ%��>M$c\��I����v�\0_\�\�\���\�\�MY�\�\�\���W\�\\\�*\�g����CG,r)!����\�y��\0}@:ߵ���\��<�C=��쇕ͪ��\�H\\\�ܽ��K@\�KMl��\�,c\��Y�S�ہ�7_C\�w/m5f?=��\������U\�\�m{m\"��X\�RC+)@wT�(uz�Hi]�\�\�-\r��ݎc���\�-�\�ڬ����)I\"�7]IH �k����>蟦>���lJ;Qc��\�\�O}=����\�\�Jܴ�M+4�0(�ؕDD*�2\�)@)JPr�\0�Tv宦\�wJm��\�\��\�q\�*+�\�\\]\\\�]H�N�aS\�q2CI!�\�\�\�U;�o�u\�uw:;�V\�MW>?\"?*��@Y\�\��$\n�\0\�5œ�v\�{�\�Y{�>Z]]�]U�\�z�Rsa�9M?��\�\�/^\��\�\�;�I\�<4R�F�`��n������p\�[馥Ck��\��\0�7>�\�/�\0��\�}��U���\��\\z�:ߧ�SҦ!\�y���\0�\�\�\�98\�\�\�ȣ\�\�p�3����XF�\�պ\�\�\�\�?�l{D\�\�W\��n��n�\�;\�v�%ȕjS��\�*\�8�R���}�\Z\�v��:�N-��\�m5bˣ��\�\�\�c�\��\�3\���غ��$ro\�(\n\Zo\�\�n\�L���\�}�\�W\�kVi�\�\�\�1�\��\�G*\�\�U\�E%YIV�u[���c��\�ͳ��tŽ��ލ/�q�ug�r�N1�\�{���>\�\�;^U��J�\�&\�n�O[��\�=\�\�\�\r5��\�A\�xL�>Z̿c�e �WRUՕ��`H/JR�R���J/\�\�\�Rw1װ�!Ԗ#�ح?{�a\��\��7ᬭ\�\�l�=\����2$�h@�~��\�Ww$ն}Ou;��\�lV\Z��Qr\�\�k;�ۆ��a\�%��+5\���Q�?7�\�\Z7Fi=�\�X\��tՎ	���\��\�ڬ�v�H\�4Q@@\�M�4�\�\�,f�\�:j\�\r�\�YEe�\�\�-V{;x\�$qG\Z\0���\0�\0\0�ڀR��0\�]\�	�\�\�S�l�M}J\�\�\�+\�\�_�/p���E{i)ҙ9>�e,��\�+��j���Ou>\�o%�\�\�r-,�#[\�\�2Yg앇\�^I��O%�Ih؂#G#\�n�Oq���N\�_�\�Q�]fY\�C�a��#6����\�M7$1��72~[w�|�c�\ny��Fe Q\��\�å�&�\�}K�6�p�Wi�^v\�\��S%�\�\�\�+,W^���Q��{���f�R��\'?O\�\��;ak�~�:�\�\�3\��\�y]Z���:B\�F�\�\�k\�Zc\�5������S\�f�jP\�\�\��\����;��z�\�=��\����ٜU\�\�m{m\"�Icu$2��A\�\�l>�~��\�\�u?Dz3C\�5\�\�\\[͒\�\\\��A\���n\��\0(I\�\rh=\�vic\0�\�\�@)JP\nR������\�ҿG����ױ�.M\�I�2io]};h�\0\�;Ŀ檝\�,�\��M+;�\�ǒI�$�\�k~���\�	�4?G\�{%\�>v����8\�ᅤ\�n�>\�$\�#�\0޵\n9�\�V$թ\nlby�\��\�8um�fK���N\�_Ku\'�\�pO�l\�hβS����\�\�\�\Zo*\��]��K�@f?�R�S�>kYO�S�\�5����\r��Z��m�\�M~�Oo�3l�V��ޅ\�,\�\�㼶�<r�h\�O ���0 �h�\��\��\0���(\�\�=Y�\Z�mLX<��^e�\�W��\���\��e�\�		����>\�JZ�US�V\�rf~h\�\��X~�5��2|nV�\�)\�)J���JR�Tx�\�\�C�\�\�v��oc\�\�\�\�X�M1�\�Os�,1�\�G-$�r�ZbG(΍!Ԡ(W�{7�==n�we7�Cd4֪\�Y�\�\�2��Mk2��ٔ�]IWVVRU�?/V\�\�؇k��\�sn\�Ǐ\�[ݦ�\�cSȞ\�!^XcoʎZ\"I�\�\�,ĎQ�\Z�;ǳ{�\�\�\�\�vSz�6CMj�5�{,\�)�ֳ/\���H!�ԕuee%X\�ҕ\'?O�\���;�k�~�z�\�\�p;�\�qst���\���汳b�)3\\�\��\��<�O\�\�����k�~���\�\�0;��\�\�\�<��\��1�\rcf�\�`Vg�_\���3\�y46�\���\�;Q�1[k��O�\��|V8l6*\�`����B\�q�UT\0\0�\�\���ڍ�\�M�\�x���\�\�\�a�V����j8��@\n��\0wT��\0�+�\���Km��\�\�s�\�p�\\=���\\�J\�`����K\�,�9\n��	,H\0@5v�\��KduƹԖ8|.\"\�[̮W%t�[\�\�ƥ\�Y�DU�$\05V�\0�O\�\�=\�uE\�K=,f\�p���\�\�\�CAq�.#~V\�u<2Y�\0\�[��\�<�>�_�OT�\Z\�7�,����\�\�f\"�����\�Z\\Fܭ\�\�xd�V��n%�yx$1Q@)JP\nR��;�Ol��;��g����=���ί\�׶\�\�\Zv��y�\�\�ۆ\�iXp8UwGl�\�=FwM\�6\�a6�{;�_��m٬4\�n�Ǜ�#�Ұ\�p�\��\�\�\�˧>\�8\�:q\�\�L�\�߉�ۥV�\�_�K˩\0N\�pp��T@@��;yt\�\�C�gN=8i�\�\�[�>w;t�\��\��Iyu \�ێ�5\n����JJR�R��?*y�|W��\�\���\"\�5��K{[H\Z[�\�p�\Z($�\�\0\0�O�t��\����\�n�:?m�\�Q�\���\'\�\��j\�\��ed�ߎD\�G�W�����Ε\�\r\��T\�+\�\�7H\�NI�z&jC/s.�nz\�\�CX\�7>[��\�\�I\����\�	\�������\�\�0�G�W? �T\�D精һk�3��\�k��Z���2lmF�D8�)X\r��ݭ�\�\�v�\0\�\���qq&�\��ָ\�yo\�c\�a\�\"�\�HX,�\��)\�\�h�#�p\Z\�K\����\�A�\�Y\�ua{k(x�!�C��\�ٕ����\�=�<T\�}7}\�l�zn.�7�<W+�Ygۻ\��\0\�Z\0^KO��_�\��\�䣁�\�k�D�\0\�ʺ�\�\�é\�Z}�.��K�3{)kw;��\�D�Ҁ�9\�\Z�N@�()JQ\�\�w�\�wa\�\�\�=�����Mc\�4Ƨ�<!\�B��\�ߕ�D�\�\��hY��:4�R��f/�k�����\�e�\�\�|�\�\�\�\�	,56;#[_\�K��\�Z0����.Е*�aff/�6�o�>\�h|N\�m��\�\�t��\r��Xm���P�\�\Z(UT\0\0�\���\0�+�\���K\���\�k�q�\�p�\\E���l�N\�`����K\�,�9\n��	,H\0h�պW@il��\�\Z�\��\�\�Ky�\�\�\�{;xԼ�K#�����b@\0Ul��>�=S\�kU^��\�\�n�\0���\�.�\�4\Z\�\�6\�n\'S\�%��\r\r�pX�,�\��!\�\����Oq�U{\�\�K9�\�>\�b/���_(.5�\�m\�\�N��K5`\Zv\�Y��C4��\0�)@+c�d�\�\�?�oQv{��cogK�[�\�m\�\�i\�\�4�ǜ�\�G!�a�\�C�{ݬ{Xu\�o��}�\�ka��1\�k]kyl\�e�왈��=I��@iuE�D��A}t\�ۓ�\\OM}6i!a�ǏW%��\n׹�\�P%���\�L�#\�* TUP�\�ӷ�N}�:q\�t\�ӆ��=��\�s�J���*��R\0<��\�(\�cP��*�Yڔ��()JO�WB�\��\n�\�m\�қQ�3��3pc�\�<l\�\�K��\�-\��\�\��U\'�UY��u��:�\�P\�\�vI\�\�I\'ദ.f�\0���ь�Hܴ��#ԕ��\�	����\�g�\���ڃՎ��7�\�O\�Yxxq���\�Yx�+\ZsϨ��j��E\�\�\��X\�\�n\���\0ch\0���oլ\�I(\�v��\��\0oNg�8�)P�)J��+�\�:�R\�MS�\��79s�\�a\�b�\�\�,\�)-�\�n$F�ʺ\�p<�� �O��\�s�m0\�U:)S6�d����h>\�k��N\�\���6\�z�M�Vz\��\�\�\'\�\�%��f\n\�?\�`\�\���;q����R>���\��7��;%�6�<{�]\�\�I�\�ڱK[�y\��\�HVRT�4t׎\�w\0\�k\r\�\���\r\��o�03\�\r\�&�(/�|�~U�Ԃ8�ΰ^[p�\�ȿ�\�4\��8?Kz2��\�5��nt�.��b�\�^\�Ӟv��)RB��()JJR�R�\�\�\�_���\�k�s�,p�\\=���\\�N\�`����K\�,�9\n��	,H\0h�\�\�[o��K\\\�Ic�\�\�\�e�\�erwK���j^I��\�TEPIb@\0Ul����=U\�sT\���\�\�j���{\�.��h.5�\�m\�\�Χ�KE`\Zv\�Y��B����-S\�sU^��\�\�j��x{\�.��h.5�\�m\�\�Χ�KE`\Zv\�Y��CT��\0�)@+g{X��\�+�\�QV�+�\�\�`c�ֺ\��ٚ\�O\�3\�?z�?\"�\�0>\�$�\�c\�è�\�}E[\�\�X-��\�Z\�[\�fk-?d\�G��q\�L�0�\0CH���,�%��\n\�3�Nܝ;bzk\�IM���,��V�\�޲�-\�ܠRg�`��Q���tӧnN��=5�٤��&�}\\�J\�+^\�oY@��\�P�3���TP��QUFi�()JJR�R��?���y��*\�G\��\��`_\r�2PO�Z�\�[m)`xsd�q%��}�\"\����W��\�\�\�\�6��f\�\�\�~��/�W�\�����p�[\�B��א\�K��{32#Vo����o��\�\�\��\�6\�g3���6p�};h�\�Ā���I,\�\�3�6�%�5�E�N?b\�\��g\�\�\�+[�$k���~\�\�\��\�\��Z�5y�5V\��\0#���\����V�[���<�\�Iff$�}\�$ק\\�I���\�\�Ud�W.jwTQ\�i$MH��+\�R���(}�x\�\�Y��.�7��\��\�\��\�߬\�N��\�\�r0�\�چ\�\� �\�ܤ�y#�\�\�S���\�\�e�y)\�I#\\�\ru\�\�Cy�}c�2T]\�ZӠ�\���\�9�uH�\�z\�E���91J����\�\� ��\�rG�T���w��\�\�\�͆\�O�\�Z0K�Y9k\\�� ��\�`�$M���*@e*ʬ,C\�O�N�\�4\�xLm\�i�il��\�y+�2�\�\��������\�j��k2\��\�ĎE\�ח\�\�&h�烪WFՒ�W<��;�\��|M�� �A�H\�`R���(j?z�\�\Z\�\�B�ޚ�\�zr:;9���x��\���\0\�;��,�\�\�7#�ND�O��n)@P\�}�wzd\�\��\�\�΃�\�Z�Lߵ�g\r��\�HdA��)WI�tee%X�\�p�]�v��VНK�\�L\�6��e\�\�\�\���1\�m�PY홉�~�\�]AV�9*a����2n\�{a�\�A\�i�Y�o\�\�3�\�\�\�$2pA��)WI�tee%X\�R�����{Xu\�o��}�\�ka��1\�k]kyl\�e�왈��=I��@iuE�Dv�\�a\�Wu����We�\r��\�q�u�\�5���f#\�~8�&~E\0!�`}\�I\�\�tӧnN��=5�٤��&�}\\�J\�+^\�oY@��\�P�3���TP��QU@��\�ӷ\'N؞��l\�B\�`��K%p�s7��K{w(ԙ�G\�*(T@���4Ҕ��\0�)�\�JWʣɏ��\0x\�\��\0Z\�~\�\�Ƕ+�n\�>�\�\�\�fo�\�\�:R\�ey[�>|\"RAyH�@G\�3*62\�ރ`�}\�.tV\�\rY�7�\����\�\�̰\�f��y�#�!\��\��\�^��:�\�~�wo#��\�\�\�2/�f\�a��R\��\"�9<(��Ėfc�_ⷵc�{Ry\'>�\�\�ю�n�v\�W�c�M|�\�\��W�\��\�\�;{:\�\�\�\�\�\�\�Ж\�a\�b�V\�\�\�j	)o\n�xQ\�%�,\�KI�K\��\�){��Ia\�?Z\�4���.j�p[m�V�&RR1$D؈��+\��()JJR�R��9 �\��\�Kj�O��%��\�z���\�\\%\�;\'��hg��O*�\��������~_�r���\�ֹX\�\�T\�<TıJ\�V��E֊M\'l�����پ\�3�\"��X\�%���5����1\�/\�\�\Z�\�<�\���\r%���\�i\�MY�u�[\�c�\�\�$\�\�U\�Еu#\�H5N�G\��\�\�[пs\��\�$�\�\�nךr[�S#�3L\�\�y�\�T\�$?��$�\�\���ڱT�\"GW�8\�\�\�\�}�*j\�>���Ǯ��~U�Ww-��P���4\'�\�Ҵ��\0�?�ު�\0	�w/.v\�V\�?�uE\��\ny\�\�m\�@Q�x\nk|lo\��P�݅\�K�d�6\�~?z�\�USճ��\�\�r�\��y\��KOp�ѹ?�j^K�z)\��\0:S�\�ҽ&�R���}�\Z\�v��:�N-��\�m5bˣ��\�\�\�c�\��\�3\���غ��$ro\�(\n\Zo\�\�n\�L���\�}�\�W\�kVi�\�\�\�1�\��\�G*\�\�U\�E%YIV\�\�\�=�z�\�\�U�\�쭁�\�X\�5����f�\��L\�z�\��\�\��4���\�\"YӼ�b��;�\�\�nZ�\0-�\�\�	�,&\�ZcD\��^�2Y]\�?\�>X4RT����\�_A�:v\�\�\�\�_M�HXbq\�\�\�WZ�3z\���r�=I�\�}���D\n��\0t\�gN��:v\��\�\�f���rY+��{��e[۹@�\�\�>�QB�EU����()�\�\��\0ƀ\��}�<W\���5\�\�2\�\�%����V\��yg�@��%�>�\�ɨ�\�{\�)\�릏\�i��m\�\�P� �O\�*\�`�\�\�\�\��K\�>5娫��gjg#P\�\�p\�\�T�\�#��jNk�:��\Z�p�6\�i[\�s����\�\�3_\���y�Q��P�\��\�F�-��\�nߒ̾��\rǼ��\�~��A\�\'\�בG<��;z\�\�;\�o^��\�w\�p%8��2\���+\�e�\�a�>��H�d.�\�y\�0?>\�qP{�)�l\�\�\�;ח�0�譮em�RIZF�+W�\�\�|��\�o9�Թ��I��7Y��\�\�^\�\�\�4\�\\J\�\�#�,\�ĒX�I>�\�y\�W\�%���s��\\\�\�(��\�8\�$M���+\�R���()JJR�R���()J\0~~8��\�\�\\�}�ݙo��x\�=N�{�Q�\0h\�\�|�!x�\'ߚֲy�&�䷱��UTR����\�j.\�+E��`���5w9\�BrzX��6+W�Ֆ\�etu\�x��\���<{�\�\�\�\�Uf?�H�\���\��Sxd\�\�V�i�L�i \�\�#y\�\�sır$��\0\�uS�UH\��簿�\�\�Œ\�_Mms�\�	J<l>X{����R\�\�ȲI��O(�G\�\�+ܲZ\�t]\��7�u��r�9�\�6V�W\���*�\�۸\�O�:�mG{g����\\�%���bF�De\�\�\�m�\�}T]\\\�V8wSa�N�DP�\�\�dԗiן\�~� �[%O�6�,�\n�\�\��\0�\���\�L\�(\��~\��Ƿ�\0�\�$TKm\�\�s��(P\�\�Kz�\�?\��N\�\"�\09��#�VX\�}M]��`\�ָ\�~��q�\0�;\�ɗ�\\��T�!z2ǔN\�J	:&i♒ Ho�\�\�\�Z1���;X^�7�璲\'\�O�2��\0��j�\�~�\�\�6M��\�\�x��3(��\0\�Z\��J�,�\�|P\��H\�\���3�푽\\�9�\'�o�\05�����1�+��\\|=7\�\���Y�&\��W�)`�6��]W�q��Qe\���\0?G�5���Ti�T�6T�1Ǖ�\�:	:�I\�\�<�\��\0\�_�f�$�\�@�\0��P-�\�T\�X��%�kvGC\�ȥRL�\\\�f��V\nr?T#��I\��\�\���i\"\�.��<V����WC�\�-��\�_��_�5��\�cO�7/,�Iͧ\��W=�Y{\�5�O�d��z\�\�7��D�}�ߝ7�}8�\�\��\"�\�a��;t�S�\"1�\�\�\�ڝ4n4�H�3�\�\�*Y#\�\Z�͍�?i\�����\rB=\�\���R^^\�I<ҹye�\�3�<�I�$�\0\Z�r\0���ŵ�j��\���=�0ݽRK���ɻ\�o�k^�lX]\�z\�\�yl��wn\�\�S�\����Щ&~�i�Fb+^��\�\�$����*3=L�/\�J\�r����\�i�Ӥ�6&\�\'�8�)XM��)@)JP\nR����\�','2020-03-20','nonTraite');
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
INSERT INTO `module` VALUES ('ALGO','Introduction a l\'algorithmique'),('AR','Administration Réseaux'),('ASD','Algorithmique et structure de données'),('BD','Base de données');
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsableformation`
--

DROP TABLE IF EXISTS `responsableformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsableformation` (
  `id_responsable_formation` int(11) NOT NULL,
  `date_nomination` date DEFAULT NULL,
  PRIMARY KEY (`id_responsable_formation`),
  KEY `fk_ResponsableFormation_Enseignant` (`id_responsable_formation`),
  CONSTRAINT `fk_ResponsableFormation_Enseignant` FOREIGN KEY (`id_responsable_formation`) REFERENCES `enseignant` (`id_enseignant`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `code_module` varchar(10) DEFAULT NULL,
  `type` enum('TD','TP') NOT NULL,
  `annee` enum('L1','L2','L3','M1','M2') NOT NULL,
  `specialite` enum('MI','GL','SI','TT','SCI','STIC','STIW','RSD') NOT NULL,
  `section` int(11) DEFAULT NULL,
  `groupe` int(11) DEFAULT NULL,
  `jour` enum('dimanche','lundi','mardi','mercredi','jeudi') NOT NULL,
  `heure` enum('8:30','10:00','11:30','13:00','14:30') NOT NULL,
  PRIMARY KEY (`code_seance`),
  KEY `fk_Seance_Module` (`code_module`),
  CONSTRAINT `fk_Seance_Module` FOREIGN KEY (`code_module`) REFERENCES `module` (`code_module`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seance`
--

LOCK TABLES `seance` WRITE;
/*!40000 ALTER TABLE `seance` DISABLE KEYS */;
INSERT INTO `seance` VALUES ('1','AR','TP','L3','GL',1,1,'lundi','11:30'),('2','BD','TP','L2','MI',3,12,'mardi','8:30'),('3','ALGO','TD','L1','MI',2,8,'mercredi','13:00'),('4','ASD','TP','L2','MI',1,3,'mardi','11:30'),('5','BD','TP','L2','MI',2,8,'dimanche','13:00');
/*!40000 ALTER TABLE `seance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seancesupp`
--

DROP TABLE IF EXISTS `seancesupp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seancesupp` (
  `code_seance` varchar(10) NOT NULL,
  `code_seance_supp` int(11) NOT NULL AUTO_INCREMENT,
  `jour` enum('dimanche','lundi','mardi','mercredi','jeudi') NOT NULL,
  `heure` enum('8:30','10:00','11:30','13:00','14:30') NOT NULL,
  `etat_seance` enum('valide','refuse','nonTraite') NOT NULL DEFAULT 'nonTraite',
  PRIMARY KEY (`code_seance_supp`,`code_seance`),
  KEY `fk_seance_seance` (`code_seance`),
  CONSTRAINT `fk_seance_seance` FOREIGN KEY (`code_seance`) REFERENCES `seance` (`code_seance`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seancesupp`
--

LOCK TABLES `seancesupp` WRITE;
/*!40000 ALTER TABLE `seancesupp` DISABLE KEYS */;
INSERT INTO `seancesupp` VALUES ('3',3,'mardi','8:30','nonTraite'),('5',7,'dimanche','8:30','nonTraite');
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
  `token` varchar(255) NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  CONSTRAINT `id_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,'1cjjef0haanibn10f7568c95dk5bllakhdara'),(2,'86469k4m3h2h9kel69bblaicc6lglecheheb');
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
  PRIMARY KEY (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'lakhdara','123456','Lakhdara','Zakaria','Constantine Rue de France','1985-05-05','Lakhdara.zakaria@gmail.com','123456789','enseignant'),(2,'lecheheb','247365','Lecheheb','Nassim','Constantine Ali Mendjli','1982-09-03','Lecheheb.nassim@gmail.com','123456789','enseignant'),(3,'Trish','p1wboZ8Iw','Trish','Dowe','236 Muir Junction','1997-12-12','tdowe0@businesswire.com','1','etudiant'),(4,'Hillie','F54QdVw','Hillie','Lakey','457 Dapin Alley','2000-08-11','hlakey1@so-net.ne.jp','2','etudiant'),(5,'Abba','H0gF2C','Abba','Eckly','8375 Merchant Circle','1999-07-10','aeckly2@ucoz.ru','3','etudiant'),(6,'Avigdor','fBECvC','Avigdor','Dawkes','03 Waubesa Lane','1996-05-05','adawkes3@springer.com','4','etudiant'),(7,'Finlay','SAuE6WqpTr','Finlay','Poacher','72 Reindahl Park','1996-11-06','fpoacher4@privacy.gov.au','5','etudiant'),(8,'Ashlan','Kvmms0','Ashlan','Kaas','61542 Almo Parkway','1999-06-13','akaas5@jigsy.com','6','etudiant'),(9,'Yevette','STmaxGC','Yevette','Rodenburg','8489 Forest Run Place','1999-05-11','yrodenburg6@earthlink.net','7','etudiant'),(10,'Moises','nbC0Kjb','Moises','Kerridge','78683 Gerald Crossing','2000-11-12','mkerridge7@stanford.edu','8','etudiant'),(11,'Murielle','XQezc6db54r3','Murielle','Dahlberg','50 Harper Street','1998-10-23','mdahlberg8@archive.org','9','etudiant'),(12,'Edith','2f8PGsjEgj','Edith','Caustick','3 Holmberg Point','1997-08-29','ecaustick9@edublogs.org','10','etudiant'),(13,'Jermaine','gcvTVhx','Jermaine','Owens','38480 Vermont Alley','1997-09-12','jowensa@biblegateway.com','11','etudiant'),(14,'Adiana','IzS0SuwuYYfe','Adiana','Bigg','744 Warbler Avenue','1995-04-16','abiggb@ebay.co.uk','12','etudiant'),(15,'Boonie','JMSLMzHQ4lNA','Boonie','Eckels','3 Tomscot Terrace','1995-09-15','beckelsc@sitemeter.com','13','etudiant'),(16,'Colver','LadQCsms46','Colver','Olivo','14 Maywood Pass','1997-06-28','colivod@squidoo.com','14','etudiant'),(17,'Erica','hUozfYSAVmd','Erica','Sharp','577 Gateway Terrace','1995-06-05','esharpe@narod.ru','15','etudiant'),(18,'Wally','ISt4NpGgY','Wally','Ballentime','01641 La Follette Road','1997-04-01','wballentimef@statcounter.com','16','etudiant'),(19,'Chadd','chcZaOL95m','Chadd','Lyste','48481 Hanover Circle','2000-12-07','clysteg@wikimedia.org','17','etudiant'),(20,'Jolee','ZGeRIE','Jolee','Clelle','471 New Castle Street','2001-04-28','jclelleh@nps.gov','18','etudiant');
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

-- Dump completed on 2020-05-22 17:50:56
