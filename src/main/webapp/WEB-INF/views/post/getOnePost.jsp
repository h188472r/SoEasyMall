<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Share</title>
<link rel='short icon' href="${pageContext.request.contextPath}/favicon.ico"  />
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/jquery-ui"></script>
<link
	href="http://www.francescomalagrino.com/BootstrapPageGenerator/3/css/bootstrap-combined.min.css"
	rel="stylesheet" media="screen">
<script type="text/javascript"
	src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">


<style>
span.error {
	color: red;
	display: inline-block;
	font-size: 8pt;
}
</style>

<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function () {
			let showFavorite = document.getElementById("showFavorite");
			let favoriteHeart = document.getElementById("favoriteHeart");
			let postLike = document.getElementById("postLike");

			//初始化XMLHttpRequest物件
			let xhr = new XMLHttpRequest();

			//收藏按鈕
			showFavorite.addEventListener("click", updateFavorite);
			//按下收藏按鈕，送出JSON字串資料
			function updateFavorite() {
				console.log("觸發收藏點擊事件");
				//建一支Object，裝收藏controller要的內容
				let favoriteInfo = {
					'favoriteCategory': 'post',
					'favoriteItemId': ${ getOnePostBean.postId }

			}
			//將物件轉為json			
			let json = JSON.stringify(favoriteInfo);

			console.log(json);

			xhr.open('POST', "<c:url value='/favoriteController/addFavoritePost'/>");
			xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xhr.send(json);

			xhr.onreadystatechange = function () {
				if (xhr.readyState == 4 && xhr.status == 200) {

					if (xhr.responseURL == "http://localhost:8080/soeasy/customerController/customerSignIn") {
						location.href = "/soeasy/customerController/customerSignIn";
					}

					let favoriteJson = JSON.parse(xhr.responseText);
					console.log(favoriteJson);
					//更改圖片
					if (favoriteJson.favoriteExist) {
						favoriteHeart.src = "${pageContext.request.contextPath}/images/post/heart.png";
						postLike.innerHTML = favoriteJson.favoriteCount;
					} else {
						favoriteHeart.src = "${pageContext.request.contextPath}/images/post/heart-empty.png";
						postLike.innerHTML = favoriteJson.favoriteCount;

					}

				}

			}

		}		
			
		})

	</script>


