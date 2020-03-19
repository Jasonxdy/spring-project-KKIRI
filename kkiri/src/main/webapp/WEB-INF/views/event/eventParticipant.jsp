<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
<!-- 이벤트 상세 페이지 CSS 적용 -->
<link rel="stylesheet"
	href="${contextPath}/resources/css/eventParticipant.css">
<title>KKIRI(끼리)</title>
</head>

<body>
	<div id="wrapper">

		<!-- Header -->
		<jsp:include page="../common/header.jsp" />

		<!-- date format 변경 -->
		<fmt:formatDate var="startDate" value="${event.eventStart}"
			pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />
		<fmt:formatDate var="endDate" value="${event.eventEnd}"
			pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />

		<!-- 이벤트 상세 상단 정보 start -->
		<jsp:include page="eventHeader.jsp">
			<jsp:param value="${startDate}" name="startDate" />
			<jsp:param value="${endDate}" name="endDate" />
		</jsp:include>
		<!-- 이벤트 상세 상단 정보 end -->

	</div>



	<!-- 이벤트 sticky element start // sticky element 사용-->
	<jsp:include page="eventStripe.jsp" />
	<!-- 이벤트 sticky element end -->

	<div class="container">
		<div class="row mt-5 event-detail-container">
			<!-- 하단 좌측 div start -->
			<div class="col-md-7 event-detail" id="attendList">
				<h3 class="mb-5">
					현재 <span class="participant-count">${event.partyCount}</span>명의 회원이
					참가 중입니다.
				</h3>

				<fmt:formatDate var="memberSignupDate"
					value="${event.memberSignupDate}" pattern="yyyy년 MM월 dd일" />

				<div class="media border p-3 profile-card">
					<img src="${contextPath}/resources/img/${event.memberProfile}"
						alt="주최자" class="rounded-circle mt-1" style="width: 60px;">
					<div class="media-body ml-3 mt-1">
						<h4>${event.memberNickname}</h4>
						<p class="text-muted">${memberSignupDate}가입</p>
					</div>
				</div>
				<c:forEach var="party" items="${partyList}">
					<fmt:formatDate var="memberSignupDate"
						value="${party.memberSignupDate}" pattern="yyyy년 MM월 dd일" />
					<div class="media border p-3 profile-card">
						<img src="${contextPath}/resources/img/${party.memberProfile}"
							alt="참가자" class="rounded-circle mt-1" style="width: 60px;">
						<div class="media-body ml-3 mt-1">
							<h4>${party.memberNickname}</h4>
							<p class="text-muted">${memberSignupDate}가입</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 하단 좌측 div end -->
			<div class="col-md-5 ">
				<div class="time-and-place">
					<h4>시간과 장소</h4>
					<!-- 이벤트 시작시간, 끝나는 시간 -->
					<p class="text-muted" style="margin-bottom: 0em;">
						<c:choose>
							<c:when
								test="${fn:substring(startDate,0,12) == fn:substring(endDate,0,12)}">
							${startDate} ~ ${fn:substring(endDate,20,25)}
						</c:when>
							<c:otherwise>
							${startDate} ~ ${endDate}
						</c:otherwise>
						</c:choose>
					</p>
					<!-- 위도, 경도로 얻은 주소 -->
					<p class="mt-3" style="margin-bottom: 0em;">
						<img src="${contextPath}/resources/img/map-ping.png" alt="지도 핑"
							style="height: 18px;" alt="위치아이콘"> ${event.eventLocation}
					</p>
					<p class="text-muted" id="eventPing">서울시 동대문구 휘경동 204-90</p>

					<!-- 지도 부분 start -->
					<div id="eventMap" style="height: 250px;"></div>
					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=113a0beb55aa56aa1fd5776ff4bb068c&libraries=services,clusterer,drawing"></script>
					<script>
						var container = document.getElementById('eventMap');
						var options = {
							center : new kakao.maps.LatLng(${event.latitude}, ${event.longtitude}),
							level : 3
						};

						var map = new kakao.maps.Map(container, options);
						
						// 마커가 표시될 위치입니다 
						var markerPosition  = new kakao.maps.LatLng(${event.latitude}, ${event.longtitude}); 

						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});

						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);
						
						
						
						// 주소-좌표 변환 객체를 생성합니다
						var geocoder = new kakao.maps.services.Geocoder();
						 
						var callback = function(result, status) {
							    if (status === kakao.maps.services.Status.OK) {
							    	var detailAddress = result[0].address.address_name;
							    	// id가 eventPing인 곳에 지번 주소 표기
							    	document.getElementById("eventPing").innerHTML = detailAddress;
							    	// id가 eventAddress인 곳에 지번 주소 표기
							    	document.getElementById("eventAddress").innerHTML = detailAddress;
							    }
						};
						
						// 지번 주소 호출
						geocoder.coord2Address(${event.longtitude}, ${event.latitude}, callback);
						 
						
						/* 지도 도구 start */
						// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
						var mapTypeControl = new kakao.maps.MapTypeControl();

						// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
						// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
						map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

						// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
						var zoomControl = new kakao.maps.ZoomControl();
						map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
						/* 지도 도구 end */
						
						
						
					</script>
					<!-- 지도 부분 end -->
				</div>


			</div>

		</div>
	</div>


	<jsp:include page="../common/footer.jsp" />

	<div id="button-top">
		<button type="button" class="top-btn">TOP</button>
	</div>

	<script>
	$(function() {
		// 신고 토글 버튼
		$("#navbardrop").click(function(e) {
			e.preventDefault();
			$(this).next(".declare-wrap").toggleClass("active");
		});
		
		
		/* 무한 스크롤 */
		//Javascript
		var count = 0; // 스크롤 갱신 횟수
		var limit = 3; // 3명씩 보여줌
		var eventNo = '${event.eventNo}';
		//스크롤 바닥 감지
		window.onscroll = function(e) {
		    //추가되는 임시 콘텐츠
		    //window height + window scrollY 값이 document height보다 클 경우,
		    if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
		    	//실행할 로직 (콘텐츠 추가)
		    	
		    	// count*limit + 4 <= evetn.partyCount 일때만 ajax 실행 
		    	if(count*limit+4 <= ${event.partyCount}){
			    	$.ajax({
			    		url : "addPartyList";
				    	type : "GET",
						data : {count : count, eventNo : eventNo},
						dataType : "json",
						success : function (partyList){
							$.each(partyList, function(i){
								
							}
							count++;
						}
			    	});
		    	}
		    	
		    }
		};
		
	});
	</script>
</body>

</html>