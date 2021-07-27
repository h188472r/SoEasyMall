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
		
		let customerMenu = document.getElementById("customerMenu");
		let customerImg = document.getElementById("customerImg");
		
		document.addEventListener("click", function(){
			customerMenu.style.display="none";
		}, true);
		
		customerImg.addEventListener("click", function(){
			customerMenu.style.display="block";
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
				<a id="customerImg" href="#" title="${customerSignInSuccess.customerName}" class="drop-down-menu">
					<img alt="" src="${pageContext.request.contextPath}/customerController/getCustomerImg" style="width: 20px; height: 20px; vertical-align:text-bottom;">
					<span style="vertical-align: top;;">${customerSignInSuccess.customerName}</span>
				</a>
				
				<div id="customerMenu">
                    <a href="<c:url value='/customerController/customerPage'></c:url>">
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
                    <a href="<c:url value='/mall/order/history'/>">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                        <span>Order</span>
                    </a>
                    <a href="#">  
        	          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill:#007500;">
        	          <path d="M12 2c5.514 0 10 4.486 10 10s-4.486 10-10 10-10-4.486-10-10 4.486-10 10-10zm0-2c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm-1.834 9.686l-4.166.575 3.032 2.914-.74 4.139 3.708-1.982 3.708 1.983-.74-4.139 3.032-2.915-4.166-.575-1.834-3.784-1.834 3.784z"/></svg>
        	          <span>${customerSignInSuccess.customerScore}</span>
                    </a>
                    <a href="<c:url value='/recordController/record/getRecordByCustomerId'/>">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                        </svg>
                        <span>成果記錄</span>
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