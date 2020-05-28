<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>年度统计</title>
	<%@include file="/common/head.jsp"%>
	<script type="text/javascript" src="js/echarts.js"></script>
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
                month : '',
                myChart : null,
                mydata: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
				myColumnData : null,
			},
			methods : {
			    searchInfoList(){

                    axios.get(`${request.getContextPath()}/car/statists/carlist?year=`+this.year+`&month=`+this.month)
                        .then(({data})=>{
                            this.myColumnData=data.result
                            this.drawLine()
                            // option = {
                            //     title: {
                            //         text: '公司年度销售额统计',
                            //         x: 'center'
                            //     },
                            //     tooltip: {
                            //         trigger: 'axis',
                            //         axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            //             type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                            //         }
                            //     },
                            //     xAxis: {
                            //         type: 'category',
                            //         data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
                            //     },
                            //     yAxis: {
                            //         type: 'value'
                            //     },
                            //     series: [{
                            //         data: data,
                            //         type: 'line'
                            //     }]
                            // };
                        })

				},
                drawLine(){
                    // 基于准备好的dom，初始化echarts实例
                    let myChart = echarts.init(document.getElementById('container'))
                    // 绘制图表
                    myChart.setOption({
                        title: { text: '公司年度销售额统计', x: 'center'},
                        tooltip: {},
                        xAxis: {
                            // type: 'category',
                            data: this.mydata
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            name: '销售额',
                            type: 'bar',
                            data: this.myColumnData
                        }]
                    });
                }

			},
			mounted(){

			    var date = new Date();
			    if (this.year.value ==null ){
			        this.year=date.getFullYear();
				}
                if (this.month.value==null ){
                    this.month=date.getMonth()+1;
                }
                this.searchInfoList()

			}
		})
	</script>
</body>
</html>
