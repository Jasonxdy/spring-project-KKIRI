<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
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


            <div class="my_event_wrapper">
              <!-- 내가 만든 이벤트 -->
                <div class="event_content create_event_con my-profile-section">
                  <h4>내가 만든 이벤트</h4>
                  <ul>
                  <c:forEach var="eve" items="${abc }"></c:forEach>
                    <li>
                      <div class="thumb-wrap">
                        <img src="../index 페이지 - 진웅/img/banner-alter-img.png" alt="이벤트썸네일">
                      </div>
                      <div class="sub-con">
                        <p class="event-date">2020년 02월 21일 19:00</p>
                        <p class="event-title">[맛집 도장깨기 2기]</p>
                        <p class="event-location"><img src="../index 페이지 - 진웅/img/map-ping.png" alt="지도마커">&nbsp; 서울시 중구 다산로</p>
                        <p class="event-explanation">
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                        </p>
                      </div>  
                    </li>
                    <li>
                      <div class="thumb-wrap">
                        <img src="../index 페이지 - 진웅/img/banner-alter-img.png" alt="이벤트썸네일">
                      </div>
                      <div class="sub-con">
                        <p class="event-date">2020년 02월 21일 19:00</p>
                        <p class="event-title">[맛집 도장깨기 2기]</p>
                        <p class="event-location"><img src="../index 페이지 - 진웅/img/map-ping.png" alt="지도마커">&nbsp; 서울시 중구 다산로</p>
                        <p class="event-explanation">
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                        </p>
                      </div>  
                    </li>
                    <li>
                      <div class="thumb-wrap">
                        <img src="../index 페이지 - 진웅/img/banner-alter-img.png" alt="이벤트썸네일">
                      </div>
                      <div class="sub-con">
                        <p class="event-date">2020년 02월 21일 19:00</p>
                        <p class="event-title">[맛집 도장깨기 2기]</p>
                        <p class="event-location"><img src="../index 페이지 - 진웅/img/map-ping.png" alt="지도마커">&nbsp; 서울시 중구 다산로</p>
                        <p class="event-explanation">
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                        </p>
                      </div>  
                      <p class="end-event">종료된 이벤트</p>
                    </li>
                  </ul>
                  <button type="button" class="green-radius-btn more-event-btn">더보기</button>
                </div>

                <!-- 내가 참여한 이벤트 --> 
                <div class="event_content participate_event_con my-profile-section">
                  <h4>내가 참여한 이벤트</h4>
                  <ul>
                    <li>
                      <div class="thumb-wrap">
                        <img src="../index 페이지 - 진웅/img/banner-alter-img.png" alt="이벤트썸네일">
                      </div>
                      <div class="sub-con">
                        <p class="event-date">2020년 02월 21일 19:00</p>
                        <p class="event-title">[맛집 도장깨기 2기]</p>
                        <p class="event-location"><img src="../index 페이지 - 진웅/img/map-ping.png" alt="지도마커">&nbsp; 서울시 중구 다산로</p>
                        <p class="event-explanation">
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                        </p>
                      </div>
                      <div class="creator-con">
                        <img src="../index 페이지 - 진웅/img/profile-ex.png" alt="회원아이콘">
                        <p class="creator-id">
                          <span>주최자 아이디</span>
                          <img src="../index 페이지 - 진웅/img/star-on.png" alt="별점">&nbsp;4.2
                        </p>
                      </div>  
                    </li>
                    <li>
                      <div class="thumb-wrap">
                        <img src="../index 페이지 - 진웅/img/banner-alter-img.png" alt="이벤트썸네일">
                      </div>
                      <div class="sub-con">
                        <p class="event-date">2020년 02월 21일 19:00</p>
                        <p class="event-title">[맛집 도장깨기 2기]</p>
                        <p class="event-location"><img src="../index 페이지 - 진웅/img/map-ping.png" alt="지도마커">&nbsp; 서울시 중구 다산로</p>
                        <p class="event-explanation">
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                        </p>
                      </div>
                      <div class="creator-con">
                        <img src="../index 페이지 - 진웅/img/profile-ex.png" alt="회원아이콘">
                        <p class="creator-id">
                          <span>주최자 아이디</span>
                          <img src="../index 페이지 - 진웅/img/star-on.png" alt="별점">&nbsp;4.2
                        </p>
                      </div>  
                    </li>
                    <li>
                      <div class="thumb-wrap">
                        <img src="../index 페이지 - 진웅/img/banner-alter-img.png" alt="이벤트썸네일">
                      </div>
                      <div class="sub-con">
                        <p class="event-date">2020년 02월 21일 19:00</p>
                        <p class="event-title">[맛집 도장깨기 2기]</p>
                        <p class="event-location"><img src="../index 페이지 - 진웅/img/map-ping.png" alt="지도마커">&nbsp; 서울시 중구 다산로</p>
                        <p class="event-explanation">
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                          이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.이벤트 설명 예시입니다.
                        </p>
                      </div>
                      <div class="creator-con">
                        <img src="../index 페이지 - 진웅/img/profile-ex.png" alt="회원아이콘">
                        <p class="creator-id">
                          <span>주최자 아이디</span>
                          <img src="../index 페이지 - 진웅/img/star-on.png" alt="별점">&nbsp;4.2
                        </p>
                        <p class="end-event">종료된 이벤트</p>
                      </div>  
                    </li>
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