SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cms_category
-- ----------------------------
DROP TABLE IF EXISTS `cms_category`;
CREATE TABLE `cms_category` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `parent_id` int(11) default NULL COMMENT '父分类ID',
  `type_id` int(11) default NULL COMMENT '分类类型',
  `child_ids` text COMMENT '所有子分类ID',
  `tag_type_ids` text default NULL COMMENT '标签分类',
  `code` varchar(50) default NULL COMMENT '编码',
  `template_path` varchar(255) default NULL COMMENT '模板路径',
  `path` varchar(2000) NOT NULL COMMENT '首页路径',
  `only_url` tinyint(1) NOT NULL COMMENT '外链',
  `has_static` tinyint(1) NOT NULL COMMENT '已经静态化',
  `url` varchar(2048) default NULL COMMENT '首页地址',
  `content_path` varchar(500) default NULL COMMENT '内容路径',
  `contain_child` tinyint(1) NOT NULL DEFAULT 1 COMMENT '包含子分类内容',
  `page_size` int(11) default NULL COMMENT '每页数据条数',
  `allow_contribute` tinyint(1) NOT NULL COMMENT '允许投稿',
  `sort` int(11) NOT NULL default '0' COMMENT '顺序',
  `hidden` tinyint(1) NOT NULL COMMENT '隐藏',
  `disabled` tinyint(1) NOT NULL COMMENT '是否删除',
  `extend_id` int(11) default NULL COMMENT '扩展ID',
  PRIMARY KEY  (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `disabled` (`disabled`),
  KEY `sort` (`sort`),
  KEY `site_id` (`site_id`),
  KEY `type_id` (`type_id`),
  KEY `allow_contribute` (`allow_contribute`),
  KEY `hidden` (`hidden`)
) COMMENT='分类';

-- ----------------------------
-- Table structure for cms_category_attribute
-- ----------------------------
DROP TABLE IF EXISTS `cms_category_attribute`;
CREATE TABLE `cms_category_attribute` (
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  `title` varchar(80) default NULL COMMENT '标题',
  `keywords` varchar(100) default NULL COMMENT '关键词',
  `description` varchar(300) default NULL COMMENT '描述',
  `data` longtext COMMENT '数据JSON',
  PRIMARY KEY  (`category_id`)
) COMMENT='分类扩展';

-- ----------------------------
-- Table structure for cms_category_model
-- ----------------------------
DROP TABLE IF EXISTS `cms_category_model`;
CREATE TABLE `cms_category_model` (
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  `model_id` varchar(20) NOT NULL COMMENT '模型编码',
  `template_path` varchar(200) default NULL COMMENT '内容模板路径',
  PRIMARY KEY  (`category_id`,`model_id`)
) COMMENT='分类模型';

-- ----------------------------
-- Table structure for cms_category_type
-- ----------------------------
DROP TABLE IF EXISTS `cms_category_type`;
CREATE TABLE `cms_category_type` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `sort` int(11) NOT NULL COMMENT '排序',
  `extend_id` int(11) default NULL COMMENT '扩展ID',
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) COMMENT='分类类型';

-- ----------------------------
-- Table structure for cms_content
-- ----------------------------
DROP TABLE IF EXISTS `cms_content`;
CREATE TABLE `cms_content` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `user_id` bigint(20) NOT NULL COMMENT '发表用户',
  `check_user_id` bigint(20) default NULL COMMENT '审核用户',
  `category_id` int(11) NOT NULL COMMENT '分类',
  `model_id` varchar(20) NOT NULL COMMENT '模型',
  `parent_id` bigint(20) default NULL COMMENT '父内容ID',
  `copied` tinyint(1) NOT NULL COMMENT '是否转载',
  `author` varchar(50) default NULL COMMENT '作者',
  `editor` varchar(50) default NULL COMMENT '编辑',
  `only_url` tinyint(1) NOT NULL COMMENT '外链',
  `has_images` tinyint(1) NOT NULL COMMENT '拥有图片列表',
  `has_files` tinyint(1) NOT NULL COMMENT '拥有附件列表',
  `has_static` tinyint(1) NOT NULL COMMENT '已经静态化',
  `url` varchar(2048) default NULL COMMENT '地址',
  `description` varchar(300) default NULL COMMENT '简介',
  `tag_ids` text default NULL COMMENT '标签',
  `cover` varchar(255) default NULL COMMENT '封面',
  `childs` int(11) NOT NULL COMMENT '子内容数',
  `scores` int(11) NOT NULL COMMENT '分数',
  `comments` int(11) NOT NULL COMMENT '评论数',
  `clicks` int(11) NOT NULL COMMENT '点击数',
  `publish_date` datetime NOT NULL COMMENT '发布日期',
  `check_date` datetime default NULL COMMENT '审核日期',
  `update_date` datetime default NULL COMMENT '更新日期',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `sort` int(11) NOT NULL default '0' COMMENT '顺序',
  `status` int(11) NOT NULL COMMENT '状态：0、草稿 1、已发布 2、待审核',
  `disabled` tinyint(1) NOT NULL COMMENT '是否删除',
  PRIMARY KEY  (`id`),
  KEY `check_date` (`check_date`,`update_date`),
  KEY `scores` (`scores`,`comments`,`clicks`),
  KEY `status` (`site_id`,`status`,`category_id`,`disabled`,`model_id`,`parent_id`,`sort`,`publish_date`),
  KEY `only_url` (`only_url`,`has_images`,`has_files`,`user_id`)
) COMMENT='内容';

-- ----------------------------
-- Table structure for cms_content_attribute
-- ----------------------------
DROP TABLE IF EXISTS `cms_content_attribute`;
CREATE TABLE `cms_content_attribute` (
  `content_id` bigint(20) NOT NULL,
  `source` varchar(50) default NULL COMMENT '内容来源',
  `source_url` varchar(2048) default NULL COMMENT '来源地址',
  `data` longtext COMMENT '数据JSON',
  `text` longtext COMMENT '内容',
  `word_count` int(11) NOT NULL COMMENT '字数',
  PRIMARY KEY  (`content_id`)
) COMMENT='内容扩展';

-- ----------------------------
-- Table structure for cms_content_file
-- ----------------------------
DROP TABLE IF EXISTS `cms_content_file`;
CREATE TABLE `cms_content_file` (
  `id` bigint(20) NOT NULL auto_increment,
  `content_id` bigint(20) NOT NULL COMMENT '内容',
  `user_id` bigint(20) NOT NULL COMMENT '用户',
  `file_path` varchar(255) NOT NULL COMMENT '文件路径',
  `image` tinyint(1) NOT NULL COMMENT '是否图片',
  `size` int(11) NOT NULL COMMENT '大小',
  `clicks` int(11) NOT NULL COMMENT '点击数',
  `sort` int(11) NOT NULL COMMENT '排序',
  `description` varchar(300) default NULL COMMENT '描述',
  PRIMARY KEY  (`id`),
  KEY `content_id` (`content_id`),
  KEY `sort` (`sort`),
  KEY `image` (`image`),
  KEY `size` (`size`),
  KEY `clicks` (`clicks`),
  KEY `user_id` (`user_id`)
) COMMENT='内容附件';

-- ----------------------------
-- Table structure for cms_content_related
-- ----------------------------
DROP TABLE IF EXISTS `cms_content_related`;
CREATE TABLE `cms_content_related` (
  `id` bigint(20) NOT NULL auto_increment,
  `content_id` bigint(20) NOT NULL COMMENT '内容',
  `related_content_id` bigint(20) default NULL COMMENT '推荐内容',
  `user_id` bigint(20) NOT NULL COMMENT '推荐用户',
  `url` varchar(2048) default NULL COMMENT '推荐链接地址',
  `title` varchar(255) default NULL COMMENT '推荐标题',
  `description` varchar(300) default NULL COMMENT '推荐简介',
  `clicks` int(11) NOT NULL COMMENT '点击数',
  `sort` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`content_id`,`related_content_id`,`user_id`,`clicks`,`sort`)
) COMMENT='推荐推荐';

-- ----------------------------
-- Table structure for cms_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `cms_dictionary`;
CREATE TABLE `cms_dictionary` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `multiple` tinyint(1) NOT NULL COMMENT '允许多选',
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`,`multiple`)
) COMMENT='字典';

-- ----------------------------
-- Table structure for cms_dictionary_data
-- ----------------------------
DROP TABLE IF EXISTS `cms_dictionary_data`;
CREATE TABLE `cms_dictionary_data` (
  `dictionary_id` bigint(20) NOT NULL COMMENT '字典',
  `value` varchar(50) NOT NULL COMMENT '值',
  `text` varchar(100) NOT NULL COMMENT '文字',
  PRIMARY KEY  (`dictionary_id`,`value`)
) COMMENT='字典数据';

-- ----------------------------
-- Table structure for cms_place
-- ----------------------------
DROP TABLE IF EXISTS `cms_place`;
CREATE TABLE `cms_place` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `path` varchar(100) NOT NULL COMMENT '模板路径',
  `user_id` bigint(20) default NULL COMMENT '提交用户',
  `item_type` varchar(50) default NULL COMMENT '推荐项目类型',
  `item_id` bigint(20) default NULL COMMENT '推荐项目ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `url` varchar(2048) default NULL COMMENT '超链接',
  `cover` varchar(255) default NULL COMMENT '封面图',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `publish_date` datetime NOT NULL COMMENT '发布日期',
  `status` int(11) NOT NULL COMMENT '状态：0、前台提交 1、已发布 ',
  `clicks` int(11) NOT NULL COMMENT '点击数',
  `disabled` tinyint(1) NOT NULL COMMENT '已禁用',
  PRIMARY KEY  (`id`),
  KEY `path` (`path`),
  KEY `disabled` (`disabled`),
  KEY `publish_date` (`publish_date`),
  KEY `create_date` (`create_date`),
  KEY `site_id` (`site_id`),
  KEY `status` (`status`),
  KEY `item_id` (`item_id`),
  KEY `item_type` (`item_type`),
  KEY `user_id` (`user_id`),
  KEY `clicks` (`clicks`)
) COMMENT='页面数据';

-- ----------------------------
-- Table structure for cms_place_attribute
-- ----------------------------
DROP TABLE IF EXISTS `cms_place_attribute`;
CREATE TABLE `cms_place_attribute` (
  `place_id` bigint(20) NOT NULL COMMENT '位置ID',
  `data` longtext COMMENT '数据JSON',
  PRIMARY KEY  (`place_id`)
) COMMENT='推荐位数据扩展';

-- ----------------------------
-- Table structure for cms_tag
-- ----------------------------
DROP TABLE IF EXISTS `cms_tag`;
CREATE TABLE `cms_tag` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `type_id` int(11) default NULL COMMENT '分类ID',
  `search_count` int(11) NOT NULL COMMENT '搜索次数',
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) COMMENT='标签';

-- ----------------------------
-- Table structure for cms_tag_type
-- ----------------------------
DROP TABLE IF EXISTS `cms_tag_type`;
CREATE TABLE `cms_tag_type` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `count` int(11) NOT NULL COMMENT '标签数',
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) COMMENT='标签类型';

-- ----------------------------
-- Table structure for cms_word
-- ----------------------------
DROP TABLE IF EXISTS `cms_word`;
CREATE TABLE `cms_word` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `search_count` int(11) NOT NULL COMMENT '搜索次数',
  `hidden` tinyint(1) NOT NULL COMMENT '隐藏',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`,`site_id`),
  KEY `hidden` (`hidden`),
  KEY `create_date` (`create_date`),
  KEY `search_count` (`search_count`)
) COMMENT='搜索词';

