<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>员工管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 基础管理 / 客户管理 </p>
<div id="root">
    <%--下拉框--%>
    <Collapse value="search">
        <Panel name="search">
            条件查询
            <p slot="content">
                <i-form  inline :label-width="80">
                    <form-item label="车牌号" >
                        <i-input type="text" v-model="carVo.carNumber" />
                    </form-item>
                    <form-item label="车辆颜色" >
                        <i-input type="text" v-model="carVo.carColor" />
                    </form-item>
                    <form-item label="车型" >
                        <i-input type="text" v-model="carVo.carType" />
                    </form-item>
                    <form-item>
                        <%--点击搜索为了页码不出错,需要在条件查询时确保页码为1--%>
                        <i-button @click="pageNo=1;searchUserPage()">搜索</i-button>
                    </form-item>
                </i-form>
            </p>
        </Panel>

    </Collapse>
    <card>
       <%--<shiro:hasPermission name="user:add">--%>
        <i-button type="success" @click="toAdd">添加用户</i-button>
        <%--</shiro:hasPermission>--%>
    </card>
    <i-table :columns="myColumns" :data="pageResult.rows" border stripe :height="400">
        <template slot-scope="{row}" slot="isFree" >
            <span>{{row.isFree==1?"空闲":"出租"}}</span>
        </template>
        <template slot-scope="{row}" slot="carImg" >
            <img :src="row.carImg" alt="" width="50">
        </template>

        <template slot-scope="{row,index}" slot="action">
            <%--<shiro:hasPermission name="user:update">--%>
                <i-button type="warning" @click="toUpdate(row)" >修改</i-button>
            <%--</shiro:hasPermission>--%>

            <%--<shiro:hasPermission name="user:del">--%>
                <i-button type="error" @click="del(row)" >刪除</i-button>
            <%--</shiro:hasPermission>--%>
        </template>
    </i-table>


    <%--弹框消息:增加弹框代码--%>
    <Modal v-model="addFlag" title="添加车辆信息" @on-ok="doAdd">
        <i-form inline :label-width="60">
            <form-item label="车牌号">
                <i-input v-model="car.carNumber"/>
            </form-item>
            <form-item label="车型">
                <i-input v-model="car.carType"/>
            </form-item>
            <form-item label="车辆颜色">
                <i-input v-model="car.carColor"/>
            </form-item>
            <form-item label="车辆价格">
                <i-input v-model="car.carPrice"/>
            </form-item>
            <form-item label="介绍">
                <i-input v-model="car.carDemp"/>
            </form-item>
            <form-item label="租赁价格">
                <i-input v-model="car.rentprice"/>
            </form-item>
            <form-item label="租赁押金">
                <i-input v-model="car.deposit"/>
            </form-item>
            <form-item label="工作照：">
                <Upload action="sys/car/upload" name="carImg" :before-upload="doBeforeUpload" :on-success="uploadSuccess">
                    <i-button icon="ios-cloud-upload-outline">请选择...</i-button>
                </Upload>
                <div class="img" :style="{'background-image': 'url(' + img +')'}" v-if="img"></div>
            </form-item>
            <form-item label="创建日期">
                <Date-Picker v-model="car.createtime" type="datetime" format="yyyy-MM-dd HH:mm"  @on-change="car.createtime=$event"></Date-Picker>
            </form-item>

        </i-form>
    </Modal>

    <%--弹框消息:修改弹框代码--%>
    <Modal v-model="updateFlag" title="修改车辆信息" @on-ok="doUpdate">
        <i-form inline :label-width="60">
            <form-item label="车牌号">
                <i-input v-model="car.carNumber"/>
            </form-item>
            <form-item label="车型">
                <i-input v-model="car.carType"/>
            </form-item>
            <form-item label="车辆颜色">
                <i-input v-model="car.carColor"/>
            </form-item>
            <form-item label="车辆价格">
                <i-input v-model="car.carPrice"/>
            </form-item>
            <form-item label="介绍">
                <i-input v-model="car.carDemp"/>
            </form-item>
            <form-item label="租赁价格">
                <i-input v-model="car.rentprice"/>
            </form-item>
            <form-item label="租赁押金">
                <i-input v-model="car.deposit"/>
            </form-item>
            <form-item label="工作照：">
                <Upload action="sys/car/upload" name="carImg" :before-upload="doBeforeUpload" :on-success="uploadSuccess">
                    <i-button icon="ios-cloud-upload-outline">请选择...</i-button>
                </Upload>
                <div class="img" :style="{'background-image': 'url(' + img +')'}" v-if="img"></div>
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
                {key:"carNumber",title:"车牌号"},
                {key:"carType",title:"车型"},
                {key:"carColor",title:"车辆颜色"},
                {key:"carPrice",title:"车辆价格"},
                {key:"carDemp",title:"优点"},
                {key:"rentprice",title:"租赁价格"},
                {slot:"isFree",title:"状态"},
                {key:"deposit",title:"押金"},
                {slot:"carImg",title:"图片"},
                {slot:"action",title:"操作",width:200}
            ],
            //表格数据内容
            myData:[],
            //条件查询输入的条件
            carVo:{},
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
            //图片预览功能的实现
            img:null,


        },
        mounted(){
            this.searchUserPage();
        },
        methods:{
            //查询user的全部数据(使用resultVo返回的方法)
            searchUserPage(){
                console.log(this.carVo);
                //get FormData  post json
                //get提交方法携带参数的方法{params:this.userVo}
                axios.get(`${ctx}/sys/car/page/${this.pageNo}/${this.pageSize}`,{params:this.carVo})
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
                this.car = row;
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
