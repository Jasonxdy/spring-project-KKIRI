<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" href="../resources/css/my_profile.css">
  <link rel="stylesheet" href="../resources/css/ticket.css">
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
            <a class="btn" href="../mypage/moveFavorite">즐겨찾기</a>
            <a class="btn active" href="../mypage/ticketLog">티켓</a>
            <a class="btn" href="../member/logout">로그아웃</a>
          </div>

          <div class="col-10">

            <ul class="nav nav-tabs" id="profile-nav-wrap">
              <li class="nav-item">
                <a class="nav-link  move-btn" href="../mypage/ticketLog" tabindex="-1">내역</a>
              </li>
              <li class="nav-item">
                <a class="nav-link move-btn" href="../mypage/recharge" tabindex="-1">충전</a>
              </li>
              <li class="nav-item">
                <a class="nav-link active move-btn" href="../mypage/moveRefund" tabindex="-1">환급</a>
              </li>
            </ul>

            <div class="ticket-wrap my-profile-section refund-wrap">
              <h4>환급</h4>
              
              <div class="notify-wrap">
                <p class="notify-title">환급 신청 시 참고사항</p>
                <p class="notify-content">
                  1. 환급은  티켓 10장 이상부터 가능합니다.<br>
                  2. 환급 시 티켓 금액의 10%를 환급 수수료로 공제한 금액을 환급해 드립니다.<br>
                  3. 환급은 계정에 등록된 계좌로 입금됩니다. 등록된 계좌가 없으실 경우 등록후 이용해 주시기 바랍니다.<br>
                  4. 환급이 아닌 구매한 티켓에 대한 환불은 고객센터 1:1 문의를 이용하여 주시기 바랍니다.<br>
                </p>
              </div>

              <div class="refund-con-wrap">
                <p class="title">내가 보유한 티켓</p>      
                <span class="con">${loginMember.memberTicket }</span>
              </div>

              <form class="refund-form" action="costTicket" method="POST" onsubmit="return validate();">
                <p class="title">환급 받을 티켓</p>
                <p class="account-info" id="accountFlag">
               
                <c:if test="${loginMember.memberAccount !=null}">
               <c:set var="Account" value="${fn:replace(loginMember.memberAccount, ',', ' ')}"/>
                
                
               환급 계좌 : ${Account}
                </c:if>
                
                <c:if test="${loginMember.memberAccount==null}">
                	등록된 계좌가 없습니다.
                </c:if>
                </p>
                <input class="refundTicket" type="number" name="refundTicket" placeholder="티켓 수 입력">
                <p class="refund-status"></p>
				<input class="refundTicketPWD" type="password" name="memberPassword" placeholder="비밀번호 입력">
                <button class="refund-submit-btn blue-radius-btn" id="refund-button">환급 신청</button>
              </form>
            </div>
          </div>
      </div>
    </div>  
  
    <script>

    var ticketCount = ${loginMember.memberTicket};
    
    
      $(function(){
        $(".refundTicket").on({
          input : function(){
            if($(this).val().trim()==""){
              $(".refund-status").text("");
            }else if($(this).val()<10){
              $(".refund-status").text("환급은 10장 이상부터 가능합니다.").css({"color":"red"});
            }else {
              refundMoney = parseInt($(this).val()*0.9*1000);
              $(".refund-status").text("총 "+refundMoney+"원 환급됩니다.").css({"color":"green"});
            }
          }
        });
      });

      $(function(){
 		  $("#refund-button").click(function(){
 	 		 if($("#accountFlag").text().trim()=="등록된 계좌가 없습니다."){
 	 			 alert("등록된 계좌가 없습니다.");
 	 			 return false;
 		 		 $("#refund-button").prop("disable","true");
 	 		 	}
 		  })
 		  
 		  
 		  
      })
      
      
      
      function validate(){
        if($(".refundTicket").val()<10){
          $(".refund-status").text("환급은 10장 이상부터 가능합니다.").css({"color":"red"});
          return false;
        }
        if($(".refundTicket").val()>ticketCount){
        	alert("보유 티켓보다 많이 환급신청을 할 수 없습니다.");
        	return false;
        }
      }
    </script>

  <!-- content 끝 -->
  <jsp:include page="../common/footer.jsp"/>
  </div>
</body>

</html>