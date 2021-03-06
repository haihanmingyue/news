<%--
  Created by IntelliJ IDEA.
  User: haihanmingyue
  Date: 2020/9/9
  Time: 19:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page isELIgnored="false" %>
<html>
<head>
    <title>用户查看</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.staticfile.org/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
    #xiugai{
        position: absolute;
        z-index: 30;
        background-color: white;
        width: 780px;
        height: 400px;
        margin-left: 20%;
        margin-top: 100px;
        border-radius: 20px;
    }
    #xiugaibc{
        position: absolute;
        z-index: 20;
        background-color: #0f0f0f;
        width: 100%;
        height: 100%;
        opacity: 0.5;
    }
    #closeBtn{
        position: absolute;
        top: 0;
        right: 0;
        width: 50px;
        border: 0 solid white;
        height: 30px;
    }
    #closeBtn:hover{
        background-color: #ff3333;
        color: white;

    }
    h4{
        position: absolute;
       left: 180px;
    }
</style>
<body>
<div id="xiugaibc"></div>
<div id="xiugai" >
<div id="msg">
    <div class="inputDiv">
        <h4>账号：</h4> <input type="text" class="form-control" id="username" title="账号" ><span id="utip"></span>
    </div>
    <div class="inputDiv">
        <h4>分类：</h4> <select id="Auth" class="form-control" style="width: 300px;margin-top: 50px" title="权限" >
            <option value="">分类</option>
            <option value="娱乐">娱乐</option>
            <option value="国际">国际</option>
            <option value="体育">体育</option>
            <option value="民生">民生</option>
        </select> <span id="autip"></span>
    </div>
    <div class="inputDiv">
        <input type="button" class="btn btn-success"  style="margin-left: 220px" onclick="cgUserBtn()" value="修改">
    </div>
    <div><button type="button" id="closeBtn" >X</button></div>
</div>
</div>

<div id="tableDiv" class="col-xs-12" style="background-color: white;height: 100%" >
<div id="sign">
    <a> 您当前的位置：&nbsp;&nbsp;&nbsp;&nbsp;管理首页</a> <a> &nbsp;> &nbsp;</a> <a> 新闻管理 </a><a>&nbsp; >&nbsp; </a>  <a> 查看新闻 </a>
