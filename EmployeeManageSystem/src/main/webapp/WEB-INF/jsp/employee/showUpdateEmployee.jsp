<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统——修改员工</title>
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
<script type="text/javascript" src="${ctx }/js/jquery-1.11.0.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery-migrate-1.2.1.js"></script>
<script src="${ctx}/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="${ctx}/js/ligerUI/js/plugins/ligerDrag.js"
	type="text/javascript"></script>
<script src="${ctx}/js/ligerUI/js/plugins/ligerDialog.js"
	type="text/javascript"></script>
<script src="${ctx}/js/ligerUI/js/plugins/ligerResizable.jss"
	type="text/javascript"></script>
<link href="${ctx}/css/pager.css" type="text/css" rel="stylesheet" />
<script language="javascript" type="text/javascript"
	src="${ctx }/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	$(function(){
		/*点击取消按钮*/
		$("#cancel").click(function(){
			history.back();
		})
		
    	/** 员工表单提交 */
		$("#updateEmployeeButton").click(function(){
			var r=confirm("确认要修改吗?");
				if (r) {
					var name = $("#username");
					var email = $("#email");
					var phone = $("#phone");
					var msg = "";
					if ($.trim(name.val()) == ""){
						msg = "姓名不能为空！";
						name.focus();
					}else if ($.trim(email.val()) == ""){
						msg = "邮箱不能为空！";
						email.focus();
					}else if (!/^\w+@\w{2,3}\.\w{2,6}$/.test($.trim(email.val()))){
						msg = "邮箱格式不正确！";
						email.focus();
					}else if ($.trim(phone.val()) == ""){
						msg = "手机号码不能为空！";
						phone.focus();
					}else if (!/^1[3|5|8]\d{9}$/.test($.trim(phone.val()))){
						msg = "手机号码格式不正确！";
						phone.focus();
					}
					if (msg != ""){
						$.ligerDialog.error(msg);
						return;
					}
					
					$.post("${ctx}/employee/updateEmployee", $("#employeeForm").serialize(),function(data){
						if (data.status == 200) {
							$.ligerDialog.alert("修改成功！");
							window.location ="${ctx}/employee/showEmployee/${pageNum}";
						}else{
							$.ligerDialog.error(data.msg);
						}
					})
				}
		});
    });
</script>
</head>
<body>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="10"></td>
		</tr>
		<tr>
			<td width="15" height="32">
				<img src="${ctx}/images/main_locleft.gif" width="15" height="32"></td>
			<td class="main_locbg font2">
				<img src="${ctx}/images/pointer.gif">&nbsp;&nbsp;&nbsp;当前位置：员工管理&gt; 修改员工
			</td>
			<td width="15" height="32">
				<img src="${ctx}/images/main_locright.gif" width="15" height="32">
			</td>
		</tr>
	</table>
	<table width="100%" height="90%" border="0" cellpadding="5"
		cellspacing="0" class="main_tabbor">
		<tr valign="top">
			<td>
				<form id="employeeForm" method="post">
					<input type="hidden" name="id" value="${employee.id}">
					<table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
						<tr>
							<td class="font3 fftd">
								<table>
									<tr>
										<td class="font3 fftd">
										姓名：<input type="text" name="username" id="username" size="20" value="${employee.username }" />
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">
										性别： <select id="gender" name="gender" style="width: 143px;">
												<c:choose>
													<c:when test="${employee.gender=='男'}">
														<option value="男" selected="selected">男</option>
														<option value="女">女</option>
													</c:when>
													<c:otherwise>
														<option value="男">男</option>
														<option value="女" selected="selected">女</option>
													</c:otherwise>
												</c:choose>
										</select>
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">
										所属部门： <select name="deptId" style="width: 100px;">
												<c:forEach items="${deptList }" var="dept">
													<c:choose>
														<c:when test="${employee.deptId==dept.id}">
															<option value="${dept.id }" selected="selected">${dept.deptName }</option>
														</c:when>
														<c:otherwise>
															<option value="${dept.id }">${dept.deptName }</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
										</select>
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">
										角色身份： <select name="roleId" style="width: 100px;">
												<c:forEach items="${roleList }" var="role">
													<c:choose>
														<c:when test="${employee.roleId==role.roleId}">
															<option value="${role.roleId }" selected="selected">${role.roleName }</option>
														</c:when>
														<c:otherwise>
															<option value="${role.roleId }">${role.roleName }</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
										</select>
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">职位：
											<select id="job_id" name="jobId" style="width: 143px;">
												<c:forEach items="${jobList }" var="job">
													<c:choose>
														<c:when test="${employee.jobId==job.id}">
															<option value="${job.id }" selected="selected">${job.name }</option>
														</c:when>
														<c:otherwise>
															<option value="${job.id }">${job.name }</option>
														</c:otherwise>
													</c:choose>
												</c:forEach>
										</select>
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">工资：
											<input name="salary" id="salary" size="20" value="${employee.salary }" />
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">邮箱：
											<input name="email" id="email" size="20" value="${employee.email }" />
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">手机：
											<input name="phone" id="phone" size="20" value="${employee.phone }" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="main_tdbor"></td>
						</tr>
						<tr>
							<td align="left" class="fftd">
								<input type="button" id="updateEmployeeButton" value="修改">&nbsp;&nbsp;
								<input type="button" value="取消 " id="cancel">
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