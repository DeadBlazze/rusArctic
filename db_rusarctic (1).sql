-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: MySQL-8.0
-- Время создания: Май 16 2025 г., 12:55
-- Версия сервера: 8.0.41
-- Версия PHP: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `db_rusarctic`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_04_05_110650_create_sessions_table', 1),
(2, '2025_04_05_162532_create_cache_table', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1o6GmxrF4j6TDoRQ51KPog0YxgTj106a7T6pWofB', NULL, '140.82.115.111', 'github-camo (7421f062)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEFuYzFoUW4yNGtoeDh1M3lvMW1oelpjTm1ndnpGRjVveTJaOVJpRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL2Fzc2V0cy9kaWxkby5zdmciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746208757),
('5GGCRA3H1mUH7t1VywwemFdtGkuG6rWcV1rbRvs8', NULL, '127.0.0.1', 'PostmanRuntime/7.43.4', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTGJwSjk1UGRLMDRrdWFuUzFDRzFKWU01ZVdPOWNnajNWcGpqeklQOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4tZ2V0LXRvdXItaW5mbyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1747308031),
('6v5og4VwMQxNGf4V14Tj04STEYFpfdPl7NOkddc8', NULL, '5.255.231.82', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRTRRMDdnNUg4ZkRzVGJoTURGcTRGWW5KU3ZjS0ZrSTJGa1hqQ1oyNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3VzZXItY2FiaW5ldCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746211789),
('bG2GWiWBpjOUD4iMPHUKA5VaTjPlVB9VfaDnae43', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMVdWSkt0WTZOU0NaT2RwM0ZUeDI5OW81UUhOZnlSRTZIYkp0V3dpdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1746232038),
('DbMveylVjwNREQZ0P3NoRmbDTgxDGni4ABPpnzT0', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUUE1THFTYU1LVWFpNk9jSEVEUEE3V3h3bUJnTERtYnhMNTBWblprVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746231864),
('GDxXyKNUxLS8exSFsUoIQSQ0GreURvTWGNsUFOKC', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMFlxcmNVd3ZUdklib2VOcEFmdzFXalE4b1FubWg0TXY3WkFSaWhDeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746231832),
('GiHVToQRnBj7eYu03l5737FOxEQQYYZsxLnxcfrx', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZlFDT0djeWV1VUpoSWRKWG5jb1Jsa2JEeE9vN3dyOHNqdklRMHFsbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1746261599),
('guy5UKo0sF6NQOrqpAZwFf1vBvFnSrOvbm1w4vDP', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZTZPN3gyNXo5c0RtWjk1QklTOGo0RVNZZG1lQWNpQ0NUa2ZUZExtcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1746261405),
('HvRV6yUNdNTAr9myjvDB9dARlt1qbqXsiFHc9NlN', NULL, '1.192.192.6', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNmpsZzA5cmlyNXhpUjBzR3JMaHhWTG9vS0h2OE9mUnBra3JxNkxySCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly93d3cubW9yaWFydGkuc2hvcC9jb25maWcuanNvbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746215795),
('kiWJ24l9d9fsJKm6oFVxetDY3a0niIoTwdqKsCcR', NULL, '92.101.67.128', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 YaBrowser/25.2.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVGQ5YVVmMDdRcnlQSmE4T0ZOWE9XanNqS0ViWThqajVyRnRJaW9sMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL2Fzc2V0cy9kaWxkbyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746208511),
('LHcgGfN5fsqgqPphw3aQmC7SmdPLN0tqNdUfbR62', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzNIbW9hZ1pLc1hZU25USE5LS09FMFNtS0tmRTZVWGUzTjNqbU43ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3dvcmRwcmVzcy93cC1hZG1pbi9zZXR1cC1jb25maWcucGhwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1746231851),
('Lw77cQcvi1nI4BG1rQGtNhy2o9RuFRl193s05SkE', NULL, '5.255.231.176', 'Mozilla/5.0 (compatible; YandexImages/3.0; +http://yandex.com/bots)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnZLMHNPb0NWV3c1d3VaRWxSYVcxY1F1M2dDalJibWxjdFB1VmpDNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wLzctcFRoXzZCczYucG5nIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1746208512),
('PP6hyiHYE8qyweICUqXEshDuDrcqfZgL437JlEDH', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic000a2ZrYUh0MXJ0T1RqcmpWRmVnOHBTZjNwV3F4MTVLcWFLbW12eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746261457),
('rddw0zngKSr2M8CEDEu2EmR01zvelKIVZsroWmE7', NULL, '31.162.4.172', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiamdqREhpWXlwM3ZkdHd2NWNFb2s0OE02aFdqMVB6dWNBdWdUUW5nQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL2Fzc2V0cy9kaWxkbyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746216477),
('rGkEQUXk78RNnXfy537gUT8AX2EdFmGSPSB9qwRX', NULL, '1.192.192.6', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoianB1YXlkdEc2UGl6OXU3bE5VeExoV0xoOWQ3blprdlB4T3dTQUhrYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly93d3cubW9yaWFydGkuc2hvcC9zaXRlbWFwLnhtbCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746215794),
('rmW4YHTJY5zBYtrsULeZUXaA4cmGW1rFuTabFhKb', NULL, '87.250.224.115', 'Mozilla/5.0 (compatible; YandexImages/3.0; +http://yandex.com/bots)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUHo4bVNFd3BneER1bW9lbDhIUVN1Y3V3WG15eDR0ZHBkcDBuRXdHMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL2RpbGRvLnN2ZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746208500),
('vJYFxTUjdY7GbdYg0LvicPk0qznZwqPeqZ0xbUVg', NULL, '213.180.203.60', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidlFndkVqbFI2NktJZjZMSFY3cnByRGJlY3NTUkxWWTNvOHFHbU8zZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL2Fzc2V0cy9kaWxkbyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746216719),
('VvslUtgAhbC7xCnjSxWOWpaHODJwBWdTGhnRtRCx', NULL, '1.192.195.11', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUXhlUlhjcU00S0oza2VNa2tIeGd4RUp5UjhSMzZvMEFaNlBXMzlvZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly93d3cubW9yaWFydGkuc2hvcC9jb25maWcuanNvbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746215983),
('xPwfV7PjFsfsC3Fqy7VeW0FETWmx0IR6pFXa2M5x', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 YaBrowser/25.2.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUHJlNk5FYmttRnVZdGN6NjRBQ2RYY0xYY3hDNWNXMWhiQTJMRkFEVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6NTE3My90b3VycyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746269888),
('y9YoYoKsYxqKfAAQbIdKw29lmkOurV1LMEIfdvIz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 YaBrowser/25.4.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFB2MktFOFhSNmxiMENtVlFOc0tjY0hYV1NJR3o2dzJVZDFxZUVmbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746977423),
('ZFr2rPh4LMWGe7dN4yAPEZWumRR0A46gJFkUFSCF', NULL, '2a06:98c0:3600::103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicGlvR0VCdUNSa1hIWU9mSldaMFJrWVpHSEpBbWdMQjc4U21vM1NMNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3dwLWFkbWluL3NldHVwLWNvbmZpZy5waHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1746261599),
('ZuLyCNTatjm30Dbzhk7WkUu1DroOi6MRnCYfZEkn', NULL, '213.180.203.219', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVoyeld3V0JYTjdFRGsxNGk0QXNJT3ByRm92OVlXMjB5TlJOTmdrVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly9tb3JpYXJ0aS5zaG9wL3RvdXJzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1746211787);

-- --------------------------------------------------------

--
-- Структура таблицы `tours`
--

CREATE TABLE `tours` (
  `id_tour` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `duration` varchar(100) NOT NULL,
  `route` varchar(100) NOT NULL,
  `includes` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` int NOT NULL,
  `is_active` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tours`
--

INSERT INTO `tours` (`id_tour`, `title`, `description`, `duration`, `route`, `includes`, `price`, `is_active`) VALUES
(1, 'Земля Франца-Иосифа: Архипелаг открытий', 'Круиз на современном ледоколе вокруг Земли Франца-Иосифа. Посещение исторических мест, наблюдение за дикой природой (белые медведи, моржи, птицы). Лекции от ученых-арктиковедов. Высадки на острова.', '12 дней / 11 ночей', 'Мурманск – Земля Франца – Иосифа – Мурманск', 'Проживание на ледоколе, питание (полный пансион), экскурсии, лекции, трансферы в Мурманске.', 8500, 1),
(2, 'Путешествие по Белому морю: от Архангельска до Соловков', 'Комбинированный тур: посещение Соловецких островов (история, монастырь, природа), переезд в Архангельск (музеи, деревянное зодчество). Морская прогулка по Белому морю.', '9 дней / 8 ночей', 'Москва – Архангельск – Соловецкие острова – Архангельск – Москва', 'Проживание в отелях, питание (завтраки), экскурсии, трансферы, авиа/жд билеты Москва-Архангельск-Москва.', 1200, 1),
(4, 'Ямальские горизонты: Культура коренных народов Севера', 'Этнографический тур в Ямало-Ненецкий автономный округ. Посещение стойбища оленеводов, знакомство с традициями, мастер-классы по ремеслам. Рыбалка, катание на оленьих упряжках (зимой).', '7 дней / 6 ночей', 'Салехард – стойбище оленеводов – Салехард', 'Проживание в гостевых домах/чумах, питание (традиционная кухня), экскурсии, трансферы, сопровождение гида-переводчика.', 950, 1),
(5, 'Таймыр: Сердце Арктики', 'Путешествие на внедорожниках по полуострову Таймыр. Посещение плато Путорана (объект всемирного наследия ЮНЕСКО), знакомство с культурой долган и нганасан. Рыбалка, сплав по реке (летом).', '14 дней / 13 ночей', 'Норильск – плато Путорана – Норильск', 'Проживание в палатках/гостевых домах, питание (полевая кухня), транспорт (внедорожники), сопровождение гида-инструктора, разрешения на посещение заповедника.', 2500, 1),
(6, 'К Северному полюсу на атомном ледоколе', 'Экспедиция на Северный полюс на атомном ледоколе \'50 лет Победы\'. Погружение на дно Северного Ледовитого океана. Посещение острова Рудольфа (Земля Франца-Иосифа) по пути.', '13 дней / 12 ночей', 'Мурманск – Северный полюс – Земля Франца-Иосифа – Мурманск', 'Проживание на ледоколе (каюты различных классов), питание (полный пансион), все экскурсии и активности на борту, авиаперелет Мурманск-Москва-Мурманск (для некоторых пакетов).', 35000, 1),
(11, 'Карское море: Вдоль арктического побережья', 'Морская экспедиция вдоль северного побережья Сибири. Посещение труднодоступных поселений, наблюдение за китами и морскими птицами, исследование арктической тундры. Высадки на Новосибирские острова.', '15 дней / 14 ночей', 'Архангельск – Карское море – Новосибирские острова – Архангельск', 'Проживание на экспедиционном судне, питание (полный пансион), экскурсии, гиды, трансферы.', 9800, 1),
(12, 'Чукотка: Край земли', 'Путешествие на Чукотку — край суровой красоты. Посещение национальных парков, морское сафари у мыса Дежнёва, знакомство с культурой чукчей и эскимосов. Возможность увидеть полярных медведей.', '10 дней / 9 ночей', 'Анадырь – мыс Дежнёва – Лаврентия – Анадырь', 'Проживание в гостиницах и лагерях, питание, сопровождение гида, внутренние перелёты и трансферы.', 4200, 1),
(13, 'Баренцево море: Легенды Териберки', 'Автотур к берегам Баренцева моря. Посещение поселка Териберка, знакомство с культурой поморов, прогулки вдоль побережья, водопады, арктические пляжи. Наблюдение за северным сиянием (осенью и зимой).', '5 дней / 4 ночи', 'Мурманск – Териберка – Мурманск', 'Проживание в гостиницах, питание (завтраки), трансферы, экскурсионная программа.', 9500, 1),
(14, 'Арктический Урал: Где рождается Север', 'Пешеходно-экспедиционный тур по северной части Уральских гор. Подъёмы на вершины, сплав по горным рекам, посещение местных эвенков и манси, первозданная природа и полное погружение в дикую Арктику.', '11 дней / 10 ночей', 'Инта – Приполярный Урал – Инта', 'Проживание в палатках и базах, питание (походное), транспорт, гиды и сопровождающие.', 1800, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `tours__images`
--

CREATE TABLE `tours__images` (
  `id_tour` int NOT NULL,
  `imagePath` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tours__images`
--

INSERT INTO `tours__images` (`id_tour`, `imagePath`) VALUES
(2, 'arh1.jpg'),
(2, 'arh2.jpg'),
(2, 'arh3.png'),
(2, 'arh4.jpg'),
(4, 'yamal1.jpg'),
(4, 'yamal2.jpg'),
(4, 'yamal3.jpeg'),
(1, 'franca1.jpg'),
(1, 'franca2.jpeg'),
(1, 'franca3.jpeg'),
(1, 'franca4.jpeg'),
(5, 'tymyr1.png'),
(5, 'tymyr2.jpeg'),
(6, 'atom1.jpg'),
(6, 'atom2.webp'),
(6, 'atom3.jpeg'),
(6, 'atom4.webp'),
(11, 'karsk1.webp'),
(11, 'karsk2.webp'),
(12, 'chukotka1.jpg'),
(12, 'chukotka3.jpg'),
(12, 'chukotka2.jpg'),
(13, 'barenz1.jpg'),
(13, 'barenz2.webp'),
(13, 'barenz3.jpg'),
(14, 'ural1.jpg'),
(14, 'ural2.png'),
(14, 'ural3.jpeg'),
(14, 'ural4.webp');

-- --------------------------------------------------------

--
-- Структура таблицы `tours__streams`
--

CREATE TABLE `tours__streams` (
  `id_stream` int NOT NULL,
  `id_tour` int NOT NULL,
  `start_time` date NOT NULL,
  `start_point` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `tours__streams`
--

INSERT INTO `tours__streams` (`id_stream`, `id_tour`, `start_time`, `start_point`) VALUES
(1, 1, '2025-07-27', 'Мурманск'),
(2, 6, '2025-06-25', 'Мурманск'),
(3, 4, '2025-06-14', 'Салехард'),
(4, 5, '2025-08-22', 'Норильск'),
(7, 2, '2025-04-17', 'Москва'),
(8, 2, '2025-07-17', 'Москва'),
(9, 11, '2025-04-22', 'Архангельск'),
(10, 11, '2025-06-29', 'Архангельск'),
(11, 11, '2025-06-14', 'Архангельск'),
(12, 12, '2025-05-26', 'Анадырь'),
(13, 12, '2025-07-17', 'Анадырь'),
(14, 13, '2025-06-14', 'Мурманск'),
(15, 13, '2025-08-22', 'Мурманск'),
(16, 14, '2025-10-10', 'Инта'),
(17, 14, '2025-09-14', 'Инта');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id_user` int NOT NULL,
  `fio` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `tel` varchar(100) NOT NULL,
  `is_admin` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id_user`, `fio`, `email`, `password`, `tel`, `is_admin`) VALUES
(23, 'Фёдор Фёдор Фёдор', 'fedor@fedor.mail', '$2y$12$giLhMAtJbNAwgLZkEq.U5.aq3SEOYpcF4ron0WDJFLDKjHyR.pTp6', '+78888888888', NULL),
(24, 'Антипов Семён Гаврилович', 'semen@sema.com', '$2y$12$T/qAIYCeNeTRAjT/k.dTW.Fl3mUy49qWCc9Arw7YhrA3LqBac1t8G', '87777777777', '1'),
(25, 'Миша Миша Миша', 'misha@misha.misha', '$2y$12$Kaf8f3H7Wasyxopjs1It6.lRaTDX1SaaAuWdEPDvsozfN4vnpb0QW', '+76148696641', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `users__streams`
--

CREATE TABLE `users__streams` (
  `id_user` int NOT NULL,
  `id_stream` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `users__streams`
--

INSERT INTO `users__streams` (`id_user`, `id_stream`, `timestamp`) VALUES
(25, 8, '2025-05-15 05:01:59'),
(25, 2, '2025-05-15 05:02:05'),
(25, 10, '2025-05-15 05:02:21'),
(25, 11, '2025-05-15 05:02:32'),
(25, 1, '2025-05-16 09:50:58'),
(25, 15, '2025-05-16 09:51:19');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Индексы таблицы `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`id_tour`);

--
-- Индексы таблицы `tours__images`
--
ALTER TABLE `tours__images`
  ADD KEY `id_tour` (`id_tour`);

--
-- Индексы таблицы `tours__streams`
--
ALTER TABLE `tours__streams`
  ADD PRIMARY KEY (`id_stream`),
  ADD KEY `id_tour` (`id_tour`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- Индексы таблицы `users__streams`
--
ALTER TABLE `users__streams`
  ADD KEY `id_user` (`id_user`) USING BTREE,
  ADD KEY `id_stream` (`id_stream`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `tours`
--
ALTER TABLE `tours`
  MODIFY `id_tour` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `tours__streams`
--
ALTER TABLE `tours__streams`
  MODIFY `id_stream` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `tours__images`
--
ALTER TABLE `tours__images`
  ADD CONSTRAINT `tours__images_ibfk_1` FOREIGN KEY (`id_tour`) REFERENCES `tours` (`id_tour`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `tours__streams`
--
ALTER TABLE `tours__streams`
  ADD CONSTRAINT `tours__streams_ibfk_1` FOREIGN KEY (`id_tour`) REFERENCES `tours` (`id_tour`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `users__streams`
--
ALTER TABLE `users__streams`
  ADD CONSTRAINT `users__streams_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `users__streams_ibfk_2` FOREIGN KEY (`id_stream`) REFERENCES `tours__streams` (`id_stream`) ON DELETE CASCADE ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
