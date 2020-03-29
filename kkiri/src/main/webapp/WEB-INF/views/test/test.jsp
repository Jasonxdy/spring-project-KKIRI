<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>
	<div>
		<jsp:include page="../../../WEB-INF/views/common/header.jsp" />
		<input type="button" onclick="selectChat()" value="채팅 로딩"/>
		<input type="text" id="message" />
		<input type="button" id="sendBtn" value="submit"/>
		<div id="messageArea"></div>
	</div>
</body>
<script>
	$("#sendBtn").click(function() {
		sendMessage();
		$('#message').val('')
	});

	var sock = new SockJS("<c:url value="/echo"/>");
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	
	// 메시지 전송
	function sendMessage() {
		var date = new Date();
		var now = moment(date).format('YYYYMMDDHHmmssdd');
		var chatContent = "${loginMember.memberProfile}," + "${loginMember.memberNickname}," + $("#message").val() + "," + now ;
		var eventNo = 100; // 임시
		
		$.ajax({
			url : "insertChat",
			type : "POST",
			data : {"eventNo" : eventNo,
					"chatContent" : chatContent},
			success : function(result){
				console.log(result);
			}
		});
		
		sock.send("${loginMember.memberProfile}," + "${loginMember.memberNickname}," + $("#message").val() + "," + now );
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
		
		var str = data.split(',');
		
		thumb = str[0];
		userId = str[1];
		comment = str[2];
		dateTemp = str[3];
		
		date = dateTemp.substring(8,10) + " : " + dateTemp.substring(10,12);
		
		content += 	"<div class='media'>" +
						"<img style='width : 64px; height : 64px;' class='mr-3' src='${contextPath}/resources/upProfileImage/" + thumb +"'>" +
						"<div class='media-body'>" +
							"<span class='h2'>" + userId + "&nbsp;</span>" +
							"<span>" + date  + "</span><br>" +
							comment +
						"</div>" +
					"</div>";
							
		//$("#messageArea").append(data + "<br/>");
		$("#messageArea").append(content);
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#messageArea").append("연결 끊김");

	}
	
	function selectChat(){
		var eventNo = 100;
		
		$.ajax({
			url : "selectChat",
			type : "POST",
			data : {"eventNo" : eventNo},
			dataType : "json",
			success : function(chatList){
				console.log(chatList)
			}
		});
	}
</script>
</html>