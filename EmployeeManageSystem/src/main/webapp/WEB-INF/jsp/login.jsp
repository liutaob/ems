<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=emulateIE7" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/loginstyle.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/login.css" />
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.select.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/css/nprogress.css" />
<script type="text/javascript" src="${ctx}/js/NProgress/nprogress.js"></script>
<title>企业员工信息管理系统</title>
</head>
<body>
<div id="container">
    <div id="bd">
    	<div id="main">
    	<form id="formLogin" method="post" onsubmit="return false;">
        	<div class="login-box">
                <div id="logo"></div>
                <h1></h1>
                <div class="input username" id="username">
                    <label for="username">用户名</label>
                    <c:choose>
					   <c:when test="${empty lastLoginName}">  
					   	<input type="text" name="username" placeholder="请输入用户名"/>
					   </c:when>
					   <c:otherwise> 
					   	<input type="text" name="username" placeholder="请输入用户名" value="${lastLoginName}"/>
					   </c:otherwise>
					</c:choose>
                    <span style="position: absolute;color: red;left:320px">${errorMsg}</span>
                </div>
                <div class="input psw" id="psw">
                    <label for="password">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
                    <c:choose>
                    	<c:when test="${empty lastLoginPwd }">
                    		<input type="password" name="password" placeholder="请输入密码" />
                    	</c:when>
                    	 <c:otherwise> 
					   	<input type="password" name="password" placeholder="请输入密码" value="${lastLoginPwd}"/>
					   </c:otherwise>
                    </c:choose>
                </div>
                <div class="input validate" name="oauthcode">
                    <label for="valiDate">验证码</label>
                    <input type="text" name="oauthcode" placeholder="请输入验证码" />
                    <div class="value">
                    <img name="jcaptcha" id="jcaptcha"
							onclick="refresh_jcaptcha(this)" src="/yzm" alt="点击刷新验证码"
							title="点击刷新验证码" style="cursor: pointer;" width="109" height="40">
						<script>
							function refresh_jcaptcha(obj) {
								obj.src = "/yzm?"+Math.random();
							}
						</script>
					</div>
                </div>
                <div id="btn" class="loginButton">
                    <input id="loginButton" class="button" value="登录" type="button" onkeydown="javascript:if(event.keyCode==13) alert('hllo')"/>
                </div>
            </div>
            </form>
        </div>
        <div id="ft">Copyright © 2019.江西理工大学 (刘涛)</div>
    </div>
   
</div>

</body>
<script type="text/javascript">
	var height = $(window).height() > 445 ? $(window).height() : 445;
	$("#container").height(height);
	var bdheight = ($(window).height() - $('#bd').height()) / 2 - 20;
	$('#bd').css('padding-top', bdheight);
	$(window).resize(function(e) {
        var height = $(window).height() > 445 ? $(window).height() : 445;
		$("#container").height(height);
		var bdheight = ($(window).height() - $('#bd').height()) / 2 - 20;
		$('#bd').css('padding-top', bdheight);
    });
	$('select').select();
	
	$(function(){
		$("#loginButton").click(function(){
			NProgress.start();
			$.post("/tologin", $("#formLogin").serialize(),function(data){
				NProgress.done();
				if (data.status == 200) {
					alert("登录成功");
					setTimeout(gotoMailPage(), 3000)
				}else{
					alert(data.msg);
					window.location.href="/?errorMsg="+encodeURI(encodeURI(data.msg));
				}
			})
		})
	//回车键
	$("#formLogin").bind("keypress",function(e){
        // 兼容FF和IE和Opera    
    var theEvent = e || window.event;    
    var code = theEvent.keyCode || theEvent.which || theEvent.charCode;    
    if (code == 13) {                  
        e.preventDefault();    
       //回车执行查询
      $("#loginButton").click(); 
    } 
});

		
		
		function gotoMailPage(){
			window.location.href="/main";
		}
	})
	
</script>

</html>
