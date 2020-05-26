<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>租车统计</title>
		<%@include file="/common/head.jsp"%>
		<script src="js/highcharts.js"></script>
		<script src="js/module/exporting.js"></script>
		<script src="js/module/series-label.js"></script>
	</head>
<body>
<div id="app">
	<Collapse value="search">
		<Panel name="search">
			条件查询
			<p slot="content">
				<i-form  inline :label-width="80">
					<form-item label="年份:">
						<i-input type="text" v-model="year"/>
					</form-item>
					<form-item>
						<i-button @click="searchInfoList">搜索</i-button>
					</form-item>
				</i-form>
			</p>
		</Panel>
	</Collapse>
	<div id="container" style="width: 600px;height:400px;margin: auto"></div>
</div>


	<script type="text/javascript">
		new Vue({
			el : '#app',
			data : {
                year : '',
                month : ''
			},
			methods : {
			    searchInfoList(){

                    axios.get(`${request.getContextPath()}/car/statists/carlist?year=`+this.year+`&month=`+this.month)
                        .then(({data})=>{
                            this.pageResult=data.result;
                            console.log(this.data.result)
                        })
				},

			},
			mounted(){

			    var date = new Date();
			    if (this.year.value ==null ){
			        this.year=date.getFullYear();
				}
                if (this.month.value==null ){
                    this.month=date.getMonth()+1;
                }
                this.searchInfoList();
			}
		}),
		Highcharts.chart('container', {

			title : {
				text : '${year } 年 各 月 份 汽 车 未  还 情 况'
			},

			//副标题
			subtitle : {
				text : '资源: MYSQL'
			},
            // y 轴标题
			yAxis : {
				title : {
					text : '数量'
				}
			},
            xAxis : {
                categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
                plotbands:[{//可以显示一个方块，如果需要的话可以更改透明度和颜色
                    from:4.5,
                    to:6.5,
                    // color:rgba(68,170,213,0)//透明度和颜色
       		 }],
            },
			// legend : {
			// 	layout : 'vertical',
			// 	align : 'right',
			// 	verticalAlign : 'middle'
			// },


			// 数据列 [{},{}] json格式
			<%--series : ${strformat},--%>
            series: [{                              // 数据列
                name: '小明',                        // 数据列名
                data: [1, 0, 4]                     // 数据
            }, {
                name: '小红',
                data: [5, 7, 3,6,7,8,8,8,8,1,2,2]
            }],
			// responsive : {
			// 	rules : [ {
			// 		condition : {
			// 			// maxWidth : 500
			// 		},
			// 		chartOptions : {
			// 			legend : {
			// 				layout : 'horizontal',
			// 				align : 'center',
			// 				verticalAlign : 'bottom'
			// 			}
			// 		}
			// 	} ]
			// }

		});
	</script>
</body>
</html>
