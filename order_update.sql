USE `coffee-shop`;

ALTER TABLE `classify` ADD COLUMN `sort_order` INT DEFAULT 99 COMMENT '排序权重';

UPDATE `classify` SET `sort_order` = 1 WHERE id = 2; -- 冰咖啡
UPDATE `classify` SET `sort_order` = 2 WHERE id = 4; -- 阿拉比卡咖啡
UPDATE `classify` SET `sort_order` = 3 WHERE id = 5; -- 罗布斯塔
