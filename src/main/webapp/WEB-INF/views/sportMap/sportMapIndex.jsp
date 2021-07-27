<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sport Map</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<link
	href="http://www.francescomalagrino.com/BootstrapPageGenerator/3/css/bootstrap-combined.min.css"
	rel="stylesheet" media="screen">
<link rel='stylesheet'
	href='https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>	
<link
	href="https://fonts.googleapis.com/css2?family=Caudex&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Lobster&display=swap"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/sportMap_index.css"
	rel="stylesheet">
	
<link href="${pageContext.request.contextPath}/css/sportMap_getAll.css"
	rel="stylesheet">	


<style>
    html, body {
        height: 100%;
        width: 100%;
        
      }
      #map {
        height: 80%;
        width: 100%;
        display: flex;
        justify-content: center;
        

      }
</style>

<script>
//---------------------------熱門場館場地用-開始--------------------------------------//
document.addEventListener("DOMContentLoaded", function(){
	let showTop = document.getElementById("showTopMaps")
	let topMaps;
	//新建XMLHttpRequest物件
	let xhr = new XMLHttpRequest();
	//設定連線內容(此方法為依照積分最高顯示前三筆地圖)
	xhr.open('GET',"<c:url value='/sportMapController/allSportMapsByTopNo.json' />",true);//true==>用非同步送出
	//對伺服器發送請求
	xhr.send();
	
	//進頁面顯示第一頁
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status ==200){
		topMaps = JSON.parse(xhr.responseText);
		console.log(topMaps);
		console.log("123");
		displayTopMaps();				
			
		}
		
	}		
	//熱門場館場地用	
	function displayTopMaps(){
		
		let content = "<div class='container'>";
		
		(topMaps).forEach(topMap =>{
		
		content += "<div class='column'>"+
	    "<div class='demo-title'>"+"</div>"
        +"<div class='post-module'>"+"<div class='thumbnail'>"+"<div class='date2'>"
        +"<div class='day'>"+"Hot"+"</div>"+"<div class='month'>"+""+"</div>"                                                    
        +"</div>"+topMap.sportMapMap+"</div>"+"<div class='post-content'>"
        +"<div class='category2'>"+"累積"+topMap.sportMapScore+"分！</div>"
        +"<h3 class='sub_title'>"+"地點："+topMap.sportMapName+"</h3>"
        +"<h3 class='description'>"+"地址："+topMap.sportMapAddress+"</h3>"
        +"<div class='post-meta'>"+"<span class='timestamp'>"+"<i class='fa fa-clock-o'>"+"</i>"
        +topMap.sportCategoryBean.sportCategoryName+"</span>"
        +"<span class='comments'>"+"<i class='fa fa-comments'>"+"</i>"
		+"<a href=' " + "<c:url value='/sportMapController/sportMap/' />" + topMap.sportMapId  +  " '>詳細資訊</a>"        
        
        +"</span>"+"</div>"+"</div>"+"</div>"+"</div>"
		
		});   
		content+= "</div>"
		showTop.innerHTML=content;		
		
		}	
	
	}
)
//---------------------------熱門場館場地用-結束--------------------------------------//

// ---------------------------地圖切換區域用-開始--------------------------------------//
	//地圖切換區域用
	document.addEventListener("DOMContentLoaded", function () {

            // let areas = document.getElementsByTagName("area");
            let areas = document.querySelectorAll("area.imgbut");
            let areasLen = areas.length;
            console.log(areas);
            console.log(areas.length);
            for (let i = 0; i < areas.length; i++) {
                areas[i].addEventListener("mouseover", mouseOver);
                areas[i].addEventListener("mouseout", mouseOut);
                areas[i].addEventListener("click", Click);
            }
        });

        function mouseOver() {
            console.log(this);
            console.log(this.id);
            document.getElementById("imgMap").src ="${pageContext.request.contextPath}/images/sportMap/Map" + this.id.substr(2) + ".png";
        }


        function mouseOut() {
        	document.getElementById("imgMap").src="${pageContext.request.contextPath}/images/sportMap/MapSport4.png";
        }


        function Click() {
            // document.getElementById("mapdiv").innerHTML = "<img src='images/" + this.id.substr(2) + ".gif'/>";
            // document.getElementById("mapdiv").innerHTML = "<img src='images/" + this.id.substr(2) + ".gif'/>";

        }



