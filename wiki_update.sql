USE `coffee-shop`;

-- Add columns if they do not exist
ALTER TABLE `classify` ADD COLUMN `description` TEXT DEFAULT NULL COMMENT '百科介绍';
ALTER TABLE `classify` ADD COLUMN `cover_image` VARCHAR(255) DEFAULT NULL COMMENT '百科图片';

-- Populate data
UPDATE `classify` SET 
  `description` = '一种传统的意式咖啡，由大约等量的浓缩咖啡、热牛奶和奶泡组成。口感醇厚绵密，带有微微的焦糖香，奶香与咖啡香达到完美的黄金比例平衡。', 
  `cover_image` = 'front/assets/img/products/1.png'
WHERE id = 1;

UPDATE `classify` SET 
  `description` = '通过将热咖啡加冰块极速冷却，或利用冷水长时间浸泡（冷萃）制成的咖啡。清爽解渴，非常适合炎热的夏季饮用，能够最大程度锁住咖啡的清新香气。', 
  `cover_image` = 'front/assets/img/blog/1.jpg'
WHERE id = 2;

UPDATE `classify` SET 
  `description` = '以意式浓缩咖啡为底，加入香浓巧克力糖浆、热牛奶和雪白的鲜奶油。咖啡与巧克力的绝妙组合带来了异常丰富甜美的口感，是许多人的初恋咖啡。', 
  `cover_image` = 'front/assets/img/products/3.png'
WHERE id = 3;

UPDATE `classify` SET 
  `description` = '全球产量最高的咖啡豆种，主要生长于高海拔地区。拥有出色的酸甜平衡度和迷人的花朵、水果香气。咖啡因含量较低，是精品高档咖啡不变的首选。', 
  `cover_image` = 'front/assets/img/blog/2.jpg'
WHERE id = 4;

UPDATE `classify` SET 
  `description` = '抗病虫害能力极强，生长于低海拔。特点是咖啡因含量高，脂质丰富，常带有强烈的泥土、麦香和黑巧克力味，多用于浓缩拼配带来浓郁厚重、满布油脂（Crema）的口感。', 
  `cover_image` = 'front/assets/img/blog/3.jpg'
WHERE id = 5;

UPDATE `classify` SET 
  `description` = '产自非洲腹地的独特咖啡资源，风味野性且富有表现力。通常带有浓郁的热带水果、香料香气，以及犹如坚果般的醇厚底蕴。', 
  `cover_image` = 'front/assets/img/products/6.png'
WHERE id = 6;

UPDATE `classify` SET 
  `description` = '产自加勒比海牙买加蓝山山脉的顶级珍宝。酸度微弱、口感极致丝滑，散发出淡淡的坚果和巧克力香气，以其完美的均衡感和极佳的纯度享誉全球。', 
  `cover_image` = 'front/assets/img/products/7.png'
WHERE id = 7;

UPDATE `classify` SET 
  `description` = '生长于夏威夷火山岩地貌，土壤富含微量矿物质。独特的热带气候赋予它明亮的果酸、细腻的焦糖甜感及淡淡的花香，余韵悠长，极其珍稀。', 
  `cover_image` = 'front/assets/img/products/8.png'
WHERE id = 8;

UPDATE `classify` SET 
  `description` = '亚洲深度风味咖啡的代表，入口极其浓烈醇厚。几乎剥离了酸度，带有标志性的草本植物、雪松木和黑巧克力的深沉焦调底韵。', 
  `cover_image` = 'front/assets/img/products/9.png'
WHERE id = 9;

UPDATE `classify` SET 
  `description` = '非洲咖啡中不可忽视的一把火炬。乌干达不仅以优质的罗布斯塔豆闻名，其高地也出产优秀的阿拉比卡。风味通常呈现强烈的可可调性，酸质圆润，伴有果干风味。', 
  `cover_image` = 'front/assets/img/products/10.png'
WHERE id = 10;

UPDATE `classify` SET 
  `description` = '南美洲咖啡工艺的标杆。以精湛的水洗法处理为主，口感极为干净均衡。拥有明亮柔和的柑橘果酸、圆润的醇度以及焦糖般甜美持久的回甘。', 
  `cover_image` = 'front/assets/img/products/11.png'
WHERE id = 11;
