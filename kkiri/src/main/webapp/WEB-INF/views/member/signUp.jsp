<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.5/js/swiper.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js" crossorigin="anonymous"></script>

  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/signUp.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/header.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/footer.css">
  <title>KKIRI(끼리)</title>
</head>

<body>
<jsp:include page="../common/header.jsp"/>
  
 <!--  <div id="wrapper">
    <div id="header">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h1 class="logo"><a href="#"><img src="img/logo.png" alt="로고"></a></h1>
            <div class="nav-section">
              <a href="#" class="login-btn">로그인</a>
              <a href="signUp.html">회원가입</a>
              <span class="separation"> | </span>
              <a href="#">고객센터</a>
              <div class="nav-item dropdown">
                      <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                      <div class="dropdown-menu" aria-labelledby="dropdown01">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                      </div>
                  </div>
            </div>
          </div>
        </div>
      </div>
    </div> -->
    
    <!-- 로그인 팝업 start-->
    <div id="login-popup" class="popup">
      <p class="popup-title">
        로그인
        <img src="img/close-btn.png" alt="닫기버튼" class="close-popup">
      </p>
      <div class="popup-content">
        <p class="sign-up-title">아직 회원이 아니신가요?&nbsp;<a href="signUp.html" class="link sign-up-link">회원가입</a></p>
        <form class="login-form-wrap custom-checkbox" action="#" method="post">
          <input type="text" name="memberId" placeholder="아이디를 입력해주세요." autocomplete="off">
          <input type="password" name="memberPwd" placeholder="비밀번호를 입력해주세요.">

          <input type="checkbox" class="custom-control-input" name="rememberId" id="rememberId">
          <label class="custom-control-label" for="rememberId">아이디 저장</label>
          <a href="#" class="link find-info-link">아이디 혹은 비밀번호를 잊으셨나요?</a>

          <button class="popup-confirm-btn login-conform-btn">로그인</button>
          <button class="popup-confirm-btn another-btn">구글 아이디로 로그인</button>
          <button class="popup-confirm-btn another-btn">페이스북 아이디로 로그인</button>
        </form>
      </div>
    </div>
    <div class="popup-shadow"></div>
    <!-- 로그인 팝업 end-->

    <script>
      // 로그인 팝업 이벤트
      $(".login-btn").on({
        click: function() {
          $(".popup-shadow, #login-popup").show(0);
        }
      });
      $(".close-popup, .popup-shadow").on({
        click: function() {
          $(".popup-shadow, #login-popup").hide(0);
        }
      });
    </script>
    <div id="container">
      <div class="signUp">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h2 class="section-title">회원가입</h2>
              <div class="progress-bar-wrap">
                <p class="progress-bar-percent"></p>
              </div>
              <form class="signUpForm" action="#" method="post">
                <div class="step1 select-location step">
                  <h3 class="signUpTitle">1단계. 회원님의 관심 지역을 선택해주세요</h3>
                  <p class="sub-title">선택하신 관심 지역을 기반으로 이벤트를 추천해드리고, 다른 회원님과 연결해드립니다.</p>
                  <img src="<%=request.getContextPath() %>/resources/img/map-example.png" alt="지도" class="map-example">
                  <div class="input-location-wrap">
                    <img src="<%=request.getContextPath() %>/resources/img/search-icon.png" alt="찾기" class="search-icon">
                    <input type="text" name="memberLocation" placeholder="주소 검색" class="interest-location-input">
                  </div>
                  <input class="locationResult" type="text" name="locationResult" value="서울시 동대문구" readonly class="interest-location-input-result">

                  <button type="button" class="go-main green-radius-btn" onclick="location.href='index.html'">메인으로</button>
                  <button type="button" class="go-step2 green-radius-btn">2단계로</button>
                </div>
                <div class="step2 select-interest step">
                  <h3 class="signUpTitle">2단계. 회원님의 관심사를 선택해주세요</h3>
                  <p class="sub-title">선택하신 관심사를 기반으로 이벤트를 추천해드리고, 관심사가 비슷한 회원님들과 더욱 편하게 만날 수 있습니다.</p>
                  <div class="interest-wrap">
                    <input type="checkbox" name="memberInterest" value="travel" id="travel"><label for="travel">여행</label>
                    <input type="checkbox" name="memberInterest" value="exercise" id="exercise"><label for="exercise">운동</label>
                    <input type="checkbox" name="memberInterest" value="book" id="book"><label for="book">독서</label>
                    <input type="checkbox" name="memberInterest" value="business" id="business"><label for="business">비즈니스</label>
                    <input type="checkbox" name="memberInterest" value="language" id="language"><label for="language">언어</label>
                    <input type="checkbox" name="memberInterest" value="music" id="music"><label for="music">음악</label>
                    <input type="checkbox" name="memberInterest" value="movie" id="movie"><label for="movie">영화/공연</label>
                    <input type="checkbox" name="memberInterest" value="dance" id="dance"><label for="dance">댄스</label>
                    <input type="checkbox" name="memberInterest" value="volunteer" id="volunteer"><label for="volunteer">봉사활동</label>
                    <input type="checkbox" name="memberInterest" value="meeting" id="meeting"><label for="meeting">사교</label>
                    <input type="checkbox" name="memberInterest" value="car" id="car"><label for="car">차/오토바이</label>
                    <input type="checkbox" name="memberInterest" value="picture" id="picture"><label for="picture">사진/영상</label>
                    <input type="checkbox" name="memberInterest" value="watchingSports" id="watchingSports"><label for="watchingSports">스포츠관람</label>
                    <input type="checkbox" name="memberInterest" value="game" id="game"><label for="game">게임</label>
                    <input type="checkbox" name="memberInterest" value="cook" id="cook"><label for="cook">요리</label>
                    <input type="checkbox" name="memberInterest" value="pet" id="pet"><label for="pet">반려동물</label>
                    <input type="checkbox" name="memberInterest" value="socialMovement" id="socialMovement"><label for="socialMovement">사회운동</label>
                    <input type="checkbox" name="memberInterest" value="beauty" id="beauty"><label for="beauty">뷰티</label>
                    <input type="checkbox" name="memberInterest" value="fashion" id="fashion"><label for="fashion">패션</label>
                    <input type="checkbox" name="memberInterest" value="etc" id="etc"><label for="etc">기타</label>
                  </div>
                  <button type="button" class="go-step1 green-radius-btn">1단계로</button>
                  <button type="button" class="go-step3 green-radius-btn">3단계로</button>
                </div>
                <div class="step3 input-info step">
                    <h3 class="signUpTitle">3단계. 회원님의 정보를 입력해주세요.</h3>
                    <p class="sub-title"><strong class='require'>필수</strong>표시는 필수적으로 입력하셔야 합니다.</p>
                    <div class="insert-member-info">
                      <label><strong class='require'>필수</strong>&nbsp;프로필 사진</label>
                      <input type="file" class="uploadInput" name="memberProfile" onchange="loadImg(this)">
                      <div class="uploadImgWrap">
                        <img class="uploadImg">
                        <button type="button" class="uploadBtn">사진 업로드</button>
                      </div><br>
                      <label for="memberId"><strong class='require'>필수</strong>&nbsp;아이디</label>
                      <input type="text" name="memberId" id="memberId"><br>
                      <label for="memberPwd"><strong class='require'>필수</strong>&nbsp;비밀번호</label>
                      <input type="password" name="memberPwd" id="memberPwd"><br>
                      <label for="memberPwd2"><strong class='require'>필수</strong>&nbsp;비밀번호 확인</label>
                      <input type="password" name="memberPwd2" id="memberPwd2"><br>
                      <label for="memberNickname"><strong class='require'>필수</strong>&nbsp;닉네임</label>
                      <input type="text" name="memberNickname" id="memberNickname"><br>
                      <p><strong class='require'>필수</strong>&nbsp;전화번호</p>
                      <input type="number" class="memberPhone" name="memberPhone1" maxlength="3" oninput="maxLengthCheck(this)">-
                      <input type="number" class="memberPhone" name="memberPhone2" maxlength="4" oninput="maxLengthCheck(this)">-
                      <input type="number" class="memberPhone" name="memberPhone3" maxlength="4" oninput="maxLengthCheck(this)"><br>
                      <label for="memberEmail"><strong class='require'>필수</strong>&nbsp;이메일</label>
                      <input type="email" name="memberEmail" id="memberEmail"><br>
                      <label for="memberBirth"><strong class='require'>필수</strong>&nbsp;생년월일</label>
                      <input type="date" name="memberBirth" id="memberBirth"><br>
                      <p><strong class='require'>필수</strong>&nbsp;성별</p>
                      <label for="male" class="gender-label"><input type="radio" name="memberGender" value="male" id="male">남자</label>
                      <label for="female" class="gender-label"><input type="radio" name="memberGender" value="female" id="female">여자</label><br>
                      <p>본인 계좌번호</p>
                      <select name="memberBankName">
                        <option value="none">은행선택</option>
                        <option value="sinhan">신한은행</option>
                        <option value="kookmin">국민은행</option>
                        <option value="woori">우리은행</option>
                        <option value="hana">하나은행</option>
                      </select>
                      <input type="number" class="memberBankNumber" name="memberBankNumber" placeholder="계좌번호입력('-' 없이 입력해주세요.)"><br>
                      <label for="memberIntroduce" class="memberIntroduceTitle">자기소개</label>
                      <textarea name="memberIntroduce" id="memberIntroduce" rows="8" cols="80" placeholder="내용을 입력해주세요."></textarea><br>
                      <button type="button" class="go-step2 green-radius-btn mt-4">2단계로</button>
                      <button type="button" class="go-step4 green-radius-btn mt-4">회원가입</button>
                    </div>
                  </div>
                  <div class="step4 signUp-complete step">
                    <h3 class="signUpTitle">회원가입 성공!</h3>
                    <p class="sub-title">KKIRI의 회원이 되신 것을 환영합니다.</p>

                    <button type="button" class="green-radius-btn mt-4" onclick="location.href='index.html'">메인으로</button>
                  </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- 회원가입 관련 스크립트 -->
    <script>
      $(function() {
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
            if($(".interest-location-input").val().trim() == ""){
              alert("관심지역을 먼저 설정해주세요!");
              return false;
            }else{
              $(".progress-bar-percent").css({"width": "50%"});
              $(".step").stop().fadeOut(300);
              $(".step2").delay(300).fadeIn(300);
            }
          }
        });
        $(".go-step3").on({
          click : function(){
            if($(".interest-wrap>input[name=memberInterest]:checked").length == 0){
              alert("적어도 한개 이상의 관심사를 선택해주세요!");
              return false;
            }else{
              $(".progress-bar-percent").css({"width" : "75%"});
              $(".step").stop().fadeOut(300);
              $(".step3").delay(300).fadeIn(300);
            }
          }
        });
        $(".go-step4").on({
          click : function(){
            $(".progress-bar-percent").css({"width" : "100%"});
            $(".step").stop().fadeOut(300);
            $(".step4").delay(300).fadeIn(300);
          }
        });
      });
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

  <!--   <div id="footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="row">
              <div class="col-md-4 footer-logo-wrap">
                <img class="footer-logo" src="img/logo2-white.png" alt="푸터로고">
              </div>
              <div class="col-md-8">
                <p class="copyright">&copy; 2020 KKIRI COMPANY. ALL RIGHTS RESERVED.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div> -->
    
    
    <div id="button-top">
      <button type="button" class="top-btn">TOP</button>
    </div>
	
	<jsp:include page="../common/footer.jsp"/>
	
    <script>
      function scrollFunction() {
        if ($(window).scrollTop() >= 200) {
          $('#button-top').show(0);
        } else {
          $('#button-top').hide(0);
        }
      }
      $(function() {
        scrollFunction();
        $(window).scroll(function() {
          scrollFunction();
        });
        $('#button-top').on({
          click: function() {
            $('html,body').stop().animate({
              scrollTop: 0
            }, 600);
          }
        });
      });
    </script>


</body>

</html>
