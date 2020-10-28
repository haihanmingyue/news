<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.staticfile.org/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>Title</title>
</head>
<style>


    .addnewsDiv input{
        width: 100px;
    }
    .input-group{
        width: 300px;
        margin-top: 10px;
    }
    .form-group{
        margin-top: 10px;
    }
    .form-group{
        margin-top: 10px;
        margin-left: 620px;
    }
    .form-group input{
       margin-left: 20px;
    }
</style>
<body>
<div id="addnewsDiv" style="margin-left: 50px;margin-top: 20px">
<form  id="form1" onsubmit="return false" action="#" method="post">

    <div class="input-group">
        <span class="input-group-addon">分组</span>
        <select id="depart" class="form-control" required="required" >
            <option value="">请选择分类</option>
            <option value="国际">国际</option>
            <option value="民生">民生</option>
            <option value="娱乐">娱乐</option>
            <option value="体育">体育</option>
        </select>
    </div>

    <div class="input-group">
        <span class="input-group-addon">新闻标题</span>
        <input type="text" id="newsTitle" class="form-control" required="required" style="width: 500px">
    </div>


    <div class="input-group">
        <textarea id="editor_id" name="content"  class="form-input-textara" style="width:1200px;height:530px;">
						&lt;strong&gt;HTML内容&lt;/strong&gt;
					</textarea>
    </div>
    <div class="input-group">
        <span class="input-group-addon">发布人</span>
        <input type="text" id="userid" class="form-control" required="required" disabled="disabled" value="${user.account}">
    </div>


    <div class="input-group">
        <span class="input-group-addon">发布时间</span>
        <input type="text" id="nowDate" class="form-control" required="required" disabled="disabled" title="提交时自动填写发布时间">
    </div>


    <div class="form-group">
        <input type="reset"  class="btn btn-default" value="重  置" />
        <input type="submit" onclick="addNewsBtn()" class="btn btn-success" value="提  交" />
    </div>
</form>
</div>
</body>
<!--a.htm页调用load方法加载b.htm，b.htm里有js，那么应在a.htm里面导入该js，载入b.htm后操作该js就像在a.htm里操作一样。-->
<script charset="utf-8" src="kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>
<script>
    KindEditor.ready(function(K) {
        window.editor = K.create('#editor_id', {
            cssPath: 'kindeditor/plugins/code/prettify.css',
            allowFileManager: true, resizeType:0 });

    });

    function addNewsBtn() {
        var html = editor.html();
        if($("#depart").val()!="" && $("#newsTitle").val()!="" && html != "" ){
            var myDate = new Date;
            var year = myDate.getFullYear(); //获取当前年
            var mon = myDate.getMonth() + 1; //获取当前月
            if(parseInt(mon)<10){
                mon = "0"+mon;
            }
            var date = myDate.getDate(); //获取当前日
            var h = myDate.getHours();//获取当前小时数(0-23)
            var m = myDate.getMinutes();//获取当前分钟数(0-59)
            var s = myDate.getSeconds();//获取当前秒
            $("#nowDate").val(year+"-"+mon+"-"+date+" "+h+":"+m+":"+s);
            $.ajax({
                type: "POST",//方法类型
                dataType: "text",//预期服务器返回的数据类型
                url: "news/addnews" ,//url
                data: {"userid":$("#userid").val().trim(),"type":$("#depart").val().trim(),"title":$("#newsTitle").val().trim(),"html":html,"date":$("#nowDate").val()},
                success: function (result) {
                    if(result=="1"){
                        alert("成功");
                        document.getElementById("form1").reset();
                        editor.html("");
                    }else if(result=="3"){
                        alert("您的权限为:"+"${user.auth}"+",无权添加其他型的新闻");
                    }
                    else {
                        alert("失败");
                    }
                },
                error : function() {
                    alert("异常！");
                }
            });
        }



    }
</script>
</html>