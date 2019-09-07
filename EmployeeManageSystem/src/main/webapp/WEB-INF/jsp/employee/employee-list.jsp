<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统 ——员工管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="${ctx}/css/test1.css" rel="stylesheet" type="text/css">
<script src="${ctx}/js/jquery-1.4.1.js"></script>
<script src="${ctx}/js/common.js" charset="utf-8"></script>
<script src="${ctx}/js/changetrcolor.js" type="text/javascript"></script>
<link href="${ctx}/css/css.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/ligerUI/skins/Aqua/css/ligerui-dialog.css" />
<link href="${ctx}/js/ligerUI/skins/ligerui-icons.css" rel="stylesheet"
	type="text/css" />
<!-- 导入layui -->
<link rel="stylesheet" type="text/css"
	href="${ctx}/css/layui/css/layui.css">
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
	$(function() {
		
		/** 获取选中的员工数据 */
		var boxs = $("input[type='checkbox'][id^='box_']");
		
		/** 给全选按钮绑定点击事件  */
		$("#checkAll").click(function() {
			// this是checkAll  this.checked是true
			// 所有数据行的选中状态与全选的状态一致
			boxs.attr("checked", this.checked);
		})
		
		/** 给数据行绑定鼠标覆盖以及鼠标移开事件  */
		$("tr[id^='data_']").hover(function() {
			$(this).css("backgroundColor", "#eeccff");
		}, function() {
			$(this).css("backgroundColor", "#ffffff");
		})

		/** 删除员工绑定点击事件 */
		$("#delete")
				.click(
						function() {
							/** 获取到用户选中的复选框  */
							var checkedBoxs = boxs.filter(":checked");
							if (checkedBoxs.length < 1) {
								$.ligerDialog.error("请选择一个需要删除的员工！");
							} else {
								/** 得到用户选中的所有的需要删除的ids */
								var ids = checkedBoxs.map(function() {
									return this.value;
								})

								$.ligerDialog
										.confirm(
											"确认要删除吗?",
											"删除员工",
											function(r) {
												if (r) {
													alert("删除："+ids.get());
													// 发送请求
													window.location = "${ctx }/employee/deleteEmployee?ids="
															+ ids.get()+"&currentPage="+${pageInfo.pageNum};
												}
											});
							}
						})
	})
</script>
</head>
<body>
	<!-- 导航 -->
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="10"></td>
		</tr>
		<tr>
			<td width="15" height="32">
			  <img src="${ctx}/images/main_locleft.gif" width="15" height="32">
			</td>
			<td class="main_locbg font2">
			  <i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：员工管理
				&gt; 员工查询
			</td>
			<td width="15" height="32"><img src="${ctx}/images/main_locright.gif" width="15" height="32"></td>
		</tr>
	</table>

	<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="main_tabbor">
		<!-- 查询区  -->
		<tr valign="top">
			<td height="30">
				<table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
					<tr>
						<td class="fftd">
							<form name="empform" method="post" id="empform" action="${ctx}/employee/${pageInfo.pageNum}/findEmployeeByCon.action">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td class="font3">
										姓名：<input type="text" name="username">
										</td>
										<td class="font3">
										部门：<select name="empDept">
												<optgroup label="请选择部门">
													<option value="0">请选择部门</option>
													<c:forEach items="${deptList}" var="dept">
														<option value="${dept.id}">${dept.deptName}</option>
													</c:forEach>
												</optgroup>
										</select>
										</td>
										<td class="font3">
										职位：<select name="empJob" style="width: 143px;">
												<optgroup label="请选择职位">
													<option value="0">请选择职位</option>
													<c:forEach items="${jobList}" var="job">
														<option value="${job.id}">${job.name}</option>
													</c:forEach>
												</optgroup>
										</select>
										</td>
										<td>
										性别：<select name="gender" id="gender">
												<optgroup label="请选择性别">
													<option value="0">请选择性别</option>
													<option value="男">男</option>
													<option value="女">女</option>
												</optgroup>
										</select> &nbsp; 
										<input type="submit" value="搜索" class="layui-btn layui-btn-xs" />
										<c:choose>
											<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
												<input id="delete" type="button" value="删除" class="layui-btn layui-btn-xs layui-btn-danger" />
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
										</td>
									</tr>
								</table>
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<!-- 数据展示区 -->
		<tr valign="top">
			<td height="20">
				<table width="100%" border="1" cellpadding="5" cellspacing="0" class="layui-table" style="border: #c2c6cc 1px solid; border-collapse: collapse;">
					<tr class="main_trbg_tit" align="center">
						<c:choose>
							<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
								<td><input type="checkbox" name="checkAll" id="checkAll"></td>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
						<td>员工姓名</td>
						<td>性别</td>
						<td>部门</td>
						<td>职位</td>
						<td>工资</td>
						<td>邮箱</td>
						<td>手机号</td>
						<td align="center">操作</td>
					</tr>
					<c:forEach items="${pageInfo.list}" var="employee" varStatus="stat">
						<tr id="data_${stat.index}" align="center" class="main_trbg">
							<c:choose>
								<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
									<td><input type="checkbox" id="box_${stat.index}" value="${employee.id}"></td>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							<td>${employee.username }</td>
							<td>${employee.gender }</td>
							<c:forEach items="${deptList }" var="dept">
								<c:choose>
									<c:when test="${employee.deptId==dept.id}">
										<td>${dept.deptName}</td>
									</c:when>
								</c:choose>
							</c:forEach>
							<!-- 这种方式记得新增职位必须是最后一个id加1  上面的方式可解决-->
							<c:forEach items="${jobList }" var="job">
								<c:choose>
									<c:when test="${employee.jobId==job.id}">
										<td>${job.name}</td>
									</c:when>
								</c:choose>
							</c:forEach>
							<td>${employee.salary }</td>
							<td>${employee.email }</td>
							<td>${employee.phone }</td>
							
							<td align="center" width="40px;">
								<c:choose>
								<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
									<a href="/employee/showUpdateEmployee?id=${employee.id}&pageNum=${pageInfo.pageNum}">
										<img title="修改" src="${ctx}/images/update.gif" />
									</a>
								</c:when>
								</c:choose>
									<a href="/mail/gotoAddMail?receiverId=${employee.id}" title="发送邮件">
										<i class="layui-icon layui-icon-dialogue" style="font-size: inherit;color:#FF5722;">
										</i>
									</a>
								</td>
							
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>

		<!-- 分页按钮 -->
		<tr>
			<th colspan="100" class="pager">共${pageInfo.total}条记录 每页 10 条
				第${pageInfo.pageNum}页 <a href="/employee/showEmployee/1.action">首页</a>
				<c:choose>
					<c:when test="${pageInfo.hasPreviousPage}">
						<a href="/employee/showEmployee/${pageInfo.prePage}.action">上一页</a>
					</c:when>
					<c:otherwise>
						<font color="#ABA8AB">上一页</font>
					</c:otherwise>
				</c:choose> <c:choose>
					<c:when test="${pageInfo.hasNextPage}">
						<a href="/employee/showEmployee/${pageInfo.nextPage}.action">下一页</a>
					</c:when>
					<c:otherwise>
						<font color="#ABA8AB">下一页</font>
					</c:otherwise>
				</c:choose> <a href="/employee/showEmployee/${pageInfo.lastPage}.action">尾页</a>
			</th>
		</tr>
	</table>
</body>
</html>