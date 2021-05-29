06 整合SSM框架————书籍管理系统

6.1 环境需求
·IDEA
·MySQL5.7/8.0
·Tomcat9
·Maven3.6

6.2 知识要求:熟练掌握MySQL数据库,Spring, Java Web(SpringMVC)及Mybatis知识,简单前端知识

6.3 项目流程
· 需求分析
· 设计数据库
· 业务
· 前端界面

6.4 具体步骤:

6.4.1 创建数据库
CREATE DATABASE `ssmBookSys`;
USE `ssmBookSys`;
CREATE TABLE `books`(
	`bookID` INT(10) NOT NULL AUTO_INCREMENT COMMENT '图书编好',
	`bookName` varchar(100) NOT NULL COMMENT '书名',
	`bookCounts` INT(11) NOT NULL COMMENT '书本数量',
	`detail` varchar(200) NOT NULL COMMENT '简介',
	KEY `bookID` (`bookID`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
INSERT INTO `books`(`bookID`,`bookName`,`bookCounts`,`detail`) VALUES
(1,'Java',1,'从入门到放弃'),
(2,'MySQL',10,'从删库到跑路'),
(3,'Linux',5,'从入门到入狱');

6.4.2 创建Maven项目,搭建环境
· pom.xml文件中导入依赖 静态资源过滤问题
导入依赖 mysqljdbc驱动√,c3p0数据库连接池√ jdbc-spring√ mybatis√ mybatis-spring√
spring5web√ aop织入包 servlet√ jsp√ jstl√ log4j日志 junit√ lombok fastjson
· IDEA连接数据库
jdbc:mysql://localhost:3306/ssmbooksys?useSSL=true&useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC 
· 建必要的包 com.wq.mapper service controller pojo utils (filter)
  建数据库properties文件 database.properties
  建必要的配置文件 resource/mybatis-config.xml applicationContext.xml(UTF8)
1)database.properties
jdbc.driver=com.mysql.cj.jdbc.Driver
## 如果使用的MySQL8.0+ 还要增加时区的配置 &serverTimeZone=Asia/Shanghai
jdbc.url=jdbc:mysql://localhost:3306/ssmbooksys?useSSL=true&useUnicode=true&characterEncoding=UTF-8&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC 
jdbc.username=root
jdbc.password=root
2)mybatis-config.xml [详见文件]
<?xml version="1.0" encoding="UTF8" ?>
<!DOCTYPE configuration
      PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
      "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <!-- mybatis配置文件 -->
    <!-- 1.配置数据源====交给spring做 -->
    <!-- 2.扫描包或者起别名(默认别名为类名 最好小写) 方便Mapper.xml -->
    <typeAliases>
        <package name="com.wq.pojo"/>
    </typeAliases>
    <!-- 3.注册Mapper.xml 也交给Spring -->
</configuration>
3)applicationContext.xml
<?xml version="1.0" encoding="UTF8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">
</beans>
6.4.3 创建pojo对象(字段名尽量和数据库里的一样)
[注意java自带一个Book的类 因此取名Books]
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Books {
    // 字段名称尽量和数据库一模一样
    private int bookID;
    private String bookName;
    private int bookCounts;
    private String detail;
}
DAO层
6.4.4 编写pojo类的操作接口(实现 增 删 改 查(一本 全部))
6.4.5 实现接口的Mapper.xml(是去改Mybatis.xml 不是 Spring.xml)==>也可以用注解实现简单的
· DOCTYPE mapper
· mybatis-3-mapper.dtd
· <mapper namespace=...>
· 增加bookID设置了自增长 不用管
· 删除的时候传入一个int参数 paramType写_int int都行(java特性)
· 修改的时候传入一个Books #{}内参数名要和对象的属性名一致
· 查询的时候要协商resultType或者resultMap属性 传参采用paramTye=map
· ====>将mapper注册到mybatis.xml 或者 用Spring注册也行
  当接口和Mapper.xml文件名一样的时候,可以直接用mapper class属性设置
  [用class还可以兼容注解方式实现SQL语句]
  否则直接使用 resource 属性 定位到mapper.xml文件的具体位置
Service层
6.4.6 实现service层接口
service层的接口跟dao接口存在细微差别 这个案例中直接使用DAO层
6.4.7 实现service层接口实现类Impl implements BookService
[业务层调用DAO层就对了] ===所以要将DAO层组合进来(后面也可以用Spring @Autowired 自动注入)
===========>业务很纯粹 要想新增功能直接使用SpringAOP横切就行

6.4.8 完成mybatis和spring的整合(也就是编写spring-mybatis.xml文件)[详见文件]

6.4.9 整合Spring和Service层(也就是编写spring-service.xml文件)[详见文件]
mapper.xml注册到mybatis.xml或者spring-mybatis.xml中 
新介绍的spring-mybatis.xml中的MapperScannerConfigurer将mapper.xml和mapper接口绑定
这步主要将这个绑定了mapper.xml的mapper注入到ServiceImpl中

6.4.10 整合SpringMVC层
· 给项目增加web 框架支持 右键项目 add framework support 勾选web
##########################################################################
# · web.xml配置DispatcherServlet 、 乱码过滤器  、 session过期时间[详见文件]
##########################################################################
· 编写spring-mvc.xml整合spring和springmvc的配置文件
  (configure application context的时候,新建的这个spring-mvc.xml自己成立了一个applicationContext,
  点击已有的applicationContext,点击上方的笔编辑勾选加入即可)[详见文件]

