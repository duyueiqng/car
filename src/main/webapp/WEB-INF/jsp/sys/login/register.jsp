<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>注册</title>
    <%@include file="/common/head.jsp"%>
</head>
<body>

<div id="root">
    <card style="margin: 0 auto; width: 400px;">
        <p>客户注册</p>
        <i-form ref="formValidate" :model="formValidate" style="padding:50px;text-align:center" :label-width="80" :rules="ruleValidate">
            <c:if test="${not empty loginErr}">
                <alert type="error" show-icon>${loginErr}</alert>
            </c:if>
            <form-item label="编号" prop="usercode">
                <i-input v-model="formValidate.usercode"/>
            </form-item>
            <form-item label="姓名" prop="username">
                <i-input v-model="formValidate.username"/>
            </form-item>
            <form-item label="密码" prop="password">
                <i-input v-model="formValidate.password"/>
            </form-item>
            <form-item label="性别" prop="sex">
                <template>
                    <Radio-Group v-model="formValidate.sex">
                        <Radio label="1">男</Radio>
                        <Radio label="0">女</Radio>
                    </Radio-Group>
                </template>
            </form-item>
            <form-item label="生日" prop="birthday">
                <Date-Picker v-model="formValidate.birthday" type="date" format="yyyy-MM-dd"  ></Date-Picker>
            </form-item>
            <form-item label="身份信息" prop="idCard">
                <i-input v-model="formValidate.idCard"/>
            </form-item>
            <form-item label="手机号" prop="phone">
                <i-input v-model="formValidate.phone"/>
            </form-item>
            <form-item label="地区" prop="address">
                <i-input v-model="formValidate.address"/>
            </form-item>
            <form-item label="照片：" prop="attachPath">
                <Upload action="sys/user/upload" name="attachPath" :before-upload="doBeforeUpload" :on-success="uploadSuccess">
                    <i-button icon="ios-cloud-upload-outline">请选择...</i-button>
                </Upload>
                <div class="img" :style="{'background-image': 'url(' + img +')'}" v-if="img"></div>
            </form-item>
            <form-item prop="code">
                <div>
                    <i-input prefix="md-images" name="code" type="text" v-model="formValidate.code" placeholder="请输入验证码" style="width: 130px;margin-left:-82px"></i-input>
                    <img src="${ctx}/car/login/getCode" onclick="this.src=this.src+'?'" style="vertical-align: middle;height:40px;margin-left: 10px">
                </div>
            </form-item>
            <form-item >
                <i-button  type="primary"  style="width:40%;" @click="doAdd('formValidate')">注册</i-button>
                <i-button  type="primary"  style="width:40%;" @click="login">去登陆</i-button>
            </form-item>

        </i-form>
    </card>
</div>
<script>
    new Vue({
        el:'#root',
        data:{
            user:{},
            //图片预览功能的实现
            img:null,
            formValidate:{
                usercode:'',
                username:'',
                password:'',
                sex:'',
                birthday:'',
                idCard:'',
                phone:'',
                address:'',
                code:''
            },
            ruleValidate: {//表单验证
                usercode: [
                    { required: true, message: '用户代号不能为空', trigger: 'blur' }
                ],
                username: [
                    { required: true, message: '用户姓名不能为空', trigger: 'blur' },
                ],
                password: [
                    { required: true, message: '密码不能为空', trigger: 'blur' },
                    { type: 'string', min:6 ,max:10, message: '密码大于6位小于10位', trigger: 'blur' }
                ],
                sex: [
                    { required: true, message: '用户性别不能为空', trigger: 'change' }
                ],
                birthday: [
                    { required: true, type: 'date', message: '用户生日不能为空', trigger: 'change' }
                ],
                idCard: [
                    { required: true, type: 'string', message: '身份证号不能为空', trigger: 'change' },
                    { type: 'string', min:18 ,max:18,equals:18, message: '身份证号必须为18位', trigger: 'blur' }
                ],
                phone: [
                    { required: true, message: '手机号不能为空', trigger: 'blur' },
                    { type: 'string', min: 11, max: 11, message: '手机号必须为11位', trigger: 'blur' }
                ],
                address: [
                    { required: true, message: '地区不能为空', trigger: 'blur' },
                ],
                code: [
                    { required: true, message: '验证码不能为空', trigger: 'blur' },
                    { type: 'string', max: 4,min:4, message: '验证码为4位字符', trigger: 'blur' }
                ]
            },
            time: 0
        },
        methods:{
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
            //添加用户
            doAdd(name){
                console.log(this.user);
                this.$refs[name].validate((valid) => {
                    if (valid) {
                        // this.$Message.success('验证成功!');
                        Object.assign(this.user,this.formValidate)
                        this.user.birthday=moment(this.user.birthday).format("YYYY-MM-DD");
                        axios.post(`${ctx}/car/sys/user/registAdd`,this.user)
                            .then(({data})=>{
                                //接收返回添加成功或者添加失败的返回值
                                iview.Message.success({content:data.msg+"5s后自动跳转登录页面",duration: 5});
                            })
                    } else {
                        this.$Message.error('验证失败!');
                    }
                })

            },
            login(){
                window.location.href="${ctx}/car/login"
            }
        }
    })
</script>

</body>
</html>
