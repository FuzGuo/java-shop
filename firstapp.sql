/*
 Navicat Premium Data Transfer

 Source Server         : 123
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : localhost:3306
 Source Schema         : firstapp

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 14/12/2023 12:18:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `local_date_time` datetime NOT NULL COMMENT '日志时间',
  `user_id` int NOT NULL COMMENT '客户id',
  `storage_id` int NOT NULL COMMENT '商品id',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `log_f_userid`(`user_id` ASC) USING BTREE,
  INDEX `log_f_storageid`(`storage_id` ASC) USING BTREE,
  CONSTRAINT `log_f_storageid` FOREIGN KEY (`storage_id`) REFERENCES `storage` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `log_f_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 724 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_croatian_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (668, '2023-12-11 08:49:27', 43, 31, '浏览');
INSERT INTO `log` VALUES (669, '2023-12-11 08:49:27', 43, 32, '浏览');
INSERT INTO `log` VALUES (670, '2023-12-11 08:49:28', 43, 33, '浏览');
INSERT INTO `log` VALUES (671, '2023-12-11 08:49:29', 43, 34, '浏览');
INSERT INTO `log` VALUES (672, '2023-12-11 08:50:05', 43, 31, '浏览');
INSERT INTO `log` VALUES (673, '2023-12-11 08:50:06', 43, 32, '浏览');
INSERT INTO `log` VALUES (674, '2023-12-11 08:50:06', 43, 33, '浏览');
INSERT INTO `log` VALUES (675, '2023-12-11 08:50:07', 43, 34, '浏览');
INSERT INTO `log` VALUES (676, '2023-12-11 09:08:30', 43, 32, '浏览');
INSERT INTO `log` VALUES (677, '2023-12-11 09:08:31', 43, 31, '浏览');
INSERT INTO `log` VALUES (678, '2023-12-11 09:08:32', 43, 34, '浏览');
INSERT INTO `log` VALUES (679, '2023-12-11 09:08:33', 43, 33, '浏览');
INSERT INTO `log` VALUES (680, '2023-12-11 15:30:33', 43, 31, '浏览');
INSERT INTO `log` VALUES (681, '2023-12-11 15:30:36', 43, 32, '浏览');
INSERT INTO `log` VALUES (682, '2023-12-11 15:30:36', 43, 33, '浏览');
INSERT INTO `log` VALUES (683, '2023-12-11 15:30:38', 43, 34, '浏览');
INSERT INTO `log` VALUES (684, '2023-12-11 15:34:14', 43, 31, '浏览');
INSERT INTO `log` VALUES (685, '2023-12-11 15:34:15', 43, 34, '浏览');
INSERT INTO `log` VALUES (686, '2023-12-11 15:34:16', 43, 32, '浏览');
INSERT INTO `log` VALUES (687, '2023-12-11 16:04:46', 43, 31, '浏览');
INSERT INTO `log` VALUES (688, '2023-12-11 16:04:46', 43, 32, '浏览');
INSERT INTO `log` VALUES (689, '2023-12-11 16:04:47', 43, 33, '浏览');
INSERT INTO `log` VALUES (690, '2023-12-11 16:04:48', 43, 34, '浏览');
INSERT INTO `log` VALUES (691, '2023-12-11 22:07:00', 43, 34, '购买');
INSERT INTO `log` VALUES (692, '2023-12-11 22:07:02', 43, 33, '购买');
INSERT INTO `log` VALUES (693, '2023-12-11 22:07:03', 43, 33, '购买');
INSERT INTO `log` VALUES (694, '2023-12-11 22:12:28', 43, 32, '浏览');
INSERT INTO `log` VALUES (695, '2023-12-11 22:12:28', 43, 31, '浏览');
INSERT INTO `log` VALUES (696, '2023-12-11 22:12:29', 43, 33, '浏览');
INSERT INTO `log` VALUES (697, '2023-12-11 22:12:30', 43, 34, '浏览');
INSERT INTO `log` VALUES (698, '2023-12-12 10:19:32', 43, 32, '浏览');
INSERT INTO `log` VALUES (699, '2023-12-12 10:19:33', 43, 31, '浏览');
INSERT INTO `log` VALUES (700, '2023-12-13 19:12:38', 43, 33, '浏览');
INSERT INTO `log` VALUES (701, '2023-12-13 19:12:39', 43, 32, '浏览');
INSERT INTO `log` VALUES (702, '2023-12-13 19:12:40', 43, 31, '浏览');
INSERT INTO `log` VALUES (703, '2023-12-13 19:45:04', 43, 31, '浏览');
INSERT INTO `log` VALUES (704, '2023-12-13 19:45:28', 43, 31, '浏览');
INSERT INTO `log` VALUES (705, '2023-12-13 19:45:29', 43, 31, '浏览');
INSERT INTO `log` VALUES (706, '2023-12-13 19:47:03', 43, 31, '浏览');
INSERT INTO `log` VALUES (707, '2023-12-13 19:47:04', 43, 31, '浏览');
INSERT INTO `log` VALUES (708, '2023-12-13 19:49:25', 43, 31, '浏览');
INSERT INTO `log` VALUES (709, '2023-12-13 19:49:40', 43, 31, '浏览');
INSERT INTO `log` VALUES (710, '2023-12-13 19:49:41', 43, 34, '浏览');
INSERT INTO `log` VALUES (711, '2023-12-13 19:49:42', 43, 32, '浏览');
INSERT INTO `log` VALUES (712, '2023-12-13 19:51:22', 43, 31, '浏览');
INSERT INTO `log` VALUES (713, '2023-12-13 19:51:23', 43, 32, '浏览');
INSERT INTO `log` VALUES (714, '2023-12-13 19:51:31', 43, 31, '浏览');
INSERT INTO `log` VALUES (715, '2023-12-13 19:51:31', 43, 32, '浏览');
INSERT INTO `log` VALUES (716, '2023-12-13 19:53:05', 43, 31, '浏览');
INSERT INTO `log` VALUES (717, '2023-12-13 19:53:05', 43, 32, '浏览');
INSERT INTO `log` VALUES (718, '2023-12-13 19:53:37', 43, 33, '浏览');
INSERT INTO `log` VALUES (719, '2023-12-13 19:53:37', 43, 33, '浏览');
INSERT INTO `log` VALUES (720, '2023-12-13 19:53:46', 43, 31, '浏览');
INSERT INTO `log` VALUES (721, '2023-12-13 19:53:48', 43, 32, '浏览');
INSERT INTO `log` VALUES (722, '2023-12-13 23:20:39', 43, 31, '购买');
INSERT INTO `log` VALUES (723, '2023-12-13 23:20:41', 43, 32, '购买');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `store_id` int NOT NULL,
  `storage_id` int NOT NULL,
  `num` int NOT NULL,
  `ostate` int NOT NULL COMMENT '发货状态：0没发货，1发货，2确认收货',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `custom_id`(`customer_id` ASC) USING BTREE,
  INDEX `order_storage_id`(`storage_id` ASC) USING BTREE,
  INDEX `order_store_id`(`store_id` ASC) USING BTREE,
  CONSTRAINT `custom_id` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_storage_id` FOREIGN KEY (`storage_id`) REFERENCES `storage` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_store_id` FOREIGN KEY (`store_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 481 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_croatian_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (479, 43, 42, 31, 1, 2);
INSERT INTO `order` VALUES (480, 43, 42, 32, 1, 2);

-- ----------------------------
-- Table structure for pay
-- ----------------------------
DROP TABLE IF EXISTS `pay`;
CREATE TABLE `pay`  (
  `user_id` int NOT NULL,
  `pay` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `FK_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay
-- ----------------------------

-- ----------------------------
-- Table structure for storage
-- ----------------------------
DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `store_id` int NULL DEFAULT NULL COMMENT '店家id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL COMMENT '名称',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL COMMENT '品牌',
  `create_time` datetime NULL DEFAULT NULL COMMENT '出厂日期',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL COMMENT '封面地址',
  `state` int NULL DEFAULT NULL COMMENT '是否上架，0否，1是',
  `sales_volume` int NULL DEFAULT 0 COMMENT '销量',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL,
  `style` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `store_id`(`store_id` ASC) USING BTREE,
  CONSTRAINT `store_id` FOREIGN KEY (`store_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_croatian_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of storage
-- ----------------------------
INSERT INTO `storage` VALUES (31, 42, 'Intel core i7-12700k CPU', 1990.00, 'Intel', '2022-06-06 00:00:00', 'http://localhost:9090/files/9a7215105cd84112b51a87d1d3de3bd5', 1, 186, NULL, NULL);
INSERT INTO `storage` VALUES (32, 42, 'NIVIDIA GeForce RTX 4090 GPU', 12000.00, 'NIVIDIA', '2023-09-05 00:00:00', 'http://localhost:9090/files/bbf1caa916014cf8bfccc75224dd0d6c', 1, 274, NULL, NULL);
INSERT INTO `storage` VALUES (33, 42, 'Intel core i9-13900K CPU', 3700.00, 'Intel', '2022-12-06 00:00:00', 'http://localhost:9090/files/84da7444bd03461bb0399efd72259e7a', 1, 144, NULL, NULL);
INSERT INTO `storage` VALUES (34, 42, 'Integral RAM 32GB kit (2X16G) DDR4 2666MHZ', 400.00, 'Integral', '2021-12-06 00:00:00', 'http://localhost:9090/files/3e368df377fe42c49f3cf154eef72827', 1, 135, NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL COMMENT '\r\n用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL,
  `account` decimal(65, 2) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL,
  `role` int NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role`(`role` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_croatian_ci COMMENT = '用户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (42, 'shangjia2', '123', 'sj', 4, '男', 9999.00, '1661391201@qq.com', 2, NULL, NULL);
INSERT INTO `user` VALUES (43, '123', '123', '11', 118, '男', 100000.00, '1661391201@qq.com', 1, NULL, 'http://localhost:9090/files/12eb9915a76d45dc8cbad87efbea60ff');
INSERT INTO `user` VALUES (44, 'admin', '123', 'admin1', 5, '男', 9999.00, '123', 3, NULL, 'http://localhost:9090/files/f8f253b9291b42079c42d69d3c0a4434');
INSERT INTO `user` VALUES (49, 'user2', '123456', 'user', 12, '男', 12.00, 'leannmiss4@gmail.com', 1, NULL, NULL);
INSERT INTO `user` VALUES (50, 'shangjia2', '123456', 'sj', 4, '男', 412.00, '123@123.com', 2, NULL, NULL);
INSERT INTO `user` VALUES (53, 'qweq', '123', '123', NULL, '男', NULL, '123@123.com', 1, NULL, NULL);
INSERT INTO `user` VALUES (56, 'qwer', '123', '123', 0, '男', 100000.00, '123@qq.com', 1, NULL, NULL);
INSERT INTO `user` VALUES (57, '1', '123456', '1', 1, '男', 1.00, '1', 1, NULL, NULL);

-- ----------------------------
-- Table structure for user_storage
-- ----------------------------
DROP TABLE IF EXISTS `user_storage`;
CREATE TABLE `user_storage`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户',
  `storage_id` int NOT NULL COMMENT '商品',
  `num` int NULL DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`user_id`, `storage_id`) USING BTREE,
  INDEX `storage_id`(`storage_id` ASC) USING BTREE,
  CONSTRAINT `storage_id` FOREIGN KEY (`storage_id`) REFERENCES `storage` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_croatian_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_storage
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