· 这里适时编写applicationContext.xml Sring全局配置文件将上面写的 三个 spring-xxx.xml import整合

6.4.11 编写Controller层,与jsp进行交互

6.5.12 编写首页index 和 listBooks页面

6.5.13 初次启动:
报错:1字节:所有spring.xml上的encoding都要换成UTF8
报错:
    @Autowired
    @Qualifier("bookServiceImpl")
    private BookService bookService;
    注入时,找不到对应的bookServiceImpl bean
错误分析步骤:
    · 查看bean是否注入成功
    方法一:在Controller中点击private BookService bookService;这行左边行号的符号,
    成功跳转到bean bookServiceImpl定义的地方,说明注入成功
    方法二:Junit单元测试,在test文件夹下进行测试,
    直接从context里取出bookServiceImpl使用,能够得到正确的结果,说明注入成功
    · 因此问题一定不底层,因为成功使用bookServiceImpl取出所有书籍
    是spring出了问题
    1.首先试着手动注入
        @Autowired                                      
        @Qualifier("bookServiceImpl")       =======>    private BookService bookService = new BookServiceImpl();
        private BookService bookService;
    也失败了,tomacat启动不报错,但是跳转链接的时候空指针异常  java.lang.NullPointerException   
    ====>springMVC出问题
    · SpringMVC整合的时候没有调用Service层的bean
    地方一:applicationContext.xml里没有注册bean(但上述测试证明 注册了 所以不是这个原因)
    地方二:web.xml中配置DispatcherServlet的时候绑定的配置文件是不是有问题!
    (只写了一个spring-mvc.xml不包含service层的xml文件 就不包含service层的Bean 所以空指针 问题所在)
    [一定要绑定包含全部spring配置文件的applicationContext.xml]
    本地测试完还是空指针,因为在测试手动注入方式的时候改动代码,忘记改回来了

6.5.13 优化首页index 和 listBooks页面 [${pageContext.request.contextPath}]
·index.jsp中<a href="[${pageContext.request.contextPath}]/books/listBooks">进入书籍页面</a>
·${pageContext.request.contextPath} 是JSP取得绝对路径的方法, 价于<%=request.getContextPath()%> 
·其实很好理解:pageContext获取当前页面的上下文,.request从上下文中取出请求,.contextPath获取请求的contextPath
·localhost:8080/ssmBookSys/index.jsp 最后的值是就是所请求的项目路径这一串前缀 : localhost:8080/ssmBookSys

流程通了之后要开始优化页面
·首先是index.jsp [详见代码]
·然后是书籍展示页面
使用bootstrap层叠样式表:<link href="../css/bootstrap.min.css" rel="stylesheet"/>
查看bootstrap中文网,上方有个全局样式 和 组件 可以学习
·栅格系统可以把页面分成好几份 放在一个容器里
###################################################################
# 静态资源问题:
# 方式一:把静态资源放在web目录下 比如放在web下的css文件夹中 web/css/a.css 
#     需要在web.xml进行配置 在进入Dispatcher拦截器之前先放这些类型资源过去 使其不被拦截
#      <servlet-mapping>
#          <servlet-name>default</servlet-name>
#         <url-pattern>*.jpg</url-pattern>
#      </servlet-mapping>
#      <servlet-mapping>
#          <servlet-name>default</servlet-name>
#          <url-pattern>*.js</url-pattern>
#      </servlet-mapping>
#      <servlet-mapping>
#          <servlet-name>default</servlet-name>
#          <url-pattern>*.css</url-pattern>
#      </servlet-mapping>
# 在jsp中如下即可
# <link href="${pageContext.request.contextPath}/css/a.css" rel="stylesheet"/>
# 
# 方法二:要把静态资源放在/WEB-INF/ 保证安全性
# 在 spring-servlet.xml  配置文件中加入 进行路由的映射
# <!--本项目把静态资源放在了web的/WEB-INF/css/a.css目录下，资源映射如下-->
# <mvc:resources mapping="/css/**" location="/WEB-INF/css/"/>
# 在jsp中如下即可(mapping怎么写,/css/就要做相应改动)====>页面方法的是映射路径mapping
# <link href="${pageContext.request.contextPath}/css/a.css" rel="stylesheet"/>
# =======================>都rebuild一下项目
# =======================>重启tomcat
# 网上有说需要在前面加 <mvc:annotation-driven/>
# 在后面加上          <mvc:default-servlet-handler/>
###################################################################

[遇到问题:使用jsp taglib c:foreach的时候 发现包太新了 pom.xml中换成如下包即可
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
    <version>1.2</version>
</dependency>]

6.5.14 增删改查
·查.
·增，
·修改的时候出现需要提交事务的问题,AOP解决====但并不是这个导致的 增加成了 事务是正常的
 [为什么是在服务类里实现AOP织入呢?
 事务是多个任务的组合,提交事务保证这多个任务ACID
 多个任务的组合就是在service层实现的]
 因为更新的时候没传bookID！！！ 用隐藏域实现
 ============================>完善项目 
 · mybatis.xml settings setting加入log4j <!-- LOG4J 不需要加_LOGGING -->
 · 在resource下加入log4j.properties
 · rebuild一下
·删除书籍

6.5.15 扩充功能
自底向上的扩充思路
数据库->DAO->Service->controller->前端
[为了和log4j的日志输出区别开,可以使用System.err.println(""");输出红色字体]
 
 