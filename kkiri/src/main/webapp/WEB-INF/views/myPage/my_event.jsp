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
  <link rel="stylesheet" href="../resources/css/my_event.css">
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
            <a class="btn active" href="../mypage/moveEvent">이벤트</a>
            <a class="btn" href="../mypage/ticketLog">티켓</a>
            <a class="btn" href="../member/logout">로그아웃</a>
          </div>

          <div class="col-10">

            <ul class="nav nav-tabs" id="profile-nav-wrap">
              <li class="nav-item">
                <a class="nav-link 
                <c:if test="${flag == 1}" >
                active 
                </c:if>
                move-btn" href="
                <c:url value="moveEvent">
                <c:param name="flag" value="1"/>
                </c:url>
                " tabindex="-1">내가 만든 이벤트</a>
              </li>
              <li class="nav-item">
                <a class="nav-link
                <c:if test="${flag == 2}">
                active 
                </c:if>
                 move-btn" href="
                  <c:url value="moveEvent">
                <c:param name="flag" value="2"/>
                </c:url>
                 
                 " tabindex="-1">내가 참여한 이벤트</a>
              </li>
            </ul>
            

            <script>
              // 탭별로 내용 보여지는 이벤트
              $(function(){
                $("#profile-nav-wrap li a").each(function(index){
                  $(this).on({
                    click : function(){
                      $("#profile-nav-wrap li a").removeClass("active");
                      $(this).addClass("active");

                      $(".event_content").stop().hide(0);
                      $(".event_content").eq(index).stop().show(0);
                    }
                  });
                });
              });
              
              </script>
			<jsp:useBean id="sysdate" class="java.util.Date"/>
            <div class="my_event_wrapper">
              <!-- 내가 만든 이벤트 -->
                <div class="event_content create_event_con my-profile-section" style="
                <c:if test="${ flag ==2}">
				display:none                
                </c:if>
                ">
                  <h4>내가 만든 이벤트</h4>
                  <ul>
                  <c:forEach var="eve" items="${eList}">
                 
                    <li class="move-detail">
                      <div class="thumb-wrap">
                        <img src="../resources/upEventThumbnail/${eve.eventThumbnail}" alt="이벤트썸네일">
                      </div>
                      <div class="sub-con">
                        <p class="event-date">
                        <fmt:formatDate value="${eve.eventStart}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                        </p>
                        <p class="event-title">${eve.eventTitle }</p>
                        <p class="event-location"><img src="../resources/img/map-ping.png" alt="지도마커">&nbsp; ${eve.eventAddress}</p>
                        <p class="event-explanation">
                          ${eve.eventContent}
                        </p>
                        <c:if test="${eve.eventEnd < sysdate }">
                        <p class="end-event">종료된 이벤트</p>
                        </c:if>
                        <input class="eveno" type="number" value="${eve.eventNo}" style="display:none">
                      </div>  
                    </li>
                  </c:forEach>
                  
                  
                  </ul>
                  <!-- 페이징바 시작 -->
                  <div class="row justify-content-center pagination-wrap">
                <div>
                  <ul class="pagination">
                  <c:if test="${pInf.currentPage >1 }">
                  
                    <li>
                      <a class="page-link " href="
                  <c:url value="moveEvent">
                  </c:url>
                      "
                      >&lt;&lt;</a>
                    </li>
                    <li>
                      <a class="page-link " href="
                    
                    <c:url value="moveEvent">
                  	</c:url>
                  ">&lt;</a>
                    </li>
                  </c:if>
                  <c:forEach var ="pg" begin="${pInf.startPage }" end="${pInf.endPage }">
                  <c:if test="${pg ==pInf.currentPage}">
                    <li>
                      <a class="page-link">${pg }</a>
                    </li>
                  </c:if>
                  <c:if test="${pg!=pInf.currentPage }">
                    <li>
                      <a class="page-link" href="
                      <c:url value="moveEvent">
                      <c:param name="currentPage" value="${pg}" />
                      </c:url>
                      ">${pg }</a>
                    </li>
                  </c:if>
                  </c:forEach>
                    
                    <!-- 다음 페이지로(>) -->
                    <c:if test="${pInf.currentPage<pInf.maxPage }">
                    <li>
                      <a class="page-link " href="
                      <c:url value="moveEvent">
                      <c:param name="currentPage" value="${pInf.currentPage+1}"/>
                      </c:url>
                      ">&gt;</a>
                    </li>
                   
                    
                    <!-- 맨 끝으로(>>) -->
                    <li>
                      <a class="page-link " href="
                      <c:url value="moveEvent">
                      <c:param name="currentPage" value="${pInf.maxPage}"/>
                      </c:url>
                      ">&gt;&gt;</a>
                    </li>
                     </c:if>
                  </ul>
                </div>
              </div>
                  
                  
                  <!-- 페이징바 종료 -->
                </div>

				<script>
				// 해당 페이지 상세 입장하는 스크립트
                  $(function(){
                	  $(".move-detail").click(function(){
                		  console.log(12345)
                		  var eventNo =  $(this).find(".eveno").val();
                		  location.href="../event/detail?no="+eventNo;
                	  })
                  })
                  
                </script>

                <!-- 내가 참여한 이벤트 --> 
                <div class="event_content participate_event_con my-profile-section" style="
                <c:if test="${ flag ==1}">
				display:none                
                </c:if>
                ">
                  <h4>내가 참여한 이벤트</h4>
                  <ul>
                  <c:forEach var="ele" items="${ejList}">
                    <li class="move-detail">
                    
                      <div class="thumb-wrap">
                        <img src="../resources/img/${ele.eventThumbnail }" alt="이벤트썸네일">
                      </div>
                      <div class="sub-con">
                        <p class="event-date">
							<fmt:formatDate value="${ele.eventStart}" pattern="yyyy년 MM월 dd일 HH:mm"/>
						</p>
                        <p class="event-title">${ele.eventTitle }</p>
                        <p class="event-location"><img src="../resources/img/map-ping.png" alt="지도마커">&nbsp; ${ele.eventAddress}</p>
                        <p class="event-explanation">
                         ${ele.eventContent}
                        </p>
                      </div>
                      <div class="creator-con">
                        <img src="../resources/upProfileImage/${ele.memberProfile }" alt="회원아이콘">
                        <p class="creator-id">
                          <span>${ele.memberNickname }</span>
                          <img src="../resources/img/star-on.png" alt="별점">&nbsp;${ele.memberRating }
                        </p>
                        <c:if test="${ele.eventEnd<sysdate }">
                        <p class="end-event">종료된 이벤트</p>
                        <input class="eveno" type="number" value="${eve.eventNo}" style="display:none">
                        </c:if>
                      </div>  
                    </li>
                    </c:forEach>
                    
                  </ul>
                  <!-- 페이징바 시작 -->
                  <div class="row justify-content-center pagination-wrap">
                <div>
                  <ul class="pagination">
                  <c:if test="${pInf.currentPage >1 }">
                  
                    <li>
                      <a class="page-link " href="
                  <c:url value="moveEvent">
                  <c:param name="flag" value="2"/>
                  </c:url>
                      "
                      >&lt;&lt;</a>
                    </li>
                    <li>
                      <a class="page-link " href="
                    
                    <c:url value="moveEvent">
                    <c:param name="flag" value="2"/>
                  	</c:url>
                  ">&lt;</a>
                    </li>
                  </c:if>
                  <c:forEach var ="pg" begin="${pInf2.startPage }" end="${pInf2.endPage }">
                  <c:if test="${pg ==pInf2.currentPage}">
                    <li>
                      <a class="page-link">${pg }</a>
                    </li>
                  </c:if>
                  <c:if test="${pg!=pInf2.currentPage }">
                    <li>
                      <a class="page-link" href="
                      <c:url value="moveEvent">
                      <c:param name="currentPage" value="${pg}" />
                      <c:param name="flag" value="2"/>
                      </c:url>
                      ">${pg }</a>
                    </li>
                  </c:if>
                  </c:forEach>
                    
                    <!-- 다음 페이지로(>) -->
                    <c:if test="${pInf2.currentPage<pInf.maxPage }">
                    <li>
                      <a class="page-link " href="
                      <c:url value="moveEvent">
                      <c:param name="currentPage" value="${pInf2.currentPage+1}"/>
                      <c:param name="flag" value="2"/>
                      </c:url>
                      ">&gt;</a>
                    </li>
                   
                    
                    <!-- 맨 끝으로(>>) -->
                    <li>
                      <a class="page-link " href="
                      <c:url value="moveEvent">
                      <c:param name="currentPage" value="${pInf2.maxPage}"/>
                      <c:param name="flag" value="2"/>
                      </c:url>
                      ">&gt;&gt;</a>
                    </li>
                     </c:if>
                  </ul>
                </div>
              </div>
                  
                  
                  <!-- 페이징바 종료 -->
                </div>
            </div>
        </div>
      </div>
    </div>  
  


  <!-- content 끝 -->
 <jsp:include page="../common/footer.jsp"/>
  
  </div>
</body>

</html>