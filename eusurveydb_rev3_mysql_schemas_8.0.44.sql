-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.44 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table eusurveydb_rev3.activity
CREATE TABLE IF NOT EXISTS `activity` (
  `ACTIVITY_ID` int NOT NULL AUTO_INCREMENT,
  `ACTIVITY_DATE` datetime DEFAULT NULL,
  `ACTIVITY_LOGID` int DEFAULT NULL,
  `ACTIVITY_NEW` blob,
  `ACTIVITY_OLD` blob,
  `ACTIVITY_SUID` varchar(255) DEFAULT NULL,
  `ACTIVITY_TYPE` varchar(255) DEFAULT NULL,
  `ACTIVITY_USER` int DEFAULT NULL,
  PRIMARY KEY (`ACTIVITY_ID`),
  KEY `IDX_SURVEY_UID` (`ACTIVITY_SUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.activity: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.activityfilter
CREATE TABLE IF NOT EXISTS `activityfilter` (
  `ACFILTER_ID` int NOT NULL AUTO_INCREMENT,
  `ACFILTER_DATEFROM` datetime DEFAULT NULL,
  `ACFILTER_DATETO` datetime DEFAULT NULL,
  `ACFILTER_DESC` varchar(255) DEFAULT NULL,
  `ACFILTER_EVENT` varchar(255) DEFAULT NULL,
  `ACFILTER_LOGID` int DEFAULT NULL,
  `ACFILTER_NEW` varchar(255) DEFAULT NULL,
  `ACFILTER_OBJECT` varchar(255) DEFAULT NULL,
  `ACFILTER_OLD` varchar(255) DEFAULT NULL,
  `ACFILTER_PROP` varchar(255) DEFAULT NULL,
  `ACFILTER_SORTKEY` varchar(255) DEFAULT NULL,
  `ACFILTER_SORTORDER` varchar(255) DEFAULT NULL,
  `ACFILTER_SURVEY` varchar(255) DEFAULT NULL,
  `ACFILTER_USER` int DEFAULT NULL,
  PRIMARY KEY (`ACFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.activityfilter: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.activityfilter_exportedcolumns
CREATE TABLE IF NOT EXISTS `activityfilter_exportedcolumns` (
  `ActivityFilter_ACFILTER_ID` int NOT NULL,
  `exportedColumns` varchar(255) DEFAULT NULL,
  UNIQUE KEY `UC_ActivityFilter_exportedColumns` (`ActivityFilter_ACFILTER_ID`,`exportedColumns`),
  CONSTRAINT `FKmx1d018e088a5u36s4x5f01sc` FOREIGN KEY (`ActivityFilter_ACFILTER_ID`) REFERENCES `activityfilter` (`ACFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.activityfilter_exportedcolumns: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.activityfilter_visiblecolumns
CREATE TABLE IF NOT EXISTS `activityfilter_visiblecolumns` (
  `ActivityFilter_ACFILTER_ID` int NOT NULL,
  `visibleColumns` varchar(255) DEFAULT NULL,
  UNIQUE KEY `UC_ActivityFilter_visibleColumns` (`ActivityFilter_ACFILTER_ID`,`visibleColumns`),
  CONSTRAINT `FKbk43h5i1fvd8u7psljty134qv` FOREIGN KEY (`ActivityFilter_ACFILTER_ID`) REFERENCES `activityfilter` (`ACFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.activityfilter_visiblecolumns: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.answers
CREATE TABLE IF NOT EXISTS `answers` (
  `ANSWER_ID` int NOT NULL AUTO_INCREMENT,
  `ANSWER_COL` int DEFAULT NULL,
  `PA_UID` varchar(255) DEFAULT NULL,
  `QUESTION_UID` varchar(255) DEFAULT NULL,
  `ANSWER_ROW` int DEFAULT NULL,
  `VALUE` longtext,
  `AS_ID` int DEFAULT NULL,
  PRIMARY KEY (`ANSWER_ID`),
  KEY `PA_UID_IDX` (`PA_UID`,`AS_ID`),
  KEY `Q_UID_IDX` (`QUESTION_UID`,`AS_ID`),
  KEY `FK1dt9mnplp02fnv6oee958td3e` (`AS_ID`),
  KEY `idx_quid_v_d` (`QUESTION_UID`,`VALUE`(10)),
  FULLTEXT KEY `v_ft_idx` (`VALUE`),
  CONSTRAINT `FK1dt9mnplp02fnv6oee958td3e` FOREIGN KEY (`AS_ID`) REFERENCES `answers_set` (`ANSWER_SET_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.answers: ~2 rows (approximately)
INSERT INTO `answers` (`ANSWER_ID`, `ANSWER_COL`, `PA_UID`, `QUESTION_UID`, `ANSWER_ROW`, `VALUE`, `AS_ID`) VALUES
	(1, 0, NULL, 'ffd580f9-48aa-50b0-6d24-45c620eae004', 0, 'Aftab', 1),
	(2, 0, '55807874-ef33-4b58-9928-1d86f5f05457', 'f69977a0-fcda-4ea7-060d-dfa7e9b2d0f2', 0, '22', 1);

-- Dumping structure for table eusurveydb_rev3.answers_comments
CREATE TABLE IF NOT EXISTS `answers_comments` (
  `ANSWER_COMMENT_ID` int NOT NULL AUTO_INCREMENT,
  `ANSWER_SET_ID` int DEFAULT NULL,
  `COMMENT_DATE` datetime DEFAULT NULL,
  `QUESTION_UID` varchar(255) DEFAULT NULL,
  `READ_BY_PARENT` bit(1) DEFAULT NULL,
  `READ_BY_PARTICIPANT` bit(1) DEFAULT NULL,
  `TEXT` longtext NOT NULL,
  `ANSWER_SET_CODE` varchar(255) DEFAULT NULL,
  `PARENT` int DEFAULT NULL,
  PRIMARY KEY (`ANSWER_COMMENT_ID`),
  KEY `ANSWERCOMMENT_IDX` (`ANSWER_SET_ID`,`QUESTION_UID`),
  KEY `FKmhc12q14vjt50u74ulpldw6pq` (`PARENT`),
  CONSTRAINT `FKmhc12q14vjt50u74ulpldw6pq` FOREIGN KEY (`PARENT`) REFERENCES `answers_comments` (`ANSWER_COMMENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.answers_comments: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.answers_explanations
CREATE TABLE IF NOT EXISTS `answers_explanations` (
  `ANSWER_EXPLANATION_ID` int NOT NULL AUTO_INCREMENT,
  `ANSWER_SET_ID` int DEFAULT NULL,
  `CHANGED` bit(1) DEFAULT NULL,
  `QUESTION_UID` varchar(255) DEFAULT NULL,
  `TEXT` longtext NOT NULL,
  PRIMARY KEY (`ANSWER_EXPLANATION_ID`),
  KEY `ANSWEREXPLANATION_IDX` (`ANSWER_SET_ID`,`QUESTION_UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.answers_explanations: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.answers_explanations_files
CREATE TABLE IF NOT EXISTS `answers_explanations_files` (
  `ANSWERS_EXPLANATIONS_ANSWER_EXPLANATION_ID` int NOT NULL,
  `files_FILE_ID` int NOT NULL,
  UNIQUE KEY `UK_gm8br4ah7nt3vdm20swi0bdcc` (`files_FILE_ID`),
  CONSTRAINT `FK8e8r1bso0u1ii8fkqgw7cv6hp` FOREIGN KEY (`files_FILE_ID`) REFERENCES `files` (`FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.answers_explanations_files: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.answers_files
CREATE TABLE IF NOT EXISTS `answers_files` (
  `ANSWERS_ANSWER_ID` int NOT NULL,
  `files_FILE_ID` int NOT NULL,
  UNIQUE KEY `UK_p8xiunyjgibn6yw2oupol0lsx` (`files_FILE_ID`),
  CONSTRAINT `FKes5apdsjsl6og3ponuiqn2pxn` FOREIGN KEY (`files_FILE_ID`) REFERENCES `files` (`FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.answers_files: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.answers_set
CREATE TABLE IF NOT EXISTS `answers_set` (
  `ANSWER_SET_ID` int NOT NULL AUTO_INCREMENT,
  `IP` varchar(255) DEFAULT NULL,
  `ANSWER_SET_DATE` datetime DEFAULT NULL,
  `ANSWER_SET_DISCLAIMER` bit(1) DEFAULT NULL,
  `ECF_PROFILE_UID` varchar(255) DEFAULT NULL,
  `ECF_TOTAL_GAP` int DEFAULT NULL,
  `ECF_TOTAL_SCORE` int DEFAULT NULL,
  `ANSWER_SET_INVID` varchar(255) DEFAULT NULL,
  `ISDRAFT` bit(1) DEFAULT NULL,
  `ANSWER_SET_LANG` varchar(255) DEFAULT NULL,
  `RESPONDER_EMAIL` varchar(255) DEFAULT NULL,
  `SCORE` int DEFAULT NULL,
  `ANSWER_SET_STARTED` datetime DEFAULT NULL,
  `SURVEY_ID` int DEFAULT NULL,
  `UNIQUECODE` varchar(36) DEFAULT NULL,
  `ANSWER_SET_UPDATE` datetime DEFAULT NULL,
  `ANSWER_SET_WCAG` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ANSWER_SET_ID`),
  UNIQUE KEY `UNIQUECODE_UNIQUE` (`UNIQUECODE`,`ISDRAFT`),
  KEY `INX_ANSWER_SET_INVID` (`ANSWER_SET_INVID`),
  KEY `INX_RESPONDER_EMAIL` (`RESPONDER_EMAIL`),
  KEY `IDX_SURVEYID_DATE` (`SURVEY_ID`,`ANSWER_SET_DATE`),
  CONSTRAINT `FK36jiux7kxm58qk26d4erigkd8` FOREIGN KEY (`SURVEY_ID`) REFERENCES `surveys` (`SURVEY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.answers_set: ~1 rows (approximately)
INSERT INTO `answers_set` (`ANSWER_SET_ID`, `IP`, `ANSWER_SET_DATE`, `ANSWER_SET_DISCLAIMER`, `ECF_PROFILE_UID`, `ECF_TOTAL_GAP`, `ECF_TOTAL_SCORE`, `ANSWER_SET_INVID`, `ISDRAFT`, `ANSWER_SET_LANG`, `RESPONDER_EMAIL`, `SCORE`, `ANSWER_SET_STARTED`, `SURVEY_ID`, `UNIQUECODE`, `ANSWER_SET_UPDATE`, `ANSWER_SET_WCAG`) VALUES
	(1, '0:0:0:0:0:0:0:1', '2026-01-02 10:32:17', b'0', NULL, NULL, NULL, NULL, b'0', 'EN', 'info@myServer.com', NULL, NULL, 3, '754f243b-59f3-4fb0-8bac-b7c3e943cca8', '2026-01-02 10:32:17', b'0');

-- Dumping structure for table eusurveydb_rev3.archive
CREATE TABLE IF NOT EXISTS `archive` (
  `ARCHIVE_ID` int NOT NULL AUTO_INCREMENT,
  `ARCHIVE_DATE` datetime DEFAULT NULL,
  `ARCHIVE_CREATED` datetime DEFAULT NULL,
  `ARCHIVE_ERROR` varchar(255) DEFAULT NULL,
  `ARCHIVE_FINISHED` bit(1) DEFAULT NULL,
  `XLSX_RESULTS` bit(1) DEFAULT NULL,
  `ARCHIVE_SLANGS` varchar(255) DEFAULT NULL,
  `ARCHIVE_SOWNER` varchar(255) DEFAULT NULL,
  `ARCHIVE_SREPLIES` int DEFAULT NULL,
  `ARCHIVE_RESTORE` bit(1) DEFAULT NULL,
  `ARCHIVE_SUPLOADEDFILES` bit(1) DEFAULT NULL,
  `ARCHIVE_SSHORTNAME` varchar(255) DEFAULT NULL,
  `ARCHIVE_STITLE` varchar(255) DEFAULT NULL,
  `ARCHIVE_SUID` varchar(255) DEFAULT NULL,
  `ARCHIVE_USER` int DEFAULT NULL,
  PRIMARY KEY (`ARCHIVE_ID`),
  KEY `IDX_ARCHIVE` (`ARCHIVE_USER`,`ARCHIVE_DATE`),
  KEY `IDX_ARCHIVE_FINISHED` (`ARCHIVE_FINISHED`,`ARCHIVE_ERROR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.archive: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.attempts
CREATE TABLE IF NOT EXISTS `attempts` (
  `ATTEMPTS_ID` int NOT NULL AUTO_INCREMENT,
  `ATTEMPTS_COUNT` int DEFAULT NULL,
  `ATTEMPTS_IP` varchar(255) DEFAULT NULL,
  `ATTEMPTS_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`ATTEMPTS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.attempts: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.attendee
CREATE TABLE IF NOT EXISTS `attendee` (
  `ATTENDEE_ID` int NOT NULL AUTO_INCREMENT,
  `ATT_CREATED` datetime NOT NULL,
  `ATTENDEE_EMAIL` varchar(255) DEFAULT NULL,
  `ATTENDEE_HIDDEN` bit(1) DEFAULT NULL,
  `ATTENDEE_NAME` varchar(255) DEFAULT NULL,
  `ATTENDEE_ORIGID` int DEFAULT NULL,
  `OWNER_ID` int DEFAULT NULL,
  `REGFORM_ID` int DEFAULT NULL,
  `ATT_UPDATED` datetime NOT NULL,
  PRIMARY KEY (`ATTENDEE_ID`),
  KEY `OWNER_HIDDEN` (`OWNER_ID`,`ATTENDEE_HIDDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.attendee: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.attendee_attributes
CREATE TABLE IF NOT EXISTS `attendee_attributes` (
  `ATTENDEE_ID` int NOT NULL,
  `ATTRIBUTE_ID` int NOT NULL,
  UNIQUE KEY `UK_giu5wynhahdvl9v5s3l6iu9vm` (`ATTRIBUTE_ID`),
  KEY `FKhy05gytge15nmsejh60indtxt` (`ATTENDEE_ID`),
  CONSTRAINT `FKe9s89r4hiicqwbr2664h44l2l` FOREIGN KEY (`ATTRIBUTE_ID`) REFERENCES `attribute` (`ATTRIBUTE_ID`),
  CONSTRAINT `FKhy05gytge15nmsejh60indtxt` FOREIGN KEY (`ATTENDEE_ID`) REFERENCES `attendee` (`ATTENDEE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.attendee_attributes: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.attendeefilter
CREATE TABLE IF NOT EXISTS `attendeefilter` (
  `AFILTER_ID` int NOT NULL AUTO_INCREMENT,
  `ATTENDEEFILTER_EMAIL` varchar(255) DEFAULT NULL,
  `ATTENDEEFILTER_NAME` varchar(255) DEFAULT NULL,
  `ATTENDEEFILTER_OWNER_ID` int DEFAULT NULL,
  PRIMARY KEY (`AFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.attendeefilter: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.attendeefilter_attributes
CREATE TABLE IF NOT EXISTS `attendeefilter_attributes` (
  `ATTENDEEFILTER_ID` int NOT NULL,
  `ATTRIBUTE_ID` int NOT NULL,
  UNIQUE KEY `UC_ATTENDEEFILTER_ATTRIBUTES` (`ATTENDEEFILTER_ID`,`ATTRIBUTE_ID`),
  KEY `FKp2whp9aatm25rju78d9g0sv3j` (`ATTRIBUTE_ID`),
  CONSTRAINT `FKc9mi73w4bkq8hytpx9jygwyoi` FOREIGN KEY (`ATTENDEEFILTER_ID`) REFERENCES `attendeefilter` (`AFILTER_ID`),
  CONSTRAINT `FKp2whp9aatm25rju78d9g0sv3j` FOREIGN KEY (`ATTRIBUTE_ID`) REFERENCES `attribute` (`ATTRIBUTE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.attendeefilter_attributes: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.attribute
CREATE TABLE IF NOT EXISTS `attribute` (
  `ATTRIBUTE_ID` int NOT NULL AUTO_INCREMENT,
  `ATTE_ID` int DEFAULT NULL,
  `ATTRIBUTE_VALUE` text,
  `attributeName_AN_ID` int NOT NULL,
  PRIMARY KEY (`ATTRIBUTE_ID`),
  KEY `FK8b0khno0lk2hfdcy024rd5sgl` (`attributeName_AN_ID`),
  CONSTRAINT `FK8b0khno0lk2hfdcy024rd5sgl` FOREIGN KEY (`attributeName_AN_ID`) REFERENCES `attributename` (`AN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.attribute: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.attributename
CREATE TABLE IF NOT EXISTS `attributename` (
  `AN_ID` int NOT NULL AUTO_INCREMENT,
  `AN_NAME` varchar(255) DEFAULT NULL,
  `OWNER_ID` int DEFAULT NULL,
  PRIMARY KEY (`AN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.attributename: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.changeowner
CREATE TABLE IF NOT EXISTS `changeowner` (
  `CHANGEOWNER_ID` int NOT NULL AUTO_INCREMENT,
  `CHANGEOWNER_FORMMANAGER` bit(1) DEFAULT NULL,
  `CHANGEOWNER_CODE` varchar(255) DEFAULT NULL,
  `CHANGEOWNER_DATE` datetime DEFAULT NULL,
  `CHANGEOWNER_EMAIL` varchar(255) DEFAULT NULL,
  `CHANGEOWNER_LOGIN` varchar(255) DEFAULT NULL,
  `CHANGEOWNER_SURVEYUID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CHANGEOWNER_ID`),
  UNIQUE KEY `CHANGEOWNER_CODE` (`CHANGEOWNER_CODE`),
  UNIQUE KEY `CHANGEOWNER_SURVEYUID` (`CHANGEOWNER_SURVEYUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.changeowner: ~0 rows (approximately)

-- Dumping structure for procedure eusurveydb_rev3.clearStatistics
DELIMITER //
CREATE PROCEDURE `clearStatistics`(id int)
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE pqid INT;	
	DECLARE ppaid INT;
	DECLARE counter INT;

	DECLARE cur1 CURSOR FOR SELECT PA_UID, QUESTION_UID FROM ANSWERS WHERE AS_ID IN
		(SELECT DISTINCT ANSWER_SET_ID FROM ANSWER_SETS WHERE SURVEY_ID = id);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;

	SET counter = 1;

	read_loop2: LOOP

		FETCH cur1 INTO ppaid,pqid;
		IF done THEN
		  LEAVE read_loop2;
		END IF;
		
		DELETE FROM LIVE_STATISTICS WHERE PAID = ppaid AND QID = pqid;

		SET counter = counter + 1;

	END LOOP;

	CLOSE cur1;

	SELECT counter;
END//
DELIMITER ;

-- Dumping structure for table eusurveydb_rev3.comment_likes
CREATE TABLE IF NOT EXISTS `comment_likes` (
  `COMMENT_LIKE_ID` int NOT NULL AUTO_INCREMENT,
  `ANSWER_COMMENT_ID` int DEFAULT NULL,
  `ANSWER_SET_CODE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`COMMENT_LIKE_ID`),
  KEY `COMMENTLIKE_IDX` (`ANSWER_COMMENT_ID`,`ANSWER_SET_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.comment_likes: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.deletedcontributions
CREATE TABLE IF NOT EXISTS `deletedcontributions` (
  `DELETEDCONTRIBUTIONS_ID` int NOT NULL AUTO_INCREMENT,
  `DELETEDCONTRIBUTIONS_CODE` varchar(255) DEFAULT NULL,
  `DELETEDCONTRIBUTIONS_CREATED` datetime DEFAULT NULL,
  `DELETEDCONTRIBUTIONS_DELETED` datetime DEFAULT NULL,
  `DELETEDCONTRIBUTIONS_SURVEY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DELETEDCONTRIBUTIONS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.deletedcontributions: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.departments
CREATE TABLE IF NOT EXISTS `departments` (
  `DEP_ID` int NOT NULL AUTO_INCREMENT,
  `DOMAIN_CODE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DEP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.departments: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.depitems
CREATE TABLE IF NOT EXISTS `depitems` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `POS` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.depitems: ~8 rows (approximately)
INSERT INTO `depitems` (`ID`, `POS`) VALUES
	(1, NULL),
	(2, NULL),
	(3, NULL),
	(4, NULL),
	(5, NULL),
	(6, NULL),
	(7, NULL),
	(8, NULL);

-- Dumping structure for table eusurveydb_rev3.domains
CREATE TABLE IF NOT EXISTS `domains` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CODE` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CODE` (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.domains: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.drafts
CREATE TABLE IF NOT EXISTS `drafts` (
  `DRAFT_ID` int NOT NULL AUTO_INCREMENT,
  `DRAFT_UID` varchar(255) DEFAULT NULL,
  `answerSet_ANSWER_SET_ID` int DEFAULT NULL,
  PRIMARY KEY (`DRAFT_ID`),
  KEY `FKg2g4g1gdjn0b9m1air6ncr2dj` (`answerSet_ANSWER_SET_ID`),
  KEY `IDX_DRAFTS_DRAFT_UID` (`DRAFT_UID`),
  CONSTRAINT `FKg2g4g1gdjn0b9m1air6ncr2dj` FOREIGN KEY (`answerSet_ANSWER_SET_ID`) REFERENCES `answers_set` (`ANSWER_SET_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.drafts: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.ecasgroups
CREATE TABLE IF NOT EXISTS `ecasgroups` (
  `eg_id` int NOT NULL,
  `GRPS` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  UNIQUE KEY `UC_ECASGROUPS` (`eg_id`,`GRPS`),
  CONSTRAINT `FKskuycp3rebmg4nu252t28mc3j` FOREIGN KEY (`eg_id`) REFERENCES `ecasusers` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.ecasgroups: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.ecasusers
CREATE TABLE IF NOT EXISTS `ecasusers` (
  `USER_ID` int NOT NULL AUTO_INCREMENT,
  `USER_DEACTIVATED` bit(1) DEFAULT NULL,
  `USER_DEPARTMENT` varchar(255) DEFAULT NULL,
  `USER_ECMONIKER` varchar(255) DEFAULT NULL,
  `USER_EMAIL` varchar(255) NOT NULL,
  `USER_EMPLOYEETYPE` varchar(255) DEFAULT NULL,
  `USER_GN` varchar(255) DEFAULT NULL,
  `USER_MODIFIED` datetime DEFAULT NULL,
  `USER_LOGIN` varchar(255) DEFAULT NULL,
  `USER_ORGANISATION` varchar(255) DEFAULT NULL,
  `USER_PHONE` varchar(255) DEFAULT NULL,
  `USER_SN` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `UK_bji3bjfayimy9kv86c2oo7084` (`USER_LOGIN`),
  UNIQUE KEY `USER_LOGIN` (`USER_LOGIN`),
  KEY `INX_DEP_ORG` (`USER_DEPARTMENT`,`USER_ORGANISATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.ecasusers: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.ecf_cluster
CREATE TABLE IF NOT EXISTS `ecf_cluster` (
  `ECF_CLUSTER_ID` int NOT NULL AUTO_INCREMENT,
  `ECF_CLUSTER_NAME` varchar(255) DEFAULT NULL,
  `ECF_CLUSTER_UID` varchar(255) DEFAULT NULL,
  `ECF_TYPE` int DEFAULT NULL,
  PRIMARY KEY (`ECF_CLUSTER_ID`),
  KEY `FKl6734oqsxok1omjiflnfpkcwi` (`ECF_TYPE`),
  CONSTRAINT `FKl6734oqsxok1omjiflnfpkcwi` FOREIGN KEY (`ECF_TYPE`) REFERENCES `ecf_type` (`ECF_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.ecf_cluster: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.ecf_competency
CREATE TABLE IF NOT EXISTS `ecf_competency` (
  `COMPETENCY_ID` int NOT NULL AUTO_INCREMENT,
  `COMPETENCY_UID` varchar(255) DEFAULT NULL,
  `COMPETENCY_DESC` varchar(255) DEFAULT NULL,
  `COMPETENCY_NAME` varchar(255) DEFAULT NULL,
  `ORDER_NUMBER` int DEFAULT NULL,
  `ECF_CLUSTER` int DEFAULT NULL,
  PRIMARY KEY (`COMPETENCY_ID`),
  KEY `FKr8owd6jab7ajlbuxfu7dn1k4f` (`ECF_CLUSTER`),
  CONSTRAINT `FKr8owd6jab7ajlbuxfu7dn1k4f` FOREIGN KEY (`ECF_CLUSTER`) REFERENCES `ecf_cluster` (`ECF_CLUSTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.ecf_competency: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.ecf_expected_score
CREATE TABLE IF NOT EXISTS `ecf_expected_score` (
  `SCORE` int DEFAULT NULL,
  `PROFILE` int NOT NULL,
  `COMPETENCY` int NOT NULL,
  PRIMARY KEY (`COMPETENCY`,`PROFILE`),
  KEY `FKj19mi4vrj2jo0q4a1docip0be` (`PROFILE`),
  CONSTRAINT `FK12yhn8bvy7rtk8guypabfe284` FOREIGN KEY (`COMPETENCY`) REFERENCES `ecf_competency` (`COMPETENCY_ID`),
  CONSTRAINT `FKj19mi4vrj2jo0q4a1docip0be` FOREIGN KEY (`PROFILE`) REFERENCES `ecf_profile` (`PROFILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.ecf_expected_score: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.ecf_profile
CREATE TABLE IF NOT EXISTS `ecf_profile` (
  `PROFILE_ID` int NOT NULL AUTO_INCREMENT,
  `PROFILE_DESC` varchar(255) DEFAULT NULL,
  `PROFILE_NAME` varchar(255) DEFAULT NULL,
  `orderNumber` int DEFAULT NULL,
  `PROFILE_UID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PROFILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.ecf_profile: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.ecf_type
CREATE TABLE IF NOT EXISTS `ecf_type` (
  `ECF_TYPE_ID` int NOT NULL AUTO_INCREMENT,
  `ECF_CLUSTER_NAME` varchar(255) DEFAULT NULL,
  `ECF_TYPE_UID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ECF_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.ecf_type: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.elements
CREATE TABLE IF NOT EXISTS `elements` (
  `type` varchar(31) NOT NULL,
  `ID` int NOT NULL AUTO_INCREMENT,
  `DISPLAYMODE` int DEFAULT NULL,
  `EDIT_COLUMNS_LOCKED` bit(1) DEFAULT NULL,
  `EDIT_ROWS_LOCKED` bit(1) DEFAULT NULL,
  `ELOCKED` bit(1) DEFAULT NULL,
  `EPOSITION` int DEFAULT NULL,
  `ELEM_SHORTNAME` varchar(255) DEFAULT NULL,
  `SOURCE_ID` int DEFAULT NULL,
  `SUBTYPE` varchar(255) DEFAULT NULL,
  `ETITLE` text,
  `ELEM_UID` varchar(255) DEFAULT NULL,
  `ANDLOGIC` bit(1) DEFAULT NULL,
  `QATTNAME` varchar(255) DEFAULT NULL,
  `DELPHICHARTTYPE` varchar(255) DEFAULT NULL,
  `QHELP` text,
  `QHIDDEN` bit(1) DEFAULT NULL,
  `QATT` bit(1) DEFAULT NULL,
  `DELPHI` bit(1) DEFAULT NULL,
  `ISUNIQUE` bit(1) DEFAULT NULL,
  `NONEGATIVE` bit(1) DEFAULT NULL,
  `QOPTIONAL` bit(1) DEFAULT NULL,
  `POINTS` int DEFAULT NULL,
  `QREADONLY` bit(1) DEFAULT NULL,
  `SCORING` int DEFAULT NULL,
  `DELPHIEXPLANATION` bit(1) DEFAULT NULL,
  `CHOICEORDER` int DEFAULT NULL,
  `COMPLEXTABLECOLUMNS` int DEFAULT NULL,
  `COMPLEXTABLEROWS` int DEFAULT NULL,
  `COMPLEXTABLESHOWHEADERS` bit(1) DEFAULT NULL,
  `COMPLEXTABLESIZE` int DEFAULT NULL,
  `CELLTYPE` int DEFAULT NULL,
  `CELLCOLUMN` int DEFAULT NULL,
  `CELLCOLUMNSPAN` int DEFAULT NULL,
  `DECIMALPLACES` int DEFAULT NULL,
  `FORMULA` varchar(255) DEFAULT NULL,
  `MAXNUMBER` double DEFAULT NULL,
  `MAXCHARS` int DEFAULT NULL,
  `MAX_CHOICES` int DEFAULT NULL,
  `MINNUMBER` double DEFAULT NULL,
  `MINCHARS` int DEFAULT NULL,
  `MIN_CHOICES` int DEFAULT NULL,
  `NUMCOLUMNS` int DEFAULT NULL,
  `NUMROWS` int DEFAULT NULL,
  `RESULTTEXT` varchar(255) DEFAULT NULL,
  `CELLROW` int DEFAULT NULL,
  `NUMBERUNIT` varchar(255) DEFAULT NULL,
  `CHECKBOXES` bit(1) DEFAULT NULL,
  `RADIO` bit(1) DEFAULT NULL,
  `CONFLABEL` longtext,
  `CONFTEXT` longtext,
  `ISUSETEXT` bit(1) DEFAULT NULL,
  `ISUSEUPLOAD` bit(1) DEFAULT NULL,
  `MAX` datetime DEFAULT NULL,
  `MIN` datetime DEFAULT NULL,
  `ISCOMPARABLE` bit(1) DEFAULT NULL,
  `ISPASSWORD` bit(1) DEFAULT NULL,
  `COLS` int DEFAULT NULL,
  `SELLIMIT` int DEFAULT NULL,
  `NUMBERING` bit(1) DEFAULT NULL,
  `SELECTION` bit(1) DEFAULT NULL,
  `ALIGN` varchar(255) DEFAULT NULL,
  `LONGDESC` varchar(255) DEFAULT NULL,
  `SCALE` int DEFAULT NULL,
  `URL` varchar(255) DEFAULT NULL,
  `IM_WIDTH` int DEFAULT NULL,
  `FIRSTCELLTEXT` longtext,
  `TABLETYPE` int DEFAULT NULL,
  `TABLEWIDTHS` varchar(255) DEFAULT NULL,
  `MATRIXCOLUMNS` int DEFAULT NULL,
  `MATRIXINTER` bit(1) DEFAULT NULL,
  `MATRIXSINGLE` bit(1) DEFAULT NULL,
  `MAX_ROWS` int DEFAULT NULL,
  `MIN_ROWS` int DEFAULT NULL,
  `QUESTIONORDER` int DEFAULT NULL,
  `MATRIXROWS` int DEFAULT NULL,
  `useRadioButtons` bit(1) DEFAULT NULL,
  `MULTIPLE_CHOICE_STYLE` int DEFAULT NULL,
  `DISPLAY` varchar(255) DEFAULT NULL,
  `GRADSCALE` bit(1) DEFAULT NULL,
  `INITSLIDER` varchar(255) DEFAULT NULL,
  `MAXDISTANCEDOUBLE` double DEFAULT NULL,
  `MAXLABEL` varchar(255) DEFAULT NULL,
  `MINLABEL` varchar(255) DEFAULT NULL,
  `ecfScore` int DEFAULT NULL,
  `EXCLUSIVE` bit(1) DEFAULT NULL,
  `QUESTION_ID` int DEFAULT NULL,
  `orderChanged` bit(1) DEFAULT NULL,
  `ICONTYPE` int DEFAULT NULL,
  `NUMICONS` int DEFAULT NULL,
  `REG` varchar(255) DEFAULT NULL,
  `COLOR` varchar(255) DEFAULT NULL,
  `HEIGHT` int DEFAULT NULL,
  `STYLE` varchar(255) DEFAULT NULL,
  `HLEVEL` int DEFAULT NULL,
  `SECTIONORDER` int DEFAULT NULL,
  `TABTITLE` varchar(255) DEFAULT NULL,
  `DISPLAYALLQUESTIONS` bit(1) DEFAULT NULL,
  `SAQUESTION` bit(1) DEFAULT NULL,
  `TARGETDATASET` bit(1) DEFAULT NULL,
  `MAXDISTANCE` int DEFAULT NULL,
  `SINGLE_CHOICE_STYLE` int DEFAULT NULL,
  `LIKERT` bit(1) DEFAULT NULL,
  `TABLECOLUMNS` int DEFAULT NULL,
  `TABLEROWS` int DEFAULT NULL,
  `MAXTIME` varchar(255) DEFAULT NULL,
  `MINTIME` varchar(255) DEFAULT NULL,
  `EXTENSIONS` varchar(255) DEFAULT NULL,
  `MAXFILESIZE` int DEFAULT NULL,
  `ECF_COMPETENCY` int DEFAULT NULL,
  `dependentElements_ID` int DEFAULT NULL,
  `ECF_PROFILE` int DEFAULT NULL,
  `id_score` int DEFAULT NULL,
  `SACRITERION` int DEFAULT NULL,
  `childElements_ID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKlv4kb6a26yqjd9q8vi38e9sv6` (`ECF_COMPETENCY`),
  KEY `FK7gxm1dji3mfvsdjx7bdjdp0x0` (`dependentElements_ID`),
  KEY `FKm9x0ot8a44dlxtd8m3unhl7or` (`ECF_PROFILE`),
  KEY `FKq5qaagmomylrk3bnhst6515e4` (`id_score`),
  KEY `FKcvyrv8wl76g2wbrqchkmmxse` (`SACRITERION`),
  KEY `FKcngcier3xpvco237w2s5pvyhi` (`childElements_ID`),
  KEY `IDX_ELEMENT_UID` (`ELEM_UID`),
  KEY `IDX_ELEMENT_URL` (`URL`),
  CONSTRAINT `FK7gxm1dji3mfvsdjx7bdjdp0x0` FOREIGN KEY (`dependentElements_ID`) REFERENCES `depitems` (`ID`),
  CONSTRAINT `FKcngcier3xpvco237w2s5pvyhi` FOREIGN KEY (`childElements_ID`) REFERENCES `elements` (`ID`),
  CONSTRAINT `FKcvyrv8wl76g2wbrqchkmmxse` FOREIGN KEY (`SACRITERION`) REFERENCES `sacriteria` (`SACRITERIA_ID`),
  CONSTRAINT `FKlv4kb6a26yqjd9q8vi38e9sv6` FOREIGN KEY (`ECF_COMPETENCY`) REFERENCES `ecf_competency` (`COMPETENCY_ID`),
  CONSTRAINT `FKm9x0ot8a44dlxtd8m3unhl7or` FOREIGN KEY (`ECF_PROFILE`) REFERENCES `ecf_profile` (`PROFILE_ID`),
  CONSTRAINT `FKq5qaagmomylrk3bnhst6515e4` FOREIGN KEY (`id_score`) REFERENCES `scoringitems` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.elements: ~23 rows (approximately)
INSERT INTO `elements` (`type`, `ID`, `DISPLAYMODE`, `EDIT_COLUMNS_LOCKED`, `EDIT_ROWS_LOCKED`, `ELOCKED`, `EPOSITION`, `ELEM_SHORTNAME`, `SOURCE_ID`, `SUBTYPE`, `ETITLE`, `ELEM_UID`, `ANDLOGIC`, `QATTNAME`, `DELPHICHARTTYPE`, `QHELP`, `QHIDDEN`, `QATT`, `DELPHI`, `ISUNIQUE`, `NONEGATIVE`, `QOPTIONAL`, `POINTS`, `QREADONLY`, `SCORING`, `DELPHIEXPLANATION`, `CHOICEORDER`, `COMPLEXTABLECOLUMNS`, `COMPLEXTABLEROWS`, `COMPLEXTABLESHOWHEADERS`, `COMPLEXTABLESIZE`, `CELLTYPE`, `CELLCOLUMN`, `CELLCOLUMNSPAN`, `DECIMALPLACES`, `FORMULA`, `MAXNUMBER`, `MAXCHARS`, `MAX_CHOICES`, `MINNUMBER`, `MINCHARS`, `MIN_CHOICES`, `NUMCOLUMNS`, `NUMROWS`, `RESULTTEXT`, `CELLROW`, `NUMBERUNIT`, `CHECKBOXES`, `RADIO`, `CONFLABEL`, `CONFTEXT`, `ISUSETEXT`, `ISUSEUPLOAD`, `MAX`, `MIN`, `ISCOMPARABLE`, `ISPASSWORD`, `COLS`, `SELLIMIT`, `NUMBERING`, `SELECTION`, `ALIGN`, `LONGDESC`, `SCALE`, `URL`, `IM_WIDTH`, `FIRSTCELLTEXT`, `TABLETYPE`, `TABLEWIDTHS`, `MATRIXCOLUMNS`, `MATRIXINTER`, `MATRIXSINGLE`, `MAX_ROWS`, `MIN_ROWS`, `QUESTIONORDER`, `MATRIXROWS`, `useRadioButtons`, `MULTIPLE_CHOICE_STYLE`, `DISPLAY`, `GRADSCALE`, `INITSLIDER`, `MAXDISTANCEDOUBLE`, `MAXLABEL`, `MINLABEL`, `ecfScore`, `EXCLUSIVE`, `QUESTION_ID`, `orderChanged`, `ICONTYPE`, `NUMICONS`, `REG`, `COLOR`, `HEIGHT`, `STYLE`, `HLEVEL`, `SECTIONORDER`, `TABTITLE`, `DISPLAYALLQUESTIONS`, `SAQUESTION`, `TARGETDATASET`, `MAXDISTANCE`, `SINGLE_CHOICE_STYLE`, `LIKERT`, `TABLECOLUMNS`, `TABLEROWS`, `MAXTIME`, `MINTIME`, `EXTENSIONS`, `MAXFILESIZE`, `ECF_COMPETENCY`, `dependentElements_ID`, `ECF_PROFILE`, `id_score`, `SACRITERION`, `childElements_ID`) VALUES
	('FREETEXT', 1, 0, b'0', b'0', b'0', 1, 'name', NULL, '', 'Your login', 'e080cffa-bbfb-499b-85ad-4ae4852d52b8', b'0', 'name', 'WordCloud', 'The user name must be unique and cannot contain blanks. You can use your email address or any other text that contains only numbers and small/upper characters.', b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('FREETEXT', 2, 0, b'0', b'0', b'0', 2, 'firstname', NULL, '', 'Your first name', '994e8788-fb04-4cb9-8fbb-cc1f3c3f4d57', b'0', 'firstname', 'WordCloud', NULL, b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('FREETEXT', 3, 0, b'0', b'0', b'0', 3, 'lastname', NULL, '', 'Your last name', 'dd96c897-bc91-496f-b505-ca931d4ba4e0', b'0', 'lastname', 'WordCloud', NULL, b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('FREETEXT', 4, 0, b'0', b'0', b'0', 4, 'password', NULL, '', 'Your password', 'e4d79bcd-5bc8-4388-bf5a-bf818c133130', b'0', 'password', 'WordCloud', NULL, b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('EMAIL', 5, 0, b'0', b'0', b'0', 5, 'email', NULL, '', 'Your email address', '4ef7aafe-4741-48a4-bd58-cda6e64b4a14', b'0', 'email', 'None', 'Please provide a valid email address for account validation.', b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('SINGLECHOICE', 6, 0, b'0', b'0', b'0', 6, 'language', NULL, '', 'Your language', '42cfdc67-eaf3-4e14-8e93-0f035a3eb7bf', b'0', 'language', 'Pie', NULL, b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'0', -1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('PossibleAnswer', 7, NULL, b'0', b'0', b'0', NULL, 'DE', NULL, '', 'German', '61a43b31-c110-40fa-aa06-39b011479d6f', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
	('PossibleAnswer', 8, NULL, b'0', b'0', b'0', NULL, 'EN', NULL, '', 'English', '8116deb5-0f7d-4f88-b9ca-9242cdc101f3', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL),
	('PossibleAnswer', 9, NULL, b'0', b'0', b'0', NULL, 'FR', NULL, '', 'French', '65263d47-87b6-457f-a5e8-99f96422e70b', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL),
	('FREETEXT', 10, 0, b'0', b'0', b'0', 1, 'name', 1, '', 'Your login', 'e080cffa-bbfb-499b-85ad-4ae4852d52b8', b'0', 'name', 'WordCloud', 'The user name must be unique and cannot contain blanks. You can use your email address or any other text that contains only numbers and small/upper characters.', b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('FREETEXT', 11, 0, b'0', b'0', b'0', 2, 'firstname', 2, '', 'Your first name', '994e8788-fb04-4cb9-8fbb-cc1f3c3f4d57', b'0', 'firstname', 'WordCloud', NULL, b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('FREETEXT', 12, 0, b'0', b'0', b'0', 3, 'lastname', 3, '', 'Your last name', 'dd96c897-bc91-496f-b505-ca931d4ba4e0', b'0', 'lastname', 'WordCloud', NULL, b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('FREETEXT', 13, 0, b'0', b'0', b'0', 4, 'password', 4, '', 'Your password', 'e4d79bcd-5bc8-4388-bf5a-bf818c133130', b'0', 'password', 'WordCloud', NULL, b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('EMAIL', 14, 0, b'0', b'0', b'0', 5, 'email', 5, '', 'Your email address', '4ef7aafe-4741-48a4-bd58-cda6e64b4a14', b'0', 'email', 'None', 'Please provide a valid email address for account validation.', b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('SINGLECHOICE', 15, 0, b'0', b'0', b'0', 6, 'language', 6, '', 'Your language', '42cfdc67-eaf3-4e14-8e93-0f035a3eb7bf', b'0', 'language', 'Pie', NULL, b'0', b'0', b'0', b'0', b'0', b'0', 0, b'0', 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'0', -1, 1, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('PossibleAnswer', 16, 0, b'0', b'0', b'0', NULL, 'DE', 7, '', 'German', '61a43b31-c110-40fa-aa06-39b011479d6f', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL),
	('PossibleAnswer', 17, 0, b'0', b'0', b'0', NULL, 'EN', 8, '', 'English', '8116deb5-0f7d-4f88-b9ca-9242cdc101f3', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL),
	('PossibleAnswer', 18, 0, b'0', b'0', b'0', NULL, 'FR', 9, '', 'French', '65263d47-87b6-457f-a5e8-99f96422e70b', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL),
	('SECTION', 19, 0, b'0', b'0', b'0', 0, 'ID1', NULL, '', 'Section Title', 'a07dcebc-598e-285f-4e64-75d4f9568bfc', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, '[Section]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('FREETEXT', 20, 0, b'0', b'0', b'0', 1, 'ID2', NULL, '', 'Your name', 'ffd580f9-48aa-50b0-6d24-45c620eae004', b'0', 'ID2', 'WordCloud', '', b'0', b'0', b'0', b'0', b'0', b'1', 0, b'0', 0, b'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('SINGLECHOICE', 21, 0, b'0', b'0', b'0', 2, 'ID3', NULL, '', 'Single Choice Question', 'f69977a0-fcda-4ea7-060d-dfa7e9b2d0f2', b'0', 'ID3', 'Pie', '', b'0', b'0', b'0', b'0', b'0', b'1', 0, b'0', 0, b'1', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, b'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', b'0', b'0', 0, 0, b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('PossibleAnswer', 22, 0, b'0', b'0', b'0', 0, 'ID4', NULL, '', 'Male', '55807874-ef33-4b58-9928-1d86f5f05457', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL),
	('PossibleAnswer', 23, 0, b'0', b'0', b'0', 1, 'ID5', NULL, '', 'Female', 'b46d1ace-2b26-44ae-8179-3dd538dc836b', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, b'0', 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL);

-- Dumping structure for table eusurveydb_rev3.elements_elements
CREATE TABLE IF NOT EXISTS `elements_elements` (
  `ELEMENTS_ID` int NOT NULL,
  `possibleAnswers_ID` int NOT NULL,
  UNIQUE KEY `UK_6e1ttf7d9e4qi3sr49ow22jt5` (`possibleAnswers_ID`),
  CONSTRAINT `FKm2ahbltm4bd8u1sno2basvrwo` FOREIGN KEY (`possibleAnswers_ID`) REFERENCES `elements` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.elements_elements: ~8 rows (approximately)
INSERT INTO `elements_elements` (`ELEMENTS_ID`, `possibleAnswers_ID`) VALUES
	(6, 7),
	(6, 8),
	(6, 9),
	(15, 16),
	(15, 17),
	(15, 18),
	(21, 22),
	(21, 23);

-- Dumping structure for table eusurveydb_rev3.elements_files
CREATE TABLE IF NOT EXISTS `elements_files` (
  `ELEMENTS_ID` int NOT NULL,
  `files_FILE_ID` int NOT NULL,
  UNIQUE KEY `UC_ELEMENTS_FILES` (`ELEMENTS_ID`,`files_FILE_ID`),
  KEY `FK4keswah46hd9c4cr971fpm4ok` (`files_FILE_ID`),
  CONSTRAINT `FK4keswah46hd9c4cr971fpm4ok` FOREIGN KEY (`files_FILE_ID`) REFERENCES `files` (`FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.elements_files: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.elements_scoringitems
CREATE TABLE IF NOT EXISTS `elements_scoringitems` (
  `ELEMENTS_ID` int NOT NULL,
  `scoringItems_ID` int NOT NULL,
  UNIQUE KEY `UK_opd1gfw29s5pdse2l493dhwut` (`scoringItems_ID`),
  CONSTRAINT `FKlds8x0tpt5ww3wjjlpgg2bfnd` FOREIGN KEY (`scoringItems_ID`) REFERENCES `scoringitems` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.elements_scoringitems: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.explanation_likes
CREATE TABLE IF NOT EXISTS `explanation_likes` (
  `EXPLANATION_LIKE_ID` int NOT NULL AUTO_INCREMENT,
  `ANSWER_EXPLANATION_ID` int DEFAULT NULL,
  `ANSWER_SET_CODE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EXPLANATION_LIKE_ID`),
  KEY `EXPLANATIONLIKE_IDX` (`ANSWER_EXPLANATION_ID`,`ANSWER_SET_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.explanation_likes: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.exportcache
CREATE TABLE IF NOT EXISTS `exportcache` (
  `EXPCA_ID` int NOT NULL AUTO_INCREMENT,
  `FILTER` varchar(255) DEFAULT NULL,
  `SURVEYID` int DEFAULT NULL,
  `EXTYPE` varchar(255) DEFAULT NULL,
  `UID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EXPCA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.exportcache: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.exports
CREATE TABLE IF NOT EXISTS `exports` (
  `EXPORT_ID` int NOT NULL AUTO_INCREMENT,
  `EXPORT_META` bit(1) DEFAULT NULL,
  `EXPORT_ALLANSWERS` bit(1) DEFAULT NULL,
  `EXPORT_CHARTS` longtext,
  `EXPORT_DATE` datetime DEFAULT NULL,
  `EXPORT_EMAIL` varchar(255) DEFAULT NULL,
  `EXPORT_FORARCHIVING` bit(1) DEFAULT NULL,
  `EXPORT_FORMAT` int DEFAULT NULL,
  `EXPORT_NAME` varchar(255) DEFAULT NULL,
  `EXPORT_NOT` bit(1) DEFAULT NULL,
  `EXPORT_PARTGROUP` int DEFAULT NULL,
  `EXPORT_SHORTNAMES` bit(1) DEFAULT NULL,
  `EXPORT_SPLIT_MCQ` bit(1) DEFAULT NULL,
  `EXPORT_STATE` int DEFAULT NULL,
  `EXPORT_TYPE` int DEFAULT NULL,
  `USER_ID` int DEFAULT NULL,
  `EXPORT_VALID` bit(1) DEFAULT NULL,
  `EXPORT_ZIPPED` bit(1) DEFAULT NULL,
  `id_acflt` int DEFAULT NULL,
  `id_resflt` int DEFAULT NULL,
  `SURVEY_ID` int DEFAULT NULL,
  PRIMARY KEY (`EXPORT_ID`),
  KEY `FK7twwvf92f5lcjvtfaxo9bw4o9` (`id_acflt`),
  KEY `FKll0y6g0u5huotfnq4k9ms0yvp` (`id_resflt`),
  KEY `FK310gvurjdmfxwvmelmivcaspv` (`SURVEY_ID`),
  KEY `CHECKNEW` (`USER_ID`,`EXPORT_STATE`,`EXPORT_NOT`),
  CONSTRAINT `FK310gvurjdmfxwvmelmivcaspv` FOREIGN KEY (`SURVEY_ID`) REFERENCES `surveys` (`SURVEY_ID`),
  CONSTRAINT `FK7twwvf92f5lcjvtfaxo9bw4o9` FOREIGN KEY (`id_acflt`) REFERENCES `activityfilter` (`ACFILTER_ID`),
  CONSTRAINT `FKll0y6g0u5huotfnq4k9ms0yvp` FOREIGN KEY (`id_resflt`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.exports: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.files
CREATE TABLE IF NOT EXISTS `files` (
  `FILE_ID` int NOT NULL AUTO_INCREMENT,
  `FILE_COMMENT` text,
  `FILE_DEL` datetime DEFAULT NULL,
  `FILE_DESC` varchar(255) DEFAULT NULL,
  `FILE_LONGDESC` varchar(255) DEFAULT NULL,
  `FILE_NAME` varchar(255) NOT NULL,
  `FILE_POS` int DEFAULT NULL,
  `FILE_UID` varchar(255) NOT NULL,
  `FILE_WIDTH` int NOT NULL,
  PRIMARY KEY (`FILE_ID`),
  KEY `IDX_FILE_UID` (`FILE_UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.files: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.globalroles
CREATE TABLE IF NOT EXISTS `globalroles` (
  `ROLE_ID` int NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(255) DEFAULT NULL,
  `ROLE_PRIVILEGES` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.globalroles: ~5 rows (approximately)
INSERT INTO `globalroles` (`ROLE_ID`, `ROLE_NAME`, `ROLE_PRIVILEGES`) VALUES
	(1, 'Administrator', 'RightManagement:2;UserManagement:2;FormManagement:2;ContactManagement:2;ECAccess:1;SystemManagement:2;'),
	(2, 'Form Manager', 'RightManagement:0;UserManagement:1;FormManagement:1;ContactManagement:1;ECAccess:0;SystemManagement:0;'),
	(3, 'Form Manager (EC)', 'RightManagement:0;UserManagement:1;FormManagement:1;ContactManagement:1;ECAccess:1;SystemManagement:0;'),
	(4, 'Support', 'RightManagement:0;UserManagement:2;FormManagement:2;ContactManagement:2;ECAccess:1;SystemManagement:1;'),
	(5, 'Contributor', 'RightManagement:0;UserManagement:0;FormManagement:0;ContactManagement:0;ECAccess:0;SystemManagement:0;');

-- Dumping structure for procedure eusurveydb_rev3.initInvitations
DELIMITER //
CREATE PROCEDURE `initInvitations`()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE pid INT;	
	DECLARE pnum INT;
    DECLARE counter INT;

	DECLARE cur1 CURSOR FOR SELECT PARTICIPATION_ID FROM PARTICIPANTS;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;

	SET counter = 1;

	read_loop2: LOOP

		FETCH cur1 INTO pid;
		IF done THEN
		  LEAVE read_loop2;
		END IF;

		SELECT count(*) FROM INVITATIONS WHERE PARTICIPATIONGROUP_ID = pid INTO pnum;

		IF (pnum > 0) THEN
			UPDATE PARTICIPANTS SET PARTICIPATION_INVITED = pnum WHERE PARTICIPATION_ID = pid;
		END IF;	
		
		SELECT count(*) FROM INVITATIONS WHERE PARTICIPATIONGROUP_ID = pid AND INV_DEACTIVATED = 1 INTO pnum;

		IF (pnum > 0) THEN
			UPDATE PARTICIPANTS SET PARTICIPATION_INVITED_DEAC = pnum WHERE PARTICIPATION_ID = pid;
		END IF;	

		SET counter = counter + 1;

	END LOOP;

	CLOSE cur1;

	SELECT counter;
END//
DELIMITER ;

-- Dumping structure for table eusurveydb_rev3.invitations
CREATE TABLE IF NOT EXISTS `invitations` (
  `INVITATION_ID` int NOT NULL AUTO_INCREMENT,
  `ATTENDEE_ANSWERS` int DEFAULT NULL,
  `ATTENDEE_ID` int DEFAULT NULL,
  `INV_DEACTIVATED` bit(1) DEFAULT NULL,
  `ATTENDEE_INVITED` datetime DEFAULT NULL,
  `PARTICIPATIONGROUP_ID` int DEFAULT NULL,
  `ATTENDEE_REMINDED` datetime DEFAULT NULL,
  `UNIQUE_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`INVITATION_ID`),
  KEY `inv_group` (`PARTICIPATIONGROUP_ID`,`INV_DEACTIVATED`),
  KEY `inv_attendee_id` (`ATTENDEE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.invitations: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.invtempl
CREATE TABLE IF NOT EXISTS `invtempl` (
  `INVTEMPL_ID` int NOT NULL AUTO_INCREMENT,
  `INVTEMPL_NAME` varchar(255) DEFAULT NULL,
  `INVTEMPLREPLY` varchar(255) DEFAULT NULL,
  `INVTEMPL1` longtext,
  `INVTEMPL2` longtext,
  `INVTEMPLMAIL` varchar(255) DEFAULT NULL,
  `INVTEMPLSUBJ` varchar(255) DEFAULT NULL,
  `INVTEMPLTEXT` int DEFAULT NULL,
  `OWNER` int NOT NULL,
  PRIMARY KEY (`INVTEMPL_ID`),
  UNIQUE KEY `INVTEMPL_NAME` (`INVTEMPL_NAME`,`OWNER`),
  KEY `FKit0due477w2ge0i9c8guaw2vk` (`OWNER`),
  CONSTRAINT `FKit0due477w2ge0i9c8guaw2vk` FOREIGN KEY (`OWNER`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.invtempl: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.languages
CREATE TABLE IF NOT EXISTS `languages` (
  `LANGUAGE_ID` int NOT NULL AUTO_INCREMENT,
  `LANGUAGE_CODE` varchar(255) DEFAULT NULL,
  `LANGUAGE_ENNAME` varchar(255) DEFAULT NULL,
  `LANGUAGE_NAME` varchar(255) DEFAULT NULL,
  `LANGUAGE_OFFI` bit(1) DEFAULT NULL,
  PRIMARY KEY (`LANGUAGE_ID`),
  KEY `IDX_LANGUAGES_LANGUAGE_CODE` (`LANGUAGE_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.languages: ~3 rows (approximately)
INSERT INTO `languages` (`LANGUAGE_ID`, `LANGUAGE_CODE`, `LANGUAGE_ENNAME`, `LANGUAGE_NAME`, `LANGUAGE_OFFI`) VALUES
	(1, 'EN', 'English', 'English', b'1'),
	(2, 'DE', 'German', 'Deutsch', b'1'),
	(3, 'FR', 'French', 'Francais', b'1');

-- Dumping structure for table eusurveydb_rev3.livestatistics
CREATE TABLE IF NOT EXISTS `livestatistics` (
  `LIVESTAT_ID` int NOT NULL AUTO_INCREMENT,
  `NUM` int DEFAULT NULL,
  `PAID` int DEFAULT NULL,
  `PAUID` varchar(255) DEFAULT NULL,
  `QID` int DEFAULT NULL,
  `QUID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LIVESTAT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.livestatistics: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.mailtasks
CREATE TABLE IF NOT EXISTS `mailtasks` (
  `MAILTASK_ID` int NOT NULL AUTO_INCREMENT,
  `MAILTASK_LOCALE` varchar(255) DEFAULT NULL,
  `MAILTASK_SENT` int DEFAULT NULL,
  `MAILTASK_TEMPLATE` varchar(255) DEFAULT NULL,
  `MAILTASK_RESULT` varchar(255) DEFAULT NULL,
  `MAILTASK_NOT` bit(1) DEFAULT NULL,
  `MAILTASK_PARAMS` longtext,
  `MAILTASK_PG` int DEFAULT NULL,
  `MAILTASK_ATT` varchar(255) DEFAULT NULL,
  `MAILTASK_S` varchar(255) DEFAULT NULL,
  `MAILTASK_SUBJECT` varchar(255) DEFAULT NULL,
  `MAILTASK_STATE` varchar(255) DEFAULT NULL,
  `MAILTASK_SURVEY` varchar(255) DEFAULT NULL,
  `MAILTASK_T1` longtext,
  `MAILTASK_T2` longtext,
  `MAILTASK_USER` int DEFAULT NULL,
  PRIMARY KEY (`MAILTASK_ID`),
  KEY `IDX_MAILTASKS` (`MAILTASK_SURVEY`,`MAILTASK_NOT`,`MAILTASK_STATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.mailtasks: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.matrix_dep
CREATE TABLE IF NOT EXISTS `matrix_dep` (
  `ELEMENTS_ID` int NOT NULL,
  `dependentElements_ID` int NOT NULL,
  `MATDEP_ID` int NOT NULL,
  PRIMARY KEY (`ELEMENTS_ID`,`MATDEP_ID`),
  UNIQUE KEY `UK_33ehtnp6nmxgvg8fb52mkg37x` (`dependentElements_ID`),
  CONSTRAINT `FKabg46x46jiidydnnq657pxotf` FOREIGN KEY (`dependentElements_ID`) REFERENCES `depitems` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.matrix_dep: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.message_types
CREATE TABLE IF NOT EXISTS `message_types` (
  `MT_ID` int NOT NULL AUTO_INCREMENT,
  `MT_CRITICALITY` int DEFAULT NULL,
  `MT_CSS` varchar(255) DEFAULT NULL,
  `MT_TIME` int DEFAULT NULL,
  `MT_ICON` varchar(255) DEFAULT NULL,
  `MT_LABEL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.message_types: ~3 rows (approximately)
INSERT INTO `message_types` (`MT_ID`, `MT_CRITICALITY`, `MT_CSS`, `MT_TIME`, `MT_ICON`, `MT_LABEL`) VALUES
	(1, 1, 'message-success', 20, 'check.png', 'Confirmation'),
	(2, 2, 'message-info', 20, 'info.png', 'Information'),
	(3, 3, 'message-error', 0, 'warning.png', 'Warning');

-- Dumping structure for table eusurveydb_rev3.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `M_ID` int NOT NULL AUTO_INCREMENT,
  `M_STATE` bit(1) DEFAULT NULL,
  `M_AUTODEAC` datetime DEFAULT NULL,
  `M_CRITICALITY` int DEFAULT NULL,
  `M_TEXT` text,
  `M_TIME` int DEFAULT NULL,
  `M_TYPE` int DEFAULT NULL,
  `M_USER` int DEFAULT NULL,
  `M_VERSION` int DEFAULT NULL,
  PRIMARY KEY (`M_ID`),
  KEY `MESSAGE_USER` (`M_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.messages: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.mt_request
CREATE TABLE IF NOT EXISTS `mt_request` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CREATED` datetime NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `SOURCE_FILE_URL` varchar(255) DEFAULT NULL,
  `IS_NOTIFY` bit(1) DEFAULT NULL,
  `SOURCE_LANG` varchar(2) NOT NULL,
  `TARGET_LANGS` varchar(255) NOT NULL,
  `TEXT_TO_TRANSLATE` varchar(4000) DEFAULT NULL,
  `TRANSLATION_ID` int DEFAULT NULL,
  `TRANSLATIONS_ID` int NOT NULL,
  `UID` varchar(255) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_1byb1nojchtypmtg6ojs3cvvh` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.mt_request: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.mt_response
CREATE TABLE IF NOT EXISTS `mt_response` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CREATED` datetime NOT NULL,
  `DELIVERY_URL` varchar(255) DEFAULT NULL,
  `ERR_CODE` varchar(255) DEFAULT NULL,
  `ERR_MSG` varchar(255) DEFAULT NULL,
  `TARGET_LANG` varchar(255) NOT NULL,
  `IS_TRANSLATED` bit(1) NOT NULL,
  `TRANSLATED_TEXT` varchar(4000) DEFAULT NULL,
  `IS_UPDATED` bit(1) NOT NULL,
  `REQUEST_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKrrm8eutwrtp66wto0n8cb0t5q` (`REQUEST_ID`),
  CONSTRAINT `FKrrm8eutwrtp66wto0n8cb0t5q` FOREIGN KEY (`REQUEST_ID`) REFERENCES `mt_request` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.mt_response: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.mv_surveys_numberpublishedanswers
CREATE TABLE IF NOT EXISTS `mv_surveys_numberpublishedanswers` (
  `SURVEYUID` varchar(255) CHARACTER SET utf8mb3 NOT NULL,
  `PUBLISHEDANSWERS` bigint NOT NULL DEFAULT '0',
  `LASTANSWER` datetime DEFAULT NULL,
  `MW_TIMESTAMP` datetime DEFAULT NULL,
  KEY `MV_SURVEYS_IND` (`SURVEYUID`,`PUBLISHEDANSWERS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table eusurveydb_rev3.mv_surveys_numberpublishedanswers: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.mv_surveys_numberpublishedanswers_new
CREATE TABLE IF NOT EXISTS `mv_surveys_numberpublishedanswers_new` (
  `SURVEYUID` varchar(255) CHARACTER SET utf8mb3 NOT NULL,
  `PUBLISHEDANSWERS` bigint NOT NULL DEFAULT '0',
  `LASTANSWER` datetime DEFAULT NULL,
  `MW_TIMESTAMP` datetime DEFAULT NULL,
  KEY `MV_SURVEYS_IND` (`SURVEYUID`,`PUBLISHEDANSWERS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table eusurveydb_rev3.mv_surveys_numberpublishedanswers_new: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.participants
CREATE TABLE IF NOT EXISTS `participants` (
  `PARTICIPATION_ID` int NOT NULL AUTO_INCREMENT,
  `ECAS_NAME` varchar(255) DEFAULT NULL,
  `PARTICIPATION_ACTIVE` bit(1) DEFAULT NULL,
  `SURVEY_CREATED` datetime DEFAULT NULL,
  `DOMAN_CODE` varchar(255) DEFAULT NULL,
  `ERROR` varchar(255) DEFAULT NULL,
  `INCREATION` tinyint(1) NOT NULL DEFAULT '0',
  `TEMPLID` int DEFAULT NULL,
  `PARTICIPANTS_NAME` varchar(255) DEFAULT NULL,
  `PARTICIPATION_OWNER_ID` int DEFAULT NULL,
  `PARTICIPATION_SURVEY_ID` int DEFAULT NULL,
  `PARTICIPATION_SURVEY_UID` varchar(255) DEFAULT NULL,
  `TEMPL1` text,
  `TEMPL2` text,
  `TEMPLSUBJ` varchar(255) DEFAULT NULL,
  `PARTICIPATION_TYPE` int DEFAULT NULL,
  `attendeeFilter_AFILTER_ID` int DEFAULT NULL,
  PRIMARY KEY (`PARTICIPATION_ID`),
  KEY `FKrg6wfc9h0bqpbjkvw9kgm6mtp` (`attendeeFilter_AFILTER_ID`),
  CONSTRAINT `FKrg6wfc9h0bqpbjkvw9kgm6mtp` FOREIGN KEY (`attendeeFilter_AFILTER_ID`) REFERENCES `attendeefilter` (`AFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.participants: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.participants_attendee
CREATE TABLE IF NOT EXISTS `participants_attendee` (
  `PARTICIPANTS_PARTICIPATION_ID` int NOT NULL,
  `attendees_ATTENDEE_ID` int NOT NULL,
  UNIQUE KEY `UC_PARTICIPANTS_ATTENDEE` (`attendees_ATTENDEE_ID`,`PARTICIPANTS_PARTICIPATION_ID`),
  CONSTRAINT `FK2psv5b6kgoxw6n6urub74ilb` FOREIGN KEY (`attendees_ATTENDEE_ID`) REFERENCES `attendee` (`ATTENDEE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.participants_attendee: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.participants_ecasusers
CREATE TABLE IF NOT EXISTS `participants_ecasusers` (
  `PARTICIPANTS_PARTICIPATION_ID` int NOT NULL,
  `ecasUsers_USER_ID` int NOT NULL,
  UNIQUE KEY `UC_PARTICIPANTS_ECASUSERS` (`ecasUsers_USER_ID`,`PARTICIPANTS_PARTICIPATION_ID`),
  CONSTRAINT `FKmyo6hq33gitbbbspgs9goo6jw` FOREIGN KEY (`ecasUsers_USER_ID`) REFERENCES `ecasusers` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.participants_ecasusers: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.paswwordreset
CREATE TABLE IF NOT EXISTS `paswwordreset` (
  `PR_ID` int NOT NULL AUTO_INCREMENT,
  `PR_CODE` varchar(255) DEFAULT NULL,
  `PR_CREATED` datetime NOT NULL,
  `PR_EMAIL` varchar(255) DEFAULT NULL,
  `PR_LOGIN` varchar(255) DEFAULT NULL,
  `PR_USER` int DEFAULT NULL,
  PRIMARY KEY (`PR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.paswwordreset: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.pending_changes
CREATE TABLE IF NOT EXISTS `pending_changes` (
  `PENDING_CHANGES_ID` int NOT NULL AUTO_INCREMENT,
  `SURVEY_UID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`PENDING_CHANGES_ID`),
  UNIQUE KEY `SURVEY_UID` (`SURVEY_UID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.pending_changes: ~2 rows (approximately)
INSERT INTO `pending_changes` (`PENDING_CHANGES_ID`, `SURVEY_UID`) VALUES
	(1, 'e6420370-c837-4910-b567-4d80386df4e4'),
	(2, 'f6c661cf-d66c-4f11-84bb-294b5367d964');

-- Dumping structure for table eusurveydb_rev3.pendingchanges_changedelements
CREATE TABLE IF NOT EXISTS `pendingchanges_changedelements` (
  `PendingChanges_PENDING_CHANGES_ID` int NOT NULL,
  `changedElements` varchar(255) DEFAULT NULL,
  KEY `FKnjr2gc4fwbe82eim6rshnjbek` (`PendingChanges_PENDING_CHANGES_ID`),
  CONSTRAINT `FKnjr2gc4fwbe82eim6rshnjbek` FOREIGN KEY (`PendingChanges_PENDING_CHANGES_ID`) REFERENCES `pending_changes` (`PENDING_CHANGES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.pendingchanges_changedelements: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.pendingchanges_deletedelements
CREATE TABLE IF NOT EXISTS `pendingchanges_deletedelements` (
  `PendingChanges_PENDING_CHANGES_ID` int NOT NULL,
  `deletedElements` varchar(255) DEFAULT NULL,
  KEY `FKoj717v37efonpfgdwy5flxyl1` (`PendingChanges_PENDING_CHANGES_ID`),
  CONSTRAINT `FKoj717v37efonpfgdwy5flxyl1` FOREIGN KEY (`PendingChanges_PENDING_CHANGES_ID`) REFERENCES `pending_changes` (`PENDING_CHANGES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.pendingchanges_deletedelements: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.pendingchanges_newelements
CREATE TABLE IF NOT EXISTS `pendingchanges_newelements` (
  `PendingChanges_PENDING_CHANGES_ID` int NOT NULL,
  `newElements` varchar(255) DEFAULT NULL,
  KEY `FKhb64dqwq07sjpux3x9cvy0o7c` (`PendingChanges_PENDING_CHANGES_ID`),
  CONSTRAINT `FKhb64dqwq07sjpux3x9cvy0o7c` FOREIGN KEY (`PendingChanges_PENDING_CHANGES_ID`) REFERENCES `pending_changes` (`PENDING_CHANGES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.pendingchanges_newelements: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.possibleanswer_element
CREATE TABLE IF NOT EXISTS `possibleanswer_element` (
  `DEPITEMS_ID` int NOT NULL,
  `dependentElements_ID` int NOT NULL,
  UNIQUE KEY `UC_POSSIBLEANSWER_ELEMENT` (`dependentElements_ID`,`DEPITEMS_ID`),
  CONSTRAINT `FK2p2pgn5iqh24ihsddvxg3bjli` FOREIGN KEY (`dependentElements_ID`) REFERENCES `elements` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.possibleanswer_element: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.publication
CREATE TABLE IF NOT EXISTS `publication` (
  `PUB_ID` int NOT NULL AUTO_INCREMENT,
  `PUB_ALLCONT` bit(1) DEFAULT NULL,
  `PUB_ALLQ` bit(1) DEFAULT NULL,
  `PUB_PASSWORD` varchar(255) DEFAULT NULL,
  `PUB_CHARTS` bit(1) DEFAULT NULL,
  `PUB_CONT` bit(1) DEFAULT NULL,
  `PUB_SEARCH` bit(1) DEFAULT NULL,
  `PUB_STAT` bit(1) DEFAULT NULL,
  `PUB_UPLOADED` bit(1) DEFAULT NULL,
  `filter_RESFILTER_ID` int DEFAULT NULL,
  PRIMARY KEY (`PUB_ID`),
  KEY `FKsyvmmtmu0y1omxlek1skkja6k` (`filter_RESFILTER_ID`),
  CONSTRAINT `FKsyvmmtmu0y1omxlek1skkja6k` FOREIGN KEY (`filter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.publication: ~4 rows (approximately)
INSERT INTO `publication` (`PUB_ID`, `PUB_ALLCONT`, `PUB_ALLQ`, `PUB_PASSWORD`, `PUB_CHARTS`, `PUB_CONT`, `PUB_SEARCH`, `PUB_STAT`, `PUB_UPLOADED`, `filter_RESFILTER_ID`) VALUES
	(1, b'1', b'1', NULL, b'0', b'0', b'1', b'0', b'0', 1),
	(2, b'1', b'1', NULL, b'0', b'0', b'1', b'0', b'0', 2),
	(3, b'1', b'1', NULL, b'0', b'0', b'1', b'0', b'0', 3),
	(4, b'1', b'1', NULL, b'0', b'0', b'1', b'0', b'0', 4);

-- Dumping structure for table eusurveydb_rev3.publishedsurvey
CREATE TABLE IF NOT EXISTS `publishedsurvey` (
  `PUBLISHEDSURVEY_ID` int NOT NULL AUTO_INCREMENT,
  `PUBLISHEDSURVEY_ORG` varchar(255) DEFAULT NULL,
  `PUBLISHEDSURVEY_PUBLISHED` datetime DEFAULT NULL,
  `PUBLISHEDSURVEY_SURVEY_UID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PUBLISHEDSURVEY_ID`),
  UNIQUE KEY `PS_SUID` (`PUBLISHEDSURVEY_SURVEY_UID`),
  KEY `PS_D_SUID` (`PUBLISHEDSURVEY_PUBLISHED`,`PUBLISHEDSURVEY_SURVEY_UID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.publishedsurvey: ~1 rows (approximately)
INSERT INTO `publishedsurvey` (`PUBLISHEDSURVEY_ID`, `PUBLISHEDSURVEY_ORG`, `PUBLISHEDSURVEY_PUBLISHED`, `PUBLISHEDSURVEY_SURVEY_UID`) VALUES
	(1, NULL, '2026-01-02 06:38:34', '40fd036a-97df-427c-b01c-9f72852e73e4');

-- Dumping structure for table eusurveydb_rev3.resultaccess
CREATE TABLE IF NOT EXISTS `resultaccess` (
  `RESACC_ID` int NOT NULL AUTO_INCREMENT,
  `RESACC_DATE` datetime DEFAULT NULL,
  `RESACC_OWNER` int DEFAULT NULL,
  `RESACC_READONLY` bit(1) DEFAULT NULL,
  `RESACC_ROQUESTIONS` varchar(255) DEFAULT NULL,
  `SURVEY` varchar(255) DEFAULT NULL,
  `RESACC_USER` int DEFAULT NULL,
  `id_resflt` int DEFAULT NULL,
  PRIMARY KEY (`RESACC_ID`),
  UNIQUE KEY `RESACC_USER` (`RESACC_USER`,`SURVEY`),
  KEY `FKjvhye6if2prn0vpu86pmhi8mn` (`id_resflt`),
  CONSTRAINT `FKjvhye6if2prn0vpu86pmhi8mn` FOREIGN KEY (`id_resflt`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultaccess: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.resultfilter
CREATE TABLE IF NOT EXISTS `resultfilter` (
  `RESFILTER_ID` int NOT NULL AUTO_INCREMENT,
  `RESFILTER_ANS_ECF_PROFILE_UID` varchar(255) DEFAULT NULL,
  `RESFILTER_CASE` varchar(255) DEFAULT NULL,
  `RESFILTER_COMP_ECF_PROFILE_UID` varchar(255) DEFAULT NULL,
  `RESFILTER_CRORUPD` bit(1) DEFAULT NULL,
  `RESFILTER_DEFAULT` bit(1) DEFAULT NULL,
  `draftId` varchar(255) DEFAULT NULL,
  `RESFILTER_DATEFROM` datetime DEFAULT NULL,
  `RESFILTER_DATETO` datetime DEFAULT NULL,
  `RESFILTER_INV` varchar(255) DEFAULT NULL,
  `RESFILTER_NOTESTANS` bit(1) DEFAULT NULL,
  `RESFILTER_REALUPD` bit(1) DEFAULT NULL,
  `RESFILTER_SORTKEY` varchar(255) DEFAULT NULL,
  `RESFILTER_SORTORDER` varchar(255) DEFAULT NULL,
  `RESFILTER_STATUS` varchar(255) DEFAULT NULL,
  `RESFILTER_SENDFROM` datetime DEFAULT NULL,
  `RESFILTER_SENDTO` datetime DEFAULT NULL,
  `surveyId` int NOT NULL,
  `RESFILTER_SURPUBRES` varchar(255) DEFAULT NULL,
  `surveyShortname` varchar(255) DEFAULT NULL,
  `RESFILTER_STITLE` varchar(255) DEFAULT NULL,
  `surveyTitle` varchar(255) DEFAULT NULL,
  `surveyUid` varchar(255) DEFAULT NULL,
  `RESFILTER_UPDATEFROM` datetime DEFAULT NULL,
  `RESFILTER_UPDATETO` datetime DEFAULT NULL,
  `RESFILTER_USER` varchar(255) DEFAULT NULL,
  `RESFILTER_OWNER` int DEFAULT NULL,
  PRIMARY KEY (`RESFILTER_ID`),
  KEY `IDX_RESULTFILTER_SURVEY_OWNER` (`surveyId`,`RESFILTER_OWNER`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter: ~4 rows (approximately)
INSERT INTO `resultfilter` (`RESFILTER_ID`, `RESFILTER_ANS_ECF_PROFILE_UID`, `RESFILTER_CASE`, `RESFILTER_COMP_ECF_PROFILE_UID`, `RESFILTER_CRORUPD`, `RESFILTER_DEFAULT`, `draftId`, `RESFILTER_DATEFROM`, `RESFILTER_DATETO`, `RESFILTER_INV`, `RESFILTER_NOTESTANS`, `RESFILTER_REALUPD`, `RESFILTER_SORTKEY`, `RESFILTER_SORTORDER`, `RESFILTER_STATUS`, `RESFILTER_SENDFROM`, `RESFILTER_SENDTO`, `surveyId`, `RESFILTER_SURPUBRES`, `surveyShortname`, `RESFILTER_STITLE`, `surveyTitle`, `surveyUid`, `RESFILTER_UPDATEFROM`, `RESFILTER_UPDATETO`, `RESFILTER_USER`, `RESFILTER_OWNER`) VALUES
	(1, NULL, NULL, NULL, b'0', b'1', NULL, NULL, NULL, NULL, b'0', b'0', 'created', 'DESC', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, NULL, NULL, NULL, b'0', b'1', NULL, NULL, NULL, NULL, b'0', b'0', 'created', 'DESC', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, NULL, NULL, NULL, b'0', b'1', NULL, NULL, NULL, NULL, b'0', b'0', 'created', 'DESC', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, NULL, NULL, NULL, b'0', b'1', NULL, NULL, NULL, NULL, b'0', b'0', 'created', 'DESC', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Dumping structure for table eusurveydb_rev3.resultfilter_exporteddiscussions
CREATE TABLE IF NOT EXISTS `resultfilter_exporteddiscussions` (
  `ResultFilter_RESFILTER_ID` int NOT NULL,
  `exportedDiscussions` varchar(255) DEFAULT NULL,
  KEY `FKcvs700m6owjt4sri5da8lc1of` (`ResultFilter_RESFILTER_ID`),
  CONSTRAINT `FKcvs700m6owjt4sri5da8lc1of` FOREIGN KEY (`ResultFilter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter_exporteddiscussions: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.resultfilter_exportedexplanations
CREATE TABLE IF NOT EXISTS `resultfilter_exportedexplanations` (
  `ResultFilter_RESFILTER_ID` int NOT NULL,
  `exportedExplanations` varchar(255) DEFAULT NULL,
  KEY `FKck0kwbdqa97bv6759lgnmx99p` (`ResultFilter_RESFILTER_ID`),
  CONSTRAINT `FKck0kwbdqa97bv6759lgnmx99p` FOREIGN KEY (`ResultFilter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter_exportedexplanations: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.resultfilter_exportedquestions
CREATE TABLE IF NOT EXISTS `resultfilter_exportedquestions` (
  `ResultFilter_RESFILTER_ID` int NOT NULL,
  `exportedQuestions` varchar(255) DEFAULT NULL,
  UNIQUE KEY `UC_ResultFilter_exportedQuestions` (`ResultFilter_RESFILTER_ID`,`exportedQuestions`),
  CONSTRAINT `FK2ggk4v7fam9aitl9f99f9li26` FOREIGN KEY (`ResultFilter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter_exportedquestions: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.resultfilter_filtervalues
CREATE TABLE IF NOT EXISTS `resultfilter_filtervalues` (
  `ResultFilter_RESFILTER_ID` int NOT NULL,
  `filterValues` text,
  `filterValues_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`ResultFilter_RESFILTER_ID`,`filterValues_KEY`),
  CONSTRAINT `FKekewyydfxndcuc2k5d4n7q9p3` FOREIGN KEY (`ResultFilter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter_filtervalues: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.resultfilter_languages
CREATE TABLE IF NOT EXISTS `resultfilter_languages` (
  `ResultFilter_RESFILTER_ID` int NOT NULL,
  `languages` varchar(255) DEFAULT NULL,
  UNIQUE KEY `UC_ResultFilter_languages` (`languages`,`ResultFilter_RESFILTER_ID`),
  KEY `FK8ttbjdvxi7y16nwtsvh2ukl49` (`ResultFilter_RESFILTER_ID`),
  CONSTRAINT `FK8ttbjdvxi7y16nwtsvh2ukl49` FOREIGN KEY (`ResultFilter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter_languages: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.resultfilter_visiblediscussions
CREATE TABLE IF NOT EXISTS `resultfilter_visiblediscussions` (
  `ResultFilter_RESFILTER_ID` int NOT NULL,
  `visibleDiscussions` varchar(255) DEFAULT NULL,
  KEY `FK232iygqv45q9g0q3ctsburjgi` (`ResultFilter_RESFILTER_ID`),
  CONSTRAINT `FK232iygqv45q9g0q3ctsburjgi` FOREIGN KEY (`ResultFilter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter_visiblediscussions: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.resultfilter_visibleexplanations
CREATE TABLE IF NOT EXISTS `resultfilter_visibleexplanations` (
  `ResultFilter_RESFILTER_ID` int NOT NULL,
  `visibleExplanations` varchar(255) DEFAULT NULL,
  KEY `FKc995v0tqc7meue0fdqaasex6k` (`ResultFilter_RESFILTER_ID`),
  CONSTRAINT `FKc995v0tqc7meue0fdqaasex6k` FOREIGN KEY (`ResultFilter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter_visibleexplanations: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.resultfilter_visiblequestions
CREATE TABLE IF NOT EXISTS `resultfilter_visiblequestions` (
  `ResultFilter_RESFILTER_ID` int NOT NULL,
  `visibleQuestions` varchar(255) DEFAULT NULL,
  UNIQUE KEY `UC_ResultFilter_visibleQuestions` (`ResultFilter_RESFILTER_ID`,`visibleQuestions`),
  CONSTRAINT `FKom7ekhxd9vcaps4csgxv3g17k` FOREIGN KEY (`ResultFilter_RESFILTER_ID`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.resultfilter_visiblequestions: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.sacriteria
CREATE TABLE IF NOT EXISTS `sacriteria` (
  `SACRITERIA_ID` int NOT NULL AUTO_INCREMENT,
  `SACRITERIA_ACRONYM` varchar(255) DEFAULT NULL,
  `SACRITERIA_NAME` varchar(255) DEFAULT NULL,
  `SACRITERIA_SURVEY` varchar(255) DEFAULT NULL,
  `SACRITERIA_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SACRITERIA_ID`),
  UNIQUE KEY `NAME_SURVEY` (`SACRITERIA_NAME`,`SACRITERIA_SURVEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.sacriteria: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.sareportconfig
CREATE TABLE IF NOT EXISTS `sareportconfig` (
  `SAREPORTCONFIG_ID` int NOT NULL AUTO_INCREMENT,
  `SAREPORTCONFIG_ALGORITHM` varchar(255) DEFAULT NULL,
  `SAREPORTCONFIG_CHARTS` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_COEFFICIENT` int DEFAULT NULL,
  `SAREPORTCONFIG_COMP` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_FEEDBACK` text NOT NULL,
  `SAREPORTCONFIG_GAPS` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_INTRO` text NOT NULL,
  `SAREPORTCONFIG_LEGEND` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_LIMIT` int DEFAULT NULL,
  `SAREPORTCONFIG_PERFTABLE` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_RESULTS` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_SCALE` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_CHART` varchar(255) DEFAULT NULL,
  `SAREPORTCONFIG_SCT` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_SURVEY` varchar(255) DEFAULT NULL,
  `SAREPORTCONFIG_TDS` bit(1) DEFAULT NULL,
  `SAREPORTCONFIG_TARGETSCORE` bit(1) DEFAULT NULL,
  PRIMARY KEY (`SAREPORTCONFIG_ID`),
  UNIQUE KEY `SURVEY_REPORT` (`SAREPORTCONFIG_SURVEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.sareportconfig: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.sascorecards
CREATE TABLE IF NOT EXISTS `sascorecards` (
  `SASCORECARD_ID` int NOT NULL AUTO_INCREMENT,
  `SASCORECARD_DATASETID` int DEFAULT NULL,
  PRIMARY KEY (`SASCORECARD_ID`),
  UNIQUE KEY `DATASET_SCORE` (`SASCORECARD_DATASETID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.sascorecards: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.sascores
CREATE TABLE IF NOT EXISTS `sascores` (
  `SASCORE_ID` int NOT NULL AUTO_INCREMENT,
  `SASCORE_CRITERION` int DEFAULT NULL,
  `SASCORE_NOTRELEVANT` bit(1) DEFAULT NULL,
  `SASCORE_SCORE` double DEFAULT NULL,
  `ScoreCard_ID` int DEFAULT NULL,
  PRIMARY KEY (`SASCORE_ID`),
  KEY `FKql356fum9n5p8rflx9dllvelk` (`ScoreCard_ID`),
  CONSTRAINT `FKql356fum9n5p8rflx9dllvelk` FOREIGN KEY (`ScoreCard_ID`) REFERENCES `sascorecards` (`SASCORECARD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.sascores: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.satargetdatasets
CREATE TABLE IF NOT EXISTS `satargetdatasets` (
  `SATARGETDATASETS_ID` int NOT NULL AUTO_INCREMENT,
  `SATARGETDATASETS_NAME` varchar(255) DEFAULT NULL,
  `SATARGETDATASETS_SURVEY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SATARGETDATASETS_ID`),
  UNIQUE KEY `NAME_SURVEY` (`SATARGETDATASETS_NAME`,`SATARGETDATASETS_SURVEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.satargetdatasets: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.scoringitems
CREATE TABLE IF NOT EXISTS `scoringitems` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CORRECT` bit(1) DEFAULT NULL,
  `FEEDBACK` text,
  `MAX` double DEFAULT NULL,
  `MAXDATE` datetime DEFAULT NULL,
  `MIN` double DEFAULT NULL,
  `MINDATE` datetime DEFAULT NULL,
  `POINTS` int DEFAULT NULL,
  `POSITION` int DEFAULT NULL,
  `SOURCE_ID` int DEFAULT NULL,
  `TYPE` int DEFAULT NULL,
  `UID` varchar(255) DEFAULT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `VALUE2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.scoringitems: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.servicerequests
CREATE TABLE IF NOT EXISTS `servicerequests` (
  `REQUESTS_ID` int NOT NULL AUTO_INCREMENT,
  `REQUESTS_COUNTER` int DEFAULT NULL,
  `REQUESTS_DATE` datetime DEFAULT NULL,
  `REQUESTS_USERID` int DEFAULT NULL,
  PRIMARY KEY (`REQUESTS_ID`),
  UNIQUE KEY `REQUESTS_USERID` (`REQUESTS_USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.servicerequests: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `SETTINGS_ID` int NOT NULL AUTO_INCREMENT,
  `SETTINGS_FORMAT` varchar(255) DEFAULT NULL,
  `SETTINGS_KEY` varchar(255) DEFAULT NULL,
  `SETTINGS_VALUE` text,
  PRIMARY KEY (`SETTINGS_ID`),
  UNIQUE KEY `UK_qnrdydvrspi8onevbdoctitv7` (`SETTINGS_KEY`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.settings: ~186 rows (approximately)
INSERT INTO `settings` (`SETTINGS_ID`, `SETTINGS_FORMAT`, `SETTINGS_KEY`, `SETTINGS_VALUE`) VALUES
	(1, 'true / false', 'LDAPsyncEnabled', 'true'),
	(2, 'number followed by \'d\' or \'w\' (days or weeks)', 'LDAPsyncFrequency', '1d'),
	(3, 'dd/MM/yyyy HH:mm:ss', 'LDAPsyncStart', '01/01/2014 23:00:00'),
	(4, 'HH:mm', 'LDAPsyncTime', '23:00'),
	(5, 'true / false', 'LDAPsync2Enabled', 'true'),
	(6, 'number followed by \'d\' or \'w\' (days or weeks)', 'LDAPsync2Frequency', '1w'),
	(7, 'dd/MM/yyyy HH:mm:ss', 'LDAPsync2Start', '01/01/2014 23:30:00'),
	(8, 'HH:mm', 'LDAPsync2Time', '23:30'),
	(9, 'true / false', 'ActivityLoggingEnabled', 'false'),
	(10, 'true / false', '101ActivityEnabled', 'true'),
	(11, 'true / false', '102ActivityEnabled', 'true'),
	(12, 'true / false', '103ActivityEnabled', 'true'),
	(13, 'true / false', '104ActivityEnabled', 'true'),
	(14, 'true / false', '105ActivityEnabled', 'true'),
	(15, 'true / false', '106ActivityEnabled', 'true'),
	(16, 'true / false', '107ActivityEnabled', 'true'),
	(17, 'true / false', '108ActivityEnabled', 'true'),
	(18, 'true / false', '109ActivityEnabled', 'true'),
	(19, 'true / false', '110ActivityEnabled', 'true'),
	(20, 'true / false', '111ActivityEnabled', 'true'),
	(21, 'true / false', '112ActivityEnabled', 'true'),
	(22, 'true / false', '113ActivityEnabled', 'true'),
	(23, 'true / false', '114ActivityEnabled', 'true'),
	(24, 'true / false', '115ActivityEnabled', 'true'),
	(25, 'true / false', '116ActivityEnabled', 'true'),
	(26, 'true / false', '117ActivityEnabled', 'true'),
	(27, 'true / false', '118ActivityEnabled', 'true'),
	(28, 'true / false', '119ActivityEnabled', 'true'),
	(29, 'true / false', '120ActivityEnabled', 'true'),
	(30, 'true / false', '121ActivityEnabled', 'true'),
	(31, 'true / false', '122ActivityEnabled', 'true'),
	(32, 'true / false', '123ActivityEnabled', 'true'),
	(33, 'true / false', '124ActivityEnabled', 'true'),
	(34, 'true / false', '128ActivityEnabled', 'true'),
	(35, 'true / false', '129ActivityEnabled', 'true'),
	(36, 'true / false', '130ActivityEnabled', 'true'),
	(37, 'true / false', '131ActivityEnabled', 'true'),
	(38, 'true / false', '132ActivityEnabled', 'true'),
	(39, 'true / false', '133ActivityEnabled', 'true'),
	(40, 'true / false', '134ActivityEnabled', 'true'),
	(41, 'true / false', '135ActivityEnabled', 'true'),
	(42, 'true / false', '136ActivityEnabled', 'true'),
	(43, 'true / false', '137ActivityEnabled', 'true'),
	(44, 'true / false', '201ActivityEnabled', 'true'),
	(45, 'true / false', '202ActivityEnabled', 'true'),
	(46, 'true / false', '203ActivityEnabled', 'true'),
	(47, 'true / false', '204ActivityEnabled', 'true'),
	(48, 'true / false', '205ActivityEnabled', 'true'),
	(49, 'true / false', '206ActivityEnabled', 'true'),
	(50, 'true / false', '207ActivityEnabled', 'true'),
	(51, 'true / false', '208ActivityEnabled', 'true'),
	(52, 'true / false', '209ActivityEnabled', 'true'),
	(53, 'true / false', '210ActivityEnabled', 'true'),
	(54, 'true / false', '211ActivityEnabled', 'true'),
	(55, 'true / false', '212ActivityEnabled', 'true'),
	(56, 'true / false', '213ActivityEnabled', 'true'),
	(57, 'true / false', '214ActivityEnabled', 'true'),
	(58, 'true / false', '215ActivityEnabled', 'true'),
	(59, 'true / false', '216ActivityEnabled', 'true'),
	(60, 'true / false', '217ActivityEnabled', 'true'),
	(61, 'true / false', '218ActivityEnabled', 'true'),
	(62, 'true / false', '219ActivityEnabled', 'true'),
	(63, 'true / false', '220ActivityEnabled', 'true'),
	(64, 'true / false', '221ActivityEnabled', 'true'),
	(65, 'true / false', '222ActivityEnabled', 'true'),
	(66, 'true / false', '223ActivityEnabled', 'true'),
	(67, 'true / false', '224ActivityEnabled', 'true'),
	(68, 'true / false', '225ActivityEnabled', 'true'),
	(69, 'true / false', '226ActivityEnabled', 'true'),
	(70, 'true / false', '227ActivityEnabled', 'true'),
	(71, 'true / false', '228ActivityEnabled', 'true'),
	(72, 'true / false', '301ActivityEnabled', 'true'),
	(73, 'true / false', '302ActivityEnabled', 'true'),
	(74, 'true / false', '303ActivityEnabled', 'true'),
	(75, 'true / false', '304ActivityEnabled', 'true'),
	(76, 'true / false', '305ActivityEnabled', 'true'),
	(77, 'true / false', '306ActivityEnabled', 'true'),
	(78, 'true / false', '307ActivityEnabled', 'true'),
	(79, 'true / false', '308ActivityEnabled', 'true'),
	(80, 'true / false', '309ActivityEnabled', 'true'),
	(81, 'true / false', '310ActivityEnabled', 'true'),
	(82, 'true / false', '311ActivityEnabled', 'true'),
	(83, 'true / false', '312ActivityEnabled', 'true'),
	(84, 'true / false', '313ActivityEnabled', 'true'),
	(85, 'true / false', '314ActivityEnabled', 'true'),
	(86, 'true / false', '315ActivityEnabled', 'true'),
	(87, 'true / false', '316ActivityEnabled', 'true'),
	(88, 'true / false', '317ActivityEnabled', 'true'),
	(89, 'true / false', '318ActivityEnabled', 'true'),
	(90, 'true / false', '319ActivityEnabled', 'true'),
	(91, 'true / false', '320ActivityEnabled', 'true'),
	(92, 'true / false', '401ActivityEnabled', 'true'),
	(93, 'true / false', '402ActivityEnabled', 'true'),
	(94, 'true / false', '403ActivityEnabled', 'true'),
	(95, 'true / false', '404ActivityEnabled', 'true'),
	(96, 'true / false', '405ActivityEnabled', 'true'),
	(97, 'true / false', '406ActivityEnabled', 'true'),
	(98, 'true / false', '407ActivityEnabled', 'true'),
	(99, 'true / false', '501ActivityEnabled', 'true'),
	(100, 'true / false', '502ActivityEnabled', 'true'),
	(101, 'true / false', '503ActivityEnabled', 'true'),
	(102, 'true / false', '504ActivityEnabled', 'true'),
	(103, 'true / false', '505ActivityEnabled', 'true'),
	(104, 'true / false', '506ActivityEnabled', 'true'),
	(105, 'true / false', '507ActivityEnabled', 'true'),
	(106, 'true / false', '508ActivityEnabled', 'true'),
	(107, 'true / false', '509ActivityEnabled', 'true'),
	(108, 'true / false', '601ActivityEnabled', 'true'),
	(109, 'true / false', '602ActivityEnabled', 'true'),
	(110, 'true / false', '603ActivityEnabled', 'true'),
	(111, 'true / false', '701ActivityEnabled', 'true'),
	(112, 'true / false', '801ActivityEnabled', 'true'),
	(113, 'true / false', '802ActivityEnabled', 'true'),
	(114, 'Integer', 'lowScore', '50'),
	(115, 'Integer', 'mediumScore', '100'),
	(116, 'Integer', 'highScore', '150'),
	(117, 'Integer', 'criticalScore', '200'),
	(118, 'Integer', 'weightSectionItem', '1'),
	(119, 'Integer', 'weightSimpleItem', '1'),
	(120, 'Integer', 'weightSimpleQuestion', '1'),
	(121, 'Integer', 'weightChoiceQuestion', '1'),
	(122, 'Integer', 'weightGalleryQuestion', '5'),
	(123, 'Integer', 'weightTableOrMatrixQuestion', '5'),
	(124, 'Integer', 'weightTooManyRows', '10'),
	(125, 'Integer', 'weightTooManyColumns', '10'),
	(126, 'Integer', 'rowThreshold', '10'),
	(127, 'Integer', 'columnThreshold', '10'),
	(128, 'Integer', 'weightTooManyPossibleAnswers', '10'),
	(129, 'Integer', 'possibleAnswersThreshold', '10'),
	(130, 'Integer', 'weightDependency', '5'),
	(131, 'Integer', 'weightDoubleDependency', '15'),
	(132, 'Integer', 'questionsThreshold', '50'),
	(133, 'Integer', 'questionsThresholdScore', '5'),
	(134, 'Integer', 'sectionThreshold', '5'),
	(135, 'Integer', 'sectionThresholdScore', '5'),
	(136, 'Integer', 'dependenciesThreshold', '10'),
	(137, 'Integer', 'dependenciesThresholdScore', '10'),
	(138, 'eucaptcha / recaptcha / internal / off', 'captcha', 'internal'),
	(139, 'minutes', 'uisessiontimeout', '60'),
	(140, 'true / false', 'disablewebservicelimit', 'false'),
	(141, 'id of newest survey that still uses old file system', 'lastsurveytomigrate', '0'),
	(142, 'HH:mm', 'surveymigratestart', '02:00'),
	(143, 'runtime in minutes', 'surveymigratetime', '120'),
	(144, 'id of newest survey that has to be checked for old answer pdfs', 'lastsurveytodeleteanswerpdfs', '0'),
	(145, 'HH:mm', 'answerpdfdeletionstart', '04:00'),
	(146, 'runtime in minutes', 'answerpdfdeletiontime', '60'),
	(147, 'true / false', 'CreateSurveysForExternalsDisabled', 'true'),
	(148, 'true / false', 'ReportingMigrationEnabled', 'false'),
	(149, 'HH:mm', 'ReportingMigrationStart', '20:00'),
	(150, 'runtime in minutes', 'ReportingMigrationTime', '60'),
	(151, 'uid of the survey', 'ReportingMigrationSurveyToMigrate', ''),
	(152, 'true / false', 'WeakAuthenticationDisabled', 'true'),
	(153, 'int', 'MaxReports', '5'),
	(154, 'text', 'ReportText', '<p>The following survey:<br /><table><tr><td>Published survey link:</td><td>[LINK]</td></tr><tr><td>Alias:</td><td>[ALIAS]</td></tr><tr><td>Title:</td><td>[TITLE]</td></tr></table>has been reported as infringing our policy by [EMAIL] at [DATE].</p><p>The reason provided is the following: [TYPE].</p><p>So far, it has been reported [COUNT] time(s).</p>'),
	(155, 'email addresses separated by ;', 'ReportRecipients', ''),
	(156, 'text', 'FreezeUserTextAdminBan', '<p>Please be informed that the following user [LOGIN] having the email address: [EMAIL] has been banned from EUSurvey.</p><p>For more information please contact the EUSurvey team.</p>'),
	(157, 'text', 'FreezeUserTextAdminUnban', '<p>Please be informed that the following user [LOGIN] having the email address: [EMAIL] has been unbanned from EUSurvey.</p><p>For more information please contact the EUSurvey team.</p>'),
	(158, 'text', 'FreezeUserTextBan', '<p>Dear Sir or Madam,</p><p>You have been banned from EUSurvey application due to infrigiment to our policy.</p><p>Reason: to specify</p><p>Please refer to our <a href="https://ec.europa.eu/eusurvey/home/tos">Terms of Service</a> for more information.</p> <p>Kind regards,<br />The EUSurvey Team</p>'),
	(159, 'text', 'FreezeUserTextUnban', '<p>Dear Sir or Madam,</p><p>You have just been unbanned and got back your access to the EUSurvey application. You can now connect to EUSurvey</p> <p>Kind regards,<br />The EUSurvey Team</p>'),
	(160, 'email addresses separated by ;', 'BannedUserRecipients', ''),
	(161, 'int', 'TrustValueCreatorInternal', '500'),
	(162, 'int', 'TrustValuePastSurveys', '500'),
	(163, 'int', 'TrustValuePrivilegedUser', '100'),
	(164, 'int', 'TrustValueNbContributions', '50'),
	(165, 'int', 'TrustValueMinimumPassMark', '100'),
	(166, 'number followed by \'y\' or \'w\' or \'d\' (years or weeks or days)', 'AnswersAnonymWorkerInterval', '1y'),
	(167, 'true / false', 'AnswersAnonymWorkerEnabled', 'true'),
	(168, 'true / false', 'UseSMTService', 'false'),
	(169, 'true / false', 'Coda', 'false'),
	(170, 'Integer', 'MaxSurveysPerUser', '10'),
	(171, 'minutes', 'MaxSurveysTimespan', '1440'),
	(172, 'Survey aliases separated by ;', 'AutomaticDraftDeleteExceptions', ''),
	(173, 'Integer', 'LastCheckedSurveyIDForZombieFiles', '-1'),
	(174, 'EULogin users separated by ;', 'EULoginWhitelist', ''),
	(175, 'true / false', 'EnableChargeback', 'false'),
	(176, 'HH:mm', 'NightlyTaskStart', '04:00'),
	(177, 'seconds', 'NightlyTaskLimit', '3600'),
	(178, 'months', 'ArchiveOlderThan', '36'),
	(179, 'months', 'ArchiveNotChangedInLast', '12'),
	(180, 'days', 'DeleteSurveysAge', '90'),
	(181, 'seconds', 'NightlyTaskLimitArchiving', '3600'),
	(182, 'true / false', 'DisableLoginPage', 'false'),
	(183, 'true / false', 'DisableWebserviceAPI', 'false'),
	(184, 'Integer', 'ContactGuestlistSizeLimitForExternals', '500'),
	(185, 'Integer', 'ContactGuestlistLimitForExternals', '1'),
	(186, 'true / false', 'EnableEUGuestList', 'false');

-- Dumping structure for table eusurveydb_rev3.shares
CREATE TABLE IF NOT EXISTS `shares` (
  `SHARE_ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `READONLY` bit(1) DEFAULT NULL,
  `OWNER` int NOT NULL,
  `RECIPIENT` int NOT NULL,
  PRIMARY KEY (`SHARE_ID`),
  KEY `FKnwrwsen723loraisq6oacm68b` (`OWNER`),
  KEY `FKjko6gga3oh5ssbukipot231tu` (`RECIPIENT`),
  CONSTRAINT `FKjko6gga3oh5ssbukipot231tu` FOREIGN KEY (`RECIPIENT`) REFERENCES `users` (`USER_ID`),
  CONSTRAINT `FKnwrwsen723loraisq6oacm68b` FOREIGN KEY (`OWNER`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.shares: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.shares_attendee
CREATE TABLE IF NOT EXISTS `shares_attendee` (
  `SHARES_SHARE_ID` int NOT NULL,
  `attendees_ATTENDEE_ID` int NOT NULL,
  UNIQUE KEY `UC_SHARES_ATTENDEE` (`SHARES_SHARE_ID`,`attendees_ATTENDEE_ID`),
  KEY `FKgwf4591vpx9ww4crl5qb6i76r` (`attendees_ATTENDEE_ID`),
  CONSTRAINT `FKgwf4591vpx9ww4crl5qb6i76r` FOREIGN KEY (`attendees_ATTENDEE_ID`) REFERENCES `attendee` (`ATTENDEE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.shares_attendee: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.skinelem
CREATE TABLE IF NOT EXISTS `skinelem` (
  `SE_ID` int NOT NULL AUTO_INCREMENT,
  `SE_BG` varchar(255) DEFAULT NULL,
  `SE_FG` varchar(255) DEFAULT NULL,
  `SE_FF` varchar(255) DEFAULT NULL,
  `SE_FS` varchar(255) DEFAULT NULL,
  `SE_FST` varchar(255) DEFAULT NULL,
  `SE_FW` varchar(255) DEFAULT NULL,
  `SE_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.skinelem: ~24 rows (approximately)
INSERT INTO `skinelem` (`SE_ID`, `SE_BG`, `SE_FG`, `SE_FF`, `SE_FS`, `SE_FST`, `SE_FW`, `SE_NAME`) VALUES
	(1, NULL, '333', NULL, NULL, NULL, NULL, '.answertext'),
	(2, 'FDF5D9', NULL, NULL, '13px', NULL, NULL, '.info-box'),
	(3, NULL, NULL, NULL, NULL, NULL, NULL, '.link'),
	(4, NULL, '333', NULL, '16px', NULL, 'bold', '.linkstitle'),
	(5, NULL, 'A6A6A6', NULL, '11px', NULL, NULL, '.questionhelp'),
	(6, NULL, '333', NULL, '13px', NULL, 'normal', '.questiontitle'),
	(7, NULL, NULL, NULL, NULL, NULL, NULL, '.matrix-header'),
	(8, NULL, NULL, NULL, NULL, NULL, NULL, '.table-header'),
	(9, NULL, '67AA03', NULL, '20px', NULL, NULL, '.sectiontitle'),
	(10, NULL, NULL, NULL, '24px', NULL, NULL, '.surveytitle'),
	(11, NULL, NULL, NULL, NULL, NULL, NULL, '.right-area'),
	(12, NULL, NULL, NULL, NULL, NULL, NULL, '.text'),
	(13, NULL, '333', NULL, NULL, NULL, NULL, '.answertext'),
	(14, 'FDF5D9', NULL, NULL, '13px', NULL, NULL, '.info-box'),
	(15, NULL, NULL, NULL, NULL, NULL, NULL, '.link'),
	(16, NULL, '333', NULL, '16px', NULL, 'bold', '.linkstitle'),
	(17, NULL, 'A6A6A6', NULL, '11px', NULL, NULL, '.questionhelp'),
	(18, NULL, '333', NULL, '13px', NULL, 'normal', '.questiontitle'),
	(19, NULL, NULL, NULL, NULL, NULL, NULL, '.matrix-header'),
	(20, NULL, NULL, NULL, NULL, NULL, NULL, '.table-header'),
	(21, NULL, '004F98', NULL, '20px', NULL, NULL, '.sectiontitle'),
	(22, NULL, NULL, NULL, '24px', NULL, NULL, '.surveytitle'),
	(23, NULL, NULL, NULL, NULL, NULL, NULL, '.right-area'),
	(24, NULL, NULL, NULL, NULL, NULL, NULL, '.text');

-- Dumping structure for table eusurveydb_rev3.skins
CREATE TABLE IF NOT EXISTS `skins` (
  `SKIN_ID` int NOT NULL AUTO_INCREMENT,
  `ISPUBLIC` bit(1) DEFAULT NULL,
  `FILE_NAME` varchar(255) DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `OWNER` int NOT NULL,
  PRIMARY KEY (`SKIN_ID`),
  KEY `FKtqsas1tc9irk7kiyq0nw8o5db` (`OWNER`),
  CONSTRAINT `FKtqsas1tc9irk7kiyq0nw8o5db` FOREIGN KEY (`OWNER`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.skins: ~2 rows (approximately)
INSERT INTO `skins` (`SKIN_ID`, `ISPUBLIC`, `FILE_NAME`, `UPDATE_DATE`, `OWNER`) VALUES
	(1, b'0', 'EUSurvey.css', '2026-01-02 06:24:30', 1),
	(2, b'1', 'EUSurveyNew.css', '2026-01-02 06:38:42', 1);

-- Dumping structure for table eusurveydb_rev3.skins_skinelem
CREATE TABLE IF NOT EXISTS `skins_skinelem` (
  `SKINS_SKIN_ID` int NOT NULL,
  `elements_SE_ID` int NOT NULL,
  UNIQUE KEY `UK_m4o8jwxyl7g25xylfqmu942vy` (`elements_SE_ID`),
  CONSTRAINT `FK66f0ot3vqdxfiouuqseue350p` FOREIGN KEY (`elements_SE_ID`) REFERENCES `skinelem` (`SE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.skins_skinelem: ~24 rows (approximately)
INSERT INTO `skins_skinelem` (`SKINS_SKIN_ID`, `elements_SE_ID`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(1, 10),
	(1, 11),
	(1, 12),
	(2, 13),
	(2, 14),
	(2, 15),
	(2, 16),
	(2, 17),
	(2, 18),
	(2, 19),
	(2, 20),
	(2, 21),
	(2, 22),
	(2, 23),
	(2, 24);

-- Dumping structure for table eusurveydb_rev3.statistics
CREATE TABLE IF NOT EXISTS `statistics` (
  `ACCESS_ID` int NOT NULL AUTO_INCREMENT,
  `BESTSCORE` int DEFAULT NULL,
  `FILTER` varchar(255) DEFAULT NULL,
  `INVALID` bit(1) DEFAULT NULL,
  `MAXSCORE` int DEFAULT NULL,
  `MEANSCORE` double DEFAULT NULL,
  `SURVEYID` int DEFAULT NULL,
  `NUMRESULTS` int DEFAULT NULL,
  PRIMARY KEY (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_bestsectionscore
CREATE TABLE IF NOT EXISTS `statistics_bestsectionscore` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `bestSectionScore` double DEFAULT NULL,
  `bestSectionScore_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`bestSectionScore_KEY`),
  CONSTRAINT `FK9g7f4cy3tawfafydlvfqn6ol5` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_bestsectionscore: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_maxsectionscore
CREATE TABLE IF NOT EXISTS `statistics_maxsectionscore` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `maxSectionScore` int DEFAULT NULL,
  `maxSectionScore_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`maxSectionScore_KEY`),
  CONSTRAINT `FKi8werjimbls730cu2ysadsvo5` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_maxsectionscore: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_meansectionscore
CREATE TABLE IF NOT EXISTS `statistics_meansectionscore` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `meanSectionScore` double DEFAULT NULL,
  `meanSectionScore_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`meanSectionScore_KEY`),
  CONSTRAINT `FKihnnly6c9glq35rs3miryjig0` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_meansectionscore: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_requestedrecords
CREATE TABLE IF NOT EXISTS `statistics_requestedrecords` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `requestedRecords` int DEFAULT NULL,
  `requestedRecords_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`requestedRecords_KEY`),
  CONSTRAINT `FK7s4whik26qufoomhgfea29ln0` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_requestedrecords: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_requestedrecordspercent
CREATE TABLE IF NOT EXISTS `statistics_requestedrecordspercent` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `requestedRecordsPercent` double DEFAULT NULL,
  `requestedRecordsPercent_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`requestedRecordsPercent_KEY`),
  CONSTRAINT `FKe814gd92rxe4rjalgoo8e6l2r` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_requestedrecordspercent: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_requestedrecordspercentscore
CREATE TABLE IF NOT EXISTS `statistics_requestedrecordspercentscore` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `requestedRecordsPercentScore` double DEFAULT NULL,
  `requestedRecordsPercentScore_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`requestedRecordsPercentScore_KEY`),
  CONSTRAINT `FKramvme68baiytio9qrtixmxlf` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_requestedrecordspercentscore: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_requestedrecordsrankingpercentscore
CREATE TABLE IF NOT EXISTS `statistics_requestedrecordsrankingpercentscore` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `requestedRecordsRankingPercentScore` double DEFAULT NULL,
  `requestedRecordsRankingPercentScore_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`requestedRecordsRankingPercentScore_KEY`),
  CONSTRAINT `FKj37iem7lfn9enrrvbc7hy0b0e` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_requestedrecordsrankingpercentscore: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_requestedrecordsrankingscore
CREATE TABLE IF NOT EXISTS `statistics_requestedrecordsrankingscore` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `requestedRecordsRankingScore` int DEFAULT NULL,
  `requestedRecordsRankingScore_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`requestedRecordsRankingScore_KEY`),
  CONSTRAINT `FKqln4bf6j8cinimgai7tnh72d5` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_requestedrecordsrankingscore: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_requestedrecordsscore
CREATE TABLE IF NOT EXISTS `statistics_requestedrecordsscore` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `requestedRecordsScore` int DEFAULT NULL,
  `requestedRecordsScore_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`requestedRecordsScore_KEY`),
  CONSTRAINT `FK3y2ckp39hegyybqnkfq5qjafh` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_requestedrecordsscore: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statistics_totalspercent
CREATE TABLE IF NOT EXISTS `statistics_totalspercent` (
  `Statistics_ACCESS_ID` int NOT NULL,
  `totalsPercent` double DEFAULT NULL,
  `totalsPercent_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Statistics_ACCESS_ID`,`totalsPercent_KEY`),
  CONSTRAINT `FKjfljlf149ota2dw390ij02m9c` FOREIGN KEY (`Statistics_ACCESS_ID`) REFERENCES `statistics` (`ACCESS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statistics_totalspercent: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.statisticsrequest
CREATE TABLE IF NOT EXISTS `statisticsrequest` (
  `REQID` int NOT NULL AUTO_INCREMENT,
  `ALLANSWERS` bit(1) DEFAULT NULL,
  `SURVEYID` int DEFAULT NULL,
  `id_resflt` int DEFAULT NULL,
  PRIMARY KEY (`REQID`),
  KEY `FKhg8y5x0v8dnyonp1qs6gq517o` (`id_resflt`),
  CONSTRAINT `FKhg8y5x0v8dnyonp1qs6gq517o` FOREIGN KEY (`id_resflt`) REFERENCES `resultfilter` (`RESFILTER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.statisticsrequest: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.status
CREATE TABLE IF NOT EXISTS `status` (
  `STATUS_ID` int NOT NULL AUTO_INCREMENT,
  `DBVERSION` int DEFAULT NULL,
  `FSCHECKSTATE` int DEFAULT NULL,
  `ANSWERANONYMDATE` datetime DEFAULT NULL,
  `LDAPSYNC2DATE` datetime DEFAULT NULL,
  `LDAPSYNCDATE` datetime DEFAULT NULL,
  `DBUPDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`STATUS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.status: ~1 rows (approximately)
INSERT INTO `status` (`STATUS_ID`, `DBVERSION`, `FSCHECKSTATE`, `ANSWERANONYMDATE`, `LDAPSYNC2DATE`, `LDAPSYNCDATE`, `DBUPDATE`) VALUES
	(1, 127, 0, NULL, NULL, NULL, '2026-01-02 06:38:35');

-- Dumping structure for table eusurveydb_rev3.submittedcontribution
CREATE TABLE IF NOT EXISTS `submittedcontribution` (
  `SUBMITTEDCONTRIBUTION_ID` int NOT NULL AUTO_INCREMENT,
  `SUBMITTEDCONTRIBUTION_AS_ID` int DEFAULT NULL,
  `SUBMITTEDCONTRIBUTION_ORG` varchar(255) DEFAULT NULL,
  `SUBMITTEDCONTRIBUTION_SUBMITTED` datetime DEFAULT NULL,
  `SUBMITTEDCONTRIBUTION_SURVEY_UID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SUBMITTEDCONTRIBUTION_ID`),
  UNIQUE KEY `SC_SUID_ASID` (`SUBMITTEDCONTRIBUTION_SURVEY_UID`,`SUBMITTEDCONTRIBUTION_AS_ID`),
  KEY `SC_D_SUID` (`SUBMITTEDCONTRIBUTION_SUBMITTED`,`SUBMITTEDCONTRIBUTION_SURVEY_UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.submittedcontribution: ~0 rows (approximately)

-- Dumping structure for event eusurveydb_rev3.SUNC_MV_SURVEYS_NUMBERPUBLISHEDANSWERS
DELIMITER //
CREATE EVENT `SUNC_MV_SURVEYS_NUMBERPUBLISHEDANSWERS` ON SCHEDULE EVERY 10 MINUTE STARTS '2026-01-02 06:38:34' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; CREATE TABLE IF NOT EXISTS MV_SURVEYS_NUMBERPUBLISHEDANSWERS AS SELECT 1 AS DUMMY ; DROP TABLE IF EXISTS MV_SURVEYS_NUMBERPUBLISHEDANSWERS_NEW; CREATE TABLE IF NOT EXISTS MV_SURVEYS_NUMBERPUBLISHEDANSWERS_NEW (MW_TIMESTAMP DATETIME) AS SELECT SURVEYS_NUMBERPUBLISHEDANSWERS.*,NOW() MW_TIMESTAMP FROM SURVEYS_NUMBERPUBLISHEDANSWERS; ALTER TABLE MV_SURVEYS_NUMBERPUBLISHEDANSWERS_NEW ADD INDEX MV_SURVEYS_IND (SURVEYUID, PUBLISHEDANSWERS); RENAME TABLE MV_SURVEYS_NUMBERPUBLISHEDANSWERS TO MV_TEMP_TABLE, MV_SURVEYS_NUMBERPUBLISHEDANSWERS_NEW TO MV_SURVEYS_NUMBERPUBLISHEDANSWERS, MV_TEMP_TABLE TO MV_SURVEYS_NUMBERPUBLISHEDANSWERS_NEW; SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; END//
DELIMITER ;

-- Dumping structure for table eusurveydb_rev3.surabuse
CREATE TABLE IF NOT EXISTS `surabuse` (
  `SURABUSE_ID` int NOT NULL AUTO_INCREMENT,
  `SURABUSE_DATE` datetime DEFAULT NULL,
  `SURABUSE_EMAIL` varchar(255) DEFAULT NULL,
  `SURABUSE_SURVEY_ID` int NOT NULL,
  `SURABUSE_TEXT` varchar(255) DEFAULT NULL,
  `SURABUSE_TYPE` varchar(255) DEFAULT NULL,
  `SURABUSE_SURVEY` int DEFAULT NULL,
  PRIMARY KEY (`SURABUSE_ID`),
  KEY `IDX_SURABUSE` (`SURABUSE_SURVEY_ID`,`SURABUSE_DATE`) USING BTREE,
  CONSTRAINT `FK1gffnjxnoib07kqs6p49u7gf9` FOREIGN KEY (`SURABUSE_SURVEY_ID`) REFERENCES `surveys` (`SURVEY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.surabuse: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.suraccess
CREATE TABLE IF NOT EXISTS `suraccess` (
  `ACCESS_ID` int NOT NULL AUTO_INCREMENT,
  `ACCESS_DEPARTMENT` varchar(255) DEFAULT NULL,
  `ACCESS_PRIVILEGES` varchar(255) DEFAULT NULL,
  `SURVEY` int DEFAULT NULL,
  `ACCESS_USER` int DEFAULT NULL,
  PRIMARY KEY (`ACCESS_ID`),
  UNIQUE KEY `ACCESS_USER` (`ACCESS_USER`,`SURVEY`),
  KEY `FKo5ulwnve8x1q1dmrga3j5eae4` (`SURVEY`),
  CONSTRAINT `FKo5ulwnve8x1q1dmrga3j5eae4` FOREIGN KEY (`SURVEY`) REFERENCES `surveys` (`SURVEY_ID`),
  CONSTRAINT `FKpns4x2bi65thg3xqa6w1ltovx` FOREIGN KEY (`ACCESS_USER`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.suraccess: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.survey_backgrounddocuments
CREATE TABLE IF NOT EXISTS `survey_backgrounddocuments` (
  `Survey_SURVEY_ID` int NOT NULL,
  `BACKGROUNDDOCUMENTS` varchar(255) DEFAULT NULL,
  `backgroundDocuments_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Survey_SURVEY_ID`,`backgroundDocuments_KEY`),
  KEY `IDX_BACK_DOCS` (`BACKGROUNDDOCUMENTS`),
  CONSTRAINT `FK7w8rhg0y1x2uoiwgdvc66ryjd` FOREIGN KEY (`Survey_SURVEY_ID`) REFERENCES `surveys` (`SURVEY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.survey_backgrounddocuments: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.survey_usefullinks
CREATE TABLE IF NOT EXISTS `survey_usefullinks` (
  `Survey_SURVEY_ID` int NOT NULL,
  `USEFULLINKS` varchar(255) DEFAULT NULL,
  `usefulLinks_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`Survey_SURVEY_ID`,`usefulLinks_KEY`),
  CONSTRAINT `FK4hmi0d34ofullexhbddd6tu83` FOREIGN KEY (`Survey_SURVEY_ID`) REFERENCES `surveys` (`SURVEY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.survey_usefullinks: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.surveys
CREATE TABLE IF NOT EXISTS `surveys` (
  `SURVEY_ID` int NOT NULL AUTO_INCREMENT,
  `DBVERSION` int DEFAULT NULL,
  `QUESTIONDWNLD` bit(1) DEFAULT NULL,
  `ALLOWEDCONTRIBUTIONS` int DEFAULT NULL,
  `ARCHIVED` bit(1) DEFAULT NULL,
  `AUDIENCE` varchar(255) DEFAULT NULL,
  `AUTOMATICPUBLISHING` bit(1) DEFAULT NULL,
  `CAPTCHA` bit(1) DEFAULT NULL,
  `CHANGECONTRIBUTION` bit(1) DEFAULT NULL,
  `CODA_LINK` varchar(255) DEFAULT NULL,
  `CODA_WAITING` bit(1) DEFAULT NULL,
  `COMPULSORYSTYLE` int DEFAULT NULL,
  `CONFURL` varchar(255) DEFAULT NULL,
  `CONFIRMATION` text,
  `CONFLINK` bit(1) DEFAULT NULL,
  `CONTACT` varchar(255) DEFAULT NULL,
  `CONTACTLABEL` varchar(255) DEFAULT NULL,
  `SURVEY_CREATED` datetime NOT NULL,
  `CRITICALCOMPLEXITY` bit(1) DEFAULT NULL,
  `RESULTPRIVILEGES` bit(1) DEFAULT NULL,
  `SURVEY_DELETED` datetime DEFAULT NULL,
  `DONOTDELETE` bit(1) DEFAULT NULL,
  `DOWNLOADCONTRIBUTION` bit(1) DEFAULT NULL,
  `EVOTETEMPLATE` varchar(255) DEFAULT NULL,
  `ECASMODE` varchar(255) DEFAULT NULL,
  `ECASSEC` bit(1) DEFAULT NULL,
  `SURVEY_END_DATE` datetime DEFAULT NULL,
  `ESCURL` varchar(255) DEFAULT NULL,
  `ESCAPE` text,
  `ESCLINK` bit(1) DEFAULT NULL,
  `HASPENDINGCHANGES` bit(1) DEFAULT NULL,
  `INTRODUCTION` text,
  `ACTIVE` bit(1) DEFAULT NULL,
  `DELETED` bit(1) DEFAULT NULL,
  `DELPHI` bit(1) DEFAULT NULL,
  `DELPHIANSWERS` bit(1) DEFAULT NULL,
  `DELPHIANSWERSANDSTATISTICSINSTANTLY` bit(1) DEFAULT NULL,
  `DELPHISTARTPAGE` bit(1) DEFAULT NULL,
  `ISDRAFT` bit(1) NOT NULL,
  `ECF` bit(1) DEFAULT NULL,
  `EVOTE` bit(1) DEFAULT NULL,
  `FROZEN` bit(1) DEFAULT NULL,
  `OPC` bit(1) DEFAULT NULL,
  `ISPUBLISHED` bit(1) DEFAULT NULL,
  `QUIZ` bit(1) DEFAULT NULL,
  `SELFASSESSMENT` bit(1) DEFAULT NULL,
  `isUseMaxNumberContribution` bit(1) DEFAULT NULL,
  `ISUSEMAXNUMBERCONTRIBUTIONLINK` bit(1) DEFAULT NULL,
  `LISTFORM` bit(1) DEFAULT NULL,
  `LISTFORMVALIDATED` bit(1) DEFAULT NULL,
  `LOGOPOS` bit(1) DEFAULT NULL,
  `LOGOTEXT` varchar(255) DEFAULT NULL,
  `MAXNUMBERCONTRIBUTION` bigint DEFAULT NULL,
  `MAXNUMBERCONTRIBUTIONLINK` varchar(255) DEFAULT NULL,
  `MAXNUMBERCONTRIBUTIONTEXT` varchar(255) DEFAULT NULL,
  `maxPrefVotes` int DEFAULT NULL,
  `MINLISTPER` int DEFAULT NULL,
  `DELPHIMINSTATISTICS` int DEFAULT NULL,
  `MOTIVATIONPOPUP` bit(1) DEFAULT NULL,
  `MOTIVATIONTITLE` varchar(255) DEFAULT NULL,
  `MOTIVATIONSTEXT` longtext NOT NULL,
  `MOTIVATIONTRIGGERPROGRESS` int DEFAULT NULL,
  `MOTIVATIONTRIGGERTIME` int DEFAULT NULL,
  `MOTIVATIONTYPE` bit(1) DEFAULT NULL,
  `MULTIPAGING` bit(1) DEFAULT NULL,
  `NOTIFICATIONUNIT` varchar(255) DEFAULT NULL,
  `NOTIFICATIONVALUE` varchar(255) DEFAULT NULL,
  `NOTIFIED` bit(1) DEFAULT NULL,
  `NOTIFYALL` bit(1) DEFAULT NULL,
  `ORGANISATION` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `PREVENTGOINGBACK` bit(1) DEFAULT NULL,
  `PROGRESSBAR` bit(1) DEFAULT NULL,
  `PROGRESSDISPLAY` int DEFAULT NULL,
  `LISTFORMREQUESTEDDATE` datetime DEFAULT NULL,
  `QUESTIONNUMBERING` int DEFAULT NULL,
  `QUIZRESULTS` longtext,
  `QUIZWELCOME` longtext,
  `QUORUM` int DEFAULT NULL,
  `ISREGFORM` bit(1) DEFAULT NULL,
  `SENDREPORTFREQUENCY` int DEFAULT NULL,
  `SENDREPORTEMAILS` varchar(255) DEFAULT NULL,
  `SAVEASDRAFT` bit(1) DEFAULT NULL,
  `SCOREBYQUESTION` bit(1) DEFAULT NULL,
  `seatsToAllocate` int DEFAULT NULL,
  `SECTIONNUMBERING` int DEFAULT NULL,
  `SURVEYSECURITY` varchar(255) DEFAULT NULL,
  `SENDCONFIRMATION` bit(1) DEFAULT NULL,
  `SENDREPORT` bit(1) DEFAULT NULL,
  `SURVEYNAME` varchar(255) NOT NULL,
  `SHOWCOUNTDOWN` bit(1) DEFAULT NULL,
  `DOCSUNAVAIL` bit(1) DEFAULT NULL,
  `PDFUNAVAIL` bit(1) DEFAULT NULL,
  `SHOWICONS` bit(1) DEFAULT NULL,
  `RESULTSTESTPAGE` bit(1) DEFAULT NULL,
  `SHOWSCORE` bit(1) DEFAULT NULL,
  `SURVEY_START_DATE` datetime DEFAULT NULL,
  `TIMELIMIT` varchar(255) DEFAULT NULL,
  `TITLE` text,
  `TITLESORT` varchar(255) NOT NULL,
  `TRUSTSCORE` int DEFAULT NULL,
  `SURVEY_UID` varchar(255) NOT NULL,
  `SURVEY_UPDATED` datetime NOT NULL,
  `VALIDATED` bit(1) DEFAULT NULL,
  `VALIDATEDPERPAGE` bit(1) DEFAULT NULL,
  `VALIDATIONCODE` varchar(255) DEFAULT NULL,
  `VALIDATOR` varchar(255) DEFAULT NULL,
  `SURVEY_VERSION` int DEFAULT NULL,
  `WCAGCOMPLIANCE` bit(1) DEFAULT NULL,
  `WEBHOOK` varchar(255) DEFAULT NULL,
  `LANGUAGE` int NOT NULL,
  `LOGO` int DEFAULT NULL,
  `OWNER` int NOT NULL,
  `publication_PUB_ID` int DEFAULT NULL,
  `SURVEYSKIN` int DEFAULT NULL,
  PRIMARY KEY (`SURVEY_ID`),
  KEY `SH_IDX` (`SURVEYNAME`),
  KEY `DRA_IDX` (`ISDRAFT`),
  KEY `FKi9indyt914gt5hqijyv9bqfsn` (`LANGUAGE`),
  KEY `FKlwcidc4p8n18t62ntb03fkjd3` (`LOGO`),
  KEY `FKap1g74m62rf6egt7h4qblrr7u` (`OWNER`),
  KEY `FKcgxbam95q9yqrrypqpjwi4j2g` (`publication_PUB_ID`),
  KEY `FKb0677ynkxklgddly8orssf9rj` (`SURVEYSKIN`),
  KEY `IDX_SURVEYS_SURVEY_UID` (`SURVEY_UID`),
  KEY `IDX_SURVEYS_ORGANISATION` (`ORGANISATION`),
  CONSTRAINT `FKap1g74m62rf6egt7h4qblrr7u` FOREIGN KEY (`OWNER`) REFERENCES `users` (`USER_ID`),
  CONSTRAINT `FKb0677ynkxklgddly8orssf9rj` FOREIGN KEY (`SURVEYSKIN`) REFERENCES `skins` (`SKIN_ID`),
  CONSTRAINT `FKcgxbam95q9yqrrypqpjwi4j2g` FOREIGN KEY (`publication_PUB_ID`) REFERENCES `publication` (`PUB_ID`),
  CONSTRAINT `FKi9indyt914gt5hqijyv9bqfsn` FOREIGN KEY (`LANGUAGE`) REFERENCES `languages` (`LANGUAGE_ID`),
  CONSTRAINT `FKlwcidc4p8n18t62ntb03fkjd3` FOREIGN KEY (`LOGO`) REFERENCES `files` (`FILE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.surveys: ~4 rows (approximately)
INSERT INTO `surveys` (`SURVEY_ID`, `DBVERSION`, `QUESTIONDWNLD`, `ALLOWEDCONTRIBUTIONS`, `ARCHIVED`, `AUDIENCE`, `AUTOMATICPUBLISHING`, `CAPTCHA`, `CHANGECONTRIBUTION`, `CODA_LINK`, `CODA_WAITING`, `COMPULSORYSTYLE`, `CONFURL`, `CONFIRMATION`, `CONFLINK`, `CONTACT`, `CONTACTLABEL`, `SURVEY_CREATED`, `CRITICALCOMPLEXITY`, `RESULTPRIVILEGES`, `SURVEY_DELETED`, `DONOTDELETE`, `DOWNLOADCONTRIBUTION`, `EVOTETEMPLATE`, `ECASMODE`, `ECASSEC`, `SURVEY_END_DATE`, `ESCURL`, `ESCAPE`, `ESCLINK`, `HASPENDINGCHANGES`, `INTRODUCTION`, `ACTIVE`, `DELETED`, `DELPHI`, `DELPHIANSWERS`, `DELPHIANSWERSANDSTATISTICSINSTANTLY`, `DELPHISTARTPAGE`, `ISDRAFT`, `ECF`, `EVOTE`, `FROZEN`, `OPC`, `ISPUBLISHED`, `QUIZ`, `SELFASSESSMENT`, `isUseMaxNumberContribution`, `ISUSEMAXNUMBERCONTRIBUTIONLINK`, `LISTFORM`, `LISTFORMVALIDATED`, `LOGOPOS`, `LOGOTEXT`, `MAXNUMBERCONTRIBUTION`, `MAXNUMBERCONTRIBUTIONLINK`, `MAXNUMBERCONTRIBUTIONTEXT`, `maxPrefVotes`, `MINLISTPER`, `DELPHIMINSTATISTICS`, `MOTIVATIONPOPUP`, `MOTIVATIONTITLE`, `MOTIVATIONSTEXT`, `MOTIVATIONTRIGGERPROGRESS`, `MOTIVATIONTRIGGERTIME`, `MOTIVATIONTYPE`, `MULTIPAGING`, `NOTIFICATIONUNIT`, `NOTIFICATIONVALUE`, `NOTIFIED`, `NOTIFYALL`, `ORGANISATION`, `PASSWORD`, `PREVENTGOINGBACK`, `PROGRESSBAR`, `PROGRESSDISPLAY`, `LISTFORMREQUESTEDDATE`, `QUESTIONNUMBERING`, `QUIZRESULTS`, `QUIZWELCOME`, `QUORUM`, `ISREGFORM`, `SENDREPORTFREQUENCY`, `SENDREPORTEMAILS`, `SAVEASDRAFT`, `SCOREBYQUESTION`, `seatsToAllocate`, `SECTIONNUMBERING`, `SURVEYSECURITY`, `SENDCONFIRMATION`, `SENDREPORT`, `SURVEYNAME`, `SHOWCOUNTDOWN`, `DOCSUNAVAIL`, `PDFUNAVAIL`, `SHOWICONS`, `RESULTSTESTPAGE`, `SHOWSCORE`, `SURVEY_START_DATE`, `TIMELIMIT`, `TITLE`, `TITLESORT`, `TRUSTSCORE`, `SURVEY_UID`, `SURVEY_UPDATED`, `VALIDATED`, `VALIDATEDPERPAGE`, `VALIDATIONCODE`, `VALIDATOR`, `SURVEY_VERSION`, `WCAGCOMPLIANCE`, `WEBHOOK`, `LANGUAGE`, `LOGO`, `OWNER`, `publication_PUB_ID`, `SURVEYSKIN`) VALUES
	(1, 53, b'0', 1, b'0', NULL, b'0', b'1', b'0', NULL, b'0', 0, '', '<span style="color: #4caf50; font-size: 200%; font-weight: bold;">✓</span> <strong style="color: black; margin-left: 6px;"> Contribution successfully submitted</strong><br /><br />Thank you for your contribution!', b'0', 'info@myServer.com', NULL, '2026-01-02 06:38:33', b'0', b'0', NULL, b'0', b'0', '', 'all', b'0', NULL, '', 'This survey has not yet been published or has already been unpublished in the meantime.', b'0', b'0', NULL, b'1', b'0', b'0', b'0', b'0', b'1', b'1', b'0', b'0', b'0', b'0', b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'1', '', 0, '', 'This survey has been closed due to the maximum number of contributions reached.', 20, 5, 1, b'0', '', 'Motivation Text', 50, 20, b'0', b'0', NULL, NULL, b'0', b'0', NULL, NULL, b'0', b'0', 0, NULL, 0, 'Thank you for your contribution', NULL, 6666, b'0', 0, '', b'1', b'1', 20, 0, 'open', b'0', b'0', 'NewSelfRegistrationSurvey', b'1', b'0', b'0', b'1', b'0', b'1', NULL, '', 'Register for EUSurvey!', 'Register for EUSurvey!', NULL, '40fd036a-97df-427c-b01c-9f72852e73e4', '2026-01-02 06:38:33', b'0', b'0', NULL, NULL, 0, b'0', '', 1, NULL, 1, 1, 1),
	(2, 53, b'0', 1, b'0', NULL, b'0', b'1', b'0', NULL, b'0', 0, '', '<span style="color: #4caf50; font-size: 200%; font-weight: bold;">✓</span> <strong style="color: black; margin-left: 6px;"> Contribution successfully submitted</strong><br /><br />Thank you for your contribution!', b'0', 'info@myServer.com', NULL, '2026-01-02 06:38:33', b'0', b'0', NULL, b'0', b'0', '', 'all', b'0', NULL, '', 'This survey has not yet been published or has already been unpublished in the meantime.', b'0', b'0', NULL, b'1', b'0', b'0', b'0', b'0', b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'1', '', 0, '', 'This survey has been closed due to the maximum number of contributions reached.', 20, 5, 1, b'0', '', 'Motivation Text', 50, 20, b'0', b'0', NULL, NULL, b'0', b'0', NULL, NULL, b'0', b'0', 0, NULL, 0, 'Thank you for your contribution', NULL, 6666, b'0', 0, '', b'1', b'1', 20, 0, 'open', b'0', b'0', 'NewSelfRegistrationSurvey', b'1', b'0', b'0', b'1', b'0', b'1', NULL, '', 'Register for EUSurvey!', 'Register for EUSurvey!', NULL, '40fd036a-97df-427c-b01c-9f72852e73e4', '2026-01-02 06:38:34', b'0', b'0', NULL, NULL, 0, b'0', '', 1, NULL, 1, 2, 1),
	(3, 127, b'0', 1, b'0', '', b'0', b'0', b'0', NULL, b'0', 0, '', '<span style="color: #4caf50; font-size: 200%; font-weight: bold;">✓</span> <strong style="color: black; margin-left: 6px;"> Contribution successfully submitted</strong><br /><br />Thank you for your contribution!', b'0', 'form:info@myServer.com', '', '2026-01-02 10:30:20', b'0', b'0', NULL, b'0', b'1', '', 'all', b'0', NULL, '', 'This survey has not yet been published or has already been unpublished in the meantime.', b'0', b'0', NULL, b'0', b'0', b'0', b'0', b'0', b'1', b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'1', '', 0, '', 'This survey has been closed due to the maximum number of contributions reached.', 20, 5, 1, b'0', '', 'Motivation Text', 50, 20, b'0', b'0', NULL, NULL, b'0', b'0', '', NULL, b'0', b'0', 0, NULL, 0, 'Thank you for your contribution', NULL, 6666, b'0', 0, '', b'1', b'1', 20, 0, 'secured', b'0', b'0', '13c00d1e-4af3-53e9-7bc2-52dae2b55631', b'1', b'0', b'0', b'1', b'0', b'1', NULL, '', 'Hello World', 'Hello World', NULL, 'e6420370-c837-4910-b567-4d80386df4e4', '2026-01-02 10:31:47', b'0', b'0', NULL, '', 0, b'0', '', 1, NULL, 1, 3, NULL),
	(4, 127, b'0', 1, b'0', '', b'0', b'0', b'0', NULL, b'0', 0, '', '<span style="color: #4caf50; font-size: 200%; font-weight: bold;">✓</span> <strong style="color: black; margin-left: 6px;"> Contribution successfully submitted</strong><br /><br />Thank you for your contribution!', b'0', 'form:info@myServer.com', '', '2026-01-02 15:54:43', b'0', b'0', NULL, b'0', b'1', '', 'all', b'0', NULL, '', 'This survey has not yet been published or has already been unpublished in the meantime.', b'0', b'0', NULL, b'0', b'0', b'0', b'0', b'0', b'1', b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'1', '', 0, '', 'This survey has been closed due to the maximum number of contributions reached.', 20, 5, 1, b'0', '', 'Motivation Text', 50, 20, b'0', b'0', NULL, NULL, b'0', b'0', '', NULL, b'0', b'0', 0, NULL, 0, 'Thank you for your contribution', NULL, 6666, b'0', 0, '', b'1', b'1', 20, 0, 'open', b'0', b'0', 'f24a9b3e-761a-aef1-7ef6-e3f163d0366b', b'1', b'0', b'0', b'1', b'0', b'1', NULL, '', 'Standard Survey', 'Standard Survey', NULL, 'f6c661cf-d66c-4f11-84bb-294b5367d964', '2026-01-02 15:54:43', b'0', b'0', NULL, '', 0, b'0', '', 1, NULL, 1, 4, NULL);

-- Dumping structure for table eusurveydb_rev3.surveys_elements
CREATE TABLE IF NOT EXISTS `surveys_elements` (
  `SURVEYS_SURVEY_ID` int NOT NULL,
  `elements_ID` int NOT NULL,
  UNIQUE KEY `UK_g1qnk9kp3h1bryg7e0eohqave` (`elements_ID`),
  CONSTRAINT `FKtkbfexacxahvx6xktfvt8xcbj` FOREIGN KEY (`elements_ID`) REFERENCES `elements` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.surveys_elements: ~15 rows (approximately)
INSERT INTO `surveys_elements` (`SURVEYS_SURVEY_ID`, `elements_ID`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(2, 10),
	(2, 11),
	(2, 12),
	(2, 13),
	(2, 14),
	(2, 15),
	(3, 19),
	(3, 20),
	(3, 21);

-- Dumping structure for view eusurveydb_rev3.surveys_numberpublishedanswers
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `surveys_numberpublishedanswers` (
	`SURVEYUID` VARCHAR(1) NOT NULL COLLATE 'utf8mb3_general_ci',
	`PUBLISHEDANSWERS` BIGINT NOT NULL,
	`LASTANSWER` DATETIME NULL
);

-- Dumping structure for table eusurveydb_rev3.surveys_tags
CREATE TABLE IF NOT EXISTS `surveys_tags` (
  `SURVEY_SURVEY_ID` int NOT NULL,
  `tags_TAG_ID` int NOT NULL,
  KEY `FKlgj1qws5qih9wu9b1fidguutm` (`tags_TAG_ID`),
  CONSTRAINT `FKlgj1qws5qih9wu9b1fidguutm` FOREIGN KEY (`tags_TAG_ID`) REFERENCES `tags` (`TAG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.surveys_tags: ~0 rows (approximately)

-- Dumping structure for procedure eusurveydb_rev3.synchronizeStatistics
DELIMITER //
CREATE PROCEDURE `synchronizeStatistics`()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE s_id INT;
	DECLARE cur1 CURSOR FOR SELECT SURVEY_ID FROM SURVEYS;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;

	read_loop: LOOP

		FETCH cur1 INTO s_id;
		IF done THEN
		  LEAVE read_loop;
		END IF;
		
		call clearStatistics(s_id);
		call updateStatistics(s_id);
		
		
	END LOOP;

	CLOSE cur1;
END//
DELIMITER ;

-- Dumping structure for table eusurveydb_rev3.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `TAG_ID` int NOT NULL AUTO_INCREMENT,
  `TAG_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`TAG_ID`),
  UNIQUE KEY `TAG_NAME` (`TAG_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.tags: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.templ
CREATE TABLE IF NOT EXISTS `templ` (
  `TEMPL_ID` int NOT NULL AUTO_INCREMENT,
  `TEMPL_NAME` varchar(255) DEFAULT NULL,
  `element_ID` int DEFAULT NULL,
  `OWNER` int NOT NULL,
  PRIMARY KEY (`TEMPL_ID`),
  KEY `FKo7g5l9jdvo83xsalg6n3t8gpn` (`element_ID`),
  KEY `FK5owbstegp8wecl9x3s2frlx2s` (`OWNER`),
  CONSTRAINT `FK5owbstegp8wecl9x3s2frlx2s` FOREIGN KEY (`OWNER`) REFERENCES `users` (`USER_ID`),
  CONSTRAINT `FKo7g5l9jdvo83xsalg6n3t8gpn` FOREIGN KEY (`element_ID`) REFERENCES `elements` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.templ: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.translation
CREATE TABLE IF NOT EXISTS `translation` (
  `TRANSLATION_ID` int NOT NULL AUTO_INCREMENT,
  `TRANSLATIONKEY` varchar(255) DEFAULT NULL,
  `LABEL` text,
  `LANGUAGE` varchar(255) DEFAULT NULL,
  `LOCKED` bit(1) DEFAULT NULL,
  `SURVEY_ID` int DEFAULT NULL,
  `TRANS_ID` int DEFAULT NULL,
  PRIMARY KEY (`TRANSLATION_ID`),
  KEY `FKlbpwon5ioqj8dp85wpvi5xvqe` (`TRANS_ID`),
  CONSTRAINT `FKlbpwon5ioqj8dp85wpvi5xvqe` FOREIGN KEY (`TRANS_ID`) REFERENCES `translations` (`TRANSLATIONS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.translation: ~14 rows (approximately)
INSERT INTO `translation` (`TRANSLATION_ID`, `TRANSLATIONKEY`, `LABEL`, `LANGUAGE`, `LOCKED`, `SURVEY_ID`, `TRANS_ID`) VALUES
	(1, 'TITLE', 'Register for EUSurvey!', 'EN', b'0', 1, 1),
	(2, 'ESCAPEPAGE', 'This survey has not yet been published or has already been unpublished in the meantime.', 'EN', b'0', 1, 1),
	(3, 'CONFIRMATIONPAGE', '<span style="color: #4caf50; font-size: 200%; font-weight: bold;">✓</span> <strong style="color: black; margin-left: 6px;"> Contribution successfully submitted</strong><br /><br />Thank you for your contribution!', 'EN', b'0', 1, 1),
	(4, 'e080cffa-bbfb-499b-85ad-4ae4852d52b8', 'Your login', 'EN', b'0', 1, 1),
	(5, 'e080cffa-bbfb-499b-85ad-4ae4852d52b8help', 'The user name must be unique and cannot contain blanks. You can use your email address or any other text that contains only numbers and small/upper characters.', 'EN', b'0', 1, 1),
	(6, '994e8788-fb04-4cb9-8fbb-cc1f3c3f4d57', 'Your first name', 'EN', b'0', 1, 1),
	(7, 'dd96c897-bc91-496f-b505-ca931d4ba4e0', 'Your last name', 'EN', b'0', 1, 1),
	(8, 'e4d79bcd-5bc8-4388-bf5a-bf818c133130', 'Your password', 'EN', b'0', 1, 1),
	(9, '4ef7aafe-4741-48a4-bd58-cda6e64b4a14', 'Your email address', 'EN', b'0', 1, 1),
	(10, '4ef7aafe-4741-48a4-bd58-cda6e64b4a14help', 'Please provide a valid email address for account validation.', 'EN', b'0', 1, 1),
	(11, '42cfdc67-eaf3-4e14-8e93-0f035a3eb7bf', 'Your language', 'EN', b'0', 1, 1),
	(12, '61a43b31-c110-40fa-aa06-39b011479d6f', 'German', 'EN', b'0', 1, 1),
	(13, '8116deb5-0f7d-4f88-b9ca-9242cdc101f3', 'English', 'EN', b'0', 1, 1),
	(14, '65263d47-87b6-457f-a5e8-99f96422e70b', 'French', 'EN', b'0', 1, 1);

-- Dumping structure for table eusurveydb_rev3.translations
CREATE TABLE IF NOT EXISTS `translations` (
  `TRANSLATIONS_ID` int NOT NULL AUTO_INCREMENT,
  `SURVEY_ACTIVE` bit(1) DEFAULT NULL,
  `COMPLETE` bit(1) DEFAULT NULL,
  `REQUESTED` bit(1) DEFAULT NULL,
  `SURVEY_ID` int DEFAULT NULL,
  `SURVEY_UID` varchar(255) DEFAULT NULL,
  `LANGUAGE` int NOT NULL,
  PRIMARY KEY (`TRANSLATIONS_ID`),
  UNIQUE KEY `LANGUAGE_SURVEY` (`SURVEY_ID`,`TRANSLATIONS_ID`),
  KEY `FKb3t6kypwbpts7ge8xth9f429u` (`LANGUAGE`),
  KEY `IDX_TRANSLATIONS_SURVEY_ID` (`SURVEY_ID`),
  CONSTRAINT `FKb3t6kypwbpts7ge8xth9f429u` FOREIGN KEY (`LANGUAGE`) REFERENCES `languages` (`LANGUAGE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.translations: ~4 rows (approximately)
INSERT INTO `translations` (`TRANSLATIONS_ID`, `SURVEY_ACTIVE`, `COMPLETE`, `REQUESTED`, `SURVEY_ID`, `SURVEY_UID`, `LANGUAGE`) VALUES
	(1, b'1', b'1', b'0', 1, '40fd036a-97df-427c-b01c-9f72852e73e4', 1),
	(2, b'1', b'1', b'0', 2, '40fd036a-97df-427c-b01c-9f72852e73e4', 1),
	(4, b'1', b'0', b'0', 3, 'e6420370-c837-4910-b567-4d80386df4e4', 1),
	(5, b'1', b'1', b'0', 4, 'f6c661cf-d66c-4f11-84bb-294b5367d964', 1);

-- Dumping structure for procedure eusurveydb_rev3.updateStatistics
DELIMITER //
CREATE PROCEDURE `updateStatistics`(id int)
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE pqid INT;	
	DECLARE ppaid INT;
	DECLARE pnum INT;
    DECLARE counter INT;

	DECLARE cur1 CURSOR FOR SELECT PA_UID, QUESTION_UID FROM ANSWERS WHERE AS_ID IN
		(SELECT DISTINCT ANSWER_SET_ID FROM ANSWER_SETS WHERE SURVEY_ID = id AND ISDRAFT = 0);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;

	SET counter = 1;

	read_loop2: LOOP

		FETCH cur1 INTO ppaid,pqid;
		IF done THEN
		  LEAVE read_loop2;
		END IF;

		SELECT MAX(PAID) FROM LIVE_STATISTICS WHERE PAID = ppaid AND QID = pqid INTO pnum;

		IF (pnum IS NOT NULL) THEN
			UPDATE LIVE_STATISTICS SET NUM = NUM + 1 WHERE PAID = ppaid AND QID = pqid;
		ELSE
			INSERT INTO LIVE_STATISTICS (PAID, QID, NUM) VALUES (ppaid, pqid, 1);
		END IF;	

		SET counter = counter + 1;

	END LOOP;

	CLOSE cur1;

	SELECT counter;
END//
DELIMITER ;

-- Dumping structure for table eusurveydb_rev3.users
CREATE TABLE IF NOT EXISTS `users` (
  `USER_ID` int NOT NULL AUTO_INCREMENT,
  `USER_PS` bit(1) DEFAULT NULL,
  `USER_PSDATE` datetime DEFAULT NULL,
  `USER_PSVERSION` varchar(255) DEFAULT NULL,
  `USER_TOS` bit(1) DEFAULT NULL,
  `USER_TOSDATE` datetime DEFAULT NULL,
  `USER_TOSVERSION` varchar(255) DEFAULT NULL,
  `ATTEMPTS` int DEFAULT NULL,
  `USER_COMMENT` varchar(255) DEFAULT NULL,
  `USER_PIVOTLANGUAGE` varchar(255) DEFAULT NULL,
  `USER_DELCODE` varchar(255) DEFAULT NULL,
  `USER_DELDATE` datetime DEFAULT NULL,
  `USER_DELREQ` bit(1) DEFAULT NULL,
  `USER_DELETED` bit(1) DEFAULT NULL,
  `USER_DISPLAYNAME` varchar(255) DEFAULT NULL,
  `USER_EMAIL` varchar(255) NOT NULL,
  `USER_EMAIL_TO_VALIDATE` varchar(255) DEFAULT NULL,
  `USER_FROZEN` bit(1) DEFAULT NULL,
  `USER_GIVENNAME` varchar(255) DEFAULT NULL,
  `USER_LANGUAGE` varchar(255) DEFAULT NULL,
  `USER_LAST_SURVEY` int DEFAULT NULL,
  `USER_LOGIN` varchar(255) DEFAULT NULL,
  `USER_ORGANISATION` varchar(255) DEFAULT NULL,
  `USER_OTHEREMAIL` varchar(255) DEFAULT NULL,
  `USER_PASSWORD` varchar(255) DEFAULT NULL,
  `USER_PWSALT` varchar(255) DEFAULT NULL,
  `USER_ATTORDER` varchar(255) DEFAULT NULL,
  `USER_SURNAME` varchar(255) DEFAULT NULL,
  `USER_TYPE` varchar(255) DEFAULT NULL,
  `USER_EXISTS_ATTEMPT_DATE` datetime DEFAULT NULL,
  `USER_EXISTS_ATTEMPS` int DEFAULT NULL,
  `VALIDATED` bit(1) DEFAULT NULL,
  `VALIDCODE` varchar(255) DEFAULT NULL,
  `VALIDDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `USER_LOGIN` (`USER_LOGIN`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.users: ~2 rows (approximately)
INSERT INTO `users` (`USER_ID`, `USER_PS`, `USER_PSDATE`, `USER_PSVERSION`, `USER_TOS`, `USER_TOSDATE`, `USER_TOSVERSION`, `ATTEMPTS`, `USER_COMMENT`, `USER_PIVOTLANGUAGE`, `USER_DELCODE`, `USER_DELDATE`, `USER_DELREQ`, `USER_DELETED`, `USER_DISPLAYNAME`, `USER_EMAIL`, `USER_EMAIL_TO_VALIDATE`, `USER_FROZEN`, `USER_GIVENNAME`, `USER_LANGUAGE`, `USER_LAST_SURVEY`, `USER_LOGIN`, `USER_ORGANISATION`, `USER_OTHEREMAIL`, `USER_PASSWORD`, `USER_PWSALT`, `USER_ATTORDER`, `USER_SURNAME`, `USER_TYPE`, `USER_EXISTS_ATTEMPT_DATE`, `USER_EXISTS_ATTEMPS`, `VALIDATED`, `VALIDCODE`, `VALIDDATE`) VALUES
	(1, b'1', '2026-01-02 10:29:23', '1', b'1', '2026-01-02 10:29:27', '1', 0, 'The admin user', 'EN', NULL, NULL, b'0', b'0', NULL, 'info@myServer.com', NULL, b'0', NULL, 'EN', 3, 'admin', NULL, NULL, '20d2ce9715327e1c058a77d84d1abe22df668662', 'IcvVkeXqe/DEoxT7Y0UN7OSENGu4kXO19OWn9nSNsLw=', NULL, NULL, 'SYSTEM', NULL, 0, b'1', NULL, NULL),
	(2, b'0', NULL, NULL, b'0', NULL, NULL, 0, 'A dummy user', 'EN', NULL, NULL, b'0', b'0', NULL, 'dummy@company.org', NULL, b'0', NULL, 'EN', NULL, 'dummy', NULL, NULL, '57f99be47bdf338f5e0fec0bda34f6c7f9d28447', 'uWNdEsUr2E/lDtU8Ls3sJ2eAbeF+xuUW9cjyGIYUR+s=', NULL, NULL, 'SYSTEM', NULL, 0, b'1', NULL, NULL);

-- Dumping structure for table eusurveydb_rev3.users_attributename
CREATE TABLE IF NOT EXISTS `users_attributename` (
  `USERS_USER_ID` int NOT NULL,
  `selectedAttributes_AN_ID` int NOT NULL,
  UNIQUE KEY `UC_USERS_ATTRIBUTENAME` (`USERS_USER_ID`,`selectedAttributes_AN_ID`),
  KEY `FK6uci5g52xxwgx82kvbh2xdeaw` (`selectedAttributes_AN_ID`),
  CONSTRAINT `FK6uci5g52xxwgx82kvbh2xdeaw` FOREIGN KEY (`selectedAttributes_AN_ID`) REFERENCES `attributename` (`AN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.users_attributename: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.users_globalroles
CREATE TABLE IF NOT EXISTS `users_globalroles` (
  `USERS_USER_ID` int NOT NULL,
  `roles_ROLE_ID` int NOT NULL,
  UNIQUE KEY `UC_USERS_GLOBALROLES` (`USERS_USER_ID`,`roles_ROLE_ID`),
  KEY `FKlrad8tja65da069l5ithved92` (`roles_ROLE_ID`),
  CONSTRAINT `FKlrad8tja65da069l5ithved92` FOREIGN KEY (`roles_ROLE_ID`) REFERENCES `globalroles` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.users_globalroles: ~1 rows (approximately)
INSERT INTO `users_globalroles` (`USERS_USER_ID`, `roles_ROLE_ID`) VALUES
	(1, 1);

-- Dumping structure for table eusurveydb_rev3.usersconfiguration
CREATE TABLE IF NOT EXISTS `usersconfiguration` (
  `UC_ID` int NOT NULL AUTO_INCREMENT,
  `UC_BANNED` bit(1) DEFAULT NULL,
  `UC_COMM` bit(1) DEFAULT NULL,
  `UC_EMAIL` bit(1) DEFAULT NULL,
  `UC_LANG` bit(1) DEFAULT NULL,
  `UC_NAME` bit(1) DEFAULT NULL,
  `UC_OTHEREMAIL` bit(1) DEFAULT NULL,
  `UC_ROLES` bit(1) DEFAULT NULL,
  `UC_USER` int DEFAULT NULL,
  PRIMARY KEY (`UC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.usersconfiguration: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.validcode
CREATE TABLE IF NOT EXISTS `validcode` (
  `VALIDCODE_ID` int NOT NULL AUTO_INCREMENT,
  `VALIDCODE_CODE` varchar(255) DEFAULT NULL,
  `VALIDCODE_DATE` datetime DEFAULT NULL,
  `VALIDCODE_SURVEYUID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`VALIDCODE_ID`),
  UNIQUE KEY `VALIDCODE_CODE` (`VALIDCODE_CODE`),
  KEY `IDX_VALIDCODE_SURVEY_UID` (`VALIDCODE_SURVEYUID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.validcode: ~1 rows (approximately)
INSERT INTO `validcode` (`VALIDCODE_ID`, `VALIDCODE_CODE`, `VALIDCODE_DATE`, `VALIDCODE_SURVEYUID`) VALUES
	(1, '8605f57e-9ce3-435f-a086-7766b4e39717', '2026-01-03 01:34:56', '40fd036a-97df-427c-b01c-9f72852e73e4');

-- Dumping structure for table eusurveydb_rev3.voters
CREATE TABLE IF NOT EXISTS `voters` (
  `VOTER_ID` int NOT NULL AUTO_INCREMENT,
  `VOTER_CREATED` datetime DEFAULT NULL,
  `VOTER_ECMONIKER` varchar(255) DEFAULT NULL,
  `VOTER_GN` varchar(255) DEFAULT NULL,
  `VOTER_SN` varchar(255) DEFAULT NULL,
  `VOTER_SURVEY` varchar(255) DEFAULT NULL,
  `USER_VOTED` bit(1) DEFAULT NULL,
  PRIMARY KEY (`VOTER_ID`),
  UNIQUE KEY `VOTER_ECMONIKER_SURVEY` (`VOTER_ECMONIKER`,`VOTER_SURVEY`),
  KEY `SURVEY_UID_IDX` (`VOTER_SURVEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.voters: ~0 rows (approximately)

-- Dumping structure for table eusurveydb_rev3.webservicetask
CREATE TABLE IF NOT EXISTS `webservicetask` (
  `WST_ID` int NOT NULL AUTO_INCREMENT,
  `WST_ADDMETA` bit(1) DEFAULT NULL,
  `WST_CONTRIBTYPE` varchar(255) DEFAULT NULL,
  `WST_COUNTER` int DEFAULT NULL,
  `WST_CREATED` datetime DEFAULT NULL,
  `WST_DONE` bit(1) DEFAULT NULL,
  `WST_EMPTYRESULT` bit(1) DEFAULT NULL,
  `WST_END` datetime DEFAULT NULL,
  `WST_ERROR` varchar(255) DEFAULT NULL,
  `WST_EXPORTTYPE` int DEFAULT NULL,
  `WST_FILETYPES` varchar(255) DEFAULT NULL,
  `WST_GROUP` int DEFAULT NULL,
  `WST_HOOK` varchar(255) DEFAULT NULL,
  `WST_NUM` int DEFAULT NULL,
  `WST_RESULT` varchar(255) DEFAULT NULL,
  `WST_SHOWIDS` bit(1) DEFAULT NULL,
  `WST_START` datetime DEFAULT NULL,
  `WST_STARTED` datetime DEFAULT NULL,
  `WST_SURVEYID` int DEFAULT NULL,
  `WST_SURVEYUID` varchar(255) DEFAULT NULL,
  `WST_TOKEN` varchar(255) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `WST_UNIQUEID` varchar(255) DEFAULT NULL,
  `WST_XMLONLY` bit(1) DEFAULT NULL,
  `WST_USER` int DEFAULT NULL,
  PRIMARY KEY (`WST_ID`),
  KEY `FKdm0irop1417fdif4n3vvujv0j` (`WST_USER`),
  CONSTRAINT `FKdm0irop1417fdif4n3vvujv0j` FOREIGN KEY (`WST_USER`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table eusurveydb_rev3.webservicetask: ~0 rows (approximately)

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `surveys_numberpublishedanswers`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `surveys_numberpublishedanswers` AS select `s`.`SURVEY_UID` AS `SURVEYUID`,count(`answers_set`.`ANSWER_SET_ID`) AS `PUBLISHEDANSWERS`,max(`answers_set`.`ANSWER_SET_DATE`) AS `LASTANSWER` from (`answers_set` join `surveys` `s`) where ((`answers_set`.`ISDRAFT` = 0) and (`answers_set`.`SURVEY_ID` = `s`.`SURVEY_ID`) and (`s`.`ISDRAFT` = 0)) group by `s`.`SURVEY_UID`
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
