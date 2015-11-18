/*!
 * Modernizr v2.7.1
 * www.modernizr.com
 *
 * Copyright (c) Faruk Ates, Paul Irish, Alex Sexton
 * Available under the BSD and MIT licenses: www.modernizr.com/license/
 */
window.Modernizr=function(e,t,n){function i(e){b.cssText=e}function o(e,t){return i(k.join(e+";")+(t||""))}function r(e,t){return typeof e===t}function a(e,t){return!!~(""+e).indexOf(t)}function s(e,t){for(var i in e){var o=e[i];if(!a(o,"-")&&b[o]!==n)return"pfx"==t?o:!0}return!1}function l(e,t,i){for(var o in e){var a=t[e[o]];if(a!==n)return i===!1?e[o]:r(a,"function")?a.bind(i||t):a}return!1}function u(e,t,n){var i=e.charAt(0).toUpperCase()+e.slice(1),o=(e+" "+E.join(i+" ")+i).split(" ");return r(t,"string")||r(t,"undefined")?s(o,t):(o=(e+" "+S.join(i+" ")+i).split(" "),l(o,t,n))}function c(){p.input=function(n){for(var i=0,o=n.length;o>i;i++)A[n[i]]=!!(n[i]in w);return A.list&&(A.list=!(!t.createElement("datalist")||!e.HTMLDataListElement)),A}("autocomplete autofocus list placeholder max min multiple pattern required step".split(" ")),p.inputtypes=function(e){for(var i,o,r,a=0,s=e.length;s>a;a++)w.setAttribute("type",o=e[a]),i="text"!==w.type,i&&(w.value=x,w.style.cssText="position:absolute;visibility:hidden;",/^range$/.test(o)&&w.style.WebkitAppearance!==n?(g.appendChild(w),r=t.defaultView,i=r.getComputedStyle&&"textfield"!==r.getComputedStyle(w,null).WebkitAppearance&&0!==w.offsetHeight,g.removeChild(w)):/^(search|tel)$/.test(o)||(i=/^(url|email)$/.test(o)?w.checkValidity&&w.checkValidity()===!1:w.value!=x)),_[e[a]]=!!i;return _}("search tel url email datetime date month week time datetime-local number range color".split(" "))}var d,h,f="2.7.1",p={},m=!0,g=t.documentElement,v="modernizr",y=t.createElement(v),b=y.style,w=t.createElement("input"),x=":)",C={}.toString,k=" -webkit- -moz- -o- -ms- ".split(" "),T="Webkit Moz O ms",E=T.split(" "),S=T.toLowerCase().split(" "),$={svg:"http://www.w3.org/2000/svg"},N={},_={},A={},D=[],F=D.slice,L=function(e,n,i,o){var r,a,s,l,u=t.createElement("div"),c=t.body,d=c||t.createElement("body");if(parseInt(i,10))for(;i--;)s=t.createElement("div"),s.id=o?o[i]:v+(i+1),u.appendChild(s);return r=["&#173;",'<style id="s',v,'">',e,"</style>"].join(""),u.id=v,(c?u:d).innerHTML+=r,d.appendChild(u),c||(d.style.background="",d.style.overflow="hidden",l=g.style.overflow,g.style.overflow="hidden",g.appendChild(d)),a=n(u,e),c?u.parentNode.removeChild(u):(d.parentNode.removeChild(d),g.style.overflow=l),!!a},j=function(t){var n=e.matchMedia||e.msMatchMedia;if(n)return n(t).matches;var i;return L("@media "+t+" { #"+v+" { position: absolute; } }",function(t){i="absolute"==(e.getComputedStyle?getComputedStyle(t,null):t.currentStyle).position}),i},I=function(){function e(e,o){o=o||t.createElement(i[e]||"div"),e="on"+e;var a=e in o;return a||(o.setAttribute||(o=t.createElement("div")),o.setAttribute&&o.removeAttribute&&(o.setAttribute(e,""),a=r(o[e],"function"),r(o[e],"undefined")||(o[e]=n),o.removeAttribute(e))),o=null,a}var i={select:"input",change:"input",submit:"form",reset:"form",error:"img",load:"img",abort:"img"};return e}(),B={}.hasOwnProperty;h=r(B,"undefined")||r(B.call,"undefined")?function(e,t){return t in e&&r(e.constructor.prototype[t],"undefined")}:function(e,t){return B.call(e,t)},Function.prototype.bind||(Function.prototype.bind=function(e){var t=this;if("function"!=typeof t)throw new TypeError;var n=F.call(arguments,1),i=function(){if(this instanceof i){var o=function(){};o.prototype=t.prototype;var r=new o,a=t.apply(r,n.concat(F.call(arguments)));return Object(a)===a?a:r}return t.apply(e,n.concat(F.call(arguments)))};return i}),N.flexbox=function(){return u("flexWrap")},N.flexboxlegacy=function(){return u("boxDirection")},N.canvas=function(){var e=t.createElement("canvas");return!(!e.getContext||!e.getContext("2d"))},N.canvastext=function(){return!(!p.canvas||!r(t.createElement("canvas").getContext("2d").fillText,"function"))},N.webgl=function(){return!!e.WebGLRenderingContext},N.touch=function(){var n;return"ontouchstart"in e||e.DocumentTouch&&t instanceof DocumentTouch?n=!0:L(["@media (",k.join("touch-enabled),("),v,")","{#modernizr{top:9px;position:absolute}}"].join(""),function(e){n=9===e.offsetTop}),n},N.geolocation=function(){return"geolocation"in navigator},N.postmessage=function(){return!!e.postMessage},N.websqldatabase=function(){return!!e.openDatabase},N.indexedDB=function(){return!!u("indexedDB",e)},N.hashchange=function(){return I("hashchange",e)&&(t.documentMode===n||t.documentMode>7)},N.history=function(){return!(!e.history||!history.pushState)},N.draganddrop=function(){var e=t.createElement("div");return"draggable"in e||"ondragstart"in e&&"ondrop"in e},N.websockets=function(){return"WebSocket"in e||"MozWebSocket"in e},N.rgba=function(){return i("background-color:rgba(150,255,150,.5)"),a(b.backgroundColor,"rgba")},N.hsla=function(){return i("background-color:hsla(120,40%,100%,.5)"),a(b.backgroundColor,"rgba")||a(b.backgroundColor,"hsla")},N.multiplebgs=function(){return i("background:url(https://),url(https://),red url(https://)"),/(url\s*\(.*?){3}/.test(b.background)},N.backgroundsize=function(){return u("backgroundSize")},N.borderimage=function(){return u("borderImage")},N.borderradius=function(){return u("borderRadius")},N.boxshadow=function(){return u("boxShadow")},N.textshadow=function(){return""===t.createElement("div").style.textShadow},N.opacity=function(){return o("opacity:.55"),/^0.55$/.test(b.opacity)},N.cssanimations=function(){return u("animationName")},N.csscolumns=function(){return u("columnCount")},N.cssgradients=function(){var e="background-image:",t="gradient(linear,left top,right bottom,from(#9f9),to(white));",n="linear-gradient(left top,#9f9, white);";return i((e+"-webkit- ".split(" ").join(t+e)+k.join(n+e)).slice(0,-e.length)),a(b.backgroundImage,"gradient")},N.cssreflections=function(){return u("boxReflect")},N.csstransforms=function(){return!!u("transform")},N.csstransforms3d=function(){var e=!!u("perspective");return e&&"webkitPerspective"in g.style&&L("@media (transform-3d),(-webkit-transform-3d){#modernizr{left:9px;position:absolute;height:3px;}}",function(t){e=9===t.offsetLeft&&3===t.offsetHeight}),e},N.csstransitions=function(){return u("transition")},N.fontface=function(){var e;return L('@font-face {font-family:"font";src:url("https://")}',function(n,i){var o=t.getElementById("smodernizr"),r=o.sheet||o.styleSheet,a=r?r.cssRules&&r.cssRules[0]?r.cssRules[0].cssText:r.cssText||"":"";e=/src/i.test(a)&&0===a.indexOf(i.split(" ")[0])}),e},N.generatedcontent=function(){var e;return L(["#",v,"{font:0/0 a}#",v,':after{content:"',x,'";visibility:hidden;font:3px/1 a}'].join(""),function(t){e=t.offsetHeight>=3}),e},N.video=function(){var e=t.createElement("video"),n=!1;try{(n=!!e.canPlayType)&&(n=new Boolean(n),n.ogg=e.canPlayType('video/ogg; codecs="theora"').replace(/^no$/,""),n.h264=e.canPlayType('video/mp4; codecs="avc1.42E01E"').replace(/^no$/,""),n.webm=e.canPlayType('video/webm; codecs="vp8, vorbis"').replace(/^no$/,""))}catch(i){}return n},N.audio=function(){var e=t.createElement("audio"),n=!1;try{(n=!!e.canPlayType)&&(n=new Boolean(n),n.ogg=e.canPlayType('audio/ogg; codecs="vorbis"').replace(/^no$/,""),n.mp3=e.canPlayType("audio/mpeg;").replace(/^no$/,""),n.wav=e.canPlayType('audio/wav; codecs="1"').replace(/^no$/,""),n.m4a=(e.canPlayType("audio/x-m4a;")||e.canPlayType("audio/aac;")).replace(/^no$/,""))}catch(i){}return n},N.localstorage=function(){try{return localStorage.setItem(v,v),localStorage.removeItem(v),!0}catch(e){return!1}},N.sessionstorage=function(){try{return sessionStorage.setItem(v,v),sessionStorage.removeItem(v),!0}catch(e){return!1}},N.webworkers=function(){return!!e.Worker},N.applicationcache=function(){return!!e.applicationCache},N.svg=function(){return!!t.createElementNS&&!!t.createElementNS($.svg,"svg").createSVGRect},N.inlinesvg=function(){var e=t.createElement("div");return e.innerHTML="<svg/>",(e.firstChild&&e.firstChild.namespaceURI)==$.svg},N.smil=function(){return!!t.createElementNS&&/SVGAnimate/.test(C.call(t.createElementNS($.svg,"animate")))},N.svgclippaths=function(){return!!t.createElementNS&&/SVGClipPath/.test(C.call(t.createElementNS($.svg,"clipPath")))};for(var R in N)h(N,R)&&(d=R.toLowerCase(),p[d]=N[R](),D.push((p[d]?"":"no-")+d));return p.input||c(),p.addTest=function(e,t){if("object"==typeof e)for(var i in e)h(e,i)&&p.addTest(i,e[i]);else{if(e=e.toLowerCase(),p[e]!==n)return p;t="function"==typeof t?t():t,"undefined"!=typeof m&&m&&(g.className+=" "+(t?"":"no-")+e),p[e]=t}return p},i(""),y=w=null,function(e,t){function n(e,t){var n=e.createElement("p"),i=e.getElementsByTagName("head")[0]||e.documentElement;return n.innerHTML="x<style>"+t+"</style>",i.insertBefore(n.lastChild,i.firstChild)}function i(){var e=y.elements;return"string"==typeof e?e.split(" "):e}function o(e){var t=v[e[m]];return t||(t={},g++,e[m]=g,v[g]=t),t}function r(e,n,i){if(n||(n=t),c)return n.createElement(e);i||(i=o(n));var r;return r=i.cache[e]?i.cache[e].cloneNode():p.test(e)?(i.cache[e]=i.createElem(e)).cloneNode():i.createElem(e),!r.canHaveChildren||f.test(e)||r.tagUrn?r:i.frag.appendChild(r)}function a(e,n){if(e||(e=t),c)return e.createDocumentFragment();n=n||o(e);for(var r=n.frag.cloneNode(),a=0,s=i(),l=s.length;l>a;a++)r.createElement(s[a]);return r}function s(e,t){t.cache||(t.cache={},t.createElem=e.createElement,t.createFrag=e.createDocumentFragment,t.frag=t.createFrag()),e.createElement=function(n){return y.shivMethods?r(n,e,t):t.createElem(n)},e.createDocumentFragment=Function("h,f","return function(){var n=f.cloneNode(),c=n.createElement;h.shivMethods&&("+i().join().replace(/[\w\-]+/g,function(e){return t.createElem(e),t.frag.createElement(e),'c("'+e+'")'})+");return n}")(y,t.frag)}function l(e){e||(e=t);var i=o(e);return!y.shivCSS||u||i.hasCSS||(i.hasCSS=!!n(e,"article,aside,dialog,figcaption,figure,footer,header,hgroup,main,nav,section{display:block}mark{background:#FF0;color:#000}template{display:none}")),c||s(e,i),e}var u,c,d="3.7.0",h=e.html5||{},f=/^<|^(?:button|map|select|textarea|object|iframe|option|optgroup)$/i,p=/^(?:a|b|code|div|fieldset|h1|h2|h3|h4|h5|h6|i|label|li|ol|p|q|span|strong|style|table|tbody|td|th|tr|ul)$/i,m="_html5shiv",g=0,v={};!function(){try{var e=t.createElement("a");e.innerHTML="<xyz></xyz>",u="hidden"in e,c=1==e.childNodes.length||function(){t.createElement("a");var e=t.createDocumentFragment();return"undefined"==typeof e.cloneNode||"undefined"==typeof e.createDocumentFragment||"undefined"==typeof e.createElement}()}catch(n){u=!0,c=!0}}();var y={elements:h.elements||"abbr article aside audio bdi canvas data datalist details dialog figcaption figure footer header hgroup main mark meter nav output progress section summary template time video",version:d,shivCSS:h.shivCSS!==!1,supportsUnknownElements:c,shivMethods:h.shivMethods!==!1,type:"default",shivDocument:l,createElement:r,createDocumentFragment:a};e.html5=y,l(t)}(this,t),p._version=f,p._prefixes=k,p._domPrefixes=S,p._cssomPrefixes=E,p.mq=j,p.hasEvent=I,p.testProp=function(e){return s([e])},p.testAllProps=u,p.testStyles=L,p.prefixed=function(e,t,n){return t?u(e,t,n):u(e,"pfx")},g.className=g.className.replace(/(^|\s)no-js(\s|$)/,"$1$2")+(m?" js "+D.join(" "):""),p}(this,this.document);