-- ----------------------------
-- Table structure for log_login
-- ----------------------------
DROP TABLE IF EXISTS `log_login`;
CREATE TABLE `log_login` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '用户名',
  `user_id` bigint(20) default NULL COMMENT '用户ID',
  `ip` varchar(64) NOT NULL COMMENT 'IP',
  `channel` varchar(50) NOT NULL COMMENT '登录渠道',
  `result` tinyint(1) NOT NULL COMMENT '结果',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `error_password` varchar(100) default NULL COMMENT '错误密码',
  PRIMARY KEY  (`id`),
  KEY `result` (`result`),
  KEY `user_id` (`user_id`),
  KEY `create_date` (`create_date`),
  KEY `ip` (`ip`),
  KEY `site_id` (`site_id`),
  KEY `channel` (`channel`)
) COMMENT='登录日志';

-- ----------------------------
-- Table structure for log_operate
-- ----------------------------
DROP TABLE IF EXISTS `log_operate`;
CREATE TABLE `log_operate` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `user_id` bigint(20) default NULL COMMENT '用户ID',
  `channel` varchar(50) NOT NULL COMMENT '操作渠道',
  `operate` varchar(40) NOT NULL COMMENT '操作',
  `ip` varchar(64) default NULL COMMENT 'IP',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `content` text NOT NULL COMMENT '内容',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `operate` (`operate`),
  KEY `create_date` (`create_date`),
  KEY `ip` (`ip`),
  KEY `site_id` (`site_id`),
  KEY `channel` (`channel`)
) COMMENT='操作日志';

-- ----------------------------
-- Table structure for log_task
-- ----------------------------
DROP TABLE IF EXISTS `log_task`;
CREATE TABLE `log_task` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `task_id` int(11) NOT NULL COMMENT '任务',
  `begintime` datetime NOT NULL COMMENT '开始时间',
  `endtime` datetime default NULL COMMENT '结束时间',
  `success` tinyint(1) NOT NULL COMMENT '执行成功',
  `result` longtext COMMENT '执行结果',
  PRIMARY KEY  (`id`),
  KEY `task_id` (`task_id`),
  KEY `success` (`success`),
  KEY `site_id` (`site_id`),
  KEY `begintime` (`begintime`)
) COMMENT='任务计划日志';

-- ----------------------------
-- Table structure for log_upload
-- ----------------------------
DROP TABLE IF EXISTS `log_upload`;
CREATE TABLE `log_upload` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `channel` varchar(50) NOT NULL COMMENT '操作渠道',
  `original_name` varchar(255) DEFAULT NULL COMMENT '原文件名',
  `file_type` varchar(20) NOT NULL COMMENT '文件类型',
  `file_size` bigint(20) NOT NULL COMMENT '文件大小',
  `ip` varchar(64) default NULL COMMENT 'IP',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `file_path` varchar(500) NOT NULL COMMENT '文件路径',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `create_date` (`create_date`),
  KEY `ip` (`ip`),
  KEY `site_id` (`site_id`),
  KEY `channel` (`channel`),
  KEY `file_type` (`file_type`),
  KEY `file_size` (`file_size`)
) COMMENT='上传日志';

-- ----------------------------
-- Table structure for sys_app
-- ----------------------------
DROP TABLE IF EXISTS `sys_app`;
CREATE TABLE `sys_app` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `channel` varchar(50) NOT NULL COMMENT '渠道',
  `app_key` varchar(50) NOT NULL COMMENT 'APP key',
  `app_secret` varchar(50) NOT NULL COMMENT 'APP secret',
  `authorized_apis`  text NULL COMMENT '授权API',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `key` (`app_key`),
  KEY `site_id` (`site_id`)
) COMMENT='应用';

-- ----------------------------
-- Table structure for sys_app_client
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_client`;
CREATE TABLE `sys_app_client` (
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `channel` varchar(20) NOT NULL COMMENT '渠道',
  `uuid` varchar(50) NOT NULL COMMENT '唯一标识',
  `user_id` bigint(20) default NULL COMMENT '绑定用户',
  `client_version` varchar(50) default NULL COMMENT '版本',
  `last_login_date` datetime default NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(64) default NULL COMMENT '上次登录IP',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `disabled` tinyint(1) NOT NULL COMMENT '是否禁用',
  PRIMARY KEY  (`site_id`,`channel`,`uuid`),
  KEY `user_id` (`user_id`,`disabled`,`create_date`)
) COMMENT='应用客户端';

-- ----------------------------
-- Table structure for sys_app_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_token`;
CREATE TABLE `sys_app_token` (
  `auth_token` varchar(40) NOT NULL COMMENT '授权验证',
  `app_id` int(11) NOT NULL COMMENT '应用ID',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY  (`auth_token`),
  KEY `app_id` (`app_id`),
  KEY `create_date` (`create_date`)
) COMMENT='应用授权';

-- ----------------------------
-- Table structure for sys_cluster
-- ----------------------------
DROP TABLE IF EXISTS `sys_cluster`;
CREATE TABLE `sys_cluster` (
  `uuid` varchar(40) NOT NULL COMMENT 'uuid',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `heartbeat_date` datetime NOT NULL COMMENT '心跳时间',
  `master` tinyint(1) NOT NULL COMMENT '是否管理',
  `cms_version` varchar(20) default NULL,
  PRIMARY KEY  (`uuid`),
  KEY `create_date` (`create_date`)
) COMMENT='服务器集群';

-- ----------------------------
-- Table structure for sys_config_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_config_data`;
CREATE TABLE `sys_config_data` (
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `code` varchar(50) NOT NULL COMMENT '配置项编码',
  `data` longtext NOT NULL COMMENT '值',
  PRIMARY KEY  (`site_id`,`code`)
) COMMENT='站点配置';

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `parent_id` int(11) default NULL COMMENT '父部门ID',
  `description` varchar(300) default NULL COMMENT '描述',
  `user_id` bigint(20) default NULL COMMENT '负责人',
  `max_sort` INT NOT NULL DEFAULT 1000 COMMENT  '最大内容置顶级别',
  `owns_all_category` tinyint(1) NOT NULL COMMENT '拥有全部分类权限',
  `owns_all_page` tinyint(1) NOT NULL COMMENT '拥有全部页面权限',
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) AUTO_INCREMENT=3 COMMENT='部门';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '1', '技术部', null, '', '1', '1000', '1', '1');
INSERT INTO `sys_dept` VALUES ('2', '2', '技术部', null, '', '3', '1000', '1', '1');

-- ----------------------------
-- Table structure for sys_dept_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_category`;
CREATE TABLE `sys_dept_category` (
  `dept_id` int(11) NOT NULL COMMENT '部门ID',
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  PRIMARY KEY  (`dept_id`,`category_id`)
) COMMENT='部门分类';

-- ----------------------------
-- Table structure for sys_dept_page
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_page`;
CREATE TABLE `sys_dept_page` (
  `dept_id` int(11) NOT NULL COMMENT '部门ID',
  `page` varchar(100) NOT NULL COMMENT '页面',
  PRIMARY KEY  (`dept_id`,`page`)
) COMMENT='部门页面';

-- ----------------------------
-- Table structure for sys_domain
-- ----------------------------
DROP TABLE IF EXISTS `sys_domain`;
CREATE TABLE `sys_domain` (
  `name` varchar(100) NOT NULL COMMENT '域名',
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `wild` tinyint(1) NOT NULL COMMENT '通配域名',
  `path` varchar(100) default NULL COMMENT '路径',
  PRIMARY KEY  (`name`),
  KEY `site_id` (`site_id`)
) COMMENT='域名';

-- ----------------------------
-- Records of sys_domain
-- ----------------------------
INSERT INTO `sys_domain` VALUES ('dev.publiccms.com', '1', '1', '');
INSERT INTO `sys_domain` VALUES ('member.dev.publiccms.com', '1', '0', '/member/');
INSERT INTO `sys_domain` VALUES ('search.dev.publiccms.com', '1', '0', '/search/');

-- ----------------------------
-- Table structure for sys_email_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_email_token`;
CREATE TABLE `sys_email_token` (
  `auth_token` varchar(40) NOT NULL COMMENT '验证码',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `email` varchar(100) NOT NULL COMMENT '邮件地址',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY  (`auth_token`),
  KEY `create_date` (`create_date`),
  KEY `user_id` (`user_id`)
) COMMENT='邮件地址验证日志';

