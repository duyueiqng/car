<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>日志管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 系统管理 / 日志管理 </p>
<div id="root">
    <%--下拉框--%>
    <Collapse value="search">
        <Panel name="search">
            条件查询
            <p slot="content">
                <i-form inline :label-width="80">
                    <form-item label="登陆名称:">
                        <i-Input   type="text" v-model="logInfoVo.loginname"></i-Input>
                    </form-item>
                    <form-item label="登陆IP:">
                        <i-Input  type="text" v-model="logInfoVo.loginip"></i-Input>
                    </form-item>
                    <form-item label="开始时间:">
                        <Date-Picker type="datetime" format="yyyy-MM-dd HH:mm" @on-change="logInfoVo.startTime=$event"></Date-Picker>
                    </form-item>
                    <form-item label="结束时间:">
                        <Date-Picker type="datetime" format="yyyy-MM-dd HH:mm" @on-change="logInfoVo.endTime=$event"></Date-Picker>
                    </form-item>
                    <form-item >
                        <i-Button  type="primary" @click="searchAll()" style="text-align: center">搜索</i-Button>
                    </form-item>
                </i-form>
            </p>
        </Panel>
    </Collapse>
    <card>
        <%--<shiro:hasPermission name="car:add">--%>
            <i-button type="success" @click="toBatchDel">批量删除</i-button>
        <%--</shiro:hasPermission>--%>
    </card>
    <i-table  border stripe :columns="myColumns" :data="myData" @on-selection-change="tableSelection=arguments[0]" :height="380">
        <template slot-scope="{row,index}" slot="action">
            <%--<shiro:hasPermission name="role:del">--%>
                <i-button type="error"  @click="del(row)" >刪除</i-button>
            <%--</shiro:hasPermission>--%>
        </template>
    </i-table>

</div>
<script>
    new Vue({
        el:'#root',
        data:{
            logInfoVo : {
                startTime : '',
                endTime : '',
                loginname : '',
                loginip : ''
            },
            myColumns:[
                {type: 'selection',width: 60,align: 'center'},
                {title:"登录名",key:"loginname"},
                {title:"登录Ip",key:"loginip"},
                {title:"登录时间",key:"logintime"},
                {title:"操作",slot:"action"},
            ],
            myData : [],
            tableSelection:[],
            // ids : [],
        },
        methods:{
            searchAll(){
                axios.get(`${ctx}/sys/logInfo/getAll`,{params:this.logInfoVo})
                    .then(({data})=>{
                        this.myData=data.result;
                    })
            },
            del(row){
                let _this=this;
                iview.Modal.confirm({
                    title:"您确定要删除嘛？",
                    content:"该操作不可逆，请谨慎操作",
                    onOk(){     //确定点击回调函数
                        axios.get(`${ctx}/sys/logInfo/deleteLog?id=${row.id}`)
                            .then(({data})=>{
                                iview.Message.success({content:data.msg});
                                this.searchAll();
                            });
                    }
                });
            },
            toBatchDel(){
                if(this.tableSelection.length<=1){
                    iview.Modal.error({
                        title:"信息提示",
                        content:"您必须选择多项项进行删除"
                    });
                    return ;
                }
                let str= this.tableSelection.map(node=>"ids="+node.id).join("&");
                console.log(str)
                axios.get(`${ctx}/sys/logInfo/deleteBatchLog?${str}`)
                    .then(({data})=>{
                        iview.Message.success({content:data.msg});
                        this.searchAll();
                    })
            }
        },
        mounted(){
            this.searchAll()
        }
    })
</script>

</body>
</html>
