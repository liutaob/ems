<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统——添加职位</title>
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
<link rel="stylesheet" type="text/css" href="${ctx}/css/layui/css/layui.css"/>
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
<script type="text/javascript">
	var jobList=[];
	$(function(){
		/*校验表单数据是否合理*/
		$("#addJobButton").click(function(){
			
			var name = $("#name");
			var remark = $("#remark");
			var depts=$("#depts");
			var msg = "";
			if ($.trim(name.val()) == ""){
				msg = "职位名不能为空！";
				name.focus();
			}else if ($.trim(remark.val()) == ""){
				msg = "职位描述不能为空！";
				remark.focus();
			}else if (remark.val().length >= 300){
				msg = "职位描述不能超过300字！";
				remark.focus();
			}else if(depts.val()=="0"){
				msg = "请先选择部门！";
				depts.focus();
			}
			if (msg != ""){
				$.ligerDialog.error(msg);
				return ;
			}
			/*新增职位*/
			$.post("${ctx}/job/addJob", $("#jobForm").serialize(),function(data){
				if (data.status == 200) {
					$.ligerDialog.alert("添加成功！");
				}else{
					$.ligerDialog.error(data.msg);
				}
			})
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
				<i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：部门管理&gt; 添加部门
			</td>
			<td width="15" height="32">
				<img src="${ctx}/images/main_locright.gif" width="15" height="32">
			</td>
		</tr>
	</table>
	<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="layui-table">
		<tr valign="top">
			<td>
				<form id="jobForm" method="post" onsubmit="">
					<table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
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
						<tr>
							<td class="font3 fftd">
								<table>
									<tr>
										<td class="font3 fftd">
										职位名称：
											<input type="text" name="name" id="name" size="20" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="font3 fftd">
								<table>
									<tr>
										<td class="font3 fftd">职位描述：
											<textarea rows="" cols="" name="remark" id="remark"></textarea>
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
								<input type="button" id="addJobButton" value="添加" class="layui-btn layui-btn-xs">&nbsp;&nbsp;
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