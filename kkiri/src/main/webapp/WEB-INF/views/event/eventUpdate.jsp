<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
    <link rel="stylesheet" href="../resources/css/commonEvent.css">
	<title>KKIRI(끼리)</title>
	<style>
	    .map_wrap {position:relative;width:100%;height:400px;}
	    .title {font-weight:bold;display:block;}
	    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
	    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
	    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	</style>
</head>

<body>
  <div id="wrapper">
  
  <fmt:formatDate var="startDate" value="${event.eventStart}"
		pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />
	<fmt:formatDate var="endDate" value="${event.eventEnd}"
		pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />
		
    <jsp:include page="../common/header.jsp"/>
    <div id="container">
      <div class="eventCreate">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h2 class="section-title">이벤트 수정</h2>
              <div class="progress-bar-wrap">
                <p class="progress-bar-percent"></p>
              </div>
              <form class="eventCreateForm" action="updateEvent?no=${event.eventNo}" method="post" enctype="multipart/form-data" role="form" onsubmit="return validate();">
                <div class="step1 select-location step">
                  <h3 class="eventCreateTitle step-1-title">1단계. 이벤트를 진행할 지역을 수정해 주세요.</h3>
                  <!-- 다음 지도창 -->
                  <div class="map_wrap">
				    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				    <div class="hAddr">
				        <span class="title">지도중심기준 주소정보</span>
				        <span id="centerAddr"></span>
				    </div>
				  </div>
                  <br>
                   <!-- 다음 지도창 끝-->
                  <div class="input-location-wrap">
                    <input type="text" name="eventAddress" placeholder="주소 검색" id="eventAddress" readonly value="${event.eventAddress}">
                    <input type="hidden" name="latitude" id="latitude" value="${event.latitude}">
                    <input type="hidden" name="longtitude" id="longtitude" value="${event.longtitude}">
                  </div>

                  <label for="eventLocation" class="eventLocation-label">참가자들이 장소를 더 찾기 쉽게 명칭을 적어주세요.</label>
                  <input type="text" name="eventLocation" class="locationInput" id="eventLocation" placeholder="모이는 장소 입력" value="${event.eventLocation}">
                  
                  <button type="button" class="go-main green-radius-btn" onclick="history.back();">이전으로</button>
                  <button type="button" class="go-step2 green-radius-btn">2단계로</button>
                </div>
                <div class="step2 select-category step">
                  <h3 class="eventCreateTitle">2단계. 이벤트의 연관 카테고리를 수정해주세요.</h3>
                   <p class="sub-title">
              		회원님께서 주최하실 이벤트의 연관 카테고리를 수정해주세요. <br>
                    (카테고리는 한개만 선택 가능합니다.)
                  </p>
                  <div class="category-wrap">
                    <input type="radio" name="eventCategory" value="여행" id="travel"><label for="travel">여행</label>
                    <input type="radio" name="eventCategory" value="운동" id="exercise"><label for="exercise">운동</label>
                    <input type="radio" name="eventCategory" value="독서" id="book"><label for="book">독서</label>
                    <input type="radio" name="eventCategory" value="비즈니스" id="business"><label for="business">비즈니스</label>
                    <input type="radio" name="eventCategory" value="언어" id="language"><label for="language">언어</label>
                    <input type="radio" name="eventCategory" value="음악" id="music"><label for="music">음악</label>
                    <input type="radio" name="eventCategory" value="영화/공연" id="movie"><label for="movie">영화/공연</label>
                    <input type="radio" name="eventCategory" value="댄스" id="dance"><label for="dance">댄스</label>
                    <input type="radio" name="eventCategory" value="봉사활동" id="volunteer"><label for="volunteer">봉사활동</label>
                    <input type="radio" name="eventCategory" value="사교" id="meeting"><label for="meeting">사교</label>
                    <input type="radio" name="eventCategory" value="차/오토바이" id="car"><label for="car">차/오토바이</label>
                    <input type="radio" name="eventCategory" value="사진/영상" id="picture"><label for="picture">사진/영상</label>
                    <input type="radio" name="eventCategory" value="스포츠관람" id="watchingSports"><label for="watchingSports">스포츠관람</label>
                    <input type="radio" name="eventCategory" value="게임" id="game"><label for="game">게임</label>
                    <input type="radio" name="eventCategory" value="요리" id="cook"><label for="cook">요리</label>
                    <input type="radio" name="eventCategory" value="반려동물" id="pet"><label for="pet">반려동물</label>
                    <input type="radio" name="eventCategory" value="사회운동" id="socialMovement"><label for="socialMovement">사회운동</label>
                    <input type="radio" name="eventCategory" value="뷰티" id="beauty"><label for="beauty">뷰티</label>
                    <input type="radio" name="eventCategory" value="패션" id="fashion"><label for="fashion">패션</label>
                    <input type="radio" name="eventCategory" value="기타" id="etc"><label for="etc">기타</label>
                  </div>
                  <button type="button" class="go-step1 green-radius-btn">1단계로</button>
                  <button type="button" class="go-step3 green-radius-btn">3단계로</button>
                </div>
                <div class="step3 input-info step">
                    <h3 class="eventCreateTitle">
                      3단계. 이벤트의 상세 정보를 수정해주세요.
                    </h3>
                    <p class="sub-title">
                      (이벤트 시간, 티켓 수, 정원은 수정 불가능합니다.)
                    </p>
                    <div class="insert-event-info">
                      <label class="event-thumbnail-label">이벤트 썸네일 사진</label>
                      <input type="file" class="uploadInput" name="thumbnailImg" onchange="loadImg(this)">
                      <div class="uploadImgWrap">
                        <img class="uploadImg" src="${contextPath}/resources/upEventThumbnail/${event.eventThumbnail}">
                        <button type="button" class="uploadBtn">사진 업로드</button>
                      </div><br>
                      <label for="eventTitle">이벤트 제목</label>
                      <input type="text" name="eventTitle" id="eventTitle" value="${event.eventTitle}"><br>
                      <label for="eventIntroduce" class="eventIntroduceTitle">이벤트 소개내용</label>
                      <textarea name="eventContent" id="eventIntroduce" rows="8" cols="80" placeholder="내용을 입력해주세요.">${event.eventContent}</textarea><br>
                      <label for="startDate">이벤트 시작 시간</label>
                      <input type="text" name="startDate" id="startDate" value="${startDate}" disabled><br>
                      <label for="endDate">이벤트 종료 시간</label>
                      <input type="text" name="endDate" id="endDate" value="${endDate}" disabled><br>
                      <label for="ticket">참가 티켓 수</label>
                      <input type="number" name="eventTicket" id="ticket" value="${event.eventTicket}" disabled><br>
                      <label for="boundary">이벤트 정원</label>
                      <input type="number" name="eventQuota" id="boundary" min="2" value="${event.eventQuota}" disabled><br>

                      
                      <button type="button" class="go-step2 green-radius-btn mt-4">2단계로</button>
                      <button class="go-step4 green-radius-btn mt-4">이벤트 수정 완료</button>
                    </div>
                  </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
	
    <!-- 이벤트생성 관련 스크립트 -->
    <script>
      $(function() {
    	  // Enter키 비활성화
    	  $("input").keydown(function() {
    		  if (event.keyCode === 13) {
    		    event.preventDefault();
    		  };
    		});
    	  
    	  /* 이벤트 종료 시간이 이벤트 시작 시간보다 무조건 느리게 작성해야하는 스크립트 */
    	  $("#eventEnd, #eventStart").on({
    		  change : function(){
    			  
    			  var eventStart = $("#eventStart").val();
	   			  eventStart = eventStart.replace(/\-/g,'');
	   			  eventStart = eventStart.replace(/\T/g,'');
	   			  eventStart = eventStart.replace(/\:/g,'');
	   			  
	   			  var eventEnd = $("#eventEnd").val();
		   		  eventEnd = eventEnd.replace(/\-/g,'');
		   	      eventEnd = eventEnd.replace(/\T/g,'');
		   		  eventEnd = eventEnd.replace(/\:/g,'');
				
    			  if($("#eventEnd").val()!="" && $("#eventStart").val()!=""){
    		   		  if(eventStart > eventEnd){
    		   			alert("이벤트 종료 시간은 시작 시간보다 이후이어야 합니다!");
    		   			$("#eventEnd").val("");
    		   		  }
    			  }
    		  }
    	  });
    	  
    	  
        $(".go-step1").on({
          click: function() {
            $(".progress-bar-percent").css({
              "width": "25%"
            });
            $(".step").stop().fadeOut(300);
            $(".step1").delay(300).fadeIn(300);
          }
        });
        $(".go-step2").on({
          click: function() {
            if($("#eventAddress").val().trim()==""){
            	alert("이벤트를 진행할 지역을 지정해주세요!");
            	$("#eventAddress").focus();
            	return false;
            }else if($("#eventLocation").val().trim()==""){
            	alert("장소의 명칭을 작성해주세요!");
            	$("#eventLocation").focus();
            	return false;
            }else{
	            $(".progress-bar-percent").css({
	              "width": "50%"
	            });
	            $(".step").stop().fadeOut(300);
	            $(".step2").delay(300).fadeIn(300);
            }
          }
        });
        $(".go-step3").on({
            click : function(){
              if($(".category-wrap>input[name=eventCategory]:checked").length == 0){
                alert("카테고리를 선택해주세요!");
                return false;
              }else{
                $(".progress-bar-percent").css({"width" : "75%"});
                $(".step").stop().fadeOut(300);
                $(".step3").delay(300).fadeIn(300);
              }
            }
          });
        
        // 기존에 선택한 카테고리 출력 
		var category = "${event.eventCategory}";       
		
		if(category != "null"){
			$(".category-wrap>input").each(function(){
				if($(this).val() == category){
					$(this).prop("checked","true");					
				}
			});
		}
		
      });
      
      function validate(){
		  /* if($(".uploadInput").val()==""){
    		  alert("이벤트 썸네일 사진을 등록해주세요!");
    		  return false;
    	  }else  */
    	  if($("#eventTitle").val().trim()==""){
    		  alert("이벤트 제목을 작성해주세요!");
    		  return false;
    	  }else if($("#eventContent").val().trim()==""){
    		  alert("이벤트 내용을 작성해주세요!");
    		  return false;
    	  }else if($("#eventStart").val()==""){
    		  alert("이벤트 시작시간을 입력해주세요!");
    		  return false;
    	  }else if($("#eventEnd").val()==""){
    		  alert("이벤트 종료시간을 입력해주세요!");
    		  return false;
    	  }else if($("#ticket").val().trim()==""){
    		  alert("참가 티켓 수를 입력해주세요!");
    		  return false;
    	  }else if($("#eventQuota").val().trim()==""){
    		  alert("이벤트 정원 수를 입력해주세요!");
    		  return false;
    	  }else{
    		  return true;
    	  }
    	  
      }
      // 전화번호 자릿수 제한
      function maxLengthCheck(object) {
        if (object.value.length > object.maxLength) {
          object.value = object.value.slice(0, object.maxLength);
        }
      }

      // 3단계. 프로필 업로드 버튼 클릭시 이벤트
      $(function(){
        $(".uploadBtn").on({
          "click" : function(){
            $(".uploadInput").click();
          }
        });
      });
      function loadImg(value){
          if(value.files && value.files[0]){
            var reader = new FileReader();
            reader.onload = function(e){
              $(".uploadImg").prop("src",e.target.result);
            }
          }
          reader.readAsDataURL(value.files[0]);
      }
    </script>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=113a0beb55aa56aa1fd5776ff4bb068c&libraries=services,clusterer,drawing"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(${event.latitude}, ${event.longtitude}), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
		
		// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		
		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			marker2.setMap(null);
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		    	
		        if (status === kakao.maps.services.Status.OK) {
		        	
		            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            
		            var content = '<div class="bAddr">' +
		                            '<span class="title">주소정보</span>' + 
		                            detailAddr + 
		                        '</div>';
		
		            // 마커를 클릭한 위치에 표시합니다 
		            marker.setPosition(mouseEvent.latLng);
		            marker.setMap(map);
		
		            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
		            infowindow.setContent(content);
		            infowindow.open(map, marker);
		        
		        document.getElementById("eventAddress").value = result[0].address.address_name;
		       
		        }   
		    });
		});
		
		// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
		    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});
		
		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);      
		}
		
		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		    
		    document.getElementById("latitude").value = coords.getLat();
	        document.getElementById("longtitude").value =  coords.getLng();
		}
		
		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        var infoDiv = document.getElementById('centerAddr');
		
		        for(var i = 0; i < result.length; i++) {
		            // 행정동의 region_type 값은 'H' 이므로
		            if (result[i].region_type === 'H') {
		                infoDiv.innerHTML = result[i].address_name;
		                break;
		            }
		        }
		    }    
		}
		$(function(){
			markerPosition  = new kakao.maps.LatLng(${event.latitude}, ${event.longtitude});
			// 마커를 생성합니다
			marker2 = new kakao.maps.Marker({
			    position: markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker2.setMap(map);
			
			// 기존 지도의 상세주소를 표시해줍니다.
            var detailAddr = '<div>지번 주소 : ${event.eventAddress} </div>';
            
            var content = '<div class="bAddr newPosition">' +
                            '<span class="title">주소정보</span>' + 
                            detailAddr + 
                        '</div>';
            
            infowindow.setContent(content);
            infowindow.open(map, marker2);
            
		});
			
	</script>
	
	<jsp:include page="../common/footer.jsp"/>
	
</body>

</html>

