

$(document).ready(function(){

	//check fixed menu
	if($(window).scrollTop()>150)
		{
			$("#categories-hidden-menu").css('position','fixed');
			$("#categories-hidden-menu").css('top','0');
		}
		else
		{
			$("#categories-hidden-menu").css('position','static');
	}

    //collapse FAQS
    $("div.panel-collapse").on('show.bs.collapse',function(){
        $(this).parent("div").find(".panel-header-hidden").removeClass("panel-header-hidden").addClass("panel-header-shown");
        $(this).parent("div").find(".arrow_carrot-2down").css({"transform":"rotate(180deg)"});
    });

    $("div.panel-collapse").on('hide.bs.collapse',function(){
        $(this).parent("div").find(".panel-header-shown").removeClass("panel-header-shown").addClass("panel-header-hidden");
        $(this).parent("div").find(".arrow_carrot-2down").css({"transform":"rotate(0deg)"});
    });

    
    //collapse Special Instruction
    $("div#collapseSpecial").on('show.bs.collapse',function(){
        $(this).parent("div").find(".instruction-heading-hide").removeClass("instruction-heading-hide").addClass("instruction-heading");
        $(this).parent("div").find(".fa-plus").removeClass("fa-plus").addClass("fa-minus") ;
        $("h4.instruction-title a").text("Close");
    });

    $("div#collapseSpecial").on('hide.bs.collapse',function(){
        $(this).parent("div").find(".instruction-heading").removeClass("instruction-heading").addClass("instruction-heading-hide");
        $(this).parent("div").find(".fa-minus").removeClass("fa-minus").addClass("fa-plus") ;
        $("h4.instruction-title a").text("Special Instruction");

    });

    // text in textarea
    $("#valueInstruction")
	  .focus(function() {
	        if (this.value === this.defaultValue) {
	            this.value = '';
	        }
	  })
	  .blur(function() {
	        if (this.value === '') {
	            this.value = this.defaultValue;
	        }
	})	
    $("a.open-dropdown").click(function(event){
    	event.stopPropagation();
    	$(".times-box").css({'display':'block'});
    	$(".times-box ul").animate({
			  height: "220px"
			},300);
    	$(".times-box").css('opacity','1');
    });
    $(document).click(function() {
    	// $(".times-box ul")
    	$(".times-box").css({'display':'none'});
    	$(".times-box").animate({opacity:'0'},300);
    	$(".times-box ul").animate({
			  height: "0px"
			},300);
	});

    //show location picker
	$( document ).on("click","a#picklocation", function() {
	  	$("#hidden-map").animate({top:"0"},400);
	  	$("html").css("overflow","hidden");
	});

	//close location picker
	$( document ).on("click","button.close-map", function() {
	  	$("#hidden-map").animate({top:"100%"},400);
	  	$("html").css("overflow","auto");
	});

	// Close menu when click
	$(document).on('click',function(){
		$("#bs-example-navbar-collapse-1").collapse('hide');
	});


	$(window).scroll(function(){

		// fixed categories menu when scroll
		if($(window).scrollTop()>150)
		{
			$("#categories-hidden-menu").css('position','fixed');
			$("#categories-hidden-menu").css('top','0');
		}
		else
		{
			$("#categories-hidden-menu").css('position','static');
		}

	});


	//scroll-link
	$("a.scroll-nav-link").click(function(e) {

		var id = $(this).attr('href');
	    // target element
	    var $id = $(id);
	    if ($id.length === 0) {
	        return;
	    }
	    // prevent standard hash navigation (avoid blinking in IE)
	    e.preventDefault();
	    var target = $id.children().find('a.collapsed')

	    if(target.length===0){
		    if($(window).scrollTop()>150)
			{
				var pos = $(id).offset().top-72;
			}
			else
			{
				var pos = $(id).offset().top-351;
			}
		    disable_scroll();
		    // animated top scrolling
	    	$('body, html').animate({scrollTop: pos},400,function(){enable_scroll();});
			return;
	    }
	    // top position relative to the document
	    target.click();

	    $id.find('.panel-collapse').on('shown.bs.collapse',function(){
    	if($(window).scrollTop()>150)
		{
			var pos = $(id).offset().top-72;
		}
		else
		{
			var pos = $(id).offset().top-140;
		}
		
	    disable_scroll();
	    // animated top scrolling
	    $('body, html').animate({scrollTop: pos},400,function(){enable_scroll();});

		});
	});

		

	$("a.scroll").click(function(e) {
		
	    // target element id
	    var id = $(this).attr('href');

	    // target element
	    var $id = $(id);
	    if ($id.length === 0) {
	        return;
	    }
	    // prevent standard hash navigation (avoid blinking in IE)
	    e.preventDefault();

	    // top position relative to the document
	    
		var pos = $(id).offset().top-72;
		$('body, html').animate({scrollTop: pos},400,function(){enable_scroll();});
	});

	/*JS DATE*/
	$(function () {
        var dateNow = new Date();
        $('#datetimepicker1').datetimepicker({
        	minDate: dateNow,
            defaultDate:dateNow,
            format:"MM/DD/YYYY"
        });
        $('.input-datetime-picker').click(function() {
            $('#datetimepicker1').datetimepicker('show');
            return false;
      	});
    });

	/*JS append element div*/
	

	// remove cart item
	$( document ).on("click",".remove-cart-item",function(){
		var item = $(this).parents(".cart-item");
		item.remove();
		check_cart_item();
	});

	// check item in basket
	function check_cart_item(old_count){
		var count = $("#your-basket li.cart-item").length;
		if(count<1){
			$("#your-basket div.total").remove();
			$("#your-basket button.btn-checkout").remove();
			$("#no-item-message").text("No Item In Your Basket!")
		}
		else{
			$("#no-item-message").text("");
			if(count==1){
				if(count>old_count){
				var checkout=$(
					'<div class="total">'+
								'<p class=" padding_col">Subtotal'+
									'<span class=" padding_col total-item ">£15.04</span></p>'+
								'<p class="padding_col">Delivery'+
									'<span class=" padding_col total-item">£2.00</span></p>'+
								'<p style="font-size:18px;"><strong class=" padding_col">Total:</strong>'+
									'<span class=" padding_col total-item total_price">£27.00</span></p>'+
								'<!-- button special instructions -->'+
								'<div class="panel-group instruction-group" id="accordionSpecial">'+
									'<div class="panel panel-default instruction-default">'+
									    '<div class="panel-heading instruction-heading-hide">'+
									      	'<h4 class="panel-title instruction-title">'+
									      		'<i id="instruction-icon" class="fa fa-plus" aria-hidden="true"></i>'+
										        '<a data-toggle="collapse" data-parent="#accordion" href="#collapseSpecial">'+
										          	'Special Instructions'+
										        '</a>'+
									      	'</h4>'+
									    '</div>'+
									    '<div id="collapseSpecial" class="panel-collapse collapse instruction-colapse">'+
									      	'<div class="panel-body instruction-body">'+
									      	'<textarea id="valueInstruction" class="instruction-content">Special Instruction...</textarea>'+
									      	'</div>'+
									    '</div>'+
									'</div>'+  
								'</div>	<!--end button special instructions -->'+
								'<button type="button" class="btn btn-large waves-effect btn-placeorder btn-checkout">Place Order</button>'+								
							'</div>');
				$("#your-basket .list_product_add").append(checkout);
				}
			}
		}
	}

	//add item to Basket
	$("#add-to-order").click(function(){
		var count = $("#your-basket li.cart-item").length;
		e.preventDefault();
		var item= $(
			'<li class="cart-item">>'+
			'<i class="fa fa-2x fa-minus-square-o remove-cart-item"></i>'+
			'<p>Demo Dish<span>£9.00</span></p>'+
			'</li>'								
		);
		$("#your-basket .list_product_add ul").append(item);
		check_cart_item(count);

	});

	//add item to Basket
	$("a.no-children-plus").click(function(e){
		var count = $("#your-basket li.cart-item").length;
		e.preventDefault();
		var item= $(
			'<li class="cart-item">'+
			'<i class="fa fa-2x fa-minus-square-o remove-cart-item"></i>'+
			'<p>Demo Dish<span>£9.00</span></p>'+
			'</li>'		
		);
		$("#your-basket .list_product_add ul").append(item);
		check_cart_item(count);

	});
	$("#mark-location").click(function(){
		var value =$("#location-map-input").val();
		document.getElementById("location-input").value = value;
	});


	var	$arg = 0;
	// radio now-late show/hide
	$('input[type="radio"]').click(function(){
        if($(this).attr("value")=="optionsNow"){
            $(".box1").not(".optionsNow").hide();
            $(".optionsNow").show();
            $arg = 0;
        }
        if($(this).attr("value")=="optionLate"){
            $(".box1").not(".optionLate").hide();
            $(".optionLate").show();
            $arg = 1;
        }
    });
    

	// css height tabs - radio now late when resize
    $(window).on('resize', function(){
    	if (($(window).width() <= 1183) && ($(window).width() >=992 ) && $arg == 1  ){
			document.getElementById('tabs').style.height = '130px';
		}
		else {
			document.getElementById('tabs').style.height = '130px';
		}
    });

    $(window).resize(function(){
    	var scrollTo = $(window).scrollTop();
		
    	if ((scrollTo >= 916) && ($(window).width()>=975) ) {
    		var margin=$("html").width()-$("#main-container").width()-30;
    		var width= $("html").width()-margin-$("#menu-list-box").width()-30;
    		$("#order-box").css('position','fixed');
    		$("#order-box").css('right',margin/2+'px');
    		$("#order-box").css('width',width+'px');
    		$("#order-box").css('bottom','0px');
    	}
    	else{
    		// $("div.thumbnail-order-box").removeClass("order-box-fixed");
    		$("#order-box").css('position','static');
    		$("#order-box").css('right','');
    		$("#order-box").css('width','');
    		$("#order-box").css('bottom','');
    		// $("#order-box").css('left',"0px");
    	}
    });

    $(window).on('scroll',function(){
    	var scrollTo = $(window).scrollTop();

    	if ((scrollTo >= 916) && ($(window).width()>=975) ) {
    		var margin=$("html").width()-$("#main-container").width()-30;
    		var width= $("html").width()-margin-$("#menu-list-box").width()-30;
    		$("#order-box").css('position','fixed');
    		$("#order-box").css('right',margin/2+'px');
    		$("#order-box").css('width',width+'px');
    		$("#order-box").css('bottom','0px');
    	}
    	else{
    		// $("div.thumbnail-order-box").removeClass("order-box-fixed");
    		$("#order-box").css('position','static');
    		$("#order-box").css('right','');
    		$("#order-box").css('width','');
    		$("#order-box").css('bottom','');
    		// $("#order-box").css('left',"0px");
    	}
    });

    // $("#datetimepicker1").datepicker();
    // $(".input-datetime-picker").datepicker();
    $(window).onload =(function(){
    	$(window).on('scroll',function(){
    	var scrollTo = $(window).scrollTop();

    	if ((scrollTo >= 916) && ($(window).width()>=975) ) {
    		var margin=$("html").width()-$("#main-container").width()-30;
    		var width= $("html").width()-margin-$("#menu-list-box").width()-30;
    		$("#order-box").css('position','fixed');
    		$("#order-box").css('right',margin/2+'px');
    		$("#order-box").css('width',width+'px');
    		$("#order-box").css('bottom','0px');
    	}
    	else{
    		// $("div.thumbnail-order-box").removeClass("order-box-fixed");
    		$("#order-box").css('position','static');
    		$("#order-box").css('right','');
    		$("#order-box").css('width','');
    		$("#order-box").css('bottom','');
    		// $("#order-box").css('left',"0px");
    	}
    });
    });
});


