<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>登录</title>
    <%@include file="/common/head.jsp"%>
    <style>
        .form{
            padding: 0 30px;
            width: 300px;
            height: 350px;
            position: absolute;
            left: 50%;
            top: 50%;
            margin: -150px 0 0 -150px;
            box-sizing: border-box;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 0 50px #009688;

        }
        .face{
            margin: -55px auto 20px;
            width: 100px;
            height: 100px;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            border: 5px solid #fff;
            overflow: hidden;
            box-shadow: 0 0 30px #009688;
        }
        .btn{
            height: 38px;
            line-height: 38px;
            padding: 0 18px;
            background-color: #009688;
            color: white;
        }
    </style>
</head>
<body>

<div id="root">
        <i-form method="post" action="${ctx}/car/login" class="form">

            <div class="face">
                <img src="/car/static/images/face.jpg" width="100px" height="100px">
            </div>
            <c:if test="${not empty loginErr}">
                <alert type="error" show-icon>${loginErr}</alert>
            </c:if>
            <form-item>
                <i-input prefix="ios-contact" size="large" name="username" type="text"></i-input>
            </form-item>
            <form-item>
                <i-input prefix="ios-lock" size="large" name="password" type="password"></i-input>
            </form-item>
            <form-item>
                    <i-input prefix="md-images" size="large" name="code" type="text" placeholder="验证码" style="width: 112px"></i-input>
                    <img src="${ctx}/car/login/getCode" onclick="this.src=this.src+'?'" style="vertical-align: middle;height:40px;margin-left: 0px">
            </form-item>
            <form-item >
                <i-button html-type="submit"  class="btn" style="margin-left: 34px">登录</i-button>
                <i-button  style="margin-left: 50px"class="btn" @click="register">注册</i-button>
            </form-item>

        </i-form>
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
