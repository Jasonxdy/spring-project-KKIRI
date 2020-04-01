<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
    <link rel="stylesheet" href="../resources/css/signUp.css">
	<title>KKIRI(끼리)</title>
	<style>
	 	html .signUp .progress-bar-wrap>p{width:75%;}
	</style>
</head>

<body>
  <div id="wrapper">
    <jsp:include page="../common/header.jsp"/>
	<div id="container">
      <div class="signUp">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h2 class="section-title">회원가입</h2>
              <div class="progress-bar-wrap">
                <p class="progress-bar-percent"></p>
              </div> 
              <form class="signUpForm" action="${contextPath}" method="post">
                  <div class="step4 signUp-complete step">
                    <h3 class="signUpTitle">회원가입 성공!</h3>
                    <p class="sub-title">KKIRI의 회원이 되신 것을 환영합니다.</p>
                    <button type="button" class="green-radius-btn mt-4">메인으로</button>
                  </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
	
    <!-- 이벤트생성 관련 스크립트 -->
    <script>
      $(function() {
        $(".progress-bar-wrap").delay(300).fadeIn(300);
        $(".progress-bar-percent").delay(200).animate({"width":"100%"},300);
        $(".step4").delay(300).fadeIn(300);
      });
    </script>
	
	<jsp:include page="../common/footer.jsp"/>
	
</body>

</html>

