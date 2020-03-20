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
            <a class="btn active" href="#">프로필</a>
            <a class="btn" href="#">이벤트</a>
            <a class="btn" href="#">티켓</a>
            <a class="btn" href="#">로그아웃</a>
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
                    <input type="text" class="update-input memberBirth" name="birthDay" value="${fn:substring(loginMember.memberBirth,0,4) }년${fn:substring(loginMember.memberBirth,5,7) }월${fn:substring(loginMember.memberBirth,8,10) }일">
                  </div>
                  <c:set var ="phones" value="${fn:split(loginMember.memberPhone,'-')}"/>
                  
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">전화번호 : </h5>
                    <div>
                      <input type="number" class="update-input memberPhone" name="memberPhone1" value="${phones[0]}" maxlength="3" oninput="maxLengthCheck(this)">&nbsp; - &nbsp;
                      <input type="number" class="update-input memberPhone" name="memberPhone2" value="${phones[1]}" maxlength="4" oninput="maxLengthCheck(this)">&nbsp; - &nbsp; 
                      <input type="number" class="update-input memberPhone" name="memberPhone3" value="${phones[2]}" maxlength="4" oninput="maxLengthCheck(this)">
                  </div>
                  </div>
                  
                  <div class="row  my-profile-section-element">
                    <h5 class="col-4">이메일 : </h5>
                    <input type="email" class="update-input memberEmail" name="memberEmail" value="${loginMember.memberEmail }">
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">관심 지역 : </h5>
                    <img src="../resources/img/map-example.png" alt="예시이미지">
                  </div>
                  <c:set var="category" value="${fn:split(loginMember.memberCategory,',') }" />
	                  <c:forEach var="i" items="${category}" >
	                  
	                  <div class="row my-profile-section-element">
	                    <h5 class="col-4">관심 카테고리 : </h5>
	                    <div class="interest-wrap col-8">
							<input type="checkbox"    <c:if test="${ i== '여행'}"> checked</c:if> name="interest" value="여행" id="travel" ><label for="travel">여행</label>
						    <input type="checkbox"    <c:if test="${ i== '운동'}"> checked</c:if> name="interest" value="운동" id="exercise" ><label for="exercise">운동</label>
						    <input type="checkbox"    <c:if test="${ i== '독서'}"> checked</c:if> name="interest" value="독서" id="book" ><label for="book">독서</label>
						    <input type="checkbox"    <c:if test="${ i== '비즈니스'}"> checked</c:if> name="interest" value="비즈니스" id="business"><label for="business">비즈니스</label>
						    <input type="checkbox"    <c:if test="${ i== '언어'}"> checked</c:if> name="interest" value="언어" id="language"><label for="language">언어</label>
						    <input type="checkbox"    <c:if test="${ i== '음악'}"> checked</c:if> name="interest" value="음악" id="music"><label for="music">음악</label>
						    <input type="checkbox"    <c:if test="${ i== '영화/공연'}"> checked</c:if> name="interest" value="영화/공연" id="movie"><label for="movie">영화/공연</label>
						    <input type="checkbox"    <c:if test="${ i== '댄스'}"> checked</c:if> name="interest" value="댄스" id="dance"><label for="dance">댄스</label>
						    <input type="checkbox"    <c:if test="${ i== '봉사활동'}"> checked</c:if> name="interest" value="봉사활동" id="volunteer"><label for="volunteer">봉사활동</label>
						    <input type="checkbox"    <c:if test="${ i== '사교'}"> checked</c:if> name="interest" value="사교" id="meeting"><label for="meeting">사교</label>
						    <input type="checkbox"    <c:if test="${ i== '차/오토바이'}"> checked</c:if> name="interest" value="차/오토바이" id="car"><label for="car">차/오토바이</label>
						    <input type="checkbox"    <c:if test="${ i== '사진/영상'}"> checked</c:if> name="interest" value="사진/영상" id="picture"><label for="picture">사진/영상</label>
						    <input type="checkbox"    <c:if test="${ i== '스포츠관람'}"> checked</c:if> name="interest" value="스포츠관람" id="watchingSports"><label for="watchingSports">스포츠관람</label>
						    <input type="checkbox"    <c:if test="${ i== '게임'}"> checked</c:if> name="interest" value="게임" id="game"><label for="game">게임</label>
						    <input type="checkbox"    <c:if test="${ i== '요리'}"> checked</c:if> name="interest" value="요리" id="cook"><label for="cook">요리</label>
						    <input type="checkbox"    <c:if test="${ i== '반려동물'}"> checked</c:if> name="interest" value="반려동물" id="pet"><label for="pet">반려동물</label>
						    <input type="checkbox"    <c:if test="${ i== '사회운동'}"> checked</c:if> name="interest" value="사회운동" id="socialMovement"><label for="socialMovement">사회운동</label>
						    <input type="checkbox"    <c:if test="${ i== '뷰티'}"> checked</c:if> name="interest" value="뷰티" id="beauty"><label for="beauty">뷰티</label>
						    <input type="checkbox"    <c:if test="${ i== '패션'}"> checked</c:if> name="interest" value="패션" id="fashion"><label for="fashion">패션</label>
						    <input type="checkbox"    <c:if test="${ i== '기타'}"> checked</c:if> name="interest" value="기타" id="etc"><label for="etc">기타</label>
		                 </div>
	                  </div>
	                  </c:forEach>
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
                      <img class="profile-img" src="../resources/img/${loginMember.memberProfile}" alt="프로필 사진">
                      <input type="file" class="uploadInput" name="profile" onchange="loadImg(this)">
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
	var distinguisher = /^(1[9]|2[0])[\d]{2}년(0[1-9]|1[0-2])월(0[1-9]|1[0-9]|2[0-9]|3[0-2])일$/ 
    var flag = false;
      function validate(){
    	  console.log("입장");
    	  if($("#nickName").val()!=""){
    		if($(".memberGender").val()!=""){
   			  if($(".memberBirth").val()!=""){
   				  if(!distinguisher.test($(".memberBirth").val().trim())){
   					  alert("xxxx년xx월xx일 형식으로 적어주세요")
   					  return false;
   				  }
   				if($(".memberPhone").val()!=""){
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
    	  console.log(flag);
      return flag;
      
      }
      
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
              $(".profile-img").prop("src",e.target.result);
            }
          }
          reader.readAsDataURL(value.files[0]);
      }
    </script>
  <!-- content 끝 -->
  
  <jsp:include page="../common/footer.jsp"/>
  </div>
</body>

</html>