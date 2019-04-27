<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>酒店预定系统</title>
    <link rel="stylesheet" href="${app}/statics/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="${app}/statics/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script src="${app}/statics/boot/js/jquery-3.3.1.min.js"></script>
    <script src="${app}/statics/boot/js/bootstrap.min.js"></script>
    <script src="${app}/statics/jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
    <script src="${app}/statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script>

    </script>
    <style>
        html {
            position: relative;
            min-height: 100%;
        }

        body {
            /* Margin bottom by footer height */
            margin-bottom: 60px;

        }

        .footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            /* Set the fixed height of the footer here */
            height: 50px;
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <%--生成导航条--%>
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#"><strong>酒店预定系统</strong></a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">你好！${admin.username} <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/login.jsp">登录</a></li>
                            <%--<li><a href="#">注册</a></li>--%>
                        </ul>
                    </li>
                    <li><a href="${app}/admin/safeOut">退出 <span class="glyphicon glyphicon-log-out"></span></a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div>
    </nav>
    <%--栅格系统--%>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
                <%--手风琴--%>
                <div class="panel-group" id="accordion" >

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="panel-title">
                                    <a href="#menu_banner" data-toggle="collapse" data-parent="#accordion">酒店管理</a>
                                </div>
                            </div>
                            <div class="panel-collapse collapse" id="menu_banner">
                                <div class="panel-body">
                                    <ul class="nav nav-pills nav-stacked">
                                        <li><a href="javascript:$('#centerLayout').load('${app}/back/room.jsp')"><span class="glyphicon glyphicon-play"></span>  房间查询</a></li>
                                        <li><a href="javascript:$('#centerLayout').load('${app}/back/scheduled.jsp')"><span class="glyphicon glyphicon-play"></span>  预定列表</a></li>
                                        <li><a href="javascript:$('#centerLayout').load('')"><span class="glyphicon glyphicon-play"></span>  入住记录</a></li>
                                        <li><a href="javascript:$('#centerLayout').load('')"><span class="glyphicon glyphicon-play"></span>  房间类型</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <a href="#menu_album" data-toggle="collapse" data-parent="#accordion">客户信息</a>
                            </div>
                        </div>
                        <div class="panel-collapse collapse" id="menu_album">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="javascript:$('#centerLayout').load('./back/album.jsp')"><span class="glyphicon glyphicon-play"></span>  客户列表</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <a href="#menu_article" data-toggle="collapse" data-parent="#accordion">统计信息</a>
                            </div>
                        </div>
                        <div class="panel-collapse collapse" id="menu_article">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="javascript:$('#centerLayout').load('./article.jsp')"><span class="glyphicon glyphicon-play"></span>  入住统计</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <a href="#menu_user" data-toggle="collapse" data-parent="#accordion">系统设置</a>
                            </div>
                        </div>
                        <div class="panel-collapse collapse" id="menu_user">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="javascript:$('#centerLayout').load('./article.jsp')"><span class="glyphicon glyphicon-play"></span>  日志查询</a></li>
                                    <li><a href="javascript:$('#centerLayout').load('./guru.jsp')"><span class="glyphicon glyphicon-play"></span>  修改密码</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-10" id="centerLayout">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">酒店预定系统</h3>
                    </div>

                    <div class="panel-body">
                        <div class="container-fluid">
                            <%--<div class="jumbotron">--%>
                                <img style="width: 100%; height: 70%" class="img-rounded" src="${app}/img/111.jpg">
                            <%--</div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="footer">
        <div class="container">
            <h5 style="text-align: center "> Copyright © 2019-2020 酒店预约系统-969180382@qq.com</h5>
        </div>
    </footer>
</body>
</html>
