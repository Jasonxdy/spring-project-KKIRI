<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KKIRI(끼리)</title>
  <link rel="stylesheet" href="../resources/css/noticeDetail.css">
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
          <h2 class="notice-title">공지사항</h2>
           <form action="updateForm" method="get" class="questionForm">
                <p class="notice-con-title">제목 : ${notice.noticeTitle}</p>
                <p class="notice-con-date">
               		작성 일자 : ${notice.noticeModifyDate}
               		<span class="notice-con-viewCount">조회 수  : ${notice.noticeCount}</span>
          		</p>
          		
               	<p class="notice-con-content">${notice.noticeContent}</p>
           </form>
           	<div class="notice-btn-wrap">
             <c:if test="${ !empty loginMember && loginMember.memberGrade == 'A' }">
		        	<a class="green-radius-btn" id="updateBtn" 
		        		href="updateForm?no=${param.no}">수정</a>
		        	<button class="green-radius-btn" id="deleteBtn">삭제</button>
		        </c:if>
		       		
              <a class="green-radius-btn"
				href="
				<c:url value="noticeList">
                  		<c:if test="${!empty param.searchKey }">
		        		<c:param name="searchKey" value="${param.searchKey}"/>
		        	</c:if>
		        	
		        	<c:if test="${!empty param.searchValue }">
		        		<c:param name="searchValue" value="${param.searchValue}"/>
		        	</c:if>
                  		<c:param name="currentPage" value="${param.currentPage}"/>
                  	</c:url>" >뒤로
                </a>
             </div>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="../common/footer.jsp"/>
	<script>
	  
	  $("#deleteBtn").on("click",function(){
			if(confirm("정말 삭제 하시겠습니까?")) location.href = "delete?no=${param.no}";
		});
    </script>
</body>

</html>



