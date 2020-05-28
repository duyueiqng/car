<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>员工管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 业务管理 / 租赁单据 </p>
<div id="root">
    <%--下拉框--%>
    <Collapse value="search">
        <Panel name="search">
            条件查询
            <p slot="content">
                <i-form  inline :label-width="80">
                    <form-item label="订单编号" >
                        <i-input type="text" v-model="renttable.id" />
                    </form-item>
                    <form-item label="状态" >
                        <i-input type="text" v-model="renttable.rentflag" />
                    </form-item>
                    <form-item>
                        <%--点击搜索为了页码不出错,需要在条件查询时确保页码为1--%>
                        <i-button @click="pageNo=1;searchUserPage()">搜索</i-button>
                    </form-item>
                </i-form>
            </p>
        </Panel>

    </Collapse>
    <i-table :columns="myColumns" :data="pageResult.rows" border stripe :height="400">
        <template slot-scope="{row}" slot="rentflag" >
            <span>{{row.rentflag==1?"使用中":"已完成"}}</span>
        </template>

        <template slot-scope="{row,index}" slot="action">
            <span v-if="row.rentflag==1">
                <i-button type="warning" @click="toUpdate(row)" >打印出租单</i-button>
            </span>
            <span v-else>
                <i-button type="error" @click="toUpdate(row)" >编辑</i-button>
                <i-button type="error" @click="del(row)" >刪除</i-button>
            </span>
        </template>
    </i-table>


    <%--弹框消息:编辑弹框代码--%>
    <Modal v-model="updateFlag" title="租赁订单" @on-ok="doUpdate">
        <i-form inline :label-width="60">
            <form-item label="订单编号">
                <i-input v-model="rent.id"/>
            </form-item>
            <form-item label="身份信息">
                <i-input v-model="rent.numCard"/>
            </form-item>
            <form-item label="车俩">
                <i-input v-model="rent.carId"/>
            </form-item>
            <form-item label="状态">
                <i-input v-model="rent.rentflag"/>
            </form-item>
            <form-item label="预付款">
                <i-input v-model="rent.imprest"/>
            </form-item>
            <form-item label="出库时间">
                <i-input v-model="rent.beginDate"/>
            </form-item>
            <form-item label="到租时间">
                <i-input v-model="rent.shouldReturnDate"/>
            </form-item>
            <form-item label="入库时间">
                <i-input v-model="rent.returnDate"/>
            </form-item>
            <form-item label="操作员">
                <i-input v-model="rent.userId"/>
            </form-item>
        </i-form>
    </Modal>



<%--分页标签::total表示页面数据总条数,:current.sync为点击页码自动改变页码,@on-change点击页码改变执行的方法--%>
    <%--show-sizer显示修改页面容量按钮,:page-size要改变的参数,:page-size-opts自定义页面容量,@on-page-size-change页面容量改变执行的方法--%>
    <Page :total="pageResult.total"
          :current.sync="pageNo"
          @on-change="searchUserPage"
          show-sizer
          :page-size="pageSize"
          :page-size-opts="[5,10,15]"
          @on-page-size-change="pageSize=arguments[0];searchUserPage()"
    />
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
                {key:"numCard",title:"身份信息"},
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
            //当前页码
            pageNo:1,
            //页面容量
            pageSize:5,
            //分页查询返回的查询数据
            pageResult:{
                rows:[],
                total:0
            },
            //添加弹框
            addFlag:false,
            //修改弹框
            updateFlag:false,
            //添加存放
            car:{},
            rent:{},
            //图片预览功能的实现
            img:null,


        },
        mounted(){
            this.searchUserPage();
        },
        methods:{
            //查询user的全部数据(使用resultVo返回的方法)
            searchUserPage(){
                console.log(this.renttable);
                //get FormData  post json
                //get提交方法携带参数的方法{params:this.userVo}
                axios.get(`${ctx}/sys/rent/page/${this.pageNo}/${this.pageSize}`,{params:this.renttable})
                    .then(({data})=>{
                        // console.log(data);
                        this.pageResult=data.result;
                        // console.log(this.pageResult.total);
                    })
            },
            //添加准备
            toAdd(){
                //帮助表单输入初始化
                this.car = {};
                this.addFlag=true;
            },
            //添加车辆
            doAdd(){
                console.log(this.car);
                axios.post(`${ctx}/sys/car/doAdd`,this.car)
                    .then(({data})=>{
                        //接收返回添加成功或者添加失败的返回值
                        iview.Message.success({content:data.msg});
                        //刷新数据
                        this.searchUserPage();
                    })
            },
            //修改准备
            toUpdate(row){
                //这句表示这一条数据是点击的数据
                this.rent = row;
                console.log(this.car);
                this.updateFlag=true;
            },
            //修改车辆
            doUpdate(row){
                this.car.createtime=moment(this.car.createtime).format("yyyy-MM-dd HH:mm");
                axios.post(`${ctx}/sys/car/doUpdate`,this.car)
                    .then(({data})=>{
                        iview.Message.success({content:data.msg});
                        // this.search();//上面双向绑定可以省略
                    })
            },
            //删除车辆
            del(row){
                let _this=this;
                let flag = iview.Modal.confirm({
                    title:"您确定要删除该车辆吗?",
                    content:"改操作不可逆,请谨慎操作.",
                    onOk(){
                        console.log(row.id);
                        axios.get(`${ctx}/sys/car/del?id=${row.id}`)
                            .then(({data})=>{
                                // this.addFlag = false;
                                iview.Message.success({content:data});
                                _this.searchUserPage();
                            })
                    }
                });
            },
            //获得上传的图片(图片预览)
            doBeforeUpload(file){
                const reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onloadend = () => {
                    this.img = reader.result;
                }
            },
            //上传工作照成功提示
            uploadSuccess(response){
                console.log("返回的图片值:"+response.result);  //上传工作照会返回一个图片的信息
                this.car.carImg=response.result.carImg;  //给需要修改的数据库指定的数据赋值
                iview.Message.success("上传成功！");
            },
            <%--//提交工作照数据保存数据库--%>
            <%--updateAttach(){--%>
                <%--console.log(this.uploadForm);--%>
                <%--axios.post(`${ctx}/sys/user/updateAttach`,this.uploadForm)--%>
                    <%--.then(({data})=>{--%>
                        <%--this.uploadFlag=false;--%>
                        <%--iview.Message.success(data.msg);--%>
                        <%--this.searchUserPage();--%>
                    <%--});--%>
            <%--}--%>




        }
    });
</script>
</body>
</html>
