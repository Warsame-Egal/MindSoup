/*
 * To see the control panel, you need to make your self an admin. 
 * Just run this query
 * update account set accountType=1 where id= <yourid>
 */


create database blog;

use blog;

CREATE TABLE `blog`.`account` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `accountType` INT,
  `browseMode` INT NULL DEFAULT 1,
  `dob` DATE,
  `createdDate` DATE,
  `email` VARCHAR(50) NOT NULL,
  `emailVisible` TINYINT NULL DEFAULT 0,
  `deleted` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
  );
  
 
INSERT INTO `blog`.`account` (firstName, lastName,username, password,email) 
VALUES ('abdirahim', 'daheeye', 'abdurahim888', '1234', 'abdu@gmail.com' );

CREATE TABLE `blog`.`post` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `accountID` INT UNSIGNED NULL,
  `postTitle` VARCHAR(100) NOT NULL,
  `postSubject` VARCHAR(50) NOT NULL,
  `postBody` TEXT NOT NULL,
  `postVisible` INT NULL DEFAULT 1,
  `DateCreated` DATETIME NULL,
  `isMature` TINYINT NULL,
  `lastEdited` DATETIME NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `accountID_idx` (`accountID` ASC),
  CONSTRAINT `accountID`
    FOREIGN KEY (`accountID`)
    REFERENCES `blog`.`account` (`id`)
    ON DELETE CASCADE);

    
    