<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>日志管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>

<div id="root">
    <card style="margin: 0 auto; width: 400px;height: 400px">
        <p>日志管理</p>
        <i-form method="post" action="${ctx}/car/login" style="margin: 80px auto; width: 300px;height: 300px">
            <%--<c:if test="${not empty loginErr}">--%>
                <%--<alert type="error" show-icon>${loginErr}</alert>--%>
            <%--</c:if>--%>
            <form-item label="登陆名称:">
                <i-input prefix="ios-contact" name="username" type="text"></i-input>
            </form-item>
            <form-item label="登陆IP:">
                <i-input prefix="ios-lock" name="loginIp" type="text"></i-input>
            </form-item>
            <form-item label="开始时间:">
                <DatePicker type="date" placeholder="" v-model=""></DatePicker>
            </form-item>
            <form-item label="结束时间:">
                <DatePicker type="date" placeholder="" v-model=""></DatePicker>
            </form-item>
            <form-item >
                <i-button html-type="submit" type="primary" style="text-align: center">登录</i-button>
            </form-item>

        </i-form>
    </card>
</div>
<script>
    new Vue({
        el:'#root',
        data:[]
    })
</script>

</body>
</html>
