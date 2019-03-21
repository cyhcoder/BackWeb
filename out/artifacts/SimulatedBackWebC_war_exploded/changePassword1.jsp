<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/styles.css">
<script type="text/javascript" src="<%=path%>/js/js.js"></script>
<script>
function frmSubmit(url) {
	document.frm.action = url;// product.do?action=query
	document.frm.submit();
}
window.onload=function(){
	if(<%=err %>=='260'){
		x = document.getElementById("err");
		x.style.display = "block";
	}
}
</script>
<title>修改密码</title>
</head>
<body>
<form action="" method="post" name="frm" id="frm">
<p id="choose_title">Please Select Service</p>
	<div id="left_frame">
		<br /> 
				<input type="button" name="" value="隐藏" id="not_display"> 
		<br />
				<input type="button" name="" value="隐藏" id="not_display"> 
		<br /> 
				<input type="button" name="" value="隐藏" id="not_display"> 
		<br /> 
		<input type="button" name="" value="取消" style="color:red;" onclick="changeFrame('<%=path%>/view/index.jsp');">
	</div>
	<div id="center_frame">	       
        <div id="input_amount">
			原始密码：<input type="password"  name="pwd" value=""><br>
			新的密码：<input type="password"  name="newPwd" value=""><br>
			确认密码：<input type="password"  name="newPwd1" value="">
        </div>
	</div>
	<div id="right_frame">
		<br /> 
				<input type="button" name="" value="隐藏" id="not_display"> 
		<br />
				<input type="button" name="" value="隐藏" id="not_display"> 
		<br />
		<input type="button" name="" value="更正" style="color:red;"> 
		<br />
		<input type="button" name="" value="确认" style="color:green;" onclick="frmSubmit('<%=path%>/core.do?action=updatePwd');">
	</div>
	</form>
	<div style="text-align:center"><p id="err" style="display:none;color:red">密码错误！</p></div>
</body>
</html>