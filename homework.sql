SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `aktivnost`
-- ----------------------------
DROP TABLE IF EXISTS `aktivnost`;
CREATE TABLE `aktivnost` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(50) NOT NULL,
  `koeficijent` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aktivnost
-- ----------------------------
INSERT INTO `aktivnost` VALUES ('1', 'dežurstvo bez ocenjivanja', '1');
INSERT INTO `aktivnost` VALUES ('2', 'dežurstvo sa ocenjivanjem', '1.2');
INSERT INTO `aktivnost` VALUES ('3', 'dežurstvo sa ispitivanjem i ocenjivanjem', '1.3');
INSERT INTO `aktivnost` VALUES ('5', 'dežurstvo na ispitu', '1');
INSERT INTO `aktivnost` VALUES ('6', 'spavanje na vežbama', '0');

-- ----------------------------
-- Table structure for `korisnik`
-- ----------------------------
DROP TABLE IF EXISTS `korisnik`;
CREATE TABLE `korisnik` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `korisnickoime` varchar(30) NOT NULL,
  `lozinka` char(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ime` varchar(30) NOT NULL,
  `prezime` varchar(30) NOT NULL,
  `telefon` varchar(30) DEFAULT NULL,
  `eposta` varchar(30) NOT NULL,
  `zvanjeid` smallint(6) DEFAULT NULL,
  `godstudija` smallint(6) DEFAULT NULL,
  `prosek` double DEFAULT NULL,
  `admin` tinyint(4) NOT NULL,
  `aktivan` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `korisnik_ibfk_1` (`zvanjeid`),
  CONSTRAINT `korisnik_ibfk_1` FOREIGN KEY (`zvanjeid`) REFERENCES `zvanje` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of korisnik
-- ----------------------------
INSERT INTO `korisnik` VALUES ('10', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'administrator', 'administrator', null, 'admin@singidunum.ac.rs', '2', null, null, '1', '1');
INSERT INTO `korisnik` VALUES ('12', 'ibranovic', '678d658eb40259754d7346b6d2eba579f677d17d', 'Irina', 'Branović', null, 'ibranovic@ieee.org', '2', '0', '0', '0', '1');
INSERT INTO `korisnik` VALUES ('19', 'ibrankovic', '678d658eb40259754d7346b6d2eba579f677d17d', 'Ivan', 'Branković', null, 'ibrankovic@singidunum.ac.rs', '5', '1', '9', '0', '1');
INSERT INTO `korisnik` VALUES ('20', 'nrancic', '678d658eb40259754d7346b6d2eba579f677d17d', 'Nikola ', 'Rančić', null, 'nrancic@singidunum.ac.rs', '5', '3', '8', '0', '1');
INSERT INTO `korisnik` VALUES ('21', 'kveselinovic', '678d658eb40259754d7346b6d2eba579f677d17d', 'Ksenija', 'Veselinović', null, 'kveselinovic@singidunum.ac.rs', '5', '4', '10', '0', '1');
INSERT INTO `korisnik` VALUES ('22', 'ajonic', '678d658eb40259754d7346b6d2eba579f677d17d', 'Aleksa', 'Jonić', null, 'ajonic@singidunum.ac.rs', '5', '2', '9', '0', '1');
INSERT INTO `korisnik` VALUES ('23', 'dzivkovic', '678d658eb40259754d7346b6d2eba579f677d17d', 'Dejan', 'Živković', null, 'dzivkovic@singidunum.ac.rs', '4', '0', '0', '0', '1');
INSERT INTO `korisnik` VALUES ('24', 'vtomasevic', '678d658eb40259754d7346b6d2eba579f677d17d', 'Violeta', 'Tomašević', null, 'vitomasevic@singidunum.ac.rs', '4', '0', '0', '0', '1');
INSERT INTO `korisnik` VALUES ('25', 'bmadov', '2bf76471d9c3a44f7e0640a22d7fbd360c39ee56', 'Bojan', 'Madov', null, 'bmadov@singidunum.ac.rs', '5', '4', '10', '0', '0');
INSERT INTO `korisnik` VALUES ('26', 'nmajstorovic', '678d658eb40259754d7346b6d2eba579f677d17d', 'Nikola', 'Majstorović', null, 'nmajstorovic@singidunum.ac.rs', '5', '4', '10', '0', '1');

-- ----------------------------
-- Table structure for `korisnik_odsek`
-- ----------------------------
DROP TABLE IF EXISTS `korisnik_odsek`;
CREATE TABLE `korisnik_odsek` (
  `korisnikid` smallint(6) NOT NULL,
  `odsekid` smallint(6) NOT NULL,
  KEY `korisnikid` (`korisnikid`),
  KEY `odsekid` (`odsekid`),
  CONSTRAINT `korisnik_odsek_ibfk_1` FOREIGN KEY (`korisnikid`) REFERENCES `korisnik` (`id`),
  CONSTRAINT `korisnik_odsek_ibfk_2` FOREIGN KEY (`odsekid`) REFERENCES `odsek` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of korisnik_odsek
-- ----------------------------
INSERT INTO `korisnik_odsek` VALUES ('25', '3');
INSERT INTO `korisnik_odsek` VALUES ('20', '3');
INSERT INTO `korisnik_odsek` VALUES ('19', '4');
INSERT INTO `korisnik_odsek` VALUES ('21', '4');
INSERT INTO `korisnik_odsek` VALUES ('22', '8');
INSERT INTO `korisnik_odsek` VALUES ('26', '8');

-- ----------------------------
-- Table structure for `korisnik_predmet`
-- ----------------------------
DROP TABLE IF EXISTS `korisnik_predmet`;
CREATE TABLE `korisnik_predmet` (
  `predmetid` smallint(6) NOT NULL,
  `korisnikid` smallint(6) NOT NULL,
  `aktivan` tinyint(4) NOT NULL,
  KEY `predmetid` (`predmetid`),
  KEY `korisnikid` (`korisnikid`),
  CONSTRAINT `korisnik_predmet_ibfk_1` FOREIGN KEY (`predmetid`) REFERENCES `predmet` (`id`),
  CONSTRAINT `korisnik_predmet_ibfk_2` FOREIGN KEY (`korisnikid`) REFERENCES `korisnik` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of korisnik_predmet
-- ----------------------------
INSERT INTO `korisnik_predmet` VALUES ('3', '22', '1');
INSERT INTO `korisnik_predmet` VALUES ('5', '22', '1');
INSERT INTO `korisnik_predmet` VALUES ('1', '19', '1');
INSERT INTO `korisnik_predmet` VALUES ('2', '19', '1');
INSERT INTO `korisnik_predmet` VALUES ('3', '19', '1');
INSERT INTO `korisnik_predmet` VALUES ('2', '25', '1');
INSERT INTO `korisnik_predmet` VALUES ('7', '25', '1');
INSERT INTO `korisnik_predmet` VALUES ('1', '12', '1');
INSERT INTO `korisnik_predmet` VALUES ('2', '12', '1');
INSERT INTO `korisnik_predmet` VALUES ('3', '12', '1');
INSERT INTO `korisnik_predmet` VALUES ('7', '12', '1');
INSERT INTO `korisnik_predmet` VALUES ('4', '24', '1');
INSERT INTO `korisnik_predmet` VALUES ('5', '24', '1');
INSERT INTO `korisnik_predmet` VALUES ('3', '21', '1');
INSERT INTO `korisnik_predmet` VALUES ('4', '21', '1');
INSERT INTO `korisnik_predmet` VALUES ('2', '23', '1');
INSERT INTO `korisnik_predmet` VALUES ('5', '23', '1');
INSERT INTO `korisnik_predmet` VALUES ('2', '26', '1');
INSERT INTO `korisnik_predmet` VALUES ('5', '26', '1');
INSERT INTO `korisnik_predmet` VALUES ('2', '20', '1');
INSERT INTO `korisnik_predmet` VALUES ('3', '20', '1');
INSERT INTO `korisnik_predmet` VALUES ('4', '20', '1');

-- ----------------------------
-- Table structure for `korisnik_vezba`
-- ----------------------------
DROP TABLE IF EXISTS `korisnik_vezba`;
CREATE TABLE `korisnik_vezba` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `korisnikid` smallint(6) NOT NULL,
  `vezbaid` smallint(6) NOT NULL,
  `aktivnostid` smallint(6) DEFAULT NULL,
  `komentar` varchar(50) DEFAULT NULL,
  `prihvacena` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `korisnikid` (`korisnikid`),
  KEY `vezbaid` (`vezbaid`),
  KEY `aktivnostid` (`aktivnostid`),
  CONSTRAINT `korisnik_vezba_ibfk_1` FOREIGN KEY (`korisnikid`) REFERENCES `korisnik` (`id`),
  CONSTRAINT `korisnik_vezba_ibfk_2` FOREIGN KEY (`vezbaid`) REFERENCES `labvezba` (`id`),
  CONSTRAINT `korisnik_vezba_ibfk_3` FOREIGN KEY (`aktivnostid`) REFERENCES `aktivnost` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of korisnik_vezba
-- ----------------------------
INSERT INTO `korisnik_vezba` VALUES ('1', '19', '1', '2', '2', '1');
INSERT INTO `korisnik_vezba` VALUES ('2', '20', '1', '2', null, '0');
INSERT INTO `korisnik_vezba` VALUES ('6', '19', '5', '3', '3', '1');
INSERT INTO `korisnik_vezba` VALUES ('7', '19', '6', '2', null, '0');
INSERT INTO `korisnik_vezba` VALUES ('8', '21', '6', '3', '3', '1');
INSERT INTO `korisnik_vezba` VALUES ('9', '20', '6', '3', '3', '1');
INSERT INTO `korisnik_vezba` VALUES ('10', '20', '5', '3', '3', '1');
INSERT INTO `korisnik_vezba` VALUES ('11', '20', '7', '3', null, '0');
INSERT INTO `korisnik_vezba` VALUES ('12', '20', '8', '3', null, '0');
INSERT INTO `korisnik_vezba` VALUES ('13', '22', '9', '3', null, '0');
INSERT INTO `korisnik_vezba` VALUES ('15', '20', '9', '1', '1', '1');
INSERT INTO `korisnik_vezba` VALUES ('16', '19', '8', '3', null, '0');
INSERT INTO `korisnik_vezba` VALUES ('19', '26', '5', '2', null, '0');

-- ----------------------------
-- Table structure for `labvezba`
-- ----------------------------
DROP TABLE IF EXISTS `labvezba`;
CREATE TABLE `labvezba` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(50) NOT NULL,
  `datum` date NOT NULL,
  `vremeod` time NOT NULL,
  `vremedo` time NOT NULL,
  `laboratorija` varchar(30) NOT NULL,
  `maxbrdemo` smallint(6) NOT NULL,
  `zakljucana` tinyint(4) NOT NULL,
  `predmetid` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `predmetid` (`predmetid`),
  CONSTRAINT `labvezba_ibfk_2` FOREIGN KEY (`predmetid`) REFERENCES `predmet` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of labvezba
-- ----------------------------
INSERT INTO `labvezba` VALUES ('1', 'Prva vezba', '2014-05-10', '16:00:00', '18:00:00', 'E01', '3', '1', '1');
INSERT INTO `labvezba` VALUES ('5', 'Druga vezba', '2014-05-11', '14:35:00', '20:00:00', 'E-02', '2', '0', '2');
INSERT INTO `labvezba` VALUES ('6', 'Vezba PJ', '2014-05-11', '12:23:34', '12:23:34', 'E09', '3', '0', '2');
INSERT INTO `labvezba` VALUES ('7', 'Proba datepickera', '2014-05-11', '18:26:28', '18:26:28', 'E-02', '6', '0', '1');
INSERT INTO `labvezba` VALUES ('8', 'Vezba iz OOP', '2014-05-23', '10:25:00', '14:15:00', 'E-01', '2', '0', '1');
INSERT INTO `labvezba` VALUES ('9', 'AJAX', '2014-06-06', '10:00:00', '12:00:00', 'E-01', '1', '0', '5');

-- ----------------------------
-- Table structure for `odsek`
-- ----------------------------
DROP TABLE IF EXISTS `odsek`;
CREATE TABLE `odsek` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of odsek
-- ----------------------------
INSERT INTO `odsek` VALUES ('1', 'softversko inženjerstvo');
INSERT INTO `odsek` VALUES ('3', 'RTI');
INSERT INTO `odsek` VALUES ('4', 'programiranje i projektovanje');
INSERT INTO `odsek` VALUES ('5', 'elektronika');
INSERT INTO `odsek` VALUES ('6', 'telekomunikacije');
INSERT INTO `odsek` VALUES ('8', 'računarstvo i informatika');
INSERT INTO `odsek` VALUES ('9', 'FIR');

-- ----------------------------
-- Table structure for `predmet`
-- ----------------------------
DROP TABLE IF EXISTS `predmet`;
CREATE TABLE `predmet` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `sifra` varchar(10) NOT NULL,
  `naziv` varchar(50) NOT NULL,
  `semestar` varchar(10) NOT NULL,
  `skolskagod` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of predmet
-- ----------------------------
INSERT INTO `predmet` VALUES ('1', 'OOP2FIR', 'Objektno orijentisano programiranje', '3', '2');
INSERT INTO `predmet` VALUES ('2', 'PRJ2FIR', 'Programski jezici', '4', '2');
INSERT INTO `predmet` VALUES ('3', 'IT3FIR', 'Internet tehnologije', '5', '3');
INSERT INTO `predmet` VALUES ('4', 'AS4FIR', 'Aplikativni softver', '7', '4');
INSERT INTO `predmet` VALUES ('5', 'ST1FIR', 'Strukture podataka i algoritmi', '4', '2');
INSERT INTO `predmet` VALUES ('7', 'PPS4FIM', 'Programski sistemi', '8', '4');
INSERT INTO `predmet` VALUES ('9', 'ORT1FIM', 'Osnovi računarske tehnike', '1', '1');
INSERT INTO `predmet` VALUES ('10', 'BP3FIR', 'Baze podataka', '3', '2');

-- ----------------------------
-- Table structure for `zvanje`
-- ----------------------------
DROP TABLE IF EXISTS `zvanje`;
CREATE TABLE `zvanje` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `naziv` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zvanje
-- ----------------------------
INSERT INTO `zvanje` VALUES ('1', 'asistent');
INSERT INTO `zvanje` VALUES ('2', 'docent');
INSERT INTO `zvanje` VALUES ('3', 'vanredni profesor');
INSERT INTO `zvanje` VALUES ('4', 'redovni profesor');
INSERT INTO `zvanje` VALUES ('5', 'demonstrator');
