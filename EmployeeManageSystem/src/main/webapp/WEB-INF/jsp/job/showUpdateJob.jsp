<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统——修改部门</title>
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
		
    	/** 职位表单提交 */
		$("#updateJobButton").click(function(){
			var r=confirm("确认要修改吗?");
				if (r) {
					var name = $("#name");
					var remark = $("#remark");
					var msg = "";
					if ($.trim(name.val()) == ""){
						msg = "职位名称不能为空！";
						name.focus();
					}else if($.trim(remark.val()) == ""){
						msg = "职位描述不能为空！";
						remark.focus();
					}
					
					if (msg != ""){
						$.ligerDialog.error(msg);
						return;
					}
					
					$.post("${ctx}/job/updateJob", $("#jobForm").serialize(),function(data){
						if (data.status == 200) {
							$.ligerDialog.alert("修改成功！");
							window.location ="${ctx}/job/showJob/${pageNum}";
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
				<img src="${ctx}/images/pointer.gif">&nbsp;&nbsp;&nbsp;当前位置：职位管理&gt; 修改职位
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
				<form action="${ctx}/job/updateJob" id="jobForm" method="post">
					<input type="hidden" name="id" value="${job.id}">
					<table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
						<tr>
							<td class="font3 fftd">
								<table>
									<tr>
										<td class="font3 fftd">
										职位名称：<input type="text" name="name" id="name" size="20" value="${job.name }" />
										</td>
									</tr>
									<tr>
										<td class="font3 fftd">
										所属部门： 
										<select name="deptId" style="width: 100px;">
												<c:forEach items="${deptList }" var="dept">
													<c:choose>
														<c:when test="${job.deptId==dept.id}">
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
										职位描述：<input name="remark" id="remark"  value="${job.remark }" />
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
								<input type="button" id="updateJobButton" value="修改">&nbsp;&nbsp;
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