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
                    <div class="card m-2" style="width: 16rem;">
					  <div class="card-body">
					  	<div class="favoriteFImg">
					  		<a href="${contextPath}/profile/user?no=${fList.memberTicket}">
					  		<img style="width: 100%;" src="${contextPath}/resources/upProfileImage/${fList.memberProfile}">
					  		</a>
					  	</div>
					    <div id="nickDiv" style="display:inline-block;" class="">${fList.memberNickname}</div>
				    	<img class="favoriteDeleteImg" src="${contextPath}/resources/img/x-btn.png">
					    <form action="changeMemo" method="post">
						    <textarea class="favorite-memo card-text mt-1" placeholder="메모"
						    		name="memberIntroduce">${fList.memberIntroduce}</textarea>
						    <input name="memberTicket" value="${fList.memberTicket}" style="display:none"/>
						    <div class="float-right" style="display:none">
							    <button class="btn btn-sm btn-outline-dark mx-1 memoUpdate">수정</button>
							    <!-- <button class="btn btn-sm btn-outline-dark mx-1">취소</button> -->
						    </div>
					    </form>
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
								<li><a class="page-link active">${p}</a></li>
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
  
  $(function(){
  	if(${loginMember == null}){
  		location.href="../mypage/main";	
  	}
  })
  
  	$(".card-body").on("mouseenter", function(){
  		$(this).children().eq(2).css("display", "inline"); // X
  		$(this).children().last().children().last().css("display", "inline"); //수정 버튼
  		console.log($(this).children().eq(2));
  	}).on("mouseleave", function(){
  		$(this).children().eq(2).css("display", "none");
  		$(this).children().last().children().last().css("display", "none");
  	});
  	
  	
  	 $(".favoriteDeleteImg").on("click", function () {
  		var favoriteNo = $(this).parent().children().eq(3).children().eq(1).val();
		//console.log(favoriteNo);
  		if(confirm("정말 삭제 하시겠습니까?")){
  			location.href="deleteFavorite?memberTicket=" + favoriteNo;
  		}
     }).mouseenter(function () {
       $(".favoriteDeleteImg").css("cursor", "pointer");
     });
  	
  	
  </script>


  <!-- content 끝 -->
 <jsp:include page="../common/footer.jsp"/>
  
  </div>
</body>

</html>