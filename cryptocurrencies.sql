hp-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 10, 2025 at 11:31 AM
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
-- Table structure for table `cryptocurrencies`
--

CREATE TABLE `cryptocurrencies` (
  `id` int(11) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `current_price` decimal(20,8) DEFAULT 0.00000000,
  `market_cap` bigint(20) DEFAULT 0,
  `volume_24h` bigint(20) DEFAULT 0,
  `price_change_24h` decimal(10,4) DEFAULT 0.0000,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cryptocurrencies`
--

INSERT INTO `cryptocurrencies` (`id`, `symbol`, `name`, `current_price`, `market_cap`, `volume_24h`, `price_change_24h`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'BTC', 'Bitcoin', 45000.00000000, 850000000000, 25000000000, 2.5000, 1, '2025-06-17 07:39:38', '2025-06-17 07:39:38'),
(2, 'ETH', 'Ethereum', 3200.00000000, 380000000000, 15000000000, -1.2000, 1, '2025-06-17 07:39:38', '2025-06-17 07:39:38'),
(3, 'ADA', 'Cardano', 1.25000000, 42000000000, 2000000000, 3.8000, 1, '2025-06-17 07:39:38', '2025-06-17 07:39:38'),
(4, 'DOT', 'Polkadot', 8.50000000, 9500000000, 800000000, -0.5000, 1, '2025-06-17 07:39:38', '2025-06-17 07:39:38'),
(5, 'LINK', 'Chainlink', 15.75000000, 7300000000, 600000000, 1.8000, 1, '2025-06-17 07:39:38', '2025-06-17 07:39:38'),
(6, 'SOL', 'Solana', 95.50000000, 42000000000, 1800000000, 4.2000, 1, '2025-06-17 07:39:38', '2025-06-17 07:39:38'),
(7, 'MATIC', 'Polygon', 0.85000000, 8200000000, 450000000, -2.1000, 1, '2025-06-17 07:39:38', '2025-06-17 07:39:38'),
(8, 'AVAX', 'Avalanche', 28.30000000, 10500000000, 350000000, 0.9000, 1, '2025-06-17 07:39:38', '2025-06-17 07:39:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cryptocurrencies`
--
ALTER TABLE `cryptocurrencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `symbol` (`symbol`),
  ADD KEY `idx_crypto_symbol` (`symbol`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cryptocurrencies`
--
ALTER TABLE `cryptocurrencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
