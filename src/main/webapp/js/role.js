new Vue({
    el:'#root',
    data:{
        mycolumns:[
            {title:"角色名称",key:"roleName"},
            {title:"角色代号",key:"roleCode"},
            {title:"创建时间",key:"creationDate"},
            {title:"修改时间",key:"modifyDate"}
        ],
        mydata:[]
    },
    // mounted(){}
    // mounted:function(){
    //     axios.get(`${}`)
    // }
});