<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<title>存款</title>
<script type="text/javascript">
	function frmSubmit(url) {
		document.frm.action = url;// product.do?action=query
		document.frm.submit();
	}
</script>
</head>
<body>
	<form name="frm" id="frm" action="" method="post">
		<p id="choose_title">Please Select Service</p>
		<div id="left_frame">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
			<br /> <input type="button" name='' value='取消'
				onclick="changeFrame('<%=path %>/view/index.jsp')">
		</div>
		<div id="center_frame">
			<div id="input_amount">
				请输入您的存款金额<br /> <input type="text" name="amount" value="">
			</div>
		</div>
		<div id="right_frame">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
			<br /> <input type="button" name="" value="隐藏" id="not_display">
			<br /> <input type="button" name="" value="更正" style="color: red;">
			<br /> <input type="button" name="" value="确认" style="color: green;"
				onclick="frmSubmit('<%=path%>/confirm.jsp');">
		</div>
	</form>
</body>
</html>