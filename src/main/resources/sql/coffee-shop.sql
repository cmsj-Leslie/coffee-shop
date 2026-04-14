/*
 Navicat Premium Dump SQL

 Source Server         : Database
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : kaka-shop

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 10/04/2026 19:50:33
*/

CREATE DATABASE IF NOT EXISTS `coffee-shop` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '收货地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 2, '张三', '浙江省杭州市XXX区XXX街道999号', '17879540000', 1);
INSERT INTO `address` VALUES (2, 2, '张三', '浙江省温州市鹿城区五马街', '17879540000', 0);
INSERT INTO `address` VALUES (8, 3, '李四', '浙江省温州市瓯海区温州商学院', '17877779999', 1);
INSERT INTO `address` VALUES (10, 1, 'Wen', 'wzbc', '15067722388', 0);
INSERT INTO `address` VALUES (11, 4, 'hgl', 'wzbc', '17757736800', 1);
INSERT INTO `address` VALUES (12, 4, 'hgl', 'wzbc1', '17757736800', 0);
INSERT INTO `address` VALUES (13, 1, 'test', '温州', '15067722388', 0);

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
INSERT INTO `ai_chat_message` VALUES (97, 1, 'user', '卡布奇诺什么味道', 'deepseek', '2026-04-08 00:59:36');
INSERT INTO `ai_chat_message` VALUES (98, 1, 'ai', '卡布奇诺是浓缩咖啡☕️+蒸奶🥛+厚奶泡的经典组合，口感绵密顺滑，奶香浓郁，咖啡味比拿铁更突出一些✨\n\n我们店里的「晨曦之舞」就是经典卡布，奶泡细腻如云朵；「赤道之韵」则用非洲豆，带点果香风味，更活泼一些💫\n\n您平时喜欢奶味重一点，还是咖啡味更突出的口感呢？', 'deepseek', '2026-04-08 00:59:36');
INSERT INTO `ai_chat_message` VALUES (99, 1, 'user', '怎么冲泡咖啡', 'deepseek', '2026-04-08 00:59:42');
INSERT INTO `ai_chat_message` VALUES (100, 1, 'ai', '哈喽！我是咖咖，很高兴为你介绍冲泡方法☕️✨\n\n常见的冲泡方式有：\n- **手冲**：适合喜欢清爽、风味层次丰富的咖啡，需要滤杯和手冲壶\n- **法压壶**：操作简单，能保留咖啡油脂，口感醇厚\n- **摩卡壶**：适合喜欢浓郁口感的家庭使用\n\n你平时喜欢什么风味的咖啡呢？我可以根据你的口味推荐最适合的冲泡方式！🫘💫', 'deepseek', '2026-04-08 00:59:42');

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
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '购物车' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (40, 3, 11, 12, '2025-06-21 12:32:34');
INSERT INTO `cart` VALUES (42, 3, 9, 5, '2025-06-21 12:32:36');
INSERT INTO `cart` VALUES (55, 4, 6, 1, '2025-06-22 10:46:18');
INSERT INTO `cart` VALUES (63, 2, 8, 1, '2026-01-13 16:12:50');
INSERT INTO `cart` VALUES (70, 1, 8, 5, '2026-03-06 23:46:16');
INSERT INTO `cart` VALUES (71, 1, 6, 1, '2026-04-08 00:57:33');

-- ----------------------------
-- Table structure for classify
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '分类名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品分类' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `collection` VALUES (32, 1, 8, '2025-06-22 11:09:01');
INSERT INTO `collection` VALUES (33, 1, 10, '2025-11-22 10:18:42');

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
  `current_price` decimal(5, 2) NULL DEFAULT NULL COMMENT '当前售价',
  `inventory` int NULL DEFAULT NULL COMMENT '库存',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '上架时间',
  `status` int NULL DEFAULT 1 COMMENT '状态【1:上架】【0:下架】',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品图片地址',
  `sale_count` int NULL DEFAULT 0 COMMENT '销量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sale_count`(`sale_count` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commodity
