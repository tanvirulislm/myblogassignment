-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 15, 2025 at 07:29 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(25, 1, 47, '2025-04-14 10:49:46', '2025-04-14 10:49:46');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `parent_id`, `content`, `created_at`, `updated_at`) VALUES
(7, 4, 35, NULL, 'sdfdsf', '2025-04-07 08:27:19', '2025-04-07 08:27:19'),
(8, 4, 35, 7, 'dsfsdfsd', '2025-04-07 08:27:27', '2025-04-07 08:27:27'),
(11, 4, 41, NULL, 'Hello dfasfsd', '2025-04-07 08:42:48', '2025-04-07 08:44:19'),
(12, 3, 41, 11, 'I ma in', '2025-04-07 08:45:33', '2025-04-07 08:45:33'),
(13, 3, 39, NULL, 'I love you', '2025-04-07 20:00:48', '2025-04-07 20:00:48'),
(14, 3, 38, NULL, 'I love you', '2025-04-10 11:30:26', '2025-04-10 11:30:26'),
(15, 3, 33, NULL, 'This is me', '2025-04-10 11:30:38', '2025-04-10 11:30:38'),
(16, 3, 35, NULL, 'Thanks', '2025-04-10 11:30:48', '2025-04-10 11:30:48'),
(17, 3, 48, NULL, 'I love it', '2025-04-10 12:56:31', '2025-04-10 12:56:31'),
(19, 3, 47, NULL, 'dfsd', '2025-04-10 23:32:13', '2025-04-10 23:32:13'),
(20, 3, 47, NULL, 'dfsd', '2025-04-10 23:32:16', '2025-04-10 23:32:16'),
(23, 3, 48, NULL, 'Yes bro', '2025-04-10 23:46:53', '2025-04-10 23:46:53'),
(26, 3, 48, NULL, 'thi iss', '2025-04-15 09:55:45', '2025-04-15 09:55:45'),
(27, 3, 53, NULL, 'Create Post 1', '2025-04-15 10:21:07', '2025-04-15 10:21:17'),
(34, 3, 46, NULL, 'Delete comment', '2025-04-15 10:57:34', '2025-04-15 10:57:34'),
(35, 3, 46, 34, 'Reply', '2025-04-15 10:57:45', '2025-04-15 10:57:45');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(4, 4, 35, '2025-04-07 08:26:47', '2025-04-07 08:26:47'),
(5, 3, 39, '2025-04-07 19:53:23', '2025-04-07 19:53:23'),
(6, 3, 38, '2025-04-07 19:55:42', '2025-04-07 19:55:42'),
(11, 3, 46, '2025-04-10 23:54:44', '2025-04-10 23:54:44'),
(15, 3, 53, '2025-04-15 10:21:00', '2025-04-15 10:21:00'),
(17, 3, 31, '2025-04-15 10:58:02', '2025-04-15 10:58:02');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_03_23_180936_create_posts_table', 1),
(5, '2025_03_23_180938_create_tags_table', 1),
(6, '2025_03_23_180941_create_post_tags_table', 1),
(7, '2025_03_23_180943_create_comments_table', 1),
(8, '2025_03_23_180945_create_likes_table', 1),
(9, '2025_03_23_180948_create_bookmarks_table', 1),
(10, '2025_03_23_180951_create_notifications_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('like','comment','reply') NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `message`, `created_at`, `updated_at`, `read_at`) VALUES
(1, 1, 'comment', ' commented on your post: fdsafdsafsdf', '2025-04-10 23:32:13', '2025-04-10 23:32:13', NULL),
(2, 1, 'comment', ' commented on your post: fdsafdsafsdf', '2025-04-10 23:32:16', '2025-04-10 23:32:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `visibility` enum('public','private') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `content`, `image`, `visibility`, `created_at`, `updated_at`) VALUES
(25, 4, 'Sunt fugiat qui atqu', 'Odio ut non labore i', NULL, 'public', '2025-04-06 04:18:36', '2025-04-06 04:18:36'),
(27, 4, 'Vitae voluptas a ape', 'Maxime dignissimos d', NULL, 'public', '2025-04-06 04:21:54', '2025-04-06 04:21:54'),
(28, 4, 'Non qui accusamus vo', 'Consectetur rerum ve', NULL, 'public', '2025-04-06 04:22:24', '2025-04-06 04:22:24'),
(30, 4, 'Hic esse aliquid su', 'Quae voluptatem eos', NULL, 'private', '2025-04-06 04:22:33', '2025-04-06 04:22:33'),
(31, 4, 'Veniam quis volupta', 'Nulla dolor voluptat', NULL, 'public', '2025-04-06 04:22:37', '2025-04-06 04:22:37'),
(32, 4, 'Eligendi obcaecati e', 'In possimus ut est', NULL, 'private', '2025-04-06 04:25:47', '2025-04-06 04:25:47'),
(33, 4, 'Labore sed eius erro', 'A laborum Quis itaq', NULL, 'public', '2025-04-06 04:28:06', '2025-04-06 04:28:06'),
(35, 4, 'I edit this title', 'Autem culpa architec', 'uploads/1743943567.png', 'public', '2025-04-06 06:46:07', '2025-04-06 19:19:42'),
(36, 4, 'Amet odit dolore ve', 'Nisi nobis ut facere', 'uploads/1743990833.png', 'private', '2025-04-06 19:53:53', '2025-04-06 19:53:53'),
(37, 4, 'Amet odit dolore ve', 'Nisi nobis ut facere', 'uploads/1743990861.png', 'private', '2025-04-06 19:54:21', '2025-04-06 19:54:21'),
(38, 4, 'Voluptate consectetu', 'Quibusdam non quae d', NULL, 'public', '2025-04-06 19:55:07', '2025-04-06 19:55:07'),
(39, 4, 'Asperiores sapiente', 'Est ut recusandae R', NULL, 'public', '2025-04-06 19:55:31', '2025-04-06 19:55:31'),
(40, 4, 'Veritatis adipisci e', 'Autem maxime ullamco', 'uploads/1743991251.png', 'private', '2025-04-06 20:00:51', '2025-04-06 20:00:51'),
(41, 4, 'Rem et quis id Nam', 'Aliquid commodi sint inventore rerum consequatur ex fuga Totam', 'uploads/1744036572.jpg', 'public', '2025-04-07 08:36:12', '2025-04-07 08:36:12'),
(44, 1, 'I am brave browser', '&lt;p&gt;This is normal Text,&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;and this is another&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;and this is another&lt;/h2&gt;&lt;h2&gt;&lt;br&gt;&lt;/h2&gt;&lt;ol&gt;&lt;li&gt;sdfdsf&lt;/li&gt;&lt;li&gt;dsfsaf&lt;/li&gt;&lt;li&gt;sdfsdaf&lt;/li&gt;&lt;li&gt;sdfsdfsd&lt;/li&gt;&lt;li&gt;sdf&lt;/li&gt;&lt;li&gt;sd&lt;/li&gt;&lt;/ol&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;blockquote&gt;fdsafsdfsdf&lt;/blockquote&gt;', NULL, 'public', '2025-04-10 12:35:36', '2025-04-10 12:35:36'),
(45, 1, 'sdsdffsd', '&lt;p&gt;sdfsdf&lt;/p&gt;&lt;p&gt;sdfgsd&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;h2&gt;&lt;strong&gt;dsfsafsadfs&lt;/strong&gt;&lt;/h2&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;sdfsdfsdaff&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;sd&lt;/p&gt;&lt;p&gt;f&lt;/p&gt;&lt;p&gt;sd&lt;/p&gt;&lt;p&gt;f&lt;/p&gt;&lt;p&gt;sd&lt;/p&gt;&lt;p&gt;fds&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', NULL, 'public', '2025-04-10 12:38:44', '2025-04-10 12:38:44'),
(46, 1, 'sdsdffsd', '<p>Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)Thumbnail Image (Optional: Replace existing)</p>', 'uploads/1744350862_67f8ae8e07263.jpg', 'public', '2025-04-10 12:38:45', '2025-04-10 23:54:22'),
(47, 1, 'fdsafdsafsdf', '<p>sdfdsafdsa</p><p>sdfsdaf</p><p>sdfsaf</p><p>asdfsasdf</p><h1>sdfsdafdsa</h1><p><br></p><ul><li>sdfs</li><li>sadfsdad</li><li>sdffsdaf</li><li>sdfsdf</li><li><br></li></ul>', 'uploads/1744350807_67f8ae57b4ca7.jpg', 'public', '2025-04-10 12:39:44', '2025-04-10 23:53:27'),
(48, 1, 'I love it', '<p>I love it</p><p><br></p><h2>So you love me?</h2><p><br></p><p><br></p><h2>So you love me?</h2><h2>So you love me?</h2><h2>So you love me?</h2><h4>So you love me?</h4><h4>So you love me?</h4><h4>So you love me?</h4><p><br></p><p><br></p><p><br></p><h2>So you love me?</h2><h2><em>So you love me?</em></h2><p><br></p><p><br></p><h2><br></h2><h2><br></h2><p><br></p><p><br></p><p><br></p><h2>So you love me?</h2><p><br></p>', 'uploads/1744350392_67f8acb85a3db.png', 'public', '2025-04-10 12:49:23', '2025-04-10 23:46:32'),
(52, 3, 'Recorded Post', '<blockquote>Recorded PostRecorded PostRecorded PostRecorded PostRecorded PostRecorded PostRecorded PostRecorded PostRecorded Post</blockquote><p><br></p><ul><li>Recorded PostRecorded PostRecorded PostRecorded PostRecorded Post</li></ul><p><br></p><h2>Recorded PostRecorded PostRecorded PostRecorded Post</h2><p><br></p><p><br></p><p><em>Recorded PostRecorded PostRecorded PostRecorded Post</em></p><p><br></p><p><br></p>', 'uploads/1744733120.jpg', 'public', '2025-04-15 10:05:20', '2025-04-15 10:05:31'),
(53, 3, 'Create Post Create PostCreate PostCreate PostCreate PostCreate PostCreate Post', '<h5>Create Post</h5><h2>Create Post</h2><h2>Create Post</h2><h2>Create Post</h2><h2><em>Create Post</em></h2><h2><a href=\"fdsfdsf.com\" rel=\"noopener noreferrer\" target=\"_blank\">Create Post</a></h2><p>ffdsfsdf<u>fsdfsdfsdf</u></p><p><br></p><ul><li><u>sdfdsfdsf</u></li><li><u>s</u></li><li><u>df</u></li><li><u>sdf</u></li><li><u>sda</u></li><li><u>f</u></li><li><u>sd</u></li><li><u>fds</u></li><li><br></li></ul>', 'uploads/1744733992_67fe87288f734.jpg', 'public', '2025-04-15 10:19:19', '2025-04-15 10:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_tags`
--

INSERT INTO `post_tags` (`id`, `post_id`, `tag_id`, `created_at`, `updated_at`) VALUES
(1, 37, 1, NULL, NULL),
(2, 37, 2, NULL, NULL),
(3, 37, 3, NULL, NULL),
(4, 40, 4, NULL, NULL),
(5, 41, 5, NULL, NULL),
(6, 41, 6, NULL, NULL),
(12, 45, 12, NULL, NULL),
(16, 48, 15, NULL, NULL),
(17, 48, 16, NULL, NULL),
(18, 46, 17, NULL, NULL),
(19, 46, 18, NULL, NULL),
(25, 52, 24, NULL, NULL),
(26, 52, 25, NULL, NULL),
(27, 52, 26, NULL, NULL),
(28, 53, 27, NULL, NULL),
(29, 53, 28, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('oGpr6EJ4JJQfnEvDg6PMixMSjWcWNYEp8rhw4J7t', NULL, '127.0.0.1', 'PostmanRuntime/7.43.2', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkxuYkNoQjZ3VDQ5NllMT1NETkwxQWROR0ZvM1dzcjNiU1JsN21qRCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fX0=', 1742925237),
('qgudujsEGt6QdH4o3lOBmuFqQeGF3RwcyzU0gsRy', NULL, '127.0.0.1', 'PostmanRuntime/7.43.2', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoieEpaTVczbGFoREdmbFNUdlNaQkNlM1FDa3JSVFBzekZycXpHQTduUCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1742851724);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Hola', '2025-04-06 19:54:21', '2025-04-06 19:54:21'),
(2, 'Non id adipisicing', '2025-04-06 19:54:21', '2025-04-06 19:54:21'),
(3, 'fdf', '2025-04-06 19:54:21', '2025-04-06 19:54:21'),
(4, 'Vel reiciendis sed e', '2025-04-06 20:00:51', '2025-04-06 20:00:51'),
(5, 'ddsf', '2025-04-07 08:36:12', '2025-04-07 08:36:12'),
(6, 'dsfdsf', '2025-04-07 08:36:12', '2025-04-07 08:36:12'),
(7, 'Iure', '2025-04-10 11:37:32', '2025-04-10 11:37:32'),
(8, 'cere', '2025-04-10 11:37:32', '2025-04-10 11:37:32'),
(9, 'saepe', '2025-04-10 11:37:32', '2025-04-10 11:37:32'),
(10, 'Xxsd', '2025-04-10 11:49:22', '2025-04-10 11:49:22'),
(11, 'sdfdsfds', '2025-04-10 11:49:22', '2025-04-10 11:49:22'),
(12, 'sdffsd', '2025-04-10 12:38:44', '2025-04-10 12:38:44'),
(13, 'dsfsd', '2025-04-10 23:35:04', '2025-04-10 23:35:04'),
(14, 'sdafdsa', '2025-04-10 23:35:05', '2025-04-10 23:35:05'),
(15, 'ddfs', '2025-04-10 23:46:32', '2025-04-10 23:46:32'),
(16, 'dsf', '2025-04-10 23:46:32', '2025-04-10 23:46:32'),
(17, 'fds', '2025-04-10 23:54:22', '2025-04-10 23:54:22'),
(18, 'sdf', '2025-04-10 23:54:22', '2025-04-10 23:54:22'),
(19, 'Et minus dolor fuga Esse adipisicing', '2025-04-11 09:59:46', '2025-04-11 09:59:46'),
(20, 'fsdf', '2025-04-15 10:02:05', '2025-04-15 10:02:05'),
(21, 'fdsafdsa', '2025-04-15 10:02:05', '2025-04-15 10:02:05'),
(22, '00000000000', '2025-04-15 10:03:16', '2025-04-15 10:03:16'),
(23, '````````', '2025-04-15 10:03:16', '2025-04-15 10:03:16'),
(24, 'dsfdsfdsfdsfds', '2025-04-15 10:05:20', '2025-04-15 10:05:20'),
(25, 'sdfdsf', '2025-04-15 10:05:20', '2025-04-15 10:05:20'),
(26, 'sfdsf', '2025-04-15 10:05:20', '2025-04-15 10:05:20'),
(27, 'hello', '2025-04-15 10:19:19', '2025-04-15 10:19:19'),
(28, 'hello1', '2025-04-15 10:19:52', '2025-04-15 10:19:52'),
(29, 'sdfsdafsafd', '2025-04-15 10:55:52', '2025-04-15 10:55:52'),
(30, 'rwewe', '2025-04-15 10:55:52', '2025-04-15 10:55:52'),
(31, 'sdfsdfsdfdsafsdafsa', '2025-04-15 10:56:19', '2025-04-15 10:56:19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `otp` varchar(255) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `email_verified_at`, `password`, `profile_photo`, `otp`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin0', 'admin0@gmail.com', NULL, '0000', NULL, '0', NULL, '2025-03-24 11:18:39', '2025-03-24 11:21:34'),
(2, 'Tanvir', 'Tanvir@gmail.com', NULL, '1234', NULL, '0', NULL, '2025-03-24 12:01:43', '2025-03-24 12:01:43'),
(3, 'hello', 'hello@admin.com', NULL, '0000', NULL, '0', NULL, '2025-04-06 03:40:16', '2025-04-15 10:58:39'),
(4, 'Nemo ex suscipit sun', 'tume@mailinator.com', NULL, 'Pa$$w0rd!', NULL, '0', NULL, '2025-04-06 03:55:50', '2025-04-06 03:55:50'),
(5, 'admin1', 'admin00@gmail.com', NULL, '111', NULL, '0', NULL, '2025-04-15 09:54:25', '2025-04-15 09:54:25'),
(6, 'sdfsdfdsfds', 'amar56390043@gmail.com', NULL, '1111', NULL, '0', NULL, '2025-04-15 10:18:19', '2025-04-15 10:18:19'),
(7, 'Dolor dolor saepe culpa deserunt excepturi voluptate quam veritatis corporis laboris tempore ullam', 'setekewic@mailinator.com', NULL, '1234', NULL, '0', NULL, '2025-04-15 10:51:58', '2025-04-15 10:51:58'),
(8, 'hellodsaddasddfsa', 'ownbinodon@gmail.com', NULL, '0000', NULL, '0', NULL, '2025-04-15 10:53:32', '2025-04-15 10:53:32'),
(9, 'fdsafsdafsda', 'talozija@mailinator.com', NULL, '1234', NULL, '0', NULL, '2025-04-15 10:54:51', '2025-04-15 10:54:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookmarks_user_id_foreign` (`user_id`),
  ADD KEY `bookmarks_post_id_foreign` (`post_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_post_id_foreign` (`post_id`),
  ADD KEY `comments_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_user_id_foreign` (`user_id`),
  ADD KEY `likes_post_id_foreign` (`post_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_user_id_foreign` (`user_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_tags_post_id_foreign` (`post_id`),
  ADD KEY `post_tags_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_name_unique` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `post_tags`
--
ALTER TABLE `post_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD CONSTRAINT `post_tags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
