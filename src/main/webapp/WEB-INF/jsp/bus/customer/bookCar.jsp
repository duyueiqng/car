<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>员工管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 基础管理 / 预订汽车 </p>
<div id="root">
    <div style="width: 80%;height: 50%;margin: 0 auto;">
        <card >
        <i-form   :label-width="80" style="margin: 0 auto ;width: 300px;height: 400px">
            <form-item label="预定用户号">
                <i-input v-model="book.custId" style="width: 200px"/>
            </form-item>
            <form-item label="预定车号">
                <i-input type="text" v-model="book.carId"  ref="carNum" style="width: 200px" @on-focus="findCar"/>
            </form-item>
            <form-item label="预订日期">
                <Date-Picker :value="book.date" type="datetime" format="yyyy-MM-dd HH:mm" ></Date-Picker>
            </form-item>
            <alert type="error" show-icon>注意：该订单只会保持24小时</alert>
            <form-item>
                <i-Button type="primary" @click="doAdd">提交</i-Button>
            </form-item>
        </i-form>
        </card>
    </div>

    <Modal v-model="carFlag" title="车辆信息表" @on-Ok="confirmCar" :height="400" :width="1000">
        <i-table :columns="myColumns" :data="carList" border stripe :height="400" :width="950" @on-selection-change="tableSelection=arguments[0]">
            <template slot-scope="{row}" slot="isFree" >
                <span>{{row.isFree==1?"出租":"空闲"}}</span>
            </template>
            <template slot-scope="{row}" slot="carImg" >
                <img :src="row.carImg" alt="" width="50">
            </template>
        </i-table>
    </Modal>
</div>
<script >
    new Vue({
        el:"#root",
        data:{
            book:{},
            carFlag : false,
            //表格表头
            myColumns:[
                {type:"selection",width:60,align:"center"},
                {key:"carNumber",title:"车牌号",width:110},
                {key:"carType",title:"车型",width:100},
                {key:"carColor",title:"车辆颜色",width:100},
                {key:"carPrice",title:"车辆价格",width:105},
                {key:"carDemp",title:"优点",width:100},
                {key:"rentprice",title:"租赁价格",width:100},
                {slot:"isFree",title:"状态",width:100},
                {key:"deposit",title:"押金",width:100},
                {slot:"carImg",title:"图片",width:100},
            ],
            //表格数据
            carList:[],
            //选择的数据
            tableSelection:[],
        },
        mounted(){
            this.searchCarList()
        },
        methods:{
            <%--searchUserList(){--%>
                <%--axios.get(`${ctx}/sys/user/page/${this.pageNo}/${this.pageSize}`,{params:this.userVo})--%>
                    <%--.then(({data})=>{--%>
                        <%--this.pageResult=data.result;--%>
                    <%--})--%>
            <%--},--%>
            searchCarList(){
                axios.get(`${ctx}/car/sys/car/freelist`,{params:{isFree:0}})
                    .then(({data})=>{
                        this.carList=data;
                    })
            },
            findCar(){
                this.carFlag=true;
            },
            confirmCar(){
                if(this.tableSelection.length!=1){
                    iview.Modal.error({
                        title:"信息提示",
                        content:"请您选择一项且只能选择一项汽车！"
                    });
                    return;
                }
                console.log(this.tableSelection[0]);
                this.book.carId=this.tableSelection[0].carNumber;
                console.log(this.book.carId);
                this.carFlag=false;

            },
            doAdd(){
                this.book.date=moment(this.book.date).format("YYYY-MM-YY HH:mm");
                axios.post(`${ctx}/car/sys/book/doAdd`,this.book)
                    .then(({data})=>{
                        iview.Message.success({content:data.result});
                    })
            }
        },

    });
</script>
</body>
</html>
