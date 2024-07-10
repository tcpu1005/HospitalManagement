-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hospitalmanagement
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hospitalmanagement
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospitalmanagement` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `hospitalmanagement` ;

-- -----------------------------------------------------
-- Table `hospitalmanagement`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`department` (
  `DepartmentID` INT NOT NULL AUTO_INCREMENT,
  `DepartmentName` VARCHAR(255) NOT NULL,
  `PhoneNumber` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`DepartmentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`user` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`doctor` (
  `DoctorID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Address` VARCHAR(255) NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(50) NULL DEFAULT NULL,
  `DepartmentID` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`DoctorID`, `UserID`, `DepartmentID`),
  INDEX `fk_Doctor_Department_idx` (`DepartmentID` ASC) VISIBLE,
  INDEX `fk_Doctor_User_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Department`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `hospitalmanagement`.`department` (`DepartmentID`),
  CONSTRAINT `fk_Doctor_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `hospitalmanagement`.`user` (`UserID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`patient` (
  `PatientID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `SocialSecurityNumber` VARCHAR(20) NULL DEFAULT NULL,
  `Gender` VARCHAR(50) NULL DEFAULT NULL,
  `Address` VARCHAR(255) NULL DEFAULT NULL,
  `BloodType` VARCHAR(5) NULL DEFAULT NULL,
  `Height` DECIMAL(5,2) NULL DEFAULT NULL,
  `Weight` DECIMAL(5,2) NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(50) NULL DEFAULT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`PatientID`, `UserID`),
  INDEX `fk_Patient_User_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `hospitalmanagement`.`user` (`UserID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`examination`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`examination` (
  `ExaminationID` INT NOT NULL AUTO_INCREMENT,
  `ExaminationDateTime` DATETIME NOT NULL,
  `ExaminationDetails` TEXT NULL DEFAULT NULL,
  `DoctorID` INT NOT NULL,
  `PatientID` INT NOT NULL,
  PRIMARY KEY (`ExaminationID`),
  INDEX `fk_Examination_Doctor_idx` (`DoctorID` ASC) VISIBLE,
  INDEX `fk_Examination_Patient_idx` (`PatientID` ASC) VISIBLE,
  CONSTRAINT `fk_Examination_Doctor`
    FOREIGN KEY (`DoctorID`)
    REFERENCES `hospitalmanagement`.`doctor` (`DoctorID`),
  CONSTRAINT `fk_Examination_Patient`
    FOREIGN KEY (`PatientID`)
    REFERENCES `hospitalmanagement`.`patient` (`PatientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`inpatient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`inpatient` (
  `InpatientID` INT NOT NULL AUTO_INCREMENT,
  `PatientID` INT NOT NULL,
  `RoomInformation` VARCHAR(255) NULL DEFAULT NULL,
  `AdmissionDateTime` DATETIME NULL DEFAULT NULL,
  `DischargeDateTime` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`InpatientID`, `PatientID`),
  INDEX `fk_Inpatient_Patient_idx` (`PatientID` ASC) VISIBLE,
  CONSTRAINT `fk_Inpatient_Patient`
    FOREIGN KEY (`PatientID`)
    REFERENCES `hospitalmanagement`.`patient` (`PatientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`medical_specialty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`medical_specialty` (
  `SpecialtyID` INT NOT NULL AUTO_INCREMENT,
  `DepartmentID` INT NOT NULL,
  `SpecialtyName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`SpecialtyID`, `DepartmentID`),
  INDEX `fk_MedicalSpecialty_Department_idx` (`DepartmentID` ASC) VISIBLE,
  CONSTRAINT `fk_MedicalSpecialty_Department`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `hospitalmanagement`.`department` (`DepartmentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`nurse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`nurse` (
  `NurseID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Address` VARCHAR(255) NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(50) NULL DEFAULT NULL,
  `DepartmentID` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`NurseID`, `UserID`, `DepartmentID`),
  INDEX `fk_Nurse_Department_idx` (`DepartmentID` ASC) VISIBLE,
  INDEX `fk_Nurse_User_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Nurse_Department`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `hospitalmanagement`.`department` (`DepartmentID`),
  CONSTRAINT `fk_Nurse_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `hospitalmanagement`.`user` (`UserID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`reservation` (
  `ReservationNumber` INT NOT NULL AUTO_INCREMENT,
  `ReservationDateTime` DATETIME NOT NULL,
  `DepartmentID` INT NOT NULL,
  `PatientID` INT NOT NULL,
  PRIMARY KEY (`ReservationNumber`),
  INDEX `fk_Reservation_Department_idx` (`DepartmentID` ASC) VISIBLE,
  INDEX `fk_Reservation_Patient_idx` (`PatientID` ASC) VISIBLE,
  CONSTRAINT `fk_Reservation_Department`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `hospitalmanagement`.`department` (`DepartmentID`),
  CONSTRAINT `fk_Reservation_Patient`
    FOREIGN KEY (`PatientID`)
    REFERENCES `hospitalmanagement`.`patient` (`PatientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospitalmanagement`.`treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalmanagement`.`treatment` (
  `TreatmentID` INT NOT NULL AUTO_INCREMENT,
  `TreatmentDateTime` DATETIME NOT NULL,
  `TreatmentDetails` TEXT NULL DEFAULT NULL,
  `NurseID` INT NOT NULL,
  `PatientID` INT NOT NULL,
  PRIMARY KEY (`TreatmentID`),
  INDEX `fk_Treatment_Nurse_idx` (`NurseID` ASC) VISIBLE,
  INDEX `fk_Treatment_Patient_idx` (`PatientID` ASC) VISIBLE,
  CONSTRAINT `fk_Treatment_Nurse`
    FOREIGN KEY (`NurseID`)
    REFERENCES `hospitalmanagement`.`nurse` (`NurseID`),
  CONSTRAINT `fk_Treatment_Patient`
    FOREIGN KEY (`PatientID`)
    REFERENCES `hospitalmanagement`.`patient` (`PatientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
