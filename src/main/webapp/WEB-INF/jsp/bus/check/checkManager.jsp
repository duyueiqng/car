<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<html>
<head>
    <title>员工管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 基础管理 / 检查单管理 </p>
<div id="root">
    <Collapse value="search">
        <Panel name="search">
            条件查询
            <p slot="content">
                <i-form  inline :label-width="80">
                    <form-item label="检查单号:" >
                        <i-input type="text" v-model="checkedVo.id" />
                    </form-item>
                    <form-item label="出租单号:" >
                        <i-input type="text" v-model="checkedVo.rentId" />
                    </form-item>
                    <form-item label="存在问题:" >
                        <i-input type="text" v-model="checkedVo.problem" />
                    </form-item>
                    <form-item label="开始时间:" >
                        <Date-Picker v-model="checkedVo.startTime" type="datetime" format="yyyy-MM-dd HH:mm"  @on-change="user.createdate=$event"></Date-Picker>
                    </form-item>
                    <form-item label="结束时间:" >
                        <Date-Picker v-model="checkedVo.endTime" type="datetime" format="yyyy-MM-dd HH:mm"  @on-change="user.createdate=$event"></Date-Picker>
                    </form-item>
                    <form-item>
                        <i-button @click="searchCheckedList">搜索</i-button>
                    </form-item>
                </i-form>
            </p>
        </Panel>
        <card>
            <i-button type="success" @click="toAdd">添加检查单</i-button>
        </card>

    </Collapse>
    <i-table :columns="myColumns" :data="checkedList" border stripe >
        <%--<template slot-scope="{row,index}" slot="action">--%>
            <%--<i-button type="warning" >修改</i-button>--%>
            <%--<i-button type="error">刪除</i-button>--%>
        <%--</template>--%>
    </i-table>


</div>
<script >
    var _this;
    new Vue({
        el:"#root",
        created(){
            _this=this;
        },
        data:{
            editIndex:-1,
            editName:'',
            myColumns:[
                {key:"field",title:"反馈",
                    render(h,{row,index}){
                     if(index==_this.editIndex){
                        let vNodes=[h("i-input",{props:{value:_this.editName},on:{
                                input:(val)=>{
                                    _this.editName=val;
                                }
                            }})]
                         return h("div",vNodes)
                     }else{
                         return h("div",row.field)
                     }
                    }
                },
                {key:"problem",title:"问题"},
                {key:"paying",title:"赔偿金额"},
                {key:"checkUserId",title:"检查者"},
                {key:"rentId",title:"租车ID"},
                {title:"操作",render(h,{row,index}){
                    if(index!=_this.editIndex) {

                        let update = h("i-button",
                            {
                                props: {type: "primary"}, style: {marginRight: "20px"},
                                on: {
                                    click: () => {
                                        _this.editIndex = index;
                                        console.log(row)
                                        _this.editName = row.field;
                                    }
                                }
                            }, "修改");
                        let del = h("i-button", {props: {type: "error"},}, "删除")
                        return h("div", [update, del])
                    }else{
                        let update = h("i-button",
                            {
                                props: {type: "primary"}, style: {marginRight: "20px"},
                                on: {
                                    click: () => {
                                        _this.editIndex = index;
                                        _this.editName = row.field;
                                        console.log(this.row)
                                    }
                                }
                            }, "确定");
                        let del = h("i-button", {props: {type: "error"},}, "取消")
                        return h("div", [update, del])
                    }
                    }}
            ],
            checkedVo:{},
            checkedList:[],


        },
        mounted(){
            this.searchCheckedList();
        },
        methods:{
            searchCheckedList(){
                axios.get(`${ctx}/sys/checktable/searchCheckedList`,{params:this.checkedVo})
                    .then(({data})=>{
                        this.checkedList=data.result;
                    })
            },
            toAdd(){

            }
        },

    });
</script>
</body>
</html>