-- ----------------------------
INSERT INTO `commodity` VALUES (6, '「晨曦之舞」', '「晨曦之舞」是一款精致而富有诗意的卡布其诺咖啡豆。栽培于哥伦比亚的高海拔地区，这些咖啡豆经过精心挑选和烘焙，以确保每一杯都带来令人陶醉的味觉体验。「晨曦之舞」的浓郁口感融合了柔和的巧克力和坚果的风味，香气中透露着轻盈的水果和花香。无论是早晨的第一杯咖啡还是午后放松的时刻，「晨曦之舞」都能带给你温暖、愉悦的享受。', '「晨曦之舞」，一袋来自哥伦比亚的卡布其诺咖啡豆，带来了一场美妙的晨曦之舞。这些深棕色的咖啡豆散发着诱人的香气，仿佛清晨初露的第一缕阳光。每一颗豆子都经过精心挑选和烘焙，保留了卡布其诺咖啡独特的风味特点。品尝「晨曦之舞」，你会感受到浓郁的巧克力和坚果的滋味，伴随着轻柔的水果和花香，每一口都如同在优雅的舞蹈中徜徉。无论是与朋友分享欢乐的时刻，还是独自享受宁静的时光，「晨曦之舞」都会为你带来温暖、愉悦的咖啡体验，让你沉浸在一片美好的晨曦中。', '深棕色', '阿拉比卡咖啡豆', '哥伦比亚', 1, 99.00, 79.00, 80, '2026-01-29 21:40:11', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/1.png', 20);
INSERT INTO `commodity` VALUES (7, '「秘境之韵」', '「秘境之韵」是一款珍贵而迷人的乌干达咖啡。这些咖啡豆生长在乌干达的高海拔地区，经过精心挑选和精湛的烘焙工艺，展现出了它们独特的品质。「秘境之韵」散发着浓郁的巧克力和坚果的香气，口感饱满顺滑，带来一种令人陶醉的感受。无论是悠闲地品味一杯，还是与朋友分享美好时光，「秘境之韵」都能带给你独特而深沉的咖啡体验。', '「秘境之韵」，一袋来自乌干达的顶级咖啡豆，诠释着这片神秘土地的独特韵味。这些深沉的棕褐色咖啡豆散发着浓郁的香气，仿佛置身于乌干达的广袤大地。每一颗豆子都经过精心挑选和精湛的烘焙工艺，保留了乌干达咖啡的独特风味。品尝「秘境之韵」，你会感受到浓郁的巧克力和坚果的口感，带来舌尖上的愉悦与满足。无论是沉浸在宁静的早晨，还是享受夜晚的宁静时刻，「秘境之韵」都将为你带来一场独特的咖啡冒险，让你感受到大地的沉静与厚重，品味乌干达的秘境之美。', '棕褐色', '阿拉比卡', '乌干达', 10, 109.00, 99.00, 7, '2025-06-21 23:31:49', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/6.png', 9);
INSERT INTO `commodity` VALUES (8, '「阳光之舞」', '「阳光之舞」是一款优雅而充满阳光气息的哥伦比亚咖啡。这些咖啡豆生长于哥伦比亚的高海拔地区，经过精心挑选和烘焙，展现出了它们独特的风味。「阳光之舞」的口感醇厚且平衡，带来了令人陶醉的味觉体验。无论是早晨的第一杯咖啡还是午后的放松时光，「阳光之舞」都能为你带来温暖、愉悦的享受。', '「阳光之舞」，一袋来自哥伦比亚的卓越咖啡豆，散发着温暖阳光的气息。这些深棕色的咖啡豆经过精心挑选和烘焙，保留了哥伦比亚咖啡独特的风味特点。「阳光之舞」的口感醇厚，带有巧克力和坚果的风味，伴随着轻盈的花香和水果香。无论是在早晨开始新的一天，还是在午后与朋友分享美好时刻，「阳光之舞」都能为你带来令人陶醉的味觉体验，让你沉浸在温暖阳光中跳跃的舞蹈中。', '深棕色', '阿拉比卡', '哥伦比亚', 11, 88.00, 60.00, 4, '2025-06-21 23:48:30', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/3.png', 12);
INSERT INTO `commodity` VALUES (9, '「冰封之心」', '「冰封之心」是一款清新纯净的冰咖啡。这种独特的制作方式，使得咖啡豆的香气和口感更为浓郁，同时又不失清爽。无论是在炎炎夏日的午后还是加班疲惫的晚上，「冰封之心」都能为你带来一份清凉活力。', '「冰封之心」，一款清新纯净的冰咖啡。这种独特的制作方式，使得咖啡豆的香气和口感更为浓郁，同时又不失清爽。「冰封之心」独特的口感和香气，仿佛将冰雪的清凉和阳光的温暖融合在一起。无论是搭配甜品、沙拉，还是单独享用，「冰封之心」都能带给你一份清新纯净的味觉体验，让你的味蕾在冰凉中舒爽地展开', '明亮透明', '阿拉比卡', '巴西、哥伦比亚、埃塞俄比亚等', 2, 129.00, 99.00, 6, '2026-01-29 21:39:44', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/2.png', 2);
INSERT INTO `commodity` VALUES (10, '「巧克力之梦」', '「巧克力之梦」是一款浓郁而诱人的摩卡咖啡。这款咖啡融合了咖啡和巧克力的美妙组合，带来了独特的口感和香气。「巧克力之梦」让你仿佛置身于巧克力的世界中，感受到甜蜜与满足。', '「巧克力之梦」，一款浓郁而诱人的摩卡咖啡。这款咖啡融合了咖啡和巧克力的美妙组合，带来了独特的口感和香气。「巧克力之梦」的浓郁巧克力味与咖啡的醇厚回味相互交织，让你沉浸在无尽的味觉享受中。无论是早晨的第一杯咖啡还是下午休憩时光，「巧克力之梦」都能为你带来一份甜蜜、诱人的美味体验，让你的味蕾沉醉在巧克力的梦境中。', '深褐色', '阿拉比卡', '巴西、哥伦比亚等', 3, 100.00, 50.00, 78, '2025-06-12 13:17:27', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/4.png', 22);
INSERT INTO `commodity` VALUES (11, '「赤道之韵」', '「赤道之韵」是一款充满活力和个性的刚果咖啡。这种咖啡以其深邃的口感和丰富的香气而著称。赤道之韵的咖啡豆种植于刚果的高海拔地区，得益于赤道地理位置的优势，享受到丰富的阳光和充沛的降雨。无论是清晨的第一口还是下午的小憩，赤道之韵都能为你带来一份充满活力和个性的咖啡体验，让你的味蕾沉浸在源自赤道大陆的热情与魅力中。', '「赤道之韵」一款充满活力和个性的刚果咖啡。这种咖啡以其深邃的口感和丰富的香气而著称。赤道之韵的咖啡豆在刚果的阳光和热带气候中茁壮成长，成为一款独具特色的咖啡作品。无论是清晨的第一口还是下午的小憩，赤道之韵都能为你带来一份充满活力和个性的咖啡体验，让你的味蕾沉浸在源自赤道大陆的热情与魅力中。', '深棕色', '刚果咖啡豆', '刚果高海拔地区', 1, 59.00, 50.00, 3, '2025-06-21 23:21:43', 1, 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/5.png', 6);

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
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '商品评价表' ROW_FORMAT = DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (18, '1703686315512', 2, 6, '卡布其诺-「晨曦之舞」*3', 'SF345834759394579', '顺丰快递', '2025-06-21 12:11:56', '2025-06-21 12:11:56', '2025-06-21 12:21:35', '2025-06-21 12:49:10', 2, 1);
INSERT INTO `order` VALUES (19, '1703686360015', 2, 8, '哥伦比亚咖啡-「阳光之舞」*1', 'YD5782345728935', '韵达快递', '2025-06-21 12:12:40', '2025-06-21 12:12:40', '2025-06-21 12:22:32', '2025-06-21 12:49:17', 2, 1);
INSERT INTO `order` VALUES (20, '1703686374468', 2, 9, '冰咖啡-「冰封之心」*1', 'YT32423487923423', '圆通快递', '2025-06-21 12:12:54', '2025-06-21 12:12:54', '2025-06-21 12:21:59', '2025-06-21 12:49:21', 2, 2);
INSERT INTO `order` VALUES (21, '1703687408750', 3, 8, '哥伦比亚咖啡-「阳光之舞」*1', NULL, NULL, '2025-06-21 12:30:09', '2025-06-21 12:30:09', NULL, NULL, 0, 8);
INSERT INTO `order` VALUES (22, '1703687498076', 3, 8, '哥伦比亚咖啡-「阳光之舞」*5', NULL, NULL, '2025-06-21 12:31:38', '2025-06-21 12:31:38', NULL, NULL, -1, 8);
INSERT INTO `order` VALUES (23, '1703687506494', 3, 6, '卡布其诺-「晨曦之舞」*4', NULL, NULL, '2025-06-21 12:31:46', '2025-06-21 12:31:46', NULL, NULL, 0, 8);
INSERT INTO `order` VALUES (24, '1703687515172', 3, 9, '冰咖啡-「冰封之心」*1', 'SF723894728934', '顺丰快递', '2025-06-21 12:31:55', '2025-06-21 12:31:55', '2025-06-21 12:41:20', NULL, 1, 8);
INSERT INTO `order` VALUES (25, '1703687522584', 3, 11, '卡布其诺-「赤道之韵」*2', 'EMS345897342342', '邮政EMS', '2025-06-21 12:32:03', '2025-06-21 12:32:03', '2025-06-21 12:53:50', '2025-06-21 12:56:03', 2, 8);
INSERT INTO `order` VALUES (26, '1703687537380', 3, 10, '摩卡咖啡-「巧克力之梦」*2', NULL, NULL, '2025-06-21 12:32:17', '2025-06-21 12:32:17', NULL, NULL, -1, 8);
INSERT INTO `order` VALUES (27, '1703687545402', 3, 7, '乌干达咖啡-「秘境之韵」*3', 'YT242342342345', '圆通快递', '2025-06-21 12:32:25', '2025-06-21 12:32:25', '2025-06-21 12:41:47', '2025-06-21 12:42:40', 2, 8);
INSERT INTO `order` VALUES (28, '1703687623966', 3, 10, '摩卡咖啡-「巧克力之梦」*3', 'SF57892734594', '顺丰快递', '2025-06-21 12:33:44', '2025-06-21 12:33:44', '2025-06-21 12:41:27', '2025-06-21 12:42:45', 2, 8);
INSERT INTO `order` VALUES (29, '1703687633368', 3, 6, '卡布其诺-「晨曦之舞」*4', NULL, NULL, '2025-06-21 12:33:53', '2025-06-21 12:33:53', NULL, NULL, 0, 8);
INSERT INTO `order` VALUES (30, '1703687642921', 3, 7, '乌干达咖啡-「秘境之韵」*2', NULL, NULL, '2025-06-21 12:34:03', '2025-06-21 12:34:03', NULL, NULL, -1, 8);
INSERT INTO `order` VALUES (31, '1703687651178', 3, 8, '哥伦比亚咖啡-「阳光之舞」*2', 'SF4782934789234', '顺丰快递', '2025-06-21 12:34:11', '2025-06-21 12:34:11', '2025-06-21 12:41:35', NULL, 1, 8);
INSERT INTO `order` VALUES (32, '1703688676216', 2, 7, '乌干达咖啡-「秘境之韵」*3', 'SF523458934025', '顺丰快递', '2025-06-21 12:51:16', '2025-06-21 12:51:16', '2025-06-21 12:53:23', '2025-06-21 12:54:28', 2, 1);
INSERT INTO `order` VALUES (34, '1703688718579', 2, 11, '卡布其诺-「赤道之韵」*1', NULL, NULL, '2025-06-21 12:51:59', '2025-06-21 12:51:59', NULL, NULL, -1, 1);
INSERT INTO `order` VALUES (35, '1750517678444', 1, 8, '哥伦比亚咖啡-「阳光之舞」*1', 'test1', '顺丰快递', '2025-06-21 22:54:38', '2025-06-21 22:54:38', '2025-06-21 22:54:49', '2025-06-21 22:54:54', 2, 10);
INSERT INTO `order` VALUES (36, '1750521367220', 1, 11, '卡布其诺-「赤道之韵」*1', 'test', '顺丰快递', '2025-06-21 23:56:07', '2025-06-21 23:56:07', '2025-06-21 23:56:36', '2025-06-21 23:56:45', 2, 10);
INSERT INTO `order` VALUES (37, '1750560639892', 4, 10, '摩卡咖啡-「巧克力之梦」*1', '1', '顺丰快递', '2025-06-22 10:50:40', '2025-06-22 10:50:40', '2025-06-22 10:52:07', '2025-06-22 10:52:12', 2, 11);
INSERT INTO `order` VALUES (38, '1750569366271', 1, 6, '卡布其诺-「晨曦之舞」*1', 'test', '顺丰快递', '2025-06-22 13:16:06', '2025-06-22 13:16:06', '2025-06-22 13:16:30', '2025-06-22 13:16:40', 2, 10);
INSERT INTO `order` VALUES (39, '1762589289772', 1, 8, '哥伦比亚咖啡-「阳光之舞」*1', NULL, NULL, '2025-11-08 16:08:10', '2025-11-08 16:08:10', NULL, NULL, 0, 10);
INSERT INTO `order` VALUES (40, '1763777808418', 1, 10, '摩卡咖啡-「巧克力之梦」*1', NULL, NULL, '2025-11-22 10:16:48', '2025-11-22 10:16:48', NULL, NULL, 0, 10);
INSERT INTO `order` VALUES (41, '1768139879348', 1, 6, '卡布其诺-「晨曦之舞」*2', NULL, NULL, '2026-01-11 21:57:59', '2026-01-11 21:57:59', NULL, NULL, 0, 10);
INSERT INTO `order` VALUES (42, '1768292434917-1', 1, 6, '卡布其诺-「晨曦之舞」*1', NULL, NULL, '2026-01-13 16:20:35', '2026-01-13 16:20:35', NULL, NULL, 0, 10);
INSERT INTO `order` VALUES (43, '1768292434917-2', 1, 8, '哥伦比亚咖啡-「阳光之舞」*1', NULL, NULL, '2026-01-13 16:20:35', '2026-01-13 16:20:35', NULL, NULL, 0, 10);
INSERT INTO `order` VALUES (44, '1772808432655-1', 2, 6, '卡布其诺-「晨曦之舞」*2', NULL, NULL, '2026-03-06 22:47:13', '2026-03-06 22:47:13', NULL, NULL, 0, 1);
INSERT INTO `order` VALUES (45, '1772808432655-2', 2, 11, '卡布其诺-「赤道之韵」*1', NULL, NULL, '2026-03-06 22:47:13', '2026-03-06 22:47:13', NULL, NULL, 0, 1);
INSERT INTO `order` VALUES (46, '1772811875674-1', 1, 6, '卡布其诺-「晨曦之舞」*1', NULL, NULL, '2026-03-06 23:44:36', '2026-03-06 23:44:36', NULL, NULL, 0, 10);
INSERT INTO `order` VALUES (47, '1775581057469-1', 1, 10, '摩卡咖啡-「巧克力之梦」*15', NULL, NULL, '2026-04-08 00:57:37', '2026-04-08 00:57:37', NULL, NULL, 0, 10);
INSERT INTO `order` VALUES (48, '1775581100220-1', 1, 11, '卡布其诺-「赤道之韵」*1', NULL, NULL, '2026-04-08 00:58:20', '2026-04-08 00:58:20', NULL, NULL, 0, 10);

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
  `role` int NULL DEFAULT 0 COMMENT '身份角色【0:用户】【1:管理员】',
  `update_time` datetime NULL DEFAULT NULL COMMENT '信息更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '管理员', 'x12345', 'admin@qq.com', 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/default.png', '我们热爱我们的咖啡。我们相信通过一杯高品质的手工咖啡可以传递和分享真挚情感，而这样简单的行为或许可以为顾客提供一些正能量。 因此，【咖咖】始终致力于通过道德采购，烘焙并提供高品质的咖啡豆。 从一粒种子到一杯咖啡，每一个环节都倾入了【咖咖】的心意和努力， 只为每一次光顾我们门店的顾客可以享受醇香的浓缩咖啡及其钟爱的咖啡饮品。', '2025-06-21 10:16:41', 1, '2026-04-08 00:59:12');
INSERT INTO `user` VALUES (2, '张三', 'x12345', 'zs@qq.com', 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/hmbb.png', '-', '2025-06-21 11:46:38', 0, '2025-06-21 11:47:13');
INSERT INTO `user` VALUES (3, '李四', 'x12345', 'ls@qq.com', '\r\nhttps://hgltest.oss-cn-hangzhou.aliyuncs.com/pdx.png', '-', '2025-06-21 12:46:56', 0, '2025-06-21 12:47:36');
INSERT INTO `user` VALUES (4, 'hgl', 'x12345', '1265209172@qq.com', 'https://hgltest.oss-cn-hangzhou.aliyuncs.com/hmbb.png', '我喜欢喝咖啡', '2025-06-22 10:19:29', 0, '2025-06-22 10:40:26');

SET FOREIGN_KEY_CHECKS = 1;
