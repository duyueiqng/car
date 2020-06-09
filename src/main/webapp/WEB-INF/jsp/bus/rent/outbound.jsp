<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>业务管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 业务管理 / 汽车出库 </p>
<div id="root">
    <card >
        <i-form inline :label-width="60" style="margin-left: 300px">
            <form-item label="身份证号">
                <i-Input v-model="idCard"/>
            </form-item>
            <form-item >
                <i-Button type="primary" @click="searchUserBy">继续</i-Button>
            </form-item>
        </i-form>
    </card>
    <div ref="rentCard" style="display: none">
        <card  title="生成出租单" >
            <i-form inline :label-width="60" @on-ok="doAdd" ref="formDynamic">
                <form-item label="预付金">
                    <i-input v-model="renttable.imprest"/>
                </form-item>
                <form-item label="应付款">
                    <i-input v-model="renttable.shouldPayPrice" ref="price"/>
                </form-item>
                <form-item label="实际交付金额">
                    <i-input v-model="renttable.price"/>
                </form-item>
                <form-item label="起租日期">
                    <Date-Picker :value="renttable.beginDate" type="datetime" format="yyyy-MM-dd HH:mm" @on-change="renttable.beginDate=$event" ></Date-Picker>
                </form-item>
                <form-item label="应归还日期">
                    <Date-Picker :value="renttable.shouldReturnDate" type="datetime" format="yyyy-MM-dd HH:mm" @on-change="renttable.shouldReturnDate=$event" ></Date-Picker>
                </form-item>
                <form-item label="出租单状态">
                    <i-Select  v-model="renttable.rentflag" style="width:200px" placeholder="请选择">
                        <i-Option  value="1" >出租中</i-Option>
                        <i-Option  value="2" disabled="true">已完成</i-Option>
                    </i-Select>
                </form-item>
                <form-item label="车号">
                    <i-input v-model="renttable.carId" ref="carNum" @on-focus="findCar"/>
                </form-item>
                <form-item label="参与活动">
                    <i-select  v-model="renttable.activityId" style="width:200px">
                        <i-Option value="">---不限---</i-Option>
                        <i-Option v-for="item in activitiyList" :value="item.id" :key="item.id">{{ item.activities }}</i-Option>
                    </i-select>
                </form-item>
                <form-item label="用户号">
                    <i-input v-model="renttable.custId"/>
                </form-item>
                <form-item label="操作人">
                    <i-input v-model="renttable.userId"/>
                </form-item>
                <form-item>
                    <i-Button type="primary" @click="doAdd">提交</i-Button>
                    <i-Button @click="handleReset('formDynamic')" style="margin-left: 8px">重置</i-Button>
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
        //挂载点
        el:"#root",
        //数据存放位置
        data:{
            //条件查询输入的条件
            idCard:null,
            addFlag:false,
            renttable:{},
            carFlag:false,
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
            //活动详细弹框
            activityFlag:false,
            //活动数据
            activitiyList:[],
        },
        mounted(){
            this.searchActivityList();

        },
        methods:{
            searchUserBy(){
                //get提交方法携带参数的方法{params:this.userVo}
                axios.get(`${ctx}/sys/user/getUserByCard?idCard=${this.idCard}`)
                    .then(({data})=>{
                        if (data.code==5000){
                            iview.Message.success({content:data.result});
                        }else{
                            iview.Message.success({content:"查询成功"});
                            this.$refs.rentCard.style.display="block";
                            this.searchCarList();
                        }

                    })
            },
            doAdd(){
                this.renttable.deleted=0;
                let params=Qs.stringify(this.renttable,{serializeDate:(datetime)=>{
                        return moment(datetime).format("YYYY-MM-DD HH:mm");
                    }});
                axios.post(`${ctx}/sys/rent/doAdd`,Qs.parse(params))
                    .then(({data})=>{
                        if (data.code=2000){
                            iview.Message.success({content:data.msg});
                            this.renttable=null;
                            clearTimeout(this.timer);  //清除延迟执行
                            this.timer = setTimeout(()=>{   //设置延迟执行
                                location. reload()
                            },5000);

                        }else {
                            iview.Message.error({content:data.msg});
                        }
                    })
            },
            searchCarList(){
                axios.get(`${ctx}/sys/car/freelist`,{params:{isFree:0}})
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
                this.renttable.imprest=this.tableSelection[0].deposit;
                console.log(this.renttable.imprest);
                this.renttable.carId=this.tableSelection[0].carNumber;
                this.renttable.shouldPayPrice=this.tableSelection[0].rentprice;

                this.carFlag=false;

            },
            handleReset (name) {
                this.$refs[name].resetFields();
            },



            //活动相关

            //查看活动信息
            searchActivityList(){
                axios.get(`${ctx}/sys/activitiy/list`)
                    .then(({data})=>{
                        this.activitiyList=data.result;
                    })
            }


        }
    });
</script>
</body>
</html>
