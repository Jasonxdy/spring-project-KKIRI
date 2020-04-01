<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${contextPath}/resources/css/eventPicture.css">
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
			<div class="col-md-7 event-picture">

			 	<ul>
				<!-- 이미지 목록이 없는 경우 -->
				<c:if test="${empty imageList}">
					<h5 class="text-muted">등록된 이벤트 사진이 아직 없습니다 :P</h3>
				</c:if>

				<!-- 이미지 목록이 있는 경우 -->
				<c:if test="${!empty imageList}">
						<c:forEach var="image" items="${imageList}" varStatus="vs">
							<li>
								<div class="picture-wrap">
									<div id="memberNo" style="display:none">${image.memberNo}</div>
									<p class="member-profile" style="display:none">${contextPath}/resources/upProfileImage/${image.memberProfile}</p>
									<p class="member-nickname" style="display:none">${image.memberNickname}</p>
									<img
										src="${contextPath}/resources/upEventPicture/${image.imgChangeName}"
										alt="이미지예시">
									<p class="picture-title" style="display:none">${image.boardTitle}</p>
									<c:if test="${fn:length(image.boardTitle) > 10}">
										<p class="picture-title-short" style="margin-bottom:5px">${fn:substring(image.boardTitle,0,7) }…</p>
									</c:if>
									<c:if test="${fn:length(image.boardTitle) <= 10}">
										<p class="picture-title-short" style="margin-bottom:5px">${image.boardTitle}</p>
									</c:if>
									<p style="margin-bottom:5px">
										<img class="eventCreater-profile ml-1" 
										src="${contextPath}/resources/upProfileImage/${image.memberProfile}" style="width: 25px; height: 25px;">
										<span class="text-muted" style="margin-top:10px"><font size="3rem">${image.memberNickname}</font></span>
									</p>
									<fmt:formatDate var="imageDate" value="${image.boardModifyDt}"
										pattern="yyyy년 MM월 dd일 HH:mm" />
									<p class="picture-date">${imageDate}</p>
									<p class="picture-content">${image.boardContent}</p>
									<p class="picture-imgNo" style="display:none;">${image.imgNo}</p>
									<p class="picture-boardNo" style="display:none;">${image.boardNo}</p>
								</div>
							</li>
						</c:forEach>
				</c:if>
				</ul>
				
				
				<!-- 최종적으로 참여했던 경우 사진 업로드 나타내기-->
				<c:if test="${!empty loginMember}">
					<c:if test="${!empty myEventList}">
						<c:forEach var="myEvent" items="${myEventList}">
							<c:if test="${event.eventNo == myEvent.eventNo && myEvent.permission == 'Y'}">
								<button type="button" class="upload-image green-radius-btn">사진
									업로드</button>
							</c:if>
						</c:forEach>
					</c:if>
				</c:if>
				
				
				
				
				<!-- 페이징 바 -->
				<div class="row justify-content-center pagination-wrap">
					<div>
						<ul class="pagination">
						<c:if test="${pInf.currentPage > 1}">
							<li><a class="page-link " href="<c:url value="picture?no=${event.eventNo}">
		                    		<c:param name="currentPage" value="1"/>
		                    	</c:url>">&lt;&lt;</a></li>
							<li><a class="page-link " href="<c:url value="picture?no=${event.eventNo}">
		                    		<c:param name="currentPage" value="${pInf.currentPage-1}"/>
		                    	</c:url>">&lt;</a></li>
		                    	</c:if>
		                    	
		                    	<c:forEach var="p" begin="${pInf.startPage}" end="${pInf.endPage}">
	                	<c:if test="${p == pInf.currentPage}">
			                <li>
			                    <a class="page-link active">${p}</a>
			                </li>
		                </c:if>
	                	
	                	<c:if test="${p != pInf.currentPage}">
	                		<li>
		                    	<a class="page-link" 
			                    	href=" 
			                    	<c:url value="picture">
			                    		<c:param name="currentPage" value="${p}"/>
			                    		<c:param name="no" value="${event.eventNo}"/>
			                    	</c:url>
		                    	">
				                    ${p}
				                </a>
		                	</li>
	                	</c:if>
	                	
                	</c:forEach>
                	<c:if test="${pInf.currentPage < pInf.maxPage }">
                	<!-- 다음 페이지로(>) -->
		                <li>
							<a class="page-link text-success" 
		                    	href=" 
		                    	<c:url value="picture">
		                    		<c:param name="currentPage" value="${pInf.currentPage+1}"/>
		                    		<c:param name="no" value="${event.eventNo}"/>
		                    	</c:url>
	                    	">
			                    &gt;
			                </a>
		                </li>
		                
		                <!-- 맨 끝으로(>>) -->
		                <li>
		                    <a class="page-link" 
		                    	href=" 
		                    	<c:url value="picture">
		                    		<c:param name="currentPage" value="${pInf.maxPage}"/>
		                    		<c:param name="no" value="${event.eventNo}"/>
		                    	</c:url>
	                    	">
			                    &gt;&gt;
			                </a>
		                </li>
	                
	                </c:if>
						</ul>
					</div>
				</div>
				<!-- 페이징 바 끝 -->
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
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=440560a29daf4ebdb30cd5fb2b3b4687&libraries=services,clusterer,drawing"></script>
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
					<span class="event-participant-profile"> <img
						src="${contextPath}/resources/upProfileImage/${event.memberProfile}"
						alt="주최자" id="eventCreater-profile-image">
					</span>
					<c:forEach var="party" items="${partyList}" varStatus="vs">
						<c:if test="${vs.count < 12}">
							<span class="event-participant-profile participant-profile">
								<img src="${contextPath}/resources/upProfileImage/${party.memberProfile}"
								alt="참석자">
								<div style="display: none;">${party.memberNo}</div>
							</span>
						</c:if>
					</c:forEach>
				</div>


			</div>
		</div>
		<!-- 이벤트 상세 페이지 end -->



		<!-- 사진 자세히 보기 팝업 -->
		<div class="popup detail-image-popup" id="popup">
			<p class="popup-title">
				사진 자세히보기 <img src="${contextPath}/resources/img/close-btn.png"
					alt="닫기버튼" class="close-popup">
			</p>
			<div class="popup-content popup-img">
				<img src="" alt="이미지예시">
				<div class="content-wrap">
					<p class="popup-picture-imgNo" style="display:none;"></p>
					<p class="popup-picture-boardNo" style="display:none;"></p>
					<p class="popup-picture-title"></p>
					<p class="popup-picture-member">
						<img src="${contextPath}/resources/upProfileImage/${event.memberProfile}"
								alt="주최자" class="eventCreater-profile mr-1" style="width: 30px; height:30px;">
						<span class="popup-picture-memberNickname" style="cursor: pointer;"></span>
					</p>
					<p class="popup-picture-date"></p>
					<p class="popup-picture-content"></p>
				</div>
			</div>
			<div class="button-area">
				<button type="button" class="modify-button green-radius-btn">수정하기</button>
				<button type="button" class="delete-button green-radius-btn">삭제하기</button>
			</div>
		</div>



		<!-- 사진 업로드 팝업 -->
		<div class="popup upload-image-popup common-image-popup">
			<p class="popup-title">
				사진 업로드 <img src="${contextPath}/resources/img/close-btn.png"
					alt="닫기버튼" class="close-popup">
			</p>
			<form action="insertPicture?no=${event.eventNo}" method="post" enctype="multipart/form-data" role="form" onsubmit="return uploadValidate();">
				<img class="upload-image-section">
				<button type="button" class="upload-image-btn green-radius-btn">사진
					업로드</button>
				<input type="file" class="upload-file" id="upload-file" name="image"
					onchange="loadImg(this)"> <label for="upload-image-title">제목</label>
				<input type="text" id="upload-image-title" placeholder="제목을 작성해주세요." name="boardTitle">

				<label for="upload-image-content">내용</label>
				<textarea id="upload-image-content" placeholder="내용을 작성해주세요." name="boardContent"></textarea>
				<input type="text" name="memberNo" style="display:none" value="${loginMember.memberNo}">
				<input type="text" name="eventNo" style="display:none" value="${event.eventNo}">

				<button class="green-radius-btn submit-upload-img">작성 완료</button>
			</form>
		</div>
		
		
		<!-- 사진 수정 팝업 -->
		<div class="popup update-image-popup common-image-popup">
			<p class="popup-title">
				사진 수정하기 <img src="${contextPath}/resources/img/close-btn.png"
					alt="닫기버튼" class="close-popup">
			</p>
			<form action="updatePicture" method="post" enctype="multipart/form-data" role="form" onsubmit="return updateValidate();">
				<img class="upload-image-section"
					src="" alt="예시 이미지">
				<button type="button" class="upload-image-btn green-radius-btn">사진
					업로드</button>
				<input type="file" class="upload-file" onchange="loadImg(this)" name="image">

				<input type="text" name="imgNo" id="upload-updateImg-imgNo" style="display:none;">
				<input type="text" name="boardNo" id="upload-updateImg-boardNo" style="display:none;">
				<label for="upload-updateImg-title">제목</label> <input type="text"
					id="upload-updateImg-title" placeholder="제목을 작성해주세요." name="boardTitle"> <label
					for="upload-updateImg-content">내용</label>
				<textarea id="upload-updateImg-content" placeholder="내용을 작성해주세요." name="boardContent"></textarea>

				<button class="green-radius-btn submit-upload-img">수정 완료</button>
			</form>
		</div>

		<div class="popup-shadow"></div>

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
		</script>



		<script>
		
                  // 사진 삭제 이벤트
                  $(".button-area .delete-button").on({
                      click : function(){
                        if(!confirm("정말로 해당 게시글을 삭제하시겠습니까?")){
                            return false;
                        }else{
                        	
                        	location.href = "deletePicture?imgNo=" + $("#popup .popup-picture-imgNo").text() + "&boardNo=" + $("#popup .popup-picture-boardNo").text();  
                        }
                      }
                  });
                  
                  // 사진 수정하기 버튼 클릭시 수정 팝업 나오는 이벤트
                  $(".button-area .modify-button").on({
                      click : function(){
                        $("#popup").hide();
                        $(".update-image-popup").show();
                        $(".update-image-popup form > img").attr("src",$("#popup .popup-content img").attr("src"));
                        $(".update-image-popup #upload-updateImg-title").val($("#popup .popup-picture-title").text());
                        
                        String.prototype.replaceAll = function(org, dest) {
                            return this.split(org).join(dest);
                        }
                        
                        $(".update-image-popup #upload-updateImg-content").html($("#popup .popup-picture-content").html().replaceAll("<br>", "\r\n"));
                        $(".update-image-popup #upload-updateImg-imgNo").val($("#popup .popup-picture-imgNo").text());
                        $(".update-image-popup #upload-updateImg-boardNo").val($("#popup .popup-picture-boardNo").text());
                      }
                  });

                  // 사진 업로드되는 이벤트
                  $(".upload-image-btn").on({
                      click : function(){
                        $(this).next().click();
                      }
                  });

                  function loadImg(value){
                    if(value.files && value.files[0]){
                        var reader = new FileReader();
                        reader.onload = function(e){
                            $(value).prev().prev(".upload-image-section").prop("src",e.target.result);
                        }
                    }
                    reader.readAsDataURL(value.files[0]);
                  }
					
                  
                  // 사진 클릭 시 이벤트
                  $(".picture-wrap").on({
                    click : function(){
                      $("#popup .popup-img>img").attr("src",$(this).children("img").attr("src"));
                      $("#popup .popup-picture-title").text($(this).find(".picture-title").text());
                      $("#popup .popup-picture-date").text($(this).find(".picture-date").text());
                      
                      $("#popup .popup-picture-content").html($(this).find(".picture-content").html());
                      $("#popup .popup-picture-imgNo").text($(this).find(".picture-imgNo").text());
                      $("#popup .popup-picture-boardNo").text($(this).find(".picture-boardNo").text());
                      
                      // 작성자 정보 얻어오기
                      $("#popup .popup-picture-member>img").attr("src",$(this).find(".member-profile").text());
                      $("#popup .popup-picture-memberNickname").text($(this).find(".member-nickname").text());
                      
                      var memNo = $(this).children("div").text();
                      $("#popup .popup-picture-member>img, #popup .popup-picture-memberNickname").on({
                    	  click : function(){
                    		  location.href = '${contextPath}/profile/user?no=' + memNo;
                    	  }
                      });
                      
                      
                      // 로그인한 사람이 해당 글을 작성한 작성자인 경우 수정, 삭제 버튼 보이기
                      if(${loginMember != null}){
	                      if($(this).children("div").text() == '${loginMember.memberNo}'){ // 작성자일때
		                      $(".button-area").css("display", "block");
	                      } else if ('${loginMember.memberGrade}' == 'A') {
		                      $(".button-area").css("display", "block");
		                      $(".button-area .modify-button").css("display", "none")
	                    	  
                      	  }	else {
		                      $(".button-area").css("display", "none");
	                      }
                      }
                      
                      $(".popup-shadow, #popup").show(0);
                    }
                  });

                  $(".close-popup, .popup-shadow").on({
                    click : function(){
                      $(".popup-shadow, .popup").hide(0);
                    }
                  });

                  // 사진 업로드 버튼 클릭시 팝업 나오는 이벤트
                  $(".upload-image").on({
                      click : function(){
                        $(".upload-image-popup, .popup-shadow").show(0);
                      }
                  });
                  
                  // 사진 수정 시 유효성 검사
                  function updateValidate(){
                	  if($("#upload-updateImg-title").val().trim() == ""){
                		  alert("제목을 입력해주세요!");
                          return false;
                	  } else if($("#upload-updateImg-content").val().trim() == ""){
                		  alert("내용을 입력해주세요!");
                          return false;
                	  }
                  }

                  // 사진 팝업 업로드시 유효성 검사
                  function uploadValidate(){
                      if($("#upload-file").val()==""){
                          alert("사진을 업로드해주세요!");
                          return false;
                      }else if($(".upload-image-popup #upload-image-title").val().trim()==""){
                          alert("제목을 입력해주세요!");
                          return false;
                      }else if($(".upload-image-popup #upload-image-content").val().trim()==""){
                          alert("내용을 입력해주세요!");
                          return false;
                      }else{
                          return true;
                      }
                  }
                  
                </script>

		<jsp:include page="../event/eventChat.jsp" />
	</div>

	<jsp:include page="../common/footer.jsp" />




</body>
</html>