<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="../resources/css/my_profile.css">
  <script src="../resources/js/index.js"></script>
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
            <a class="btn active" href="#">프로필</a>
            <a class="btn" href="#">이벤트</a>
            <a class="btn" href="#">티켓</a>
            <a class="btn" href="#">로그아웃</a>
          </div>

          <div class="col-10">
            
            <div id="secession-member" class="my-profile-section">
              <h4>회원 탈퇴</h4>
              <form action="deleteMember" method="post" class="secession-form" onsubmit="return validate();">
                
                <p class="secession-terms">
                  KKIRI 회원(이하 "회원")을 탈퇴하기 전에 반드시 읽어 주십시오.<br>

                  본 약관은 KKIRI 주식회사(이하 “당사”)가 KKIRI 회원(이하 “회원”)의 탈퇴에 관한 모든 조건을 규정한 것입니다.
                  회원탈퇴를 하실 경우에는 아래의 내용에 동의하신 것으로 간주됩니다.<br>
                  탈퇴 후에는 당사가 운영하는 모든 웹사이트(이하 “KKIRI TRAVEL 사이트”)에서 제공하는 회원 대상 서비스를 이용하실 수 없습니다.<br>
                  보유하신 KKIRI 포인트는 탈퇴하시는 시점부터 전부 무효가 됩니다.<br>
                  탈퇴 후에도 카드결제 등으로 발생한 이용요금 지불책임은 이행해야 합니다.<br>
                  회원 탈퇴 수속이 수리된 후에도 회원정보에 대해서는 당사가 관리하게 됩니다.<br>
                  탈퇴 후에 회원정보를 삭제하는 경우도 있으므로 양해해 주십시오.<br>
                  KKIRI 주식회사<br>
                </p>

                <div class="secession-info-wrap">
                  <p class="info-title">위의 약관에 대해서 동의 하십니까?</p>
                  <div class="info-content">
                    <span class="va_m radio">
                      <input type="radio" class="va_m radio" name="agree-status" value="yes" id="yes">
                    </span>
                    <label for="yes" class="va_m radio">예</label>
                    <span class="va_m radio">
                      <input type="radio" class="va_m radio" name="agree-status" id="no" value="no">
                    </span>                      
                    <label for="no" class="va_m radio">아니오</label>
                  </div>
                  
                  <p class="info-title">비밀번호 확인</p>
                  <input name ="password" type="password" class="form-control" placeholder="비밀번호를 입력해주세요." id="pass-flag">

                  <p class="info-title info-title3">
                    모든 약관에 동의하시며, <br>
                    회원탈퇴를 원하실 경우<br>
                    "회원탈퇴"라고 적어주시기 바랍니다.
                  </p>  
                  <input type="text" class="form-control" id="user-input-secession">
                </div>
                <div class="button-wrap">
                  <button type="button" onclick="location.href='my_profile.jsp'" class="green-radius-btn prev-btn">이전</button>
                  <button class="btn green-radius-btn submit-btn">회원탈퇴</button>
                </div>
              </form>
            </div>
        </div>
      </div>
    </div>
    </div>
   
    <script>
      function maxLengthCheck(object) {
        if (object.value.length > object.maxLength) {
          object.value = object.value.slice(0, object.maxLength);
        }
      }
      function validate(){
        if($(".info-content input[name='agree-status']:checked").val()=="yes"){
          if($("#user-input-secession").val()=="회원탈퇴"){
            	return true
            if($("#pass-flag").val()!=""){
            }else{
            	alert("비밀번호를 입력해주시기 바랍니다.")
            	return false
            }
          }else{
            alert('"회원탈퇴"라고 정확히 입력해주셔야 합니다!');
            return false;
          }
        }else{
          alert("약관에 동의해주셔야 회원탈퇴를 하실 수 있습니다!");
          return false;
        }
      }
   		// 비밀번호 체크 부분

      $("#pass-flag").change(function(){
    	  if($("#pass-flag").val()==""){
    		 alert("비밀번호 확인란을 입력해주세요");
    		 return false;
    	  }else if ($("#pass-flag").val()!=""){
    		  passcheck = true;
    	  }
      })
      
      $(function(){
        $(".uploadBtn").on({
          "click" : function(){
            $(".uploadInput").click();
          }
        });
      });
      function loadImg(value){
          if(value.files && value.files[0]){
            var reader = new FileReader();
            reader.onload = function(e){
              $(".profile-img").prop("src",e.target.result);
            }
          }
          reader.readAsDataURL(value.files[0]);
      }
    </script>
  <!-- content 끝 -->
  <jsp:include page="../common/footer.jsp"/>
</body>

</html>