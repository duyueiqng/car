<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <title>Insert title here</title>
    <%@include file="/common/head.jsp"%>
    <style>
        .layout-logo{
            width: 50px;
            height: 30px;
            border-radius: 3px;
            float: left;
            position: relative;
            top: 15px;
            left: 120px;
        }
        .layout-nav{
            margin-left:200px;
            letter-spacing: 10px;
            font-size:24px;

        }
        .menu-item i{
            transform: translateX(0px);
            transition: font-size .2s ease, transform .2s ease;
            vertical-align: middle;
            font-size: 16px;
        }
        /*.collapsed-menu{*/
        /*overflow: hidden;*/
        /*!*background-color:red !important;*!*/
        /*}*/
        .collapsed-menu .ivu-menu-light{
            transform: translateX(5px);
            transition: font-size .2s ease .2s, transform .2s ease .2s;
            vertical-align: middle;
            font-size: 22px;
        }
        .collapsed-menu span{
            display: none;
            width: 0px;
            transition: width .2s ease;
        }
        .collapsed-menu .ivu-icon-ios-arrow-down{
            display: none;
        }
        .layout-footer-center{
            text-align: center;
        }
        .bg{
            z-index: 19891014;
            opacity: 0.1;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            position: fixed;
            pointer-events: auto;
        }
        .loginbox {
            z-index: 19891015;
            top: 150px;
            left: 588px;
            margin: 0;
            border-radius: 2px;
            background: white;
            box-shadow: 1px 1px 50px rgba(0,0,0,.3);
            display: none;
            width: 360px;
            height: 210px;
            position: fixed;
            padding: 40px;
        }
    </style>
</head>
<body>
<div id="root" >
    <div class="layout" class="bg"  ref="bg" >
        <Layout>
            <Header>
                <i-Menu mode="horizontal" theme="dark" active-name="1">
                    <h3 style="color:white;float: left;margin-left: 30px">汽车租赁管理系统</h3>
                    <div class="layout-logo" style="color:white;float: left;left: 18px;top:18px;margin-right: 800px">
                        <Icon @click.native="collapsedSider" :class="rotateIcon" :style="{margin: '0 20px'}" type="md-menu" size="24"></Icon>
                    </div>
                    <div class="layout-nav"style="width: 83%;font-size: 14px;letter-spacing: 5px;" >
                        <Menu-Item name="1">
                            <Icon type="ios-navigate"></Icon>
                            <span @click="clear">清除缓存</span>
                        </Menu-Item>
                        <Menu-Item name="2">
                            <Icon type="ios-keypad"></Icon>
                            <span @click="offScreen">锁屏</span>
                        </Menu-Item>
                        <Submenu name="3">
                            <template slot="title" style="font-family: Ionicons;speak: none;font-style: normal;font-size:18px;font-weight: 400;">
                                <Avatar src="https://dev-file.iviewui.com/userinfoPDvn9gKWYihR24SpgC319vXY8qniCqj4/avatar"></Avatar>
                                管理员
                            </template>
                            <Menu-Item name="3-1">
                                <a href="sys/car/index" target="main">个人资料</a>
                            </Menu-Item>
                            <Menu-Item name="3-2">
                                <a href="sys/user/index" target="main">修改密码</a>
                            </Menu-Item>
                            <Menu-Item name="3-2">
                                <a @click.href="logout()">退出系统</a>
                            </Menu-Item>
                        </Submenu>
                    </div>
                </i-Menu>
            </Header>
            <Layout>
                <sider ref="side1" collapsible hide-trigger collapsible-width="0"  v-model="isCollapsed" :style="{background: '#fff'}" :class="menuitemClasses">
                    <i-Menu active-name="1-2" theme="light" width="auto" >
                        <c:forEach items="${menuList}" var="p01" varStatus="vs01">
                            <Submenu name="${vs01.index}">
                                <template slot="title">
                                    <Icon type="${p01.icon}"></Icon>
                                    <span>${p01.name}</span>
                                </template>
                                <c:forEach items="${p01.children}" var="p02" varStatus="vs02">
                                    <Menu-Item name="${vs01.index}-${vs02.index}">
                                        <a href="${p02.url}" target="main"><span>${p02.name}</span></a>
                                    </Menu-Item>
                                </c:forEach>
                            </Submenu>
                        </c:forEach>

                    </i-Menu>
                </sider>
                <Layout :style="{padding: '0 24px 24px'}">
                    <i-Content :style="{minHeight: '500px', background: '#fff'}">
                        <iframe name="main" width="1300px" height="600px" frameborder="0" src="/car/sys/menu/welcome/index"></iframe>
                    </i-Content>
                </Layout>
            </Layout>
        </Layout>
        <Footer class="layout-footer-center">2019-2020 &copy; TalkingData</Footer>
    </div>

    <div ref="lockcmsFlag"  class="loginbox">
        <i-form method="get"  class="form">
            <form-item>
                <i-input prefix="ios-contact" v-model ="pwd" size="large" name="username" type="text" placeholder="请输入锁屏密码"></i-input>
            </form-item>
            <form-item>
                <i-button @click="close" style="" class="button">解锁</i-button>
                <span style="color: red;font-size: 18px;margin: 10px 10px 10px 30px">{{msg}}</span>
            </form-item>
        </i-form>
        <p style="color: red">呔~~~哪里来的妖怪,我是不会告诉密码是123456的!</p>
    </div>
</div>


<script>
    new Vue({
        el:"#root",
        data:{
            menus:[],
            isCollapsed: false,
            pwd:'',
            msg:'',
        },
        computed: {
            rotateIcon : function () {
                return [
                    'menu-icon',
                    this.isCollapsed ? 'rotate-icon' : ''
                ];
            },
            menuitemClasses: function () {
                return [
                    'menu-item',
                    this.isCollapsed ? 'collapsed-menu' : ''
                ]
            }

        },
        methods:{
            logout(){
                location.href = `${ctx}/car/logout`;
            },
            clear(){
                window.location.href = `${ctx}/car/index`;
            },
            offScreen(){
                this.$refs.lockcmsFlag.style.display="block";
                this.$refs.bg.style.zIndex="19891014";
                this.$refs.bg.style.backgroundColor="black";
                this.$refs.bg.style.opacity="0.4";
                // this.$refs.bg.style.position="absolute";
            },
            close(){
                if(this.pwd==="123456"){
                    this.$refs.lockcmsFlag.style.display="none";
                    this.$refs.bg.style.opacity="1";
                }else{
                    this.msg="屏幕密码错误";
                }
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            }
        },
        mounted(){
            // this.createMenu();
        }
    })
</script>
</body>
</html>
