SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `ntic` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `ntic`;

-- -----------------------------------------------------
-- Table `ntic`.`Utilisateur`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Utilisateur` (
  `id_utilisateur` INT NOT NULL ,
  `user` VARCHAR(20) NOT NULL ,
  `pass` VARCHAR(20) NOT NULL COMMENT '				' ,
  `nom` VARCHAR(30) NOT NULL ,
  `prenom` VARCHAR(30) NOT NULL ,
  `adresse` VARCHAR(60) NOT NULL ,
  `date_n` DATE NOT NULL ,
  `email` VARCHAR(40) NOT NULL ,
  `telephone` VARCHAR(10) NOT NULL ,
  `photo` BLOB NULL ,
  `type_utilisateur` ENUM('etudiant','enseignant','admin','chefDepartement','responsableFormation') NOT NULL ,
  `code_departement` ENUM('MI','TLSI','IFA') NOT NULL ,
  PRIMARY KEY (`id_utilisateur`) ,
  INDEX code_departement (`code_departement` ASC) ,
  CONSTRAINT `code_departement`
    FOREIGN KEY (`code_departement` )
    REFERENCES `ntic`.`Departement` (`code_departement` )
   ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Enseignant`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Enseignant` (
  `id_enseignant` INT NOT NULL ,
  `grade` VARCHAR(20) NOT NULL ,
  INDEX id_enseignant (`id_enseignant` ASC) ,
  PRIMARY KEY (`id_enseignant`) ,
  CONSTRAINT `id_enseignant`
    FOREIGN KEY (`id_enseignant` )
    REFERENCES `ntic`.`Utilisateur` (`id_utilisateur` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`ChefDepartement`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`ChefDepartement` (
  `id_chef_departement` INT NOT NULL ,
  `date_nomination` DATE NOT NULL ,
  INDEX id_chef_departement (`id_chef_departement` ASC) ,
  PRIMARY KEY (`id_chef_departement`) ,
  CONSTRAINT `id_chef_departement`
    FOREIGN KEY (`id_chef_departement` )
    REFERENCES `ntic`.`Enseignant` (`id_enseignant` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Departement`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Departement` (
  `code_departement` ENUM('MI','TLSI','IFA') NOT NULL ,
  `id_chef_departement` INT NOT NULL ,
  PRIMARY KEY (`code_departement`) ,
  CONSTRAINT `id_chefdepartement`
    FOREIGN KEY (`id_chef_departement` )
    REFERENCES `ntic`.`ChefDepartement` (`id_chef_departement` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Etudiant`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Etudiant` (
  `id_etudiant` INT NOT NULL ,
  `annee` ENUM('L1','L2','L3','M1','M2') NOT NULL ,
  `specialite` ENUM('MI','GL','SI','TI','SCI','STIC','STIW','RSD') NOT NULL ,
  `section` INT NOT NULL ,
  `groupe` INT NOT NULL ,
  `etat` ENUM('actif','bloque') NOT NULL ,
  PRIMARY KEY (`id_etudiant`) ,
  INDEX id_etudiant (`id_etudiant` ASC) ,
  CONSTRAINT `id_etudiant`
    FOREIGN KEY (`id_etudiant` )
    REFERENCES `ntic`.`Utilisateur` (`id_utilisateur` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Admin`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Admin` (
  `id_admin` INT NOT NULL ,
  `date_nomination` DATE NOT NULL ,
  INDEX id_admin (`id_admin` ASC) ,
  PRIMARY KEY (`id_admin`) ,
  CONSTRAINT `id_admin`
    FOREIGN KEY (`id_admin` )
    REFERENCES `ntic`.`Utilisateur` (`id_utilisateur` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`ResponsableFormation`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`ResponsableFormation` (
  `id_responsable` INT NOT NULL ,
  `date_nomination` DATE NOT NULL ,
  INDEX id_responsable (`id_responsable` ASC) ,
  PRIMARY KEY (`id_responsable`) ,
  CONSTRAINT `id_responsable`
    FOREIGN KEY (`id_responsable` )
    REFERENCES `ntic`.`Enseignant` (`id_enseignant` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Module`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Module` (
  `code_module` VARCHAR(10) NOT NULL ,
  `nom` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`code_module`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Seance`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Seance` (
  `code_seance` VARCHAR(10) NOT NULL ,
  `section` INT NOT NULL ,
  `groupe` INT NOT NULL ,
  `date` DATE NOT NULL ,
  `etat_séance` ENUM('valide','refuse','nonTraite') NOT NULL ,
  `code_module` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`code_seance`) ,
  INDEX code_module (`code_module` ASC) ,
  CONSTRAINT `code_module`
    FOREIGN KEY (`code_module` )
    REFERENCES `ntic`.`Module` (`code_module` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Absence`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Absence` (
  `numero_absence` INT NOT NULL AUTO_INCREMENT ,
  `code_seance` VARCHAR(10) NOT NULL ,
  `id_etudiant` INT NOT NULL ,
  PRIMARY KEY (`numero_absence`) ,
  INDEX code_seance (`code_seance` ASC) ,
  INDEX id_etudiant (`id_etudiant` ASC) ,
  CONSTRAINT `code_seance`
    FOREIGN KEY (`code_seance` )
    REFERENCES `ntic`.`Seance` (`code_seance` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `id_etudiant`
    FOREIGN KEY (`id_etudiant` )
    REFERENCES `ntic`.`Etudiant` (`id_etudiant` )
   ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `ntic`.`Justification`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Justification` (
  `numero_justification` INT NOT NULL AUTO_INCREMENT ,
  `numero_absence` INT NOT NULL ,
  `fichier` BLOB NOT NULL ,
  `date_justification` DATE NOT NULL ,
  `etat` ENUM('valide','refuse','nonTraite') NOT NULL ,
  INDEX numero_absence (`numero_absence` ASC) ,
  PRIMARY KEY (`numero_justification`) ,
  CONSTRAINT `numero_absence`
    FOREIGN KEY (`numero_absence` )
    REFERENCES `ntic`.`Absence` (`numero_absence` )
   ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`SeanceSupp`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`SeanceSupp` (
  `code_seance_supp` VARCHAR(10) NOT NULL ,
  `etat_supp` ENUM('valide','refuse','nonTraite') NOT NULL ,
  `numero_notification` INT NOT NULL ,
  PRIMARY KEY (`code_seance_supp`) ,
  INDEX numero_notification (`numero_notification` ASC) ,
  INDEX code_seance_supp (`code_seance_supp` ASC) ,
  CONSTRAINT `numero_notification`
    FOREIGN KEY (`numero_notification` )
    REFERENCES `ntic`.`Notification` (`numero_notification` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `code_seance_supp`
    FOREIGN KEY (`code_seance_supp` )
    REFERENCES `ntic`.`Seance` (`code_seance` )
   ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Notification`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Notification` (
  `numero_notification` INT NOT NULL AUTO_INCREMENT ,
  `description` LONGTEXT NOT NULL ,
  `permission_etudiant` BOOLEAN NOT NULL ,
  `code_seance_supp` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`numero_notification`) ,
    FOREIGN KEY (`code_seance_supp` )
    REFERENCES `ntic`.`SeanceSupp` (`code_seance_supp` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`CongeAcademique`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`CongeAcademique` (
  `numero_conge_academique` INT NOT NULL AUTO_INCREMENT ,
  `id_etudiant` INT NOT NULL ,
  `fichier` BLOB NOT NULL ,
  `etat` ENUM('valide','refuse','nonTraite') NOT NULL ,
  PRIMARY KEY (`numero_conge_academique`) ,
  CONSTRAINT `idetudiant`
    FOREIGN KEY (`id_etudiant` )
    REFERENCES `ntic`.`Etudiant` (`id_etudiant` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`EmploieDuTemps`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`EmploieDuTemps` (
  `numero_emploi` INT NOT NULL AUTO_INCREMENT ,
  `id_chef_departement` INT NOT NULL ,
  `emploi` BLOB NOT NULL ,
  `specialite` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`numero_emploi`) ,
  CONSTRAINT `idchefdepartement`
    FOREIGN KEY (`id_chef_departement` )
    REFERENCES `ntic`.`ChefDepartement` (`id_chef_departement` )
   ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ntic`.`Enseignement`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ntic`.`Enseignement` (
  `code_module` VARCHAR(10) NOT NULL ,
  `id_enseignant` INT NOT NULL ,
  INDEX code_module (`code_module` ASC) ,
  INDEX id_enseignant (`id_enseignant` ASC) ,
  PRIMARY KEY (`code_module`, `id_enseignant`) ,
  CONSTRAINT `codemodule`
    FOREIGN KEY (`code_module` )
    REFERENCES `ntic`.`Module` (`code_module` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idenseignant`
    FOREIGN KEY (`id_enseignant` )
    REFERENCES `ntic`.`Enseignant` (`id_enseignant` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

