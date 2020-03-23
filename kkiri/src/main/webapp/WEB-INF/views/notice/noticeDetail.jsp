<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.5/js/swiper.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"
    integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
    crossorigin="anonymous"></script>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap&subset=korean"
    rel="stylesheet">
  <link rel="stylesheet" href="css/common.css">
  <link rel="stylesheet" href="css/questionWrite.css">
  <link rel="stylesheet" href="css/header.css">
  <link rel="stylesheet" href="css/footer.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
  <title>KKIRI(끼리)</title>
</head>

<body>
  <jsp:include page="../common/header.jsp"/>
  
    <!-- content 시작 -->
    <div id="container" class="container">
      <div class="row mt-5">
        <ul class="nav nav-tabs">
          <li class="nav-item">
            <a class="nav-link" href="board.html" tabindex="-1">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="#" tabindex="-1">1:1문의 작성</a>
          </li>
        </ul>
      </div>

      <div class="row justify-content-md-center questionWriteSection">
        <div class="col-12 rounded-sm">
          <h2 class="mt-3 mb-3">1:1문의 작성</h2>
           <form action="#" method="get" class="questionForm">
              <label for="contactEmail">답변을 받으실 이메일 주소를 입력해주세요.</label>
              <input type="email" id="contactEmail">
              <br>
              <label for="questionTitle">제목</label>
              <input type="text" id="questionTitle">
              <br>
              <label for="questionContent">내용</label>
              <textarea id="questionContent"></textarea>

              <button class="green-radius-btn">글 쓰기</button>&nbsp;
              <button type="reset" class="green-radius-btn">취소</button>
           </form>
        </div>
      </div>
    </div>
  </div>


  <!-- content 끝 -->
  <div id="footer">
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
  </div>
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
    $(function () {
      scrollFunction();
      $(window).scroll(function () {
        scrollFunction();
      });
      $('#button-top').on({
        click: function () {
          $('html,body').stop().animate({ scrollTop: 0 }, 600);
        }
      });
    });
    </script>
</body>

</html>



