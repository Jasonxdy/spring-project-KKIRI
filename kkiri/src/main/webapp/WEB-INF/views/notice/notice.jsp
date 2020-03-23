<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.5/js/swiper.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"
    integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
    integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
    crossorigin="anonymous"></script>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap&subset=korean"
    rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/header.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/footer.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
  <title>KKIRI(끼리)</title>
</head>

<body>
  <jsp:include page="../common/header.jsp"/>
  
    <!-- content 시작 -->
    <div id="container" class="container">
      <div class="row mt-5">
        <ul class="nav nav-tabs">
          <li class="nav-item">
            <a class="nav-link active" href="#" tabindex="-1">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="questionWrite.html" tabindex="-1">1:1문의 작성</a>
          </li>
        </ul>
      </div>

      <div class="row justify-content-md-center boardWrap">
        <div class="col-12 rounded-sm">
          <h2 class="mt-3 mb-5">공지사항</h2>
          <table id="list-table" class="table table-hover table-striped table-sm">
            <thead>
              <tr class="text-center">
                <th scope="col">NO</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회수</th>
              </tr>
            </thead>
            <tbody>
              <tr class="text-center">
                <th scope="row">1</th>
                <td><p class="board-title-td">공지사항 1</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">2</th>
                <td><p class="board-title-td">공지사항 2</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">3</th>
                <td><p class="board-title-td">공지사항 3</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">4</th>
                <td><p class="board-title-td">공지사항 4</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">5</th>
                <td><p class="board-title-td">공지사항 5</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">6</th>
                <td><p class="board-title-td">공지사항 6</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">7</th>
                <td><p class="board-title-td">공지사항 7</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">8</th>
                <td><p class="board-title-td">공지사항 8</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">9</th>
                <td><p class="board-title-td">공지사항 9</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
              <tr class="text-center">
                <th scope="row">10</th>
                <td><p class="board-title-td">공지사항 10</p></td>
                <td>관리자</td>
                <td>2020-01-01</td>
                <td>10</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>


      <div class="row justify-content-md-center">
        <!-- 검색 -->
        <div class="col-md-2 col-sm-3">
          <div class="input-group">
            <select class="custom-select" id="inputGroupSelect04" aria-label="Example select with button addon">
              <option selected>구분</option>
              <option value="1">작성일</option>
              <option value="2">제목</option>
            </select>
          </div>
        </div>
        <div class="col-md-9 col-sm-7">
          <div class="input-group mb-3">
            <input type="text" class="form-control inputSection">
          </div>
        </div>
        <div class="col-md-1 col-sm-2">
          <div class="input-group-append">
            <button class="green-radius-btn search-btn" type="button">검색</button>
          </div>
        </div>
      </div>

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


  <!-- content 끝 -->
  <div id="footer">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="row">
            <div class="col-md-4 footer-logo-wrap">
              <img class="footer-logo" src="img/logo2-white.png" alt="푸터로고">
            </div>
            <div class="col-md-8">
              <p class="copyright">&copy; 2020 KKIRI COMPANY. ALL RIGHTS RESERVED.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div id="button-top">
    <button type="button" class="top-btn">TOP</button>
  </div>

	<jsp:include page="../common/footer.jsp"/>

  <script>
    function scrollFunction() {
      if ($(window).scrollTop() >= 200) {
        $('#button-top').show(0);
      } else {
        $('#button-top').hide(0);
      }
    }
    $(function () {
      scrollFunction();
      $(window).scroll(function () {
        scrollFunction();
      });
      $('#button-top').on({
        click: function () {
          $('html,body').stop().animate({ scrollTop: 0 }, 600);
        }
      });
    });
    </script>
</body>

</html>