-- ----------------------------
-- Table structure for sys_extend
-- ----------------------------
DROP TABLE IF EXISTS `sys_extend`;
CREATE TABLE `sys_extend` (
  `id` int(11) NOT NULL auto_increment,
  `item_type` varchar(20) NOT NULL COMMENT '扩展类型',
  `item_id` int(11) NOT NULL COMMENT '扩展项目ID',
  PRIMARY KEY  (`id`)
) COMMENT='扩展';

-- ----------------------------
-- Table structure for sys_extend_field
-- ----------------------------
DROP TABLE IF EXISTS `sys_extend_field`;
CREATE TABLE `sys_extend_field` (
  `extend_id` int(11) NOT NULL COMMENT '扩展ID',
  `code` varchar(20) NOT NULL COMMENT '编码',
  `required` tinyint(1) NOT NULL COMMENT '是否必填',
  `maxlength` int(11) default NULL,
  `name` varchar(20) NOT NULL COMMENT '名称',
  `description` varchar(100) default NULL COMMENT '解释',
  `input_type` varchar(20) NOT NULL COMMENT '表单类型',
  `default_value` varchar(50) default NULL COMMENT '默认值',
  `dictionary_id` bigint(20) default NULL COMMENT '数据字典ID',
  `sort` int(11) NOT NULL default '0' COMMENT '顺序',
  PRIMARY KEY  (`extend_id`,`code`),
  KEY `sort` (`sort`)
) COMMENT='扩展字段';

