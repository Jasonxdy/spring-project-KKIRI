<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/footer.css">
</head>
<body>
	<div id="footer">
          <div class="container">
          	<div class="row">
          		<div class="col-md-12">
          			<div class="row">
          				<div class="col-md-4 footer-logo-wrap">
                    <img class="footer-logo" src="<%=request.getContextPath() %>/resources/img/logo2-white.png" alt="푸터로고">
          				</div>
          				<div class="col-md-8">
                    <p class="copyright">&copy; 2020 KKIRI COMPANY. ALL RIGHTS RESERVED.</p>
          				</div>
          			</div>
          		</div>
          	</div>
          </div>
        </div>
         </div> 

         <div id="button-top">
          <button type="button" class="top-btn">TOP</button>
        </div>


      <script>
        function scrollFunction(){
          if($(window).scrollTop()>=200){
                $('#button-top').show(0);
            }else{
                $('#button-top').hide(0);
            }
        }
       $(function(){
         scrollFunction();
         $(window).scroll(function(){
           scrollFunction();
         });
         $('#button-top').on({
             click : function(){
                 $('html,body').stop().animate({scrollTop:0},600);
             }
         });
       });
       </script>
</body>
</html>