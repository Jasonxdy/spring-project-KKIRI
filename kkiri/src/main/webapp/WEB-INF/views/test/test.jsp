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
	
	var noticeDate = null;
	moment.lang('ko',{
		weekdays: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"]
	});
	
	// 메시지 전송
	function sendMessage() {
		var date = new Date();
		var now = moment(date).format('YYYYMMDDHHmmssdddd');
		var chatContent = "${loginMember.memberProfile}," + "${loginMember.memberNickname}," + $("#message").val() + "," + now ;
		
		var eventNo = 100; // 임시
		
		$.ajax({
			url : "insertChat",
			type : "POST",
			data : {"eventNo" : eventNo,
					"chatContent" : chatContent},
			success : function(result){
				sock.send(chatContent+","+result);
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
		
		console.log(data);
		var str = data.split(',');
		
		if(str[0] === 'delete'){
			$("#chat"+str[1]).empty();
			content += "<div>삭제된 메세지 입니다.</div>";
			
			$("#chat"+str[1]).append(content);
		} else{
			
			thumb = str[0];
			userId = str[1];
			comment = str[2];
			dateTemp = str[3];
			chatNo = str[4];
			
			if(noticeDate != dateTemp.substring(0,8)){
				noticeDate = dateTemp.substring(0,8);
				content += "<div>------- " + moment(new Date(dateTemp.substring(0,4), dateTemp.substring(4,6)-1, dateTemp.substring(6,8))).format('YYYY년 M월 DD일 dddd') + " -------</div>"
			}
			
			date = dateTemp.substring(8,10) + " : " + dateTemp.substring(10,12);

			console.log(comment);
			if(userId === '${loginMember.memberNickname}'){
				content += 	"<div id='chat"+ chatNo +"' class='media'>" +
								"<img style='width : 64px; height : 64px;' class='mr-3' src='${contextPath}/resources/upProfileImage/" + thumb +"'>" +
								"<div class='media-body'>" +
									"<span class='h2' style='color:red;'>" + userId + "&nbsp;</span>" +
									"<span>" + date  + "</span><br>" +
									comment +
									"<div onclick=deleteChat("+chatNo+")>X</div>" +
								"</div>" +
							"</div>";
			} else{
				content += 	"<div id='chat"+ chatNo +"' class='media'>" +
								"<img style='width : 64px; height : 64px;' class='mr-3' src='${contextPath}/resources/upProfileImage/" + thumb +"'>" +
								"<div class='media-body'>" +
									"<span class='h2'>" + userId + "&nbsp;</span>" +
									"<span>" + date  + "</span><br>" +
									comment +
								"</div>" +
							"</div>";
			}
								
			$("#messageArea").append(content);
		}
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#messageArea").append("연결 끊김");

	}
	
	function selectChat(){
		var eventNo = 100;
		var content = "";
		
		$.ajax({
			url : "selectChat",
			type : "POST",
			data : {"eventNo" : eventNo},
			dataType : "json",
			success : function(chatList){
				console.log(chatList);
				
				for(var i in chatList){
					var str = chatList[i].chatContent.split(',');
					
					var thumb = str[0];
					var userId = str[1];
					var comment = str[2];
					var dateTemp = str[3];
					var date = dateTemp.substring(8,10) + " : " + dateTemp.substring(10,12);
					
					if(noticeDate != dateTemp.substring(0,8)){
						noticeDate = dateTemp.substring(0,8);
						content += "<div>------- " + moment(new Date(dateTemp.substring(0,4), dateTemp.substring(4,6)-1, dateTemp.substring(6,8))).format('YYYY년 M월 DD일 dddd') + " -------</div>"
					}
					
					if(userId === '${loginMember.memberNickname}'){
						content += 	"<div id='chat" +chatList[i].chatNo+ "' class='media'>" +
										"<img style='width : 64px; height : 64px;' class='mr-3' src='${contextPath}/resources/upProfileImage/" + thumb +"'>" +
										"<div class='media-body'>" +
											"<span class='h2' style='color:red;'>" + userId + "&nbsp;</span>" +
											"<span>" + date  + "</span><br>" +
											comment +
											"<div onclick=deleteChat("+chatList[i].chatNo+")>X</div>" +
										"</div>" +
									"</div>";
					} else{
						content += 	"<div id='chat" +chatList[i].chatNo+ "' class='media'>" +
										"<img style='width : 64px; height : 64px;' class='mr-3' src='${contextPath}/resources/upProfileImage/" + thumb +"'>" +
										"<div class='media-body'>" +
											"<span class='h2'>" + userId + "&nbsp;</span>" +
											"<span>" + date  + "</span><br>" +
											comment +
										"</div>" +
									"</div>";
					}
				}
					
				$("#messageArea").append(content);
			}
		});
	}
	
	function deleteChat(no){
		$.ajax({
			url : "deleteChat",
			type : "POST",
			data : {"chatNo" : no},
			success : function(result){
				sock.send("delete,"+no);
			}
		});
	}
</script>
</html>