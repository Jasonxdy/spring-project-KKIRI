<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 이벤트 후기 페이지 CSS 적용 -->
<title>KKIRI(끼리)</title>
</head>
<body>
	<div id="wrapper">

		<!-- Header -->
		<jsp:include page="../common/header.jsp" />

		<!-- 현재시간 구하기 -->
		<jsp:useBean id="currTime" class="java.util.Date" />

		<!-- date format 변경 -->
		<fmt:formatDate var="startDate" value="${event.eventStart}"
			pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />
		<fmt:formatDate var="endDate" value="${event.eventEnd}"
			pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />

		<!-- 이벤트 상세 상단 정보 start -->
		<jsp:include page="eventHeader.jsp" />
		<!-- 이벤트 상세 상단 정보 end -->
	</div>

	<!-- 이벤트 sticky element start // sticky element 사용-->
	<jsp:include page="eventStripe.jsp" />
	<!-- 이벤트 sticky element end -->

	<div class="container">
		<div class="row mt-5 event-detail-container">
			<div class="col-md-7 event-afterComment">

				<!-- 후기 작성, 수정, 삭제 -->
				<%-- <c:if test="${loginMember != null && event.eventNo == myEvent}"> --%>
				<div id="comment-div">
					<p class="info-text">후기글은 익명으로 기록됩니다.</p>



				</div>
				<%-- </c:if> --%>
				<!-- 후기 작성, 수정, 삭제 end -->




				<ul class="comment-wrap">
					<c:if test="${empty ratingList}">
						<h4>
							작성된 후기가 없습니다.
							</h3>
					</c:if>

					<c:if test="${!empty ratingList }">
						<c:forEach var="rating" items="${ratingList}" varStatus="vs">

							<li>
								<p class="comment-content">${rating.ratingContent}</p>
								<p class="star-rating">
									<img src="${contextPath}/resources/img/star-on.png" alt="별점">
									<span class="rating-num">${rating.ratingScore}</span>
								</p>
							</li>
						</c:forEach>
					</c:if>
				</ul>

				<div class="container text-center" id="loading"
					style="display: none;">
					<img src="${contextPath}/resources/img/loading.gif">
				</div>


				<!-- ajax로 후기 목록 출력 -->
				<c:if test="${pInf.listCount > 5}">
					<div class='row' id='addCommentList'>
						<div class='col-md-12 text-center mt-3'>
							<div>
								<button class='btn btn-primary'
									style='background-color: #00a185; border: none;'
									onclick='moreCommentList()'>더보기</button>
							</div>
						</div>
					</div>
				</c:if>





