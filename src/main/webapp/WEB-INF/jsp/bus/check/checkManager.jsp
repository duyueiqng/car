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
            <i-button type="success" @click="doAdd">添加检查单</i-button>
        </card>

    </Collapse>
    <i-table :columns="myColumns" :data="checkedList" border stripe >
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
            editObj:{
                editIndex:-1,
                editName:'',
                editProblem:'',
                editPaying:'',
                editCheckUserId:'',
                editRentId:'',
                editCheckDate:'',
                editType:false,//false:add,true:update
            },
            checktable:'',
            myColumns:[
                {key:"field",title:"反馈",
                    render(h,{row,index}){
                     if(index==_this.editObj.editIndex){
                        let vNodes=[h("i-input",{props:{value:_this.editObj.editName},on:{
                                input:(val)=>{
                                    _this.editObj.editName=val;
                                }
                            }})]
                         return h("div",vNodes)
                     }else{
                         return h("div",row.field)
                     }
                    }
                },
                {key:"problem",title:"问题",
                    render(h,{row,index}){
                        if(index==_this.editObj.editIndex){
                            let vNodes=[h("i-input",{props:{value:_this.editObj.editProblem},on:{
                                    input:(val)=>{
                                        _this.editObj.editProblem=val;
                                    }
                                }})]
                            return h("div",vNodes)
                        }else{
                            return h("div",row.problem)
                        }
                    }
                },
                {key:"paying",title:"赔偿金额",
                    render(h,{row,index}){
                        if(index==_this.editObj.editIndex){
                            let vNodes=[h("i-input",{props:{value:_this.editObj.editPaying},on:{
                                    input:(val)=>{
                                        _this.editObj.editPaying=val;
                                    }
                                }})]
                            return h("div",vNodes)
                        }else{
                            return h("div",row.paying)
                        }
                    }
                },
                {key:"checkUserId",title:"检查者",
                    render(h,{row,index}){
                        if(index==_this.editObj.editIndex&&_this.editObj.editType==false){
                            let vNodes=[h("i-input",{props:{value:_this.editObj.editCheckUserId},on:{
                                    input:(val)=>{
                                        _this.editObj.editCheckUserId=val;
                                    }
                                }})]
                            return h("div",vNodes)
                        }else{
                            return h("div",row.checkUserId)
                        }
                    }
                },
                {key:"checkDate",title:"检查时间",
                    render(h,{row,index}){
                        if(index==_this.editObj.editIndex&&_this.editObj.editType==false){
                            let vNodes=[h("Date-Picker",{props:{value:_this.editObj.editCheckDate,type: 'datetime',format:"yyyy-MM-dd HH:mm", },on:{
                                    'on-change': (val) => {
                                        _this.editObj.editCheckDate = val;
                                    }
                                }})]
                            return h("div",vNodes)
                        }else{
                            return h("div",row.checkDate)
                        }
                    }
                },
                {key:"rentId",title:"租车ID",
                    render(h,{row,index}){
                        if(index==_this.editObj.editIndex&&_this.editObj.editType==false){
                            let vNodes=[h("i-input",{props:{value:_this.editObj.editRentId},on:{
                                    input:(val)=>{
                                        _this.editObj.editRentId=val;
                                    }
                                }})]
                            return h("div",vNodes)
                        }else{
                            return h("div",row.rentId)
                        }
                    }
                },
                {title:"操作",render(h,{row,index}){
                    if(index!=_this.editObj.editIndex) {
                        let update = h("i-button",
                            {
                                props: {type: "primary"}, style: {marginRight: "20px"},
                                on: {
                                    click: () => {
                                        _this.editObj.editIndex = index;
                                        _this.editObj.editName = row.field;
                                        _this.editObj.editProblem = row.problem;
                                        _this.editObj.editPaying = row.paying;
                                        _this.editObj.editType == true;
                                    }
                                }
                            }, "修改");
                        let del = h("i-button", {props: {type: "error"},on:{
                                click:()=>{
                                    _this.toDelete(row);
                                }
                            }}, "删除")
                        return h("div", [update, del])
                    }else{
                        let ok = h("i-button",
                            {
                                props: {type: "primary"}, style: {marginRight: "20px"},
                                on: {
                                    click: () => {
                                        row.field = _this.editObj.editName;
                                        row.problem = _this.editObj.editProblem ;
                                        row.paying = _this.editObj.editPaying ;
                                        if(_this.editObj.editCheckDate!=null){
                                            row.checkDate=_this.editObj.editCheckDate
                                        }
                                        if(_this.editObj.editCheckUserId!=null){
                                            row.checkUserId=_this.editObj.editCheckUserId
                                        }
                                        if(_this.editObj.editRentId!=null){
                                            row.rentId=_this.editObj.editRentId
                                        }
                                        _this.checktable = row;
                                        if(_this.editObj.editType == true){
                                            _this.toUpdate();
                                        }else{
                                            _this.toAdd();
                                        }
                                        _this.editObj.editIndex = -1;
                                    }
                                }
                            }, "确定");
                        let cancel = h("i-button", {props: {type: "error"},on:{
                                click:()=>{
                                    _this.editObj.editIndex = -1;
                                }
                            }}, "取消")
                        return h("div", [ok, cancel])
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
            toUpdate(){
                axios.post(`${ctx}/sys/checktable/updateChecked`,this.checktable)
                    .then(({data})=>{
                        iview.Message.success({content:data.msg});
                        this.checktable=null
                    })
            },
            doAdd(){
                var addObj = {}
                Object.assign(addObj,_this.editObj)//复制editObj的属性到addObj
                _this.checkedList.push(addObj);
                // _this.findIndex(function(value){//返回元素再数组中的编号
                //     return value = addObj;
                // })
                _this.editObj.editIndex=_this.checkedList.length-1;
                console.log("增加了一行")
            },
            toAdd(){
                axios.post(`${ctx}/sys/checktable/addChecked`,this.checktable)
                    .then(({data})=>{
                        iview.Message.success({content:data.msg});
                    })
            },
            toDelete(row){
                let flag = iview.Modal.confirm({
                    title:"您确定要删除该记录吗?",
                    content:"改操作不可逆,请谨慎操作.",
                    onOk(){
                        axios.get(`${ctx}/sys/checktable/del?checkedId=${row.checkId}`)
                            .then(({data})=>{
                                iview.Message.success({content:msg});
                                _this.searchCheckedList();
                            })
                    }
                });
            }
        },

    });
</script>
</body>
</html>
