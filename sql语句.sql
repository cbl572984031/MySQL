#查询所有数据库
SHOW DATABASES;  

#查询指定库创建语句
SHOW CREATE DATABASE test;  

#判断不存在则创建
CREATE DATABASE IF NOT EXISTS test02;  

#创建时判断不存在与设置默认字符集
CREATE DATABASE IF NOT EXISTS test03 CHARACTER SET gbk;  

#ALTER 修改指定库属性
ALTER DATABASE test03 CHARACTER SET utf8;  

#DROP 删除库 存在则删除
DROP DATABASE IF EXISTS test03; 

#查询当前所在库
SELECT DATABASE();  

#切换到指定库
USE test; 

#查询库下所有表
SHOW TABLES; 

#查询表结构
DESC student; 
DESCRIBE student;

#查询test库中student表的结构与属性
SHOW TABLE STATUS FROM test LIKE 'product'; 

/*
创建数据表 语法:
	CREATE TABLE 表名(
		列名 数据类型 约束,
		...
		列名 数据类型 约束
	) 属性;
*/
CREATE TABLE IF NOT EXISTS product (
	id INT,
	NAME VARCHAR(20) NOT NULL,
	price DOUBLE NOT NULL,
	COUNT INT NOT NULL,
	TIME DATETIME NOT NULL
) DEFAULT CHARACTER SET utf8;


/*
MySQL中常用的数据类型
	int: 		整数类型
	double: 	小数类型
	date: 		日期类型，包含年月日，格式yyyy-MM-dd
	datetime: 	日期类型，包含年月日时分秒，格式yyyy-MM-dd HH:mm:ss
	timestamp:	时间戳类型，包含年月日时分秒，*如果不给该列赋值、或者赋值为null，则默认使用当前系统时间
	varchar(长度): 	字符串类型
*/

/***** 修改数据表 *****/
#修改表名 
ALTER TABLE 表名 RENAME TO 新表名;

#修改表的字符集
ALTER TABLE 表名 CHARACTER SET 字符集名称;

#单独添加一列
ALTER TABLE 表名 ADD 列名 数据类型;

#修改某列的数据类型
ALTER TABLE 表名 MODIFY 列名 新数据类型;

#修改列名和数据类型
ALTER TABLE 表名 CHANGE 列名 新列名 新数据类型;

#删除某一列
ALTER TABLE 表名 DROP 列名;

#删除表
DROP TABLE 表名;


/***** 表数据操作 *******/
#数据值除数字外,其他数据类型都需要用'或"包起来

#添加单条表数据
INSERT INTO 表名 (列名1, 列名2, ...) VALUES (值1, 值2, ...);
INSERT INTO 表名 VALUES (值1, 值2, ...);

#添加多条表数据
INSERT INTO 表名 (列名1, 列名2, ...) VALUES (值1, 值2, ...),(值1, 值2, ...);
INSERT INTO 表名 VALUES (值1, 值2, ...),(值1, 值2, ...);

#修改表数据  如果不加条件,则会将所有数据修改.
UPDATE 表名 SET 列名1=值1, 列名2=值2, ... [WHERE 条件];

#删除表中数据 如果不加条件,则会将所有数据删除.
DELETE FROM 表名 [WHERE 条件];


/******* 表的查询 ********/
#查询表中所有字段
SELECT * FROM 表名;

#查询指定字段
SELECT 列名1,... FROM 表名;

#去除重复查询
SELECT DISTINCT 列名1,... FROM 表名;

#计算列的值(四则运算)
SELECT 列名1 运算符(+-*/) 列名2 FROM 表名;

#起别名查询
SELECT 列名 AS 别名 FROM 表名;

#为null时替换
SELECT IFNULL(为null时需要替换的列名, 替换的值) FROM 表名;

/*
常用查询符号

>		大于
<		小于
>=		大于等于
<=		小于等于
=		等于
<>或!=		不等于
BETWEEN ... AND ...	在某个范围之间(都包含)
IN(值1, 值2, ...)	多选一
LKE 占位符	模糊查询 _单个任意字符 %多个任意字符
IS NULL		是NULL
IS NOT NULL 	不是NULL
AND或&&		与
OR或||		或
NOT或!		非

*/

/*
聚合函数查询
将一列数据作为一个整体,进行纵向计算

count(列名)		统计数据(一般选用不为null的列)
max(列名)		最大值
min(列名)		最小值
sum(列名)		求和
avg(列名)		平均值

*/

#排序查询
SELECT 列名 FROM 表名 [WHERE ...] ORDER BY 排序列名 DESC [, 排序列名2 ASC];