-- ----------------------------
-- Table structure for sys_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_module`;
CREATE TABLE `sys_module` (
  `id` varchar(30) NOT NULL,
  `url` varchar(255) default NULL COMMENT '链接地址',
  `authorized_url` text COMMENT '授权地址',
  `attached` varchar(300) default NULL COMMENT '标题附加',
  `parent_id` varchar(30) default NULL COMMENT '父模块',
  `menu` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否菜单',
  `sort` int(11) NOT NULL COMMENT '排序',
  PRIMARY KEY  (`id`),
  KEY `parent_id` (`parent_id`,`menu`),
  KEY `sort` (`sort`)
) COMMENT='模块';

-- ----------------------------
-- Records of sys_module
-- ----------------------------
INSERT INTO `sys_module` VALUES ('app_add', 'sysApp/add', 'sysApp/save', NULL, 'app_list', 0, 0);
INSERT INTO `sys_module` VALUES ('app_client_disable', NULL, 'sysAppClient/disable', NULL, 'app_client_list', 0, 0);
INSERT INTO `sys_module` VALUES ('app_client_enable', NULL, 'sysAppClient/enable', NULL, 'app_client_list', 0, 0);
INSERT INTO `sys_module` VALUES ('app_client_list', 'sysAppClient/list', NULL, '<i class=\"icon-coffee icon-large\"></i>', 'user_menu', 1, 4);
INSERT INTO `sys_module` VALUES ('app_delete', NULL, 'sysApp/delete', NULL, 'app_list', 0, 0);
INSERT INTO `sys_module` VALUES ('app_list', 'sysApp/list', NULL, '<i class=\"icon-linux icon-large\"></i>', 'system_menu', 1, 5);
INSERT INTO `sys_module` VALUES ('category', NULL, NULL, '<i class=\"icon-folder-open icon-large\"></i>', NULL, 1, 5);
INSERT INTO `sys_module` VALUES ('category_add', 'cmsCategory/add', 'cmsCategory/addMore,cmsTemplate/lookup,cmsCategory/categoryPath,cmsCategory/contentPath,file/doUpload,cmsCategory/save', '', 'category_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('category_delete', NULL, 'cmsCategory/delete', '', 'category_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('category_extend', NULL, NULL, '<i class=\"icon-road icon-large\"></i>', 'category', 1, 2);
INSERT INTO `sys_module` VALUES ('category_menu', 'cmsCategory/list', NULL, '<i class=\"icon-folder-open icon-large\"></i>', 'category', 1, 1);
INSERT INTO `sys_module` VALUES ('category_move', 'cmsCategory/moveParameters', 'cmsCategory/move,cmsCategory/lookup', '', 'category_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('category_publish', 'cmsCategory/publishParameters', 'cmsCategory/publish', '', 'category_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('category_push', 'cmsCategory/push_page', 'cmsPlace/push,cmsPlace/add,cmsPlace/save', '', 'category_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('category_type_add', 'cmsCategoryType/add', 'cmsCategoryType/save', NULL, 'category_type_list', 0, 0);
INSERT INTO `sys_module` VALUES ('category_type_change', 'cmsCategory/changeTypeParameters', 'cmsCategory/changeType', '', 'category_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('category_type_delete', NULL, 'cmsCategoryType/delete', NULL, 'category_type_list', 0, 0);
INSERT INTO `sys_module` VALUES ('category_type_list', 'cmsCategoryType/list', NULL, '<i class=\"icon-road icon-large\"></i>', 'category_extend', 1, 1);
INSERT INTO `sys_module` VALUES ('clearcache', NULL, 'clearCache', '', NULL, 0, 10);
INSERT INTO `sys_module` VALUES ('config_add', 'sysConfig/add', 'sysConfig/save', NULL, 'config_list', 0, 0);
INSERT INTO `sys_module` VALUES ('config_data_delete', NULL, 'sysConfigData/delete', NULL, 'config_data_list', 0, 0);
INSERT INTO `sys_module` VALUES ('config_data_edit', 'sysConfigData/edit', 'sysConfigData/save', NULL, 'config_data_list', 0, 0);
INSERT INTO `sys_module` VALUES ('config_data_list', 'sysConfigData/list', NULL, '<i class=\"icon-cog icon-large\"></i>', 'system_menu', 1, 1);
INSERT INTO `sys_module` VALUES ('config_delete', NULL, 'sysConfig/delete', NULL, 'config_list', 0, 0);
INSERT INTO `sys_module` VALUES ('config_list', 'sysConfig/list', NULL, '<i class=\"icon-cogs icon-large\"></i>', 'config_menu', 1, 2);
INSERT INTO `sys_module` VALUES ('config_list_data_dictionary', 'cmsDictionary/lookup', NULL, NULL, 'config_list', 0, 0);
INSERT INTO `sys_module` VALUES ('config_menu', NULL, NULL, '<i class=\"icon-gear icon-large\"></i>', 'develop', 1, 2);
INSERT INTO `sys_module` VALUES ('content', NULL, NULL, '<i class=\"icon-book icon-large\"></i>', NULL, 1, 2);
INSERT INTO `sys_module` VALUES ('content_add', 'cmsContent/add', 'cmsContent/addMore,cmsContent/save,ueditor', '', 'content_menu', 1, 0);
INSERT INTO `sys_module` VALUES ('content_check', NULL, 'cmsContent/check', '', 'content_menu', 1, 0);
INSERT INTO `sys_module` VALUES ('content_delete', NULL, 'cmsContent/delete', '', 'content_menu', 1, 0);
INSERT INTO `sys_module` VALUES ('content_extend', NULL, NULL, '<i class=\"icon-road icon-large\"></i>', 'content', 1, 1);
INSERT INTO `sys_module` VALUES ('content_menu', 'cmsContent/list', 'sysUser/lookup', '<i class=\"icon-book icon-large\"></i>', 'content', 1, 0);
INSERT INTO `sys_module` VALUES ('content_move', 'cmsContent/moveParameters', 'cmsContent/move', '', 'content_menu', 1, 0);
INSERT INTO `sys_module` VALUES ('content_publish', NULL, 'cmsContent/publish', '', 'content_menu', 1, 0);
INSERT INTO `sys_module` VALUES ('content_push', 'cmsContent/push', 'cmsContent/push_content,cmsContent/push_content_list,cmsContent/push_to_content,cmsContent/push_page,cmsContent/push_page_list,cmsPlace/add,cmsPlace/save,cmsContent/related,cmsContent/unrelated,cmsPlace/delete', '', 'content_menu', 1, 0);
INSERT INTO `sys_module` VALUES ('content_recycle_delete', NULL, 'cmsContent/realDelete', NULL, 'content_recycle_list', 0, 0);
INSERT INTO `sys_module` VALUES ('content_recycle_list', 'cmsRecycleContent/list', 'sysUser/lookup', '<i class=\"icon-trash icon-large\"></i>', 'content_extend', 1, 3);
INSERT INTO `sys_module` VALUES ('content_recycle_recycle', NULL, 'cmsContent/recycle', NULL, 'content_recycle_list', 0, 0);
INSERT INTO `sys_module` VALUES ('content_refresh', NULL, 'cmsContent/refresh', '', 'content_menu', 1, 0);
INSERT INTO `sys_module` VALUES ('content_select_category', 'cmsCategory/lookup', NULL, NULL, 'content_add', 0, 0);
INSERT INTO `sys_module` VALUES ('content_select_category_type', 'cmsCategoryType/lookup', NULL, NULL, 'content_add', 0, 0);
INSERT INTO `sys_module` VALUES ('content_select_content', 'cmsContent/lookup', 'cmsContent/lookup_list', NULL, 'content_add', 0, 0);
INSERT INTO `sys_module` VALUES ('content_select_tag_type', 'cmsTagType/lookup', NULL, NULL, 'content_add', 0, 0);
INSERT INTO `sys_module` VALUES ('content_select_template', 'cmsTemplate/lookup', NULL, NULL, 'content_add', 0, 0);
INSERT INTO `sys_module` VALUES ('content_select_user', 'sysUser/lookup', NULL, NULL, 'content_add', 0, 0);
INSERT INTO `sys_module` VALUES ('content_sort', 'cmsContent/sortParameters', 'cmsContent/sort', '', 'content_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('content_uncheck', NULL, 'cmsContent/uncheck', '', 'content_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('content_view', 'cmsContent/view', NULL, '', 'content_menu', 0, 0);
INSERT INTO `sys_module` VALUES ('dept_add', 'sysDept/add', 'sysDept/lookup,sysUser/lookup,sysDept/save', NULL, 'dept_list', 0, 0);
INSERT INTO `sys_module` VALUES ('dept_delete', NULL, 'sysDept/delete', NULL, 'dept_list', 0, 0);
INSERT INTO `sys_module` VALUES ('dept_list', 'sysDept/list', 'sysDept/lookup,sysUser/lookup', '<i class=\"icon-group icon-large\"></i>', 'user_menu', 1, 2);
INSERT INTO `sys_module` VALUES ('dept_user_list', 'sysDept/userList', 'sysDept/addUser,sysDept/saveUser,sysDept/enableUser,sysDept/disableUser', NULL, 'dept_list', 0, 0);
INSERT INTO `sys_module` VALUES ('develop', NULL, NULL, '<i class=\"icon-folder-close-alt icon-large\"></i>', NULL, 1, 7);
INSERT INTO `sys_module` VALUES ('dictionary_add', 'cmsDictionary/add', 'cmsDictionary/save', NULL, 'dictionary_list', 0, 0);
INSERT INTO `sys_module` VALUES ('dictionary_delete', NULL, 'cmsDictionary/delete', NULL, 'dictionary_list', 0, 0);
INSERT INTO `sys_module` VALUES ('dictionary_list', 'cmsDictionary/list', NULL, '<i class=\"icon-book icon-large\"></i>', 'system_menu', 1, 4);
INSERT INTO `sys_module` VALUES ('domain_config', 'sysDomain/config', 'sysDomain/saveConfig,cmsTemplate/directoryLookup,cmsTemplate/lookup', NULL, 'domain_list', 0, 0);
INSERT INTO `sys_module` VALUES ('domain_list', 'sysDomain/domainList', NULL, '<i class=\"icon-qrcode icon-large\"></i>', 'system_menu', 1, 3);
INSERT INTO `sys_module` VALUES ('file_menu', NULL, NULL, '<i class=\"icon-folder-close-alt icon-large\"></i>', 'develop', 1, 1);
INSERT INTO `sys_module` VALUES ('log_login', 'log/login', 'sysUser/lookup', '<i class=\"icon-signin icon-large\"></i>', 'log_menu', 1, 3);
INSERT INTO `sys_module` VALUES ('log_login_delete', NULL, 'logLogin/delete', NULL, 'log_login', 0, 0);
INSERT INTO `sys_module` VALUES ('log_menu', NULL, NULL, '<i class=\"icon-list-alt icon-large\"></i>', 'maintenance', 1, 3);
INSERT INTO `sys_module` VALUES ('log_operate', 'log/operate', 'sysUser/lookup', '<i class=\"icon-list-alt icon-large\"></i>', 'log_menu', 1, 2);
INSERT INTO `sys_module` VALUES ('log_operate_delete', NULL, 'logOperate/delete', NULL, 'log_operate', 0, 0);
INSERT INTO `sys_module` VALUES ('log_operate_view', 'log/operateView', NULL, NULL, 'log_operate', 0, 0);
INSERT INTO `sys_module` VALUES ('log_task', 'log/task', 'sysUser/lookup', '<i class=\"icon-time icon-large\"></i>', 'log_menu', 1, 4);
INSERT INTO `sys_module` VALUES ('log_task_delete', NULL, 'logTask/delete', NULL, 'log_task', 0, 0);
INSERT INTO `sys_module` VALUES ('log_task_view', 'log/taskView', NULL, NULL, 'log_task', 0, 0);
INSERT INTO `sys_module` VALUES ('log_upload', 'log/upload', 'sysUser/lookup', '<i class=\"icon-list-alt icon-large\"></i>', 'log_menu', 1, 1);
INSERT INTO `sys_module` VALUES ('maintenance', NULL, NULL, '<i class=\"icon-cogs icon-large\"></i>', NULL, 1, 6);
INSERT INTO `sys_module` VALUES ('model_add', 'cmsModel/add', 'cmsModel/save,cmsTemplate/lookup', NULL, 'model_list', 0, 0);
INSERT INTO `sys_module` VALUES ('model_delete', NULL, 'cmsModel/delete', NULL, 'model_list', 0, 0);
INSERT INTO `sys_module` VALUES ('model_list', 'cmsModel/list', NULL, '<i class=\"icon-th-large icon-large\"></i>', 'config_menu', 1, 1);
INSERT INTO `sys_module` VALUES ('myself', NULL, NULL, '<i class=\"icon-user icon-large\"></i>', NULL, 1, 1);
INSERT INTO `sys_module` VALUES ('myself_content', 'myself/contentList', NULL, '<i class=\"icon-book icon-large\"></i>', 'myself_menu', 1, 2);
INSERT INTO `sys_module` VALUES ('myself_content_add', 'cmsContent/add', 'cmsContent/addMore,file/doUpload,cmsContent/lookup,cmsContent/lookup_list,cmsContent/save,ueditor,ckeditor/upload', NULL, 'myself_content', 0, 0);
INSERT INTO `sys_module` VALUES ('myself_content_delete', NULL, 'cmsContent/delete', NULL, 'myself_content', 0, 0);
INSERT INTO `sys_module` VALUES ('myself_content_publish', NULL, 'cmsContent/publish', NULL, 'myself_content', 0, 0);
INSERT INTO `sys_module` VALUES ('myself_content_push', 'cmsContent/push', 'cmsContent/push_content,cmsContent/push_content_list,cmsContent/push_to_content,cmsContent/push_page,cmsContent/push_page_list,cmsContent/push_to_place,cmsContent/related', NULL, 'myself_content', 0, 0);
INSERT INTO `sys_module` VALUES ('myself_content_refresh', NULL, 'cmsContent/refresh', NULL, 'myself_content', 0, 0);
INSERT INTO `sys_module` VALUES ('myself_log_login', 'myself/logLogin', NULL, '<i class=\"icon-signin icon-large\"></i>', 'myself_menu', 1, 4);
INSERT INTO `sys_module` VALUES ('myself_log_operate', 'myself/logOperate', NULL, '<i class=\"icon-list-alt icon-large\"></i>', 'myself_menu', 1, 3);
INSERT INTO `sys_module` VALUES ('myself_menu', NULL, NULL, '<i class=\"icon-user icon-large\"></i>', 'myself', 1, 0);
INSERT INTO `sys_module` VALUES ('myself_password', 'myself/password', 'changePassword', '<i class=\"icon-key icon-large\"></i>', 'myself_menu', 1, 1);
INSERT INTO `sys_module` VALUES ('myself_token', 'myself/userTokenList', NULL, '<i class=\"icon-unlock-alt icon-large\"></i>', 'myself_menu', 1, 5);
INSERT INTO `sys_module` VALUES ('page', NULL, NULL, '<i class=\"icon-globe icon-large\"></i>', NULL, 1, 3);
INSERT INTO `sys_module` VALUES ('page_list', 'cmsPage/list', 'cmsPage/metadata,sysUser/lookup,cmsContent/lookup,cmsContent/lookup_list,cmsCategory/lookup', '<i class=\"icon-globe icon-large\"></i>', 'page_menu', 1, 1);
INSERT INTO `sys_module` VALUES ('page_menu', NULL, NULL, '<i class=\"icon-globe icon-large\"></i>', 'page', 1, 0);
INSERT INTO `sys_module` VALUES ('page_metadata', 'cmsPage/metadata', 'cmsPage/save', NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('page_publish', NULL, 'cmsTemplate/publish', NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('page_save', NULL, 'cmsPage/save,file/doUpload,cmsPage/clearCache', NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('page_select_category', 'cmsCategory/lookup', NULL, NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('page_select_category_type', 'cmsCategoryType/lookup', NULL, NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('page_select_content', 'cmsContent/lookup', 'cmsContent/lookup_list', NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('page_select_tag_type', 'cmsTagType/lookup', NULL, NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('page_select_template', 'cmsTemplate/lookup', NULL, NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('page_select_user', 'sysUser/lookup', NULL, NULL, 'page_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_add', 'cmsPlace/add', 'cmsContent/lookup,cmsPlace/lookup,cmsPlace/lookup_content_list,file/doUpload,cmsPlace/save', NULL, 'place_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_check', NULL, 'cmsPlace/check', NULL, 'place_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_clear', NULL, 'cmsPlace/clear', NULL, 'place_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_data_list', 'cmsPlace/dataList', NULL, NULL, 'place_list', 0, 1);
INSERT INTO `sys_module` VALUES ('place_delete', NULL, 'cmsPlace/delete', NULL, 'place_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_list', 'cmsPlace/list', 'sysUser/lookup,cmsPlace/data_list', '<i class=\"icon-list-alt icon-large\"></i>', 'page_menu', 1, 1);
INSERT INTO `sys_module` VALUES ('place_publish', 'cmsPlace/publish_place', 'cmsTemplate/publishPlace', NULL, 'place_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_refresh', NULL, 'cmsPlace/refresh', NULL, 'place_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_template_content', 'placeTemplate/content', 'cmsTemplate/help,cmsTemplate/chipLookup,cmsWebFile/lookup,cmsWebFile/contentForm,placeTemplate/form', NULL, 'place_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_template_data_dictionary', 'cmsDictionary/lookup', NULL, NULL, 'place_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_template_fragment', 'cmsTemplate/ftlLookup', NULL, NULL, 'place_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_template_help', 'cmsTemplate/help', NULL, NULL, 'place_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_template_list', 'placeTemplate/list', NULL, '<i class=\"icon-list-alt icon-large\"></i>', 'file_menu', 1, 2);
INSERT INTO `sys_module` VALUES ('place_template_metadata', 'placeTemplate/metadata', 'cmsTemplate/savePlaceMetaData', NULL, 'place_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_template_place', 'placeTemplate/lookup', NULL, NULL, 'place_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_template_webfile', 'cmsWebFile/lookup', NULL, NULL, 'place_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('place_view', 'cmsPlace/view', NULL, NULL, 'place_list', 0, 0);
INSERT INTO `sys_module` VALUES ('report_user', 'report/user', NULL, '<i class=\"icon-male icon-large\"></i>', 'user_menu', 1, 5);
INSERT INTO `sys_module` VALUES ('role_add', 'sysRole/add', 'sysRole/save', NULL, 'role_list', 0, 0);
INSERT INTO `sys_module` VALUES ('role_delete', NULL, 'sysRole/delete', NULL, 'role_list', 0, 0);
INSERT INTO `sys_module` VALUES ('role_list', 'sysRole/list', NULL, '<i class=\"icon-user-md icon-large\"></i>', 'user_menu', 1, 3);
INSERT INTO `sys_module` VALUES ('system_menu', NULL, NULL, '<i class=\"icon-cogs icon-large\"></i>', 'maintenance', 1, 2);
INSERT INTO `sys_module` VALUES ('tag_add', 'cmsTag/add', 'cmsTagType/lookup,cmsTag/save', NULL, 'tag_list', 0, 0);
INSERT INTO `sys_module` VALUES ('tag_delete', NULL, 'cmsTag/delete', NULL, 'tag_list', 0, 0);
INSERT INTO `sys_module` VALUES ('tag_list', 'cmsTag/list', 'cmsTagType/lookup', '<i class=\"icon-tag icon-large\"></i>', 'content_extend', 1, 1);
INSERT INTO `sys_module` VALUES ('tag_type_delete', NULL, 'cmsTagType/delete', NULL, 'tag_type_list', 0, 0);
INSERT INTO `sys_module` VALUES ('tag_type_list', 'cmsTagType/list', NULL, '<i class=\"icon-tags icon-large\"></i>', 'category_extend', 1, 2);
INSERT INTO `sys_module` VALUES ('tag_type_save', 'cmsTagType/add', 'cmsTagType/save', NULL, 'tag_type_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_add', 'sysTask/add', 'sysTask/save,sysTask/example,taskTemplate/lookup', NULL, 'task_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_delete', NULL, 'sysTask/delete', NULL, 'task_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_list', 'sysTask/list', NULL, '<i class=\"icon-time icon-large\"></i>', 'system_menu', 1, 2);
INSERT INTO `sys_module` VALUES ('task_pause', NULL, 'sysTask/pause', NULL, 'task_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_recreate', NULL, 'sysTask/recreate', NULL, 'task_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_resume', NULL, 'sysTask/resume', NULL, 'task_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_runonce', NULL, 'sysTask/runOnce', NULL, 'task_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_template_content', 'taskTemplate/content', 'taskTemplate/save,taskTemplate/chipLookup,cmsTemplate/help,placeTemplate/form,cmsWebFile/contentForm', NULL, 'task_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_template_delete', NULL, 'taskTemplate/delete', NULL, 'task_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_template_fragment', 'taskTemplate/chipLookup', NULL, NULL, 'task_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_template_help', 'cmsTemplate/help', NULL, NULL, 'task_template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('task_template_list', 'taskTemplate/list', NULL, '<i class=\"icon-time icon-large\"></i>', 'file_menu', 1, 3);
INSERT INTO `sys_module` VALUES ('template_content', 'cmsTemplate/content', 'cmsTemplate/save,cmsTemplate/chipLookup,cmsWebFile/lookup,placeTemplate/form,cmsWebFile/contentForm,cmsTemplate/demo,cmsTemplate/help,cmsTemplate/upload,cmsTemplate/doUpload', NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_content-type', 'cmsTemplate/contentTypeLookup', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_content_form', 'cmsTemplate/contentForm', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_data_dictionary', 'cmsDictionary/lookup', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_delete', NULL, 'cmsTemplate/delete', NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_demo', 'cmsTemplate/demo', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_fragment', 'cmsTemplate/ftlLookup', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_help', 'cmsTemplate/help', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_list', 'cmsTemplate/list', 'cmsTemplate/directory', '<i class=\"icon-code icon-large\"></i>', 'file_menu', 1, 1);
INSERT INTO `sys_module` VALUES ('template_metadata', 'cmsTemplate/metadata', 'cmsTemplate/saveMetadata', NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_place', 'placeTemplate/lookup', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_place_form', 'placeTemplate/form', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_upload', 'cmsTemplate/upload', 'cmsTemplate/doUpload', NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('template_website_file', 'cmsWebFile/lookup', NULL, NULL, 'template_list', 0, 0);
INSERT INTO `sys_module` VALUES ('user_add', 'sysUser/add', 'sysDept/lookup,sysUser/save', NULL, 'user_list', 0, 0);
INSERT INTO `sys_module` VALUES ('user_disable', NULL, 'sysUser/disable', NULL, 'user_list', 0, 0);
INSERT INTO `sys_module` VALUES ('user_enable', NULL, 'sysUser/enable', NULL, 'user_list', 0, 0);
INSERT INTO `sys_module` VALUES ('user_list', 'sysUser/list', NULL, '<i class=\"icon-user icon-large\"></i>', 'user_menu', 1, 1);
INSERT INTO `sys_module` VALUES ('user_menu', NULL, NULL, '<i class=\"icon-user icon-large\"></i>', 'maintenance', 1, 1);
INSERT INTO `sys_module` VALUES ('webfile_content', 'cmsWebFile/content', 'cmsWebFile/save', NULL, 'webfile_list', 0, 0);
INSERT INTO `sys_module` VALUES ('webfile_directory', 'cmsWebFile/directory', 'cmsWebFile/createDirectory', NULL, 'webfile_list', 0, 0);
INSERT INTO `sys_module` VALUES ('webfile_list', 'cmsWebFile/list', NULL, '<i class=\"icon-globe icon-large\"></i>', 'file_menu', 1, 4);
INSERT INTO `sys_module` VALUES ('webfile_unzip', NULL, 'cmsWebFile/unzip,cmsWebFile/unzipHere', NULL, 'webfile_list', 0, 0);
INSERT INTO `sys_module` VALUES ('webfile_upload', 'cmsWebFile/upload', 'cmsWebFile/doUpload', NULL, 'webfile_list', 0, 0);
INSERT INTO `sys_module` VALUES ('webfile_zip', NULL, 'cmsWebFile/zip', NULL, 'webfile_list', 0, 0);
INSERT INTO `sys_module` VALUES ('word_list', 'cmsWord/list', NULL, '<i class=\"icon-search icon-large\"></i>', 'content_extend', 1, 2);

-- ----------------------------
-- Table structure for sys_module_lang
-- ----------------------------
DROP TABLE IF EXISTS `sys_module_lang`;
CREATE TABLE `sys_module_lang` (
  `module_id` varchar(30) NOT NULL COMMENT '模块ID',
  `lang` varchar(20) NOT NULL COMMENT '语言',
  `value` varchar(100) DEFAULT NULL COMMENT '值',
  PRIMARY KEY (`module_id`,`lang`)
) COMMENT='模块语言';

-- ----------------------------
-- Records of sys_module_lang
-- ----------------------------
INSERT INTO `sys_module_lang` VALUES ('app_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('app_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('app_client_disable', '', '禁用');
INSERT INTO `sys_module_lang` VALUES ('app_client_disable', 'en', 'Disable');
INSERT INTO `sys_module_lang` VALUES ('app_client_enable', '', '启用');
INSERT INTO `sys_module_lang` VALUES ('app_client_enable', 'en', 'Enable');
INSERT INTO `sys_module_lang` VALUES ('app_client_list', '', '客户端管理');
INSERT INTO `sys_module_lang` VALUES ('app_client_list', 'en', 'Application client management');
INSERT INTO `sys_module_lang` VALUES ('app_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('app_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('app_list', '', '应用授权');
INSERT INTO `sys_module_lang` VALUES ('app_list', 'en', 'Application Authorization');
INSERT INTO `sys_module_lang` VALUES ('category', '', '分类');
INSERT INTO `sys_module_lang` VALUES ('category', 'en', 'Category');
INSERT INTO `sys_module_lang` VALUES ('category_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('category_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('category_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('category_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('category_extend', '', '分类扩展');
INSERT INTO `sys_module_lang` VALUES ('category_extend', 'en', 'Category extension');
INSERT INTO `sys_module_lang` VALUES ('category_menu', '', '分类管理');
INSERT INTO `sys_module_lang` VALUES ('category_menu', 'en', 'Category management');
INSERT INTO `sys_module_lang` VALUES ('category_move', '', '移动');
INSERT INTO `sys_module_lang` VALUES ('category_move', 'en', 'Move');
INSERT INTO `sys_module_lang` VALUES ('category_publish', '', '生成');
INSERT INTO `sys_module_lang` VALUES ('category_publish', 'en', 'Publish');
INSERT INTO `sys_module_lang` VALUES ('category_push', '', '推荐');
INSERT INTO `sys_module_lang` VALUES ('category_push', 'en', 'Push');
INSERT INTO `sys_module_lang` VALUES ('category_type_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('category_type_add', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('category_type_change', '', '修改类型');
INSERT INTO `sys_module_lang` VALUES ('category_type_change', 'en', 'Change category type');
INSERT INTO `sys_module_lang` VALUES ('category_type_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('category_type_delete', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('category_type_list', '', '分类类型');
INSERT INTO `sys_module_lang` VALUES ('category_type_list', 'en', 'Category type');
INSERT INTO `sys_module_lang` VALUES ('clearcache', '', '刷新缓存');
INSERT INTO `sys_module_lang` VALUES ('clearcache', 'en', 'Clear cache');
INSERT INTO `sys_module_lang` VALUES ('config_add', '', '添加/修改');
INSERT INTO `sys_module_lang` VALUES ('config_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('config_data_delete', '', '清空配置');
INSERT INTO `sys_module_lang` VALUES ('config_data_delete', 'en', 'Clear config data');
INSERT INTO `sys_module_lang` VALUES ('config_data_edit', '', '修改');
INSERT INTO `sys_module_lang` VALUES ('config_data_edit', 'en', 'Edit');
INSERT INTO `sys_module_lang` VALUES ('config_data_list', '', '站点配置');
INSERT INTO `sys_module_lang` VALUES ('config_data_list', 'en', 'Site configuration');
INSERT INTO `sys_module_lang` VALUES ('config_delete', '', '删除配置');
INSERT INTO `sys_module_lang` VALUES ('config_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('config_list', '', '站点配置管理');
INSERT INTO `sys_module_lang` VALUES ('config_list', 'en', 'Site config management');
INSERT INTO `sys_module_lang` VALUES ('config_list_data_dictionary', '', '选择数据字典');
INSERT INTO `sys_module_lang` VALUES ('config_list_data_dictionary', 'en', 'Select data dictionary');
INSERT INTO `sys_module_lang` VALUES ('config_menu', '', '配置管理');
INSERT INTO `sys_module_lang` VALUES ('config_menu', 'en', 'Configuration management');
INSERT INTO `sys_module_lang` VALUES ('content', '', '内容');
INSERT INTO `sys_module_lang` VALUES ('content', 'en', 'Content');
INSERT INTO `sys_module_lang` VALUES ('content_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('content_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('content_check', '', '审核');
INSERT INTO `sys_module_lang` VALUES ('content_check', 'en', 'Check');
INSERT INTO `sys_module_lang` VALUES ('content_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('content_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('content_extend', '', '内容扩展');
INSERT INTO `sys_module_lang` VALUES ('content_extend', 'en', 'Content extension');
INSERT INTO `sys_module_lang` VALUES ('content_menu', '', '内容管理');
INSERT INTO `sys_module_lang` VALUES ('content_menu', 'en', 'Content management');
INSERT INTO `sys_module_lang` VALUES ('content_move', '', '移动');
INSERT INTO `sys_module_lang` VALUES ('content_move', 'en', 'Move');
INSERT INTO `sys_module_lang` VALUES ('content_publish', '', '生成');
INSERT INTO `sys_module_lang` VALUES ('content_publish', 'en', 'Publish');
INSERT INTO `sys_module_lang` VALUES ('content_push', '', '推荐');
INSERT INTO `sys_module_lang` VALUES ('content_push', 'en', 'Push');
INSERT INTO `sys_module_lang` VALUES ('content_recycle_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('content_recycle_delete', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('content_recycle_list', '', '内容回收站');
INSERT INTO `sys_module_lang` VALUES ('content_recycle_list', 'en', 'Content recycle');
INSERT INTO `sys_module_lang` VALUES ('content_recycle_recycle', '', '还原');
INSERT INTO `sys_module_lang` VALUES ('content_recycle_recycle', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('content_refresh', '', '刷新');
INSERT INTO `sys_module_lang` VALUES ('content_refresh', 'en', 'Refresh');
INSERT INTO `sys_module_lang` VALUES ('content_select_category', '', '选择分类');
INSERT INTO `sys_module_lang` VALUES ('content_select_category', 'en', 'Select category');
INSERT INTO `sys_module_lang` VALUES ('content_select_category_type', '', '选择分类类型');
INSERT INTO `sys_module_lang` VALUES ('content_select_category_type', 'en', 'Select category type');
INSERT INTO `sys_module_lang` VALUES ('content_select_content', '', '选择内容');
INSERT INTO `sys_module_lang` VALUES ('content_select_content', 'en', 'Select content');
INSERT INTO `sys_module_lang` VALUES ('content_select_tag_type', '', '选择标签类型');
INSERT INTO `sys_module_lang` VALUES ('content_select_tag_type', 'en', 'Select tag type');
INSERT INTO `sys_module_lang` VALUES ('content_select_template', '', '选择模板');
INSERT INTO `sys_module_lang` VALUES ('content_select_template', 'en', 'Select template');
INSERT INTO `sys_module_lang` VALUES ('content_select_user', '', '选择用户');
INSERT INTO `sys_module_lang` VALUES ('content_select_user', 'en', 'Select user');
INSERT INTO `sys_module_lang` VALUES ('content_sort', '', '置顶');
INSERT INTO `sys_module_lang` VALUES ('content_sort', 'en', 'Sort');
INSERT INTO `sys_module_lang` VALUES ('content_uncheck', '', '撤销审核');
INSERT INTO `sys_module_lang` VALUES ('content_uncheck', 'en', 'Uncheck');
INSERT INTO `sys_module_lang` VALUES ('content_view', '', '查看');
INSERT INTO `sys_module_lang` VALUES ('content_view', 'en', 'View');
INSERT INTO `sys_module_lang` VALUES ('dept_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('dept_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('dept_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('dept_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('dept_list', '', '部门管理');
INSERT INTO `sys_module_lang` VALUES ('dept_list', 'en', 'Department management');
INSERT INTO `sys_module_lang` VALUES ('dept_user_list', '', '人员管理');
INSERT INTO `sys_module_lang` VALUES ('dept_user_list', 'en', 'Department user management');
INSERT INTO `sys_module_lang` VALUES ('develop', '', '开发');
INSERT INTO `sys_module_lang` VALUES ('develop', 'en', 'Development');
INSERT INTO `sys_module_lang` VALUES ('dictionary_add', '', '添加/修改');
INSERT INTO `sys_module_lang` VALUES ('dictionary_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('dictionary_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('dictionary_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('dictionary_list', '', '数据字典');
INSERT INTO `sys_module_lang` VALUES ('dictionary_list', 'en', 'Dictionary management');
INSERT INTO `sys_module_lang` VALUES ('domain_config', '', '修改');
INSERT INTO `sys_module_lang` VALUES ('domain_config', 'en', 'Edit');
INSERT INTO `sys_module_lang` VALUES ('domain_list', '', '绑定域名');
INSERT INTO `sys_module_lang` VALUES ('domain_list', 'en', 'Domain management');
INSERT INTO `sys_module_lang` VALUES ('file_menu', '', '文件管理');
INSERT INTO `sys_module_lang` VALUES ('file_menu', 'en', 'File maintenance');
INSERT INTO `sys_module_lang` VALUES ('log_login', '', '登录日志');
INSERT INTO `sys_module_lang` VALUES ('log_login', 'en', 'Login log');
INSERT INTO `sys_module_lang` VALUES ('log_login_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('log_login_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('log_menu', '', '日志管理');
INSERT INTO `sys_module_lang` VALUES ('log_menu', 'en', 'Log management');
INSERT INTO `sys_module_lang` VALUES ('log_operate', '', '操作日志');
INSERT INTO `sys_module_lang` VALUES ('log_operate', 'en', 'Operate log');
INSERT INTO `sys_module_lang` VALUES ('log_operate_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('log_operate_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('log_operate_view', '', '查看');
INSERT INTO `sys_module_lang` VALUES ('log_operate_view', 'en', 'View');
INSERT INTO `sys_module_lang` VALUES ('log_task', '', '任务计划日志');
INSERT INTO `sys_module_lang` VALUES ('log_task', 'en', 'Task log');
INSERT INTO `sys_module_lang` VALUES ('log_task_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('log_task_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('log_task_view', '', '查看');
INSERT INTO `sys_module_lang` VALUES ('log_task_view', 'en', 'View');
INSERT INTO `sys_module_lang` VALUES ('log_upload', '', '文件上传日志');
INSERT INTO `sys_module_lang` VALUES ('log_upload', 'en', 'Upload log');
INSERT INTO `sys_module_lang` VALUES ('maintenance', '', '维护');
INSERT INTO `sys_module_lang` VALUES ('maintenance', 'en', 'Maintenance');
INSERT INTO `sys_module_lang` VALUES ('model_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('model_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('model_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('model_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('model_list', '', '内容模型管理');
INSERT INTO `sys_module_lang` VALUES ('model_list', 'en', 'Model management');
INSERT INTO `sys_module_lang` VALUES ('myself', '', '个人');
INSERT INTO `sys_module_lang` VALUES ('myself', 'en', 'Myself');
INSERT INTO `sys_module_lang` VALUES ('myself_content', '', '我的内容');
INSERT INTO `sys_module_lang` VALUES ('myself_content', 'en', 'My content');
INSERT INTO `sys_module_lang` VALUES ('myself_content_add', '', '修改');
INSERT INTO `sys_module_lang` VALUES ('myself_content_add', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('myself_content_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('myself_content_delete', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('myself_content_publish', '', '生成');
INSERT INTO `sys_module_lang` VALUES ('myself_content_publish', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('myself_content_push', '', '推荐');
INSERT INTO `sys_module_lang` VALUES ('myself_content_push', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('myself_content_refresh', '', '刷新');
INSERT INTO `sys_module_lang` VALUES ('myself_content_refresh', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('myself_log_login', '', '我的登录日志');
INSERT INTO `sys_module_lang` VALUES ('myself_log_login', 'en', 'My login log');
INSERT INTO `sys_module_lang` VALUES ('myself_log_operate', '', '我的操作日志');
INSERT INTO `sys_module_lang` VALUES ('myself_log_operate', 'en', 'My operate log');
INSERT INTO `sys_module_lang` VALUES ('myself_menu', '', '与我相关');
INSERT INTO `sys_module_lang` VALUES ('myself_menu', 'en', 'My account');
INSERT INTO `sys_module_lang` VALUES ('myself_password', '', '修改密码');
INSERT INTO `sys_module_lang` VALUES ('myself_password', 'en', 'Change password');
INSERT INTO `sys_module_lang` VALUES ('myself_token', '', '我的登录授权');
INSERT INTO `sys_module_lang` VALUES ('myself_token', 'en', 'My login token');
INSERT INTO `sys_module_lang` VALUES ('page', '', '页面');
INSERT INTO `sys_module_lang` VALUES ('page', 'en', 'Page');
INSERT INTO `sys_module_lang` VALUES ('page_list', '', '页面管理');
INSERT INTO `sys_module_lang` VALUES ('page_list', 'en', 'Page management');
INSERT INTO `sys_module_lang` VALUES ('page_menu', '', '页面维护');
INSERT INTO `sys_module_lang` VALUES ('page_menu', 'en', 'Page maintenance');
INSERT INTO `sys_module_lang` VALUES ('page_metadata', '', '元数据管理');
INSERT INTO `sys_module_lang` VALUES ('page_metadata', 'en', 'Metadata management');
INSERT INTO `sys_module_lang` VALUES ('page_publish', '', '生成页面');
INSERT INTO `sys_module_lang` VALUES ('page_publish', 'en', 'Publish');
INSERT INTO `sys_module_lang` VALUES ('page_save', '', '保存页面配置');
INSERT INTO `sys_module_lang` VALUES ('page_save', 'en', 'Save configuration');
INSERT INTO `sys_module_lang` VALUES ('page_select_category', '', '选择分类');
INSERT INTO `sys_module_lang` VALUES ('page_select_category', 'en', 'Select category');
INSERT INTO `sys_module_lang` VALUES ('page_select_category_type', '', '选择分类类型');
INSERT INTO `sys_module_lang` VALUES ('page_select_category_type', 'en', 'Select category type');
INSERT INTO `sys_module_lang` VALUES ('page_select_content', '', '选择内容');
INSERT INTO `sys_module_lang` VALUES ('page_select_content', 'en', 'Select content');
INSERT INTO `sys_module_lang` VALUES ('page_select_tag_type', '', '选择标签类型');
INSERT INTO `sys_module_lang` VALUES ('page_select_tag_type', 'en', 'Select tag type');
INSERT INTO `sys_module_lang` VALUES ('page_select_template', '', '选择模板');
INSERT INTO `sys_module_lang` VALUES ('page_select_template', 'en', 'Select template');
INSERT INTO `sys_module_lang` VALUES ('page_select_user', '', '选择用户');
INSERT INTO `sys_module_lang` VALUES ('page_select_user', 'en', 'Select user');
INSERT INTO `sys_module_lang` VALUES ('place_add', '', '增加/修改推荐位数据');
INSERT INTO `sys_module_lang` VALUES ('place_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('place_check', '', '审核推荐位数据');
INSERT INTO `sys_module_lang` VALUES ('place_check', 'en', 'Check');
INSERT INTO `sys_module_lang` VALUES ('place_clear', '', '清空推荐位数据');
INSERT INTO `sys_module_lang` VALUES ('place_clear', 'en', 'Clear');
INSERT INTO `sys_module_lang` VALUES ('place_data_list', '', '推荐位数据');
INSERT INTO `sys_module_lang` VALUES ('place_data_list', 'en', 'Page fragment data');
INSERT INTO `sys_module_lang` VALUES ('place_delete', '', '删除推荐位数据');
INSERT INTO `sys_module_lang` VALUES ('place_delete', 'en', 'data');
INSERT INTO `sys_module_lang` VALUES ('place_list', '', '页面片段管理');
INSERT INTO `sys_module_lang` VALUES ('place_list', 'en', 'Page fragment management');
INSERT INTO `sys_module_lang` VALUES ('place_publish', '', '发布');
INSERT INTO `sys_module_lang` VALUES ('place_publish', 'en', 'Publish');
INSERT INTO `sys_module_lang` VALUES ('place_refresh', '', '刷新推荐位数据');
INSERT INTO `sys_module_lang` VALUES ('place_refresh', 'en', 'Refresh');
INSERT INTO `sys_module_lang` VALUES ('place_template_content', '', '修改');
INSERT INTO `sys_module_lang` VALUES ('place_template_content', 'en', 'Edit template');
INSERT INTO `sys_module_lang` VALUES ('place_template_data_dictionary', '', '选择数据字典');
INSERT INTO `sys_module_lang` VALUES ('place_template_data_dictionary', 'en', 'Select data dictionary');
INSERT INTO `sys_module_lang` VALUES ('place_template_fragment', '', '模板片段');
INSERT INTO `sys_module_lang` VALUES ('place_template_fragment', 'en', 'Template fragment');
INSERT INTO `sys_module_lang` VALUES ('place_template_help', '', '模板帮助');
INSERT INTO `sys_module_lang` VALUES ('place_template_help', 'en', 'Template help');
INSERT INTO `sys_module_lang` VALUES ('place_template_list', '', '页面片段模板');
INSERT INTO `sys_module_lang` VALUES ('place_template_list', 'en', 'Page fragment template');
INSERT INTO `sys_module_lang` VALUES ('place_template_metadata', '', '修改元数据');
INSERT INTO `sys_module_lang` VALUES ('place_template_metadata', 'en', 'Edit metadata');
INSERT INTO `sys_module_lang` VALUES ('place_template_place', '', '页面片段');
INSERT INTO `sys_module_lang` VALUES ('place_template_place', 'en', 'Page fragment');
INSERT INTO `sys_module_lang` VALUES ('place_template_webfile', '', '网站文件');
INSERT INTO `sys_module_lang` VALUES ('place_template_webfile', 'en', 'Website file');
INSERT INTO `sys_module_lang` VALUES ('place_view', '', '查看推荐位数据');
INSERT INTO `sys_module_lang` VALUES ('place_view', 'en', 'View');
INSERT INTO `sys_module_lang` VALUES ('report_user', '', '用户数据监控');
INSERT INTO `sys_module_lang` VALUES ('report_user', 'en', 'User report');
INSERT INTO `sys_module_lang` VALUES ('role_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('role_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('role_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('role_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('role_list', '', '角色管理');
INSERT INTO `sys_module_lang` VALUES ('role_list', 'en', 'Role management');
INSERT INTO `sys_module_lang` VALUES ('system_menu', '', '系统维护');
INSERT INTO `sys_module_lang` VALUES ('system_menu', 'en', 'System maintenance');
INSERT INTO `sys_module_lang` VALUES ('tag_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('tag_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('tag_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('tag_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('tag_list', '', '标签管理');
INSERT INTO `sys_module_lang` VALUES ('tag_list', 'en', 'Tag management');
INSERT INTO `sys_module_lang` VALUES ('tag_type_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('tag_type_delete', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('tag_type_list', '', '标签分类');
INSERT INTO `sys_module_lang` VALUES ('tag_type_list', 'en', 'Tag type');
INSERT INTO `sys_module_lang` VALUES ('tag_type_save', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('tag_type_save', 'en', 'test');
INSERT INTO `sys_module_lang` VALUES ('task_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('task_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('task_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('task_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('task_list', '', '任务计划');
INSERT INTO `sys_module_lang` VALUES ('task_list', 'en', 'Task management');
INSERT INTO `sys_module_lang` VALUES ('task_pause', '', '暂停');
INSERT INTO `sys_module_lang` VALUES ('task_pause', 'en', 'Pause');
INSERT INTO `sys_module_lang` VALUES ('task_recreate', '', '重新初始化');
INSERT INTO `sys_module_lang` VALUES ('task_recreate', 'en', 'Recreate');
INSERT INTO `sys_module_lang` VALUES ('task_resume', '', '恢复');
INSERT INTO `sys_module_lang` VALUES ('task_resume', 'en', 'Resume');
INSERT INTO `sys_module_lang` VALUES ('task_runonce', '', '立刻执行');
INSERT INTO `sys_module_lang` VALUES ('task_runonce', 'en', 'Run once');
INSERT INTO `sys_module_lang` VALUES ('task_template_content', '', '修改');
INSERT INTO `sys_module_lang` VALUES ('task_template_content', 'en', 'Edit');
INSERT INTO `sys_module_lang` VALUES ('task_template_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('task_template_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('task_template_fragment', '', '任务计划脚本片段');
INSERT INTO `sys_module_lang` VALUES ('task_template_fragment', 'en', 'Task script fragment');
INSERT INTO `sys_module_lang` VALUES ('task_template_help', '', '帮助');
INSERT INTO `sys_module_lang` VALUES ('task_template_help', 'en', 'help');
INSERT INTO `sys_module_lang` VALUES ('task_template_list', '', '任务计划脚本');
INSERT INTO `sys_module_lang` VALUES ('task_template_list', 'en', 'Task template management');
INSERT INTO `sys_module_lang` VALUES ('template_content', '', '修改');
INSERT INTO `sys_module_lang` VALUES ('template_content', 'en', 'Edit');
INSERT INTO `sys_module_lang` VALUES ('template_content-type', '', '选择content-type');
INSERT INTO `sys_module_lang` VALUES ('template_content-type', 'en', 'Select content-type');
INSERT INTO `sys_module_lang` VALUES ('template_content_form', '', '内容投稿表单');
INSERT INTO `sys_module_lang` VALUES ('template_content_form', 'en', 'Content contribute form');
INSERT INTO `sys_module_lang` VALUES ('template_data_dictionary', '', '选择数据字典');
INSERT INTO `sys_module_lang` VALUES ('template_data_dictionary', 'en', 'Select data dictionary');
INSERT INTO `sys_module_lang` VALUES ('template_delete', '', '删除');
INSERT INTO `sys_module_lang` VALUES ('template_delete', 'en', 'Delete');
INSERT INTO `sys_module_lang` VALUES ('template_demo', '', '模板示例');
INSERT INTO `sys_module_lang` VALUES ('template_demo', 'en', 'Template example');
INSERT INTO `sys_module_lang` VALUES ('template_fragment', '', '模板片段');
INSERT INTO `sys_module_lang` VALUES ('template_fragment', 'en', 'Template fragment');
INSERT INTO `sys_module_lang` VALUES ('template_help', '', '模板帮助');
INSERT INTO `sys_module_lang` VALUES ('template_help', 'en', 'Template help');
INSERT INTO `sys_module_lang` VALUES ('template_list', '', '模板文件管理');
INSERT INTO `sys_module_lang` VALUES ('template_list', 'en', 'Template management');
INSERT INTO `sys_module_lang` VALUES ('template_metadata', '', '修改元数据');
INSERT INTO `sys_module_lang` VALUES ('template_metadata', 'en', 'Edit metadata');
INSERT INTO `sys_module_lang` VALUES ('template_place', '', '页面片段');
INSERT INTO `sys_module_lang` VALUES ('template_place', 'en', 'Page fragment');
INSERT INTO `sys_module_lang` VALUES ('template_place_form', '', '页面片段投稿表单');
INSERT INTO `sys_module_lang` VALUES ('template_place_form', 'en', 'Page fragment data contribute form');
INSERT INTO `sys_module_lang` VALUES ('template_upload', '', '上传模板');
INSERT INTO `sys_module_lang` VALUES ('template_upload', 'en', 'Upload template');
INSERT INTO `sys_module_lang` VALUES ('template_website_file', '', '网站文件');
INSERT INTO `sys_module_lang` VALUES ('template_website_file', 'en', 'Website file');
INSERT INTO `sys_module_lang` VALUES ('user_add', '', '增加/修改');
INSERT INTO `sys_module_lang` VALUES ('user_add', 'en', 'Add/edit');
INSERT INTO `sys_module_lang` VALUES ('user_disable', '', '禁用');
INSERT INTO `sys_module_lang` VALUES ('user_disable', 'en', 'Disable');
INSERT INTO `sys_module_lang` VALUES ('user_enable', '', '启用');
INSERT INTO `sys_module_lang` VALUES ('user_enable', 'en', 'Enable');
INSERT INTO `sys_module_lang` VALUES ('user_list', '', '用户管理');
INSERT INTO `sys_module_lang` VALUES ('user_list', 'en', 'User management');
INSERT INTO `sys_module_lang` VALUES ('user_menu', '', '用户管理');
INSERT INTO `sys_module_lang` VALUES ('user_menu', 'en', 'User maintenance');
INSERT INTO `sys_module_lang` VALUES ('webfile_content', '', '修改文件');
INSERT INTO `sys_module_lang` VALUES ('webfile_content', 'en', 'Edit file');
INSERT INTO `sys_module_lang` VALUES ('webfile_directory', '', '新建目录');
INSERT INTO `sys_module_lang` VALUES ('webfile_directory', 'en', 'Create Directory');
INSERT INTO `sys_module_lang` VALUES ('webfile_list', '', '网站文件管理');
INSERT INTO `sys_module_lang` VALUES ('webfile_list', 'en', 'Website file management');
INSERT INTO `sys_module_lang` VALUES ('webfile_unzip', '', '解压缩');
INSERT INTO `sys_module_lang` VALUES ('webfile_unzip', 'en', 'Decompress');
INSERT INTO `sys_module_lang` VALUES ('webfile_upload', '', '上传');
INSERT INTO `sys_module_lang` VALUES ('webfile_upload', 'en', 'Upload');
INSERT INTO `sys_module_lang` VALUES ('webfile_zip', '', '压缩');
INSERT INTO `sys_module_lang` VALUES ('webfile_zip', 'en', 'Compress');
INSERT INTO `sys_module_lang` VALUES ('word_list', '', '搜索词管理');
INSERT INTO `sys_module_lang` VALUES ('word_list', 'en', 'Search word management');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `owns_all_right` tinyint(1) NOT NULL COMMENT '拥有全部权限',
  `show_all_module` tinyint(1) NOT NULL COMMENT '显示全部模块',
  PRIMARY KEY  (`id`),
  KEY `site_id` (`site_id`)
) AUTO_INCREMENT=2 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '1', '超级管理员', '1', '0');

-- ----------------------------
-- Table structure for sys_role_authorized
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_authorized`;
CREATE TABLE `sys_role_authorized` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `url` varchar(100) NOT NULL COMMENT '授权地址',
  PRIMARY KEY  (`role_id`,`url`)
) COMMENT='角色授权地址';

