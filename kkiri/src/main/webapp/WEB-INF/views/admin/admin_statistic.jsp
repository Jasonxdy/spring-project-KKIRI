<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자페이지 - 회원</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin.css">
	<!-- <script type="text/javascript" src="https://cdnjs.com/libraries/Chart.js"></script> -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../common/header.jsp" />
		<!-- content 시작 -->
		<div id="container" class="container">
			<div class="row mt-5">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link" href="member"
						tabindex="-1">회원</a></li>
					<li class="nav-item"><a class="nav-link" href="event"
						tabindex="-1">이벤트</a></li>
					<li class="nav-item"><a class="nav-link" href="report"
						tabindex="-1">신고</a></li>
					<li class="nav-item"><a class="nav-link" href="ask"
						tabindex="-1">문의</a></li>
					<li class="nav-item"><a class="nav-link"
						href="management" tabindex="-1">관리</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="statistic" tabindex="-1">통계</a></li>
				</ul>
			</div>
			
			<canvas id="bar-chart" width="800" height="450"></canvas>
			<canvas id="event-chart" width="800" height="450"></canvas>
			
		</div>
		<!-- content 끝 -->
	</div>
	<jsp:include page="../common/footer.jsp" />


	<script>
		var eList = null;
		function scrollFunction() {
			if ($(window).scrollTop() >= 200) {
				$('#button-top').show(0);
			} else {
				$('#button-top').hide(0);
			}
		}
		$(function() {
			scrollFunction();
			$(window).scroll(function() {
				scrollFunction();
			});
			$('#button-top').on({
				click : function() {
					$('html,body').stop().animate({
						scrollTop : 0
					}, 600);
				}
			});
		});
		
		
		$(function(){
			$.ajax({
        		url : "eventStatistic",
        		type : "post",
        		dataType: "json",
        		success : function(eList){
        			this.eList = eList;
        			console.log(eList);
        		},
        		error : function(e){
        			console.log("ajax 통신 실패");
        			console.log(e);
        		}
        	});
		});
		
  		
  		
  		  
  		  
		// Bar chart
		new Chart(document.getElementById("bar-chart"), {
		    type: 'bar',
		    data: {
		      labels: ["a","b","c","d","e"],
		      datasets: [
		        {
		          label: "Population (millions)",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		          data: [2478,5267,734,784,433]
		        }
		      ]
		    },
		    options: {
		      legend: { display: false },
		      title: {
		        display: true,
		        text: 'Predicted world population (millions) in 2050'
		      }
		    }
		});
  		  
  		new Chart(document.getElementById("event-chart"), {
		    type: 'bar',
		    data: {
		      labels: [
			    	  /* for(var i=0; i<eList.length; i++){
				  		  if(i<eList.length){
				  		  eList[i].eventDate + ", "
				  		  } else{
				  			  eList[i].eventDate
				  		  }
			  		  }  */
		  		  	],
		      datasets: [
		        {
		          label: "Population (millions)",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		          data: [2478,5267,734,784,433]
		        }
		      ]
		    },
		    options: {
		      legend: { display: false },
		      title: {
		        display: true,
		        text: 'Predicted world population (millions) in 2050'
		      }
		    }
		});


	</script>
</body>

</html>