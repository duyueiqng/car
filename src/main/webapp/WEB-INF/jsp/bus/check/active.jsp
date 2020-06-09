<%--
  Created by IntelliJ IDEA.
  User: 86155
  Date: 2020/6/9
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<html>
<head>
    <title>Title</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<div id="root">
    <card>
        <i-button type="success" @click="toAdd">活动添加</i-button>
    </card>
    <i-table :columns="myColumns" :data="myData" border stripe :height="400">
        <template slot-scope="{row}" slot="status" >
            <span>{{row.num>0?"进行中":"已过期"}}</span>
        </template>
    </i-table>

    <modal v-model="addFlag" title="添加活动" @on-ok="doAdd">
        <i-form  :label-width="80" style="padding: 30px">
            <form-item label="活动名称">
                <i-input v-model="activitiy.activities" size="large"/>
            </form-item>
            <form-item label="赠送礼品">
                <i-input v-model="activitiy.gifts" size="large"/>
            </form-item>
            <form-item label="礼品数量">
                <i-input v-model="activitiy.num" size="large"/>
            </form-item>
            <form-item label="活动说明">
                <i-input v-model="activitiy.content" size="large"/>
            </form-item>
            <form-item label="创建时间">
                <date-picker type="datetime" size="large" format="yyyy-MM-dd HH:mm" v-model="activitiy.datetime" @on-change="activitiy.datetime=$event"/>
            </form-item>
        </i-form>
    </modal>

</div>

<script>

    new Vue({
        //挂载点
        el:"#root",
        //数据存放位置
        data:{
            //表格数据
            myColumns:[
                {key:"id",title:"活动编号"},
                {key:"activities",title:"活动名称"},
                {key:"gifts",title:"活动礼品"},
                {key:"num",title:"礼品数量"},
                {key:"content",title:"活动内容"},
                {key:"datetime",title:"活动时间"},
                {slot:"status",title:"活动状态"}
            ],
            //表格数据内容
            myData:[],
            time:new Date(),
            activitiy:{},
            addFlag:false,
        },
        mounted(){
            this.find123();
        },
        methods:{
            find123(){
                axios.get(`${ctx}/sys/activitiy/find`)
                    .then(({data})=>{
                        console.log(data.result);
                        this.myData=data.result;
                    })
            },
            toAdd(){
                this.addFlag=true;
            },
            doAdd() {
                axios.post(`${ctx}/sys/activitiy/doAdd`,this.activitiy)
                    .then(({data})=>{
                        iview.Message.success({content:data.msg});
                    })
            }


        },




    })


</script>

</body>
</html>
