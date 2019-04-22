<%@page contentType="text/html; utf-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入bootstrap -->
    <link rel="stylesheet" href="${app}/statics/boot/css/bootstrap.css" />
    <!-- 引入JQuery  bootstrap.js-->
    <script type="text/javascript" src="${app}/statics/boot/js/jquery-3.3.1.min.js" ></script>
    <script type="text/javascript" src="${app}/statics/boot/js/bootstrap.js" ></script>
    <script type="text/javascript" src="${app}/script/jquery.validate.js"></script>
    <style type="text/css">
        body{
            background: url(${pageContext.request.contextPath}/img/5052a9caac63ff6a723eed36d7daa415.jpg) no-repeat;
            background-size:100% 100%;
            background-attachment:fixed;
        }
        #login_box{
            padding: 35px;
            border-radius:15px;  /*div圆角*/
            background: #56666B;
            color: #fff;
        }
        #login_title{
            color: #000000;
        }
    </style>
    <script type="text/javascript">
        $(function(){
            //点击更换验证码：
            $("#captchaImage").click(function(){//点击更换验证码
                //点击更换验证码
                var time =new Date().getTime()
                $("#captchaImage").attr("src","${app}/code/showcode?"+time);
            });
            $.validator.setDefaults({
                submitHandler: function() {
                    //表单的异步提交
                    $.ajax({
                        //几个参数需要注意一下
                        type: "POST",//方法类型
                        dataType: "json",//预期服务器返回的数据类型
                        url: "${app}/admin/login" ,//url
                        data: $('#loginForm').serialize(),
                        success: function (result) {
                            if (result.code=="200") {
                                alert("登录成功！~");
                                location.href="${app}/index.jsp";
                            }else if (result.code=="500"){
                                alert("用户名或密码错误！~");
                            }else{
                                alert("系统内部错误！~");
                            };
                        },
                        error : function() {
                            alert("异常！");
                        }
                    });
                }
            });
            // 表单验证
            $().ready(function () {
                $("#loginForm").validate({
                    rules:{
                        username:{
                            required:true,
                            minlength: 4
                        },
                        password:{
                            required:true,
                            minlength: 6
                        },
                        code:{
                            required:true,
                            remote:{
                                url:"${app}/admin/checkCode",
                                type:"post",
                                dataType:"json",
                                data:{
                                    code:function () {
                                        return $('#code').val();
                                    }
                                }
                            }
                        }
                    },
                    messages:{
                        username:{
                            required:"请输入用户名",
                            minlength: "用户名不能少于4位"
                        },
                        password:{
                            required:"请输入密码",
                            minlength: "密码不能少于6位"
                        },
                        code:{
                            required:"验证码不能为空",
                            remote: "验证码错误"
                        }
                    },
                })
            });
        });
    </script>

</head>
<body>
<div class="container" id="top">
    <div class="row" style="margin-top: 240px;">
        <div class="col-md-offset-4 col-md-4">
            <div class="col-md-offset-2 col-md-9">
                <h1 id='login_title'>酒店预约系统</h1>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4" >
        </div>
        <div class="col-md-4" id='login_box'>
            <form class="form-horizontal" id="loginForm">
                <div class="form-group">
                    <label class="col-md-3 control-label">用户名</label> <!--control-label标签对齐 -->
                    <div class="col-md-9">
                        <input name="username" class="form-control" type="text"  placeholder="请输入用户名"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-3 control-label">密码</label>
                    <div class="col-md-9">
                        <input name="password" class="form-control" type="text" placeholder="请输入密码" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">验证码</label>
                    <div class="col-md-9">
                        <div class="row">
                            <div class="col-sm-6">
                                <input style="width: 120px" class="form-control" type="text" placeholder="请输入验证码" id="code" name="code"  maxlength="4" autocomplete="off"/>

                            </div>
                            <div class="col-sm-6">
                                <img id="captchaImage" class="captchaImage" src="${app}/code/showcode" title="点击更换验证码" />

                            </div>
                        </div>
                      <%-- <input style="width: 120px" class="form-control" type="text" placeholder="请输入验证码" id="code" name="code"  maxlength="4" autocomplete="off"/>
                        <img id="captchaImage" class="captchaImage" src="${app}/code/showcode" title="点击更换验证码" />--%>
                    </div>
                </div>


                <div class="form-group">
                    <div class="col-md-offset-7 col-md-5">
                        <input type="submit" class="form-control" class="btn-default" value="登录"/>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-4" >
        </div>
    </div>
</div>

</body>
</html>