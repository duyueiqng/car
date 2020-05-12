<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<html>
<head>
    <title>角色管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 系统管理 / 角色管理 </p>
<div id="app">

    <card>
        <i-button type="success" @click="addRole">添加角色</i-button>
        <i-button type="primary" @click="toGrait">角色授权</i-button>
    </card>
    <i-table  border stripe :columns="myColumns" :data="myData" @on-selection-change="tableSelection=arguments[0]">
        <template slot-scope="{row,index}" slot="action">
            <i-button type="warning" @click="toUpdate(row)" >修改</i-button>
            <i-button type="error" @click="del(row)" >刪除</i-button>
        </template>
    </i-table>

    <modal v-model="addFlag" title="添加角色" @on-ok="add">
        <i-form  :label-width="80"  >
            <form-item label="角色代号">
                <i-input v-model="role.roleCode" />
            </form-item>
            <form-item label="角色名称">
                <i-input v-model="role.roleName" />
            </form-item>
        </i-form>
    </modal>
    <modal v-model="updateFlag" title="修改角色" @on-ok="update">
        <i-form  :label-width="80" style="padding: 30px">
            <form-item label="角色代号">
                <i-input v-model="role.roleCode" size="large"/>
            </form-item>
            <form-item label="角色名称">
                <i-input v-model="role.roleName" size="large"/>
            </form-item>
            <form-item label="修改时间">
                <date-picker type="datetime" size="large" format="yyyy-MM-dd HH:mm" v-model="role.createdate" @on-change="role.createdate=$event"/>
            </form-item>
        </i-form>
    </modal>
    <modal v-model="graideFlag" title="角色授权"  >
        <tree ref="tree" :data="treeDate" show-checkbox multiple :on-select="tableSelection"></tree>
    </modal>

</div>
<script>

    new Vue({
        el:'#app',
        data:{
            myColumns:[
                {type: 'selection',width: 60,align: 'center'},
                {title:"角色名称",key:"roleName"},
                {title:"角色代号",key:"roleCode"},
                {title:"创建时间",key:"createdate"},
                {title:"修改时间",key:"modifyDate"},
                {title:"操作",slot:"action"},
            ],
            myData:[],
            addFlag:false,
            role:{},
            updateFlag:false,
            graideFlag:false,
            treeDate:[],
            tableSelection:[]
        },
        mounted(){
            this.search();
        },
        methods:{
            search(){
                axios.get(`${ctx}/sys/role/list`)
                    .then(({data})=>{
                        this.myData=data.result;
                    })
            },
            addRole(){
                this.role={};
                this.addFlag=true;
            },
            add(){
                axios.post(`${ctx}/sys/role/add`,this.role)
                    .then(({data})=>{
                        this.addFlag=false;
                        iview.Message.success({content:data.msg});
                        this.search();
                    })
            },
            toUpdate(row){
                Object.assign(this.role,row);
                this.updateFlag=true;
            },
            update(){
                axios.post(`${ctx}/sys/role/update`,this.role)
                    .then(({data})=>{
                        this.updateFlag=false;
                        iview.Message.success({content:data.msg});
                        this.search();
                    })
            },
            del(row){
                let _this=this;
                iview.Modal.confirm({
                    title:"您确定要删除嘛？",
                    content:"该操作不可逆，请谨慎操作",
                    onOk(){     //确定点击回调函数
                        axios.get(`${ctx}/sys/role/delete?id=${row.id}`)
                            .then(({data})=>{
                                iview.Message.success({content:data.msg});
                                _this.search();
                            });
                    }
                });
            },
            toGrait(){
                if(this.tableSelection.length!=1){
                    iview.Modal.error({
                        title:"信息提示",
                        content:"您只能选择一项进行提交"
                    });
                    return ;
                }
                axios.get(`${ctx}/sys/role/searchTreeNode?id=${this.tableSelection[0].id}`)
                    .then(({data})=>{
                        this.treeDate=data.result;
                        this.graideFlag=true;
                    })
            }
        },

    });
</script>
</body>
</html>
