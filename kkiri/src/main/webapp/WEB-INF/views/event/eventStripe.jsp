<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<nav class="navbar navbar-expand-sm navbar-light" id="stripe">
		<div class="container" id="event-navi">
			<ul class="navbar-nav nav-ul ml-2">
				<li class="nav-item"><a class="nav-link active" id="detail" href="detail?no=${event.eventNo}">정보</a>
				</li>
				<li class="nav-item"><a class="nav-link" id="selectParticipant" href="selectParticipant?no=${event.eventNo}">참가회원</a></li>
			</ul>

			<ul class="navbar-nav nav-ul ml-2">
				<c:choose>
					<c:when test="${(event.eventQuota - event.partyCount-1) <= 0}">
						<li class="nav-item mt-2 text-muted"><b class="text-danger"> 모집 완료 </b></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item mt-2 text-muted"><b> ${event.eventQuota - event.partyCount-1}자리 남음 </b></li>
					</c:otherwise>
				</c:choose>
				<li class=""><a class="nav-link" href="selectParty"
					id="event-participate"> 이벤트 참가 </a></li>
				<li class="nav-item dropdown" id="report-button"><a
					class="nav-link dropdown-toggle" href="#" id="navbardrop"
					data-toggle="dropdown"> ··· </a>
					<div class="declare-wrap">
						<a class="declare-btn" href="#">이벤트 신고하기</a>
					</div></li>
			</ul>
		</div>
	</nav>
	
	<script>
		var pathname = window.location.pathname;
		var shortPathname = pathname.substring(13, pathname.length);
		switch(shortPathname){
			case "detail" :
				$("#event-navi li a").removeClass("active");
				$("#detail").addClass("active");
				break;
			
			case "selectParticipant" :
				$("#event-navi li a").removeClass("active");
				$("#selectParticipant").addClass("active");
				break;
		}
		
		console.log(shortPathname);
		
		
		
		
	</script>
	
<!-- 	<script>
		$(function(){
			$("#event-navi li a").removeClass("active");
			$("선택자").addClass("active");
		});
	</script> -->

</body>
</html>