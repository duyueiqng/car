<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<html>
<head>
    <title>员工管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 基础管理 / 车辆管理 </p>
<div id="root">
    <Collapse value="search">
        <%--<Panel name="search">--%>
            <%--条件查询--%>
            <%--<p slot="content">--%>
                <%--<i-form  inline :label-width="80">--%>
                    <%--<form-item label="用户代号" >--%>
                        <%--<i-input type="text" v-model="userVo.userCode" />--%>
                    <%--</form-item>--%>
                    <%--<form-item label="角色">--%>
                        <%--<i-select  v-model="userVo.userRole" style="width:200px">--%>
                            <%--<i-Option value=" ">【全部】</i-Option>--%>
                            <%--<i-Option v-for="item in roleList" :value="item.id" :key="item.id">{{ item.roleName }}</i-Option>--%>
                        <%--</i-select>--%>
                    <%--</form-item>--%>
                    <%--<form-item label="出生日期">--%>
                        <%--<row>--%>
                            <%--<col span="12">--%>
                            <%--<Date-Picker type="date" placeholder="Start date"  style="width: 180px" @on-change="userVo.startDate=$event"></Date-Picker>--%>
                            <%--</col>--%>
                            <%--<col span="12">--%>
                            <%--<Date-Picker type="date"  placeholder="End date"  style="width: 180px" @on-change="userVo.endDate=$event"></Date-Picker>--%>
                            <%--</col>--%>
                        <%--</row>--%>
                    <%--</form-item>--%>
                    <%--<form-item>--%>
                        <%--<i-button @click="searchUserList">搜索</i-button>--%>
                    <%--</form-item>--%>
                <%--</i-form>--%>
            <%--</p>--%>
        <%--</Panel>--%>
        <card>
            <i-button type="success" >添加用户</i-button>
            <i-button type="primary" @click="toGraint">角色授权</i-button>
        </card>

    </Collapse>
    <i-table :columns="myColumns" :data="carList" border stripe>
        <template slot-scope="{row,index}" slot="action">
            <i-button type="warning" @click="toUpdate(row)" >修改</i-button>
            <i-button type="error" @click="del(row)" >刪除</i-button>
        </template>
    </i-table>
    <%--<modal v-model="graideFlag" title="角色授权" @on-ok="graint">--%>
        <%--<card>--%>
            <%--授权对象:&nbsp;&nbsp;&nbsp;--%>
        <%--</card>--%>
        <%--<i-table :columns="myColumns2" :data="roleList" border stripe @on-selection-change="tableSelection2=arguments[0]">--%>

        <%--</i-table>--%>

    <%--</modal>--%>
    <%--<page :total="pageResult.tatal" &lt;%&ndash;总页数&ndash;%&gt;--%>
          <%--:current.sync="pageNo"  &lt;%&ndash;当前页&ndash;%&gt;--%>
          <%--:page-size="pageSize"     &lt;%&ndash;每页条数&ndash;%&gt;--%>
          <%--@on-change="searchUserList"   &lt;%&ndash; 页码改变的回调，返回改变后的页码 &ndash;%&gt;--%>
          <%--show-sizer        &lt;%&ndash; 显示分页，用来改变page-size &ndash;%&gt;--%>
          <%--:page-size-opts="[5,10,15]" &lt;%&ndash;每页条数切换的配置 &ndash;%&gt;--%>
          <%--@on-page-size-change="changePageSize(arguments[0])" &lt;%&ndash; 切换每页条数时的回调，返回切换后的每页条数 &ndash;%&gt;--%>
    <%--/>--%>
</div>
<script >
    new Vue({
        el:"#root",
        data:{
            myColumns:[
                {type: 'selection',width: 60,align: 'center'},
                {key:"carNumber",title:"车牌号"},
                {key:"carType",title:"车型"},
                {slot:"carColor",title:"颜色"},
                {key:"carPrice",title:"价格"},
                {key:"rentprice",title:"租赁价格"},
                {key:"carDemp",title:"介绍"},
                {key:"deposit",title:"押金"},
                {key:"carImg",title:"图片"},
                {slot:"action",title:"操作",width:200}
            ],
            carList:[],

        },
        mounted(){
            this.searchUserList();
        },
        methods:{
            searchUserList(){
                axios.get(`${ctx}/sys/car/list/`)
                    .then(({data})=>{
                        this.carList=data;
                        console.log(data)
                    })
            }
        }
    });
</script>
</body>
</html>
