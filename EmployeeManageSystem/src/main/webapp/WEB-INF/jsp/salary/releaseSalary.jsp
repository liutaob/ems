<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>员工信息管理系统——发放工资</title>
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
		$("#addSalaryButton").click(function(){
			
			var empId = $("#empId");
			var money = $("#money");
			var status = $("#status");
			var msg = "";
			if ($.trim(money.val()) == ""){
				msg = "工资不能为空！";
				money.focus();
			}else if ($.trim(empId.val()) == ""){
				msg = "员工不能为空！";
				empId.focus();
			}else if(status.val()=="0"){
				msg = "请先选择是否发放！";
				status.focus();
			}
			if (msg != ""){
				$.ligerDialog.error(msg);
				return ;
			}
			
			/*创建工资单*/
			$.post("${ctx}/salary/addSalary", $("#salaryForm").serialize(),function(data){
				if (data.status == 200) {
					$.ligerDialog.alert("发放成功！");
				}else{
					$.ligerDialog.error(data.msg);
				}
			})
		})
		
		/*验证员工*/
		 $("#yzEmployee").click(function(){
			 var empName=$("#empId").val();
			 if($.trim(empName) == ""){
				 $.ligerDialog.error("请输入员工姓名");
				 return ;
			 }
			 var param={"empId":empName};
			$.ajax({
				type:"post",
				url:"/employee/yz",
				contentType:"application/x-www-form-urlencoded",
				data:param,
				dataType:"json",
				success:function(data){
					if (data.status == 200) {
						$.ligerDialog.alert("验证成功！");
						$("#empId").val(data.data.id);//回填ID，因为添加工资表单对象直接隐射，如果回填名字则比较复杂
						$("#money").val(data.data.salary);
					}else{
						$.ligerDialog.error(data.msg);
						$("#empId").val("");
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
				<i class="layui-icon layui-icon-location" style="font-size: inherit;"></i>当前位置：工资管理&gt; 发放工资
			</td>
			<td width="15" height="32">
				<img src="${ctx}/images/main_locright.gif" width="15" height="32">
			</td>
		</tr>
	</table>
	<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="layui-table">
		<tr valign="top">
			<td>
				<form id="salaryForm" method="post" onsubmit="">
					<table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
						<tr>
								<td class="font3 fftd">
									<table>
									<tr>
										<td class="font3 fftd">
										员工姓名：
											<input type="text" name="empId" id="empId" size="20" />
											<input type="button" id="yzEmployee" value="验证" class="layui-btn layui-btn-xs layui-btn-danger">&nbsp;&nbsp;
										</td>
									</tr>
								</table>
								</td>
							</tr>
						<tr>
						<tr>
							<td class="font3 fftd">
								<table>
									<tr>
										<td class="font3 fftd">
										他的工资:<input type="text" name="money" id="money" placeholder="工资金额（￥）" readonly="readonly">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td class="font3 fftd">
								<table>
									<tr>
										<td class="font3 fftd">
										是否立即发放:
										<select name="status" id="status">
											<optgroup label="是否立即发放">
      										<option value="0">是否立即发放</option>
   											<option value="1">是</option>
   											<option value="2">否</option>
      										</optgroup>
      									</select>
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
								<input type="button" id="addSalaryButton" value="确定" class="layui-btn layui-btn-xs">&nbsp;&nbsp;
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