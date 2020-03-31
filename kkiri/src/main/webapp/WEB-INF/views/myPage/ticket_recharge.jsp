<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="../resources/css/my_profile.css">
<link rel="stylesheet" href="../resources/css/ticket.css">
<title>KKIRI(끼리)</title>
</head>

<body>
	<div id="wrapper">
		<jsp:include page="../common/header.jsp" />
		<div id="container">
			<div class="container">
				<!-- content 시작 -->
				<div class="row">
					<div class="col-2 nav-wrap">
						<a class="btn " href="../mypage/in">프로필</a> <a class="btn"
							href="../mypage/moveEvent">이벤트</a> <a class="btn"
							href="../mypage/moveFavorite">즐겨찾기</a> <a class="btn active"
							href="../mypage/ticketLog">티켓</a> <a class="btn"
							href="../member/logout">로그아웃</a>
					</div>

					<div class="col-10">

						<ul class="nav nav-tabs" id="profile-nav-wrap">
							<li class="nav-item"><a class="nav-link  move-btn"
								href="../mypage/ticketLog" tabindex="-1">내역</a></li>
							<li class="nav-item"><a class="nav-link active move-btn"
								href="../mypage/recharge" tabindex="-1">충전</a></li>
							<li class="nav-item"><a class="nav-link move-btn"
								href="../mypage/moveRefund" tabindex="-1">환급</a></li>
						</ul>

						<div class="ticket-wrap my-profile-section recharge-wrap">
							<h4>티켓 충전</h4>

							<form  method="post" class="recharge-form"
								onsubmit="return validate();">
								<p class="recharge-title">충전 금액</p>
								<div class="recharge-box">
									<input type="radio" name="recharge-amount" value="1000"
										id="1000"><label for="1000">1,000원</label> <input
										type="radio" name="recharge-amount" value="3000" id="3000"><label
										for="3000">3,000원</label> <input type="radio"
										name="recharge-amount" value="5000" id="5000"><label
										for="5000">5,000원</label>
								</div>
								<div class="recharge-box">
									<input type="radio" name="recharge-amount" value="10000"
										id="10000"><label for="10000">10,000원</label> <input
										type="radio" name="recharge-amount" value="50000" id="50000"><label
										for="50000">50,000원</label> <input type="radio"
										name="recharge-amount" value="100000" id="100000"><label
										for="100000">100,000원</label>
								</div>

								<div class="recharge-way">
									<p class="recharge-title">결제 방식</p>
									<div class="recharge-box">
										<input class="rechargeMethod" type="radio" name="recharge-way"
											value="kakao" id="kakao"><label for="kakao">&nbsp;카카오페이</label>
										<input class="rechargeMethod" type="radio" name="recharge-way"
											value="creditCard" id="creditCard"><label
											for="creditCard">&nbsp;카드 결제</label> <input
											class="rechargeMethod" type="radio" name="recharge-way"
											value="phone" id="phone"><label for="phone">&nbsp;휴대폰
											결제</label>
									</div>
								</div>
								<button id="move-recharge" type="submit">구매</button>
							</form>
							<script type="text/javascript"
								src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
							<script type="text/javascript"
								src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
						</div>
					</div>
				</div>
			</div>

			<script>
				var recharge;
				var memberNo = '${loginMember.memberNo}';
				var memberId = '${loginMember.memberId}';
				$(function(){
					$("#move-recharge").click(function(){
				recharge = $("input[name=recharge-amount]:checked").val();
				var rechargeway = $("input[name=recharge-way]:checked").val();
				var merchant_uid;
				console.log(recharge);
						$.ajax({
							url : "mypage/ticketRecharge" ,
							type : "POST" ,
							data : { "recharge-amount" : recharge,
									"recharge-way" : rechargeway,
									"loginMember" : loginMember },
							success: function(merchant_uid){

								if(merchant_uid != ""){
									Card(merchant_uid);
								}else{
									alert("쿠폰충전중 오류가 발생하여 작업을 취소했습니다.")
									}
								},
							error : function(){
								alert("ajax 통신 실패");
							}
						});
					});
				});
				
				
				// 결제 API 추가
				// buyer_addr : '서울특별시 강남구 삼성동',						    buyer_postcode : '123-456',    $(".recharge-box >input").val()
				var IMP = window.IMP; // 생략가능
				
					
				
				IMP.init('imp13908741'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
					function Card(merchant_uid){
						IMP.request_pay({
						    pg : 'inicis', // version 1.1.0부터 지원.
						    pay_method : 'card',
						    merchant_uid : merchant_uid,
						    name : '주문명:티켓 충전',
						    amount : 100,
						    buyer_email : '${loginMember.memberEmail}',
						    buyer_name : '${loginMember.memberNickname}',
						    buyer_tel : '${loginMember.memberPhone}',
						    
						    // m_redirect_url : '../mypage/ticketRecharge'
						}, function(rsp) {
						    if ( rsp.success ) {
						    	
						    	
						    	
						        var msg = '결제가 완료되었습니다.';
						        msg += '고유ID : ' + rsp.imp_uid;
						        msg += '상점 거래ID : ' + rsp.merchant_uid;
						        msg += '결제 금액 : ' + rsp.paid_amount;
						        msg += '카드 승인번호 : ' + rsp.apply_num;
						        alert(msg);
						        
						        // url로 값을 보냄
						        location.href = "../mypage/successRecharge?recharge="+recharge
						    } else {
						        
						    
						    $.ajax({
						    	url:"mypage/deleteTicket",
						    	type:"POST",
						    	data:
						    		{merchant_uid : rsp.merchant_uid} ,
						    	
						    success: function(){
						    	
						    var msg = '결제에 실패하였습니다.';
					        msg += '에러내용 : ' + rsp.error_msg;
					    alert(msg);
						    }
						    });
						    
						    }
						});
						return true;
					}
				
				</script>

			<script>
    
      function validate(){
    	  var checker = $("input[name=recharge-way]:checked").val();
    	  
        if($("input[name=recharge-amount]:checked").length==0){
        	console.log(checker);
          alert("충전 금액을 선택해주세요!");
          return false;
        }
        if($("input[name=recharge-way]:checked").length==0){
          alert("결제 방식을 선택해주세요!");
          return false;
        }
        return false;
      }
      
    </script>
			<!-- content 끝 -->
			<jsp:include page="../common/footer.jsp" />
		</div>
</body>

</html>