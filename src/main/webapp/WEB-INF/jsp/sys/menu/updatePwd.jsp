<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>修改密码</title>
    <%@include file="/common/head.jsp"%>
    <style>
        .form{
            padding: 0 30px;
            width: 300px;
            height: 350px;
            position: absolute;
            left: 50%;
            top: 50%;
            margin: -150px 0 0 -150px;
            box-sizing: border-box;
            background: #fff;
            border-radius: 5px;
            /*box-shadow: 0 0 50px #009688;*/

        }
        .btn{
            height: 38px;
            line-height: 38px;
            padding: 0 18px;
            /*background-color: #009688;*/
            color: white;
            width: 100px;
        }
    </style>
</head>
<body>

<div id="root">
        <i-form method="post" class="form">
            <alert type="error" show-icon v-show="flag">{{msg}}</alert>
            <form-item>
                <i-input prefix="ios-lock" size="large" placeholder="旧密码" v-model="passwordOld" name="passwordOld" type="password"></i-input>
            </form-item>
            <form-item>
                <i-input prefix="ios-lock" size="large" name="password" v-model="passwordNew" placeholder="新密码" type="password"></i-input>
            </form-item>
            <form-item >
                <i-button   class="btn" type="primary" @click="updatePwd" style="margin-left: 63px">修改</i-button>
            </form-item>
        </i-form>
</div>
<script>
    new Vue({
        el:'#root',
        data:{
            passwordNew:'',
            passwordOld:'',
            msg:'',
            flag:false,
        },
        methods:{
            updatePwd(){
                console.log(${user.password})
                console.log(this.passwordNew)
                if(this.passwordOld==${user.password}){
                    axios.get(`${ctx}/car/sys/user/updatePwd`,{params:{pwdNew:this.passwordNew,userid:${user.id}}})
                        .then(({data})=>{
                            iview.Message.success({content:data.msg});
                            this.flag=false;
                            location.href = `${ctx}/car/logout`;
                        })
                }else{
                    this.msg="原密码错误"
                    this.flag=true;
                }

            }
        }
    })
</script>

</body>
</html>
