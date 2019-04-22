<%@page isELIgnored="false" contentType="text/html; utf-8" pageEncoding="UTF-8" %>

<style>
    .page-header{
        margin-top: 0px;
    }
    h1{
        margin-top: 0px;
    }
</style>
<script>
    //用来监听模态框关闭事件
    $(function() {
        $("#myModal").on('hidden.bs.modal',function () {
            document.getElementById("form1").reset();
        })
        //用来监听模态框打开事件
        $('#myModal').on('show.bs.modal', function (e) {
            // console.log(e.target);
            // console.log(e.relatedTarget);
            var updates = $(e.relatedTarget).data("update");
            var id = $(e.relatedTarget).data("id");
            if(updates){
                $.post("${pageContext.request.contextPath}/room/findById",{id:id},function (result) {
                    $("#upload1").attr("hidden","hidden");
                    $("#ms").val(result.description);
                    $("#clj").val(result.hyperlink);
                    $("#status").val(result.status);
                    $("#id").val(result.id);
                },"JSON");
            }else{
                $("#upload1").removeAttr("hidden");
            }
        })
        //保存数据
        $("#save").click(function () {
            var form = $('#form1')[0];
            var formdata = new FormData(form);
            $.ajax({
                url: '${pageContext.request.contextPath}/room/saveOrUpdate',
                type: 'POST',
                data: formdata,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function() {
                    $("#save").attr("data-dismiss","modal");
                    $("#list").trigger("reloadGrid");
                },
                error: function(data) {
                }
            });
        });
        //创建表格
        $("#list").jqGrid({
            //caption: "用户列表",
            url: "${pageContext.request.contextPath}/room/findAll",
            styleUI: 'Bootstrap',//使用bootstrap风格样式
            datatype: "json",
            autowidth: true,
            pager: "#pager",
            height : "65%",
            viewrecords: true,
            altRows:true,//奇偶行颜色
            rowNum: 10,
            //editurl: "${pageContext.request.contextPath}/",//编辑时的url
            colNames: ["房间类型", "房号", "房间状态","更新时间","备注信息","操作"],
            colModel: [
                {name: "type", editable: true,sortable:false},
                {name: "number", editable: true,sortable:true},
                {name: "status", editable: true,sortable:false},
                {name: "updateTime", editable: true,search:false,sortable:false},
                {name: "remark", editable: true,search:false,sortable:false},
                {
                    name: "options",width:230,search:false,sortable:false,
                    formatter: function (value, options, row) {
                        var content;
                        if (row.status=="空闲房") {
                            content =
                                "<button class='btn btn-primary' data-toggle='modal' data-target='#myModal' onclick=\"details('"+row.id+"')\">详情</button> "+
                                "<button class='btn btn-warning' onclick=\"preview('"+row.id+"','"+row.description+"')\">预定</button> "+
                                "<button class='btn btn-warning' data-toggle='modal' data-target='#myModal' data-update='"+true+"' data-id='"+row.id+"'>入住</button> "+
                                "<button class='btn btn-warning' data-toggle='modal' data-target='#myModal' data-update='"+true+"' data-id='"+row.id+"'>修改</button> "+
                                "<button class='btn btn-danger' onclick=\"del('"+row.id+"')\">删除</button> ";
                        }else{
                            content =
                                "<button class='btn btn-warning' data-toggle='modal' data-target='#myModal' data-update='" + true + "' data-id='" + row.id + "'>修改</button> " +
                                "<button class='btn btn-danger' onclick=\"del('" + row.id + "')\">删除</button> ";
                        }
                        return content;
                    }
                }
            ],
        }).jqGrid("navGrid", "#pager", {edit: false, add: false, del: false, search: true, refresh: false});
        //

    })
    function del(id) {
        $.post("${pageContext.request.contextPath}/room/delete",{id:id},function () {
            $("#list").trigger("reloadGrid");
        });
    }
    function preview(title,description) {
        $("#myModal1").modal("show");
        $("#img1").attr("src","${pageContext.request.contextPath}/upload/room/"+title);
        $("#label1").text(title);
        $("#desc1").text(description);
    }

    //搜索


        $("#dc").click(function () {
        window.location.href="${pageContext.request.contextPath}/room/exportAll";
    })
    $("#aaa").click(function () {
        var form = $('#form2')[0];
        var formdata = new FormData(form);
        $.ajax({
            url: '${pageContext.request.contextPath}/room/importExcel',
            type: 'POST',
            data: formdata,
            async: false,
            cache: false,
            contentType: false,
            processData: false
        });
    })
    //房间类型回显
    $("#add").click(function () {
        $.post("${pageContext.request.contextPath}/roomType/findAll",function (aaa) {
            $("#type").empty();
            for (var i = 0; i < aaa.length; i++) {
                var item = aaa[i];
                $("#type").append('<option value="' + item.id + '" selected>' + item.type + '</option>');
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


</script>

<div class="container-fluid">
    <div>
        <div class="page-header">
            <h1>房间查询</h1>
        </div>
        <%--标签页开始--%>
        <ul id="myTab" class="nav nav-tabs">
            <li class="active"><a href="#roomlist" data-toggle="tab">房间列表</a></li>
            <li><a href="#addRoom" data-toggle="tab" id="add">添加房间</a></li>
            <%--<li><a href="" data-toggle="tab" id="search">搜索房间</a></li>--%>
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
            <div class="tab-pane fade" id="addRoom">
                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-5">
                        <br/>
                        <br/>
                        <form action="javascript:" enctype="multipart/form-data" id="form">
                            <div class="form-group">
                                <div class="row ">
                                    <label for="type" class="col-sm-2 control-label">房间类型:</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" name="roomtypeId" id="type">
                                            <option>单人房</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <div class="row">
                                    <label for="number" class="col-sm-2 control-label">房号:</label>
                                    <div class="col-sm-10">
                                        <input type="text" id="number" name="number" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <div class="row">
                                    <label for="remark" class="col-sm-2 control-label">备注信息:</label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="3" id="remark" name="remark"></textarea>
                                    </div>
                                </div>
                            </div>
                            <hr/>
                            <div class="form-group">
                                <div class="col-sm-offset-8 col-sm-4">
                                    <button type="submit" class="btn btn-primary" id="baocun">保存</button>
                                    <button type="button" class="btn btn-warning">取消</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-sm-5"></div>
                </div>
            </div>
        </div>

        <!-- 模态框（Modal1） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">编辑轮播图信息</h4>
                    </div>
                    <div class="modal-body">
                        <form action="" enctype="multipart/form-data" id="form1">
                            <div class="form-group" id="upload1" >
                                <label for="exampleInputFile">请选择图片:</label>
                                <input type="file" id="exampleInputFile" name="file1">
                                <p class="help-block">图片的大小不能超过10M!</p>
                            </div>
                            <div class="form-group">
                                <label for="ms">图片描述:</label>
                                <input type="text" id="ms" name="description" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label for="clj">图片超链接:</label>
                                <input type="text" id="clj" name="hyperlink" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label for="status">图片状态:</label>
                                <select class="form-control" name="status" id="status">
                                    <option value="激活">激活</option>
                                    <option value="未激活">未激活</option>
                                </select>
                            </div>
                            <div class="form-group" hidden>
                                <label for="id">图片ID:</label>
                                <input type="text" id="id" name="id" class="form-control"/>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="save">保存</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </div>
</div>