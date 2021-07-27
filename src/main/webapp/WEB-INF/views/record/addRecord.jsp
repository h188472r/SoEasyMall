<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<link
	href="${pageContext.request.contextPath}/css/Record/record_Add.css"
	rel="stylesheet">
<title>新增成果記錄日誌</title>
<link rel='short icon'
	href="${pageContext.request.contextPath}/favicon.ico" />
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
					<li><a href='<c:url value='/recordController/record/getRecordByCustomerId'/>'>&emsp;&frasl;&emsp;成果記錄日誌</a></li>
					<li>&emsp;&frasl;&emsp;新增</li>
				</ul>
			</div>
			<hr>
			<div>
				<fieldset
					style="width: 900px; ">
					<legend style="color:#3a7ca5;font-weight: bold;font-size: large;margin-bottom: 20px;">新增您的身高體重</legend>
					<form:form method="POST" action="addRecord"
						modelAttribute="recordBean" enctype='multipart/form-data'>
						<table>
							<tr>
								<td>您的身高？（公分） :</td>
								<td width='600'><form:input path='recordHeight' type="text" />
									<form:errors path="recordHeight" cssClass="error" /></td>
							</tr>
							<tr>
								<td>您的體重？（公斤） :</td>
								<td width='600'><form:input path='recordWeight' type="text" />
									<form:errors path="recordWeight" cssClass="error" /></td>
							</tr>
							<tr>
								<td>紀錄的日期？ （格式 : 西元年/月/日）:</td>
								<td width='600'><form:input path='recordDate' type="date" />
									<form:errors path="recordDate" cssClass="error" /></td>
							</tr>
							<tr>
								<td><input type='submit'></td>
							<tr>
						</table>
					</form:form>
				</fieldset>
			</div>
			</section>
	</div>

	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />
</body>
</html>