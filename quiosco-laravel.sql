/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` double NOT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT '1',
  `categoria_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productos_categoria_id_foreign` (`categoria_id`),
  CONSTRAINT `productos_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE `pedidos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `total` double NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedidos_user_id_foreign` (`user_id`),
  CONSTRAINT `pedidos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `pedido_productos`;
CREATE TABLE `pedido_productos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pedido_id` bigint unsigned NOT NULL,
  `producto_id` bigint unsigned NOT NULL,
  `cantidad` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_productos_pedido_id_foreign` (`pedido_id`),
  KEY `pedido_productos_producto_id_foreign` (`producto_id`),
  CONSTRAINT `pedido_productos_pedido_id_foreign` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pedido_productos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `admin`) VALUES
(1, 'Jose Rivas', 'jose@gmail.com', NULL, '$2y$10$hor.MLpSQyVjH0QLECBjeewYrjJRL1yHtUm2KA6vbUMlw1TFl6u4W', NULL, '2023-10-16 05:07:25', '2023-10-16 05:07:25', 1);
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `admin`) VALUES
(2, 'Stefany', 'stefany@gmail.com', NULL, '$2y$10$G3FlkotH1sg808/jS7f9aOPJ72Zqy4AL3.pwyGsVUCZMMECB1WgoG', NULL, '2023-10-16 05:19:33', '2023-10-16 05:19:33', 0);

