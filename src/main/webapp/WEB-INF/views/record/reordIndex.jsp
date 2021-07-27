<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/jquery-ui"></script>
<link
	href="http://www.francescomalagrino.com/BootstrapPageGenerator/3/css/bootstrap-combined.min.css"
	rel="stylesheet" media="screen">
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="${pageContext.request.contextPath}/css/Record/record_index.css"
	rel="stylesheet">

<title>成果記錄日誌</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<br>
		<section id="offer">
			<div style="background-color: #C9D8BF; text-align: center;">
				<div style="margin: 5% auto;">
					<h1 style="color: #1d3b2a; font-family: Caudex;">So Record</h1>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						這邊成果紀錄日誌，是專為有心以健康的方式減重的人設計的。主要是記錄前10筆，希望從「飲食控制」和「多做運動」雙管齊下，達成健康減重的目標。</p>

					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						當你記錄完日記，立刻針對你記錄的內容做小小分析，將這些分析當作之後數個星期的改進。每天記錄減重日記，讓你更清楚每天體重和生理的變化。</p>
				</div>
			</div>
		</section>
	<div id='mainWrapper2'>
		<section>
			<br>
			<div>
				<ul id="uk_breadcrumb">
					<li><a href='<c:url value='/'></c:url>'>首頁</a></li>
					<li>&emsp;&frasl;&emsp;成果記錄</li>
				</ul>
			</div>
			<hr>
			<h4 style="color:#3DCA79;font-weight: bold;">一、BMI成果記錄圖表</h4>
			<div id="linechart">
				<canvas id="myChart2"
					style="display: block; box-sizing: border-box; height: 300px; width: 1200px;"></canvas>
			</div>
			<br>
			<h4 style="color:#E800E8;font-weight: bold;">二、體重成果記錄圖表</h4>
			<div id="linechart">
				<canvas id="myChart3"
					style="display: block; box-sizing: border-box; height: 300px; width: 1200px;"></canvas>
			</div>
			<br>
			<h4 style="color:#00AEAE;font-weight: bold;">三、成果記錄列表</h4>  
			<div class="main">
			<table border='1' cellpadding="3" cellspacing="1">
				<tr>
					<th width='100'>日誌ID</th>
					<th width='100'>會員ID</th>
					<th width='100'>身高</th>
					<th width='100'>體重</th>
					<th width='100'>BMI</th>
					<th width='100'>日期</th>
					<th colspan='2' width='72'>資料維護</th>
				</tr>
				<c:forEach var='record' items='${recordBean}'>
					<tr>
						<td style="text-align: center">${record.recordId}</td>
						<td style="text-align: center">${record.customerBean.customerName}</td>
						<td style="text-align: center">${record.recordHeight} 公分</td>
						<td style="text-align: center">${record.recordWeight} 公斤</td>
						<td style="text-align: center">${record.recordBmi}</td>
						<td style="text-align: center">${record.recordDate}</td>

						<td><a href="<c:url value='/recordController/addRecord'/>"><button>新增日誌</button></a></td>
						<td><a class='deleteSportMap'
							href="<c:url value='/recordController/deleteRecord/${record.recordId}' />"><button>刪除</button></a></td>
					</tr>
				</c:forEach>


			</table>
			</div>
			<br>

			<div>
				
<%-- 				<a href="<c:url value='/recordController/getAllRecords'/>"><button>所有日誌</button></a>  --%>
<%-- 				<a href="<c:url value='/recordController/record/getRecordByCustomerId'/>"><button>會員日誌</button></a> --%>
			</div>


			<form method='POST'>
				<input type='hidden' name='_method' value='DELETE'>
			</form>

		</section>
	</div>
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />

	<script>
		var xmlhttp = new XMLHttpRequest();
		var url = "http://localhost:8080/soeasy/recordController/record/getTop10RecordByCustomerId.json";
		xmlhttp.open("GET", url, true);
		xmlhttp.send();

		xmlhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var data = JSON.parse(this.responseText);
				console.log(data);

				var recordBmi = data.map(function(elem) {
					return elem.recordBmi;
				});
				console.log(recordBmi);

				var recordDate = data.map(function(elem) {
					return elem.recordDate;
				});
				console.log(recordDate);

				var recordWeight = data.map(function(elem) {
					return elem.recordWeight;
				});
				console.log(recordWeight);

				var ctx = document.getElementById('myChart2');
				var myChart = new Chart(ctx, {
					type : 'line',
					data : {
						labels : recordDate,
						datasets : [ {
							label : 'BMI',
							data : recordBmi,
							fill : false,
							borderColor : '#3DCA79',
						} ]

					},
				});

				var ctx = document.getElementById('myChart3');
				var myChart = new Chart(ctx, {
					type : 'line',
					data : {
						labels : recordDate,
						datasets : [ {
							label : '體重',
							data : recordWeight,
							fill : false,
							borderColor : '#E800E8',
						} ]
					},
				});
			}
		}

		$(document).ready(function() {
			$('.deleteSportMap').click(function() {
				if (confirm('確定刪除此筆紀錄? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

					console.log(href);
				}
				return false;

			});
		})

		// 		var ctx = document.getElementById('myChart2');
		// 		var myChart = new Chart(ctx, {
		// 			type : 'line',
		// 			data : {
		// 				labels : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月' ],
		// 				datasets : [ {
		// 					label : 'BMI',
		// 					data : [ 20, 18.6, 18, 17.8, 17.5, 17.1, 16.9 ],
		// 					fill : false,
		// 					borderColor : '#3DCA79',
		// 				} ]
		// 			},
		// 		});
	</script>
</body>
</html>