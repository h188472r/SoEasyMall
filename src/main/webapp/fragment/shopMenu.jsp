<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	window.onload = function () {
		
		let shopMenu = document.getElementById("shopMenu");
		let shopImg = document.getElementById("shopImg");
		
		document.addEventListener("click", function(){
			shopMenu.style.display="none";
		}, true);
		
		shopImg.addEventListener("click", function(){
			shopMenu.style.display="block";
		}, true);
	}


</script>

<style>
        .rotate-45 {
            --transform-rotate: 45deg;
            transform: rotate(45deg);
        }
    
        .group:hover .group-hover\:flex {
            display: flex;
        }

        svg{
            margin-right: 10px;
            color: #007500;
            width: 25px;
            height: 25px;
            
        }
    </style>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customerMenu.css">
<body>
<!-- 		<div class="drop-down-menu"> -->
				<a id="shopImg" href="#" title="${shopSignInSuccess.shopName}" class="drop-down-menu">
					<img alt="" src="${pageContext.request.contextPath}/shopController/getShopImg" style="width: 20px; height: 20px; vertical-align: text-bottom;">
					<span style="vertical-align: top;">${shopSignInSuccess.shopName}</span>
				</a>
				
				<div id="shopMenu">
                   <a href="<c:url value='//shopController/showShopPage'/>">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        <span class="ml-2 text-sm font-medium">Account</span>
                    </a>
                    <a href="#">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                        <span>Search</span>
                    </a>
                    <a href="<c:url value='/shop/shoplist'/>">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                        <span>Product</span>
                    </a>
                    <a href="#">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />
                        </svg>
                        <span>Settings</span>
                    </a>
                    <a href="#">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                        </svg>
                        <span>Messages</span>
                    </a>
                    <a href="<c:url value='/customerController/signOut'></c:url>">
                    
                        <svg xmlns="http://www.w3.org/2000/svg" fill="#007500"
                            viewBox="-5 0 34 34" stroke="currentColor">
							<path stroke-linecap="round" stroke-linejoin="round" 
								 d="M24 20v-4h-10v-4h10v-4l6 6zM22 18v8h-10v6l-12-6v-26h22v10h-2v-8h-16l8 4v18h8v-6z"/>
								
                        </svg>
                        <span>Sign out</span>
                    </a>
<!--         	</div> -->
			
				</div>
			
			
        		
</body>
</html>