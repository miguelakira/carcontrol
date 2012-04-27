-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 27, 2012 at 05:36 PM
-- Server version: 5.1.62
-- PHP Version: 5.3.2-1ubuntu4.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `carcontrol_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `estados`
--

CREATE TABLE IF NOT EXISTS `estados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `nome` varchar(256) NOT NULL,
  `sigla` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `estados`
--

INSERT INTO `estados` (`id`, `created_at`, `updated_at`, `nome`, `sigla`) VALUES
(1, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Acre', 'AC'),
(2, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Alagoas', 'AL'),
(3, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Amapá', 'AP'),
(4, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Amazonas', 'AM'),
(5, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Bahia', 'BA'),
(6, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Ceará', 'CE'),
(7, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Distrito Federal', 'DF'),
(8, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Espírito Santo', 'ES'),
(9, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Goiás', 'GO'),
(10, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Maranhão', 'MA'),
(11, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Mato Grosso', 'MT'),
(12, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Mato Grosso do Sul', 'MS'),
(13, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Minas Gerais', 'MG'),
(14, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Pará', 'PA'),
(15, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Paraíba', 'PB'),
(16, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Paraná', 'PR'),
(17, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Pernambuco', 'PE'),
(18, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Piauí', 'PI'),
(19, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Rio de Janeiro', 'RJ'),
(20, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Rio Grande do Norte', 'RN'),
(21, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Rio Grande do Sul', 'RS'),
(22, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Rondônia', 'RO'),
(23, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Roraima', 'RR'),
(24, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Santa Catarina', 'SC'),
(25, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'São Paulo', 'SP'),
(26, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Sergipe', 'SE'),
(27, '2012-04-26 20:05:08', '2012-04-26 20:05:08', 'Tocantins', 'TO');
