-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2015 at 10:09 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `books`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `bookId` int(3) NOT NULL,
  `author` varchar(50) NOT NULL,
  `pages` int(3) NOT NULL,
  `stock` int(3) NOT NULL,
  `bookTitle` varchar(50) NOT NULL,
  `studentID` int(6) NOT NULL,
  PRIMARY KEY (`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`bookId`, `author`, `pages`, `stock`, `bookTitle`, `studentID`) VALUES
(446, '32', 13, 121, 'asdasd', 0),
(860, 'Ahsan Shabbir', 324, 123, 'Learn PHP', 0),
(871, 'asdha', 324, 131, 'testt', 11);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `studentId` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(63) NOT NULL,
  `password` varchar(40) NOT NULL,
  `rollNo` varchar(30) NOT NULL,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `rollNo` (`rollNo`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`studentId`, `name`, `phone`, `email`, `password`, `rollNo`) VALUES
(1, 'Test user', '+923338484848', 'test@mail.com', '33d403e86a266347fe3d264951eb0720', '1202-01'),
(3, 'test', '123123123', 'test@yahoo.com', '33d403e86a266347fe3d264951eb0720', '793'),
(11, 'ahsan', '34234', 'ahsan@mail.com', '33d403e86a266347fe3d264951eb0720', '584');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `bookId` int(3) NOT NULL,
  `studentId` int(4) NOT NULL,
  `issue` date NOT NULL,
  `end` date NOT NULL,
  KEY `fkey` (`studentId`),
  KEY `fkey1` (`bookId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fkey` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkey1` FOREIGN KEY (`bookId`) REFERENCES `books` (`bookId`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
