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
            <a class="btn" href="#">프로필</a>
            <a class="btn" href="#">이벤트</a>
            <a class="btn active" href="#">티켓</a>
            <a class="btn" href="#">로그아웃</a>
          </div>

          <div class="col-10">

            <ul class="nav nav-tabs" id="profile-nav-wrap">
              <li class="nav-item">
                <a class="nav-link active move-btn" href="javascript:" tabindex="-1">내역</a>
              </li>
              <li class="nav-item">
                <a class="nav-link move-btn" href="javascript:" tabindex="-1">충전</a>
              </li>
              <li class="nav-item">
                <a class="nav-link move-btn" href="javascript:" tabindex="-1">환급</a>
              </li>
            </ul>

            <div class="ticket-wrap my-profile-section">
              <h4>티켓 사용 내역</h4>
              <p class="have-ticket">보유한 티켓 수 : <span>5장</span></p>

              <select name="ticket-sort" id="ticket-sort">
                <option value="all">전체</option>
                <option value="U">사용</option>
                <option value="P">수익</option>
                <option value="C">충전</option>
                <option value="R">환급</option>
                <option value="B">환불</option>
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
                  <tr>
                    <td class="ticket-sort">사용</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">-1</td>
                    <td class="ticket-name">크로스핏 모임</td>
                    <td class="ticket-money"></td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">충전</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">+5</td>
                    <td class="ticket-name"></td>
                    <td class="ticket-money">5,000원</td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">환급</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">-10</td>
                    <td class="ticket-name"></td>
                    <td class="ticket-money">9,000원</td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">수익</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">+10</td>
                    <td class="ticket-name">개발자 모임</td>
                    <td class="ticket-money"></td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">환불</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">-10</td>
                    <td class="ticket-name"></td>
                    <td class="ticket-money">10,000원</td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">사용</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">-1</td>
                    <td class="ticket-name">크로스핏 모임</td>
                    <td class="ticket-money"></td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">충전</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">+5</td>
                    <td class="ticket-name"></td>
                    <td class="ticket-money">5,000원</td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">환급</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">-10</td>
                    <td class="ticket-name"></td>
                    <td class="ticket-money">9,000원</td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">수익</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">+10</td>
                    <td class="ticket-name">개발자 모임</td>
                    <td class="ticket-money"></td>
                  </tr>
                  <tr>
                    <td class="ticket-sort">환불</td>
                    <td class="ticket-date">2019-02-19</td>
                    <td class="ticket-amount">-10</td>
                    <td class="ticket-name"></td>
                    <td class="ticket-money">10,000원</td>
                  </tr>
                </tbody>
              </table>

              <script>
                $(function(){
                  // 종류별로 색깔구분하기
                  $(".ticket-amount").each(function(index){
                    if($(".ticket-amount").eq(index).text().substring(0,1)=="-"){
                      $(this).css({"color":"#c82333"});
                    }else if($(".ticket-amount").eq(index).text().substring(0,1)=="+"){
                      $(this).css({"color":"#0069d9"});
                    }
                  });

                  $(".ticket-table tbody .ticket-sort").each(function(i){
                    $("#ticket-sort").on({
                      change : function(){
                        if($(this).find("option:checked").text()=="전체"){
                          $(".ticket-table tbody tr").show(0);
                        }else if($(this).find("option:checked").text()==$(".ticket-table tbody .ticket-sort").eq(i).text()){
                          $(".ticket-table tbody tr").eq(i).show(0);
                        }else{
                          $(".ticket-table tbody tr").eq(i).hide(0);
                        }
                      }
                    });
                  })

                });
              </script>
              
              <!-- 페이징 바 -->
              <div class="row justify-content-center pagination-wrap">
                <div>
                  <ul class="pagination">
                    <li>
                      <a class="page-link " href="#">&lt;&lt;</a>
                    </li>
                    <li>
                      <a class="page-link " href="#">&lt;</a>
                    </li>
                    <li>
                      <a class="page-link" href="#">1</a>
                    </li>
                    <li>
                      <a class="page-link " href="#">2</a>
                    </li>
                    <li>
                      <a class="page-link " href="#">3</a>
                    </li>
                    <li>
                      <a class="page-link " href="#">4</a>
                    </li>
                    <li>
                      <a class="page-link " href="#">5</a>
                    </li>
                    <!-- 다음 페이지로(>) -->
                    <li>
                      <a class="page-link " href="#">&gt;</a>
                    </li>
                    <!-- 맨 끝으로(>>) -->
                    <li>
                      <a class="page-link " href="#">&gt;&gt;</a>
                    </li>
                  </ul>
                </div>
              </div>
              <!-- 페이징 바 끝 -->
            </div>
          </div>
      </div>
    </div>  
  
	<jsp:include page="../common/footer.jsp"/>

</body>

</html>