-- phpMyAdmin SQL Dump
-- version 3.4.5deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Dec 07, 2011 at 02:40 AM
-- Server version: 5.1.58
-- PHP Version: 5.3.6-13ubuntu3.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `motech_dw`
--

-- --------------------------------------------------------

--
-- Table structure for table `dim_client`
--

CREATE TABLE IF NOT EXISTS `dim_client` (
  `address` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `facility` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `community` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `motech_id` varchar(50) DEFAULT NULL,
  `name` varchar(102) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `death_date` date DEFAULT NULL,
  `client_key` bigint(20) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  `client_type` text,
  `gender` varchar(50) DEFAULT NULL,
  `reg_age` bigint(20) DEFAULT NULL,
  KEY `idx_dim_client_lookup` (`name`,`motech_id`,`phone_number`,`address`,`community`,`facility`,`birthdate`,`death_date`),
  KEY `idx_dim_client_tk` (`client_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dim_date`
--

CREATE TABLE IF NOT EXISTS `dim_date` (
  `date_key` tinytext,
  `date_value` datetime DEFAULT NULL,
  `date_short` tinytext,
  `date_medium` tinytext,
  `date_long` tinytext,
  `date_full` tinytext,
  `day_in_year` int(11) DEFAULT NULL,
  `day_abbreviation` tinytext,
  `day_name` tinytext,
  `week_in_year` int(11) DEFAULT NULL,
  `week_in_month` int(11) DEFAULT NULL,
  `month_abbreviation` tinytext,
  `month_name` tinytext,
  `year2` tinytext,
  `year4` tinytext,
  `day_in_week` int(11) DEFAULT NULL,
  `month_number` int(11) DEFAULT NULL,
  `day_in_month` int(11) DEFAULT NULL,
  `quarter_number` int(11) DEFAULT NULL,
  `quarter_name` tinytext,
  `year_quarter` tinytext,
  `year_month_number` tinytext,
  `year_month_abbreviation` tinytext,
  `is_first_day_in_month` varchar(3) DEFAULT NULL,
  `is_last_day_in_month` varchar(3) DEFAULT NULL,
  `is_first_day_in_week` varchar(3) DEFAULT NULL,
  `is_last_day_in_week` varchar(3) DEFAULT NULL,
  `is_weekend` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dim_location`
--

CREATE TABLE IF NOT EXISTS `dim_location` (
  `location_key` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `facility` varchar(255) DEFAULT NULL,
  `city_village` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `latlong` varchar(101) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `pregnant_population_estimate` int(11) unsigned DEFAULT NULL,
  `child_under_one_population_estimate` int(10) unsigned DEFAULT NULL,
  `general_population_estimate` int(10) unsigned DEFAULT NULL,
  `population_estimate_year` int(11) DEFAULT NULL,
  KEY `idx_dim_location_lookup` (`location_id`),
  KEY `idx_dim_location_tk` (`location_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fact_call`
--

CREATE TABLE IF NOT EXISTS `fact_call` (
  `motech_id` varchar(255) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `message_a` decimal(32,0) DEFAULT NULL,
  `message_b` decimal(32,0) DEFAULT NULL,
  `message_c` decimal(32,0) DEFAULT NULL,
  `duration` decimal(32,0) DEFAULT NULL,
  `client_key` bigint(20) DEFAULT NULL,
  `date_key` varchar(255) DEFAULT NULL,
  `location_key` int(11) DEFAULT NULL,
  KEY `idx_fact_call_lookup` (`motech_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fact_pregnancy`
--

CREATE TABLE IF NOT EXISTS `fact_pregnancy` (
  `motech_id` varchar(50) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `trimester` varchar(6) DEFAULT NULL,
  `client_key` bigint(20) DEFAULT NULL,
  `location_key` int(11) DEFAULT NULL,
  `date_key` varchar(255) DEFAULT NULL,
  KEY `idx_fact_pregnancy_lookup` (`motech_id`,`start_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fact_program`
--

CREATE TABLE IF NOT EXISTS `fact_program` (
  `motech_id` varchar(50) DEFAULT NULL,
  `program` varchar(200) DEFAULT NULL,
  `language` varchar(7) DEFAULT NULL,
  `phone_number` text,
  `phone_ownership` text,
  `telco` varchar(8) DEFAULT NULL,
  `delivery_day` text,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `medium` text,
  `delivery_time` text,
  `client_key` bigint(20) DEFAULT NULL,
  `date_key` varchar(255) DEFAULT NULL,
  `location_key` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `facility_id` bigint(20) DEFAULT NULL,
  KEY `idx_fact_program_lookup` (`motech_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fact_registration`
--

CREATE TABLE IF NOT EXISTS `fact_registration` (
  `date_key` varchar(255) DEFAULT NULL,
  `location_key` int(10) DEFAULT NULL,
  `client_key` bigint(20) DEFAULT NULL,
  `program_name` varchar(200) DEFAULT NULL,
  KEY `idx_fact_registration_lookup` (`date_key`,`location_key`,`client_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
