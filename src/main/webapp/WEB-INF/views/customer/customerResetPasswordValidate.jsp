<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function(){
		let password = document.getElementById("password");
		let checkPassword = document.getElementById("checkPassword");
		let passwordSubmit = document.getElementById("passwordSubmit");
		let promptText = document.getElementById("promptText");
		let xhr = new XMLHttpRequest();
		
		passwordSubmit.addEventListener("click", function(){
			xhr.open('POST', "<c:url value='/passwordResetValidate/resetPassword.do'/>" , true);
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhr.send("token=" + "${token}" + "&" + "password=" + password.value + "&" + "checkPassword=" + checkPassword.value);
			xhr.onreadystatechange = function(){
				if (xhr.readyState == 4 && xhr.status == 200){
					let responseMessage = JSON.parse(xhr.responseText);		
					promptText.innerHTML = responseMessage.responseMessage;
				}
			}
		});
	});
</script>
</head>
<body>
	<div style="height: 35%;width: 80%;background-image: url('${pageContext.request.contextPath}/images/resetPassword/checkPwdTitle.jpg');background-position: center;background-size: cover;margin: 0 10% 0 10%">
	</div>
	<div class="container text-center" style="margin-top: 50px; margin-bottom: 50px;">
		<div class="input-group w-50 my-5 text-center" style="margin-left: 25%">
			<div class="input-group-prepend">
				<span class="input-group-text" style="font-size: 22px">輸入帳戶密碼</span>
			</div>
			<input class="form-control" id="password" style="font-size: 22px" placeholder="password">
		</div>
		
		<div class="input-group w-50 my-5 text-center" style="margin-left: 25%">
			<div class="input-group-prepend">
				<span class="input-group-text" style="font-size: 22px">確認帳戶密碼</span>
			</div>
			<input class="form-control" id="checkPassword" style="font-size: 22px" placeholder="checkpassword">
		</div>
		<div>
			<button class="btn btn-outline-primary w-50 mb-5" id="passwordSubmit" style="font-size: 22px">送出</button>
		</div>
		<div>
			<span id="promptText"></span>
		</div>
	</div>
<%-- 	<div style="height: 20%;width: 80%;background-image: url('${pageContext.request.contextPath}/images/resetPassword/checkPwd4Star.jpg');background-position: center;background-size: cover;margin: 0 10% 0 10%"> --%>
<!-- 	</div> -->
	<hr style="width: 80%; margin-left: 10%; margin-top: 5%">
</body>
</html>