<script>
		document.addEventListener("DOMContentLoaded", function () {

			//變數宣告------------------------------------------------------------

			let replies;
			let postBean = ${ getOnePostBean.postId }
			// 查詢字串包含1.即將要讀取的類別(postCategoryBean),
			// 注意，查詢字串的前面有問號
			let queryString = "?postBean=" + postBean;
			let customerId = ${ customerSignInSuccess.customerId }
// 			console.log("customerId=" + customerId);

			//變數宣告------------------------------------------------------------

			//載入時 取得所有此文章的留言-----------------------------------------------------


			//新建XMLHttpRequest物件
			let xhr = new XMLHttpRequest();
			//設定連線內容
			xhr.open("GET", "<c:url value='/ReplyNeedLoginController/getAllReply.json'/>" + queryString, true);
			//對伺服器發送請求
			xhr.send();
			//當readyState屬性值改變時呼叫此方法
			xhr.onreadystatechange = function () {
				if (xhr.readyState == 4 && xhr.status == 200) {

					replies = JSON.parse(xhr.responseText);
					// 			console.log(xhr.responseText);
					// 			console.log("replies="+replies);

					displayReplies();
				}
			}
			
			function favoriteReply() {
				let inputFavoriteReplyId = null;
				$(".replyShowFavorite").on('click', function (event) {
					console.log("點擊愛心");
					console.log(this.dataset.id);
					let updateFavoriteReplyId = this.dataset.id;
					let replyLike = document.getElementById("replyLike"+updateFavoriteReplyId);
					let replyImg = document.getElementById("replyImg"+updateFavoriteReplyId);

					//建一支Object，裝收藏controller要的內容
					let favoriteInfo = {
						'favoriteCategory': 'reply',
						'favoriteItemId': updateFavoriteReplyId
					}

					//將物件轉為json			
					let json = JSON.stringify(favoriteInfo);

					console.log(json);

					xhr.open('POST', "<c:url value='/favoriteController/addFavoriteReply'/>");
					xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
					xhr.send(json);

					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {

							if (xhr.responseURL == "http://localhost:8080/soeasy/customerController/customerSignIn") {
								location.href = "/soeasy/customerController/customerSignIn";
							}

							let favoriteJson = JSON.parse(xhr.responseText);
							console.log(favoriteJson);
							//更改圖片
							if (favoriteJson.favoriteExist) {
								replyImg.src = "${pageContext.request.contextPath}/images/post/heart.png";
								replyLike.innerHTML = favoriteJson.favoriteCount;
							} else {
								replyImg.src = "${pageContext.request.contextPath}/images/post/heart-empty.png";
								replyLike.innerHTML = favoriteJson.favoriteCount;

							}

						}

					}
				})
			}

			// 顯示送回來的所有留言
			function displayReplies() {

				// 	 		console.log(xhr.responseText);
				// 	 		console.log(replies);


				let content = "";

				(replies).forEach(reply => {

					//                     console.log("reply.favoriteStatus=" + reply.favoriteStatus);

					if (reply.replyStatus == 2) {

						content += '<div class="row-fluid" style="border-top: 4px #C9D8BF dotted; padding-top: 1%; background-color:rgb(245,245,245);">'
							+ '<div class="span11" style="display: flex;">'
							//	 						留言者頭像
							+ '<img alt="留言者頭像" src="${pageContext.request.contextPath}/images/salad.png" class="img-circle"'
							+ 'style="width: 50px; height: 50px;" />&nbsp;&nbsp;'
							+ '<div style="font-style:italic;">'
							// 							留言者暱稱+樓層+時間
							+ '這則回應已被刪除。<br> B' + reply.replyFloor + '&nbsp;&nbsp;‧&nbsp;&nbsp;' + reply.replyTime.substring(0, 16)
							+ '</div>'
							+ '</div>'
							+ '<div class="row-fluid">'
							+ '<div class="span12" style="padding: 2%; font-style:italic;">'
							+ '<p>'
							+ '已經刪除的內容就像變了心的女朋友一樣，錯過是無法再相見的！'
							+ '</p>'
							+ '</div>'
							+ '</div>'
							+ '</div>'
					} else {



						// 有無收藏
						if (reply.favoriteStatus == null) {
							// Like圖片(無收藏)ID
							img = '<img id="replyImg'+reply.replyId+'" src="${pageContext.request.contextPath}/images/post/heart-empty.png">'
						} else {
							// Like圖片(有收藏)ID
							img = '<img id="replyImg'+reply.replyId+'" src="${pageContext.request.contextPath}/images/post/heart.png">'
						}
// 						console.log("reply.customerBean.customerId=" + reply.customerBean.customerId);
						// 是否是留言本人
						if (reply.customerBean.customerId == customerId) {

							// Update按鈕
							btnContent = '<div class="span2">'
								+ '<button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#replyInfoModal"'
								+ 'data-id="' + reply.replyId
								+ '"data-content="' + reply.replyContent
								+ '">Update</button>'

								// 	Delete按鈕
								+ '<button type="button" class="btn btn-success btn-sm" style="margin: 0% 1%;" data-toggle="modal" data-target="#replyDeleteModal"'
								+ 'data-id="' + reply.replyId
								+ '"data-status="' + reply.replyStatus
								+ '">Delete</button>'

								+ '</div>'
						} else {
							btnContent = ''
						}

						content += '<div class="row-fluid" style="border-top: 4px #C9D8BF dotted; padding-top: 1%">'
							+ '<div class="span11" style="display: flex;">'
							//	 						留言者頭像
							+ '<img alt="留言者頭像" src="<c:url value="/customerController/getCustomerImgById/' + reply.customerBean.customerId + '" />" class="img-circle"'
							+ 'style="width: 50px; height: 50px;" />&nbsp;&nbsp;'
							+ '<div>'
							// 							留言者暱稱+樓層+時間
							+ reply.customerBean.customerName + '<br> B' + reply.replyFloor + '&nbsp;&nbsp;‧&nbsp;&nbsp;' + reply.replyTime.substring(0, 16)
							+ '</div>'
							+ '</div>'

							+ '<div class="span1">'

							+ '<div style="display:flex; align-items :end;" class="replyFavorite" data-id="' + reply.replyId + '">'
							//							Like按鈕(無收藏)ID
							+ '<button class="replyShowFavorite"  data-id="' + reply.replyId + '"'
							+ 'style="border: none; background-color: transparent;">'
							+ img
							+ '</button>'
							//	 						Like數量
							+ '<p id="replyLike'+reply.replyId+'">'
							+ reply.replyLike + '</p>'
							+ '</div>'

							+ '</div>'


							+ '</div>'

							+ '<div style="display:flex;">'

							+ '<div class="row-fluid">'
							+ '<div class="span10" style="padding: 2%;">'
							+ '<p>'
							// 							留言內容
							+ reply.replyContent
							+ '</p>'
							+ '</div>'

							+ btnContent

							+ '</div>'

							+ '</div>';

					}

				})
				document.getElementById("insertReplies").innerHTML = content;
				favoriteReply();
			}


			//		互動視窗--更新留言
			//		開啟互動視窗表單
			let inputReplyId = null;
			$('#replyInfoModal').on('show.bs.modal', function (event) {
				//	 		取得代入update按鈕的值
				let button = $(event.relatedTarget);
				let updateReplyId = button.data('id');
				inputReplyId = updateReplyId;		//作為表單送出用ID
				let updateReplyContent1 = button.data('content').replaceAll("\n", "");
				let updateReplyContent = updateReplyContent1.replaceAll("<br>", "\n");
				let modal = $(this);
				//			依照取得值寫入表單
				modal.find('.modal-title').text('留言修改	ID: ' + updateReplyId);
				modal.find('.modal-body #recipient-content').val(updateReplyContent);
			})

			//	 	互動視窗--更新留言--送出按鈕
			let sendReplyInfo = document.getElementById("sendReplyInfo");
			let replyInfo_form = document.getElementById("replyInfo_form");

			sendReplyInfo.addEventListener("click", function () {
				//			表單資料初始化
				// ID使用原先取得的值
				let inputRreplyContent = document.getElementById("recipient-content");

				//	 		建立一支obj，將input內容裝入

				let updateReplyObj = {
					"replyId": inputReplyId,	//Id為Update代入的值(全域)
					"replyContent": inputRreplyContent.value
				}

				//	 		將物件轉為JSON字串
				let json = JSON.stringify(updateReplyObj);

				xhr.open('POST', "<c:url value='/ReplyNeedLoginController/updateReply'/>", true);
				xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
				xhr.send(json);

				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4 && xhr.status == 200) {
						//					接收回傳訊息，更新訊息框
						let replyJSON = JSON.parse(xhr.responseText);
						//	 				infoMessage.innerHTML = replyJSON.updateMessage;
						console.log(replyJSON);
						//					重新撈留言

						//設定連線內容
						xhr.open("GET", "<c:url value='/ReplyNeedLoginController/getAllReply.json'/>" + queryString, true);
						//對伺服器發送請求
						xhr.send();
						//當readyState屬性值改變時呼叫此方法
						xhr.onreadystatechange = function () {
							if (xhr.readyState == 4 && xhr.status == 200) {

								replies = JSON.parse(xhr.responseText);

								displayReplies();
							}
						}
					}
				}

			})

			// --------------------------------------------------------------------------------------------------------------------------

			// //		互動視窗--刪除留言
			// //		開啟互動視窗表單
			let inputDeleteReplyId = null;
			$('#replyDeleteModal').on('show.bs.modal', function (event) {
				// //	 		取得代入delete按鈕的值
				let button = $(event.relatedTarget);
				let deleteReplyId = button.data('id');
				inputDeleteReplyId = deleteReplyId;		//作為表單送出用ID
				let deleteReplyStatus = button.data('status');
				let modal = $(this);
				// //			依照取得值寫入表單
				modal.find('.modal-title').text('留言刪除	ID: ' + deleteReplyId);
				if (deleteReplyStatus == 1) {
					modal.find('.modal-body #recipient-status1').prop('checked', true);
				} else if (deleteReplyStatus == 2) {
					modal.find('.modal-body #recipient-status2').prop('checked', true);
				}
			})

			// //	 	互動視窗--刪除留言--送出按鈕
			let sendReplyDelete = document.getElementById("sendReplyDelete");
			let replyDelete_form = document.getElementById("replyDelete_form");

			sendReplyDelete.addEventListener("click", function () {
				// //			表單資料初始化
				// 		// ID使用原先取得的值
				let inputReplyStatus1 = document.getElementById("recipient-status1");
				let inputReplyStatus2 = document.getElementById("recipient-status2");

				let inputReplyStatus = null;
				if (inputReplyStatus1.checked) {
					inputReplyStatus = inputReplyStatus1.value;
				} else if (inputReplyStatus2.checked) {
					inputReplyStatus = inputReplyStatus2.value;
				}

				// //	 		建立一支obj，將input內容裝入

				let deleteReplyObj = {
					"replyId": inputDeleteReplyId,	//Id為delete代入的值(全域)
					"replyStatus": inputReplyStatus
				}

				// //	 		將物件轉為JSON字串
				let json = JSON.stringify(deleteReplyObj);

				xhr.open('POST', "<c:url value='/ReplyNeedLoginController/deleteReply'/>", true);
				xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
				xhr.send(json);

				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4 && xhr.status == 200) {
						//					接收回傳訊息，更新訊息框
						let replyJSON = JSON.parse(xhr.responseText);
						//	 				infoMessage.innerHTML = replyJSON.deleteMessage;
						console.log(replyJSON);
						//					重新撈留言

						//設定連線內容
						xhr.open("GET", "<c:url value='/ReplyNeedLoginController/getAllReply.json'/>" + queryString, true);
						// 					//對伺服器發送請求
						xhr.send();
						// 					//當readyState屬性值改變時呼叫此方法
						xhr.onreadystatechange = function () {
							if (xhr.readyState == 4 && xhr.status == 200) {

								replies = JSON.parse(xhr.responseText);

								displayReplies();
							}
						}
					}
				}

			})

		})
	</script>


