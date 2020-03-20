<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="${contextPath}/resources/css/eventAfterComment.css">
<link rel="stylesheet"
	href="${contextPath}/resources/css/eventJoinModal.css">
</head>
<body>



	<!-- date format 변경 -->
	<fmt:formatDate var="startDate" value="${event.eventStart}"
		pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />
	<fmt:formatDate var="endDate" value="${event.eventEnd}"
		pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />

	<!-- 현재시간 구하기 -->
	<jsp:useBean id="currTime" class="java.util.Date" />



	<nav class="navbar navbar-expand-sm navbar-light" id="stripe">
		<div class="container" id="event-navi">
			<ul class="navbar-nav nav-ul ml-2">
				<c:choose>
					<c:when test="${currTime < event.eventEnd}">
						<li class="nav-item"><a class="nav-link active" id="detail"
							href="detail?no=${event.eventNo}">정보</a></li>
						<li class="nav-item"><a class="nav-link"
							id="selectParticipant"
							href="selectParticipant?no=${event.eventNo}">참가회원</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link active" id="detail"
							href="detail?no=${event.eventNo}">정보</a></li>
						<li class="nav-item"><a class="nav-link"
							id="selectParticipant"
							href="selectParticipant?no=${event.eventNo}">참가회원</a></li>
						<li class="nav-item"><a class="nav-link" href="#">사진</a></li>
						<li class="nav-item"><a class="nav-link active" href="#">후기</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>

			<ul class="navbar-nav nav-ul ml-2">
				<!-- 이벤트 종료 전 -->
				<c:if test="${currTime < event.eventEnd}">
					<c:choose>
					<c:when test="${(event.eventQuota - event.partyCount-1) <= 0}">
						<li class="nav-item mt-2 text-muted"><b class="text-danger">
								모집 완료 </b></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item mt-2 text-muted"><b>
								${event.eventQuota - event.partyCount-1}자리 남음 </b></li>
					</c:otherwise>
					</c:choose>
				<li class=""><a class="nav-link event-participate-btn"
					id="event-participate"> 이벤트 참가 </a> <a
					class="nav-link event-participate-btn"
					id="cancel-event-participate"> 이벤트 참가취소 </a></li>
				</c:if>
				
				<!-- 이벤트 종료 후 -->
				<c:if test="${currTime >= event.eventEnd}">
				<li class=""><a class="nav-link aleady-finish-event"
					id="end-event"> 종료된 이벤트 </a></li>
				</c:if>
				
				<li class="nav-item dropdown" id="report-button"><a
					class="nav-link dropdown-toggle" href="" id="navbardrop"
					data-toggle="dropdown"> ··· </a>
					<div class="declare-wrap">
						<a class="declare-btn" href="#">이벤트 신고하기</a>
					</div></li>
			</ul>
		</div>
	</nav>

	<div class="popup declare-event-popup">
		<p class="popup-title">
			이벤트 신고 <img src="${contextPath}/resources/img/close-btn.png"
				alt="닫기버튼" class="close-popup">
		</p>
		<div class="popup-content">
			<form action="#" method="post" onsubmit="return declareCondition();">
				<label for="declare-reason">신고사유를 선택해주세요.</label> <select
					name="reportCategory" id="declare-reason">
					<option value="none">신고 사유 선택</option>
					<option value="A">선정적이거나 불법적인 내용의 이벤트</option>
					<option value="B">카테고리에 적합하지 않은 주제</option>
					<option value="C">욕설, 광고, 저작권 위배</option>
					<option value="D">참가에 필요한 정보 부족</option>
					<option value="E">불참, 괴롭힘, 폭력</option>
					<option value="F">기타</option>
				</select> <label for="declare-content" class="declare-content-label">추가적인
					신고사유를 입력해주세요.</label>
				<textarea name="reportContent" id="declare-content"></textarea>
				<button class="green-radius-btn">신고하기</button>
			</form>
		</div>
	</div>


	<div class="popup join-event-popup">
		<p class="popup-title">
			이벤트 참가 신청 <img src="${contextPath}/resources/img/close-btn.png"
				alt="닫기버튼" class="close-popup">
		</p>
		<div class="popup-content">
			<p class="event-title">${event.eventTitle }</p>

			<p class="event-date">
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
			<p class="join-money">
				참가비용 : <img src="${contextPath}/resources/img/dollor-icon.png"
					alt="참가비용"> <span>${event.eventTicket} 티켓</span>
			</p>
			<p class="popup-comment">이벤트에 참가하시겠습니까?</p>
			<button type="button" class="join-event-btn green-radius-btn" onclick="joinEvent();">이벤트
				참가</button>
		</div>
	</div>

	<div class="popup-shadow"></div>

	<script>
		var pathname = window.location.pathname;
		var shortPathname = pathname.substring(13, pathname.length);
		switch (shortPathname) {
		case "detail":
			$("#event-navi li a").removeClass("active");
			$("#detail").addClass("active");
			break;

		case "selectParticipant":
			$("#event-navi li a").removeClass("active");
			$("#selectParticipant").addClass("active");
			break;
		}


		$(function() {
			// 신고 토글 버튼
			$("#navbardrop").click(function(e) {
				e.preventDefault();
				$(this).next(".declare-wrap").toggleClass("active");
			});

		});
	</script>

	<script>
		// 이벤트 참가 버튼 클릭시 팝업
		$("#event-participate").on({
			click : function(e) {
				if(${ empty sessionScope.loginMember  }) {
					$(".popup-shadow, #login-popup").show(0);
				} else {
					console.log("로그인 후 실행됨..");
					if(${(event.eventQuota - event.partyCount-1) <= 0}){
						alert("해당 이벤트는 모집 완료되었습니다");
						return false;
					} else {
						e.preventDefault();
						$(".join-event-popup, .popup-shadow").show(0);
					}
				}
				
			}
		});

		$(".join-event-btn").on({
			click : function() {
				$(".join-event-popup, .popup-shadow").hide(0);
				$("#event-participate").hide(0);
				$("#cancel-event-participate").css({
					"display" : "block"
				});
			}
		});

		$("#cancel-event-participate").on({
			click : function() {
				if (confirm("정말로 이벤트 참가를 취소하시겠습니까?")) {
					alert("이벤트 참가 취소 백단 실행");
					$("#cancel-event-participate").hide(0);
					$("#event-participate").show(0);
				}
			}
		});

		$(".already-join").on({
			click : function() {
				alert();
			}
		});
		// 신고하기 버튼 클릭시 팝업
		$(".declare-btn").on({
			click : function(e) {
				if(${ empty sessionScope.loginMember  }) {
					$(".popup-shadow, #login-popup").show(0);
				} else {
					e.preventDefault();
					$(".declare-event-popup, .popup-shadow").show(0);
				}
			}
		});

		$(".close-popup, .popup-shadow").on({
			click : function() {
				$(".popup-shadow, .popup").hide(0);
			}
		});

		function declareCondition() {
			if ($("#declare-reason").val() == "none") {
				alert("신고 사유를 선택해주세요");
				$("#declare-reason").focus();
				return false;
			}
		}
		
		
		// 이벤트 참가 확인 버튼 클릭 시
		function joinEvent(){
			if(${loginMember.memberTicket < event.eventTicket}){
				if(confirm("보유 티켓이 부족합니다. 충전 페이지로 이동하시겠습니까?")){
					
				}
			}
			
		}
		
		$(".event-participate-btn").mouseenter(function(){
			$(this).parent().css("cursor", "pointer");
		});
		
	</script>

	<!-- 	<script>
		$(function(){
			$("#event-navi li a").removeClass("active");
			$("선택자").addClass("active");
		});
	</script> -->

</body>
</html>