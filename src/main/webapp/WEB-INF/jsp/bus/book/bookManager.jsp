<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>员工管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 基础管理 / 预订管理 </p>
<div id="root">
    <Collapse value="search">
        <Panel name="search">
            条件查询
            <p slot="content">
                <i-form  inline :label-width="80">
                    <form-item label="处理人:" >
                        <i-input type="text" v-model="bookVo.userId" />
                    </form-item>
                    <form-item label="处理对象:" >
                        <i-input type="text" v-model="bookVo.custId" />
                    </form-item>
                    <form-item label="预定单状态:">
                        <i-select  v-model="bookVo.flag" style="width:200px">
                            <i-Option value=" ">【全部】</i-Option>
                            <i-Option  value="0" >已完成</i-Option>
                            <i-Option  value="1" >进行中</i-Option>
                        </i-select>
                    </form-item>
                    <form-item label="创建日期">
                        <Date-Picker v-model="bookVo.date" type="datetime" format="yyyy-MM-dd HH:mm"  @on-change="bookVo.date=$event"></Date-Picker>
                    </form-item>
                    <form-item>
                        <i-button @click="searchBookList">搜索</i-button>
                    </form-item>
                </i-form>
            </p>
        </Panel>
        <card>
            <shiro:hasPermission name="user:add">
                <%--<i-button type="success" @click="toAdd">添加预订</i-button>--%>
            </shiro:hasPermission>
        </card>
    </Collapse>
    <i-table :columns="myColumns" :data="pageResult.rows" border stripe @on-selection-change="tableSelection=arguments[0]">
        <template slot-scope="{row}" slot="flag">
            {{row.flag==1?"进行中":"已完成"}}
        </template>
        <template slot-scope="{row}" slot="result">
            {{row.result==1?"通过":"驳回"}}
        </template>
        <template slot-scope="{row,index}" slot="action">
            <span v-if="row.flag==1">
                   <i-button type="warning" @click="toUpdate(row)">处理</i-button>
            </span>
            <span v-else>
                   <%--<i-button type="warning" @click="toUpdate(row)">查看</i-button>--%>
                   <i-button type="warning" @click="sendMail(row)">通知</i-button>
            </span>
        </template>
    </i-table>
    <Modal v-model="updateFlag" title="预订处理">
        <i-form inline :label-width="60">
            <form-item label="处理意见">
                <i-input v-model="book.advise" type="text"/>
            </form-item>
            <form-item label="处理时间">
                <Date-Picker v-model="book.dealTime" type="datetime" format="yyyy-MM-dd HH:mm"  @on-change="book.dealTime=$event"></Date-Picker>
            </form-item>
            <form-item label="处理人:" >
                <i-input type="text" v-model="book.userId" />
            </form-item>
            <i-button type="warning" @click="toOk()">通过</i-button>
            <i-button type="warning" @click="toCancle()" >驳回</i-button>
        </i-form>
    </Modal>
    <Modal v-model="addFlag" title="增加预订">
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
    </Modal>
    <Modal v-model="carFlag" title="车辆信息表" @on-Ok="confirmCar" :height="400" :width="1000">
        <i-table :columns="carColumns" :data="carList" border stripe :height="400" :width="950" @on-selection-change="tableSelection=arguments[0]">
            <template slot-scope="{row}" slot="isFree" >
                <span>{{row.isFree==1?"出租":"空闲"}}</span>
            </template>
            <template slot-scope="{row}" slot="carImg" >
                <img :src="row.carImg" alt="" width="50">
            </template>
        </i-table>
    </Modal>
    <page :total="pageResult.total" <%--总页数--%>
          :current.sync="pageNo"  <%--当前页--%>
          :page-size="pageSize"     <%--每页条数--%>
          <%--@on-change="searchBookList"   &lt;%&ndash; 页码改变的回调，返回改变后的页码 &ndash;%&gt;--%>
          show-sizer        <%-- 显示分页，用来改变page-size --%>
          :page-size-opts="[5,10,15]" <%--每页条数切换的配置 --%>
          @on-page-size-change="changePageSize(arguments[0])" <%-- 切换每页条数时的回调，返回切换后的每页条数 --%>
          />
