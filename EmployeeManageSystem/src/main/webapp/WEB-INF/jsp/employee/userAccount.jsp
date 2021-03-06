<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统——账号管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="${ctx}/css/css.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/ligerUI/skins/Aqua/css/ligerui-dialog.css" />
<link href="${ctx}/js/ligerUI/skins/ligerui-icons.css" rel="stylesheet"
	type="text/css" />
<!-- 导入layui -->
<link rel="stylesheet" type="text/css" href="${ctx}/css/layui/css/layui.css">
<script type="text/javascript" src="${ctx}/css/layui/layui.js"></script>	
<script type="text/javascript" src="${ctx }/js/jquery-1.11.0.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery-migrate-1.2.1.js"></script>
<script src="${ctx}/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="${ctx}/js/ligerUI/js/plugins/ligerDrag.js"
	type="text/javascript"></script>
<script src="${ctx}/js/ligerUI/js/plugins/ligerDialog.js"
	type="text/javascript"></script>
<script src="${ctx}/js/ligerUI/js/plugins/ligerResizable.js"
	type="text/javascript"></script>
<link href="${ctx}/css/pager.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/nprogress.css" />
<script type="text/javascript" src="${ctx}/js/NProgress/nprogress.js"></script>
<script type="text/javascript">
	
	$(function(){
		/*校验表单数据是否合理*/
		$("#updateUserAccountButton").click(function(){
			 NProgress.start();
			var roleId=${sessionScope.USERS_SESSION.roleId};
			var param;
			var msg="";
			var newpwd = $("#newpwd");
			var repeatNewpwd = $("#repeatNewpwd");
			if(roleId<3){
				var username = $("#username");
				if ($.trim(username.val()) == ""){
					msg = "姓名不能为空！";
					username.focus();
				}
				param={"username":username.val(),"password":newpwd.val()};
			}else{
				var oldpwd = $("#oldpwd");
				if ($.trim(oldpwd.val()) == ""){
					msg = "密码不能为空！";
					oldpwd.focus();
				}
				param={"oldpwd":oldpwd.val(),"password":newpwd.val()};
			}
			if ($.trim(newpwd.val()) == ""|| $.trim(repeatNewpwd.val()) == ""){
				msg = "密码不能为空！";
				newpwd.focus();
			}else if ($.trim(newpwd.val()) != $.trim(repeatNewpwd.val())){
				msg = "两次输入密码不一致！";
				newpwd.focus();
			}
			if (msg != ""){
				NProgress.done();
				$.ligerDialog.error(msg);
				var inputs = $("input");
				inputs.not(".buttons").each(function(){
					$(this).val("");//遍历得到的每一个jquery对象
				});
				return ;
			}
			
			$.ajax({
				type:"post",
				url:"/user/updateUserAccount",
				contentType:"application/x-www-form-urlencoded",
				data:param,
				dataType:"json",
				success:function(data){
					NProgress.done();
					if (data.status == 200) {
						$.ligerDialog.alert("修改密码成功！");
					}else{
						$.ligerDialog.error(data.msg);
						var inputs = $("input");
						inputs.not(".buttons").each(function(){
							$(this).val("");//遍历得到的每一个jquery对象
						});
					}
				}
			});
			/*这个和删除那里居然不进方法*/
			/*$.post("/user/updateUserAccount", param,function(data){
				if (data.status == 200) {
					$.ligerDialog.alert("修改密码成功！");
				}else{
					$.ligerDialog.alert(data.msg);
				}
			})*/
		})
		 
    });

	</script>
</head>
<body>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" >
		<tr>
			<td height="10"></td>
		</tr>
		<tr>
			<td width="15" height="32">
				<img src="${ctx}/images/main_locleft.gif" width="15" height="32">
			</td>
			<td class="main_locbg font2">
				<i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：账号管理&gt;
				<c:choose>
					<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
						找回密码
					</c:when>
					<c:otherwise>
						修改密码
					</c:otherwise>
				</c:choose>
			</td>
			<td width="15" height="32">
				<img src="${ctx}/images/main_locright.gif" width="15" height="32">
			</td>
		</tr>
	</table>
	<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="layui-table">
		<tr valign="top">
			<td>
				<form id="employeeForm" method="post" onsubmit="">
					<table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
						<tr>
							<td class="font3 fftd">
								<table>
								<c:choose>
									<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
										<!-- 动态验证两次是否相同？ 用户名是否存在？-->
										<tr>
											<td class="font3 fftd">员工用户名：
												<input type="text" name="username" id="username" size="20" />
											</td>
										</tr>
										<tr>
											<td class="font3 fftd">输入新密码：
												<input type="password" name="newpwd" id="newpwd" size="20" />
											</td>
										</tr>
										<tr>
											<td class="font3 fftd">确认新密码：
												<input type="password" name="repeatNewpwd" id="repeatNewpwd" size="20" />
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="font3 fftd">输入旧密码：
												<input type="password" name="oldpwd" id="oldpwd" size="20" />
											</td>
										</tr>
										<tr>
											<td class="font3 fftd">输入新密码：
												<input type="password" name="newpwd" id="newpwd" size="20" />
											</td>
										</tr>
										<tr>
											<td class="font3 fftd">确认新密码：
												<input type="password" name="repeatNewpwd" id="repeatNewpwd" size="20" />
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
								</table>
							</td>
						</tr>
						<tr>
							<td class="main_tdbor"></td>
						</tr>
						<tr>
							<td align="left" class="fftd">
								<input type="button" id="updateUserAccountButton" value="确定" class="layui-btn layui-btn-xs buttons">&nbsp;&nbsp;
								<input type="reset" value="重置 " class="layui-btn layui-btn-xs buttons">
							</td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
	</table>
	<div style="height: 10px;"></div>
</body>
</html>