-- ----------------------------
-- Records of sys_role_authorized
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_module`;
CREATE TABLE `sys_role_module` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `module_id` varchar(30) NOT NULL COMMENT '模块ID',
  PRIMARY KEY  (`role_id`,`module_id`)
) COMMENT='角色授权模块';

-- ----------------------------
-- Records of sys_role_module
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  PRIMARY KEY  (`role_id`,`user_id`)
) COMMENT='用户角色';

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES ('1', '1');

-- ----------------------------
-- Table structure for sys_site
-- ----------------------------
DROP TABLE IF EXISTS `sys_site`;
CREATE TABLE `sys_site` (
  `id` smallint(6) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `use_static` tinyint(1) NOT NULL COMMENT '启用静态化',
  `site_path` varchar(255) NOT NULL COMMENT '站点地址',
  `use_ssi` tinyint(1) NOT NULL COMMENT '启用服务器端包含',
  `dynamic_path` varchar(255) NOT NULL COMMENT '动态站点地址',
  `disabled` tinyint(1) NOT NULL COMMENT '禁用',
  PRIMARY KEY  (`id`),
  KEY `disabled` (`disabled`)
) AUTO_INCREMENT=2 COMMENT='站点';

-- ----------------------------
-- Records of sys_site
-- ----------------------------
INSERT INTO `sys_site` VALUES ('1', 'PublicCMS', '1', '//dev.publiccms.com:8080/publiccms/webfile/', '0', '//dev.publiccms.com:8080/publiccms/', '0');

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task` (
  `id` int(11) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `status` int(11) NOT NULL COMMENT '状态',
  `cron_expression` varchar(50) NOT NULL COMMENT '表达式',
  `description` varchar(300) default NULL COMMENT '描述',
  `file_path` varchar(255) default NULL COMMENT '文件路径',
  `update_date` datetime default NULL COMMENT '更新时间',
  PRIMARY KEY  (`id`),
  KEY `status` (`status`),
  KEY `site_id` (`site_id`),
  KEY `update_date` (`update_date`)
) AUTO_INCREMENT=8 COMMENT='任务计划';

