<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统 ——后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<!-- 导入layui -->
<link rel="stylesheet" type="text/css" href="${ctx}/css/layui/css/layui.css">
<script type="text/javascript" src="${ctx}/css/layui/layui.js"></script>
<link href="${ctx}/fkjava.ico" rel="shortcut icon" type="image/x-icon" />
<link href="${ctx}/css/css.css" type="text/css" rel="stylesheet" />
</head>
<body>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="10"></td>
		</tr>
		<tr>
			<td width="15" height="32">
				<img src="${ctx}/images/main_locleft.gif" width="15" height="32">
			</td>
			<td class="main_locbg font2">
				<i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>
				当前位置：后台管理&gt; 当前用户
			</td>
			<td width="15" height="32">
				<img src="${ctx}/images/main_locright.gif" width="15" height="32">
			</td>
		</tr>
	</table>
	<table width="100%" height="90%" border="0" cellpadding="10" cellspacing="0" class="main_tabbor">
		<tr valign="top">
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
					<tr>
						<td class="font3 fftd">
							<i class="layui-icon layui-icon-user"></i>
							用户姓名:
							<font color="red" size="2">
								${sessionScope.USERS_SESSION.username}
							</font>
						</td>
					</tr>
					<tr>
						<td class="main_tdbor"></td>
					</tr>

					<tr>
						<td class="font3 fftd">
							<i class="layui-icon layui-icon-male layui-icon-male"></i>
							用户性别:
							<font color="red" size="2">
								${sessionScope.USERS_SESSION.gender}
							</font>
						</td>
					</tr>
					<tr>
						<td class="main_tdbor"></td>
					</tr>
					
					<tr>
						<td class="font3 fftd">
							<i class="layui-icon layui-icon-vercode"></i>
							用户身份:
							<font color="red" size="2">
								${sessionScope.ROLE_SESSION.roleName}
							</font>
						</td>
					</tr>
					
					<tr>
						<td class="main_tdbor"></td>
					</tr>

					<tr>
						<td class="font3 fftd">
							<i class="layui-icon layui-icon-location"></i>
							所在部门:
							<font color="red" size="2">
								${sessionScope.DEPT_SESSION.deptName}
							</font>
						</td>
					</tr>
					<tr>
						<td class="main_tdbor"></td>
					</tr>

					<tr>
						<td class="font3 fftd">
							<i class="layui-icon layui-icon-util"></i>当前职位:
							<font color="red" size="2">
								${sessionScope.JOB_SESSION.name}
							</font>
						</td>
					</tr>
					<tr>
						<td class="main_tdbor"></td>
					</tr>
					<tr>
						<td class="font3 fftd">
							<i class="layui-icon layui-icon-cellphone"></i>
							手机号:
							<font color="red" size="2">
								${sessionScope.USERS_SESSION.phone}
							</font>
						</td>
					</tr>
					
					<tr>
						<td class="main_tdbor"></td>
					</tr>
					<tr>
						<td class="font3 fftd">
							<i class="layui-icon layui-icon-dialogue"></i>
							邮箱:
							<font color="red" size="2">
								${sessionScope.USERS_SESSION.email}
							</font>
						</td>
					</tr>
					
					<tr>
						<td class="main_tdbor"></td>
					</tr>
					
					<tr>
						<td class="font3 fftd">
							<i class="layui-icon layui-icon-date"></i>
							入职时间:
							<font color="red" size="2">
									<f:formatDate value="${sessionScope.USERS_SESSION.created}" type="date" dateStyle="long" />
							</font>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div style="height: 10px;"></div>
</body>
</html>