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

        .collapsed-menu{
            overflow: hidden;
            background-color:red !important;
        }
        .collapsed-menu .ivu-menu-light{
            background-color:#000 !important;
        }
    </style>
</head>
<body>
<div id="root">
    <div class="layout">
        <Layout>
            <Header>
                <i-Menu mode="horizontal" theme="dark" active-name="1">
                    <div class="layout-logo">
                        <Avatar src="https://dev-file.iviewui.com/userinfoPDvn9gKWYihR24SpgC319vXY8qniCqj4/avatar"></Avatar>
                    </div>
                    <div class="layout-nav">
                        <h3 style="color:white">汽车租赁管理系统</h3>
                        <i-button type="primary" size="small" style="position:relative;top:-30px;left:990px;" @click="logout()">退出</i-button>
                    </div>
                </i-Menu>
            </Header>
            <Layout>
                <sider collapsible collapsible-width="1%"  v-model="isCollapsed" :style="{background: '#fff'}" :class="menuitemClasses">
                    <i-Menu active-name="1-2" theme="light" width="auto" :open-names="['1']">
                        <%--<c:forEach items="${menuList}" var="p01" varStatus="vs01">--%>
                            <%--<Submenu name="${vs01.index}">--%>
                                <%--<template slot="title">--%>
                                    <%--<Icon type="${p01.icon}"></Icon>--%>
                                    <%--${p01.name}--%>
                                <%--</template>--%>
                                <%--<c:forEach items="${p01.children}" var="p02" varStatus="vs02">--%>
                                    <%--<Menu-Item name="${vs01.index}-${vs02.index}">--%>
                                        <%--<a href="${p02.url}" target="main">${p02.name}</a>--%>
                                    <%--</Menu-Item>--%>
                                <%--</c:forEach>--%>
                            <%--</Submenu>--%>
                        <%--</c:forEach>--%>

                        <Submenu name="1">
                            <template slot="title">
                                <Icon type="ios-navigate"></Icon>
                                基础管理
                            </template>
                            <Menu-Item name="1-1">
                                <a href="sys/car/index" target="main">车辆管理</a>
                            </Menu-Item>
                            <Menu-Item name="1-2">
                                <a href="sys/user/index" target="main">客户管理</a>
                            </Menu-Item>
                        </Submenu>
                        <Submenu name="2">
                            <template slot="title">
                                <Icon type="ios-keypad"></Icon>
                                业务管理
                            </template>
                            <Menu-Item name="2-1">
                                <a href="sys/role/index" target="main">汽车出库</a>
                            </Menu-Item>
                            </template>
                            <Menu-Item name="2-2">
                                <a href="sys/role/index" target="main">汽车入库</a>
                            </Menu-Item>
                            </template>
                            <Menu-Item name="2-3">
                                <a href="sys/role/index" target="main">租赁单据</a>
                            </Menu-Item>
                        </Submenu>
                        <Submenu name="3">
                            <template slot="title">
                                <Icon type="ios-analytics"></Icon>
                                系统管理
                            </template>
                            <Menu-Item name="3-1">
                                <a href="sys/role/index" target="main">角色管理</a>
                            </Menu-Item>
                            </template>
                            <Menu-Item name="3-2">
                                <a href="sys/role/index" target="main">日志管理</a>
                            </Menu-Item>
                        </Submenu>
                        </Submenu>
                        <Submenu name="4">
                            <template slot="title">
                                <Icon type="ios-analytics"></Icon>
                                统计管理
                            </template>
                            <Menu-Item name="4-1">
                                <a href="sys/role/index" target="main">租赁地区统计</a>
                            </Menu-Item>
                            </template>
                            <Menu-Item name="4-2">
                                <a href="sys/role/index" target="main">销售统计</a>
                            </Menu-Item>
                        </Submenu>
                    </i-Menu>
                </sider>
                <Layout :style="{padding: '0 24px 24px'}">
                    <i-Content :style="{minHeight: '500px', background: '#fff'}">
                        <iframe name="main" width="1300px" height="600px" frameborder="0"></iframe>
                    </i-Content>
                </Layout>
            </Layout>
        </Layout>
    </div>


</div>


<script>
    new Vue({
        el:"#root",
        data:{
            menus:[],
            isCollapsed: false
        },
        computed: {
            menuitemClasses: function () {
                return [
                    'menu-item',
                    this.isCollapsed ? 'collapsed-menu' : ''
                ]
            }
        },
        methods:{
            logout(){
                location.href = `${ctx}/logout`;
            },
            <%--createMenu(){--%>
                <%--axios.get("${pageContext.request.contextPath}/createMenu")--%>
                    <%--.then(({data})=>{--%>
                        <%--this.menus=data.result;--%>
                    <%--});--%>
            <%--}--%>
        },
        mounted(){
            // this.createMenu();
        }
    })
</script>
</body>
</html>
