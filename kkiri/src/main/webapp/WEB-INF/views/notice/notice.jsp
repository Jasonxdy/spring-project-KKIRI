<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항</title>
</head>
<body>
  <jsp:include page="../common/header.jsp"/>
    <!-- content 시작 -->
    <div id="container" class="container">
      <div class="row mt-5">
        <ul class="nav nav-tabs">
          <li class="nav-item">
            <a class="nav-link active" href="#" tabindex="-1">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${contextPath }/ask/ask" tabindex="-1">1:1문의 작성</a>
          </li>
        </ul>
      </div>

      <div class="row justify-content-md-center boardWrap">
        <div class="col-12 rounded-sm">
          <h2 class="mt-3 mb-5">공지사항</h2>
          <table id="list-table" class="table table-hover table-striped table-sm">
            <thead>
              <tr class="text-center">
                <th scope="col">NO</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회수</th>
              </tr>
            </thead>
            <tbody>
            	<c:if test="${empty list }">
					<tr>
						<td colspan="5">존재하는 공지사항이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${!empty list }">
					<c:forEach var="notice" items="${list}" varStatus="vs">
						<tr class="text-center">
							<th scope="row">${notice.noticeNo}</th>
							<td><p class="board-title-td">${notice.noticeTitle}</p></td>
							<td>${loginMember}</td>
							<td>${notice.noticeModifyDate}</td>
							<td>${notice.noticeCount}</td>
						</tr>
					</c:forEach>
				</c:if>
            </tbody>
          </table>
        </div>
      </div>


      <div class="row justify-content-md-center">
        <!-- 검색 -->
        <div class="col-md-2 col-sm-3">
          <div class="input-group">
            <select class="custom-select" id="inputGroupSelect04" aria-label="Example select with button addon">
              <option selected>구분</option>
              <option value="1">작성일</option>
              <option value="2">제목</option>
            </select>
          </div>
        </div>
        <div class="col-md-9 col-sm-7">
          <div class="input-group mb-3">
            <input type="text" class="form-control inputSection">
          </div>
        </div>
        <div class="col-md-1 col-sm-2">
          <div class="input-group-append">
            <button class="green-radius-btn search-btn" type="button">검색</button>
          </div>
        </div>
        <div>
        <%-- 로그인된 계정이 관리자 등급인 경우 --%>
	        <c:if test="${ !empty loginMember && loginMember.memberGrade == 'A' }">
	        	<button type="button" class="btn btn-success float-right" id="insertBtn" 
	        		onclick="location.href = 'insertForm';">글쓰기</button>
	        </c:if>
        </div>
		
      <!-- 페이징 바 -->
      <div class="row justify-content-center pagination-wrap">
        <div>
          <ul class="pagination">
            <li>
              <a class="page-link " href="#">&lt;&lt;</a>
            </li>
            <li>
              <a class="page-link " href="#">&lt;</a>
            </li>
            <li>
              <a class="page-link" href="#">1</a>
            </li>
            <li>
              <a class="page-link " href="#">2</a>
            </li>
            <li>
              <a class="page-link " href="#">3</a>
            </li>
            <li>
              <a class="page-link " href="#">4</a>
            </li>
            <li>
              <a class="page-link " href="#">5</a>
            </li>
            <!-- 다음 페이지로(>) -->
            <li>
              <a class="page-link " href="#">&gt;</a>
            </li>
            <!-- 맨 끝으로(>>) -->
            <li>
              <a class="page-link " href="#">&gt;&gt;</a>
            </li>
          </ul>
        </div>
      </div>
      <!-- 페이징 바 끝 -->
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