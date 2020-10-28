<%--
  Created by IntelliJ IDEA.
  User: haihanmingyue
  Date: 2020/9/9
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.staticfile.org/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>

<body>

<%--       //顶部--%>
        <div class="nav nav-pills col-xs-12 col-sm-12" id="nav">
            <div id="logo">
                <p>LOGO</p>
            </div>
            <a id="name">新闻管理系统</a>
                <button type="button" id="lgout" class="btn btn-default">退出</button>
            <c:if test="${not empty user}">
                <a id="account" title="${user.account} 权限:${user.auth}" >${user.account}</a>
            </c:if>
            <c:if test="${empty user}">
                <button type="button" id="login" class="btn btn-primary">登录</button>
            </c:if>

        </div>

<%--        侧边--%>
<div style="width: 100%;height: 100%">

        <div id="cebian" class="col-xs-4" style="height: 85%">
                <div id="home" class="CBDiv">
                <span class="glyphicon glyphicon-home" style="font-size: 20px;position: relative;top: 7px"></span> <a style="color: black;font-size: 18px;position: relative;top: 5px;" id="index-home"> 首页</a>
                </div>

            <div class="CBDiv">
               <div class="li-title"><span class="li-name">用户管理</span> <span class="jiantou">▶</span></div>
                <div class="li-menu">
                    <div class="li" onclick="userIndex()"><span  class="li-name">用户查看</span></div>
                    <div class="li" onclick="addUser()"><span  class="li-name">用户添加</span></div>
                </div>
            </div>
            <div class="CBDiv">
                <div class="li-title"><span class="li-name">新闻管理</span> <span class="jiantou">▶</span></div>
                <div class="li-menu">
                    <div class="li" onclick="newsIndex()" ><span class="li-name">新闻查看</span></div>
                    <div class="li" onclick="addNews()" ><span class="li-name">新闻添加</span></div>
                </div>
            </div>
            <div style="clear:both;" title="该标签用于清除du浮动，使left和right的父标签能自zhi适应高度！"></div>
        </div>
    <div id="content" >

    </div>
</div>

</body>
<script charset="utf-8" src="kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>

<script>
    $("#content").load("shouye.jsp");
    var lis = $(".li-menu");
    var jianrou = $(".jiantou");
    lis.hide();

    $("#index-home").click(function () {
        $("#content").load("shouye.jsp");
    });

    //侧边导航
    $(".li-title").click(function () {
        if($(this).text().indexOf("用户管理") != -1){

            lis.not(':eq(0)').hide(300,function () {
                jianrou.not(':eq(0)').text("▶");
            });//关闭其他的栏目

           lis.eq(0).slideToggle(function () {
               if(lis.eq(0).is(":visible")){
                   jianrou.eq(0).text("▼");
               }else {
                   jianrou.eq(0).text("▶");
               }
           });
        }else if($(this).text().indexOf("新闻管理") != -1){
            lis.not(':eq(1)').hide(300,function () {
                jianrou.not(':eq(1)').text("▶");
            });//关闭其他的栏目
            lis.eq(1).slideToggle(function () {
                if(lis.eq(1).is(":visible")){
                    jianrou.eq(1).text("▼");
                }else {
                    jianrou.eq(1).text("▶");
                }
            });
        }

    });

    $("#login").click(function () {
        $("#content").load("user/toLogin");
    });
    $("#lgout").click(function () {
        window.location.href="user/lgout";
    });
    function userIndex() {
        $("#content").load("user/userindex");
    }
    function addUser() {
        $("#content").load("user/addUserIndex");
    }

    function newsIndex() {
        $("#content").load("news/newsindex");
    }
    function addNews() {
        $("#content").load("/news/addnews.jsp");
    }

    KindEditor.ready(function(K) {
        window.editor = K.create('#editor_id', {
            cssPath: 'kindeditor/plugins/code/prettify.css',
            allowFileManager: true, resizeType:0 });

    });

</script>
</html>
