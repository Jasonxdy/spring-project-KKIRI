<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/signUp.css">
  <title>KKIRI(끼리)</title>
</head>

<body>
<div id="wrapper">
<jsp:include page="../common/header.jsp"/>
  
    <div id="container">
      <div class="signUp">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <h2 class="section-title">회원가입</h2>
              <div class="progress-bar-wrap">
                <p class="progress-bar-percent"></p>
              </div>
              <form class="signUpForm" action="createId" method="post" enctype="multipart/form-data" onsubmit="return validate();">
                <div class="step1 select-location step">
                  <h3 class="signUpTitle">1단계. 회원님의 관심 지역을 선택해주세요</h3>
                  <p class="sub-title">선택하신 관심 지역을 기반으로 이벤트를 추천해드리고, 다른 회원님과 연결해드립니다.</p>
                  
                  <!-- 다음 지도창 -->
                  <div id="map" style="width:50%;height:300px;margin:auto"></div>
                  <br>
                   <!-- 다음 지도창 끝-->
                  
                  <div class="input-location-wrap">
                  <img src="<%=request.getContextPath() %>/resources/img/search-icon.png" alt="찾기" class="search-icon"
                 		onclick="sample5_execDaumPostcode()" >
                    
                    <input type="text" name="memberLocation" placeholder="주소 검색" class="interest-location-input"
                    	id="sample5_address" onclick="sample5_execDaumPostcode()" readonly>
                  </div>
                  <input class="locationResult" type="text" name="locationResult" value="서울시 동대문구" readonly class="interest-location-input-result"
                  	style="display:none">

					<!-- https://hongku.tistory.com/250   지도-->
					<!-- 다음 지도 -->
					
					<!--  <input type="text" id="sample5_address" placeholder="주소"> -->
					<!--  <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br> -->
					
					<!-- 다음 지도 끝 -->
					
					<br>
					
															<!-- location.href='home' -->
                  <button type="button" class="go-main green-radius-btn" onclick="location.href='${contextPath}'">메인으로</button>
                  <button type="button" class="go-step2 green-radius-btn">2단계로</button>
                </div>
                <div class="step2 select-interest step">
                  <h3 class="signUpTitle">2단계. 회원님의 관심사를 선택해주세요</h3>
                  <p class="sub-title">선택하신 관심사를 기반으로 이벤트를 추천해드리고, 관심사가 비슷한 회원님들과 더욱 편하게 만날 수 있습니다.</p>
                  <div class="interest-wrap">
                    <input type="checkbox" name="memberInterest" value="여행" id="travel"><label for="travel">여행</label>
                    <input type="checkbox" name="memberInterest" value="운동" id="exercise"><label for="exercise">운동</label>
                    <input type="checkbox" name="memberInterest" value="독서" id="book"><label for="book">독서</label>
                    <input type="checkbox" name="memberInterest" value="비즈니스" id="business"><label for="business">비즈니스</label>
                    <input type="checkbox" name="memberInterest" value="언어" id="language"><label for="language">언어</label>
                    <input type="checkbox" name="memberInterest" value="음악" id="music"><label for="music">음악</label>
                    <input type="checkbox" name="memberInterest" value="영화/공연" id="movie"><label for="movie">영화/공연</label>
                    <input type="checkbox" name="memberInterest" value="댄스" id="dance"><label for="dance">댄스</label>
                    <input type="checkbox" name="memberInterest" value="봉사활동" id="volunteer"><label for="volunteer">봉사활동</label>
                    <input type="checkbox" name="memberInterest" value="사교" id="meeting"><label for="meeting">사교</label>
                    <input type="checkbox" name="memberInterest" value="차/오토바이" id="car"><label for="car">차/오토바이</label>
                    <input type="checkbox" name="memberInterest" value="사진/영상" id="picture"><label for="picture">사진/영상</label>
                    <input type="checkbox" name="memberInterest" value="스포츠관람" id="watchingSports"><label for="watchingSports">스포츠관람</label>
                    <input type="checkbox" name="memberInterest" value="게임" id="game"><label for="game">게임</label>
                    <input type="checkbox" name="memberInterest" value="요리" id="cook"><label for="cook">요리</label>
                    <input type="checkbox" name="memberInterest" value="반려동물" id="pet"><label for="pet">반려동물</label>
                    <input type="checkbox" name="memberInterest" value="사회운동" id="socialMovement"><label for="socialMovement">사회운동</label>
                    <input type="checkbox" name="memberInterest" value="뷰티" id="beauty"><label for="beauty">뷰티</label>
                    <input type="checkbox" name="memberInterest" value="패션" id="fashion"><label for="fashion">패션</label>
                    <input type="checkbox" name="memberInterest" value="기타" id="etc"><label for="etc">기타</label>
                  </div>
                  <button type="button" class="go-step1 green-radius-btn">1단계로</button>
                  <button type="button" class="go-step3 green-radius-btn">3단계로</button>
                </div>
                <div class="step3 input-info step" id="step3">
                    <h3 class="signUpTitle">3단계. 회원님의 정보를 입력해주세요.</h3>
                    <p class="sub-title"><strong class='require'>필수</strong>표시는 필수적으로 입력하셔야 합니다.</p>
                    <div class="insert-member-info">
                      <label><strong class='require'>필수</strong>&nbsp;프로필 사진</label>
                      <input type="file" id="isFile" class="uploadInput" name="uploadProfile" onchange="loadImg(this)">
                      <div class="uploadImgWrap">
                        <img class="uploadImg">
                        <button type="button" class="uploadBtn">사진 업로드</button>
                      </div><br>
                      <label for="memberId"><strong class='require'>필수</strong>&nbsp;아이디</label>
                      <input type="text" name="memberId" id="memberId"><br>
                      <div >
                            <span id="checkId">&nbsp;</span>
                        </div>
                      
                      <label for="memberPwd"><strong class='require'>필수</strong>&nbsp;비밀번호</label>
                      <input type="password" name="memberPwd" id="memberPwd"><br>
                      <div >
                            <span id="checkPwd">&nbsp;</span>
                        </div>
                        
                      <label for="memberPwd2"><strong class='require'>필수</strong>&nbsp;비밀번호 확인</label>
                      <input type="password" name="memberPwd2" id="memberPwd2"><br>
                      <div>
                            <span id="checkPwd2">&nbsp;</span>
                        </div>
                      
                      <label for="memberNickname"><strong class='require'>필수</strong>&nbsp;닉네임</label>
                      <input type="text" name="memberNickname" id="memberNickname"><br>
                      <div>
                            <span id="checkNickName">&nbsp;</span>
                        </div>
                      
                      <p><strong class='require'>필수</strong>&nbsp;전화번호</p>
                      <!-- <input type="number" class="memberPhone" name="memberPhone1" id="memberPhone1" maxlength="3" oninput="maxLengthCheck(this)">- -->
                      		<select class="custom-select mb-1" id="memberPhone1" name="memberPhone1"
                      			style="margin:0; padding:5px;" required>
                                <option>010</option>
                                <option>011</option>
                                <option>016</option>
                                <option>017</option>
                                <option>019</option>
                            </select>-
                      <input type="number" class="memberPhone" name="memberPhone2" id="memberPhone2" maxlength="4" oninput="maxLengthCheck(this)">-
                      <input type="number" class="memberPhone" name="memberPhone3" id="memberPhone3" maxlength="4" oninput="maxLengthCheck(this)"><br>
                      <div>
                            <span id="checkPhone">&nbsp;</span>
                        </div>
                      
                      <label for="memberEmail"><strong class='require'>필수</strong>&nbsp;이메일</label>
                      <input type="email" name="memberEmail" id="memberEmail"><br>
                      <div>
                            <span id="checkEmail">&nbsp;</span>
                      </div>
                       
                      <div class="container text-center" id="loading">
						<img style="height: 3rem;" src="${contextPath}/resources/img/loading.gif">
					  </div>
                      <div id="ECD">
	                      <label for=""><strong class='require'>필수</strong>&nbsp;이메일 인증</label>
	                      <button id="emailConfirmBtn" class="btn btn-outline-dark mb-1" type="button">인증번호 받기</button>
	                      <input id="emailConfirmInput" type="text" style="width:11%;" placeholder="인증번호">
	                      <%-- <input id="emailConfirmNo" type="text" style="display:none;" value="${confirmNo}"> --%>
	                      <div id="emailConfirmSpan" style="display:inline-block; width:25%"></div>
                      </div>
                      <script>
                      	
                      </script>
                      
                      <label for="memberBirth"><strong class='require'>필수</strong>&nbsp;생년월일</label>
                      <input type="date" name="memberBirth" id="memberBirth"><br>
                      
                      <p><strong class='require'>필수</strong>&nbsp;성별</p>
                      <label for="male" class="gender-label"><input type="radio" class="memberGender" name="memberGender" value="M" id="male">남자</label>
                      <label for="female" class="gender-label"><input type="radio" class="memberGender" name="memberGender" value="F" id="female">여자</label><br>
                      <p>본인 계좌번호</p>
                      <select name="memberBankName">
                        <option value="none">은행선택</option>
                        <option value="신한은행">신한은행</option>
                        <option value="국민은행">국민은행</option>
                        <option value="우리은행">우리은행</option>
                        <option value="하나은행">하나은행</option>
                      </select>
                      <input type="text" class="memberBankNumber" name="memberBankNumber" placeholder="계좌번호입력('-' 없이 입력해주세요.)"><br>
                      
                      <label for="memberAccountName" class="memberIntroduceTitle">예금주명</label>
                      <input type="text" class="memberAccountName" name="memberAccountName" placeholder="예금주명"><br>
                      
                      <label for="memberIntroduce" class="memberIntroduceTitle">자기소개</label>
                      <textarea name="memberIntroduce" id="memberIntroduce" rows="8" cols="80" placeholder="내용을 입력해주세요."></textarea><br>
                      <button type="button" class="go-step2 green-radius-btn mt-4">2단계로</button>
                      <button class="go-step4 green-radius-btn mt-4">회원가입</button>
                    </div>
                  </div>
                  
                  <div class="step4 signUp-complete step">
                    <h3 class="signUpTitle">회원가입 성공!</h3>
                    <p class="sub-title">KKIRI의 회원이 되신 것을 환영합니다.</p>

                    <button type="button" class="green-radius-btn mt-4" onclick="location.href='${contextPath}'">메인으로</button>
                  </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
   </div>
    <!-- 회원가입 관련 스크립트 -->
    <script>
      $(function() {
        $(".go-step1").on({
          click: function() {
            $(".progress-bar-percent").css({
              "width": "25%"
            });
            $(".step").stop().fadeOut(300);
            $(".step1").delay(300).fadeIn(300);
          }
        });
        $(".go-step2").on({
          click: function() {
            if($(".interest-location-input").val().trim() == ""){
              alert("관심지역을 먼저 설정해주세요!");
              return false;
            }else{
              $(".progress-bar-percent").css({"width": "50%"});
              $(".step").stop().fadeOut(300);
              $(".step2").delay(300).fadeIn(300);
            }
          }
        });
        $(".go-step3").on({
          click : function(){
            if($(".interest-wrap>input[name=memberInterest]:checked").length == 0){
              alert("적어도 한개 이상의 관심사를 선택해주세요!");
              return false;
            }else{
              $(".progress-bar-percent").css({"width" : "75%"});
              $(".step").stop().fadeOut(300);
              $(".step3").delay(300).fadeIn(300);
            }
          }
        });
       
        
      });
      
      
      // 유효성 검사 
    	  var createIdCheck={
    		 // "isFile":false,  // 파일 확장자 유효성체크
    		  
    		  "memberProfile":false,
    		  "memberId":false, // 입력확인, 아이디 유효성, 중복 검사
    		  "memberIdUnique":false,
    		  "memberPwd":false, // 입력 확인, 비번 유효성
    		  "memberPwd2":false, // 중복검사
    		  
    		  "memberNickname":false, //중복 검사, 입력확인
    		  "memberNickUnique":false,
    		  
    		  "memberPhone":false,
    		  "memberEmail":false, //중복 검사, 입력확인
    		  "memberEmailConfirm":false, //중복 검사, 입력확인
    		  "memberBirth":false, //입력 확인
    		  "memberGender":false //입력 확인 
    	  };
    	  
    		$(document).ready(function(){
    			$("#loading").hide();
    			
    			/* var $isFile = $('isFile').val();
    			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/; */
    			
    			var $memberId = $("#memberId");
    			var $memberIdUnique = $("memberIdUnique");
    			var $memberPwd = $("#memberPwd");
    			var $memberPwd2 = $("#memberPwd2");
    			
    			var $memberNickname = $("#memberNickname");
    			var $memberNickUnique = $("#memberNickUnique");
    			
				var $memberPhone = ("#memberPhone");
    		/* 	var $memberPhone1 = $("#memberPhone1"); */
    			var $memberPhone2 = $("#memberPhone2");
    			var $memberPhone3 = $("#memberPhone3");
    		
    			var $memberEmail = $("#memberEmail");
    			var $memberEmailUnique = $("#memberEmailUnique");
    			
    			var $memberBirth = $("#memberBirth");
    			var $memberGender = $(".memberGender");
    			
    			
    			
    			
			      // 이미지 종류 유효성 검사
			      /*  $isFile.on("input", function(){
						if($(!isFile.match(fileForm)){
							alert("이미지 파일만 업로드 가능")
							createIdCheck.isFile = false;
						}else{
							createIdCheck.isFile = true;
						}
					});  */
			      
					/*   if(!#isFile.match(fileForm)) {
			    	alert("이미지 파일만 업로드 가능");
			        return false;
			    	} */
			    	
					
			    /*    $isFile.on("input",function(){
			    	  if(!isFile.match(fileForm)) {
					    	alert("이미지 파일만 업로드 가능");
					    	createIdCheck.isFile = false;
					    }else{
					    	createIdCheck.isFile = true;
					    }
			      })
			        */
					 
			      
			    
			      
    			
    			
				$memberId.on("input" , function(){
					
					var regExp = /^[a-z][a-zA-z\d]{5,11}$/;
					if(!regExp.test($memberId.val())){
						$("#checkId").text("아이디 형식을 확인").css("color", "#c82333" );
						
						createIdCheck.memberId=false;
					}else{
						
						createIdCheck.memberId=true;
						$.ajax({
							url: "idUniqueCheck",
							data: {memberId: $memberId.val() },
							type : "post",
							success : function(result){
								
								if(result == "true"){
									$("#checkId").text("아이디 사용가능").css("color", "#00a185" );
									createIdCheck.memberIdUnique = true;
								}else{
									$("#checkId").text("이미 등록된 아이디").css("color", "#c82333" );
									createIdCheck.memberIdUnique = false;
								}
							},
							error: function(e){
								console.log("ajax 통신 실패");
	                			console.log(e);
							}
							
						}); // ajax 끝
						
						
					}
					
				});
    			
				// 비번
				$memberPwd.on("input", function(){
					
					var regExp = /^[a-zA-Z0-9~!@#$%^&*()_+]{6,15}$/;
					if(!regExp.test($memberPwd.val())){
						$("#checkPwd").text("비밀번호 형식을 확인").css({"color": "#c82333"});
						createIdCheck.memberPwd = false;
					}else{
						$("#checkPwd").text("사용 가능한 비밀번호").css({"color": "#00a185"});
						createIdCheck.memberPwd = true;
					}
					
				});
    			
				// 비번 체크
				$memberPwd2.on("input", function(){
					if($memberPwd.val().trim() != $memberPwd2.val().trim()){
						$("#checkPwd2").text("비밀번호 불일치").css("color", "#c82333" );
						createIdCheck.memberPwd2 = false;
					}else{
						$("#checkPwd2").text("비밀번호 일치").css("color", "#00a185" );
						createIdCheck.memberPwd2 = true;
					}
					
				});
    			
				// 닉네임 ajax
				$memberNickname.on("input" , function(){
					
					var regExp = /^[a-zA-z0-9가-힣\d]{2,12}$/;
					if(!regExp.test($memberNickname.val())){
						$("#checkNickName").text("2글자 이상 입력").css("color", "#c82333" );
						
						createIdCheck.memberNickname=false;
					}else{
						
						createIdCheck.memberNickname=true;
						$.ajax({
							url: "memberNickUnique",
							data: {memberNickname: $memberNickname.val() },
							type : "post",
							success : function(result){
								
								if(result == "true"){
									$("#checkNickName").text("닉네임 사용가능").css("color", "#00a185" );
									
								}else{
									$("#checkNickName").text("이미 등록된 닉네임").css("color", "#c82333" );
									
								}
							},
							error: function(e){
								console.log("ajax 통신 실패");
	                			console.log(e);
							}
							
						}); // ajax 끝
						createIdCheck.memberNickUnique = true;
						
					}
					
				});
				
				
				// 이메일 ajax
				$memberEmail.on("input" , function(){
					
					var regExp = /^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/;
					if(!regExp.test($memberEmail.val())){
						$("#checkEmail").text("이메일 형식을 확인해주세요.").css("color", "#c82333" );
						
						createIdCheck.memberEmail=false;
					}else{
						
						createIdCheck.memberEmail=true;
						$.ajax({
							url: "memberEmailUnique",
							data: {memberEmail: $memberEmail.val() },
							type : "post",
							success : function(result){
								
								if(result == "true"){
									$("#checkEmail").text("이메일 사용가능").css("color", "#00a185" );
									createIdCheck.memberEmailUnique = true;
								}else{
									$("#checkEmail").text("이미 등록된 이메일").css("color", "#c82333" );
									createIdCheck.memberEmailUnique = false;
								}
							},
							error: function(e){
								console.log("ajax 통신 실패");
	                			console.log(e);
							}
							
						}); // ajax 끝
						createIdCheck.memberEmailUnique = true;
						if(createIdCheck.memberEmailUnique && createIdCheck.memberEmail){
							$("#emailConfirmBtn").removeClass("btn-outline-dark").addClass("btn-outline-primary");
						}
					}
					
				});
				
				// 이메일 인증
					//$("#emailConfirmBtn").removeClass("btn-outline-dark").addClass("btn-outline-primary");
					$("#emailConfirmBtn").on("click", function(){
						$("#ECD").hide();
						$("#loading").show();
						var email = $("#memberEmail").val();
						$.ajax({
							url: "emailConfirm",
							data: {email: email},
							type : "post",
							success : function(result){
								if(result != "false"){
									alert("인증번호가 "+ email + "로 발송되었습니다.");
									emailConfirmNo = result;
								} else alert("인증 메일 발송 실패");
								$("#loading").hide();
	                			$("#ECD").show();
							},
							error: function(e){
								console.log("ajax 통신 실패");
	                			console.log(e);
	                			$("#loading").hide();
	                			$("#ECD").show();
							}
						}); // ajax 끝
					});
				
				$("#emailConfirmInput").on("input", function(){
					if($("#emailConfirmInput").val() == emailConfirmNo){
						$("#emailConfirmSpan").text("인증 번호 일치").css("color", "#00a185");
						createIdCheck.memberEmailConfirm = true;
					} else {
						$("#emailConfirmSpan").text("인증 번호 불일치").css("color", "#c82333");
						createIdCheck.memberEmailConfirm = false;
					}
				});
				
				//전화 번호
				$(".memberPhone").on("input", function(){
					
				//	var regExp1 =  /^\d{2,3}$/;  숫자 3글자
	                var regExp2 =  /^\d{3,4}$/; // 숫자 3~4 글자
	                var regExp3 =  /^\d{4,4}$/; // 숫자 4 글자
					
 				 	if(!regExp2.test($memberPhone2.val())
							|| !regExp3.test($memberPhone3.val()) ){
						$("#checkPhone").text("유효하지 않는 전화번호").css("color", "#c82333" );
						createIdCheck.memberPhone = false;
					}else{
						$("#checkPhone").text("유효한 전화번호").css("color", "#00a185" );
						createIdCheck.memberPhone = true;
					}   
					
				});
				
				// 생년월일
					$memberBirth.on("input", function(){
					if($("#memberBirth").val().trim() == ""){
						createIdCheck.memberBirth = false;
					}else{
						createIdCheck.memberBirth = true;
					}
				});
				
				// 성별
					$memberGender.on("input", function(){
						if($(".memberGender").val().trim() == ""){
							createIdCheck.memberGender = false;
						}else{
							createIdCheck.memberGender = true;
						}
					});
					
				
				
    		}); // ready 함수 끝
    		
      
    		
    		
      // 전화번호 자릿수 제한
      function maxLengthCheck(object) {
        if (object.value.length > object.maxLength) {
          object.value = object.value.slice(0, object.maxLength);
        }
      }

      // 3단계. 프로필 업로드 버튼 클릭시 이벤트
      $(function(){
        $(".uploadBtn").on({
          "click" : function(){
            $(".uploadInput").click();
          }
        });
      });
      
      // 이미지 등록 체크
      function loadImg(value){
          if(value.files && value.files[0]){
            var reader = new FileReader();
            reader.onload = function(e){
              $(".uploadImg").prop("src",e.target.result);
              
              createIdCheck.memberProfile = true;
            }
          }
          reader.readAsDataURL(value.files[0]);
      }
      
      // 이미지 파일
      /* function validate(){
    	  var imgFile = $('#isFile').val();
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/;
    	  
    	  if(imgFile != "" && imgFile != null) {
      	    if(!imgFile.match(fileForm)) {
      	    	alert("이미지 파일만 업로드 가능");
      	        return false;
      	    } 
      	 }
      } */
      
		
      
      
   // 유효성 검사 validate()	
 		function validate(){
  			for(var key in createIdCheck){
  				console.log(key + " / " + createIdCheck[key]);
  				
  				if(!createIdCheck[key]){
  					alert("필수 입력사항을 확인해주세요");
  					var id = "#"+key;
  					$(id).focus();
  					return false;
  				}
  			}
  		}
   
    </script>

    
	
	<jsp:include page="../common/footer.jsp"/>
	

	<!-- 다음 지도 API 스크립트 -->

	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=440560a29daf4ebdb30cd5fb2b3b4687&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
	<!-- 다음 지도 API  스크립트 끝~~~ -->


</body>

</html>
