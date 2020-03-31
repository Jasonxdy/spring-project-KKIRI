<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../resources/css/findId.css">
    <script src='../resources/js/index.js'></script>

    
    <title>KKIRI(끼리)</title>
    </head>
    <body>
      <div id="wrapper">
		<jsp:include page="../common/header.jsp"/>
        <div id="container">
          <!-- 배너 start -->
          
         <script>
           $(function(){
            $(".nav-tabs>li>a").each(function(i){ 
              $(this).on({
                click : function(){
                  $(".nav-tabs>li>a").removeClass("active");
                  $(this).addClass("active");
                  $(".tab-pane").hide(0);
                  $(".tab-pane").eq(i).show(0);
                }
              });
            });
           });
         </script>
          <div class="container">
            
              <ul class="nav nav-tabs">
                <li class="nav-item">
                  <a class="nav-link active" data-toggle="tab">아이디 찾기</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" data-toggle="tab">비밀번호 찾기</a>
                </li>
               
              </ul>
              <div class="tab-content">
                <div class="tab-pane active" id="id1">
                  <br>
                  <br>
                  <h2 class="tab-title" style="text-align: center;">회원님의 아이디를 찾아드립니다.</h2>
                  <br>
                  <br>

                  <form action="findId" method="POST" class="common-form" onsubmit="return validate1();">

                      <div>

                        <div class=" mb-3" >
                          
                          <label for="memberEmail" class="findInfo-title">회원님의 이메일을 입력해주세요.</label>
                          <input type="email" id="memberEmail" name="findIdEmail" class="form-control memberEmail" placeholder="회원님의 이메일"> 
                          <p class="checkEmail">&nbsp;</p>

                        </div>
                      </div>
                      
                      <br>
                      <br>
                      <div style="text-align: center;">
                        <button type="submit" id="emailButton" class="green-radius-btn" >아이디 찾기</button>
                      </div>
                      <br>
                  </form>
                  
                </div>

                <div class="tab-pane" id="id2">
                  <br>
                  <br>
                  <h2 class="tab-title" style="text-align: center;">회원님의 비밀번호를 찾아드립니다.</h2>
                  <br>
                  <br>
                  <form action="findPwd" method="post" class="common-form" onsubmit="return validate2();">

                    <div style="text-align: center; margin: 0 auto;">

                      <div class=" mb-3" >
                        <label for="memberId" class="findInfo-title">회원님의 아이디를 입력해주세요.</label>
                        <input type="text" id="memberId" name="memberId" class="form-control" placeholder="회원님의 아이디">
                        <p class="checkId">&nbsp;</p>
                      </div>
                    </div>
                    <div style="text-align: center; margin: 0 auto;">
                      <div class=" mb-3" >
                        <label for="memberEmail2" class="findInfo-title">회원님의 이메일을 입력해주세요.</label>
                        <input type="email" id="memberEmail2" name="memberEmail" class="form-control memberEmail" placeholder="회원님의 이메일">
                        <p class="checkEmail">&nbsp;</p>
                      </div>
                    </div>
                    <br>
                    <div style="text-align: center;">
                      <button type="submit" class="green-radius-btn" id="pwdButton">비밀번호 찾기</button>&nbsp;&nbsp;
                    </div>
                  </form>
                </div> 
              </div>
          </div>
         </div>
          <script>
            var memberEmail1 = false;
            
            var findPwdCondition = {
              "memberId" : false,
              "memberEmail2" : false
            }

            $(function(){
              // 아이디 찾기 탭 - 이메일 유효성 검사
              $("#memberEmail").on({
                "input" : function(){
                  var regExp =  /^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/; // 한글 두 글자 이상
                  if(!regExp.test($(this).val())){ 
                    $(this).next(".checkEmail").text("이메일 형식이 유효하지 않습니다.").css({"color":"red"});
                    memberEmail1=false;
                  }else{
                    $(this).next(".checkEmail").text("유효한 이메일 형식입니다.").css({"color":"green"});
                    memberEmail1=true;
                  }
                }
              });

              // 비밀번호 찾기 탭 - 1) 아이디 유효성 검사
              $("#memberId").on({
                "input" : function(){
                  var regExp =  /^[a-z][a-zA-z\d]{5,11}$/; // 첫글자는 영어 소문자, 나머지 글자는 영어 대,소문자 + 숫자, 총 6~12글자
                  if(!regExp.test($(this).val())){ 
                    $(this).next(".checkId").text("아이디 형식이 유효하지 않습니다.").css({"color":"red"});
                    findPwdCondition.memberId=false;
                  }else{
                    $(this).next(".checkId").text("유효한 아이디 형식입니다.").css({"color":"green"});
                    findPwdCondition.memberId=true;
                  }
                }
              });

              // 비밀번호 찾기 탭 - 2) 이메일 유효성 검사
              $("#memberEmail2").on({
                "input" : function(){
                  var regExp =  /^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/; // 한글 두 글자 이상
                  if(!regExp.test($(this).val())){ 
                    $(this).next(".checkEmail").text("이메일 형식이 유효하지 않습니다.").css({"color":"red"});
                    findPwdCondition.memberEmail2=false;
                  }else{
                    $(this).next(".checkEmail").text("유효한 이메일 형식입니다.").css({"color":"green"});
                    findPwdCondition.memberEmail2=true;
                  }
                }
              });
            });

            // 첫번째 탭(아이디 찾기) FORM 전달 검사 이벤트
            function validate1(){
              if(memberEmail1==false){
                alert("이메일 형식이 유효하지 않습니다. 이메일을 다시 확인해주세요.");
                $("#memberEmail").focus();
                return false;
              }
            }

             // 두번째 탭(비밀번호 찾기) FORM 전달 검사 이벤트
             function validate2(){
              for(var key in findPwdCondition){
                if(!findPwdCondition[key]){
                  alert("일부 입력값이 잘못되었습니다.");
                  var id = "#"+key;
                  $(id).focus();
                  return false;
                }
              }
            }

          </script>
<jsp:include page="../common/footer.jsp"/>

    </body>
</html>
