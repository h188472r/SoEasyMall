<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer SignIn SignUp</title>
    <link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer_signin_up.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer_shop_switch.css">
	<script
  		src="https://code.jquery.com/jquery-3.6.0.min.js"
  		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  		crossorigin="anonymous">
	</script>
    <script>
        window.onload = function () {
            const signInBtn = document.getElementById("signIn");
            const signUpBtn = document.getElementById("signUp");
            const firstForm = document.getElementById("form1");
            const secondForm = document.getElementById("form2");
            const container = document.querySelector(".container");
            const customerShopSwitch1 = document.getElementById("switchID1");
            const customerShopSwitch2 = document.getElementById("switchID2");
            
            const signout_prompt = document.getElementById("signout_prompt");
            const recent_sign_in = document.getElementById("recent_sign_in");
			const customerSignInEmail = document.getElementById("customerSignInEmail");
			const customerSignInPassword = document.getElementById("customerSignInPassword");
            
			//登入or註冊模式
            let signMode = "${signMode}";
            //登出告別訊息
            let farewellMessage = "${farewellMessage}";
            //登出者Bean
            let customerSignOutEmailBean = "${customerSignOutEmailBean}"

            if(signMode == "sign_up"){
            	container.classList.add("right-panel-active");
            } else if(signMode == "sign_in"){
                container.classList.remove("right-panel-active");
            }
            
            if(farewellMessage != ""){
	            signout_prompt.innerHTML = farewellMessage;
            	recent_sign_in.innerHTML = "最近登入";
            }
            
            if(customerSignOutEmailBean != ""){
	            customerSignInEmail.value = "${customerSignOutEmailBean}";
            }
            
            signInBtn.addEventListener("click", () => {
                if(signMode == "sign_up"){
                    container.classList.remove("right-panel-active");
                    signMode = "sign_in";
                } else if(signMode == "sign_in"){
                    secondForm.addEventListener("submit", (e) => e.preventDefault());
                }
            });

            signUpBtn.addEventListener("click", () => {
                if(signMode == "sign_in"){
                    container.classList.add("right-panel-active");
                    signMode = "sign_up";
                } else if(signMode == "sign_up"){
                    firstForm.addEventListener("submit", (e) => e.preventDefault());
                }
            });

            customerShopSwitch1.addEventListener("change", () => {
            	customerShopSwitch2.checked = customerShopSwitch1.checked;
            	setTimeout("location.href='/soeasy/shopController/addShop'",350);
            });

            customerShopSwitch2.addEventListener("change", () => {
            	customerShopSwitch1.checked = customerShopSwitch2.checked;
            	setTimeout("location.href='/soeasy/shopController/addShop'",350);
            });
            
        }
    </script>
</head>
<body>
	<jsp:include page="/fragment/header.jsp" />	
