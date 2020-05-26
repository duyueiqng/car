<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>业务管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 业务管理 / 检查单管理 </p>
<div id="root">
    <card >
        <i-form :label-width="60">
            <form-item label="检查单号">
                <i-Input v-model="checktable.Id"/>
            </form-item>
            <form-item label="检查时间">
                <i-Input v-model="checktable.checkDate"/>
            </form-item>
            <form-item label="检查员">
                <i-Input v-model="checktable.checkUser"/>
            </form-item>
            <form-item label="出租单号">
                <i-Input v-model="checktable.rentId"/>
            </form-item>
            <form-item >
                <i-Button type="primary" @click="searchUserBy">继续</i-Button>
            </form-item>
        </i-form>
    </card>
</div>
<script >
    new Vue({
        //挂载点
        el:"#root",
        //数据存放位置
        data:{
            //条件查询输入的条件
            checktable:{},
        },
        mounted(){
        },
        methods:{

        }
    });
</script>
</body>
</html>