</div>

    <div id="table">
        <table class="table table-bordered form-inline">
            <caption>
                <div class="input-group" style="width: 200px">
                    <span class="input-group-addon">新闻编号</span>
                    <input type="text" id="selectID" class="form-control">
                </div>
                <div class="input-group" style="width: 200px">
                  <span class="input-group-addon">标题</span>
                    <input type="text" id="selectBT" class="form-control">
                </div>
                <div class="input-group" style="width: 250px">
                    <span class="input-group-addon">创建人</span>
                    <input type="text" id="selectUserId" class="form-control">
                </div>
                <div class="input-group" style="width: 250px">
                    <span class="input-group-addon">创建日期</span>
                    <input type="month" id="selectDate" class="form-control">
                </div>
                <div class="input-group">
                    <select id="SelectType" class="form-control" style="width: 200px;" >
                        <option value="">分类</option>
                        <option value="娱乐">娱乐</option>
                        <option value="国际">国际</option>
                        <option value="体育">体育</option>
                        <option value="民生">民生</option>
                    </select>
                </div>
                <div class="input-group">
                    <button class="btn btn-default" style="height: 35px;font-size: 10px;" onclick="searchBtn()">搜索</button>
                </div>

            </caption>
            <thead>
            <tr>
                <th>选择</th>
                <th>新闻编号</th>
                <th>新闻标题</th>
                <th>简介</th>
                <th>分类</th>
                <th>创建人</th>
                <th>创建日期</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${info.list}" var="news" varStatus="no">
                 <tr>
                     <td style="width: 5%"><input type="checkbox"></td>
                     <td style="width: 10%"><a onclick="news('${news.id}')" style="cursor: pointer">${news.id}</a></td>
                     <td style="width: 20%">${news.title}</td>
                     <td style="width: 10%">${fn:substring(news.title, 0, 10)}</td>
                     <td style="width: 10%">${news.type}</td>
                     <td style="width: 10%">${news.userId}</td>
                     <td style="width: 10%">${news.createDate}</td>
                     <td style="width: 10%">
                         <input type="button" onclick="xiugai('${news.id}','${news.userId}')" class="btn btn-default" value="修改">
                         <input type="button"  onclick="deleteNews('${news.id}','${news.userId}')" class="btn btn-default" value="删除">
                     </td>
                     </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <c:if test="${empty info}">
    <div class="footer" style="position: fixed" >
        <a style="color: black;cursor: text">共&nbsp;</a>
        <a style="color: black;cursor: text">0</a>
        <a style="color: black;cursor: text">&nbsp;条</a>
        &nbsp;&nbsp;<a>首页</a>
        &nbsp;&nbsp;<a>上一页</a>
        &nbsp;&nbsp;<a >下一页</a>
        &nbsp;&nbsp;<a style="color: black;cursor: text">第</a>
        &nbsp;<a style="color: black;cursor: text">0</a>
        &nbsp;<a style="color: black;cursor: text">页</a>
        &nbsp;<a style="color: black;cursor: text">共</a>
        &nbsp;<a style="color: black;cursor: text">0</a>
        &nbsp;<a style="color: black;cursor: text">页</a>
        &nbsp;&nbsp;<input type="text">
        &nbsp;&nbsp;<button class="btn btn-success">跳转</button>
    </div >
    </c:if>
    <c:if test="${not empty info}">
        <div class="footer" style="position: fixed" >
            <a style="color: black;cursor: text">共&nbsp;</a>
            <a id="totalResult" style="color: black;cursor: text">${info.total}</a>
            <a style="color: black;cursor: text">&nbsp;条</a>
            &nbsp;&nbsp;<a onclick="goFirst()">首页</a>
            &nbsp;&nbsp;<a onclick="goPre()" id="prePage">上一页</a>
            &nbsp;&nbsp;<a onclick="goNext()" id="nextPage" >下一页</a>
            &nbsp;<a id="endPage" onclick="goEnd()">尾页</a>
            &nbsp;&nbsp;<a style="color: black;cursor: text">第</a>
            &nbsp;<a id="currentPage" style="color: black;cursor: text">${info.pageNum}</a>
            &nbsp;<a style="color: black;cursor: text">页</a>
            &nbsp;<a style="color: black;cursor: text">共</a>
            &nbsp;<a id="totalPages" style="color: black;cursor: text">${info.pages}</a>
            &nbsp;<a style="color: black;cursor: text">页</a>
            &nbsp;&nbsp;<input type="text" id="tiaoPage" style="border-color: lightgray">
            &nbsp;&nbsp;<button class="btn btn-success" onclick="tiaoZhuan()">跳转</button>
        </div >
    </c:if>
