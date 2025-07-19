-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 18, 2025 at 02:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SE SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Table structure for table `trades`
--

CREATE TABLE `trades` (
  `id` int(11) NOT NULL,
  `buy_order_id` int(11) NOT NULL,
  `sell_order_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `trading_pair` varchar(20) NOT NULL,
  `quantity` decimal(20,8) NOT NULL,
  `price` decimal(20,8) NOT NULL,
  `total_value` decimal(20,8) GENERATED ALWAYS AS (`quantity` * `price`) STORED,
  `buyer_fee` decimal(20,8) DEFAULT 0.00000000,
  `seller_fee` decimal(20,8) DEFAULT 0.00000000,
  `trade_type` enum('maker','taker') NOT NULL,
  `executed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `trades`
--
ALTER TABLE `trades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buy_order_id` (`buy_order_id`),
  ADD KEY `sell_order_id` (`sell_order_id`),
  ADD KEY `idx_trading_pair` (`trading_pair`,`executed_at`),
  ADD KEY `idx_user_trades` (`buyer_id`,`executed_at`),
  ADD KEY `idx_seller_trades` (`seller_id`,`executed_at`),
  ADD KEY `idx_trades_pair_time` (`trading_pair`,`executed_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trades`
--
ALTER TABLE `trades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `trades`
--
ALTER TABLE `trades`
  ADD CONSTRAINT `trades_ibfk_1` FOREIGN KEY (`buy_order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `trades_ibfk_2` FOREIGN KEY (`sell_order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `trades_ibfk_3` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `trades_ibfk_4` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
