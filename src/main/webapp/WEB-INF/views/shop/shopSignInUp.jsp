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
    <title>Shop SignIn SignUp</title>
    <link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop_signin_up.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer_shop_switch.css">
    
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
			const shopSignInEmail = document.getElementById("shopSignInEmail");
			const shopSignInPassword = document.getElementById("shopSignInPassword");
            
			//登入or註冊模式
            let signMode = "${signMode}";
            //登出告別訊息
            let farewellMessage = "${farewellMessage}";
            //登出者Bean
            let shopSignOutEmailBean = "${shopSignOutEmailBean}"

            if(signMode == "sign_up"){
            	container.classList.add("right-panel-active");
            } else if(signMode == "sign_in"){
                container.classList.remove("right-panel-active");
            }
            
            if(farewellMessage != ""){
	            signout_prompt.innerHTML = farewellMessage;
            	recent_sign_in.innerHTML = "最近登入";
            }
            
            if(shopSignOutEmailBean != ""){
	            shopSignInEmail.value = "${shopSignOutEmailBean}";
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
            	setTimeout("location.href='/soeasy/customerController/addCustomer'",350);
            });

            customerShopSwitch2.addEventListener("change", () => {
            	customerShopSwitch1.checked = customerShopSwitch2.checked;
            	setTimeout("location.href='/soeasy/customerController/addCustomer'",350);
            });
            
            
        }
    </script>
</head>
<body>
	<jsp:include page="/fragment/header.jsp" />
	<div class = "imgbg">
	<div class="container right-panel-active">
        <!-- Sign Up -->
        <div class="container__form container--signup">
            <form:form method="Post" action="addShop" modelAttribute="shopBean" class="form" id="form1">
                <h2 class="form__title">Sign Up</h2>
                
                <form:input path="shopName" type="text" placeholder="User" class="input" />
                <form:errors path="shopName" cssClass="error" />
                
                <form:input path="shopEmail" type="email" placeholder="Email" class="input" />
                <form:errors path="shopEmail" cssClass="error" />

                <form:input path="shopPhone" type="text" placeholder="Phone" class="input" />
                <form:errors path="shopPhone" cssClass="error" />

                <form:input path="shopPassword" type="password" placeholder="Password" class="input" />
                <form:errors path="shopPassword" cssClass="error" />
                
                <form:input path="shopCheckPassword" type="password" placeholder="Check Password" class="input" />
                <form:errors path="shopCheckPassword" cssClass="error" />
                <button class="btn">Sign Up</button>
            </form:form>
        </div>

        <!-- Sign In -->
        <div class="container__form container--signin">
            <form:form method="Post" action="shopSignIn" modelAttribute="shopSignInBean" class="form" id="form2">
                <h2 class="form__title">Sign In</h2>
                
                <p id="signout_prompt"></p>
                <p id="recent_sign_in"></p>   
                
                <form:input path="shopSignInEmail" type="email" placeholder="Email" class="input" />
                <form:errors path="shopSignInEmail" cssClass="error" />
                
                <form:input path="shopSignInPassword" type="password" placeholder="Password" class="input" />
                <form:errors path="shopSignInPassword" cssClass="error" />
                <form:errors path="invalidCredentials" cssClass="error" />
                
                <a href="<c:url value='/shopController/shopForgotPassword'></c:url>" class="link">Forgot your password?</a>
                <button class="btn">Sign In</button>
            </form:form>
        </div>

        <!-- Overlay -->
        <div class="container__overlay">
            <div class="overlay">
                <div class="overlay__panel overlay--left">
	            	<div class="switch switch-left">
    					<input class="switch-checkbox" id="switchID1" type="checkbox" name="switch-checkbox">
    					<label class="switch-label" for="switchID1">
        					<span class="switch-txt" turnOn="會員" turnOff="廠商"></span>
        					<span class="switch-Round-btn"></span>
    					</label>
					</div>
                    <button class="btn" id="signIn">Sign In</button>
                </div>
                <div class="overlay__panel overlay--right">
                	<div class="switch switch-right">
    					<input class="switch-checkbox" id="switchID2" type="checkbox" name="switch-checkbox">
    					<label class="switch-label" for="switchID2">
        					<span class="switch-txt" turnOn="會員" turnOff="廠商"></span>
        					<span class="switch-Round-btn"></span>
    					</label>
					</div>
                    <button class="btn" id="signUp">Sign Up</button>
                </div>  
            </div>
        </div>
    </div>
    </div>
    <jsp:include page="/fragment/footer.jsp" />
</body>
</html>