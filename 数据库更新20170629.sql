

-- 项目表新增字段
ALTER TABLE `project`
ADD COLUMN `customer_name`  varchar(20) NULL COMMENT '客户名' AFTER `project_status`,
ADD COLUMN `customer_phone`  varchar(20) NULL COMMENT '客户手机' AFTER `customer_name`,
ADD COLUMN `is_report`  tinyint(1) NULL DEFAULT 0 COMMENT '是否报备到orvibo' AFTER `customer_phone`,
ADD COLUMN `is_delete`  tinyint(1) NULL DEFAULT 0 COMMENT '删除标志' AFTER `is_report`;
-- 产品表新增字段
ALTER TABLE `product`
ADD COLUMN `smart_system_id`  int(11) DEFAULT NULL COMMENT '所属智能系统';

-- banner表
DROP TABLE IF EXISTS `t_baseinfo_banner`;
CREATE TABLE `t_baseinfo_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `image_url` varchar(255) DEFAULT NULL COMMENT '图片url',
  `image_alt` varchar(255) DEFAULT NULL COMMENT '图片的alt说明',
  `link` varchar(255) DEFAULT NULL COMMENT '图片超链接',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `type` mediumint(9) DEFAULT NULL COMMENT 'banner类型',
  `sn` mediumint(9) DEFAULT NULL COMMENT '序号',
  `status` tinyint(1) DEFAULT NULL COMMENT '启用/禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='banner表';

-- 用户消息相关表
-- ----------------------------
-- Table structure for t_msg_message_content
-- ----------------------------
CREATE TABLE `t_msg_message_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `message_text` text NOT NULL COMMENT '消息内容',
  `message_title` varchar(255) DEFAULT NULL COMMENT '消息标题',
  `message_summary` varchar(255) DEFAULT NULL COMMENT '消息概要',
  `thumb_image` varchar(255) DEFAULT NULL COMMENT '标题缩略图',
  `message_type` tinyint(4) DEFAULT NULL COMMENT '消息类型 1表示1对1的消息，2表示1对组的消息，3表示全局消息',
  `content_type` tinyint(4) DEFAULT NULL COMMENT '消息内容类型 0-系统公告 1-系统消息 2-订单消息 3-项目消息 4-支持消息',
  `sender_id` int(11) DEFAULT NULL COMMENT '发送者id  0表示系统消息',
  `owner_id` int(11) DEFAULT NULL COMMENT '0-全局消息  其他为对应接受者id  type=2时为某一分组的消息',
  `foreign_id` int(11) DEFAULT NULL COMMENT '消息 可能关联的外键key',
  `sn` mediumint(9) DEFAULT '0' COMMENT '序号，默认为0',
  `status` tinyint(4) DEFAULT NULL COMMENT '消息状态 0-草稿箱 1-已发布 2-以回收',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='消息正文 一对一 一对多 消息';

-- ----------------------------
-- Table structure for t_msg_message_log
-- ----------------------------
DROP TABLE IF EXISTS `t_msg_message_log`;
CREATE TABLE `t_msg_message_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `message_id` int(11) NOT NULL COMMENT '消息id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `read_flag` tinyint(1) DEFAULT NULL COMMENT '阅读标志 true-已读 false-未读',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新人',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户消息状态记录（已读、未读、删除等）';

-- 快速报价相关表

-- ----------------------------
-- Table structure for t_sale_intention
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_intention`;
CREATE TABLE `t_sale_intention` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '报价单id',
  `note` varchar(255) DEFAULT NULL COMMENT '报价单名称',
  `project_id` int(11) DEFAULT NULL COMMENT '关联的项目id',
  `order_id` int(11) DEFAULT NULL COMMENT '关联的订单id',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '客户名',
  `customer_phone` varchar(20) DEFAULT NULL COMMENT '客户手机号',
  `customer_address` varchar(255) DEFAULT NULL COMMENT '客户地址',
  `price` decimal(10,0) DEFAULT NULL COMMENT '价格',
  `final_price` decimal(10,0) DEFAULT NULL COMMENT '最终价格',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `partner_id` int(11) DEFAULT NULL COMMENT '合作商id',
  `template_name` varchar(255) DEFAULT NULL COMMENT '户型',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `template_id` int(11) DEFAULT NULL COMMENT '户型id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1157 DEFAULT CHARSET=utf8 COMMENT='意向报价单';

-- ----------------------------
-- Table structure for t_sale_intention_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_intention_detail`;
CREATE TABLE `t_sale_intention_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `intention_id` int(11) NOT NULL COMMENT '报价单id',
  `space_id` int(11) NOT NULL COMMENT '空间id',
  `space_name` varchar(255) NOT NULL COMMENT '空间名',
  `system_id` int(11) NOT NULL COMMENT '智能系统id',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `product_num` int(11) NOT NULL COMMENT '产品数量',
  `product_name` varchar(255) DEFAULT NULL COMMENT '产品名',
  `product_model` varchar(255) DEFAULT NULL COMMENT '产品型号',
  `product_description` varchar(255) DEFAULT NULL COMMENT '产品描述',
  `product_image_url` varchar(255) DEFAULT NULL COMMENT '产品图片',
  `product_price` decimal(10,0) DEFAULT NULL COMMENT '产品单价',
  `product_total_price` decimal(10,0) DEFAULT NULL COMMENT '产品总价',
  `category_name` varchar(255) DEFAULT NULL COMMENT '产品目录',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  `version_id` int(11) DEFAULT NULL COMMENT '版本id',
  `product_code` varchar(255) DEFAULT NULL COMMENT '产品编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5366 DEFAULT CHARSET=utf8 COMMENT='报价意向单明细';

