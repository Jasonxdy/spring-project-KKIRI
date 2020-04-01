<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="../resources/css/noticeInsertUpdate.css">
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
            <a class="nav-link active" href="${contextPath}/notice/noticeList" tabindex="-1">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link " href="${contextPath }/ask/ask" tabindex="-1">1:1문의 작성</a>
          </li>
        </ul>
      </div>
      

      <div class="row justify-content-md-center questionWriteSection">
        <div class="col-12 rounded-sm">
          <h2 class="notice-title">공지사항 작성</h2>
           <form action="insert" method="get" class="questionForm" onsubmit="return validate();">
         		<div class="section">
					<label class="input-group-addon insert-label">작성일</label>
					<h5 id="today"></h5>
			  	</div>
			  	
			  	<div class="section">
		              <label for="noticeTitle">제목</label>
		              <input type="text" id="noticeTitle" name="noticeTitle">
	            </div>
              
             	<div class="section">	
		              <label for="noticeContent">내용</label>
		              <textarea id="noticeContent" name="noticeContent"></textarea>
				</div>	
				
				<div class="notice-btn-wrap">
	              <button type="submit" class="green-radius-btn">등록</button>&nbsp;
	              <a href="${header.referer}" class="green-radius-btn">목록으로</a>
	            </div>
           </form>
        </div>
      </div>
    </div>
  </div>


  <!-- content 끝 -->
  
  <jsp:include page="../common/footer.jsp"/>
  
  <script>
    
 	// 오늘 날짜 출력 
	var today = new Date();

  	var str = today.getFullYear() + "-"
    		+ (today.getMonth()+1) + "-"
    		+ today.getDate();
	$("#today").html(str);
    
	// 유효성 검사
	function validate(){
		if( $("#noticeTitle").val().trim().length == 0){
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