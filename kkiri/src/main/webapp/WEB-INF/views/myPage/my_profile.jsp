<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>KKIRI(끼리)</title>
</head>

<body>
  <div id="wrapper">
    <jsp:include page="../common/header.jsp">
    <div id="container">
      <div class="container">
        <!-- content 시작 -->
        <div class="row">
          <div class="col-2 nav-wrap">
            <a class="btn active" href="#">프로필</a>
            <a class="btn" href="#">이벤트</a>
            <a class="btn" href="#">티켓</a>
            <a class="btn" href="#">로그아웃</a>
          </div>

          <div class="col-10">

            <ul class="nav nav-tabs" id="profile-nav-wrap">
              <li class="nav-item">
                <a class="wty1 nav-link active move-btn" href="javascript:" tabindex="-1">내 정보</a>
              </li>
              <li class="nav-item">
                <a class="wty1 nav-link move-btn" href="javascript:" tabindex="-1">비밀번호 변경</a>
              </li>
              <li class="nav-item">
                <a class="wty1 nav-link move-btn" href="javascript:" tabindex="-1">환급 계좌</a>
              </li>
              <li class="nav-item">
                <a class="wty1 nav-link move-btn" href="javascript:" tabindex="-1">회원탈퇴</a>
              </li>
            </ul>
            
            <div id="display-profile" class="my-profile-section moving-1" >
              <h4>프로필</h4>
              <div class="row">
                <div class="col-8 ">
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">닉네임 : </h5>
                    <div class="col-8">wonty3000</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">성별 : </h5>
                    <div class="col-8">남</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">생년월일 : </h5>
                    <div class="col-8">1991.12.13</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">전화번호 : </h5>
                    <div class="col-8">010-5625-2489</div>
                  </div>
                  <div class="row  my-profile-section-element">
                    <h5 class="col-4">이메일 : </h5>
                    <div class="col-8">wonty3000@naver.com</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">관심 지역 : </h5>
                    <div class="col-8">
                      <p class="member-interest-location">서울시 은평구</p>
                    </div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4">관심 카테고리 : </h5>
                    <div class="col-8">
                      <p class="member-interest">운동</p>  
                      <p class="member-interest">운동</p>  
                      <p class="member-interest">운동</p>  
                    </div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">보유한 티켓 수 :</h5>
                    <div class="col-8">5개</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4">소개 :  </h5>
                    <p class="col-8 introduce-box">얼음과 같으며 지혜는 날카로우나 갑 속에 든 칼이다 청춘의 끓는 피가 아니더면 인간이 얼마나 쓸쓸하랴? 얼음에 싸인 만물은 얼음이 있을 뿐이다 그들에게 생명을 불어 넣는 것은 따뜻한 봄바람이다 풀밭에 속잎나고 가지에 싹이</p>
                  </div>
                </div>
                <div class="col-4">
                  <h5 class="profile-name">프로필 사진</h5>
                  <img class="profile-img" src="../index 페이지 - 진웅/img/cat-1.jpg" alt="프로필 사진">
                </div>
                <br>
                <div class="btn my-profile-btn">
                  수정하기
                </div>
              </div>
            </div>
    
    
            <div id="display-password" class="my-profile-section moving-1" >
              <h4>비밀번호 변경</h4>
                
                  <div class="row my-profile-tableTitle" >
                    <div class="col-4">
                      현재 비밀번호
                    </div>
                    <input class="passborder" type="password" placeholder="현재 비밀번호를 입력해주세요." >
                  </div>
                  <br>
                  <div class="row my-profile-tableTitle">
                    <div class="col-4">
                      새로운 비밀번호
                    </div>
                    <input class="passborder" type="password" placeholder="새로운 비밀번호를 입력해주세요." >
                  </div>
                  <br>
                  <div class="row my-profile-tableTitle">
                    <div class="col-4">
                      비밀번호 확인
                    </div>
                    <input class="passborder" type="password" placeholder="새로운 비밀번호를 다시 입력해주세요." >
                  </div>
                  <br>
                  <div class="row">

                    <div class="btn my-profile-btn">
                      수정하기
                    </div>
                  </div>
                    
              </div>
              
              <div id="display-account" class="my-profile-section moving-1" >
                <h4>환급 계좌</h4>
                <div class="row my-profile-tableTitle">
                  <div class="col-4">
                    은행
                  </div>
                <input class="passborder" type="text" placeholder="현재 등록된 계좌가 없습니다." readonly disabled>
              </div>
              <br>
              <div class="row my-profile-tableTitle">
                <div class="col-4">
                  계좌번호
                </div>
                <input class="passborder" type="text" placeholder="현재 등록된 계좌가 없습니다.">
              </div>
              <br>
              <div class="row my-profile-tableTitle">
                <div class="col-4">
                  예금주
                </div>
                <input class="passborder" type="text" placeholder="현재 등록된 계좌가 없습니다.">
              </div>
              <br>
              <div class="btn my-profile-btn">
                수정하기
              </div>
            </div>
            
            <div id="display-delete" class="my-profile-section moving-1">
              <h4>회원 탈퇴</h4>
              <br>
              <div id="delete-modal" class="btn my-profile-btn secession-btn">
                회원탈퇴
              </div>
            </div>
          </div>


        </div>
      </div>
    </div>  
    <script>
      // 회원 탈퇴용 확인창 값이 true 면 화면이동
      $(function(){
        $("#delete-modal").click(function(){
          var flag1 = confirm("회원탈퇴 하시겠습니까?");
        });

        var scrollTop=0; 

        $(window).scroll(function(){
          scrollTop = $(window).scrollTop();
          if(scrollTop>230){
            $("#profile-nav-wrap").addClass("sticky").removeClass("nav-tabs");
          }else{
            $("#profile-nav-wrap").removeClass("sticky").addClass("nav-tabs");
          }

          $(".moving-1").each(function(index){
            if($(window).scrollTop()>=$(".moving-1").eq(index).offset().top-300){
              $("#profile-nav-wrap>li>a").removeClass("active");
              $("#profile-nav-wrap>li").eq(index).find("a").addClass("active");
            }else{
              $("#profile-nav-wrap>li").eq(index).find("a").removeClass("active");
            }
          });
        });

        $(".move-btn").each(function(index){
          $(this).on({
            click: function(){
              $('html,body').stop().animate({scrollTop: $('.moving-1').eq(index).offset().top-100},600);
            }
          });
        });

    

      });

    </script>
  


  <!-- content 끝 -->
  <div id="footer">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="row">
            <div class="col-md-4 footer-logo-wrap">
              <img class="footer-logo" src="../index 페이지 - 진웅/img/logo2-white.png" alt="푸터로고">
            </div>
            <div class="col-md-8">
              <p class="copyright">&copy; 2020 KKIRI COMPANY. ALL RIGHTS RESERVED.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div id="button-top">
    <button type="button" class="top-btn">TOP</button>
  </div>
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