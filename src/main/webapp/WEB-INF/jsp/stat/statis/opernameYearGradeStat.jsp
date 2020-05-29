<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>业务员年度统计</title>
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
					<form-item label="用户:">
						<i-input type="text" v-model="userId"/>
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
                userId : '',
                myChart : null,
                mydata: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
				myColumnData : null,
			},
			methods : {
			    searchInfoList(){

                    axios.get(`${request.getContextPath()}/car/statists/userList?year=`+this.year+`&userId=`+this.userId)
                        .then(({data})=>{
                            this.myColumnData=data.result
                            this.drawLine()
                        })
				},
                drawLine(){
                    // 基于准备好的dom，初始化echarts实例
                    let myChart = echarts.init(document.getElementById('container'))
                    // 绘制图表
                    myChart.setOption({
                        title: {
                            text: '年度业务员销售额统计',
                            x: 'center'
                        },
                        color: ['#3398DB'],
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                            }
                        },
                        grid: {
                            left: '3%',
                            right: '4%',
                            bottom: '3%',
                            containLabel: true
                        },
                        xAxis: [
                            {
                                type: 'category',
                                data: this.mydata,
                                axisTick: {
                                    alignWithLabel: true
                                }
                            }
                        ],
                        yAxis: [
                            {
                                type: 'value'
                            }
                        ],
                        series: [
                            {
                                name: '销售额',
                                type: 'bar',
                                barWidth: '60%',
                                data: this.myColumnData
                            }
                        ]
                    });
                }

			},
			mounted(){

			    var date = new Date();
			    if (this.year.value ==null ){
			        this.year=date.getFullYear();
				}
                this.searchInfoList()

			}
		})
	</script>
</body>
</html>
