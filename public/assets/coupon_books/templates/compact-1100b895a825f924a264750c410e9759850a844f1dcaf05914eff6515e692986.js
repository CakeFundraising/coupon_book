(function(){var o,n,e,i,a,t,s;null==CakeCouponBook.coupon_books&&(CakeCouponBook.coupon_books={}),null==(e=CakeCouponBook.coupon_books).templates&&(e.templates={}),i=function(){$(".overlay-img").mouseenter(function(){$(this).addClass("hover")}).mouseleave(function(){$(this).removeClass("hover")})},o=function(){window.location.search.indexOf("purchased=1")>-1&&$("#after_purchase_modal").modal("show")},n=function(){$(window).height()+1200<$(document).height()&&$("#top-link-block").removeClass("hidden").affix({offset:{top:1200}})},a=function(){var o,n,e,i;n=$(".book-nav"),i=n.find(".nav-section"),o=n.find(".buy_button_section"),e=n.find(".nav-about-link"),o.hide(),n.affix({offset:{top:n.offset().top}}),n.on("affixed.bs.affix",function(){i.removeClass("col-md-12").addClass("col-md-9"),o.show()}),n.on("affix-top.bs.affix",function(){o.hide(),i.removeClass("col-md-9").addClass("col-md-12")}),n.find("a.book-nav-link").each(function(){$(this).click(function(){$("html, body").animate({scrollTop:$("#coupons.green").offset().top},500)})})},t=function(){var o,n;n=$(".book-nav ul.nav"),o=n.find("li a.book-nav-link"),o.each(function(){var o,e,i;i=$(this),i.removeAttr("href").removeAttr("data-toggle"),e=i.data("cid"),o=$("#"+e),i.off("click").click(function(){n.find("li").each(function(){$(this).removeClass("active")}),i.closest("li").addClass("active"),$("html, body").animate({scrollTop:o.offset().top-$(".book-nav").height()},500)})})},s=function(){var o,n,e;n=$("#remote-items"),o=n.find("#see-more-link"),e=n.find("#spinner"),CakeCouponBook.coupon_books.templates.dealSeeAllLink(),o.click(function(){e.removeClass("hidden"),$(this).hide()}),o.on("ajax:success",function(o,e){n.html(e),t()}).on("ajax:error",function(){e.hide(),o.show(),alert("There was an error, please reload this page and try again.")})},CakeCouponBook.coupon_books.templates.dealSeeAllLink=function(){var o,n,e;e=$("#remote-items"),n=e.find(".see-more-box"),o=e.find("#see-more-link"),n.click(function(){o.click()})},CakeCouponBook.coupon_books.templates.compact=function(){i(),o(),n(),a(),s(),CakeCouponBook.subscriptors.validation()}}).call(this);