<script>
		document.addEventListener("DOMContentLoaded", function () {

			//變數宣告------------------------------------------------------------

			let top3Replies;
			let postBean = ${ getOnePostBean.postId }
			// 查詢字串包含1.即將要讀取的類別(postCategoryBean),
			// 注意，查詢字串的前面有問號
			let queryString = "?postBean=" + postBean;

			//變數宣告------------------------------------------------------------

			//新建XMLHttpRequest物件
			let xhr = new XMLHttpRequest();
			//設定連線內容
			xhr.open("GET", "<c:url value='/ReplyNeedLoginController/getTop3Reply.json'/>" + queryString, true);
			//對伺服器發送請求
			xhr.send();
			//當readyState屬性值改變時呼叫此方法
			xhr.onreadystatechange = function () {
				if (xhr.readyState == 4 && xhr.status == 200) {

					replies = JSON.parse(xhr.responseText);
					// 			console.log(xhr.responseText);
					// 			console.log("replies="+replies);

					displayTop3Replies();
				}
			}

			// 顯示送回來的所有留言
			function displayTop3Replies() {

				// 		console.log(xhr.responseText);
				// 		console.log(replies);


				let contentTop3 = "";

				(replies).forEach(reply => {

					if (reply.replyStatus == 2) {
						contentTop3 += '<div class="row-fluid" style="border-top: 4px #C9D8BF dotted; padding-top: 1%; background-color:rgb(245,245,245);">'
							+ '<div class="span11" style="display: flex;">'
							//	 						留言者頭像
							+ '<img alt="留言者頭像" src="${pageContext.request.contextPath}/images/salad.png" class="img-circle"'
							+ 'style="width: 50px; height: 50px;" />&nbsp;&nbsp;'
							+ '<div style="font-style:italic;">'
							// 							留言者暱稱+樓層+時間
							+ '這則回應已被刪除。<br> B' + reply.replyFloor + '&nbsp;&nbsp;‧&nbsp;&nbsp;' + reply.replyTime.substring(0, 16)
							+ '</div>'
							+ '</div>'
							+ '<div class="row-fluid">'
							+ '<div class="span12" style="padding: 2%; font-style:italic;">'
							+ '<p>'
							+ '已經刪除的內容就像變了心的女朋友一樣，錯過是無法再相見的！'
							+ '</p>'
							+ '</div>'
							+ '</div>'
							+ '</div>'
					} else {
						contentTop3 += '<div class="row-fluid" style="border-top: 4px #C9D8BF dotted; padding-top: 1%">'
							+ '<div class="span11" style="display: flex;">'
							//					留言者頭像
							+ '<img alt="留言者頭像" src="<c:url value="/customerController/getCustomerImgById/' + reply.customerBean.customerId + '" />" class="img-circle"'
							+ 'style="width: 50px; height: 50px;" />&nbsp;&nbsp;'
							+ '<div>'
							//					留言者暱稱+樓層+時間
							+ reply.customerBean.customerName + '<br> B' + reply.replyFloor + '&nbsp;&nbsp;‧&nbsp;&nbsp;' + reply.replyTime.substring(0, 16)
							+ '</div>'
							+ '</div>'

							+ '<div class="span1">'
							//				Like按鈕SVG
	// 						+'<svg id="color" enable-background="new 0 0 24 24" height="512" viewBox="0 0 24 24" width="512" xmlns="http://www.w3.org/2000/svg"><path d="m22.843 12.586c-.169-.372-.169-.8 0-1.172l.895-1.969c.333-.733.348-1.58.04-2.323-.309-.744-.917-1.333-1.671-1.615l-2.024-.76c-.384-.144-.686-.445-.829-.829l-.76-2.024c-.282-.754-.871-1.362-1.615-1.671-.741-.308-1.59-.293-2.323.04l-1.969.895c-.373.17-.801.17-1.172 0l-1.97-.895c-.732-.334-1.581-.349-2.323-.04-.744.308-1.333.917-1.615 1.671l-.76 2.024c-.143.384-.445.685-.829.829l-2.024.76c-.754.282-1.363.871-1.671 1.615-.308.743-.293 1.59.04 2.323l.895 1.969c.169.372.169.8 0 1.172l-.895 1.969c-.333.733-.348 1.58-.04 2.323.309.744.917 1.333 1.671 1.615l2.024.76c.384.144.686.445.829.829l.76 2.024c.282.754.871 1.362 1.615 1.671.355.147.735.221 1.115.221.413 0 .826-.087 1.208-.261l1.969-.895c.373-.17.801-.17 1.172 0l1.969.895c.732.334 1.581.348 2.323.04.744-.309 1.333-.917 1.615-1.671l.76-2.024c.144-.384.445-.686.829-.829l2.024-.76c.754-.282 1.362-.871 1.671-1.615.308-.743.293-1.59-.04-2.323z" fill="#f44336"/><g fill="#fafafa"><path d="m13.414 9.702c-.877-.877-2.305-.877-3.182 0s-.877 2.305 0 3.182l1.414 1.414c.438.438 1.015.658 1.591.658s1.152-.22 1.591-.658c.877-.877.877-2.305 0-3.182zm.354 3.535c-.293.293-.768.293-1.061 0l-1.414-1.414c-.292-.292-.292-.769 0-1.061.146-.147.338-.219.53-.219s.384.072.53.219l1.414 1.414c.293.293.293.769.001 1.061z"/><path d="m8.818 12.177c-.293-.293-.768-.293-1.061 0s-.293.768 0 1.061l1.237 1.237-1.061 1.062-1.238-1.238c-.293-.293-.768-.293-1.061 0s-.293.768 0 1.061l3.536 3.536c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061l-1.237-1.237 1.061-1.062 1.237 1.237c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z"/><path d="m18.364 9.702-3.006-3.006.53-.53c.293-.293.293-.768 0-1.061s-.768-.293-1.061 0l-1.059 1.06-.002.001-.001.001-1.06 1.061c-.293.293-.293.768 0 1.061.146.146.339.22.53.22.192 0 .384-.073.53-.22l.53-.531 3.006 3.006c.146.146.338.22.53.22s.384-.073.53-.22c.296-.294.296-.769.003-1.062z"/></g><path d="m13.025 11.435-1.061 1.061.742.742c.146.146.338.22.53.22s.384-.073.53-.22c.292-.292.292-.769 0-1.061zm6.809-6.809-3.273 3.273 1.803 1.803c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.804-1.804-1.415 1.415.742.742c.877.877.877 2.305 0 3.182-.438.438-1.015.658-1.591.658s-1.152-.22-1.591-.658l-.742-.742-.354.354 1.803 1.803c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.237-1.237-1.061 1.062 1.237 1.237c.293.293.293.768 0 1.061-.146.146-.338.22-.53.22s-.384-.073-.53-.22l-1.803-1.803-2.743 2.743c.048.078.089.161.121.248l.76 2.024c.282.754.871 1.362 1.615 1.671.355.147.735.221 1.115.221.413 0 .826-.087 1.208-.261l1.969-.895c.187-.085.387-.127.587-.127s.4.042.585.127l1.969.895c.381.174.795.261 1.208.261.38 0 .76-.074 1.116-.221.744-.309 1.333-.917 1.615-1.671l.76-2.024c.144-.384.445-.686.829-.829l2.024-.76c.754-.282 1.362-.871 1.671-1.615.308-.743.293-1.59-.04-2.323l-.895-1.969c-.169-.372-.169-.8 0-1.172l.895-1.969c.333-.733.348-1.58.04-2.323-.309-.744-.917-1.333-1.671-1.615l-2.024-.76c-.087-.036-.17-.076-.248-.124z" fill="#d43a2f"/><path d="m14.086 10.374-1.061 1.061.742.742c.292.292.292.768 0 1.061-.147.146-.338.22-.53.22s-.384-.073-.53-.22l-.742-.742-1.061 1.061.742.742c.438.438 1.015.658 1.591.658s1.152-.22 1.591-.658c.877-.877.877-2.305 0-3.182z" fill="#dadada"/><path d="m10.551 13.909-3.182 3.182 1.803 1.803c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061l-1.237-1.237 1.061-1.062 1.237 1.237c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z" fill="#dadada"/><path d="m16.561 7.899-1.061 1.06 1.803 1.803c.146.146.338.22.53.22s.384-.073.53-.22c.293-.293.293-.768 0-1.061z" fill="#dadada"/></svg>'
							+'<svg enable-background="new 0 0 24 24" height="512" viewBox="0 0 24 24" width="512" xmlns="http://www.w3.org/2000/svg"><g id="color"><g><g><path d="m21.758 12.527c-.152-.335-.152-.72 0-1.055l.805-1.772c.3-.66.313-1.422.036-2.091-.278-.67-.825-1.2-1.504-1.454l-1.822-.684c-.345-.129-.617-.401-.746-.746l-.684-1.822c-.253-.677-.783-1.225-1.453-1.503-.667-.277-1.431-.264-2.091.036l-1.772.805c-.336.153-.721.153-1.055 0l-1.771-.805c-.659-.3-1.423-.313-2.091-.036-.67.278-1.2.825-1.454 1.504l-.684 1.822c-.129.346-.4.617-.746.746l-1.822.684c-.678.254-1.226.784-1.504 1.454-.276.669-.263 1.431.036 2.091l.805 1.772c.152.335.152.72 0 1.055l-.805 1.772c-.3.66-.313 1.422-.036 2.091.278.67.825 1.2 1.504 1.454l1.822.684c.345.129.617.401.746.746l.684 1.822c.254.677.784 1.225 1.454 1.503.32.133.662.199 1.004.199.372 0 .744-.078 1.087-.235l1.772-.805c.336-.153.721-.153 1.055 0l1.772.805c.659.301 1.423.313 2.091.036.67-.278 1.2-.825 1.454-1.504l.684-1.822c.129-.345.401-.617.746-.746l1.822-.684c.679-.254 1.226-.784 1.504-1.454.277-.669.264-1.431-.036-2.091z" fill="#f44336"/></g></g></g><g id="_x31_.5"><g><g><path d="m8.237 23.998c-.38 0-.76-.073-1.115-.221-.744-.309-1.333-.917-1.615-1.671l-.76-2.024c-.144-.384-.445-.686-.829-.829l-2.024-.76c-.754-.282-1.362-.871-1.671-1.615-.308-.743-.293-1.59.04-2.323l.895-1.969c.169-.372.169-.8 0-1.172l-.895-1.969c-.333-.733-.348-1.58-.04-2.323.308-.744.917-1.333 1.671-1.615l2.024-.76c.384-.144.686-.445.829-.829l.76-2.024c.282-.754.871-1.363 1.615-1.671.742-.309 1.591-.294 2.323.04l1.969.895c.371.17.799.17 1.172 0l1.969-.895c.733-.333 1.582-.348 2.323-.04.744.309 1.333.917 1.615 1.671l.76 2.024c.144.384.445.686.829.829l2.024.76c.754.282 1.362.871 1.671 1.615.308.743.293 1.59-.04 2.323l-.895 1.969c-.169.372-.169.8 0 1.172l.895 1.969c.333.733.348 1.58.04 2.323-.309.744-.917 1.333-1.671 1.615l-2.024.76c-.384.144-.686.445-.829.829l-.76 2.024c-.282.754-.871 1.362-1.615 1.671-.741.308-1.59.294-2.323-.04l-1.969-.895c-.371-.17-.799-.17-1.172 0l-1.969.895c-.382.174-.795.261-1.208.261zm.001-22.498c-.184 0-.367.036-.543.108-.366.152-.645.44-.784.812l-.76 2.024c-.296.788-.918 1.41-1.706 1.706l-2.024.76c-.372.14-.66.418-.812.784-.151.367-.145.768.02 1.129l.895 1.969c.349.768.349 1.646 0 2.414l-.895 1.969c-.164.361-.171.762-.02 1.129.152.366.44.645.812.784l2.024.76c.788.296 1.41.918 1.706 1.706l.76 2.024c.14.372.418.66.784.812.366.15.767.144 1.129-.02l1.969-.895c.768-.35 1.646-.35 2.414 0l1.969.895c.361.163.763.171 1.129.02.366-.152.645-.44.784-.812l.76-2.024c.296-.788.918-1.41 1.706-1.706l2.024-.76c.372-.14.66-.418.812-.784.151-.367.145-.768-.02-1.129l-.895-1.969c-.349-.768-.349-1.646 0-2.414l.895-1.969c.164-.361.171-.762.02-1.129-.152-.366-.44-.645-.812-.784l-2.024-.76c-.788-.296-1.41-.918-1.706-1.706l-.76-2.024c-.14-.372-.418-.66-.784-.812-.367-.15-.767-.144-1.129.02l-1.969.895c-.768.35-1.646.35-2.414 0l-1.969-.895c-.187-.085-.386-.128-.586-.128z"/></g></g><g><g><g><path d="m13.237 14.956c-.576 0-1.152-.22-1.591-.658l-1.414-1.414c-.877-.877-.877-2.305 0-3.182s2.305-.877 3.182 0l1.414 1.414c.877.877.877 2.305 0 3.182-.438.438-1.015.658-1.591.658zm-1.414-4.412c-.192 0-.384.072-.53.219-.292.292-.292.769 0 1.061l1.414 1.414c.293.293.768.293 1.061 0 .292-.292.292-.769 0-1.061l-1.414-1.414c-.147-.147-.338-.219-.531-.219z"/></g></g><g><g><path d="m13.237 8.508c-.191 0-.384-.073-.53-.22-.293-.293-.293-.768 0-1.061l2.121-2.122c.293-.293.768-.293 1.061 0s.293.768 0 1.061l-2.121 2.122c-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m9.702 19.114c-.192 0-.384-.073-.53-.22l-3.536-3.536c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.536 3.536c.293.293.293.768 0 1.061-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m11.823 16.992c-.192 0-.384-.073-.53-.22l-3.535-3.535c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.535 3.535c.293.293.293.768 0 1.061-.147.147-.338.22-.531.22z"/></g></g><g><g><path d="m17.834 10.982c-.192 0-.384-.073-.53-.22l-3.536-3.536c-.293-.293-.293-.768 0-1.061s.768-.293 1.061 0l3.536 3.536c.293.293.293.768 0 1.061-.147.147-.339.22-.531.22z"/></g></g><g><g><path d="m7.935 17.347c-.192 0-.384-.073-.53-.22-.293-.293-.293-.768 0-1.061l2.121-2.122c.292-.292.767-.294 1.061 0 .293.293.293.768 0 1.061l-2.121 2.122c-.148.146-.339.22-.531.22z"/></g></g></g></g></svg>'

							//					Like數量
							+ '</a>' + '&nbsp;&nbsp;'+reply.replyLike
							+ '</div>'
							+ '</div>'

							+ '<div class="row-fluid">'
							+ '<div class="span12" style="padding: 2%;">'
							+ '<p>'
							//					留言內容
							+ reply.replyContent
							+ '</p>'
							+ '</div>'
							+ '</div>'
					}

				})
				document.getElementById("insertTop3Replies").innerHTML = contentTop3;
			}
			
			
		})
	</script>

