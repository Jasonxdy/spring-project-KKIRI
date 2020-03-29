<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="../resources/css/my_profile.css">
  <link rel="stylesheet" href="../resources/css/my_favorite.css">
  <title>KKIRI(끼리)</title>
</head>

<body>
  <div id="wrapper">
    <jsp:include page="../common/header.jsp"/>
    <div id="container">
      <div class="container">
        <!-- content 시작 -->
        <div class="row">
          <div class="col-2 nav-wrap">
            <a class="btn " href="../mypage/in">프로필</a>
            <a class="btn" href="../mypage/moveEvent">이벤트</a>
            <a class="btn active" href="../mypage/moveFavorite">즐겨찾기</a>
            <a class="btn" href="../mypage/ticketLog">티켓</a>
            <a class="btn" href="../member/logout">로그아웃</a>
          </div>

          <div class="col-10">

           
			<jsp:useBean id="sysdate" class="java.util.Date"/>
              <!-- 내가 만든 이벤트 -->
                <div class="event_content create_event_con my-profile-favorite">
                  <h4>즐겨찾기</h4>
                  <br>
                 <div class="row justify-content-md-start">
                  <c:forEach var="fList" items="${fList}">
                    <div class="card m-2" style="width: 14rem;">
					  <div class="card-body">
					  	<div class="favoriteFImg">
					  		<img style="width: 100%;" src="${contextPath}/resources/upProfileImage/${fList.memberProfile}">
					  	</div>
					    <div id="nickDiv" style="display:inline-block;" class="">${fList.memberNickname}</div>
					    <a class=""  href="deleteFavorite?memberTicket=${fList.memberTicket}&memberNo=${fList.memberNo}" style="display:none;">
					    	<img style="" src="${contextPath}/resources/img/x-btn.png">
					    </a>
					    	<%-- ${fList.memberIntroduce} --%>
					    <textarea class="favorite-memo card-text mt-1" placeholder="메모"
					    		style="resize: none; height: 5rem;">${fList.memberIntroduce}</textarea>
					    <span style="display:none">${fList.memberTicket}</span>
					    <div class="float-right" style="display:none">
						    <button class="btn btn-sm btn-outline-dark mx-1 memoUpdate">수정</button>
						    <!-- <button class="btn btn-sm btn-outline-dark mx-1">취소</button> -->
					    </div>
					  </div>
					</div>
                  </c:forEach>
					
				</div>
                  
                  
                  <!-- 페이징바 시작 -->
              <div class="row justify-content-center pagination-wrap">
                <ul class="pagination">
						<c:if test="${pInf.currentPage > 1}">
							<li>
								<!-- 맨 처음으로(<<) --> <a class="page-link"
								href="
		                    	<c:url value="moveFavorite">
		                    		<c:param name="currentPage" value="1"/>
		                    	</c:url>
	                    	">
									&lt;&lt; </a>
							</li>

							<li>
								<!-- 이전으로(<) --> <a class="page-link"
								href=" 
		                    	<c:url value="moveFavorite">
		                    		<c:param name="currentPage" value="${pInf.currentPage-1}"/>
		                    	</c:url>
	                    	">
									&lt; </a>
							</li>
						</c:if>

						<!-- 10개의 페이지 목록 -->
						<c:forEach var="p" begin="${pInf.startPage}" end="${pInf.endPage}">


							<c:if test="${p == pInf.currentPage}">
								<li><a class="page-link">${p}</a></li>
							</c:if>

							<c:if test="${p != pInf.currentPage}">
								<li><a class="page-link"
									href=" 
			                    	<c:url value="moveFavorite">
			                    		<c:param name="currentPage" value="${p}"/>
			                    	</c:url>
		                    	">
										${p} </a></li>
							</c:if>

						</c:forEach>

						<!-- 다음 페이지로(>) -->
						<c:if test="${pInf.currentPage < pInf.maxPage }">
							<li><a class="page-link"
								href=" 
		                    	<c:url value="moveFavorite">
		                    		<c:param name="currentPage" value="${pInf.currentPage+1}"/>
		                    	</c:url>
	                    	">
									&gt; </a></li>

							<!-- 맨 끝으로(>>) -->
							<li><a class="page-link"
								href=" 
		                    	<c:url value="moveFavorite">
		                    		<c:param name="currentPage" value="${pInf.maxPage}"/>
		                    	</c:url>
	                    	">
									&gt;&gt; </a></li>
						</c:if>
					</ul>
              </div>
                  <!-- 페이징바 종료 -->
                </div>
        </div>
      </div>
    </div>  
  <script>
  	/* $(".favorite-memo").on("mouseenter", function(){
  		//console.log($(this).val());
  		//html("<button>수정</button>")
  		$(this).parent().children().last().css("display", "inline");
  	}).on("mouseleave", function(){
  		$(this).parent().children().last().css("display", "none");;
  	}); */
  	$(".card-body").on("mouseenter", function(){
  		$(this).children().eq(2).css("display", "inline");
  		$(this).children().last().css("display", "inline");
  	}).on("mouseleave", function(){
  		$(this).children().eq(2).css("display", "none");
  		$(this).children().last().css("display", "none");
  	});
  	
  	$(".memoUpdate").on("click", function(){
  		var favoriteNo = $(this).parent().parent().children().eq(4).text();
  		var updateMemo = $(this).parent().parent().children().eq(3).val();
  		//console.log(memberNo);
  		location.href="changeMemo?memberIntroduce=" + updateMemo + "&memberTicket=" + favoriteNo;
  	});
  	
  	
  </script>


  <!-- content 끝 -->
 <jsp:include page="../common/footer.jsp"/>
  
  </div>
</body>

</html>