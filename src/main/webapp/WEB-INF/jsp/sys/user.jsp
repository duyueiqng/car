<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<html>
<head>
    <title>员工管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 基础管理 / 客户管理 </p>
<div id="root">
    <Collapse value="search">
        <Panel name="search">
            条件查询
            <p slot="content">
                <i-form  inline :label-width="80">
                    <form-item label="客户姓名:" >
                        <i-input type="text" v-model="userVo.username" />
                    </form-item>
                    <form-item label="身份信息:" >
                        <i-input type="text" v-model="userVo.id_card" />
                    </form-item>
                    <form-item label="角色查询:">
                        <i-select  v-model="userVo.userRole" style="width:200px">
                            <i-Option value=" ">【全部】</i-Option>
                            <i-Option v-for="item in roleList" :value="item.id" :key="item.id">{{ item.roleName }}</i-Option>
                        </i-select>
                    </form-item>
                    <form-item>
                        <i-button @click="searchUserList">搜索</i-button>
                    </form-item>
                </i-form>
            </p>
        </Panel>
        <card>
            <i-button type="success" @click="toAdd">添加用户</i-button>
            <i-button type="primary" @click="toGraint">角色授权</i-button>
        </card>

    </Collapse>
    <i-table :columns="myColumns" :data="pageResult.rows" border stripe @on-selection-change="tableSelection=arguments[0]">
        <template slot-scope="{row}" slot="sex">
            {{row.sex==1?"男":"女"}}
        </template>
        <template slot-scope="{row}" slot="roleName">
            {{row.role.roleName}}
        </template>
        <template slot-scope="{row}" slot="idCard">
            {{row.idCard}}
        </template>
        <template slot-scope="{row}" slot="attachPath">
            <img :src="row.attachPath" alt="" width="50">
        </template>
        <template slot-scope="{row,index}" slot="action">
            <i-button type="warning" @click="toUpdate(row)" >修改</i-button>
            <i-button type="error" @click="del(row)" >刪除</i-button>
        </template>
    </i-table>
    <modal v-model="graideFlag" title="角色授权" @on-ok="graint">
        <card>
            授权对象:&nbsp;&nbsp;&nbsp;
        </card>
        <i-table :columns="myColumns2" :data="roleList" border stripe @on-selection-change="tableSelection2=arguments[0]">

        </i-table>

    </modal>


    <%--弹框消息:增加弹框代码--%>
    <Modal v-model="addFlag" title="增加客户信息" @on-ok="doAdd">
        <i-form :model="forItem" inline :label-width="60">
            <form-item label="编号">
                <i-input v-model="user.usercode"/>
            </form-item>
            <form-item label="姓名">
                <i-input v-model="user.username"/>
            </form-item>
            <form-item label="密码">
                <i-input type="password" v-model="user.password"/>
            </form-item>
            <form-item label="性别">
                <template>
                    <Radio-Group v-model="user.sex">
                        <Radio label="1">男</Radio>
                        <Radio label="0">女</Radio>
                    </Radio-Group>
                </template>
                <%--<i-input v-model="user.gender"/>--%>
            </form-item>
            <form-item label="生日">
                <Date-Picker v-model="user.birthday" type="date" format="yyyy-MM-dd"  @on-change="user.birthday=$event"></Date-Picker>
            </form-item>
            <form-item label="身份信息">
                <i-input v-model="user.idCard"/>
            </form-item>
            <form-item label="角色:">
                <i-select  v-model="user.userRole" style="width:200px">
                    <i-Option v-for="item in roleList" :value="item.id" :key="item.id">{{ item.roleName }}</i-Option>
                </i-select>
            </form-item>
            <form-item label="手机号">
                <i-input v-model="user.phone"/>
            </form-item>
            <form-item label="地区">
                <i-input v-model="user.address"/>
            </form-item>
            <form-item label="照片：">
                <Upload action="sys/user/upload" name="attachPath" :before-upload="doBeforeUpload" :on-success="uploadSuccess">
                    <i-button icon="ios-cloud-upload-outline">请选择...</i-button>
                </Upload>
                <div class="img" :style="{'background-image': 'url(' + img +')'}" v-if="img"></div>
            </form-item>
            <form-item label="创建日期">
                <Date-Picker v-model="user.createdate" type="datetime" format="yyyy-MM-dd HH:mm"  @on-change="user.createdate=$event"></Date-Picker>
            </form-item>

        </i-form>
    </Modal>

    <%--弹框消息:修改弹框代码--%>
    <Modal v-model="updateFlag" title="修改客户信息" @on-ok="doUpdate">
        <i-form :model="forItem" inline :label-width="60">
            <form-item label="编号">
                <i-input v-model="user.usercode"/>
            </form-item>
            <form-item label="姓名">
                <i-input v-model="user.username"/>
            </form-item>
            <form-item label="性别">
                <template>
                    <Radio-Group v-model="user.sex">
                        <Radio label="1">男</Radio>
                        <Radio label="0">女</Radio>
                    </Radio-Group>
                </template>
            </form-item>
            <form-item label="生日">
                <Date-Picker v-model="user.birthday" type="date" format="yyyy-MM-dd"  @on-change="user.birthday=$event"></Date-Picker>
            </form-item>
            <form-item label="身份信息">
                <i-input v-model="user.idCard"/>
            </form-item>
            <form-item label="手机号">
                <i-input v-model="user.phone"/>
            </form-item>
            <form-item label="地区">
                <i-input v-model="user.address"/>
            </form-item>
            <form-item label="创建日期">
                <Date-Picker v-model="user.createdate" type="datetime" format="yyyy-MM-dd HH:mm"  @on-change="user.createdate=$event"></Date-Picker>
            </form-item>

        </i-form>
    </Modal>




    <page :total="pageResult.total" <%--总页数--%>
          :current.sync="pageNo"  <%--当前页--%>
          :page-size="pageSize"     <%--每页条数--%>
          @on-change="searchUserList"   <%-- 页码改变的回调，返回改变后的页码 --%>
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
                {type: 'selection',width: 60,align: 'center'},
                {key:"usercode",title:"代号",width: 80},
                {key:"username",title:"名称",width: 120},
                {slot:"sex",title:"性别",width: 70},
                {key:"birthday",title:"生日",width: 120},
                {key:"phone",title:"手机",width: 138},
                {slot:"roleName",title:"角色名称",width: 130},
                {slot:"attachPath",title:"工作照",width: 120},
                {key:"address",title:"地址",width: 70},
                {slot:"idCard",title:"身份证号",width: 200},
                {slot:"action",title:"操作",width:166}
            ],
            myColumns2:[
                {type: 'selection',width: 80,align: 'center'},
                {key:"roleName",title:"角色名称"},
                {key:"modifyBy",title:"操作人"},
            ],
            pageResult:{
                rows:[],
                tatal:0
            },
            userVo:{},
            roleList:[],
            pageNo:1,
            pageSize:5,
            graideFlag:false,
            tableSelection:[],
            tableSelection2:[],
            graintId:0,
            graintRoleId:0,
            addFlag:false,
            updateFlag:false,
            user:{},
            //图片预览功能的实现
            img:null,

        },
        mounted(){
            this.searchUserList();
            this.searchRoleList();
        },
        methods:{
            searchUserList(){
                axios.get(`${ctx}/sys/user/page/${this.pageNo}/${this.pageSize}`,{params:this.userVo})
                    .then(({data})=>{
                        this.pageResult=data.result;
                        // console.log(this.pageResult)
                    })
            },
            searchRoleList(){
                axios.get(`${ctx}/sys/role/list`)
                    .then(({data})=>{
                        this.roleList=data.result;
                    })
            },
            changePageSize(pageSize){
                this.pageSize=pageSize;
                this.searchUserList();
            },
            //添加准备
            toAdd(){
                //帮助表单输入初始化
                this.user = {};
                this.addFlag=true;
            },
            //添加车辆
            doAdd(){
                console.log(this.user);
                axios.post(`${ctx}/sys/user/doAdd`,this.user)
                    .then(({data})=>{
                        //接收返回添加成功或者添加失败的返回值
                        iview.Message.success({content:data.msg});
                        //刷新数据
                        this.searchUserList();
                    })
            },
            //修改准备
            toUpdate(row){
                //帮助表单输入初始化
                this.user = row;
                this.updateFlag=true;
            },
            //修改
            doUpdate(row){
                console.log(this.user);
                axios.post(`${ctx}/sys/user/doUpdate`,this.user)
                    .then(({data})=>{
                        //接收返回添加成功或者添加失败的返回值
                        iview.Message.success({content:data.msg});
                        //刷新数据
                        this.searchUserList();
                    })
            },

            //删除用户
            del(row){
                let _this=this;
                let flag = iview.Modal.confirm({
                    title:"您确定要删除该用户吗?",
                    content:"改操作不可逆,请谨慎操作.",
                    onOk(){
                        console.log(row.id);
                        axios.get(`${ctx}/sys/user/del?id=${row.id}`)
                            .then(({data})=>{
                                // this.addFlag = false;
                                iview.Message.success({content:data});
                                _this.searchUserList();
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
                console.log(response);  //上传工作照会返回一个图片的信息
                this.user.attachPath=response.result.attachPath;  //给需要修改的数据库指定的数据赋值
                iview.Message.success("上传成功！");
            },

        },

    });
</script>
</body>
</html>
