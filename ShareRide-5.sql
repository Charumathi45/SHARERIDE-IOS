-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 25, 2025 at 07:50 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ShareRide`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_signup`
--

CREATE TABLE `admin_signup` (
  `id` int(11) NOT NULL,
  `admin_id` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `confirm_password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_signup`
--

INSERT INTO `admin_signup` (`id`, `admin_id`, `email`, `password`, `confirm_password`) VALUES
(1, 'admin123', 'admin123@gmail.com', '123admin', '123admin'),
(2, 'admin001', 'admin@example.com', 'admin123', 'admin123'),
(3, '65', 'xyz@gmail.com', 'clock', 'clock'),
(4, 'admin90', 'Charu14@gmail.com', 'admin123', 'admin123'),
(5, 'admin78', 'Vanshika@gmail.com', 'admin123', 'admin123'),
(6, '34', 'Harshita@gmail.com', '1234567', '1234567'),
(7, 'admin23', 'varshinie@gmail.com', 'v', 'v'),
(8, '04', 'sant@gmail.com', 's', 's'),
(9, '1405', 'charu1405@gmail.com', '12345', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `availableriderequest`
--

CREATE TABLE `availableriderequest` (
  `id` int(11) NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `from_location` varchar(100) DEFAULT NULL,
  `to_location` varchar(100) DEFAULT NULL,
  `driver_name` varchar(100) DEFAULT NULL,
  `seats` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `is_full` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `availableriderequest`
--

INSERT INTO `availableriderequest` (`id`, `departure_time`, `arrival_time`, `from_location`, `to_location`, `driver_name`, `seats`, `price`, `is_full`) VALUES
(1, '13:30:00', '13:20:00', 'velacherry', 'chrompt', 'sanjay', 5, 200, 0),
(2, '13:30:00', '13:20:00', 'velacherry', 'chrompt', 'dhanush', 7, 200, 0),
(3, '13:30:00', '13:20:00', 'velacherry', 'chrompt', 'dhanush', 7, 200, 0),
(4, '13:30:00', '13:20:00', 'velacherry', 'chrompt', 'dhanush', 7, 200, 0),
(5, '13:30:00', '13:20:00', 'velacherry', 'chrompt', 'dhanush', 7, 200, 0),
(6, '13:30:00', '13:20:00', 'velacherry', 'chrompt', 'dhanush', 7, 200, 0),
(7, '13:30:00', '13:20:00', 'velacherry', 'chrompt', 'dhanush', 7, 200, 0),
(8, '13:30:00', '13:20:00', 'velacherry', 'chrompt', 'dhanush', 7, 200, 0);

-- --------------------------------------------------------

--
-- Table structure for table `booking_page`
--

CREATE TABLE `booking_page` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_location` varchar(255) DEFAULT NULL,
  `to_location` varchar(255) DEFAULT NULL,
  `departure_address` text DEFAULT NULL,
  `arrival_address` text DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `fare` decimal(10,2) DEFAULT NULL,
  `seats_available` int(11) DEFAULT NULL,
  `driver_name` varchar(100) DEFAULT NULL,
  `driver_rating` float DEFAULT NULL,
  `driver_verified` tinyint(1) DEFAULT NULL,
  `boot_space` varchar(100) DEFAULT NULL,
  `car_model` varchar(100) DEFAULT NULL,
  `booking_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking_page`
--

INSERT INTO `booking_page` (`booking_id`, `user_id`, `from_location`, `to_location`, `departure_address`, `arrival_address`, `duration`, `fare`, `seats_available`, `driver_name`, `driver_rating`, `driver_verified`, `boot_space`, `car_model`, `booking_time`) VALUES
(70, 2, 'Porur', 'Velachery', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 30.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-11 08:13:25'),
(71, 2, 'Hosur', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 500.00, 1, '2', 5, 1, 'yes', 'Car', '2025-08-11 09:05:51'),
(72, 2, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 150.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-12 03:04:55'),
(73, 1, 'velacherry', 'chrompt', 'pvr, velacherry', 'cross street, chrompt', '1.3m', 200.00, 2, 'Sanjay', 2.8, 1, 'limited boot space', 'tata', '2025-08-12 03:12:37'),
(74, 2, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 150.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-12 04:20:04'),
(75, 2, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 150.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-12 07:05:44'),
(76, 2, 'Tiruttani', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 30.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-12 07:20:11'),
(77, 2, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 150.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-12 09:50:13'),
(78, 2, 'Tiruttani', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 30.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-12 10:34:02'),
(79, 19, 'Marina beach, chennai', 'T nagar, chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 20.00, 1, '2', 5, 1, 'yes', 'Car', '2025-08-13 04:01:23'),
(80, 2, 'Marina beach, chennai', 'T nagar, chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 20.00, 1, '2', 5, 1, 'yes', 'Car', '2025-08-13 04:16:40'),
(81, 2, 'Marina beach, chennai', 'T nagar, chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 20.00, 1, '2', 5, 1, 'yes', 'Car', '2025-08-13 08:28:04'),
(82, 2, 'Vellore ', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 100.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-14 05:45:16'),
(83, 20, 'Marina beach, chennai', 'Saveetha college , Thandalam', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 50.00, 3, '2', 5, 1, 'yes', 'Car', '2025-08-14 08:40:55'),
(84, 2, 'Marina beach, chennai', 'Saveetha college , Thandalam', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 50.00, 3, '2', 5, 1, 'yes', 'Car', '2025-08-14 08:51:43'),
(85, 2, 'Chittlapakkam,chennai', 'Saveetha college, Thandalam ', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 40.00, 1, '2', 5, 1, 'yes', 'Car', '2025-08-18 02:56:58'),
(86, 2, 'Chennai', 'Vellore', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 100.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-19 05:00:13'),
(87, 2, 'Thirumazhisai', 'Saveetha college ,thandalam', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 30.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-21 09:33:20'),
(88, 2, 'Vadapalani', 'Mangadu', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 200.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-22 03:59:37'),
(89, 2, 'Vadapalani', 'Mangadu', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 200.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-22 03:59:45'),
(90, 2, 'Chennai', 'Velacherry', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-22 04:35:50'),
(91, 2, 'Chennai', 'Coimbatore', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-25 08:37:18'),
(92, 2, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '2', 5, 1, 'yes', 'Car', '2025-08-30 03:02:32'),
(93, 3, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-01 05:27:34'),
(94, 2, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-01 05:29:35'),
(95, 3, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-01 05:35:50'),
(96, 3, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-01 05:42:29'),
(97, 3, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-01 05:44:14'),
(98, 3, 'Chennai', 'Coimbatore', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '2', 5, 1, 'yes', 'Car', '2025-09-01 09:17:20'),
(99, 3, 'Madurai', 'Vadapalani', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 100.00, 2, '2', 5, 1, 'yes', 'Car', '2025-09-03 03:11:39'),
(100, 3, 'Coimbatore', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 100.00, 2, '2', 5, 1, 'yes', 'Car', '2025-09-03 04:54:22'),
(101, 2, 'Bangalore', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 100.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-03 07:58:07'),
(102, 2, 'Chennai', 'Dugdh', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '2', 5, 1, 'yes', 'Car', '2025-09-03 09:34:17'),
(103, 2, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 100.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-04 03:26:02'),
(104, 17, 'Trichy', 'Chennai', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 100.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-04 03:52:23'),
(105, 3, '11', '1', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 1.00, 1, '22', 5, 1, 'yes', 'Car', '2025-09-04 04:03:53'),
(106, 3, '11', '1', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 1.00, 1, '22', 5, 1, 'yes', 'Car', '2025-09-04 04:04:57'),
(107, 3, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-04 05:29:00'),
(108, 3, 'Chennai', 'Tiruttani', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '2', 5, 1, 'yes', 'Car', '2025-09-06 05:22:23'),
(109, 2, 'Chennai', 'Tiruttani', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '2', 5, 1, 'yes', 'Car', '2025-09-06 09:18:19'),
(110, 3, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 04:45:03'),
(111, 3, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 04:55:31'),
(112, 3, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 05:57:47'),
(113, 3, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 06:01:45'),
(114, 3, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 06:06:43'),
(115, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 06:11:29'),
(116, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 07:28:35'),
(117, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 07:32:13'),
(118, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 07:36:18'),
(119, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 07:37:38'),
(120, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 07:50:24'),
(121, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 07:55:59'),
(122, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 08:18:39'),
(123, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 08:25:04'),
(124, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-08 08:30:05'),
(125, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 200.00, 2, '2', 5, 1, 'yes', 'Car', '2025-09-10 06:31:46'),
(126, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 200.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-11 07:49:35'),
(127, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 200.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-11 07:49:48'),
(128, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 200.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-13 07:52:43'),
(129, 2, 'Chennai', 'Trichy', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 200.00, 2, '3', 5, 1, 'yes', 'Car', '2025-09-13 08:06:12'),
(130, 3, 'Saveetha university', 'Koyambedu', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-17 03:53:11'),
(131, 2, 'Saveetha university', 'Koyambedu', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-17 04:04:22'),
(132, 2, 'Saveetha university', 'Koyambedu', 'No address', 'arrival address', 'Min 2 hr Max 7 hr', 0.00, 1, '2', 5, 1, 'yes', 'Car', '2025-09-17 04:04:34');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('pending','resolved','reported') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_profiles`
--

CREATE TABLE `driver_profiles` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `emergency_contact` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `blood_group` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver_profiles`
--

INSERT INTO `driver_profiles` (`id`, `email`, `emergency_contact`, `address`, `blood_group`) VALUES
(1, 'john@example.com', '9123456789', 'New Delhi', 'B+'),
(3, 'varsh@gmail.com', '6785436758', 'trichy', 'a '),
(4, 'charu987@gmail.com', '9876543245', 'chennai', 'a '),
(5, '1', '1', '1', '1'),
(6, '2', '2', '2', '2'),
(7, 'charu@gmail.com', '4567789909', 'chennai', 'a '),
(8, 'charu14@gmail', '978654789', 'chennai, g block', 'a ');

-- --------------------------------------------------------

--
-- Table structure for table `driver_registration`
--

CREATE TABLE `driver_registration` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `mobile_number` varchar(15) NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `rc_number` varchar(50) NOT NULL,
  `vehicle_type` varchar(50) NOT NULL,
  `car_model` varchar(50) NOT NULL,
  `is_verified` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver_registration`
--

INSERT INTO `driver_registration` (`id`, `full_name`, `mobile_number`, `license_number`, `rc_number`, `vehicle_type`, `car_model`, `is_verified`) VALUES
(1, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(2, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(3, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(4, 'guna', '6789654356', 'fdgt54647', 'dfgh343536', 'suv ', 'tata', 0),
(5, 'guna', '6789654356', 'fdgt54647', 'dfgh343536', 'suv ', 'tata', 0),
(6, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(7, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(8, 'vanshika', '456789876', 'fd456', '34er', 'large', '34dfdg', 0),
(9, 'harshi', '54678934', 'sd4356', 'dse23456', 'large', 'tata', 0),
(10, 'charu', '354678976', 'rd3456', '34567', 'tata', '3435', 0),
(11, 'charu', '3435366', '5467et', '3435678dg', 'tata', '324dsfsg', 0),
(12, 'harish', '4567898765', 'dfg567', '4567gh', 'tata', '34tygh', 0),
(13, 'Fdgdhh', '45467899', 'ref3534678', 'tdrdg3456', 'tsghshsj345', 'ewrwy45', 0),
(14, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(15, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(16, 'varshini', '9786546789', '234 235 256 ', '234dfg', 'suv', 'swift', 0),
(17, 'charu', '7689546783', '345 3456', '34df', 'tn 34 rd 4563 ', 'swift', 0),
(18, 'charu', '7689546783', '345 3456', '34df', 'tn 34 rd 4563 ', 'swift', 0),
(19, 'charu', '7689546783', '345 3456', '34df', 'tn 34 rd 4563 ', 'swift', 0),
(20, 'charu', '7689546783', '345 3456', '34df', 'tn 34 rd 4563 ', 'swift', 0),
(21, 'charu', '7689546783', '345 3456', '34df', 'tn 34 rd 4563 ', 'swift', 0),
(23, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(24, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(25, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(26, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(27, 'John', '9876543210', 'DL1234567890', 'TN09RC4567', 'Sedan', 'Honda', 0),
(28, '1', '1', '1', '1', '1', '1', 0),
(29, '1', '1', '1', '2', '1', '1', 0),
(30, '1', '1', '1', '1', '1', '1', 0),
(31, 'Guna', '9876543245', 'fdg678', '34567', 'swift ', 'suv', 0),
(32, 'charu', '456789675', '567 678 567 ', '4567dfg ', '56 swift ', 'suv', 0);

-- --------------------------------------------------------

--
-- Table structure for table `driver_reports`
--

CREATE TABLE `driver_reports` (
  `id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `notes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offerridecompleted`
--

CREATE TABLE `offerridecompleted` (
  `id` int(11) NOT NULL,
  `driver_id` varchar(100) NOT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `from_location` text NOT NULL,
  `to_location` text NOT NULL,
  `ride_time` datetime NOT NULL,
  `distance` float NOT NULL,
  `fare` decimal(10,2) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `feedback` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offerridecompleted`
--

INSERT INTO `offerridecompleted` (`id`, `driver_id`, `passenger_name`, `from_location`, `to_location`, `ride_time`, `distance`, `fare`, `rating`, `feedback`) VALUES
(1, 'D123', 'John Doe', '123 Main Street, San Francisco', '456 Market Street, San Francisco', '2025-07-18 15:45:00', 12.5, 24.50, 4, 'Great ride, very comfortable!'),
(2, 'D123', 'John Doe', '123 Main Street, San Francisco', '456 Market Street, San Francisco', '2025-07-18 15:45:00', 12.5, 24.50, 4, 'Great ride, very comfortable!'),
(3, 'D123', 'John Doe', '123 Main Street, San Francisco', '456 Market Street, San Francisco', '2025-07-18 15:45:00', 12.5, 24.50, 4, 'Great ride, very comfortable!'),
(4, 'D123', 'John Doe', '123 Main Street, San Francisco', '456 Market Street, San Francisco', '2025-07-18 15:45:00', 12.5, 24.50, 4, 'Great ride, very comfortable!'),
(5, 'D123', 'John Doe', '123 Main Street, San Francisco', '456 Market Street, San Francisco', '2025-07-18 15:45:00', 12.5, 24.50, 4, 'Great ride, very comfortable!'),
(6, 'D123', 'John Doe', '123 Main Street, San Francisco', '456 Market Street, San Francisco', '2025-07-18 15:45:00', 12.5, 24.50, 4, 'Great ride, very comfortable!');

-- --------------------------------------------------------

--
-- Table structure for table `offerrides`
--

CREATE TABLE `offerrides` (
  `id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `pickup_location` varchar(255) NOT NULL,
  `drop_location` varchar(255) NOT NULL,
  `departure_date` date NOT NULL,
  `available_seats` int(11) NOT NULL,
  `car_details` varchar(255) DEFAULT NULL,
  `seat_price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offerrides`
--

INSERT INTO `offerrides` (`id`, `driver_id`, `pickup_location`, `drop_location`, `departure_date`, `available_seats`, `car_details`, `seat_price`) VALUES
(1, 1, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(2, 2, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(3, 2, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(4, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(5, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(6, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(7, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(8, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(9, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(10, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(11, 198, 'Chennai', 'Trichy', '2025-07-30', 4, 'Honda ', 200.00),
(12, 508, 'Coimbatore ', 'Tirunelveli', '2025-07-31', 2, 'Honda ', 300.00),
(26, 60, 'Madurai', 'Karakudi', '2025-08-02', 2, 'Tata', 40.00),
(27, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(28, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(29, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(30, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(31, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(32, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(33, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(34, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(35, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(36, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(37, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(38, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(39, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(40, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(41, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(42, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(43, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(44, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(45, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(46, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(47, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(48, 23, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Tata', 60.00),
(49, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(50, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(51, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(52, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(53, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(54, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(55, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(56, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(57, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(58, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(59, 34, 'Chrompet', 'Pondicherry', '2025-08-08', 2, 'Swift', 50.00),
(60, 34, 'Chrompet', 'Pondicherry', '2025-08-08', 2, 'Swift', 50.00),
(61, 34, 'Chrompet', 'Pondicherry', '2025-08-08', 2, 'Swift', 50.00),
(62, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(63, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(64, 34, 'Chrompet', 'Pondicherry', '2025-08-02', 2, 'Swift', 50.00),
(65, 3, 'Wet', 'Gudi', '2025-08-02', 2, 'Tagav33', 233.00),
(66, 3, 'Huffs', 'Reteyu', '2025-08-02', 3, 'Tadagi', 349.00),
(67, 45, 'Fdgdhh', 'Dfdghdj', '2025-08-02', 2, 'Tata', 456.00),
(68, 78, 'Chennai', 'Coimbatore', '2025-08-04', 2, 'Honda', 243.00),
(69, 56, 'Vellore', 'Chennai', '2025-08-04', 2, 'Honda', 234.00),
(70, 23, 'Chennai', 'Coimbatore', '2025-08-04', 2, 'Honda tn 20 x 6758', 34.00),
(71, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, 'Honda', 234.00),
(72, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, 'Tata', 345.00),
(73, 67, 'Chennai', 'Coimbatore', '2025-08-04', 2, 'Tata', 345.00),
(74, 23, 'Chennai', 'Trichy', '2025-08-04', 2, 'Tata', 234.00),
(75, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(76, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(77, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(78, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(79, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(80, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(81, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(82, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(83, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(84, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(85, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(86, 45, 'Chennai', 'Coimbatore', '2025-08-04', 2, '234 honda', 234.00),
(87, 12, 'Chennai', 'Trichy', '2025-08-04', 3, 'Tata', 234.00),
(88, 2, 'Chennai', 'Trichy', '2025-08-05', 2, 'Tata', 234.00),
(89, 2, 'Chennai', 'Trichy', '2025-08-05', 4, 'Honda', 678.00),
(90, 2, 'Chennai', 'Trichy', '2025-08-05', 2, 'Tata', 24.00),
(91, 2, 'Chennai', 'Trichy', '2025-08-05', 2, 'Honda', 234.00),
(92, 2, 'Ap', 'Tn', '2025-08-05', 2, 'Tata', 234.00),
(93, 2, 'Ap', 'Tn', '2025-08-05', 2, 'Tata', 234.00),
(94, 2, 'Eddy’s', 'Fdgdhh', '2025-08-05', 2, 'Tata', 324.00),
(95, 2, 'Chennai', 'Trichy', '2025-08-05', 3, 'Tata', 234.00),
(96, 2, 'Chennai', 'Trichy', '2025-08-06', 4, 'Swift', 234.00),
(97, 2, 'Chennai', 'Fdgdhh', '2025-08-06', 2, 'Gfh5677', 256.00),
(98, 2, 'Chennai', 'Trichy', '2025-08-06', 3, 'Tata4567', 456.00),
(99, 2, 'Chennai', 'Trichy', '2025-08-07', 3, 'Swghj', 500.00),
(100, 2, 'Chennai', 'Coimbatore', '2025-08-07', 2, 'Tata', 345.00),
(132, 2, 'Kanchipuram', 'Avadi', '2025-08-07', 2, 'Tata', 50.00),
(133, 2, 'Vellore', 'Chennai', '2025-08-07', 3, 'Swift', 234.00),
(154, 2, 'West street,Madurai', 'Anna Nagar,Chennai', '2025-08-08', 3, '34gdf', 300.00),
(155, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(156, 5, 'Saveetha college, Thandalam', 'Ponamalle bus stand ', '2025-08-08', 2, 'Tn 45 cd 3456 ', 15.00),
(157, 2, 'Chennai central', 'Marina beach', '2025-08-08', 2, '34dfg', 40.00),
(158, 0, 'Saveetha college Thandalam ', 'Kg, poonamalle', '2025-08-08', 2, 'Tn 34 dh 5678', 10.00),
(159, 2, 'Anna Nagar West ', 'Kamala theatre ', '2025-08-08', 2, 'Ret5677', 35.00),
(160, 2, 'Anangaputhur, amman Kovil stop', 'TVs bus stop, Tiruttani', '2025-08-08', 4, 'Tn 34 ad 2345', 100.00),
(161, 2, 'Chennai', 'Trichy ', '2025-08-08', 2, 'Tn 34 dg 3456', 35.00),
(162, 2, 'Chennai', 'Marina beach', '2025-08-08', 2, 'Tn 45 dg 4567', 23.00),
(163, 2, 'VC CM', 'Fghhh', '2025-08-08', 3, 'Tn 45 fg 2345', 34.00),
(164, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(165, 2, 'Huk', 'Cbn', '2025-08-09', 2, 'Ert56', 345.00),
(166, 2, 'Trichy', 'Coimbatore', '2025-08-09', 2, 'Tn 45 dg 6789', 200.00),
(167, 2, 'Trichy ', 'Coimbatore', '2025-08-09', 3, 'Tn 20 dg 5678', 200.00),
(168, 2, 'Chennai', 'Mumbai', '2025-08-09', 2, 'Swift , tn 67 th 6789', 600.00),
(169, 2, 'Chennai', 'Mumbai', '2025-08-09', 3, 'Tn 20 gh 5678', 600.00),
(170, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(171, 2, 'Hosur', 'Trichy', '2025-08-11', 1, 'Tn 34 rt 5678 , swift', 500.00),
(172, 2, 'Porur', 'Velachery', '2025-08-11', 2, 'Swift', 30.00),
(173, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(174, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(175, 2, 'Trichy', 'Chennai', '2025-08-12', 2, 'Tn 34 dg 5674, swift ', 150.00),
(176, 2, 'Chennai', 'Tiruttani', '2025-08-12', 2, 'Tn 56 dg 3456', 23.00),
(177, 2, 'Chennai', 'Trichy', '2025-08-12', 3, 'Tn 56 bnhg 6789', 300.00),
(178, 2, 'Tiruttani', 'Chennai', '2025-08-12', 2, 'Tn 34 df 5678', 30.00),
(180, 2, 'Marina beach, chennai', 'T nagar, chennai', '2025-08-13', 1, 'Tn 34 df 5678, swift', 20.00),
(181, 2, 'Vellore ', 'Chennai', '2025-08-14', 2, 'Tn 34 cd 3456, swift ', 100.00),
(182, 2, 'Marina beach, chennai', 'Saveetha college , Thandalam', '2025-08-14', 3, 'Tn 34 sd 4567, swift ', 50.00),
(183, 2, 'Chittlapakkam,chennai', 'Saveetha college, Thandalam ', '2025-08-18', 1, 'Swift ', 40.00),
(184, 2, 'Chennai', 'Vellore', '2025-08-19', 2, 'Swift', 100.00),
(185, 3, 'Trichy', 'Chennai', '2025-08-21', 2, 'Swift', 200.00),
(186, 2, 'Thirumazhisai', 'Saveetha college ,thandalam', '2025-08-21', 2, 'Ertiga', 30.00),
(187, 2, 'Vadapalani', 'Mangadu', '2025-08-22', 2, 'Swift ', 200.00),
(188, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(189, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(190, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(191, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 0.00),
(192, 2, 'Kundrathur', 'Mangadu', '2025-08-22', 2, 'Swift', 0.00),
(193, 2, 'Chennai', 'Velacherry', '2025-08-22', 2, 'Swift', 0.00),
(194, 2, 'Chennai', 'Coimbatore', '2025-08-25', 2, 'Swift ', 0.00),
(195, 2, 'Chennai', 'Coimbatore', '2025-08-25', 2, 'Swift ', 0.00),
(196, 2, 'Trichy', 'Chennai', '2025-08-30', 2, 'Swift', 0.00),
(197, 101, 'chennai', 'coimbatore', '2025-07-25', 2, 'Swift TN07AB1234', 250.00),
(199, 2, 'Trichy', 'Chennai', '2025-09-01', 1, 'Tn 20 dg 3456', 0.00),
(200, 2, 'Trichy', 'Chennai', '2025-09-01', 2, 'Tn 23 df 3456, swift ', 200.00),
(201, 2, 'Trichy', 'Chennai', '2025-09-01', 1, 'Tn 34 sd 3456, swift ', 100.00),
(202, 2, 'Trichy', 'Chennai', '2025-09-01', 2, 'Tn 34 sd 2345', 250.00),
(203, 2, 'Chennai', 'Coimbatore', '2025-09-01', 2, 'Swift', 0.00),
(204, 2, 'Madurai', 'Vadapalani', '2025-09-03', 2, 'Swift', 100.00),
(205, 2, 'Coimbatore', 'Trichy', '2025-09-03', 2, 'Swift', 100.00),
(206, 3, 'Bangalore', 'Chennai', '2025-09-03', 2, 'Swift', 100.00),
(207, 2, 'Chennai', 'Dugdh', '2025-09-03', 2, 'Swift', 0.00),
(208, 3, 'Trichy', 'Chennai', '2025-09-04', 2, 'Swift', 100.00),
(209, 22, '', '', '2025-09-04', 0, '', 0.00),
(210, 22, '11', '1', '2025-09-04', 1, '1', 1.00),
(211, 3, 'Chennai', 'Trichy', '2025-09-04', 2, 'Swift', 0.00),
(212, 2, 'Chennai', 'Tiruttani', '2025-09-06', 2, 'Swift ', 0.00),
(213, 2, 'Chennai', 'Tiruttani', '2025-09-06', 2, 'Swift', 0.00),
(214, 2, 'Chennai', 'Trichy', '2025-09-06', 2, 'Swift', 0.00),
(215, 3, 'Chennai', 'Trichy', '2025-09-08', 2, 'Swift', 0.00),
(216, 2, 'Chennai', 'Trichy', '2025-09-10', 2, 'Swift ', 200.00),
(217, 2, 'Chennai', 'Trichy', '2025-09-11', 1, 'Swift', 200.00),
(218, 2, 'Bangalore', 'Madurai', '2025-09-11', 2, 'Swift', 300.00),
(219, 3, 'Chennai', 'Trichy', '2025-09-13', 2, 'Swift', 200.00),
(220, 2, 'Chennai', 'Tiruttani', '2025-09-13', 2, 'Swift', 0.00),
(221, 2, 'Saveetha university', 'Koyambedu', '2025-09-17', 1, 'Swift', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `passenger_requests`
--

CREATE TABLE `passenger_requests` (
  `request_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `seats_requested` int(11) NOT NULL,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passenger_requests`
--

INSERT INTO `passenger_requests` (`request_id`, `driver_id`, `seats_requested`, `status`) VALUES
(1, 104, 2, 'pending'),
(2, 104, 2, 'pending'),
(3, 104, 2, 'pending'),
(4, 104, 2, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `ride_completed`
--

CREATE TABLE `ride_completed` (
  `id` int(11) NOT NULL,
  `pickup_location` varchar(255) NOT NULL,
  `dropoff_location` varchar(255) NOT NULL,
  `departure_date` date NOT NULL,
  `seat_price` decimal(10,2) NOT NULL,
  `passenger_name` varchar(255) NOT NULL,
  `seats_booked` int(11) NOT NULL,
  `total_fare` decimal(10,2) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `feedback` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ride_completed`
--

INSERT INTO `ride_completed` (`id`, `pickup_location`, `dropoff_location`, `departure_date`, `seat_price`, `passenger_name`, `seats_booked`, `total_fare`, `rating`, `feedback`) VALUES
(1, 'Chennai', 'Bangalore', '2025-08-20', 500.00, 'John Smith', 2, 1000.00, 5, 'Great ride, very comfortable!'),
(2, 'Chennai', 'Bangalore', '2025-08-20', 500.00, 'John', 2, 1000.00, 5, 'Great ride, very comfortable'),
(3, 'Chennai', 'Bangalore', '2025-08-20', 500.00, 'John', 2, 1000.00, 5, 'Great ride, very comfortable');

-- --------------------------------------------------------

--
-- Table structure for table `ride_confirmation`
--

CREATE TABLE `ride_confirmation` (
  `confirmation_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `passenger_name` varchar(100) DEFAULT NULL,
  `seats_confirmed` int(11) DEFAULT NULL,
  `fare` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ride_confirmation`
--

INSERT INTO `ride_confirmation` (`confirmation_id`, `driver_id`, `passenger_name`, `seats_confirmed`, `fare`) VALUES
(1, 1, 'Sarah Johnson', 2, 350.00),
(2, 1, 'Sarah Johnson', 2, 350.00);

-- --------------------------------------------------------

--
-- Table structure for table `ride_otps`
--

CREATE TABLE `ride_otps` (
  `otp_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `passenger_id` int(11) NOT NULL,
  `otp_code` varchar(6) NOT NULL,
  `is_verified` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_requests`
--

CREATE TABLE `ride_requests` (
  `id` int(11) NOT NULL,
  `pickup_location` varchar(255) NOT NULL,
  `dropoff_location` varchar(255) NOT NULL,
  `travel_date` date NOT NULL,
  `travel_time` time NOT NULL,
  `passenger_count` int(11) DEFAULT 1,
  `driver_note` text DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ride_requests`
--

INSERT INTO `ride_requests` (`id`, `pickup_location`, `dropoff_location`, `travel_date`, `travel_time`, `passenger_count`, `driver_note`, `driver_id`) VALUES
(18, 'Trichy', 'Kallakurichi', '2025-07-28', '13:42:09', 2, '', NULL),
(19, 'Trichy ', 'Madurai', '2025-07-30', '13:53:32', 2, '', NULL),
(20, 'Trichy', 'Chennai', '2025-07-30', '14:41:50', 2, '', NULL),
(21, 'Chennai', 'Vadapalani', '2025-07-28', '14:46:28', 2, '', NULL),
(22, 'Trichy', 'Chennai', '2025-07-31', '15:26:37', 2, '', NULL),
(23, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(24, 'Kallakurichi', 'Tiruvallur', '2025-07-28', '16:04:45', 1, 'Female driver only ', NULL),
(25, 'Chennai', 'Trichy', '2025-07-31', '11:16:13', 1, 'Come fast', NULL),
(27, 'Chennai', 'Trichy', '2025-07-30', '11:54:25', 2, 'Come fast', NULL),
(39, 'Chennai', 'Coimbatore', '2025-08-01', '14:16:09', 2, '', NULL),
(40, 'Chennai', 'Coimbatore', '2025-08-01', '14:16:09', 2, '', NULL),
(52, 'Wet', 'Ecr', '2025-07-31', '14:18:56', 2, '', NULL),
(53, 'Chennai', 'Trichy', '2025-07-31', '14:32:32', 2, '', NULL),
(54, 'Chennai', 'Trichy', '2025-07-30', '14:32:32', 2, '', NULL),
(55, 'Chennai', 'Trichy', '2025-07-30', '14:52:29', 2, '', NULL),
(56, 'Chennai', 'Trichy', '2025-07-30', '14:52:29', 2, '', NULL),
(57, 'Chennai', 'Trichy', '2025-07-31', '14:52:29', 2, '', NULL),
(58, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(59, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(60, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(61, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(62, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(63, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(64, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(65, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL),
(66, 'velacherry', 'chrompet', '2025-07-05', '13:44:00', 4, 'please come and pickup me ', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sos_alerts`
--

CREATE TABLE `sos_alerts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sos_alerts`
--

INSERT INTO `sos_alerts` (`id`, `user_id`, `latitude`, `longitude`, `message`) VALUES
(1, 12, '10.7905', '78.7047', 'Emergency! Need help now!'),
(2, 12, '10.7905', '78.7047', 'Emergency! Need help now!'),
(3, 3, '10.7905', '78.7047', 'Emergency! Need help now!'),
(4, 3, '10.7905', '78.7047', 'Emergency! Need help now!'),
(5, 3, '10.7905', '78.7047', 'Emergency! Need help now!'),
(6, 3, '10.7905', '78.7047', 'Emergency! Need help now!');

-- --------------------------------------------------------

--
-- Table structure for table `user_signup`
--

CREATE TABLE `user_signup` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_signup`
--

INSERT INTO `user_signup` (`id`, `name`, `email`, `password`) VALUES
(1, 'charu123', 'va123rsh@gmail.com', '123456x'),
(2, 'Guna', 'charu987@gmail.com', '123456789'),
(3, 'charu', 'varsh@gmail.com', '123456'),
(4, 'charu', 'varsh1@gmail.com', '123456'),
(5, 'Test', 'test@gmail.com', '123'),
(6, 'Test', 'test1@gmail.com', '123'),
(7, 'Test', 'test123@gmail.com', '123'),
(8, 'Chdgdy', 'Dsfg234@gmail.com', '123456789'),
(9, 'Dugdh. ', 'Char@gmail.com', '123456'),
(10, 'Dghdj', 'gdhh@gmail.com', '12345'),
(11, 'Charu', 'fgdhdj@gmail.com', '12345'),
(12, 'Charu', 'charu14@gmail.com', '12345'),
(13, 'Sanjay', 's@gmail.com', '123sanjay'),
(14, 'Guna', 'guna07@gmail.com', 'guna'),
(15, 'P.Bhuvaneshwari', 'Bhuvana@gmail.com', 'padma4venki'),
(16, 'Santhosh', 'Sandy!@gmail.com', 'a'),
(17, 'Abinaya', 'abinaya@gmail.com', 'abinaya'),
(18, 'SSS', 'Seba@123.com', '1234'),
(19, 'Test01', 'Test01@hotmail.com', '12345'),
(20, 'Babitha', 'dnagababitha@gmail.com', '123456789!ee'),
(21, 'Shaptha', 'Shapthapoonkuzhali@gmail.com', '11s30m20042008'),
(22, '1', '1', '1'),
(23, 'Dharshini N', 'Neehathn@gmail.com', 'Dharshini@2004'),
(24, 'Sanjana', 'sanjana@gmail.com', 'Sanjana');

-- --------------------------------------------------------

--
-- Table structure for table `verify_request_otp`
--

CREATE TABLE `verify_request_otp` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `otp` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `verify_request_otp`
--

INSERT INTO `verify_request_otp` (`id`, `user_id`, `otp`) VALUES
(1, 1, '5774');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_signup`
--
ALTER TABLE `admin_signup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_id` (`admin_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `availableriderequest`
--
ALTER TABLE `availableriderequest`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking_page`
--
ALTER TABLE `booking_page`
  ADD PRIMARY KEY (`booking_id`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_id` (`driver_id`);

--
-- Indexes for table `driver_profiles`
--
ALTER TABLE `driver_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_registration`
--
ALTER TABLE `driver_registration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_reports`
--
ALTER TABLE `driver_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_driver` (`driver_id`);

--
-- Indexes for table `offerridecompleted`
--
ALTER TABLE `offerridecompleted`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offerrides`
--
ALTER TABLE `offerrides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `passenger_requests`
--
ALTER TABLE `passenger_requests`
  ADD PRIMARY KEY (`request_id`);

--
-- Indexes for table `ride_completed`
--
ALTER TABLE `ride_completed`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ride_confirmation`
--
ALTER TABLE `ride_confirmation`
  ADD PRIMARY KEY (`confirmation_id`);

--
-- Indexes for table `ride_otps`
--
ALTER TABLE `ride_otps`
  ADD PRIMARY KEY (`otp_id`);

--
-- Indexes for table `ride_requests`
--
ALTER TABLE `ride_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sos_alerts`
--
ALTER TABLE `sos_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_signup`
--
ALTER TABLE `user_signup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `verify_request_otp`
--
ALTER TABLE `verify_request_otp`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_signup`
--
ALTER TABLE `admin_signup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `availableriderequest`
--
ALTER TABLE `availableriderequest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `booking_page`
--
ALTER TABLE `booking_page`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver_profiles`
--
ALTER TABLE `driver_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `driver_registration`
--
ALTER TABLE `driver_registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `driver_reports`
--
ALTER TABLE `driver_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `offerridecompleted`
--
ALTER TABLE `offerridecompleted`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `offerrides`
--
ALTER TABLE `offerrides`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT for table `passenger_requests`
--
ALTER TABLE `passenger_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ride_completed`
--
ALTER TABLE `ride_completed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ride_confirmation`
--
ALTER TABLE `ride_confirmation`
  MODIFY `confirmation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ride_otps`
--
ALTER TABLE `ride_otps`
  MODIFY `otp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_requests`
--
ALTER TABLE `ride_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `sos_alerts`
--
ALTER TABLE `sos_alerts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_signup`
--
ALTER TABLE `user_signup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `verify_request_otp`
--
ALTER TABLE `verify_request_otp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `driver_registration` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `driver_reports`
--
ALTER TABLE `driver_reports`
  ADD CONSTRAINT `fk_driver` FOREIGN KEY (`driver_id`) REFERENCES `driver_registration` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
