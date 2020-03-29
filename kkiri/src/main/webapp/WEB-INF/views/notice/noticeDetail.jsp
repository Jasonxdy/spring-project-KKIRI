<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<html lang="ko">
<head>
  <meta charset="UTF-8">
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
          <h2 class="mt-3 mb-3">공지사항 작성</h2>
           <form action="#" method="get" class="questionForm">
             
              <br>
              <label for="questionTitle">제목</label>
              <input type="text" id="questionTitle">
              <br>
              <label for="questionContent">내용</label>
              <textarea id="questionContent"></textarea>

			<p>
				${notice.noticeModifyDate }
				<span class="float-right">조회수  ${notice.noticeCount }</span>
			</p>


              <button class="green-radius-btn">글쓰기</button>&nbsp;
              <button type="reset" class="green-radius-btn">취소</button>
           </form>
        </div>
      </div>
    </div>
  </div>


  <!-- content 끝 -->

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



