(function(){var o,n,e,t,a,i,c;null==CakeCouponBook.coupon_books&&(CakeCouponBook.coupon_books={}),null==(e=CakeCouponBook.coupon_books).templates&&(e.templates={}),t=function(){$(".overlay-img").mouseenter(function(){$(this).addClass("hover")}).mouseleave(function(){$(this).removeClass("hover")})},o=function(){window.location.search.indexOf("purchased=1")>-1&&$("#after_purchase_modal").modal("show")},n=function(){$(window).height()+1200<$(document).height()&&$("#top-link-block").removeClass("hidden").affix({offset:{top:1200}})},a=function(){var o,n,e,t,a;e=$(".book-nav"),a=e.find(".nav-section"),n=e.find(".buy_button_section"),t=e.find(".nav-about-link"),o=$("#learn-more-banner"),e.affix({offset:{top:e.offset().top}}),e.find("a.book-nav-link").each(function(){$(this).click(function(){$("html, body").animate({scrollTop:0},500)})}),t.click(function(){$("html, body").animate({scrollTop:o.offset().top-$(".book-nav").height()},500)})},i=function(){var o,n;n=$(".book-nav ul.nav"),o=n.find("li a"),o.each(function(){var o,e,t;t=$(this),t.removeAttr("href").removeAttr("data-toggle"),e=t.data("cid"),o=$("#"+e),t.off("click").click(function(){n.find("li").each(function(){$(this).removeClass("active")}),t.closest("li").addClass("active"),$("html, body").animate({scrollTop:o.offset().top-$(".book-nav").height()},500)})})},c=function(){var o,n,e;n=$("#remote-items"),o=n.find("#see-more-link"),e=n.find("#spinner"),o.click(function(){e.removeClass("hidden"),$(this).hide()}),o.on("ajax:success",function(o,e){n.html(e),i()}).on("ajax:error",function(){e.hide(),o.show(),alert("There was an error, please reload this page and try again.")})},CakeCouponBook.coupon_books.templates.compact=function(){t(),o(),n(),a(),c(),CakeCouponBook.subscriptors.validation()}}).call(this);