#分组查询
SELECT 列名 FROM 表名 [WHERE ...] GROUP BY 分组列名 [HAVING 分组后的条件过滤] [ORDER BY 排序方式];

#分页查询
SELECT 列名 FROM 表名 [WHERE ...] LIMIT 查询下标,查询条数;




/******* 约束 *******/
#什么是约束: 对表中的数据进行限定,保证数据的正确性,有效性,完整性.

#约束的分类:
PRIMARY KEY		主键约束
PRIMARY KEY AUTO_INCREMENT  主键自增
UNIQUE			唯一约束
NOT NULL 		非空约束
FOREIGN KEY		外键约束
FOREIGN KEY ON UPDATE CASCADE  外键级联更新
FOREIGN KEY ON DELETE CASCADE  外键级联删除

#删除自增约束 通过modify修改表结构删除约束
ALTER TABLE 表名 MODIFY 列名 数据类型;

#删除唯一约束
ALTER TABLE 表名 DROP INDEX 列名;



/******* 主键 *******/
#主键的特点: 主键默认为非空且唯一,一张表只能有一个主键,主键一般用于表中数据的唯一标识.

#建表时添加主键
<列名> <数据类型> PRIMARY KEY [默认值],

#也可以由多列组成
PRIMARY KEY (列1, 列2)

#建表后添加主键
ALTER TABLE 表名 ADD PRIMARY KEY (列名);
ALTER TABLE 表名 MODIFY 列名 数据类型 PRIMARY KEY;

#删除主键
ALTER TABLE 表名 DROP PRIMARY KEY;




/******* 外键 *******/

#建表时添加外键约束
CONSTRAINT 外键名 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名) 
	[ON DELETE {RESTRICT | CASCADE | SET NULL | NO ACTION}]
	[ON UPDATE {RESTRICT | CASCADE | SET NULL | NO ACTION}];

#on delete on update 表示事件触发限制,可设置参数:
	RESTRICT	(限制) 如果想删除主表,主表下面有对应从表的记录,主表将无法删除
	CASCADE		(级联) 如果主表记录删除,则从表相关的记录也会被删除
	SET NULL	将外键设置为空
	NO ACTION	什么都不做



#建表后添加外键约束
ALTER TABLE 表名 ADD CONSTRAINT 外键名 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名);

#删除外键约束
ALTER TABLE 表名 DROP FOREIGN KEY 外键名;





/***** 模拟学生课程表 *****/
USE test02;

CREATE TABLE IF NOT EXISTS  stu(
	id INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20) NOT NULL
) CHARACTER SET utf8;

CREATE TABLE IF NOT EXISTS teacher(
	id INT(4) PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20) DEFAULT ""
);

CREATE TABLE IF NOT EXISTS course(
	id INT(4) PRIMARY KEY AUTO_INCREMENT,
	course_name VARCHAR(20) NOT NULL,
	t_id INT(4) NOT NULL,
	UNIQUE(course_name,t_id),
	CONSTRAINT ct_fk1 FOREIGN KEY (t_id) REFERENCES teacher(id)
);

CREATE TABLE IF NOT EXISTS classroom(
	id INT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	room_num VARCHAR(20) NOT NULL,
	TIME TIMESTAMP NOT NULL,
	c_id INT(4) NOT NULL,
	UNIQUE(c_id, TIME),
	UNIQUE(TIME,room_num),
	CONSTRAINT cc_fk1 FOREIGN KEY (c_id) REFERENCES course(id)
) CHARACTER SET utf8;

CREATE TABLE IF NOT EXISTS learning(
	stu_id INT(4) NOT NULL,
	room_id INT(4) NOT NULL,
	CONSTRAINT ls_fk FOREIGN KEY (stu_id) REFERENCES stu(id),
	CONSTRAINT lc_fk FOREIGN KEY (room_id) REFERENCES classroom(id)
);

/*** 添加基础数据 ***/
INSERT INTO teacher VALUES(NULL, "张三"),(NULL, "李四");
INSERT INTO stu VALUES(NULL, "小红"),(NULL, "小白");
INSERT INTO course VALUES(NULL,"语文", 1),(NULL,"数学", 2);
INSERT INTO classroom VALUES (NULL,'201','2021-8-13 14:00:00',4);
INSERT INTO classroom VALUES (NULL,'202','2021-8-13 14:00:00',2);
INSERT INTO learning VALUES (1, 1),(1,2),(2,1);