</div>
<script >
    new Vue({
        el:"#root",
        data:{
            myColumns:[
                {key:"custId",title:"用户号",width: 80},
                {key:"carId",title:"预定车号",width: 120},
                {slot:"flag",title:"状态",width: 90},
                {key:"date",title:"预定时间",width: 170},
                {key:"userId",title:"处理人",width: 120},
                {key:"dealTime",title:"处理时间",width: 170},
                {slot:"result",title:"结果",width: 88},
                {key:"advise",title:"处理建议",width: 118},
                {key:"remark",title:"客户知情",width: 128},
                {slot:"action",title:"操作",width:166}
            ],
            bookVo:{},
            //当前页码
            pageNo:1,
            //页面容量
            pageSize:5,
            //分页查询返回的查询数据
            pageResult:{
                rows:[],
                total:0
            },
            book:{},
            advise:'',
            date:'',
            userId:'',
            updateFlag:false,
            addFlag:false,
            carFlag:false,
            carColumns:[
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
            carList:[]

        },
        mounted(){
            this.searchBookList();

        },
        methods:{
            sendMail(row){
                console.log(row)
                Object.assign(this.book,row);
                let params=Qs.stringify(this.book,{serializeDate:(datetime)=>{
                        return moment(datetime).format("YYYY-MM-DD HH:mm");
                    }});
                // this.book.dealTime=moment(this.book.dealTime).format("YYYY-MM-DD HH:mm");
                console.log(this.book)
                axios.get(`${ctx}/sys/book/sendMail`,{params:Qs.parse(params)})
                    .then(({data})=>{
                        iview.Message.success({content:data.msg});
                        this.book=null;
                    })
            },
            searchBookList(){
                axios.get(`${ctx}/sys/book/page/${this.pageNo}/${this.pageSize}`,{params:this.bookVo})
                    .then(({data})=>{
                        this.pageResult=data.result;
                    })
            },
            toAdd(){
                this.addFlag=true;
            },
            findCar(){
                this.carFlag=true;
                this.searchCarList();
            },
            searchCarList(){
                axios.get(`${ctx}/sys/car/freelist`,{params:{isFree:0}})
                    .then(({data})=>{
                        this.carList=data;
                    })
            },
            confirmCar(){
                if(this.tableSelection.length!=1){
                    iview.Modal.error({
                        title:"信息提示",
                        content:"请您选择一项且只能选择一项汽车！"
                    });
                    return;
                }
                console.log(this.tableSelection[0])
                this.book.carId=this.tableSelection[0].carNumber;
                console.log(this.book.carId)
                this.carFlag=false;

            },
            doAdd(){
                axios.post(`${ctx}/sys/book/doAdd`,this.book)
                    .then(({data})=>{
                        console.log(data)
                        iview.Message.success({content:data.msg});
                        this.book=null;
                    })
            },
            toUpdate(row){
                this.updateFlag=true;
                Object.assign(this.book,row);
                console.log(this.book)
            },
            toOk(){
                this.flag=true;
                Object.assign(this.book.flag,0)
                this.book.dealTime=moment(this.book.dealTime).format("YYYY-MM-DD HH:mm");
                this.book.result=0;
                this.book.flag=0;
                this.book.remark="未通知";
                console.log(this.book)
                //通过验证
                axios.post(`${ctx}/sys/book/updateBook`,this.book)
                    .then(({data})=>{
                        console.log(data)
                        iview.Message.success({content:data.msg});
                        this.book=null;
                    })
            },
            toCancle(){
                //驳回
                this.book.result=1;
                this.book.flag=0;
                this.book.remark="未通知";
                console.log(this.book)
                axios.post(`${ctx}/sys/book/updateBook`,this.book)
                    .then(({data})=>{
                        console.log(data)
                        iview.Message.success({content:data.msg});
                        this.book=null;
                    })
            }


        },

    });
</script>
</body>
</html>
