<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=113a0beb55aa56aa1fd5776ff4bb068c&libraries=services,clusterer,drawing"></script>
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
			<div id="searchBar" class="container"
				style="color: white; display: flex; justify-content: center;">
				<div class="row my-3 card shadow"
					style="background-color: #272e37; width: 100%;">
					<div class="col-md-12">

						<!-- <form> -->
							<div class="row p-2">
								<div class="col-md-3">
									<label class="mt-1 h4 event-section-title">카테고리</label> 
									<input name="searchKey" class="form-control mt-1 p-1" autocomplete="off" type="text" id="searchKey" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

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

								<div class="col-md-4 mt-1 event-location">
									<div class="dropdown" style="display: inline-block;">
										<div class="mr-3">
											<span class="h4 event-section-title">반경</span> <a
												class="h4 event-section-title"
												style="color: white; text-decoration: underline;"
												data-toggle="dropdown" href="#" id="round">5 km</a>
											<ul class="dropdown-menu my-1" id="roundMenu">
												<li><a class="dropdown-item" href="javascript:"
													data-value="1" data-copy="5 km">5 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="2" data-copy="10 km">10 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="3" data-copy="25 km">25 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="4" data-copy="50 km">50 km</a></li>
												<li><a class="dropdown-item" href="javascript:"
													data-value="5" data-copy="100 km">100 km</a></li>
											</ul>
										</div>
									</div>

									<div class="dropdown mr-1" style="display: inline-block;">
										<div>
											<span class="h4 event-section-title">지역</span> 
											<a
												class="h4 event-section-title"
												style="color: white; text-decoration: underline;"
												data-toggle="dropdown" href="#" id="place">KH정보교육원</a>

											<div class="dropdown-menu find-city-wrap">
												<!-- <label for="city">도시: </label> -->
												<input id="city" class="form-control">
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-5 text-center findEventTitleWrap">
									<input type="text" name="searchValue" id="searchValue" class="p-1 form-control eventTItleInput"
										style="border-radius: 0.25rem;" placeholder="제목">
									<a class="btn btn-primary" style="background-color: #00a185; border: none;" onclick="searchSlist()">검색</a>
								</div>
							</div>
						<!-- </form> -->
					</div>
				</div>
			</div>
			<!-- 검색창 end -->
			
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" pattern="yyyyMMddHHmm" var="nowDate" />
			<!-- 이벤트 목록 -->
			<div class="container my-5" id="searchListArea">
			</div>
		</div>
		<jsp:include page="../../../WEB-INF/views/common/footer.jsp" />

		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.56793540174546, 126.98310888649587), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
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
			
			// 마커를 생성하고 지도위에 표시하는 함수입니다
			function addMarker(position) {
			    // 마커를 생성합니다
			    var marker = new kakao.maps.Marker({
			        position: position
			    });
			    // 마커가 지도 위에 표시되도록 설정합니다
			    marker.setMap(map);
			    // 생성된 마커를 배열에 추가합니다
			    markers.push(marker);
			}
			
			 $(function() {
		          var availableCity = ["서울특별시 강남구","서울특별시 강동구","서울특별시 강북구","서울특별시 강서구","서울특별시 관악구","서울특별시 광진구","서울특별시 구로구","서울특별시 금천구","서울특별시 노원구","서울특별시 도봉구","서울특별시 동대문구","서울특별시 동작구","서울특별시 마포구","서울특별시 서대문구","서울특별시 서초구","서울특별시 성동구","서울특별시 성북구","서울특별시 송파구","서울특별시 양천구","서울특별시 영등포구","서울특별시 용산구","서울특별시 은평구","서울특별시 종로구","서울특별시 중구","서울특별시 중랑구"];
		          $("#city").autocomplete({
		              source: availableCity,
		              select: function(event, ui) {
		                  console.log(ui.item);
		                  $("#place").text(ui.item.value);
		                  
		               		// 주소로 좌표를 검색합니다
							geocoder.addressSearch(ui.item.value, function(result, status) {
								
						     if (status === kakao.maps.services.Status.OK) {
						        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						        map.setCenter(coords);
						    	} 
							});  
		              },
		              focus: function(event, ui) {
		                  return false;
		                  //event.preventDefault();
		              }
		          });
		        });
			 
			 /* 이 위로 지도 관련 스크립트 */
			 
			 $("#categoryMenu").find("a").on('click',function(){
		          $("#searchKey").prop("value",$(this).text());
		        });

		        $("#roundMenu").find("a").on('click',function(){
		          $("#round").text($(this).text());
		        });
		        
		        $("#place").on('input',function(){
		        	console.log("aa");
		        });
		        
		    // 이 위로 검색창 관련 스크립트
		    var searchKey = "";
		    var searchValue ="";
		    var currentPage = 2;
		    
		    function searchSlist(){
		    	searchKey = $("#searchKey").val();
		    	searchValue =  $("#searchValue").val();
		    	
		    	$.ajax({
		    		url : "searchEvents",
		    		type : "POST",
		    		data : {"searchKey" : searchKey,
		    				"searchValue" : searchValue},
		    		dataType : "json",
		    		success : function(sList){
		    			var content = "";
		    			var startDate ="";
		    			
		    			if(sList == ""){
		    				$("#searchListArea").empty();
		    				content = "<tr id='searchList'><td colspan='5'>존재하는 이벤트가 없습니다.</td></tr>"
		    				$(content).appendTo("#searchListArea");	
		    			} else{
		    				$("#searchListArea").empty();
		    				$.each(sList, function(i){
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
		    					content +=
		    								"<div class='row card shadow my-4' id='searchList'>" +
		    									"<div class='col-md-12 h-100'>" +
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
															"<span>" + sList[i].eventLocation + "</span>" +
															"<p>" + sList[i].eventContent + "</p>" +
														"</div>" +
														"<div class='col-md-3'>" +
															"<div class='p-3'>" +
																"<div>" +
																	"<img style='width: 4rem; height: 4rem; border-radius: 50%;' src='${contextPath}/resources/upProfileImage/"+ sList[i].memberProfile +"' alt=''>" +
																	"<div style='display: inline-block;'>" +
																		"<p class='mb-1'>" + sList[i].memberId + "</p>" +
																		"<img style='width: 1rem; height: 1rem;' src='${contextPath}/resources/img/star-on.png' alt=''>" +
																		"<span>x" + sList[i].eventScore + "</span>" +
																	"</div>" +
																"</div>";
											if(${nowDate} < sList[i].eventEnd){
															content += "<p id='join' class='text-center float-right' style='margin-top: 5rem;'>티켓 1장</p>" +
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
											
											// 마커 하나를 지도위에 표시합니다 
											addMarker(new kakao.maps.LatLng(sList[i].latitude, sList[i].longitude));
		    				});
		    				content += "<div class='row' id='addBtn'><div class='col-md-12 text-center'><div><button class='btn btn-primary' style='background-color: #00a185; border: none;' onclick='moreSlist()'>더보기</button></div></div></div>"
		    				$(content).appendTo("#searchListArea");
		    			}
		    		} ,
		    		error : function(){
		    			alert("이벤트 목록 조회 ajax 호출 실패");
		    		}
		    	});
		    };
		    
		    function moreSlist(){
		    	$.ajax({
		    		url : "searchEvents",
		    		type : "POST",
		    		data : {"searchKey" : searchKey,
		    				"searchValue" : searchValue,
		    				"currentPage" : currentPage},
		    		dataType : "json",
		    		success : function(sList){
		    			var content = "";
		    			var startDate ="";
		    			currentPage += 1;
		    			
		    			if(sList == ""){
		    				$("#addBtn").remove();
		    			} else{
		    				$("#addBtn").remove();
		    				$.each(sList, function(i){
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
		    					content +=
		    								"<div class='row card shadow my-4' id='searchList'>" +
		    									"<div class='col-md-12 h-100'>" +
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
															"<span>" + sList[i].eventLocation + "</span>" +
															"<p>" + sList[i].eventContent + "</p>" +
														"</div>" +
														"<div class='col-md-3'>" +
															"<div class='p-3'>" +
																"<div>" +
																	"<img style='width: 4rem; height: 4rem; border-radius: 50%;' src='${contextPath}/resources/upProfileImage/"+ sList[i].memberProfile +"' alt=''>" +
																	"<div style='display: inline-block;'>" +
																		"<p class='mb-1'>" + sList[i].memberId + "</p>" +
																		"<img style='width: 1rem; height: 1rem;' src='${contextPath}/resources/img/star-on.png' alt=''>" +
																		"<span>x" + sList[i].eventScore + "</span>" +
																	"</div>" +
																"</div>";
											if(${nowDate} < sList[i].eventEnd){
															content += "<p id='join' class='text-center float-right' style='margin-top: 5rem;'>티켓 1장</p>" +
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
											// 마커 하나를 지도위에 표시합니다 
											addMarker(new kakao.maps.LatLng(sList[i].latitude, sList[i].longitude));
		    				});
		    				content += "<div class='row' id='addBtn'><div class='col-md-12 text-center'><div><button class='btn btn-primary' style='background-color: #00a185; border: none;' onclick='moreSlist()'>더보기</button></div></div></div>"
		    				$(content).appendTo("#searchListArea");
		    			}
		    		} ,
		    		error : function(){
		    			alert("이벤트 목록 더보기 ajax 호출 실패");
		    		}
		    	});
		    };
		    
		    $(function(){ 
		    	searchSlist();
		    });
		</script>
</body>
</html>