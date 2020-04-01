<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.kkiri.member.model.vo.Member"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.5/js/swiper.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/jquery.slick/1.6.0/slick.min.js"></script>
    <script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/header.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/index.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/board.css">
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" scope="application"/>
	<c:if test="${!empty msg }">
		<script>alert("${msg}")</script>
		<c:remove var="msg"/>
	</c:if>
	
	<div id="header">
          <div class="container">
          	<div class="row">
          		<div class="col-md-12">
                <h1 class="logo"><a href="${contextPath}"><img src="<%=request.getContextPath() %>/resources/img/logo.png" alt="로고"></a></h1>
                <div class="nav-section">
                
                <!-- 로그인 안될 때(태균) -->
                 
                 <c:if test="${ empty sessionScope.loginMember  }">
	                 <a href="#" class="login-btn">로그인</a>
	                 <a href="${contextPath }/member/signUp">회원가입</a>
	                 <a href="${contextPath }/notice/noticeList">고객센터</a>
	                 <a href="${pageContext.servletContext.contextPath}/search/searchEvent">탐색</a>
                 </c:if>
                  
                  
                  <!-- 로그인 된 후(태균) -->
                  <c:if test="${ ! empty sessionScope.loginMember}">
	                  <c:if test="${loginMember.memberGrade == 'A' }">
	                  <a href="${contextPath}/admin/member" class="createEvent-btn">관리자 페이지</a>
	                  </c:if>
	                  <c:if test="${loginMember.memberGrade != 'A' }">
	                  <a href="${contextPath}/event/goEventCreate" class="createEvent-btn">이벤트 생성하기</a>
	                  </c:if>
	                  <span class="separation"> | </span>
	                  <a href="${contextPath }/notice/noticeList">고객센터</a>
	                  <span class="separation"> | </span>
	                  <a href="${pageContext.servletContext.contextPath}/search/searchEvent">탐색</a>
	                  <div class="profile-wrap">
	                    <!--  <img src="<%=request.getContextPath() %>/resources/img/profile-ex.png" alt="프로필" class="profile-icon">-->
	                    
	                    <c:set var="src" value="${contextPath }/resources/upProfileImage/${loginMember.memberProfile }"/>
	                    <img src="${src}" alt="프로필" class="profile-icon" >
	                    <ul class="profile-menu">
	                      <li><a href="${contextPath}/mypage/in">프로필</a></li>
	                      <li><a href="${contextPath}/mypage/moveEvent">이벤트</a></li>
	                      <li><a href="${contextPath}/mypage/moveFavorite">즐겨찾기</a></li>
	                      <li><a href="${contextPath}/mypage/ticketLog">티켓</a></li>
	                      <li><a href="${contextPath}/member/logout">로그아웃</a></li>
	                    </ul>
	                  </div>
               	  </c:if>
               	  
               	  <!-- 로그인 후 관리자 -->
               
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
            <form class="login-form-wrap custom-checkbox" action="${contextPath }/member/login" method="post">
              <%-- <input type="text" name="memberId" placeholder="아이디를 입력해주세요." autocomplete="off" value="<%=memberId %>"> --%>
             
              <input type="text" id="memberId" name="memberId" placeholder="아이디를 입력해주세요."  
                <c:if test="${!empty cookie.rememberId.value}">
              		value="${cookie.rememberId.value}"
              	</c:if>
              required>
              
              <input type="password" id="memberPwd" name="memberPwd" placeholder="비밀번호를 입력해주세요." required>

              <input type="checkbox" class="custom-control-input" name="rememberId" id="rememberId" 
              	<c:if test="${!empty cookie.rememberId.value}">checked</c:if>  
              >
              <!-- 쿠키에 저장된 값이 있다면 checked 아니면 ckecked 하지 않음 -->
              
              <label class="custom-control-label" for="rememberId">아이디 저장</label>
              <a href="${contextPath }/member/findMember" class="link find-info-link">아이디 혹은 비밀번호를 잊으셨나요?</a>

              <button class="popup-confirm-btn login-conform-btn">로그인</button>
              <button id="googleLogin" type="button" class="popup-confirm-btn another-btn">구글 아이디로 로그인</button>
              <button id="kakaoLogin" type="button" class="popup-confirm-btn another-btn">카카오 아이디로 로그인</button>
              <button id="naverLogin" type="button" class="popup-confirm-btn another-btn">네이버 아이디로 로그인</button>
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
        
        $("#googleLogin").on("click", function(){
        	location.href = "${google_url}";
        })
        
         $("#kakaoLogin").on("click", function(){
        	location.href = "${kakao_url}";
        })
        
         $("#naverLogin").on("click", function(){
        	location.href = "${naverUrl}";
        })
      </script>
      
      
      
    <!--   <script src="https://cdn.jsdelivr.net/npm/js-cookie@rc/dist/js.cookie.min.js" >
  	 // 쿠키 스크립트
  	$("#memberId").val(Cookies.get('key'));      
	    if($("#memberId").val() != ""){
	        $("#rememberId").attr("checked", true);
	    }
    
	$("#rememberId").change(function(){
	    if($("#rememberId").is(":checked")){
	        Cookies.set('key', $("#memberId").val(), { expires: 7 });
	    }else{
	          Cookies.remove('key');
	    }
	});
	     
	$("#memberId").keyup(function(){
	    if($("#rememberId").is(":checked")){
	        Cookies.set('key', $("#memberId").val(), { expires: 7 });
	    }
	});

      </script> -->
    
	
</body>
</html>