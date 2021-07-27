<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
span.error {
	color: red;
	display: inline-block;
	font-size: 8pt;
}

</style>



<title>新增運動地點</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>

	<jsp:include page="/fragment/header.jsp" />
	<a href="<c:url value='/sportMapController/displaySportMaps' />"><button>所有運動地點</button></a>
	<div>
		<fieldset style="width: 900px;">
			<legend>新增運動地圖</legend>
			<form:form method="POST" action ="add" modelAttribute="sportMapBean"
				enctype='multipart/form-data'>
			<table>
				<tr>
				<td>運動分類</td>
				<td>
				<form:select path='sportCategoryBean.sportCategoryId'>
					<form:option label="請挑選" value="-1"/>
					<form:options items="${sportCategoryBeanList}"
					itemLabel='sportCategoryName' itemValue='sportCategoryId'/> 
				</form:select> 
				<form:errors path="sportCategoryBean" cssClass="error"/>  
				</td>		
				
				</tr>
				<tr>
					<td>運動地點名稱：</td>
					<td width='600'><form:input path='sportMapName' /> 
					<form:errors path="sportMapName" cssClass="error" />
					</td>
				</tr>	
				<tr>
					<td>地址：</td>
					<td width='600'><form:input path='sportMapAddress' /> 
					<form:errors path="sportMapAddress" cssClass="error" />
					</td>
				</tr>
				<tr>
					<td>地點簡介：</td>
					<td width='600'><form:input path='sportMapInfo' /> 
					<form:errors path="sportMapInfo" cssClass="error" />
					</td>
				<tr>	
					<td>地圖：</td>
					<td width='600'><form:input path='sportMapMap' /> 
					<form:errors path="sportMapMap" cssClass="error" />
					</td>
				</tr>
				<tr>
				<td>
					<input type='submit'>
				</td>
				<tr>

			</table>
			</form:form>

		</fieldset>

	</div>
	
	<jsp:include page="/fragment/footer.jsp" />
	

</body>
</html>