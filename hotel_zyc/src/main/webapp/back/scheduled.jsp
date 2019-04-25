<%@page isELIgnored="false" contentType="text/html; utf-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    .page-header{
        margin-top: 0px;
    }
    h2{
        margin-top: 0px;
    }
</style>
<script>
    //用来监听模态框关闭事件
    $(function() {
        $(".modal").on('hidden.bs.modal',function () {
            document.getElementById("form1").reset();
            document.getElementById("form3").reset();
            document.getElementById("form4").reset();
            $("#qqq").attr("hidden",false);
        })
        //创建表格
        $("#list").jqGrid({
            url: "${pageContext.request.contextPath}/scheduled/findAll",
            styleUI: 'Bootstrap',//使用bootstrap风格样式
            datatype: "json",
            autowidth: true,
            pager: "#pager",
            height : "65%",
            hiddengrid: false,
            viewrecords: true,
            altRows:true,//奇偶行颜色
            rowNum: 10,
            colNames: ["房间类型", "房号", "预定时间","预定入住时间","预定人","性别","电话","证件号码","预定状态","预约方式","押金","价格","操作"],
            colModel: [
                {name: "roomType.type", editable: true,sortable:false},
                {name: "room.number", editable: true,sortable:true},
                {name: "scheduledTime", editable: true,search:false,sortable:false},
                {name: "checkinTime", editable: true,search:false,sortable:false},
                {name: "scheduler", editable: true,sortable:false},
                {name: "sex", editable: true,search:false,sortable:false},
                {name: "phone", editable: true,sortable:false},
                {name: "idCard", editable: true,sortable:false},
                {name: "status", editable: true,sortable:false},
                {name: "mode", editable: true,sortable:false},
                {name: "roomType.deposit", editable: true,search:false,sortable:false},
                {name: "price", editable: true,search:false,sortable:false},
                {
                    name: "options",width:335,search:false,sortable:false,
                    formatter: function (value, options, row) {
                        var content;
                        if (row.status=="预定成功") {
                            content =
                                "<button class='btn btn-default' onclick=\"checkIn('"+row.id+"')\">入住</button> "+
                                "<button class='btn btn-default' onclick=\"cancel('"+row.id+"')\">取消</button> "+
                                "<button class='btn btn-default' onclick=\"modify('"+row.id+"')\">修改</button> "+
                                "<button class='btn btn-danger' onclick=\"del('"+row.id+"')\">删除</button> ";
                        }else{
                            content =
                                "<button class='btn btn-default' data-toggle='modal' data-target='#myModal1' onclick=\"details('"+row.id+"')\">修改</button> "+
                                "<button class='btn btn-danger' onclick=\"del('"+row.id+"')\">删除</button> ";
                        }
                        return content;
                    }
                },
            ],
            loadComplete: function () {
                //debugger;
                //在表格加载完成后执行
                var ids = $("#list").jqGrid("getDataIDs");//获取所有行的id
                var rowDatas = $("#list").jqGrid("getRowData");//获取所有行的数据
                for (var ii = 0; ii < rowDatas.length; ii++) {
                    var rowData = rowDatas[ii];
                    if (rowData.status == "预定成功") {
                        $("#" + ids[ii] + " td").css("background-color", "#D1EEEE");
                    }
                    if (rowData.status == "已入住") {
                        $("#" + ids[ii] + " td").css("background-color", "#ebc8ee");
                    }
                    if (rowData.status == "已取消") {
                        $("#" + ids[ii] + " td").css("background-color", "#EEEED1");
                    }
                }
            }

        }).jqGrid("navGrid", "#pager", {edit: false, add: false, del: false, search: true, refresh: false});
    })
    //预定记录删除
    function del(id) {
        $.post("${pageContext.request.contextPath}/room/delete",{id:id},function () {
            $("#list").trigger("reloadGrid");
        });
    }
    //房间信息修改
    $("#save1").click(function () {
        var data = $('#form1').serialize();//将表单数据表单序列化
        $.post("${pageContext.request.contextPath}/room/updateRoom",data,function () {
            $("#list").trigger("reloadGrid");
        })
    })
    //预定取消
    function cancel(id){
        $.post("${pageContext.request.contextPath}/scheduled/cancel",{id:id},function () {
            $("#list").trigger("reloadGrid");
        });
    }
    //房间入住
    function checkIn(id){
        $.post("${pageContext.request.contextPath}/checkIn/add1",{id:id},function () {
            $("#list").trigger("reloadGrid");
        })
    }
    //房间类型回显
    $("#add").click(function () {
        $.post("${pageContext.request.contextPath}/roomType/findAll",function (aaa) {
            $("#type").empty();
            for (var i = 0; i < aaa.length; i++) {
                var item = aaa[i];
                $("#type").append('<option value="' + item.id + '">' + item.type + '</option>');
            }
        })
    })

    //房间添加
    $("#baocun").click(function () {
        var data = $('#form').serialize();//将表单数据表单序列化
        $.post("${pageContext.request.contextPath}/room/addRoom",data,function () {
            $("#list").trigger("reloadGrid");
        })
        $('#centerLayout').load('${pageContext.request.contextPath}/back/room.jsp');
    })
    //房间详情
    function details(id) {
        $.post("${pageContext.request.contextPath}/room/findRoomAndType",{id:id},function (result) {
            //房间详情回显
            $("#number2").attr("value",result.number);
            $("#status2").attr("value",result.status);
            $("#type2").attr("value",result.type);
            $("#priced").attr("value",result.roomType.priceDay);
            $("#priceh").attr("value",result.roomType.priceHour);
            $("#yajin").attr("value",result.roomType.deposit);
            $("#sheshi").attr("value",result.roomType.installation);
            //房间修改回显
            $("#number1").attr("value",result.number);
            $("#id1").attr("value",result.id);
            $("#remark1").html(result.remark);
            $.post("${pageContext.request.contextPath}/roomType/findAll",function (aaa) {
                $("#type1").empty();
                for (var i = 0; i < aaa.length; i++) {
                    var item = aaa[i];
                    if(item.type==result.type){
                        $("#type1").append('<option value="' + item.id + '" selected>' + item.type + '</option>');
                    }else{
                        $("#type1").append('<option value="' + item.id + '">' + item.type + '</option>');
                    }
                }
            })
        })
    }
    //更改日期格式
    $("#checkinTime1").blur(function () {
        var x=document.getElementById("checkinTime1").value;
        year=x.substring(0,4);
        month=x.substring(5,7);
        day=x.substring(8,10);
        hour=x.substring(11,13);
        minute=x.substring(14)
        format=year+"-"+month+"-"+day+" "+hour+":"+minute+":00";
        $("#checkinTime").attr("value",format);
    })

