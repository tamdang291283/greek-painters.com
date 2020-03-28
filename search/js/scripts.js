$( document ).ready(function() {

var $wrapper = $('.searchresults');
$wrapper.find('.shopwrapper').sort(function (a, b) {
    return +a.dataset.distance - +b.dataset.distance;
})
.appendTo( $wrapper );


$( "#sortnamedsc" ).click(function() {

     var $wrapper = $('.searchresults');
$wrapper.find('.shopwrapper').sort(function (a, b) {
   return ($(b).text()) > ($(a).text()) ? 1 : -1; 
})
.appendTo( $wrapper );
});

$( "#sortnameasc" ).click(function() {
     var $wrapper = $('.searchresults');
$wrapper.find('.shopwrapper').sort(function (a, b) {
   return ($(b).text()) < ($(a).text()) ? 1 : -1; 
})
.appendTo( $wrapper );
});

$( "#sortpriceasc" ).click(function() {
var $wrapper = $('.searchresults');
$wrapper.find('.shopwrapper').sort(function (a, b) {
    return +a.dataset.distance - +b.dataset.distance;
})
.appendTo( $wrapper );
});

$( "#sortpricedsc" ).click(function() {
var $wrapper = $('.searchresults');
$wrapper.find('.shopwrapper').sort(function (a, b) {
    return +b.dataset.distance - +a.dataset.distance;
})
.appendTo( $wrapper );
});

$( "#sortopen" ).click(function() {
$(".filter").css('background-color','#f3f3f3');
$(".shopwrapper").hide();
$("div").find("[data-open='open']").show();
});

$( "#sortopenclosed" ).click(function() {
$(".filter").css('background-color','#f3f3f3');
$(".shopwrapper").show();

});
 
 
$( ".filter" ).click(function() {
$(".filter").css('background-color','#f3f3f3');
$(".shopwrapper").hide();
$("div").find("[data-foodtype*='" + $(this).data('foodtype') + "']").show();
$(this).css('background-color','#FEC752');
 if ($(window).width() <= 1000) { 

 $("#cusinesearchhide").hide();
	$("#cusinesearchshow").show();
	$('#cuisinesearch').hide(); 
 }
});
 
$( ".filterclear" ).click(function() {
$(".shopwrapper").show();
$(".filter").css('background-color','#f3f3f3');

});


$( "#searchtype" ).click(function() {
$("#autocomplete2").hide();
$("#autocomplete").show();
});

$( "#searchtypename" ).click(function() {
$("#autocomplete").hide();
$("#autocomplete2").show();
});

$( "#searchtypedish" ).click(function() {
$("#autocomplete").hide();
$("#autocomplete2").show();
});

$( "#cusinesearchhide" ).click(function() {
$("#cusinesearchhide").hide();
$("#cusinesearchshow").show();
$('#cuisinesearch').hide(); 
});


$( "#cusinesearchshow" ).click(function() {
$("#cusinesearchshow").hide();
$("#cusinesearchhide").show();
$('#cuisinesearch').show(); 
});


	

});

$(window).load(function() {

 if ($(window).width() > 1000) {  
	$("#cusinesearchhide").hide();
$("#cusinesearchshow").show(); 
	$('#cuisinesearch').show(); 
	}
	if ($(window).width() <= 1000) {
	$("#cusinesearchhide").hide();
	$("#cusinesearchshow").show();
	$('#cuisinesearch').hide();  
	}
       
});

$(window).resize(function() {

 if ($(window).width() > 1000) {  
	$("#cusinesearchhide").hide();
$("#cusinesearchshow").show(); 
	$('#cuisinesearch').show(); 
	}
	
if ($(window).width() <= 1000) { 
	$("#cusinesearchhide").hide();
	$("#cusinesearchshow").show();
	$('#cuisinesearch').hide();   
	}
       
});