-- ----------------------------
-- Records of sys_task
-- ----------------------------
INSERT INTO `sys_task` VALUES ('1', '1', '重新生成所有页面', '0', '0 0/2 * * ?', '重新生成所有页面', '/publishPage.task', NULL);
INSERT INTO `sys_task` VALUES ('2', '1', '重建索引', '0', '0 0 1 1 ? 2099', '重建全部索引', '/reCreateIndex.task', NULL);
INSERT INTO `sys_task` VALUES ('3', '1', '清理日志', '0', '0 0 1 * ?', '清理三个月以前的日志', '/clearLog.task', NULL);
INSERT INTO `sys_task` VALUES ('4', '1', '重新生成内容页面', '0', '0 0 1 1 ? 2099', '重新生成内容页面', '/publishContent.task', NULL);
INSERT INTO `sys_task` VALUES ('5', '1', '重新生成所有分类页面', '0', '0 0/6 * * ?', '重新生成所有分类页面', '/publishCategory.task', NULL);
INSERT INTO `sys_task` VALUES ('7', '1', '重新生成全站', '0', '0 0 1 1 ? 2099', '重新生成全站', '/publishAll.task', NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL auto_increment,
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `name` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `nick_name` varchar(45) NOT NULL COMMENT '昵称',
  `dept_id` int(11) default NULL COMMENT '部门',
  `roles` text COMMENT '角色',
  `email` varchar(100) default NULL COMMENT '邮箱地址',
  `email_checked` tinyint(1) NOT NULL COMMENT '已验证邮箱',
  `superuser_access` tinyint(1) NOT NULL COMMENT '是否管理员',
  `disabled` tinyint(1) NOT NULL COMMENT '是否禁用',
  `last_login_date` datetime default NULL COMMENT '最后登录日期',
  `last_login_ip` varchar(64) default NULL COMMENT '最后登录ip',
  `login_count` int(11) NOT NULL COMMENT '登录次数',
  `registered_date` datetime default NULL COMMENT '注册日期',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`,`site_id`),
  UNIQUE KEY `nick_name` (`nick_name`,`site_id`),
  KEY `email` (`email`),
  KEY `disabled` (`disabled`),
  KEY `lastLoginDate` (`last_login_date`),
  KEY `email_checked` (`email_checked`),
  KEY `dept_id` (`dept_id`)
) AUTO_INCREMENT=2 COMMENT='用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '管理员', '1', '1', 'master@sanluan.com', '0', '1', '0', '2017-01-01 00:00:00', '127.0.0.1', '0', '2017-01-01 00:00:00');


-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_token`;
CREATE TABLE `sys_user_token` (
  `auth_token` varchar(40) NOT NULL COMMENT '登录授权',
  `site_id` smallint(6) NOT NULL COMMENT '站点ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `channel` varchar(50) NOT NULL COMMENT '渠道',
  `create_date` datetime NOT NULL COMMENT '创建日期',
  `login_ip` varchar(64) NOT NULL COMMENT '登录IP',
  PRIMARY KEY  (`auth_token`),
  KEY `user_id` (`user_id`),
  KEY `create_date` (`create_date`),
  KEY `channel` (`channel`),
  KEY `site_id` (`site_id`)
) COMMENT='用户令牌';

-- ----------------------------
-- Records of sys_user_token
-- ----------------------------
