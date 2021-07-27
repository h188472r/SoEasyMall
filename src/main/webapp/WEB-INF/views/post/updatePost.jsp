<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Post</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<style>
span.error {
	color: red;
	display: inline-block;
	font-size: 8pt;
}
.button{
	border: 2px #3DCA79 solid; 
	background-color:#EBFAF1;
	font-size: 25px;
	border-radius: 5px;
}
.button:hover{
	border: 1px #3DCA79 solid; 
	background-color:#3DCA79;
}
</style>
</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<hr style="color: transparent;">
	
	<div>
		<div class="container-fluid" style="width: 80%; padding: 1% 5%; border: 2px solid lightslategray; border-radius: 10px; box-shadow: 3px 3px 12px lightgrey; margin-left: 5%; margin-top: 10%; margin-bottom: 3%;">
			<div class="row-fluid" style="text-align: center;">
				<h2 style="font-size: 25px;">修改文章</h2>
		<div>
			<a href="<c:url value="/PostNeedLoginController/getPost/${postId}"></c:url>">回上一頁</a>
		</div>
			<br>
				<form:form method="POST" action="" modelAttribute="postBean" enctype='multipart/form-data'>
					<form:input path='postTitle' type="text" placeholder="文章標題..."
						style=" width: 99.7%; font-size: 50px; border: none;border-top: 3px #3DCA79 dashed; border-bottom: 3px #3DCA79 dashed;background-color: #EBFAF1; " />
					<div style="background-color: #EBFAF1; padding: 1%; text-align: left;">
						<form:errors path="postTitle" cssClass="error" style=" font-size: 15px;" />
					</div>

					<div style="display: flex; border-bottom: 3px #3DCA79 dashed; background-color: #EBFAF1">
						<div style="width: 50%; text-align: left;">
							<form:select path='postCategoryBean.postCategoryId' style=" width: 50%; font-size: 30px; border: none;background-color: #EBFAF1;">
								<form:option label="點此挑選文章類別" value="-1" style="background-color: white" />
								<form:options items="${postCategoryBeanList}" style="background-color: white;" 
								 itemLabel='postCategoryName' itemValue='postCategoryId' />
							</form:select>
							<form:errors path="postCategoryBean" cssClass="error" style="font-size: 15px;width:25%;" />
						</div>
						<div style="display:none;">
						<p>文章狀態：</p>
						<form:radiobutton path="postStatus" value="1" />正常 
						<form:radiobutton path="postStatus" value="2" />刪除文章</td>
						</div>
						<div style="width: 50%;">
							<form:input path='postMultiImg' type="file" style=" width: 50%; font-size: 25px; margin-left: -70%;" />
							<form:errors path="postMultiImg" cssClass="error" style="font-size: 15px;" />
						</div>
					</div>
					<form:textarea path='postContent' placeholder="文章內容..."
						style="width: 99.7%; height: 350px; overflow-y: scroll;font-size: 20px;border: none;background-color: #EBFAF1; border-bottom: 3px #3DCA79 dashed;" />
					<div
						style="background-color: #EBFAF1; padding: 1%; text-align: left; margin-top: -0.5%;">
						<form:errors path="postContent" cssClass="error" style="font-size: 15px;" />

					</div>
					<br>
					<input type='submit' value="Submit" class="button">
					<input type="reset" value="Reset" class="button">
				</form:form>
			</div>
		</div>
	</div>

	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />

</body>
</html>