</head>



<body>
	<!-- 引入共同的頁首  copy這行-->
	<jsp:include page="/fragment/header.jsp" />

	<hr style="color: transparent;">

	<!-- --------------------------------------------文章顯示區開始------------------------------------------------------- -->
	<div class="container-fluid"
		style="width: 80%; padding: 1% 5%; border: 2px solid lightslategray; border-radius: 10px; box-shadow: 3px 3px 12px lightgrey; margin-left: 10%; margin-top: 8.5%;">
		<!-- 			作者頭像+暱稱開始 -->
		<div class="row-fluid">
			<div class="span10" style="display: flex; align-items: center;">
				<img alt="作者頭像"
					src="<c:url value='/customerController/getCustomerImgById/${getOnePostBean.customerBean.customerId}' />"
					class="img-circle" style="width: 50px; height: 50px;" />
				<p class="text-left">&nbsp;&nbsp;&nbsp;${getOnePostBean.customerBean.customerNickname}</p>
			</div>
			<!-- 			作者頭像+暱稱結束 -->

			<div class="span2" style="display: flex; align-items: center;">
				<c:choose>
					<c:when
						test="${getOnePostBean.customerBean.customerId == customerSignInSuccess.customerId}">
						<!-- --------------------------------------------文章修改區開始------------------------------------------------------- -->
						<a
							href="<c:url value='/PostNeedLoginController/updatePost/${getOnePostBean.postId}' /> "
							style="text-decoration: none; margin: 5%; width: 15%; height: 10%;">
							<svg viewBox="-27 0 512 512.00052"
								xmlns="http://www.w3.org/2000/svg" style="width: 100%;">
								<path
									d="m32.308594 256.488281c0 65.777344 32.679687 123.921875 82.6875 159.082031 8.8125 6.199219 9.28125 19.070313.816406 25.734376l-.238281.1875c-5.527344 4.351562-13.277344 4.640624-19.035157.597656-58.378906-41-96.539062-108.847656-96.539062-185.601563 0-124.496093 103.050781-225.5625 227.296875-226.625v32.316407c-106.414063 1.054687-194.988281 87.648437-194.988281 194.308593zm0 0"
									fill="#1ed688" />
								<path
									d="m233.230469.964844 59.375 40.613281c3.179687 2.175781 3.179687 6.867187 0 9.042969l-59.375 40.613281c-3.636719 2.488281-8.570313-.117187-8.570313-4.519531v-81.226563c0-4.40625 4.933594-7.007812 8.570313-4.523437zm0 0"
									fill="#1ab975" />
								<path
									d="m425.382812 255.511719c0-65.777344-32.683593-123.921875-82.691406-159.082031-8.8125-6.199219-9.28125-19.070313-.816406-25.734376l.238281-.1875c5.527344-4.351562 13.277344-4.640624 19.035157-.597656 58.382812 41 96.539062 108.847656 96.539062 185.601563 0 124.496093-102.875 225.5625-227.125 226.625v-32.316407c106.414062-1.054687 194.820312-87.644531 194.820312-194.308593zm0 0"
									fill="#1ed688" />
								<path
									d="m224.460938 511.035156-59.375-40.613281c-3.179688-2.175781-3.179688-6.867187 0-9.042969l59.375-40.613281c3.632812-2.488281 8.570312.117187 8.570312 4.519531v81.226563c0 4.40625-4.9375 7.011719-8.570312 4.523437zm0 0"
									fill="#1ab975" />
								<path
									d="m329.628906 230.820312-97.257812 80.65625-24.519532 20.335938c-5.777343 4.785156-13.089843 7.382812-20.527343 7.382812-1.238281 0-2.476563-.070312-3.726563-.214843-8.675781-1.019531-16.660156-5.621094-21.898437-12.617188l-37.820313-50.414062c-8.539062-11.386719-6.230468-27.550781 5.160156-36.105469 11.398438-8.539062 27.5625-6.230469 36.105469 5.160156l25.53125 34.042969.207031-.167969 105.828126-87.765625c10.964843-9.085937 27.222656-7.570312 36.3125 3.394531 9.089843 10.964844 7.570312 27.222657-3.394532 36.3125zm0 0"
									fill="#1ed688" />
								<path
									d="m329.628906 230.820312-97.257812 80.65625c-15.90625-7.941406-29.894532-18.917968-41.488282-32.597656l105.828126-87.765625c10.964843-9.085937 27.222656-7.570312 36.3125 3.394531 9.089843 10.964844 7.570312 27.222657-3.394532 36.3125zm0 0"
									fill="#35e298" />
							</svg>
						</a>
						<!-- --------------------------------------------文章修改區結束------------------------------------------------------- -->

						<!-- --------------------------------------------文章刪除區開始------------------------------------------------------- -->
						<a class="deletePost"
							href="<c:url value='/PostNeedLoginController/deletePost/${getOnePostBean.postId}' /> "
							style="text-decoration: none; margin: 3%; width: 15%; height: 10%;">
							<svg height="427pt" viewBox="0 0 427 427.00131"
								style="width: 100%; height: 10%; fill: limegreen;"
								xmlns="http://www.w3.org/2000/svg">
								<path
									d="m232.398438 154.703125c-5.523438 0-10 4.476563-10 10v189c0 5.519531 4.476562 10 10 10 5.523437 0 10-4.480469 10-10v-189c0-5.523437-4.476563-10-10-10zm0 0" />
								<path
									d="m114.398438 154.703125c-5.523438 0-10 4.476563-10 10v189c0 5.519531 4.476562 10 10 10 5.523437 0 10-4.480469 10-10v-189c0-5.523437-4.476563-10-10-10zm0 0" />
								<path
									d="m28.398438 127.121094v246.378906c0 14.5625 5.339843 28.238281 14.667968 38.050781 9.285156 9.839844 22.207032 15.425781 35.730469 15.449219h189.203125c13.527344-.023438 26.449219-5.609375 35.730469-15.449219 9.328125-9.8125 14.667969-23.488281 14.667969-38.050781v-246.378906c18.542968-4.921875 30.558593-22.835938 28.078124-41.863282-2.484374-19.023437-18.691406-33.253906-37.878906-33.257812h-51.199218v-12.5c.058593-10.511719-4.097657-20.605469-11.539063-28.03125-7.441406-7.421875-17.550781-11.5546875-28.0625-11.46875h-88.796875c-10.511719-.0859375-20.621094 4.046875-28.0625 11.46875-7.441406 7.425781-11.597656 17.519531-11.539062 28.03125v12.5h-51.199219c-19.1875.003906-35.394531 14.234375-37.878907 33.257812-2.480468 19.027344 9.535157 36.941407 28.078126 41.863282zm239.601562 279.878906h-189.203125c-17.097656 0-30.398437-14.6875-30.398437-33.5v-245.5h250v245.5c0 18.8125-13.300782 33.5-30.398438 33.5zm-158.601562-367.5c-.066407-5.207031 1.980468-10.21875 5.675781-13.894531 3.691406-3.675781 8.714843-5.695313 13.925781-5.605469h88.796875c5.210937-.089844 10.234375 1.929688 13.925781 5.605469 3.695313 3.671875 5.742188 8.6875 5.675782 13.894531v12.5h-128zm-71.199219 32.5h270.398437c9.941406 0 18 8.058594 18 18s-8.058594 18-18 18h-270.398437c-9.941407 0-18-8.058594-18-18s8.058593-18 18-18zm0 0" />
								<path
									d="m173.398438 154.703125c-5.523438 0-10 4.476563-10 10v189c0 5.519531 4.476562 10 10 10 5.523437 0 10-4.480469 10-10v-189c0-5.523437-4.476563-10-10-10zm0 0" />
							</svg>
						</a>
						<!-- --------------------------------------------文章刪除區結束------------------------------------------------------- -->

						<!-- --------------------------------------------前一頁------------------------------------------------------- -->
						<a class="" href="<c:url value="/postByCategory"></c:url>">回上一頁
						</a>
						<!-- --------------------------------------------前一頁------------------------------------------------------- -->

					</c:when>
					<c:otherwise>
						<!-- --------------------------------------------前一頁------------------------------------------------------- -->
						<a class="" href="<c:url value="/postByCategory"></c:url>">回上一頁
						</a>
						<!-- --------------------------------------------前一頁------------------------------------------------------- -->
					</c:otherwise>

				</c:choose>
			</div>
		</div>



		<!-- 			作者頭像+暱稱結束 -->

		<!-- 			文章標題+類別+時間 -->
		<div class="row-fluid">
			<div class="span12">
				<h2>${getOnePostBean.postTitle}</h2>
				<a>${getOnePostBean.postCategory}</a>&nbsp;&nbsp;‧&nbsp;&nbsp;${fn:substring(getOnePostBean.postUploadTime,0,16)}
			</div>

		</div>
		<!-- 			文章標題+類別+時間 -->

		<!-- 			文章圖片 -->
		<div class="row-fluid" style="margin-bottom: 2%;">
			<div class="span12" style="text-align: center;">
				<img alt="文章圖片"
					src="<c:url value='/PostController/getPicture/${getOnePostBean.postId}' />"
					class="img-polaroid" />
			</div>
		</div>
		<!-- 			文章圖片 -->

		<!-- 			文章內容 -->
		<div class="row-fluid">
			<div class="span12">
				<p>${getOnePostBean.postContent}</p>
			</div>
		</div>
		<!-- 			文章內容 -->
		<br>
		<!-- 			文章likes -->
		<div class="row-fluid">
			<div style="display: flex;">
				<c:choose>
					<c:when test="${getOnePostBean.favoriteStatus == true}">
						<div style="display: flex; align-items: end;">
							<button id="showFavorite"
								style="border: none; background-color: transparent;">
								<img id="favoriteHeart"
									src="${pageContext.request.contextPath}/images/post/heart.png">
							</button>
							<p id="postLike">${getOnePostBean.postLike}</p>
						</div>
					</c:when>
					<c:otherwise>
						<div style="display: flex; align-items: end;">
							<button id="showFavorite"
								style="border: none; background-color: transparent;">
								<img id="favoriteHeart"
									src="${pageContext.request.contextPath}/images/post/heart-empty.png">
							</button>
							<p id="postLike">${getOnePostBean.postLike}</p>
						</div>

					</c:otherwise>
				</c:choose>
				<div style="margin: 0% 1%;">
					<!-- Load Facebook SDK for JavaScript -->
					<div id="fb-root"></div>
					<script>
					 function sethref() 
					 {
					  document.getElementById("shareFB").setAttribute("href","https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(document.URL));
					 }
					 
					window.onload = sethref;
					(function(d, s, id) {
						var js, fjs = d.getElementsByTagName(s)[0];
						if (d.getElementById(id)) return;
						js = d.createElement(s); js.id = id;
						js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0";
						fjs.parentNode.insertBefore(js, fjs);
					}(document, 'script', 'facebook-jssdk'));</script>

					<!-- Your share button code -->
					<!-- 					要改發表的那台點腦的IP -->
					<div class="fb-share-button"
						data-href="http://192.168.10.79:8080/soeasy/PostNeedLoginController/getPost/${getOnePostBean.postId}"
						data-layout="button_count" data-name="SoEasy Share"></div>
				</div>
				<!-- 				Line Share -->
				<div style="margin-top: 0.5%;">
					<div class="line-it-button" data-lang="zh_Hant" data-type="share-a"
						data-ver="3"
						data-url="http://192.168.10.79:8080/soeasy/PostNeedLoginController/getPost/${getOnePostBean.postId}"
						data-color="default" data-size="small" data-count="true"
						style="display: none;"></div>
				</div>
				<script
					src="https://www.line-website.com/social-plugins/js/thirdparty/loader.min.js"
					async="async" defer="defer"></script>
				<!-- 				Line Share -->
				<!-- 				Twitter Share -->
				<script>
				window.twttr = (function(d, s, id) {
  					var js, fjs = d.getElementsByTagName(s)[0],
  					t = window.twttr || {};
					if (d.getElementById(id)) return t;
  					js = d.createElement(s);
 			 		js.id = id;
  					js.src = "https://platform.twitter.com/widgets.js";
  					fjs.parentNode.insertBefore(js, fjs);

  					t._e = [];
  					t.ready = function(f) {
    				t._e.push(f);
  					};

 					return t;
				}(document, "script", "twitter-wjs"));
				</script>
				<div style="margin-top: 0.5%; margin-left: 1%;">
					<a class="twitter-share-button"
						href="http://192.168.10.79:8080/soeasy/PostNeedLoginController/getPost/${getOnePostBean.postId}">
						Tweet</a>
				</div>
				<!-- 				Twitter Share -->
				<!-- 				Skype Share -->
				<script>
				// Place this code in the head section of your HTML file 
				(function(r, d, s) {
					r.loadSkypeWebSdkAsync = r.loadSkypeWebSdkAsync || function(p) {
					var js, sjs = d.getElementsByTagName(s)[0];
					if (d.getElementById(p.id)) { return; }
					js = d.createElement(s);
					js.id = p.id;
					js.src = p.scriptToLoad;
					js.onload = p.callback
					sjs.parentNode.insertBefore(js, sjs);
				};
				var p = {
					scriptToLoad: 'https://swx.cdn.skype.com/shared/v/latest/skypewebsdk.js',
					id: 'skype_web_sdk'
				};
				r.loadSkypeWebSdkAsync(p);
			})(window, document, 'script');
			</script>

				<!-- Add class skype-share and data-style attribute with value (large, small, circle, square) to get the default button style -->
				<!-- Additional attributes: data-lang='en-US' (for language) data-href='' (use '' for page URL, 'www.skype.com' for specific URL) -->
				<!-- data-text = 'some message' (to pre-fill the message to that will be shared by the user, use '' to prompt user to enter a message) -->
				<!-- Place the code of the share button where you what the share button to appear -->
				<div style="margin-top: 0.5%; margin-left: 1%;">
					<div role='link' aria-labelledby='shareButtonLabel' tabindex='0'
						onKeydown='skypeShareKeyDownHandler(event)' class='skype-share'
						data-href='http://192.168.10.79:8080/soeasy/PostNeedLoginController/getPost/${getOnePostBean.postId}'
						data-lang='' data-text='' data-style='small'></div>
				</div>
				<!-- 				Skype Share -->
			</div>
			<br>
			<!-- 			文章likes -->

			<!-- --------------------------------------------文章顯示區------------------------------------------------------- -->

			<!-- --------------------------------------------留言區------------------------------------------------------- -->

			<div
				style="border-top: 4px #325b43 dotted; padding-top: 1%; height: 150px">

				<form:form method="POST" modelAttribute="replyBean"
					enctype='multipart/form-data'>
					<label for="">回應：</label>
					<form:textarea path='replyContent' placeholder="寫下你的回應..."
						style="overflow-y: scroll; width:90%; height:115px; padding: 1%; margin-top: 0.5%;" />
					<input type='submit'>
				</form:form>
			</div>

			<!-- --------------------------------------------留言區------------------------------------------------------- -->

			<!-- ------------------------------------------熱門留言------------------------------------------------------- -->
			<h4 style="border-top: 3px #325b43 solid; padding-top: 1%;">熱門回應</h4>
			<div id="insertTop3Replies" style="background-color: #F0FFF0;">

			</div>
			<!-- ------------------------------------------熱門留言----------------------------------------ㄦ------------- -->

			<!-- ------------------------------------------留言顯示區----------------------------------------------------- -->
			<div id="insertReplies"></div>
			<!-- ------------------------------------------留言顯示區----------------------------------------------------- -->
		</div>




		<!-- 	---------------------用來接delete的post--------------------------	 -->

		<form method='POST'>
			<input type='hidden' name='_method' value='DELETE'>
		</form>

		<!-- ----------------------------刪除單筆文章用-------------------------------- -->
		<script>
		//將 get 請求轉換為 post 請求提交
		$(document).ready(function() {
			$('.deletePost').click(function() {
				if (confirm('確定刪除此文章嗎? ')) {
					var href = $(this).attr('href');
					$('form').attr('action', href).submit();

					console.log(href);
				}
				return false;

			});
		})
	</script>
		<!-- ----------------------------刪除單筆文章用-------------------------------- -->

		<div class="mainWrapper">
			<section id="offer">
				<div>
					<div></div>
				</div>
			</section>
		</div>

		<!-- 引入共同的頁尾  copy這行-->
		<jsp:include page="/fragment/footer.jsp" />

		<!-- 			互動視窗--留言資料 -->
		<div class="modal fade" id="replyInfoModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true"
			style="background-color: transparent; margin-left: -5%; margin-top: -10%;">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">ID:</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form id="replyInfo_form" action="#" method="post">
							<div class="form-group">
								<label for="recipient-content" class="col-form-label">Content:</label>
								<textarea class="form-control" id="recipient-content"></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" style="color: black;"
							class="btn btn-secondary" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-success" data-dismiss="modal"
							id="sendReplyInfo"
							style="background-color: #007500; border-color: #007500">Send</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 			---------------------------------------------------------------------------------------------------------------- -->

		<!-- 			---------------------------------------------------------------------------------------------------------------- -->
		<!-- 			互動視窗--刪除留言 -->
		<div class="modal fade" id="replyDeleteModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true"
			style="background-color: transparent; margin-left: -5%; margin-top: -10%;">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">刪除留言</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>刪除留言的話留言將永遠消失，確認是否要刪除此篇留言嗎?</p>
						<form id="replyDelete_form" action="#" method="post">
							<div class="form-group"
								style="display: flex; justify-content: flex-start;">
								<label for="recipient-status1" class="col-form-label">保留:</label>
								<input type="radio" class="form-control form-check-input"
									id="recipient-status1" name="radio-status"
									style="margin: 10px 5px 0px 5px" value="1"> <label
									for="recipient-status2" class="col-form-label">刪除:</label> <input
									type="radio" class="form-control form-check-input"
									id="recipient-status2" name="radio-status"
									style="margin: 10px 5px 0px 5px" value="2">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							style="color: black;" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-success" data-dismiss="modal"
							id="sendReplyDelete"
							style="background-color: #007500; border-color: #007500">Save
							change</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>