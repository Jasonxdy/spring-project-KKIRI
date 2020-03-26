<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<title>KKIRI(끼리)</title>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<script src="${contextPath}/resources/js/index.js"></script>
		<div id="container">
          <!-- 배너 start -->
          <div id="banner">
            <div class="banner-text-area">
              <p class="banner-title">
                		많은 사람들이 끼리를 통해 삶을 공유하고 있습니다.<br>
                <span class="banner-sub-title">내 주변의 사람들과 좋아하는 일을 함께 하며 새로운 경험을 즐겨 보세요.</span>
              </p>
              	<c:choose>
              		<c:when test="${!empty loginMember}">
		              	<a href="${contextPath}/event/goEventCreate" class="go-sign-up">이벤트 생성하기</a>
              		</c:when>
              		<c:otherwise>
		              	<a href="${contextPath}/member/signUp" class="go-sign-up">끼리 가입하기</a>
              		</c:otherwise>
              	</c:choose>
            </div>
    				<video class='video' autoplay loop muted>
    					<source src='${contextPath}/resources/movie/banner-movie.mp4' type='video/mp4'>
    				</video>
            <div class="video-shadow"> </div>
      		</div>
          <!-- 배너 end -->

          <!-- 이런 이벤트는 어떠세요? start -->
          <div id="event-recommend">
            <div class="container">
              <div class="row">
                <div class="col-md-12">
                


                
                <!-- 이벤트 상세페이지 들어가기 Test용 start-->
                <h5>
                	<a href="${pageContext.servletContext.contextPath}/event/detail">
                		이벤트 상세페이지 들어가기 테스트용입니다 (삭제 예정)
                	</a>
                </h5>
                <!-- 이벤트 상세페이지 들어가기 Test용 start-->
			
			
			
				<h3 class="box-title">	
					<c:choose>
	              		<c:when test="${!empty loginMember}">
	              			<c:if test="${(loginMember != null) && (loginMember.memberPlace != null) }">
		              			${loginMember.memberNickname}님,
		              			<c:set var="mPlace" value="${fn:split(loginMember.memberPlace,' ')}"/>
		              			${mPlace[0]} ${mPlace[1]}
		              			 지역 주변에 이런 이벤트 어떠세요?<br>
		              			<span class="box-sub-title">주변에서 열리는 이벤트에 참석해보세요.</span>
	              			</c:if>
	              		</c:when>
	              		<c:otherwise>
		              		이런 이벤트 어떠세요?<br>
	                    	<span class="box-sub-title">끼리에 가입하고 이벤트에 참여하세요.</span>
	              		</c:otherwise>
	              	</c:choose>
 				</h3>
                    
                  <div class="blog-slider">
                    <div class="blog-slider__wrp swiper-wrapper">
                    
                    
                    <c:if test="${empty eventList}">
                    	<p class="no-data-content">이벤트가 존재하지 않습니다!</p>
                    </c:if>
                    <c:if test="${!empty eventList}">
                    	<c:forEach var="event" items="${eventList}" varStatus="vs">
	                      <div class="blog-slider__item swiper-slide">
	                        <div class="blog-slider__img" onclick="eventLink();" >
	                          <img src="${contextPath}/resources/upEventThumbnail/${event.eventThumbnail}" alt="이벤트 썸네일">
	                        </div>
	                        <div class="blog-slider__content">
	                          <span class="blog-slider__code">
	                          	<fmt:formatDate var="startDate" value="${event.eventStart}" pattern="yyyy년 MM월 dd일 E요일 · HH:mm" />
	                          	${startDate} 
	                          </span>
	                          <div class="blog-slider__title">
	                            <p class="address">[${event.eventTitle}]</p>
	                            <p class="location"><img src="${contextPath}/resources/img/map-ping.png" alt="위치"> &nbsp;${event.eventAddress}</p>
	                          </div>
	                          <div class="blog-slider__text">
	                            <p class="leader">주최자</p>
	                            <div class="content">
	                              <img src="${contextPath}/resources/upProfileImage/${event.memberProfile}" alt="프로필" class="profile-img">
	                              <p class="leader-info">
	                                		${event.memberNickname}<br>
	                                <img src="${contextPath}/resources/img/star-on.png" alt="별점" class="star-img">
	                                <span class="star-rating">${event.memberRating}</span>
	                              </p>
	                              <p class="member-count">참석인원 : ${event.partyCount}/${event.eventQuota}</p>
	                            </div>
	                            <p class="ticket">티켓 : ${event.eventTicket}장</p>
	                          </div>
	                        </div>
	                      </div>
                      	 </c:forEach>
                    </c:if>
                      
                    </div>
                    <c:if test="${!empty eventList}">
                    	<div class="blog-slider__pagination swiper-pagination-bullets"></div>
                    </c:if>
                  </div>
                </div>
              </div>
            </div>
          </div>
          

		  <!-- 이벤트 상세 주소 매핑 스크립트 -->
		  <script>
		  	function eventLink(){
		  		var linkIndex = $(".blog-slider__pagination .swiper-pagination-bullet-active").index()+1;
		  		if(linkIndex == 1){
		  			location.href="${contextPath}/event/detail?no=${eventList[0].eventNo}";
		  		}else if(linkIndex == 2){
		  			location.href="${contextPath}/event/detail?no=${eventList[1].eventNo}";
		  		}else if(linkIndex == 3){
		  			location.href="${contextPath}/event/detail?no=${eventList[2].eventNo}";
		  		}else if(linkIndex == 4){
		  			location.href="${contextPath}/event/detail?no=${eventList[3].eventNo}";
		  		}else if(linkIndex == 5){
		  			location.href="${contextPath}/event/detail?no=${eventList[4].eventNo}";
		  		}
	  		}
		  </script>
		  <!-- 이런 이벤트는 어떠세요? end -->
		  
          <!-- 주최자 랭킹 start -->
          <div id="ranking">
            <div class="container">
              <div class="row">
                <div class="col-md-12">
                  <h3 class="box-title">
                    한주간 가장 높은 평점을 받은 ${rankSize}명을 소개합니다.<br>
                    <span class="box-sub-title">축하드립니다! 앞으로도 멋진 모임들을 많이 만들어주세요.</span>
                  </h3>
                    <div class="ranking-wrap">
                      <ul class="ranker-list">
                      
                      <c:if test="${empty mlist}">
                      	<p class="no-data-info">데이터가 존재하지 않습니다!</p>
                      </c:if>
                      <c:if test="${!empty mlist}">
                         <c:forEach var="ranking" items="${mlist}" varStatus="vs">
	                      	 <li class="ranker" onclick="location.href='${contextPath}/profile/user?no=${ranking.memberNo}'">
	                          <p class="rank"></p>
	                          <img src="${contextPath}/resources/upProfileImage/${ranking.memberProfile}" alt="회원 썸네일">
	                          <p class="nickname">${ranking.memberNickname}</p>
	                          <p class="star-rating"><img src="${contextPath}/resources/img/star-on.png" alt="별점" class="star-img">&nbsp; ${ranking.memberRating}</p>
	                        </li>
                        </c:forEach>
                      </c:if>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
              <script>
			  	$(function(){
		  		    // 첫번째 랭크 on 이벤트 추가시키기
			  		$(".ranking-wrap .ranker").eq(0).addClass("on");
			  		
		  		    // 1위
			  		$(".ranking-wrap .rank").eq(0).addClass("first-rank").text("1 st");
		  		    // 2위
			  		$(".ranking-wrap .rank").eq(1).addClass("second-rank").text("2 nd");
		  		    // 3위
			  		$(".ranking-wrap .rank").eq(2).addClass("third-rank").text("3 rd");
		  		    // 4위
			  		$(".ranking-wrap .rank").eq(3).addClass("least-rank").text("4 th");
		  		    // 5위
			  		$(".ranking-wrap .rank").eq(4).addClass("leasr-rank").text("5 th");
			  	});
			  </script>                
          <!-- 주최자 랭킹 end -->

          <!-- 카테고리 추천 start -->
          <div id="category-list">
            <div class="container">
              <div class="row">
                <div class="col-md-12">
                  <h3 class="box-title">
                    카테고리<br>
                    <span class="box-sub-title">관심있는 주제별로 이벤트를 찾아보세요.</span>
                  </h3>
                  <ul class="category-ul">
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=여행">
                        <div class="blue-background"><img src="${contextPath}/resources/img/travel-icon.png" alt=""></div>
                        <span class="category-name">여행</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=운동">
                        <div class="blue-background"><img src="${contextPath}/resources/img/exercise-icon.png" alt=""></div>
                        <span class="category-name">운동</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=독서">
                        <div class="blue-background"><img src="${contextPath}/resources/img/book-icon.png" alt=""></div>
                        <span class="category-name">독서</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=비즈니스">
                        <div class="blue-background"><img src="${contextPath}/resources/img/business-icon.png" alt=""></div>
                        <span class="category-name">비즈니스</span>
                      </a>
                    </li>
                  </ul>
                  <ul class="category-ul">
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=언어">
                        <div class="blue-background"><img src="${contextPath}/resources/img/language-icon.png" alt=""></div>
                        <span class="category-name">언어</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=음악">
                        <div class="blue-background"><img src="${contextPath}/resources/img/music-icon.png" alt=""></div>
                        <span class="category-name">음악</span>
                      </a>
                    </li>
                    <li>
                     <a href="${contextPath}/search/searchEvent?searchKey=영화/공연">
                        <div class="blue-background"><img src="${contextPath}/resources/img/cinema-icon.png" alt=""></div>
                        <span class="category-name">영화/공연</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=댄스">
                        <div class="blue-background"><img src="${contextPath}/resources/img/dance-icon.png" alt=""></div>
                        <span class="category-name">댄스</span>
                      </a>
                    </li>
                  </ul>
                  <ul class="category-ul">
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=봉사활동">
                        <div class="blue-background"><img src="${contextPath}/resources/img/volunteer-icon.png" alt=""></div>
                        <span class="category-name">봉사활동</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=사교">
                        <div class="blue-background"><img src="${contextPath}/resources/img/friend-icon.png" alt=""></div>
                        <span class="category-name">사교</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=차/오토바이">
                        <div class="blue-background"><img src="${contextPath}/resources/img/car-icon.png" alt=""></div>
                        <span class="category-name">차/오토바이</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=사진/영상">
                        <div class="blue-background"><img src="${contextPath}/resources/img/camera-icon.png" alt=""></div>
                        <span class="category-name">사진/영상</span>
                      </a>
                    </li>
                  </ul>
                  <ul class="category-ul">
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=스포츠관람">
                        <div class="blue-background"><img src="${contextPath}/resources/img/stadium-icon.png" alt=""></div>
                        <span class="category-name">스포츠관람</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=게임">
                        <div class="blue-background"><img src="${contextPath}/resources/img/game-icon.png" alt=""></div>
                        <span class="category-name">게임</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=요리">
                        <div class="blue-background"><img src="${contextPath}/resources/img/cook-icon.png" alt=""></div>
                        <span class="category-name">요리</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=반려동물">
                        <div class="blue-background"><img src="${contextPath}/resources/img/pet-icon.png" alt=""></div>
                        <span class="category-name">반려동물</span>
                      </a>
                    </li>
                  </ul>
                  <ul class="category-ul">
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=사회운동">
                        <div class="blue-background"><img src="${contextPath}/resources/img/socialMovement-icon.png" alt=""></div>
                        <span class="category-name">사회운동</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=뷰티">
                        <div class="blue-background"><img src="${contextPath}/resources/img/beauty-icon.png" alt=""></div>
                        <span class="category-name">뷰티</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=패션">
                        <div class="blue-background"><img src="${contextPath}/resources/img/fashion-icon.png" alt=""></div>
                        <span class="category-name">패션</span>
                      </a>
                    </li>
                    <li>
                      <a href="${contextPath}/search/searchEvent?searchKey=기타">
                        <div class="blue-background"><img src="${contextPath}/resources/img/etc-icon.png" alt=""></div>
                        <span class="category-name">기타</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <!-- 카테고리 추천 end -->
        </div>
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
</body>
</html>