// ---------------------------地圖切換區域用-結束--------------------------------------//

</script>


</head>
<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />
<!-- -------------------------So Map標題------------------------------ -->
	<div class="mainWrapper">
		<section id="offer">
			<div style="background-color: #C9D8BF; text-align: center;">
				<div style="margin: 5% auto;">
					<h1 style="color: #1d3b2a; font-family: Caudex;">So Map</h1>
					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						運動使我們充滿活力，快揮灑你的汗水，展現你的風采</p>

					<p style="color: #325b43; font-family: Lobster; font-size: 18px;">
						現在就起身尋找一個適合自己的地點吧！</p>
				</div>

			</div>

		</section>
	</div>
	
	
	<!-- ------------------------------內容1區塊-開始--------------------------------- -->	
	
    <!-- ------------------------------依區域區塊1-開始--------------------------------- -->

	<div class="centerDiv">
		<div class="btnBy1">
						
			<div>
				<span>依區域：</span>
			</div>
			<div>
				<a 	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=台北市' />"><button class="font1">所有台北市</button></a>
				
			</div>
			
			<div>
				<a 	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=中正區' />"><button class="font1">中正區</button></a>
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=萬華區' />"><button class="font1">萬華區</button></a>
				
			</div>
			<div>
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=大安區' />"><button class="font1">大安區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=文山區' />"><button class="font1">文山區</button></a>
				
			</div>
			<div>
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=信義區' />"><button class="font1">信義區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=南港區' />"><button class="font1">南港區</button></a>
				
			</div>
			<div>
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=士林區' />"><button class="font1">士林區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=北投區' />"><button class="font1">北投區</button></a>
				
			</div>	
			<div>
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=中山區' />"><button class="font1">中山區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=大同區' />"><button class="font1">大同區</button></a>
				
			</div>	
			<div>
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=松山區' />"><button class="font1">松山區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=內湖區' />"><button class="font1">內湖區</button></a>
				
			</div>	
		 

		</div>
<!-- ------------------------------依區域區塊1-結束--------------------------------- -->
		
<!-- ------------------------------中間地圖區塊開始------------------------------ -->
				
		<div class="btnBy2">
			
				

