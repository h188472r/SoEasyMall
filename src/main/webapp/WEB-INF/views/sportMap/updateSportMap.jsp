<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form" %>

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

<title>單筆運動地點</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
</head>
<body>

	<div id="">
		<fieldset style="width:700px;">
		
			<legend>更新資料</legend>
			<form:form method="POST" modelAttribute="sportMapBean" enctype='multipart/form-data'>
			<table >
			
				<tr>
				<td>分類：</td>
				<td>
				<form:select path="sportCategoryBean">
				<form:option value="-1" label="請挑選" />
				<form:options items="${sportCategoryBeanList}" 
				itemLabel='sportCategoryName' itemValue='sportCategoryId'/>
				</form:select>
				<form:errors path="sportCategoryBean" cssClass="error" />
				</td>				
				</tr>
				<tr>
				
				<td>運動地點名稱：</td>
				<td width ='200'><form:input path='sportMapName' readonly='readonly'/><br>
				<form:errors path='sportMapName' cssClass="error"/>	
				</tr>
				<tr>
				
				<td>地址：</td>
				<td width ='200'><form:input path='sportMapAddress'/><br>
				<form:errors path='sportMapAddress' cssClass="error"/>	
				
				</tr>
				<tr>
				<td>地點簡介：</td>
				<td width ='200'><form:input path='sportMapInfo'/><br>
				<form:errors path='sportMapInfo' cssClass="error"/>	
				
				</tr>
				<tr>
				<td>地圖：</td>
				<td width ='200'><form:input path='sportMapMap'/><br>
				<form:errors path='sportMapMap' cssClass="error"/>		
								
				</tr>
				
				 
	   			<tr>
	    		<td>
	      		<input type='submit'>
        		</td>
	   			</tr>
				
			</table>
		</form:form>
			
			
			

			
				
		</fieldset><br>
	
	
	</div>
	<a href="<c:url value='/sportMapController/displaySportMaps' />"><button>所有運動地點</button></a>
	


</body>
</html>