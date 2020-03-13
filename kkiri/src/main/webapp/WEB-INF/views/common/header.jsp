<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.5/js/swiper.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/header.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/index.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/header.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/board.css">
</head>
<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" scope="application"/>
	<div id="header">
          <div class="container">
          	<div class="row">
          		<div class="col-md-12">
                <h1 class="logo"><a href="#"><img src="<%=request.getContextPath() %>/resources/img/logo.png" alt="로고"></a></h1>
                <div class="nav-section">
                  <a href="#" class="login-btn">로그인</a>
                  <a href="signUp.html">회원가입</a>
                  <a href="${pageContext.servletContext.contextPath}/search/searchEvent">탐색</a>
                  <!--  -->
                  <%-- <a href="eventCreate.html" class="createEvent-btn">이벤트 생성하기</a>
                  <span class="separation"> | </span>
                  <a href="#">고객센터</a>
                  <div class="profile-wrap">
                    <img src="<%=request.getContextPath() %>/resources/img/profile-ex.png" alt="프로필" class="profile-icon">
                    <ul class="profile-menu">
                      <li><a href="#">프로필</a></li>
                      <li><a href="#">이벤트</a></li>
                      <li><a href="#">티켓</a></li>
                      <li><a href="#">로그아웃</a></li>
                    </ul>
                  </div> --%>
                </div>
          		</div>
          	</div>
          </div>
        </div>

        <!-- 프로필 사진 클릭시 세부 메뉴 on/off 이벤트 start-->
        <script>
          $(function(){
            $(".profile-icon").on({
              "click" : function(){
                $(".profile-menu").toggleClass("on");
              }
            });
          });
        </script>
        <!-- 프로필 사진 클릭시 세부 메뉴 on/off 이벤트 end-->

        <!-- 로그인 팝업 start-->
        <div id="login-popup" class="popup">
          <p class="popup-title">
            로그인
            <img src="<%=request.getContextPath() %>/resources/img/close-btn.png" alt="닫기버튼" class="close-popup">
          </p>
          <div class="popup-content">
            <p class="sign-up-title">아직 회원이 아니신가요?&nbsp;<a href="signUp.html" class="link sign-up-link">회원가입</a></p>
            <form class="login-form-wrap custom-checkbox" action="member/login" method="post">
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
          click : function(){
            $(".popup-shadow, #login-popup").show(0);
          }
        });
        $(".close-popup, .popup-shadow").on({
          click : function(){
            $(".popup-shadow, #login-popup").hide(0);
          }
        });
      </script>
    
</body>
</html>