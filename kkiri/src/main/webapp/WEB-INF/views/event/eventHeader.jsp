<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="container" class="container mt-5">
			<!-- 이벤트 상세 상단 정보 start -->
			<div class="row event-detail-info">
				<div class="col-md-7" id="eventDetailDiv">

					<!-- date format 변경 -->
					<fmt:formatDate var="startDate" value="${event.eventStart}"
						pattern="yyyy년 MM월 dd일 E요일 · HH:mm"/>
					<fmt:formatDate var="endDate" value="${event.eventEnd}"
						pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />
						
					<!-- 이벤트 시작시간, 끝나는 시간 -->
					<p class="text-muted" id="eventDate" style="margin-bottom: 0em;">
						${startDate}</p>
					<h2 id="eventTitle">${event.eventTitle}</h2>
					<!-- 위도, 경도로 얻은 주소 -->
					<p id="eventLocation" style="margin-bottom: 0em;">
						<img src="${contextPath}/resources/img/map-ping.png"
							style="height: 18px;"> ${event.eventLocation}
					</p>
					<p class="text-muted" id="eventAddress"></p>
					<p id="eventTicket">
						<img src="${contextPath}/resources/img/dollor-icon.png"> <b>${event.eventTicket}</b>
						티켓
					</p>
				</div>
				<div class="col-md-5" id="eventCreater">
					<h3>이벤트 주최자</h3>
					<div class="event-creator-info mt-3">
						<img src="${contextPath}/resources/upProfileImage/${event.memberProfile}"
							alt="주최자" class="eventCreater-profile mr-3">
						<div class="id-rating">
							<h5>${event.memberNickname}</h5>
							<p class="star-rating align-self-center">
							<c:choose>
								<c:when test="${event.memberRating != 0}">
									<img src="${contextPath}/resources/img/star-on.png" alt="별점"
										class="star-img">&nbsp; <b><fmt:formatNumber value="${event.memberRating}" pattern=".0"/></b>	
								</c:when>
								<c:otherwise>
									<p class="text-muted">
									<img src="${contextPath}/resources/img/star-on.png" alt="별점"
										class="star-img"> 아직 작성된 평가가 없습니다.
									</p>
								</c:otherwise>
							</c:choose>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script>
			$(".eventCreater-profile").on({
					click : function(){
						location.href = "${contextPath}/profile/user?no=" + ${event.memberNo};
					}
			});
		
		</script>
</body>
</html>