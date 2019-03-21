<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="model.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String err = (String) request.getAttribute("err");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=path %>/css/styles.css">
<script type="text/javascript" src="<%=path %>/js/js.js"></script>
<title>登录用户</title>
<script type="text/javascript">
	function frmSubmit(url) {
		document.frm.action = url;// product.do?action=query
		document.frm.submit();
	}
	window.onload=function(){ 
		if(<%=err %>=='101'){
			x = document.getElementById("err");
			x.style.display = "block";
		}
    }
</script>
</head>
<body>
	<form name="frm" id="frm" action="" method="post">
		<p id="choose_title">Please Login in</p>
		<div id="left_frame">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
		</div>
		<div id="center_frame">
			<div id="input_amount">
				账号：<input type="text" id="account_input" name="accountid" value="" /><br />
				密码：<input type="password" name="pwd" value="" />
			</div>
		</div>
		<div id="right_frame">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
			<br /> <input type="button" name='' value='确认' style="color: green;"
				onclick="frmSubmit('<%=path%>/core.do?action=login')">
		</div>
	</form>
	<div style="text-align:center"><p id="err" style="display:none;color:red">用户名或密码错误，请重新登录。</p></div>
</body>
</html>