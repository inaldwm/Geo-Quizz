-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 30 Avril 2018 à 22:26
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `geo_quizz_bd`
--

-- --------------------------------------------------------

--
-- Structure de la table `pins`
--

CREATE TABLE IF NOT EXISTS `pins` (
  `idPins` int(11) NOT NULL DEFAULT '0',
  `nom` varchar(45) DEFAULT NULL,
  `adresse` varchar(45) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPins`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `idQuestion` int(11) NOT NULL,
  `question` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `reponse`
--

CREATE TABLE IF NOT EXISTS `reponse` (
  `idreponse` int(11) NOT NULL,
  `valeur` varchar(45) DEFAULT NULL,
  `correcte` int(11) DEFAULT NULL,
  PRIMARY KEY (`idreponse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `reseauxsocial`
--

CREATE TABLE IF NOT EXISTS `reseauxsocial` (
  `idreseauxSocial` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `Utilisateur_idUtilisateur` int(11) NOT NULL,
  PRIMARY KEY (`idreseauxSocial`,`Utilisateur_idUtilisateur`),
  KEY `fk_reseauxSocial_Utilisateur1_idx` (`Utilisateur_idUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `score`
--

CREATE TABLE IF NOT EXISTS `score` (
  `idScore` int(11) NOT NULL DEFAULT '0',
  `point` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `Utilisateur_idUtilisateur` int(11) NOT NULL,
  `Video_has_Question_idQuizz` varchar(45) NOT NULL,
  PRIMARY KEY (`idScore`,`Utilisateur_idUtilisateur`,`Video_has_Question_idQuizz`),
  KEY `fk_Score_Utilisateur1_idx` (`Utilisateur_idUtilisateur`),
  KEY `fk_Score_Video_has_Question1_idx` (`Video_has_Question_idQuizz`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `theme`
--

CREATE TABLE IF NOT EXISTS `theme` (
  `idTheme` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTheme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `theme`
--

INSERT INTO `theme` (`idTheme`, `nom`) VALUES
(1, 'Sport'),
(2, 'Culture'),
(3, 'Economie'),
(4, 'Societe');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `idUtilisateur` int(11) NOT NULL,
  `pseudo` varchar(45) DEFAULT NULL,
  `mdp` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUtilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `video`
--

CREATE TABLE IF NOT EXISTS `video` (
  `idVideo` int(11) NOT NULL,
  `url` varchar(45) DEFAULT NULL,
  `Pins_idPins` int(11) NOT NULL,
  PRIMARY KEY (`idVideo`),
  KEY `fk_Video_Pins_idx` (`Pins_idPins`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `video_has_question`
--

CREATE TABLE IF NOT EXISTS `video_has_question` (
  `Video_idVideo` int(11) NOT NULL,
  `Question_idQuestion` int(11) NOT NULL,
  `reponse_idreponse` int(11) NOT NULL,
  `idQuizz` varchar(45) NOT NULL,
  PRIMARY KEY (`idQuizz`),
  KEY `fk_Video_has_Question_Question1_idx` (`Question_idQuestion`),
  KEY `fk_Video_has_Question_Video1_idx` (`Video_idVideo`),
  KEY `fk_Video_has_Question_reponse1_idx` (`reponse_idreponse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `video_has_theme`
--

CREATE TABLE IF NOT EXISTS `video_has_theme` (
  `Video_idVideo` int(11) NOT NULL,
  `Theme_idTheme` int(11) NOT NULL,
  PRIMARY KEY (`Video_idVideo`,`Theme_idTheme`),
  KEY `fk_Video_has_Theme_Theme1_idx` (`Theme_idTheme`),
  KEY `fk_Video_has_Theme_Video1_idx` (`Video_idVideo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `reseauxsocial`
--
ALTER TABLE `reseauxsocial`
  ADD CONSTRAINT `fk_reseauxSocial_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `score`
--
ALTER TABLE `score`
  ADD CONSTRAINT `fk_Score_Utilisateur1` FOREIGN KEY (`Utilisateur_idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Score_Video_has_Question1` FOREIGN KEY (`Video_has_Question_idQuizz`) REFERENCES `video_has_question` (`idQuizz`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `fk_Video_Pins` FOREIGN KEY (`Pins_idPins`) REFERENCES `pins` (`idPins`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `video_has_question`
--
ALTER TABLE `video_has_question`
  ADD CONSTRAINT `fk_Video_has_Question_Video1` FOREIGN KEY (`Video_idVideo`) REFERENCES `video` (`idVideo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Video_has_Question_Question1` FOREIGN KEY (`Question_idQuestion`) REFERENCES `question` (`idQuestion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Video_has_Question_reponse1` FOREIGN KEY (`reponse_idreponse`) REFERENCES `reponse` (`idreponse`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `video_has_theme`
--
ALTER TABLE `video_has_theme`
  ADD CONSTRAINT `fk_Video_has_Theme_Video1` FOREIGN KEY (`Video_idVideo`) REFERENCES `video` (`idVideo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Video_has_Theme_Theme1` FOREIGN KEY (`Theme_idTheme`) REFERENCES `theme` (`idTheme`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
