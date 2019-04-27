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
            document.getElementById("form").reset();
        })
        //创建表格
        $("#list").jqGrid({
            url: "${pageContext.request.contextPath}/checkIn/findAll",
            styleUI: 'Bootstrap',//使用bootstrap风格样式
            datatype: "json",
            autowidth: true,
            pager: "#pager",
            height : "65%",
            hiddengrid: false,
            viewrecords: true,
            altRows:true,//奇偶行颜色
            rowNum: 10,
            colNames: ["入住人", "性别","证件号码","电话","入住时间","更新时间","操作"],
            colModel: [
                {name: "name", editable: true,sortable:false},
                {name: "sex", editable: true,search:false,sortable:true},
                {name: "idCard", editable: true,sortable:false},
                {name: "phone", editable: true,sortable:false},
                {name: "checkinTime", editable: true,search:false,sortable:false},
                {name: "updateTime", editable: true,search:false,sortable:false},
                {
                    name: "options",width:335,search:false,sortable:false,
                    formatter: function (value, options, row) {
                        var content;
                            content =
                                "<button class='btn btn-danger' onclick=\"del('"+row.id+"')\">删除</button> ";
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
        if(confirm("确定要删除吗？？？")==true){
            $.post("${pageContext.request.contextPath}/room/delete",{id:id},function () {
                $("#list").trigger("reloadGrid");
            });
        }
    }
    //预定信息修改
    $("#save").click(function () {
        var data = $('#form').serialize();//将表单数据表单序列化
        $.post("${pageContext.request.contextPath}/scheduled/update",data,function () {
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
    //预定修改回显
    function modify(id,scheduler,sex,phone,idCard) {
        $("#myModal").modal("show");
        $("#scheduler").attr("value",scheduler);
        $("#phone").attr("value",phone);
        $("#idCard").attr("value",idCard);
        $("#id").attr("value",id);
        $("#sex").empty();
        if (sex=="男") {
            $("#sex").append("<option value='男'>男</option>");
            $("#sex").append("<option value='女'>女</option>");
        }else{
            $("#sex").append("<option value='女'>女</option>");
            $("#sex").append("<option value='男'>男</option>");
        }
    }
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

        <%--预定修改模态框--%>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">修改信息</h4>
                    </div>
                    <div class="modal-body" >
                        <form action="javascript:" enctype="multipart/form-data" id="form">
                            <div class="form-group" hidden>
                                <div class="row">
                                    <label for="id" class="col-sm-2 control-label">预定id:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="id" class="form-control" name="id"/>
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
                                    <label for="phone" class="col-sm-2 control-label">电话:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="phone" class="form-control" name="phone"/>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label for="idCard" class="col-sm-2 control-label">证件号码:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="idCard" class="form-control" name="idCard"/>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="save">保存</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </div>
</div>