INSERT INTO `categorias` (`id`, `nombre`, `icono`, `created_at`, `updated_at`) VALUES
(1, 'Café', 'cafe', '2023-10-16 03:54:31', '2023-10-16 03:54:31');
INSERT INTO `categorias` (`id`, `nombre`, `icono`, `created_at`, `updated_at`) VALUES
(2, 'Hamburguesas', 'hamburguesa', '2023-10-16 03:54:31', '2023-10-16 03:54:31');
INSERT INTO `categorias` (`id`, `nombre`, `icono`, `created_at`, `updated_at`) VALUES
(3, 'Pizzas', 'pizza', '2023-10-16 03:54:31', '2023-10-16 03:54:31');
INSERT INTO `categorias` (`id`, `nombre`, `icono`, `created_at`, `updated_at`) VALUES
(4, 'Donas', 'dona', '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(5, 'Pasteles', 'pastel', '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(6, 'Galletas', 'galletas', '2023-10-16 03:54:31', '2023-10-16 03:54:31');

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_01_20_000039_create_categorias_table', 1),
(6, '2023_01_20_223819_create_productos_table', 1),
(7, '2023_01_25_161942_create_pedidos_table', 1),
(8, '2023_01_25_170825_create_pedido_productos_table', 1),
(9, '2023_01_26_175750_add_admin_column_to_users_table', 1);

INSERT INTO `productos` (`id`, `nombre`, `precio`, `imagen`, `disponible`, `categoria_id`, `created_at`, `updated_at`) VALUES
(1, 'Café Caramel con Chocolate', 59.9, 'cafe_01', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31');
INSERT INTO `productos` (`id`, `nombre`, `precio`, `imagen`, `disponible`, `categoria_id`, `created_at`, `updated_at`) VALUES
(2, 'Café Frio con Chocolate Grande', 49.9, 'cafe_02', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31');
INSERT INTO `productos` (`id`, `nombre`, `precio`, `imagen`, `disponible`, `categoria_id`, `created_at`, `updated_at`) VALUES
(3, 'Latte Frio con Chocolate Grande', 54.9, 'cafe_03', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31');
INSERT INTO `productos` (`id`, `nombre`, `precio`, `imagen`, `disponible`, `categoria_id`, `created_at`, `updated_at`) VALUES
(4, 'Latte Frio con Chocolate Grande', 54.9, 'cafe_04', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(5, 'Malteada Fria con Chocolate Grande', 54.9, 'cafe_05', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(6, 'Café Mocha Caliente Chico', 39.9, 'cafe_06', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(7, 'Café Mocha Caliente Grande con Chocolate', 59.9, 'cafe_07', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(8, 'Café Caliente Capuchino Grande', 59.9, 'cafe_08', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(9, 'Café Mocha Caliente Mediano', 49.9, 'cafe_09', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(10, 'Café Mocha Frio con Caramelo Mediano', 49.9, 'cafe_10', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(11, 'Café Mocha Frio con Chocolate Mediano', 49.9, 'cafe_11', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(12, 'Café Espresso', 29.9, 'cafe_12', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(13, 'Café Capuchino Grande con Caramelo', 59.9, 'cafe_13', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(14, 'Café Caramelo Grande', 59.9, 'cafe_14', 1, 1, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(15, 'Paquete de 3 donas de Chocolate', 39.9, 'donas_01', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(16, 'Paquete de 3 donas Glaseadas', 39.9, 'donas_02', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(17, 'Dona de Fresa', 19.9, 'donas_03', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(18, 'Dona con Galleta de Chocolate', 19.9, 'donas_04', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(19, 'Dona glass con Chispas Sabor Fresa', 19.9, 'donas_05', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(20, 'Dona glass con Chocolate', 19.9, 'donas_06', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(21, 'Dona de Chocolate con MÁS Chocolate', 19.9, 'donas_07', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(22, 'Paquete de 3 donas de Chocolate', 39.9, 'donas_08', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(23, 'Paquete de 3 donas con Vainilla y Chocolate', 39.9, 'donas_09', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(24, 'Paquete de 6 Donas', 69.9, 'donas_10', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(25, 'Paquete de 3 Variadas', 39.9, 'donas_11', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(26, 'Dona Natural con Chocolate', 19.9, 'donas_12', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(27, 'Paquete de 3 Donas de Chocolate con Chispas', 39.9, 'donas_13', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(28, 'Dona Chocolate y Coco', 19.9, 'donas_14', 1, 4, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(29, 'Paquete Galletas de Chocolate', 29.9, 'galletas_01', 1, 6, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(30, 'Paquete Galletas de Chocolate y Avena', 39.9, 'galletas_02', 1, 6, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(31, 'Paquete de Muffins de Vainilla', 39.9, 'galletas_03', 1, 6, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(32, 'Paquete de 4 Galletas de Avena', 24.9, 'galletas_04', 1, 6, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(33, 'Galletas de Mantequilla Variadas', 39.9, 'galletas_05', 1, 6, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(34, 'Galletas de sabores frutales', 39.9, 'galletas_06', 1, 6, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(35, 'Hamburguesa Sencilla', 59.9, 'hamburguesas_01', 1, 2, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(36, 'Hamburguesa de Pollo', 59.9, 'hamburguesas_02', 1, 2, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(37, 'Hamburguesa de Pollo y Chili', 59.9, 'hamburguesas_03', 1, 2, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(38, 'Hamburguesa Queso y Pepinos', 59.9, 'hamburguesas_04', 1, 2, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(39, 'Hamburguesa Cuarto de Libra', 59.9, 'hamburguesas_05', 1, 2, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(40, 'Hamburguesa Doble Queso', 69.9, 'hamburguesas_06', 1, 2, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(41, 'Hot Dog Especial', 49.9, 'hamburguesas_07', 1, 2, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(42, 'Paquete 2 Hot Dogs', 69.9, 'hamburguesas_08', 1, 2, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(43, '4 Rebanadas de Pay de Queso', 69.9, 'pastel_01', 1, 5, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(44, 'Waffle Especial', 49.9, 'pastel_02', 1, 5, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(45, 'Croissants De la casa', 39.9, 'pastel_03', 1, 5, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(46, 'Pay de Queso', 19.9, 'pastel_04', 1, 5, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(47, 'Pastel de Chocolate', 29.9, 'pastel_05', 1, 5, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(48, 'Rebanada Pastel de Chocolate', 29.9, 'pastel_06', 1, 5, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(49, 'Pizza Spicy con Doble Queso', 69.9, 'pizzas_01', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(50, 'Pizza Jamón y Queso', 69.9, 'pizzas_02', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(51, 'Pizza Doble Queso', 69.9, 'pizzas_03', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(52, 'Pizza Especial de la Casa', 69.9, 'pizzas_04', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(53, 'Pizza Chorizo', 69.9, 'pizzas_05', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(54, 'Pizza Hawaiana', 69.9, 'pizzas_06', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(55, 'Pizza Tocino', 69.9, 'pizzas_07', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(56, 'Pizza Vegetales y Queso', 69.9, 'pizzas_08', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(57, 'Pizza Pepperoni y Queso', 69.9, 'pizzas_09', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(58, 'Pizza Aceitunas y Queso', 69.9, 'pizzas_10', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31'),
(59, 'Pizza Queso, Jamón y Champiñones', 69.9, 'pizzas_11', 1, 3, '2023-10-16 03:54:31', '2023-10-16 03:54:31');



INSERT INTO `pedidos` (`id`, `user_id`, `total`, `estado`, `created_at`, `updated_at`) VALUES
(1, 1, 209.7, 1, '2023-10-16 05:10:28', '2023-10-16 05:14:23');
INSERT INTO `pedidos` (`id`, `user_id`, `total`, `estado`, `created_at`, `updated_at`) VALUES
(2, 1, 89.8, 0, '2023-10-16 05:13:51', '2023-10-16 05:13:51');
INSERT INTO `pedidos` (`id`, `user_id`, `total`, `estado`, `created_at`, `updated_at`) VALUES
(3, 1, 199.5, 0, '2023-10-16 05:14:49', '2023-10-16 05:14:49');
INSERT INTO `pedidos` (`id`, `user_id`, `total`, `estado`, `created_at`, `updated_at`) VALUES
(4, 1, 49.9, 0, '2023-10-16 05:18:17', '2023-10-16 05:18:17'),
(5, 2, 39.9, 0, '2023-10-16 05:20:22', '2023-10-16 05:20:22');

INSERT INTO `pedido_productos` (`id`, `pedido_id`, `producto_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(1, 1, 42, 2, '2023-10-16 05:10:28', '2023-10-16 05:10:28');
INSERT INTO `pedido_productos` (`id`, `pedido_id`, `producto_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(2, 1, 59, 1, '2023-10-16 05:10:28', '2023-10-16 05:10:28');
INSERT INTO `pedido_productos` (`id`, `pedido_id`, `producto_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(3, 2, 14, 1, '2023-10-16 05:13:51', '2023-10-16 05:13:51');
INSERT INTO `pedido_productos` (`id`, `pedido_id`, `producto_id`, `cantidad`, `created_at`, `updated_at`) VALUES
(4, 2, 48, 1, '2023-10-16 05:13:51', '2023-10-16 05:13:51'),
(5, 3, 41, 1, '2023-10-16 05:14:49', '2023-10-16 05:14:49'),
(6, 3, 58, 1, '2023-10-16 05:14:49', '2023-10-16 05:14:49'),
(7, 3, 28, 2, '2023-10-16 05:14:49', '2023-10-16 05:14:49'),
(8, 3, 33, 1, '2023-10-16 05:14:49', '2023-10-16 05:14:49'),
(9, 4, 9, 1, '2023-10-16 05:18:17', '2023-10-16 05:18:17'),
(10, 5, 34, 1, '2023-10-16 05:20:22', '2023-10-16 05:20:22');

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 1, 'token', '301ed6c378fb4fb4d6717aa3ba38ef838841da088f7a8cf7e51c2f29dbdbb540', '[\"*\"]', '2023-10-16 05:09:47', NULL, '2023-10-16 05:09:46', '2023-10-16 05:09:47');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(4, 'App\\Models\\User', 1, 'token', '277bc99915995c6281120cf9bab44d0a52049e902f1d1e0c06092f657a08bb1e', '[\"*\"]', '2023-10-16 05:11:49', NULL, '2023-10-16 05:11:06', '2023-10-16 05:11:49');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(6, 'App\\Models\\User', 1, 'token', '397fc162b9b06b70f78cf27b9fe4044b0828aea5c01498ea13e7383b1179a1f9', '[\"*\"]', '2023-10-16 05:12:43', NULL, '2023-10-16 05:12:40', '2023-10-16 05:12:43');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(9, 'App\\Models\\User', 1, 'token', '3cadaa2318e3ab11157c80612124df2c476a8f04c5ae8507c617af73aa464288', '[\"*\"]', '2023-10-16 05:15:18', NULL, '2023-10-16 05:15:06', '2023-10-16 05:15:18'),
(12, 'App\\Models\\User', 1, 'token', '5fa3c35f73210a7345db81687b34613a840b982de6df946831a7385d70eb1fe9', '[\"*\"]', '2023-10-16 05:20:37', NULL, '2023-10-16 05:20:37', '2023-10-16 05:20:37'),
(13, 'App\\Models\\User', 1, 'token', '2256d5f141a6c22200ce57e04daa7b31d381dad8d001db7e541baa7d86a293aa', '[\"*\"]', '2023-10-16 05:42:13', NULL, '2023-10-16 05:20:37', '2023-10-16 05:42:13');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;