/*
SQLyog Community v9.60 
MySQL - 5.6.21-log : Database - my_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`my_db` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `my_db`;

/*Table structure for table `answer` */

DROP TABLE IF EXISTS `answer`;

CREATE TABLE `answer` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `answertext` text NOT NULL,
  `fk_qid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`aid`),
  KEY `answer_fk1` (`fk_qid`),
  CONSTRAINT `answer_fk1` FOREIGN KEY (`fk_qid`) REFERENCES `question` (`qid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `answer` */

/*Table structure for table `attendance` */

DROP TABLE IF EXISTS `attendance`;

CREATE TABLE `attendance` (
  `attendanceid` int(10) unsigned NOT NULL,
  `fk_participant` int(10) unsigned DEFAULT NULL,
  `fk_supervisor` int(10) unsigned DEFAULT NULL,
  `dateofchecking` date DEFAULT NULL,
  `status` enum('present','absent','postponed') DEFAULT NULL,
  `timein` time DEFAULT NULL,
  `timeout` time DEFAULT NULL,
  PRIMARY KEY (`attendanceid`),
  KEY `attendance_fk1` (`fk_participant`),
  KEY `attendance_fk2` (`fk_supervisor`),
  CONSTRAINT `attendance_fk1` FOREIGN KEY (`fk_participant`) REFERENCES `training_participant` (`participantid`),
  CONSTRAINT `attendance_fk2` FOREIGN KEY (`fk_supervisor`) REFERENCES `training_facilitator` (`facilitatorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `attendance` */

/*Table structure for table `businessunit` */

DROP TABLE IF EXISTS `businessunit`;

CREATE TABLE `businessunit` (
  `buid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `buname` varchar(50) NOT NULL,
  `fk_buhead` char(3) DEFAULT NULL,
  PRIMARY KEY (`buid`),
  KEY `bu_fk1` (`fk_buhead`),
  CONSTRAINT `bu_fk1` FOREIGN KEY (`fk_buhead`) REFERENCES `useraccount` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `businessunit` */

insert  into `businessunit`(`buid`,`buname`,`fk_buhead`) values (1,'HR department','101');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `catid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `fk_formid` int(10) unsigned DEFAULT NULL,
  `fk_parentcat` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`catid`),
  KEY `cat_fk1` (`fk_formid`),
  KEY `cat_fk2` (`fk_parentcat`),
  CONSTRAINT `cat_fk1` FOREIGN KEY (`fk_formid`) REFERENCES `form` (`formid`),
  CONSTRAINT `cat_fk2` FOREIGN KEY (`fk_parentcat`) REFERENCES `category` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `category` */

/*Table structure for table `course_feedbackform` */

DROP TABLE IF EXISTS `course_feedbackform`;

CREATE TABLE `course_feedbackform` (
  `formid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_participantid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`formid`),
  KEY `coursefbform_fk1` (`fk_participantid`),
  CONSTRAINT `coursefbform_fk1` FOREIGN KEY (`fk_participantid`) REFERENCES `training_participant` (`participantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `course_feedbackform` */

/*Table structure for table `effectiveness_assessform` */

DROP TABLE IF EXISTS `effectiveness_assessform`;

CREATE TABLE `effectiveness_assessform` (
  `formid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_facilitatorid` int(10) unsigned DEFAULT NULL,
  `fk_participantid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`formid`),
  KEY `effaf_fk1` (`fk_facilitatorid`),
  KEY `effaf_fk2` (`fk_participantid`),
  CONSTRAINT `effaf_fk1` FOREIGN KEY (`fk_facilitatorid`) REFERENCES `training_facilitator` (`facilitatorid`),
  CONSTRAINT `effaf_fk2` FOREIGN KEY (`fk_participantid`) REFERENCES `training_participant` (`participantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `effectiveness_assessform` */

/*Table structure for table `faci_feedbackform` */

DROP TABLE IF EXISTS `faci_feedbackform`;

CREATE TABLE `faci_feedbackform` (
  `formid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_facilitatorid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`formid`),
  KEY `facifbform_fk1` (`fk_facilitatorid`),
  CONSTRAINT `facifbform_fk1` FOREIGN KEY (`fk_facilitatorid`) REFERENCES `training_facilitator` (`facilitatorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `faci_feedbackform` */

/*Table structure for table `form` */

DROP TABLE IF EXISTS `form`;

CREATE TABLE `form` (
  `formid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` enum('Training Effectiveness Evaluation Form','Skills Assessment Evaulation Form','Training Needs Analysis','Course Feedback Form','Facilitator''s Feedback Form') NOT NULL,
  `instruction` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`formid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `form` */

/*Table structure for table `job` */

DROP TABLE IF EXISTS `job`;

CREATE TABLE `job` (
  `jobid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jobtitle` varchar(50) NOT NULL,
  PRIMARY KEY (`jobid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `job` */

insert  into `job`(`jobid`,`jobtitle`) values (1,'HR Specialist');

/*Table structure for table `needs_analysisform` */

DROP TABLE IF EXISTS `needs_analysisform`;

CREATE TABLE `needs_analysisform` (
  `formid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_participantid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`formid`),
  KEY `naf_fk1` (`fk_participantid`),
  CONSTRAINT `naf_fk1` FOREIGN KEY (`fk_participantid`) REFERENCES `training_participant` (`participantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `needs_analysisform` */

/*Table structure for table `question` */

DROP TABLE IF EXISTS `question`;

CREATE TABLE `question` (
  `qid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `questiontext` text NOT NULL,
  `fk_category` int(10) unsigned NOT NULL,
  PRIMARY KEY (`qid`),
  KEY `question_fk1` (`fk_category`),
  CONSTRAINT `question_fk1` FOREIGN KEY (`fk_category`) REFERENCES `category` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `question` */

/*Table structure for table `skills_assessform` */

DROP TABLE IF EXISTS `skills_assessform`;

CREATE TABLE `skills_assessform` (
  `formid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_participantid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`formid`),
  KEY `skillsaf_fk1` (`fk_participantid`),
  CONSTRAINT `skillsaf_fk1` FOREIGN KEY (`fk_participantid`) REFERENCES `training_participant` (`participantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `skills_assessform` */

/*Table structure for table `training` */

DROP TABLE IF EXISTS `training`;

CREATE TABLE `training` (
  `trainingid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `objective` text,
  `outline` text,
  `schedule` varchar(30) DEFAULT NULL,
  `venue` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`trainingid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `training` */

/*Table structure for table `training_facilitator` */

DROP TABLE IF EXISTS `training_facilitator`;

CREATE TABLE `training_facilitator` (
  `facilitatorid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_trainingid` int(10) unsigned DEFAULT NULL,
  `fk_userid` char(3) DEFAULT NULL,
  PRIMARY KEY (`facilitatorid`),
  KEY `tf_fk2` (`fk_trainingid`),
  KEY `tf_fk1` (`fk_userid`),
  CONSTRAINT `tf_fk1` FOREIGN KEY (`fk_userid`) REFERENCES `useraccount` (`userid`),
  CONSTRAINT `tf_fk2` FOREIGN KEY (`fk_trainingid`) REFERENCES `training` (`trainingid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `training_facilitator` */

/*Table structure for table `training_participant` */

DROP TABLE IF EXISTS `training_participant`;

CREATE TABLE `training_participant` (
  `participantid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_trainingid` int(10) unsigned DEFAULT NULL,
  `fk_userid` char(3) DEFAULT NULL,
  `fk_supervisor` char(3) DEFAULT NULL,
  PRIMARY KEY (`participantid`),
  KEY `tp_fk2` (`fk_trainingid`),
  KEY `tp_fk1` (`fk_userid`),
  KEY `tp_fk3` (`fk_supervisor`),
  CONSTRAINT `tp_fk1` FOREIGN KEY (`fk_userid`) REFERENCES `useraccount` (`userid`),
  CONSTRAINT `tp_fk2` FOREIGN KEY (`fk_trainingid`) REFERENCES `training` (`trainingid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tp_fk3` FOREIGN KEY (`fk_supervisor`) REFERENCES `useraccount` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `training_participant` */

/*Table structure for table `useraccount` */

DROP TABLE IF EXISTS `useraccount`;

CREATE TABLE `useraccount` (
  `userid` char(3) NOT NULL,
  `fname` varchar(30) NOT NULL,
  `mname` varchar(20) DEFAULT NULL,
  `lname` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `month` int(10) unsigned DEFAULT NULL,
  `day` int(10) unsigned DEFAULT NULL,
  `year` int(10) unsigned DEFAULT NULL,
  `gender` enum('Female','Male') DEFAULT NULL,
  `contactno` varchar(11) NOT NULL,
  `emailad` varchar(30) NOT NULL,
  `barangay` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `fk_jobid` int(10) unsigned NOT NULL,
  `fk_buid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `user_fk1` (`fk_jobid`),
  KEY `user_fk2` (`fk_buid`),
  CONSTRAINT `user_fk1` FOREIGN KEY (`fk_jobid`) REFERENCES `job` (`jobid`),
  CONSTRAINT `user_fk2` FOREIGN KEY (`fk_buid`) REFERENCES `businessunit` (`buid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `useraccount` */

insert  into `useraccount`(`userid`,`fname`,`mname`,`lname`,`password`,`month`,`day`,`year`,`gender`,`contactno`,`emailad`,`barangay`,`city`,`province`,`fk_jobid`,`fk_buid`) values ('101','Ara','Kat','Adlawon','admin',6,28,1989,'Female','09235674532','araadlawon@asi.com','Talamban','Cebu','Cebu',1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