<!-------------------------------------中間圖片區塊-開始--------------------------------- -->
	
     <img id="imgMap" alt="" src="${pageContext.request.contextPath}/images/sportMap/MapSport4.png" usemap="#FPMap0"  />
 

	<map id="imgMap" name="FPMap0">
    	<area id="idBeitou" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=北投區' ></c:url>" coords="311,108,304,117,296,124,292,131,284,133,278,139,271,145,261,146,250,156,240,164,235,172,227,184,231,192,248,190,256,196,258,202,274,198,291,165,302,154,315,135,319,121" shape="poly">
    	<area id="idShilin" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=士林區' ></c:url>" coords="326,121,317,128,314,141,311,152,302,164,292,171,286,180,281,190,275,201,269,206,258,202,240,194,238,198,261,215,273,220,289,211,308,206,331,196,340,189,338,191,348,175,344,180" shape="poly">
    	<area id="idNeihu" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=內湖區' ></c:url>" coords="340,194,330,197,319,202,312,208,314,221,320,234,336,243,346,239,358,236,365,224,366,209" shape="poly">
   	 	<area id="idZhongshan" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=中山區' ></c:url>" coords="298,234,303,229,310,225,308,214,293,212,285,216,277,226,278,233,278,239,277,246,284,247,292,249,297,246" shape="poly">
    	<area id="idDatong" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=大同區' ></c:url>" coords="261,225,261,233,262,241,261,249,268,252,279,250,276,221" shape="poly">
    	<area id="idSongshan" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=松山區' ></c:url>" coords="315,226,301,231,298,239,298,249,304,250,311,250,323,246" shape="poly">
    	<area id="idWanhua" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=萬華區' ></c:url>" coords="266,267,267,254,258,253,247,257,246,270,251,282,257,281,271,275" shape="poly">
    	<area id="idZhongzheng" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=中正區' ></c:url>" coords="284,254,286,260,286,266,280,270,290,287,270,276,269,252" shape="poly">
    	<area id="idDaan" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=大安區' ></c:url>" coords="288,254,287,263,284,270,293,284,312,282,307,266,307,252" shape="poly">
    	<area id="idXinyi" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=信義區' ></c:url>" coords="309,252,308,262,313,279,317,284,331,275,336,264,327,247" shape="poly">
    	<area id="idNangang" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=南港區' ></c:url>" coords="330,247,336,260,333,272,326,280,340,281,348,276,354,275,363,275,374,270,382,264,359,248,357,237" shape="poly">
    	<area id="idWenshan" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=文山區' ></c:url>" coords="299,304,313,321,321,323,331,323,342,327,362,321,344,310,344,298,339,286,318,287,301,284,290,287,288,296" shape="poly">
    	<area id="idLinkou" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=林口區' ></c:url>" coords="137,173,125,178,113,183,102,183,89,182,80,185,69,191,77,202,91,206,102,208,110,211,124,218,125,229,137,235,152,233,161,233,171,226,164,202" shape="poly">
    	<area id="idBali" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=八里區' ></c:url>" coords="140,170,149,182,154,189,162,198,172,212,172,199,175,189,181,185,185,178,191,176,198,178,208,184,217,185,219,166,209,153,197,145,187,141,171,152,166,164" shape="poly">
    	<area id="idWugu" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=五股區' ></c:url>" coords="188,177,180,186,175,201,175,216,179,224,183,226,187,230,197,231,204,231,211,233,221,233,220,218,219,203,219,191" shape="poly">
    	<area id="idLuzhou" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=蘆洲區' ></c:url>" coords="223,194,221,210,221,227,231,225,242,222,250,210,240,200" shape="poly">
    	<area id="idSanchong" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=三重區' ></c:url>" coords="252,210,258,218,259,235,261,248,251,250,242,257,230,256,230,232" shape="poly">
    	<area id="idBanqiao" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=板橋區' ></c:url>" coords="244,258,227,257,218,265,212,271,205,282,204,291,196,302,198,315,210,298,225,299,247,275" shape="poly">
    	<area id="idXinzhuang" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=新莊區' ></c:url>" coords="227,235,217,236,208,243,206,255,200,262,193,267,182,259,174,254,164,257,172,263,177,270,183,277,193,281,199,287,227,256" shape="poly">
    	<area id="idTaishan" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=泰山區' ></c:url>" coords="203,234,189,232,175,223,168,230,158,235,162,240,168,246,176,249,192,263,204,255,210,237" shape="poly">
    	<area id="idYonghe" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=永和區' ></c:url>" coords="252,283,258,285,263,291,271,298,285,299,284,296,286,287,269,275,253,282" shape="poly">
    	<area id="idZhonghe" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=中和區' ></c:url>" coords="244,279,241,284,233,289,229,295,234,300,237,308,241,315,241,321,249,319,257,319,265,314,275,305,284,302" shape="poly">
    	<area id="idTucheng" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=土城區' ></c:url>" coords="229,298,216,299,205,305,200,314,191,318,185,323,179,333,183,344,195,346,205,344,212,341,219,339,227,332,233,323,240,317" shape="poly">
    	<area id="idShulin" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=樹林區' ></c:url>" coords="180,275,162,280,168,284,173,289,168,294,160,296,156,305,148,311,150,318,153,323,145,331,140,338,149,337,155,339,160,337,166,339,173,339,181,323,187,315,196,309,194,296,196,287,194,283" shape="poly">
    	<area id="idXindian" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=新店區' ></c:url>" coords="286,302,282,307,273,308,264,314,262,319,250,323,238,326,231,331,225,339,227,350,234,355,244,356,248,362,250,370,250,378,244,383,235,398,243,404,247,414,257,404,263,400,269,397,284,392,290,385,294,388,303,392,310,387,318,399,325,392,321,375,335,369,342,369,342,354,352,328,340,327,311,322" shape="poly">
    	<area id="idTamsui" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=淡水區' ></c:url>" coords="210,79,209,91,203,99,197,106,191,113,187,118,185,124,175,127,181,134,192,139,200,143,205,148,212,153,218,162,219,171,224,183,230,170,239,162,256,148,274,137,261,128,247,115,257,104,254,93,231,82" shape="poly">
    	<area id="idSanzhi" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=三芝區' ></c:url>" coords="265,47,252,52,240,55,235,63,229,70,214,74,227,79,238,82,250,88,256,95,257,103,252,113,263,123,270,130,278,136,300,124,311,105,309,95,303,81,298,64,286,69" shape="poly">
    	<area id="idShimen" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=石門區' ></c:url>" coords="288,38,277,43,267,36,273,53,282,63,292,61,302,62,303,80,313,101,324,96,332,88,340,80,347,72,355,67,361,54,334,31,313,38" shape="poly">
    	<area id="idJinshan" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=金山區' ></c:url>" coords="360,68,348,73,340,80,331,91,330,97,317,101,313,108,322,120,332,124,332,132,336,146,342,144,355,128,362,115,371,106,380,103,388,97,373,83,378,67,364,51" shape="poly">
    	<area id="idWanli" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=萬里區' ></c:url>" coords="389,99,378,105,367,109,359,120,355,129,351,140,339,149,342,164,350,174,362,173,374,170,389,166,398,163,434,143,428,137,424,126,428,110,407,119,395,109" shape="poly">
    	<area id="idXizhi" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=汐止區' ></c:url>" coords="370,172,357,174,350,180,341,191,356,200,365,207,367,216,361,241,371,252,388,266,403,265,424,259,444,263,454,254,447,239,429,233,411,220,398,215,391,201,383,184" shape="poly">
    	<area id="idShenkeng" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=深坑區' ></c:url>" coords="346,277,343,286,346,292,346,302,350,311,360,317,371,315,377,307,384,297,383,284,377,273,363,277" shape="poly">
    	<area id="idShiding" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=石碇區' ></c:url>" coords="402,271,397,276,382,275,387,294,381,306,376,315,368,320,358,326,351,336,345,349,342,365,338,374,324,379,324,394,336,405,352,411,369,414,383,414,390,407,390,395,386,386,400,377,398,368,409,359,403,346,404,333,421,329,430,319,449,315,453,306,453,292,434,276,434,267,422,264,416,265,409,268" shape="poly">
    	<area id="idPinglin" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=坪林區' ></c:url>" coords="389,417,393,424,402,423,412,423,419,425,429,429,440,436,458,419,481,418,499,411,501,398,509,385,509,375,502,362,509,346,513,327,509,311,494,311,467,319,442,319,428,327,420,335,411,337,409,349,412,363,403,370,398,383,394,393" shape="poly">
    	<area id="idPingxi" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=平溪區' ></c:url>" coords="451,284,439,277,437,265,449,262,456,248,465,244,472,243,479,244,486,244,494,240,504,234,509,231,517,231,522,234,524,241,529,243,530,250,525,257,518,263,510,269,506,275,499,280,494,286,488,301,495,307,484,310,467,311,457,314" shape="poly">
    	<area id="idRuifang" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=瑞芳區' ></c:url>" coords="512,225,503,227,495,223,484,210,486,198,491,192,498,190,504,190,511,192,518,191,525,185,532,178,541,190,549,186,556,185,563,186,570,187,582,188,593,188,610,188,629,185,600,200,594,208,578,208,566,208,558,223,546,231,543,238,547,250,538,255,530,244,525,231" shape="poly">
    	<area id="idShuangxi" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=雙溪區' ></c:url>" coords="568,210,563,217,555,225,548,231,547,242,550,250,545,254,535,256,528,264,522,268,516,273,510,277,505,286,497,292,497,301,508,306,512,315,512,332,511,342,507,350,505,363,516,379,535,377,545,373,556,369,566,359,561,348,554,340,559,326,574,324,573,308,582,297,589,284,599,273,598,261,595,250,595,236,586,229,584,213" shape="poly">
    	<area id="idGongliao" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=貢寮區' ></c:url>" coords="604,203,595,206,589,213,589,226,595,236,597,253,601,258,601,267,597,279,590,285,582,297,576,307,577,322,587,324,599,322,622,309,635,309,650,303,658,301,672,306,686,297,699,286,687,276,670,273,649,278,647,270,637,263,637,249,634,238,624,225,624,210,626,190,615,197" shape="poly">
    	<area id="idWulai" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=烏來區' ></c:url>" coords="269,399,261,401,254,408,249,414,252,423,254,431,251,438,242,443,244,451,233,459,225,463,220,470,215,478,210,483,205,488,198,493,194,502,198,509,201,519,203,528,207,533,214,542,219,550,229,552,233,559,247,579,267,570,288,565,292,553,302,547,316,541,330,537,341,530,337,517,334,505,342,495,337,482,346,473,362,470,368,462,382,457,398,455,409,450,417,447,434,436,419,430,403,430,391,428,385,419,373,417,356,415,342,413,324,403,309,394,289,388" shape="poly">
    	<area id="idSanxia" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=三峽區' ></c:url>" coords="219,341,211,345,204,348,189,346,181,345,173,342,162,340,151,340,142,340,135,344,127,350,122,356,112,360,103,367,108,372,107,382,116,384,123,390,129,399,131,406,129,414,132,419,131,430,140,432,145,434,156,434,164,430,173,430,179,433,183,436,208,463,210,475,224,460,240,452,238,443,247,438,251,429,246,414,238,406,233,396,246,378,248,361,238,356" shape="poly">
    	<area id="idYingge" class="imgbut"  href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=鶯歌區' ></c:url>" coords="125,348,132,344,137,338,142,330,147,322,144,313,131,313,122,312,115,312,110,317,110,327,110,338,105,344,102,352,110,353,121,354,123,349" shape="poly">
	</map>

