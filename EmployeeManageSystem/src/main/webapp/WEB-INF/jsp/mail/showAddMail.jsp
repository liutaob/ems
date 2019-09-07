<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>企业员工信息管理系统 ——发送邮件</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<!-- 导入layui -->
<link rel="stylesheet" type="text/css" href="${ctx}/css/layui/css/layui.css">
<script type="text/javascript" src="${ctx}/css/layui/layui.js"></script>
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
<script src="${ctx}/js/ligerUI/js/plugins/ligerResizable.js"
	type="text/javascript"></script>
<link href="${ctx}/css/pager.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/nprogress.css" />
<script type="text/javascript" src="${ctx}/js/NProgress/nprogress.js"></script>
<script type="text/javascript">
 $(function(){
		 /*点击取消按钮*/
		$("#cancel").click(function(){
			history.back();
		})
	 	
		/*点击发送按钮*/
       $("#sendButton").click(function(){
    	   NProgress.start();
       	var desc =$("#descs").val();
       	if($.trim(desc) == ""){
       		NProgress.done();
       		$.ligerDialog.error("邮件内容不能为空");
       		return ;
       	}
       	$.post("${ctx}/mail/addMail", $("#mailForm").serialize(),function(data){
       		NProgress.done();
			if (data.status == 200) {
				$.ligerDialog.alert("发送成功！");
				$(descs).val("");
			}else{
				$.ligerDialog.error(data.msg);
			}
		})
       })
   });
</script>
</head>
<body>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td height="10"></td>
		</tr>
		<tr>
			<td width="15" height="32"><img
				src="${ctx }/images/main_locleft.gif" width="15" height="32"></td>
			<td class="main_locbg font2"><i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：邮件管理
				&gt; 发送邮件</td>
			<td width="15" height="32"><img
				src="${ctx }/images/main_locright.gif" width="15" height="32"></td>
		</tr>
	</table>

	<table width="100%" height="90%" border="0" cellpadding="10"
		cellspacing="0" class="layui-table">
		<tr valign="top">
			<td>
				<form id="mailForm" name="mailForm">
					<input type="hidden" name="receiverId" id="receiverId" value="${receiverId}">
					<table width="100%" border="0" cellpadding="0" cellspacing="10"
						class="main_tab">
						<tr>
							<td class="font3 fftd">
							邮件内容：<br/>
							<textarea name="descs" cols="88" rows="11" id="descs"></textarea>
							</td>
						</tr>
						<tr>
							<td class="main_tdbor"></td>
						</tr>
						<tr>
							<td class="font3 fftd">
							<input type="button" id="sendButton" value="发送" class="layui-btn layui-btn-xs">
							<input type="button" id="cancel" value="返回" class="layui-btn layui-btn-xs"></td>
						</tr>
						<tr>
							<td class="main_tdbor"></td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
	</table>
	<div style="height: 10px;"></div>
</body>
</html>