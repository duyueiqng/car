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
				text: '公司年度销售额统计',
				x:'center'
			},
			tooltip : {
				trigger: 'axis',
				axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			xAxis: {
				type: 'category',
				data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月','八月','九月','十月','十一月','十二月']
			},
			yAxis: {
				type: 'value'
			},
			series: [{
				data: data,
				type: 'line'
			}]

		});
	</script>
</body>
</html>
