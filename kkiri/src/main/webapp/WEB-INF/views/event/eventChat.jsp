<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/chatting.css">

	<button type="button" class="chatting-btn">
		<img src="${contextPath}/resources/img/chat-icon.png" alt="채팅 아이콘">
	</button>
	<div class="chatting-wrap">
		<p class="chatting-title">
			채팅 방
			<button type="button" class="close-btn">
				<img src="${contextPath}/resources/img/close-btn.png" alt="채팅창 닫기">
			</button>
		</p>

		<div id="messageArea" class="chatting-content">
		</div>

		<form action="#" method="get" class="chatting-form"
			onsubmit="return false;">
			<textarea id="message" class="chatting-text-input" placeholder="내용을 입력해주세요."></textarea>
			<button id="sendBtn" class="chatting-submit">
				<span class="text-hidden">전송하기</span>
			</button>
		</form>
	</div>
	
	<script>
		var eventNo = ${event.eventNo}; // 임시
		var sock = new SockJS("<c:url value="/echo"/>");
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		
		var noticeDate = null;
		moment.lang('ko',{
			weekdays: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"]
		});
	
		// 채팅창 스크립트
		$(function() {
			$(".chatting-btn").on({
				click : function() {
					<c:if test="${loginMember == null}">
						alert("참석한 이벤트만 참여가 가능합니다.");
						return false;
					</c:if>
					
					<c:if test="${fn:length(myEventList) == 0}">
						alert("참석한 이벤트만 참여가 가능합니다.");
						return false;
					</c:if>
					
					<c:set var="doneLoop" value="false"/>
					<c:forEach var="eventList" items="${myEventList}" varStatus="vs">
						<c:if test="${eventList.eventNo == event.eventNo}">
							<c:if test="${eventList.permission == 'Y'}">
								<c:set var="doneLoop" value="true"/>
								selectChat();
								$(".chatting-wrap").stop().fadeIn(300);
							</c:if>
						</c:if>
						<c:if test="${not doneLoop}">
							<c:if test="${fn:length(myEventList) == vs.count}">
								alert("참석한 이벤트만 참여가 가능합니다.");
							</c:if>
						</c:if>
					</c:forEach>
					
					setTimeout(function(){
						$("#messageArea").scrollTop($("#messageArea")[0].scrollHeight);	
					},100);
				}
			});
			
			$(".close-btn>img").on({
				click : function() {
					$(".chatting-wrap").stop().fadeOut(300);
					$("#messageArea").empty();
				}
			});
			
			$("#message").on({
				keydown : function(e){
					var keyCode = e.keyCode;
					if(keyCode == 13 && !e.shiftKey){
						e.preventDefault();
						$("#sendBtn").click();
						$('#message').val('');
					}
				}
			});
		});
		
		// 채팅 보내기
		$("#sendBtn").click(function() {
			if($("#message").val().trim()==""){
				alert("내용을 입력해주세요");
			}else{
				sendMessage();
				$('#message').val('');
			}
		});
		
		// 메시지 전송
		function sendMessage() {
			var date = new Date();
			var now = moment(date).format('YYYYMMDDHHmmssdddd');
			var content = $("#message").val();
			//content = content.replace("\n","<br>");
			var chatContent = "${loginMember.memberProfile}|%$" + "${loginMember.memberNickname}|%$" + content + "|%$" + now ;
			
			$.ajax({
				url : "insertChat",
				type : "POST",
				data : {"eventNo" : eventNo,
						"chatContent" : chatContent},
				success : function(result){
					sock.send(chatContent+"|%$"+result);
				}, error : function(){
	    			alert("메세지 전송 ajax 실패");
	    		}
			});
		}
		
		// 서버로부터 메시지를 받았을 때
		function onMessage(msg) {
			var data = msg.data;
			var userId = null;
			var content = "";
			var dateTemp = null;
			var thumb = null;
			var comment = null;
			var date = null;
			var chatNo = null;
			
			var str = data.split('|%$');
			
			if(str[0] === 'delete'){
				$("#chat"+str[1]).html('삭제된 메세지 입니다.');
			} else{
				thumb = str[0];
				userId = str[1];
				comment = str[2];
				dateTemp = str[3];
				chatNo = str[4];
				
				if(noticeDate != dateTemp.substring(0,8)){
					noticeDate = dateTemp.substring(0,8);
					content += "<div class='date-info'>" + moment(new Date(dateTemp.substring(0,4), dateTemp.substring(4,6)-1, dateTemp.substring(6,8))).format('YYYY년 M월 DD일 dddd') + "</div>"
				}
				
				date = dateTemp.substring(8,10) + " : " + dateTemp.substring(10,12);

				if(userId === '${loginMember.memberNickname}'){
					content += 	"<div class='my-area'>" +
									"<p class='con' id='chat"+ chatNo +"'>" +
										/* "<button class='delete-btn' onclick=deleteChat("+chatNo+")><span class='text-hidden'>글삭제</span></button>" + */ 
									"</p>" +
									"<p class='con-time'>" + date + "</p>" +
								"</div>";
				} else{
					content += 	"<div id='chat"+ chatNo +"' class='other-member'>" +
									"<img class='profile-img' src='${contextPath}/resources/upProfileImage/" + thumb +"' alt='타회원 프로필'>" +
									"<p class='nickname'>" + userId + "</p>" +
									"<div class='con-wrap'>" +
										"<p class='con' id='chat"+ chatNo +"'>" +
										"</p>" +
										"<p class='con-time'>" + date + "</p>" +
									"</div>" +
								"</div>";
				}
				$("#messageArea").append(content);
				$("#chat"+chatNo).text(comment);
				$("#chat"+chatNo).append("<button class='delete-btn' onclick=deleteChat("+chatNo+")><span class='text-hidden'>글삭제</span></button>");
				$("#messageArea").scrollTop($("#messageArea")[0].scrollHeight);
			}
		}
		
		// 서버와 연결을 끊었을 때
		function onClose(evt) {
			$("#messageArea").append("연결 끊김");

		}
		
		function selectChat(){
			var content = "";
			
			$.ajax({
				url : "selectChat",
				type : "POST",
				data : {"eventNo" : eventNo},
				dataType : "json",
				success : function(chatList){
					
					for(var i in chatList){
						content = ""; // 임시
						
						var str = chatList[i].chatContent.split('|%$');
						
						var thumb = str[0];
						var userId = str[1];
						var comment = str[2];
						var dateTemp = str[3];
						var date = dateTemp.substring(8,10) + " : " + dateTemp.substring(10,12);
						
						if(noticeDate != dateTemp.substring(0,8)){
							noticeDate = dateTemp.substring(0,8);
							content += "<div class='date-info'>" + moment(new Date(dateTemp.substring(0,4), dateTemp.substring(4,6)-1, dateTemp.substring(6,8))).format('YYYY년 M월 DD일 dddd') + "</div>"
						}
						
						
						if(userId === '${loginMember.memberNickname}'){
							content += 	"<div class='my-area'>" +
											"<p class='con' id='chat"+ chatList[i].chatNo +"'>" +
											/* "<button class='delete-btn' onclick=deleteChat("+chatList[i].chatNo+")><span class='text-hidden'>글삭제</span></button>" + */ 
											"</p>" +
											"<p class='con-time'>" + date + "</p>" +
										"</div>";
						} else{
							content += 	"<div class='other-member'>" +
											"<img class='profile-img' src='${contextPath}/resources/upProfileImage/" + thumb +"' alt='타회원 프로필'>" +
											"<p class='nickname'>" + userId + "</p>" +
											"<div class='con-wrap'>" +
												"<p class='con' id='chat"+ chatList[i].chatNo +"'>" +
												"</p>" +
												"<p class='con-time'>" + date + "</p>" +
											"</div>" +
										"</div>";
						}
						$("#messageArea").append(content);
						$("#chat"+chatList[i].chatNo).text(comment);
						$("#chat"+chatList[i].chatNo).append("<button class='delete-btn' onclick=deleteChat("+chatList[i].chatNo+")><span class='text-hidden'>글삭제</span></button>");
					}
				}, error : function(){
	    			alert("메세지 리스트 호출 ajax 실패");
	    		}
			});
		}
		
		function deleteChat(no){
			$.ajax({
				url : "deleteChat",
				type : "POST",
				data : {"chatNo" : no},
				success : function(result){
					sock.send("delete|%$"+no);
				}, error : function(){
	    			alert("메세지 삭제 ajax 실패");
	    		}
			});
		}
	</script>
</body>
</html>