</script>

<div class="container-fluid">
    <div>
        <div class="page-header">
            <h2>房间查询</h2>
        </div>
        <%--标签页开始--%>
        <ul id="myTab" class="nav nav-tabs">
            <li class="active"><a href="#roomlist" data-toggle="tab">预定列表</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <%--表格--%>
            <div class="tab-pane fade in active" id="roomlist">
                <div class="tab-content" id="home">
                    <div role="tabpanel" class="tab-pane active">
                        <table id="list"></table>
                        <div id="pager" style="height: 30px"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 房间修改模态框（Modal1） -->
        <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">房间修改</h4>
                    </div>
                    <div class="modal-body">
                        <form action="javascript:" enctype="multipart/form-data" id="form1">
                            <div class="form-group" hidden>
                                <div class="row">
                                    <label for="id1" class="col-sm-2 control-label">房间id:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="id1" name="id" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row ">
                                    <label for="type1" class="col-sm-2 control-label">房间类型:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" name="roomtypeId" id="type1">
                                            <option>单人房</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <div class="row">
                                    <label for="number1" class="col-sm-2 control-label">房号:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="number1" name="number" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <div class="row">
                                    <label for="remark1" class="col-sm-2 control-label">备注信息:</label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="3" id="remark1" name="remark" ></textarea>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="save1">保存</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <!-- 房间详情模态框（Modal2） -->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">房间详情</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row ">
                                <label for="number2" class="col-sm-2 control-label">房号:</label>
                                <div class="col-sm-10">
                                    <input type="text" id="number2" class="form-control" readonly/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label for="status2" class="col-sm-2 control-label">房间状态:</label>
                                <div class="col-sm-10">
                                    <input type="text" id="status2" class="form-control" readonly/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label for="type2" class="col-sm-2 control-label">房间类型:</label>
                                <div class="col-sm-10">
                                    <input type="text" id="type2" class="form-control" readonly/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label for="priced" class="col-sm-2 control-label">价钱/天:</label>
                                <div class="col-sm-10">
                                    <input type="text" id="priced" class="form-control" readonly/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label for="priceh" class="col-sm-2 control-label">价钱/小时:</label>
                                <div class="col-sm-10">
                                    <input type="text" id="priceh" class="form-control" readonly/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label for="yajin" class="col-sm-2 control-label">押金:</label>
                                <div class="col-sm-10">
                                    <input type="text" id="yajin" class="form-control" readonly/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label for="sheshi" class="col-sm-2 control-label">配套设施:</label>
                                <div class="col-sm-10">
                                    <input type="text" id="sheshi" class="form-control" readonly/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <%--房间预定模态框--%>
        <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">登记信息</h4>
                    </div>
                    <div class="modal-body">
                        <form action="javascript:" enctype="multipart/form-data" id="form3">
                            <div class="form-group" hidden>
                                <div class="row">
                                    <label for="number3" class="col-sm-2 control-label">房间id:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="number3" class="form-control" name="number"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="checkinTime" class="col-sm-2 control-label">入住时间:</label>
                                    <div class="col-sm-10">
                                        <input type="datetime-local" id="checkinTime1" class="form-control"/>
                                        <input type="text" id="checkinTime" class="form-control" name="checkinTime"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="scheduler" class="col-sm-2 control-label">预定人:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="scheduler" class="form-control" name="scheduler"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="phone" class="col-sm-2 control-label">电话:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="phone" class="form-control" name="phone"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="idCard" class="col-sm-2 control-label">身份证号:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="idCard" class="form-control" name="idCard"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="sex" class="col-sm-2 control-label">性别:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" name="sex" id="sex">
                                            <option value="男">男</option>
                                            <option value="女">女</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="mode" class="col-sm-2 control-label">预约方式:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" name="mode" id="mode" onchange="myselect()">
                                            <option value="钟点房">钟点房</option>
                                            <option value="非钟点房">非钟点房</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="qqq">
                                <div class="row">
                                    <label for="price" class="col-sm-2 control-label">入住时间/小时:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="price" class="form-control" name="price"/>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="save3">保存</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <%--房间入住模态框--%>
        <div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">登记信息</h4>
                    </div>
                    <div class="modal-body">
                        <form action="javascript:" enctype="multipart/form-data" id="form4">
                            <div class="form-group" hidden>
                                <div class="row">
                                    <label for="roomId" class="col-sm-2 control-label">房间id:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="roomId" class="form-control" name="roomId"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="name" class="col-sm-2 control-label">入住人:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="name" class="form-control" name="name"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="sex1" class="col-sm-2 control-label">性别:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" name="sex" id="sex1">
                                            <option value="男">男</option>
                                            <option value="女">女</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="phone1" class="col-sm-2 control-label">电话:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="phone1" class="form-control" name="phone"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="idCard1" class="col-sm-2 control-label">身份证号:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="idCard1" class="form-control" name="idCard"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <label for="mode1" class="col-sm-2 control-label">入住方式:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" name="mode" id="mode1" onchange="myselect()">
                                            <option value="钟点房">钟点房</option>
                                            <option value="非钟点房">非钟点房</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="qqq1">
                                <div class="row">
                                    <label for="price1" class="col-sm-2 control-label">入住时间/小时:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="price1" class="form-control" name="price"/>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="save4">保存</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </div>
</div>
