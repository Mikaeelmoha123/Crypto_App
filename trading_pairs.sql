php-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 06, 2025 at 07:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crypto`
--

-- --------------------------------------------------------

--
-- Table structure for table `trading_pairs`
--

CREATE TABLE `trading_pairs` (
  `id` int(11) NOT NULL,
  `base_currency` varchar(10) NOT NULL,
  `quote_currency` varchar(10) NOT NULL,
  `pair_symbol` varchar(20) NOT NULL,
  `min_order_size` decimal(20,8) DEFAULT 0.00000001,
  `max_order_size` decimal(20,8) DEFAULT 999999999.00000000,
  `price_precision` int(11) DEFAULT 8,
  `quantity_precision` int(11) DEFAULT 8,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trading_pairs`
--

INSERT INTO `trading_pairs` (`id`, `base_currency`, `quote_currency`, `pair_symbol`, `min_order_size`, `max_order_size`, `price_precision`, `quantity_precision`, `is_active`, `created_at`) VALUES
(1, 'BTC', 'USD', 'BTC/USD', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(2, 'ETH', 'USD', 'ETH/USD', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(3, 'ADA', 'USD', 'ADA/USD', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(4, 'DOT', 'USD', 'DOT/USD', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(5, 'LINK', 'USD', 'LINK/USD', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(6, 'SOL', 'USD', 'SOL/USD', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(7, 'MATIC', 'USD', 'MATIC/USD', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(8, 'AVAX', 'USD', 'AVAX/USD', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(9, 'ETH', 'BTC', 'ETH/BTC', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06'),
(10, 'ADA', 'BTC', 'ADA/BTC', 0.00000001, 999999999.00000000, 8, 8, 1, '2025-06-17 07:40:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `trading_pairs`
--
ALTER TABLE `trading_pairs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_pair` (`base_currency`,`quote_currency`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trading_pairs`
--
ALTER TABLE `trading_pairs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
