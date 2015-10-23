/*!
 * parallax.js v1.3.1 (http://pixelcog.github.io/parallax.js/)
 * @copyright 2015 PixelCog, Inc.
 * @license MIT (https://github.com/pixelcog/parallax.js/blob/master/LICENSE)
 */
!function(t,e,n,i){function o(e,n){var r=this;"object"==typeof n&&(delete n.refresh,delete n.render,t.extend(this,n)),this.$element=t(e),!this.imageSrc&&this.$element.is("img")&&(this.imageSrc=this.$element.attr("src"));var a=(this.position+"").toLowerCase().match(/\S+/g)||[];return a.length<1&&a.push("center"),1==a.length&&a.push(a[0]),("top"==a[0]||"bottom"==a[0]||"left"==a[1]||"right"==a[1])&&(a=[a[1],a[0]]),this.positionX!=i&&(a[0]=this.positionX.toLowerCase()),this.positionY!=i&&(a[1]=this.positionY.toLowerCase()),r.positionX=a[0],r.positionY=a[1],"left"!=this.positionX&&"right"!=this.positionX&&(this.positionX=isNaN(parseInt(this.positionX))?"center":parseInt(this.positionX)),"top"!=this.positionY&&"bottom"!=this.positionY&&(this.positionY=isNaN(parseInt(this.positionY))?"center":parseInt(this.positionY)),this.position=this.positionX+(isNaN(this.positionX)?"":"px")+" "+this.positionY+(isNaN(this.positionY)?"":"px"),navigator.userAgent.match(/(iPod|iPhone|iPad)/)?(this.iosFix&&!this.$element.is("img")&&this.$element.css({backgroundImage:"url("+this.imageSrc+")",backgroundSize:"cover",backgroundPosition:this.position}),this):navigator.userAgent.match(/(Android)/)?(this.androidFix&&!this.$element.is("img")&&this.$element.css({backgroundImage:"url("+this.imageSrc+")",backgroundSize:"cover",backgroundPosition:this.position}),this):(this.$mirror=t("<div />").prependTo("body"),this.$slider=t("<img />").prependTo(this.$mirror),this.$mirror.addClass("parallax-mirror").css({visibility:"hidden",zIndex:this.zIndex,position:"fixed",top:0,left:0,overflow:"hidden"}),this.$slider.addClass("parallax-slider").one("load",function(){r.naturalHeight&&r.naturalWidth||(r.naturalHeight=this.naturalHeight||this.height||1,r.naturalWidth=this.naturalWidth||this.width||1),r.aspectRatio=r.naturalWidth/r.naturalHeight,o.isSetup||o.setup(),o.sliders.push(r),o.isFresh=!1,o.requestRender()}),this.$slider[0].src=this.imageSrc,void((this.naturalHeight&&this.naturalWidth||this.$slider[0].complete)&&this.$slider.trigger("load")))}function r(i){return this.each(function(){var r=t(this),a="object"==typeof i&&i;this==e||this==n||r.is("body")?o.configure(a):r.data("px.parallax")||(a=t.extend({},r.data(),a),r.data("px.parallax",new o(this,a))),"string"==typeof i&&o[i]()})}!function(){for(var t=0,n=["ms","moz","webkit","o"],i=0;i<n.length&&!e.requestAnimationFrame;++i)e.requestAnimationFrame=e[n[i]+"RequestAnimationFrame"],e.cancelAnimationFrame=e[n[i]+"CancelAnimationFrame"]||e[n[i]+"CancelRequestAnimationFrame"];e.requestAnimationFrame||(e.requestAnimationFrame=function(n){var i=(new Date).getTime(),o=Math.max(0,16-(i-t)),r=e.setTimeout(function(){n(i+o)},o);return t=i+o,r}),e.cancelAnimationFrame||(e.cancelAnimationFrame=function(t){clearTimeout(t)})}(),t.extend(o.prototype,{speed:.2,bleed:0,zIndex:-100,iosFix:!0,androidFix:!0,position:"center",overScrollFix:!1,refresh:function(){this.boxWidth=this.$element.outerWidth(),this.boxHeight=this.$element.outerHeight()+2*this.bleed,this.boxOffsetTop=this.$element.offset().top-this.bleed,this.boxOffsetLeft=this.$element.offset().left,this.boxOffsetBottom=this.boxOffsetTop+this.boxHeight;var t=o.winHeight,e=o.docHeight,n=Math.min(this.boxOffsetTop,e-t),i=Math.max(this.boxOffsetTop+this.boxHeight-t,0),r=this.boxHeight+(n-i)*(1-this.speed)|0,a=(this.boxOffsetTop-n)*(1-this.speed)|0;if(r*this.aspectRatio>=this.boxWidth){this.imageWidth=r*this.aspectRatio|0,this.imageHeight=r,this.offsetBaseTop=a;var s=this.imageWidth-this.boxWidth;this.offsetLeft="left"==this.positionX?0:"right"==this.positionX?-s:isNaN(this.positionX)?-s/2|0:Math.max(this.positionX,-s)}else{this.imageWidth=this.boxWidth,this.imageHeight=this.boxWidth/this.aspectRatio|0,this.offsetLeft=0;var s=this.imageHeight-r;this.offsetBaseTop="top"==this.positionY?a:"bottom"==this.positionY?a-s:isNaN(this.positionY)?a-s/2|0:a+Math.max(this.positionY,-s)}},render:function(){var t=o.scrollTop,e=o.scrollLeft,n=this.overScrollFix?o.overScroll:0,i=t+o.winHeight;this.visibility=this.boxOffsetBottom>t&&this.boxOffsetTop<i?"visible":"hidden",this.mirrorTop=this.boxOffsetTop-t,this.mirrorLeft=this.boxOffsetLeft-e,this.offsetTop=this.offsetBaseTop-this.mirrorTop*(1-this.speed),this.$mirror.css({transform:"translate3d(0px, 0px, 0px)",visibility:this.visibility,top:this.mirrorTop-n,left:this.mirrorLeft,height:this.boxHeight,width:this.boxWidth}),this.$slider.css({transform:"translate3d(0px, 0px, 0px)",position:"absolute",top:this.offsetTop,left:this.offsetLeft,height:this.imageHeight,width:this.imageWidth,maxWidth:"none"})}}),t.extend(o,{scrollTop:0,scrollLeft:0,winHeight:0,winWidth:0,docHeight:1<<30,docWidth:1<<30,sliders:[],isReady:!1,isFresh:!1,isBusy:!1,setup:function(){if(!this.isReady){var i=t(n),r=t(e);r.on("scroll.px.parallax load.px.parallax",function(){var t=o.docHeight-o.winHeight,e=o.docWidth-o.winWidth;o.scrollTop=Math.max(0,Math.min(t,r.scrollTop())),o.scrollLeft=Math.max(0,Math.min(e,r.scrollLeft())),o.overScroll=Math.max(r.scrollTop()-t,Math.min(r.scrollTop(),0)),o.requestRender()}).on("resize.px.parallax load.px.parallax",function(){o.winHeight=r.height(),o.winWidth=r.width(),o.docHeight=i.height(),o.docWidth=i.width(),o.isFresh=!1,o.requestRender()}),this.isReady=!0}},configure:function(e){"object"==typeof e&&(delete e.refresh,delete e.render,t.extend(this.prototype,e))},refresh:function(){t.each(this.sliders,function(){this.refresh()}),this.isFresh=!0},render:function(){this.isFresh||this.refresh(),t.each(this.sliders,function(){this.render()})},requestRender:function(){var t=this;this.isBusy||(this.isBusy=!0,e.requestAnimationFrame(function(){t.render(),t.isBusy=!1}))}});var a=t.fn.parallax;t.fn.parallax=r,t.fn.parallax.Constructor=o,t.fn.parallax.noConflict=function(){return t.fn.parallax=a,this},t(n).on("ready.px.parallax.data-api",function(){t('[data-parallax="scroll"]').parallax()})}(jQuery,window,document),function(){null==CakeCouponBook.parallax&&(CakeCouponBook.parallax={}),CakeCouponBook.parallax.init=function(){$(".parallax-window").parallax({naturalWidth:1440,naturalHeight:900,bleed:60})}}.call(this);