-- ----------------------------
-- Table structure for t_sale_intention_system_version
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_intention_system_version`;
CREATE TABLE `t_sale_intention_system_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `intention_id` int(11) NOT NULL COMMENT '报价单id',
  `system_id` int(11) NOT NULL COMMENT '系统id',
  `version_id` int(11) NOT NULL COMMENT '版本id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4666 DEFAULT CHARSET=utf8 COMMENT='报价单相关系统版本信息';

-- ----------------------------
-- Table structure for t_sale_smart_system
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_smart_system`;
CREATE TABLE `t_sale_smart_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `system_name` varchar(255) NOT NULL COMMENT '智能系统名',
  `system_short_name` varchar(255) DEFAULT NULL COMMENT '系统简称',
  `status` tinyint(1) DEFAULT NULL COMMENT '启用状态',
  `image_url` varchar(255) DEFAULT NULL COMMENT '图标',
  `note` varchar(512) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='智能系统表';

-- ----------------------------
-- Table structure for t_sale_smart_system_version
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_smart_system_version`;
CREATE TABLE `t_sale_smart_system_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `smart_system_id` int(11) NOT NULL COMMENT '智能系统的id',
  `version_id` int(11) NOT NULL COMMENT '版本id  基础版/标准版/尊享版等',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  `image_url` varchar(512) DEFAULT NULL,
  `note` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sale_space
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_space`;
CREATE TABLE `t_sale_space` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `space_name` varchar(255) NOT NULL COMMENT '空间名',
  `image_url` varchar(512) DEFAULT NULL COMMENT '空间配置的图片',
  `icon_url` varchar(255) DEFAULT NULL COMMENT '图标的url',
  `icon2_url` varchar(255) DEFAULT NULL COMMENT '第二个icon',
  `note` varchar(512) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='空间信息表';

-- ----------------------------
-- Table structure for t_sale_space_product
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_space_product`;
CREATE TABLE `t_sale_space_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `space_id` int(11) NOT NULL COMMENT '空间id',
  `version_id` int(11) NOT NULL COMMENT '版本id',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `product_num` int(11) DEFAULT NULL COMMENT '产品数量',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sale_template
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_template`;
CREATE TABLE `t_sale_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '快速报价模版id',
  `template_name` varchar(255) NOT NULL COMMENT '快速报价名',
  `image_url` varchar(255) DEFAULT NULL COMMENT '户型图url',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  `note` varchar(512) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态 启用禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='快速报价模版';

-- ----------------------------
-- Table structure for t_sale_template_space
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_template_space`;
CREATE TABLE `t_sale_template_space` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `template_id` int(11) NOT NULL COMMENT '模版id',
  `space_id` int(11) NOT NULL COMMENT '空间id',
  `space_num` int(11) DEFAULT NULL COMMENT '空间数量',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='模版空间关联表';

-- ----------------------------
-- Table structure for t_sale_version
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_version`;
CREATE TABLE `t_sale_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `version_name` varchar(255) NOT NULL COMMENT '版本名',
  `sn` mediumint(9) DEFAULT '0' COMMENT '序号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  `note` varchar(512) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='智能系统版本';




-- 系统表

-- ----------------------------
-- Table structure for t_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_config`;
CREATE TABLE `t_sys_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `code` varchar(255) NOT NULL COMMENT '代码',
  `value` varchar(255) NOT NULL COMMENT '配置值',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Table structure for t_sys_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_dictionary`;
CREATE TABLE `t_sys_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `type_code` int(11) NOT NULL COMMENT '类型编码',
  `type_value` varchar(255) NOT NULL COMMENT '类型说明',
  `item_code` int(11) DEFAULT NULL COMMENT '明细编码',
  `item_value` varchar(255) DEFAULT NULL COMMENT '明细说明',
  `status` tinyint(1) NOT NULL COMMENT '状态0-禁用 1-启用',
  `create_time` datetime DEFAULT NULL,
  `create_user` varchar(255) DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `last_update_user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_sys_operate_record
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_operate_record`;
CREATE TABLE `t_sys_operate_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `ip_addr` varchar(255) DEFAULT NULL COMMENT '操作者ip',
  `oper_user` int(11) DEFAULT NULL COMMENT '操作者id',
  `relative_id` int(11) DEFAULT NULL COMMENT '关联id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) DEFAULT NULL COMMENT '创建人',
  `last_update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_update_user` varchar(255) DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户操作日指表';