</div>
</body>
<script>
    $("#xiugaibc").hide();
    $("#xiugai").hide();

    function xiugai(id,userid) {
        var account = '${user.account}';
        var auth = '${user.auth}';
        if(account != userid && auth!="admin"){
            alert("你无权修改他人发布的新闻");
        }else {
            $("#content").load("news/openChangeNews?id="+id);

        }

   }
    //搜索
    function searchBtn() {
        var pageNum = 1+"";
        changePage(pageNum);
    }
    //删除
    function deleteNews(id,userId) {
        var flag = confirm("确定删除吗");
        if(flag){
            $.ajax({
                url: "news/deletenews",
                dataType: "text",
                type: "post",
                data: {"id": id,"userId":userId},
                success: function (data) {
                    if (data.trim() == "1") {
                        alert("删除成功");
                        var pageNum = parseInt($("#currentPage").text().trim());
                        changePage(pageNum+"");
                    } else if (data.trim() == "no") {
                        alert("您不是管理员，不能删除其他人发布的新闻");
                    } else{
                        alert("删除失败");
                    }
                },
                error: function () {
                    alert("链接后台服务器失败");
                }
            });
        }
    }
    // 页面跳转
    function tiaoZhuan() {
        var pages = $("#tiaoPage").val();
        if(parseInt(pages.trim())<1 || parseInt(pages.trim())> parseInt($("#totalPages").text().trim())){
            alert("请输入正确页数");
        }else {
            changePage(pages);
        }
    }
    function cgUserBtn() {

        if ($("#Auth").val() == "") {
            $("#autip").text("权限不能为空");
        } else {
            $("#autip").text("");
        }

        if ($("#autip").text() == "") {
            $.ajax({
                url: "news/cgnewsmsg",
                dataType: "text",
                type: "post",
                data: {"account": $("#username").val(),"auth": $("#Auth").val()},
                success: function (data) {
                    if (data.trim() == "1") {
                        alert("修改成功");
                        var pageNum = parseInt($("#currentPage").text().trim());
                        changePage(pageNum+"");
                        $("#xiugaibc").hide();
                        $("#xiugai").hide();
                        $("#username").val("");
                        $("#Auth").val("");
                    } else if (data.trim() == "no") {
                        alert("您不能修改自己的权限");
                    } else{
                        alert("修改失败");
                    }
                },
                error: function () {
                    alert("链接后台服务器失败");
                }
            });
        }
    }
    function goNext() {
        var pageNum = parseInt($("#currentPage").text().trim())+1;
        changePage(pageNum+"");

    }
    function goPre() {
        var pageNum = parseInt($("#currentPage").text().trim())-1;
        changePage(pageNum+"");
    }
    function goFirst() {
        changePage(1+"");
    }
    function goEnd() {
        changePage($("#totalPages").text().trim());
    }
    function BtnDV() {

        if($("#currentPage").text().trim() == $("#totalPages").text().trim()){
            $("#nextPage").removeAttr('onclick');
        }else {
            $("#nextPage").attr("onclick","goNext();");
        }
        if($("#currentPage").text().trim() <= 1){
            $("#prePage").removeAttr('onclick');
        }else {
            $("#prePage").attr("onclick","goPre();");
        }
    }
    $("#selectID").keyup(function () {
        $(this).val($(this).val().replace(/[^0-9.]/g, ''));
    });
    function changePage(pageNum) {
        var id = $("#selectID").val().trim();
        var title = $("#selectBT").val().trim();
        var createDate = $("#selectDate").val().trim();
        var userId = $("#selectUserId").val().trim();
        var type = $("#SelectType").val().trim();
        $.ajax({
            url:"news/changepage",
            type:"GET",
            // contentType: "application/json;charset=UTF-8",
            dataType:"JSON",
            data:{"pageNum":pageNum,"id":id,"title":title,"userId":userId,"type":type,"createDate":createDate},
            success:function(data){
                $("#table table tr:not(:first)").remove();
                var date = data.list;
                for(var i=0;i<date.length;i++) {
                    var id = "'"+date[i].id+"'";
                    var userId = "'"+date[i].userId+"'";
                    var content = date[i].title.substring(0,10);
                    $("#table table tbody").append('<tr>' +
                        '<td style="width: 5%"><input type="checkbox"></td>' +
                        '<td style="width: 10%"><a onclick="news('+date[i].id+')" style="cursor: pointer">'+date[i].id+'<a></td>' +
                        '<td style="width: 20%">'+date[i].title+'</td> ' +
                        '<td style="width: 10%">'+content+'</td> ' +
                        '<td style="width: 10%">'+date[i].type+'</td>' +
                        '<td style="width: 10%">'+date[i].userId+'</td>' +
                        '<td style="width: 10%">'+date[i].createDate+'</td>' +
                        '<td style="width: 10%">' +
                        '<input type="button" onclick="xiugai('+id+','+userId+')" class="btn btn-default" value="修改">' +
                        '<input type="button" onclick="deleteNews('+id+','+userId+')" class="btn btn-default" value="删除">' +
                        '</td>' + '</tr>');
                }
                $("#currentPage").text(pageNum);
                $("#totalPages").text(data.pages);
                $("#totalResult").text(data.total);
                BtnDV();
            },
            error:function(){
                alert("链接后台服务器失败");
            }
        });
    }
    function news(id) {
        window.open("news/news?id="+id);
    }
</script>
</html>
