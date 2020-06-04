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
        <i-form method="post" action="${ctx}/car/login" style="margin: 80px auto; width: 300px;height: 300px">
            <c:if test="${not empty loginErr}">
                <alert type="error" show-icon>${loginErr}</alert>
            </c:if>
            <form-item>
                <i-input prefix="ios-contact" name="username" type="text"></i-input>
            </form-item>
            <form-item>
                <i-input prefix="ios-lock" name="password" type="password"></i-input>
            </form-item>
            <form-item>
                    <i-input prefix="md-images" name="code" type="text" placeholder="请输入验证码" style="width: 150px"></i-input>
                    <img src="${ctx}/car/login/getCode" onclick="this.src=this.src+'?'" style="vertical-align: middle;height:40px;margin-left: 10px">
            </form-item>
            <form-item >
                <i-button html-type="submit" type="primary" style="margin-right: 50px;margin-left: 34px">登录</i-button>
                <i-button type="primary" style="margin-left: 50px" @click="register">注册</i-button>
            </form-item>

        </i-form>
    </card>
</div>
<script>
    new Vue({
        el:'#root',
        data:[

        ],
        methods:{
            register(){
             window.location.href="${ctx}/car/toRegister"
            },

        }
    })
</script>

</body>
</html>
