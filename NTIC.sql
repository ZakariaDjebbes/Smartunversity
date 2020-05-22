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
INSERT INTO `justification` VALUES (3,59,_binary 'ÿ\Øÿ\à\0JFIF\0\0H\0H\0\0ÿ\Û\0C\0			\n\n\n\n\n\n	\n\n\nÿ\Û\0C\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nÿÀ\000\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0H\0\n\0\0	!1\nA\"a#2Qq4‚¡$BR%3Sbr‘’£\ÃD”¢±cƒ“²ðÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	ÿ\Ä\0;\0\0\0\0\0\0!1AQqa‘¡±\"2r\Ñ#BRÁ\áñSb5‚²ÿ\Ú\0\0\0?\0ŒúR•EŸ«‚”¥\0¥)@)JP\nR”>\ÃÙ…<Jû‘\\Ÿžkdú:\í7\×\\¾\Ñm4–:z~<5n§f²\Ç8ÿ\0Š7e/p>A0¤œ\ï\Åg§¦¨ªf&«—¸\Ô]¯¶‹2\Ï_3cjor¢¾†¶Wž\Â\Æÿ\0-{7e5\Õ\Ä\î{xË¼Œ~T{“ú\nœN–>–­Š\Ñ\æ\ß?Õ–\îe5\Úð\Ò`°*q\Ö\0ñ\î -<£ø2´\'ô©\ØnŽ:_\é˜=Š\Ø\Í7¦£T	$ø\Ü\\k<ü{s,¤%?«³Ö¤\ÔxJ²T\íL\äbx©E\â/hŒ;@«®\'N\äÞ¿|õ¯[]\í\Üg¨6Šm\r\ÒÆ£³³•‡üã©¡\\T!û\ãñf6‘TV\ç\í\Ímž\Úý+\\g„s\î–üh>Žd\ÅAs’‘?B`^“ú\Ôñ¤QÄ¡Q·_¡\É“[ú|)m‰?S7/<½\n‚\ë\í\ëÜ©MØ…¼¹¯Šýˆ—Û¥añÐ¡\ÝÎ©5~]\ÇcOc-q\Ê\ß\Òar@þµ–0\ßL·müb¯\ã£Ö¹>©Jóüý$J‘\0?_ü+ž=¸&¶Œ²Ú£MQ\'©«\Òn<­vrW\É\ÑrOD4_ô\éö°±ñ›’½\ã\ç\×\ÖyE\çÿ\0%\Â\×_§Gµ•ò‘e²+~\Z\Ë(\Ü\ç¸jÞ‘À\ß­>G¹¬¿\Óh2\Ë\Ý7Á\rw\ç|]\ï;Ž“?­H\ë\Íý2}¸òj\Â\Ä\ë|g?ºlõ/—òõcõ¬K¹J\É\ä›hz¬\ÕX–#òÿ\0x°ö\Ù?Ÿ£ønj[<{\Zx\à\ZÀû-®D\×z*M\'c\Ê\'v¢¯“ªö“ÁQH\Üï¥¬]8“\\mnö\è}GjJÇ’[¬t\ÒqöU	2rWõ­I\Þþ\Ó\Ý\Ãú{i$\Ü.•u<¶‘r[!§­FV\0ƒýökC\'¦¿÷ü^*\ÔCËŸzü\ÉR¡YP0?ñk[>¶ÈŸm^yú“›O´6¡z%R2f÷·%ñO±M»›k›+©,\ï-d†hœ¤±J…Y{A÷\nñ€Áþ•m z\é;ªLD˜}ø\Øm9¨C\ÆcK\Û\Ür‹¨G\Ç\ì®‰b?ª:šŽ®ª¾–M¨Ô†\ãPô‰¼¹\r1rþOŸ\Ô\êo¬¹û\"N8ž%ý_\×5¬\ÂU°\ë…Q\É\à¥Á‡}¢0\ÝÁR;œNË¿\æoŠkOø$r=°_õ­„\ëµ\ßZ\Ï-\æ÷m\r\Ã\à‘üSU\àI¼\Æ?¿\0´¨ƒ“\ì\Ë°5¯^\Ü\Ôfzi\éŸØ•ª\Õ\ï/;U\î\Ó{¦I\è&l]\íT_ô)JVj)JP\nR””¥\0¥)@)JP\nR”” <{Šžx<CÁošs\í\Ç\Ø\ém)©µÆ¥²\Ñ\Ú3O\Þ\åòù+…·\Çc1¶¯<÷2±\ácŽ4™‰ø\0W\Ôj¹ri†i¢§‰d•Q\Zš\ÕWR!\Öò8ø­ˆ\è_¶V}ÀuC³š!­4\äWžKY\æQ¡\Æ\ÛqûÊ¯Á3\È?\ê\âA#\ËÀ!#½²¾›Œ6\Æ\Ãy{€[þ7\"\å\'²Û«Km­¾\ãñ²\Æy™ùùŠ6Ž8f¢\\4ŽŒÒºNZi§,±8\Ì|Ž?j\ÃJ8TD@`\0\0T\Æ×…Ÿ*$•Z“†þ¼j\Ç\Ú}¦ s\è°ú$MK\"ü©ô¦þ{9š7\Ðÿ\0\Ó\á\ÑwJ¿„\Õû—ˆÿ\0\âv­€+œ–¨µSeƒ\ï—&5÷\0ƒ)•ÔŽCŠ\ß+,}ž6´°¶HbE\n‰\Zð\0\0qð+\Ø*OŸŠ\à‚}¼Ö§TÔ´ÔŒ\ìD\Ôjw«y\ÄœATµ	#—Š\êNI±:!úaJ:W \Ô\nR””­\ï•\ß\'hûJm÷oN5Ž¥\ÞmMb\í£´{\Í\å”g•+ð¤2[+âœ‡Ô¢«$‘\Øwž\ï«\Ó\çh\Ä\ß\â#Ö»›Ÿ1Ë„\ÛûL\Ò\Ë\Ô\âKÛ¹B¿\á\á\à:\ÇÊ––AÂ‘\Ó`º\ëÓ§^\ã]:\âz”\é³V‹üNA},–6\àª\Þ\á¯UA–\Ê\î O§2r>\å]JºFV4ßø\ÝÎ§7w=¿ñ¯/µ.¬Ô·\Íw™\Ì\ädò’i°\0T*$j\"*ª€ª\0Í¬;§uÚ¨«}\é\Ù[ö¿\Âß˜\íõ®Š¼¸e²\ÔJ\ÄúoÀ>œ\É\Ë§\0´lO³#IuúV\è/¯N{t\ë‰\êS¦\ÍZ/ñ9ô²XÛ½\Ã^ªƒ-•\Ü@ŸNd\ä}Êº•t,Œ¬sM\0¥)@\ç\ÜPž=\Í)@zYLN37e&;)aÍ¼\ÈRXf@\Ê\êGH>\Ä\íQÿ\0\×Ó¯\Ñ\×R\ëw«¶Z\Ì\ívª˜3‰´ýª¶6y?ý[\"UT|û\Âb÷<Ÿ*\Ã\åö?\é\\žyö¯-M%5[;2µ†\êËˆ¯Xv©*-Óº7\'Ô¼\ÓbõB©}lv\ãê· }Tp\Û\ï $™nX½[ŠòŸ|}\È7ˆôÜ€O¥ Gö\'ÄzÁ~^_Š¸v¾\Û\Í\rºzV÷Cn6’\Çfðù7øÜ¥šOñŸ•x\ÜaúPù\Ü÷éº‹a}½]¿\"™ý\"\Ó\ä6\âò\çÏ•ù&\Æi—#\çÑ‘<Ÿ,f\ru\Â\ÒÂ‹%/\Ä\ÞÓ—ªðŸ(®Neù9RHŸ*¯ý¿Šùr!Î¹à¯¿5\îfðy½5™¼\ÓZ›uŽ\ÉX\\=½\í\í»C5¼¨J¼r#€\È\ÊAH\ï^˜\çžC\Ü\Õj\ä§IG,SÆ’F¹¢\ìT8¥)_¢”¥\0¥)@)JP\nR”?€hýÉ®HR=¿É¬\×Ð—B;\Ù\Ü{`\Ú\ržÇˆ`V}C¨®£ckˆµ-Á‘\Èý\ç>\á\"\É\Ø…Ë–e©‘#3UØ†º\ét¡³P¾²±\è\ÈØ™ª®\ä>{¤þ’÷»­=\â\Ç\ìŽ\Ã\é7\È\å/{«©9K\\u¸ =\ÍÌ€N%\ç\ç‚Xª™TØ‹¶—gÞž;xi¸³X\ËDÔºú\î\Ø&[Zd­J9šd\äþ\Z~T\Ï\í\æ\ÍÂ…\Èýt°ý¿6‚\r±\Ù\Ük©‚Iž\Ôˆ¦÷-p¬\ÎÀ\äø ü¨	\0{’s¯¿>\ÇÞ¬»5‚{ò\'jO$\å÷8oIš\\¹c\n—RQ9c¤MYlW÷»»‚xŸ \0ø¥*HS”¥\0¥)@)J\ÐNù]òv´¦\Ðÿ\0vô\ãX\ê]\æ\Ô\Ö.\Ú;G¼\ÞQ\ÙFyQ’¿\nC%²°>)\Èy\ÝJ)\n²Iù]òv´¦\Ðÿ\0vô\ãX\ê]\æ\Ô\Ö.\Ú;G¼\ÞQ\ÙFyQ’¿\nC%²°>)\Èy\ÝJ)\n²IK÷\ß}÷s©½\Ý\Ïo\Æü\ë\Ë\íM«5-ó]\æs9)<¤šC\ì\0…DU\n‰\Z€ˆŠª *€\ï¾û¹\Ô\Þ\î\ç·\ã~u\åö¦Õš–ù®ó9œ”žRM!ö\0Â¢*…D@DEUP@@)JP;\ÚÃºwQ]¨úŠ·Þ•¿kü-ùŽ\ßZ\è«Ë†[-Ad¬O¦ü\éÌœ±ŠpF\Äû24‘½½º\ëÓ§^\ã]:\âz”\é³V‹üNA},–6\ã\Åop×ª \Ëew\'Ó™9r®¥]#+\Z6V\Ïö«\î‘Ô‡jÎ£\í7‹cn\ä\Éb2rEk¬´5\Ì\ì,õ˜oh˜\0}9\×ÉŒS¨-1ödwÀº\í+\åökqd\Ýý¥\Ó;­6†\Îi‡\Ôx+\\“\é\ÝMf-ò8\Ó4K\'\á\îbús\'—‹/\'‚¯¨ ¥()J\\2«\àkšP\ZQ\Üû³À÷\Â]k\\5´\ZOr`·\ãªì­‡eG\r\äc^?`\Ò\'Ä•\Z½=JôÍ½=#n\æKd·\ÛFÏ†\Îc›óCw	$%\Ä|Kðxa÷H¬¢\Ý|¸\âµ\ç¸nŠ\î%´ ·;,³6JòiWi\n›¼UÁ*O¤MÂ‡ˆŸ\0~\ë*º\ÆoX~\Zö¬‘\'fO%\ç\ß\Þ]º1\Òõ\Ã\Î\Ú*÷,”‹«Š³½½\ÜSÃU\Ï\Ý>Æƒ€=ÿ\0§–º\Ï\è\Ã{z\Þ\ëÝ’\Þ\Ì Š\ê\Ûb²¶\Ê\Æ\Ó+jI	q9SÁOŒ\n¬JÄ±ãŠ­f†Jy9%M¨w¶\åEw¡e]#\Ññ½3EMh¹œR”¬g¼R” ¥\ã\ÜPŽO\åöÞ€0Š\ìt†“\Ô\ÚóT\ã´FŒÁ\Ü\äòù‹\è¬ñx\ë8\Ë\Ësq#„Ž4Qò\Ì\Äü\ë\ëZ¯vM\Ú`žx©¢t²®MD\ÍUv\"!÷}$ôŸ¼}io~\'a¶S\×y<‹ù\Ý\Ý\Ê·\ÆÚ©K«‡\0øD€Õ‰UPY”4ô\Ðv\Ðvý\Ø|~\Í\íuˆšå¸¸\Ô9ù\â\ã+xTšB>\ÙS’@QÏ¹8\ë´\'m-1\ÛÃ§Xpùk{k\Í{¨\Ò;\Íi˜\æo\ák|ú0†eñ1w\àyø¸ÿ\0#“V†³6\ß¼‘?Q\ÞI\Ã\îp†–ô™QŒnKGH\åJH\×V_½S÷/w\ê~\éOŠTŒ¦E)JJR€R• ò»\ä\íiM¡þ\í\éÆ±Ô»Í©¬]´vy¼£²Œò£%~†Ke`|Sóº”Rd’0ò»\ä\íiM¡þ\í\éÆ±Ô»Í©¬]´vy¼£²Œò£%~†Ke`|Sóº”Rd’:—\ï¾û\î\çS{»žßù×—Ú›Vj[\æ»\Ì\ærRyI4‡\Ø\0\nˆª5U@U\07\ß}÷s©½\Ý\Ïo\Æü\ë\Ë\íM«5-ó]\æs9)<¤šC\ì\0…DU\n‰\Z€ˆŠª *€>:€R” ¥y`‚k©’\Þ\Ú&’IX\ãEå˜“À\0“@ ‚k©\Ò\Þ\Ú&’I*F‹\ÉbO\0\0>MX\ï\é\Äúp\á\Ø8p}~uõ¡\Ã\ë©;\í¾\Û\ì¤6¤Žþö6÷\ß\rGü?³0õ¸>œO§\rƒƒ\×\ß_š!d\×r,w\Û}·\ÙHA]6§óG{|\ßfŽ#þÙ˜z\Ü&ò€R” ¥()JJR€R” 5Û¸÷ný¤\î%±W;a¯ KÕŠ½Æ”\Ô\ÐÛ†¸\Å]•\à0øó¸$\\€\êº²£­fú—\é«vúEÞŒ\Î\Äonœlns?¯-\r\ä\'ŸN\æ z‘8«p\È!YYEºÀü£Ú´§½l7p=‚“5¢1A¹ZJ\Þ[)\ì†ñx\æK	XûxK\Ç\å$	·!K†Œ\ßì­¸E\ïbO\ÔO4\áÏv\è‡I\Ó\áƒh+]$‹¿ö*\ïN\î)Ô­Y$žMsû§\Ø×·›\Â\æt\ÖfóM\ê<UÅŽCu%µõ\Ü-¶óF\Å^7F\0«+>\à‚+\Ós\ïU“‘Z¹)\Ý0\Ëñ¤Œ\\\Ñu¢ŠR•ð\Ì)JP“\ÍM_\Óy\Û\Ë¦¢\î¼\Ø/,®I%ƒn\ì®\áÿ\0hAI/ø>þrþx\ã>\ÜD\"Q\ã]­ú\Î÷\ê\Ó´b\Þxô\Æ<Œ–µ\È\Ã\Êúø\ÜyF­ö’f+}ÁrüVˆ\Òz_¡ôÍ†\Òø¨,1Ø»8­l,­\"	Æ¡4Qìªª\0\0|S<-jl¯Z©R|¼øô9‹O¸ù\ÔTÉ‡èŸ“Þ™È©¹»›\×w3µ\0À§\0|\nR¬)JJR€R•=÷»\ï\íwi\í®m¼\Û\Ù1ú—{µ.=ŸL\é‰\Î<-ÊŒ•øS\Ê\Ä>œ\\†™”\Â+º\Ù÷\Êï“´]¥6‡û·¦\Ú\ÇRo6¦±v\Ñ\Ú=\åòŽ\Æ3ÊŒ•øR-ÕñNC\Î\êQHU’H\ê_¾ûï»M\î\î{~7\ç^_jmY©oš\ï3™\ÉI\å$\Ò`\0*\"¨TH\ÔDUUT\à\Þ]\ç\ÝN¡·C7½[Ù®ò:›Uj;÷¼\Ífò·¤\×2±÷?ÁTQ@TP@P\0ùZJR€R•å·‚k©’\Ú\Ú&’I,q¢’\Ì\Äð\0\ä\Ðx&¹•-­\âg’Fh¤³x\0òy«}8¿N[¯¾¾´BÉ®\äX\ï¶ûo²ºmH\rý\ìmó}ð\Ñ\Ä\Ãû3~Û\é\Ãúp\â\Ø0}~uó¢My\"\Ç}·»}”ƒ‘¦Ô€\Ñ\ß\Þ\Æ\Ã\Þûá£ˆÿ\0‡öfý·	» ¥()JJÁ½À»‚ô\ç\ÛW§,§R]Hj\Âc\íyƒ†µekü\íùRc²´Œ‘\ç#pI\'…E\îUU˜VJ\ç\ês\î5\'q¡×”z³\ÃŸórlð¾à¿°½O/À•\ã\Þ\àþù½ñõ}_~`A@[~•‚{y÷\éÏ¹‡NXÎ£úq\Ôßˆ³¸\â\î\í”_\àoÂƒ%\Ô`Ÿ^A9Y«¡*À\Öv ¥()J\\2†\'\ï\\Ò€…Ÿ©¶-Ž\0·p-–Àúi=\ÄVûai\å\Ü$9 Á-\ã¼|–ø\ç\Ôc\'µ\\7r6÷Iî¶„\Ë\í®¼ÁÃ’\Ãg1\ÓX\ä\ì.W˜ç·•\nHúb*¬\ÝÅº+\Õ]õU¨v:“Í‹ŽO\Æ\éL¤\ëþ?+7£\' \0]xhŸ€©ñ\íÁ5\æ)µû‰|.\ÛÜ¿\ä\ìm\ã\å¹Q-†µù\É\Zg\Z®öÿ\0mô\ä`ºPž}\Í*t±\Ëpµq\îó¡ö<V\Ív\è\Øu¿\×”Ú¼ÕŠÏ¦ñNsšµr¯al\ÈL\'ô–V†÷RG\Åg¦õS¶&\ír\äi\ï\×zk\rž{„\ë“cj¹zn\êM\Óù\Ñ	\é;¢‹\ryªð\â\ßWnI9—õc\âX-Y?\Ø\í\ÏÁ17¨Tû«\Ï ?¾x?Ò¼–X\Û\Çil#‰ÆŠ8\0\nór<ýó«––š:Zv\ÄÍL\Í+õ\âªÿ\0xš\áP¹¾G+—»‚tLýR”¯A¨¥()Q\ã\ß{¾ö\×vŸ\Ú\æ\ÛÍ½“©7»R\ã\ÙôÆ™‘ü\á\Ã\ÂÜ¨\É_…<¬@ƒ\é\Å\Èi™H\"»¨û\Ý÷¶»´þ\×6\Þm\ì˜ýK½Ú—Ï¦4Ì\ç\åFJü)\åbN.CL\Ê@\á\Ýjs¼›Éº=B\îŽw{7¯\\\ä5.ªÔ™½\Í\æò“y\Íu3}\Ï\ÙT\0Q@TUUP@\r\ä\ÞM\Ñ\êts»Ù½z\ç!©uV¤\È=\îo7”›\Îk©›\î~Ê \0ªŠ¢ªª€ª\0ùzJR€R•å··š\êd¶¶‰¤’Fh¤³1<\0\0ù4\Þ	®¦[khšI$`±ÆªK3À\0“V<úq>œHv\ß\×\×_:!d×’,w»}·\ÙH]4¤Žþò6ù¾#†Ž#þÙ›ö\ÜN\'Ó‰À[\àúû\ë\ëD,šöEŽûo¶û\'\0+¦”€\Ñ\ß\ÞF\ß7\ÇÙ£ˆÿ\0‡öfý·	» ¥()JX7¸/pNœûkt\ã”\êG©Mø\\}§0aðÖ¥Zû;~\ÊLvV‘’<\än	$ð¨¡Ê¢³pN\à9v\Ö\é\Ë)ÔR:§ð˜\ëN`\Ã\á­\nµþvü©1\ÙZFHó•¸$“Â¢†weEf\î}\Üÿ\0¨\Þ\ê}F]o¶û\äÿ\0	Žµ[h\Ýep\Ía§¬K!ˆ<\ån¥œ€Ò°Ê‹h¹÷sþ£{©uu¾\Û\ï”ü.>\ÔIm£tm•\Ë5†±-È† xó•¸V–rJÀ{*,q¦¶Ò”\Çv\É\îo\Ôok£m7\ïa2þ½Ç…¾¯\Ò“²\Øj\0Ü˜&Ÿ^X\Å0¢c\È\åY\Ñ\íñ\ÛÓ¸gN\Ì:r\ÆuÓ†¦üEÁgpwl«¿\n–wQ‚|y0\ådR®„«Ty­Ž\í“\Üß¨\Þ\Ö=F\Úo\Þ\Âeý{;}_¤/\'e°\Ô6¹0L>.¼±Š`DÇ‘Ê³£v\êV	\í\é\Ü3§N\æ9c:Ž\é¿S~\"\Î\àˆ3¸+¶U¿Àß…K;¨Á>¼òr²)WBU¬\í@)JP\nR”G\ÕQŸDg¨Þ\Û}4v$M©ö½¤\É)‰9yñl^\ÇþUTŸ\ß\à@À{½HšûÁø¯S5‰\Ç\êE\Î+iö·P´WL’Da\Ã+\ìA‚\ryk)™YLø±\Èn°\å\î«^\à¸@¿nE\æ›Óªf…8=\È\æ‡\ØñY÷¹ŸH—]u¬v&y\r\à¿\Ò\ÒI\Éõ1—\É\äû±–…›\îð±¬G<š¦\ê }<\î‰\ÛZ¹¥¶[¥=\ê\Õ\rt›dj9:¦`¨#òŸ\çS©ô¸t®t?O\Z§ª\Ìþ?\Æ÷\\e¿…•\×\ãfYK©ûyÜ´\Ê\Ã\ïøt5¸\\6SQe\í0K7¸¼¿¹Ž\Þ\Ò\Þ1\ËK+°UQú’@þµm¾”6;\ÓoMú+c4\äJ¶šgN\Ú\ØzŠ¼z\Ï`<§þÓ¿““÷,MJ0½«t\î\Ø\Ôó_ðPþ\Ñ8hpü6¸\×\'N\ì\Ýô·_š\ädn\Ï\àOšUŒq€¥)@)JPžf\Û!ˆ»²\ÄeM\Ü\Ö\Ò%­\è…d6ò!dðogñ$\ìx\à\Õ1û\ÐôK\Ö\ïF=oj{>¸µ&CW\æõ~B|¶#sgV6ú²Ü°¼dûD\è\n#\Úÿ\0òü\"(1˜™®‰X7¸o®œû•ô\ç”é»©\r/ø¬}\×3\áó6¡Vÿ\0|ˆ\ïm$ øH¼A\å]K#†Ve QÖ•²]Ï»auÚ³¨Ë­Š\ß|g\âñ\×~¥Æ\ÖVV\ì¶:ŠÀ0h‰\ç\ÂE\åVX	-\î\È\Ñ\Èú\Û@)JP\n\Ü>\Æ]Ytƒ\Ñop\Ý%½ýjm$z—KÚ“\r†YÕ¦þ\ê\ä\Ó\Ñ\Ëþ.}xðY<ýX\ÃI)\Ó\ÊP\æÑš\ÏI\î6’\Æk\í©ls8LÍ”W¸Œ¶.\ég·¼¶•C\Ç,R!*\è\ÊA\Z\íªª?O‡\Ô«»mj\Û>˜zž\Ì_fv/5}û)4÷\Z2\âFå®­\Ôr\Ïj\ÌKMn¾\à“,c\Ï\Í&´ÆŒ\ÖZOq´–3_hKc™Á\æl¢½\ÄeñwK=½å´Š9b‘	WFR`x \Ðµ)JXc®þ»:v\í\ÕÓ¾_©^¥ur\ã°\Ø\åô¬, ñ{\Ü\Å\ë)1YZDHõf\í\ÈUP\Î\åQ‡=vu\×Ó·n®²ýJõ\'¬…\Ç/¥aao\â÷¹‹\ÖRb²´ˆ‘\ê\Ìþ\'\ÈUP\Î\åQ…B»ªwU\ê+»Q3\ï&ò\ß6;Ži-ô>ˆ³¹g²ÀY3\â¼ñ\ê\Îþ*eœ€\Ò0\0DŽ4\Õ\î™\Üÿ\0¨\ê½L\Þ\ï¾ó\äe³\ÄZ4–\Ú#FAt^\ÏN\ã\Ë!\Ø•üU¥œ€Ò°º‰\Z&´R””¥\0¥)@l—k\Þ\æý@v°\ê^\Ã6S%-\Ö2wŽ\ßY\èù\îŠY\ê,xnZ	}ˆI–h¦\nZ\'<ŽU\à=õ\éÓ¯q®q=JtÙ«Eþ\' ¾–Kqâ·¸k\ÕPe²»ˆ\éÌœ¹WR®…‘•+g{XwN\ê+µQVûÓ²·\í…¿1\Û\ë]yp\Ëe¨,•‰ôß€}9“–1NhØŸfF’7\ëô¬-\Ð_^:÷\Z\é\×Ô§Mš´_\âr\éd±·+{†½U[+¸>œ\É\Èû•u*\èYX\æšJR€R” \"\êž\éY³zCõ§±žW;\ÖÀjc–6“ó%³¹û$s+§ý\ë¡PžO5lŽ¿:z\ÆõQ\Ñ\æ\à\ì]ý”sË\ÓW	õG\";\Ô_R\ÚOòN‘7ùj§O»\Å4lŽŒC+¯òª\ß\Ò$5©2lzy¡\Úþ\Ï8‰nXfKl‹ñ@\í_Kµ§‚\æ†\Îök\Ø\×\ß\î\ä»_¥§³y¬±\Ï\í\ìƒ\åQ,Q®S\È\Â\ÓGû•h˜”\"\Ô{¨*úT¶\Ò\ßRû—»2Û‡8\r%i\Û\ß\Ä\ÞÜ™=¿\â\Èÿ\0Nju\Ã\ï\ÅHp¬	³µ½Ê«á¨¥´ývu\Ã­:/\Ã\ZÞ«­}Pæ”¥I\ÊDR•…·{¸?G;Ô¶ˆ\év÷\ë	„\Ü-\ÂGm/§¯\'!\ç\àø ‘Àð€\Ê\á’)_YÕ’?&P¦”¥\0¥)@`\Þ\à¾úr\îUÓžS¦þ¤´·\â±\×|Í‡\Ì\Ú[üðR#½´ƒ\á*òAu,Ž”\Ô#¹ÿ\0l£{Vuu±;\íŒü^:\ïÔ¸Ñº\Ê\ÊÝ–\ÇPØ†\0M<øJ¼ª\Ë%¢b=\Ù\Z9\í5ƒ{vû\éÏ¹ONYN›º’\Ò\Â\ïw\Ìø|Å¢ª\ß\à\ïÂ‘\í¤„NU\ä‚*\êY23)Ž´­š\î‰Ú³©ŽÔ›ý&\Î\ï¾%oq–}­±ð0°\Ôhüz‰\É>”\Ê\nú¶\ìKFX{²2Hú\Ë@)JP\n”\ï§\Ã\ê\ÕÝ¶µmŸL=Of/³;š¾ý”¿š{q#r\×V\ê9gµf%¦·_pI–1\ç\æ“E(óh\Íe¤÷Ic5öÔ¶9œf\Ê+\ÜF_t³\Û\Þ[H¡\ã–)•te †‚\rbþ»:\ë\éÛ·WN\Ù~¥z“\Ö\Â\ã—Ò°°·ñ{\Ü\Å\ë)1YZDHõfÀ\ä*¨gr¨ŒÂµ‡~¢\Ú\á§\Ø.¡qù­i²\×b{‹^=\ÒL†›½!Ÿ\Ê\Ë\ÕuV‚Wö’eP\ÌeB\ÔYu‡º§u^¢»°u>òo-óc°\æ’\ßC\è‹;–{,“0>+\Ï¬\ï\â¦Y\È\r#\0\0TH\ã@\Õ;ªõÝƒ¨™÷“yo›€\Ç4–úDYÜ³\Ù`,™ñ^xõg2\Î@i\0¢G\Zjõ)@)JP\nR³2vü\ë^Žß¯¨ö8v™3\Ùm«\Ä#\Òõyñõ|9õ?\ê~\Ëñ>—«û???\Ë@ašR””¥³½¬;§uÚ¨«}\é\Ù[ö¿\Âß˜\íõ®Š¼¸e²\ÔJ\ÄúoÀ>œ\É\Ë§\0´lO³#I\ÛÛ ¾½:u\î5Ó®\'©N›5h¿\Ä\ä\Ò\Écn<V÷\rzª¶Wq}9“‘÷*\êUÐ²2±£el\ïk\é\ÝEv£\ê*\ßzvVý¯ð·\æ;}k¢¯.lµ’±>›ð§2r\Æ)À-\ì\È\ÒF\à]~•…º\ëÓ§^\ã]:\âz”\é³V‹üNA},–6\ã\Åop×ª \Ëew\'Ó™9r®¥]#+\Ó@(IÆ” <W,ð4l9òR8ªª÷D\Øö\éß¸\ê\í„6¢+Hµ\\ùlH¼*Z\Þñy/ñ\n“ª”Õ«@\àü}\ê¾¨\í³]1\Öö•\Ü{[EŠ\rI \ãŠWT\ãÔ¸µºœ3÷>œ\Ð/òQQlWIn÷›Ú©ç¨½½Ÿ.Î¡Æ®¥Uøfb§V\ëO\îmÒŸ·Q\âúa\ÜmÓ’\ß\Â\\Î¸Lxb=\Þ+[HO\ê<®¤\Ì\Z•…pk@~›,2\âûd\à\ï‚ñý¥©2\×ñó\Å\Ó\Å\Ïþ•oð<ûñü\ëkfbGl‰©À€i&­õ˜\æ¾WÈ©\Ñ2Dô9¥+A;\åw\É\Ú>Ò›Cý\ÛÓc©w›SX»h\íóyGe\åFJü)–\ÊÀø§!\çu(¤*\É${B;\åw\É\Ú>Ò›Cý\ÛÓc©w›SX»h\íóyGe\åFJü)–\ÊÀø§!\çu(¤*\É$u1\ßÿ\0\Þ>¥7‹7\ÔønCP\ë\rC‘7¹\\\åôßµ’_o8¢\0ªˆ€**ª¨\n \Îû\ï¾\îu7»¹\íøßy}©µf¥¾k¼\Îg%\'”“H}€\0p¨Š¡Q#PUTP\ÇP@úpþ£\Èwò@}}k‘»c±\Û\ÝÁ\ÊN\0ÔŠ\0X\ì/dc\í}ð±\Ê\Ä{+[ƒ<\ÞU ž[i’\â\ÞVŽH\Ø2:7X{‚ø<ÕŽ¾œO¨\î-ýƒ\Ð_Z\Ýc\×q¬v;}¸YI€\Z‘G…\ìŒ}¯€\ác”ÿ\0ˆöV>·p&ö”¥\0¥)@až»º\éÛ¸§N\Ù~šú•\Ò+‘\ÃdWÕ°¿€*^\á\ïUHŠö\ÒR¥2r}ø*\ÊY2;)¨Wu^\Õ]Evž\ê&}œ\ÞK\íE¥¸\Ñ\Z\Þ\ÎÙ’\Ë?d¬’òO¥:y(–KF\ÄY\Z9\ëu†z\î\èO§n\â;eúk\êWH®G\r‘_V\Âþ\0©{‡½U\"+\ÛIH>”\É\É÷\à«)dp\È\ì¤\n4Ò¶‡º¯j®¢»Ou>\Îo%öŽ\"\Ò\Ühogl\ÉeŸ²V\Éy\'Ò<”K%£b,«\Ô”¥\0¥)@)JP\nR¥;\éðú|uor][g\Ô\ïS˜{\ì6\Å\áo¿e-\rÆ³¸¸k[v2Z«³\\/¹ \Åóóx@}>OŽ­\îK«lú\ês}†Ø¼-÷\ì¢å¡¸\Öw·\rknÃ†KU`Vk…÷$£>~o\r¢b\Ùýª‡j†\ÅC·5\Ñ+ƒþ\Æ\ZLb\âþ\Îþ\Îô½/\Â~\Ç\Óô}?\É\áÇ·\ï\è\Ý¤ö\çIc4\ÓV8l&\Ê+,N\'j°[\Ù\ÛÆ¡#Š(\ÐDU\0€v\ÔVþ¡?§¯Tv\æ\ÕW½Sô±„¾\Ë\ìfb÷›«@Z{q#p¶ó±\åžÍ˜…†\á¹*HŠS\å\àóE=_£Wi-/¯ô¶GCk9c˜\Ãe\ìe³\Ê\â²V«=½å¼ŠRHeÁWFRAR ‘Uoú…>ž½QÛ—T\ÞõM\Ò\Îû1±™{\în­T´÷\Z.\âF\ám\çc\Ë=›1\ÃrT‘‡\ËÁ\æ)\éJP\nR”\Îö°\î\ÔWj>¢­÷§eo\Úÿ\0~c·Öº*ò\á–\ËPY+\é¿\0ús\',bœÑ±>Ì$oon‚úô\é×¸\×N¸ž¥:lÕ¢ÿ\0_K%¸ñ[\Ü5\ê¨2\Ù]\Ä	ô\æNGÜ«©WB\È\ÊÆ•³½¬;§uÚ¨«}\é\Ù[ö¿\Âß˜\íõ®Š¼¸e²\ÔJ\ÄúoÀ>œ\É\Ë§\0´lO³#IuúV\è/¯N{t\ë‰\êS¦\ÍZ/ñ9ô²XÛ½\Ã^ªƒ-•\Ü@ŸNd\ä}Êº•t,Œ¬sMù>H÷\â¢\ê¿\Ûg»Û£\ÝÄ‹…\Æ\ç²8™“us(?ýqü\ÍK\à`O}ª6¾¨¼\"\äû|\á/ü98\Ý\È\Ç\Üü9µ¼‹ŸýZ\Ô\ß#I-R§v~ÿ\0Eµn£\Ç\ÔMò\"tr*s\'ý=Ø¶\Åö¤\Ûf•x{‰sú6^ð¯ÿ\0oºÀ“ýkJ~žÜ«\å;Q\í²HÀµ¼¹ˆO\è-xÿ\0·Æ·X?¥z­ù~,¿Šz\Z<a\Ûü\Õ[\Û\Û\ï_ÿ\0Òš\r\ß+¾N\Ñö”\Ú¦ô\ãXj]\æ\Ô\Ö.\Ú;G<¾Q\ÙFyQ’¿\nC%²°>)\Èy\ÝJ)\n²IK÷\ß}÷s©½\Ý\Ïo\Æü\ë\Ë\íM«5-ó]\æs9)<¤šC\ì\0…DU\n‰\Z€ˆŠª *€-¡\ß+±®\Ñwk\Ú\ï&œ[5¼\ÚjÁ—Gk‡\Æ;\Ø\Ç,1·\åAg¶f\'\Åø/±uZH\ä©~û\ìF\îôÇ»\Ù\í‡ß¦µf™¿kL\Î#Œ\È8 ‚9WFR®’)(\è\Ê\ÊJ°\'\ØGŽ¥)@+\Ëò\ÚÌ—6ó4oGFá”ƒ\È ƒ^*P@úq>£\Èwú@}kuMw\Z\Çc·Ûƒ”Ÿ©\0\ác°¼‘¾/¾9Oøec\ëpg›Ê D\Ík2\\[J\É$l\Z7F\à©\à‚>«}8¿Q\ä;û .¾µ\ÂÇ®\ãX\ìvûp²—\0.¤Q\Â\Ça{#kï…ŽR\Ú=•­Áœ	»¥)@)JPg®\î„úv\î)Ó¶_¦¾¥tŠ\äp\Ùõl/\à\n—¸{\ÕR\"½´”ƒ\éLœŸ~\n²–GŽ\Êj\ÝWµ_Q=§ú‰Ÿf÷–\È\äp9–\ãC\ëk;fK,ý’°k\É>”\é\ä¢X	-Adx\ä{zõ\Ù\×_NÝººv\Ëõ+Ôž°\\n¾•……¿‹\Þ\æ/YIŠ\Ê\Ò\"G«3øž!UC;•Df\n\î­\ÝS¨®\ìDÏ¼›\É|q\ØsKo¡ôE¥\Ë=–É˜\äVwñS,\ä‘”\08\Ð\r^¥)@)JP\nR”§}=ÿ\0OŽ¬\îM«,úŸ\êw}†Ø¼5ñô¢å¡¸\Öw1?\rknÃ†KU`Vk…÷$£>~o\r¦4nŒ\Ò{s¤±š@\é«6e–\'‹µX-\ì\í\ãP‘\Åh¢*€Àª\Íô÷ýAÚ³¶Ö­³é‡©\ì\ÅögbóW§Ò—óOq£.e~Z\ê\ÝG,ö¬Ä´\Ö\ë\î	2\Æ<ü\ÒkL\è\Íe¤÷Ic5öÔ¶9œf\Ê+\ÜF_t³\Û\Þ[H¡\ã–)•te †‚\r\ÛR” \Õ\ê\í#¥õþ–\Éhms¦\ìs\\½”¶ylVN\Õg·¼·‘JI±¸*\è\ÊH*A+´¥UŸ¨O\é\ì\Õ=¹uM\ïTý,\áo²û˜¾\æ\ê\Ñ|\ç¸\ÑW7o;Y\ìÙˆXn’¤ˆ¥>~4T\Õú5v\Òúÿ\0J\ä´6¹\Óv9Œ.^\Ê[<¶+%j³\Û\Þ[È…$†X\Üte$ ‚V\ï¨S\é\í\Õ]¹uU\ïT½-ao³˜¾\æ\ê\ÕKOq¢\î$n\Úv<³\Ú3°\Ü7%IH|¼`\"¢”¥\0¥)@l\ïk\é\ÝEv£\ê*\ßzvVý¯ð·\æ;}k¢¯.lµ’±>›ð§2r\Æ)À-\ì\È\ÒFöö\è/¯N{t\ë‰\êS¦\ÍZ/ñ9ô²XÛ‚«{†½U[+¸>œ\É\Èû•u*\èYX\Ô\'µk¢»­õo²»-`l0¶;k­o-™¬´ý“1£ñÇ©3ð\Â(\r#î¨²H–ö\è/ ¾{rô\ë‰é¯¦\Í$,18õõrY+€­{™½e[Û¹@¤\ÏÀûE\nˆTš<‡Á­ú‘ð\Ã#\ÛP\ß\çû?P\âg§7‘\Åÿ\0¹[õ\â+A~¤Œ\È\Çv\Å\Ô6$øÿ\0hjLú^G/þ\Ýk®Ÿø\ésþ*Kpkó•go¼o©\ãúl³+“í•„±/\Ïön¤\Ë[‘\Ï\Ç7O/ú¿\ë[ü\0æ¢›\éP\Üxò1n6\ÖKp^\\6¸L€Rß¹Õ¤H\è<­d?Ìš••<ý«ø³½$¶D©Àõi*‘\Ôx\æ¾\'È«\ÑrTõ9­\ï•\Ø\×h»µm	Ôºqlt\Îói«]¬^\ïc°\Æß•žÙ˜Ÿ\à¼\Å\Ôi#“)[BP\Ó}ö#wzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHd\à‚9WFR®’)(\è\Ê\ÊJ°\'\ãª\àò»\Z\ív­¡:—N-Ž™\Þm5bË£µ‹\Ã\ã\ìc–\Ûò ³\Û3\âüØº‚­$rT\Ã}ö#wzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHd\à‚9WFR®’)(\è\Ê\ÊJ°$Ž¥)@+\Ë\ÄÖ³¥Í´­‘°h\äFá•\äGÁ\æ¼T ,ô\â}Gpoô8>:ú\Ö\ë¼#²\Û\íÁ\ÊO\Â\êE\0,v’1ö¾ã…ŽSþ#\ÙXú\Ü\æò¨\ÄÖ³¥Í´­‘°h\äFá”ƒ\È ƒV=úpþ£¨7þ\ß\Ð\'_:\Ýc×‘¬v[}¸99À]J Ž\ÂòFø¾\Ë§üG²·\í¸37U†z\ìë¯§n\Ý];eú•\êOX.7Ž_J\Â\Â\ß\Å\ïs¬¤\Åei#Õ™üOª¡Ê¢3]uô\íÛ«§l¿R½I\ë\Æ\áq\Ë\éXX[ø½\îbõ”˜¬­\"$z³?‰\àrT3¹TFaP®\ê\ÕzŠ\îÁ\ÔLûÉ¼·ÍŽÀcšK}¢,\îY\ì°LÀø¯<z³¿Š™g 4Œ\0Q#\0wT\î«\ÔWv¢g\ÞM\å¾lv\Ò[\è}gr\Ïe€²f\Åy\ãÕüT\Ë9¤`\0\n‰i«Ô¥\0¥)@)JP\nR”¥;\éðúƒµwm­[g\ÓSÙ‹\ì\Î\Åæ¯¿e/\æž\ãF\\HÜµÕºŽY\íY‰i­\×\ÜeŒyù¤\ÑcJü\Ú3Yi=\Æ\ÒX\Í} u-Žg™²Š÷—\Å\Ý,ö÷–\Ò(x\åŠD%]H!\àƒ]µUG\éðúƒµwm­[g\ÓSÙ‹\ì\Î\Åæ¯¿e/\æž\ãF\\HÜµÕºŽY\íY‰i­\×\ÜeŒyù¤Ö˜Ñš\ËI\î6’\Æk\í©ls8<Í”W¸Œ¾.\ég·¼¶‘C\Ç,R!*\è\ÊA\Z¶¥)@+«\Õ\ÚGK\ëý+’\Ð\Ú\çM\Ø\æ0¹‹)lò¸¬ª\Ïoyo\"”’)cpUÑ”T‚<WiJ«PŸ\ÓÛª{qj«Þ©zZ\Â_f631}\ÍÍ²ùOq¢\î%n\Úv<³\Ú3°\Ü7%IH|ühª«ôjý#¥·J\ä´6¸\Óv9Œ.^\Ê[<¶\'\'j³\Û\Þ[È¥$ŠX\Üte$ ‚	VÏ¨K\é\í\Õ=¸µU\ïT\Ý,\áo³˜¾\æ\æ\Øž\ãE\ÜH\Ü-´\ìyg´f!a¸nJ’\"”ùø<ÀEUl\ïk\ÖEw[\ê*\ßevZÀ\Øalw\Z\×Z\Þ[3Yiû&b=G\ãRg\á„P\ZF\ÝQd‘8\íc\ÚÃ¨®\ëE[\ì¦\Ê\Ø-Ž\ãZ\ë[\Ëvk-?d\ÌG¨üq\êLü0Š\0CHÀûª,’%½ú\n\è3§NÜ;bzk\é³IM‚ú¹,•ÀV½\ÌÞ²-\íÜ Rgñ`¨¡Q¢ª€tÓ§nN±=5ôÙ¤…†&Á}\\–J\à+^\æoY@–ö\îP©3ø°TP¨QUFi¥(Ž9?j¯ª\'4¸\Î\Þøk\'%¹û~9ù\â\Úò_ý¿ô©%b8 \ÔA}X—%ž\Ü\í\ÑG/\å\Ég²9i\ÂÁ*Oÿ\0X\Ü#Z‹\ä‰ªU\î\ËÄŸh²‘Õ˜þ‰ºDrònkýŒMô©\îL8N¦7/i¥¸\n\Ùý%k’	\ã\È\Ù\\˜ý¿‰\âûÿ\0…Nª	þW^\Í[\è\ÛÜ—l5M\Å\ãEe—\Î`d\0n‰|lžGþšH_ü‚­«\Æ|\Íx0­BKlFç­ª©ã¬˜\éú\Ò\ë~9uB\'\Ã3Z\äæš—\Ñ\Ý)J“€­\ï•\Ø\×h»µm	Ôºqlt\Îói«]¬^\ïc°\Æß•žÙ˜Ÿ\à¼\Å\Ôi#“)@P\Ó}ö#wzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHd\à‚9WFR®’)(\è\Ê\ÊJ°\'\ãª\àò»\Z\ív­¡:—N-Ž™\Þm5bË£µ‹\Ã\ã\ìc–\Ûò ³\Û3\âüØº‚­$rT\Ã}ö#wzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHd\à‚9WFR®’)(\è\Ê\ÊJ°$Ž¥)@+\Ëo<Ö³-Í´­‘°h\äV!•\äGÁ¯(\ÉÕ§_}`u\Ê4§üª÷\Û5¬—D\àc\Äiµ\ÉÊ¼[@ ‘‚\ê\Ï\'Šú—\å,¾\æ\í\â8\Ãt¥\0¥)@)J”\ï§\Ã\éñÕ½\ÉumŸS½Na\ï°\Û…¾ý”\\´7\Z\Î\â6\á­m\Øp\Éj¬\n\Íp¾\äƒg\Ï\Í\á\Ð\ì9ô\ë\ë\î\è\æ}ý\ê!™\Ñ{-h³\Û\Øe1\è‘\ä5%\èž6^ª2¬?¼“²²–SÞ£E¬=Õ»Uu\Ú¨™öoy,NG‘in4>·´µd²\Ï\Ù+ä¼“\éNžJ%€’Ñ±GŽGº.ÑšOnt–3@\è5c†\Âal¢²\Ä\âqv«½¼j8¢\0TEP\0P8\0V/ë»¡>»Št\í—é¯©]\"¹6E}[ø¥\îõTˆ¯m% úS\'\'ß‚¬¥‘\Ã#²(\ÓJ\Úê½ªºŠ\í=\ÔLû9¼–?\Ú8‹Kq¢5½³%–~\ÉX%\äŸJtòQ,–ˆ ²4r>¯P\nR”¥°?\Ô)¸=³õv?§£r—Úƒa²·­\ê@§»\ÒJÀµ\å ³Û–%¥µ>M$c\ÔòI¢ú”øvÿ\0_\è\Ö\Ðø\Ë\ÛMY\Î\é\ìõ„W\Ø\\\Î*\ég¶½¶‘CG,r)!•”‚®\îªyôÿ\0}@:ßµþ¸·\éó¨<ŽC=°ùì‡•Íª†ž\çH\\\ÈÜ½õšK@\ÌKMl¿½\ï,c\ÔòY­S·Û¢7_C\âw/m5f?=§³\Øø¯°¹œU\Ú\Ïm{m\"†ŽX\äRC+)@wT¥(uz¿Hi]À\Ò\Ù-\r®ôÝŽc˜²–\Ï-‰\ÉÚ¬ö÷–ò)I\"–7]IH ‚k´¥‰ú>èŸ¦>‚¶lJ;Qc¤ô\é\ÈO}=µ³¼²\Ü\ÜJÜ´³M+4“0(¥Ø•DD*€2\Å)@)JPr±\0¿Två®¦\ëwJm½­\Ú\É›\Ðq\Í*+ó\é\\]\\\Î]HûNòaS\ïq2CI!ý\Õ\ä\ÕU;¢oƒu\Üuw:;ŸV\ÒMW>?\"?*ö¶@Y\Ä\ëü$\nÿ\0\ç5Å“¤v\ä{—\ÓY{û>Z]]]U—\Ãz»Rsa³9M?˜´\Ï\á/^\Úò\Â\æ;‹I\ã<4R£F¨`ô«nôŸ½ø¤ºp\Ñ[é¦¥Ck©´\íµÿ\0‚7>‹\É/ÿ\0´\ä„}Š‘Uøö©\Öú\\z©:ß§SÒ¦!\çy¡²ÿ\0\Â\Æ\ì98\ë\Ò\ÎÈ£\ï\áp³3·®‚´XF¯\ÜÕº\Ø\ä\Õ\Í?Ál{D\á\ÇW\áøn‘¦n\Ù;\év¯%È•jS‘ñ\Í*\Æ8ÀR”  }ò»\Z\ív­¡:—N-Ž™\Þm5bË£µ‹\Ã\ã\ìc–\Ûò ³\Û3\âüØº‚­$ro\å(\n\Zo\Æ\Än\ïL›»ž\Ø}ù\ÐW\ÚkVi«\æ´\Ì\á²1ø\Éƒ\ÜG*\è\ÊU\ÒE%YIVüu[û¾c¥\îÍ³ªtÅ½–žÞ/Žq£ug¤r¾N1—\Ä{½»±>\î\Ð;^U¤ŽJ”\ï&\ÍnO[£\Ù=\ë\Ð\Ù\r5ª´\ÖA\ì³xL¤>ZÌ¿cöe †WRUÕ•”•`H/JR€R” ¥J/\Ó\Ï\ØRw1×°õ!Ô–#‰Ø­?{Áa\åº\Æò7á¬­\Ü\Ël¤=\ÂýÁŠ2$óh@ö~Ÿ§\ÃWw$Õ¶}Ou;ˆ¾\ÃlV\ZûöQr\Ð\Ük;ˆÛ†µ·a\Ã%ª°+5\Âû’QŸ?7†\Ó\Z7Fi=¹\ÒX\Í tÕŽ	…²Š\Ë‰\ÅÚ¬övñ¨H\âŠ4Q@@\àM£4–\Ü\é,f‚\Ð:j\Ç\r„\ÃYEe‰\Ä\ã-V{;x\Ô$qG\Z\0¨Š \0 \0\0®Ú€R” 0\Ï]\Ý	ô\í\ÜS§l¿M}J\é\È\á²+\ê\Ø_À/p÷ª¤E{i)Ò™9>üe,Ž”\Ô+º¯j®¢ûOu>\Îo%‘\È\àr-,ú#[\Ù\Û2Ygì•‡\æ^Iô§O%ÀIhØ‚#G#\Ýn°OqžúN\ë_¤\íQ´]fY\ØC£a°—#6¤»ºŽ\ÚM7$1³”72~[w‰|‰cù\ny«†Fe Q\æ•ô\ÛÃ¥ô&‹\Ý}K¤6»p—Wi¼^v\ê\×ªS%˜\Ë\Ù\Ç+,W^„ŸžQ¿ƒ{¯—¾f€R” \'?O\ï\Ô®;ak‹~Ÿ:‚\È\ä3\Û\Èy]Z¯”÷:B\æFü\×\Ök\îZc\å5²þ÷¼‘S\ÉfŒjP\á\Û\íÁ\Ñ³¡ñ;™¶z¶\Ã=§³\Øø¯°ÙœU\Ò\Ím{m\"†Icu$2²A\Ý\Õl>~¸ú\î\Æu?Dz3C\ä5\Î\Ë\\[Í’\Ô\\\Ü‹A\ÈÁ™n\á™ÿ\0(I\å\rh=\ävic\0¤\Å\ìŸ@)JP\nR””¥†ºý\êÒ¿G›ƒ¾—×±Á.M\ÜIŒ2io]};hÿ\0\Ï;Ä¿æª\É,“\ÈóM+;»\ÌÇ’Iù$ý\êk~©þ©\Û	 4?G\Ú{%\ã>võ³ú†8\äá…¤\ÇnŒ>\ë$\Í#ÿ\0Þµ\n9ª\ÛV$Õ©\nlby©\Úþ\Ï8um¸fK”‰ñN\í_Ku\'Š\æ pO½l\ÏhÎ²S¢¸ô®\é\æ\ï„\Zo*\ç«]›…K–@f?¤R¬S¹>kYOûSƒ\Ç5¦ôµ\r•»Z¹—mú\ÑM~´Oo3lVø¦Þ…\É,\î­\ï­ã¼¶<r h\ÙO ƒ÷¯0 µh‡\Ó÷\Öÿ\0ü¬º(\Ç\è=Y˜\Z·mLX<¸–^ež\ÕWýŽ\àü“\åúe‰\åž		ù­ðù>\â®JZ–US¶V\ìrf~h\ß\ìõX~ñ5¾¡2|nV¯\ê™)\Í)Jôš‘JR€Tx÷\Ý\ìCµ\Ý\Øv¹·oc\Ç\é­\î\ÓXöM1©\äOs¯,1·\åG-$úrðZbG(Î!Ô (W¼{7º==nŽwe7¯Cd4Öª\ÓY²\Í\á2øMk2ýÙ”‚]IWVVRU?/V\î\ï»Ø‡k»°\ísn\ÞÇ\Ó[Ý¦±\ìšcSÈž\æ!^XcoÊŽZ\"Iô\å\à´,ÄŽQ\Z§;Ç³{£\Ó\Ö\è\çvSzô6CMj­5{,\Þ)„Ö³/\Øý™H!•Ô•uee%X\ËÒ•\'?O÷\Óû®;Ÿk›~ zƒ\Ç\äp;\Èqst¥¡¹\Õ÷·æ±³b°)3\\¯\îû\Çõ<šO\ï\Óý­ûŸk‹~ ú„\Æ\ä0;¿\â\æ\å< ¹\Õ÷1·\rcfþ\Å`Vg¹_\Ý÷Š3\êy46©\Ûý¿\Ñ;Q¢1[k¶šO‚\Óø|V8l6*\Õ`¶²¶B\Çq¨UT\0\0¦\ß\íþˆÚŠ\ÛM³\ÒxüžÀ\ã\â±\Ãa±V‹µ•´j8£@\nª \0wT”¥\0¥+«\Õú»Kmþ–\È\ës¨\ìpø\\=”·™\\®J\é`·³·K\É,²9\nˆª	,H\0@5v­\ÒúKduÆ¹Ô–8|.\"\Ê[Ì®W%t°[\Ù\ÛÆ¥\ä–Y…DU–$\05Vÿ\0¨O\ê\Õ=\ÆuE\ïK=,f\ïpûˆ¾\â\î\åCAq­.#~V\âu<2Y«\0\Ñ[·ˆ\È<¼>¡_¨OT÷\Z\Õ7½,ô³›¾\Ã\ìf\"÷‹«¥ò‚\ãZ\\FÜ­\Ä\êxd³V¡·n%yx$1Q@)JP\nR”¶;¶Olž£;¦õg°›‰ü=¿…Î¯\Õ×¶\ì\Ö\ZvÀ·yˆ\ã\ÍÛ†\ÂiXp8UwGlž\Ù=FwM\ê6\Ïa6ø{;_«¯mÙ¬4\ínóÇ›·#„Ò°\àpª\î–ø\í\é\ÛË§>\Ú8\ã:q\é\ÃLþ\Òß‰ó¹Û¥V¿\Ï_•KË©\0N\Üpp±¨T@@ ½;yt\ç\ÛC§gN=8iŸ\Ã\Ú[ñ>w;tª\×ù\ëò Iyu \ÉÛŽŽ5\nˆ¨©JJR€R” ?*yû|W§›\Ë\ãôö\"\ç5”»K{[H\Z[‰\åp«\Z($³\ì\0\0’Oð¯tö¨\ëúŒº\Þnœ:?m‹\ÒQ§\Ý—¢\'\á\íñj\Þ\ÉþedƒßŽD\ìGºW–²¥””Î•\Û\r\Ö²T\â+\Ü\è7H\äNI½z&jC/s.¯nz\ß\ëCX\ï¬7>[±\Ò\ÑI\Èôñ–ü\Ç	\àû©“†™—\ì\Ó0¬GŠW? “T\åDï¨Ò»k—3ô¶\Ëk§²Z¡¡2lmF§D8¥)X\r©±Ý­ú\í\Ïvÿ\0\ê\Ï»‹qq&˜\ÈÖ¸\èyo\Äc\äa\å\"¯\ÞHX,©\Ç”)\È\Õh#ªp\Z\çK\ãõŽ–\ËA\ÊY\Åua{k(x®!‘C¤ˆ\ÃÙ•”‚ù©\Ò=‡<T\Õ}7}\Îl³zn.€7—<W+ŒYgÛ»\ë©ÿ\0\ÅZ\0^KO¿œ_\ãü\Åä£ò™\ákªDÿ\0\ÂÊº—\å\çÃ©\ÌZ}À.®§Ký3{)kw;¦þ\îDÀÒ€ò9\ä\Z°N@¥()JQ\ã\ßw±\×wa\Ú\æ\Ü=½¦·»Mc\Ù4Æ§‘<!\ÌB¼°\Æß•´D“\é\ËÁhY‰£:4‡R€«f/¦k¨ž®úŠ\Êeú\ì\Û|þ\Þ\í–\Þ\ê	,56;#[_\êKøó\ØZ0ø·øõ.Ð•*Áaff/¡6ûo´>\Ôh|N\Ùm¦“\Ç\àtöŽ\rŠµXm¬­£P±\Å\Z(UT\0\0®\î””¥\0¥+«\Õú»K\íþ•\Ékq¨\ìpø\\E”·™l®N\é`·³·K\É,’9\nˆª	,H\0h®ÕºW@il–¹\×\ZŽ\Ç…\Ã\ÙKy–\Ê\ä\î–{;xÔ¼“K#¨Š ±b@\0Ulú…>¡=S\ÜkU^ô±\Ò\Înÿ\0±˜‹\î.®\Ô4\Z\Ò\â6\ån\'S\Ã%š°\r\r»pX,£\ÏÁ!\ç\êú„õOq½U{\Ò\×K9«\ì>\Æb/¸ºº_(.5¥\Äm\Ê\ÜN§†K5`\Zv\à±YŸ‚C4”¥\0¥)@+cûdö\Å\ê?ºoQv{°¸cogK[«\ïm\Ø\Øi\ë\Ü4óÇœ‡\ÜG!¥aÀ\áCº{Ý¬{Xu\Ýo¨«}•\Ùka…°1\Ük]kyl\Íe§ì™ˆõŽ=IŸ†@iuE’D··A}t\éÛ“§\\OM}6i!a‰ÇW%’¸\n×¹›\ÖP%½»”\êLþ#\ì* TUP¥\ÛÓ·—N}´:q\Æt\ãÓ†™ü=¥¿\çs·J­ž¿*——R\0<¸\à(\ácP¨€*YÚ” ¥()JOŠWB‚\Äû\n¢\Üm\ÂÒ›Q¡3•¯3pc°\Ø<l\×\ÙKû–\á-\à‰\È\ì€U\'úUY»‹u««:ö\ê«P\ï\ÖvI\á\ÆI\'à´¦.fÿ\0Œ‰›ÑŒ€HÜ´¯Á#Ô•øö\à	ú‘ûœ\Øg¹\íû²ÚƒÕŽˆ®7þ\ÖO\ÊYxxq ’\ÆYxø+\ZsÏ¨¢j®ñE\×\ß\ËøX\×\án\Þõÿ\0ch\0­¶…oÕ¬\ÊI(\Ñvµ¿\Ëÿ\0oNgž8¥)Pó¥…)J•‚+±\Ò:·R\èMSŽ\Öú79sŒ\Ìa\ïb»\Å\ä,\ä)-µ\Än$F¬Êº\ïp<§ žOõ¯\é®sšm0\ÏU:)S6ªd¨»³h>\åšk¸—N\Ð\åò÷6\Öz÷M¤Vz\Ó\Ä\Þ\'\Â\ê%ùôf\n\Ì?\á`\é\Éðò;qÁ“þ•R>‘ú±\Þ‹7¿¿;%ž6™<{ø]\Ù\ÊI¶\ÈÚ±K[„y\Æü\ÕHVRT‹4t×Ž\Ðw\0\Øk\r\ä\Úûñ\r\Òño¨03\Ê\r\Æ&ð(/€|~UøÔ‚8÷Î°^[p‡\ÝÈ¿¨\ß4\ã÷8?Kz2¨Á\×5¬¥nt’.¬¿b¯\í^\îÓžvù¥)RB™¥()JJR€R•\Õ\ê\í_¥´•\Éks©,pø\\=”·™\\¶N\é`·³·K\É,²9\nˆª	,H\0h¯\Õ\Ú[oô¶K\\\ëIc‡\Â\á\ìe¼\ËerwK½¼j^I¥‘\ÈTEPIb@\0Ulú„þ¡=U\ÜsT\Þôµ\Ò\Îjû±˜{\î.®€h.5¥\Äm\Ê\ÜÎ§†KE`\Zv\à±YŸ‚Bú„þ¡-S\ÜsU^ôµ\Ò\Öjû±x{\î.®€h.5¥\Äm\Ê\ÜÎ§†KE`\Zv\à±YŸ‚CT”¥\0¥)@+g{Xö°\ê+º\ßQVû+²\Ö\Ã`c¸Öº\ÖòÙš\ËO\Ù3\ê?z“?\"€\Ò0>\ê‹$ˆ\íc\ÚÃ¨®\ë}E[\ì®\ËX-Ž\ãZ\ë[\Ëfk-?d\ÌG¨üq\êLü0Š\0CHÀûª,’%½º\n\è3§NÜ;bzk\é³IM‚ú¹,•ÀV½\ÌÞ²-\íÜ Rgñ`¨¡Q¢ª€tÓ§nN±=5ôÙ¤…†&Á}\\–J\à+^\æoY@–ö\îP©3ø°TP¨QUFi¥()JJR€R” ?ûûžyù­*\ïG\Ü÷\Ûó`_\r¢2PO¹Zº\Þ[m)`xsd¼q%üª}¼\"\çò‚œ…W‚¡\Ê\å\ã\Ä6·f\Ä\Ü\î~¼™/³W¡\íô¦™†p·[\ÏBŸ×\ÒKÁ¤{32#Vo©ž¥·o«\è\Ì\ï¾ö\ê6\Ég3ù¼¬6pŽ};h“\éÄ€ð«óòI,\Ì\Æ3½6†%Š5ýEòN?b\í\ÑŒg\Å\×\Ü+[•$k¿÷ª~\Ô\î\â½‹\Í\æóZ‹5y©5V\âÿ\0#º’\æúúòV’[‰‹<Ž\ÌIff$’}\É$×§\\ðI÷¡ü\Ç\ØUd®W.jwTQ\Çi$MH‡¥+\á”R” ¥(}¼x\ç\ïY¯¡.¼7··\Þõ\Û\îö\Îß¬\ÐN«¢\Ó\×r0´\ËÚ†\ä\Å º\ãÜ¤ y#ò¬\ê\ØSõŸ—\ï\Íe‚y)\äI#\\•\ru\Ò\×Cy¡}cñ½2T]\èZÓ î¿¶¸\ÏÁ¹\Û9žuH³\Úz\îE¸›’91J€ü‹\Ê\à \àrG½T¥­w»¢\í\â°\ÞÍ†\ÕOŽ\ÊZ0K«Y9k\\± ½µ\Ä`$MÀöö*@e*Ê¬,C\ÛO¼Ný\Ä4\ÔxLm\Úiil¯—\Ñy+µ2\æš\Ùø‰‡Ÿ÷€¾\Þj¼©k2\Í‚\àÄŽE\ì¿×—\Ø\á½&hŽçƒªWFÕ’‘W<ö«;\ÝÁ|M¾  ŽA¥H\Ê`R” ¥(j?z®\Ý\Z\ç¹\ïBùÞšö\ãzr:;9ø¨²xµŽ\å“˜ž\0\Æ;Š¨,ö\Î\Ä7#ŸNDŽOôün)@P\Ó}öwzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHdA«£)WI”tee%Xñ\Õpù]v‹»VÐK§\ÇL\ï6š±e\Ñ\Ú\Å\áñŽö1\ËmùPYí™‰ñ~À\ì]AV’9*a¾û»½2n\î{a÷\çA\ßi­Y¦o\Ú\Ó3†\È\Ç\ã$2pA«£)WI”tee%X\ÇR” ³½¬{Xu\Ýo¨«}•\Ùka…°1\Ük]kyl\Íe§ì™ˆõŽ=IŸ†@iuE’Dv±\ía\ÔWu¾¢­öWe¬\r†À\Çq­u­\å³5–Ÿ²f#\Ô~8õ&~E\0!¤`}\ÕI\Þ\ÝtÓ§nN±=5ôÙ¤…†&Á}\\–J\à+^\æoY@–ö\îP©3ø°TP¨QU@‚º\éÓ·\'NØžšúl\ÒB\Ã`¾®K%p¯s7¬ K{w(Ô™üG\Ø*(T@¨ª£4Ò””¥\0¥)À\çšJWÊ£Éøš\0x\ã\Üÿ\0Z\×~\á\ÝÇ¶+·n\Ò>½\Ü\ì’\Þfo‘\ã\Ó:R\Îey[€>|\"RAyHñ@G\ï3*62\îÞƒ`»}\á.tV\æ\rY¹7ü\ãô•\È\âÌ°\åf¼‘yô#ø!\é‘\â’\ë^ž¥:˜\Þ~®wo#½»\í¬§\Ì\ç2/Àf\åa´„R\Þþ\"‰9<(û’Ä–fc½_â·µc‰{Ry\'>þ\â\íÑŽˆnºv\ÖWµc¤M|ý\Í\àœWÀ\îú\Ð\ë;{:\ë\Þ\Û\í\î\Þ\ÜÐ–\êa\ébñV\Ì\Â\Ój	)o\n’xQ\É%,\ìKI¬K\ãÀ\äš){ý¨Ia\É?Z\Í4•¬’.j§p[m´VŠ&RR1$DØˆ‡¥+\ï¥()JJR€R” 9 ‘\ä®\ÇKj½O¡µ%–±\ÑzŠó—\Æ\\%\Æ;\'Žºhg·•O*ñº\ÊÀýÁ®¸øù~_Šr€òú\×Ö¹X\î\ÓT\Ã<TÄ±J\ÔV®¥EÖŠM\'lŸ©’²°Ù¾\à3þ\"¬°X\î%¥¯û5ÀøŠ1\Ì/\Ï\Ë\Z˜\Ï<²\Æ±—\r%¬´¦\ài\ÛMY¢u–[\Ïc\Ç\Ý$\Ð\ÏU\ÑÐ•u#\ÜH5N¾G\É÷\ç\í[Ð¿s\î¬û\ê$¸\Ù\Ín×šr[S#£3L\Ó\ã®yý\æT\ä$?õ‘$\å\æ‰˜Ú±T‘\"GW­8\ï\ë\Ä\æœ} *j\ç>¶À¨Ç®µ~UúWw-œ‹PùÁþ4\'ý\àÒ´¡ÿ\0¨?¢Þªÿ\0	¤w/.v\ËV\Î?³uE\Òþ\ny\Ú\Þm\î@Q’x\nk|lo\ìòP¥Ý…\ÂK¨d’6\ä~?zœ\ÓUSÕ³·‘\É\Ürµ\æÁy\ÃõKOpÑ¹?’j^K±z)\ìÿ\0:S‘\ÏÒ½& R”  }ò»\Z\ív­¡:—N-Ž™\Þm5bË£µ‹\Ã\ã\ìc–\Ûò ³\Û3\âüØº‚­$ro\å(\n\Zo\Æ\Än\ïL›»ž\Ø}ù\ÐW\ÚkVi«\æ´\Ì\á²1ø\Éƒ\ÜG*\è\ÊU\ÒE%YIV\æ\Î\Ö=¬zŠ\î·\ÔU¾\Êì­°\ÂX\î5®µ¼¶f²\ÓöL\Äz\Ç¤\Ï\Ã 4Œº¢\É\"YÓ¼÷b®Ÿ;»\è\ÌnZÿ\0-Š\Ü\ì	Ž,&\àZcD\îö^§2Y]\Ä?\Ú>X4RTø´ˆû\Ð_A:v\ã\é\Û\Ó_MšHXbq\ë\ê\ä²WZ÷3z\Ê··r€=IŸ\Ä}‚¢…D\nŠª\0t\ÐgN¹:v\Äô\×\Óf’›õrY+€­{™½e[Û¹@¤\Ï\â>ÁQB¢EU¦” ¥()À\çš\ãÿ\0Æ€\à‚}‡<W\èóö5\é\å2\Ø\Ì%”™­ôV\Öð¡ygš@ªŠ%‰>À\ïÉ¨þ\ë{\ê)\èë¦\Æi•»m\Ñ\ÕPù ƒO\Ý*\ã`\Ö\ß\È\Ãô„K\î>5å¨«¦¤gjg#P\Ü\Ùp\å\ïT¤\è#—‚jNk±:©¾\Zûpô6\Öi[\Ýs¸ú·„\Ã\ã 3_\äò—‰ñ–y…Qú“P÷\Üó\êF-¿\Ùnß’Ì¾¯”\rÇ¼µð\á~±†A\É\'\ã×‘G<¬‚;z\Ø\î;\Õo^ú¤\æw\ãp%8˜¦2\âôž+\Êe\Ïaò>£€Hõd.þ\äy\ì0?>\ÜqP{®)–l\ã¥\Ô\Þ;×—«0€è­®emùRIZFŸ+Wþ\ß\É|¹ž\æo9šÔ¹»½I©³7Yõ\Ã\Ü^\ß\Þ\Ü4\Ó\\J\ä³\É#±,\ìÄ’X’I>õ\éŽy\äW\Ï%½¸¨sœ®\\\Ô\é(¢Š\Ò8\Ó$Mˆ‡¥+\á”R” ¥()JJR€R” ¥()J\0~~8­”\è\ï»\\¬}£Ý™oôôx\é=N{ŽQÿ\0h\Ì\Ü|’!xù\'ßšÖ²y÷&¹ä·±¬ðUTR¿µ•«\Üj.\Ö+Eö™`¯²5w9\×BrzXú¥6+WþÕ–\Ñetu\ãx¬™\Ü•‡<{»\Æ\Ï\ç\áUf?­H–\Ãõ\Ò÷Sxd\Î\ìVùi½Li \Æ\å#y\á\äsÄ±r$ˆÿ\0\ÙuSúUH\Èþç°¿½\Ä\ÞÅ’\Æ_Mms\áž	J<l>X{ƒúŠ“R\â\ÚÈ²IšŽO(¼G\ì\ï‡+Ü²Z\åt]\Ëñ7Áu§‰r–9—\Ê6V£W\è ò*­\ÝÛ¸\ÇO¯:ªmG{gý©¦\\¬%ûƒñbFDe\ã\í\Åm–\Ú}T]\\\àV8wSa´N¡DPñ\Ü\ãdÔ—i×Ÿ\ä ~• ƒ[%O6¯,ý\n‚\ë\ìÿ\0\è¿†\ìL\Þ(\ì—Á~\äòƒÇ·ÿ\0Š\ä$TKm\Ç\Õs°ù(P\î\çKz¿\ç?\îöN\×\"ÿ\09±#úVX\Ã}M]·ò`\çÖ¸\î~¦‹qÿ\0ñ;\ÖÉ—«\\‰ªTô!z2Ç”N\ÊJ	:&iâ™’ Ho\Í\ç\éZ1Šú‹;X^¨7›ç’²\'\äO£2ÿ\0ô·jü\å~¢\î\Ö6M–÷\ä\ïxøú3(¼ÿ\0\ç·Z\ÍýJƒ,ý\ë|P\ÖþH\Å\Þó±ø3úí‘½\\ò9¸\'Ÿoÿ\05¹¿©··1ð+­²\\|=7\ã\åü½Y±&\ãýW›)`Ž6‡¥]W–qû‡Qe\í±Àÿ\0?Gñ5…÷«Ti®Tõ6Tš1Ç•®\Ê:	:¦I\â¹\Ü<¹\äÿ\0\á_‰fŠ$ó•\Õ@ÿ\0ˆñP-¹\ßT\çXº‰%ƒkvGC\éÈ¥RL“\\\äfõV\nr?T#ô­I\Þþ\ì\Ãú„i\"\Ü.ªõ<V’ò§®WCþ\ã- \Ô_ûþ_¯5¬Ÿ\ÛcOƒ7/,½IÍ§\ÙûW=©Y{\×5ðO¹dž z\à\é7¥¼D™}÷ß7§}8ü\Ò\Ê÷\"¦\êaóû;tò–Sú\"1¨\é\ê¯\ê™Ú4n4÷H»3\Ô\×*Y#\Ô\ZÍ?i\Ìò¯ý—ô\rB=\Õ\Ä÷·R^^\ÜI<Ò¹ye™\Ë3±<’I÷$ÿ\0\Zür\0öõ«Åµ³j…‰\â¥Á‡=ž0Ý½RKœ®É»\åo‚k^ªlX]\Ñz\Ô\ë†yl÷»wn\ï\äºS¦\Ïžü€Ð©&~¸išFb+^þþ\Õ\Ï$§°÷ý*3=Lõ/\íJ\år÷—•¦\Éi±Ó¤¶6&\æ¢\'û8¥)XM°¥)@)JP\nR””¥ÿ\Ù','2020-03-20','nonTraite'),(4,60,_binary 'ÿ\Øÿ\à\0JFIF\0\0H\0H\0\0ÿ\Û\0C\0			\n\n\n\n\n\n	\n\n\nÿ\Û\0C\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nÿÀ\000\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0H\0\n\0\0	!1\nA\"a#2Qq4‚¡$BR%3Sbr‘’£\ÃD”¢±cƒ“²ðÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	ÿ\Ä\0;\0\0\0\0\0\0!1AQqa‘¡±\"2r\Ñ#BRÁ\áñSb5‚²ÿ\Ú\0\0\0?\0ŒúR•EŸ«‚”¥\0¥)@)JP\nR”>\ÃÙ…<Jû‘\\Ÿžkdú:\í7\×\\¾\Ñm4–:z~<5n§f²\Ç8ÿ\0Š7e/p>A0¤œ\ï\Åg§¦¨ªf&«—¸\Ô]¯¶‹2\Ï_3cjor¢¾†¶Wž\Â\Æÿ\0-{7e5\Õ\Ä\î{xË¼Œ~T{“ú\nœN–>–­Š\Ñ\æ\ß?Õ–\îe5\Úð\Ò`°*q\Ö\0ñ\î -<£ø2´\'ô©\ØnŽ:_\é˜=Š\Ø\Í7¦£T	$ø\Ü\\k<ü{s,¤%?«³Ö¤\ÔxJ²T\íL\äbx©E\â/hŒ;@«®\'N\äÞ¿|õ¯[]\í\Üg¨6Šm\r\ÒÆ£³³•‡üã©¡\\T!û\ãñf6‘TV\ç\í\Ímž\Úý+\\g„s\î–üh>Žd\ÅAs’‘?B`^“ú\Ôñ¤QÄ¡Q·_¡\É“[ú|)m‰?S7/<½\n‚\ë\í\ëÜ©MØ…¼¹¯Šýˆ—Û¥añÐ¡\ÝÎ©5~]\ÇcOc-q\Ê\ß\Òar@þµ–0\ßL·müb¯\ã£Ö¹>©Jóüý$J‘\0?_ü+ž=¸&¶Œ²Ú£MQ\'©«\Òn<­vrW\É\ÑrOD4_ô\éö°±ñ›’½\ã\ç\×\ÖyE\çÿ\0%\Â\×_§Gµ•ò‘e²+~\Z\Ë(\Ü\ç¸jÞ‘À\ß­>G¹¬¿\Óh2\Ë\Ý7Á\rw\ç|]\ï;Ž“?­H\ë\Íý2}¸òj\Â\Ä\ë|g?ºlõ/—òõcõ¬K¹J\É\ä›hz¬\ÕX–#òÿ\0x°ö\Ù?Ÿ£ønj[<{\Zx\à\ZÀû-®D\×z*M\'c\Ê\'v¢¯“ªö“ÁQH\Üï¥¬]8“\\mnö\è}GjJÇ’[¬t\ÒqöU	2rWõ­I\Þþ\Ó\Ý\Ãú{i$\Ü.•u<¶‘r[!§­FV\0ƒýökC\'¦¿÷ü^*\ÔCËŸzü\ÉR¡YP0?ñk[>¶ÈŸm^yú“›O´6¡z%R2f÷·%ñO±M»›k›+©,\ï-d†hœ¤±J…Y{A÷\nñ€Áþ•m z\é;ªLD˜}ø\Øm9¨C\ÆcK\Û\Ür‹¨G\Ç\ì®‰b?ª:šŽ®ª¾–M¨Ô†\ãPô‰¼¹\r1rþOŸ\Ô\êo¬¹û\"N8ž%ý_\×5¬\ÂU°\ë…Q\É\à¥Á‡}¢0\ÝÁR;œNË¿\æoŠkOø$r=°_õ­„\ëµ\ßZ\Ï-\æ÷m\r\Ã\à‘üSU\àI¼\Æ?¿\0´¨ƒ“\ì\Ë°5¯^\Ü\Ôfzi\éŸØ•ª\Õ\ï/;U\î\Ó{¦I\è&l]\íT_ô)JVj)JP\nR””¥\0¥)@)JP\nR”” <{Šžx<CÁošs\í\Ç\Ø\ém)©µÆ¥²\Ñ\Ú3O\Þ\åòù+…·\Çc1¶¯<÷2±\ácŽ4™‰ø\0W\Ôj¹ri†i¢§‰d•Q\Zš\ÕWR!\Öò8ø­ˆ\è_¶V}ÀuC³š!­4\äWžKY\æQ¡\Æ\ÛqûÊ¯Á3\È?\ê\âA#\ËÀ!#½²¾›Œ6\Æ\Ãy{€[þ7\"\å\'²Û«Km­¾\ãñ²\Æy™ùùŠ6Ž8f¢\\4ŽŒÒºNZi§,±8\Ì|Ž?j\ÃJ8TD@`\0\0T\Æ×…Ÿ*$•Z“†þ¼j\Ç\Ú}¦ s\è°ú$MK\"ü©ô¦þ{9š7\Ðÿ\0\Ó\á\ÑwJ¿„\Õû—ˆÿ\0\âv­€+œ–¨µSeƒ\ï—&5÷\0ƒ)•ÔŽCŠ\ß+,}ž6´°¶HbE\n‰\Zð\0\0qð+\Ø*OŸŠ\à‚}¼Ö§TÔ´ÔŒ\ìD\Ôjw«y\ÄœATµ	#—Š\êNI±:!úaJ:W \Ô\nR””­\ï•\ß\'hûJm÷oN5Ž¥\ÞmMb\í£´{\Í\å”g•+ð¤2[+âœ‡Ô¢«$‘\Øwž\ï«\Ó\çh\Ä\ß\â#Ö»›Ÿ1Ë„\ÛûL\Ò\Ë\Ô\âKÛ¹B¿\á\á\à:\ÇÊ––AÂ‘\Ó`º\ëÓ§^\ã]:\âz”\é³V‹üNA},–6\àª\Þ\á¯UA–\Ê\î O§2r>\å]JºFV4ßø\ÝÎ§7w=¿ñ¯/µ.¬Ô·\Íw™\Ì\ädò’i°\0T*$j\"*ª€ª\0Í¬;§uÚ¨«}\é\Ù[ö¿\Âß˜\íõ®Š¼¸e²\ÔJ\ÄúoÀ>œ\É\Ë§\0´lO³#IuúV\è/¯N{t\ë‰\êS¦\ÍZ/ñ9ô²XÛ½\Ã^ªƒ-•\Ü@ŸNd\ä}Êº•t,Œ¬sM\0¥)@\ç\ÜPž=\Í)@zYLN37e&;)aÍ¼\ÈRXf@\Ê\êGH>\Ä\íQÿ\0\×Ó¯\Ñ\×R\ëw«¶Z\Ì\ívª˜3‰´ýª¶6y?ý[\"UT|û\Âb÷<Ÿ*\Ã\åö?\é\\žyö¯-M%5[;2µ†\êËˆ¯Xv©*-Óº7\'Ô¼\ÓbõB©}lv\ãê· }Tp\Û\ï $™nX½[ŠòŸ|}\È7ˆôÜ€O¥ Gö\'ÄzÁ~^_Š¸v¾\Û\Í\rºzV÷Cn6’\Çfðù7øÜ¥šOñŸ•x\ÜaúPù\Ü÷éº‹a}½]¿\"™ý\"\Ó\ä6\âò\çÏ•ù&\Æi—#\çÑ‘<Ÿ,f\ru\Â\ÒÂ‹%/\Ä\ÞÓ—ªðŸ(®Neù9RHŸ*¯ý¿Šùr!Î¹à¯¿5\îfðy½5™¼\ÓZ›uŽ\ÉX\\=½\í\í»C5¼¨J¼r#€\È\ÊAH\ï^˜\çžC\Ü\Õj\ä§IG,SÆ’F¹¢\ìT8¥)_¢”¥\0¥)@)JP\nR”?€hýÉ®HR=¿É¬\×Ð—B;\Ù\Ü{`\Ú\ržÇˆ`V}C¨®£ckˆµ-Á‘\Èý\ç>\á\"\É\Ø…Ë–e©‘#3UØ†º\ét¡³P¾²±\è\ÈØ™ª®\ä>{¤þ’÷»­=\â\Ç\ìŽ\Ã\é7\È\å/{«©9K\\u¸ =\ÍÌ€N%\ç\ç‚Xª™TØ‹¶—gÞž;xi¸³X\ËDÔºú\î\Ø&[Zd­J9šd\äþ\Z~T\Ï\í\æ\ÍÂ…\Èýt°ý¿6‚\r±\Ù\Ük©‚Iž\Ôˆ¦÷-p¬\ÎÀ\äø ü¨	\0{’s¯¿>\ÇÞ¬»5‚{ò\'jO$\å÷8oIš\\¹c\n—RQ9c¤MYlW÷»»‚xŸ \0ø¥*HS”¥\0¥)@)J\ÐNù]òv´¦\Ðÿ\0vô\ãX\ê]\æ\Ô\Ö.\Ú;G¼\ÞQ\ÙFyQ’¿\nC%²°>)\Èy\ÝJ)\n²Iù]òv´¦\Ðÿ\0vô\ãX\ê]\æ\Ô\Ö.\Ú;G¼\ÞQ\ÙFyQ’¿\nC%²°>)\Èy\ÝJ)\n²IK÷\ß}÷s©½\Ý\Ïo\Æü\ë\Ë\íM«5-ó]\æs9)<¤šC\ì\0…DU\n‰\Z€ˆŠª *€\ï¾û¹\Ô\Þ\î\ç·\ã~u\åö¦Õš–ù®ó9œ”žRM!ö\0Â¢*…D@DEUP@@)JP;\ÚÃºwQ]¨úŠ·Þ•¿kü-ùŽ\ßZ\è«Ë†[-Ad¬O¦ü\éÌœ±ŠpF\Äû24‘½½º\ëÓ§^\ã]:\âz”\é³V‹üNA},–6\ã\Åop×ª \Ëew\'Ó™9r®¥]#+\Z6V\Ïö«\î‘Ô‡jÎ£\í7‹cn\ä\Éb2rEk¬´5\Ì\ì,õ˜oh˜\0}9\×ÉŒS¨-1ödwÀº\í+\åökqd\Ýý¥\Ó;­6†\Îi‡\Ôx+\\“\é\ÝMf-ò8\Ó4K\'\á\îbús\'—‹/\'‚¯¨ ¥()J\\2«\àkšP\ZQ\Üû³À÷\Â]k\\5´\ZOr`·\ãªì­‡eG\r\äc^?`\Ò\'Ä•\Z½=JôÍ½=#n\æKd·\ÛFÏ†\Îc›óCw	$%\Ä|Kðxa÷H¬¢\Ý|¸\âµ\ç¸nŠ\î%´ ·;,³6JòiWi\n›¼UÁ*O¤MÂ‡ˆŸ\0~\ë*º\ÆoX~\Zö¬‘\'fO%\ç\ß\Þ]º1\Òõ\Ã\Î\Ú*÷,”‹«Š³½½\ÜSÃU\Ï\Ý>Æƒ€=ÿ\0§–º\Ï\è\Ã{z\Þ\ëÝ’\Þ\Ì Š\ê\Ûb²¶\Ê\Æ\Ó+jI	q9SÁOŒ\n¬JÄ±ãŠ­f†Jy9%M¨w¶\åEw¡e]#\Ññ½3EMh¹œR”¬g¼R” ¥\ã\ÜPŽO\åöÞ€0Š\ìt†“\Ô\ÚóT\ã´FŒÁ\Ü\äòù‹\è¬ñx\ë8\Ë\Ësq#„Ž4Qò\Ì\Äü\ë\ëZ¯vM\Ú`žx©¢t²®MD\ÍUv\"!÷}$ôŸ¼}io~\'a¶S\×y<‹ù\Ý\Ý\Ê·\ÆÚ©K«‡\0øD€Õ‰UPY”4ô\Ðv\Ðvý\Ø|~\Í\íuˆšå¸¸\Ô9ù\â\ã+xTšB>\ÙS’@QÏ¹8\ë´\'m-1\ÛÃ§Xpùk{k\Í{¨\Ò;\Íi˜\æo\ák|ú0†eñ1w\àyø¸ÿ\0#“V†³6\ß¼‘?Q\ÞI\Ã\îp†–ô™QŒnKGH\åJH\×V_½S÷/w\ê~\éOŠTŒ¦E)JJR€R• ò»\ä\íiM¡þ\í\éÆ±Ô»Í©¬]´vy¼£²Œò£%~†Ke`|Sóº”Rd’0ò»\ä\íiM¡þ\í\éÆ±Ô»Í©¬]´vy¼£²Œò£%~†Ke`|Sóº”Rd’:—\ï¾û\î\çS{»žßù×—Ú›Vj[\æ»\Ì\ærRyI4‡\Ø\0\nˆª5U@U\07\ß}÷s©½\Ý\Ïo\Æü\ë\Ë\íM«5-ó]\æs9)<¤šC\ì\0…DU\n‰\Z€ˆŠª *€>:€R” ¥y`‚k©’\Þ\Ú&’IX\ãEå˜“À\0“@ ‚k©\Ò\Þ\Ú&’I*F‹\ÉbO\0\0>MX\ï\é\Äúp\á\Ø8p}~uõ¡\Ã\ë©;\í¾\Û\ì¤6¤Žþö6÷\ß\rGü?³0õ¸>œO§\rƒƒ\×\ß_š!d\×r,w\Û}·\ÙHA]6§óG{|\ßfŽ#þÙ˜z\Ü&ò€R” ¥()JJR€R” 5Û¸÷ný¤\î%±W;a¯ KÕŠ½Æ”\Ô\ÐÛ†¸\Å]•\à0øó¸$\\€\êº²£­fú—\é«vúEÞŒ\Î\Äonœlns?¯-\r\ä\'ŸN\æ z‘8«p\È!YYEºÀü£Ú´§½l7p=‚“5¢1A¹ZJ\Þ[)\ì†ñx\æK	XûxK\Ç\å$	·!K†Œ\ßì­¸E\ïbO\ÔO4\áÏv\è‡I\Ó\áƒh+]$‹¿ö*\ïN\î)Ô­Y$žMsû§\Ø×·›\Â\æt\ÖfóM\ê<UÅŽCu%µõ\Ü-¶óF\Å^7F\0«+>\à‚+\Ós\ïU“‘Z¹)\Ý0\Ëñ¤Œ\\\Ñu¢ŠR•ð\Ì)JP“\ÍM_\Óy\Û\Ë¦¢\î¼\Ø/,®I%ƒn\ì®\áÿ\0hAI/ø>þrþx\ã>\ÜD\"Q\ã]­ú\Î÷\ê\Ó´b\Þxô\Æ<Œ–µ\È\Ã\Êúø\ÜyF­ö’f+}ÁrüVˆ\Òz_¡ôÍ†\Òø¨,1Ø»8­l,­\"	Æ¡4Qìªª\0\0|S<-jl¯Z©R|¼øô9‹O¸ù\ÔTÉ‡èŸ“Þ™È©¹»›\×w3µ\0À§\0|\nR¬)JJR€R•=÷»\ï\íwi\í®m¼\Û\Ù1ú—{µ.=ŸL\é‰\Î<-ÊŒ•øS\Ê\Ä>œ\\†™”\Â+º\Ù÷\Êï“´]¥6‡û·¦\Ú\ÇRo6¦±v\Ñ\Ú=\åòŽ\Æ3ÊŒ•øR-ÕñNC\Î\êQHU’H\ê_¾ûï»M\î\î{~7\ç^_jmY©oš\ï3™\ÉI\å$\Ò`\0*\"¨TH\ÔDUUT\à\Þ]\ç\ÝN¡·C7½[Ù®ò:›Uj;÷¼\Ífò·¤\×2±÷?ÁTQ@TP@P\0ùZJR€R•å·‚k©’\Ú\Ú&’I,q¢’\Ì\Äð\0\ä\Ðx&¹•-­\âg’Fh¤³x\0òy«}8¿N[¯¾¾´BÉ®\äX\ï¶ûo²ºmH\rý\ìmó}ð\Ñ\Ä\Ãû3~Û\é\Ãúp\â\Ø0}~uó¢My\"\Ç}·»}”ƒ‘¦Ô€\Ñ\ß\Þ\Æ\Ã\Þûá£ˆÿ\0‡öfý·	» ¥()JJÁ½À»‚ô\ç\ÛW§,§R]Hj\Âc\íyƒ†µekü\íùRc²´Œ‘\ç#pI\'…E\îUU˜VJ\ç\ês\î5\'q¡×”z³\ÃŸórlð¾à¿°½O/À•\ã\Þ\àþù½ñõ}_~`A@[~•‚{y÷\éÏ¹‡NXÎ£úq\Ôßˆ³¸\â\î\í”_\àoÂƒ%\Ô`Ÿ^A9Y«¡*À\Öv ¥()J\\2†\'\ï\\Ò€…Ÿ©¶-Ž\0·p-–Àúi=\ÄVûai\å\Ü$9 Á-\ã¼|–ø\ç\Ôc\'µ\\7r6÷Iî¶„\Ë\í®¼ÁÃ’\Ãg1\ÓX\ä\ì.W˜ç·•\nHúb*¬\ÝÅº+\Õ]õU¨v:“Í‹ŽO\Æ\éL¤\ëþ?+7£\' \0]xhŸ€©ñ\íÁ5\æ)µû‰|.\ÛÜ¿\ä\ìm\ã\å¹Q-†µù\É\Zg\Z®öÿ\0mô\ä`ºPž}\Í*t±\Ëpµq\îó¡ö<V\Ív\è\Øu¿\×”Ú¼ÕŠÏ¦ñNsšµr¯al\ÈL\'ô–V†÷RG\Åg¦õS¶&\ír\äi\ï\×zk\rž{„\ë“cj¹zn\êM\Óù\Ñ	\é;¢‹\ryªð\â\ßWnI9—õc\âX-Y?\Ø\í\ÏÁ17¨Tû«\Ï ?¾x?Ò¼–X\Û\Çil#‰ÆŠ8\0\nór<ýó«––š:Zv\ÄÍL\Í+õ\âªÿ\0xš\áP¹¾G+—»‚tLýR”¯A¨¥()Q\ã\ß{¾ö\×vŸ\Ú\æ\ÛÍ½“©7»R\ã\ÙôÆ™‘ü\á\Ã\ÂÜ¨\É_…<¬@ƒ\é\Å\Èi™H\"»¨û\Ý÷¶»´þ\×6\Þm\ì˜ýK½Ú—Ï¦4Ì\ç\åFJü)\åbN.CL\Ê@\á\Ýjs¼›Éº=B\îŽw{7¯\\\ä5.ªÔ™½\Í\æò“y\Íu3}\Ï\ÙT\0Q@TUUP@\r\ä\ÞM\Ñ\êts»Ù½z\ç!©uV¤\È=\îo7”›\Îk©›\î~Ê \0ªŠ¢ªª€ª\0ùzJR€R•å··š\êd¶¶‰¤’Fh¤³1<\0\0ù4\Þ	®¦[khšI$`±ÆªK3À\0“V<úq>œHv\ß\×\×_:!d×’,w»}·\ÙH]4¤Žþò6ù¾#†Ž#þÙ›ö\ÜN\'Ó‰À[\àúû\ë\ëD,šöEŽûo¶û\'\0+¦”€\Ñ\ß\ÞF\ß7\ÇÙ£ˆÿ\0‡öfý·	» ¥()JX7¸/pNœûkt\ã”\êG©Mø\\}§0aðÖ¥Zû;~\ÊLvV‘’<\än	$ð¨¡Ê¢³pN\à9v\Ö\é\Ë)ÔR:§ð˜\ëN`\Ã\á­\nµþvü©1\ÙZFHó•¸$“Â¢†weEf\î}\Üÿ\0¨\Þ\ê}F]o¶û\äÿ\0	Žµ[h\Ýep\Ía§¬K!ˆ<\ån¥œ€Ò°Ê‹h¹÷sþ£{©uu¾\Û\ï”ü.>\ÔIm£tm•\Ë5†±-È† xó•¸V–rJÀ{*,q¦¶Ò”\Çv\É\îo\Ôok£m7\ïa2þ½Ç…¾¯\Ò“²\Øj\0Ü˜&Ÿ^X\Å0¢c\È\åY\Ñ\íñ\ÛÓ¸gN\Ì:r\ÆuÓ†¦üEÁgpwl«¿\n–wQ‚|y0\ådR®„«Ty­Ž\í“\Üß¨\Þ\Ö=F\Úo\Þ\Âeý{;}_¤/\'e°\Ô6¹0L>.¼±Š`DÇ‘Ê³£v\êV	\í\é\Ü3§N\æ9c:Ž\é¿S~\"\Î\àˆ3¸+¶U¿Àß…K;¨Á>¼òr²)WBU¬\í@)JP\nR”G\ÕQŸDg¨Þ\Û}4v$M©ö½¤\É)‰9yñl^\ÇþUTŸ\ß\à@À{½HšûÁø¯S5‰\Ç\êE\Î+iö·P´WL’Da\Ã+\ìA‚\ryk)™YLø±\Èn°\å\î«^\à¸@¿nE\æ›Óªf…8=\È\æ‡\ØñY÷¹ŸH—]u¬v&y\r\à¿\Ò\ÒI\Éõ1—\É\äû±–…›\îð±¬G<š¦\ê }<\î‰\ÛZ¹¥¶[¥=\ê\Õ\rt›dj9:¦`¨#òŸ\çS©ô¸t®t?O\Z§ª\Ìþ?\Æ÷\\e¿…•\×\ãfYK©ûyÜ´\Ê\Ã\ïøt5¸\\6SQe\í0K7¸¼¿¹Ž\Þ\Ò\Þ1\ËK+°UQú’@þµm¾”6;\ÓoMú+c4\äJ¶šgN\Ú\ØzŠ¼z\Ï`<§þÓ¿““÷,MJ0½«t\î\Ø\Ôó_ðPþ\Ñ8hpü6¸\×\'N\ì\Ýô·_š\ädn\Ï\àOšUŒq€¥)@)JPžf\Û!ˆ»²\ÄeM\Ü\Ö\Ò%­\è…d6ò!dðogñ$\ìx\à\Õ1û\ÐôK\Ö\ïF=oj{>¸µ&CW\æõ~B|¶#sgV6ú²Ü°¼dûD\è\n#\Úÿ\0òü\"(1˜™®‰X7¸o®œû•ô\ç”é»©\r/ø¬}\×3\áó6¡Vÿ\0|ˆ\ïm$ øH¼A\å]K#†Ve QÖ•²]Ï»auÚ³¨Ë­Š\ß|g\âñ\×~¥Æ\ÖVV\ì¶:ŠÀ0h‰\ç\ÂE\åVX	-\î\È\Ñ\Èú\Û@)JP\n\Ü>\Æ]Ytƒ\Ñop\Ý%½ýjm$z—KÚ“\r†YÕ¦þ\ê\ä\Ó\Ñ\Ëþ.}xðY<ýX\ÃI)\Ó\ÊP\æÑš\ÏI\î6’\Æk\í©ls8LÍ”W¸Œ¶.\ég·¼¶•C\Ç,R!*\è\ÊA\Z\íªª?O‡\Ô«»mj\Û>˜zž\Ì_fv/5}û)4÷\Z2\âFå®­\Ôr\Ïj\ÌKMn¾\à“,c\Ï\Í&´ÆŒ\ÖZOq´–3_hKc™Á\æl¢½\ÄeñwK=½å´Š9b‘	WFR`x \Ðµ)JXc®þ»:v\í\ÕÓ¾_©^¥ur\ã°\Ø\åô¬, ñ{\Ü\Å\ë)1YZDHõf\í\ÈUP\Î\åQ‡=vu\×Ó·n®²ýJõ\'¬…\Ç/¥aao\â÷¹‹\ÖRb²´ˆ‘\ê\Ìþ\'\ÈUP\Î\åQ…B»ªwU\ê+»Q3\ï&ò\ß6;Ži-ô>ˆ³¹g²ÀY3\â¼ñ\ê\Îþ*eœ€\Ò0\0DŽ4\Õ\î™\Üÿ\0¨\ê½L\Þ\ï¾ó\äe³\ÄZ4–\Ú#FAt^\ÏN\ã\Ë!\Ø•üU¥œ€Ò°º‰\Z&´R””¥\0¥)@l—k\Þ\æý@v°\ê^\Ã6S%-\Ö2wŽ\ßY\èù\îŠY\ê,xnZ	}ˆI–h¦\nZ\'<ŽU\à=õ\éÓ¯q®q=JtÙ«Eþ\' ¾–Kqâ·¸k\ÕPe²»ˆ\éÌœ¹WR®…‘•+g{XwN\ê+µQVûÓ²·\í…¿1\Û\ë]yp\Ëe¨,•‰ôß€}9“–1NhØŸfF’7\ëô¬-\Ð_^:÷\Z\é\×Ô§Mš´_\âr\éd±·+{†½U[+¸>œ\É\Èû•u*\èYX\æšJR€R” \"\êž\éY³zCõ§±žW;\ÖÀjc–6“ó%³¹û$s+§ý\ë¡PžO5lŽ¿:z\ÆõQ\Ñ\æ\à\ì]ý”sË\ÓW	õG\";\Ô_R\ÚOòN‘7ùj§O»\Å4lŽŒC+¯òª\ß\Ò$5©2lzy¡\Úþ\Ï8‰nXfKl‹ñ@\í_Kµ§‚\æ†\Îök\Ø\×\ß\î\ä»_¥§³y¬±\Ï\í\ìƒ\åQ,Q®S\È\Â\ÓGû•h˜”\"\Ô{¨*úT¶\Ò\ßRû—»2Û‡8\r%i\Û\ß\Ä\ÞÜ™=¿\â\Èÿ\0Nju\Ã\ï\ÅHp¬	³µ½Ê«á¨¥´ývu\Ã­:/\Ã\ZÞ«­}Pæ”¥I\ÊDR•…·{¸?G;Ô¶ˆ\év÷\ë	„\Ü-\ÂGm/§¯\'!\ç\àø ‘Àð€\Ê\á’)_YÕ’?&P¦”¥\0¥)@`\Þ\à¾úr\îUÓžS¦þ¤´·\â±\×|Í‡\Ì\Ú[üðR#½´ƒ\á*òAu,Ž”\Ô#¹ÿ\0l£{Vuu±;\íŒü^:\ïÔ¸Ñº\Ê\ÊÝ–\ÇPØ†\0M<øJ¼ª\Ë%¢b=\Ù\Z9\í5ƒ{vû\éÏ¹ONYN›º’\Ò\Â\ïw\Ìø|Å¢ª\ß\à\ïÂ‘\í¤„NU\ä‚*\êY23)Ž´­š\î‰Ú³©ŽÔ›ý&\Î\ï¾%oq–}­±ð0°\Ôhüz‰\É>”\Ê\nú¶\ìKFX{²2Hú\Ë@)JP\n”\ï§\Ã\ê\ÕÝ¶µmŸL=Of/³;š¾ý”¿š{q#r\×V\ê9gµf%¦·_pI–1\ç\æ“E(óh\Íe¤÷Ic5öÔ¶9œf\Ê+\ÜF_t³\Û\Þ[H¡\ã–)•te †‚\rbþ»:\ë\éÛ·WN\Ù~¥z“\Ö\Â\ã—Ò°°·ñ{\Ü\Å\ë)1YZDHõfÀ\ä*¨gr¨ŒÂµ‡~¢\Ú\á§\Ø.¡qù­i²\×b{‹^=\ÒL†›½!Ÿ\Ê\Ë\ÕuV‚Wö’eP\ÌeB\ÔYu‡º§u^¢»°u>òo-óc°\æ’\ßC\è‹;–{,“0>+\Ï¬\ï\â¦Y\È\r#\0\0TH\ã@\Õ;ªõÝƒ¨™÷“yo›€\Ç4–úDYÜ³\Ù`,™ñ^xõg2\Î@i\0¢G\Zjõ)@)JP\nR³2vü\ë^Žß¯¨ö8v™3\Ùm«\Ä#\Òõyñõ|9õ?\ê~\Ëñ>—«û???\Ë@ašR””¥³½¬;§uÚ¨«}\é\Ù[ö¿\Âß˜\íõ®Š¼¸e²\ÔJ\ÄúoÀ>œ\É\Ë§\0´lO³#I\ÛÛ ¾½:u\î5Ó®\'©N›5h¿\Ä\ä\Ò\Écn<V÷\rzª¶Wq}9“‘÷*\êUÐ²2±£el\ïk\é\ÝEv£\ê*\ßzvVý¯ð·\æ;}k¢¯.lµ’±>›ð§2r\Æ)À-\ì\È\ÒF\à]~•…º\ëÓ§^\ã]:\âz”\é³V‹üNA},–6\ã\Åop×ª \Ëew\'Ó™9r®¥]#+\Ó@(IÆ” <W,ð4l9òR8ªª÷D\Øö\éß¸\ê\í„6¢+Hµ\\ùlH¼*Z\Þñy/ñ\n“ª”Õ«@\àü}\ê¾¨\í³]1\Öö•\Ü{[EŠ\rI \ãŠWT\ãÔ¸µºœ3÷>œ\Ð/òQQlWIn÷›Ú©ç¨½½Ÿ.Î¡Æ®¥Uøfb§V\ëO\îmÒŸ·Q\âúa\ÜmÓ’\ß\Â\\Î¸Lxb=\Þ+[HO\ê<®¤\Ì\Z•…pk@~›,2\âûd\à\ï‚ñý¥©2\×ñó\Å\Ó\Å\Ïþ•oð<ûñü\ëkfbGl‰©À€i&­õ˜\æ¾WÈ©\Ñ2Dô9¥+A;\åw\É\Ú>Ò›Cý\ÛÓc©w›SX»h\íóyGe\åFJü)–\ÊÀø§!\çu(¤*\É${B;\åw\É\Ú>Ò›Cý\ÛÓc©w›SX»h\íóyGe\åFJü)–\ÊÀø§!\çu(¤*\É$u1\ßÿ\0\Þ>¥7‹7\ÔønCP\ë\rC‘7¹\\\åôßµ’_o8¢\0ªˆ€**ª¨\n \Îû\ï¾\îu7»¹\íøßy}©µf¥¾k¼\Îg%\'”“H}€\0p¨Š¡Q#PUTP\ÇP@úpþ£\Èwò@}}k‘»c±\Û\ÝÁ\ÊN\0ÔŠ\0X\ì/dc\í}ð±\Ê\Ä{+[ƒ<\ÞU ž[i’\â\ÞVŽH\Ø2:7X{‚ø<ÕŽ¾œO¨\î-ýƒ\Ð_Z\Ýc\×q¬v;}¸YI€\Z‘G…\ìŒ}¯€\ác”ÿ\0ˆöV>·p&ö”¥\0¥)@až»º\éÛ¸§N\Ù~šú•\Ò+‘\ÃdWÕ°¿€*^\á\ïUHŠö\ÒR¥2r}ø*\ÊY2;)¨Wu^\Õ]Evž\ê&}œ\ÞK\íE¥¸\Ñ\Z\Þ\ÎÙ’\Ë?d¬’òO¥:y(–KF\ÄY\Z9\ëu†z\î\èO§n\â;eúk\êWH®G\r‘_V\Âþ\0©{‡½U\"+\ÛIH>”\É\É÷\à«)dp\È\ì¤\n4Ò¶‡º¯j®¢»Ou>\Îo%öŽ\"\Ò\Ühogl\ÉeŸ²V\Éy\'Ò<”K%£b,«\Ô”¥\0¥)@)JP\nR¥;\éðú|uor][g\Ô\ïS˜{\ì6\Å\áo¿e-\rÆ³¸¸k[v2Z«³\\/¹ \Åóóx@}>OŽ­\îK«lú\ês}†Ø¼-÷\ì¢å¡¸\Öw·\rknÃ†KU`Vk…÷$£>~o\r¢b\Ùýª‡j†\ÅC·5\Ñ+ƒþ\Æ\ZLb\âþ\Îþ\Îô½/\Â~\Ç\Óô}?\É\áÇ·\ï\è\Ý¤ö\çIc4\ÓV8l&\Ê+,N\'j°[\Ù\ÛÆ¡#Š(\ÐDU\0€v\ÔVþ¡?§¯Tv\æ\ÕW½Sô±„¾\Ë\ìfb÷›«@Z{q#p¶ó±\åžÍ˜…†\á¹*HŠS\å\àóE=_£Wi-/¯ô¶GCk9c˜\Ãe\ìe³\Ê\â²V«=½å¼ŠRHeÁWFRAR ‘Uoú…>ž½QÛ—T\ÞõM\Ò\Îû1±™{\în­T´÷\Z.\âF\ám\çc\Ë=›1\ÃrT‘‡\ËÁ\æ)\éJP\nR”\Îö°\î\ÔWj>¢­÷§eo\Úÿ\0~c·Öº*ò\á–\ËPY+\é¿\0ús\',bœÑ±>Ì$oon‚úô\é×¸\×N¸ž¥:lÕ¢ÿ\0_K%¸ñ[\Ü5\ê¨2\Ù]\Ä	ô\æNGÜ«©WB\È\ÊÆ•³½¬;§uÚ¨«}\é\Ù[ö¿\Âß˜\íõ®Š¼¸e²\ÔJ\ÄúoÀ>œ\É\Ë§\0´lO³#IuúV\è/¯N{t\ë‰\êS¦\ÍZ/ñ9ô²XÛ½\Ã^ªƒ-•\Ü@ŸNd\ä}Êº•t,Œ¬sMù>H÷\â¢\ê¿\Ûg»Û£\ÝÄ‹…\Æ\ç²8™“us(?ýqü\ÍK\à`O}ª6¾¨¼\"\äû|\á/ü98\Ý\È\Ç\Üü9µ¼‹ŸýZ\Ô\ß#I-R§v~ÿ\0Eµn£\Ç\ÔMò\"tr*s\'ý=Ø¶\Åö¤\Ûf•x{‰sú6^ð¯ÿ\0oºÀ“ýkJ~žÜ«\å;Q\í²HÀµ¼¹ˆO\è-xÿ\0·Æ·X?¥z­ù~,¿Šz\Z<a\Ûü\Õ[\Û\Û\ï_ÿ\0Òš\r\ß+¾N\Ñö”\Ú¦ô\ãXj]\æ\Ô\Ö.\Ú;G<¾Q\ÙFyQ’¿\nC%²°>)\Èy\ÝJ)\n²IK÷\ß}÷s©½\Ý\Ïo\Æü\ë\Ë\íM«5-ó]\æs9)<¤šC\ì\0…DU\n‰\Z€ˆŠª *€-¡\ß+±®\Ñwk\Ú\ï&œ[5¼\ÚjÁ—Gk‡\Æ;\Ø\Ç,1·\åAg¶f\'\Åø/±uZH\ä©~û\ìF\îôÇ»\Ù\í‡ß¦µf™¿kL\Î#Œ\È8 ‚9WFR®’)(\è\Ê\ÊJ°\'\ØGŽ¥)@+\Ëò\ÚÌ—6ó4oGFá”ƒ\È ƒ^*P@úq>£\Èwú@}kuMw\Z\Çc·Ûƒ”Ÿ©\0\ác°¼‘¾/¾9Oøec\ëpg›Ê D\Ík2\\[J\É$l\Z7F\à©\à‚>«}8¿Q\ä;û .¾µ\ÂÇ®\ãX\ìvûp²—\0.¤Q\Â\Ça{#kï…ŽR\Ú=•­Áœ	»¥)@)JPg®\î„úv\î)Ó¶_¦¾¥tŠ\äp\Ùõl/\à\n—¸{\ÕR\"½´”ƒ\éLœŸ~\n²–GŽ\Êj\ÝWµ_Q=§ú‰Ÿf÷–\È\äp9–\ãC\ëk;fK,ý’°k\É>”\é\ä¢X	-Adx\ä{zõ\Ù\×_NÝººv\Ëõ+Ôž°\\n¾•……¿‹\Þ\æ/YIŠ\Ê\Ò\"G«3øž!UC;•Df\n\î­\ÝS¨®\ìDÏ¼›\É|q\ØsKo¡ôE¥\Ë=–É˜\äVwñS,\ä‘”\08\Ð\r^¥)@)JP\nR”§}=ÿ\0OŽ¬\îM«,úŸ\êw}†Ø¼5ñô¢å¡¸\Öw1?\rknÃ†KU`Vk…÷$£>~o\r¦4nŒ\Ò{s¤±š@\é«6e–\'‹µX-\ì\í\ãP‘\Åh¢*€Àª\Íô÷ýAÚ³¶Ö­³é‡©\ì\ÅögbóW§Ò—óOq£.e~Z\ê\ÝG,ö¬Ä´\Ö\ë\î	2\Æ<ü\ÒkL\è\Íe¤÷Ic5öÔ¶9œf\Ê+\ÜF_t³\Û\Þ[H¡\ã–)•te †‚\r\ÛR” \Õ\ê\í#¥õþ–\Éhms¦\ìs\\½”¶ylVN\Õg·¼·‘JI±¸*\è\ÊH*A+´¥UŸ¨O\é\ì\Õ=¹uM\ïTý,\áo²û˜¾\æ\ê\Ñ|\ç¸\ÑW7o;Y\ìÙˆXn’¤ˆ¥>~4T\Õú5v\Òúÿ\0J\ä´6¹\Óv9Œ.^\Ê[<¶+%j³\Û\Þ[È…$†X\Üte$ ‚V\ï¨S\é\í\Õ]¹uU\ïT½-ao³˜¾\æ\ê\ÕKOq¢\î$n\Úv<³\Ú3°\Ü7%IH|¼`\"¢”¥\0¥)@l\ïk\é\ÝEv£\ê*\ßzvVý¯ð·\æ;}k¢¯.lµ’±>›ð§2r\Æ)À-\ì\È\ÒFöö\è/¯N{t\ë‰\êS¦\ÍZ/ñ9ô²XÛ‚«{†½U[+¸>œ\É\Èû•u*\èYX\Ô\'µk¢»­õo²»-`l0¶;k­o-™¬´ý“1£ñÇ©3ð\Â(\r#î¨²H–ö\è/ ¾{rô\ë‰é¯¦\Í$,18õõrY+€­{™½e[Û¹@¤\ÏÀûE\nˆTš<‡Á­ú‘ð\Ã#\ÛP\ß\çû?P\âg§7‘\Åÿ\0¹[õ\â+A~¤Œ\È\Çv\Å\Ô6$øÿ\0hjLú^G/þ\Ýk®Ÿø\ésþ*Kpkó•go¼o©\ãúl³+“í•„±/\Ïön¤\Ë[‘\Ï\Ç7O/ú¿\ë[ü\0æ¢›\éP\Üxò1n6\ÖKp^\\6¸L€Rß¹Õ¤H\è<­d?Ìš••<ý«ø³½$¶D©Àõi*‘\Ôx\æ¾\'È«\ÑrTõ9­\ï•\Ø\×h»µm	Ôºqlt\Îói«]¬^\ïc°\Æß•žÙ˜Ÿ\à¼\Å\Ôi#“)[BP\Ó}ö#wzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHd\à‚9WFR®’)(\è\Ê\ÊJ°\'\ãª\àò»\Z\ív­¡:—N-Ž™\Þm5bË£µ‹\Ã\ã\ìc–\Ûò ³\Û3\âüØº‚­$rT\Ã}ö#wzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHd\à‚9WFR®’)(\è\Ê\ÊJ°$Ž¥)@+\Ë\ÄÖ³¥Í´­‘°h\äFá•\äGÁ\æ¼T ,ô\â}Gpoô8>:ú\Ö\ë¼#²\Û\íÁ\ÊO\Â\êE\0,v’1ö¾ã…ŽSþ#\ÙXú\Ü\æò¨\ÄÖ³¥Í´­‘°h\äFá”ƒ\È ƒV=úpþ£¨7þ\ß\Ð\'_:\Ýc×‘¬v[}¸99À]J Ž\ÂòFø¾\Ë§üG²·\í¸37U†z\ìë¯§n\Ý];eú•\êOX.7Ž_J\Â\Â\ß\Å\ïs¬¤\Åei#Õ™üOª¡Ê¢3]uô\íÛ«§l¿R½I\ë\Æ\áq\Ë\éXX[ø½\îbõ”˜¬­\"$z³?‰\àrT3¹TFaP®\ê\ÕzŠ\îÁ\ÔLûÉ¼·ÍŽÀcšK}¢,\îY\ì°LÀø¯<z³¿Š™g 4Œ\0Q#\0wT\î«\ÔWv¢g\ÞM\å¾lv\Ò[\è}gr\Ïe€²f\Åy\ãÕüT\Ë9¤`\0\n‰i«Ô¥\0¥)@)JP\nR”¥;\éðúƒµwm­[g\ÓSÙ‹\ì\Î\Åæ¯¿e/\æž\ãF\\HÜµÕºŽY\íY‰i­\×\ÜeŒyù¤\ÑcJü\Ú3Yi=\Æ\ÒX\Í} u-Žg™²Š÷—\Å\Ý,ö÷–\Ò(x\åŠD%]H!\àƒ]µUG\éðúƒµwm­[g\ÓSÙ‹\ì\Î\Åæ¯¿e/\æž\ãF\\HÜµÕºŽY\íY‰i­\×\ÜeŒyù¤Ö˜Ñš\ËI\î6’\Æk\í©ls8<Í”W¸Œ¾.\ég·¼¶‘C\Ç,R!*\è\ÊA\Z¶¥)@+«\Õ\ÚGK\ëý+’\Ð\Ú\çM\Ø\æ0¹‹)lò¸¬ª\Ïoyo\"”’)cpUÑ”T‚<WiJ«PŸ\ÓÛª{qj«Þ©zZ\Â_f631}\ÍÍ²ùOq¢\î%n\Úv<³\Ú3°\Ü7%IH|ühª«ôjý#¥·J\ä´6¸\Óv9Œ.^\Ê[<¶\'\'j³\Û\Þ[È¥$ŠX\Üte$ ‚	VÏ¨K\é\í\Õ=¸µU\ïT\Ý,\áo³˜¾\æ\æ\Øž\ãE\ÜH\Ü-´\ìyg´f!a¸nJ’\"”ùø<ÀEUl\ïk\ÖEw[\ê*\ßevZÀ\Øalw\Z\×Z\Þ[3Yiû&b=G\ãRg\á„P\ZF\ÝQd‘8\íc\ÚÃ¨®\ëE[\ì¦\Ê\Ø-Ž\ãZ\ë[\Ëvk-?d\ÌG¨üq\êLü0Š\0CHÀûª,’%½ú\n\è3§NÜ;bzk\é³IM‚ú¹,•ÀV½\ÌÞ²-\íÜ Rgñ`¨¡Q¢ª€tÓ§nN±=5ôÙ¤…†&Á}\\–J\à+^\æoY@–ö\îP©3ø°TP¨QUFi¥(Ž9?j¯ª\'4¸\Î\Þøk\'%¹û~9ù\â\Úò_ý¿ô©%b8 \ÔA}X—%ž\Ü\í\ÑG/\å\Ég²9i\ÂÁ*Oÿ\0X\Ü#Z‹\ä‰ªU\î\ËÄŸh²‘Õ˜þ‰ºDrònkýŒMô©\îL8N¦7/i¥¸\n\Ùý%k’	\ã\È\Ù\\˜ý¿‰\âûÿ\0…Nª	þW^\Í[\è\ÛÜ—l5M\Å\ãEe—\Î`d\0n‰|lžGþšH_ü‚­«\Æ|\Íx0­BKlFç­ª©ã¬˜\éú\Ò\ë~9uB\'\Ã3Z\äæš—\Ñ\Ý)J“€­\ï•\Ø\×h»µm	Ôºqlt\Îói«]¬^\ïc°\Æß•žÙ˜Ÿ\à¼\Å\Ôi#“)@P\Ó}ö#wzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHd\à‚9WFR®’)(\è\Ê\ÊJ°\'\ãª\àò»\Z\ív­¡:—N-Ž™\Þm5bË£µ‹\Ã\ã\ìc–\Ûò ³\Û3\âüØº‚­$rT\Ã}ö#wzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHd\à‚9WFR®’)(\è\Ê\ÊJ°$Ž¥)@+\Ëo<Ö³-Í´­‘°h\äV!•\äGÁ¯(\ÉÕ§_}`u\Ê4§üª÷\Û5¬—D\àc\Äiµ\ÉÊ¼[@ ‘‚\ê\Ï\'Šú—\å,¾\æ\í\â8\Ãt¥\0¥)@)J”\ï§\Ã\éñÕ½\ÉumŸS½Na\ï°\Û…¾ý”\\´7\Z\Î\â6\á­m\Øp\Éj¬\n\Íp¾\äƒg\Ï\Í\á\Ð\ì9ô\ë\ë\î\è\æ}ý\ê!™\Ñ{-h³\Û\Øe1\è‘\ä5%\èž6^ª2¬?¼“²²–SÞ£E¬=Õ»Uu\Ú¨™öoy,NG‘in4>·´µd²\Ï\Ù+ä¼“\éNžJ%€’Ñ±GŽGº.ÑšOnt–3@\è5c†\Âal¢²\Ä\âqv«½¼j8¢\0TEP\0P8\0V/ë»¡>»Št\í—é¯©]\"¹6E}[ø¥\îõTˆ¯m% úS\'\'ß‚¬¥‘\Ã#²(\ÓJ\Úê½ªºŠ\í=\ÔLû9¼–?\Ú8‹Kq¢5½³%–~\ÉX%\äŸJtòQ,–ˆ ²4r>¯P\nR”¥°?\Ô)¸=³õv?§£r—Úƒa²·­\ê@§»\ÒJÀµ\å ³Û–%¥µ>M$c\ÔòI¢ú”øvÿ\0_\è\Ö\Ðø\Ë\ÛMY\Î\é\ìõ„W\Ø\\\Î*\ég¶½¶‘CG,r)!•”‚®\îªyôÿ\0}@:ßµþ¸·\éó¨<ŽC=°ùì‡•Íª†ž\çH\\\ÈÜ½õšK@\ÌKMl¿½\ï,c\ÔòY­S·Û¢7_C\âw/m5f?=§³\Øø¯°¹œU\Ú\Ïm{m\"†ŽX\äRC+)@wT¥(uz¿Hi]À\Ò\Ù-\r®ôÝŽc˜²–\Ï-‰\ÉÚ¬ö÷–ò)I\"–7]IH ‚k´¥‰ú>èŸ¦>‚¶lJ;Qc¤ô\é\ÈO}=µ³¼²\Ü\ÜJÜ´³M+4“0(¥Ø•DD*€2\Å)@)JPr±\0¿Två®¦\ëwJm½­\Ú\É›\Ðq\Í*+ó\é\\]\\\Î]HûNòaS\ïq2CI!ý\Õ\ä\ÕU;¢oƒu\Üuw:;ŸV\ÒMW>?\"?*ö¶@Y\Ä\ëü$\nÿ\0\ç5Å“¤v\ä{—\ÓY{û>Z]]]U—\Ãz»Rsa³9M?˜´\Ï\á/^\Úò\Â\æ;‹I\ã<4R£F¨`ô«nôŸ½ø¤ºp\Ñ[é¦¥Ck©´\íµÿ\0‚7>‹\É/ÿ\0´\ä„}Š‘Uøö©\Öú\\z©:ß§SÒ¦!\çy¡²ÿ\0\Â\Æ\ì98\ë\Ò\ÎÈ£\ï\áp³3·®‚´XF¯\ÜÕº\Ø\ä\Õ\Í?Ál{D\á\ÇW\áøn‘¦n\Ù;\év¯%È•jS‘ñ\Í*\Æ8ÀR”  }ò»\Z\ív­¡:—N-Ž™\Þm5bË£µ‹\Ã\ã\ìc–\Ûò ³\Û3\âüØº‚­$ro\å(\n\Zo\Æ\Än\ïL›»ž\Ø}ù\ÐW\ÚkVi«\æ´\Ì\á²1ø\Éƒ\ÜG*\è\ÊU\ÒE%YIVüu[û¾c¥\îÍ³ªtÅ½–žÞ/Žq£ug¤r¾N1—\Ä{½»±>\î\Ð;^U¤ŽJ”\ï&\ÍnO[£\Ù=\ë\Ð\Ù\r5ª´\ÖA\ì³xL¤>ZÌ¿cöe †WRUÕ•”•`H/JR€R” ¥J/\Ó\Ï\ØRw1×°õ!Ô–#‰Ø­?{Áa\åº\Æò7á¬­\Ü\Ël¤=\ÂýÁŠ2$óh@ö~Ÿ§\ÃWw$Õ¶}Ou;ˆ¾\ÃlV\ZûöQr\Ð\Ük;ˆÛ†µ·a\Ã%ª°+5\Âû’QŸ?7†\Ó\Z7Fi=¹\ÒX\Í tÕŽ	…²Š\Ë‰\ÅÚ¬övñ¨H\âŠ4Q@@\àM£4–\Ü\é,f‚\Ð:j\Ç\r„\ÃYEe‰\Ä\ã-V{;x\Ô$qG\Z\0¨Š \0 \0\0®Ú€R” 0\Ï]\Ý	ô\í\ÜS§l¿M}J\é\È\á²+\ê\Ø_À/p÷ª¤E{i)Ò™9>üe,Ž”\Ô+º¯j®¢ûOu>\Îo%‘\È\àr-,ú#[\Ù\Û2Ygì•‡\æ^Iô§O%ÀIhØ‚#G#\Ýn°OqžúN\ë_¤\íQ´]fY\ØC£a°—#6¤»ºŽ\ÚM7$1³”72~[w‰|‰cù\ny«†Fe Q\æ•ô\ÛÃ¥ô&‹\Ý}K¤6»p—Wi¼^v\ê\×ªS%˜\Ë\Ù\Ç+,W^„ŸžQ¿ƒ{¯—¾f€R” \'?O\ï\Ô®;ak‹~Ÿ:‚\È\ä3\Û\Èy]Z¯”÷:B\æFü\×\Ök\îZc\å5²þ÷¼‘S\ÉfŒjP\á\Û\íÁ\Ñ³¡ñ;™¶z¶\Ã=§³\Øø¯°ÙœU\Ò\Ím{m\"†Icu$2²A\Ý\Õl>~¸ú\î\Æu?Dz3C\ä5\Î\Ë\\[Í’\Ô\\\Ü‹A\ÈÁ™n\á™ÿ\0(I\å\rh=\ävic\0¤\Å\ìŸ@)JP\nR””¥†ºý\êÒ¿G›ƒ¾—×±Á.M\ÜIŒ2io]};hÿ\0\Ï;Ä¿æª\É,“\ÈóM+;»\ÌÇ’Iù$ý\êk~©þ©\Û	 4?G\Ú{%\ã>võ³ú†8\äá…¤\ÇnŒ>\ë$\Í#ÿ\0Þµ\n9ª\ÛV$Õ©\nlby©\Úþ\Ï8um¸fK”‰ñN\í_Ku\'Š\æ pO½l\ÏhÎ²S¢¸ô®\é\æ\ï„\Zo*\ç«]›…K–@f?¤R¬S¹>kYOûSƒ\Ç5¦ôµ\r•»Z¹—mú\ÑM~´Oo3lVø¦Þ…\É,\î­\ï­ã¼¶<r h\ÙO ƒ÷¯0 µh‡\Ó÷\Öÿ\0ü¬º(\Ç\è=Y˜\Z·mLX<¸–^ež\ÕWýŽ\àü“\åúe‰\åž		ù­ðù>\â®JZ–US¶V\ìrf~h\ß\ìõX~ñ5¾¡2|nV¯\ê™)\Í)Jôš‘JR€Tx÷\Ý\ìCµ\Ý\Øv¹·oc\Ç\é­\î\ÓXöM1©\äOs¯,1·\åG-$úrðZbG(Î!Ô (W¼{7º==nŽwe7¯Cd4Öª\ÓY²\Í\á2øMk2ýÙ”‚]IWVVRU?/V\î\ï»Ø‡k»°\ísn\ÞÇ\Ó[Ý¦±\ìšcSÈž\æ!^XcoÊŽZ\"Iô\å\à´,ÄŽQ\Z§;Ç³{£\Ó\Ö\è\çvSzô6CMj­5{,\Þ)„Ö³/\Øý™H!•Ô•uee%X\ËÒ•\'?O÷\Óû®;Ÿk›~ zƒ\Ç\äp;\Èqst¥¡¹\Õ÷·æ±³b°)3\\¯\îû\Çõ<šO\ï\Óý­ûŸk‹~ ú„\Æ\ä0;¿\â\æ\å< ¹\Õ÷1·\rcfþ\Å`Vg¹_\Ý÷Š3\êy46©\Ûý¿\Ñ;Q¢1[k¶šO‚\Óø|V8l6*\Õ`¶²¶B\Çq¨UT\0\0¦\ß\íþˆÚŠ\ÛM³\ÒxüžÀ\ã\â±\Ãa±V‹µ•´j8£@\nª \0wT”¥\0¥+«\Õú»Kmþ–\È\ës¨\ìpø\\=”·™\\®J\é`·³·K\É,²9\nˆª	,H\0@5v­\ÒúKduÆ¹Ô–8|.\"\Ê[Ì®W%t°[\Ù\ÛÆ¥\ä–Y…DU–$\05Vÿ\0¨O\ê\Õ=\ÆuE\ïK=,f\ïpûˆ¾\â\î\åCAq­.#~V\âu<2Y«\0\Ñ[·ˆ\È<¼>¡_¨OT÷\Z\Õ7½,ô³›¾\Ã\ìf\"÷‹«¥ò‚\ãZ\\FÜ­\Ä\êxd³V¡·n%yx$1Q@)JP\nR”¶;¶Olž£;¦õg°›‰ü=¿…Î¯\Õ×¶\ì\Ö\ZvÀ·yˆ\ã\ÍÛ†\ÂiXp8UwGlž\Ù=FwM\ê6\Ïa6ø{;_«¯mÙ¬4\ínóÇ›·#„Ò°\àpª\î–ø\í\é\ÛË§>\Ú8\ã:q\é\ÃLþ\Òß‰ó¹Û¥V¿\Ï_•KË©\0N\Üpp±¨T@@ ½;yt\ç\ÛC§gN=8iŸ\Ã\Ú[ñ>w;tª\×ù\ëò Iyu \ÉÛŽŽ5\nˆ¨©JJR€R” ?*yû|W§›\Ë\ãôö\"\ç5”»K{[H\Z[‰\åp«\Z($³\ì\0\0’Oð¯tö¨\ëúŒº\Þnœ:?m‹\ÒQ§\Ý—¢\'\á\íñj\Þ\ÉþedƒßŽD\ìGºW–²¥””Î•\Û\r\Ö²T\â+\Ü\è7H\äNI½z&jC/s.¯nz\ß\ëCX\ï¬7>[±\Ò\ÑI\Èôñ–ü\Ç	\àû©“†™—\ì\Ó0¬GŠW? “T\åDï¨Ò»k—3ô¶\Ëk§²Z¡¡2lmF§D8¥)X\r©±Ý­ú\í\Ïvÿ\0\ê\Ï»‹qq&˜\ÈÖ¸\èyo\Äc\äa\å\"¯\ÞHX,©\Ç”)\È\Õh#ªp\Z\çK\ãõŽ–\ËA\ÊY\Åua{k(x®!‘C¤ˆ\ÃÙ•”‚ù©\Ò=‡<T\Õ}7}\Îl³zn.€7—<W+ŒYgÛ»\ë©ÿ\0\ÅZ\0^KO¿œ_\ãü\Åä£ò™\ákªDÿ\0\ÂÊº—\å\çÃ©\ÌZ}À.®§Ký3{)kw;¦þ\îDÀÒ€ò9\ä\Z°N@¥()JQ\ã\ßw±\×wa\Ú\æ\Ü=½¦·»Mc\Ù4Æ§‘<!\ÌB¼°\Æß•´D“\é\ËÁhY‰£:4‡R€«f/¦k¨ž®úŠ\Êeú\ì\Û|þ\Þ\í–\Þ\ê	,56;#[_\êKøó\ØZ0ø·øõ.Ð•*Áaff/¡6ûo´>\Ôh|N\Ùm¦“\Ç\àtöŽ\rŠµXm¬­£P±\Å\Z(UT\0\0®\î””¥\0¥+«\Õú»K\íþ•\Ékq¨\ìpø\\E”·™l®N\é`·³·K\É,’9\nˆª	,H\0h®ÕºW@il–¹\×\ZŽ\Ç…\Ã\ÙKy–\Ê\ä\î–{;xÔ¼“K#¨Š ±b@\0Ulú…>¡=S\ÜkU^ô±\Ò\Înÿ\0±˜‹\î.®\Ô4\Z\Ò\â6\ån\'S\Ã%š°\r\r»pX,£\ÏÁ!\ç\êú„õOq½U{\Ò\×K9«\ì>\Æb/¸ºº_(.5¥\Äm\Ê\ÜN§†K5`\Zv\à±YŸ‚C4”¥\0¥)@+cûdö\Å\ê?ºoQv{°¸cogK[«\ïm\Ø\Øi\ë\Ü4óÇœ‡\ÜG!¥aÀ\áCº{Ý¬{Xu\Ýo¨«}•\Ùka…°1\Ük]kyl\Íe§ì™ˆõŽ=IŸ†@iuE’D··A}t\éÛ“§\\OM}6i!a‰ÇW%’¸\n×¹›\ÖP%½»”\êLþ#\ì* TUP¥\ÛÓ·—N}´:q\Æt\ãÓ†™ü=¥¿\çs·J­ž¿*——R\0<¸\à(\ácP¨€*YÚ” ¥()JOŠWB‚\Äû\n¢\Üm\ÂÒ›Q¡3•¯3pc°\Ø<l\×\ÙKû–\á-\à‰\È\ì€U\'úUY»‹u««:ö\ê«P\ï\ÖvI\á\ÆI\'à´¦.fÿ\0Œ‰›ÑŒ€HÜ´¯Á#Ô•øö\à	ú‘ûœ\Øg¹\íû²ÚƒÕŽˆ®7þ\ÖO\ÊYxxq ’\ÆYxø+\ZsÏ¨¢j®ñE\×\ß\ËøX\×\án\Þõÿ\0ch\0­¶…oÕ¬\ÊI(\Ñvµ¿\Ëÿ\0oNgž8¥)Pó¥…)J•‚+±\Ò:·R\èMSŽ\Öú79sŒ\Ìa\ïb»\Å\ä,\ä)-µ\Än$F¬Êº\ïp<§ žOõ¯\é®sšm0\ÏU:)S6ªd¨»³h>\åšk¸—N\Ð\åò÷6\Öz÷M¤Vz\Ó\Ä\Þ\'\Â\ê%ùôf\n\Ì?\á`\é\Éðò;qÁ“þ•R>‘ú±\Þ‹7¿¿;%ž6™<{ø]\Ù\ÊI¶\ÈÚ±K[„y\Æü\ÕHVRT‹4t×Ž\Ðw\0\Øk\r\ä\Úûñ\r\Òño¨03\Ê\r\Æ&ð(/€|~UøÔ‚8÷Î°^[p‡\ÝÈ¿¨\ß4\ã÷8?Kz2¨Á\×5¬¥nt’.¬¿b¯\í^\îÓžvù¥)RB™¥()JJR€R•\Õ\ê\í_¥´•\Éks©,pø\\=”·™\\¶N\é`·³·K\É,²9\nˆª	,H\0h¯\Õ\Ú[oô¶K\\\ëIc‡\Â\á\ìe¼\ËerwK½¼j^I¥‘\ÈTEPIb@\0Ulú„þ¡=U\ÜsT\Þôµ\Ò\Îjû±˜{\î.®€h.5¥\Äm\Ê\ÜÎ§†KE`\Zv\à±YŸ‚Bú„þ¡-S\ÜsU^ôµ\Ò\Öjû±x{\î.®€h.5¥\Äm\Ê\ÜÎ§†KE`\Zv\à±YŸ‚CT”¥\0¥)@+g{Xö°\ê+º\ßQVû+²\Ö\Ã`c¸Öº\ÖòÙš\ËO\Ù3\ê?z“?\"€\Ò0>\ê‹$ˆ\íc\ÚÃ¨®\ë}E[\ì®\ËX-Ž\ãZ\ë[\Ëfk-?d\ÌG¨üq\êLü0Š\0CHÀûª,’%½º\n\è3§NÜ;bzk\é³IM‚ú¹,•ÀV½\ÌÞ²-\íÜ Rgñ`¨¡Q¢ª€tÓ§nN±=5ôÙ¤…†&Á}\\–J\à+^\æoY@–ö\îP©3ø°TP¨QUFi¥()JJR€R” ?ûûžyù­*\ïG\Ü÷\Ûó`_\r¢2PO¹Zº\Þ[m)`xsd¼q%üª}¼\"\çò‚œ…W‚¡\Ê\å\ã\Ä6·f\Ä\Ü\î~¼™/³W¡\íô¦™†p·[\ÏBŸ×\ÒKÁ¤{32#Vo©ž¥·o«\è\Ì\ï¾ö\ê6\Ég3ù¼¬6pŽ};h“\éÄ€ð«óòI,\Ì\Æ3½6†%Š5ýEòN?b\í\ÑŒg\Å\×\Ü+[•$k¿÷ª~\Ô\î\â½‹\Í\æóZ‹5y©5V\âÿ\0#º’\æúúòV’[‰‹<Ž\ÌIff$’}\É$×§\\ðI÷¡ü\Ç\ØUd®W.jwTQ\Çi$MH‡¥+\á”R” ¥(}¼x\ç\ïY¯¡.¼7··\Þõ\Û\îö\Îß¬\ÐN«¢\Ó\×r0´\ËÚ†\ä\Å º\ãÜ¤ y#ò¬\ê\ØSõŸ—\ï\Íe‚y)\äI#\\•\ru\Ò\×Cy¡}cñ½2T]\èZÓ î¿¶¸\ÏÁ¹\Û9žuH³\Úz\îE¸›’91J€ü‹\Ê\à \àrG½T¥­w»¢\í\â°\ÞÍ†\ÕOŽ\ÊZ0K«Y9k\\± ½µ\Ä`$MÀöö*@e*Ê¬,C\ÛO¼Ný\Ä4\ÔxLm\Úiil¯—\Ñy+µ2\æš\Ùø‰‡Ÿ÷€¾\Þj¼©k2\Í‚\àÄŽE\ì¿×—\Ø\á½&hŽçƒªWFÕ’‘W<ö«;\ÝÁ|M¾  ŽA¥H\Ê`R” ¥(j?z®\Ý\Z\ç¹\ïBùÞšö\ãzr:;9ø¨²xµŽ\å“˜ž\0\Æ;Š¨,ö\Î\Ä7#ŸNDŽOôün)@P\Ó}öwzd\Ý\Üö\Ã\ïÎƒ¾\ÓZ³Lßµ¦g\r‘\ÆHdA«£)WI”tee%Xñ\Õpù]v‹»VÐK§\ÇL\ï6š±e\Ñ\Ú\Å\áñŽö1\ËmùPYí™‰ñ~À\ì]AV’9*a¾û»½2n\î{a÷\çA\ßi­Y¦o\Ú\Ó3†\È\Ç\ã$2pA«£)WI”tee%X\ÇR” ³½¬{Xu\Ýo¨«}•\Ùka…°1\Ük]kyl\Íe§ì™ˆõŽ=IŸ†@iuE’Dv±\ía\ÔWu¾¢­öWe¬\r†À\Çq­u­\å³5–Ÿ²f#\Ô~8õ&~E\0!¤`}\ÕI\Þ\ÝtÓ§nN±=5ôÙ¤…†&Á}\\–J\à+^\æoY@–ö\îP©3ø°TP¨QU@‚º\éÓ·\'NØžšúl\ÒB\Ã`¾®K%p¯s7¬ K{w(Ô™üG\Ø*(T@¨ª£4Ò””¥\0¥)À\çšJWÊ£Éøš\0x\ã\Üÿ\0Z\×~\á\ÝÇ¶+·n\Ò>½\Ü\ì’\Þfo‘\ã\Ó:R\Îey[€>|\"RAyHñ@G\ï3*62\îÞƒ`»}\á.tV\æ\rY¹7ü\ãô•\È\âÌ°\åf¼‘yô#ø!\é‘\â’\ë^ž¥:˜\Þ~®wo#½»\í¬§\Ì\ç2/Àf\åa´„R\Þþ\"‰9<(û’Ä–fc½_â·µc‰{Ry\'>þ\â\íÑŽˆnºv\ÖWµc¤M|ý\Í\àœWÀ\îú\Ð\ë;{:\ë\Þ\Û\í\î\Þ\ÜÐ–\êa\ébñV\Ì\Â\Ój	)o\n’xQ\É%,\ìKI¬K\ãÀ\äš){ý¨Ia\É?Z\Í4•¬’.j§p[m´VŠ&RR1$DØˆ‡¥+\ï¥()JJR€R” 9 ‘\ä®\ÇKj½O¡µ%–±\ÑzŠó—\Æ\\%\Æ;\'Žºhg·•O*ñº\ÊÀýÁ®¸øù~_Šr€òú\×Ö¹X\î\ÓT\Ã<TÄ±J\ÔV®¥EÖŠM\'lŸ©’²°Ù¾\à3þ\"¬°X\î%¥¯û5ÀøŠ1\Ì/\Ï\Ë\Z˜\Ï<²\Æ±—\r%¬´¦\ài\ÛMY¢u–[\Ïc\Ç\Ý$\Ð\ÏU\ÑÐ•u#\ÜH5N¾G\É÷\ç\í[Ð¿s\î¬û\ê$¸\Ù\Ín×šr[S#£3L\Ó\ã®yý\æT\ä$?õ‘$\å\æ‰˜Ú±T‘\"GW­8\ï\ë\Ä\æœ} *j\ç>¶À¨Ç®µ~UúWw-œ‹PùÁþ4\'ý\àÒ´¡ÿ\0¨?¢Þªÿ\0	¤w/.v\ËV\Î?³uE\Òþ\ny\Ú\Þm\î@Q’x\nk|lo\ìòP¥Ý…\ÂK¨d’6\ä~?zœ\ÓUSÕ³·‘\É\Ürµ\æÁy\ÃõKOpÑ¹?’j^K±z)\ìÿ\0:S‘\ÏÒ½& R”  }ò»\Z\ív­¡:—N-Ž™\Þm5bË£µ‹\Ã\ã\ìc–\Ûò ³\Û3\âüØº‚­$ro\å(\n\Zo\Æ\Än\ïL›»ž\Ø}ù\ÐW\ÚkVi«\æ´\Ì\á²1ø\Éƒ\ÜG*\è\ÊU\ÒE%YIV\æ\Î\Ö=¬zŠ\î·\ÔU¾\Êì­°\ÂX\î5®µ¼¶f²\ÓöL\Äz\Ç¤\Ï\Ã 4Œº¢\É\"YÓ¼÷b®Ÿ;»\è\ÌnZÿ\0-Š\Ü\ì	Ž,&\àZcD\îö^§2Y]\Ä?\Ú>X4RTø´ˆû\Ð_A:v\ã\é\Û\Ó_MšHXbq\ë\ê\ä²WZ÷3z\Ê··r€=IŸ\Ä}‚¢…D\nŠª\0t\ÐgN¹:v\Äô\×\Óf’›õrY+€­{™½e[Û¹@¤\Ï\â>ÁQB¢EU¦” ¥()À\çš\ãÿ\0Æ€\à‚}‡<W\èóö5\é\å2\Ø\Ì%”™­ôV\Öð¡ygš@ªŠ%‰>À\ïÉ¨þ\ë{\ê)\èë¦\Æi•»m\Ñ\ÕPù ƒO\Ý*\ã`\Ö\ß\È\Ãô„K\î>5å¨«¦¤gjg#P\Ü\Ùp\å\ïT¤\è#—‚jNk±:©¾\Zûpô6\Öi[\Ýs¸ú·„\Ã\ã 3_\äò—‰ñ–y…Qú“P÷\Üó\êF-¿\Ùnß’Ì¾¯”\rÇ¼µð\á~±†A\É\'\ã×‘G<¬‚;z\Ø\î;\Õo^ú¤\æw\ãp%8˜¦2\âôž+\Êe\Ïaò>£€Hõd.þ\äy\ì0?>\ÜqP{®)–l\ã¥\Ô\Þ;×—«0€è­®emùRIZFŸ+Wþ\ß\É|¹ž\æo9šÔ¹»½I©³7Yõ\Ã\Ü^\ß\Þ\Ü4\Ó\\J\ä³\É#±,\ìÄ’X’I>õ\éŽy\äW\Ï%½¸¨sœ®\\\Ô\é(¢Š\Ò8\Ó$Mˆ‡¥+\á”R” ¥()JJR€R” ¥()J\0~~8­”\è\ï»\\¬}£Ý™oôôx\é=N{ŽQÿ\0h\Ì\Ü|’!xù\'ßšÖ²y÷&¹ä·±¬ðUTR¿µ•«\Üj.\Ö+Eö™`¯²5w9\×BrzXú¥6+WþÕ–\Ñetu\ãx¬™\Ü•‡<{»\Æ\Ï\ç\áUf?­H–\Ãõ\Ò÷Sxd\Î\ìVùi½Li \Æ\å#y\á\äsÄ±r$ˆÿ\0\ÙuSúUH\Èþç°¿½\Ä\ÞÅ’\Æ_Mms\áž	J<l>X{ƒúŠ“R\â\ÚÈ²IšŽO(¼G\ì\ï‡+Ü²Z\åt]\Ëñ7Áu§‰r–9—\Ê6V£W\è ò*­\ÝÛ¸\ÇO¯:ªmG{gý©¦\\¬%ûƒñbFDe\ã\í\Åm–\Ú}T]\\\àV8wSa´N¡DPñ\Ü\ãdÔ—i×Ÿ\ä ~• ƒ[%O6¯,ý\n‚\ë\ìÿ\0\è¿†\ìL\Þ(\ì—Á~\äòƒÇ·ÿ\0Š\ä$TKm\Ç\Õs°ù(P\î\çKz¿\ç?\îöN\×\"ÿ\09±#úVX\Ã}M]·ò`\çÖ¸\î~¦‹qÿ\0ñ;\ÖÉ—«\\‰ªTô!z2Ç”N\ÊJ	:&iâ™’ Ho\Í\ç\éZ1Šú‹;X^¨7›ç’²\'\äO£2ÿ\0ô·jü\å~¢\î\Ö6M–÷\ä\ïxøú3(¼ÿ\0\ç·Z\ÍýJƒ,ý\ë|P\ÖþH\Å\Þó±ø3úí‘½\\ò9¸\'Ÿoÿ\05¹¿©··1ð+­²\\|=7\ã\åü½Y±&\ãýW›)`Ž6‡¥]W–qû‡Qe\í±Àÿ\0?Gñ5…÷«Ti®Tõ6Tš1Ç•®\Ê:	:¦I\â¹\Ü<¹\äÿ\0\á_‰fŠ$ó•\Õ@ÿ\0ˆñP-¹\ßT\çXº‰%ƒkvGC\éÈ¥RL“\\\äfõV\nr?T#ô­I\Þþ\ì\Ãú„i\"\Ü.ªõ<V’ò§®WCþ\ã- \Ô_ûþ_¯5¬Ÿ\ÛcOƒ7/,½IÍ§\ÙûW=©Y{\×5ðO¹dž z\à\é7¥¼D™}÷ß7§}8ü\Ò\Ê÷\"¦\êaóû;tò–Sú\"1¨\é\ê¯\ê™Ú4n4÷H»3\Ô\×*Y#\Ô\ZÍ?i\Ìò¯ý—ô\rB=\Õ\Ä÷·R^^\ÜI<Ò¹ye™\Ë3±<’I÷$ÿ\0\Zür\0öõ«Åµ³j…‰\â¥Á‡=ž0Ý½RKœ®É»\åo‚k^ªlX]\Ñz\Ô\ë†yl÷»wn\ï\äºS¦\Ïžü€Ð©&~¸išFb+^þþ\Õ\Ï$§°÷ý*3=Lõ/\íJ\år÷—•¦\Éi±Ó¤¶6&\æ¢\'û8¥)XM°¥)@)JP\nR””¥ÿ\Ù','2020-03-20','nonTraite');
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
INSERT INTO `module` VALUES ('ALGO','Introduction a l\'algorithmique'),('AR','Administration RÃ©seaux'),('ASD','Algorithmique et structure de donnÃ©es'),('BD','Base de donnÃ©es');
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
