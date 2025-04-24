-- Create the database (optional, since we already set MYSQL_DATABASE)
CREATE DATABASE IF NOT EXISTS mydatabase;

-- Switch to the database
USE mydatabase;
-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mydb
-- Erstellungszeit: 03. Apr 2025 um 09:17
-- Server-Version: 11.7.2-MariaDB-ubu2404
-- PHP-Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `TaskSphere`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Attachments`
--

CREATE TABLE `Attachments` (
  `id` int(11) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_url` text NOT NULL,
  `uploaded_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `BoardAttachments`
--

CREATE TABLE `BoardAttachments` (
  `attachment_id` int(11) NOT NULL,
  `board_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `BoardComments`
--

CREATE TABLE `BoardComments` (
  `comment_id` int(11) NOT NULL,
  `board_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Boards`
--

CREATE TABLE `Boards` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Comments`
--

CREATE TABLE `Comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Groups`
--

CREATE TABLE `Groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Labels`
--

CREATE TABLE `Labels` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `color` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `TaskAttachments`
--

CREATE TABLE `TaskAttachments` (
  `attachment_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `TaskComments`
--

CREATE TABLE `TaskComments` (
  `comment_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `TaskLabels`
--

CREATE TABLE `TaskLabels` (
  `task_id` int(11) NOT NULL,
  `label_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Tasks`
--

CREATE TABLE `Tasks` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `board_id` int(11) NOT NULL,
  `assigned_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `TaskToDoItems`
--

CREATE TABLE `TaskToDoItems` (
  `id` int(11) NOT NULL,
  `list_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `TaskToDoLists`
--

CREATE TABLE `TaskToDoLists` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `UserGroups`
--

CREATE TABLE `UserGroups` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `role` enum('Admin','Member') DEFAULT 'Member'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Users`
--

CREATE TABLE `Users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `Attachments`
--
ALTER TABLE `Attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indizes für die Tabelle `BoardAttachments`
--
ALTER TABLE `BoardAttachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `board_id` (`board_id`);

--
-- Indizes für die Tabelle `BoardComments`
--
ALTER TABLE `BoardComments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `board_id` (`board_id`);

--
-- Indizes für die Tabelle `Boards`
--
ALTER TABLE `Boards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `Comments`
--
ALTER TABLE `Comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `Groups`
--
ALTER TABLE `Groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indizes für die Tabelle `Labels`
--
ALTER TABLE `Labels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indizes für die Tabelle `TaskAttachments`
--
ALTER TABLE `TaskAttachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `task_id` (`task_id`);

--
-- Indizes für die Tabelle `TaskComments`
--
ALTER TABLE `TaskComments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `task_id` (`task_id`);

--
-- Indizes für die Tabelle `TaskLabels`
--
ALTER TABLE `TaskLabels`
  ADD PRIMARY KEY (`task_id`,`label_id`),
  ADD KEY `label_id` (`label_id`);

--
-- Indizes für die Tabelle `Tasks`
--
ALTER TABLE `Tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `board_id` (`board_id`),
  ADD KEY `assigned_user_id` (`assigned_user_id`);

--
-- Indizes für die Tabelle `TaskToDoItems`
--
ALTER TABLE `TaskToDoItems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `list_id` (`list_id`);

--
-- Indizes für die Tabelle `TaskToDoLists`
--
ALTER TABLE `TaskToDoLists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_id` (`task_id`);

--
-- Indizes für die Tabelle `UserGroups`
--
ALTER TABLE `UserGroups`
  ADD PRIMARY KEY (`user_id`,`group_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indizes für die Tabelle `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `Attachments`
--
ALTER TABLE `Attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Boards`
--
ALTER TABLE `Boards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Comments`
--
ALTER TABLE `Comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Groups`
--
ALTER TABLE `Groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Labels`
--
ALTER TABLE `Labels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Tasks`
--
ALTER TABLE `Tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `TaskToDoItems`
--
ALTER TABLE `TaskToDoItems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `TaskToDoLists`
--
ALTER TABLE `TaskToDoLists`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `Attachments`
--
ALTER TABLE `Attachments`
  ADD CONSTRAINT `Attachments_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `Users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `BoardAttachments`
--
ALTER TABLE `BoardAttachments`
  ADD CONSTRAINT `BoardAttachments_ibfk_1` FOREIGN KEY (`attachment_id`) REFERENCES `Attachments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `BoardAttachments_ibfk_2` FOREIGN KEY (`board_id`) REFERENCES `Boards` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `BoardComments`
--
ALTER TABLE `BoardComments`
  ADD CONSTRAINT `BoardComments_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `Comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `BoardComments_ibfk_2` FOREIGN KEY (`board_id`) REFERENCES `Boards` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Boards`
--
ALTER TABLE `Boards`
  ADD CONSTRAINT `Boards_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Boards_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Comments`
--
ALTER TABLE `Comments`
  ADD CONSTRAINT `Comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `TaskAttachments`
--
ALTER TABLE `TaskAttachments`
  ADD CONSTRAINT `TaskAttachments_ibfk_1` FOREIGN KEY (`attachment_id`) REFERENCES `Attachments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `TaskAttachments_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `Tasks` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `TaskComments`
--
ALTER TABLE `TaskComments`
  ADD CONSTRAINT `TaskComments_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `Comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `TaskComments_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `Tasks` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `TaskLabels`
--
ALTER TABLE `TaskLabels`
  ADD CONSTRAINT `TaskLabels_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `Tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `TaskLabels_ibfk_2` FOREIGN KEY (`label_id`) REFERENCES `Labels` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `Tasks`
--
ALTER TABLE `Tasks`
  ADD CONSTRAINT `Tasks_ibfk_1` FOREIGN KEY (`board_id`) REFERENCES `Boards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Tasks_ibfk_2` FOREIGN KEY (`assigned_user_id`) REFERENCES `Users` (`id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `TaskToDoItems`
--
ALTER TABLE `TaskToDoItems`
  ADD CONSTRAINT `TaskToDoItems_ibfk_1` FOREIGN KEY (`list_id`) REFERENCES `TaskToDoLists` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `TaskToDoLists`
--
ALTER TABLE `TaskToDoLists`
  ADD CONSTRAINT `TaskToDoLists_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `Tasks` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `UserGroups`
--
ALTER TABLE `UserGroups`
  ADD CONSTRAINT `UserGroups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `UserGroups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- Insert some sample data
INSERT INTO Users (username, email, password_hash) VALUES ('Maiko0', 'maiko@maiko.de', "123");
INSERT INTO Users (username, email, password_hash) VALUES ('bernd', 'bernd@bernd.de', "123231d");