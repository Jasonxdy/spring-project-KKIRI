<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="../resources/css/my_profile.css">
  <link rel="stylesheet" href="../resources/css/update_profile.css">
  <!-- services 라이브러리 불러오기 -->
  
  <title>KKIRI(끼리)</title>
</head>

<body>
  <div id="wrapper">
    <jsp:include page="../common/header.jsp"/>
    <div id="container">
      <div class="container">
        <!-- content 시작 -->
        <div class="row">
          <div class="col-2 nav-wrap">
            <a class="btn active" href="../mypage/in">프로필</a>
            <a class="btn" href="#">이벤트</a>
            <a class="btn" href="#">티켓</a>
            <a class="btn" href="../member/logout">로그아웃</a>
          </div>
          

          <div class="col-10">
            
            <div id="update-profile" class="my-profile-section moving-1" >
              <h4>프로필 수정</h4>
              <form action="updateMember" method="post" class="modify-form"  onsubmit="return validate();"  enctype="multipart/form-data"> 
              <div class="row">
                <div class="">
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">닉네임 : </h5>
                    <input id="nickName" type="text" class="update-input memberNickname" name="memberNickname" value="${loginMember.memberNickname}">
                    
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">성별 : </h5>
                    <div>
                    <span class="va_m radio memberGenderWrap">
                      <input type="radio" class="memberGender va_m radio" name="memberGender" value="M" id="male" 
                      
                      <c:if test="${loginMember.memberGender == 'M'}">
                      checked
                      </c:if> >
                    </span>
                    <label for="male" class="va_m radio">남</label>
                    <span class="va_m radio memberGenderWrap">
                      <input type="radio" class="memberGender va_m radio" name="memberGender" id="female" value="F"
                      <c:if test="${loginMember.memberGender == 'F'}">
                      checked
                      </c:if>
                      >
                    </span>                      
                    <label for="female" class="va_m radio">여</label>
                  </div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">생년월일 : </h5>
                    <input type="text" id="birthDay" class="update-input memberBirth" name="birthDay" value="${fn:substring(loginMember.memberBirth,0,4) }년${fn:substring(loginMember.memberBirth,5,7) }월${fn:substring(loginMember.memberBirth,8,10) }일">
                  	<div id="birthDayChecker" style="display : block; backgroundColor:white;"></div>
                  </div>
                  <script type="text/javascript">
                  var distinguisher = /^(1[9]|2[0])[\d]{2}년(0[1-9]|1[0-2])월(0[1-9]|1[0-9]|2[0-9]|3[0-2])일$/ 
                  
                  $(function(){
                	  $("#birthDay").on("input",function(){
                		  console.log(123);
                		  if(!distinguisher.test($("#birthDay").val())){
                			  $("#birthDayChecker").text("xxxx년xx월xx일 형식으로 적어주세요").css("color","red").css("display","block");
                		  }else{
                			  $("#birthDayChecker").text("유효한 형식입니다.").css("color","green").css("display","block");
                		  }
                	  })
                  })
                  
                  
                  </script>
                  
                  <c:set var ="phones" value="${fn:split(loginMember.memberPhone,'-')}"/>
                  
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">전화번호 : </h5>
                    <div>
                    	<select class="update-input memberPhone" name="memberPhone1" id="phone1" >
							<option <c:if test="${phones[0] == '010'}"> selected </c:if>>010</option>
							<option <c:if test="${phones[0] == '011'}"> selected </c:if>>011</option>
							<option <c:if test="${phones[0] == '016'}"> selected </c:if>>016</option>
							<option <c:if test="${phones[0] == '017'}"> selected </c:if>>017</option>
							<option <c:if test="${phones[0] == '019'}"> selected </c:if>>019</option>
						</select>&nbsp; - &nbsp;
                      <input type="number" class="update-input memberPhone"  id="phone2" name="memberPhone2" value="${phones[1]}" maxlength="4" oninput="maxLengthCheck(this)">&nbsp; - &nbsp; 
                      <input type="number" class="update-input memberPhone"  id="phone3" name="memberPhone3" value="${phones[2]}" maxlength="4" oninput="maxLengthCheck(this)">
                      <input type="text" class="update-input memberPhone"  id="memberPhone" name="memberPhone" value="${loginMember.memberPhone}" style="display: none;">
                  </div>
                  </div>
                  
                  <div class="row  my-profile-section-element">
                    <h5 class="col-4">이메일 : </h5>
                    <input type="email" class="update-input memberEmail" name="memberEmail" value="${loginMember.memberEmail }">
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">관심 지역 : </h5>
                    <div id="map" style="width:100%;height:300px;margin:auto"></div>
                    
                    
                    </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 "></h5>
                    <input type="text" name="memberPlace" placeholder="주소 검색" class="interest-location-input col-5"
                    	id="sample5_address" onkeypress="sample5_execDaumPostcode()" value="${loginMember.memberPlace }" readonly>
                  <img src="<%=request.getContextPath() %>/resources/img/search-icon.png" alt="찾기" class="search-icon col-3"
                 		onclick="sample5_execDaumPostcode()" style="width:10%; height:100%;">
                  </div>
                  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=440560a29daf4ebdb30cd5fb2b3b4687&libraries=services"></script>
					<script>
				    // 로그인이 되어 있지 않으면 메인으로 보냄
				    
				    $(function(){
				    	if(${loginMember == null}){
				    		location.href="../mypage/main";	
				    	}
				    })
					
					    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
					        mapOption = {
					            center: new daum.maps.LatLng(37.569285398240084, 126.98739006297323), // 지도의 중심좌표
					            level: 3 // 지도의 확대 레벨
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
					    
					 // 주소로 좌표를 검색합니다
					    geocoder.addressSearch('${loginMember.memberPlace}', function(result, status) {
					    	// 정상적으로 검색이 완료됐으면 
					        if (status === kakao.maps.services.Status.OK) {

					           var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

					           // 결과값으로 받은 위치를 마커로 표시합니다
					           var marker = new kakao.maps.Marker({
					               map: map,
					               position: coords
					           });

					           // 인포윈도우로 장소에 대한 설명을 표시합니다
					           var infowindow = new kakao.maps.InfoWindow({
					               content: '<div style="width:150px;text-align:center;padding:6px 0;">관심장소</div>'
					           });
					           infowindow.open(map, marker);

					           // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					           map.setCenter(coords);
					       } 
					   });        	
				    

					
					    function sample5_execDaumPostcode() {
					        new daum.Postcode({
					            oncomplete: function(data) {
					                var addr = data.address; // 최종 주소 변수
					
					                // 주소 정보를 해당 필드에 넣는다.
					                document.getElementById("sample5_address").value = addr;
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

                  
                  <c:set var="category" value="${fn:split(loginMember.memberCategory,',') }" />
                  	<c:set var = "i" value="0"/>
	                  <div class="row my-profile-section-element">
	                    <h5 class="col-4">관심 카테고리 : </h5>
	                    <div class="interest-wrap col-8">
							<input type="checkbox"  class="interest"  <c:if test="${ category[i]== '여행'}"> checked <c:set var="i" value="${i+1}"/></c:if> name="interest" value="여행" id="travel" ><label for="travel">여행</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '운동'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="운동" id="exercise" ><label for="exercise">운동</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '독서'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="독서" id="book" ><label for="book">독서</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '비즈니스'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="비즈니스" id="business"><label for="business">비즈니스</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '언어'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="언어" id="language"><label for="language">언어</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '음악'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="음악" id="music"><label for="music">음악</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '영화/공연'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="영화/공연" id="movie"><label for="movie">영화/공연</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '댄스'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="댄스" id="dance"><label for="dance">댄스</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '봉사활동'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="봉사활동" id="volunteer"><label for="volunteer">봉사활동</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '사교'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="사교" id="meeting"><label for="meeting">사교</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '차/오토바이'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="차/오토바이" id="car"><label for="car">차/오토바이</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '사진/영상'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="사진/영상" id="picture"><label for="picture">사진/영상</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '스포츠관람'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="스포츠관람" id="watchingSports"><label for="watchingSports">스포츠관람</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '게임'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="게임" id="game"><label for="game">게임</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '요리'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="요리" id="cook"><label for="cook">요리</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '반려동물'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="반려동물" id="pet"><label for="pet">반려동물</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '사회운동'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="사회운동" id="socialMovement"><label for="socialMovement">사회운동</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '뷰티'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="뷰티" id="beauty"><label for="beauty">뷰티</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '패션'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="패션" id="fashion"><label for="fashion">패션</label>
						    <input type="checkbox"  class="interest"  <c:if test="${ category[i]== '기타'}"> checked <c:set var="i" value="${i+1}"/> </c:if> name="interest" value="기타" id="etc"><label for="etc">기타</label>
		                 </div>
	                  </div>
	                  
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">보유한 티켓 수 :</h5>
                    <div class="col-8">${loginMember.memberTicket }개</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4">소개 :  </h5>
                    <textarea class="update-input memberIntroduce" name="memberIntroduce">${loginMember.memberIntroduce}</textarea>
                  </div>
                  
                  <div class="row my-profile-section-element">
                    <h5 class="profile-name col-4">프로필 사진 : </h5>
                    <div class="col-8">
                      <img class="profile-img" src="../resources/upProfileImage/${loginMember.memberProfile}" alt="프로필 사진">
                      <input type="file" class="uploadInput" name="profile" onchange="loadImg(this)" 
                      value="../resources/upProfileImage/${loginMember.memberProfile}"
                      >
                      <button type="button" class="uploadBtn green-radius-btn">사진 변경하기</button>
                    </div>
                  </div>
                </div>
                <button class="btn my-profile-btn">
                  수정하기
                </button>
              </div>
              </form>
            </div>
        </div>
      </div>
    </div>  
    <script>
    
    
      function maxLengthCheck(object) {
        if (object.value.length > object.maxLength) {
          object.value = object.value.slice(0, object.maxLength);
        }
      }
      
      
    var flag = false;
	var phone1 = /^(01[0-9])-[/d]{3,4}-[/d]{4}$/
	var phone = ${loginMember.memberPhone};
      function validate(){
    	  if($("#nickName").val()!=""){
    		if($(".memberGender").val()!=""){
   			  if($(".memberBirth").val()!=""){
   				  if(!distinguisher.test($(".memberBirth").val().trim())){
   					  alert("xxxx년xx월xx일 형식으로 적어주세요")
   					  return false;
   				  }
   				if($(".memberPhone").val()!=""){
   					if(!phone1.test(phone)){
   						console.log("4456");
   					}
   				  if($(".memberEmail").val()!=""){
   					if($(".interest-wrap>input").val()!=""){
   						   console.log("123");
   					 if($(".memberIntroduce").val()!=""){
   						   console.log("456");
   					   if($(".profile-img").src()!=""){
   						   flag = true;
   					   }
   					 }
   					}
   				  }
   				}
   			  }
    		}
    	  }
    	  if(!flag){
    		  alert("페이지를 전부 입력해주시기 바랍니다.")
    	  }
      return flag;
      
      }
      
      $(function(){
        $(".uploadBtn").on({
          "click" : function(){
            $(".uploadInput").click();
          }
        });
        
        $(".memberPhone").change(function(){
        	phone = $("#phone1").val();
        	phone += '-';
        	phone += $("#phone2").val();
        	phone += '-';
        	phone += $("#phone3").val();
        	console.log(phone+"phone");
        	$("#memberPhone").val(phone);
        })
        
      });
      function loadImg(value){
          if(value.files && value.files[0]){
            var reader = new FileReader();
            reader.onload = function(e){
              $(".profile-img").prop("src",e.target.result);
            }
          }
          reader.readAsDataURL(value.files[0]);
      }
      
      $(function(){
    				console.log($(".uploadInput").val());
    	  
    	$(".uploadInput").change(
    			function(){
    				console.log($(".uploadInput").val());
    			})
      })
      
    </script>
  <!-- content 끝 -->
  
  <jsp:include page="../common/footer.jsp"/>
  </div>
</body>

</html>