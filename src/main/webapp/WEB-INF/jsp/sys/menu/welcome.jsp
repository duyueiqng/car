<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>欢迎页</title>
    <%@include file="/common/head.jsp"%>
    <style>
        .welcome{
            font-size: 24px;
            margin: 0 auto;
            line-height: 200px;
            height: 200px;
            width: 23%;
            vertical-align: middle;
            margin-top:50px ;
        }
    </style>
</head>
<body>

<div id="root">
    <div class="welcome">
        <img src="static/images/1.jpg" width="200px" height="200px" />

    </div>
    <h3 style="letter-spacing: 20px;font-size: 24px;text-align: center;margin-top: 50px">欢迎来到汽车租赁管理系统</h3>
</div>
<script>
    new Vue({
        el:'#root',
        data:[

        ],
        methods:{

        }
    })
</script>

</body>
</html>
