SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `dbinfox` DEFAULT CHARACTER SET utf8;
USE `dbinfox`;

CREATE TABLE IF NOT EXISTS `dbinfox`.`tbclientes` (
  `idtcli` INT NOT NULL AUTO_INCREMENT,
  `nomecli` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idtcli`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dbinfox`.`tbusuarios` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(50) NOT NULL,
  `login` VARCHAR(15) NOT NULL,
  `senha` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dbinfox`.`estado` (
  `idestado` INT NOT NULL AUTO_INCREMENT,
  `nome_estado` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idestado`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dbinfox`.`cidade` (
  `idcidade` INT NOT NULL AUTO_INCREMENT,
  `nome_cidade` VARCHAR(255) NOT NULL,
  `idestado` INT NOT NULL,
  PRIMARY KEY (`idcidade`),
  INDEX `fk_cidade_estado1_idx` (`idestado` ASC),
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`idestado`)
    REFERENCES `dbinfox`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dbinfox`.`bairro` (
  `idbairro` INT NOT NULL AUTO_INCREMENT,
  `nome_bairro` VARCHAR(255) NOT NULL,
  `idcidade` INT NOT NULL,
  PRIMARY KEY (`idbairro`),
  INDEX `fk_bairro_cidade1_idx` (`idcidade` ASC),
  CONSTRAINT `fk_bairro_cidade1`
    FOREIGN KEY (`idcidade`)
    REFERENCES `dbinfox`.`cidade` (`idcidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dbinfox`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(255) NULL,
  `numero_endereco` VARCHAR(10) NULL,
  `complemento` VARCHAR(55) NULL,
  `idbairro` INT NOT NULL,
  `idcli` INT NULL,
  `iduser` INT NULL,
  PRIMARY KEY (`idendereco`),
  INDEX `fk_endereco_bairro1_idx` (`idbairro` ASC),
  INDEX `fk_endereco_tbclientes1_idx` (`idcli` ASC),
  INDEX `fk_endereco_tbusuarios1_idx` (`iduser` ASC),
  CONSTRAINT `fk_endereco_bairro1`
    FOREIGN KEY (`idbairro`)
    REFERENCES `dbinfox`.`bairro` (`idbairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_tbclientes1`
    FOREIGN KEY (`idcli`)
    REFERENCES `dbinfox`.`tbclientes` (`idtcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_tbusuarios1`
    FOREIGN KEY (`iduser`)
    REFERENCES `dbinfox`.`tbusuarios` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dbinfox`.`tbos` (
  `os` INT NOT NULL AUTO_INCREMENT,
  `data_os` TIMESTAMP NULL DEFAULT current_timestamp,
  `tipo` VARCHAR(15) NOT NULL,
  `situacao` VARCHAR(20) NOT NULL,
  `equipamento` VARCHAR(150) NULL,
  `defeito` VARCHAR(150) NOT NULL,
  `servico` VARCHAR(150) NULL,
  `tecnico` VARCHAR(50) NULL,
  `valor` DECIMAL(10,2) NULL,
  `idcli` INT NOT NULL,
  PRIMARY KEY (`os`),
  INDEX `fk_tbos_tbclientes1_idx` (`idcli` ASC),
  CONSTRAINT `fk_tbos_tbclientes1`
    FOREIGN KEY (`idcli`)
    REFERENCES `dbinfox`.`tbclientes` (`idtcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dbinfox`.`telefone` (
  `idtelefone` INT NOT NULL AUTO_INCREMENT,
  `fone` VARCHAR(20) NOT NULL,
  `principal` TINYINT NULL,
  `iduser` INT NULL,
  `idtcli` INT NULL,
  PRIMARY KEY (`idtelefone`),
  INDEX `fk_telefone_tbusuarios1_idx` (`iduser` ASC),
  INDEX `fk_telefone_tbclientes1_idx` (`idtcli` ASC),
  CONSTRAINT `fk_telefone_tbusuarios1`
    FOREIGN KEY (`iduser`)
    REFERENCES `dbinfox`.`tbusuarios` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefone_tbclientes1`
    FOREIGN KEY (`idtcli`)
    REFERENCES `dbinfox`.`tbclientes` (`idtcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dbinfox`.`email` (
  `idemail` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(150) NOT NULL,
  `principal` TINYINT NULL,
  `iduser` INT NULL,
  `dtcli` INT NULL,
  PRIMARY KEY (`idemail`),
  INDEX `fk_email_tbusuarios1_idx` (`iduser` ASC),
  INDEX `fk_email_tbclientes1_idx` (`dtcli` ASC),
  CONSTRAINT `fk_email_tbusuarios1`
    FOREIGN KEY (`iduser`)
    REFERENCES `dbinfox`.`tbusuarios` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_email_tbclientes1`
    FOREIGN KEY (`dtcli`)
    REFERENCES `dbinfox`.`tbclientes` (`idtcli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;