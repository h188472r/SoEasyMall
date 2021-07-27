<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,700" rel="stylesheet"> -->
<link href="${pageContext.request.contextPath}/css/sportMap_getOne.css" rel="stylesheet">
<title>運動地點介紹</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded",function(){
		let showFavorite = document.getElementById("showFavorite");
		let favoriteHeart = document.getElementById("favoriteHeart");
		
		//初始化XMLHttpRequest物件
		let xhr = new XMLHttpRequest();
		
		//收藏按鈕
		showFavorite.addEventListener("click",updateFavorite);
		//按下收藏按鈕，送出JSON字串資料
		function updateFavorite(){
			//建一支Object，裝收藏controller要的內容
			let favoriteInfo = {
				'favoriteCategory' : 'sportMap'	,
				'favoriteItemId' : ${sportMapBean.sportMapId}
				
			}
			//將物件轉為json			
			let json = JSON.stringify(favoriteInfo);
			
			console.log(json);
			
			xhr.open('POST',"<c:url value='/favoriteController/addFavorite'/>");
			xhr.setRequestHeader("Content-Type","application/json;charset=UTF-8");
			xhr.send(json);
			
			xhr.onreadystatechange = function(){
				if (xhr.readyState == 4 && xhr.status ==200){
					
					if(xhr.responseURL == "http://localhost:8080/soeasy/customerController/customerSignIn"){
						location.href="/soeasy/customerController/customerSignIn";
					}
					
					let favoriteJson = JSON.parse(xhr.responseText);
// 					console.log(favoriteJson);
					//更改圖片
					if (favoriteJson.favoriteExist){
						favoriteHeart.src="${pageContext.request.contextPath}/images/sportMap/Like2.png";
					}else {
						favoriteHeart.src="${pageContext.request.contextPath}/images/sportMap/Like1.png";

					}
					
				}
				
				
			}
			
			
		}		
		
		
		
	} )


</script>




</head>
<body>
	<jsp:include page="/fragment/header.jsp" />

<!-- ----------------------------------- -->
 
 <div>
 <div class="blog-card">
		
        <div style="margin-top:50px;"> ${sportMapBean.sportMapMap} </div>

        <div class="rightC">
            
<%--                <div class="floatR"> <a id='getLikeLink' href="<c:url value='/' />sportMapNeedLogin/getLike/sportMap/${sportMapBean.sportMapId}"> --%>
<%--                     <img src="${pageContext.request.contextPath}/images/sportMap/Like1.png"></a></div> --%>

<%--                 <div  class="floatR"><button id="showFavorite"><img id="favoriteHeart" src="${pageContext.request.contextPath}/images/sportMap/Like1.png"></button></div>   --%>
		<c:choose>
			<c:when test="${sportMapBean.favoriteStatus == true}">
                <div  class="floatR"><button id="showFavorite" style="border: none; background-color: transparent;"><img id="favoriteHeart" src="${pageContext.request.contextPath}/images/sportMap/Like2.png"></button></div>  
			</c:when>
			<c:otherwise>
			   <div  class="floatR"><button id="showFavorite" style="border: none; background-color: transparent;"><img id="favoriteHeart" src="${pageContext.request.contextPath}/images/sportMap/Like1.png"></button></div>  
			
			</c:otherwise>
		</c:choose>
                    
          <div class="">  
            <h1>${sportMapBean.sportMapName}</h1>
            <h3>${sportMapBean.sportMapAddress}</h3>
            <h2>Information：</h2>
            <p> ${sportMapBean.sportMapInfo}</p>
            <br>
            <br>
          </div>  
             <div class="floatR2">   
             <div style="color:#ff9e00;font-weight: bold;">來個評分吧！</div>
                <a class='getScore1Link'
                    href="<c:url value='/' />sportMapNeedLogin/getScore/${sportMapBean.sportMapId}/1"> 
                    <img src="${pageContext.request.contextPath}/images/sportMap/MapSportstar1.png"></a>
                <a class='getScore2Link'
                    href="<c:url value='/' />sportMapNeedLogin/getScore/${sportMapBean.sportMapId}/2"> 
                    <img src="${pageContext.request.contextPath}/images/sportMap/MapSportstar2.png"></a>
                <a class='getScore3Link'
                    href="<c:url value='/' />sportMapNeedLogin/getScore/${sportMapBean.sportMapId}/3"> 
                    <img src="${pageContext.request.contextPath}/images/sportMap/MapSportstar3.png"></a>
                <a class='getScore4Link'
                    href="<c:url value='/' />sportMapNeedLogin/getScore/${sportMapBean.sportMapId}/4"> 
                    <img src="${pageContext.request.contextPath}/images/sportMap/MapSportstar4.png"></a>
                <a class='getScore5Link'
                    href="<c:url value='/' />sportMapNeedLogin/getScore/${sportMapBean.sportMapId}/5"> 
                    <img src="${pageContext.request.contextPath}/images/sportMap/MapSportstar5.png"></a>

				</div>
            	<div class="floatR2" style="color:#ff9e00;font-weight: bold;">目前累積：${sportMapBean.sportMapScore}分</div>
            	
	<div class="style2 floatR2"><a href="<c:url value='/showSportMapIndex'></c:url>" title="SportMap"> <img src="${pageContext.request.contextPath}/images/sportMap/home.png"></a></div>
            	
            
        </div>
    </div>

</div>




<!-- ------------------------------用來接POST-------------------------------- -->
	<form method='POST'>
		<input type='hidden' name='_method' value='score'>
	</form>

	<!-- -----------------------------收藏地點------------------------------- -->
<!-- 	<script> -->
<!-- // 		$(document).ready(function() { -->
<!-- // 			$('#getLikeLink').click(function() { -->
<!-- // 				if (confirm('要收藏這個地點嗎? ')) { -->
<!-- // 					var href = $(this).attr('href'); -->
<!-- // 					$('form').attr('action', href).submit(); -->
<%-- // 					console.log(${customerSignInSuccess.customerId}); --%>
<!-- // 				} -->
<!-- // 				return false; -->

<!-- // 			}); -->
<!-- // 		}) -->
<!-- 	</script> -->
	<!-- -----------------------------收藏地點------------------------------- -->
	<!-- -----------------------------評分一下------------------------------- -->
	<script>
		$(document).ready(function() {
			$('.getScore1Link').click(function() {
				if (confirm('要來個評分嗎? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

				}
				return false;

			});
		})
	</script>
	<script>
		$(document).ready(function() {
			$('.getScore2Link').click(function() {
				if (confirm('要來個評分嗎? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

				}
				return false;

			});
		})
	</script>
	<script>
		$(document).ready(function() {
			$('.getScore3Link').click(function() {
				if (confirm('要來個評分嗎? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

				}
				return false;

			});
		})
	</script>
	<script>
		$(document).ready(function() {
			$('.getScore4Link').click(function() {
				if (confirm('要來個評分嗎? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

				}
				return false;

			});
		})
	</script>
	<script>
		$(document).ready(function() {
			$('.getScore5Link').click(function() {
				if (confirm('要來個評分嗎? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

				}
				return false;

			});
		})
	</script>
	<!-- -----------------------------評分一下------------------------------- -->


	<jsp:include page="/fragment/footer.jsp" />

</body>
</html>