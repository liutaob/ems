<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统 ——职位管理</title>
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
		/** 给数据行绑定鼠标覆盖以及鼠标移开事件  */
		$("tr[id^='data_']").hover(function() {
			$(this).css("backgroundColor", "#eeccff");
		}, function() {
			$(this).css("backgroundColor", "#ffffff");
		})
	});
	
	/*
	根据职位id删除职位
	*/
	function deleteJob(jobId){
		var currentPage=${pageInfo.pageNum };
		var param={"jobId":jobId,"currentPage":currentPage};
		$.ligerDialog.confirm("确认要删除吗?","删除部门",
			function(r) {
				if (r) {
					$.ajax({
						type:"post",
						url:"/job/deleteJob",
						contentType:"application/x-www-form-urlencoded",
						data:param,
						dataType:"json",
						success:function(data){
							if (data.status == 200) {
								$.ligerDialog.alert("删除成功！");
								window.location.href="${ctx}/job/showJob/"+currentPage;
							}else{
								$.ligerDialog.alert(data.msg);
							}
						}
					});
				}
			});
	}
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
			  <i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：职位管理
				&gt; 职位查询
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
							<form name="jobForm" method="post" id="jobForm" action="${ctx}/job/${pageInfo.pageNum}/findJobByCon.action">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td class="font3">
										职位名称：<input type="text" name="name" id="name">
										部门：<select name="deptId">
												<optgroup label="请选择部门">
													<option value="0">请选择部门</option>
													<c:forEach items="${deptList}" var="dept">
														<option value="${dept.id}">${dept.deptName}</option>
													</c:forEach>
												</optgroup>
										</select>
										<input type="submit" value="搜索" class="layui-btn layui-btn-xs" />
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
						<td>职位名称</td>
						<td>所属部门</td>
						<td>职位描述</td>
						<c:choose>
							<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
								<td align="center" colspan="2">操作</td>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</tr>
					<c:forEach items="${pageInfo.list}" var="job" varStatus="stat">
						<tr id="data_${stat.index}" align="center" class="main_trbg">
							<td>${job.name}</td>
							<c:forEach items="${deptList }" var="dept">
								<c:choose>
									<c:when test="${dept.id==job.deptId}">
										<td>${dept.deptName}</td>
									</c:when>
								</c:choose>
							</c:forEach>
							<td>${job.remark}</td>
							<c:choose>
							<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
							<td align="center" width="40px;">
									<a href="/job/showUpdateJob?id=${job.id}&pageNum=${pageInfo.pageNum}">
									<img title="修改" src="${ctx}/images/update.gif" />
									</a>
								</td>
								<td align="center" width="40px;">
									<a onclick="deleteJob(${job.id})" style="font-size: inherit;color:#FF5722;cursor: pointer;">
									<img title="删除" src="${ctx}/images/delete.gif" />
									</a>
								</td>
							</c:when>
							<c:otherwise>
							</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>

		<!-- 分页按钮 -->
		<tr>
			<th colspan="100" class="pager">共${pageInfo.total}条记录 每页 10 条
				第${pageInfo.pageNum}页 <a href="/job/showJob/1.action">首页</a>
				<c:choose>
					<c:when test="${pageInfo.hasPreviousPage}">
						<a href="/job/showJob/${pageInfo.prePage}.action">上一页</a>
					</c:when>
					<c:otherwise>
						<font color="#ABA8AB">上一页</font>
					</c:otherwise>
				</c:choose> <c:choose>
					<c:when test="${pageInfo.hasNextPage}">
						<a href="/job/showJob/${pageInfo.nextPage}.action">下一页</a>
					</c:when>
					<c:otherwise>
						<font color="#ABA8AB">下一页</font>
					</c:otherwise>
				</c:choose> <a href="/job/showJob/${pageInfo.lastPage}.action">尾页</a>
			</th>
		</tr>
	</table>
</body>
</html>