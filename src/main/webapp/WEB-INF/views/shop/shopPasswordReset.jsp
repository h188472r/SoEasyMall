<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Forgot Password</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function(){
		let emailInput = document.getElementById("emailInput");
		let emailSubmit = document.getElementById("emailSubmit");
		let errortext = document.getElementById("errortext");
		let xhr = new XMLHttpRequest();
		
		emailSubmit.addEventListener("click", function(){
			errortext.innerHTML = "請稍後";
			xhr.open('POST', "<c:url value='/passwordResetValidate/sendShopValidationEmail.do'/>" , true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.send("email=" + emailInput.value);
			
			xhr.onreadystatechange = function(){
				if (xhr.readyState == 4 && xhr.status == 200){
					let responseMessage = JSON.parse(xhr.responseText);		
					errortext.innerHTML = responseMessage.responseMessage;
				}
			}
		});
	});

</script>

</head>
<body>
	<div style="length: 80%;width: 80%;margin: 10% 10%; text-align: center;">
		<div class="container">
			<img alt="" src="${pageContext.request.contextPath}/images/resetPassword/SearchEmailTitle.png">
			<div class="mb-3">
				<span style="font-size: 30px">請輸入電子郵件以搜尋帳號</span>
			</div>
			<div class="mb-3" style="text-align: center;">
				<input style="width: 400px; font-size: 28px; border-color: rgb(56, 150, 27); border-width: 5px; " id="emailInput" type="email" placeholder="email">
			</div>
			<div class="mb-3">
				<button class="btn btn-outline-secondary" style="font-size: 26px;border-radius: 15px; width: 100px" id="emailSubmit">Go</button>
			</div>
			<div class="mb-3">
				<span id="errortext"></span>
			</div>
		</div>
	</div>
</body>
</html>