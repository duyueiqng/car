<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>登录</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>

<div id="root">
    <card style="margin: 0 auto; width: 400px;height: 400px">
        <p>用户登录</p>
        <i-form method="post" action="${ctx}/smbms/login" style="margin: 80px auto; width: 300px;height: 300px">
            <c:if test="${not empty loginErr}">
                <alert type="error" show-icon>${loginErr}</alert>
            </c:if>
            <form-item>
                <i-input prefix="ios-contact" name="username" type="text"></i-input>
            </form-item>
            <form-item>
                <i-input prefix="ios-lock" name="password" type="password"></i-input>
            </form-item>
            <form-item >
                <i-button html-type="submit" type="primary" >登录</i-button>
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
