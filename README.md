# 企业管理系统

[项目展示地址](https://ems.iliutao.com)

**账密:**

~~~
刘涛/111111
~~~

### 开发工具:

eclipse、mysql,redis数据库、阿里云服务器

### 项目技术

* SSM框架
* Quarz定时框架
* SpringMail邮件
* mysql数据库，redis缓存
* 部署方面linux阿里云，docker部署

### 项目介绍: 

本系统主要目的在于解决企业管理问题，分为普通用户和管理员两个角色，主要有企业信息员工、部门、职位、工资、邮件等管理功能，新入职员工、修改密码、每日打卡都有邮件提醒.

### 项目流程: 

搭建maven项目，基于SSM框架进行后台开发，以html、js、ajax配合jsp完成前台页面展示，需要应用到的服务器或中间件均部署在准生产环境的Linux系统上，如Mysql、redis、tomcat、nginx等，其中使用SpringMail和quartz定时完成邮件提醒功能。在完成开发后，将项目部署在阿里云服务器上，并且通过nginx实现了负载均衡。