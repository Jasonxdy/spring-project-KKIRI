<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=440560a29daf4ebdb30cd5fb2b3b4687&libraries=services,clusterer,drawing"></script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../../../WEB-INF/views/common/header.jsp" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/searchEvent.css">
		<div id="container" class="container-fluid px-0">
			<!-- 지도 start -->
			<div id="map"></div>
			<!-- 지도 end -->

			<!-- 검색창 start -->
			<div id="searchBar" class="container" style="color: white; display: flex; justify-content: center;">
				<div class="row my-3 card shadow"
					style="background-color: #272e37; width: 100%;">
					<div class="col-md-12">
						<!-- <form> -->
							<div class="row p-3 find-event-wrap">
								<div class="category-wrap">
									<label class="mt-1 h4 event-section-title">카테고리</label> 
									<input name="searchKey" class="form-control mt-1 p-1" autocomplete="off" type="text" id="searchKey" readonly data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<!-- 카테고리  -->
									<ul class="dropdown-menu my-1" style="width: 30rem;"
										id="categoryMenu">
										<li style="display: inline-block;">
											<ul>
												<li><a class="dropdown-item" href="javascript:">여행</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">운동</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">독서</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">비즈니스</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">언어</a>
												</li>
											</ul>
										</li>

										<li style="display: inline-block;">
											<ul>
												<li><a class="dropdown-item" href="javascript:">음악</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">영화/공연</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">댄스</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">봉사활동</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">사교</a>
												</li>
											</ul>
										</li>

										<li style="display: inline-block;">
											<ul>
												<li><a class="dropdown-item" href="javascript:">차/오토바이</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">사진/영상</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">스포츠관람</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">게임</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">요리</a>
												</li>
											</ul>
										</li>

										<li style="display: inline-block;">
											<ul>
												<li><a class="dropdown-item" href="javascript:">반려동물</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">사회운동</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">뷰티</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">패션</a>
												</li>
												<li><a class="dropdown-item" href="javascript:">기타</a>
												</li>
											</ul>
										</li>
									</ul>
								</div>
								<!-- 반경 -->
								<div class="mt-1 event-location">
									<div class="dropdown">
										<div class="mr-3">
											<span class="h4 event-section-title">반경</span> <a
												class="h4 event-section-title"
												style="color: white; text-decoration: underline;"
												data-toggle="dropdown" href="#" id="round">5 km</a>
											<ul class="dropdown-menu my-1" id="roundMenu">
												<li><a class="dropdown-item" href="javascript:"
													data-value="1" data-copy="1 km">1 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="2" data-copy="3 km">3 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="3" data-copy="5 km">5 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="4" data-copy="10 km">10 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="5" data-copy="25 km">25 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="6" data-copy="50 km">50 km</a></li>
											</ul>
										</div>
									</div>
									<!-- 지역 -->
									<div class="dropdown mr-1" style="display: inline-block;">
										<div>
											<span class="h4 event-section-title">지역</span> 
											<a class="h4 event-section-title" style="color: white; text-decoration: underline;" data-toggle="dropdown" href="#" id="place">
											
											<!-- 로그인 된 경우 즐겨찾는 장소가 있는 경우 자동으로 검색 -->
											<c:if test="${(loginMember != null) && (loginMember.memberPlace != null) }">
												<%-- <c:set var="mPlace" value="${fn:split(loginMember.memberPlace,' ')}"/>
												${mPlace[0]} ${mPlace[1]} --%>
												${loginMember.memberPlace}
												</a>
												
											</c:if>
											
											<c:if test="${(loginMember == null) || (loginMember.memberPlace == null)}">
												KH정보교육원
												</a>
											</c:if>
											

											<div class="dropdown-menu find-city-wrap">
												<input id="city" class="form-control">
											</div>
										</div>
									</div>
								</div>
								<!-- 이벤트 제목 검색 -->
								<div class="text-center findEventTitleWrap">
									<input type="text" name="searchValue" id="searchValue" class="p-1 form-control eventTItleInput"
										style="border-radius: 0.25rem;" placeholder="제목">
									<a id="findEventButton" class="btn btn-primary" style="background-color: #00a185; border: none;" onclick="searchSlist()">검색</a>
								</div>
							</div>
					</div>
				</div>
			</div>
			<!-- 검색창 end -->
			
			<!-- 이벤트 종료 상태 버튼 -->
			<div class="container">
				<div class="row">
						<div class="col-md-12">
							<div class="float-right">
								<label>종료 이벤트</label>
								<label class="switch">
									<input type="checkbox" id="checkEventStatus">
									<span class="slider round"></span>
								</label>
							</div>
						</div>
				</div>
			</div>
			
			<!-- 현재 시간과 이벤트 시작시간을 비교해 종료여부를 나타내기 위해 사용 -->
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" pattern="yyyyMMddHHmm" var="nowDate" />
			
			<!-- 이벤트 목록 -->
			<div class="container my-5" id="searchListArea">
			</div>
			<div class="container text-center" id="loading">
				<img src="${contextPath}/resources/img/loading.gif">
			</div>
		</div>
		<jsp:include page="../../../WEB-INF/views/common/footer.jsp" />
	
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.56793540174546, 126.98310888649587), // 지도의 중심좌표
		        //center: coords,
		        level: 5 // 지도의 확대 레벨
		    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new kakao.maps.MapTypeControl();
			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
			var markers = [];
			var overlays = [];
			
			// 지도의 기본 중심 좌표
			var coords = new kakao.maps.LatLng(37.56793540174546, 126.98310888649587);
			// 카테고리에 선택된 값 대입
			var testValue = "${findKeyword}";
			
			$(function() {
				if($("#checkEventStatus").is(":checked") == true){
	        		// 종료 이벤트 체크박스가 체크된 경우
	        		checkEventStatus = 1;
	        	} else{
	        		// 종료 이벤트 체크박스가 체크 해제된 경우
	        		checkEventStatus = 0;
	        	}
				
				// 지역 설정 리스트
				var availableCity = ["서울특별시 강남구","서울특별시 강동구","서울특별시 강북구","서울특별시 강서구","서울특별시 관악구","서울특별시 광진구","서울특별시 구로구","서울특별시 금천구","서울특별시 노원구","서울특별시 도봉구","서울특별시 동대문구","서울특별시 동작구","서울특별시 마포구","서울특별시 서대문구","서울특별시 서초구","서울특별시 성동구","서울특별시 성북구","서울특별시 송파구","서울특별시 양천구","서울특별시 영등포구","서울특별시 용산구","서울특별시 은평구","서울특별시 종로구","서울특별시 중구","서울특별시 중랑구"];
		        // 주소 자동 완성
				$("#city").autocomplete({
		        	source: availableCity,
		            select: function(event, ui) {
			            $("#place").text(ui.item.value);
			                  
			            // 주소로 좌표를 검색해 성공할 경우 그 좌표값이 지도의 중심값으로 변경되고 그 좌표값을 반경으로 이벤트 리스트 검색
						geocoder.addressSearch(ui.item.value, function(result, status) {
									
							if (status === kakao.maps.services.Status.OK) {
								coords = new kakao.maps.LatLng(result[0].y, result[0].x);
								map.setCenter(coords);
							} 
						});
						searchSlist();
		            },
		            focus: function(event, ui) {
		            	return false;
		            }
		        });
		        // 관심 지역 설정한 경우
		        <c:if test="${(loginMember != null) && (loginMember.memberPlace != null) }">
			        geocoder.addressSearch($("#place").text(), function(result, status) {
						
						if (status === kakao.maps.services.Status.OK) {
							coords = new kakao.maps.LatLng(result[0].y, result[0].x);
							map.setCenter(coords);
							
							if(testValue.length>0){ // index에 카테고리를 클릭해서 탐색을 들어갔을때
								$("#searchKey").val(testValue);
					    		$("#findEventButton").click();
					    	}else{
								searchSlist();  // 그냥 탐색을 들어갔을 때
					    	}
						} 
					});
				</c:if>
				
				// 관심지역 없는 경우
				<c:if test="${(logiMember == null) && (loginMember.memberPlace == null)}">
					if(testValue.length>0){ // index에 카테고리를 클릭해서 탐색을 들어갔을때
						$("#searchKey").val(testValue);
			    		$("#findEventButton").click();
			    	}else{
						searchSlist();  // 그냥 탐색을 들어갔을 때
			    	}
				</c:if>
			});
			 // 카테고리가 선택된 경우 이벤트 검색
			 $("#categoryMenu").find("a").on('click',function(){
		          $("#searchKey").prop("value",$(this).text());
		        });
			// 반경이 선택된 경우 이벤트 검색
		        $("#roundMenu").find("a").on('click',function(){
		          $("#round").text($(this).text());
		          searchSlist();
		        });
		       // 종료 이벤트 버튼이 클릭된 경우 이벤트 검색
		        $("#checkEventStatus").on('change',function(){
		        	
		        	if($("#checkEventStatus").is(":checked") == true){
		        		// 종료 이벤트 체크박스가 체크된 경우
		        		checkEventStatus = 1;
		        	} else{
		        		// 종료 이벤트 체크박스가 체크 해제된 경우
		        		checkEventStatus = 0;
		        	}
		        	searchSlist();
		        });
		        
		    // 이 위로 검색창 관련 스크립트
		    var searchKey = "";
		    var searchValue ="";
		    var currentPage = 2;
		    var num = 0;
		    var radius = 0;
		    var limit = 5;
		    var limitTemp = 5;
		    var webPage = 1;
		    var checkEventStatus = 0;
		    var content = "";
			var startDate ="";
			
			function setList(sList){
				$.each(sList, function(i){
					// 반경 계산을 위한 중심 좌표
					var c1 = coords;
					// 반경 계산을 위한 이벤트 좌표
					var c2 = new kakao.maps.LatLng(sList[i].latitude, sList[i].longitude);
					// 좌표 사이의 거리를 계산
					var poly = new kakao.maps.Polyline({
						path:[c1,c2]
					});
					var dist = poly.getLength();
					
					// 반경을 조건으로 실행
					if(dist<radius){
						num += 1;
    					
    					// 시작 시간 포맷 변경
    					startDate = sList[i].eventStart.substring(0,4) +
    								 "년 " + 
    								 sList[i].eventStart.substring(4,6) +
    								 "월 "+
    								 sList[i].eventStart.substring(6,8) +
    								 "일 " +
    								 sList[i].eventStart.substring(8,10) +
    								 ":" +
    								 sList[i].eventStart.substring(10,12)
    								 ;
    					// ajax 사용을 위해 content에 내용 작성
    					content +=
    								"<div class='row card shadow my-4' id='searchList'>" +
    									"<div class='col-md-12 h-100 eventBar' onclick=\"location.href= '${contextPath}/event/detail?no="+ sList[i].eventNo +"'\" >" +
    										"<div class='row h-100'>" +
												"<div class='col-md-3 thumb-wrap'>" +
													"<img class='p-2 thumb' src='${contextPath}/resources/upEventThumbnail/" + sList[i].eventThumbnail + "' alt='로고'>" +
												"</div>" +
												"<div class='col-md-6 p-3'>" +
													"<p class='mb-1' style='color: darkcyan;'>" + 
													startDate + 
													"</p>" +
													"<h2 class='mb-3'>" + sList[i].eventTitle + "</h2>" +
													"<img class='mb-2' src='${contextPath}/resources/img/map-ping.png' alt='' style='width: 1rem; height: 1.5rem;'>" + 
													"<span>" + sList[i].eventAddress + "</span>" +
													"<p>"+sList[i].eventLocation+"</p>" +
													"<p class='content category-content'>" + sList[i].eventCategory + "</p>" +
												"</div>" +
												"<div class='col-md-3'>" +
													"<div class='p-3'>" +
														"<div>" +
															"<img style='width: 4rem; height: 4rem; border-radius: 50%;' src='${contextPath}/resources/upProfileImage/"+ sList[i].memberProfile +"' alt=''>" +
															"<div style='display: inline-block; vertical-align: middle;'>" +
																"<p class='mb-1'>" + sList[i].memberNickname + "</p>" +
																"<img style='width: 1rem; height: 1rem;' src='${contextPath}/resources/img/star-on.png' alt=''>" +
																"<span>" + sList[i].eventScore.toFixed(1) + "</span>" +
															"</div>" +
														"</div>";
						// 현재 날짜와 이벤트 종료시간을 비교하여 종료 이벤트 결정
						if(${nowDate} < sList[i].eventEnd){
											content += "<p id='join' class='text-center float-right' style='margin-top: 5rem;'>티켓"+ sList[i].eventTicket + "장</p>" +
													"</div>" +
												"</div>" +
											"</div>" +
										"</div>" +
									"</div>";
						} else{
											content += "<p class='already-finish-event float-right' style='margin-top: 5rem;'>종료된 이벤트</p>" +
													"</div>" +
												"</div>" +
											"</div>" +
										"</div>" +
									"</div>";
						}
									
						// 해당 이벤트의 좌표를 기반으로 지도 API에 마커를 생성
					    var marker = new kakao.maps.Marker({
					        map: map,
					        position: new kakao.maps.LatLng(sList[i].latitude, sList[i].longitude)
					    });
						markers.push(marker);
						// 마커 생성과 동시에 마커에 오버레이 정보와 기능 추가
					    kakao.maps.event.addListener(marker, 'click', function() {
					    	var overlay = new kakao.maps.CustomOverlay({
						        position: new kakao.maps.LatLng(sList[i].latitude, sList[i].longitude)
						    });
					    	
					    	var overlayContent = document.createElement('div');
						    overlayContent.setAttribute('class','owrap');
						    
						    var overlayInfo = document.createElement('div');
						    overlayInfo.setAttribute('class','oinfo');
						    
						    var overlayTitle = document.createElement('div');
						    overlayTitle.setAttribute('class','otitle');
						    overlayTitle.innerHTML = sList[i].eventTitle;
						    
						    var overlayClose = document.createElement('div');
						    overlayClose.setAttribute('class','oclose');
						    
						    var overlayBody = document.createElement('div');
						    overlayBody.setAttribute('class','obody');
						    overlayBody.setAttribute("onclick","location.href = '${contextPath}/event/detail?no=" + sList[i].eventNo + "'");
						    
						    var overlayImg = document.createElement('div');
						    overlayImg.setAttribute('class','oimg');
						    overlayImg.appendChild(
						    				document.createElement('img'))
						    				.setAttribute('src',"${contextPath}/resources/upEventThumbnail/"+sList[i].eventThumbnail);
						    
						    var overlayDesc = document.createElement('div');
						    overlayDesc.setAttribute('class','odesc');
						    
						 	// 잠깐대기
						    var overlayAddress = document.createElement('div');
						    overlayAddress.setAttribute('class','oaddress');
						    overlayAddress.innerHTML = sList[i].eventAddress;
						    
						    var overlayPlace = document.createElement('div');
						    overlayPlace.setAttribute('class','oplace');
						    overlayPlace.innerHTML = sList[i].eventLocation;
						    
						    /* var overlayScore = document.createElement('div');
						    overlayScore.setAttribute('class','oscore');
						    overlayScore.appendChild(
						    				document.createElement('img'))
						    				.setAttribute('src',"${contextPath}/resources/img/star-on.png");
						    overlayScore.appendChild(
						    				document.createElement('span')).innerHTML = sList[i].eventScore; */
						    
						    var overlayJoin = document.createElement('p');
						    overlayJoin.setAttribute('class','ojoin');
						    
							if(${nowDate} < sList[i].eventEnd){
						    	overlayJoin.setAttribute('id','join');
						    	overlayJoin.innerHTML = "티켓" + sList[i].eventTicket + "장";
						    } else{
						    	overlayJoin.setAttribute('class','already-finish-event')
						    	overlayJoin.innerHTML = "종료된 이벤트";
						    }
						    
						    overlayContent.appendChild(overlayInfo);
						    overlayInfo.appendChild(overlayTitle);
						    overlayTitle.appendChild(overlayClose);
						    overlayInfo.appendChild(overlayBody);
						    overlayBody.appendChild(overlayImg);
						    overlayBody.appendChild(overlayDesc);
						    overlayDesc.appendChild(overlayAddress);
						    overlayDesc.appendChild(overlayPlace);
						    //overlayDesc.appendChild(overlayScore);
						    //overlayScore.appendChild(overlayJoin);
						    overlayDesc.appendChild(overlayJoin);

						    overlayClose.onclick = function () {
						        overlay.setMap(null);
						    };
						    
						    overlay.setContent(overlayContent);
						    
					        overlay.setMap(map);
					        overlays.push(overlay);
					    });
					}
				});
				
				function setMarkers(map) {
		    	    for (var i = 0; i < markers.length; i++) {
		    	        markers[i].setMap(map);
		    	    }            
		    	}
			}
		    // 이벤트 리스트 탐색
		    function searchSlist(){
		    	// 로딩이미지 구현
		    	$("#loading").show();
    			$("#searchListArea").hide();
		    	// 카테고리와 제목을 변수에 저장
		    	searchKey = $("#searchKey").val();
		    	searchValue =  $("#searchValue").val();
		    	
		    	// 현재 검색된 이벤트 갯수
		    	num = 0;
		    	// 한번에 검색될 이벤트 수
		    	limitTemp = 5;
		    	// 총 이벤트 수 계산을 위한 변수
		    	webPage = 1;
		    	// 이벤트 검색을 위한 변수
		    	currentPage = 2;
		    	
		    	$("#searchListArea").empty();
		    	
		    	// 지도 api에 생성된 마커 삭제와 배열 초기화
		    	markers.forEach(function(marker){
		    		marker.setMap(null); 
		    	});
    			markers.length = 0;
    			
    			overlays.forEach(function(overlay){
    				overlay.setMap(null);
    			});
    			overlays.length = 0;
    			
		    	$.ajax({
		    		url : "searchEvents",
		    		type : "POST",
		    		data : {"searchKey" : searchKey,
		    				"searchValue" : searchValue,
		    				"limit" : limitTemp,
		    				"checkEventStatus" : checkEventStatus},
		    		dataType : "json",
		    		success : function(sList){
		    			
		    			content = "";
		    			startDate = "";
		    			
		    			switch($("#round").text()){
		    				case '1 km': radius= 1000; break;
		    				case '3 km': radius= 3000; break;
		    				case '5 km': radius= 5000; break;
		    				case '10 km': radius= 10000; break;
		    				case '25 km': radius= 25000; break;
		    				case '50 km': radius= 50000; break;
		    			}
		    			// 검색된 이벤트가 없는 경우
		    			if(sList == ""){
		    				$("#searchListArea").empty();
		    				content = "<div class='text-center h2'>존재하는 이벤트가 없습니다.</div>";
		    				$(content).appendTo("#searchListArea");	
		    				$("#loading").hide();
			    			$("#searchListArea").show();
		    			} else{
		    				// 이벤트가 검색된 경우
		    				$("#searchListArea").empty();
		    				
		    				setList(sList);
		    				
		    				content += "<div class='row' id='addBtn'><div class='col-md-12 text-center'><div><button class='btn btn-primary' style='background-color: #00a185; border: none;' onclick='moreSlist()'>더보기</button></div></div></div>"
		    				$(content).appendTo("#searchListArea");
		    				
		    				if(num < limit){
		    					limitTemp = limit - num;
		    					moreSlist();
		    				} else{
			    				$("#loading").hide();
				    			$("#searchListArea").show();
		    				}
		    			}
		    		} ,
		    		error : function(){
		    			alert("이벤트 목록 조회 ajax 호출 실패");
		    		}
		    	});
		    };
		    
		    // 한번의 db조회로 설정한 개수의 이벤트가 만족되지 않는 경우 추가 검색
		    function moreSlist(){
		    	//$("#loading").show();
    			//$("#searchListArea").hide();
		    	$.ajax({
		    		url : "searchEvents",
		    		type : "POST",
		    		data : {"searchKey" : searchKey,
		    				"searchValue" : searchValue,
		    				"currentPage" : currentPage,
		    				"limit" : limitTemp,
		    				"checkEventStatus" : checkEventStatus},
		    		dataType : "json",
		    		success : function(sList){
		    			content = "";
		    			startDate ="";
		    			currentPage += 1;
		    			
		    			if(sList == ""){
		    				if(num == 0){
		    					$("#searchListArea").empty();
		    					content = "<div class='text-center h2'>존재하는 이벤트가 없습니다.</div>";
			    				$(content).appendTo("#searchListArea");	
			    				$("#loading").hide();
				    			$("#searchListArea").show();
		    				} else{
			    				$("#addBtn").remove();
			    				$("#searchListArea").show();
			    		    	$("#loading").hide();
		    				}
		    			} else{
		    				$("#addBtn").remove();
		    				
		    				setList(sList);
		    				
		    				content += "<div class='row' id='addBtn'><div class='col-md-12 text-center'><div><button class='btn btn-primary' style='background-color: #00a185; border: none;' onclick='moreSlist()'>더보기</button></div></div></div>"
		    				$(content).appendTo("#searchListArea");
		    				
		    				if(num >= (webPage*limit)){
		    					limitTemp = limit;
		    					webPage += 1;
		    					$("#searchListArea").show();
			    		    	$("#loading").hide();
		    				} else{
		    					limitTemp = (limit*webPage) - num;
		    					moreSlist();
		    				}
		    			}
		    		} ,
		    		error : function(){
		    			alert("이벤트 목록 더보기 ajax 호출 실패");
		    		}
		    	});
		    };
		</script>
</body>
</html>