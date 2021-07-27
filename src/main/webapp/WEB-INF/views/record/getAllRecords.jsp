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
<title>查詢全部營養師列表</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<style>
#mainWrapper2 {
	width: 80%;
	padding-left: 10%;
	padding-right: 10%;
}

body * {
	font-family: '微軟正黑體';
}

#uk_breadcrumb {
	flex-wrap: wrap;
	list-style: none;
	display: flex;
	font-size: 18px;
}

#uk_breadcrumb li a {
	text-decoration: none;
}

#h3css {
	font-family: '微軟正黑體';
	color: #FF4D00;
}

#h3css2 {
	font-family: '微軟正黑體';
	color: #007FFF;
}

#pcss {
	font-family: '微軟正黑體';
	color: #B22222;
}

#linechart {
	width: 1200px;
	height: 300px;
}

.thumbnail {
	float: left;
	width: 320px;
	margin-left: 30px;
	margin-right: 25px;
	margin-top: 30px;
}

.page-icon {
	margin: 20px 0 0 0;
	/*設置距離頂部20像素*/
	font-size: 0;
	/*修復行內元素之間空隙間隔*/
	text-align: center;
	/*設置內容居中顯示*/
}

/*設置共有的的樣式佈局，主要是進行代碼優化，提高運行效率*/
.page-icon a, .page-disabled, .page-next {
	border: 1px solid #ccc;
	border-radius: 3px;
	padding: 4px 10px 5px;
	font-size: 14PX;
	/*修復行內元素之間空隙間隔*/
	margin-right: 10px;
}

/*對 a 標籤進行樣式佈局 */
.page-icon a {
	text-decoration: none;
	/*取消鏈接的下劃線*/
	color: #005aa0;
}

.page-current {
	color: #ff6600;
	padding: 4px 10px 5px;
	font-size: 14PX;
	/*修復行內元素之間空隙間隔*/
}

.page-disabled {
	color: #ccc;
}

.page-next i, .page-disabled i {
	cursor: pointer;
	/*設置鼠標經過時的顯示狀態，這裏設置的是顯示狀態爲小手狀態*/
	display: inline-block;
	/*設置顯示的方式爲行內塊元素*/
	width: 5px;
	height: 9px;
	background-image:
		url(http://img.mukewang.com/547fdbc60001bab900880700.gif);
	/*獲取圖標的背景鏈接*/
}

.page-disabled i {
	background-position: -80px -608px;
	margin-right: 3px;
}

.page-next i {
	background-position: -62px -608px;
	margin-left: 3px;
}
</style>
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<section>
		<img
			src="${pageContext.request.contextPath}/images/nutritionist/nutritionistHeader.png"
			width="100%" height="100%">
	</section>
	<div id='mainWrapper2'>
		<section>
			<br>
			<div>
				<ul id="uk_breadcrumb">
					<li><a href='<c:url value='/'></c:url>'>首頁</a></li>
					<li>&emsp;&frasl;&emsp;營養師列表</li>
				</ul>
			</div>
			<hr>
			<h4>成果記錄圖表</h4>
			<div id="linechart">
				<canvas id="myChart2" style="display: block; box-sizing: border-box; height: 300px; width: 1200px;"></canvas>
			</div>
			<h4>成果記錄列表</h4>
			
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
				<c:forEach var='record' items='${records}'>
					<tr>
						<td style="text-align: center">${record.recordId}</td>
						<td style="text-align: center">${record.customerBean.customerId}</td>
						<td style="text-align: center">${record.recordHeight}</td>
						<td style="text-align: center">${record.recordWeight}</td>
						<td style="text-align: center">${record.recordBmi}</td>
						<td style="text-align: center">${record.recordDate}</td>
						
						<td><a
							href="#">編輯</a></td>
						<td><a class='deletelink'
							href="#">刪除</a></td>
					</tr>
				</c:forEach>
			</table>

			<div class="page-icon">
				<span class="page-disabled"><i></i>上一頁</span> <span
					class="page-current">1</span> <a href="#">2</a> <a href="#">3</a> <a
					class="page-next" href="#">下一頁<i></i></a>
			</div>
			<br>

			<div>
				<a href="<c:url value='/recordController/addRecord'/>"><button>新增日誌</button></a>
<%-- 				<a href="<c:url value='/recordController/getAllRecords'/>"><button>	所有日誌</button></a> --%>
				<a href="<c:url value='/recordController/record/getRecordByCustomerId'/>"><button> 會員日誌</button></a>
			</div>


		</section>
	</div>
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
	
	<script>
		var ctx = document.getElementById('myChart2');
		var myChart = new Chart(ctx, {
			type : 'line',
			data : {
				labels : [ '一月', '二月', '三月', '四月', '五月', '六月', '七月' ],
				datasets : [ {
					label : 'BMI',
					data : [ 20, 18.6, 18, 17.8, 17.5, 17.1, 16.9 ],
					fill : false,
					borderColor : '#3DCA79',
				} ]
			},
		});
	</script>
</body>
</html>