<!-------------------------------------中間圖片區塊-結束--------------------------------- -->	
<!-- -----------------------------------依分類區塊-開始------------------------------ -->
			
			<div>
				<a href="<c:url value='/sportMapController/displaySportMaps' />"><button class="font2">所有運動地點</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsByCategoryId?sportCategoryBean=1' />"><button class="font2">運動中心</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsByCategoryId?sportCategoryBean=2' />"><button class="font2">室內場館</button></a>

			
				<a	href="<c:url value='/sportMapController/displaySportMapsByCategoryId?sportCategoryBean=3' />"><button class="font2">戶外球場</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsByCategoryId?sportCategoryBean=4' />"><button class="font2">河濱及公園</button></a>
			
<%-- 				<a	href="<c:url value='/sportMapController/displaySportMapsByCategoryId?sportCategoryBean=5' />"><button class="font2">游泳池</button></a> --%>
			</div>								
				
		</div>
<!-- -----------------------------------依分類區塊-結束------------------------------ -->
<!-- -----------------------------------依區域區塊2-開始------------------------------ -->

		<div class="btnBy3">
			<div>
				<span>依區域：</span>
			</div>
			<div>
				
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=新北市' />"><button class="font1">所有新北市</button></a>
			</div>
			
			<div>
				
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=板橋區' />"><button class="font1">板橋區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=中和區' />"><button class="font1">中和區</button></a>
			</div>
			<div>
				
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=新莊區' />"><button class="font1">新莊區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=淡水區' />"><button class="font1">淡水區</button></a>
			</div>
			<div>
				
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=三重區' />"><button class="font1">三重區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=新店區' />"><button class="font1">新店區</button></a>
			</div>
			<div>
				
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=五股區' />"><button class="font1">五股區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=林口區' />"><button class="font1">林口區</button></a>
			</div>	
			<div>
				
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=蘆洲區' />"><button class="font1">蘆洲區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=八里區' />"><button class="font1">八里區</button></a>
			</div>	
			<div>
				
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=土城區' />"><button class="font1">土城區</button></a>
			
				<a	href="<c:url value='/sportMapController/displaySportMapsBySportMapAddress?sportMapAddress=永和區' />"><button class="font1">永和區</button></a>
			</div>
			
			<br>
