<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
    <link rel="stylesheet" href="../resources/css/commonEvent.css">
	<title>KKIRI(끼리)</title>
</head>

<body>
  <div id="wrapper">
    <jsp:include page="../common/header.jsp"/>
    <div id="container">
      <div class="eventCreate">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h2 class="section-title">이벤트 생성</h2>
              <div class="progress-bar-wrap">
                <p class="progress-bar-percent"></p>
              </div>
              <form class="eventCreateForm" action="#" method="post" enctype="multipart/form-data" role="form" onsubmit="return validate();">
                <div class="step1 select-location step">
                  <h3 class="eventCreateTitle step-1-title">1단계. 이벤트를 진행할 지역을 지정해 주세요.</h3>
                  <!-- 다음 지도창 -->
                  <div id="map"></div>
                  <br>
                   <!-- 다음 지도창 끝-->
                  <div class="input-location-wrap">
                  	<img src="${contextPath}/resources/img/search-icon.png" alt="찾기" class="search-icon" onclick="map_api()" >
                    <input type="text" name="memberLocation" placeholder="주소 검색" id="memberLocation" onclick="map_api()" readonly>
                  </div>

                  <label for="eventLocation" class="eventLocation-label">참가자들이 장소를 더 찾기 쉽게 명칭을 적어주세요.(선택사항)</label>
                  <input type="text" name="eventLocation" class="locationInput" id="eventLocation" placeholder="모이는 장소 입력">
                  
                  <button type="button" class="go-main green-radius-btn" onclick="history.back();">이전으로</button>
                  <button type="button" class="go-step2 green-radius-btn">2단계로</button>
                </div>
                <div class="step2 select-category step">
                  <h3 class="eventCreateTitle">2단계. 이벤트의 연관 카테고리를 선택해주세요.</h3>
                  <p class="sub-title">
                    회원님께서 주최하실 이벤트의 연관 카테고리를 선택해주세요. 더 활발한 모임이 되는데에 도움이 될거에요.<br>
                    (카테고리는 한개만 선택 가능합니다.)
                  </p>
                  <div class="category-wrap">
                    <input type="radio" name="memberInterest" value="travel" id="travel"><label for="travel">여행</label>
                    <input type="radio" name="memberInterest" value="exercise" id="exercise"><label for="exercise">운동</label>
                    <input type="radio" name="memberInterest" value="book" id="book"><label for="book">독서</label>
                    <input type="radio" name="memberInterest" value="business" id="business"><label for="business">비즈니스</label>
                    <input type="radio" name="memberInterest" value="language" id="language"><label for="language">언어</label>
                    <input type="radio" name="memberInterest" value="music" id="music"><label for="music">음악</label>
                    <input type="radio" name="memberInterest" value="movie" id="movie"><label for="movie">영화/공연</label>
                    <input type="radio" name="memberInterest" value="dance" id="dance"><label for="dance">댄스</label>
                    <input type="radio" name="memberInterest" value="volunteer" id="volunteer"><label for="volunteer">봉사활동</label>
                    <input type="radio" name="memberInterest" value="meeting" id="meeting"><label for="meeting">사교</label>
                    <input type="radio" name="memberInterest" value="car" id="car"><label for="car">차/오토바이</label>
                    <input type="radio" name="memberInterest" value="picture" id="picture"><label for="picture">사진/영상</label>
                    <input type="radio" name="memberInterest" value="watchingSports" id="watchingSports"><label for="watchingSports">스포츠관람</label>
                    <input type="radio" name="memberInterest" value="game" id="game"><label for="game">게임</label>
                    <input type="radio" name="memberInterest" value="cook" id="cook"><label for="cook">요리</label>
                    <input type="radio" name="memberInterest" value="pet" id="pet"><label for="pet">반려동물</label>
                    <input type="radio" name="memberInterest" value="socialMovement" id="socialMovement"><label for="socialMovement">사회운동</label>
                    <input type="radio" name="memberInterest" value="beauty" id="beauty"><label for="beauty">뷰티</label>
                    <input type="radio" name="memberInterest" value="fashion" id="fashion"><label for="fashion">패션</label>
                    <input type="radio" name="memberInterest" value="etc" id="etc"><label for="etc">기타</label>
                  </div>
                  <button type="button" class="go-step1 green-radius-btn">1단계로</button>
                  <button type="button" class="go-step3 green-radius-btn">3단계로</button>
                </div>
                <div class="step3 input-info step">
                    <h3 class="eventCreateTitle">3단계. 이벤트의 상세 정보를 입력해주세요.</h3>
                      <p class="sub-title">
                      	상세 정보는 모두 필수 입력사항입니다.
                 	  </p>
                    <div class="insert-event-info">
                      <label class="event-thumbnail-label">이벤트 썸네일 사진</label>
                      <input type="file" class="uploadInput" name="eventProfile" onchange="loadImg(this)">
                      <div class="uploadImgWrap">
                        <img class="uploadImg">
                        <button type="button" class="uploadBtn">사진 업로드</button>
                      </div><br>
                      <label for="eventTitle">이벤트 제목</label>
                      <input type="text" name="eventTitle" id="eventTitle"><br>
                      <label for="eventIntroduce" class="eventIntroduceTitle">이벤트 소개내용</label>
                      <textarea name="eventIntroduce" id="eventIntroduce" rows="8" cols="80" placeholder="내용을 입력해주세요."></textarea><br>
                      <label for="startDate">이벤트 시작 시간</label>
                      <input type="datetime-local" name="startDate" id="startDate"><br>
                      <label for="endDate">이벤트 종료 시간</label>
                      <input type="datetime-local" name="endDate" id="endDate"><br>
                      <label for="ticket">참가 티켓 수</label>
                      <input type="number" name="eventTicket" id="ticket"><br>
                      <label for="boundary">이벤트 정원</label>
                      <input type="number" name="boundary" id="boundary" min="2"><br>

                      
                      <button type="button" class="go-step2 green-radius-btn mt-4">2단계로</button>
                      <button class="go-step4 green-radius-btn mt-4">이벤트 생성</button>
                    </div>
                  </div>
                  <div class="step4 signUp-complete step">
                    <h3 class="eventCreateTitle">이벤트 생성이 완료되었습니다!</h3>
                    <p class="sub-title">이제 참가자들을 모아 이벤트를 함께 즐기세요.</p>

                    <button type="button" class="green-radius-btn mt-4">이벤트 상세 페이지로</button>
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
    	  /* 이벤트 종료 시간이 이벤트 시작 시간보다 무조건 느리게 작성해야하는 스크립트 */
    	  $("#endDate, #startDate").on({
    		  change : function(){
    			  if($("#endDate").val()!="" && $("#startDate").val()!=""){
    				  var startDate = $("#startDate").val();
    	   			  startDate = startDate.replace(/\-/g,'');
    	   			  startDate = startDate.replace(/\T/g,'');
    	   			  startDate = startDate.replace(/\:/g,'');
    	   			  
    	   			  var endDate = $("#endDate").val();
    		   		  endDate = endDate.replace(/\-/g,'');
    		   	      endDate = endDate.replace(/\T/g,'');
    		   		  endDate = endDate.replace(/\:/g,'');
    		   		  
    		   		  if(startDate > endDate){
    		   			alert("이벤트 종료 시간은 시작 시간보다 이후이어야 합니다!");
    		   			$("#endDate").val("");
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
            if($("#memberLocation").val().trim()==""){
            	alert("이벤트를 진행할 지역을 지정해주세요!");
            	$("#memberLocation").focus();
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
              if($(".category-wrap>input[name=memberInterest]:checked").length == 0){
                alert("카테고리를 선택해주세요!");
                return false;
              }else{
                $(".progress-bar-percent").css({"width" : "75%"});
                $(".step").stop().fadeOut(300);
                $(".step3").delay(300).fadeIn(300);
              }
            }
          });
        
        
      /*   $(".go-step4").on({
          click : function(){
        	
            $(".progress-bar-percent").css({"width" : "100%"});
            $(".step").stop().fadeOut(300);
            $(".step4").delay(300).fadeIn(300);
          }
        }); */
      });
      
      function validate(){
    	  if($(".uploadInput").val()==""){
    		  alert("이벤트 썸네일 사진을 등록해주세요!");
    		  return false;
    	  }else if($("#eventTitle").val().trim()==""){
    		  alert("이벤트 제목을 작성해주세요!");
    		  return false;
    	  }else if($("#eventIntroduce").val().trim()==""){
    		  alert("이벤트 내용을 작성해주세요!");
    		  return false;
    	  }else if($("#startDate").val()==""){
    		  alert("이벤트 시작시간을 입력해주세요!");
    		  return false;
    	  }else if($("#endDate").val()==""){
    		  alert("이벤트 종료시간을 입력해주세요!");
    		  return false;
    	  }else if($("#ticket").val().trim()==""){
    		  alert("참가 티켓 수를 입력해주세요!");
    		  return false;
    	  }else if($("#boundary").val().trim()==""){
    		  alert("이벤트 정원 수를 입력해주세요!");
    		  return false;
    	  }else{
    		  var 
    		  $.ajax({
    			 "url" : "createEvent",
    			 "type" : "post",
    			 "data" : 
    		  });
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
    
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=440560a29daf4ebdb30cd5fb2b3b4687&libraries=services"></script>
	
	<script>
	    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	        mapOption = {
	            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
	            level: 5 // 지도의 확대 레벨
	        };
	
	    //지도를 미리 생성
	    var map = new daum.maps.Map(mapContainer, mapOption);
	    //주소-좌표 변환 객체를 생성
	    var geocoder = new daum.maps.services.Geocoder();
	    //마커를 미리 생성
	    var marker = new daum.maps.Marker({
	        position: new daum.maps.LatLng(37.537187, 127.005476),
	        map: map
	    });
	
	
	    function map_api() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                var addr = data.address; // 최종 주소 변수
	
	                // 주소 정보를 해당 필드에 넣는다.
	                document.getElementById("memberLocation").value = addr;
	                // 주소로 상세 정보를 검색
	                geocoder.addressSearch(data.address, function(results, status) {
	                    // 정상적으로 검색이 완료됐으면
	                    if (status === daum.maps.services.Status.OK) {
	
	                        var result = results[0]; //첫번째 결과의 값을 활용
	
	                        // 해당 주소에 대한 좌표를 받아서
	                        var coords = new daum.maps.LatLng(result.y, result.x);
	                        // 지도를 보여준다.
	                        mapContainer.style.display = "block";
	                        map.relayout();
	                        // 지도 중심을 변경한다.
	                        map.setCenter(coords);
	                        // 마커를 결과값으로 받은 위치로 옮긴다.
	                        marker.setPosition(coords)
	                    }
	                });
	            }
	        }).open();
	    }
	</script>
	<!-- 다음 지도 API  스크립트 끝~~~ -->
	
	<jsp:include page="../common/footer.jsp"/>
	
</body>

</html>

