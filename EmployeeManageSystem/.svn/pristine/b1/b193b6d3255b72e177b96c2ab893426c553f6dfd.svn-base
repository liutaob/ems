<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统 ——公告管理</title>
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
		/** 获取选中的数据 */
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
		
		
		/** 删除公告绑定点击事件 */
		$("#delete").click(function() {
			/** 获取到用户选中的复选框  */
			var checkedBoxs = boxs.filter(":checked");
			if (checkedBoxs.length < 1) {
				$.ligerDialog.error("请至少选择一个要删除的记录！");
			} else {
				/** 得到用户选中的所有的需要删除的ids */
				var ids = checkedBoxs.map(function() {
					return this.value;
				})
				$.ligerDialog
					.confirm(
						"确认要删除吗?",
						"删除记录",
						function(r) {
							if (r) {
								alert("删除："+ids.get());
								// 发送请求
								window.location = "${ctx }/notice/deleteNotice?ids="
										+ ids.get()+"&currentPage="+${pageInfo.pageNum};
							}
						});
			}
		})
		
		/** 给预览绑定点击事件 */
		$("a[id^='prev_'").click(function(){
			var noticeId = this.id.replace('prev_','');
			$.ligerDialog.open({ 
				title:'预览公告',
				height: 500, 
				url: '${ctx}/notice/previewNotice?id='+noticeId, 
				width: 750, 
				showMax: true, 
				showToggle: true, 
				showMin: true, 
				isResize: true, 
				slide: false 
				});
		})
	});
	
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
			  <i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：公告管理
				&gt; 公告查询
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
							<form method="post"  action="${ctx}/notice/${pageInfo.pageNum}/findNoticeByCon.action">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td class="font3">
										公告标题：<input type="text" name="noticeTitle" id="noticeTitle">
										<td class="font3">
										<c:choose>
											<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
												范围：<select name="deptId">
												<optgroup label="请选择部门">
													<option value="0">全体部门</option>
													<c:forEach items="${deptList}" var="dept">
														<option value="${dept.id}">${dept.deptName}</option>
													</c:forEach>
												</optgroup>
												</select>
											</c:when>
										</c:choose>
										<input type="submit" value="搜索" class="layui-btn layui-btn-xs" />
										<c:choose>
											<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
												<input id="delete" type="button" value="删除" class="layui-btn layui-btn-xs layui-btn-danger" />
											</c:when>
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
						</c:choose>
						<td>公告标题</td>
						<td>公告内容</td>
						<td>发布范围</td>
						<td>发布人</td>
						<td>发布时间</td>
						<td>预览</td>
					</tr>
					<c:forEach items="${pageInfo.list}" var="notice" varStatus="stat">
						<tr id="data_${stat.index}" align="center" class="main_trbg">
							<c:choose>
								<c:when test="${sessionScope.USERS_SESSION.roleId<3}">
									<td><input type="checkbox" id="box_${stat.index}" value="${notice.id}"></td>
								</c:when>
							</c:choose>
							<td>${notice.noticeTitle}</td>
							<td>${notice.content}</td>
							<c:if test="${notice.deptId==0}">
								<td>全体人员</td>
							</c:if>
							<c:forEach items="${deptList }" var="dept">
								<c:choose>
									<c:when test="${dept.id==notice.deptId}">
										<td>${dept.deptName}</td>
									</c:when>
								</c:choose>
							</c:forEach>
							<c:forEach items="${empList}" var="emp">
								<c:choose>
									<c:when test="${notice.empId==emp.id}">
										<td>${emp.username}</td>
									</c:when>
								</c:choose>
							</c:forEach>
							<td><f:formatDate value="${notice.created}" type="date"
									dateStyle="long" />
							</td>
							<td align="center" width="40px;">
								<a href="#" id="prev_${notice.id }"> 
									<i class="layui-icon layui-icon-camera" style="font-size: inherit;color:#FF5722;">预览</i>
								</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>

		<!-- 分页按钮 -->
		<tr>
			<th colspan="100" class="pager">共${pageInfo.total}条记录 每页5 条
				第${pageInfo.pageNum}页 <a href="/notice/showNotice/1.action">首页</a>
				<c:choose>
					<c:when test="${pageInfo.hasPreviousPage}">
						<a href="/notice/showNotice/${pageInfo.prePage}.action">上一页</a>
					</c:when>
					<c:otherwise>
						<font color="#ABA8AB">上一页</font>
					</c:otherwise>
				</c:choose> <c:choose>
					<c:when test="${pageInfo.hasNextPage}">
						<a href="/notice/showNotice/${pageInfo.nextPage}.action">下一页</a>
					</c:when>
					<c:otherwise>
						<font color="#ABA8AB">下一页</font>
					</c:otherwise>
				</c:choose> <a href="/notice/showNotice/${pageInfo.lastPage}.action">尾页</a>
			</th>
		</tr>
	</table>
</body>
</html>