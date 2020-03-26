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
            <a class="btn" href="#">프로필</a>
            <a class="btn active" href="#">이벤트</a>
            <a class="btn" href="#">티켓</a>
            <a class="btn" href="#">로그아웃</a>
          </div>

          <div class="col-10">

            <ul class="nav nav-tabs" id="profile-nav-wrap">
              <li class="nav-item">
                <a class="nav-link active move-btn" href="javascript:" tabindex="-1">내가 만든 이벤트</a>
              </li>
              <li class="nav-item">
                <a class="nav-link move-btn" href="javascript:" tabindex="-1">내가 참여한 이벤트</a>
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
                <div class="event_content create_event_con my-profile-section">
                  <h4>내가 만든 이벤트</h4>
                  <ul>
                  <c:forEach var="eve" items="${eList}">
                 
                    <li>
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
                      </div>  
                    </li>
                  </c:forEach>
                  </ul>
                  <button type="button" class="green-radius-btn more-event-btn">더보기</button>
                </div>

                <!-- 내가 참여한 이벤트 --> 
                <div class="event_content participate_event_con my-profile-section">
                  <h4>내가 참여한 이벤트</h4>
                  <ul>
                  <c:forEach var="ele" items="${ejList}">
                    <li>
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
                        
                        </c:if>
                      </div>  
                    </li>
                    </c:forEach>
                    
                  </ul>
                  <button type="button" class="green-radius-btn more-event-btn">더보기</button>
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