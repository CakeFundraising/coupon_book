(function(){var e,t,n,i,o;null==CakeCouponBook.coupon_books&&(CakeCouponBook.coupon_books={}),null==(n=CakeCouponBook.coupon_books).templates&&(n.templates={}),i=function(){$(".overlay-img").mouseenter(function(){$(this).addClass("hover")}).mouseleave(function(){$(this).removeClass("hover")})},e=function(){window.location.search.indexOf("purchased=1")>-1&&$("#after_purchase_modal").modal("show")},t=function(){$(window).height()+1200<$(document).height()&&$("#top-link-block").removeClass("hidden").affix({offset:{top:1200}})},o=function(){var e,t,n,i,o;n=$(".book-nav"),o=n.find(".nav-section"),t=n.find(".buy_button_section"),i=n.find(".nav-about-link"),e=$("#learn-more-banner"),t.hide(),n.affix({offset:{top:n.offset().top}}),n.on("affixed.bs.affix",function(){o.removeClass("col-md-12").addClass("col-md-10"),t.show()}),n.on("affix-top.bs.affix",function(){t.hide(),o.removeClass("col-md-10").addClass("col-md-12")}),n.find("a.book-nav-link").each(function(){$(this).click(function(){$("html, body").animate({scrollTop:$("#coupons.green").offset().top},500)})}),i.click(function(){$("html, body").animate({scrollTop:e.offset().top-$(".book-nav").height()},500)})},CakeCouponBook.coupon_books.templates.compact=function(){i(),e(),t(),o(),CakeCouponBook.subscriptors.validation()}}).call(this);