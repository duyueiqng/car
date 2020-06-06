<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>个人信息</title>
    <%@include file="/common/head.jsp"%>
    <style>
        .boxCrid{
                margin: auto;
                /*border: 1px solid red;*/
                width: 60%;
                height: 100%;
                background-color: antiquewhite;
        }
        .biaoti{
                margin: auto;
                text-align: center;
                font-size: 24px;
    }
        .xinxi{
                font-size: 18px;
                color: darkgoldenrod;
                padding-left: 80px;
                padding-top: 20px;
        }
    </style>
</head>
<body style="background-color: #dcdee2">

<div id="root">
    <div class="boxCrid"style="margin: auto">
        <h3 class="biaoti" >个人信息</h3>
    <div>
        <Row :gutter="16">
        <i-col span="6">
        <div><img src="${user.attachPath}" width="200px" height="200px" style="margin-left: 280px"></div>
        </i-col>
        </Row>
    </div>
    <div class="xinxi">
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>用户代号</div>
            </i-col>
            <i-col span="6">
                <div>${user.usercode}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>用户姓名</div>
            </i-col>
            <i-col span="6">
                <div>${user.username}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>性别</div>
            </i-col>
            <i-col span="6">
                <div>${user.sex==1?"男":"女"}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>生日</div>
            </i-col>
            <i-col span="6">
                <div>${user.birthday}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>身份证号</div>
            </i-col>
            <i-col span="6">
                <div>${user.idCard}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>手机号</div>
            </i-col>
            <i-col span="6">
                <div>${user.phone}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>地址</div>
            </i-col>
            <i-col span="6">
                <div>${user.address}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>邮箱</div>
            </i-col>
            <i-col span="6">
                <div>${user.email==""?"无邮箱":user.email}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>
        <Row :gutter="16">
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
            <i-col span="6">
                <div>用户状态</div>
            </i-col>
            <i-col span="6">
                <div>${user.state==1?"激活":"未激活"}</div>
            </i-col>
            <i-col span="6">
                <div>&nbsp;&nbsp;</div>
            </i-col>
        </Row>

        </div>
    </div>

</div>
<script>
    var vm = new Vue({
        el:'#root',
        created(){
        },
        data:{
            user:{},
            //图片预览功能的实现
            img:null,
        },
        mounted () {
            // this.start=window.start; // 方法赋值给window
        },
        methods:{
            //获得上传的图片(图片预览)
            doBeforeUpload(file){
                const reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onloadend = () => {
                    this.img = reader.result;
                }
            },
        }


    });

</script>

</body>
</html>
