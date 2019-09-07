<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统 ——收件箱</title>
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
		//var boxs = $("input[type='checkbox'][id^='box_']");
		
		/** 给全选按钮绑定点击事件  */
		/*$("#checkAll").click(function() {
			// this是checkAll  this.checked是true
			// 所有数据行的选中状态与全选的状态一致
			boxs.attr("checked", this.checked);
		})*/
		
		/** 给数据行绑定鼠标覆盖以及鼠标移开事件  */
		$("tr[id^='data_']").hover(function() {
			$(this).css("backgroundColor", "#eeccff");
		}, function() {
			$(this).css("backgroundColor", "#ffffff");
		})
		
		
		/** 给预览绑定点击事件 */
		$("a[id^='prev_'").click(function(){
			var mailId = this.id.replace('prev_','');
			$.ligerDialog.open({ 
				title:'预览邮件',
				height: 500, 
				url: '${ctx}/mail/previewMail?id='+mailId, 
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
			  <i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：邮件管理
				&gt; 收件箱
			</td>
			<td width="15" height="32"><img src="${ctx}/images/main_locright.gif" width="15" height="32"></td>
		</tr>
	</table>

	<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="main_tabbor">
		<!-- 查询区  -->
		<%-- <tr valign="top">
			<td height="30">
				<table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
					<tr>
						<td class="fftd">
							<form method="post"  action="${ctx}/mail/${pageInfo.pageNum}/findMailByCon.action">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td class="font3">
										发件人：<select name="receiverId">
												<optgroup label="请选择发件人">
													<option value="0">请选择发件人</option>
													<c:forEach items="${empList}" var="emp">
														<option value="${emp.id}">${emp.username}</option>
													</c:forEach>
												</optgroup>
										</select>
										<td class="font3">
											邮件内容:<input type="text" id="descs" name="descs">
										<input type="submit" value="搜索" class="layui-btn layui-btn-xs" />
										<input id="delete" type="button" value="删除" class="layui-btn layui-btn-xs layui-btn-danger" />
										</td>
									</tr>
								</table>
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr> --%>
		
		<!-- 数据展示区 -->
		<tr valign="top">
			<td height="20">
				<table width="100%" border="1" cellpadding="5" cellspacing="0" class="layui-table" style="border: #c2c6cc 1px solid; border-collapse: collapse;">
					<tr class="main_trbg_tit" align="center">
						<!-- <td><input type="checkbox" name="checkAll" id="checkAll"></td> -->
						<td>发件人</td>
						<td>邮件内容</td>
						<td>收件时间</td>
						<td align="center" colspan="2">操作</td>
					</tr>
					<c:forEach items="${pageInfo.list}" var="mail" varStatus="stat">
						<tr id="data_${stat.index}" align="center" class="main_trbg">
							<%-- <td><input type="checkbox" id="box_${stat.index}" value="${mail.id}"></td> --%>
							<c:forEach items="${empList}" var="emp">
								<c:choose>
									<c:when test="${mail.senderId==emp.id}">
										<td>${emp.username}</td>
									</c:when>
								</c:choose>
							</c:forEach>
							<td>${mail.descs}</td>
							<td><f:formatDate value="${mail.times}" type="date" dateStyle="long" />
							</td>
							<td align="center" width="40px;">
								<a href="#" id="prev_${mail.id }"> 
									<i class="layui-icon layui-icon-camera" style="font-size: inherit;color:#FF5722;">预览</i>
								</a>
							</td>
							<td align="center" width="40px;">
								<a href="/mail/gotoAddMail?receiverId=${mail.senderId}"> 
									<i class="layui-icon layui-icon-dialogue" style="font-size: inherit;color:#FF5722;">回复</i>
								</a>	
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>

		<!-- 分页按钮 -->
		<tr>
			<th colspan="100" class="pager">共${pageInfo.total}条记录 每页 5 条
				第${pageInfo.pageNum}页 <a href="/mail/showReceiveMail/1.action?userId=${sessionScope.USERS_SESSION.id}">首页</a>
				<c:choose>
					<c:when test="${pageInfo.hasPreviousPage}">
						<a href="/mail/showReceiveMail/${pageInfo.prePage}.action?userId=${sessionScope.USERS_SESSION.id}">上一页</a>
					</c:when>
					<c:otherwise>
						<font color="#ABA8AB">上一页</font>
					</c:otherwise>
				</c:choose> <c:choose>
					<c:when test="${pageInfo.hasNextPage}">
						<a href="/mail/showReceiveMail/${pageInfo.nextPage}.action?userId=${sessionScope.USERS_SESSION.id}">下一页</a>
					</c:when>
					<c:otherwise>
						<font color="#ABA8AB">下一页</font>
					</c:otherwise>
				</c:choose> <a href="/mail/showReceiveMail/${pageInfo.lastPage}.action?userId=${sessionScope.USERS_SESSION.id}">尾页</a>
			</th>
		</tr>
	</table>
</body>
</html>