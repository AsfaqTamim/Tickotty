-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: May 14, 2022 at 01:28 PM
-- Server version: 5.7.32
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `tickotty`
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

--
-- Dumping data for table `ARTICLES`
--

INSERT INTO `ARTICLES` (`ID`, `TITLE`, `AUTHOR`, `URL`, `DATE`, `CONTENT`, `KEYWORDS`, `DESCRIPTION`, `CATEGORY`) VALUES
(1, 'Lorem ipsum dolor sit amet', '1', 'lorem-ipsum-dolor-sit-amet', '2022-04-09 15:44:22', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.</p><p>&nbsp;</p>', '[\"Tickets\",\"Test\"]', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 1),
(3, 'Cursus euismod quis', '1', 'Cursus-euismod-quis', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 3),
(4, 'Penatibus et magnis ', '1', 'Penatibus-et-magnis', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 1),
(5, 'Ultricies leo integer', '1', 'ultricies-leo-integer', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 3),
(6, 'Gravida rutrum quisque', '1', 'gravida-rutrum-quisque', '2022-04-09 15:44:22', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.</p>', '[\"gravida\"]', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 3),
(7, 'Porttitor lacus luctus accumsan', '1', 'Porttitor-lacus-luctus-accumsan', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 1),
(8, 'Pellentesque diam volutpat', '1', 'pellentesque-diam-volutpat', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 3),
(9, 'Nullam ac tortor vitae', '1', 'nullam-ac-tortor-vitae', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 2),
(10, 'Tellus in metus', '1', 'tellus-in-metus', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 2),
(11, 'Ut sem nulla pharetra', '1', 'Ut-sem-nulla-pharetra', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 2),
(12, 'Turpis cursus in hac habitasse platea dictumst', '1', 'turpis-cursus-in-hac-habitasse-platea-dictumst', '2022-04-09 15:44:22', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Condimentum lacinia quis vel eros donec ac odio tempor. Arcu ac tortor dignissim convallis aenean et. Sit amet facilisis magna etiam tempor orci eu lobortis elementum. Tincidunt vitae semper quis lectus nulla at volutpat diam. Duis at consectetur lorem donec massa. At augue eget arcu dictum varius duis. A arcu cursus vitae congue mauris. Arcu odio ut sem nulla pharetra diam sit amet nisl. Donec ultrices tincidunt arcu non.</p><p>Enim ut tellus elementum sagittis vitae et leo duis. Parturient montes nascetur ridiculus mus mauris vitae ultricies leo. Amet nulla facilisi morbi tempus iaculis urna id volutpat lacus. Pulvinar etiam non quam lacus suspendisse. Purus faucibus ornare suspendisse sed nisi lacus sed viverra. Non odio euismod lacinia at quis risus sed vulputate odio. Pulvinar neque laoreet suspendisse interdum consectetur libero id. Viverra accumsan in nisl nisi scelerisque eu ultrices. Fermentum odio eu feugiat pretium nibh. Laoreet id donec ultrices tincidunt arcu non sodales neque. Placerat in egestas erat imperdiet sed. Iaculis at erat pellentesque adipiscing commodo elit at. Mauris commodo quis imperdiet massa tincidunt. Ipsum dolor sit amet consectetur. Platea dictumst quisque sagittis purus sit amet volutpat consequat mauris. Eget velit aliquet sagittis id. Etiam tempor orci eu lobortis elementum nibh tellus molestie. Vitae sapien pellentesque habitant morbi tristique senectus et netus et. Nulla aliquet porttitor lacus luctus accumsan tortor.</p><p>Dignissim enim sit amet venenatis urna cursus. Nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Eu lobortis elementum nibh tellus molestie nunc non blandit. Condimentum mattis pellentesque id nibh tortor id. Mi quis hendrerit dolor magna eget est lorem ipsum dolor. Tincidunt vitae semper quis lectus nulla at volutpat diam. Sit amet commodo nulla facilisi nullam. Ut lectus arcu bibendum at varius vel pharetra vel turpis. Tincidunt ornare massa eget egestas purus viverra. Non consectetur a erat nam at lectus. Et odio pellentesque diam volutpat. Gravida neque convallis a cras semper. Venenatis tellus in metus vulputate eu. Et egestas quis ipsum suspendisse ultrices gravida dictum fusce. Libero id faucibus nisl tincidunt eget nullam. Tortor vitae purus faucibus ornare suspendisse sed nisi lacus. Eros in cursus turpis massa tincidunt. Nisl purus in mollis nunc sed id. Lobortis feugiat vivamus at augue eget.</p>', '[]', 'Enim ut tellus elementum sagittis vitae et leo duis.', 2),
(13, 'Interdum velit euismod in pellentesque', '1', 'interdum-velit-euismod-in-pellentesque', '2022-04-09 15:44:22', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mi turpis, maximus sit amet mauris vitae, lobortis ullamcorper ipsum. Praesent sit amet turpis eget purus tristique blandit eget in mauris. Nullam sagittis erat non nibh pulvinar, eu vehicula urna vestibulum. Donec a turpis dapibus, vestibulum velit vel, laoreet sapien. Vestibulum malesuada, nunc at condimentum volutpat, metus augue egestas est, at porttitor mauris eros at ligula.', '[]', '', 1),
(14, 'Eu ultrices vitae auctor eu augue', '1', 'eu-ultrices-vitae-auctor-eu-augue', '2022-04-09 20:48:54', '<p>Pharetra pharetra massa massa ultricies mi quis hendrerit. Porta nibh venenatis cras sed felis eget velit. Malesuada nunc vel risus commodo viverra maecenas. Eu ultrices vitae auctor eu augue ut lectus arcu bibendum. Duis tristique sollicitudin nibh sit amet commodo nulla facilisi. Tortor vitae purus faucibus ornare suspendisse sed nisi lacus. Orci dapibus ultrices in iaculis. Sit amet nisl purus in mollis. Eu ultrices vitae auctor eu augue ut lectus arcu bibendum. Sollicitudin tempor id eu nisl nunc mi ipsum.</p><p>Nullam eget felis eget nunc lobortis mattis aliquam faucibus. Auctor elit sed vulputate mi. Tincidunt ornare massa eget egestas. Ornare suspendisse sed nisi lacus sed viverra. Nisl purus in mollis nunc sed. Nulla facilisi etiam dignissim diam. Iaculis at erat pellentesque adipiscing commodo elit at imperdiet. Leo vel fringilla est ullamcorper eget nulla. Nam aliquam sem et tortor.</p>', '[\"eu\"]', 'Eu ultrices vitae auctor eu augue', 1),
(15, 'Egestas sed tempus urna et pharetra', '1', 'egestas-sed-tempus-urna-et-pharetra', '2022-04-09 21:26:23', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet nisl purus in mollis nunc sed id. Ut placerat orci nulla pellentesque dignissim enim sit amet venenatis. Lectus magna fringilla urna porttitor rhoncus dolor purus non enim. Nulla pharetra diam sit amet nisl suscipit adipiscing bibendum. Ipsum dolor sit amet consectetur adipiscing elit ut aliquam. Gravida in fermentum et sollicitudin ac orci phasellus egestas. Eget egestas purus viverra accumsan in nisl. Sodales ut eu sem integer. Etiam tempor orci eu lobortis elementum nibh. Eget nullam non nisi est sit. Vitae tempus quam pellentesque nec nam aliquam sem. A diam sollicitudin tempor id eu nisl nunc mi. Egestas sed tempus urna et pharetra pharetra massa. Massa eget egestas purus viverra accumsan in nisl. Sed blandit libero volutpat sed. Risus nec feugiat in fermentum posuere urna nec.</p><p>Nullam eget felis eget nunc lobortis mattis aliquam faucibus. Auctor elit sed vulputate mi. Tincidunt ornare massa eget egestas. Ornare suspendisse sed nisi lacus sed viverra. Nisl purus in mollis nunc sed. Nulla facilisi etiam dignissim diam. Iaculis at erat pellentesque adipiscing commodo elit at imperdiet. Leo vel fringilla est ullamcorper eget nulla. Nam aliquam sem et tortor. Pharetra pharetra massa massa ultricies mi quis hendrerit. Porta nibh venenatis cras sed felis eget velit. Malesuada nunc vel risus commodo viverra maecenas. Eu ultrices vitae auctor eu augue ut lectus arcu bibendum. Duis tristique sollicitudin nibh sit amet commodo nulla facilisi. Tortor vitae purus faucibus ornare suspendisse sed nisi lacus. Orci dapibus ultrices in iaculis. Sit amet nisl purus in mollis. Eu ultrices vitae auctor eu augue ut lectus arcu bibendum. Sollicitudin tempor id eu nisl nunc mi ipsum.</p>', '[\"egestas\",\"sed\"]', 'Egestas sed tempus urna et pharetra pharetra massa', 1),
(16, 'Quis hendrerit dolor magna', '1', 'quis-hendrerit-dolor-magna', '2022-04-09 21:27:48', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non quam lacus suspendisse faucibus interdum. Quis hendrerit dolor magna eget est lorem ipsum dolor. Pellentesque eu tincidunt tortor aliquam nulla facilisi cras. Vitae tempus quam pellentesque nec nam aliquam. Id leo in vitae turpis massa sed. Dolor morbi non arcu risus. Libero enim sed faucibus turpis in eu mi bibendum neque. Aliquet bibendum enim facilisis gravida neque convallis a cras. Neque laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt. Nec sagittis aliquam malesuada bibendum arcu vitae elementum. In eu mi bibendum neque egestas congue quisque egestas.</p><p>Nibh tellus molestie nunc non. Lorem sed risus ultricies tristique nulla aliquet enim tortor at. Feugiat scelerisque varius morbi enim nunc faucibus a pellentesque. Proin nibh nisl condimentum id venenatis a. Feugiat pretium nibh ipsum consequat nisl. Sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt. Feugiat vivamus at augue eget. Suspendisse interdum consectetur libero id faucibus. Netus et malesuada fames ac turpis egestas sed tempus. Volutpat lacus laoreet non curabitur gravida. Ultrices gravida dictum fusce ut placerat orci nulla.</p>', '[\"quis\"]', 'Quis hendrerit dolor magna', 1),
(17, 'Tincidunt vitae semper quis lectus', '1', 'tincidunt-vitae-semper-quis-lectus', '2022-04-09 21:28:35', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Condimentum lacinia quis vel eros donec ac odio tempor. Arcu ac tortor dignissim convallis aenean et. Sit amet facilisis magna etiam tempor orci eu lobortis elementum. Tincidunt vitae semper quis lectus nulla at volutpat diam. Duis at consectetur lorem donec massa. At augue eget arcu dictum varius duis. A arcu cursus vitae congue mauris. Arcu odio ut sem nulla pharetra diam sit amet nisl. Donec ultrices tincidunt arcu non.</p><p>Enim ut tellus elementum sagittis vitae et leo duis. Parturient montes nascetur ridiculus mus mauris vitae ultricies leo. Amet nulla facilisi morbi tempus iaculis urna id volutpat lacus. Pulvinar etiam non quam lacus suspendisse. Purus faucibus ornare suspendisse sed nisi lacus sed viverra. Non odio euismod lacinia at quis risus sed vulputate odio. Pulvinar neque laoreet suspendisse interdum consectetur libero id. Viverra accumsan in nisl nisi scelerisque eu ultrices. Fermentum odio eu feugiat pretium nibh. Laoreet id donec ultrices tincidunt arcu non sodales neque. Placerat in egestas erat imperdiet sed. Iaculis at erat pellentesque adipiscing commodo elit at. Mauris commodo quis imperdiet massa tincidunt. Ipsum dolor sit amet consectetur. Platea dictumst quisque sagittis purus sit amet volutpat consequat mauris. Eget velit aliquet sagittis id. Etiam tempor orci eu lobortis elementum nibh tellus molestie. Vitae sapien pellentesque habitant morbi tristique senectus et netus et. Nulla aliquet porttitor lacus luctus accumsan tortor.</p><p>Dignissim enim sit amet venenatis urna cursus. Nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Eu lobortis elementum nibh tellus molestie nunc non blandit. Condimentum mattis pellentesque id nibh tortor id. Mi quis hendrerit dolor magna eget est lorem ipsum dolor. Tincidunt vitae semper quis lectus nulla at volutpat diam. Sit amet commodo nulla facilisi nullam. Ut lectus arcu bibendum at varius vel pharetra vel turpis. Tincidunt ornare massa eget egestas purus viverra. Non consectetur a erat nam at lectus. Et odio pellentesque diam volutpat. Gravida neque convallis a cras semper. Venenatis tellus in metus vulputate eu. Et egestas quis ipsum suspendisse ultrices gravida dictum fusce. Libero id faucibus nisl tincidunt eget nullam. Tortor vitae purus faucibus ornare suspendisse sed nisi lacus. Eros in cursus turpis massa tincidunt. Nisl purus in mollis nunc sed id. Lobortis feugiat vivamus at augue eget.</p>', '[\"vitae\"]', 'Enim ut tellus elementum sagittis vitae et leo duis.', 1);

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

--
-- Dumping data for table `ARTICLE_CATEGORIES`
--

INSERT INTO `ARTICLE_CATEGORIES` (`ID`, `CATEGORY_URL`, `NAME`, `PARENT`) VALUES
(1, 'getting-started', 'Getting Started', NULL),
(2, 'faq', 'FAQ', NULL),
(3, 'help-docs', 'Help Docs', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `CANNED_RESPONSES`
--

CREATE TABLE `CANNED_RESPONSES` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(191) NOT NULL,
  `MESSAGE` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CANNED_RESPONSES`
--

INSERT INTO `CANNED_RESPONSES` (`ID`, `NAME`, `MESSAGE`) VALUES
(1, 'About Product', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
(2, 'Your Ticket', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
(3, 'Lorem Ipsum', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
(4, 'Ticket Status', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n'),
(5, 'Check Files', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\r\n'),
(6, 'Assigned', 'asdfasdfas\n');

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

--
-- Dumping data for table `CATEGORIES`
--

INSERT INTO `CATEGORIES` (`ID`, `ORDER`, `NAME`, `MAIN`, `PARENT`) VALUES
(1, 1, 'Support', 0, 0),
(2, 2, 'Test', 0, 0),
(3, 3, 'Product', 0, 0);

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

--
-- Dumping data for table `CONVERSATIONS`
--

INSERT INTO `CONVERSATIONS` (`ID`, `RELATION_TYPE`, `RELATED_ID`, `SENDER_ID`, `RECEIVER_ID`, `DATE`, `MESSAGE`) VALUES
(1, 'TICKET', 9, 2, 9, '2022-04-13 16:37:14', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n'),
(2, 'TICKET', 4, 3, 12, '2022-04-13 17:15:59', 'Facilisis volutpat est velit egestas dui id. Arcu ac tortor dignissim convallis aenean. Facilisi morbi tempus iaculis urna id volutpat. Fermentum odio eu feugiat pretium nibh ipsum consequat.\n'),
(3, 'TICKET', 4, 12, 12, '2022-04-13 17:16:25', 'Arcu ac tortor dignissim convallis aenean. Facilisi morbi tempus iaculis urna id volutpat. Fermentum odio eu feugiat pretium nibh ipsum consequat.\n'),
(4, 'TICKET', 3, 3, 11, '2022-04-13 17:17:49', 'Urna id volutpat lacus laoreet. Purus non enim praesent elementum. Consectetur a erat nam at lectus urna duis convallis.\n'),
(5, 'TICKET', 2, 1, 10, '2022-04-13 17:19:10', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco?\n'),
(6, 'TICKET', 2, 10, 10, '2022-04-13 17:19:42', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n'),
(7, 'TICKET', 5, 1, 13, '2022-04-13 17:34:59', 'Aliquam eleifend mi in nulla. Lacinia quis vel eros donec ac odio tempor.\n'),
(8, 'TICKET', 5, 13, 13, '2022-04-13 17:35:29', 'Eget lorem dolor sed viverra. Leo integer malesuada nunc vel risus commodo viverra maecenas. Leo urna molestie at elementum.\n'),
(9, 'TICKET', 9, 1, 9, '2022-04-14 04:00:36', 'Pretium nibh ipsum consequat nisl vel pretium lectus. Porttitor lacus luctus accumsan tortor. Ornare arcu odio ut sem.\n'),
(11, 'TICKET', 8, 1, 15, '2022-04-17 19:12:24', 'Ac ut consequat semper viverra nam libero justo. Ultrices sagittis orci a scelerisque purus semper eget duis at. Sed risus pretium quam vulputate. Nec nam aliquam sem et.\n'),
(13, 'TICKET', 9, 1, 9, '2022-04-21 07:04:09', 'We will help you soon!\n'),
(14, 'TICKET', 11, 1, 14, '2022-04-23 06:09:59', 'Vulputate enim nulla aliquet porttitor lacus luctus. Euismod elementum nisi quis eleifend quam adipiscing vitae proin. In egestas erat imperdiet sed.\n'),
(15, 'TICKET', 11, 1, 14, '2022-05-08 23:29:01', 'Test\n'),
(23, 'TICKET', 2, 1, 10, '2022-05-11 01:11:01', 'test\n'),
(24, 'TICKET', 11, 1, 14, '2022-05-11 01:11:51', 'test2\n');

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

--
-- Dumping data for table `CUSTOM_FIELDS`
--

INSERT INTO `CUSTOM_FIELDS` (`ID`, `NAME`, `DESCRIPTION`, `CONDITION`, `TYPE`, `REQUIRED`, `ORDER`, `DATA`, `RELATION_TYPE`, `PERMISSIONS`, `APPLICANT_TYPE`, `INPUT_SELECTED_FORMS`, `ACTIVE`) VALUES
(3, 'Product Code', 'What is your product code?', '{\"STATUS\":false,\"VALUE\":[]}', 'input', 'false', 2, '', 'TICKET', 'true', NULL, NULL, 'true'),
(4, 'Lıcense Code', 'What is your license code?', '{\"STATUS\":false,\"VALUE\":[]}', 'input', '', 2, '', 'TICKET', '', NULL, NULL, 'true'),
(5, 'Product type', 'Please select your product type', '{\"STATUS\":false,\"VALUE\":[]}', 'select', '', 3, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]', 'TICKET', '', NULL, NULL, 'true');

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

--
-- Dumping data for table `CUSTOM_FIELD_DATA`
--

INSERT INTO `CUSTOM_FIELD_DATA` (`ID`, `FIELD_ID`, `RELATED_ID`, `DATA`) VALUES
(1, 3, 1, '\"EXR-ERD\"'),
(2, 4, 1, '\"EMEA-MO-43\"'),
(3, 5, 1, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(4, 43, 1, '\"\"'),
(5, 3, 2, '\"XRC-43R5-2D\"'),
(6, 4, 2, '\"EMEA-435F\"'),
(7, 5, 2, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(8, 43, 2, '\"\"'),
(9, 3, 3, '\"SX4-434R-F\"'),
(10, 4, 3, '\"EMEA-43R-T\"'),
(11, 5, 3, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(12, 43, 3, '\"\"'),
(13, 3, 4, '\"UI-XE-3\"'),
(14, 4, 4, '\"EMEA-323\"'),
(15, 5, 4, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(16, 43, 4, '\"\"'),
(17, 3, 5, '\"XR-454-5\"'),
(18, 4, 5, '\"EMEA-53F-C\"'),
(19, 5, 5, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(20, 43, 5, '\"\"'),
(21, 3, 6, '\"XRC-RR-TD\"'),
(22, 4, 6, '\"EMEA-43R-C\"'),
(23, 5, 6, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(24, 43, 6, '\"\"'),
(25, 3, 7, '\"XEC-RF-044\"'),
(26, 4, 7, '\"EMEA-44F-C\"'),
(27, 5, 7, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(28, 43, 7, '\"\"'),
(29, 3, 8, '\"XEX-DES-55\"'),
(30, 4, 8, '\"EMEA-5D5-64\"'),
(31, 5, 8, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(32, 43, 8, '\"\"'),
(33, 3, 9, '\"67-JH-76\"'),
(34, 4, 9, '\"EMEA-567-KJ\"'),
(35, 5, 9, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(36, 43, 9, '\"\"'),
(37, 3, 10, '\"1\"'),
(38, 4, 10, '\"\"'),
(39, 5, 10, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(40, 48, 10, '[{\"NAME\":\"Black\",\"ID\":0,\"$$hashKey\":\"object:183\"},{\"NAME\":\"Red\",\"ID\":1,\"$$hashKey\":\"object:184\"},{\"NAME\":\"Yellow\",\"ID\":2,\"$$hashKey\":\"object:187\"}]'),
(41, 3, 11, '\"XRC-RR-TD\"'),
(42, 4, 11, '\"EMEA-43R-C\"'),
(43, 5, 11, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]'),
(44, 3, 12, '\"a\"'),
(45, 4, 12, '\"v\"'),
(46, 5, 12, '[{\"NAME\":\"XL\",\"ID\":\"0\",\"$$hashKey\":\"object:159\"},{\"NAME\":\"SM\",\"ID\":\"1\",\"$$hashKey\":\"object:162\"}]');

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
(1, 'General'),
(2, 'Sales'),
(3, 'Accounting'),
(4, 'IT'),
(5, 'Law');

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

--
-- Dumping data for table `LOGS`
--

INSERT INTO `LOGS` (`ID`, `DATE`, `USER_ID`, `CLIENT`, `RELATION_TYPE`, `RELATED_ID`, `DETAIL`) VALUES
(1, '2022-04-13 16:30:30', 9, '0b856b', 'TICKET', 1, '<strong>Juniper</strong> created a ticket <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a>'),
(2, '2022-04-13 16:31:27', 2, '', 'TICKET', 1, 'Harper assigned to #ce6106 by Dexter'),
(3, '2022-04-13 16:37:14', 2, '0b856b', 'TICKET', 1, '<span class=\"text-bold\">Harper Harris </span> replied <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a>'),
(4, '2022-04-13 16:38:54', 10, '42cbb1', 'TICKET', 2, '<strong>Oscar</strong> created a ticket <a ng-href=\"#!/tickets/ticket/33a52d\" class=\"notification-target-link\">#33a52d</a>'),
(5, '2022-04-13 16:39:43', 11, '703dd6', 'TICKET', 3, '<strong>Carson</strong> created a ticket <a ng-href=\"#!/tickets/ticket/e9ad5b\" class=\"notification-target-link\">#e9ad5b</a>'),
(6, '2022-04-13 16:40:25', 12, '42bbb4', 'TICKET', 4, '<strong>Daniel</strong> created a ticket <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a>'),
(7, '2022-04-13 16:41:50', 13, '691115', 'TICKET', 5, '<strong>Callie</strong> created a ticket <a ng-href=\"#!/tickets/ticket/6ac44c\" class=\"notification-target-link\">#6ac44c</a>'),
(8, '2022-04-13 17:14:49', 3, '', 'TICKET', 4, 'Rebecca assigned to #314429 by Dexter'),
(9, '2022-04-13 17:15:59', 3, '42bbb4', 'TICKET', 4, '<span class=\"text-bold\">Rebecca Hill </span> replied <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a>'),
(10, '2022-04-13 17:16:25', 12, '42bbb4', 'TICKET', 4, '<span class=\"text-bold\">Daniel Robinson </span> replied <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a>'),
(11, '2022-04-13 17:16:57', 3, '42bbb4', 'TICKET', 4, '<strong>Rebecca</strong> changed <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a> status to closed'),
(12, '2022-04-13 17:17:49', 3, '703dd6', 'TICKET', 3, '<span class=\"text-bold\">Rebecca Hill </span> replied <a ng-href=\"#!/tickets/ticket/e9ad5b\" class=\"notification-target-link\">#e9ad5b</a>'),
(13, '2022-04-13 17:19:10', 1, '42cbb1', 'TICKET', 2, '<span class=\"text-bold\">Dexter Bones </span> replied <a ng-href=\"#!/tickets/ticket/33a52d\" class=\"notification-target-link\">#33a52d</a>'),
(14, '2022-04-13 17:19:42', 10, '42cbb1', 'TICKET', 2, '<span class=\"text-bold\">Oscar Berry </span> replied <a ng-href=\"#!/tickets/ticket/33a52d\" class=\"notification-target-link\">#33a52d</a>'),
(15, '2022-04-13 17:34:59', 1, '691115', 'TICKET', 5, '<span class=\"text-bold\">Dexter Bones </span> replied <a ng-href=\"#!/tickets/ticket/6ac44c\" class=\"notification-target-link\">#6ac44c</a>'),
(16, '2022-04-13 17:35:29', 13, '691115', 'TICKET', 5, '<span class=\"text-bold\">Callie Mills </span> replied <a ng-href=\"#!/tickets/ticket/6ac44c\" class=\"notification-target-link\">#6ac44c</a>'),
(17, '2022-04-13 17:37:10', 14, '59a1c8', 'TICKET', 6, '<strong>Naomi</strong> created a ticket <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a>'),
(18, '2022-04-13 17:39:35', 17, '090937', 'TICKET', 7, '<strong>Cäcilie</strong> created a ticket <a ng-href=\"#!/tickets/ticket/04ca21\" class=\"notification-target-link\">#04ca21</a>'),
(19, '2022-04-14 02:18:25', 5, '', 'TICKET', 6, 'Bradley assigned to <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> by Dexter'),
(20, '2022-04-14 02:19:56', 6, '', 'TICKET', 6, '<strong>Camden</strong> assigned to <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> by <span class=\"text-bold\">Dexter</span>'),
(21, '2022-04-14 02:29:16', 15, '3e6c69', 'TICKET', 8, '<strong>Demi</strong> created a ticket <a ng-href=\"#!/tickets/ticket/ee6402\" class=\"notification-target-link\">#ee6402</a>'),
(22, '2022-04-14 03:58:49', 9, '0b856b', 'TICKET', 9, '<strong>Juniper</strong> created a ticket <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>'),
(23, '2022-04-14 04:00:36', 1, '0b856b', 'TICKET', 9, '<span class=\"text-bold\">Dexter Bones </span> replied <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>'),
(24, '2022-04-16 17:46:39', 1, '0b856b', 'TICKET', 9, '<span class=\"text-bold\">Dexter Bones </span> replied <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>'),
(25, '2022-04-16 18:06:15', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(26, '2022-04-17 13:24:40', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(27, '2022-04-17 13:36:28', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(28, '2022-04-17 13:49:16', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(29, '2022-04-17 19:12:24', 1, '3e6c69', 'TICKET', 8, '<span class=\"text-bold\">Dexter Bones </span> replied <a ng-href=\"#!/tickets/ticket/ee6402\" class=\"notification-target-link\">#ee6402</a>'),
(31, '2022-04-17 20:57:41', 2, '', '', 0, '<strong>Harper</strong> logged in the system'),
(32, '2022-04-17 21:05:32', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(33, '2022-04-17 21:08:08', 2, '', '', 0, '<strong>Harper</strong> logged in the system'),
(34, '2022-04-17 21:08:26', 9, '', '', 0, '<strong>Juniper</strong> logged in the system'),
(35, '2022-04-17 21:21:52', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(36, '2022-04-17 21:47:16', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(37, '2022-04-17 21:57:01', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(38, '2022-04-17 22:06:22', 10, '', '', 0, '<strong>Oscar</strong> logged in the system'),
(39, '2022-04-17 22:06:31', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(40, '2022-04-20 03:55:29', 1, '0b856b', 'TICKET', 9, '<strong>Dexter</strong> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Assigned'),
(41, '2022-04-20 03:55:31', 1, '0b856b', 'TICKET', 9, '<strong>Dexter</strong> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Replied'),
(42, '2022-04-20 03:55:40', 1, '0b856b', 'TICKET', 9, '<strong>Dexter</strong> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Assigned'),
(43, '2022-04-20 03:55:53', 1, '0b856b', 'TICKET', 9, '<strong>Dexter</strong> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Replied'),
(44, '2022-04-20 04:01:31', 1, '0b856b', 'TICKET', 9, '<span class=\"text-bold\">Dexter Bones </span> replied <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>'),
(45, '2022-04-20 08:30:41', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(46, '2022-04-20 20:21:11', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(47, '2022-04-21 07:04:09', 1, '0b856b', 'TICKET', 1, '<span class=\"text-bold\">Dexter Bones </span> replied <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a>'),
(48, '2022-04-21 07:04:41', 1, '0b856b', 'TICKET', 1, '<strong>Dexter</strong> merged <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a> with <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>'),
(49, '2022-04-21 07:04:41', 1, '0b856b', 'TICKET', 9, '<strong>Dexter</strong> merged <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a> with <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>'),
(50, '2022-04-21 07:04:41', 1, '0b856b', 'TICKET', 1, '<strong>Dexter</strong> changed <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a> status to closed'),
(51, '2022-04-21 07:06:04', 1, '0b856b', 'TICKET', 10, '<strong>Dexter</strong> changed <a ng-href=\"#!/tickets/ticket/BT77NFG\" class=\"notification-target-link\">#BT77NFG</a> status to closed'),
(52, '2022-04-21 09:55:40', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(53, '2022-04-21 19:40:27', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(54, '2022-04-22 00:08:59', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(55, '2022-04-22 02:18:56', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(56, '2022-04-22 03:17:27', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(57, '2022-04-22 20:55:26', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(58, '2022-04-23 01:41:16', 14, '', '', 0, '<strong>Naomi</strong> logged in the system'),
(59, '2022-04-23 01:42:02', 14, '59a1c8', 'TICKET', 11, '<strong>Naomi</strong> created a ticket <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>'),
(60, '2022-04-23 01:42:10', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(69, '2022-04-23 03:40:19', 1, '59a1c8', 'TICKET', 6, '<strong>Dexter</strong> merged <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> with <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>'),
(70, '2022-04-23 03:40:19', 1, '59a1c8', 'TICKET', 11, '<strong>Dexter</strong> merged <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> with <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>'),
(71, '2022-04-23 03:40:19', 1, '59a1c8', 'TICKET', 6, '<strong>Dexter</strong> changed <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> status to closed'),
(72, '2022-04-23 03:42:37', 1, '59a1c8', 'TICKET', 6, '<strong>Dexter</strong> merged <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> with <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>'),
(73, '2022-04-23 03:42:37', 1, '59a1c8', 'TICKET', 11, '<strong>Dexter</strong> merged <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> with <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>'),
(74, '2022-04-23 03:42:37', 1, '59a1c8', 'TICKET', 6, '<strong>Dexter</strong> changed <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> status to closed'),
(75, '2022-04-23 05:44:42', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(76, '2022-04-23 06:09:51', 1, '', 'TICKET', 11, '<strong>Dexter</strong> assigned to <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> by <span class=\"text-bold\">Dexter</span>'),
(77, '2022-04-23 06:09:59', 1, '59a1c8', 'TICKET', 11, '<span class=\"text-bold\">Dexter Bones </span> replied <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>'),
(78, '2022-04-23 09:20:07', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(79, '2022-04-23 10:58:40', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(80, '2022-04-23 20:14:48', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(81, '2022-04-24 03:33:41', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(82, '2022-04-25 01:52:23', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(83, '2022-04-25 01:53:14', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(84, '2022-04-25 06:49:16', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(85, '2022-04-25 10:33:29', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(86, '2022-04-25 22:35:30', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(87, '2022-04-25 22:55:21', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(88, '2022-04-26 02:53:58', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(89, '2022-04-26 04:25:13', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(90, '2022-04-26 04:25:29', 9, '', '', 0, '<strong>Juniper</strong> logged in the system'),
(91, '2022-04-26 04:26:09', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(92, '2022-04-26 16:16:57', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(93, '2022-04-27 04:10:21', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(94, '2022-04-28 04:57:07', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(95, '2022-04-28 15:27:13', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(96, '2022-04-28 16:27:10', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(97, '2022-04-28 16:33:48', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(98, '2022-04-28 16:35:47', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(99, '2022-04-28 16:44:19', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(100, '2022-04-29 06:35:31', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(101, '2022-04-29 09:35:27', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(102, '2022-04-29 09:42:50', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(103, '2022-04-29 16:11:54', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(104, '2022-04-29 20:32:39', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(105, '2022-04-30 03:33:49', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(106, '2022-05-01 00:37:28', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(107, '2022-05-01 15:01:53', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(108, '2022-05-01 21:32:05', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(109, '2022-05-02 12:10:57', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(110, '2022-05-02 12:36:31', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(111, '2022-05-02 18:29:36', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(112, '2022-05-03 09:26:32', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(113, '2022-05-03 10:29:33', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(114, '2022-05-03 20:48:10', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(115, '2022-05-04 00:56:23', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(116, '2022-05-04 10:29:37', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(117, '2022-05-04 10:31:34', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(118, '2022-05-04 16:40:59', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(119, '2022-05-04 18:48:00', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(120, '2022-05-04 20:16:10', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(121, '2022-05-05 10:21:55', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(122, '2022-05-05 19:40:00', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(123, '2022-05-05 19:51:05', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(124, '2022-05-05 21:32:57', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(125, '2022-05-05 21:54:45', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(126, '2022-05-06 21:48:01', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(127, '2022-05-08 12:07:08', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(128, '2022-05-08 12:33:35', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(129, '2022-05-08 13:04:29', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(130, '2022-05-08 14:36:11', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(132, '2022-05-08 23:02:58', 1, '59a1c8', 'TICKET', 11, '0'),
(133, '2022-05-08 23:03:21', 1, '59a1c8', 'TICKET', 11, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talep durumunu Replied olarak değiştirdi'),
(134, '2022-05-08 23:05:01', 1, '59a1c8', 'TICKET', 11, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talep durumunu Atanıldı olarak değiştirdi'),
(135, '2022-05-08 23:12:37', 1, '59a1c8', 'TICKET', 11, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talep durumunu Cevaplandı olarak değiştirdi'),
(136, '2022-05-08 23:12:57', 14, '', '', 0, '<strong>Naomi</strong> logged in the system'),
(137, '2022-05-08 23:15:55', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(138, '2022-05-08 23:16:04', 1, '59a1c8', 'TICKET', 11, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talep durumunu Kapandı olarak değiştirdi'),
(139, '2022-05-08 23:29:01', 1, '59a1c8', 'TICKET', 11, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talebi yanıtladı'),
(140, '2022-05-08 23:29:12', 14, '', '', 0, '<strong>Naomi</strong> logged in the system'),
(141, '2022-05-08 23:38:41', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(142, '2022-05-08 23:40:23', 1, '', 'TICKET', 3, '<strong>Dexter</strong> Dexter adlı kullanıcıyı <a ng-href=\'#!/tickets/ticket/e9ad5b\' class=\'notification-target-link\'>#e9ad5b</a> numaralı talebe atadı.'),
(143, '2022-05-08 23:45:11', 1, '', '', 0, '<strong>Dexter</strong> sisteme giriş yaptı'),
(144, '2022-05-08 23:52:39', 1, '42cbb1', 'TICKET', 2, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı'),
(145, '2022-05-08 23:57:25', 1, '42cbb1', 'TICKET', 2, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı'),
(146, '2022-05-09 00:02:53', 1, '42cbb1', 'TICKET', 2, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı'),
(147, '2022-05-09 00:03:56', 1, '42cbb1', 'TICKET', 2, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı'),
(148, '2022-05-09 00:06:44', 1, '42cbb1', 'TICKET', 2, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı'),
(149, '2022-05-09 00:07:56', 1, '42cbb1', 'TICKET', 2, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı'),
(150, '2022-05-09 00:10:01', 1, '42cbb1', 'TICKET', 2, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı'),
(151, '2022-05-09 00:19:30', 1, '', '', 0, '<strong>Dexter</strong> sisteme giriş yaptı'),
(152, '2022-05-09 15:03:26', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(153, '2022-05-10 02:10:43', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(154, '2022-05-11 01:08:50', 1, '', '', 0, '<strong>Dexter</strong> logged in the system'),
(155, '2022-05-11 01:11:01', 1, '42cbb1', 'TICKET', 2, '<strong>Dexter</strong> replied <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a>'),
(156, '2022-05-11 01:11:51', 1, '59a1c8', 'TICKET', 11, '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talebi yanıtladı'),
(157, '2022-05-12 23:16:27', 1, '', '', 0, '<strong>Dexter</strong> sisteme giriş yaptı'),
(158, '2022-05-14 15:47:21', 1, '', '', 0, '<strong>Dexter</strong> logged in the system');

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

--
-- Dumping data for table `NOTES`
--

INSERT INTO `NOTES` (`ID`, `RELATION_TYPE`, `RELATED_ID`, `NOTE`, `USER_ID`, `DATE`, `PRIVATE`) VALUES
(1, 'TICKET', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n', 1, '2022-04-13 17:34:22', 'true'),
(2, 'TICKET', 9, 'Elit eget gravida cum sociis natoque penatibus et magnis dis. Lectus magna fringilla urna porttitor rhoncus dolor purus.\n', 1, '2022-04-14 04:01:41', 'true');

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

--
-- Dumping data for table `NOTIFICATIONS`
--

INSERT INTO `NOTIFICATIONS` (`ID`, `READ`, `DATE`, `TITLE`, `DETAIL`, `RELATION_TYPE`, `RELATED_ID`, `RECEIVER`) VALUES
(1, 'false', '2022-04-13 16:31:27', 'New Assign', '<span class=\"text-bold\">Dexter</span> assigned you to <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a>', 'TICKET', '1', 2),
(2, 'false', '2022-04-13 16:31:27', 'New Assign', '<span class=\"text-bold\">Harper Harris </span> assigned to <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a>', 'TICKET', '1', 9),
(3, 'false', '2022-04-13 16:37:14', 'New Assign', '<span class=\"text-bold\">Harper Harris </span> replied the <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a>', 'TICKET', '1', 9),
(4, 'false', '2022-04-13 17:14:49', 'New Assign', '<span class=\"text-bold\">Dexter</span> assigned you to <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a>', 'TICKET', '4', 3),
(5, 'false', '2022-04-13 17:14:49', 'New Assign', '<span class=\"text-bold\">Rebecca Hill </span> assigned to <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a>', 'TICKET', '4', 12),
(6, 'false', '2022-04-13 17:15:59', 'New Assign', '<span class=\"text-bold\">Rebecca Hill </span> replied the <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a>', 'TICKET', '4', 12),
(7, 'false', '2022-04-13 17:16:25', 'New Assign', '<span class=\"text-bold\">Daniel Robinson </span> replied the <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a>', 'TICKET', '4', 3),
(8, 'false', '2022-04-13 17:16:57', 'Status Changed', '<span class=\"text-bold\">Rebecca Hill </span> changed <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a> status to Closed', 'TICKET', '4', 12),
(9, 'false', '2022-04-13 17:16:57', 'Status Changed', '<span class=\"text-bold\">Rebecca Hill </span> changed <a ng-href=\"#!/tickets/ticket/314429\" class=\"notification-target-link\">#314429</a> status to Closed', 'TICKET', '4', 3),
(10, 'false', '2022-04-13 17:17:49', 'New Assign', '<span class=\"text-bold\">Rebecca Hill </span> replied the <a ng-href=\"#!/tickets/ticket/e9ad5b\" class=\"notification-target-link\">#e9ad5b</a>', 'TICKET', '3', 11),
(11, 'true', '2022-04-13 17:19:10', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> replied the <a ng-href=\"#!/tickets/ticket/33a52d\" class=\"notification-target-link\">#33a52d</a>', 'TICKET', '2', 10),
(12, 'true', '2022-04-13 17:19:42', 'New Assign', '<span class=\"text-bold\">Oscar Berry </span> replied the <a ng-href=\"#!/tickets/ticket/33a52d\" class=\"notification-target-link\">#33a52d</a>', 'TICKET', '2', 1),
(13, 'false', '2022-04-13 17:34:59', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> replied the <a ng-href=\"#!/tickets/ticket/6ac44c\" class=\"notification-target-link\">#6ac44c</a>', 'TICKET', '5', 13),
(14, 'true', '2022-04-13 17:35:29', 'New Assign', '<span class=\"text-bold\">Callie Mills </span> replied the <a ng-href=\"#!/tickets/ticket/6ac44c\" class=\"notification-target-link\">#6ac44c</a>', 'TICKET', '5', 1),
(15, 'false', '2022-04-14 02:18:25', 'New Assign', '<span class=\"text-bold\">Dexter</span> assigned you to <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a>', 'TICKET', '6', 5),
(16, 'false', '2022-04-14 02:18:25', 'New Assign', '<span class=\"text-bold\">Bradley Mccarty </span> assigned to <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a>', 'TICKET', '6', 14),
(17, 'false', '2022-04-14 02:19:56', 'New Assign', '<span class=\"text-bold\">Dexter</span> assigned you to <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a>', 'TICKET', '6', 6),
(18, 'false', '2022-04-14 02:19:56', 'New Assign', '<span class=\"text-bold\">Camden Lambert </span> assigned to <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a>', 'TICKET', '6', 14),
(19, 'false', '2022-04-14 04:00:36', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> replied the <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>', 'TICKET', '9', 9),
(20, 'false', '2022-04-16 17:46:39', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> replied the <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>', 'TICKET', '9', 9),
(21, 'false', '2022-04-17 19:12:24', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> replied the <a ng-href=\"#!/tickets/ticket/ee6402\" class=\"notification-target-link\">#ee6402</a>', 'TICKET', '8', 15),
(22, 'false', '2022-04-20 03:55:29', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Assigned', 'TICKET', '9', 9),
(23, 'false', '2022-04-20 03:55:29', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Assigned', 'TICKET', '9', 1),
(24, 'false', '2022-04-20 03:55:31', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Replied', 'TICKET', '9', 9),
(25, 'false', '2022-04-20 03:55:31', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Replied', 'TICKET', '9', 1),
(26, 'false', '2022-04-20 03:55:40', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Assigned', 'TICKET', '9', 9),
(27, 'true', '2022-04-20 03:55:40', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Assigned', 'TICKET', '9', 1),
(28, 'false', '2022-04-20 03:55:53', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Replied', 'TICKET', '9', 9),
(29, 'false', '2022-04-20 03:55:53', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a> status to Replied', 'TICKET', '9', 1),
(30, 'false', '2022-04-20 04:01:31', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> replied the <a ng-href=\"#!/tickets/ticket/3c77aa\" class=\"notification-target-link\">#3c77aa</a>', 'TICKET', '9', 9),
(31, 'false', '2022-04-21 07:04:09', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> replied the <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a>', 'TICKET', '1', 9),
(32, 'false', '2022-04-21 07:04:41', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/ce6106\" class=\"notification-target-link\">#ce6106</a> status to Closed', 'TICKET', '1', 9),
(33, 'false', '2022-04-21 07:06:04', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/BT77NFG\" class=\"notification-target-link\">#BT77NFG</a> status to Closed', 'TICKET', '10', 9),
(34, 'false', '2022-04-21 07:06:04', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/BT77NFG\" class=\"notification-target-link\">#BT77NFG</a> status to Closed', 'TICKET', '10', 1),
(35, 'false', '2022-04-23 03:40:19', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> status to Closed', 'TICKET', '6', 14),
(36, 'false', '2022-04-23 03:42:37', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/e7ca47\" class=\"notification-target-link\">#e7ca47</a> status to Closed', 'TICKET', '6', 14),
(37, 'false', '2022-04-23 06:09:51', 'New Assign', '<span class=\"text-bold\">Dexter</span> assigned you to <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>', 'TICKET', '11', 1),
(38, 'false', '2022-04-23 06:09:51', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> assigned to <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>', 'TICKET', '11', 14),
(39, 'false', '2022-04-23 06:09:59', 'New Assign', '<span class=\"text-bold\">Dexter Bones </span> replied the <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a>', 'TICKET', '11', 14),
(40, 'false', '2022-05-08 23:02:58', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> status to Assigned', 'TICKET', '11', 14),
(41, 'false', '2022-05-08 23:02:58', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> status to Assigned', 'TICKET', '11', 1),
(42, 'false', '2022-05-08 23:03:21', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> status to Replied', 'TICKET', '11', 14),
(43, 'false', '2022-05-08 23:03:21', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> status to Replied', 'TICKET', '11', 1),
(44, 'false', '2022-05-08 23:05:01', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> status to Atanıldı', 'TICKET', '11', 14),
(45, 'false', '2022-05-08 23:05:01', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> status to Atanıldı', 'TICKET', '11', 1),
(46, 'false', '2022-05-08 23:12:37', 'Status Changed', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talep durumunu Cevaplandı olarak değiştirdi', 'TICKET', '11', 14),
(47, 'false', '2022-05-08 23:12:37', 'Status Changed', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talep durumunu Cevaplandı olarak değiştirdi', 'TICKET', '11', 1),
(48, 'false', '2022-05-08 23:16:04', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> status to Closed', 'TICKET', '11', 14),
(49, 'false', '2022-05-08 23:16:04', 'Status Changed', '<span class=\"text-bold\">Dexter Bones </span> changed <a ng-href=\"#!/tickets/ticket/d46c74\" class=\"notification-target-link\">#d46c74</a> status to Closed', 'TICKET', '11', 1),
(50, 'false', '2022-05-08 23:29:01', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talebi yanıtladı', 'TICKET', '11', 14),
(51, 'false', '2022-05-08 23:40:23', 'New Assign', '<strong>Dexter</strong> sizi <a ng-href=\'#!/tickets/ticket/e9ad5b\' class=\'notification-target-link\'>#e9ad5b</a> numaralı talebe atadı.', 'TICKET', '3', 1),
(52, 'false', '2022-05-08 23:40:23', 'New Assign', '<strong>Dexter</strong> Dexter adlı kullanıcıyı <a ng-href=\'#!/tickets/ticket/e9ad5b\' class=\'notification-target-link\'>#e9ad5b</a> numaralı talebe atadı.', 'TICKET', '3', 11),
(53, 'false', '2022-05-08 23:52:39', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı', 'TICKET', '2', 10),
(54, 'false', '2022-05-08 23:57:25', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı', 'TICKET', '2', 10),
(55, 'false', '2022-05-09 00:02:53', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı', 'TICKET', '2', 10),
(56, 'false', '2022-05-09 00:03:56', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı', 'TICKET', '2', 10),
(57, 'false', '2022-05-09 00:06:44', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı', 'TICKET', '2', 10),
(58, 'false', '2022-05-09 00:07:56', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı', 'TICKET', '2', 10),
(59, 'false', '2022-05-09 00:10:01', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a> numaralı talebi yanıtladı', 'TICKET', '2', 10),
(60, 'false', '2022-05-11 01:11:01', 'Replied', '<strong>Dexter</strong> replied <a ng-href=\'#!/tickets/ticket/33a52d\' class=\'notification-target-link\'>#33a52d</a>', 'TICKET', '2', 10),
(61, 'false', '2022-05-11 01:11:51', 'Cevaplandı', '<strong>Dexter</strong> <a ng-href=\'#!/tickets/ticket/d46c74\' class=\'notification-target-link\'>#d46c74</a> numaralı talebi yanıtladı', 'TICKET', '11', 14);

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
  `NO_REPLY_EMAIL` varchar(255) NOT NULL,
  `LANG` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `OPTIONS`
--

INSERT INTO `OPTIONS` (`NAME`, `HELPDESK_STATUS`, `VACATION_MODE`, `DEFAULT_DEPARTMENT`, `APPLICATION_NAME`, `APP_COLOR`, `DESK_URL`, `MAX_PAGE_SIZE`, `BUSINESS_HOURS`, `DEFAULT_LOCALE`, `DEFAULT_TIME_ZONE`, `EMAIL_ENCRYPTION`, `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS`, `NO_REPLY_EMAIL`, `LANG`) VALUES
('APP', 'true', 'false', 1, 'Tickotty - Help Desk', '#3F51B5', 'http://localhost:8888/tickotty/', 6, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]', 3, 'Europe/Istanbul', 0, 'smtpout.secureserver.net', '587', 'support@luceat.solutions', '**91D428aa', 'noreply@luceat.solutions', 'en_US');

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
(8, 14, 2),
(9, 14, 5),
(10, 15, 2),
(11, 15, 5),
(12, 2, 1),
(13, 2, 2),
(14, 2, 6),
(15, 3, 1),
(16, 3, 2),
(17, 3, 6),
(18, 4, 1),
(19, 4, 2),
(20, 4, 6),
(21, 5, 1),
(22, 5, 2),
(23, 5, 6),
(24, 6, 1),
(25, 6, 2),
(26, 6, 6),
(27, 7, 1),
(28, 7, 2),
(29, 7, 6),
(30, 8, 1),
(31, 8, 2),
(32, 8, 6),
(34, 9, 2),
(35, 9, 5),
(37, 10, 2),
(38, 10, 5),
(40, 11, 2),
(41, 11, 5),
(43, 12, 2),
(44, 12, 5),
(46, 13, 2),
(47, 13, 5),
(49, 14, 2),
(50, 14, 5),
(52, 15, 2),
(53, 15, 5),
(55, 16, 2),
(56, 16, 5),
(58, 17, 2),
(59, 17, 5),
(61, 1, 1),
(64, 1, 7);

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
(1, 'In Progress', 1, 1),
(4, 'In Progress', 1, 2),
(5, 'In Review', 2, 2),
(8, 'In Review', 2, 1),
(9, 'Done', 3, 1),
(12, 'Done', 3, 2),
(14, 'In Progress', 1, 3),
(15, 'In Review', 2, 3),
(16, 'Done', 3, 3),
(18, 'In Progress', 1, 5),
(19, 'In Progress', 1, 4),
(20, 'In Review', 2, 4),
(21, 'In Lawyer Review', 2, 5),
(22, 'In Repair', 3, 4),
(23, 'Confirmed', 3, 5),
(25, 'In Case', 4, 5),
(26, 'Done', 4, 4),
(27, 'Done', 5, 5);

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

--
-- Dumping data for table `SLA_POLICIES`
--

INSERT INTO `SLA_POLICIES` (`ID`, `NAME`, `DESCRIPTION`, `TRIGGER`, `VIOLATION_RULES`, `TARGETS`, `CREATED_DATE`, `UPDATED_DATE`, `ACTIVE`) VALUES
(1, 'Default SLA Policy', 'Default sla policy for all tickets.', '{\"RELATION_TYPE\":\"1\",\"REALTION\":\"5\",\"RELATION\":\"9\"}', '[{\"ID\":1,\"NAME\":\"Violation Response\",\"DESCRIPTION\":\"Set escalation rule when a ticket is not responded to on time\",\"ESCALATE\":\"1\",\"WARN_ASSIGNED\":true,\"INFORM\":[{\"ID\":\"1\",\"CLIENT_ID\":null,\"DEPARTMENT_ID\":\"1\",\"LANGUAGE\":\"english\",\"ADDRESS\":\"891 Myrl Pass Suite 669 South Aliyah, WV 09539-6270\",\"PHONE\":\"+1-427-368-5552\",\"TOKEN\":\"mkcr4\",\"EMAIL\":\"admin@luceat.solutions\",\"NAME\":\"Dexter\",\"SURNAME\":\"Bones\",\"USERNAME\":\"root\",\"ADMIN\":true,\"STAFF\":false,\"WORKING_HOURS\":[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}],\"PRIVILEGES\":[{\"ID\":\"1\",\"NAME\":\"Clients\",\"deger\":true},{\"ID\":\"2\",\"NAME\":\"Tickets\",\"deger\":true},{\"ID\":\"3\",\"NAME\":\"Reports\",\"deger\":true},{\"ID\":\"4\",\"NAME\":\"Options\",\"deger\":true},{\"ID\":\"5\",\"NAME\":\"Staff\",\"deger\":true},{\"ID\":\"6\",\"NAME\":\"SLA\",\"deger\":true},{\"ID\":\"7\",\"NAME\":\"Knowledge Base\",\"deger\":true}],\"$$hashKey\":\"object:1120\"}],\"$$hashKey\":\"object:50\"},{\"ID\":2,\"NAME\":\"Violation Resolve\",\"DESCRIPTION\":\"Set escalation hierarchy when a ticket is not resolved on time\",\"ESCALATE\":\"1\",\"WARN_ASSIGNED\":true,\"INFORM\":[{\"ID\":\"1\",\"CLIENT_ID\":null,\"DEPARTMENT_ID\":\"1\",\"LANGUAGE\":\"english\",\"ADDRESS\":\"891 Myrl Pass Suite 669 South Aliyah, WV 09539-6270\",\"PHONE\":\"+1-427-368-5552\",\"TOKEN\":\"mkcr4\",\"EMAIL\":\"admin@luceat.solutions\",\"NAME\":\"Dexter\",\"SURNAME\":\"Bones\",\"USERNAME\":\"root\",\"ADMIN\":true,\"STAFF\":false,\"WORKING_HOURS\":[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}],\"PRIVILEGES\":[{\"ID\":\"1\",\"NAME\":\"Clients\",\"deger\":true},{\"ID\":\"2\",\"NAME\":\"Tickets\",\"deger\":true},{\"ID\":\"3\",\"NAME\":\"Reports\",\"deger\":true},{\"ID\":\"4\",\"NAME\":\"Options\",\"deger\":true},{\"ID\":\"5\",\"NAME\":\"Staff\",\"deger\":true},{\"ID\":\"6\",\"NAME\":\"SLA\",\"deger\":true},{\"ID\":\"7\",\"NAME\":\"Knowledge Base\",\"deger\":true}],\"$$hashKey\":\"object:1120\"}],\"$$hashKey\":\"object:51\"}]', '[{\"ID\":1,\"NAME\":\"LOW\",\"OPERATIONAL_HOURSES\":1,\"DATA\":[{\"NAME\":\"RESPOND\",\"TIME\":5,\"PERIOD\":\"2\",\"$$hashKey\":\"object:60\"},{\"NAME\":\"RESOLVE\",\"TIME\":10,\"PERIOD\":\"2\",\"$$hashKey\":\"object:61\"}],\"$$hashKey\":\"object:40\"},{\"ID\":2,\"NAME\":\"MEDIUM\",\"OPERATIONAL_HOURSES\":1,\"DATA\":[{\"NAME\":\"RESPOND\",\"TIME\":4,\"PERIOD\":\"2\",\"$$hashKey\":\"object:80\"},{\"NAME\":\"RESOLVE\",\"TIME\":9,\"PERIOD\":\"2\",\"$$hashKey\":\"object:81\"}],\"$$hashKey\":\"object:41\"},{\"ID\":3,\"NAME\":\"HIGH\",\"OPERATIONAL_HOURSES\":1,\"DATA\":[{\"NAME\":\"RESPOND\",\"TIME\":3,\"PERIOD\":\"2\",\"$$hashKey\":\"object:94\"},{\"NAME\":\"RESOLVE\",\"TIME\":8,\"PERIOD\":\"2\",\"$$hashKey\":\"object:95\"}],\"$$hashKey\":\"object:42\"}]', '2019-10-04 19:24:41', '2022-05-03 09:28:44', 'true'),
(2, 'Default SLA Policy', 'Default sla policy for all tickets.', '{\"RELATION_TYPE\":\"1\",\"RELATION\":\"10\"}', '[{\"ID\":1,\"NAME\":\"Violation Response\",\"DESCRIPTION\":\"Set escalation rule when a ticket is not responded to on time\",\"ESCALATE\":\"2\",\"WARN_ASSIGNED\":true,\"INFORM\":[{\"ID\":\"1\",\"CLIENT_ID\":null,\"DEPARTMENT_ID\":\"1\",\"LANGUAGE\":\"english\",\"ADDRESS\":\"891 Myrl Pass Suite 669 South Aliyah, WV 09539-6270\",\"PHONE\":\"+1-427-368-5552\",\"TOKEN\":\"mkcr4\",\"EMAIL\":\"admin@luceat.solutions\",\"NAME\":\"Dexter\",\"SURNAME\":\"Bones\",\"USERNAME\":\"root\",\"ADMIN\":true,\"STAFF\":false,\"WORKING_HOURS\":[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}],\"PRIVILEGES\":[{\"ID\":\"1\",\"NAME\":\"Clients\",\"deger\":true},{\"ID\":\"2\",\"NAME\":\"Tickets\",\"deger\":true},{\"ID\":\"3\",\"NAME\":\"Reports\",\"deger\":true},{\"ID\":\"4\",\"NAME\":\"Options\",\"deger\":true},{\"ID\":\"5\",\"NAME\":\"Staff\",\"deger\":true},{\"ID\":\"6\",\"NAME\":\"SLA\",\"deger\":true},{\"ID\":\"7\",\"NAME\":\"Knowledge Base\",\"deger\":true}],\"$$hashKey\":\"object:437\"}],\"$$hashKey\":\"object:193\"},{\"ID\":2,\"NAME\":\"Violation Resolve\",\"DESCRIPTION\":\"Set escalation hierarchy when a ticket is not resolved on time\",\"ESCALATE\":\"2\",\"WARN_ASSIGNED\":true,\"INFORM\":[{\"ID\":\"2\",\"CLIENT_ID\":null,\"DEPARTMENT_ID\":\"1\",\"LANGUAGE\":\"\",\"ADDRESS\":\"51418 Huel Lights Apt. 610 Manleyside, MO 32071-7304\",\"PHONE\":\"+1 (301) 562-1122\",\"TOKEN\":\"615615\",\"EMAIL\":\"harper@luceat.solutions\",\"NAME\":\"Harper\",\"SURNAME\":\"Harris\",\"USERNAME\":\"harper\",\"ADMIN\":false,\"STAFF\":true,\"WORKING_HOURS\":[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}],\"PRIVILEGES\":[{\"ID\":\"1\",\"NAME\":\"Clients\",\"deger\":true},{\"ID\":\"2\",\"NAME\":\"Tickets\",\"deger\":true},{\"ID\":\"3\",\"NAME\":\"Reports\",\"deger\":\"\"},{\"ID\":\"4\",\"NAME\":\"Options\",\"deger\":\"\"},{\"ID\":\"5\",\"NAME\":\"Staff\",\"deger\":\"\"},{\"ID\":\"6\",\"NAME\":\"SLA\",\"deger\":true},{\"ID\":\"7\",\"NAME\":\"Knowledge Base\",\"deger\":\"\"}],\"$$hashKey\":\"object:464\"}],\"$$hashKey\":\"object:194\"}]', '[{\"ID\":1,\"NAME\":\"LOW\",\"OPERATIONAL_HOURSES\":1,\"DATA\":[{\"NAME\":\"RESPOND\",\"TIME\":10,\"PERIOD\":1,\"$$hashKey\":\"object:203\"},{\"NAME\":\"RESOLVE\",\"TIME\":10,\"PERIOD\":1,\"$$hashKey\":\"object:204\"}],\"$$hashKey\":\"object:183\"},{\"ID\":2,\"NAME\":\"MEDIUM\",\"OPERATIONAL_HOURSES\":1,\"DATA\":[{\"NAME\":\"RESPOND\",\"TIME\":10,\"PERIOD\":1,\"$$hashKey\":\"object:223\"},{\"NAME\":\"RESOLVE\",\"TIME\":10,\"PERIOD\":1,\"$$hashKey\":\"object:224\"}],\"$$hashKey\":\"object:184\"},{\"ID\":3,\"NAME\":\"HIGH\",\"OPERATIONAL_HOURSES\":1,\"DATA\":[{\"NAME\":\"RESPOND\",\"TIME\":10,\"PERIOD\":1,\"$$hashKey\":\"object:237\"},{\"NAME\":\"RESOLVE\",\"TIME\":10,\"PERIOD\":1,\"$$hashKey\":\"object:238\"}],\"$$hashKey\":\"object:185\"}]', '2022-03-26 06:01:05', '2022-04-13 02:48:30', 'true');

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

--
-- Dumping data for table `TICKETS`
--

INSERT INTO `TICKETS` (`ID`, `PARENT_ID`, `TOKEN`, `CLIENT`, `CREATED_DATE`, `USER_ID`, `SEEN_BY`, `SEEN_DATE`, `ASSIGNED_ID`, `ASSIGNED_DATE`, `CLOSER_ID`, `CLOSED_DATE`, `REPLIED_DATE`, `LAST_REPLY`, `SUBJECT`, `DETAIL`, `PRIORITY`, `SLA_POLICY`, `STATUS`, `CATEGORY_ID`, `DEPARTMENT_ID`, `PROCESS`, `SPAM`) VALUES
(1, 0, 'ce6106', '0b856b', '2022-04-13 16:30:30', 9, 1, '2022-04-13 16:31:18', 2, '2022-04-13 16:37:14', 1, '2022-04-21 07:04:41', '2022-04-13 16:37:14', '2022-04-21 07:04:09', 'Lorem ipsum dolor sit amet', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n', 1, 1, 4, 1, 1, 1, 'false'),
(2, NULL, '33a52d', '42cbb1', '2022-04-13 16:38:54', 10, 1, '2022-04-13 17:18:56', 1, '2022-04-13 17:19:10', 0, '0000-00-00 00:00:00', '2022-04-13 17:19:10', '2022-05-11 01:11:01', 'Excepteur sint occaecat cupidatat non proident', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n', 1, 2, 3, 1, 1, 0, 'true'),
(3, NULL, 'e9ad5b', '703dd6', '2022-04-13 16:39:42', 11, 1, '2022-04-13 16:42:23', 1, '2022-05-08 23:40:23', 0, '0000-00-00 00:00:00', '2022-04-13 17:17:49', '2022-04-13 17:17:49', 'Urna id volutpat lacus laoreet', 'Mattis vulputate enim nulla aliquet porttitor. Lorem ipsum dolor sit amet consectetur adipiscing elit pellentesque habitant. Eget gravida cum sociis natoque penatibus. Sit amet nisl suscipit adipiscing bibendum est ultricies integer. Nunc pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Urna id volutpat lacus laoreet. Purus non enim praesent elementum. Consectetur a erat nam at lectus urna duis convallis. Convallis aenean et tortor at risus viverra adipiscing at. Fringilla ut morbi tincidunt augue. Odio tempor orci dapibus ultrices in iaculis nunc sed augue.\n', 2, 0, 3, 1, 2, 4, 'false'),
(4, NULL, '314429', '42bbb4', '2022-04-13 16:40:25', 12, 1, '2022-04-13 17:14:41', 3, '2022-04-13 17:15:59', 3, '2022-04-13 17:16:57', '2022-04-13 17:15:59', '2022-04-13 17:16:25', 'Facilisis volutpat est velit egestas dui id', 'Vulputate sapien nec sagittis aliquam malesuada bibendum. Ut aliquam purus sit amet luctus venenatis lectus magna. Congue mauris rhoncus aenean vel. Ut faucibus pulvinar elementum integer enim. Pretium fusce id velit ut tortor. Non nisi est sit amet facilisis magna etiam tempor orci. Facilisis volutpat est velit egestas dui id. Arcu ac tortor dignissim convallis aenean. Facilisi morbi tempus iaculis urna id volutpat. Fermentum odio eu feugiat pretium nibh ipsum consequat.\n', 3, 0, 4, 1, 4, 19, 'false'),
(5, NULL, '6ac44c', '691115', '2022-04-13 16:41:50', 13, 1, '2022-04-13 17:29:55', 1, '2022-04-13 17:34:59', 0, '0000-00-00 00:00:00', '2022-04-13 17:34:59', '2022-04-13 17:35:29', 'Gravida dictum fusce ut placerat', 'Viverra vitae congue eu consequat ac felis. Praesent semper feugiat nibh sed pulvinar proin gravida. Aliquam ultrices sagittis orci a scelerisque purus. Sapien nec sagittis aliquam malesuada bibendum arcu vitae. Aliquam eleifend mi in nulla. Lacinia quis vel eros donec ac odio tempor. Ullamcorper morbi tincidunt ornare massa eget egestas purus viverra accumsan. Tellus elementum sagittis vitae et leo duis ut. Non odio euismod lacinia at quis. Eget lorem dolor sed viverra. Leo integer malesuada nunc vel risus commodo viverra maecenas. Leo urna molestie at elementum. Enim facilisis gravida neque convallis. Gravida dictum fusce ut placerat. Feugiat sed lectus vestibulum mattis ullamcorper velit.\n', 2, 0, 3, 1, 5, 0, 'false'),
(6, 11, 'e7ca47', '59a1c8', '2022-04-13 17:37:10', 14, 1, '2022-04-14 01:09:04', 6, '2022-04-14 02:19:56', 1, '2022-04-23 03:42:37', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'Ullamcorper sit amet risus nullam eget', 'Id cursus metus aliquam eleifend mi in nulla posuere sollicitudin. Amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus et. Cursus vitae congue mauris rhoncus aenean. Id nibh tortor id aliquet. Tincidunt lobortis feugiat vivamus at augue. Netus et malesuada fames ac turpis egestas. Ullamcorper sit amet risus nullam eget. Tristique senectus et netus et malesuada fames ac. Pulvinar elementum integer enim neque volutpat ac tincidunt. Mauris commodo quis imperdiet massa tincidunt nunc pulvinar sapien et. Quis varius quam quisque id diam vel. Augue eget arcu dictum varius duis at consectetur lorem. Massa sed elementum tempus egestas sed sed risus. Porta non pulvinar neque laoreet suspendisse interdum consectetur libero id. Sed libero enim sed faucibus turpis in eu mi. Vulputate enim nulla aliquet porttitor lacus luctus. Euismod elementum nisi quis eleifend quam adipiscing vitae proin. In egestas erat imperdiet sed.\n', 1, 0, 4, 1, 1, 1, 'false'),
(7, NULL, '04ca21', '090937', '2022-04-13 17:39:35', 17, 1, '2022-04-13 18:20:18', NULL, NULL, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'Phasellus vestibulum lorem sed risus ultricies', 'Arcu felis bibendum ut tristique et. Malesuada proin libero nunc consequat interdum varius sit amet mattis. Consectetur a erat nam at lectus urna duis convallis convallis. Est placerat in egestas erat imperdiet sed euismod nisi porta.\n', 2, 0, 1, 1, 4, 0, 'false'),
(8, NULL, 'ee6402', '3e6c69', '2022-04-14 02:29:16', 15, 1, '2022-04-14 03:46:10', 1, '2022-04-17 19:12:24', 0, '0000-00-00 00:00:00', '2022-04-17 19:12:24', '2022-04-17 19:12:24', 'Malesuada fames ac turpis egestas', 'Sem integer vitae justo eget magna fermentum iaculis eu non. Egestas egestas fringilla phasellus faucibus scelerisque eleifend. Nunc scelerisque viverra mauris in aliquam sem. Quam quisque id diam vel quam elementum pulvinar. Netus et malesuada fames ac turpis. Aliquam ultrices sagittis orci a. Ac ut consequat semper viverra nam libero justo. Ultrices sagittis orci a scelerisque purus semper eget duis at. Sed risus pretium quam vulputate. Nec nam aliquam sem et.\n', 1, 0, 3, 1, 1, 9, 'false'),
(9, NULL, '3c77aa', '0b856b', '2022-04-14 03:58:49', 9, 1, '2022-04-14 03:59:44', 1, '2022-04-14 04:00:36', 0, '0000-00-00 00:00:00', '2022-04-14 04:00:36', '2022-04-20 04:01:31', 'Nunc non blandit massa enim', 'Vitae tortor condimentum lacinia quis vel eros donec. Massa massa ultricies mi quis hendrerit. Volutpat diam ut venenatis tellus in metus. Amet nulla facilisi morbi tempus iaculis urna id. Mauris sit amet massa vitae tortor condimentum. Mattis enim ut tellus elementum. Ullamcorper velit sed ullamcorper morbi tincidunt. Posuere morbi leo urna molestie at elementum eu facilisis. Volutpat ac tincidunt vitae semper quis lectus. Pretium nibh ipsum consequat nisl vel pretium lectus. Porttitor lacus luctus accumsan tortor. Ornare arcu odio ut sem. Elementum nibh tellus molestie nunc non blandit massa enim nec. Suspendisse faucibus interdum posuere lorem ipsum. Elit eget gravida cum sociis natoque penatibus et magnis dis. Lectus magna fringilla urna porttitor rhoncus dolor purus.\n', 1, 1, 3, 1, 1, 1, 'false'),
(10, 9, 'BT77NFG', '0b856b', '2022-04-14 03:58:49', 9, 1, '2022-04-14 03:59:44', 1, '2022-04-14 04:00:36', 1, '2022-04-21 07:06:04', '2022-04-14 04:00:36', '2022-04-20 04:01:31', 'Nunc non blandit massa enim', 'Vitae tortor condimentum lacinia quis vel eros donec. Massa massa ultricies mi quis hendrerit. Volutpat diam ut venenatis tellus in metus. Amet nulla facilisi morbi tempus iaculis urna id. Mauris sit amet massa vitae tortor condimentum. Mattis enim ut tellus elementum. Ullamcorper velit sed ullamcorper morbi tincidunt. Posuere morbi leo urna molestie at elementum eu facilisis. Volutpat ac tincidunt vitae semper quis lectus. Pretium nibh ipsum consequat nisl vel pretium lectus. Porttitor lacus luctus accumsan tortor. Ornare arcu odio ut sem. Elementum nibh tellus molestie nunc non blandit massa enim nec. Suspendisse faucibus interdum posuere lorem ipsum. Elit eget gravida cum sociis natoque penatibus et magnis dis. Lectus magna fringilla urna porttitor rhoncus dolor purus.\r\n', 1, 1, 4, 1, 1, 1, 'false'),
(11, NULL, 'd46c74', '59a1c8', '2022-04-23 01:42:02', 14, 1, '2022-04-23 01:42:29', 1, '2022-04-23 06:09:59', 1, '2022-05-08 23:16:04', '2022-04-23 06:09:59', '2022-05-11 01:11:51', 'Ullamcorper sit amet risus nullam eget', 'Id cursus metus aliquam eleifend mi in nulla posuere sollicitudin. Amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus et. Cursus vitae congue mauris rhoncus aenean. Id nibh tortor id aliquet. Tincidunt lobortis feugiat vivamus at augue. Netus et malesuada fames ac turpis egestas. Ullamcorper sit amet risus nullam eget. Tristique senectus et netus et malesuada fames ac. Pulvinar elementum integer enim neque volutpat ac tincidunt. Mauris commodo quis imperdiet massa tincidunt nunc pulvinar sapien et. Quis varius quam quisque id diam vel. Augue eget arcu dictum varius duis at consectetur lorem. Massa sed elementum tempus egestas sed sed risus. Porta non pulvinar neque laoreet suspendisse interdum consectetur libero id. Sed libero enim sed faucibus turpis in eu mi. Vulputate enim nulla aliquet porttitor lacus luctus. Euismod elementum nisi quis eleifend quam adipiscing vitae proin. In egestas erat imperdiet sed.\n', 1, 0, 4, 1, 1, 1, 'false');

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

--
-- Dumping data for table `TOKENS`
--

INSERT INTO `TOKENS` (`ID`, `TOKEN`, `USER_ID`, `DATE`) VALUES
(0, 'de56c3384223446f8d12494776a227', 1, '2022-04-12'),
(0, 'fd5a192ec643de78ea3f5675f54832', 1, '2022-04-12'),
(0, 'e93b2fb6f952e5d40770399bb90773', 1, '2022-04-12'),
(0, '440833a23b39cd70e01b3e7db0f8af', 1, '2022-04-12'),
(0, 'a342cc36aa15899afbe08164b1a221', 1, '2022-04-12'),
(0, '484d76ef773f149478537402372ae9', 1, '2022-04-12'),
(0, 'd04eb3a5976b5749fd6eaa4e0f1291', 1, '2022-04-12'),
(0, 'baafc28cf32f09057a2516654fc6ec', 1, '2022-04-12'),
(0, 'f6066563d5db5e037407fccbdf0bf2', 1, '2022-04-12'),
(0, 'c87f2161fe917d8bb10bb092b71405', 1, '2022-04-12'),
(0, 'efb87e5d7f9ded6dda52526fb7959d', 1, '2022-04-12'),
(0, '8d218ab77052eb96980b29aee881ab', 1, '2022-04-12'),
(0, 'a5c1d6e97e278389b9923c235bfc74', 10, '2022-05-09'),
(0, '17e9b2fcfeefbf84beb4c6cf9f1e5e', 10, '2022-05-09');

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
(1, 'mkcr4', NULL, 'Dexter', 'Bones', 'admin@luceat.solutions', '+1-427-368-5552', '891 Myrl Pass Suite 669 South Aliyah, WV 09539-6270', 'true', 'false', 1, 'en_US', 'root', '$2y$10$5WE8N45AriF.90CV/zmS/.h8cOqixiwuAdc3VHBTWj2d6P7q5nV9G', '', '[{ \"PATH\": \"tickets\", \"PRIVILAGES\": { \"CREATE\": true, \"READ\": true, \"UPDATE\": true, \"DELETE\": true } }, { \"PATH\": \"clients\", \"PRIVILAGES\": { \"CREATE\": true, \"READ\": true, \"UPDATE\": true, \"DELETE\": true } }]', 'true'),
(2, '615615', NULL, 'Harper', 'Harris', 'harper@luceat.solutions', '+1 (301) 562-1122', '51418 Huel Lights Apt. 610 Manleyside, MO 32071-7304', 'false', 'true', 1, 'en_US', 'harper', '$2y$10$SEv/bzaZI.KEDtJQuixFSuaNRidu00i2WtcJwk/PpE.h3UD4UgInK', '', '', 'true'),
(3, 'f8fa23', NULL, 'Rebecca', 'Hill', 'rebecca@luceat.solutions', '(789) 589-3507', '1695 Darius Via Dougburgh, IA 58568-5144', 'false', 'true', 1, 'en_US', 'rebecca', '$2y$10$K5KiRYv0kQfg5dOI5DwY9.JPOe3NVIh1IQiRx4PsqfDVJdFC5j6XW', '', '', 'true'),
(4, 'b60d40', NULL, 'Christopher', 'Harris', 'christopher@luceat.solutions', '+1 (858) 542-7744', '59327 Dare Route Apt. 203 New Abdielport, AZ 68733', 'false', 'true', 2, 'en_US', 'christopher', '$2y$10$YZDsakSALOj5K4HCcNKaFeNYrMkTh601UmduptOfvCW.FWGHOFV8S', '', '', 'true'),
(5, 'a0295a', NULL, 'Bradley', 'Mccarty', 'bradley@luceat.solutions', '+1 (719) 876-8103', '56749 Jacobi Landing Suite 872 Port Aliviafort, WY 64070-8782', 'false', 'true', 3, 'en_US', 'bradley', '$2y$10$wBceAn7P6W0W2yG2dAgeuOjZdYl0aXO59jEqiDeVpQ7NERDYW62/O', '', '', 'true'),
(6, 'e98992', NULL, 'Camden', 'Lambert', 'camden@luceat.solutions', '+1-436-989-6495', '406 Price Unions Apt. 117 Langworthmouth, NM 11355-5076', 'false', 'true', 3, 'en_US', 'camden', '$2y$10$zzPtY.1RvH7qcgytfbYuFOP/BdfjmoGxvjj3g8HT7PxoEKKUdPFzi', '', '', 'true'),
(7, '60dc8c', NULL, 'Alessandra', 'Garcia', 'alessandra@luceat.solutions', '+1-591-793-4043', '17043 Graham Orchard West Wayne, UT 12933', 'false', 'true', 4, 'en_US', 'alessandra', '$2y$10$iQZya17FQn/RwSFhiMWNIuw/Jyo99gKan9Arm6TGmikSTfxmPQYxG', '', '', 'true'),
(8, 'fc963a', NULL, 'Vivienne', 'Phillips', 'vivienne@luceat.solutions', '+1-843-204-0310', '67715 Zboncak Orchard Verdamouth, KS 56691-4430', 'false', 'true', 0, 'en_US', 'vivienne', '$2y$10$jF4IVTUgpHwawHBmDyGy2uFJtI31xEn55.P1/A8fiicMKsD6XuvP6', '', '', 'true'),
(9, '0b856b', NULL, 'Juniper', 'Mulder', 'juniper@example.com', '1-931-626-4884', '3577 Raul Brook East Leeton, TN 98210-5015', 'false', 'false', 0, 'en_US', 'juniper', '$2y$10$EfOh34Pqb/9cdGIaDKtCHuIDgtEMtg7a4bUcKUtu0p2opfrg2Vc2u', '', '', 'true'),
(10, '42cbb1', NULL, 'Oscar', 'Berry', 'abaris@null.net', '1-950-618-0048', '9259 Dooley Crossing Suite 386 East Colemanchester, CO 48547', 'false', 'false', 0, 'en_US', 'oscar', '$2y$10$y.lXTTwGnlLIKqpNabhzduWIRUkfTFxo1r0e0KUFoiyvdK4UVPvqC', '', '', 'true'),
(11, '703dd6', NULL, 'Carson', 'Ramos', 'carson@example.com', '+1-345-325-6348', '83533 Yost Center Suite 375 Christiansenville, OR 88969-8598', 'false', 'false', 0, 'en_US', 'carson', '$2y$10$SQVd23iye2ZPvhZRI1fJION04sfn8UDhIngugQyXMuKhftkW4NcYq', '', '', 'true'),
(12, '42bbb4', NULL, 'Daniel', 'Robinson', 'daniel@example.com', '+1 (838) 900-1364', '1590 Chanelle Path Lake Hertaland, CA 51960', 'false', 'false', 0, 'en_US', 'daniel', '$2y$10$O6e3frRHN7gT7RUQA/Hc4uYDVj0LXb.wvHGh4G3KlY6J6chpJ3vfe', '', '', 'true'),
(13, '691115', NULL, 'Callie', 'Mills', 'callie@example.com', '+1-797-327-9250', '99315 Giovanna Shore East Kelsi, CT 76683-1879', 'false', 'false', 0, 'en_US', 'callie', '$2y$10$Ni7fvn8SQgJTuQKZIP5QNOZEArZt4QyD0U7VZ09pWa8Z8uB0DTnfa', '', '', 'true'),
(14, '59a1c8', NULL, 'Naomi', 'Adams', 'naomi@example.com', '+1-476-786-2352', '441 Diana Land Ernestinaport, OR 66455-1192', 'false', 'false', 0, 'en_US', 'naomi', '$2y$10$Rq/.hPciFUNSADSKjMK1QeDChayr/16uUYtR80frnVWPd3fReqY1u', '', '', 'true'),
(15, '3e6c69', NULL, 'Demi', 'Schultz', 'demi@example.com', '1-963-849-9355', '93354 Romaguera Point Suite 564 East Douglashaven, NE 54937-0002', 'false', 'false', 0, 'en_US', 'demi', '$2y$10$RN.i9PmdAhRIOzPZY/C6vumcP0WabO7eoYuXD0dubXDxgIPd/38eC', '', '', 'true'),
(16, '66e818', NULL, 'Auguste', 'Schulte', 'auguste@example.com', '+49(0)2590 499978', 'Rosalinde-Hanke-Ring 8/8 13331 Neu-Ulm', 'false', 'false', 0, 'en_US', 'auguste', '$2y$10$a/7o4k.tn9m3N3eu/aasLu4D6Yl.L/DHEn1swDlwpA6ZGJzQJoafC', '', '', 'true'),
(17, '090937', NULL, 'Cäcilie', 'Dietrich', 'cacilie@example.com', '+49(0)0222 076670', 'Ortwin-Voigt-Platz 1a 71446 Haren (Ems)', 'false', 'false', 0, 'en_US', 'cacilie', '$2y$10$Gu6/PKrTbC2h3ycX8eGkcONDQxTKM0o3npX9w/PBnFmay16zuoGXa', '', '', 'true'),
(18, '39821b', '0b856b', 'Jordyn', 'Holmes', 'Jordyn@example.com', '952-367-6889 x898', '523 Florencio Coves Suite 423 Jaimemouth, MT 70671-5522', 'false', 'false', NULL, 'en_US', 'Jordyn', '$2y$10$WwLNz5toONP79.YxZ9GoB.WUEFNKe3VCyEiuJ8QKqTiggiw6CDLCe', '', '', 'true'),
(19, '374766', '0b856b', 'Kayson', 'Watkins', 'kayson@example.com', '1-506-854-0685 x6660', '893 Vella Village Suite 028 West Brigitteland, CA 86079', 'false', 'false', NULL, 'en_US', 'kayson', '$2y$10$mL303wJ4/.wEcSiM2fx5nufFStT9EN0.Kl78idQy6ZAOD66pJjrQm', '', '', 'true'),
(20, '4a981b', '0b856b', 'Knox', 'Jones', 'knox@example.com', '+1-538-304-6796', '94254 Wilderman Lodge Cummerataville, MS 96062', 'false', 'false', NULL, 'en_US', 'knox', '$2y$10$4Uz75AUopg82H/9EcBspZuXxK9KgS.zdiNivmG5Lj5Z5k94h0QFLi', '', '', 'true'),
(21, 'f84081', '0b856b', 'Zara', 'Long', 'zara@example.com', '+1 (490) 220-8862', '88699 Vandervort Island Suite 404 Douglasstad, IA 61668', 'false', 'false', NULL, 'en_US', 'zara', '$2y$10$FzPZz2zzJu4z5RNzXkRUHucplWl9ToCcU/f6iFymdTx/b0JCFdnqO', '', '', 'true'),
(22, '975011', '0b856b', 'Gwendolyn', 'Hill', 'gwendolyn@example.com', '+1 (490) 220-8862', '955 Rosa Ways Ernestoside, ID 70965-7637', 'false', 'false', NULL, 'en_US', 'gwendolyn', '$2y$10$Bh6V/aKgyrUVhKxgRDaIAu1bUcTPhaNskdnh8u/O4duSj1MaNnXn6', '', '', 'true');

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
(1, 1, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(2, 2, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(3, 3, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(4, 4, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(5, 5, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(6, 6, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(7, 7, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(8, 8, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(9, 9, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(10, 10, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(11, 11, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(12, 12, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(13, 13, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(14, 14, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(15, 15, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(16, 16, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(17, 17, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(18, 18, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(19, 19, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(20, 20, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(21, 21, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]'),
(22, 22, '[{\"DAY\":\"monday\",\"END\":\"19:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:360\"},{\"DAY\":\"tuesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:361\"},{\"DAY\":\"wednesday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:362\"},{\"DAY\":\"thursday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:363\"},{\"DAY\":\"friday\",\"END\":\"18:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"15:00\",\"START\":\"14:30\"},\"STATUS\":true,\"$$hashKey\":\"object:364\"},{\"DAY\":\"saturday\",\"END\":\"13:00\",\"START\":\"09:00\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":true,\"$$hashKey\":\"object:365\"},{\"DAY\":\"sunday\",\"END\":\"\",\"START\":\"\",\"BREAKS\":{\"END\":\"\",\"START\":\"\"},\"STATUS\":false,\"$$hashKey\":\"object:366\"}]');

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `ARTICLE_CATEGORIES`
--
ALTER TABLE `ARTICLE_CATEGORIES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `CANNED_RESPONSES`
--
ALTER TABLE `CANNED_RESPONSES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `CONVERSATIONS`
--
ALTER TABLE `CONVERSATIONS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `CUSTOM_FIELDS`
--
ALTER TABLE `CUSTOM_FIELDS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `CUSTOM_FIELD_DATA`
--
ALTER TABLE `CUSTOM_FIELD_DATA`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `DEPARTMENTS`
--
ALTER TABLE `DEPARTMENTS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `FILES`
--
ALTER TABLE `FILES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `LOGS`
--
ALTER TABLE `LOGS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT for table `NOTES`
--
ALTER TABLE `NOTES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `NOTIFICATIONS`
--
ALTER TABLE `NOTIFICATIONS`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `SLA_POLICIES`
--
ALTER TABLE `SLA_POLICIES`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `SLA_VIOLATIONS`
--
ALTER TABLE `SLA_VIOLATIONS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `TICKETS`
--
ALTER TABLE `TICKETS`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
