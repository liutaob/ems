<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>员工管理系统 ——后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="${ctx}/css/css.css" type="text/css" rel="stylesheet" />
<!-- 导入layui -->
<link rel="stylesheet" type="text/css" href="${ctx}/css/layui/css/layui.css">
<script type="text/javascript" src="${ctx}/css/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery-1.11.0.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery-migrate-1.2.1.js"></script>
<script language="javascript" type="text/javascript"> 
			$(function(){
				/** 给左侧功能菜单绑定点击事件  */
				$("td[id^='navbg']").click(function(){
				   	 /** 获取一级菜单的id */
				   	 var navbgId = this.id;
				   	 /** 获取对应的二级菜单id */
				   	 var submenuId = navbgId.replace('navbg','submenu');
				   	 /** 控制二级菜单显示或隐藏  */
				   	 $("#"+submenuId).toggle();
				   	 /** 控制关闭或者开启的图标*/
				   	 $("#"+navbgId).toggleClass("left_nav_expand");
				   	 
				   	 /** 控制其他的一级菜单的二级菜单隐藏按钮都关闭  */
				   	 $("tr[id^='submenu']").not("#"+submenuId).hide();
				   	 /** 控制其他一级菜单的图片显示关闭  */
				   	 $("td[id^='navbg']").not(this).removeClass().addClass("left_nav_closed");
				   	 
				   	 
				})
			})
		</script>
</head>
<body>
	<div style="margin: 10px; background-color: #FFFFFF; text-align: left;">
		<table width="200" height="100%" border="0" cellpadding="0"
			cellspacing="0" class="left_nav_bg">
			<tr>
				<td class="manage left_nav_expand">
					<div class="font1">
						<div class="left_margin"><i class="layui-icon layui-icon-username">员工管理</i></div>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td height="50">
					<p class="left_nav_link">
						<a href="employee/showEmployee/1" target="main">
						<i class="layui-icon layui-icon-triangle-r">员工查询</i>
						</a>
					</p>
					<c:choose>
						<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
							<p class="left_nav_link">
								<a href="empoloyee/gotoAddEmployee" target="main">
								<i class="layui-icon layui-icon-add-1">添加员工</i>
								</a>
							</p>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td height="2"></td>
			</tr>

			<tr>
				<td id="navbg1" class="manage">
					<div class="font1">
						<div class="left_margin"><i class="layui-icon layui-icon-app" style="cursor: pointer;">部门管理</i></div>
					</div>
				</td>
			</tr>
			<tr valign="top" id="submenu1" style="display: none">
				<td class="left_nav_bgshw" height="50">
					<p class="left_nav_link">
						<a href="dept/showDept/1" target="main">
						<i class="layui-icon layui-icon-triangle-r">部门查询</i>
						</a>
					</p>
					<c:choose>
						<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
							<p class="left_nav_link">
								<a href="dept/gotoAddDept" target="main">
									<i class="layui-icon layui-icon-add-1">添加部门</i>
								</a>
							</p>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td height="2"></td>
			</tr>

			<tr>
				<td id="navbg2" class="manage">
					<div class="font1">
						<div class="left_margin"><i class="layui-icon layui-icon-template" style="cursor: pointer;">职位管理</i></div>
					</div>
				</td>
			</tr>
			<tr valign="top" id="submenu2" style="display: none">
				<td class="left_nav_bgshw" height="50">
					<p class="left_nav_link">
					<a href="job/showJob/1" target="main">
						<i class="layui-icon layui-icon-triangle-r">职位查询</i></a>
					</p>
					<c:choose>
						<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
							<p class="left_nav_link">
								<a href="job/gotoAddJob" target="main">
									<i class="layui-icon layui-icon-add-1">添加职位</i>
								</a>
							</p>
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td height="2"></td>
			</tr>
			
	<c:choose>
		<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
			<tr>
				<td id="navbg3" class="manage">
					<div class="font1">
						<div class="left_margin"><i class="layui-icon layui-icon-rmb" style="cursor: pointer;">工资管理</i></div>
					</div>
				</td>
			</tr>
			<tr valign="top" id="submenu3" style="display: none">
				<td class="left_nav_bgshw" height="50">
					<p class="left_nav_link">
					<a href="salary/showSalary/1" target="main">
					<i class="layui-icon layui-icon-triangle-r">发放记录</i></a>
					</p>
					<p class="left_nav_link">
						<a href="salary/showAddSalary" target="main">
						<i class="layui-icon layui-icon-add-1">发放工资</i></a>
					</p>
				</td>
			</tr>
			<tr>
				<td height="2"></td>
			</tr>
		</c:when>
	</c:choose>

			<tr>
				<td id="navbg4" class="manage">
					<div class="font1">
						<div class="left_margin"><i class="layui-icon layui-icon-speaker" style="cursor: pointer;">公告管理</i></div>
					</div>
				</td>
			</tr>
			<tr valign="top" id="submenu4" style="display: none">
				<td class="left_nav_bgshw tdbtmline" height="50">
					<p class="left_nav_link">
						<a href="notice/showNotice/1" target="main">
						<i class="layui-icon layui-icon-triangle-r">公告查询</i>
						</a>
					</p>
					<c:choose>
						<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
							<p class="left_nav_link">
								<a href="notice/showAddNotice" target="main">
								<i class="layui-icon layui-icon-add-1">添加公告</i>
								</a>
							</p>
						</c:when>
					</c:choose>
				</td>
			</tr>
			
			<tr>
				<td id="navbg5" class="manage">
					<div class="font1">
						<div class="left_margin"><i class="layui-icon layui-icon-speaker" style="cursor: pointer;">邮件管理</i></div>
					</div>
				</td>
			</tr>
			<tr valign="top" id="submenu5" style="display: none">
				<td class="left_nav_bgshw tdbtmline" height="50">
					<p class="left_nav_link">
						<a href="mail/showSendMail/1?userId=${sessionScope.USERS_SESSION.id}" target="main">
						<i class="layui-icon layui-icon-triangle-r">发件箱</i>
						</a>
					</p>
					<p class="left_nav_link">
						<a href="mail/showReceiveMail/1?userId=${sessionScope.USERS_SESSION.id}" target="main">
						<i class="layui-icon layui-icon-triangle-r">收件箱</i>
						</a>
					</p>
				</td>
			</tr>
			
			<tr>
				<td id="navbg6" class="manage">
					<div class="font1">
						<div class="left_margin"><i class="layui-icon layui-icon-password" style="cursor: pointer;">账号管理</i></div>
					</div>
				</td>
			</tr>
			<tr valign="top" id="submenu6" style="display: none">
				<td class="left_nav_bgshw tdbtmline" height="50">
					<p class="left_nav_link">
						<a href="/user/gotoUserAccount" target="main">
							<c:choose>
								<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
									<i class="layui-icon layui-icon-triangle-r">找回密码</i>
								</c:when>
								<c:otherwise>
									<i class="layui-icon layui-icon-triangle-r">修改密码</i>
								</c:otherwise>
							</c:choose>
						</a>
					</p>
				</td>
			</tr>
			<tr>
				<td height="10" bgcolor="#e5f0ff">&nbsp;</td>
			</tr>
		</table>
	</div>
</body>
</html>