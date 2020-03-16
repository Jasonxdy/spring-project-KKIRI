<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- 이벤트 상세 페이지 CSS 적용 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/eventDetail.css">
<title>KKIRI(끼리)</title>

</head>
<body>
	<div id="wrapper">

		<!-- Header -->
		<jsp:include page="../common/header.jsp" />

		<!-- 이벤트 상세 페이지 start -->
		<div id="container" class="container mt-5">

			<!-- 이벤트 상세 상단 정보 start -->
			<div class="row event-detail-info">
				<div class="col-md-7" id="eventDetailDiv">
				
					<!-- date format 변경 -->
					<fmt:formatDate var="startDate" value="${event.eventStart}" pattern="yyyy년 MM월 dd일 E요일 · HH:mm"/>
					<fmt:formatDate var="endDate" value="${event.eventEnd}" pattern="yyyy년 MM월 dd일 E요일 · HH:mm"/>
					
					<!-- 이벤트 시작시간, 끝나는 시간 -->
					<p class="text-muted" id="eventDate" style="margin-bottom: 0em;">
						${startDate}
					</p>
					<h2 id="eventTitle">
						${event.eventTitle}
					</h2>
					<!-- 위도, 경도로 얻은 주소 -->
					<p id="eventLocation" style="margin-bottom: 0em;">
						<img src="${contextPath}/resources/img/map-ping.png"
							style="height: 18px;"> ${event.eventLocation}
					</p>
					<p class="text-muted">서울시 동대문구 휘경동 204-90</p>
					<p id="eventTicket">
						<img src="${contextPath}/resources/img/dollor-icon.png"> <b>${event.eventTicket}</b>
						티켓
					</p>
				</div>
				<div class="col-md-5" id="eventCreater">
					<h3>이벤트 주최자</h3>
					<div class="event-creator-info mt-3">
						<img src="${contextPath}/resources/img/${event.memberProfile}" alt="주최자"
							class="eventCreater-profile mr-3">
						<div class="id-rating">
							<h5>${event.memberNickname}</h5>
							<p class="star-rating">
								<img src="${contextPath}/resources/img/star-on.png" alt="별점"
									class="star-img">&nbsp; ${event.memberRating}
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 이벤트 상세 상단 정보 end -->
	
	<!-- 참석자 명수 변수 선언 -->
	<c:set var="partyCount" value="${fn:length(partyList)}"/>


	<!-- 이벤트 sticky element start // sticky element 사용-->
	<jsp:include page="eventStripe.jsp">
		<jsp:param value="${partyCount}" name="partyCount"/>
	</jsp:include>
	<!-- 이벤트 sticky element end -->

	<div class="container">
		<div class="row mt-5 event-detail-container">
			<div class="col-md-7 event-detail">
				<!-- 최대 크기 적용, 사진 가운데 정렬 필요 -->
				<img src="${contextPath}/resources/img/${event.eventThumbnail}"
					class="event-thumbnail">
				<p class="mt-3" id="eventContent">
					${event.eventContent}
				</p>
			</div>
			<div class="col-md-5">
				<div class="time-and-place">
					<h4>시간과 장소</h4>
					<!-- 이벤트 시작시간, 끝나는 시간 -->
					<p class="text-muted" style="margin-bottom: 0em;">
						<c:choose>
						<c:when test="${fn:substring(startDate,0,12) == fn:substring(endDate,0,12)}">
							${startDate} ~ ${fn:substring(endDate,20,25)}
						</c:when>
						<c:otherwise>
							${startDate} ~ ${endDate}
						</c:otherwise>
					</c:choose>
					</p>
					<!-- 위도, 경도로 얻은 주소 -->
					<p class="mt-3" style="margin-bottom: 0em;">
						<img src="${contextPath}/resources/img/map-ping.png"
							style="height: 18px;" alt="위치아이콘"> 
							
							${event.eventLocation}

					</p>
					<p class="text-muted" id="eventPing">
						서울시 동대문구 휘경동 204-90
					</p>

					<!-- 지도 부분 start -->
					<div style="height: 250px; background-color: gray;"></div>
					<!-- 지도 부분 end -->
				</div>

				<div class="event-participant mt-5">
					
					
					<h4>
						참석자 (<span>${partyCount}</span>명) <span id="see-all"> <a href="#">
								모두 보기 </a>
						</span>
					</h4>
				</div>
				<div class="event-participant-profile-wrap" id="event-party-list">
<%-- 					<span class="event-participant-profile"> <img
						src="${contextPath}/resources/img/profile-ex.png" alt="주최자">
					</span> --%>
				</div>


			</div>
		</div>
		<!-- 이벤트 상세 페이지 end -->

	</div>

	<jsp:include page="../common/footer.jsp" />


	<script>
		$(function() {
			// 신고 토글 버튼
			$("#navbardrop").click(function(e) {
				e.preventDefault();
				$(this).next(".declare-wrap").toggleClass("active");
			});
			
			
			// console 값 테스트 용
			console.log("${partyList}");
			console.log("${fn:length(partyList)}")
			
			// 참석자 목록 출력
			var $partyList = $("#event-party-list");
			
			
			
		});
	</script>

</body>
</html>