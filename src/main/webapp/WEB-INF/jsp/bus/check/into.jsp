<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>汽车出库管理</title>
    <%@include file="/common/head.jsp"%>
</head>

<style>
    .demo-split{
        height: 250px;
        border: 1px solid #dcdee2;
    }
    .demo-split-pane{
        padding: 10px;
    }
    .demo-split-pane.no-padding{
        height: 250px;
        padding: 0;
    }
</style>
<body>
<p>当前位置 : 业务管理 / 汽车入库 </p>
<div id="root">
    <Collapse value="search">
        <Panel name="search">
            温馨提示:请输入您的租赁单号进行还车
            <p slot="content">
                <i-form  inline :label-width="80">
                    <form-item label="订单号:" >
                        <i-input type="text" v-model="renttable.id" />
                    </form-item>
                    <form-item>
                        <%--点击搜索为了页码不出错,需要在条件查询时确保页码为1--%>
                        <i-button @click="findOk()">确定</i-button>
                    </form-item>
                </i-form>
            </p>
        </Panel>
    </Collapse>

    <i-table ref="table" :columns="myColumns" :data="myData" border stripe :height="400">
        <template slot-scope="{row}" slot="rentflag" >
            <span>{{row.rentflag!=1.0?"已完成":"使用中"}}</span>
        </template>
        <template slot-scope="{row,index}" slot="action">
            <i-button type="warning" @click="toReturn(row)" >归还</i-button>
        </template>
    </i-table>


    <%--弹框消息:修改弹框代码--%>
    <Modal v-model="Return" title="归还信息" @on-ok="doReturn(row)" :width="60">
        <template>
            <div class="demo-split">
                <Split >
                    <div slot="left" class="demo-split-pane no-padding">
                        <Split  mode="vertical">
                            <div slot="top" class="demo-split-pane">
                                <h3>车辆信息</h3>
                                <p>车牌号:{{car.carNumber}}</p>
                                <p>车辆颜色:{{car.carColor}}</p>
                                <p>车辆类型:{{car.carType}}</p>
                                <p>租赁金额:{{car.rentprice}}</p>
                                <p>压赁金额:{{car.deposit}}</p>
                            </div>
                            <div slot="bottom" class="demo-split-pane">
                                <h3>客户信息</h3>
                                <p>客户姓名:{{user.username}}</p>
                                <p>性别:{{user.sex}}</p>
                                <p>地址:{{user.address}}</p>
                                <p>身份ID:{{user.idCard}}</p>
                                <p>手机号:{{user.phone}}</p>
                            </div>
                        </Split>
                    </div>
                    <div slot="right" class="demo-split-pane">
                        <template v-if="checktable==null">
                            <h3>违规信息为空!</h3>
                        </template>
                        <template v-else>
                            <h3>违规信息:</h3>
                            <p>违规编号:{{checktable.id}}</p>
                            <p>违规事项:{{checktable.problem}}</p>
                            <p>违规时间:{{checktable.checkDate}}</p>
                            <p>驾驶员:{{checktable.checkUserId}}</p>
                            <p>相关订单:{{checktable.rentId}}</p>
                            <p>赔付金额:{{checktable.paying}}</p>
                            <h2>退付:{{car.deposit}}-{{checktable.paying}}={{car.deposit-checktable.paying}}</h2>
                            <p>(计算:退付=压赁金额-赔付金额)</p>
                        </template>
                        <p>请输入盈利金额完成订单:</p>

                        <i-form  inline :label-width="60">
                            <form-item label="money:">
                                <i-input v-model="car.rentprice"/>
                            </form-item>
                        </i-form>
                    </div>
                </Split>
            </div>
        </template>
    </Modal>



</div>
<script >
    new Vue({
        //挂载点
        el:"#root",
        //数据存放位置
        data:{
            //表格数据
            myColumns:[
                {key:"id",title:"订单编号"},
                {key:"custId",title:"身份信息"},
                {key:"carId",title:"车辆"},
                {slot:"rentflag",title:"状态"},
                {key:"imprest",title:"预付款"},
                {key:"beginDate",title:"租赁时间"},
                {key:"shouldReturnDate",title:"到期时间"},
                {key:"returnDate",title:"归还时间"},
                {key:"userId",title:"操作员"},
                {slot:"action",title:"操作",width:200}
            ],
            //表格数据内容
            myData:[],
            //条件查询输入的条件
            renttable:{},
            //查询的车辆信息
            car:{},
            //归还弹框
            Return:false,
            //归还的订单信息
            rent:{},
            //违规的查询信息
            checktable:{},
            //查询的用户的信息
            user:{},
            //归还
            returnVo:{},



        },
        mounted(){
            // this.searchUserPage();
        },
        methods:{
            findOk(){
                let _this=this;
                console.log(this.renttable);
                axios.get(`${ctx}/sys/rent/select`,{params:this.renttable})
                    .then(({data})=>{
                        console.log(data);
                        if(data.msg!=null){
                            iview.Message.success({content:data.msg});
                            _this.myData=null;
                        }else {
                            _this.myData=data.result;
                            console.log(_this.myData);
                        }
                    })

            },

            //归还弹框显示
            toReturn(row){
                //违规信息显示

                this.checktable.rentId=row.id;
                console.log(this.checktable.rentId);
                axios.get(`${ctx}/sys/checktable/select`,{params:this.checktable})
                    .then(({data})=>{
                        console.log(data);
                        if (data == null) {
                            this.checktable=null;
                        }
                        this.checktable=data.result;
                    });
                //车辆信息显示
                this.car.carNumber=row.carId;
                axios.get(`${ctx}/sys/rent/car`,{params:this.car})
                    .then(({data})=>{
                        console.log(data);
                        this.car=data.result;
                    });
                //查询客户信息
                this.user.idCard=row.custId;
                axios.get(`${ctx}/sys/rent/user`,{params:this.user})
                    .then(({data})=>{
                        console.log(data);
                        this.user=data.result;
                    });

                this.renttable=row;
                console.log(this.renttable);
                this.Return=true;
            },

            //去归还
            doReturn(row){
                this.returnVo.rentId=this.renttable.id;
                this.returnVo.carid=this.car.id;
                axios.get(`${ctx}/sys/rent/todoupdate`,{params:this.returnVo})
                    .then(({data})=>{
                        iview.Message.success({content:data.msg});
                        clearTimeout(this.timer);  //清除延迟执行
                        this.timer = setTimeout(()=>{   //设置延迟执行
                            location. reload()
                        },2000);
                        <%--window.location.href="${ctx}/bus/check/rent/index"--%>
                    });





            }






        }
    });
</script>
</body>
</html>
