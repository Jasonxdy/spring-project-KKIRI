$(function(){

  // 배너 영상 반응형
  var winW = 0, bannerH=0, txtH=0;

    resizeBanner();

    $(window).resize(function(){
      resizeBanner();
    });

    function resizeBanner(){
      winW = $(window).innerWidth();
      $('.video').css({width:winW});

      bannerH=$("#banner").innerHeight();
      txtH=$(".banner-text-area").height();

      $(".banner-text-area").css({top:(bannerH-txtH)/2});
  }

  //이런 이벤트 어떠세요? 슬라이드
  var swiper = new Swiper('.blog-slider', {
        effect: 'fade',
        loop: false,
        pagination: {
          el: '.blog-slider__pagination',
          clickable: true
        }
  });
  
  // 주최자 랭킹 
		$(".ranker-list>li").each(function(i){
      $(this).on({
        mouseenter : function(){
          $(".ranker-list>li").removeClass("on");
          $(this).addClass("on");
        },
        mouseleave : function(){
          $(".ranker-list>li").removeClass("on");
        }
      });
    });

});