<!-- 			<div> -->
<%-- 			<form> --%>
<!-- 			<input name="" id="" type="text" placeholder="今天 想找什麼地點呢？"> -->
			
<%-- 			</form> --%>
<!-- 			</div>		 -->
			
				
		</div>
		
	</div>
<!-- -----------------------------------依區域區塊2-結束------------------------------ -->
	
<!-- -----------------------------------內容1區塊-結束--------------------------------- -->
	
<!-- ------------------------------------內容2區塊-開始--------------------------------- -->	
	<div class="centerDiv">
		<div>
		
		<div class="HotTitle" style="background-color: 	#fffae5;">
		<img src="${pageContext.request.contextPath}/images/sportMap/Hot1.jpg" width="35px" height="35px">
		熱門場館場地
		</div><br>
		
			<div id="showTopMaps" >
				
			</div>
		</div>

	</div>
<!-- -----------------------------------內容2區塊-結束--------------------------------- -->
		
<!-- -----------------------------------內容3區塊-開始--------------------------------- -->	
<!-- 	<div class="centerDiv"> -->

<!-- </div> -->
<!----------------------------------- 測試Google Maps Api開始	--------------------- -->
<!-- Google Maps 金鑰20210703 Create- -->
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAslkjoKdTG8kP9v47BpOssCN7VQ20oAFE&callback=initMap" async defer></script> -->

