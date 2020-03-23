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
      

      <div class="row justify-content-md-center questionWriteSection">
        <div class="col-12 rounded-sm">
          <h2 class="mt-3 mb-3">공지사항 작성</h2>
           <form action="#" method="get" class="questionForm">
           	
	       	  <span class="form-inline mb-2">
				<label class="input-group-addon mr-3 insert-label">작성자</label>
				<h5 class="my-0" id="writer">${loginMember.memberId}</h5>
			  </span>
				&nbsp; &nbsp;
		      <span class="form-inline mb-2">
				<label class="input-group-addon mr-3 insert-label">작성일</label>
				<h5 class="my-0" id="today"></h5>
			  </span>
			  
              <br>
              <label for="questionTitle">제목</label>
              <input type="text" id="questionTitle">
              <br>
              <label for="questionContent">내용</label>
              <textarea id="questionContent"></textarea>

              <button class="green-radius-btn">수정</button>&nbsp;
              <button type="reset" class="green-radius-btn">취소</button>
           </form>
        </div>
      </div>
    </div>
  


  <!-- content 끝 -->
  
  <jsp:include page="../common/footer.jsp"/>
  
  <div id="button-top">
    <button type="button" class="top-btn">TOP</button>
  </div>

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