<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<c:if test="${ticketSort==null }">
			<c:set var="ticketSort" value="all"/>
			</c:if>

          <div class="col-10">

            <ul class="nav nav-tabs" id="profile-nav-wrap">
              <li class="nav-item">
                <a class="nav-link active move-btn" href="../mypage/ticketLog" tabindex="-1">내역</a>
              </li>
              <li class="nav-item">
                <a class="nav-link move-btn" href="../mypage/recharge" tabindex="-1">충전</a>
              </li>
              <li class="nav-item">
                <a class="nav-link move-btn" href="../mypage/moveRefund" tabindex="-1">환급</a>
              </li>
            </ul>

            <div class="ticket-wrap my-profile-section">
              <h4>티켓 사용 내역</h4>
              <p class="have-ticket">보유한 티켓 수 : <span>${loginMember.memberTicket }</span></p>

              <select name="ticket-sort" id="ticket-sort">
              <c:if test="${ticketSort=='all' }">
              checked
              </c:if>
                <option value="all" <c:if test="${ticketSort=='all'}">
              checked
              </c:if>>전체</option>
                <option value="U" 
                <c:if test="${ticketSort=='U'}">selected</c:if>
              >사용</option>
                <option value="P" <c:if test="${ticketSort=='P' }">
              selected
              </c:if>>수익</option>
                <option value="C" <c:if test="${ticketSort=='C' }">
            selected
              </c:if>>충전</option>
                <option value="R" <c:if test="${ticketSort=='R' }">
             selected
              </c:if>>환급</option>
                <option value="B" <c:if test="${ticketSort=='B' }">
       selected
              </c:if>>환불</option>
              </select>
		
              <table class="ticket-table table table-hover table-striped">
                <thead>
                  <tr>
                    <th class="ticket-sort">종류</th>
                    <th class="ticket-date">날짜</th>
                    <th class="ticket-amount">티켓 수</th>
                    <th class="ticket-name">이벤트 명</th>
                    <th class="ticket-money">금액</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var="tl" items="${ticketList}">
                  <tr>
                    <td class="ticket-sort">
                    <c:if test="${tl.paymentType =='U'}">
                    					사용
                    </c:if>
                    <c:if test="${tl.paymentType =='P'}">
                                       	수익
                    </c:if>
                    <c:if test="${tl.paymentType =='C'}">
                         			   	   충전       
                    </c:if>
                    <c:if test="${tl.paymentType =='R'}">
        								환급           
        	 		</c:if>
                    <c:if test="${tl.paymentType =='B'}">
      									환불            
      				</c:if>
                    
                    </td>
                    <td class="ticket-date">
                    ${tl.paymentDate}
                    </td>
                    <td class="ticket-amount">
                    ${tl.paymentTicket }
                    </td>
                    <td class="ticket-name">
                    ${tl.eventName }
                    </td>
                    <td class="ticket-money">
                    <c:if test="${tl.paymentType =='R'||tl.paymentType =='B'}">
                    <c:set var="t2" value="${(tl.paymentTicket*-900)}"/>
                    <fmt:formatNumber value="${t2}" groupingUsed="true" pattern="#,000"/>
                    원
                    </c:if>
                    <c:if test="${tl.paymentType =='C'}">
                    <c:set var="t2" value="${(tl.paymentTicket*-1000)}"/>
                    <fmt:formatNumber value="${t2}" groupingUsed="true" pattern="#,000"/>
                    원
                    </c:if>
                    </td>
                  </tr>
		
				</c:forEach>
				</tbody>
                 
                
              </table>

              <script>
              $(function(){
			    	if(${loginMember == null}){
			    		location.href="../mypage/main";	
			    	}
			    })
              
              
              
              
              
              
              // 변수 선언
              var currentPage = ${pInf.currentPage};
              
              var ticketsort = '${ticketSort}';
             
              // 클릭할때 마다 ticketLog를 호출해라
              
              
                $(function(){
                  // 종류별로 색깔구분하기
                  $(".ticket-amount").each(function(index){
                    if($(".ticket-amount").eq(index).text().trim()<0){
                      $(this).css({"color":"#c82333"});
                    }else if($(".ticket-amount").eq(index).text().trim()>0){
                      $(this).css({"color":"#0069d9"});
                    }
                  });
	
                    $("#ticket-sort").on({
                      change : function(){
                        	ticketsort = $(this).val();
                        	location.href="ticketLog?ticketsort="+ticketsort+"&currentPage="+1;
                      }
                    });
                    
                });
              </script>
              
              <!-- 페이징 바 -->
              <div class="row justify-content-center pagination-wrap">
                <div>
                  <ul class="pagination">
                  <c:if test="${pInf.currentPage >1 }">
                  
                    <li>
                      <a class="page-link " href="
                  <c:url value="ticketLog">
                    <c:param name="ticketsort" value="${ticketSort}"/>  
                  </c:url>
                      "
                      >&lt;&lt;</a>
                    </li>
                    <li>
                      <a class="page-link " href="
                    
                    <c:url value="ticketLog">
                    <c:param name="ticketsort" value="${ticketSort}"/>  
                  	</c:url>
                  ">&lt;</a>
                    </li>
                  </c:if>
                  <c:forEach var ="pg" begin="${pInf.startPage }" end="${pInf.endPage }">
                  <c:if test="${pg ==pInf.currentPage}">
                    <li>
                      <a class="page-link active">${pg }</a>
                    </li>
                  </c:if>
                  <c:if test="${pg!=pInf.currentPage }">
                    <li>
                      <a class="page-link" href="
                      <c:url value="ticketLog">
                      <c:param name="ticketsort" value="${ticketSort}" />
                      <c:param name="currentPage" value="${pg}" />
                      </c:url>
                      ">${pg }</a>
                    </li>
                  </c:if>
                  </c:forEach>
                    
                    <!-- 다음 페이지로(>) -->
                    <c:if test="${pInf.currentPage<pInf.maxPage }">
                    <li>
                      <a class="page-link " href="
                      <c:url value="ticketLog">
                      <c:param name="ticketsort" value="${ticketSort}" />
                      <c:param name="currentPage" value="${pInf.currentPage+1}"/>
                      </c:url>
                      ">&gt;</a>
                    </li>
                   
                    
                    <!-- 맨 끝으로(>>) -->
                    <li>
                      <a class="page-link " href="
                      <c:url value="ticketLog">
                      <c:param name="ticket-sort" value="${ticketSort}" />
                      <c:param name="currentPage" value="${pInf.maxPage}"/>
                      </c:url>
                      ">&gt;&gt;</a>
                    </li>
                     </c:if>
                  </ul>
                </div>
              </div>
              <!-- 페이징 바 끝 -->
            </div>
          </div>
      </div>
    </div>  
  
	<jsp:include page="../common/footer.jsp"/>
	</div>
</body>

</html>