/*** 查询老师对应的课程 ***/
SELECT * FROM course, (SELECT NAME, id teacher_id FROM teacher) t WHERE course.t_id = t.teacher_id;

/*** 查询所有信息 ***/
SELECT NAME, room_num, TIME, course_name, teacher_name FROM stu, (
	SELECT * FROM learning l,(
		SELECT * FROM classroom, (
			SELECT course_name,t_id,id cour_id, teacher_name FROM course, (
				SELECT NAME teacher_name,id teacher_id FROM teacher
			) t WHERE course.t_id = t.teacher_id
		) ce WHERE classroom.c_id = ce.cour_id
	) c WHERE l.room_id = c.id
) kc WHERE stu.id = kc.stu_id;




/****** 多表查询 *******/

#内联查询 (交集)
SELECT 列名 FROM 表名1 [INNER] JOIN 表名2 ON 关联条件;

#隐式内联查询
SELECT 列名 FROM 表1, 表2 WHERE 关联条件;



#外联查询
#左联(查询左表的全部数据,和左右两张表有交集部分的数据)
SELECT 列名 FROM 表1 LEFT [OUTER] JOIN 表2 ON 查询条件;

#右联
SELECT 列名 FROM 表1 RIGHT [OUTER] JOIN 表2 ON 查询条件;



#子查询
#将查询的结果作为另一条语句的查询条件

#单行单表
SELECT 列名 FROM 表名 WHERE 列名 [< > = <= >=] (SELECT 列名 FROM 表名 [WHERE ...]);

#多行单表
SELECT 列名 FROM 表名 WHERE 列名 [NOT] IN (SELECT 列名 FROM 表名 [WHERE ...]);

#多行多表 参照内联外联
SELECT 列名 FROM 表名 [别名], (SELECT 列名 FROM 表名 [WHERE ...]) [别名] [WHERE ...];
SELECT 列名 FROM 表名 LEFT JOIN (SELECT 列名 FROM 表名 [WHERE ...]) ON 查询条件;





/********* 视图 *******/
#创建视图
CREATE VIEW 视图名称 [(视图列表)] AS 查询语句;

#查询视图
SELECT * FROM 视图名称;

#修改视图数据 (修改视图数据后,源表数据也会被修改)
UPDATE 视图名称 SET 列名=值 WHERE 条件;

#修改视图结构
ALTER VIEW 视图名称 (列名列表) AS 查询语句;

#删除视图语法
DROP VIEW [IF EXISTS] 视图名称;






/******* 备份与恢复 *******/
/*
备份
	登录到mysql服务器,输入: mysqldump -u root -p 数据库名称>文件保存路径
*/

/*
恢复
	1.登录mysql数据库
	2.删除已备份的数据库
	3.重新创建名称相同的数据库
	4.使用该数据库
	5.导入文件 执行: source 备份文件全路径
*/





/******* 存储过程 ******/

#修改结束分割符
DELIMITER $;

#创建存储过程
CREATE PROCEDURE 存储过程名称 (参数列表)
BEGIN
	DECLARE a VARCHAR(10) DEFAULT "";
	...
END$;
DELIMITER ;


#参数传递
#IN: 	代表输入参数,需要由调用者传递实际数据(默认)
#OUT:	代表输出参数,该参数可以作为返回值
#INOUT:	既可以作为输入参数,也可以作为返回值
CREATE PROCEDURE 存储过程名称 ([IN|OUT|INOUT] 参数名 数据类型)
BEGIN
	sql语句;
END$;


#调用存储过程
CALL 存储过程名称();

#删除存储过程
DROP PROCEDURE [IF EXISTS] 存储过程名称;

#创建变量
DECLARE 变量名称 类型 [DEFAULT 默认值];

#修改变量值
SET 变量名=值;
SELECT * INTO 变量名 FROM 表名;

#if语句
IF 条件判断 THEN
	sql语句;
	...
ELSEIF 条件判断 THEN
	...
ELSE
	默认语句;

END IF;


#while循环语句
WHILE 条件判断语句 DO
	循环体语句;
	条件控制语句;
END WHILE;

#存储函数
#存储函数和存储过程非常相似,区别在于存储函数必须要有返回值
CREATE FUNCTION 函数名称(参数列表) RETURN 返回值类型
BEGIN
	sql语句;
	RETURN 结果;
END$;




/****** 触发器 *****/

#创建触发器
DELIMITER $;

CREATE TRIGGER 触发器名称 BEFORE|AFTER INSERT|UPDATE|DELETE ON 表名 FOR EACH ROW
BEGIN
	触发器要执行的功能
END$;