<div class="centerDiv" style="background-color: #f2f2f2;"><h3>Let's Show All Maps</h3></div>   
<div id="map"></div>  



<script>
var map;
var markers = [];
var position = [
  {label:'1',lat:25.038644735174145,lng:121.51948345530062}, 
  {label:'2',lat:25.0390672564532,lng:121.509871283183},
  {label:'3',lat:25.0476608,lng:121.5067638},
  {label:'4',lat:25.02207361,lng:121.5067318},
  {label:'5',lat:25.02207361,lng:121.5067318},
  {label:'6',lat:25.02082072,lng:121.54574},
  {label:'7',lat:25.02289828,lng:121.5356686},
  {label:'8',lat:25.03121642,lng:121.5355627},
  {label:'9',lat:25.0247905,lng:121.5462804},
  {label:'10',lat:25.01342204,lng:121.540205},
  {label:'11',lat:24.99736765,lng:121.5592647},
  {label:'12',lat:24.98715283,lng:121.5604168},
  {label:'13',lat:24.99024539,lng:121.5598142},
  {label:'14',lat:25.03187456,lng:121.5667817},
  {label:'15',lat:25.02613813,lng:121.5704288},
  {label:'16',lat:25.02597036,lng:121.5616911},
  {label:'17',lat:25.02598008,lng:121.5616911},
  {label:'18',lat:25.04905532,lng:121.5817973},
  {label:'19',lat:25.04296751,lng:121.6178838},
  {label:'20',lat:25.04296401,lng:121.5848328},
  {label:'21',lat:25.05534678,lng:121.6036616},
  {label:'22',lat:25.0471241,lng:121.6139101},
  {label:'23',lat:25.08957743,lng:121.52149},
  {label:'24',lat:25.09254198,lng:121.5172493},
  {label:'25',lat:25.11342948,lng:121.5330396},
  {label:'26',lat:25.10809268,lng:121.5219103},
  {label:'27',lat:25.08612179,lng:121.5211944},
  {label:'28',lat:25.11087685,lng:121.5315604},
  {label:'29',lat:25.11666747,lng:121.5097726},
  {label:'30',lat:25.13658619,lng:121.5012822},
  {label:'31',lat:25.05512275,lng:121.5213503},
  {label:'33',lat:25.07043091,lng:121.5287224},
  {label:'34',lat:25.06512496,lng:121.5161826},
  {label:'35',lat:25.04993147,lng:121.5138007},
  {label:'36',lat:25.07372866,lng:121.510443},
  {label:'37',lat:25.05818368,lng:121.5155188},
  {label:'38',lat:25.04880138,lng:121.5503383},
  {label:'39',lat:25.0613648,lng:121.5664167},
  {label:'40',lat:25.05156091,lng:121.5508591},
  {label:'41',lat:25.0498979,lng:121.5524425},
  {label:'42',lat:25.07837987,lng:121.5750078},
  {label:'43',lat:25.08293651,lng:121.5829353},
  {label:'44',lat:25.06661251,lng:121.574362},
  {label:'45',lat:25.06244523,lng:121.6045965},
  {label:'46',lat:25.02290242,lng:121.4577281},
  {label:'47',lat:24.99325477,lng:121.4874544},
  {label:'49',lat:25.04000848,lng:121.4483854},
  {label:'50',lat:25.02044232,lng:121.4336521},
  {label:'51',lat:25.02362075,lng:121.4440153},
  {label:'52',lat:25.02632434,lng:121.4240012},
  {label:'53',lat:25.04163099,lng:121.4464303},
  {label:'54',lat:25.04077787,lng:121.4518275},
  {label:'55',lat:25.18757548,lng:121.4428718},
  {label:'56',lat:25.05474423,lng:121.4879564},
  {label:'57',lat:25.06156203,lng:121.4862319},
  {label:'58',lat:25.088398,lng:121.4903423},
  {label:'59',lat:25.05993588,lng:121.4809068},
  {label:'60',lat:25.09531313,lng:121.4484301},
  {label:'61',lat:25.08658865,lng:121.3805174},
  {label:'62',lat:25.07810922,lng:121.3691106},
  {label:'63',lat:25.06823069,lng:121.3997148},
  {label:'64',lat:25.09133104,lng:121.462328},
  {label:'65',lat:24.98572468,lng:121.4571864},
  {label:'66',lat:25.00344901,lng:121.5244646},
  {label:'67',lat:25.01098334,lng:121.508727},
  {label:'68',lat:24.96740109,lng:121.5424829}

];

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: {
      lat: 25.04993147,
      lng: 121.5138007     
    }
  });

  for (var i = 0; i < position.length; i++) {
    addMarker(i);
  }
}

function addMarker(e) {
  markers[e] = new google.maps.Marker({
    position: {
      lat: position[e].lat,
      lng: position[e].lng
    },
    map: map,
    animation: google.maps.Animation.BOUNCE,
    // label: 'SoEasy',
    label: position[e].label,
    icon:'${pageContext.request.contextPath}/images/sportMap/Lucky.jpg'
    	
  });
}

</script>



<!----------------------------------- 測試Google Maps Api結束	--------------------- -->
<!-- ------------------------------內容3區塊-結束--------------------------------- -->
	
		
	<!-- 引入共同的頁尾  copy這行-->
	<jsp:include page="/fragment/footer.jsp" />





</body>
</html>