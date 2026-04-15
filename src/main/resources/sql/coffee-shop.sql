/*
 Navicat Premium Dump SQL

 Source Server         : Database
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : coffee-shop

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 16/04/2026 04:32:00
*/


-- ----------------------------
-- 创建数据库并指定 utf8mb4 字符集，彻底防止生僻汉字与乱码问题
-- ----------------------------
CREATE DATABASE IF NOT EXISTS `coffee-shop` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `coffee-shop`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '收货地址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '手机号码',
  `is_default` int NULL DEFAULT NULL COMMENT '是否默认【1:是】【0:否】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '收货地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 2, '张三', '浙江省杭州市XXX区XXX街道999号', '17879540000', 1);
INSERT INTO `address` VALUES (2, 2, '张三', '浙江省温州市鹿城区五马街', '17879540000', 0);
INSERT INTO `address` VALUES (8, 3, '李四', '浙江省温州市瓯海区温州商学院', '17877779999', 1);
INSERT INTO `address` VALUES (10, 1, 'Wen', 'wzbc', '15067722388', 0);
INSERT INTO `address` VALUES (11, 4, 'hgl', 'wzbc', '17757736800', 1);
INSERT INTO `address` VALUES (12, 4, 'hgl', 'wzbc1', '17757736800', 0);

-- ----------------------------
-- Table structure for ai_chat_message
-- ----------------------------
DROP TABLE IF EXISTS `ai_chat_message`;
CREATE TABLE `ai_chat_message`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息角色: user/ai',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息内容',
  `provider` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'AI提供商: deepseek/gemini',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'AI聊天记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ai_chat_message
-- ----------------------------
INSERT INTO `ai_chat_message` VALUES (77, 2, 'user', '推荐一款咖啡', 'deepseek', '2026-01-13 16:15:00');
INSERT INTO `ai_chat_message` VALUES (78, 2, 'ai', '您好！我是咖咖，很高兴为您推荐咖啡☕✨\n\n为了给您最合适的推荐，可以告诉我您的口味偏好吗？比如：\n- 喜欢果酸明亮还是醇厚低酸？\n- 偏爱花香果香还是坚果巧克力风味？\n- 想喝热饮还是冰饮？\n\n期待您的回复，帮您找到心仪的那一杯💫', 'deepseek', '2026-01-13 16:15:00');
INSERT INTO `ai_chat_message` VALUES (79, 2, 'user', '卡布奇诺什么味道', 'deepseek', '2026-01-13 16:15:11');
INSERT INTO `ai_chat_message` VALUES (80, 2, 'ai', '卡布奇诺是浓缩咖啡+蒸奶+厚奶泡的经典组合，口感绵密顺滑！☕ 奶泡像云朵一样柔软，入口先是浓郁的咖啡香，接着是牛奶的香甜，最后留下绵密的触感。\n\n我们店里的「晨曦之舞」卡布就是经典风味，奶泡超厚超满足！如果你喜欢果香更突出的，可以试试「赤道之韵」，用了非洲豆底，会带一点明亮的果酸哦～✨\n\n你平时喜欢奶味重一点，还是咖啡味更突出的口感呢？', 'deepseek', '2026-01-13 16:15:11');
INSERT INTO `ai_chat_message` VALUES (81, 2, 'user', '怎么冲泡咖啡', 'deepseek', '2026-01-13 16:15:12');
INSERT INTO `ai_chat_message` VALUES (82, 2, 'ai', '您好！我是咖咖，很高兴为您介绍咖啡冲泡方法☕\n\n我们有几种常见冲泡方式：\n**手冲咖啡**：适合喜欢清爽口感，能品尝到咖啡豆本身风味的朋友。水温88-94℃，研磨度像砂糖颗粒，先闷蒸30秒再分段注水✨\n\n**法压壶**：操作简单，能保留咖啡油脂，口感醇厚。用粗研磨咖啡粉，热水浸泡4分钟即可🫘\n\n**摩卡壶**：适合喜欢浓郁口感的家庭使用，能做出类似意式的咖啡🌿\n\n您平时喜欢什么口味的咖啡呢？我可以根据您的喜好推荐最适合的冲泡方式！', 'deepseek', '2026-01-13 16:15:12');
INSERT INTO `ai_chat_message` VALUES (91, 1, 'user', '推荐一款咖啡', 'deepseek', '2026-01-22 13:42:14');
INSERT INTO `ai_chat_message` VALUES (92, 1, 'ai', '您好！我是咖咖，很高兴为您推荐咖啡 ☕✨\n\n为了给您最合适的推荐，可以告诉我您喜欢什么样的口味吗？比如：\n- 喜欢果酸明亮还是醇厚低酸？\n- 偏爱花香果香还是巧克力坚果调？\n- 想喝意式奶咖还是手冲单品？\n\n期待您的回复，帮您找到那杯命中注定的咖啡！💫', 'deepseek', '2026-01-22 13:42:14');
INSERT INTO `ai_chat_message` VALUES (93, 1, 'user', '怎么冲泡咖啡', 'deepseek', '2026-02-07 19:34:05');
INSERT INTO `ai_chat_message` VALUES (94, 1, 'ai', '您好！我是咖咖，很高兴为您介绍咖啡冲泡方法☕✨\n\n**常用冲泡方式：**\n1️⃣ **手冲咖啡**：适合喜欢干净明亮风味的您\n   - 研磨度：中细（如砂糖）\n   - 水温：88-94℃\n   - 比例：1:15（咖啡粉:水）\n   - 技巧：先闷蒸30秒，再分2-3段注水\n\n2️⃣ **法压壶**：适合喜欢醇厚口感的您\n   - 研磨度：粗（如粗砂）\n   - 水温：93-96℃\n   - 时间：浸泡4分钟\n\n3️⃣ **摩卡壶**：适合喜欢浓郁风味的您\n   - 研磨度：中细\n   - 可制作接近意式的浓缩感\n\n**小贴士**：不同产地咖啡适合不同冲泡方式哦！比如非洲豆用手冲更能展现花果香，而曼特宁用法压更显醇厚🌿\n\n您平时喜欢什么风味的咖啡呢？我可以为您推荐更具体的冲泡方案！', 'deepseek', '2026-02-07 19:34:05');
INSERT INTO `ai_chat_message` VALUES (95, 2, 'user', '推荐一款咖啡', 'deepseek', '2026-03-06 22:49:52');
INSERT INTO `ai_chat_message` VALUES (96, 2, 'ai', '您好！我是咖咖，很高兴为您推荐咖啡 ☕✨\n\n为了给您最合适的推荐，可以告诉我您喜欢什么口味吗？比如：\n- 喜欢果酸明亮还是醇厚低酸？\n- 喜欢奶咖还是黑咖啡？\n- 今天想尝试什么风格？\n\n或者我可以先为您介绍几款人气选择：\n🌿「晨曦之舞」卡布奇诺 - 绵密奶泡，经典柔和\n🫘「阳光之舞」单品 - 哥伦比亚豆，焦糖坚果风味\n💫「冰封之心」冷萃 - 顺滑甘甜，夏日清爽\n\n您更倾向哪一种呢？', 'deepseek', '2026-03-06 22:49:52');
INSERT INTO `ai_chat_message` VALUES (97, 1, 'user', '推荐一款咖啡', 'deepseek', '2026-03-11 16:39:43');
INSERT INTO `ai_chat_message` VALUES (98, 1, 'ai', '您好！我是咖咖，很高兴为您推荐咖啡☕️✨\n\n为了给您最合适的推荐，可以告诉我您的口味偏好吗？比如：\n- 喜欢酸一点还是苦一点的？\n- 喜欢果香、花香还是巧克力坚果风味？\n- 平时喝奶咖多还是黑咖啡？\n\n期待您的回复，帮您找到那杯命中注定的咖啡💫', 'deepseek', '2026-03-11 16:39:43');
INSERT INTO `ai_chat_message` VALUES (99, 2, 'user', '推荐一款咖啡', 'deepseek', '2026-03-15 11:39:03');
INSERT INTO `ai_chat_message` VALUES (100, 2, 'ai', '您好！我是咖咖，很高兴为您推荐咖啡☕\n\n为了给您最合适的推荐，可以告诉我您喜欢什么样的口味吗？比如：\n- 喜欢果酸明亮还是醇厚低酸？\n- 偏爱花香果香还是坚果巧克力风味？\n- 想喝热的还是冰的？\n\n或者您可以直接告诉我您的偏好，我来为您匹配最适合的咖啡✨', 'deepseek', '2026-03-15 11:39:03');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `commodity_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `count` int NULL DEFAULT NULL COMMENT '数量',
  `add_time` datetime NULL DEFAULT NULL COMMENT '加入购物车时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '购物车' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (40, 3, 11, 12, '2025-06-21 12:32:34');
INSERT INTO `cart` VALUES (42, 3, 9, 5, '2025-06-21 12:32:36');
INSERT INTO `cart` VALUES (55, 4, 6, 1, '2025-06-22 10:46:18');
INSERT INTO `cart` VALUES (68, 1, 10, 15, '2026-03-06 22:44:18');
INSERT INTO `cart` VALUES (69, 1, 11, 1, '2026-03-06 22:44:24');
INSERT INTO `cart` VALUES (70, 1, 8, 5, '2026-03-06 23:46:16');

-- ----------------------------
-- Table structure for classify
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '归类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classify
-- ----------------------------
INSERT INTO `classify` VALUES (1, '卡布其诺', '2025-06-05 11:52:25');
INSERT INTO `classify` VALUES (2, '冰咖啡', '2025-06-05 11:52:37');
INSERT INTO `classify` VALUES (3, '摩卡咖啡', '2025-06-05 11:52:54');
INSERT INTO `classify` VALUES (4, '阿拉比卡咖啡', '2025-06-05 11:53:08');
INSERT INTO `classify` VALUES (5, '罗布斯塔', '2025-06-21 11:41:00');
INSERT INTO `classify` VALUES (6, '刚果咖啡', '2025-06-21 11:41:14');
INSERT INTO `classify` VALUES (7, '蓝山咖啡', '2025-06-21 11:41:29');
INSERT INTO `classify` VALUES (8, '夏威夷卡曼', '2025-06-21 11:41:41');
INSERT INTO `classify` VALUES (9, '印度曼特宁', '2025-06-21 11:41:55');
INSERT INTO `classify` VALUES (10, '乌干达咖啡', '2025-06-21 11:42:08');
INSERT INTO `classify` VALUES (11, '哥伦比亚咖啡', '2025-06-21 11:42:51');

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `commodity_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `add_time` datetime NULL DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collection
-- ----------------------------
INSERT INTO `collection` VALUES (24, 2, 11, '2025-06-21 12:12:11');
INSERT INTO `collection` VALUES (25, 2, 10, '2025-06-21 12:12:12');
INSERT INTO `collection` VALUES (26, 2, 6, '2025-06-21 12:12:18');
INSERT INTO `collection` VALUES (27, 3, 11, '2025-06-21 12:30:17');
INSERT INTO `collection` VALUES (28, 3, 10, '2025-06-21 12:30:21');
INSERT INTO `collection` VALUES (29, 3, 8, '2025-06-21 12:30:27');
INSERT INTO `collection` VALUES (30, 3, 6, '2025-06-21 12:30:32');
INSERT INTO `collection` VALUES (33, 1, 10, '2025-11-22 10:18:42');
INSERT INTO `collection` VALUES (34, 1, 6, '2026-03-27 17:48:40');
INSERT INTO `collection` VALUES (35, 2, 28, '2026-04-16 04:08:09');

