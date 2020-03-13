<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>KKIRI(끼리)</title>
  <link rel="stylesheet" href="../index 페이지 - 진웅/css/my_profile.css">
</head>

<body>
  <div id="wrapper">
    <jsp:include page="../common/header.jsp"/>
    
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
                    <div class="col-8">${loginMember.memberNickname }</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">성별 : </h5>
                    <div class="col-8">
                    <c:if test="${loginMember.memberGender =='M'}">
                    	남	
                    </c:if>
                    <c:if test="${loginMember.memberGender =='F'}">
                    	여	
                    </c:if>
                   
                    </div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">생년월일 : </h5>
                    <div class="col-8">${loginMember.memberBirth}</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">전화번호 : </h5>
                    <div class="col-8">${loginMember.memberPhone }</div>
                  </div>
                  <div class="row  my-profile-section-element">
                    <h5 class="col-4">이메일 : </h5>
                    <div class="col-8">${loginMember.memberEmail }</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">관심 지역 : </h5>
                    <div class="col-8">
                      <p class="member-interest-location">${loginMember.memberPlace }</p>
                    </div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4">관심 카테고리 : </h5>
                    <div class="col-8">
                    	<c:forEach var="i" varStatus="vs"  items="${loginMember.memberCategory}">
                    	
                      <p class="member-interest">${vs.current}</p>  

                    	</c:forEach>
                    </div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4 ">보유한 티켓 수 :</h5>
                    <div class="col-8">${loginMember.memberTicket }개</div>
                  </div>
                  <div class="row my-profile-section-element">
                    <h5 class="col-4">소개 :  </h5>
                    <p class="col-8 introduce-box">${loginMember.memberIntroduce }</p>
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
          
          if(scrollTop == 0){
              $("#profile-nav-wrap>li:first>a").addClass("active");
          }
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
  

<jsp:include page="../common/footer.jsp"/>
  
</body>

</html>