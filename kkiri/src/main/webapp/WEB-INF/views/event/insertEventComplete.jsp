<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
    <link rel="stylesheet" href="../resources/css/commonEvent.css">
	<title>KKIRI(끼리)</title>
	<style>
	 	html .eventCreate .progress-bar-wrap>p{width:75%;}
	</style>
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
              <form class="eventCreateForm" action="#" method="post">
                  <div class="step4 signUp-complete step">
                    <h3 class="eventCreateTitle">이벤트 생성이 완료되었습니다!</h3>
                    <p class="sub-title">이제 참가자들을 모아 이벤트를 함께 즐기세요.</p>

                    <button type="button" onclick="location.href='detail?no=${eventNo}'" class="green-radius-btn mt-4">이벤트 상세 페이지로</button>
                  </div>
              </form>
            </div>
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

