<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
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
    <script type="text/javascript" src="<%=path%>/js/jquery-3.3.1.js"></script>
    <script>
        let b1 = true;
        let first = 0;
        function frmSubmit(url) {
            let np1 = $('#newPwd1');
            if(np1.val()!==""){
                if(b1){
                    document.frm.action = url;// product.do?action=query
                    document.frm.submit();
                }
            }else{
                $('#err1').css({"display":"block"});
            }
        }
        const err1 = "260";
        $(function () {
            if (err1==='<%=err %>'){
                let x = document.getElementById("err");
                x.style.display = "block";
            }
            let np = $('#newPwd');
            let np1 = $('#newPwd1');
            np.on("blur",function () {
                if(first===0){
                    first++;
                }else{
                    if(np.val()!==np1.val()){   //错误提示
                        $('#err1').css({"display":"block"});
                        b1 = false;
                    }
                }
            });
            np1.on("blur",function () {
                if(np.val()!==np1.val()){   //错误提示
                    $('#err1').css({"display":"block"});
                    b1 = false;
                }
            });
            function raster(){
                $('#err').css({"display":"none"});
                $('#err1').css({"display":"none"});
                b1=true;
            }
            np.on("focus",raster);
            np1.on("focus",raster);
        })

    </script>
    <title>修改密码</title>
</head>
<body>
<form action="" method="post" name="frm" id="frm">
    <p id="choose_title">Please Select Service</p>
    <div id="left_frame">
        <br/>
        <input type="button" name="" value="隐藏" class="not_display">
        <br/>
        <input type="button" name="" value="隐藏" class="not_display">
        <br/>
        <input type="button" name="" value="隐藏" class="not_display">
        <br/>
        <input type="button" name="" value="取消" style="color:red;" onclick="changeFrame('<%=path%>/index.jsp');">
    </div>
    <div id="center_frame">
        <div id="input_amount">
            原始密码：<input type="password" name="pwd" value=""><br>
            新的密码：<input type="password" id="newPwd" name="newPwd" value=""><br>
            确认密码：<input type="password" id="newPwd1" name="newPwd1" value="">
        </div>
    </div>
    <div id="right_frame">
        <br/>
        <input type="button" name="" value="隐藏" class="not_display">
        <br/>
        <input type="button" name="" value="隐藏" class="not_display">
        <br/>
        <input type="button" name="" value="更正" style="color:red;">
        <br/>
        <input type="button" name="" value="确认" style="color:green;"
               onclick="frmSubmit('<%=path%>/core.do?action=updatePwd');">
    </div>
</form>
<div style="text-align:center"><p id="err" style="display:none;color:red">密码错误！</p></div>
<div style="text-align:center"><p id="err1" style="display:none;color:red">两次输入的密码不一致。</p></div>
</body>
</html>