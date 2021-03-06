<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统——添加员工</title>
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
	var jobList=[];
	$(function(){
		/*校验表单数据是否合理*/
		$("#addEmployeeButton").click(function(){
			 NProgress.start();
			var username = $("#username");
			var dept = $("#depts");
			var job = $("#jobs");
			var salary = $("#salary");
			var email = $("#email");
			var phone = $("#phone");
			var msg = "";
			if ($.trim(username.val()) == ""){
				msg = "姓名不能为空！";
				username.focus();
			}else if ($.trim(dept.val()) == ""){
				msg = "部门不能为空！";
				dept.focus();
			}else if ($.trim(salary.val()) == ""){
				msg = "工资不能为空！";
				salary.focus();
			}else if ($.trim(email.val()) == ""){
				msg = "邮箱不能为空！";
				email.focus();
			}else if (!/^\w+@\w{2,3}\.\w{2,6}$/.test($.trim(email.val()))){
				//至少1个以上的数字或字母   @   2到3个数字或字母   .
				msg = "邮箱格式不正确！";
				email.focus();
			}else if ($.trim(phone.val()) == ""){
				msg = "手机号不能为空！";
				phone.focus();
			}else if (!/^1[3|5|8]\d{9}$/.test($.trim(phone.val()))){
				msg = "手机号码格式不正确！";
				phone.focus();
			}
			if (msg != ""){
				NProgress.done();
				$.ligerDialog.error(msg);
				return ;
			}
			
			/*新增员工*/
			$.post("${ctx}/employee/addEmployee", $("#employeeForm").serialize(),function(data){
				NProgress.done();
				if (data.status == 200) {
					$.ligerDialog.alert("添加成功！");
				}else{
					$.ligerDialog.error(data.msg);
				}
			})
		})
		
		/*动态根据部门显示职位*/
		$('#depts').change(function(e){
			var params = {"deptId":$(this).val()};
			 $.post("/job/findJobsByDept", params, function(_data){
				 if(_data.status != 200){
					 $.ligerDialog.error(_data.msg);
				 }else{
					 jobList=_data.data;
			 			var option="";
			 			//清除上次可选择的内容 并重新添加
			 			$("#jobs").empty();
			 			for(var i=0;i<jobList.length;i++){
			 				option='<option value='+jobList[i].id+'>'+jobList[i].name+'</option>';
			 				$("#jobs").append(option);
			 			}
				 }
	 		});
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
				<i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：员工管理&gt; 添加员工
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
									<tr>
										<td class="font3 fftd">姓&nbsp;名：
											<input type="text" name="username" id="username" size="20" />
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">性&nbsp;别：
											<input name="gender" type="radio" checked="checked" value="男"/>男
											<input name="gender" type="radio" value="女"/>女
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">身&nbsp;份：
											<select name="roleId" id="roles">
      										<optgroup label="请选择角色等级">
      										<option value="0">请选择角色等级</option>
      										<c:forEach items="${roleList}" var="role">
      											<option value="${role.roleId}">${role.roleName}</option>
      										</c:forEach>
      										</optgroup>
      									</select>
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">部&nbsp;门：
										<select name="deptId" id="depts">
      										<optgroup label="请选择部门">
      										<option value="0">请选择部门</option>
      										<c:forEach items="${deptList}" var="dept">
      											<option value="${dept.id}">${dept.deptName}</option>
      										</c:forEach>
      										</optgroup>
      									</select>
      									</td>
									</tr>
									<tr>
										<td class="font3 fftd">职&nbsp;位：
										<select name="jobId">
      										<optgroup label="请选择职位" id="jobs">
      										
      										</optgroup>
      									</select>
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">工&nbsp;资：
											<input type="text" name="salary" id="salary" size="20" />
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">邮&nbsp;箱：
											<input type="text" name="email" id="email" size="20" />
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">手机号：
											<input type="text" name="phone" id="phone" size="20" />
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
								<input type="button" id="addEmployeeButton" value="添加" class="layui-btn layui-btn-xs">&nbsp;&nbsp;
								<input type="reset" value="重置 " class="layui-btn layui-btn-xs">
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