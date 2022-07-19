-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 23, 2022 at 01:51 AM
-- Server version: 5.7.32
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `TICKOTTY`
--

-- --------------------------------------------------------

--
-- Table structure for table `ADMIN_PANEL_MENU`
--

CREATE TABLE `ADMIN_PANEL_MENU` (
  `ID` int(11) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `URL` varchar(255) NOT NULL,
  `ICON` varchar(255) NOT NULL,
  `PATH` varchar(255) DEFAULT NULL,
  `SHOW` varchar(255) NOT NULL,
  `ORDER` int(11) NOT NULL,
  `MAIN_MENU_ID` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ADMIN_PANEL_MENU`
--

INSERT INTO `ADMIN_PANEL_MENU` (`ID`, `TITLE`, `URL`, `ICON`, `PATH`, `SHOW`, `ORDER`, `MAIN_MENU_ID`) VALUES
(1, 'Panel', 'dashboard', 'icon app-icon-panel', 'dashboard', 'true', 1, 0),
(2, 'Clients', 'clients', 'icon app-icon-clients', 'clients', 'false', 2, 0),
(3, 'Tickets', 'tickets', 'icon app-icon-tickets', 'tickets', 'true', 3, 0),
(4, 'Staff', 'staff', 'icon app-icon-staff', 'staff', 'false', 6, 0),
(5, 'Reports', 'reports', 'icon app-icon-reports', 'reports', 'false', 5, 0),
(7, 'SLA', 'sla', 'icon app-icon-sla', 'sla', 'false', 5, 0),
(8, 'Options', 'options', 'icon app-icon-options', 'options', 'false', 7, 0),
(9, 'Knowledge Base', 'knowledge-base', 'icon app-icon-knowledge-base', 'knowledge', 'false', 6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ARTICLES`
--

CREATE TABLE `ARTICLES` (
  `ID` int(11) NOT NULL,
  `TITLE` varchar(100) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `URL` varchar(100) DEFAULT NULL,
  `DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CONTENT` text NOT NULL,
  `KEYWORDS` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `CATEGORY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ARTICLE_CATEGORIES`
--

CREATE TABLE `ARTICLE_CATEGORIES` (
  `ID` int(11) NOT NULL,
  `CATEGORY_URL` varchar(255) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PARENT` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `CANNED_RESPONSES`
--

CREATE TABLE `CANNED_RESPONSES` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(191) NOT NULL,
  `MESSAGE` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `CATEGORIES`
--

CREATE TABLE `CATEGORIES` (
  `ID` int(11) NOT NULL,
  `ORDER` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `MAIN` tinyint(11) NOT NULL,
  `PARENT` tinyint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `CONVERSATIONS`
--

CREATE TABLE `CONVERSATIONS` (
  `ID` int(11) NOT NULL,
  `RELATION_TYPE` varchar(255) NOT NULL,
  `RELATED_ID` int(11) NOT NULL DEFAULT '0',
  `SENDER_ID` int(11) NOT NULL DEFAULT '0',
  `RECEIVER_ID` int(11) NOT NULL DEFAULT '0',
  `DATE` datetime NOT NULL,
  `MESSAGE` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `CUSTOM_FIELDS`
--

CREATE TABLE `CUSTOM_FIELDS` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `CONDITION` varchar(255) NOT NULL,
  `TYPE` varchar(255) NOT NULL,
  `REQUIRED` varchar(255) NOT NULL DEFAULT 'false',
  `ORDER` int(11) NOT NULL,
  `DATA` longtext NOT NULL,
  `RELATION_TYPE` varchar(255) NOT NULL,
  `PERMISSIONS` varchar(255) NOT NULL,
  `APPLICANT_TYPE` longtext,
  `INPUT_SELECTED_FORMS` longtext,
  `ACTIVE` varchar(255) NOT NULL DEFAULT 'true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `CUSTOM_FIELD_DATA`
--

CREATE TABLE `CUSTOM_FIELD_DATA` (
  `ID` int(11) NOT NULL,
  `FIELD_ID` int(11) NOT NULL,
  `RELATED_ID` int(11) NOT NULL,
  `DATA` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DEPARTMENTS`
--

CREATE TABLE `DEPARTMENTS` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `DEPARTMENTS`
--

INSERT INTO `DEPARTMENTS` (`ID`, `NAME`) VALUES
(1, 'General');

-- --------------------------------------------------------

--
-- Table structure for table `FILES`
--

CREATE TABLE `FILES` (
  `ID` int(11) NOT NULL,
  `UPLOAD_DATE` datetime NOT NULL,
  `FILE_NAME` varchar(255) NOT NULL,
  `FILE_TYPE` varchar(255) NOT NULL,
  `FILE_SIZE` decimal(10,0) NOT NULL,
  `RELATION_TYPE` varchar(255) NOT NULL,
  `RELATED_ID` int(11) NOT NULL,
  `UPLOADER_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `LOGS`
--

CREATE TABLE `LOGS` (
  `ID` int(11) NOT NULL,
  `DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `USER_ID` int(11) NOT NULL,
  `CLIENT` varchar(255) NOT NULL,
  `RELATION_TYPE` varchar(255) NOT NULL,
  `RELATED_ID` int(11) NOT NULL,
  `DETAIL` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `NOTES`
--

CREATE TABLE `NOTES` (
  `ID` int(11) NOT NULL,
  `RELATION_TYPE` varchar(255) NOT NULL,
  `RELATED_ID` int(11) NOT NULL,
  `NOTE` text NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `DATE` datetime NOT NULL,
  `PRIVATE` varchar(255) NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `NOTIFICATIONS`
--

CREATE TABLE `NOTIFICATIONS` (
  `ID` int(11) UNSIGNED NOT NULL,
  `READ` varchar(255) NOT NULL DEFAULT 'false',
  `DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TITLE` varchar(255) NOT NULL,
  `DETAIL` varchar(255) NOT NULL,
  `RELATION_TYPE` varchar(255) NOT NULL,
  `RELATED_ID` varchar(255) NOT NULL,
  `RECEIVER` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `OPTIONS`
--

CREATE TABLE `OPTIONS` (
  `NAME` varchar(255) NOT NULL,
  `HELPDESK_STATUS` varchar(255) NOT NULL DEFAULT 'true',
  `VACATION_MODE` varchar(255) NOT NULL,
  `DEFAULT_DEPARTMENT` int(11) NOT NULL,
  `APPLICATION_NAME` varchar(255) NOT NULL,
  `APP_COLOR` varchar(255) NOT NULL,
  `DESK_URL` varchar(255) NOT NULL,
  `MAX_PAGE_SIZE` int(11) NOT NULL,
  `BUSINESS_HOURS` longtext NOT NULL,
  `DEFAULT_LOCALE` int(11) NOT NULL,
  `DEFAULT_TIME_ZONE` varchar(255) NOT NULL,
  `EMAIL_ENCRYPTION` int(11) NOT NULL,
  `SMTP_HOST` varchar(255) NOT NULL,
  `SMTP_PORT` varchar(255) NOT NULL,
  `SMTP_USER` varchar(255) NOT NULL,
  `SMTP_PASS` varchar(255) NOT NULL,
  `NO_REPLY_EMAIL` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `OPTIONS`
--

INSERT INTO `OPTIONS` (`NAME`, `HELPDESK_STATUS`, `VACATION_MODE`, `DEFAULT_DEPARTMENT`, `APPLICATION_NAME`, `APP_COLOR`, `DESK_URL`, `MAX_PAGE_SIZE`, `BUSINESS_HOURS`, `DEFAULT_LOCALE`, `DEFAULT_TIME_ZONE`, `EMAIL_ENCRYPTION`, `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS`, `NO_REPLY_EMAIL`) VALUES
('APP', 'true', 'true', 1, 'Tickotty™ - Help Desk', '#3F51B5', 'http://localhost:8888/tickotty/', 6, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]', 3, 'Europe/Istanbul', 0, 'smtpout.secureserver.net', '587', 'support@luceat.solutions', '', 'noreply@luceat.solutions');

-- --------------------------------------------------------

--
-- Table structure for table `PERMISSIONS`
--

CREATE TABLE `PERMISSIONS` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) NOT NULL,
  `KEY` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PERMISSIONS`
--

INSERT INTO `PERMISSIONS` (`ID`, `NAME`, `TYPE`, `KEY`) VALUES
(1, 'Clients', 'x', 'clients'),
(2, 'Tickets', 'o', 'tickets'),
(3, 'Reports', 'x', 'reports'),
(4, 'Options', 'x', 'options'),
(5, 'Staff', 'x', 'staff'),
(6, 'SLA', 'x', 'sla'),
(7, 'Knowledge Base', 'x', 'knowledge');

-- --------------------------------------------------------

--
-- Table structure for table `PRIVILEGES`
--

CREATE TABLE `PRIVILEGES` (
  `ID` int(11) NOT NULL,
  `USER_ID` int(5) NOT NULL,
  `PERMISSION_ID` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PRIVILEGES`
--

INSERT INTO `PRIVILEGES` (`ID`, `USER_ID`, `PERMISSION_ID`) VALUES
(2, 1, 3),
(3, 1, 5),
(5, 1, 6),
(6, 1, 4),
(7, 1, 2),
(8, 1, 1),
(9, 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `PROCESSES`
--

CREATE TABLE `PROCESSES` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `ORDER` int(11) NOT NULL,
  `DEPARTMENT_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PROCESSES`
--

INSERT INTO `PROCESSES` (`ID`, `NAME`, `ORDER`, `DEPARTMENT_ID`) VALUES
(1, 'In Progress', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `SLA_POLICIES`
--

CREATE TABLE `SLA_POLICIES` (
  `ID` int(11) UNSIGNED NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` text,
  `TRIGGER` longtext NOT NULL,
  `VIOLATION_RULES` longtext NOT NULL,
  `TARGETS` longtext,
  `CREATED_DATE` datetime DEFAULT NULL,
  `UPDATED_DATE` datetime DEFAULT NULL,
  `ACTIVE` varchar(255) DEFAULT 'true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `SLA_VIOLATIONS`
--

CREATE TABLE `SLA_VIOLATIONS` (
  `ID` int(11) NOT NULL,
  `SLA_POLICY` int(11) NOT NULL,
  `VIOLATION_TYPE` int(11) NOT NULL,
  `TICKET_ID` int(11) NOT NULL,
  `TICKET_TOKEN` varchar(255) NOT NULL,
  `PERSON_WILL_BE_NOTIFIED` longtext NOT NULL,
  `ALERT_DATE` datetime DEFAULT NULL,
  `WARNED` varchar(255) NOT NULL DEFAULT 'false',
  `DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `TICKETS`
--

CREATE TABLE `TICKETS` (
  `ID` int(11) NOT NULL,
  `PARENT_ID` int(11) DEFAULT NULL,
  `TOKEN` varchar(255) NOT NULL,
  `CLIENT` varchar(255) NOT NULL,
  `CREATED_DATE` datetime NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `SEEN_BY` int(11) NOT NULL,
  `SEEN_DATE` datetime NOT NULL,
  `ASSIGNED_ID` int(11) DEFAULT NULL,
  `ASSIGNED_DATE` datetime DEFAULT NULL,
  `CLOSER_ID` int(11) NOT NULL,
  `CLOSED_DATE` datetime NOT NULL,
  `REPLIED_DATE` datetime NOT NULL,
  `LAST_REPLY` datetime NOT NULL,
  `SUBJECT` varchar(255) NOT NULL,
  `DETAIL` longtext NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `SLA_POLICY` int(11) NOT NULL,
  `STATUS` int(11) NOT NULL,
  `CATEGORY_ID` int(11) NOT NULL,
  `DEPARTMENT_ID` int(11) NOT NULL,
  `PROCESS` int(11) NOT NULL,
  `SPAM` varchar(255) NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `TODO`
--

CREATE TABLE `TODO` (
  `ID` int(11) NOT NULL,
  `DETAIL` text NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `CREATED_DATE` datetime NOT NULL,
  `DONE` varchar(255) NOT NULL DEFAULT 'false'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `TOKENS`
--

CREATE TABLE `TOKENS` (
  `ID` int(11) NOT NULL,
  `TOKEN` varchar(255) NOT NULL,
  `USER_ID` int(10) NOT NULL,
  `DATE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `USERS`
--

CREATE TABLE `USERS` (
  `ID` int(11) NOT NULL,
  `TOKEN` varchar(255) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `SURNAME` varchar(255) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `PHONE` varchar(255) NOT NULL,
  `ADDRESS` text NOT NULL,
  `ADMIN` varchar(255) DEFAULT 'false',
  `STAFF` varchar(255) DEFAULT 'false',
  `DEPARTMENT_ID` int(11) DEFAULT NULL,
  `LANGUAGE` varchar(255) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  `PASSWORD` varchar(100) NOT NULL,
  `ADDITIONAL_DATA` longtext NOT NULL,
  `PERMISSIONS` longtext NOT NULL,
  `ACTIVE` varchar(255) NOT NULL DEFAULT 'true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `USERS`
--

INSERT INTO `USERS` (`ID`, `TOKEN`, `CLIENT_ID`, `NAME`, `SURNAME`, `EMAIL`, `PHONE`, `ADDRESS`, `ADMIN`, `STAFF`, `DEPARTMENT_ID`, `LANGUAGE`, `USERNAME`, `PASSWORD`, `ADDITIONAL_DATA`, `PERMISSIONS`, `ACTIVE`) VALUES
(1, 'mkcr4', NULL, 'Super', 'Admin', 'admin@luceat.solutions', '', '', 'true', 'false', 1, 'english', 'root', '$2y$10$5WE8N45AriF.90CV/zmS/.h8cOqixiwuAdc3VHBTWj2d6P7q5nV9G', '', '[{ \"PATH\": \"tickets\", \"PRIVILAGES\": { \"CREATE\": true, \"READ\": true, \"UPDATE\": true, \"DELETE\": true } }, { \"PATH\": \"clients\", \"PRIVILAGES\": { \"CREATE\": true, \"READ\": true, \"UPDATE\": true, \"DELETE\": true } }]', 'true');

-- --------------------------------------------------------

--
-- Table structure for table `WORKING_HOURS`
--

CREATE TABLE `WORKING_HOURS` (
  `ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `WORKING_HOURS` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `WORKING_HOURS`
--

INSERT INTO `WORKING_HOURS` (`ID`, `USER_ID`, `WORKING_HOURS`) VALUES
(1, 1, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ADMIN_PANEL_MENU`
--
ALTER TABLE `ADMIN_PANEL_MENU`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `ARTICLES`
--
ALTER TABLE `ARTICLES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `ARTICLE_CATEGORIES`
--
ALTER TABLE `ARTICLE_CATEGORIES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `CANNED_RESPONSES`
--
ALTER TABLE `CANNED_RESPONSES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `CONVERSATIONS`
--
ALTER TABLE `CONVERSATIONS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `CUSTOM_FIELDS`
--
ALTER TABLE `CUSTOM_FIELDS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `CUSTOM_FIELD_DATA`
--
ALTER TABLE `CUSTOM_FIELD_DATA`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `DEPARTMENTS`
--
ALTER TABLE `DEPARTMENTS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `FILES`
--
ALTER TABLE `FILES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `LOGS`
--
ALTER TABLE `LOGS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `NOTES`
--
ALTER TABLE `NOTES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `NOTIFICATIONS`
--
ALTER TABLE `NOTIFICATIONS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `OPTIONS`
--
ALTER TABLE `OPTIONS`
  ADD PRIMARY KEY (`NAME`);

--
-- Indexes for table `PERMISSIONS`
--
ALTER TABLE `PERMISSIONS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `PRIVILEGES`
--
ALTER TABLE `PRIVILEGES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `PROCESSES`
--
ALTER TABLE `PROCESSES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `SLA_POLICIES`
--
ALTER TABLE `SLA_POLICIES`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `SLA_VIOLATIONS`
--
ALTER TABLE `SLA_VIOLATIONS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `TICKETS`
--
ALTER TABLE `TICKETS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `TODO`
--
ALTER TABLE `TODO`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `USERS`
--
ALTER TABLE `USERS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `WORKING_HOURS`
--
ALTER TABLE `WORKING_HOURS`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ADMIN_PANEL_MENU`
--
ALTER TABLE `ADMIN_PANEL_MENU`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `ARTICLES`
--
ALTER TABLE `ARTICLES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ARTICLE_CATEGORIES`
--
ALTER TABLE `ARTICLE_CATEGORIES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CANNED_RESPONSES`
--
ALTER TABLE `CANNED_RESPONSES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CONVERSATIONS`
--
ALTER TABLE `CONVERSATIONS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CUSTOM_FIELDS`
--
ALTER TABLE `CUSTOM_FIELDS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CUSTOM_FIELD_DATA`
--
ALTER TABLE `CUSTOM_FIELD_DATA`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DEPARTMENTS`
--
ALTER TABLE `DEPARTMENTS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `FILES`
--
ALTER TABLE `FILES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `LOGS`
--
ALTER TABLE `LOGS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `NOTES`
--
ALTER TABLE `NOTES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `NOTIFICATIONS`
--
ALTER TABLE `NOTIFICATIONS`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `PERMISSIONS`
--
ALTER TABLE `PERMISSIONS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `PRIVILEGES`
--
ALTER TABLE `PRIVILEGES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `PROCESSES`
--
ALTER TABLE `PROCESSES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `SLA_POLICIES`
--
ALTER TABLE `SLA_POLICIES`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `SLA_VIOLATIONS`
--
ALTER TABLE `SLA_VIOLATIONS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `TICKETS`
--
ALTER TABLE `TICKETS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `TODO`
--
ALTER TABLE `TODO`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `USERS`
--
ALTER TABLE `USERS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `WORKING_HOURS`
--
ALTER TABLE `WORKING_HOURS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;