<!-- ajax 구현으로 인해 페이징 바 삭제 -->
<%-- 
				<!-- 페이징 바 -->
				<div class="row justify-content-center pagination-wrap">
					<div>
						<ul class="pagination">
							<c:if test="${pInf.currentPage > 1}">
								<li><a class="page-link "
									href="<c:url value="comment?no=${event.eventNo}">
		                    		<c:param name="currentPage" value="1"/>
		                    	</c:url>">&lt;&lt;</a></li>
								<li><a class="page-link "
									href="<c:url value="comment?no=${event.eventNo}">
		                    		<c:param name="currentPage" value="${pInf.currentPage-1}"/>
		                    	</c:url>">&lt;</a></li>
							</c:if>

							<c:forEach var="p" begin="${pInf.startPage}"
								end="${pInf.endPage}">
								<c:if test="${p == pInf.currentPage}">
									<li><a class="page-link">${p}</a></li>
								</c:if>

								<c:if test="${p != pInf.currentPage}">
									<li><a class="page-link"
										href=" 
			                    	<c:url value="comment">
			                    		<c:param name="currentPage" value="${p}"/>
			                    		<c:param name="no" value="${event.eventNo}"/>
			                    	</c:url>
		                    	">
											${p} </a></li>
								</c:if>

							</c:forEach>
							<c:if test="${pInf.currentPage < pInf.maxPage }">
								<!-- 다음 페이지로(>) -->
								<li><a class="page-link text-success"
									href=" 
		                    	<c:url value="comment">
		                    		<c:param name="currentPage" value="${pInf.currentPage+1}"/>
		                    		<c:param name="no" value="${event.eventNo}"/>
		                    	</c:url>
	                    	">
										&gt; </a></li>

								<!-- 맨 끝으로(>>) -->
								<li><a class="page-link"
									href=" 
		                    	<c:url value="comment">
		                    		<c:param name="currentPage" value="${pInf.maxPage}"/>
		                    		<c:param name="no" value="${event.eventNo}"/>
		                    	</c:url>
	                    	">
										&gt;&gt; </a></li>

							</c:if>
						</ul>
					</div>
				</div>
				<!-- 페이징 바 끝 -->
 --%>			</div>

			<div id="popup" class="popup create-comment-popup">
				<p class="popup-title">
					후기 남기기 <img src="${contextPath}/resources/img/close-btn.png"
						alt="닫기버튼" class="close-popup">
				</p>
				<div class="popup-content">
					<form
						action="insertRating?eventNo=${event.eventNo}&memberNo=${loginMember.memberNo}"
						method="post" onsubmit="return validate1();">
						<textarea name="ratingContent" id="afterComment"
							placeholder="후기를 작성해주세요."></textarea>
						<input type="hidden" class="star-rating" value="0.5"
							name="ratingScore">
						<div class="starRev">
							<p class="starRev-title">별점</p>
							<span class="starR starR1 on">0.5</span> <span
								class="starR starR2">1</span> <span class="starR starR1">1.5</span>
							<span class="starR starR2">2</span> <span class="starR starR1">2.5</span>
							<span class="starR starR2">3</span> <span class="starR starR1">3.5</span>
							<span class="starR starR2">4</span> <span class="starR starR1">4.5</span>
							<span class="starR starR2">5</span>&nbsp;
							<p class="star-result">0.5</p>
						</div>
						<button class="green-radius-btn">후기 등록</button>
					</form>
				</div>
			</div>


			<div class="popup update-comment-popup">
				<p class="popup-title">
					후기 수정하기 <img src="${contextPath}/resources/img/close-btn.png"
						alt="닫기버튼" class="close-popup">
				</p>
				<div class="popup-content">
					<form
						action="updateRating?eventNo=${event.eventNo}&memberNo=${loginMember.memberNo}"
						method="post" onsubmit="return validate2();">
						<textarea name="ratingContent" id="updateComment"
							placeholder="후기를 작성해주세요."></textarea>
						<input type="hidden" class="star-rating" id="ratingScore"
							name="ratingScore">
						<div class="starRev">
							<p class="starRev-title">별점</p>
							<span class="starR starR1 on">0.5</span> <span
								class="starR starR2">1</span> <span class="starR starR1">1.5</span>
							<span class="starR starR2">2</span> <span class="starR starR1">2.5</span>
							<span class="starR starR2">3</span> <span class="starR starR1">3.5</span>
							<span class="starR starR2">4</span> <span class="starR starR1">4.5</span>
							<span class="starR starR2">5</span>&nbsp;
							<p class="star-result">0.5</p>
						</div>
						<button class="green-radius-btn">수정 완료</button>
					</form>
				</div>
			</div>


			<div class="col-md-5">
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
							${startDate} ~ <br> ${endDate}
						</c:otherwise>
						</c:choose>
					</p>
					<!-- 위도, 경도로 얻은 주소 -->
					<p class="mt-3" style="margin-bottom: 0em;">
						<img src="${contextPath}/resources/img/map-ping.png"
							style="height: 18px;" alt="위치아이콘"> ${event.eventLocation}

					</p>
					<p class="text-muted" id="eventPing"></p>

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

				<div class="event-participant mt-5">


					<c:set var="partySize" value="${fn:length(partyList)}" />
					<c:if test="${partySize > 11}">
						<c:set var="partySize" value="11" />
					</c:if>

					<h4>
						참석자 (<span>${event.partyCount}</span>명) <span id="see-all">
							<a href="selectParticipant?no=${event.eventNo}"> 모두 보기 </a>
						</span>
					</h4>
				</div>
				<div class="event-participant-profile-wrap" id="event-party-list">
					<span class="event-participant-profile"
						id="eventCreater-profile-image"> <img
						src="${contextPath}/resources/upProfileImage/${event.memberProfile}"
						alt="주최자">
					</span>
					<c:forEach var="party" items="${partyList}" varStatus="vs">
						<c:if test="${vs.count < 12}">
							<span class="event-participant-profile participant-profile">
								<img
								src="${contextPath}/resources/upProfileImage/${party.memberProfile}"
								alt="참석자">
								<div style="display: none">${party.memberNo}</div>
							</span>
						</c:if>
					</c:forEach>
				</div>


			</div>
		</div>
		<!-- 이벤트 상세 페이지 end -->
		
		<jsp:include page="../event/eventChat.jsp" />
	</div>



	<script>
	
		if(${loginMember != null}) { // 로그인 된 경우
			
			var myEventCheck = false; // 참석 여부 체크
			
			<c:forEach var="party" items="${myEventList}">
				if(${party.eventNo == event.eventNo}){
					if('${party.permission}' == 'Y') { // 참여신청도 했고 승인도 됐었던 경우
						myEventCheck = true;
					}
				}
			</c:forEach>
			
			var myRating = "";
			
			if(myEventCheck && ${loginMember.memberNo != event.memberNo}) { // 참여했는데 주최자가 아닌 경우 후기 작성 가능
				$("#comment-div").show(0); // 보이기
				if(${myRating != null} && ${!empty myRating}) { // 내가 작성한 후기가 있는 경우
	                myRating += "<div class='my-comment'>" +
	                    "<p class='title'>내 후기</p>" +
	                    "<p class='content'>" + '${myRating.ratingContent}' + "</p>" +
	                    "<p class='star-rating'>" + 
	                        "<img src='${contextPath}/resources/img/star-on.png' alt='별점'>" +
	                        "<span class='rating-num'> "+ ${myRating.ratingScore} + "</span>" +
	                    "</p>" +
	                "</div>" +
	                
	                "<button type='button' class='green-radius-btn delete-my-con common-btn'>후기 삭제</button>" +
	                "<button type='button' class='green-radius-btn update-my-con common-btn'>후기 수정</button>";
	                
	                $(myRating).appendTo("#comment-div");
				} else { // 내가 작성한 후기가 없는 경우
	                $("<button type='button' class='insert-comment green-radius-btn' id='insertRatingBtn'>후기" + 
							"남기기</button>").appendTo("#comment-div");
				}
			}
			
			
			
		}
		
	
	
	
	
	
                // 이벤트 참가 버튼 클릭시 팝업
                $("#event-participate").on({
                    click : function(e){
                        e.preventDefault();
                        $(".join-event-popup, .popup-shadow").show(0);
                    }
                });

                $(".join-event-btn").on({
                    click : function(){
                        $(".join-event-popup, .popup-shadow").hide(0);
                        $("#event-participate").hide(0);
                        $("#cancel-event-participate").css({"display":"block"});
                    }
                });

                $("#cancel-event-participate").on({
                    click : function(){
                        if(confirm("정말로 이벤트 참가를 취소하시겠습니까?")){
                            alert("이벤트 참가 취소 백단 실행");
                            $("#cancel-event-participate").hide(0);
                            $("#event-participate").show(0);
                        }
                    }
                });

                $(".already-join").on({
                    click : function(){
                       alert();
                    }
                });

                  // 후기 작성 팝업
                  $("#insertRatingBtn").on({
                    click : function(){
                      $(".popup-shadow, .create-comment-popup").show(0);
                    }
                  });

                  $(".close-popup, .popup-shadow").on({
                    click : function(){
                      $(".popup-shadow, .popup").hide(0);
                    }
                  });

                    $(".starRev .starR").on({
                        click : function(){
                            $(".starRev .starR").removeClass("on");
                            $(this).addClass("on").prevAll(".starR").addClass("on");

                            $(".starRev .star-result").text($(this).text());
                            $(".popup-content .star-rating").val($(this).text());
                        }
                    });

                    function validate1(){
                        if($("#afterComment").val().trim()==""){
                            alert("후기 내용을 작성해주세요.");
                            return false;
                        }
                    }

                    function validate2(){
                        if($("#updateComment").val().trim()==""){
                            alert("후기 내용을 작성해주세요.");
                            return false;
                        }
                    }


                    // 후기 수정 팝업
                    $(".update-my-con").on({
                        click : function(){
                            $(".update-comment-popup, .popup-shadow").show(0);
                            $(".update-comment-popup .star-result").text($(".my-comment .rating-num").text());

                            /* $(".update-comment-popup #updateComment").text($(".my-comment .content").text().replace(/<br> ?/g, '&#013;&#010;')); */
                            var ratingContent = '${myRating.ratingContent}';
                            String.prototype.replaceAll = function(org, dest) {
                                return this.split(org).join(dest);
                            }
                            $(".update-comment-popup #updateComment").text(ratingContent.replaceAll("<br>", "\r\n"));
                            
                            $("#ratingScore").val("${myRating.ratingScore}");
                            
                            var starScore = $(".my-comment .rating-num").text();
                            if(starScore==5){
                                $(".update-comment-popup .starRev .starR").addClass("on");
                            }else if(starScore>4){
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(9)").addClass("on");
                            }else if(starScore==4){
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(8)").addClass("on");
                            }else if(starScore>3){
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(7)").addClass("on");
                            }else if(starScore==3){
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(6)").addClass("on");
                            }else if(starScore>2){
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(5)").addClass("on");
                            }else if(starScore==2){
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(4)").addClass("on");
                            }else if(starScore>1){
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(3)").addClass("on");
                            }else if(starScore==1){
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(2)").addClass("on");
                            }else{
                                $(".update-comment-popup .starRev .starR").removeClass("on");
                                $(".update-comment-popup .starRev .starR:lt(1)").addClass("on");
                            }
                        }
                    });

                    // 후기 삭제
                    $(".delete-my-con").on({
                        click : function(){
                            if(!confirm("후기를 삭제하시겠습니까?")){
                                return false;
                            }else{
                            	var ratingNo = '${myRating.ratingNo}';
                                location.href = 'deleteRating?ratingNo=' + ratingNo;
                            }
                        }
                    });
                    
                    
                </script>


	<!-- 프로필 사진 클릭 시  프로필 상세 이동 -->
	<script>
			$(".participant-profile").on({
				click : function(e){
					var memberNo = $(this).children("div").text();
					location.href = "${contextPath}/profile/user?no=" + memberNo;
				}
			})
			
		$("#eventCreater-profile-image").on({
					click : function(){
						location.href = "${contextPath}/profile/user?no=" + ${event.memberNo};
					}
			});
			
			
			
			/* 더보기 버튼 클릭 시 ajax로 후기 로딩 */
			
			// 현재 표기하는 리스트 수
			var count = 0; // 스크롤 갱신 횟수
			var limit = 5; // 5명씩 보여줌
			var eventNo = '${event.eventNo}';
			
			function executeAjax () {
		$.ajax({
    		url : "addCommentList",
	    	type : "GET",
			data : {count : count, limit : limit, eventNo : eventNo},
			dataType : "json",
			success : function (commentList){
				$.each(commentList, function(i){
				$commentWrap = $(".comment-wrap");
				var commendCard = 
					"<li>" +
						"<p class='comment-content'>" + commentList[i].ratingContent + "</p>" +
								"<p class='star-rating'>" +
									"<img src='${contextPath}/resources/img/star-on.png' alt='별점'>" +
									"<span class='rating-num'>" + commentList[i].ratingScore + "</span>" +
								"</p>" +
							"</li>";
				$commentWrap.append(commendCard);
				});
			},
			beforeSend:function(){
		        $('#loading').css('display', 'block');
		    },
		    complete : function(){
		        $('#loading').css('display', 'none');
		    },
			error : function(){
				console.log("후기 목록 조회 ajax 호출 실패");
			}
    	});
	}
	
			function moreCommentList() {
				if(count+2 <= Math.ceil(${pInf.listCount}/limit)){
		    	executeAjax();
		    	if(count+2 == Math.ceil(${pInf.listCount}/limit)){
		    		$("#addCommentList").remove();
		    	}
		    	count++;
		    	console.log("count : " + count);
	    	}
			}
		</script>


	<jsp:include page="../common/footer.jsp" />

</body>
</html>