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
  <div id="wrapper">
  <jsp:include page="../common/header.jsp"/>
  
    <!-- content 시작 -->
    <div id="container" class="container">
      
      <div class="row mt-5">
        <ul class="nav nav-tabs">
          <li class="nav-item">
            <a class="nav-link active" href="${contextPath }/notice/noticeList" tabindex="-1">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link " href="${contextPath }/ask/ask" tabindex="-1">1:1문의 작성</a>
          </li>
        </ul>
      </div>
      

      <div class="row justify-content-md-center questionWriteSection">
        <div class="col-12 rounded-sm">
          <h2 class="mt-3 mb-3">공지사항 작성</h2>
           <form action="insert" method="get" class="questionForm">
           
				&nbsp; &nbsp;
		      <span class="form-inline mb-2">
				<label class="input-group-addon mr-3 insert-label">작성일</label>
				<h5 class="my-0" id="today"></h5>
			  </span>
			  
              <br>
              <label for="questionTitle" >제목</label>
              <input type="text" id="questionTitle" name="noticeTitle">
              <br>
              <label for="questionContent">내용</label>
              <textarea id="noticeContent" name="noticeContent"></textarea>

              <button type="submit" class="green-radius-btn">등록</button>&nbsp;
              <a href="${header.referer}" class="green-radius-btn">목록으로</a>
           </form>
        </div>
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
    
 	// 오늘 날짜 출력 
		var today = new Date();

  	var str = today.getFullYear() + "-"
    		+ (today.getMonth()+1) + "-"
    		+ today.getDate();
	$("#today").html(str);
    
	// 유효성 검사
	function validate(){
		if( $("#questionTitle").val().trim().length == 0){
			alert("제목을 입력해 주세요.");
			$("#questionTitle").focus();
			return false;
		}
		
		if( $("#noticeContent").val().trim().length == 0){
			alert("내용을 입력해 주세요.");
			$("#noticeContent").focus();
			return false;
		}
	}
	
    
    </script>
</body>

</html>