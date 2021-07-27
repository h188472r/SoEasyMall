<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增營養師</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />
	<section>
		<img
			src="${pageContext.request.contextPath}/images/nutritionist/nutritionistHeader.png"
			width="100%" height="100%">
	</section>
	<div>
		<fieldset style="width: 900px;">
			<legend>新增營養師</legend>
			<form:form method="POST" action="addNutritionist"
				modelAttribute="nutritionistBean" enctype='multipart/form-data'>
				<table>
					<tr>
						<td>營養師姓名 :</td>
						<td width='600'><form:input path='nutritionistName'
								type="text" /> <form:errors path="nutritionistName"
								cssClass="error" /></td>
					</tr>
					<tr>
						<td>營養師性別：</td>
						<td width='600'><form:radiobuttons path='nutritionistGender'
								items="${genderMap}" /> <form:errors path="nutritionistGender"
								cssClass="error" /></td>
					</tr>
					<tr>
						<td>營養師學位 :</td>
						<td width='600'><form:input path='nutritionistDegree'
								type="text" /> <form:errors path="nutritionistDegree"
								cssClass="error" /></td>
					</tr>
					<tr>
						<td>營養師 E-mail :</td>
						<td width='600'><form:input path='nutritionistEmail'
								type="text" /> <form:errors path="nutritionistEmail"
								cssClass="error" /></td>
					</tr>
					<tr>
					<tr>
						<td>營養師專長 :</td>
						<td><form:select
								path='nutritionistCategoryBean.nutritionistCategoryId'>
								<form:option label="請挑選" value="-1" />
								<form:options items="${nutritionistCategoryList}"
									itemLabel='nutritionistCategoryName'
									itemValue='nutritionistCategoryId' />
							</form:select> <form:errors path="nutritionistCategoryBean" cssClass="error" /></td>

					</tr>
					<tr>
						<td>營養師圖片：</td>
						<td width='600'><form:input path='nutritionistMultiImg'
								type="file" /> <form:errors path="nutritionistMultiImg"
								cssClass="error" /></td>
					</tr>
					<tr>
						<td><input type='submit'></td>
					<tr>
				</table>
			</form:form>
		</fieldset>
	</div>


	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />

</body>
</html>