-- ----------------------------
-- Table structure for commodity
-- ----------------------------
DROP TABLE IF EXISTS `commodity`;
CREATE TABLE `commodity`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品名称',
  `info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '商品简介',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '商品描述',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '颜色',
  `material` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '原材料',
  `origin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '产地',
  `classify_id` int NULL DEFAULT NULL COMMENT '商品分类ID',
  `original_price` decimal(5, 2) NULL DEFAULT NULL COMMENT '原价',
  `current_price` decimal(5, 2) NULL DEFAULT NULL COMMENT '现价',
  `inventory` int NULL DEFAULT NULL COMMENT '库存',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '上架时间',
  `status` int NULL DEFAULT 1 COMMENT '状态【1:上架】【0:下架】',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品图片地址',
  `sale_count` int NULL DEFAULT 0 COMMENT '销量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sale_count`(`sale_count` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commodity
-- ----------------------------
INSERT INTO `commodity` VALUES (6, '「晨曦之舞」', '「晨曦之舞」是一款精致而富有诗意的卡布其诺咖啡豆。栽培于哥伦比亚的高海拔地区，这些咖啡豆经过精心挑选和烘焙，以确保每一杯都带来令人陶醉的味觉体验。「晨曦之舞」的浓郁口感融合了柔和的巧克力和坚果的风味，香气中透露着轻盈的水果和花香。无论是早晨的第一杯咖啡还是午后放松的时刻，「晨曦之舞」都能带给你温暖、愉悦的享受。', '「晨曦之舞」，一袋来自哥伦比亚的卡布其诺咖啡豆，带来了一场美妙的晨曦之舞。这些深棕色的咖啡豆散发着诱人的香气，仿佛清晨初露的第一缕阳光。每一颗豆子都经过精心挑选和烘焙，保留了卡布其诺咖啡独特的风味特点。品尝「晨曦之舞」，你会感受到浓郁的巧克力和坚果的滋味，伴随着轻柔的水果和花香，每一口都如同在优雅的舞蹈中徜徉。无论是与朋友分享欢乐的时刻，还是独自享受宁静的时光，「晨曦之舞」都会为你带来温暖、愉悦的咖啡体验，让你沉浸在一片美好的晨曦中。', '深棕色', '阿拉比卡咖啡豆', '哥伦比亚', 1, 99.00, 79.00, 76, '2026-01-29 21:40:11', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/1.png', 24);
INSERT INTO `commodity` VALUES (7, '「秘境之韵」', '「秘境之韵」是一款珍贵而迷人的乌干达咖啡。这些咖啡豆生长在乌干达的高海拔地区，经过精心挑选和精湛的烘焙工艺，展现出了它们独特的品质。「秘境之韵」散发着浓郁的巧克力和坚果的香气，口感饱满顺滑，带来一种令人陶醉的感受。无论是悠闲地品味一杯，还是与朋友分享美好时光，「秘境之韵」都能带给你独特而深沉的咖啡体验。', '「秘境之韵」，一袋来自乌干达的顶级咖啡豆，诠释着这片神秘土地的独特韵味。这些深沉的棕褐色咖啡豆散发着浓郁的香气，仿佛置身于乌干达的广袤大地。每一颗豆子都经过精心挑选和精湛的烘焙工艺，保留了乌干达咖啡的独特风味。品尝「秘境之韵」，你会感受到浓郁的巧克力和坚果的口感，带来舌尖上的愉悦与满足。无论是沉浸在宁静的早晨，还是享受夜晚的宁静时刻，「秘境之韵」都将为你带来一场独特的咖啡冒险，让你感受到大地的沉静与厚重，品味乌干达的秘境之美。', '棕褐色', '阿拉比卡', '乌干达', 10, 109.00, 99.00, 7, '2025-06-21 23:31:49', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/6.png', 9);
INSERT INTO `commodity` VALUES (8, '「阳光之舞」', '「阳光之舞」是一款优雅而充满阳光气息的哥伦比亚咖啡。这些咖啡豆生长于哥伦比亚的高海拔地区，经过精心挑选和烘焙，展现出了它们独特的风味。「阳光之舞」的口感醇厚且平衡，带来了令人陶醉的味觉体验。无论是早晨的第一杯咖啡还是午后的放松时光，「阳光之舞」都能为你带来温暖、愉悦的享受。', '「阳光之舞」，一袋来自哥伦比亚的卓越咖啡豆，散发着温暖阳光的气息。这些深棕色的咖啡豆经过精心挑选和烘焙，保留了哥伦比亚咖啡独特的风味特点。「阳光之舞」的口感醇厚，带有巧克力和坚果的风味，伴随着轻盈的花香和水果香。无论是在早晨开始新的一天，还是在午后与朋友分享美好时刻，「阳光之舞」都能为你带来令人陶醉的味觉体验，让你沉浸在温暖阳光中跳跃的舞蹈中。', '深棕色', '阿拉比卡', '哥伦比亚', 11, 88.00, 60.00, 2, '2025-06-21 23:48:30', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/3.png', 14);
INSERT INTO `commodity` VALUES (9, '「冰封之心」', '「冰封之心」是一款清新纯净的冰咖啡。这种独特的制作方式，使得咖啡豆的香气和口感更为浓郁，同时又不失清爽。无论是在炎炎夏日的午后还是加班疲惫的晚上，「冰封之心」都能为你带来一份清凉活力。', '「冰封之心」，一款清新纯净的冰咖啡。这种独特的制作方式，使得咖啡豆的香气和口感更为浓郁，同时又不失清爽。「冰封之心」独特的口感和香气，仿佛将冰雪的清凉和阳光的温暖融合在一起。无论是搭配甜品、沙拉，还是单独享用，「冰封之心」都能带给你一份清新纯净的味觉体验，让你的味蕾在冰凉中舒爽地展开', '明亮透明', '阿拉比卡', '巴西、哥伦比亚、埃塞俄比亚等', 2, 129.00, 99.00, 6, '2026-01-29 21:39:44', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/2.png', 2);
INSERT INTO `commodity` VALUES (10, '「巧克力之梦」', '「巧克力之梦」是一款浓郁而诱人的摩卡咖啡。这款咖啡融合了咖啡和巧克力的美妙组合，带来了独特的口感和香气。「巧克力之梦」让你仿佛置身于巧克力的世界中，感受到甜蜜与满足。', '「巧克力之梦」，一款浓郁而诱人的摩卡咖啡。这款咖啡融合了咖啡和巧克力的美妙组合，带来了独特的口感和香气。「巧克力之梦」的浓郁巧克力味与咖啡的醇厚回味相互交织，让你沉浸在无尽的味觉享受中。无论是早晨的第一杯咖啡还是下午休憩时光，「巧克力之梦」都能为你带来一份甜蜜、诱人的美味体验，让你的味蕾沉醉在巧克力的梦境中。', '深褐色', '阿拉比卡', '巴西、哥伦比亚等', 3, 100.00, 50.00, 93, '2025-06-12 13:17:27', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/4.png', 7);
INSERT INTO `commodity` VALUES (11, '「赤道之韵」', '「赤道之韵」是一款充满活力和个性的刚果咖啡。这种咖啡以其深邃的口感和丰富的香气而著称。赤道之韵的咖啡豆种植于刚果的高海拔地区，得益于赤道地理位置的优势，享受到丰富的阳光和充沛的降雨。无论是清晨的第一口还是下午的小憩，赤道之韵都能为你带来一份充满活力和个性的咖啡体验，让你的味蕾沉浸在源自赤道大陆的热情与魅力中。', '「赤道之韵」一款充满活力和个性的刚果咖啡。这种咖啡以其深邃的口感和丰富的香气而著称。赤道之韵的咖啡豆在刚果的阳光和热带气候中茁壮成长，成为一款独具特色的咖啡作品。无论是清晨的第一口还是下午的小憩，赤道之韵都能为你带来一份充满活力和个性的咖啡体验，让你的味蕾沉浸在源自赤道大陆的热情与魅力中。', '深棕色', '刚果咖啡豆', '刚果高海拔地区', 1, 59.00, 50.00, 3, '2025-06-21 23:21:43', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/5.png', 6);
INSERT INTO `commodity` VALUES (12, '「翡翠庄园」', '「翡翠庄园」是一款来自埃塞俄比亚的顶级阿拉比卡咖啡豆。生长于海拔1800米以上的高原产区，日夜温差大，赋予了咖啡豆丰富的层次感。入口有明亮的柑橘酸质，中段呈现蜂蜜般的甜感，回甘悠长带有茉莉花香，是一款极具辨识度的精品咖啡。', '「翡翠庄园」，源自埃塞俄比亚耶加雪菲产区的臻选阿拉比卡咖啡豆。这些翠绿色的生豆经过浅中度烘焙后，散发出迷人的花果香气。品尝「翡翠庄园」，你会先感受到柑橘和柠檬的明亮酸质，紧接着是蜂蜜与红茶的圆润甜感，最后在舌尖留下茉莉花和佛手柑的优雅余韵。这是一款值得细细品味的咖啡，适合手冲或虹吸壶冲泡，让每一个风味层次都得到完美展现。', '浅棕色', '阿拉比卡咖啡豆', '埃塞俄比亚', 4, 128.00, 99.00, 50, '2026-02-15 10:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/3.png', 8);
INSERT INTO `commodity` VALUES (13, '「丛林之力」', '「丛林之力」是一款风味浓烈的罗布斯塔咖啡豆。产自越南中央高原的优质庄园，这款咖啡以其强劲的醇厚度和低酸度著称。浓郁的坚果和黑巧克力风味，搭配厚实的油脂感，特别适合制作意式浓缩和越南冰咖啡，给你满满的能量与活力。', '「丛林之力」，一款来自越南中央高原的顶级罗布斯塔咖啡豆。与阿拉比卡不同，罗布斯塔以其强劲有力的口感闻名于世。「丛林之力」经过深度烘焙后，展现出浓烈的黑巧克力和烟熏坚果风味，咖啡因含量更高，油脂更丰富。无论是制作一杯浑厚的意式浓缩，还是搭配炼乳制成经典越南冰咖啡，「丛林之力」都能带给你无与伦比的醇厚体验和充沛精力。', '深黑色', '罗布斯塔咖啡豆', '越南', 5, 69.00, 49.00, 100, '2026-02-20 14:30:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/6.png', 15);
INSERT INTO `commodity` VALUES (14, '「刚果之魂」', '「刚果之魂」是一款来自刚果基伍湖畔的精品咖啡。种植于火山土壤之上，得天独厚的矿物质赋予了这款咖啡独特的风味。口感圆润饱满，带有黑莓和黑加仑的果香，尾韵呈现可可和香料的温暖气息，是非洲咖啡中的隐藏瑰宝。', '「刚果之魂」，一款来自非洲心脏地带的珍稀咖啡豆。刚果民主共和国的基伍湖产区，拥有火山地质和热带雨林气候的双重恩赐。「刚果之魂」的咖啡豆在海拔1500米的火山坡地上自然成熟，经过水洗处理后保留了纯净的风味本质。品尝这款咖啡，你会感受到黑莓和黑加仑的浓郁果香，中段是丝滑的可可和太妃糖甜感，收尾带有肉桂和丁香的温暖香料气息。每一口都在诉说着这片神秘大陆的故事。', '深褐色', '刚果咖啡豆', '刚果基伍湖产区', 6, 119.00, 89.00, 30, '2026-03-01 09:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/5.png', 3);
INSERT INTO `commodity` VALUES (15, '「蓝山之巅」', '「蓝山之巅」是一款产自牙买加蓝山山脉的殿堂级咖啡。蓝山咖啡被誉为咖啡中的极品，以其完美的平衡感著称——酸、甜、苦三者和谐共存，毫无突兀。醇厚丝滑的口感搭配淡雅的花香和坚果甜感，是真正的咖啡鉴赏家之选。', '「蓝山之巅」，源自牙买加蓝山山脉海拔2100米以上的顶级产区。蓝山咖啡之所以享誉全球，在于其无与伦比的平衡感：柔和的果酸、丝滑的醇厚和恰到好处的甘甜交织在一起，形成了近乎完美的味觉体验。「蓝山之巅」采用日晒处理法，最大限度保留了咖啡樱桃的天然甜感。细饮之下，你能品味到杏仁、奶油和淡淡的蓝莓气息，余韵绵长清雅，仿佛置身于蓝山的云雾之巅。全球年产量极为稀少，每一颗豆子都弥足珍贵。', '浅棕色', '蓝山咖啡豆', '牙买加', 7, 168.00, 138.00, 15, '2026-03-05 11:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/1.png', 6);
INSERT INTO `commodity` VALUES (16, '「火山之吻」', '「火山之吻」是一款来自夏威夷科纳海岸的精品咖啡。生长在毛纳罗亚火山肥沃的斜坡上，享受着太平洋温润的海风和火山云层的天然遮荫。口感如丝绸般顺滑，带有焦糖和澳洲坚果的甜香，酸度柔和而不失活泼，是夏威夷阳光的完美诠释。', '「火山之吻」，一款源自夏威夷大岛科纳海岸的顶级咖啡豆。科纳咖啡是全球最珍贵的咖啡品种之一，仅在夏威夷大岛西侧狭长的科纳咖啡带上种植。「火山之吻」的咖啡树扎根于毛纳罗亚火山上千年积累的矿物质丰富土壤中，每天享受着上午的阳光和下午火山云层带来的天然遮荫。这种独特的微气候赋予了咖啡豆无可比拟的风味——入口是焦糖和澳洲坚果的甜润，中段浮现热带水果的活泼酸质，收尾留下蜂蜜和香草的温柔余韵。', '金棕色', '科纳咖啡豆', '美国夏威夷', 8, 158.00, 128.00, 20, '2026-03-10 15:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/2.png', 4);
INSERT INTO `commodity` VALUES (17, '「苏门答腊之夜」', '「苏门答腊之夜」是一款来自印尼苏门答腊岛的经典曼特宁咖啡。以其沉稳厚重的口感著称于世，几乎零酸度，浓郁的草本和泥土芬芳融合着黑巧克力和烟草的深邃风味。这是一款属于深夜独处时光的咖啡，沉静、深沉、耐人寻味。', '「苏门答腊之夜」，一款来自印度尼西亚苏门答腊岛北部林东产区的黄金曼特宁咖啡豆。曼特宁咖啡以其独特的湿刨处理法闻名于世，这种古老的加工方式赋予了咖啡豆与众不同的醇厚风味。「苏门答腊之夜」经过中深度烘焙后，展现出深沉的泥土和草本芬芳，伴随着黑巧克力、烟草叶和松木的复杂层次。口感厚重如天鹅绒，几乎感受不到酸度，取而代之的是绵长持久的苦甜回甘。适合法压壶或滴滤冲泡，在安静的夜晚细细品味，如同聆听苏门答腊热带雨林的低语。', '墨绿色', '曼特宁咖啡豆', '印度尼西亚', 9, 108.00, 79.00, 40, '2026-03-15 08:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/4.png', 10);
INSERT INTO `commodity` VALUES (18, '「月光序曲」', '「月光序曲」是一款浪漫优雅的卡布其诺咖啡豆。选用巴西圣保罗产区的精品豆，中度烘焙后呈现柔和的奶油巧克力风味，搭配绵密奶泡后口感如月光般轻柔。低酸度高甜感，适合喜欢温柔口感的咖啡爱好者。', '「月光序曲」，一款源自巴西圣保罗高原的卡布其诺咖啡豆。这片阳光充沛的产区赋予了咖啡豆天然的甜感和圆润的口感。经过中度烘焙后，「月光序曲」展现出奶油巧克力和烤杏仁的温暖风味，酸度极低，甜度突出。制成卡布其诺后，浓郁的咖啡底韵与绵密的奶泡完美融合，每一口都像月光洒落般温柔。适合在安静的午后或浪漫的夜晚，给自己一份优雅的享受。', '中棕色', '阿拉比卡咖啡豆', '巴西', 1, 89.00, 69.00, 60, '2026-03-20 09:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/2.png', 11);
INSERT INTO `commodity` VALUES (19, '「维也纳之晨」', '「维也纳之晨」是一款经典欧式风格的卡布其诺咖啡豆。灵感来自维也纳百年咖啡馆文化，选用危地马拉安提瓜产区的优质豆，口感醇厚均衡，带有蜂蜜和榛果的甜香，配上厚厚的奶泡就是一杯完美的维也纳式卡布其诺。', '「维也纳之晨」，致敬维也纳百年咖啡文化的经典之作。选用危地马拉安提瓜火山产区的精品咖啡豆，得益于火山土壤的丰富矿物质，这款咖啡豆拥有极其均衡的口感。中深度烘焙后呈现浓郁的蜂蜜、榛果和淡淡的烟熏气息，制成卡布其诺后醇厚中带有优雅的甜感。仿佛置身于维也纳老城的咖啡馆中，听着华尔兹的旋律，品味一杯传承百年的经典。', '深棕色', '阿拉比卡咖啡豆', '危地马拉', 1, 95.00, 75.00, 45, '2026-03-22 10:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/4.png', 9);
INSERT INTO `commodity` VALUES (20, '「极地冰泉」', '「极地冰泉」是一款极致清爽的冰咖啡。采用冷萃工艺，将精选的肯尼亚AA级咖啡豆在低温下浸泡18小时，萃取出纯净而浓缩的咖啡液。口感清冽如冰泉，带有黑醋栗和柠檬的明亮酸质，回甘带有红糖的甜感，是炎夏解暑的不二之选。', '「极地冰泉」，采用精选肯尼亚AA级咖啡豆，通过18小时低温冷萃工艺精制而成。冷萃法最大限度地减少了苦涩物质的萃取，同时保留了咖啡豆最精华的风味分子。品尝「极地冰泉」，你会首先感受到黑醋栗和柠檬的清新酸质，接着是红糖和焦糖的圆润甜感，收尾留下干净利落的回甘。无需加糖加奶即可享受其天然的甜美，加入冰块后更是清爽宜人，每一口都像极地冰泉般纯净透彻。', '琥珀色', '肯尼亚AA咖啡豆', '肯尼亚', 2, 109.00, 85.00, 35, '2026-03-18 14:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/3.png', 8);
INSERT INTO `commodity` VALUES (21, '「夏日风暴」', '「夏日风暴」是一款充满热带风情的冰咖啡。选用巴西和哥伦比亚的拼配豆，深度烘焙后以急速冷却工艺锁住浓郁风味。口感强劲有力，带有黑巧克力和烤核桃的大胆风味，冰饮后更显爽快刺激，适合喜欢浓烈冰咖啡的朋友。', '「夏日风暴」，一款为追求强烈口感而生的冰咖啡。精选巴西喜拉多和哥伦比亚慧兰产区的优质豆进行黄金比例拼配，深度烘焙后通过日式急冷法制成——将高温萃取的咖啡液直接注入满杯冰块中，瞬间锁住风味的同时激发出独特的清爽感。「夏日风暴」口感浓烈厚重，黑巧克力和烤核桃的风味扑面而来，尾韵带有微微的烟熏气息。加入牛奶后变成丝滑的冰拿铁，别有一番风味。', '深黑色', '拼配咖啡豆', '巴西、哥伦比亚', 2, 79.00, 59.00, 70, '2026-03-25 16:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/6.png', 13);
INSERT INTO `commodity` VALUES (22, '「可可幻想」', '「可可幻想」是一款以可可风味为主调的摩卡咖啡。将哥伦比亚单品豆与加纳优质可可粉巧妙融合，口感柔滑甜美，带有牛奶巧克力和香草的温暖气息。无论热饮还是冰饮，都能感受到可可与咖啡交织的美妙层次。', '「可可幻想」，一款将咖啡与可可完美融合的摩卡咖啡。精选哥伦比亚慧兰产区的单品咖啡豆作为基底，搭配加纳阿散蒂地区的顶级可可粉。中度烘焙的咖啡豆带来坚果和焦糖的底韵，与天然可可粉的丝滑甜感相互映衬。品尝「可可幻想」，你会感受到牛奶巧克力的柔和甜美，夹杂着一丝香草和肉桂的温暖，仿佛置身于巧克力工坊的甜蜜梦境中。热饮时醇厚温暖，冰饮时清甜爽口，是甜品爱好者的不二之选。', '巧克力色', '阿拉比卡咖啡豆', '哥伦比亚', 3, 85.00, 65.00, 55, '2026-03-12 11:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/1.png', 6);
INSERT INTO `commodity` VALUES (23, '「午夜摩卡」', '「午夜摩卡」是一款浓郁深沉的摩卡咖啡。选用埃塞俄比亚哈拉尔产区的日晒豆，天然带有蓝莓和红酒的发酵风味，搭配70%黑巧克力的苦甜，碰撞出令人着迷的复杂口感。适合深夜独酌，一人一杯，品味生活的苦与甜。', '「午夜摩卡」，一款为深夜时刻而生的摩卡咖啡。精选埃塞俄比亚哈拉尔产区的野生日晒豆，这种古老的处理方式赋予了咖啡豆独特的发酵风味——蓝莓、红酒和热带干果的香气扑鼻而来。搭配精选70%黑巧克力粉，苦甜交织间展现出惊人的复杂度。品尝「午夜摩卡」，前调是黑巧克力的微苦，中段浮现蓝莓果酱的甜润，收尾则是红酒般悠长的余韵。这是一杯有故事的咖啡，适合在午夜灯下细细品味。', '墨褐色', '哈拉尔咖啡豆', '埃塞俄比亚', 3, 98.00, 78.00, 30, '2026-03-28 20:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/5.png', 4);
INSERT INTO `commodity` VALUES (24, '「高原晨露」', '「高原晨露」是一款来自哥斯达黎加塔拉珠产区的阿拉比卡精品豆。种植在海拔1600米的高原上，昼夜温差大使咖啡樱桃缓慢成熟，积累了丰富的糖分。口感明亮干净，带有青苹果和蜂蜜的清新调性，是一款适合清晨享用的活力咖啡。', '「高原晨露」，源自哥斯达黎加塔拉珠高原的精品阿拉比卡咖啡豆。海拔1600米的产区拥有得天独厚的微气候条件，丰沛的降雨和凉爽的夜晚让咖啡樱桃在枝头缓慢成熟，积累了极为丰富的糖分和风味物质。蜜处理工艺保留了果肉中的天然甜感，浅度烘焙后展现出青苹果、白葡萄和蜂蜜的清新调性。口感明亮干净，酸质如晨露般清甜，余韵留下淡淡的奶油香。每天清晨来一杯，开启充满活力的新一天。', '浅金色', '阿拉比卡咖啡豆', '哥斯达黎加', 4, 118.00, 89.00, 40, '2026-04-01 08:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/2.png', 5);
INSERT INTO `commodity` VALUES (25, '「云端漫步」', '「云端漫步」是一款来自云南保山产区的精品阿拉比卡咖啡豆。中国云南独特的高原气候孕育出了这款媲美中美洲产区的优质咖啡，口感柔顺平衡，带有红枣和黑糖的东方韵味，展现了中国精品咖啡的新高度。', '「云端漫步」，源自中国云南保山潞江坝的精品阿拉比卡咖啡豆。云南是中国最重要的咖啡产区，海拔1200-1500米的高原地带、充足的日照和适宜的温差，为咖啡种植提供了绝佳条件。「云端漫步」采用日晒处理法，中度烘焙后展现出独具东方韵味的风味——红枣、黑糖和桂圆的甜感交织着淡淡的烟熏和坚果气息。口感柔顺平衡，酸度温和，适合各种冲泡方式。这是一款代表中国精品咖啡崛起的作品，让世界品味来自云端的东方美味。', '棕红色', '阿拉比卡咖啡豆', '中国云南', 4, 78.00, 59.00, 79, '2026-04-05 09:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/6.png', 19);
INSERT INTO `commodity` VALUES (26, '「雷霆觉醒」', '「雷霆觉醒」是一款高咖啡因的罗布斯塔劲豆。选用印度南部卡纳塔克邦的优质罗布斯塔豆，意式深度烘焙后呈现浓烈的烟熏和焦糖风味，咖啡因含量是普通阿拉比卡的两倍。专为需要强劲提神效果的咖啡饮者而生。', '「雷霆觉醒」，一款为追求极致提神效果而精心打造的罗布斯塔咖啡豆。选用印度卡纳塔克邦优质罗布斯塔品种，咖啡因含量高达2.5%，几乎是普通阿拉比卡豆的两倍。意式深度烘焙后，「雷霆觉醒」展现出浓烈的烟熏木质调性，伴随着焦糖、黑巧克力和核桃皮的粗犷风味。油脂丰富，制成意式浓缩后表面覆盖着厚厚的金色克丽玛。一杯下去，如同雷霆贯体，瞬间唤醒全部感官。适合加班深夜、考试备战、早起困难的每一个需要能量爆发的时刻。', '深黑色', '罗布斯塔咖啡豆', '印度', 5, 59.00, 39.00, 117, '2026-04-02 07:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/1.png', 25);
INSERT INTO `commodity` VALUES (27, '「铁血战士」', '「铁血战士」是一款拼配型罗布斯塔咖啡。将越南和乌干达两大罗布斯塔产区的优质豆黄金比例拼配，追求极致的浓厚和强劲。口感如铁般刚硬，带有深焙坚果和黑胡椒的辛辣尾韵，专为重口味咖啡爱好者打造。', '「铁血战士」，一款将浓烈推向极致的拼配罗布斯塔咖啡豆。精选越南邦美蜀高原和乌干达埃尔贡山产区的两款顶级罗布斯塔豆，以6:4的黄金比例拼配。越南豆贡献了厚重的body和坚果底韵，乌干达豆则带来了独特的辛辣和泥土气息。法式深度烘焙后，「铁血战士」的口感如铁般刚硬有力，黑胡椒和烟熏木材的风味扑面而来，余韵持久而强劲。适合制作意式浓缩、摩卡壶或越南滴漏咖啡，是真正硬核咖啡爱好者的终极之选。', '炭黑色', '拼配罗布斯塔豆', '越南、乌干达', 5, 55.00, 42.00, 90, '2026-04-08 13:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/4.png', 16);
INSERT INTO `commodity` VALUES (28, '「雨林秘语」', '「雨林秘语」是一款来自刚果热带雨林深处的野生咖啡。这些咖啡树在原始雨林的遮荫下自然生长，未经人工施肥，保留了最原始纯粹的风味。口感圆润浓厚，带有热带水果和黑糖的甜感，尾韵有独特的泥土和草本芬芳。', '「雨林秘语」，一款来自刚果伊图里雨林深处的野生咖啡豆。与人工种植园不同，这些咖啡树在千年原始雨林的巨木遮荫下自然生长，从未接受过人工施肥或化学处理，是真正意义上的有机野生咖啡。采摘后经过传统日晒处理，「雨林秘语」保留了最原始纯粹的风味——热带芒果和百香果的甜酸，黑糖和焦糖的温暖底韵，收尾处有独特的湿木和青苔的森林气息。每一口都像是在聆听热带雨林的秘密低语，感受大自然最本真的味道。', '深褐色', '野生咖啡豆', '刚果伊图里雨林', 6, 135.00, 99.00, 16, '2026-04-03 10:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/3.png', 4);
INSERT INTO `commodity` VALUES (29, '「基伍之光」', '「基伍之光」是一款产自刚果基伍湖东岸的水洗精品咖啡。火山沃土和湖泊微气候的双重恩泽，赋予了这款咖啡卓越的品质。口感细腻如丝，酸质明亮而有层次，带有柑橘、蜂蜜和白花的优雅香气，是刚果精品咖啡的代表之作。', '「基伍之光」，源自刚果基伍湖东岸尼拉贡戈火山脚下的精品咖啡。基伍湖是非洲大裂谷中的高海拔湖泊，湖畔的火山灰土壤富含矿物质，加上湖面蒸发形成的独特微气候，为咖啡种植创造了绝佳条件。「基伍之光」采用精细水洗处理法，去除了所有杂味，保留了咖啡豆最纯净的风味本质。浅中度烘焙后展现出柑橘和血橙的明亮酸质，中段是蜂蜜和杏仁的丝滑甜感，收尾带有茉莉和橙花的淡雅芬芳。如同基伍湖畔的第一缕晨光，温暖而充满希望。', '浅棕色', '精品水洗咖啡豆', '刚果基伍湖', 6, 125.00, 95.00, 25, '2026-04-06 11:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/2.png', 4);
INSERT INTO `commodity` VALUES (30, '「云雾仙境」', '「云雾仙境」是一款牙买加蓝山产区的高海拔精品咖啡。种植于蓝山山脉2000米以上常年云雾缭绕的区域，极端的生长条件使咖啡豆发展出无与伦比的复杂风味。口感如天鹅绒般丝滑，零酸度的温柔中蕴含着坚果和花香的层层惊喜。', '「云雾仙境」，产自牙买加蓝山山脉最高海拔种植区的珍稀咖啡豆。海拔2000米以上的山峰常年被云雾笼罩，气温极低，咖啡樱桃需要比低海拔产区多出两个月才能完全成熟。这种极端缓慢的生长过程让咖啡豆积累了惊人的风味复杂度。「云雾仙境」的口感如天鹅绒般丝滑，几乎感受不到酸度，取而代之的是从杏仁到奶油，从茉莉花到蜂蜜的层层风味递进。余韵清雅绵长，仿佛漫步于蓝山巅峰的云雾仙境中。年产量不足百磅，极为珍贵。', '象牙白', '蓝山咖啡豆', '牙买加', 7, 198.00, 158.00, 8, '2026-04-07 09:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/5.png', 2);
INSERT INTO `commodity` VALUES (31, '「牙买加之风」', '「牙买加之风」是一款蓝山风味的中度烘焙咖啡。选用牙买加蓝山山脉1200米产区的优质豆，虽不及山顶豆珍贵，但同样继承了蓝山咖啡均衡柔和的经典风格。带有核桃、奶油和淡淡的果酸，性价比极高的蓝山入门之选。', '「牙买加之风」，来自牙买加蓝山山脉中段海拔1200米产区的优质咖啡豆。虽然不是最顶级的蓝山山顶豆，但依然完美继承了蓝山咖啡的经典DNA——无可挑剔的均衡感。中度烘焙后，「牙买加之风」展现出核桃和烤杏仁的坚果香气，搭配清新的柑橘酸和奶油般的顺滑body。既有蓝山咖啡标志性的优雅平衡，又以更亲民的价格让更多人能够体验蓝山风味。这是一款性价比极高的蓝山入门之选，也是日常饮用的绝佳伴侣。', '中棕色', '蓝山咖啡豆', '牙买加', 7, 108.00, 85.00, 35, '2026-04-09 14:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/6.png', 7);
INSERT INTO `commodity` VALUES (32, '「太平洋之风」', '「太平洋之风」是一款来自夏威夷大岛东侧卡乌产区的精品咖啡。与西侧的科纳咖啡不同，卡乌产区受丰沛降雨的影响，咖啡豆呈现出更加果香浓郁的风味。口感轻盈活泼，带有菠萝和芒果的热带果香，酸质明亮清新。', '「太平洋之风」，源自夏威夷大岛东南侧卡乌产区的精品咖啡豆。与西侧著名的科纳产区不同，卡乌地区降雨更加丰沛，火山土壤也更加年轻肥沃，这种独特的风土赋予了咖啡豆鲜明的热带水果特性。浅度烘焙后，「太平洋之风」绽放出菠萝、芒果和百香果的热带果香，酸质明亮如太平洋的海风般清新。口感轻盈活泼，甜度自然，余韵留下椰子和香草的温柔。每一口都仿佛能感受到夏威夷温暖的太平洋微风拂面。', '浅琥珀色', '夏威夷咖啡豆', '美国夏威夷', 8, 138.00, 108.00, 25, '2026-04-10 10:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/3.png', 5);
INSERT INTO `commodity` VALUES (33, '「椰影阳光」', '「椰影阳光」是一款融合夏威夷风情的科纳混合咖啡。以30%顶级科纳豆搭配70%精选中美洲豆，既保留了科纳咖啡标志性的丝滑甜感，又以更亲民的价格让更多人品味夏威夷风味。口感圆润甜美，带有椰糖和太妃的温暖气息。', '「椰影阳光」，一款将夏威夷阳光装进杯中的科纳混合咖啡。以30%的夏威夷大岛科纳特级豆为核心，搭配70%精选哥斯达黎加和洪都拉斯的优质中美洲豆，黄金比例拼配后呈现出极具性价比的夏威夷风味。科纳豆贡献了标志性的丝滑质感和焦糖甜感，中美洲豆则带来了坚果和可可的厚实底韵。中度烘焙后口感圆润甜美，椰糖和太妃的温暖气息缭绕舌尖。仿佛坐在夏威夷棕榈树下，沐浴着金色阳光，享受一杯惬意的午后咖啡。', '金棕色', '拼配咖啡豆', '美国夏威夷', 8, 98.00, 75.00, 50, '2026-04-11 15:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/1.png', 9);
INSERT INTO `commodity` VALUES (34, '「深林沉香」', '「深林沉香」是一款来自苏门答腊亚齐省的陈年曼特宁咖啡。经过两年自然陈化，咖啡豆的酸度几乎完全消失，取而代之的是令人惊叹的沉香木和雪松的木质芳香。口感浓厚如蜜，是曼特宁咖啡中的极致之作，适合资深咖啡玩家。', '「深林沉香」，一款经过两年自然陈化的苏门答腊曼特宁咖啡豆。来自亚齐省的有机种植园，采用传统湿刨法处理后，在恒温恒湿的仓库中缓慢陈化24个月。时间的魔法让咖啡豆发生了奇妙的转变——酸度几乎完全消失，取而代之的是浓郁的沉香木、雪松和陈年葡萄酒的复杂芳香。中深度烘焙后口感浓厚如蜜，入口是太妃糖和黑巧克力的醇厚，中段浮现檀木和烟草的沉静气息，余韵持久而深邃。这是一杯需要时间来品味的咖啡，每一口都在讲述时光沉淀的故事。', '深墨色', '陈年曼特宁豆', '印度尼西亚', 9, 138.00, 108.00, 14, '2026-04-12 08:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/5.png', 4);
INSERT INTO `commodity` VALUES (35, '「黑夜骑士」', '「黑夜骑士」是一款烘焙度极深的曼特宁咖啡。选用苏门答腊林东产区的精品豆，法式深度烘焙带来浓烈的碳烤和黑巧克力风味。口感厚重强劲，苦度突出但回甘绵长，搭配牛奶后变成一杯浓郁丝滑的重口味拿铁。', '「黑夜骑士」，一款为深烘爱好者量身打造的曼特宁咖啡豆。选用苏门答腊林东产区的精品曼特宁豆，经过法式深度烘焙后颜色深如夜空。在极高的烘焙温度下，咖啡豆表面泛着油光，散发出浓烈的碳烤、黑巧克力和焦糖的复合香气。「黑夜骑士」的口感厚重强劲，苦度突出而富有层次——从入口的深焙苦韵到中段的黑巧克力，再到收尾时意想不到的焦糖甜感回甘。适合制成意式浓缩或搭配牛奶做成浓郁的重口味拿铁，是黑夜中提神醒脑的可靠伙伴。', '炭黑色', '曼特宁咖啡豆', '印度尼西亚', 9, 88.00, 65.00, 55, '2026-04-13 19:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/2.png', 11);
INSERT INTO `commodity` VALUES (36, '「维多利亚湖畔」', '「维多利亚湖畔」是一款来自乌干达布吉苏产区的精品水洗咖啡。种植于维多利亚湖北岸的埃尔贡山坡上，湖泊的调节作用使气候温润宜人。口感干净明亮，带有番茄和黑醋栗的特殊酸质，是非洲咖啡中独具一格的存在。', '「维多利亚湖畔」，源自乌干达东部布吉苏地区的精品水洗咖啡豆。埃尔贡山是一座古老的盾状火山，其北坡紧邻非洲最大的淡水湖——维多利亚湖。湖泊的巨大水体为山坡上的咖啡园提供了温暖湿润的微气候，使咖啡樱桃在温和的环境中缓慢成熟。精细水洗处理后，「维多利亚湖畔」展现出独特的番茄和黑醋栗酸质，中段是红糖和杏仁的甜感，收尾带有黑茶和柑橘皮的复杂余韵。口感干净明亮，酸甜平衡，是非洲精品咖啡中独具一格的宝藏之选。', '琥珀色', '乌干达精品豆', '乌干达', 10, 99.00, 79.00, 30, '2026-03-30 10:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/4.png', 5);
INSERT INTO `commodity` VALUES (37, '「非洲之星」', '「非洲之星」是一款来自乌干达西部鲁文佐里山脉的高海拔咖啡。被称为月亮山的鲁文佐里终年积雪覆盖，山坡上的咖啡豆在冰雪融水灌溉下生长。口感醇厚饱满，带有黑巧克力、烤花生和热带干果的温暖风味。', '「非洲之星」，一款源自乌干达西部鲁文佐里山脉的高海拔精品咖啡豆。鲁文佐里山脉被称为月亮山，是非洲第三高峰，终年积雪的山峰提供了纯净的冰雪融水灌溉着山坡上的咖啡园。海拔1800米的种植区日温差超过15度，极大地促进了咖啡豆风味物质的积累。「非洲之星」经过日晒处理和中深度烘焙后，展现出黑巧克力和烤花生的浓郁底韵，搭配热带干果和太妃糖的甜感。口感醇厚饱满，如同非洲大地般厚实而温暖，是乌干达咖啡中当之无愧的明星之作。', '深棕色', '乌干达高海拔豆', '乌干达', 10, 115.00, 89.00, 22, '2026-04-04 11:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/3.png', 7);
INSERT INTO `commodity` VALUES (38, '「安第斯之吻」', '「安第斯之吻」是一款来自哥伦比亚慧兰产区的精品咖啡。种植于安第斯山脉的高海拔坡地，得益于赤道阳光和安第斯冷风的交汇。口感甜美柔和，带有红苹果和蜂蜜的甜感，酸度温和如安第斯山间清泉般柔顺自然。', '「安第斯之吻」，源自哥伦比亚慧兰省安第斯山脉高海拔咖啡产区。慧兰省是哥伦比亚最知名的咖啡产区之一，海拔1700米的种植园终年被安第斯山间的轻雾笼罩，昼暖夜凉的气候让咖啡樱桃缓慢而均匀地成熟。水洗处理后浅中度烘焙，「安第斯之吻」展现出红苹果和蜜桃的甜美果香，中段是蜂蜜和红糖的温暖甜感，收尾留下可可和杏仁的淡雅余韵。口感如安第斯山间的清泉般柔顺自然，甜度出众，适合各种冲泡方式。', '中棕色', '哥伦比亚精品豆', '哥伦比亚', 11, 92.00, 72.00, 45, '2026-04-06 09:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/1.png', 8);
INSERT INTO `commodity` VALUES (39, '「麦德林传奇」', '「麦德林传奇」是一款来自哥伦比亚麦德林地区的传统深烘咖啡。麦德林是哥伦比亚咖啡的黄金产区，以出产口感浓郁、酸度低的咖啡闻名于世。这款咖啡延续了麦德林的经典风格，浓厚的焦糖和黑巧克力风味令人沉醉。', '「麦德林传奇」，致敬哥伦比亚咖啡之都麦德林的传奇之作。麦德林所在的安蒂奥基亚省是哥伦比亚历史最悠久的咖啡产区，几代人的种植经验积淀出了闻名世界的哥伦比亚特级品质标准。「麦德林传奇」选用当地最大颗粒的Supremo等级豆，中深度烘焙后展现出经典的哥伦比亚风味——浓郁的焦糖和黑巧克力底韵，搭配烤核桃和淡淡的红莓果酸。口感厚实而不沉闷，苦甜交织间尽显大产区的王者风范。适合制作美式、手冲或拿铁，是百搭而经典的日常之选。', '深棕色', '哥伦比亚特级豆', '哥伦比亚', 11, 85.00, 65.00, 65, '2026-04-08 10:00:00', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/6.png', 14);

-- ----------------------------
-- Table structure for commodity_comment
-- ----------------------------
DROP TABLE IF EXISTS `commodity_comment`;
CREATE TABLE `commodity_comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `commodity_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `stars` int NULL DEFAULT NULL COMMENT '评星数【1-5】',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '评价',
  `comment_time` datetime NULL DEFAULT NULL COMMENT '评价时间',
  `reply_id` int NULL DEFAULT NULL COMMENT '回复评论的ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品评价表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commodity_comment
-- ----------------------------
INSERT INTO `commodity_comment` VALUES (11, 3, 10, 4, '包装不错，快递迅速！质量嘎嘎好', '2025-06-21 12:43:34', NULL);
INSERT INTO `commodity_comment` VALUES (12, 2, 6, 5, '味道很好～', '2025-06-21 12:49:40', NULL);
INSERT INTO `commodity_comment` VALUES (13, 2, 8, 4, '还可以哦', '2025-06-21 12:49:57', NULL);
INSERT INTO `commodity_comment` VALUES (14, 2, 9, 3, '口感一般', '2025-06-21 12:50:16', NULL);
INSERT INTO `commodity_comment` VALUES (15, 2, 7, 5, '味道很不错，咖啡味道浓郁', '2025-06-21 12:55:04', NULL);
INSERT INTO `commodity_comment` VALUES (16, 3, 11, 5, '性价比可以', '2025-06-21 12:56:23', NULL);
INSERT INTO `commodity_comment` VALUES (17, 1, 6, 5, '非常不错，很好喝', '2025-06-21 21:14:49', NULL);
INSERT INTO `commodity_comment` VALUES (18, 1, 8, 5, '很不错', '2025-06-21 22:55:05', NULL);
INSERT INTO `commodity_comment` VALUES (19, 1, 8, 4, '很不错', '2025-06-21 23:57:21', NULL);
INSERT INTO `commodity_comment` VALUES (20, 4, 10, 5, '味道不错', '2025-06-22 10:52:24', NULL);
INSERT INTO `commodity_comment` VALUES (21, 1, 8, 5, '很不错', '2025-06-22 13:16:51', NULL);
INSERT INTO `commodity_comment` VALUES (22, 2, 6, 5, '很不错', '2026-01-13 15:40:20', NULL);
INSERT INTO `commodity_comment` VALUES (23, 1, 6, NULL, '感谢您的评价', '2026-01-22 13:25:59', 22);
INSERT INTO `commodity_comment` VALUES (24, 2, 6, 5, '很不错', '2026-04-16 04:07:10', NULL);

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '优惠券名称',
  `type` int NOT NULL COMMENT '优惠券类型【1:满减券】【2:折扣券】',
  `min_amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '最低使用金额',
  `reduce_amount` decimal(8, 2) NULL DEFAULT NULL COMMENT '满减金额（type=1时使用）',
  `discount` decimal(4, 2) NULL DEFAULT NULL COMMENT '折扣率（type=2时使用，如0.8表示8折）',
  `start_time` datetime NOT NULL COMMENT '生效时间',
  `end_time` datetime NOT NULL COMMENT '失效时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status` int NULL DEFAULT 1 COMMENT '状态【1:启用】【0:禁用】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '优惠券表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of coupon
-- ----------------------------
INSERT INTO `coupon` VALUES (9, '优惠券满300减40', 1, 300.00, 40.00, NULL, '2026-04-16 03:39:00', '2026-05-16 03:39:00', '2026-04-16 03:39:43', 1);
INSERT INTO `coupon` VALUES (11, '优惠券满500-60', 1, 500.00, 60.00, NULL, '2026-04-16 04:22:00', '2026-05-16 04:22:00', '2026-04-16 04:22:23', 1);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '订单号',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `commodity_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '订单记录',
  `courier_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '快递单号',
  `courier_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '快递公司',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '付款时间',
  `shipping_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `success_time` datetime NULL DEFAULT NULL COMMENT '成交时间',
  `status` int NULL DEFAULT NULL COMMENT '订单状态【-1:取消】【0:等待发货】【1:已发货】【2:已完成】',
  `address_id` int NULL DEFAULT NULL COMMENT '地址ID',
  `total_amount` decimal(8, 2) NULL DEFAULT NULL COMMENT '订单总金额',
  `actual_amount` decimal(8, 2) NULL DEFAULT NULL COMMENT '实付金额（优惠后）',
  `coupon_id` int NULL DEFAULT NULL COMMENT '使用的优惠券ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (18, '1703686315512', 2, 6, '卡布其诺-「晨曦之舞」*3', 'SF345834759394579', '顺丰快递', '2025-06-21 12:11:56', '2025-06-21 12:11:56', '2025-06-21 12:21:35', '2025-06-21 12:49:10', 2, 1, NULL, NULL, NULL);
INSERT INTO `order` VALUES (19, '1703686360015', 2, 8, '哥伦比亚咖啡-「阳光之舞」*1', 'YD5782345728935', '韵达快递', '2025-06-21 12:12:40', '2025-06-21 12:12:40', '2025-06-21 12:22:32', '2025-06-21 12:49:17', 2, 1, NULL, NULL, NULL);
INSERT INTO `order` VALUES (20, '1703686374468', 2, 9, '冰咖啡-「冰封之心」*1', 'YT32423487923423', '圆通快递', '2025-06-21 12:12:54', '2025-06-21 12:12:54', '2025-06-21 12:21:59', '2025-06-21 12:49:21', 2, 2, NULL, NULL, NULL);
INSERT INTO `order` VALUES (21, '1703687408750', 3, 8, '哥伦比亚咖啡-「阳光之舞」*1', NULL, NULL, '2025-06-21 12:30:09', '2025-06-21 12:30:09', NULL, NULL, 0, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (22, '1703687498076', 3, 8, '哥伦比亚咖啡-「阳光之舞」*5', NULL, NULL, '2025-06-21 12:31:38', '2025-06-21 12:31:38', NULL, NULL, -1, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (23, '1703687506494', 3, 6, '卡布其诺-「晨曦之舞」*4', NULL, NULL, '2025-06-21 12:31:46', '2025-06-21 12:31:46', NULL, NULL, 0, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (24, '1703687515172', 3, 9, '冰咖啡-「冰封之心」*1', 'SF723894728934', '顺丰快递', '2025-06-21 12:31:55', '2025-06-21 12:31:55', '2025-06-21 12:41:20', NULL, 1, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (25, '1703687522584', 3, 11, '卡布其诺-「赤道之韵」*2', 'EMS345897342342', '邮政EMS', '2025-06-21 12:32:03', '2025-06-21 12:32:03', '2025-06-21 12:53:50', '2025-06-21 12:56:03', 2, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (26, '1703687537380', 3, 10, '摩卡咖啡-「巧克力之梦」*2', NULL, NULL, '2025-06-21 12:32:17', '2025-06-21 12:32:17', NULL, NULL, -1, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (27, '1703687545402', 3, 7, '乌干达咖啡-「秘境之韵」*3', 'YT242342342345', '圆通快递', '2025-06-21 12:32:25', '2025-06-21 12:32:25', '2025-06-21 12:41:47', '2025-06-21 12:42:40', 2, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (28, '1703687623966', 3, 10, '摩卡咖啡-「巧克力之梦」*3', 'SF57892734594', '顺丰快递', '2025-06-21 12:33:44', '2025-06-21 12:33:44', '2025-06-21 12:41:27', '2025-06-21 12:42:45', 2, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (29, '1703687633368', 3, 6, '卡布其诺-「晨曦之舞」*4', NULL, NULL, '2025-06-21 12:33:53', '2025-06-21 12:33:53', NULL, NULL, 0, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (30, '1703687642921', 3, 7, '乌干达咖啡-「秘境之韵」*2', NULL, NULL, '2025-06-21 12:34:03', '2025-06-21 12:34:03', NULL, NULL, -1, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (31, '1703687651178', 3, 8, '哥伦比亚咖啡-「阳光之舞」*2', 'SF4782934789234', '顺丰快递', '2025-06-21 12:34:11', '2025-06-21 12:34:11', '2025-06-21 12:41:35', NULL, 1, 8, NULL, NULL, NULL);
INSERT INTO `order` VALUES (32, '1703688676216', 2, 7, '乌干达咖啡-「秘境之韵」*3', 'SF523458934025', '顺丰快递', '2025-06-21 12:51:16', '2025-06-21 12:51:16', '2025-06-21 12:53:23', '2025-06-21 12:54:28', 2, 1, NULL, NULL, NULL);
INSERT INTO `order` VALUES (35, '1750517678444', 1, 8, '哥伦比亚咖啡-「阳光之舞」*1', 'test1', '顺丰快递', '2025-06-21 22:54:38', '2025-06-21 22:54:38', '2025-06-21 22:54:49', '2025-06-21 22:54:54', 2, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (36, '1750521367220', 1, 11, '卡布其诺-「赤道之韵」*1', 'test', '顺丰快递', '2025-06-21 23:56:07', '2025-06-21 23:56:07', '2025-06-21 23:56:36', '2025-06-21 23:56:45', 2, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (37, '1750560639892', 4, 10, '摩卡咖啡-「巧克力之梦」*1', '1', '顺丰快递', '2025-06-22 10:50:40', '2025-06-22 10:50:40', '2025-06-22 10:52:07', '2025-06-22 10:52:12', 2, 11, NULL, NULL, NULL);
INSERT INTO `order` VALUES (38, '1750569366271', 1, 6, '卡布其诺-「晨曦之舞」*1', 'test', '顺丰快递', '2025-06-22 13:16:06', '2025-06-22 13:16:06', '2025-06-22 13:16:30', '2025-06-22 13:16:40', 2, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (39, '1762589289772', 1, 8, '哥伦比亚咖啡-「阳光之舞」*1', NULL, NULL, '2025-11-08 16:08:10', '2025-11-08 16:08:10', NULL, NULL, 0, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (40, '1763777808418', 1, 10, '摩卡咖啡-「巧克力之梦」*1', NULL, NULL, '2025-11-22 10:16:48', '2025-11-22 10:16:48', NULL, NULL, 0, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (41, '1768139879348', 1, 6, '卡布其诺-「晨曦之舞」*2', NULL, NULL, '2026-01-11 21:57:59', '2026-01-11 21:57:59', NULL, NULL, 0, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (42, '1768292434917-1', 1, 6, '卡布其诺-「晨曦之舞」*1', NULL, NULL, '2026-01-13 16:20:35', '2026-01-13 16:20:35', NULL, NULL, 0, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (43, '1768292434917-2', 1, 8, '哥伦比亚咖啡-「阳光之舞」*1', NULL, NULL, '2026-01-13 16:20:35', '2026-01-13 16:20:35', NULL, NULL, 0, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (44, '1772808432655-1', 2, 6, '卡布其诺-「晨曦之舞」*2', NULL, NULL, '2026-03-06 22:47:13', '2026-03-06 22:47:13', NULL, NULL, -1, 1, NULL, NULL, NULL);
INSERT INTO `order` VALUES (45, '1772808432655-2', 2, 11, '卡布其诺-「赤道之韵」*1', NULL, NULL, '2026-03-06 22:47:13', '2026-03-06 22:47:13', NULL, NULL, -1, 1, NULL, NULL, NULL);
INSERT INTO `order` VALUES (46, '1772811875674-1', 1, 6, '卡布其诺-「晨曦之舞」*1', NULL, NULL, '2026-03-06 23:44:36', '2026-03-06 23:44:36', NULL, NULL, 0, 10, NULL, NULL, NULL);
INSERT INTO `order` VALUES (47, '1772900000000', 1, 6, '卡布其诺*1', NULL, NULL, '2026-04-10 02:43:38', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (48, '1772900000001', 2, 8, '阳光之舞*2', NULL, NULL, '2026-04-10 02:43:38', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (49, '1772900000002', 3, 11, '赤道之韵*1', NULL, NULL, '2026-04-11 02:43:38', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (50, '1772900000003', 1, 7, '秘境之韵*1', NULL, NULL, '2026-04-12 02:43:38', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (51, '1772900000004', 2, 9, '冰封之心*2', NULL, NULL, '2026-04-12 02:43:38', NULL, NULL, '2026-04-16 04:06:55', 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (53, '1772900000006', 1, 6, '晨曦之舞*3', NULL, NULL, '2026-04-13 02:43:38', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (55, '1772900000008', 3, 11, '赤道之韵*2', NULL, NULL, '2026-04-14 02:43:38', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (56, '1772900000009', 1, 6, '晨曦之舞*1', NULL, NULL, '2026-04-15 02:43:38', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (57, '1772900000010', 4, 7, '秘境之韵*1', NULL, NULL, '2026-04-15 02:43:38', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (61, '1772900000014', 2, 6, '晨曦之舞*1', NULL, NULL, '2026-04-16 02:43:38', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL);
INSERT INTO `order` VALUES (62, '1776283443319-1', 2, 8, '哥伦比亚咖啡-「阳光之舞」*2', NULL, NULL, '2026-04-16 04:04:03', '2026-04-16 04:04:03', NULL, NULL, -1, 1, 238.00, 218.00, 6);
INSERT INTO `order` VALUES (63, '1776283443319-2', 2, 26, '罗布斯塔-「雷霆觉醒」*1', NULL, NULL, '2026-04-16 04:04:03', '2026-04-16 04:04:03', NULL, NULL, -1, 1, 238.00, 218.00, 6);
INSERT INTO `order` VALUES (64, '1776283443319-3', 2, 6, '卡布其诺-「晨曦之舞」*1', NULL, NULL, '2026-04-16 04:04:03', '2026-04-16 04:04:03', NULL, NULL, -1, 1, 238.00, 218.00, 6);
INSERT INTO `order` VALUES (65, '1776283564059-1', 2, 26, '罗布斯塔-「雷霆觉醒」*2', NULL, NULL, '2026-04-16 04:06:04', '2026-04-16 04:06:04', NULL, NULL, -1, 2, 236.00, 236.00, NULL);
INSERT INTO `order` VALUES (66, '1776283564059-2', 2, 6, '卡布其诺-「晨曦之舞」*2', NULL, NULL, '2026-04-16 04:06:04', '2026-04-16 04:06:04', NULL, NULL, -1, 2, 236.00, 236.00, NULL);
INSERT INTO `order` VALUES (67, '1776284477756-1', 2, 34, '印度曼特宁-「深林沉香」*1', NULL, NULL, '2026-04-16 04:21:18', '2026-04-16 04:21:18', NULL, NULL, 0, 1, 266.00, 246.00, 10);
INSERT INTO `order` VALUES (68, '1776284477756-2', 2, 25, '阿拉比卡咖啡-「云端漫步」*1', NULL, NULL, '2026-04-16 04:21:18', '2026-04-16 04:21:18', NULL, NULL, 0, 1, 266.00, 246.00, 10);
INSERT INTO `order` VALUES (69, '1776284477756-3', 2, 28, '刚果咖啡-「雨林秘语」*1', NULL, NULL, '2026-04-16 04:21:18', '2026-04-16 04:21:18', NULL, NULL, 0, 1, 266.00, 246.00, 10);
INSERT INTO `order` VALUES (70, '1776284808301-1', 2, 11, '卡布其诺-「赤道之韵」*1', NULL, NULL, '2026-04-16 04:26:48', '2026-04-16 04:26:48', NULL, NULL, 0, 1, 228.00, 228.00, NULL);
INSERT INTO `order` VALUES (71, '1776284808301-2', 2, 6, '卡布其诺-「晨曦之舞」*1', NULL, NULL, '2026-04-16 04:26:48', '2026-04-16 04:26:48', NULL, NULL, 0, 1, 228.00, 228.00, NULL);
INSERT INTO `order` VALUES (72, '1776284808301-3', 2, 28, '刚果咖啡-「雨林秘语」*1', NULL, NULL, '2026-04-16 04:26:48', '2026-04-16 04:26:48', NULL, NULL, 0, 1, 228.00, 228.00, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱地址',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像地址',
  `info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '个人说明',
  `register_time` datetime NULL DEFAULT NULL COMMENT '注册时间',
  `role` int NULL DEFAULT 0 COMMENT '用户角色【0:普通用户 1:管理员】',
  `update_time` datetime NULL DEFAULT NULL COMMENT '最新更新',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '管理员', 'x12345', 'admin@qq.com', 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/default.png', '我们热爱我们的咖啡。我们相信通过一杯高品质的手工咖啡可以传递和分享真挚情感，而这样简单的行为或许可以为顾客提供一些正能量。 因此，【咖咖】始终致力于通过道德采购，烘焙并提供高品质的咖啡豆。 从一粒种子到一杯咖啡，每一个环节都倾入了【咖咖】的心意和努力， 只为每一次光顾我们门店的顾客可以享受醇香的浓缩咖啡及其钟爱的咖啡饮品。', '2025-06-21 10:16:41', 1, '2025-06-22 13:17:07');
INSERT INTO `user` VALUES (2, '张三', 'x12345', 'zs@qq.com', 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/hmbb.png', '-', '2025-06-21 11:46:38', 0, '2025-06-21 11:47:13');
INSERT INTO `user` VALUES (3, '李四', 'x12345', 'ls@qq.com', '\r\nhttps://hgltest.oss-cn-hangzhou.aliyuncs.com/pdx.png', '-', '2025-06-21 12:46:56', 0, '2025-06-21 12:47:36');
INSERT INTO `user` VALUES (4, 'hgl', 'x12345', '1265209172@qq.com', 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/hmbb.png', '我喜欢喝咖啡', '2025-06-22 10:19:29', 0, '2025-06-22 10:40:26');

-- ----------------------------
-- Table structure for user_coupon
-- ----------------------------
DROP TABLE IF EXISTS `user_coupon`;
CREATE TABLE `user_coupon`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `coupon_id` int NOT NULL COMMENT '优惠券ID',
  `status` int NULL DEFAULT 0 COMMENT '使用状态【0:未使用】【1:已使用】',
  `receive_time` datetime NOT NULL COMMENT '领取时间',
  `use_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `order_id` int NULL DEFAULT NULL COMMENT '使用的订单ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_coupon_id`(`coupon_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户优惠券表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_coupon
-- ----------------------------
INSERT INTO `user_coupon` VALUES (1, 1, 1, 0, '2026-04-16 03:01:15', NULL, NULL);
INSERT INTO `user_coupon` VALUES (2, 2, 1, 0, '2026-04-16 03:01:15', NULL, NULL);
INSERT INTO `user_coupon` VALUES (3, 3, 1, 0, '2026-04-16 03:01:15', NULL, NULL);
INSERT INTO `user_coupon` VALUES (4, 4, 1, 0, '2026-04-16 03:01:15', NULL, NULL);
INSERT INTO `user_coupon` VALUES (5, 1, 2, 0, '2026-04-16 03:02:21', NULL, NULL);
INSERT INTO `user_coupon` VALUES (6, 2, 2, 0, '2026-04-16 03:02:21', NULL, NULL);
INSERT INTO `user_coupon` VALUES (7, 3, 2, 0, '2026-04-16 03:02:21', NULL, NULL);
INSERT INTO `user_coupon` VALUES (8, 4, 2, 0, '2026-04-16 03:02:21', NULL, NULL);
INSERT INTO `user_coupon` VALUES (9, 1, 3, 0, '2026-04-16 03:03:57', NULL, NULL);
INSERT INTO `user_coupon` VALUES (10, 2, 3, 0, '2026-04-16 03:03:57', NULL, NULL);
INSERT INTO `user_coupon` VALUES (11, 3, 3, 0, '2026-04-16 03:03:57', NULL, NULL);
INSERT INTO `user_coupon` VALUES (12, 4, 3, 0, '2026-04-16 03:03:57', NULL, NULL);
INSERT INTO `user_coupon` VALUES (13, 1, 4, 0, '2026-04-16 03:09:26', NULL, NULL);
INSERT INTO `user_coupon` VALUES (14, 2, 4, 0, '2026-04-16 03:09:26', NULL, NULL);
INSERT INTO `user_coupon` VALUES (15, 3, 4, 0, '2026-04-16 03:09:26', NULL, NULL);
INSERT INTO `user_coupon` VALUES (16, 4, 4, 0, '2026-04-16 03:09:26', NULL, NULL);
INSERT INTO `user_coupon` VALUES (17, 1, 5, 0, '2026-04-16 03:12:35', NULL, NULL);
INSERT INTO `user_coupon` VALUES (18, 2, 5, 0, '2026-04-16 03:12:35', NULL, NULL);
INSERT INTO `user_coupon` VALUES (19, 3, 5, 0, '2026-04-16 03:12:35', NULL, NULL);
INSERT INTO `user_coupon` VALUES (20, 4, 5, 0, '2026-04-16 03:12:35', NULL, NULL);
INSERT INTO `user_coupon` VALUES (25, 1, 7, 0, '2026-04-16 03:17:51', NULL, NULL);
INSERT INTO `user_coupon` VALUES (26, 2, 7, 0, '2026-04-16 03:17:51', NULL, NULL);
INSERT INTO `user_coupon` VALUES (27, 3, 7, 0, '2026-04-16 03:17:51', NULL, NULL);
INSERT INTO `user_coupon` VALUES (28, 4, 7, 0, '2026-04-16 03:17:51', NULL, NULL);
INSERT INTO `user_coupon` VALUES (33, 1, 9, 0, '2026-04-16 03:39:43', NULL, NULL);
INSERT INTO `user_coupon` VALUES (34, 2, 9, 0, '2026-04-16 03:39:43', NULL, NULL);
INSERT INTO `user_coupon` VALUES (35, 3, 9, 0, '2026-04-16 03:39:43', NULL, NULL);
INSERT INTO `user_coupon` VALUES (36, 4, 9, 0, '2026-04-16 03:39:43', NULL, NULL);
INSERT INTO `user_coupon` VALUES (41, 1, 11, 0, '2026-04-16 04:22:23', NULL, NULL);
INSERT INTO `user_coupon` VALUES (42, 2, 11, 0, '2026-04-16 04:22:23', NULL, NULL);
INSERT INTO `user_coupon` VALUES (43, 3, 11, 0, '2026-04-16 04:22:23', NULL, NULL);
INSERT INTO `user_coupon` VALUES (44, 4, 11, 0, '2026-04-16 04:22:23', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
