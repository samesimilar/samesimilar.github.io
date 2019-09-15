(function(d){var h=[];d.loadImages=function(a,e){"string"==typeof a&&(a=[a]);for(var f=a.length,g=0,b=0;b<f;b++){var c=document.createElement("img");c.onload=function(){g++;g==f&&d.isFunction(e)&&e()};c.src=a[b];h.push(c)}}})(window.jQuery||window.Zepto);
 $.fn.hasAttr = function(name) { var attr = $(this).attr(name); return typeof attr !== typeof undefined && attr !== false; };
function em1() {
	var c = "tbnftjnjmbsAhnbjm/dpn";
	var addr = "mailto:";
	for(var i = 0; i < c.length; i++)
		addr += String.fromCharCode(c.charCodeAt(i) - 1);
	location.href=addr;
}

$(document).ready(function() {
r = function() {
$('.img').attr('src', (window.devicePixelRatio > 1) ? ((window.devicePixelRatio > 2) ? 'images/tank-2880.png' : 'images/tank-1920.png') : 'images/tank-960.png');};
$(window).resize(r);
r();
if(location.protocol === 'file:')
{
$("head").append($("<link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=PT+Sans|Muli&amp;subset=all'></link>"));
}

});