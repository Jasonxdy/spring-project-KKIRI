<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap&subset=korean"
  rel="stylesheet">
  <link rel="stylesheet" href="../resources/css/my_profile.css">

  
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
            <a class="btn active" href="../mypage/in">프로필</a>
            <a class="btn" href="../mypage/event">이벤트</a>
            <a class="btn" href="../mypage/ticket">티켓</a>
            <a class="btn" href="${contextPath}/member/logout">로그아웃</a>
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
                    <div class="col-8">
                    ${fn:substring(loginMember.memberBirth,0,4) }년 &nbsp;
                    ${fn:substring(loginMember.memberBirth,5,7) }월  &nbsp;
                    ${fn:substring(loginMember.memberBirth,8,10) }일
                    
                    </div>
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
                    <c:set var="category" value="${fn:split(loginMember.memberCategory,',') }" />
                    	<c:forEach var="i" varStatus="vs"  items="${category}">
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
                  <img class="profile-img" src="../resources/img/${loginMember.memberProfile}" alt="프로필 사진">
                </div>
                <br>
                <button class="btn my-profile-btn" id="updateMyPage">
                  수정하기
                </button>
              </div>
            </div>
    
    
            <form id="display-password" class="my-profile-section moving-1" action="updatePassword" onsubmit="return passCheck();" method="POST">
              <h4>비밀번호 변경</h4>
                
                  <div class="row my-profile-tableTitle" >
                    <div class="col-4">
                      현재 비밀번호
                    </div>
                    <input class="passborder" type="password" placeholder="현재 비밀번호를 입력해주세요." name ="originPassword" >
                  </div>
                  <br>
                  <div class="row my-profile-tableTitle">
                    <div class="col-4">
                      새로운 비밀번호
                    </div>
                    <input id="passCheck1" class="passborder" type="password" placeholder="새로운 비밀번호를 입력해주세요." name ="changePassword" >
                  </div>
                  <br>
                  <div class="row my-profile-tableTitle">
                    <div class="col-4">
                      비밀번호 확인
                    </div>
                    <input id="passCheck2" class="passborder" type="password" placeholder="새로운 비밀번호를 다시 입력해주세요." >
                  </div>
                  <br>
                  <div class="row">

                    <button class="btn my-profile-btn" type="submit" >
                      수정하기
                    </button>
                  </div>
                    
              </form>
              
              <form id="display-account" class="my-profile-section moving-1" action="../mypage/updateAccount" onsubmit="">
              <c:set var="banks" value="${fn:split(loginMember.memberAccount, ',')}"/>
                <h4>환급 계좌</h4>
                <div class="row my-profile-tableTitle">
                  
                  
                  <div class="col-4">
                    은행
                  </div>
                <select class="passborder" name="bankName" >
                
                	<option value="null"
                <c:if test="${loginMember.memberAccount ==null }">
                	selected
                </c:if>
                	>등록된 은행이 없습니다.</option>
                
                    <option value="국민" <c:if test="${fn:substring(loginMember.memberAccount,0,2)  == '국민'}">selected</c:if>>국민은행</option>
                    <option value="우리" <c:if test="${fn:substring(loginMember.memberAccount,0,2)  == '우리'}">selected</c:if>>우리은행</option>
                    <option value="신한" <c:if test="${fn:substring(loginMember.memberAccount,0,2)  == '신한'}">selected</c:if>>신한은행</option>
                    <option value="농협" <c:if test="${fn:substring(loginMember.memberAccount,0,2)  == '농협'}">selected</c:if>>농협은행</option>
                    <option value="기업" <c:if test="${fn:substring(loginMember.memberAccount,0,2)  == '기업'}">selected</c:if>>기업은행</option>
                    <option value="하나" <c:if test="${fn:substring(loginMember.memberAccount,0,2)  == '하나'}">selected</c:if>>하나은행</option>

                  </select>
              </div>
              <br>
              <div class="row my-profile-tableTitle">
                <div class="col-4">
                  계좌번호
                </div>
                <input class="passborder" type="text" placeholder="현재 등록된 계좌가 없습니다." name="bankNumber" 
                <c:if test="${loginMember.memberAccount !=null }">
                	value ="${banks[1]}"
                	
                </c:if> >
              </div>
              <br>
              <div class="row my-profile-tableTitle">
                <div class="col-4">
                  예금주
                </div>
                <input class="passborder" type="text" placeholder="현재 등록된 계좌가 없습니다." name="bankOrner" 
                <c:if test="${loginMember.memberAccount !=null }">
                	value ="${banks[2]}"
                </c:if> >
                
              </div>
              <br>
              <button class="btn my-profile-btn" type="submit" >
                수정하기
              </button>
            </form>
            
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
    
    // 로그인이 되어 있지 않으면 메인을 ㅗ보냄
    
    $(function(){
    	if(${loginMember == null}){
    		location.href="../mypage/main";	
    	}
    })
    
	$(function(){
		$("#updateMyPage").click(function(){
			location.href="../mypage/updateMyPage";
		})
	})

    
    
    // 비밀번호 정규표현식 확인용
    function passCheck(){
	    var regExp = /^[A-Za-z0-9]{6,12}$/;
	    	
	    if(!regExp.test($("#passCheck1").val())){
	    		alert("유효하지 않은 양식의 비밀번호 입니다.");
	    		return false;
	    	console.log("passcheck gg");
	    	
	    }
    	if($("#passCheck1").val()!=$("#passCheck2").val()){
    		alert("변경된 비밀번호가 다릅니다. 다시 확인해주시기 바랍니다.");
    		return false;
    	}


    }
    
      $(function(){
    	  
    	  
    	  
      // 회원 탈퇴용 확인창 값이 true 면 화면이동
    	  
        $("#delete-modal").click(function(){
          var flag1 = confirm("회원탈퇴 하시겠습니까?");
        	if(flag1){
        		location.href="movedeleteMember";
        	}
        
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