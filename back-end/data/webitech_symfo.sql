-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 17 mars 2023 à 12:49
-- Version du serveur : 5.7.40
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `webitech_symfo`
--

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_64C19C1727ACA70` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `parent_id`, `name`, `slug`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'Politique', 'politique', '2023-03-17 13:47:52', '2023-03-17 13:47:52', NULL),
(2, NULL, 'Economie', 'economie', '2023-03-17 13:47:52', '2023-03-17 13:47:52', NULL),
(3, NULL, 'Culture', 'culture', '2023-03-17 13:47:52', '2023-03-17 13:47:52', NULL),
(4, NULL, 'Sports', 'sports', '2023-03-17 13:47:52', '2023-03-17 13:47:52', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9474526C4B89032C` (`post_id`),
  KEY `IDX_9474526CA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE IF NOT EXISTS `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5A8A6C8D12469DE2` (`category_id`),
  KEY `IDX_5A8A6C8DF675F31B` (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `post`
--

INSERT INTO `post` (`id`, `category_id`, `author_id`, `title`, `slug`, `content`, `image`, `active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 2, 'Mobilisation contre la réforme des retraites : la CGT affirme avoir coupé le courant au stade de France et au chantier du village olympique à Saint-Denis !', 'mobilisation-contre-la-reforme-des-retraites-la-cgt-affirme-avoir-coupe-le-courant-au-stade-de-france-et-au-chantier-du-village-olympique-a-saint-denis', '<h3>&quot;L&#39;action a priv&eacute; d&#39;&eacute;nergie le village olympique, le quartier au niveau zone commerciale, des data centers et aussi le stade de France&quot;, a d&eacute;taill&eacute; S&eacute;bastien Menesplier, secr&eacute;taire g&eacute;n&eacute;ral de la CGT &eacute;nergie.</h3>\r\n\r\n<p>Premi&egrave;re action d&#39;ampleur revendiqu&eacute;e par la CGT dans le cadre de la mobilisation contre&nbsp;<a href=\"https://www.francetvinfo.fr/economie/retraite/reforme-des-retraites/\">la r&eacute;forme des retraites</a>. Des agents du secteur du gaz et de l&#39;&eacute;lectricit&eacute; ont coup&eacute;, jeudi 9 mars, le courant du stade de France et du chantier du village olympique &agrave; Saint-Denis, a annonc&eacute; le syndicat CGT &agrave; des journalistes sur place.&nbsp;<em>&quot;L&#39;action a priv&eacute; d&#39;&eacute;nergie le village olympique, le quartier au niveau zone commerciale, des data centers et aussi le stade de France&quot;</em>, a pr&eacute;cis&eacute; S&eacute;bastien Menesplier, secr&eacute;taire g&eacute;n&eacute;ral de la CGT &eacute;nergie. Suivez notre direct.&nbsp;</p>', '31021484-6409e5c27b117505871297.jpg', 1, '2023-03-09 13:57:22', '2023-03-17 13:49:35', NULL),
(2, 1, 1, 'Affaire des assistants d\'eurodéputés MoDem : François Bayrou et dix autres personnes renvoyés devant un tribunal', 'affaire-des-assistants-deurodeputes-modem-francois-bayrou-et-dix-autres-personnes-renvoyes-devant-un-tribunal', '<h3>Un non-lieu a en revanche &eacute;t&eacute; ordonn&eacute; pour l&#39;ancienne ministre Sylvie Goulard.</h3>\r\n\r\n<p>Deux juges d&#39;instruction parisiennes ont ordonn&eacute;, jeudi 9 mars, le renvoi en correctionnelle du pilier de la majorit&eacute; Fran&ccedil;ois Bayrou et de dix autres personnes dans&nbsp;<a href=\"https://www.francetvinfo.fr/politique/modem/assistants-parlementaires-du-modem/\">l&#39;affaire de l&#39;emploi irr&eacute;gulier d&#39;assistants d&#39;eurod&eacute;put&eacute;s</a>, a appris franceinfo de source judiciaire, confirmant une information de l&#39;AFP.&nbsp;</p>\r\n\r\n<p>Un non-lieu a en revanche &eacute;t&eacute; ordonn&eacute; pour Sylvie Goulard, qui avait d&eacute;missionn&eacute; du minist&egrave;re des Arm&eacute;es en 2017 un mois apr&egrave;s son arriv&eacute;e, apr&egrave;s les r&eacute;v&eacute;lations sur ces faits. Les onze personnes physiques ainsi que le MoDem et l&#39;ex-UDF sont soup&ccedil;onn&eacute;s d&#39;avoir utilis&eacute; des fonds europ&eacute;ens pour embaucher des assistants parlementaires qui auraient en r&eacute;alit&eacute; travaill&eacute;, au moins partiellement, pour le parti entre 2009 et 2014.</p>', '6409d799e59bc-000-33389kb-6409e66ded687268207719.webp', 1, '2023-03-09 14:00:13', '2023-03-17 13:49:35', NULL),
(3, 4, 1, 'Equipe de France : entre déconvenues sportives et tensions en coulisses, le bilan contrasté de Corinne Diacre', 'equipe-de-france-entre-deconvenues-sportives-et-tensions-en-coulisses-le-bilan-contraste-de-corinne-diacre', '<h3>La Nordiste de 48 ans a &eacute;t&eacute; d&eacute;mise de ses fonctions de s&eacute;lectionneuse de l&#39;&eacute;quipe de France par le Comex, jeudi.</h3>\r\n\r\n<p>a sentence est tomb&eacute;e. Dans le sillage de&nbsp;<a href=\"https://www.francetvinfo.fr/sports/foot/noel-le-graet/football-noel-le-graet-a-la-tete-de-la-fff-une-presidence-entre-reussites-sportives-et-couacs-repetes_5594681.html\">la d&eacute;mission de No&euml;l Le Graet</a>, &agrave; l&#39;issue d&#39;une r&eacute;union du Comex (comit&eacute; ex&eacute;cutif), il y a quelques jours,&nbsp;<a href=\"https://www.francetvinfo.fr/sports/foot/equipe-de-france/equipe-de-france-corinne-diacre-ecartee-de-son-poste-de-selectionneuse_5682689.html\">Corinne Diacre a &eacute;t&eacute; d&eacute;mise de ses fonctions de s&eacute;lectionneuse</a>&nbsp;de l&#39;&eacute;quipe de France f&eacute;minine,<strong>&nbsp;</strong>jeudi 9 mars. Au&nbsp;c&oelig;ur&nbsp;de la tourmente apr&egrave;s<strong>&nbsp;</strong><a href=\"https://www.francetvinfo.fr/sports/foot/equipe-de-france/equipe-de-france-feminine-de-football-on-vous-explique-la-crise-autour-du-retrait-de-plusieurs-joueuses-qui-fragilise-la-selectionneuse-corinne-diacre_5679491.html\">la d&eacute;cision de Wendie Renard et de plusieurs autres internationales</a><strong>&nbsp;</strong>de ne plus jouer avec la s&eacute;lection, la d&eacute;sormais ex-entra&icirc;neuse des Bleues ne sera donc pas sur le banc tricolore lors de la prochaine Coupe du monde, pr&eacute;vue dans cinq mois&nbsp;en Australie et en Nouvelle-Z&eacute;lande (20 juillet-20 ao&ucirc;t). Mais que restera-t-il de son mandat de six ans &agrave; la t&ecirc;te de l&#39;&eacute;quipe de France f&eacute;minine ?</p>\r\n\r\n<h2>Des conflits relationnels avec ses cadres</h2>\r\n\r\n<p>Tanc&eacute;e tout au long de son mandat pour sa gestion des relations humaines, Corinne Diacre en a finalement sans doute fait les frais. Pour cause, l&#39;annonce de la mise en retrait de Wendie Renard et de trois autres Fran&ccedil;aises a eu un effet quasiment imm&eacute;diat. La capitaine des Bleues avait annonc&eacute; sur ses r&eacute;seaux sociaux, vendredi 24 f&eacute;vrier, faire une croix sur la Coupe du monde 2023&nbsp;<em>&quot;dans de telles conditions&quot;</em>, d&eacute;non&ccedil;ant&nbsp;<em>&quot;un syst&egrave;me bien loin des exigences requises par le plus haut niveau&quot;.</em></p>', 'phpqkfgol-6409e6b0789b2261183392.webp', 1, '2023-03-09 14:01:20', '2023-03-17 13:49:35', NULL),
(4, 3, 2, 'Le chanteur Marcel Amont, vedette du music-hall, est mort à l\'âge de 93 ans', 'le-chanteur-marcel-amont-vedette-du-music-hall-est-mort-a-lage-de-93-ans', '<h3>L&#39;artiste aux 75 ann&eacute;es de carri&egrave;re s&#39;est &eacute;teint &agrave; son domicile de Saint-Cloud, &agrave; l&#39;ouest de Paris.</h3>\r\n\r\n<p>a chanson&nbsp;<em>Bleu, blanc, blond,&nbsp;</em>c&#39;&eacute;tait lui.&nbsp;<em>Le Mexicain</em>, aussi. Le chanteur Marcel Amont,&nbsp;<a href=\"https://www.francetvinfo.fr/culture/musique/culture-l-infatigable-marcel-amont_3005447.html\">vedette du music-hall</a>, est d&eacute;c&eacute;d&eacute; &agrave; l&#39;&acirc;ge de 93 ans, selon un communiqu&eacute; de sa famille transmis &agrave; l&#39;AFP, dans la nuit du mercredi 8 au jeudi 9 mars. L&#39;artiste bondissant et show-man fantaisiste, aux 75 ann&eacute;es de carri&egrave;re, s&#39;est &eacute;teint &agrave; son domicile, &agrave; Saint-Cloud, &agrave; l&#39;ouest de Paris.&nbsp;<em>&quot;</em><em>Marcel Amont a fait bondir des millions de c&oelig;urs &agrave; travers le monde&quot;,</em>&nbsp;a r&eacute;agi la ministre de la Culture, Rima Abdul Malak, sur Twitter.&nbsp;</p>\r\n\r\n<p><iframe frameborder=\"0\" id=\"twitter-widget-0\" scrolling=\"no\" src=\"https://platform.twitter.com/embed/Tweet.html?dnt=false&amp;embedId=twitter-widget-0&amp;features=eyJ0ZndfdGltZWxpbmVfbGlzdCI6eyJidWNrZXQiOltdLCJ2ZXJzaW9uIjpudWxsfSwidGZ3X2ZvbGxvd2VyX2NvdW50X3N1bnNldCI6eyJidWNrZXQiOnRydWUsInZlcnNpb24iOm51bGx9LCJ0ZndfdHdlZXRfZWRpdF9iYWNrZW5kIjp7ImJ1Y2tldCI6Im9uIiwidmVyc2lvbiI6bnVsbH0sInRmd19yZWZzcmNfc2Vzc2lvbiI6eyJidWNrZXQiOiJvbiIsInZlcnNpb24iOm51bGx9LCJ0ZndfbWl4ZWRfbWVkaWFfMTU4OTciOnsiYnVja2V0IjoidHJlYXRtZW50IiwidmVyc2lvbiI6bnVsbH0sInRmd19leHBlcmltZW50c19jb29raWVfZXhwaXJhdGlvbiI6eyJidWNrZXQiOjEyMDk2MDAsInZlcnNpb24iOm51bGx9LCJ0ZndfZHVwbGljYXRlX3NjcmliZXNfdG9fc2V0dGluZ3MiOnsiYnVja2V0Ijoib24iLCJ2ZXJzaW9uIjpudWxsfSwidGZ3X3ZpZGVvX2hsc19keW5hbWljX21hbmlmZXN0c18xNTA4MiI6eyJidWNrZXQiOiJ0cnVlX2JpdHJhdGUiLCJ2ZXJzaW9uIjpudWxsfSwidGZ3X2xlZ2FjeV90aW1lbGluZV9zdW5zZXQiOnsiYnVja2V0Ijp0cnVlLCJ2ZXJzaW9uIjpudWxsfSwidGZ3X3R3ZWV0X2VkaXRfZnJvbnRlbmQiOnsiYnVja2V0Ijoib24iLCJ2ZXJzaW9uIjpudWxsfX0%3D&amp;frame=false&amp;hideCard=false&amp;hideThread=false&amp;id=1633742359807574017&amp;lang=en&amp;origin=https%3A%2F%2Fbo-pic-franceinfo.francetelevisions.tv%2F&amp;sessionId=c478ea8d2c64595841bfbb34bd24572ef4fe6d83&amp;theme=light&amp;widgetsVersion=aaf4084522e3a%3A1674595607486&amp;width=550px\" title=\"Twitter Tweet\"></iframe></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Il faisait partie d&rsquo;une g&eacute;n&eacute;ration d&rsquo;artistes n&eacute;s dans les ann&eacute;es 20. Apr&egrave;s plusieurs succ&egrave;s dans les d&eacute;cennies 1950, 1960 et 1970, il avait quelque peu &eacute;t&eacute; rel&eacute;gu&eacute; au deuxi&egrave;me plan de l&#39;industrie musicale. Mais il avait gard&eacute; une vivacit&eacute; d&rsquo;esprit et une curiosit&eacute; le poussant &agrave; &eacute;crire son premier roman &agrave; 92 ans.&nbsp;</p>\r\n\r\n<h2>Premiers succ&egrave;s dans les ann&eacute;es 50</h2>\r\n\r\n<p>Marcel Jean-Pierre Balthazar Miramon nait le 1er avril 1929 &agrave; Bordeaux. Ses parents Modeste Miramon et Rom&eacute;lie Lamazou &eacute;taient des paysans autodidactes natifs d&rsquo;Etsaut dans la vall&eacute;e d&#39;Aspe (Pyr&eacute;n&eacute;es-Atlantiques), install&eacute;s dans la capitale girondine et reconvertis, lui en employ&eacute; des chemins de fer, elle en infirmi&egrave;re. Apr&egrave;s le baccalaur&eacute;at, Marcel Amont h&eacute;site entre une carri&egrave;re d&#39;enseignant d&#39;&eacute;ducation physique et le Conservatoire d&#39;art dramatique. Il s&rsquo;oriente finalement vers la com&eacute;die, puis la chanson. Il d&eacute;bute dans la r&eacute;gion bordelaise, puis il part pour Paris en 1950 o&ugrave; il se fait peu &agrave; peu un nom dans la plupart des cabarets des deux rives (Villa d&#39;Este, La Fontaine des Quatre-Saisons, etc.).</p>\r\n\r\n<p>Apr&egrave;s la tourn&eacute;e de Jean Nohain en premi&egrave;re partie de Philippe Clay en 1953, o&ugrave; il manque de mourir apr&egrave;s le spectacle de Bordeaux et doit faire un an de sanatorium, il conna&icirc;t v&eacute;ritablement le succ&egrave;s en 1956 avec son premier disque,&nbsp;<em>Escamillo</em>, qui devient vite un tube.</p>\r\n\r\n<p><iframe height=\"315\" src=\"https://www.youtube.com/embed/aHSNrMKfXUs\" title=\"Marcel Amont  \" width=\"578\"></iframe></p>\r\n\r\n<p>Il monte sur la sc&egrave;ne de l&rsquo;Olympia&nbsp;<a href=\"https://www.francetvinfo.fr/culture/musique/j-en-avais-la-chair-de-poule-le-jour-ou-marcel-amont-est-devenu-la-premiere-partie-d-edith-piaf-a-l-olympia_5701250.html\" rel=\"noopener\" target=\"_blank\">en premi&egrave;re partie d&rsquo;Edith Piaf</a>, puis est sacr&eacute; &quot;r&eacute;v&eacute;lation de l&#39;ann&eacute;e&quot; et re&ccedil;oit le Prix de l&#39;Acad&eacute;mie Charles-Cros, en m&ecirc;me temps que Serge Gainsbourg et Juliette Gr&eacute;co. Les tubes s&rsquo;enchainent&nbsp;:&nbsp;<em>Tout doux tout doucement</em>, et&nbsp;<em>Bleu, blanc, blond</em>, deux adaptations de succ&egrave;s am&eacute;ricains.</p>\r\n\r\n<p><iframe height=\"315\" src=\"https://www.youtube.com/embed/DLxjhWdUz7Q\" title=\"Marcel Amont \" width=\"578\"></iframe></p>\r\n\r\n<h2>Cons&eacute;cration dans les ann&eacute;es 60</h2>\r\n\r\n<p>Trois mois et demi &agrave; guichets ferm&eacute;s pour un r&eacute;cital &agrave; Bobino en 1962, des chansons sign&eacute;es Claude Nougaro (&nbsp;<em>Le Balayeur du roy</em>,&nbsp;<em>Porte-plume</em>,&nbsp;<em>Le Tango des jumeaux</em>,&nbsp;<em>Le Jazz et la java</em>), cinq semaines &agrave; L&rsquo;Olympia en 1965 avec des danseuses sur sc&egrave;ne, innovation &agrave; l&rsquo;&eacute;poque, le succ&egrave;s de Marcel Amont durant les sixties ne faiblit pas. Le 1er octobre 1967, il anime la premi&egrave;re &eacute;mission en couleur de l&#39;histoire de la t&eacute;l&eacute;vision fran&ccedil;aise,&nbsp;<em>Amont Tour</em>. Mais les ann&eacute;es 60 sont surtout celles du plus grand tube de sa carri&egrave;re&nbsp;:&nbsp;<em>Le Mexicain</em>, &eacute;crit par Charles Aznavour.</p>\r\n\r\n<p><iframe height=\"315\" src=\"https://www.youtube.com/embed/CyDTvQKUb8c\" title=\"Marcel Amont \" width=\"578\"></iframe></p>\r\n\r\n<h2>Populaire mais respect&eacute; dans la profession</h2>\r\n\r\n<p>Parall&egrave;lement aux succ&egrave;s l&eacute;gers, aux sc&eacute;nographies avec danseuses, choristes et cascadeurs &agrave; l&rsquo;Olympia en 1970, ou son penchant pour les imitations et la com&eacute;die, il garde une certaine estime dans le milieu de la chanson fran&ccedil;aise, notamment gr&acirc;ce au morceau&nbsp;<em>Le Chapeau de Mireille</em>&nbsp;que lui offre son ami&nbsp;<a href=\"https://www.francetvinfo.fr/culture/musique/rock/brassens-berry-young-ces-artistes-qui-ont-utilise-la-meme-musique-pour-plusieurs-chansons_4184879.html\">Brassens</a>&nbsp;en 1974. Une premi&egrave;re pour &quot;Tonton Georges&quot; qui jusque-l&agrave; avait toujours interpr&eacute;t&eacute; lui-m&ecirc;me ses chansons.</p>\r\n\r\n<p><iframe height=\"315\" src=\"https://www.youtube.com/embed/lW1V844XtKo\" title=\"\" width=\"578\"></iframe></p>\r\n\r\n<p>Cette reconnaissance vaut &agrave; Marcel Amont d&rsquo;avoir des chansons &eacute;crites par Julien Clerc,&nbsp;<a href=\"https://www.francetvinfo.fr/culture/musique/chanson-francaise/le-soldat-rose-3-interview-d-039-alain-et-pierre-souchon-a-l-039-occasion-de-la-sortie-de-l-039-album_3338601.html\">Alain Souchon</a>&nbsp;ou&nbsp;<a href=\"https://www.francetvinfo.fr/culture/musique/chanson-francaise/je-ne-suis-pas-nostalgique-je-prefere-etre-dans-le-present-maxime-le-forestier-en-tournee_3733123.html\">Maxime Le Forestier</a>. M&ecirc;me s&rsquo;il se fait plus rare m&eacute;diatiquement durant les ann&eacute;es 80 et 90, cela ne l&rsquo;emp&ecirc;che pas de se produire en tourn&eacute;e dans le monde entier, notamment au Japon, en Russie, &agrave; San Francisco ou &agrave; Rome.</p>\r\n\r\n<h2>Sur sc&egrave;ne jusqu&rsquo;&agrave; la fin</h2>\r\n\r\n<p>Marcel Amont n&rsquo;a jamais quitt&eacute; la sc&egrave;ne. Il est rest&eacute; tr&egrave;s actif durant les d&eacute;cennies 2000 et 2010, que ce soit &agrave; travers les tourn&eacute;es&nbsp;<em>&Acirc;ge tendre</em>, de nombreux duos avec entre autres Agn&egrave;s Jaoui, G&eacute;rard Darmon, Didier Lockwood,&nbsp;<a href=\"https://www.francetvinfo.fr/culture/musique/jazz/bireli-lagrene-seul-avec-sa-guitare-sur-son-nouvel-album-solo-suites_5119942.html\">Bir&eacute;li Lagr&egrave;ne</a>, des albums jusqu&rsquo;&agrave; r&eacute;cemment&nbsp;avec&nbsp;<em>Par-dessus l&#39;&eacute;paule&nbsp;</em>en 2018, et plusieurs spectacles dont un concert exceptionnel &agrave; l&#39;Alhambra en 2019 pour ses 90 ans. Il avait alors &eacute;t&eacute; rejoint sur sc&egrave;ne par une vingtaine d&rsquo;invit&eacute;s dont entre autres&nbsp;<a href=\"https://www.francetvinfo.fr/culture/musique/chanson-francaise/je-ne-suis-pas-nostalgique-je-prefere-etre-dans-le-present-maxime-le-forestier-en-tournee_3733123.html\">Maxime Leforestier</a>, Serge Lama, G&eacute;rard Lenorman, Nicoletta, Michel Jonasz,&nbsp;<a href=\"https://www.francetvinfo.fr/culture/spectacles/theatre/francois-morel-raymond-devos-c-etait-avant-tout-un-grand-homme-de-music-hall_3488187.html\">Fran&ccedil;ois Morel</a>...</p>\r\n\r\n<p><iframe frameborder=\"0\" height=\"315\" src=\"https://www.youtube.com/embed/RNBV_5efz5M\" title=\"Marcel Amont fête ses 90 ans sur la scène de l\'Alhambra\" width=\"578\"></iframe></p>\r\n\r\n<h2>Quelques r&ocirc;les au cin&eacute;ma et &agrave; la t&eacute;l&eacute;vision</h2>\r\n\r\n<p>D&egrave;s les ann&eacute;es 50, Marcel Amont est apparu dans des seconds r&ocirc;les au cin&eacute;ma. Il a notamment d&eacute;but&eacute; aux c&ocirc;t&eacute;s de Brigitte Bardot dans&nbsp;<em>La mari&eacute;e est trop belle</em>&nbsp;de Pierre Gaspard-Huit en 1956. Il a incarn&eacute; Jean de La Fontaine dans le t&eacute;l&eacute;film&nbsp;<em>Moli&egrave;re pour rire et pour pleurer</em>&nbsp;de Marcel Camus en 1973. Plus r&eacute;cemment il a jou&eacute; dans l&rsquo;&eacute;pisode&nbsp;<em>Chaos dans le vin noir</em>&nbsp;de la s&eacute;rie&nbsp;<em>Le Sang de la vigne</em>, diffus&eacute;e sur France 3. En 1984 il &eacute;tait interview&eacute; pour son premier r&ocirc;le dans le film&nbsp;<em>Les Ma&icirc;tres du soleil</em>, de Jean-Jacques Aublanc.</p>\r\n\r\n<p><iframe height=\"315\" src=\"https://www.youtube.com/embed/TBbUv1m7Hqc\" title=\"Marcel Amont au cinéma dans \" width=\"578\"></iframe></p>\r\n\r\n<h2>Auteur de livres sur la chanson et romancier sur le tard</h2>\r\n\r\n<p>Au cours de sa carri&egrave;re, Marcel Amont a publi&eacute; une dizaine de livres autour de ses chansons (&nbsp;<em>Une chanson, qu&#39;y a-t-il &agrave; l&#39;int&eacute;rieur d&#39;une chanson ?</em>&nbsp;en 1989,&nbsp;<em>&Ccedil;a se dit, &ccedil;a s&#39;&eacute;crit, &ccedil;a se chante</em>&nbsp;en 2000) de ses origines gasconnes (&nbsp;<em>Comment peut-on &ecirc;tre gascon ?</em>&nbsp;en 2001) ou de sa correspondance avec ses pairs (&nbsp;<em>Lettres &agrave; des amis</em>&nbsp;en 2014). &Agrave; 92 ans, il a &eacute;crit son premier roman&nbsp;<em>Adieu la belle Marguerite</em>, paru en 2021 aux &eacute;ditions Cairn.</p>\r\n\r\n<p><img alt=\"&quot;Adieu la belle Marguerite&quot;, l\'unique roman de Marcel Amont, paru en 2021 (éditions Cairn)\" src=\"https://www.francetvinfo.fr/pictures/vz8gGw_MCTU6ThBlqgUccEJ5hGY/fit-in/720x/2022/08/04/phpIWSFey.jpg\" style=\"height:405px; width:720px\" /></p>\r\n\r\n<p>&quot;Adieu la belle Marguerite&quot;, l&#39;unique roman de Marcel Amont, paru en 2021&nbsp;(&eacute;ditions Cairn)</p>\r\n\r\n<p>Encore r&eacute;cemment, Marcel Amont affichait une sant&eacute; de fer et un enthousiasme digne d&rsquo;un jeune de vingt ans. Il disait vouloir chanter jusqu&rsquo;&agrave; ses 100 ans.&nbsp;La vie en a d&eacute;cid&eacute; autrement, et il n&rsquo;aura pas pu r&eacute;aliser totalement son r&ecirc;ve. Malgr&eacute; tout, il a parcouru avec brio pas moins de sept d&eacute;cennies sur le devant de la sc&egrave;ne et reste un exemple de long&eacute;vit&eacute; dans le patrimoine culturel fran&ccedil;ais.</p>', '640973dbe65a7-080-hl-smulas-1833234-6409e6e2ae0cd044284307.webp', 1, '2023-03-09 14:02:10', '2023-03-17 13:49:35', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_like_id` int(11) DEFAULT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`),
  KEY `IDX_8D93D64976E89822` (`comment_like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `comment_like_id`, `email`, `roles`, `password`, `firstname`, `lastname`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'hugo@actu.news', '[\"ROLE_AUTHOR\"]', '$2y$13$dX8f/2fRZI0DvT8YLJeYcubX/R7Zmepm0zPxc9V6B/uYndVIH.tWS', 'Hugo', 'LIEGEARD', '2023-03-17 13:45:35', '2023-03-17 13:45:36', NULL),
(2, NULL, 'bruno.b@actu.news', '[\"ROLE_USER\"]', '$2y$13$dX8f/2fRZI0DvT8YLJeYcubX/R7Zmepm0zPxc9V6B/uYndVIH.tWS', 'Bruno', 'BARON', '2023-03-17 13:49:02', '2023-03-17 13:49:02', NULL),
(3, NULL, 'anthony.bauchet@actu.news', '[\"ROLE_USER\", \"ROLE_AUTHOR\"]', '$2y$13$dX8f/2fRZI0DvT8YLJeYcubX/R7Zmepm0zPxc9V6B/uYndVIH.tWS', 'Anthony', 'BAUCHET', '2023-03-17 13:49:02', '2023-03-17 13:49:02', NULL),
(4, NULL, 'cedric.templier@tech.news', '[\"ROLE_USER\", \"ROLE_ADMIN\", \"ROLE_AUTHOR\"]', '$2y$13$dX8f/2fRZI0DvT8YLJeYcubX/R7Zmepm0zPxc9V6B/uYndVIH.tWS', 'Cédric', 'TEMPLIER', '2023-03-17 13:49:02', '2023-03-17 13:49:02', NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `FK_64C19C1727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`);

--
-- Contraintes pour la table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FK_9474526C4B89032C` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  ADD CONSTRAINT `FK_9474526CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `FK_5A8A6C8D12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `FK_5A8A6C8DF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_8D93D64976E89822` FOREIGN KEY (`comment_like_id`) REFERENCES `comment` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
