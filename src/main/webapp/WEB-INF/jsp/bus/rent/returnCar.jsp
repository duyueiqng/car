<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>业务管理</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>
<p>当前位置 : 业务管理 / 还车 </p>
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

</div>
<script >
    new Vue({
        //挂载点
        el:"#root",
        //数据存放位置
        data:{
            //条件查询输入的条件
            user:{},
            idCard:null,
            renttable:{}
        },
        mounted(){
        },
        methods:{
            //查询user的全部数据(使用resultVo返回的方法)
            searchUserBy(){
                //get提交方法携带参数的方法{params:this.userVo}
                axios.get(`${ctx}/sys/user/getUserByCard?idCard=${this.idCard}`)
                    .then(({data})=>{
                        if (data.result!=null){
                            iview.Message.success({content:"操作成功！"});
                            this.addFlag=true;
                        }else {
                            iview.Message.error({content:"请输入正确的身份证号!"});
                        }

                    })
            },
        }
    });
</script>
</body>
</html>
