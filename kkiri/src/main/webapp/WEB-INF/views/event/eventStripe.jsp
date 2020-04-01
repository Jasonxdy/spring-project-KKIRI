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
						<li class="nav-item"><a class="nav-link" id="picture"
							href="picture?no=${event.eventNo}">사진</a></li>
						<li class="nav-item"><a class="nav-link" id="comment"
							href="comment?no=${event.eventNo}">후기</a></li>
					</c:otherwise>
				</c:choose>
			</ul>

			<ul class="navbar-nav nav-ul ml-2">
				<!-- 이벤트 종료 전 -->
				<c:if test="${currTime < event.eventEnd}">
					<c:choose>
						<c:when test="${(event.eventQuota - event.partyCount) <= 0}">
							<li class="nav-item mt-2 text-muted"><b class="text-danger">
									모집 완료 </b></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item mt-2 text-muted"><b id="left-seat">
									${event.eventQuota - event.partyCount}자리 남음 </b></li>
						</c:otherwise>
					</c:choose>

					<li class=""><a class="nav-link event-participate-btn"
						id="event-participate"> 이벤트 참가 </a> <a
						class="nav-link event-participate-btn" id="event-wait-list">
							참가 신청 목록 </a> <a class="nav-link event-participate-btn"
						id="cancel-event-participate"> 이벤트 참가취소 </a> <a
						class="nav-link event-participate-btn" id="wait-event-participate">
							주최자 승인 대기중 </a>
							<a
						class="nav-link event-participate-btn" id="denied-event-participate">
							참가 거절됨 </a>
				</c:if>

				<!-- 이벤트 종료 후 -->
				<c:if test="${currTime >= event.eventEnd}">
					<li class="nav-link event-participate-btn float-right mt-1"
						id="event-complete" style="height: 36px">이벤트 완료 확인</li>
					<!-- 					<li class="nav-link event-participate-btn float-right mt-1" id="event-complete-confirmed" style="height: 36px">이벤트 완료 확인됨</li> -->
					<li class="" id="event-complete-confirmed"><p
							class='already-finish-event float-right'>이벤트 완료 확인됨</p></li>
					<li class=""><p class='already-finish-event float-right'>종료된
							이벤트</p></li>
				</c:if>

				<li class="nav-item dropdown" id="report-button"><a
					class="nav-link dropdown-toggle" href="" id="navbardrop"
					data-toggle="dropdown"> ··· </a>
					<div class="declare-wrap">
						<a class="declare-btn" href="#">이벤트 신고하기</a>
						<c:if test="${(loginMember.memberNo == event.memberNo || loginMember.memberGrade == 'A') && (currTime < event.eventStart) }">
							<a class="updateEvent" href="updateEventGo?no=${event.eventNo}">이벤트 수정</a>
						</c:if>
					</div></li>
			</ul>
		</div>
	</nav>





	<!-- 이벤트 신고 모달 -->
	<div class="popup declare-event-popup">
		<p class="popup-title">
			이벤트 신고 <img src="${contextPath}/resources/img/close-btn.png"
				alt="닫기버튼" class="close-popup">
		</p>
		<div class="popup-content">
			<form
				action="insertReport?eventNo=${event.eventNo}&memberNo=${loginMember.memberNo}"
				method="post" onsubmit="return declareCondition();">
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



	<!-- 이벤트 참가 모달 -->
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
			<button type="button" class="join-event-btn green-radius-btn"
				onclick="joinEvent();">이벤트 참가</button>
		</div>
	</div>

	<div class="popup-shadow"></div>



	<!-- 주최자로 로그인 시 참가 신청 회원 목록 모달 -->
	<div class="popup creator-participant-list" style="top: 50%">
		<p class="popup-title">
			참가 회원 목록 <img src="${contextPath}/resources/img/close-btn.png"
				alt="닫기버튼" class="close-popup">
		</p>
		<div class="popup-content popup-event-partylist">
			<c:if test="${empty eventParty }">
				<h4 class="text-muted">이벤트 참가 목록이 아직 없습니다 :P</h4>
			</c:if>
			<c:if test="${!empty eventParty }">
				<h5 class="mb-4">
					이벤트 참석 인원 : <span id="left-seat-modal" style="color: #007bff">${event.eventQuota - event.partyCount}</span>
					/ ${event.eventQuota}
				</h5>
				<c:forEach var="party" items="${eventParty}">
					<fmt:formatDate var="memberSignupDate"
						value="${party.memberSignupDate}" pattern="yyyy년 MM월 dd일" />
					<div class="media border p-3 profile-card event-party-member-card">
						<span style="display: none">${party.memberNo}</span> <img
							src="${contextPath}/resources/upProfileImage/${party.memberProfile}"
							alt="참가자" class="rounded-circle mt-1"
							style="width: 60px; cursor: pointer;"
							onclick="location.href = '${contextPath}/profile/user?no=${party.memberNo}'">
						<div class="media-body ml-3 mt-1">
							<h4>
								<a href="${contextPath}/profile/user?no=${party.memberNo}">${party.memberNickname}</a>
							</h4>
							<p class="text-muted">${memberSignupDate}가입</p>
						</div>

						<div class="event-status-btnWrap">
							<!--  승인된 경우 -->
							<c:if test="${party.permission == 'Y'}">
								<button type="button" class="permission-finish">참가 승인됨</button>
							</c:if>
							<!-- 거절된 경우 -->
							<c:if test="${party.permission == 'D'}">
								<button type="button" class="reject-finish">참가 거절됨</button>
							</c:if>

							<!-- 승인 대기인 경우 -->
							<c:if test="${party.permission == 'N'}">
								<div class="do-wrap">
									<div style="display: none;">${party.memberNo }</div>
									<button type="button" class="do-permission">승인하기</button>
									<button type="button" class="do-reject">거절하기</button>
								</div>
								<button type="button" class="permission-finish"
									style="display: none;">참가 승인됨</button>
								<button type="button" class="reject-finish"
									style="display: none;">참가 거절됨</button>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</c:if>

		</div>
	</div>

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
			
		case "comment":
			$("#event-navi li a").removeClass("active");
			$("#comment").addClass("active");
			break;
			
		case "picture":
			$("#event-navi li a").removeClass("active");
			$("#picture").addClass("active");
			break;
			
		}

		
		
		// READY 함수
		$(function() {
			
			// 신고 토글 버튼
			$("#navbardrop").click(function(e) {
				e.preventDefault();
				$(this).next(".declare-wrap").toggleClass("active");
			});
			
			// cursor 변경
			$(".event-participate-btn").mouseenter(function(){
				$(this).parent().css("cursor", "pointer");
			});
			
			
			
			var myEventCheck = false; // 로그인한 회원이 해당 이벤트의 주최자 혹은 참여자인지 여부 체크
			var permissionCheck = false; // 승인 대기중인 경우
			var deniedCheck = false; // 거절된 경우
			if(${currTime < event.eventEnd}){ // 이벤트가 종료되지 않았을때만 실행
				if(${loginMember != null}){ // 로그인된 경우
					
					<c:forEach var="party" items="${myEventList}">
						if(${party.eventNo == event.eventNo}){
							if('${party.permission}' == 'Y') { // 참여신청도 했고 승인도 된 경우
								permissionCheck = true;
							} else if('${party.permission}' == 'D'){
								deniedCheck = true;
							}
							myEventCheck = true;
						}
					</c:forEach>
					
					if(myEventCheck) { // 로그인한 회원이 해당 이벤트의 주최자 혹은 참여자인 경우
						if(${loginMember.memberNo == event.memberNo}) { // 로그인한 회원이 주최자인 경우
							// 참가 신청 버튼 --> 참가자 승인 버튼으로 변경
							$("#event-wait-list").css({
								"display" : "block"
							});
						} else { // 로그인된 회원이 참여자인 경우
							
							if(permissionCheck){ // 참여자이면서 승인이 된 경우
								$("#cancel-event-participate").css({
									"display" : "block"
								});
							} else if(deniedCheck) {
								$("#denied-event-participate").css({
									"display" : "block"
								});
							} else{ // 참여자이지만 승인이 안된 경우
								// 승인 대기중 버튼 보이기
								$("#wait-event-participate").css({
									"display" : "block"
								});
							}
						
						}
					} else { // 로그인한 회원이 해당 이벤트에 참여하지 않은 경우 
						$("#event-participate").css({
							"display" : "block"
						});
					}
				} else { // 로그인 안된 경우
					// 이벤트 참가 버튼 보이기
					$("#event-participate").css({
						"display" : "block"
					});
				}
			}
			// 이벤트가 종료되지 않은 경우 end
			else {  // 이벤트가 종료된 경우
				if(${loginMember != null}){ 
					if(${event.memberNo} == '${loginMember.memberNo}') {
						if('${event.eventConfirm}' == 'Y'){
							$("#event-complete-confirmed").css({
								"display" : "block"
							});
						} else {
							$("#event-complete").css({
								"display" : "block"
							});
						}
					}
				}
			}
		});
		// READY 함수 END
		
	</script>





	<script>
		// 주최자인 경우 이벤트 참가자 승인 대기 목록 조회
		$("#event-wait-list").on({
			click : function(e){
				/* 모달 출력 */
				 $(".popup-shadow, .creator-participant-list").show(0);
			}
		});
		
		// 이벤트 완료 버튼 클릭 시
		$("#event-complete").on({
			click : function(e){
				if(confirm("이벤트를 완료 처리 하시겠습니까?")) {
					$.ajax({
						url: "confirmEventComplete",
						type: "POST",
						data: {
							"eventNo": ${event.eventNo},
							"memberNo" : '${loginMember.memberNo}',
							"eventTicket" : ${event.eventTicket}
						},
						success : function(result){
							var msg = null;
							switch(result) {
							case 1 : 
								$("#event-complete").css({
									"display" : "none"
								});
								$("#event-complete-confirmed").css({
									"display" : "block"
								});
								break;
							case 0 : 
								msg = "이벤트 완료 확인 실패";
								break;
							case -1 : 
								msg = "이벤트 완료 확인 과정 중 오류 발생";
								break;
							}
							if(msg != null) {
								alert(msg);
							}
						},
						error : function(){
							console.log("ajax 통신 실패");
						}
					});
					
					$("#event-complete-confirmed").css({
						"cursor" : "default"
					});
					
				}
			}
		});
	
	
	
		// 이벤트 참가 버튼 클릭시 팝업
		$("#event-participate").on({
			click : function(e) {
				if(${ empty sessionScope.loginMember  }) {
					$(".popup-shadow, #login-popup").show(0);
				} else {
					if(${(event.eventQuota - event.partyCount) <= 0}){
						alert("해당 이벤트는 모집 완료되었습니다");
						return false;
					} else {
						e.preventDefault();
						$(".join-event-popup, .popup-shadow").show(0);
					}
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
				if(${ empty loginMember }) {
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
		
		
		var memberTicket; // 받아올 티켓 수 저장용 변수
		
		// 로그인 회원 티켓 수 조회 Ajax
		function joinEventAjax(memberNo){
			$.ajax({
				url: "getMemberTicket",
				type: "POST",
				data: {
					"memberNo": memberNo
				},
				success : function(result){
					var msg = null;
					switch(result) {
					case 1 : 
						memberTicket = result;
						break;
					case 0 : 
						msg = "로그인 회원 티켓 수 조회 실패";
						break;
					case -1 : 
						msg = "로그인 회원 티켓 수 조회 과정 중 오류 발생";
						break;
					}
					
					if(msg != null) {
						alert(msg);
					}
					
				},
				error : function(){
					console.log("ajax 통신 실패");
				}
			});
		}
	
		
		// 이벤트 참가 확인 버튼 클릭 시
		function joinEvent() {
			console.log("memberTicket : " + memberTicket);
			joinEventAjax(${loginMember.memberNo});
			if(memberTicket < ${event.eventTicket}){
				if(confirm("보유 티켓이 부족합니다. 충전 페이지로 이동하시겠습니까?")){
					location.href = '${contextPath}/mypage/recharge';
				}
			} else {
				location.href = 'joinEvent?eventNo=' + ${event.eventNo} + '&eventTicket=' + ${event.eventTicket} + '&memberNo=' + '${loginMember.memberNo}';
			}
		}
		
		
		// 이벤트 참가 취소
		$("#cancel-event-participate").on({
			click : function() {
				if (confirm("이벤트 참가를 정말 취소하시겠습니까?")) {
					location.href = 'cancelJoinEvent?eventNo=' + ${event.eventNo} + '&eventTicket=' + ${event.eventTicket} + '&memberNo=' + '${loginMember.memberNo}';
				}
			}
		});
		
		// 승인 대기중 취소 ajax
		function cancleWaitEventAjax(){
			$.ajax({
				url: "cancelWaitEvent",
				type: "POST",
				data: {
					"eventNo": ${event.eventNo},
					"memberNo" : '${loginMember.memberNo}',
					"eventTicket" : ${event.eventTicket}
				},
				success : function(result){
					var msg = null;
					switch(result) {
					case 1 : 
						break;
					case 0 : 
						msg = "이벤트 승인 대기 취소 실패";
						break;
					case -1 : 
						msg = "이벤트 승인 대기 취소 오류 발생";
						break;
					}
					
					if(msg != null) {
						alert(msg);
					}
					
				},
				error : function(){
					console.log("ajax 통신 실패");
				}
			});
		}
		
		// 이벤트 승인 대기 취소 버튼 클릭 --> ajax로 DB 반영
		$("#wait-event-participate").on({
			click : function() {
				
				if(confirm("이벤트 참가를 정말 취소하시겠습니까?")) {
					// 이벤트 승인 대기 취소 ajax
					cancleWaitEventAjax();
					$("#wait-event-participate").css({
						"display" : "none"
					});
					$("#event-participate").css({
						"display" : "block"
					});
				}
				
				}
			});
		
		
		// 참가자 승인 ajax
		function permissionAjax (memberNo) {
			$.ajax({
				url: "approveEventJoin",
				type: "POST",
				data: {
					"eventNo": ${event.eventNo},
					"memberNo" : memberNo
				},
				success : function(result){
					var msg = null;
					switch(result) {
					case 1 :
						break;
					case 0 : 
						msg = "참가자 참여 승인 실패";
						break;
					case -1 : 
						msg = "참가자 참여 승인 실패";
						break;
					}
					
					if(msg != null) {
						alert(msg);
					}
					
				},
				error : function(){
					console.log("ajax 통신 실패");
				}
			});
		}
		
		// 참가자 거절 ajax
		function rejectAjax (memberNo) {
			$.ajax({
				url: "rejectEventJoin",
				type: "POST",
				data: {
					"eventNo": ${event.eventNo},
					"memberNo" : memberNo,
					"eventTicket" : ${event.eventTicket}
				},
				success : function(result){
					var msg = null;
					switch(result) {
					case 1 :
						break;
					case 0 : 
						msg = "참가자 참여 거절 실패";
						break;
					case -1 : 
						msg = "참가자 참여 거절 실패";
						break;
					}
					
					if(msg != null) {
						alert(msg);
					}
					
				},
				error : function(){
					console.log("ajax 통신 실패");
				}
			});
		}
		
		
		/* 주최자인 경우 참가 승인,거절 버튼 클릭 시 event */
		// 승인 버튼 클릭 시 -> DB 반영 후 결과 맞을 경우 버튼 변경 (승인됨)
		// 참가자 숫자, 자리 남음, 변경
		var count = ${event.eventQuota - event.partyCount};
		
		$(".do-permission").on({
			click : function(e) {
				
				
				// 정원 초과 아닌 경우 
				if(count > 0){
					if(confirm("해당 회원을 참가 승인하겠습니까?")){
						var memberNo = $(this).parent().find("div").text();
						
						// 승인 ajax 호출
						permissionAjax(memberNo);
						// 부모 없앰
						$(this).parent().css("display", "none");
						// 생기게 하고
						$(this).parent().next().css("display","block");
						
						count--;
						
						$("#left-seat").html(count + "자리 남음");
						$("#left-seat-modal").html(count);
					}
				} else {
					alert("정원이 초과되었습니다.");
				}
				
				
			}
		});
		
		
		// 거절 버튼 클릭
		$(".do-reject").on({
			click : function(e) {
				
				if(confirm("해당 회원을 참가 거절하시겠습니까? \r\n(거절된 회원은 참석 신청이 불가합니다.)")){
					// 정원 초과 아닌 경우 
					var memberNo = $(this).parent().find("div").text();
					
					// 거절 ajax 호출
					rejectAjax(memberNo);
					// 부모 없앰
					$(this).parent().css("display", "none");
					// 생기게 하고
					$(this).parent().next().next().css("display","block");
				}
			}
		});
		
		
		// 거절된 경우 버튼 클릭 시 alert
		$("#denied-event-participate").on({
			click : function(e){
				alert("주최자가 이벤트 참여를 거절했습니다. 다음 이벤트를 이용해주세요.\n (사용하신 티켓은 반환되었습니다)");
			}
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