var keys = [37, 38, 39, 40];
function preventDefault(e) {
  e = e || window.event;
  if (e.preventDefault)
      e.preventDefault();
  e.returnValue = false;  
}
function keydown(e) {
    for (var i = keys.length; i--;) {
        if (e.keyCode === keys[i]) {
            preventDefault(e);
            return;
        }
    }
}
function wheel(e) {
  preventDefault(e);
}
function disable_scroll() {
  if (window.addEventListener) {
      window.addEventListener('DOMMouseScroll', wheel, false);
  }
  window.onmousewheel = document.onmousewheel = wheel;
  document.onkeydown = keydown;
}

function enable_scroll() {
    if (window.removeEventListener) {
        window.removeEventListener('DOMMouseScroll', wheel, false);
    }
    window.onmousewheel = document.onmousewheel = document.onkeydown = null;  
}



// radio delivery - collection
function showDelivery(){
  	document.getElementById('divDelivery').style.display ='block';
  	document.getElementById('delivery1').style.color ='#F7B427';
	document.getElementById('collection1').style.color ='grey';
}
function hideDelivery(){
  	document.getElementById('divDelivery').style.display = 'none';
  	document.getElementById('delivery1').style.color ='grey';
  	document.getElementById('collection1').style.color ='#F7B427';
}
// --------------------------

// radio now-late-css
function hideLate(){

	document.getElementById('tabs').style.height = '115px';
}
function showLate(){
		if (($(window).width() <= 1199) && ($(window).width() >=992 ) ){
			document.getElementById('tabs').style.height = '130px';
		}
		else {
			document.getElementById('tabs').style.height = '130px';
		}	
}
// --------------------------




  
 