<!-- <div class="mainWrapper"> -->
<!-- 				<header> -->
<!-- 					<div id="logo"> -->
<%-- 						<a href="<c:url value="/"></c:url>"> --%>
<%-- 						<img src="${pageContext.request.contextPath}/images/ICON.png" style="margin-left:52.5%; margin-top:-3.7%; "></a> --%>
<!-- 					</div> -->
<%-- 					<a href="<c:url value='/admin/adminLogin'></c:url>"><button --%>
<!-- 							style="position: absolute; color: white; background-color: white;border: none;margin-left:7%;">admin</button></a> -->
<!-- 					<div id="headerLinks" style="margin-right:7.59%; margin-top:-0.43%; width:60%;"> -->
<%-- 						<c:if --%>
<%-- 							test="${empty customerSignInSuccess && empty shopSignInSuccess && empty adminLoginSuccess}"> --%>
<%-- 							<a href="<c:url value='/customerController/addCustomer'></c:url>" --%>
<!-- 								title="Login/Register">登入/註冊</a> -->
<%-- 						</c:if> --%>
<%-- 						<c:if test="${!empty customerSignInSuccess}"> --%>
<%-- 							<jsp:include page="/fragment/customerMenu.jsp" /> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${!empty shopSignInSuccess}"> --%>
<%-- 							<jsp:include page="/fragment/shopMenu.jsp" /> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${!empty adminLoginSuccess}"> --%>
<%-- 							<jsp:include page="/fragment/adminMenu.jsp" /> --%>
<%-- 						</c:if> --%>
<%-- 						<a href="<c:url value='/mall/cart/index'/>" title="Cart">購物車</a> --%>
<!-- 					</div> -->
<!-- 					<nav style="margin-right:7.55%; width:60%;"> -->
<%-- 						<a href="<c:url value='/'></c:url>" title="Link">首頁</a> <a --%>
<!-- 							href="#" title="Link">園地</a> <a -->
<%-- 							href="<c:url value='/lectureIndex'></c:url>" title="SoLecture">講座</a> --%>
<%-- 						<a href="<c:url value='/mall'></c:url>" title="Mall">商城</a> <a --%>
<%-- 							href="<c:url value='/postIndex'></c:url>" title="So Share">分享</a> --%>
<%-- 						<a href="<c:url value='/showSportMapIndex'></c:url>" --%>
<!-- 							title="SportMap">地圖</a> <a -->
<%-- 							href="<c:url value='/nutritionist'></c:url>" title="Link">營養師</a> --%>
<!-- 					</nav> -->
<!-- 				</header> -->
<!-- 			</div> -->
	<div class = "imgbg">
	<div class="container right-panel-active">
        <!-- Sign Up -->
        <div class="container__form container--signup">
            <form:form method="Post" action="addCustomer" modelAttribute="customerBean" class="form" id="form1">
                <h2 class="form__title">Sign Up</h2>
                
                <form:input path="customerName" type="text" placeholder="User" class="input" />
                <form:errors path="customerName" cssClass="error" />
                
                <form:input path="customerEmail" type="email" placeholder="Email" class="input" />
                <form:errors path="customerEmail" cssClass="error" />

                <form:input path="customerPassword" type="password" placeholder="Password" class="input" />
                <form:errors path="customerPassword" cssClass="error" />
                
                <form:input path="customerCheckPassword" type="password" placeholder="Check Password" class="input" />
                <form:errors path="customerCheckPassword" cssClass="error" />
                <button class="btn">Sign Up</button>
            </form:form>
        </div>

        <!-- Sign In -->
        <div class="container__form container--signin">
            <form:form method="Post" action="customerSignIn" modelAttribute="customerSignInBean" class="form" id="form2">
                <h2 class="form__title">Sign In</h2>
                
                <p id="signout_prompt"></p>
                <p id="recent_sign_in"></p>                
                
                <form:input path="customerSignInEmail" type="email" placeholder="Email" class="input" />
                <form:errors path="customerSignInEmail" cssClass="error" />
                
                <form:input path="customerSignInPassword" type="password" placeholder="Password" class="input" />
                <form:errors path="customerSignInPassword" cssClass="error" />
                <form:errors path="invalidCredentials" cssClass="error" />

                <a href="<c:url value='/customerController/customerForgotPassword'></c:url>" class="link">Forgot your password?</a>
                <button class="btn">Sign In</button>
            </form:form>
        </div>

        <!-- Overlay -->
        <div class="container__overlay">
            <div class="overlay">
                <div class="overlay__panel overlay--left">
<!--                 	會員廠商切換 -->
	            	<div class="switch switch-left">
    					<input class="switch-checkbox" checked="checked" id="switchID1" type="checkbox" name="switch-checkbox">
    					<label class="switch-label" for="switchID1">
        					<span class="switch-txt" turnOn="會員" turnOff="廠商"></span>
        					<span class="switch-Round-btn"></span>
    					</label>
					</div>
<!-- 					SIGN IN -->
	               	<button class="btn" id="signIn">Sign In</button>
                </div>
                <div class="overlay__panel overlay--right">
<!--                 	會員廠商切換 -->
                	<div class="switch switch-right">
    					<input class="switch-checkbox" checked="checked"  id="switchID2" type="checkbox" name="switch-checkbox">
    					<label class="switch-label" for="switchID2">
        					<span class="switch-txt" turnOn="會員" turnOff="廠商"></span>
        					<span class="switch-Round-btn"></span>
    					</label>
					</div>
					
<!-- 					SIGN UP -->
	                <button class="btn" id="signUp">Sign Up</button>
                </div>  
            </div>
        </div>
    </div>
    </div>
    <jsp:include page="/fragment/footer.jsp" />
</body>
</html>