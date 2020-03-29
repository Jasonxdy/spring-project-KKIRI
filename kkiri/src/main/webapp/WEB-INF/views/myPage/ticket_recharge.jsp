<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <a class="nav-link active move-btn" href="../mypage/recharge" tabindex="-1">충전</a>
              </li>
              <li class="nav-item">
                <a class="nav-link move-btn" href="../mypage/moveRefund" tabindex="-1">환급</a>
              </li>
            </ul>

            <div class="ticket-wrap my-profile-section recharge-wrap">
              <h4>티켓 충전</h4>
              
              <form action="ticketRecharge" method="get" class="recharge-form" onsubmit="return validate();">
                <p class="recharge-title">충전 금액</p>
                <div class="recharge-box">
                  <input type="radio" name="recharge-amount" value="1000" id="1000"><label for="1000">1,000원</label>
                  <input type="radio" name="recharge-amount" value="3000" id="3000"><label for="3000">3,000원</label>
                  <input type="radio" name="recharge-amount" value="5000" id="5000"><label for="5000">5,000원</label>
                </div>
                <div class="recharge-box">
                  <input type="radio" name="recharge-amount" value="10000" id="10000"><label for="10000">10,000원</label>
                  <input type="radio" name="recharge-amount" value="50000" id="50000"><label for="50000">50,000원</label>
                  <input type="radio" name="recharge-amount" value="100000" id="100000"><label for="100000">100,000원</label>
                </div>

                <div class="recharge-way">
                  <p class="recharge-title">결제 방식</p>
                  <div class="recharge-box">
                    <input type="radio" name="recharge-way" value="kakao" id="kakao"><label for="kakao">&nbsp;카카오페이</label>
                    <input type="radio" name="recharge-way" value="creditCard" id="creditCard"><label for="creditCard">&nbsp;카드 결제</label>
                    <input type="radio" name="recharge-way" value="phone" id="phone"><label for="phone">&nbsp;휴대폰 결제</label>
                  </div>
                </div>

                <button type="submit">구매</button>
              </form>
            </div>
          </div>
      </div>
    </div>  
  
    <script>
      function validate(){
        if($("input[name=recharge-amount]:checked").length==0){
          alert("충전 금액을 선택해주세요!");
          return false;
        }else if($("input[name=recharge-way]:checked").length==0){
          alert("결제 방식을 선택해주세요!");
          return false;
        }else{
          return true;
        }

      }
    </script>
https://developers.kakao.com/docs/restapi/kakaopay-api#시작하기-전에
https://developers.kakao.com/docs/restapi/kakaopay-api#결제프로세스
https://developers.kakao.com/docs/restapi/kakaopay-api#단건결제-프로세스
  <!-- content 끝 -->
	<jsp:include page="../common/footer.jsp"/>
  </div>
</body>

</html>