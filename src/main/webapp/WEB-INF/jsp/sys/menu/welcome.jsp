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

    <div style="border: solid 1px green;display: block;width: 666px;margin: auto;font-size: 16px;margin-top: 20px" >
        <img src="static/images/火热.jpg">
    感恩回馈，据了解，6月1日至6月14日，交通运输部就《关于促进汽车租赁业健康发展的指导意见》
    在部政府网站向社会公开征求意见。根据梳理出的194条意见建议，交通运输部对《指导意见》进行了修改完善，
    将适用范围限定为小微型客车租赁；充实了反恐防范相关要求，增加了“维护公共安全”“按要求采集和报送有关
    信息”等内容；增加了“鼓励使用新能源车辆开展分时租赁”“鼓励分时租赁经营者采用信用模式代替押金管理”等表述。
    </div>

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