DELIMITER ;

#触发器分类
/*
触发类型		OLD				NEW

INSERT			无				NEW表示将要或已经新增的数据
UPDATE			OLD表示修改之前的数据		NEW表示将要或已经修改后的数据
DELETE			OLD表示将要或已经删除的数据	无

*/

#查看触发器
SHOW TRIGGERS;

#删除触发器
DROP TRIGGER 触发器名称;




/******** 事物 ********/
#开启事务
START TRANSACTION;

#回滚
ROLLBACK;

#提交事务
COMMIT;

#事务提交方式分类
#自动提交 (mysql默认)
#手动提交

#查看事务提交方式
SELECT @@autocommit;

#修改事务提交的方式
SET @@autocommit = 数字; #0手动提交 1自动提交

#事务的四大特征(ACID):
#原子性(Atomicity): 事务包含的所有操作要么全部成功,要么全部失败回滚.
#一致性(Consistency): 事务必须使数据库从一个一致性状态变换到另一个一致性状态.
#隔离性(Isolcation): 多个程序并发访问数据库时,数据库为每个程序开启事务不被其他事务的操作干扰,多个并发事务之间相互隔离.
#持久性(Durability): 事务一旦被提交,那么对数据库中的数据改变是永久性的,即便数据库系统遇到故障,也不会丢失提交事务的操作.

# 查询数据库隔离级别
SELECT @@tx_isolation;

#修改数据库隔离级别(修改后需要重新连接)
SET GLOBAL TRANSACTION ISOLATION LEVEL 级别字符串;

/*
隔离级别		名称		会引发的问题
READ UNCOMMITTED	读未提交	脏读,不可重复读,幻读
READ COMMITTED		读已提交	不可重复读,幻读
REPEATABLE READ		可重复读	幻读
SERIALIZABLE		串行化		无


脏读: 在一个事务处理过程中读取到另一个未提交事务中的数据,导致两次查询结果不一致

不可重复读: 在一个事务处理过程中读取到了另一个事务中修改并已提交的数据,导致两次查询结果不一致

幻读: 查询某数据不存在,准备插入此纪录,但执行插入时发现此纪录已存在,无法插入. 或查询数据不存在,执行删除操作,却返回删除成功

*/





/****** 存储引擎 *******/
#查询数据库支持的存储引擎
SHOW ENGINES;

#查询数据库所有数据表的存储引擎
SHOW TABLE STATUS FROM 数据库名称;

#查询数据库中某个数据表的存储引擎
SHOW TABLE STATUS FROM 数据库名称 WHERE NAME="表名称";

#创建数据表,指定存储引擎
CREATE TABLE 表名(
	列名 数据类型,
	...
) ENGINE=引擎名称;

#修改数据表存储引擎
ALTER TABLE 表名 ENGINE=引擎名称;







/******* 索引 ********/
#创建索引
CREATE [UNIQUE | FULLTEXT] INDEX 索引名称 [USING 索引类型] ON 表名(列名...);

#查看索引
SHOW INDEX FROM 表名;


#添加索引
#普通索引
ALTER TABLE 表名 ADD INDEX 索引名称(列名);

#组合索引
ALTER TABLE 表名 ADD INDEX 索引名称(列1, 列2...);

#主键索引
ALTER TABLE 表名 ADD PRIMARY KEY (主键列名);

#外键索引
ALTER TABLE 表名 ADD CONSTRAINT 外键名 FOREIGN KEY (本表列名) REFERENCES 主表名(列名);

#唯一索引
ALTER TABLE 表名 ADD UNIQUE 索引名称(列名);

#全文索引
ALTER TABLE 表名 ADD FULLTEXT 索引名称(列名);


#删除索引
DROP INDEX 索引名称 ON 表名;





/******* 锁 *********/
/*
InnoDB共享锁(读锁):
	数据可以被多个事务查询,但不能修改
	根据主键为查询条件添加的共享锁默认为行锁,非主键查询条件的默认为表锁
*/
SELECT 条件 LOCK IN SHARE MODE;


/*
InnoDB排他锁(写锁):
	加锁的数据,不能被其他事务加锁查询或修改
*/
SELECT 条件 FOR UPDATE;


/*
MyISAM读锁:
	所有连接只能查询数据,不能修改
*/
#加锁
LOCK TABLE 表名 READ;

#解锁
UNLOCK TABLES;


/*
MyISAM写锁:
	其他连接不能查询和修改数据
*/
#加锁
LOCK TABLE 表名 WRITE;

#解锁
UNLOCK TABLES;






































