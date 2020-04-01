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
							<c:if test="${notice.noticeStatus == 'Y' }">
								<tr class="text-center">
									<th scope="row">${notice.noticeNo}</th>
									<td><p class="board-title-td">${notice.noticeTitle}</p></td>
									<td>${notice.noticeModifyDate}</td>
									<td>${notice.noticeCount}</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
            </tbody>
          </table>
        </div>
      </div>


      <div class="container justify-content-md-center search-content-wrap">
        <!-- 검색 -->
        
        <div class="selector-wrap">
          <div class="input-group">
          <form action="noticeList" class="text-center" id="searchForm" method="GET" >
            <select name="searchKey" class="custom-select" id="inputGroupSelect04" aria-label="Example select with button addon">
              <option selected>구분</option>
              <option value="title">제목</option>
              <option value="content">내용</option>
              <option value="createDate">작성일</option>
              <option value="title_content">제목+내용</option>
            </select>
          </div>
        </div>
        <div class="input-text-wrap">
          <div class="input-group mb-3">
            <input name="searchValue" type="text" class="form-control inputSection">
          </div>
        </div>
        <div class="find-btn-wrap">
          <div class="input-group-append">
            <button type="submit" class="green-radius-btn search-btn">검색</button>
          </div>
        </div>
       </form>
        
        <div class="write-btn-wrap">
        <%-- 로그인된 계정이 관리자 등급인 경우 --%>
	        <c:if test="${ !empty loginMember && loginMember.memberGrade == 'A' }">
	        	<button type="button" class="green-radius-btn search-btn" id="insertBtn" 
	        		onclick="location.href = 'insertForm';">글 쓰기</button>
	        </c:if>
       </div>
        
		
      <!-- 페이징 바 -->
      <div class="row justify-content-center pagination-wrap">
        <div>
          <ul class="pagination">
          <!-- 맨 처음 -->
          <c:if test="${pInf.currentPage>1 }">
          	<li>
                 <a class="page-link text-success" 
                   	href=" 
                   	<c:url value="noticeList">
                   		<c:if test="${!empty param.searchKey }">
			        		<c:param name="searchKey" value="${param.searchKey}"/>
			        	</c:if>
			        		
			        	<c:if test="${!empty param.searchValue }">
			        		<c:param name="searchValue" value="${param.searchValue}"/>
			        	</c:if>
                   		<c:param name="currentPage" value="1"/>
                   	</c:url>
                  	">
                    &lt;&lt;
                </a>
               </li>
               
               <li>
               	<!-- 이전으로(<) -->
           			<a class="page-link text-success" 
                   	href=" 
                   	<c:url value="noticeList">
                   		<c:if test="${!empty param.searchKey }">
			        		<c:param name="searchKey" value="${param.searchKey}"/>
			        	</c:if>
			        	
			        	<c:if test="${!empty param.searchValue }">
			        		<c:param name="searchValue" value="${param.searchValue}"/>
			        	</c:if>
                   		<c:param name="currentPage" value="${pInf.currentPage-1}"/>
                   	</c:url>
                	">	
                    &lt;
                </a>
               </li>
       
          </c:if>
          
          
          <c:forEach var="p" begin="${pInf.startPage}" end="${pInf.endPage}">
            
            
            	<c:if test="${p == pInf.currentPage}">
              <li>
                  <a class="page-link active">${p}</a>
              </li>
             </c:if>
            	
            	<c:if test="${p != pInf.currentPage}">
            		<li>
                 	<a class="page-link text-success" 
                  	href=" 
                  	<c:url value="noticeList">
                  		<c:if test="${!empty param.searchKey }">
		        		<c:param name="searchKey" value="${param.searchKey}"/>
		        	</c:if>
		        	
		        	<c:if test="${!empty param.searchValue }">
		        		<c:param name="searchValue" value="${param.searchValue}"/>
		        	</c:if>
                  		<c:param name="currentPage" value="${p}"/>
                  	</c:url>
                 	">
                   ${p}
               </a>
             	</li>
            	</c:if>
            	
           	</c:forEach>
            
            <!-- 다음 페이지로(>) -->
			 <c:if test="${pInf.currentPage < pInf.maxPage }">
	                <li>
						<a class="page-link text-success" 
	                    	href=" 
	                    	<c:url value="noticeList">
	                    		<c:if test="${!empty param.searchKey }">
					        		<c:param name="searchKey" value="${param.searchKey}"/>
					        	</c:if>
					        	
					        	<c:if test="${!empty param.searchValue }">
					        		<c:param name="searchValue" value="${param.searchValue}"/>
					        	</c:if>
	                    		<c:param name="currentPage" value="${pInf.currentPage+1}"/>
	                    	</c:url>
                    	">
		                    &gt;
		                </a>
	                </li>
	                
	                <!-- 맨 끝으로(>>) -->
	                <li>
	                    <a class="page-link text-success" 
	                    	href=" 
	                    	<c:url value="noticeList">
	                    		<c:if test="${!empty param.searchKey }">
					        		<c:param name="searchKey" value="${param.searchKey}"/>
					        	</c:if>
					        	<c:if test="${!empty param.searchValue }">
					        		<c:param name="searchValue" value="${param.searchValue}"/>
					        	</c:if>
	                    		<c:param name="currentPage" value="${pInf.maxPage}"/>
	                    	</c:url>
                    	">
		                    &gt;&gt;
		                </a>
	                </li>
                </c:if>            

          </ul>
        </div>
      </div>
      <!-- 페이징 바 끝 -->
    </div>
  </div>
</div>

  <!-- content 끝 -->
  
  <jsp:include page="../common/footer.jsp"/>

	

  <script>
  	console.log("${list}");
	//공지사항 상세보기
	$(function(){
		$("#list-table td").click(function(){
			var noticeNo = $(this).parent().children().eq(0).text();
			// 쿼리스트링을 이용하여 get 방식으로 글 번호를 server로 전달
			<c:url var="detailUrl" value="detail">
          		<c:if test="${!empty param.searchKey }">
        		<c:param name="searchKey" value="${param.searchKey}"/>
	        	</c:if>
	        	<c:if test="${!empty param.searchValue }">
	        		<c:param name="searchValue" value="${param.searchValue}"/>
	        	</c:if>
	        	
             	<c:param name="currentPage" value="${pInf.currentPage}"/>
           	</c:url>
			
			location.href="${detailUrl}&no="+noticeNo;
		
		}).mouseenter(function(){
			$(this).parent().css("cursor", "pointer");
		
		});
		
	});
  
  
		// 페이지 이동 후에도 검색 결과가 검색창 input 태그에 표시되도록 하는 script
		$(function(){
			var searchKey = "${param.searchKey}";
			var searchValue = "${param.searchValue}";
			
			if(searchKey != "null" && searchValue != "null"){
				$.each($("select[name=searchKey] > option"), function(index, item){
					if($(item).val() == searchKey){
						$(item).prop("selected","true");
					} 
				});
				
				$("input[name=searchValue]").val(searchValue);
			}
				
		});
  
    </script>
</body>

</html>