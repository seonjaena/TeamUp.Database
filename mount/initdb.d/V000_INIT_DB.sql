CREATE TABLE IF NOT EXISTS `USER_ROLE` (
  `IDX` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  PRIMARY KEY (`IDX`),
  UNIQUE KEY `USER_ROLE_UNIQUE` (`NAME`),
  UNIQUE KEY `USER_ROLE_UNIQUE_1` (`PRIORITY`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `USER_ROLE` VALUES (1, 'ADMIN',1),(2, 'PRIVATE_GOLD',2),(3, 'PRIVATE_SILVER',3),(4, 'PRIVATE_BRONZE',4);



CREATE TABLE IF NOT EXISTS `USER` (
  `IDX` bigint(20) NOT NULL AUTO_INCREMENT,
  `ACCOUNT_ID` varchar(100) NOT NULL,
  `NICKNAME` varchar(100) NOT NULL,
  `ROLE` int(11) NOT NULL,
  `STATUS` char(1) NOT NULL,
  `ACCOUNT_PW` varchar(100) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `BIRTH` date DEFAULT NULL,
  `PHONE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`IDX`),
  UNIQUE KEY `USER_UNIQUE` (`ACCOUNT_ID`),
  UNIQUE KEY `USER_UNIQUE_2` (`NICKNAME`),
  UNIQUE KEY `USER_UNIQUE_3` (`PHONE`),
  KEY `USER_USER_ROLE_FK` (`ROLE`),
  CONSTRAINT `USER_USER_ROLE_FK` FOREIGN KEY (`ROLE`) REFERENCES `USER_ROLE` (`IDX`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `USER_REFRESH_TOKEN` (
  `IDX` bigint(20) NOT NULL AUTO_INCREMENT,
  `IDX_HASH` char(32) NOT NULL,
  `USER_IDX` bigint(20) NOT NULL,
  `VALUE` varchar(300) NOT NULL,
  PRIMARY KEY (`IDX`),
  UNIQUE KEY `USER_REFRESH_TOKEN_UNIQUE` (`IDX_HASH`),
  UNIQUE KEY `USER_REFRESH_TOKEN_UNIQUE_1` (`USER_IDX`),
  UNIQUE KEY `USER_REFRESH_TOKEN_UNIQUE_2` (`VALUE`),
  CONSTRAINT `USER_REFRESH_TOKEN_USER_FK` FOREIGN KEY (`USER_IDX`) REFERENCES `USER` (`IDX`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `USER_VERIFICATION_CODE` (
  `IDX` bigint(20) NOT NULL AUTO_INCREMENT,
  `PHONE_NUMBER` varchar(20) DEFAULT NULL,
  `VERIFICATION_CODE` varchar(100) DEFAULT NULL,
  `TYPE` char(1) NOT NULL,
  `EMAIL_ADDRESS` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IDX`),
  KEY `USER_VERIFICATION_CODE_USER_FK` (`PHONE_NUMBER`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

