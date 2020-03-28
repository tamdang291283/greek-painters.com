
<%
    
   if Session("ResID")& "" <> "" then
        session("restaurantid")=Session("ResID")
        Session("ResID") = ""
    else
        session("restaurantid")=Request.QueryString("id_r")
    end if
    %>
    <!-- #include file="Config.asp" -->
    <!-- #include file="../timezone.asp" -->
    <!-- #include file="../restaurantsettings.asp" -->
    <%
   Dim CurrentURL, CurrentFilename
   If UCase(Request.ServerVariables("HTTPS")) = "ON" Then
        CurrentURL = "https://" & Request.ServerVariables("SERVER_NAME")  &  Request.ServerVariables("URL") 
    Else
        CurrentURL = "http://" & Request.ServerVariables("SERVER_NAME")  &  Request.ServerVariables("URL") 
    End If
    


    CurrentFilename = Right(CurrentURL, Len(CurrentURL) - InstrRev(CurrentURL,"/"))

     

    If UCASE(SITE_URL & "LOCAL/" & CurrentFilename) <> UCASE(CurrentURL) and instr( lcase(CurrentURL),"urlrewrite.asp") = 0  Then
        if Request.ServerVariables("QUERY_STRING")  & "" <> "" then
            CurrentFilename  = CurrentFilename & "?"&  Request.ServerVariables("QUERY_STRING")
        end if
      
                 
        Response.Redirect(SITE_URL & CurrentFilename)
    elseif UCase(Request.ServerVariables("HTTPS")) = "OFF" and  instr( lcase(CurrentURL),"urlrewrite.asp") > 0 and instr(lcase(SITE_URL),"https") > 0   then
            Dim httpsURL :  httpsURL = Request.ServerVariables("QUERY_STRING") 
            httpsURL  = replace(httpsURL,"404;http:","https:")
            httpsURL  = replace(httpsURL,":80","")
            
            Response.Redirect(httpsURL)
    End If
      
    %>


<% 
   ' task 263
    Dim StrAllergen : StrAllergen = ""
    function FindAllergen(byval allergen )
             allergens  = "," & replace(allergens," ","") & ","   
            dim result : result = ""
            dim allergenID : allergenID = ""
        if StrAllergen <> "" then
           dim arrAllergen : arrAllergen =  split(StrAllergen,"[**]")
               dim index :  index = 0
            for index = 0 to ubound(arrAllergen) 
                if arrAllergen(index) & "" <> "" then
                    allergenID = split(arrAllergen(index),"|")(0)
                    if allergen = allergenID  then
                        result = arrAllergen(index)
                    end if 
                end if
            next
        end if
        FindAllergen = result
    end function
    'task 263
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
 
    Dim vRestaurantId
    vRestaurantId = session("restaurantid")
    Dim sDayOfWeek
    Dim sHour
    Dim sIsOpen
    Dim sName
    Dim sPostalCode
    Dim sDeliveryFee
    Dim sDeliveryDistance
    Dim sDeliveryMinAmount
    Dim sAverageDeliveryTime
    Dim sAverageCollectionTime
    Dim sRestaurantLat
    Dim sRestaurantLng
    Dim sDistanceCalMethod
    sRestaurantLat = ""
    sRestaurantLng = ""
   
    sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
    sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))
    function formatHourMin(byval hh, byval mm)
        dim result :  result = ""
        if hh < 10 then
            hh = "0" & hh
        end if
        if mm < 10 then
            mm = "0" & mm
        end if
        result = hh & ":" & mm
        formatHourMin = result
    end function
     Dim hhmm1 : hhmm1=  formatHourMin(Hour(DateAdd("h",houroffset,now)),Minute(DateAdd("h",houroffset,now)))

    objCon.Open sConnString
     objRds.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & vRestaurantId, objCon
     dim objRdsMainCategory
    Set objRdsMainCategory = Server.CreateObject("ADODB.Recordset") 
  Dim limittopping , s_BannerURL 
 ' check url
     '' Get Url Menu, checkout , thanks
    dim MenuURL,CheckoutURL,ThankURL
        CheckoutURL = SITE_URL& "checkOut.asp?id_r=" & vRestaurantId
    
    if vRestaurantId & "" <> "" and request.querystring("timeout") <> "yes" then
           dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
               rs_url.open  "SELECT FromLink FROM URL_REWRITE a inner join BusinessDetails b on (a.RestaurantID=b.ID )  where RestaurantID=" & vRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' " ,objCon
           while not rs_url.eof 
               if instr(lcase(rs_url("FromLink")),"/menu") > 0 then
                     if instr(lcase(CurrentURL),"urlrewrite.asp") = 0 then
                        Dim sURLRedirect : sURLRedirect  = Replace( lcase( rs_url("FromLink")& ""),"http://","https://")
                            rs_url.close()
                            set rs_url = nothing
                            objCon.close()
                            set objCon = nothing
                        if instr( lcase(SITE_URL),"https://") = 0 then
                            sURLRedirect = replace(sURLRedirect,"https://","http://") 
                            
                        end if
                        sURLRedirect =  replace(lcase(sURLRedirect),lcase(SITE_URL),lcase(SITE_URL) & "local/")
                        Response.Redirect( sURLRedirect ) 
                     end if   
                     MenuURL = rs_url("FromLink")
               elseif  instr(lcase(rs_url("FromLink")),"/checkout") > 0 then
                     CheckoutURL = rs_url("FromLink")
               elseif instr(lcase(rs_url("FromLink")),"/thanks") > 0 then
                     ThankURL = rs_url("FromLink")
               end if 
               rs_url.movenext()
           wend
            rs_url.close()
        set rs_url =  nothing
        MenuURL =  replace(lcase(MenuURL),lcase(SITE_URL),lcase(SITE_URL) & "local/")  

        CheckoutURL =  replace(lcase(CheckoutURL),lcase(SITE_URL),lcase(SITE_URL) & "local/")

        ThankURL =  replace(lcase(ThankURL),lcase(SITE_URL),lcase(SITE_URL) & "local/") 
         if instr( lcase(SITE_URL) ,"https://") > 0  then
            MenuURL  = replace(MenuURL,"http://","https://")               
            CheckoutURL  = replace(CheckoutURL,"http://","https://")  
            ThankURL  = replace(ThankURL,"http://","https://")   
            
         end if  
    end if
      
'check opening times

Set objRds2 = Server.CreateObject("ADODB.Recordset") 

objRds2.Open "SELECT convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeek & " order by DayOfWeek, Hour_From", objCon
'loop through opening time
isopen=false
Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
'response.write sHour
     Dim Hour_From : Hour_From = FormatTimeC(objRds2("Hour_From"),8)
    Dim Hour_To : Hour_To =  FormatTimeC(objRds2("Hour_To"),8)
 if DateDiff("n",Hour_From,Hour_To)<0 then
	if (sHour >= Hour_From and sHour <= "23:59:00") or (sHour >= "00:00:00"  and sHour <= Hour_To ) Then
		sisopen=true
	end if
 else
	if (Hour_From <= sHour and Hour_To >= sHour) Then
		sisopen=true
	end if
end if
objRds2.MoveNext    
Loop

objRds2.Close
    set objRds2 = nothing
'if it is has found not to be open and time is early morning then check previous days time
if isopen=false and DateDiff("n",sHour,"12:00:00")>0 then
sDayOfWeekprev=sDayOfWeek-1
if sDayOfWeekprev=0 then
sDayOfWeekprev=7
end if
Set objRds2 = Server.CreateObject("ADODB.Recordset") 
objRds2.Open "SELECT convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeekprev, objCon

Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
    Dim o_Hour_From : o_Hour_From = FormatTimeC(objRds2("Hour_From"),8)
    Dim o_Hour_To : o_Hour_To =  FormatTimeC(objRds2("Hour_To"),8)
 if DateDiff("n",o_Hour_From,o_Hour_To)<0 then
	if (sHour <= o_Hour_To) Then
		sisopen=true
	end if
end if
objRds2.MoveNext    
Loop
objRds2.Close
    set objRds2 = nothing
end if
    ' task 263    
    EnableAllergen = objRds("EnableAllergen") & ""
    EnableSuitableFor = objRds("EnableSuitableFor") & ""
    if EnableAllergen = "" then
        EnableAllergen = "No"
    end if 
    if EnableSuitableFor = "" then
        EnableSuitableFor = "No"
    end if 

    Dim SQL1 : SQL1 = "select ID,Name,icon,Type from allergen with(nolock) "
    if EnableAllergen = "Yes" and EnableSuitableFor = "No"  then
        SQL1 = SQL1 &  " where type ='Allergen' " 
    elseif EnableAllergen = "No" and EnableSuitableFor = "Yes"  then
        SQL1 = SQL1 &  " where type ='SuitableFor' " 
    elseif EnableAllergen = "No" and EnableSuitableFor = "No"  then
         SQL1 = SQL1 &  " where 1 != 1 " 
    end if
   
    Dim Rs_Allergen : set Rs_Allergen =  Server.CreateObject("ADODB.Recordset")
        Rs_Allergen.open  SQL1 ,objCon
    while not Rs_Allergen.EOF 
        if StrAllergen = "" then
            StrAllergen =   Rs_Allergen("ID") & "|" & Rs_Allergen("Name") & "|" & Rs_Allergen("icon") & "|" & Rs_Allergen("Type")
        else
            StrAllergen =  StrAllergen & "[**]" & Rs_Allergen("ID") & "|" & Rs_Allergen("Name") & "|" & Rs_Allergen("icon") & "|" & Rs_Allergen("Type")
        end if
     
        Rs_Allergen.movenext() 
    wend
        Rs_Allergen.close()
    set Rs_Allergen = nothing
    'End task 263

    s_BannerURL = trim( objRds("s_BannerURL") & "" ) 
    sName = objRds("Name")
    sPostalCode = objRds("PostalCode")
    sDeliveryFreeDistance  = 0
    sDeliveryMaxDistance  = 0
    sDeliveryFee = 0
    sDeliveryMinAmount  = 0
	menupagetext=objRds("menupagetext")
	sorderonlywhenopen = objRds("orderonlywhenopen")
	sorderdisablelater = objRds("disablelaterdelivery")
	individualpostcodeschecking=objRds("individualpostcodeschecking")
    sDistanceCalMethod = ""
	
	if not isnull(objRds("individualpostcodes")) then
	
	individualpostcodes="|" & replace(objRds("individualpostcodes"),",","|") & "|"
	end if
    sDeliveryChargeOverrideByOrderValue = 1000000000
    if Not IsNull(objRds("DeliveryMaxDistance")) Then sDeliveryMaxDistance = Cdbl(objRds("DeliveryMaxDistance"))
    if Not IsNull(objRds("DeliveryFreeDistance")) Then sDeliveryFreeDistance = Cdbl(objRds("DeliveryFreeDistance"))
    if Not IsNull(objRds("DeliveryMinAmount")) Then sDeliveryMinAmount = Cdbl(objRds("DeliveryMinAmount"))
    if Not IsNull(objRds("DeliveryFee")) Then sDeliveryFee = Cdbl(objRds("DeliveryFee"))
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))
	if Not IsNull(objRds("DeliveryChargeOverrideByOrderValue")) Then sDeliveryChargeOverrideByOrderValue = Cdbl(objRds("DeliveryChargeOverrideByOrderValue"))
	if Not IsNull(objRds("Latitude")) Then sRestaurantLat = objRds("Latitude")
    if Not IsNull(objRds("Longitude")) Then sRestaurantLng = objRds("Longitude")
    If not IsNull(objRds("distancecalmethod")) Then sDistanceCalMethod = objRds("distancecalmethod")

%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Menu - <%= objRds("Name")%></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="description" content="">
  <meta name="author" content="">
  
  
	<!--link rel="stylesheet/less" href="../less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="../less/responsive.less" type="text/css" /-->
	<!--script src="../Scripts/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="<%=SITE_URL %>css/bootstrap.css" rel="stylesheet">
    <link href="stylesheet" href="<%=SITE_URL %>css/bootstrap-select.css">
	<link href="<%=SITE_URL %>css/style.css?v=1.7" rel="stylesheet">
    
    <link href="<%=SITE_URL %>css/product.css?v=1.9" rel="stylesheet">
	<link href="<%=SITE_URL %>css/datepicker.css" rel="stylesheet">
	<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="<%=SITE_URL %>css/addtohomescreen.css">


    <link rel="stylesheet" type="text/css" href="<%=SITE_URL %>css/product-menu-demo.css">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="../Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
 
 

<meta name="apple-mobile-web-app-title" content="<%= objRds("Name")%>">
<% If FAVICONURL & "" <> "" Then %>
<link rel="shortcut icon" sizes="16x16" href="<%=FAVICONURL %>">
<% End if %>
<% If ADDTOHOMESCREENURL & "" <> "" Then %>
<!--link rel="apple-touch-icon-precomposed" sizes="152x152" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="120x120" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="76x76" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=ADDTOHOMESCREENURL %>"-->
<link rel="apple-touch-icon-precomposed" href="<%=ADDTOHOMESCREENURL %>">
<% end if %>

  <script>
    
   var individualpostcodeschecking ;
     <% if individualpostcodeschecking = 0 then %>  
      individualpostcodeschecking = false;
      <% else %>
     individualpostcodeschecking = true;

      <% end if %>

  </script>
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.min.js"></script>
    <script defer type="text/javascript" src="<%=SITE_URL %>Scripts/jquery.lazy.min.js"></script>
	<script defer type="text/javascript" src="<%=SITE_URL %>Scripts/js.cookie.js"></script>
	
	
	<script type="text/javascript" src="<%=SITE_URL %>Scripts/bootstrap.min.js"></script>
	<script defer  type="text/javascript" src="<%=SITE_URL %>Scripts/scripts.js"></script>
	
    <script defer src="<%=SITE_URL %>Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="<%=SITE_URL %>Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script defer  src="<%=SITE_URL %>Scripts/bootstrap-select.js?v=2.7"></script>
    <script defer type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&libraries=places"></script>
	
	  
	<style media="screen" type="text/css">
         img.lazy {
            display: block;
        }
<%= objRds("css")%>

.loader {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url('<%= objRds("ImgUrl") %>') 50% 50% no-repeat rgb(249,249,249);
}
.pac-container {z-index:10000;}

@media only screen and (max-width: 767px){

.social-thumb{
display:block;
margin-top: 5px;
}
.social-text{display: none}
.link-book-table{margin-top:0;}
#topmenumobile .thumb-special-offers{
margin-bottom: 10px;
}
.icon-thumb{
text-align: right;
}
#mainmenu{
top: 0;
}
}

#topmenumobile .media:first-child{
padding: 0 15px;
}

#wholepage{
padding-top: 0px;
}

#header{
position: static;
margin-bottom: 15px;
padding: 15px 0!important;
}
div#topmenumobile {
    display: flex;
    align-items: center;
}
.social-info {
    min-width: 125px;
    margin-left: auto;
text-align: right;
}

.media, .media .media {
    margin-top: 0px;
}

@media only screen and (max-width: 767px){

    #topmenumobile .media > a {
        float: none !important;
        display:block;
        margin-bottom: 10px
    }

    #topmenumobile .media-body div, #topmenumobile .media-body i{
        font-size: 12px;
    }

   
      .social-info{
        min-width: 182px;
    }
   

}

	   
       
@media only screen and (max-width: 413px){
    .social-info{
        min-width: 135px;
    }
    #topmenumobile .media-body div{font-size: 10px}
  
}

#topmenumobile .u-display-block .glyphicon {
    font: normal normal normal 14px/1 FontAwesome;
}

@media (max-width: 767px){
   
    .link-book-table {
        line-height: 1.42857143;
         padding: 6px 8px;
    }
   
    .link-book-table .glyphicon{
        margin-left: 0;
    }
   
}

</style>

<script>
function checkboxlimit(checkgroup, limit){          
          $("[toppinggroup=" + checkgroup + "]").each(function(){
              $(this).bind("click",function(){
                  var checkedcount=0;
                  $("[toppinggroup=" + checkgroup + "]").each(function(){
                      if($(this).is(":checked"))
                          checkedcount+=1;
                  });
                  if (checkedcount>limit){
                      alert("You can only select a maximum of "+limit+" checkboxes");
                      $(this).prop("checked", false);
                  }
              });
          });  
         
      }
 function ShowdishpropertiesV2( itemtoshow) {
        if($("#" + itemtoshow).is(":visible") ){
            $("#img" + itemtoshow).addClass("arrow-icon-down").removeClass("arrow-icon-up");
            $("#" + itemtoshow).slideUp("slow");
        }
        else{
            $("#img" + itemtoshow).addClass("arrow-icon-up").removeClass("arrow-icon-down");
            $("#" + itemtoshow).slideDown("slow");
        }
    }
		
    
<!-- Begin Update re_menu -->

function scrollToV2(id)
{
  // Scroll
  $('html,body').animate({scrollTop: $("#"+id).offset().top-160},'slow');
}
function scrollToV3(id,farTop)
{
  // Scroll
  $('html,body').animate({scrollTop: $("."+id).offset().top-farTop},'slow');
}

<!-- end Update re_menu -->
function scrollMobile()
        {
            $(window).scroll(function(){
                  if($(window).scrollTop()>80)
		            {
			           // $("#topmenumobile").hide();
                       var menuWidth = $('.menu-bar-wrapper').width();
                       $('.menu-bar-wrapper').css('width',menuWidth);
                        $('.menu-bar-wrapper').addClass('fix-header');
                        
                        $(".fake-header").show();

		            }
		            else
		            {  // $("#topmenumobile").show();
                        $('.menu-bar-wrapper').removeClass('fix-header');
                        $('.menu-bar-wrapper').css('width','auto');
			            $(".fake-header").hide();
	                }
	        });
 
           
        }


    var screenmode = "deskstop";
    
    function detechScreen()
    {
        if($(window).width() <=992 && screenmode=="deskstop"){
                $("[data-type='group-cate']").each(function(){
                    $(this).hide();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                });
                
                screenmode= "mobile";
                 //$("#mainmenu").css("top","136px");
               
       }else if($(window).width() > 992 && screenmode=="mobile"){
                $("[data-type='group-cate']").each(function(){
                    $(this).show();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
                });
                 //$("#mainmenu").css("top","0px");
                 screenmode = "deskstop";

        }
    }
     $(document).ready(function(){
        if($(window).width() <=992){

                  $("[data-type='group-cate']").each(function(){
                        $(this).hide();
                        $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                    });
                    scrollMobile();
                
                    screenmode= "mobile";
                }else{
                 
                  $("[data-type='group-cate']").each(function(){
                        $(this).show();
                        $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
                    });
                    screenmode= "deskstop";
              }
    }
    );

   $(window).on('resize', function () {
        detechScreen();
    }); 
  var _scrollTopHeight;
$(window).load(function() {

 if ($(window).width() <= 992) {  

            $(window).off('.affix');
$('#rightaffix').removeData('bs.affix').removeClass('affix affix-top affix-bottom');

       }

       if($(window).width() <= 768) {  
_scrollTopHeight = 257;
} else {_scrollTopHeight = 277}

$(window).resize(function(){

      if ($(window).width() <= 992) {  

            $(window).off('.affix');
$('#rightaffix').removeData('bs.affix').removeClass('affix affix-top affix-bottom');

       } 

        if($(window).width() <= 768) {  
_scrollTopHeight = 257;
} else {_scrollTopHeight = 277}

});


$('.movedown').click(function(e){
$('#navbar-menu-mobile').slideToggle();
if(($(window).scrollTop()>80)){
    scrollToV3($(this).attr('data'),53);
}
else{
    scrollToV3($(this).attr('data'),_scrollTopHeight);
}
});

$('.btnadd').click(function(e){
 
   
    $('#addtobasket').fadeIn('slow', function(){
        $('#addtobasket').delay(1000).fadeOut('slow');
		
    });	
});

$( "#butcontinue" ).click(function() {
scrollToV2("beforeorder");
});


$( "#butbasket" ).click(function() {
scrollToV2("basket");
});

$( ".catlink" ).click(function() {
$(".catlink").css({'background-color':'#f3f3f3'});
$(this).css({'background-color':'#c0c0c0'});
});




});



$(document).ready(function() {

	$("form").keypress(function(e) {
  //Enter key
  if (e.which == 13) {
CheckDistance();
    return false;
  }
});

<%if  request.querystring("timeout")="yes" then%>

                $("#SessionTimeout").modal();
				
<%end if%>

<%if  objRds("announcement")<>"" and 1 = 2 then%>

$("#AnnouncementModal div.modal-body").html('<%=replace(objRds("announcement"),vbCrLf,"<BR>")%>');
                $("#AnnouncementModal").modal();
				
<%end if%>
	
});


	




</script>
	
	
	<script>
var nua = navigator.userAgent;
var is_android = ((nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1) && !(nua.indexOf('Chrome') > -1));
if(is_android) {
        $('#bs-example-navbar-collapse-1').removeClass("scrollable-menu");
		

}

</script>

</head>

<body>
<div class="fake-header" style="display:none;"></div>
<div class="loader"></div>
<div  id="wholepage" style="padding-bottom:100px;display:none;">

	<div class="row clearfix headerbox" id="header">
		<div class="col-md-12 col-xs-12" style="padding-bottom:10px;">
			<div class="media">
				 <a href="#" class="pull-left"><img src="<%= objRds("ImgUrl") %>" width=70 class="media-object" alt="<%= objRds("Name") %>"></a>
				<div class="media-body">
					<h4 class="media-heading">
				
				<div style="float:right;">
				
				<div class="hidden-xs">
				<span class="glyphicon glyphicon glyphicon-earphone"></span> <%= objRds("Telephone") %> 
                <span class="glyphicon glyphicon glyphicon-envelope"></span>  <%= objRds("Email") %></div>
                <div class="visible-xs">


                <a  class="link-book-table"  href="https://www.google.co.uk/maps?q=<%= objRds("Address") %>" target="_blank"><span class="glyphicon glyphicon-map-marker"></span></a>
                <a  class="link-book-table" href="tel:<%= objRds("Telephone") %>"><span class="glyphicon glyphicon-earphone"></span></a>
                <a  class="link-book-table" href="mailto:<%= objRds("Email") %>"><span class="glyphicon glyphicon-envelope"></span></a>

                </div>
                </div>	
						 <%= objRds("Name") %>

					</h4><div class="hidden-xs"><b><%= objRds("Address") %> </b><br></div>


<%= objRds("FoodType") %>
					
			</div>
			</div>
		</div>
		 <%            
            objRds.Close
        
        %>	
		
	</div>
    <div class="container">
        
          <% if s_BannerURL & "" <> "" then %>
        <div  style="overflow:hidden;" class="banner">
            <img src="<%=s_BannerURL %>" style="padding-bottom:15px;width:100%;" />
        </div>
            <div style="height:15px;"></div>
        <%end if %>
           <style>
            
.nav-stacked.nav-stacked.nav-pills.navdesktop li:nth-child(2){
padding-top:0;
}
.sidebar-header.sidebar-header{
background-color: #94b604;
    z-index: 100;
    width: 192px;
    color: #fff;
    border-color: #94b604;
    border: 1px solid #94b604;
    border-radius: 4px;
    padding: 10px 10px;
    border-bottom: 0px solid transparent;
    border-bottom-right-radius: 0px;
    border-bottom-left-radius: 0px;
    font-size: 18px;
}
.nav-stacked.nav-pills.navdesktop{
    border-top-right-radius: 0px;
    border-top-left-radius: 0px;
}

@media only screen and (max-width: 1199px){
.sidebar-header.sidebar-header{
max-width: 154.3px;
}

}
@media only screen and (max-width: 991px){
.sidebar-header.sidebar-header {
    display: none!important;
}
}


        </style>
	    <div class="row clearfix">
		    <div class="col-md-2 visible-md visible-lg" id="categories">
		
		    <div data-spy="affix" data-offset-top="300" data-offset-bottom="200">
			    <div style="width:165px; height : 450px; overflow : auto; " class="hidden-xs">
                    <div class="sidebar-header">
	                    <b>Categories</b>
                    </div>
                    <ul class="nav nav-stacked nav-pills navdesktop" style="width:155px;overflow : auto;height: 80vh;border-top-right-radius: 0px;border-top-left-radius: 0px;">
				   
				
			      <%
                        Dim SQLCategory 
                        SQLCategory ="  SELECT DISTINCT mc.id, mc.NAME, mc.description, displayorder ,ct.DayValue, convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To "
                        SQLCategory = SQLCategory & " FROM   ( menucategories AS mc  "
                        SQLCategory = SQLCategory & "        INNER JOIN Category_Openning_Time as ct "
                        SQLCategory = SQLCategory & "          on ( ct.categoryid = mc.id and ct.DayValue= " & sDayOfWeek & "   and ct.hour_from <= '" & hhmm1&"' and hour_to >= '"&hhmm1&"' and ct.status = 'ACTIVE'  )  ) "
                        SQLCategory = SQLCategory & "        INNER JOIN menuitems AS mi "
                        SQLCategory = SQLCategory & "                ON mc.id = mi.idmenucategory "
                        SQLCategory = SQLCategory & "  WHERE  mc.idbusinessdetail = " & vRestaurantId & "  "
                        SQLCategory = SQLCategory & "        AND (( ( mi.idbusinessdetail ) = " & vRestaurantId & "  )) "
                        SQLCategory = SQLCategory & "        AND mi.hidedish <> 1 "
                        SQLCategory = SQLCategory & " ORDER  BY mc.displayorder; "
                  'objCon.Open sConnString
       
              objRdsMainCategory.Open   SQLCategory , objCon
                            if not objRdsMainCategory.EOF then
                        
                                Do While NOT objRdsMainCategory.Eof
						
                                %>
                                <li ><a href="#menucat_<%=objRdsMainCategory("ID") %>" class="catlink" onclick="SelectLeftategory(<%=objRdsMainCategory("ID") %>);">
                                    <%= objRdsMainCategory("Name") %></a> </li>
                                <%
                                    objRdsMainCategory.MoveNext    
                                Loop
                                objRdsMainCategory.MoveFirst()
                            end if
                            %>
				
			    </ul>
			    </div></div>
		    </div>
           <script>
        function SelectLeftategory(ID)
        {
              $("#txtSearch").val("");
                $("#tabmenu").trigger("click");
                $(".product-line-heading").show();
                $("[data-type=group-cate]").each(function(){
                    var categroup  = $(this);
                    categroup.find(".product-line").each(function(){
                            $(this).show();
                    });
                });
            $("#categroup-" + ID ).hide();
            $("#categroup-" + ID ).show();
            document.location.href = document.location.href.replace(document.location.hash,"") + "#menucat_" +  ID;
        }
    </script>
		    <div class="col-md-6half column" id="mainmenu">
			    <ul class="nav nav-stacked nav-pills">
			
				    </ul>

    <!-- Begin update html menu bar -->

    <div class="menu-bar-wrapper">
    <div class="menu-bar">
        <div class="menu-bar__item menu-bar__menu active" onclick="if($('#txtSearch').val() !='') { $('#txtSearch').val('');SearchTerms('txtSearch'); }  $('#navbar-menu-mobile').slideToggle();$('.js-menu-custom-item').slideUp();">
            <span class="glyphicon glyphicon-align-justify"></span> <span class="menu-text hidden-xs"> Menu</span>
        </div>
        <div class="menu-bar__item menu-bar__search" onclick="if($('#txtSearch').val() !='') { $('#txtSearch').val('');SearchTerms('txtSearch'); } $('.js-menu-custom-item').slideToggle('fast');$('#navbar-menu-mobile').slideUp();">
            <span class=" glyphicon glyphicon-search"></span>
            <span class="menu-text hidden-xs">Search</span>
        </div>
          <% if StrAllergen & "" <> "" then %>
      <div   class="menu-bar__item menu-bar__booking"   data-toggle="modal" data-target="#FilterModal">
        <span class="glyphicon glyphicon-filter" id="icoAllergenFilter"></span>
        <span class="menu-text">Filter</span>
    </div>
    <% end if %>
        <div class="menu-bar__item menu-bar__login visible-sm visible-xs" data-toggle="modal" data-target="#loginModal">
            <span class="glyphicon glyphicon-user"></span>
            <span class="menu-text hidden-xs">Login</span>
        </div>
        <div class="menu-bar__item menu-bar__review" data-toggle="modal" data-target="#reviewsModal" >
            <span class="glyphicon glyphicon-comment"></span>
            <span class="menu-text hidden-xs">Review<span>
        </div>
    </div>

    <div class="collapse scrollable-menu hidden-lg hidden-md" id="navbar-menu-mobile" style="display:none;">
        <ul class="nav navbar-nav">
            <%
            if not objRdsMainCategory.EOF then
                Do While NOT objRdsMainCategory.Eof
        
                %>
                <li ><a class="movedown" data="categroup-<%=objRdsMainCategory("ID") %>"  onclick="CategorySelection('categroup-<%=objRdsMainCategory("ID") %>');">
                    <%=objRdsMainCategory("Name") %></a> </li>
                <%
                    objRdsMainCategory.MoveNext    
                Loop
                objRdsMainCategory.MoveFirst()
            end if
        %>
        </ul>   
    </div>
    <div class="alpha-search-custom js-menu-custom-item">
        <div class="input-group" style="width:100%;">
        <input type="search" class="search-query form-control clearable" spellcheck="false"  autocapitalize="off" autocomplete="off" autocorrect="off" id="txtSearch" onchange="SearchTerms('txtSearch');" onkeyup="SearchTerms('txtSearch');"  placeholder="Search as you type" />
       <!-- <span class="input-group-btn">
            <button class="btn btn-primary" type="button">Search</button>
          </span>-->
        </div>
    </div>

    </div>

    <!-- End update menu bar -->

    <script type="text/javascript">
        function tog(v){return v?'addClass':'removeClass';} 

            $(document).on('input', '.clearable', function(){
                $(this)[tog(this.value)]('x');
            }).on('mousemove', '.x', function( e ){
                $(this)[tog(this.offsetWidth-18 < e.clientX-this.getBoundingClientRect().left)]('onX');
            }).on('touchstart click', '.onX', function( ev ){
                ev.preventDefault();
                $(this).removeClass('x onX').val('').change();
                SearchTerms('txtSearch');
            });

                        $(".clearable").trigger("input");

    </script>
                
				
                           <% 
                
                    Dim vCategoryId                
                    Dim vMenuItemId
                    Dim vMenuItemPrice
                    Dim f  
                    dim objRds_MenuItem : set objRds_MenuItem  =  Server.CreateObject("ADODB.Recordset")
                    dim SQL 
                        SQL = " SELECT mi.*, mi.Name AS Name, "
                        SQL =SQL & " mip.Id AS PropertyId, mip.Name AS PropertyName, "
                        SQL =SQL & "mip.Price AS PropertyPrice,  mi.allowtoppings AS miallowtoppings, "
                        SQL =SQL & " mip.allowtoppings AS mipallowtoppings,mip.i_displaysort  "
                        SQL = SQL & ",mip.s_ContainAllergen as s_ContainAllergen_p,mip.s_MayContainAllergen as s_MayContainAllergen_p,mip.s_SuitableFor as s_SuitableFor_p "
                        SQL = SQL & ",mi.s_ContainAllergen as s_ContainAllergen_m,mi.s_MayContainAllergen as s_MayContainAllergen_m,mi.s_SuitableFor as s_SuitableFor_m "
                        SQL =SQL & " FROM  MenuItems AS mi "
                        SQL =SQL & " LEFT JOIN MenuItemProperties AS mip ON mi.Id = mip.IdMenuItem "
                        SQL =SQL & "WHERE    mi.idbusinessdetail =  " & vRestaurantId & "  AND mi.hidedish<>1 "
                        SQL =SQL & " ORDER BY mi.i_displaysort,mi.id,mip.i_displaysort,mip.Id; "
                    objRds_MenuItem.Open SQL, objCon 
                    dim categoryID,CategoryName,CategoryDescription
                    dim s_ContainAllergen_p,s_MayContainAllergen_p,s_SuitableFor_p 
                            dim s_ContainAllergen_m,s_MayContainAllergen_m,s_SuitableFor_m
                    while not objRdsMainCategory.EOF
                                    
                            categoryID = objRdsMainCategory("ID")
                            CategoryName = objRdsMainCategory("Name")
                            CategoryDescription = objRdsMainCategory("Description")
                            %>
                            <div class="categroup-<%=categoryID %> "></div>
                                <div id="group-categroup-<%=categoryID %>" class="product-line-heading clearfix" onclick="ShowdishpropertiesV2('categroup-<%=categoryID %>')">
                                <h4 class="product-line-heading__cat pull-left" >
                                <a id="menucat_<%=categoryID %>" name="menucat_<%=categoryID %>" ></a>
                                <%= CategoryName%>   
                                </h4>
                                <div class="product-line-heading__icon-wrapper is-vertical-center">
                                    <img class="product-line-heading__icon" src="<%=SITE_URL %>images/menu-category-collapse--retina.png" alt="" id="imgcategroup-<%=categoryID %>">
                                </div>            
                                <% if CategoryDescription & "" <> "" then %>
                                    <div class="product-line-heading__cat-des">
                                        <%= CategoryDescription %>
                                    </div>    
                                <% end if %>  
                                    </div>
                            <div id="categroup-<%=categoryID %>" class="group-ptoduct-line" data-type="group-cate">
                            <%
                             ' Load Menu Item 
                                objRds_MenuItem.Filter =  " IdMenuCategory = " & categoryID  & ""

                                dim Code,MenuDescription,dishpropertygroupid,hidedish
                                dim MenuItemName,Photo,MenuPrice,menuPrintingName,Spicyness,Vegetarian
                                dim PropertyName,PropertyId,PropertyPrice,miallowtoppings,mipallowtoppings
                            
                                MenuItemName = ""
                                dim menuItemNameID : menuItemNameID = ""
                                while not objRds_MenuItem.EOF
                                       s_ContainAllergen_m = replace(objRds_MenuItem("s_ContainAllergen_m") & ""," ","")
                                    s_MayContainAllergen_m = replace(objRds_MenuItem("s_MayContainAllergen_m") & ""," ","")
                                    s_SuitableFor_m = replace(objRds_MenuItem("s_SuitableFor_m") & ""," ","")
                            
                                    s_ContainAllergen_p = replace(objRds_MenuItem("s_ContainAllergen_p") & ""," ","")
                                    s_MayContainAllergen_p = replace(objRds_MenuItem("s_MayContainAllergen_p") & ""," ","")
                                    s_SuitableFor_p = replace(objRds_MenuItem("s_SuitableFor_p") & ""," ","") 
                                       vMenuItemId = objRds_MenuItem("Id")
                                       Code =  objRds_MenuItem("Code")
                                       MenuDescription = objRds_MenuItem("Description")
                                       dishpropertygroupid = objRds_MenuItem("dishpropertygroupid")
                                       hidedish = objRds_MenuItem("hidedish")
                                       MenuItemName = objRds_MenuItem("Name")
                                       Photo = objRds_MenuItem("Photo")
                                       MenuPrice = objRds_MenuItem("Price")
                                       menuPrintingName = objRds_MenuItem("PrintingName")
                                       Spicyness = objRds_MenuItem("Spicyness")
                                       'Vegetarian = objRds_MenuItem("Vegetarian")
                                       PropertyName = objRds_MenuItem("PropertyName")
                                        PropertyId = "-1"
                                         If Not IsNull(objRds_MenuItem("PropertyId")) Then
                                            PropertyId = objRds_MenuItem("PropertyId")
                                            PropertyPrice = objRds_MenuItem("PropertyPrice")   
                                            if MenuPrice & "" = "0" or MenuPrice & "" = ""  then 
                                                MenuPrice = PropertyPrice
                                            end if                     
                                        End If
                                   
                                       miallowtoppings = objRds_MenuItem("miallowtoppings")
                                       mipallowtoppings = objRds_MenuItem("mipallowtoppings")
                            
                                        dim class_noborder : class_noborder = ""
                                        if menuItemNameID = vMenuItemId then
                                            class_noborder = " no-border"
                                        End if
                                        dim parent : parent = "" 
                                         if menuItemNameID <> vMenuItemId then
                                                parent = "parent='0'"
                                        end if
                                           %>

                              
                                    <div class="product-line <%=class_noborder %>" name="<%=vMenuItemId %>" <%=parent %> >
                                        <!--Menu Item Name-->                                  
                                   
                                            <% 
                                          
                                                if menuItemNameID <> vMenuItemId then  %>
                                                     <div class="product-line__content-left<%=class_noborder %>">
                                                        <div class="d-flex-center d-flex-start">
                                                 <%
                                                     dim styleMarginleft : styleMarginleft =""
								                If Photo <> "" Then 
                                                     styleMarginleft = "style='margin-left:12px;' "
								                   photo=1%>
                                                       <div  class="product10w photo" data-toggle="modal" data-target="#lightbox">  
                                                            <img data-src="<%=SITE_URL %>Images/<%=vRestaurantId %>/<%= objRds_MenuItem("Photo")%>" class="img-rounded lazy" alt="<%= MenuItemName%>" style="vertical-align: top;width:30px;max-width:40px;" /> 
                                                                <div class="overlay">
                                                                        <a href="javascript:;"  class="magnifying-glass-icon foobox" style="top:12px;left:20px;">
                                                                        <i class="fa fa-search"></i>
                                                                        </a>
                                                                </div>
						                                </div>	
                                                <%End If %>


											    <div class="product-line__number" <%=styleMarginleft %>>
                                                <% If Code <> "" Then 
								                    code=1%>
                                                   
                                                        <%= objRds_MenuItem("Code")  %>.
                                                    <%End If %>
											    </div>




                                                <div class="product-line__description desc "   s_ContainAllergen_m="<%=s_ContainAllergen_m & "|" & s_MayContainAllergen_m %>" s_MayContainAllergen_m="<%=s_MayContainAllergen_m %>" s_SuitableFor_m="<%=s_SuitableFor_m %>">
                                                <%=MenuItemName %>
                                                <%If Vegetarian Then %>
                                                    <!--<img src="<%=SITE_URL %>Images/veggie_small.png" alt="veggie" />-->
                                                <%End If %>

                                                 <%
                                                dim index_m ,s_contain
                                           
                                                 if s_ContainAllergen_m & "" <> "" then 
                                                  ''FindAllergen
                                                    dim   arr_s_ContainAllergen_m : arr_s_ContainAllergen_m = split(s_ContainAllergen_m,",")
                                                     index_m = 0
                                                    for index_m = 0 to ubound(arr_s_ContainAllergen_m)
                                                         s_contain = FindAllergen(arr_s_ContainAllergen_m(index_m) )
                                                        if s_contain & "" <> "" then
                                                                %>
                                                                    <img width="17" height="17" data-container="body" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=replace( split(s_contain,"|")(2),"amber","red")   %>" title="Contains <%=split(s_contain,"|")(1) %>"  alt="Contains <%=split(s_contain,"|")(1) %>" />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                             <% if s_MayContainAllergen_m & "" <> "" then 
                                                  ''FindAllergen
                                                    dim arr_s_MayContainAllergen_m : arr_s_MayContainAllergen_m= split(s_MayContainAllergen_m,",")
                                                  index_m = 0
                                                    for index_m = 0 to ubound(arr_s_MayContainAllergen_m)
                                                        s_contain =FindAllergen(arr_s_MayContainAllergen_m(index_m) )
                                                        if s_contain & "" <> "" then%>
                                                                    <img width="17" height="17" data-container="body" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=split(s_contain,"|")(2)  %>" title="May contain <%=split(s_contain,"|")(1) %>" alt="May contain <%=split(s_contain,"|")(1) %>" />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                                  <% if s_SuitableFor_m & "" <> "" then 
                                                  ''FindAllergen
                                                    dim arr_s_SuitableFor_m : arr_s_SuitableFor_m= split(s_SuitableFor_m,",")
                                                    index_m = 0
                                                    for index_m = 0 to ubound(arr_s_SuitableFor_m)
                                                         s_contain =FindAllergen( arr_s_SuitableFor_m(index_m) )
                                                        if s_contain & "" <> "" then%>
                                                                    <img width="17" height="17" data-container="body" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=split(s_contain,"|")(2)  %>"  title="<%=split(s_contain,"|")(1) %>" alt="<%=split(s_contain,"|")(1) %>"  />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                                <%
                                                     dim spicytitle  : spicytitle = "Mildly Spicy" 
                                                
                                                if Spicyness = 2  then
                                                    spicytitle = "Spicy" 
                                                elseif Spicyness = 3  then
                                                    spicytitle = "Very Spicy" 
                                                end if
                                                    If Spicyness> 0 Then %>
                                                   <img src="<%=SITE_URL %>Images/spicy_<%= Spicyness %>.png?v=1.1"  height="17" alt="<%=spicytitle %>" title="<%=spicytitle %>"  data-container="body" data-toggle="tooltip"  />
                                                <%End If %><br />
                                                <% if MenuDescription & "" <> "" then %>
                                                    <i><span class="small"><%= MenuDescription %></span></i>
                                                <% end if %>

                                                </div>
                                             </div>
                                         </div>
                                            <% end if
                                                menuItemNameID = vMenuItemId
                                            %>
                                       
                                        <!--Propertyname and Price-->
                                        <!--<div style="width:30%;float:left;">-->
                                            <!--PropertyName-->
                                            <div class="product-line__content-right " style="width:85%">
                                            <div class="d-flex-center d-flex-end">
                                            <div class="product-line__property-name"  s_ContainAllergen_p="<%=s_ContainAllergen_p & "|" & s_MayContainAllergen_p %>" s_MayContainAllergen_p="<%=s_MayContainAllergen_p %>"  s_SuitableFor_p="<%=s_SuitableFor_p %>"><%=PropertyName %></div> 

                                                 <%
                                                 if s_ContainAllergen_p & "" <> "" then 
                                                  ''FindAllergen
                                                    dim   arr_s_ContainAllergen_p : arr_s_ContainAllergen_p = split(s_ContainAllergen_p,",")
                                                     index_m = 0
                                                    for index_m = 0 to ubound(arr_s_ContainAllergen_p)
                                                         s_contain = FindAllergen(arr_s_ContainAllergen_p(index_m) )
                                                        if s_contain & "" <> "" then
                                                                %>
                                                                    <img width="17" height="17" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=replace(split(s_contain,"|")(2),"amber","red")  %>" title="Contains <%=split(s_contain,"|")(1) %>"  alt="Contains <%=split(s_contain,"|")(1) %>" />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                             <% if s_MayContainAllergen_p & "" <> "" then 
                                                  ''FindAllergen
                                                    dim arr_s_MayContainAllergen_p : arr_s_MayContainAllergen_p= split(s_MayContainAllergen_p,",")
                                                  index_m = 0
                                                    for index_m = 0 to ubound(arr_s_MayContainAllergen_p)
                                                        s_contain =FindAllergen(arr_s_MayContainAllergen_p(index_m) )
                                                        if s_contain & "" <> "" then%>
                                                                    <img width="17" height="17" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=split(s_contain,"|")(2)  %>" title="May contain <%=split(s_contain,"|")(1) %>"  alt="May contain <%=split(s_contain,"|")(1) %>" />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                                  <% if s_SuitableFor_p & "" <> "" then 
                                                  ''FindAllergen
                                                    dim arr_s_SuitableFor_p : arr_s_SuitableFor_p= split(s_SuitableFor_p,",")
                                                    index_m = 0
                                                    for index_m = 0 to ubound(arr_s_SuitableFor_p)
                                                         s_contain =FindAllergen( arr_s_SuitableFor_p(index_m) )
                                                        if s_contain & "" <> "" then%>
                                                                    <img width="17" height="17" data-toggle="tooltip"  src="<%=SITE_URL %>Images/allergen/png/<%=split(s_contain,"|")(2)  %>" title="<%=split(s_contain,"|")(1) %>" alt="<%=split(s_contain,"|")(1) %>"  />
                                                                <%
                                                        end if
                                                    next
                                                %>

                                            <% end if %>

                                             <% donotshowprice="n"
								                dishpropertiestext=""
								                pricefrom=0
								            ' code to check if other dish properties are applicable to this product
								            if dishpropertygroupid & "" <>"" then%>
								            <%
								            'Set objCon_properties = Server.CreateObject("ADODB.Connection")
								            Set objRds_properties = Server.CreateObject("ADODB.Recordset") 
          
								            'objCon_properties.Open sConnString
                                                objRds_properties.Open "SELECT * FROM MenuDishpropertiesGroups where id in (" & dishpropertygroupid & ") order by i_displaysort,id", objCon
				                                While NOT objRds_properties.Eof 
                                                    dishpropertiestext =  dishpropertiestext & "<div class=""dishproperties__title"">" & objRds_properties("dishpropertygroup") & " </div> "
                                                    dishpropertiestext =  dishpropertiestext & " <select name=""" & objRds_properties("id") & """ id=""" & objRds_properties("id") & """ class=""form-control selectpicker"" data-group=""dishproperties" & vMenuItemId & "-" & PropertyId & """"
                                                    if objRds_properties("dishpropertyrequired")<>1  then
                                                        dishpropertiestext = dishpropertiestext & " data-required=""n"">"
                                                        dishpropertiestext = dishpropertiestext & "><option value=""0"">-- select --</option>"
                                                    else
                                                        dishpropertiestext = dishpropertiestext & " data-required=""y"" data-caption=""Please choose " & replace(objRds_properties("dishpropertygroup"),"""","") & """>"
                                                        dishpropertiestext = dishpropertiestext & "><option value=""0"">-- select --</option>"
                                                    end if
						
								                    'Set objCon_propertiesitems = Server.CreateObject("ADODB.Connection")
								                    Set objRds_propertiesitems = Server.CreateObject("ADODB.Recordset") 
								                    'objCon_propertiesitems.Open sConnString
                                                    'SQL = "SELECT * FROM MenuDishproperties where dishpropertygroupid=" & objRds_properties("id")  & "  order by i_displaysort,id "
                                                    SQL = "SELECT dishproperty,dishpropertyprice,id,i_displaysort,s_ContainAllergen,s_MayContainAllergen,s_SuitableFor FROM MenuDishproperties with(nolock)    where dishpropertygroupid=" & objRds_properties("id")  & " order by i_displaysort, id "
                                                    objRds_propertiesitems.Open SQL, objCon
				                                    dim s_ContainAllergen_dp,s_MayContainAllergen_dp,s_SuitableFor_dp  
                                                    dim htmltooltip : htmltooltip = "" 
				                                    While NOT objRds_propertiesitems.Eof 
                                                         dim htmlicon : htmlicon = ""
                                                     '   htmltooltip = ""
                                                    s_ContainAllergen_dp = replace(objRds_propertiesitems("s_ContainAllergen") & ""," ","") 
                                                    s_MayContainAllergen_dp = replace(objRds_propertiesitems("s_MayContainAllergen") & "" ," ","") 
                                                    s_SuitableFor_dp  = replace(objRds_propertiesitems("s_SuitableFor") & ""," ","") 
                                                     htmltooltip = htmltooltip & "<b>" &  objRds_propertiesitems("dishproperty") & "</b>"  & "<br/>"
                                                     dim htmltooltip1 : htmltooltip1 = ""
                                                     if s_ContainAllergen_dp & "" <> "" then                                                   
                                                        dim   arr_s_ContainAllergen_dp : arr_s_ContainAllergen_dp = split(s_ContainAllergen_dp,",")
                                                         index_m = 0
                                                        for index_m = 0 to ubound(arr_s_ContainAllergen_dp)
                                                             s_contain = FindAllergen(arr_s_ContainAllergen_dp(index_m) )
                                                            if s_contain & "" <> "" then
                                                                if instr(htmltooltip1,"Contains") = 0 then
                                                                     htmltooltip1 = htmltooltip1 &  "Contains: " 
                                                                end if
                                                                     htmltooltip1 =  htmltooltip1 & " <img width=""17"" height=""17""  src=""" & SITE_URL & "Images/allergen/png/" & replace( split(s_contain,"|")(2),"amber","red") & """ /> "
                                                                     htmltooltip1 =  htmltooltip1 &  split(s_contain,"|")(1) & ", "
                                                                       htmlicon = htmlicon &  SITE_URL &  "Images/allergen/png/"  & replace(split(s_contain,"|")(2),"amber","red")  & ";"                                                                
                                                            end if
                                                        next
                                                    end if
                                                        if htmltooltip1 & "" <> "" then
                                                            htmltooltip1 =  left(trim(htmltooltip1),len(trim(htmltooltip1))-1)
                                                            htmltooltip = htmltooltip & "<span class=""tip-allergen"">" &  htmltooltip1 & "</span><br/>"
                                                         end if
                                                    htmltooltip1  =""
                                                    if s_MayContainAllergen_dp & "" <> "" then                                                   
                                                        dim   arr_s_MayContainAllergen_dp : arr_s_MayContainAllergen_dp = split(s_MayContainAllergen_dp,",")
                                                         index_m = 0
                                                        for index_m = 0 to ubound(arr_s_MayContainAllergen_dp)
                                                             s_contain = FindAllergen(arr_s_MayContainAllergen_dp(index_m) )
                                                            if s_contain & "" <> "" then
                                                                       if instr(htmltooltip1,"May Contain") = 0 then
                                                                             htmltooltip1 = htmltooltip1 &  "May Contain: " 
                                                                        end if
                                                                        htmltooltip1 =  htmltooltip1 & " <img width=""17"" height=""17""  src=""" & SITE_URL & "Images/allergen/png/" & split(s_contain,"|")(2) & """ /> "
                                                                        htmltooltip1 =  htmltooltip1 & split(s_contain,"|")(1) & ", "
                                                                       htmlicon = htmlicon &  SITE_URL &  "Images/allergen/png/"  & split(s_contain,"|")(2)  & ";"   
                                                            end if
                                                        next
                                                    end if
                                                     if htmltooltip1 & "" <> "" then
                                                            htmltooltip1 =  left(trim(htmltooltip1),len(trim(htmltooltip1))-1)
                                                            htmltooltip = htmltooltip & "<span class=""tip-allergen"">" &  htmltooltip1 & "</span><br/>"
                                                         end if
                                                    htmltooltip1  =""
                                                    if s_SuitableFor_dp & "" <> "" then                                                   
                                                        dim   arr_s_SuitableFor_dp : arr_s_SuitableFor_dp = split(s_SuitableFor_dp,",")
                                                         index_m = 0
                                                        for index_m = 0 to ubound(arr_s_SuitableFor_dp)
                                                             s_contain = FindAllergen(arr_s_SuitableFor_dp(index_m) )
                                                            if s_contain & "" <> "" then
                                                                       if instr(htmltooltip1,"Suitable For") = 0 then
                                                                             htmltooltip1 = htmltooltip1 &  "Suitable For: " 
                                                                        end if
                                                                        htmltooltip1 =  htmltooltip1 & " <img width=""17"" height=""17""  src=""" & SITE_URL & "Images/allergen/png/" & split(s_contain,"|")(2) & """ /> "
                                                                        htmltooltip1 =  htmltooltip1 & split(s_contain,"|")(1) & ", "
                                                                      htmlicon = htmlicon &  SITE_URL &  "Images/allergen/png/"  & split(s_contain,"|")(2)  & ";"   
                                                            end if
                                                        next
                                                    end if
                                                     if htmltooltip1 & "" <> "" then
                                                            htmltooltip1 =  left(trim(htmltooltip1),len(trim(htmltooltip1))-1)
                                                            htmltooltip = htmltooltip & "<span class=""tip-allergen"">" &  htmltooltip1 & "</span><br/>"
                                                         end if
                                                  '  htmltooltip =  htmltooltip & "<br/>"

				                                        add=""
				                                        if objRds_properties("dishpropertypricetype")="add" then
				                                            add=" - add "
				                                        else
				                                            donotshowprice="y"
				                                            if pricefrom & "" = "0" or pricefrom & "" = ""  then
					                                            pricefrom=objRds_propertiesitems("dishpropertyprice")
				                                            end if
				                                        end if
				                                       ' dishpropertiestext = dishpropertiestext & "<option value=""" & objRds_propertiesitems("id") & """>" & objRds_propertiesitems("dishproperty") & add & " " &  CURRENCYSYMBOL & FormatNumber(objRds_propertiesitems("dishpropertyprice"),2) & "</option>"
                                                        dishpropertiestext = dishpropertiestext & "<option data-thumbnail=""" & htmlicon & """ s_SuitableFor_dp="""& s_SuitableFor_dp &"""  s_MayContainAllergen_dp="""& s_MayContainAllergen_dp  &""" s_ContainAllergen_dp="""& s_ContainAllergen_dp & "|" & s_MayContainAllergen_dp &""" value=""" & objRds_propertiesitems("id") & """>" & objRds_propertiesitems("dishproperty") & add & " " &  CURRENCYSYMBOL & FormatNumber(objRds_propertiesitems("dishpropertyprice"),2) & "</option>"
				    		                            objRds_propertiesitems.MoveNext
							                        wend 
                                                        objRds_propertiesitems.close()
                                                        set objRds_propertiesitems = nothing        
                                                dishpropertiestext = dishpropertiestext & "</select>"
                                                 '' Add Add tooltip here
                                                    if instr(htmltooltip,"Contains:") =  0 and instr(htmltooltip,"May Contain:") =  0 and  instr(htmltooltip,"Suitable For:") =  0 then
                                                            htmltooltip = ""
                                                    else
                                                        dishpropertiestext =  dishpropertiestext & "   <span class=""glyphicon glyphicon-exclamation-sign append text-info tip"" data-tip=""tip-"&objRds_properties("id")&""" ></span> <br>"    
                                                        dishpropertiestext = dishpropertiestext & "<div id=""tip-" & objRds_properties("id") & """ class=""tip-content hidden""> "
                                                        dishpropertiestext=  dishpropertiestext &    htmltooltip
                                                        dishpropertiestext = dishpropertiestext & "</div>"
                                                    end if                                                  
                                            '' end 
						                        objRds_properties.MoveNext
                                                wend 
                                                objRds_properties.close()
                                                set objRds_properties = nothing
                                            End if

                                  
								    ' code to check if toppings are applicable to this product
								    dishtoppingstext=""
								    if (miallowtoppings & "" <> "0" and trim( miallowtoppings & "") <> "") or ( mipallowtoppings & "" <> "0" and trim( mipallowtoppings & "") <> "")  then
                                             dim listtoppinggroupid : listtoppinggroupid = ""
                                                if trim( miallowtoppings & "") <> "0" and trim( miallowtoppings & "") <> ""   then
                                                    listtoppinggroupid = miallowtoppings
                                                end if

                                                if trim( mipallowtoppings & "") <> "0" and  trim( mipallowtoppings & "") <> ""  then
                                                    if listtoppinggroupid = "" then
                                                        listtoppinggroupid =mipallowtoppings
                                                    else
                                                        listtoppinggroupid =listtoppinggroupid &  "," & mipallowtoppings
                                                    end if
                                                end if
                                             Set objRds_toppings_Group = Server.CreateObject("ADODB.Recordset")  
                                                SQL = "select ID,toppingsgroup,i_displaysort,isnull(limittopping,0) as limittopping from Menutoppingsgroups where IdBusinessDetail = " &   vRestaurantId & " and ID in (" &listtoppinggroupid& ")  order by i_displaysort,id "                                                     
                                                objRds_toppings_Group.Open SQL, objCon
                                            while not objRds_toppings_Group.EOF 
                                                Set objRds_toppings = Server.CreateObject("ADODB.Recordset")           
                                                    SQL = "SELECT id,topping,toppingprice,i_displaysort,s_ContainAllergen,s_MayContainAllergen,s_SuitableFor FROM MenuToppings with(nolock)    where  IdBusinessDetail=" & vRestaurantId                                               
                                                    SQL =SQL & " and toppinggroupid=" & objRds_toppings_Group("ID")    & " order by i_displaysort,id "                                            
                                                    objRds_toppings.Open SQL, objCon
                                                dishtoppingstext =  "<div class=""dishproperties__title"">" & objRds_toppings_Group("toppingsgroup") & " </div> "
                                                dim s_ContainAllergen_t,s_MayContainAllergen_t,s_SuitableFor_t 
                                                While NOT objRds_toppings.Eof 
                                                    s_ContainAllergen_t = Replace(objRds_toppings("s_ContainAllergen")& ""," ","") 
                                                    s_MayContainAllergen_t  =Replace( objRds_toppings("s_MayContainAllergen")&""," ","")
                                                    s_SuitableFor_t  = Replace( objRds_toppings("s_SuitableFor")&""," ","")
                                                    dim shtmlicons : shtmlicons = ""

                                                     if s_ContainAllergen_t & "" <> "" then 
                                                          ''FindAllergen
                                                            dim   arr_s_ContainAllergen_t : arr_s_ContainAllergen_t = split(s_ContainAllergen_t,",")
                                                             index_m = 0
                                                            for index_m = 0 to ubound(arr_s_ContainAllergen_t)
                                                                 s_contain = FindAllergen(arr_s_ContainAllergen_t(index_m) )
                                                                if s_contain & "" <> "" then
                                                                        shtmlicons = shtmlicons &  "<img width=""17"" data-toggle=""tooltip""  height=""17"" src=""" & SITE_URL & "Images/allergen/png/" & replace(split(s_contain,"|")(2),"amber","red") & """    title=""Contains "&split(s_contain,"|")(1)&"""  alt=""Contains "&split(s_contain,"|")(1)&""" />"
                                                                end if
                                                            next
                                                    end if

                                                    if s_MayContainAllergen_t & "" <> "" then 
                                                          ''FindAllergen
                                                            dim   arr_s_MayContainAllergen_t : arr_s_MayContainAllergen_t = split(s_MayContainAllergen_t,",")
                                                             index_m = 0
                                                            for index_m = 0 to ubound(arr_s_MayContainAllergen_t)
                                                                 s_contain = FindAllergen(arr_s_MayContainAllergen_t(index_m) )
                                                                if s_contain & "" <> "" then
                                                                        shtmlicons = shtmlicons &  "<img width=""17"" height=""17"" data-toggle=""tooltip""  src=""" & SITE_URL & "Images/allergen/png/" & split(s_contain,"|")(2) & """    title=""May contain "&split(s_contain,"|")(1)&"""  alt=""May contain "&split(s_contain,"|")(1)&""" />"
                                                                end if
                                                            next
                                                    end if

                                                    if s_SuitableFor_t & "" <> "" then 
                                                          ''FindAllergen
                                                            dim   arr_s_SuitableFor_t : arr_s_SuitableFor_t = split(s_SuitableFor_t,",")
                                                             index_m = 0
                                                            for index_m = 0 to ubound(arr_s_SuitableFor_t)
                                                                 s_contain = FindAllergen(arr_s_SuitableFor_t(index_m) )
                                                                if s_contain & "" <> "" then
                                                                        shtmlicons = shtmlicons &  "<img width=""17"" height=""17"" data-toggle=""tooltip""  src=""" & SITE_URL & "Images/allergen/png/" & split(s_contain,"|")(2) & """    title="""&split(s_contain,"|")(1)&"""  alt="""&split(s_contain,"|")(1)&""" />"
                                                                end if
                                                            next
                                                    end if

                                                    dishtoppingstext = dishtoppingstext &  "<span s_ContainAllergen_t="""  & s_ContainAllergen_t & "|" & s_MayContainAllergen_t & """  s_MayContainAllergen_t="""  & s_MayContainAllergen_t & """  s_SuitableFor_t="""  & s_SuitableFor_t & """  class=""topping d-flex""> " 
                                                    dishtoppingstext = dishtoppingstext &  " <span class=""mr-5""> " 
                                                    dishtoppingstext = dishtoppingstext &  "    <input type=""checkbox"" toppinggroup=""topping_" & objRds_toppings_Group("ID") &""" name=""" & objRds_toppings("topping") & """ value=""" & objRds_toppings("id") & """ data-group=""toppings" & vMenuItemId & "-" & PropertyId & """> " & objRds_toppings("topping") & shtmlicons 
                                                    dishtoppingstext = dishtoppingstext &  " </span> " 
                                                    dishtoppingstext = dishtoppingstext &  " <span  class=""ml-auto""> " 
                                                    dishtoppingstext = dishtoppingstext &  CURRENCYSYMBOL & FormatNumber(objRds_toppings("toppingprice"),2)  
                                                    dishtoppingstext = dishtoppingstext &  " </span> " 
                                                    dishtoppingstext = dishtoppingstext &  "</span>"
								                    objRds_toppings.MoveNext
                                                wend 
                                                    objRds_toppings.close()
                                                set objRds_toppings = nothing
                                                  if cint( objRds_toppings_Group("limittopping")) > 0 then
                                                        dishtoppingstext  = dishtoppingstext & "<script>checkboxlimit('topping_" & objRds_toppings_Group("ID") & "'," &  objRds_toppings_Group("limittopping")  &  ");</script>"
                                                    end if
                                                objRds_toppings_Group.movenext()
                                            wend
                                                objRds_toppings_Group.close()
                                                set objRds_toppings_Group = nothing
                                    end if
								    %> 
                                
                                    <% 
                                    
                                        noprice=0
                                        If Not IsNull(MenuPrice) and donotshowprice="n" Then %>
                                        <div class="product-line__price"><b><%=CURRENCYSYMBOL%><%= FormatNumber(MenuPrice, 2) %></b></div> 
                                
                                    <%  noprice=1
                                        End If %>
							
                                    <%if pricefrom & "" <> "0" then%>
                               
                                     <div class="product-line__price"><b>from <%=CURRENCYSYMBOL%><%= FormatNumber(pricefrom, 2) %></b></div>    
                                    <%noprice=1
                                    end if%>


                                  
                                            <!--Add to cart-->
                                            <div class="product-line__action-btn">	
                                                <div align="right">
                                                <% if dishpropertiestext & "" <> ""  or dishtoppingstext & "" <> "" then  %>
                                                    <button class="btn btn-success" onclick="Showdishproperties('dishproperties<%=vMenuItemId %>-<%=objRds_MenuItem("PropertyId") %>');">
                                                        <span style="top:2px;" class="glyphicon glyphicon-plus-sign"></span>
                                                    </button>
                                                <% else %>
                                                    <button class="btn btn-success btnadd" onclick="Add(<%=vMenuItemId %>,<%=PropertyId %>,this);">
                                                      <span class="glyphicon glyphicon-plus"></span>
                                                      <span class="fa fa-refresh fa-spin" aria-hidden="true" style=" width: 1em;display:none;"></span>
                                                    </button>    
                                                <% end if %>
                                                </div>					
                                            </div>

                                            </div>
                                        </div>
                                            <!--End Add to cart-->

                                       
                                        </div>
                                    <!--</div>-->
                                     <%if dishpropertiestext<>"" or dishtoppingstext<>"" then%>
					                <div class="dishproperties" id="dishproperties<%=vMenuItemId %>-<%=objRds_MenuItem("PropertyId") %>">
					                    <div class="row dishproperties__inner">

					                    <div  class="col-md-5 col-sm-5 desc pr-0 desc">
					                        <%if dishtoppingstext<>"" then%>
                                                    <div class="dishproperties__heading">    
					                                <b>Toppings</b>
                                                    </div>
					                                <%=dishtoppingstext%>
					                        <%end if%>
					                    </div>

                                        <div  class="col-md-6 col-sm-6 desc">
					                    <%if dishpropertiestext<>"" then%>
                                            <div class="dishproperties__heading" name="dishproperties__heading">
					                            <b>Dish Options</b>
                                            </div>
					                        <%=dishpropertiestext%>
                                            <script type="text/javascript">
                                                $(function(){
                                                    $('.tip').each(function () {
                                                        $(this).tooltip(
                                                        {
                                                            html: true,
                                                            title: $('#' + $(this).data('tip')).html(),
                                                            container: 'body'
                                                        });
                                                    });
                                                    
                                                });
                                            </script>
					                    <%end if%>
					                    </div>
                                        <div class="col-md-1 col-sm-1 dishproperties__btn is-vertical-center">
                                               <div align="left">
						                       <button class="btn btn-success btnadd" onclick="Add(<%=vMenuItemId %>,<%=PropertyId%>,this);">
                                                    <span class="glyphicon glyphicon-plus"></span>
                                                   <span class="fa fa-refresh fa-spin" aria-hidden="true" style=" width: 1em;display:none;"></span>
						                       </button></div>
                                        </div>
                                        </div>
					                </div>
					
					            <%end if%>

                               
                                 <%
                                       objRds_MenuItem.MoveNext 
                                wend
                               %>
                                </div>
                                <%
                             'end 
                        objRdsMainCategory.MoveNext
                    wend
				        objRds_MenuItem.Close()
                    set objRds_MenuItem = nothing
                        objRdsMainCategory.close()
                    set objRdsMainCategory = nothing
                                     %>

		    </div>
		    <div class="col-md-3half column" id="pricecolumn">
		
		
		    <div class="panel panel-default" id="noorders" style="display:none;">
      <div class="panel-heading" >
        <h3 class="panel-title">Ordering available during opening hours only</h3>
      </div></div>
		
	
			
  




	    <div id="rightaffix" <%if STICK_MENU="Yes"  then%>data-spy="affix" data-offset-top="300" data-offset-bottom="200"<%end if%>>
    <div class="panel panel-primary"  id="basket"  >
      <div class="panel-heading">
        <h3 class="panel-title"><span class="glyphicon glyphicon glyphicon-shopping-cart"></span> Your Order</h3>
      </div>
      <div class="panel-body" style="padding:15px 8px 15px 8px;" id="footerbasket">
   
                         

                            <form id="CheckOutForm" action="<%=CheckoutURL %>" method="post">                
                            <input type="hidden" name="deliveryDistance" id="distance" value="" />
                            <input type="hidden" name="deliveryType" value="" />
						    <input type="hidden" name="deliverydelay" id="deliverydelay" value="<%=sAverageDeliveryTime%>" />
						    <input type="hidden" name="collectiondelay" id="collectiondelay" value="<%=sAverageCollectionTime%>" />
                            <input type="hidden" name="deliveryPC" value="<%=request.querystring("postcode")%>" />
                            <input type="hidden" name="deliveryTime" value="" />
						    <input type="hidden" name="asaporder" value="" />
						    <input type="hidden" name="special" value="" />
                            <input type="hidden" name="deliveryLat" value="" />
                            <input type="hidden" name="deliveryLng" value="" />
                            <input type="hidden" name="deliveryAddress" value="" />
                            <input type="hidden" name="deliveryPostCode" value="" />
                            <input type="hidden" name="TableNumberCheckout" value="" />
                       </form>
                            <div id="shoppingcart"></div>                        
          

                                   
                    
      </div>
    </div>






    <div class="panel panel-danger" >
      <div class="panel-heading"  >
              <h3 class="panel-title">Opening Hours</h3>
      </div>
            <div class="panel-body">           
                            <table border="0" width="100%" id="openninghours">
                                <% 
                       
                            objRds.Open "SELECT  oi.minacceptorderbeforeclose,  convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To ,DayOfWeek,delivery,collection " & _
                            " FROM openingtimes oi " & _
                            " where oi.IdBusinessDetail = " & vRestaurantId & _
                            " order by DayOfWeek, Hour_From", objCon
                            Dim jsDate, tempminacceptorderbeforeclose
                            jsDate = ""
						    jscnt=0
						    currentdayofweek=""
                        
                        
                            Do While NOT objRds.Eof 
                 jscnt=jscnt+1
                                if ISNULL(objRds("minacceptorderbeforeclose")) OR objRds("minacceptorderbeforeclose") & "" = "" Then
                                   tempminacceptorderbeforeclose = -1
                             Else
                                    tempminacceptorderbeforeclose = objRds("minacceptorderbeforeclose")
                            End If
                                  Dim o1_Hour_From : o1_Hour_From =  FormatTimeC(objRds("Hour_From"),5) 
                                 Dim o1_Hour_To : o1_Hour_To =  FormatTimeC(objRds("Hour_To"),5) 
                                if jsDate <> "" Then jsDate = jsDate & ","
                                    jsDate = jsDate & jscnt & ": { min:Date.parse('01/01/2011 " & o1_Hour_From & "'),  max: Date.parse('01/01/2011 " & o1_Hour_To & "'), d:'" & objRds("DayOfWeek") & "', delivery:'" & objRds("delivery") & "', collection:'" & objRds("collection") & "',minacceptorderbeforeclose:" & tempminacceptorderbeforeclose &"}"
                                
                                    dim isavailable : isavailable ="y"
                                    if objRds("collection")="n" and objRds("delivery")="n" then
                                                isavailable = "n"
                                    end if

                                %>
                                <tr name="nameopentime" <% if objRds("DayOfWeek") = Weekday(DateAdd("h",houroffset,now), vbMonday)  then %> style="font-weight:bold;" <% end if %>  nameopentime="<%=objRds("DayOfWeek") %>" available="<%=isavailable %>">
                                    <td style="width: 30px">
								    <%if currentdayofweek<>objRds("DayOfWeek") then%>
                                        <%= WeekdayName(objRds("DayOfWeek"), false, vbMonday) %>
									    <%end if%>
                                    </td>
                                    <td>
                                      <div align="right"> <%if objRds("collection")="n" then%><img src="<%=SITE_URL %>Images/no-collection.gif" width="18" data-toggle="tooltip" data-placement="left" title="Collection is not available during this time slot"></i> <%end if%> <%if objRds("delivery")="n" then%><img src="<%=SITE_URL %>Images/no-delivery.gif" width="18" data-toggle="tooltip" data-placement="left" title="Delivery is not available during this time slot"></i> <%end if%> <%= o1_Hour_From%>
                                        - <%= o1_Hour_To  %></div>  <%' objRds("minacceptorderbeforeclose") & "|" & ISNULL(objRds("minacceptorderbeforeclose")) & "|" & (objRds("minacceptorderbeforeclose") & "" = "") & "|" & tempminacceptorderbeforeclose %>
                                    </td>
                                   <script type="text/javascript">
                                       $(function () {
                                           $("[data-toggle=tooltip]").tooltip();
                                       });
    </script>
                               
                                </tr>
                                <%currentdayofweek=objRds("DayOfWeek")
                                objRds.MoveNext    
                            Loop
                    
                            objRds.Close
                            set objRds =  nothing
                            objCon.Close
                            set objCon = nothing
						
                                %>
                            </table>
                        </div>
        </div>
	    <%=menupagetext%>
	
    </div>







		
	    </div>
	    </div>
	</div>
</div>
<script>
             function CategorySelection(ID)
            {
        
                $("#txtSearch").val("");
                $(".product-line-heading").show();
                $("[data-type=group-cate]").each(function(){
                    var categroup  = $(this);
                    categroup.find(".product-line").each(function(){
                        $(this).show();
                    });
                }); 

                $("[data-type='group-cate']").each(function(){
                    $(this).hide();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                });
                $("#" + ID).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
              
                $("#" + ID).slideDown("slow");

            }
           function selectcategorymobile(groupid,obj)
            {
                var idAnchor  =  $(obj).attr("data");
              
                $('#' + groupid ).hide();
                $('#' + groupid).slideDown('show');
            }
        </script>
<script>
        
    function IsMatchSearch(terms, text)
    {
        var arrTerms  = terms.split(" ");
        var result = false;
        for(var i= 0 ; i< arrTerms.length;i++)
        {
             if(arrTerms[i].toLowerCase()!="")
                {
                    result = text.toLowerCase().indexOf(arrTerms[i].toLowerCase()) >-1? true:false
                    if(result == false)
                        break;      
                }
              
        }
        return result;
    }
    
    var allergenvalues="",suitableforvalue="";
    var containmaycontain =  false;
    function SearchAllergen(obj,mode,id)
    {
        if($(obj).find(".icon-check").length > 0 )
            $(obj).find(".icon-check").remove();
        else
        {
            if(mode=="Allergen")
                $('<span class="glyphicon glyphicon-remove icon-check" attrvalue="' + id.replace("filter_","")+ '"></span>').insertBefore("#" + id);
            else
                $('<span class="glyphicon glyphicon-ok icon-check" attrvalue="' + id.replace("filter_","")+ '"></span>').insertBefore("#" + id);    
        }

        
    }
    function ClearFilter()
    {
        if($("#FilterModal").find(".icon-check").length > 0 )
            $("#FilterModal").find(".icon-check").remove();

   
        //Filter();
     
    }
    function Filter()
    {
        if($("#filter-may").is(":checked"))
            containmaycontain  = true;
        else
            containmaycontain  = false;
        allergenvalues="";
        suitableforvalue="";
        $("#allergenlist").find("li").each(function(){
            if( $(this).find(".icon-check").length > 0)
                allergenvalues += $(this).find(".icon-check").attr("attrvalue") +",";
        });
        $("#suitableforlist").find("li").each(function(){
            if($(this).find(".icon-check").length >0)
                suitableforvalue += $(this).find(".icon-check").attr("attrvalue") +",";
        });


     
        $("[data-type=group-cate]").each(function(){
            var categroup  = $(this);
            categroup.find(".product-line").each(function(){
                    
                if(screenmode=="mobile")
                {
                    categroup.hide();
                    $(this).show();
                    $(categroup).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                }else
                {
                    $(this).show();
                }
                    
                    
            });
        });
        $("#FilterModal").modal("hide");

        $(".product-line__property-name").show();
        $(".topping").show();
        $("[name='ContainAllergen_dp']").show();                
        $(".product-line-heading").show();
        if(allergenvalues !="" || suitableforvalue !="" || screenmode!="mobile")
        {
            $("[data-type='group-cate']").each(function(){
                $(this).show();
                $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
            });
        }else
        {
            if(screenmode=="mobile")
            {
                $("[data-type='group-cate']").each(function(){
                    $(this).hide();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                });
            }
        }

        if (allergenvalues != "" || suitableforvalue != "") $('#icoAllergenFilter').addClass('glyphicon-filtered');
        else $('#icoAllergenFilter').removeClass('glyphicon-filtered');

        filterSearchAllergen(allergenvalues);
        filterSearchSuitable(suitableforvalue);
        
    }
    function isMatchFilterSeachAllergen(valueseach, valueproperty)
    {
        var result =  false;
        
        if(valueseach == "" || typeof valueproperty == "undefined" )
            result = false;
        else if(valueseach != "")
        {
            if(typeof valueproperty != "undefined")
            {
                var scontain = valueproperty.split("|")[0];
                var maycontain = valueproperty.split("|")[1];
                if(containmaycontain == false)
                    valueproperty = scontain;
                else
                {
                    valueproperty = scontain;
                    if(maycontain.trim() !="")
                        valueproperty +="," + maycontain;
                }
                valueproperty.split(",").forEach(function(value,index){
                    if(value !="")
                    {
                        valueseach.split(",").forEach(function(value2,index2){
                       
                            if(value2!="" && value2.trim() == value.trim())
                                result =  true;
                        });
                    }
                });
            }
        }
        return result;
    }
    function isMatchFilterSeachSuitable(valueseach, valueproperty)
    {
        var result =  false;
        
        if(valueseach == "" || typeof valueproperty == "undefined" )
            result = true;
        else if(valueseach != "")
        {
            if(typeof valueproperty != "undefined")
            {
                valueproperty.split(",").forEach(function(value,index){
                    if(value !="")
                    {
                        valueseach.split(",").forEach(function(value2,index2){
                       
                            if(value2!="" && value2.trim() == value.trim())
                                result =  true;
                        });
                    }
                });
            }
        }
        return result;
    }
    function getouterHTML($obj){
        if(typeof $obj !="undefined" && $($obj).length > 0)
            return $obj[0].outerHTML;
    }
    function CheckPropertyMatch(searchtext,obj,attrid,mode)
    {
        var result =  false;
        if(searchtext=="")        
            result =  true;       
        else{
            if(mode=="allergen")
            {   
                result =  true;
                obj.each(function(){
                    var $this  = $(this);
                    if(typeof  $this.attr(attrid) != "undefined" && $this.attr(attrid) !="-1" && $this.attr(attrid) !="|"  )
                    {
                        var scontain = $this.attr(attrid).split("|")[0];
                        var maycontain = $this.attr(attrid).split("|")[1];
                        var valueproperty ="";
                        if(containmaycontain == false)
                            valueproperty = scontain;
                        else
                        {
                            valueproperty = scontain;
                            if(maycontain.trim() !="")
                                valueproperty +="," + maycontain;
                        }

                        valueproperty.split(",").forEach(function(value,index){
                            if(value !="")
                            {
                                searchtext.split(",").forEach(function(value2,index2){                               
                                   if(value2!="" && value2.trim() == value.trim() )                            
                                        result =  false;
                                });
                            }
                            
                        });
                    }

                });
            }else{
                attrid = attrid.replace("s_containallergen_","s_SuitableFor_");
                obj.each(function(){
                    var $this  = $(this);
                    if(typeof  $this.attr(attrid) != "undefined" && $this.attr(attrid)!="-1")
                    {
                        $this.attr(attrid).split(",").forEach(function(value,index){
                            if(value !="")
                            {
                                searchtext.split(",").forEach(function(value2,index2){                               
                                    if(value2!="" && value2.trim() == value.trim())                                
                                        result =  true;                               
                                });
                            }
                        });
                    }
                });
            }
            
        }
        return result;
    }
       
    function filterToppingProperty(searchtext,obj,attrid,mode)
    {
        var result =  false;
        if(searchtext==""){
           // $(idsearch).show();
            result =  true;
        }
        else{
            if(mode=="allergen")
            {                
                obj.each(function(){
                    var $this  = $(this);
                    if(typeof  $this.attr(attrid) != "undefined" && $this.attr(attrid) !="-1" )
                    {
                        var scontain = $this.attr(attrid).split("|")[0];
                        var maycontain = $this.attr(attrid).split("|")[1];
                        var valueproperty ="";
                        if(containmaycontain == false)
                            valueproperty = scontain;
                        else
                        {
                            valueproperty = scontain;
                            if(maycontain.trim() !="")
                                valueproperty +="," + maycontain;
                        }
                        if(valueproperty=="")
                        {
                            result =  true;
                        }
                        else
                        {
                            valueproperty.split(",").forEach(function(value,index){
                                if(value !="")
                                {  
                               
                                    searchtext.split(",").forEach(function(value2,index2){                               
                                        if(value2!="" && value2.trim() == value.trim())
                                        {                                        
                                            //if($this.is(":visible") || typeof $this.attr("style")=="undefined")
                                            $this.hide();                                        
                                        }else if(value2!=""  )                               
                                            result =  true;
                                    });
                                }else
                                {
                                    //if($this.is(":visible"))
                                    //    $this.hide(); 
                                    result =  true;
                                }
                            });
                        }
                        
                    }
                });
            }else{
                attrid = attrid.replace("s_containallergen_","s_SuitableFor_");
                obj.each(function(){
                    var $this  = $(this);
                    if(typeof  $this.attr(attrid) != "undefined" && $this.attr(attrid)!="-1")
                    {
                        $this.attr(attrid).split(",").forEach(function(value,index){
                            if(value !="")
                            {
                                searchtext.split(",").forEach(function(value2,index2){                               
                                    if(value2!="" && value2.trim() != value.trim() &&  $this.is(":visible"))
                                    {
                                       // if($this.is(":visible"))
                                            $this.hide();
                                      
                                    }else if(value2!="" && value2.trim() == value.trim())                                
                                        result =  true;
                                
                                });
                            }else
                            {
                                if($this.is(":visible"))
                                    $this.hide();
                            }
                        });
                    }
                });
            }
            
        }
        return result;
        
    }
    function filterSearchAllergen(allergenlist)
    {
        var searchtext =  allergenlist;
        var itemsearch  = "s_containallergen_m";
        var propertysearch  = "s_containallergen_p";
        var dishpropertysearch  = "s_containallergen_dp";
        var toppingsearch  = "s_containallergen_t";
        var mode = "allergen";
        if(searchtext!=""){
            $(".dishproperties").hide();
            $(".product-line-heading").hide();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){                    
                    var nameid = $(this).attr("name");
                    //if(nameid + "" == "439")
                    //    debugger;
                    var istopping =  false;
                    var isdishname = true;                       
                    var isdishproperty = false;
                    if($(this).find(".product-line__content-left").length > 0)
                    {
                        //check property
                        if($(this).find(".product-line__description").length > 0) 
                        {                            
                                if(isMatchFilterSeachAllergen(searchtext,$(this).find(".product-line__description").attr("" +  itemsearch)))                        
                                    isdishname = false;         
                        }                       
                        //dishproperties468-
                        if($("#dishproperties"  + nameid + "-").length > 0 && isdishname == true)
                        {
                                isdishname = filterToppingProperty(searchtext,$("#dishproperties"  + nameid + "-").find(".topping"),"s_containallergen_t",mode);
                            if(isdishname == false)
                                isdishname =  filterToppingProperty(searchtext,$("#dishproperties"  + nameid + "-").find("[name='ContainAllergen_dp']"),"s_containallergen_dp",mode);                           
                        }
                        //if(nameid + "" == "439")
                        //    console.log("isdishname1 " + isdishname);
                    }else{
                        var _flag = false;
                        var isShowParent  = true;
                        categroup.find('[name="' + nameid + '"]').each(function(){
                            var propertyObj = $(this);
                            var isshowproperty = false;
                            if(typeof propertyObj.attr("Parent") == "undefined" )
                            {   
                                if(isShowParent == true)
                                {
                                    isshowproperty = CheckPropertyMatch(searchtext,propertyObj.find(".product-line__property-name:first"),"s_containallergen_p",mode);   
                                    if(isshowproperty==true)
                                    {
                                        var nextobj =  propertyObj.next();                                 
                                        if(nextobj.attr("class")=="dishproperties")
                                        {
                                            // check all property meet search 
                                            var isshowtopping = filterToppingProperty(searchtext,nextobj.find(".topping"),"s_containallergen_t",mode) ;
                                            var isshowproperty  = filterToppingProperty(searchtext,nextobj.find("[name='ContainAllergen_dp']"),"s_containallergen_dp",mode)
                                            if(isshowtopping ==false && isshowproperty == false )
                                                isshowproperty =  false;                                            
                                        }
                                    }
                                    if(isshowproperty==false && propertyObj.is(":visible"))
                                        propertyObj.hide();
                                    if(isshowproperty == true){
                                        isdishname = true;
                                        _flag  = true;
                                    }   
                                }
                                                                 
                            } else
                            {
                                if(propertyObj.find(".product-line__description").length > 0) 
                                {                    
                                if(isMatchFilterSeachAllergen(searchtext,propertyObj.find(".product-line__description").attr("" +  itemsearch)))
                                    {
                                        _flag = false;         
                                        isShowParent =  false;
                                    }
                                        
                                }      
                            }
                        });
                        isdishname = _flag;
                    }
                   
                    if( isdishname == false)
                    {
                        if( $(this).is(":visible"))
                            $(this).hide();
                    }
                    if($(this).is(":visible"))
                    {
                        categroup.show();
                        $("#group-" + categroup.attr("id")).show();
                        $("#group-" + categroup.attr("id")).find("img").removeClass("arrow-icon-down").addClass("arrow-icon-up");
                    }
                });
            });
        }
        
    }

    function filterSearchSuitable(allergenlist,mode)
    {
        var searchtext =  allergenlist;
        var itemsearch  = "s_suitablefor_m";
        var propertysearch  = "s_suitablefor_p";
        var dishpropertysearch  = "s_suitablefor_dp";
        var toppingsearch  = "s_suitablefor_t";
        var mode = "SuitableFor";
        if(searchtext!=""){
            $(".dishproperties").hide();
            $(".product-line-heading").hide();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){                    
                    var nameid = $(this).attr("name");
                    var istopping =  false;
                    var isdishname = false;    
                    var isdishproperty = false;
                    if($(this).find(".product-line__content-left").length > 0)
                    {
                        //check property
                        if($(this).find(".product-line__description").length > 0) 
                        {       
                                if(isMatchFilterSeachSuitable(searchtext,$(this).find(".product-line__description").attr("" +  itemsearch)))                        
                                    isdishname = true;                           
                        }                       
                        //dishproperties468-
                        if($("#dishproperties"  + nameid + "-").length > 0 && isdishname == false)
                        {
                            isdishname = filterToppingProperty(searchtext,$("#dishproperties"  + nameid + "-").find(".topping"),"s_containallergen_t",mode);
                            if(isdishname == false)
                                isdishname =  filterToppingProperty(searchtext,$("#dishproperties"  + nameid + "-").find("[name='ContainAllergen_dp']"),"s_containallergen_dp",mode);                           
                        }
                    }else{
                        categroup.find('[name="' + nameid + '"]').each(function(){
                            var propertyObj = $(this);
                            var isshowproperty = false;
                            if(typeof propertyObj.attr("Parent") == "undefined")
                            {   
                                
                                    isshowproperty = CheckPropertyMatch(searchtext,propertyObj,"s_containallergen_p",mode);
                                    if(isshowproperty==false)
                                    {
                                        var nextobj =  propertyObj.next();                                 
                                        if(nextobj.attr("class")=="dishproperties")
                                        {
                                            // check all property meet search 
                                            isshowproperty =  filterToppingProperty(searchtext,nextobj.find(".topping"),"s_containallergen_t",mode);
                                            if(isshowproperty==false)
                                                isshowproperty =  filterToppingProperty(searchtext,nextobj.find("[name='ContainAllergen_dp']"),"s_containallergen_dp",mode);
                                        }
                                    }
                                if(isshowproperty==false && propertyObj.is(":visible"))
                                    propertyObj.hide();
                                if(isshowproperty == true)
                                   isdishname = true;
                            }  
                        });
                    }
                        if( isdishname == false)
                        {
                            if( $(this).is(":visible"))
                                $(this).hide();
                        }
                       
                        if($(this).is(":visible"))
                        {
                            categroup.show();
                            $("#group-" + categroup.attr("id")).show();
                            $("#group-" + categroup.attr("id")).find("img").removeClass("arrow-icon-down").addClass("arrow-icon-up");
                        }
                    
                });
            });
        }
       
    }
    function IsMatchSearch(terms, text)
    {
        var arrTerms  = terms.split(" ");
        var result = false;
        for(var i= 0 ; i< arrTerms.length;i++)
        {
            if(arrTerms[i].toLowerCase()!="")
            {
                result = text.toLowerCase().indexOf(arrTerms[i].toLowerCase()) >-1? true:false
                if(result == false)
                    break;      
            }              
        }
        return result;
    }
    function SearchTerms(objID)
    {
        var searchtext =  $("#" + objID).val().trim();
        if(searchtext!=""){
             $(".dishproperties").hide();
            $(".product-line-heading").hide();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){
                   
                    if( ( $(this).find(".hidden-product-name").length > 0 &&  IsMatchSearch(searchtext, $(this).find(".hidden-product-name").html().trim()) ) || (  $(this).find(".product-line__description").length > 0 &&    IsMatchSearch(searchtext, $(this).find(".product-line__description").html().trim())) )
                    {
                        $(this).show();
                        categroup.show();
                        $("#group-" + categroup.attr("id")).show();
                        $("#group-" + categroup.attr("id")).find("img").removeClass("arrow-icon-down").addClass("arrow-icon-up");
                    }else
                    {
                        $(this).hide();
                    }
                });
            });
        }else{
            $(".product-line-heading").show();
            $("[data-type=group-cate]").each(function(){
                var categroup  = $(this);
                categroup.find(".product-line").each(function(){
                     if(screenmode=="mobile")
                    {
                        categroup.hide();
                        $(this).show();
                        $(categroup).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                    }else
                    {
                        $(this).show();
                    }
                });
            });
        }        
    }


        var curnumday = <%=Weekday(DateAdd("h",houroffset,now),vbMonday) %>;
         function isDayClose(iday)
    {
        var isClose = true;   
        $("[name=nameopentime]").each(function(){
            if($(this).attr("nameopentime")==iday && $(this).attr("available")=="y")
                isClose =  false;
        });
        
        if(isClose==true && $('[nameopentime='+iday+']').length > 0){
            $('[nameopentime='+iday+']').slice(1).remove();
            $('[nameopentime='+iday+'] td:eq(1)').html("<div align='right'>Closed</div>");
            

            isClose = false;
        }
            
        return isClose;
    }
    var ArrDay =[1,2,3,4,5,6,7];
    var ArrNameDay =["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];

    for(var iday = 0; iday<ArrDay.length;iday++)
    {
        if(isDayClose(ArrDay[iday]))
        {   var styleCurrentday ="";
                if(ArrDay[iday]==curnumday)
                    styleCurrentday="font-weight:bold;";
            if(ArrDay[iday]==1)
            {
                $( "#openninghours" ).prepend( "<tr name='nameopentime' nameopentime='" +ArrDay[iday]+"' style='" + styleCurrentday + "'><td style='width:30px;'>" +ArrNameDay[iday] + "</td><td><div align='right'>Closed</div></td></tr>" );
            }
            else
            {   var pday  = ArrDay[iday]-1;
               
                $("<tr name='nameopentime' nameopentime='" +ArrDay[iday]+"' style='"+styleCurrentday+"'><td style='width:30px;'>" +ArrNameDay[iday] + "</td><td><div align='right'>Closed</div></td></tr>").insertAfter("[nameopentime="+pday+"] :last");
            }
        }
    }
        
        if($.trim($("[nameopentime="+curnumday+"] div").html()) == "CLOSED")
        {
            $("#msgclose").show();
            $("#msgcurrent").hide();
            
        }
    </script>

<script type="text/javascript">
    // process for product line no border 
    $(".no-border").each(function(){
        $("[name='" +$(this).attr("name")+ "']").addClass("no-border");
    });
    $(".no-border").filter("[parent='0']").each(function(){
        var obj =   $(this).find(".product-line__content-right").clone();
        var newline = '<div class="product-line  no-border"  fishversion="true">';
                
        $(newline +  $(obj).wrapAll('<div class="abc">').parent().html() + "</div>").insertAfter(this);
        $(this).find(".product-line__content-right").remove();
        $(this).find(".product-line__content-left").removeClass("product-line__content-left").addClass("product-line__content");
    });
    $("[fishversion=true]").find(".product-line__content-right").css("border-top","none");
    $(function(){
        $("input.noSubmit").keypress(function(e){
            var k=e.keyCode || e.which;
            if(k==13){
                e.preventDefault();
            }
        });
    });
        
    var jsDate = {
        <%=jsDate %>
        };
    var myDays= ["Monday","Tuesday","Wednesday",
        "Thursday","Friday","Saturday","Sunday"]

    function ReloadShop() {
		
        $("#shoppingcart").load("<%=SITE_URL%>local/ShoppingCart.asp?id_r=<%= vRestaurantId %>"); 
	                
    }

    function Add(mi, mip,obj) {
		
		
        //add toppings chosen to querystring
        toppingschosen = $("input[data-group='toppings" + mi + "-" + mip + "']:checked").map(function() {return this.value;}).get().join(',');
        //alert(toppingschosen);
        optionsnotchosen="";
        //add dishproperties chosen to querystring format "id|value,id|value...."
        var dishproperties = [];
        $("select[data-group='dishproperties" + mi + "-" + mip + "']").each(function(){
            if ($(this).attr('data-required')=='y' && $(this).val()==0 ) {
                optionsnotchosen="y";
                alert($(this).attr('data-caption'));
		
            }
            dishproperties.push( $(this).attr('id')  + "|" + $(this).val()  );
		 
        });
        dishproperties.join(",");
        //alert(dishproperties);
		
        if (optionsnotchosen=='') {
            $(obj).find("span:eq(0)").hide();
            $(obj).find("span:eq(1)").show();
            $("#shoppingcart").load("<%=SITE_URL%>local/ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=add&mi=" + mi + "&mip=" + mip + "&toppingids=" + toppingschosen + "&dishproperties=" + dishproperties,function(){
               
                $(obj).find("span:eq(1)").hide();
                $(obj).find("span:eq(0)").show();
            });
        }
 
    }
		
	

    function Delc(itemId) {
	
        $("#shoppingcart").load("<%=SITE_URL%>local/ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=del&id=" + itemId);

    }
    function Del(itemId,qty)
    {
        $("#shoppingcart").load("<%=SITE_URL%>local/ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=del&qty="+qty+"&id=" + itemId);
    }
    function Showdishproperties(itemtoshow) {
	
        $("#" + itemtoshow).slideToggle();

    }
    
    function VoucherCode() {
	
	
        $("#shoppingcart").load("<%=SITE_URL%>local/ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=vouchercode&vouchercode=" + $('#vouchercode').val());
        return false;

    }


        
    function GetDistance(postalCode) {

        var deferred = $.Deferred();

        var service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix({
            origins: ['<%=sPostalCode %>'],
            destinations: [postalCode],
            travelMode: google.maps.TravelMode.DRIVING,
            unitSystem: google.maps.UnitSystem.METRIC,
            avoidHighways: false,
            avoidTolls: false
        }, function callback(response, status) {
            deferred.resolve(response) ;
        });
        
        return deferred.promise();
    }
    function GetDistanceGMLatLng(oLat, oLng, dLat, dLng) {

        var deferred = $.Deferred();

        var service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix({
            origins: [new google.maps.LatLng(oLat, oLng)],
            destinations: [new google.maps.LatLng(dLat, dLng) ],
            travelMode: google.maps.TravelMode.DRIVING,
            unitSystem: google.maps.UnitSystem.METRIC,
            avoidHighways: false,
            avoidTolls: false
        }, function callback(response, status) {
            if(status == google.maps.DistanceMatrixStatus.OK)
                CheckDistanceLatLng( parseFloat(response.rows[0].elements[0].distance.value/1000).toFixed(2) );
                    
                
        });        
           
    }

    function CheckDistance() {
           
            
			
        <%if individualpostcodeschecking=0 then%>
         CheckDistanceLatLng();
        return false;
        $.when(GetDistance(zipcode)).then(function(data) {
                
            var distance = -1;

            if (data.rows && data.rows.length > 0) {
                if (data.rows[0].elements
                        && data.rows[0].elements.length > 0) {
                    if (data.rows[0].elements[0].status == 'OK')
                        distance = data.rows[0].elements[0].distance.value;
                }
            }

            if(distance >= 0) 
            {
                var free_miles = parseFloat('<%=sDeliveryFreeDistance %>');
                var max_miles = parseFloat('<%=sDeliveryMaxDistance %>');
                var form = $("#CheckOutForm");
                <%if mileskm="miles" then%>
                var miles = distance * .6214;
                <%else%>
                var miles = distance;
                <%end if%>
                miles=(Math.round(miles / 10) / 100);
                $("#DeliverySpan").html("Distance: " + miles + " m");
                //console.log(distance, free_miles, max_miles);
                if(miles > max_miles)
                {
                    $('.delivery_info').hide();   
                    $("#missingPostcodeAlert").show();
                    $("#missingPostcodeAlert").html('This Takeaway Only Offers <strong>Collection</strong> To Your Postcode');                       
                    $('input[name=distance]', form).val('');
                    $('.delivery_info').addClass('alert-danger');
                    $('.delivery_info').removeClass('alert-success'); 
                }
                else
                {
                    var total = parseFloat($("#SubTotal").val());
					
					
                    if (total><%=sDeliveryChargeOverrideByOrderValue%>) {
						
                    $("#missingPostcodeAlert").hide();
					
                    $('.delivery_info').show();
                    $('#delivery_fee').text('0'); 
                    $('input[name=deliveryDistance]', form).val(miles);
                    $('#showdistance').html(miles + ' <%=mileskm%>');
                    $.ajax({url: "ajaxdeliverydistance.asp?d=" + miles , success: function(result){
                        ReloadShop();
                    }});
                    $('input[name=deliveryPC]', form).val(zipcode);
                    $('div.beforeorder').css('border-color', '#E9EAEB');
						
                    $('.delivery_info').removeClass('alert-danger');
                    $('.delivery_info').addClass('alert-success');
						
						
                } else {
					
                    $("#missingPostcodeAlert").hide();
					
                $('.delivery_info').show();
                if(miles <= free_miles) {
                    $('#delivery_fee').text('0'); 
                    $('#df').css('color', '#3c763d');
                } else  {
					
                    $('#delivery_fee').text('<%= FormatNumber(sDeliveryFee, 2) %>');
                }
                $('input[name=deliveryDistance]', form).val(miles);
                $('#showdistance').html(miles + ' <%=mileskm%>');
						
                $.ajax({url: "ajaxdeliverydistance.asp?d=" + miles , success: function(result){
                    ReloadShop();
                }});
                $('input[name=deliveryPC]', form).val(zipcode);
                $('div.beforeorder').css('border-color', '#E9EAEB');
						
                $('.delivery_info').removeClass('alert-danger');
                $('.delivery_info').addClass('alert-success');
            }
        }
        }
    else 
    {
                    $("#DeliverySpan").html("Distance: --");
    $("#missingPostcodeAlert").html('Your Postcode code seems to be <strong>invalid</strong>');                   
    $('input[name=distance]', form).val('');
    }     

    return false; 
    
    });
			
    <%else%>
            var zipcode = $("#validate_pc").val();
                
    if(!zipcode || zipcode == '')
    {
        $('#DeliveryDistance div.delivery_info').hide();   
        $("#missingPostcodeAlert").show();
        $("#missingPostcodeAlert").html('<strong>Postal Code Required!</strong>');
        $('input[name=distance]', form).val('');
        $('.delivery_info').addClass('alert-danger');
        $('.delivery_info').removeClass('alert-success'); 
        return false;
    }
    var miles;
    var distance;
    var form = $("#CheckOutForm");
    if(zipcode.indexOf(' ') >= 0){
			
        firstpartofzipcode = "|" + zipcode.substr(0,zipcode.indexOf(' ')) + "|";
        individualpostcodes = "<%=individualpostcodes%>";
        if(individualpostcodes.toLowerCase().indexOf(firstpartofzipcode.toLowerCase()) >= 0){
			
			
            $("#missingPostcodeAlert").hide();
            $("#missingPostcodeAlert3").hide();
            $("#missingPostcodeAlert2").hide();	
	
	
		    
            $('.delivery_info').show();
					
            $('#delivery_fee').text('<%= FormatNumber(sDeliveryFee, 2) %>');
            var zipcode = $("#validate_pc").val();


            $.when(GetDistance(zipcode)).then(function(data) {
                distance = -1;
                if (data.rows && data.rows.length > 0) {
                    if (data.rows[0].elements && data.rows[0].elements.length > 0) {
                        if (data.rows[0].elements[0].status == 'OK') {
                            distance = data.rows[0].elements[0].distance.value;
                        }
                    }
                }
                <%if mileskm="miles" then%>
                                    var miles = distance * .6214;
                <%else%>
                var miles = distance;
                <%end if%>
                miles=(Math.round(miles / 10) / 100);
                $('input[name=deliveryDistance]', form).val(miles);
                $('#showdistance').html(miles + ' <%=mileskm%>');
                $.ajax({url: "ajaxdeliverydistance.asp?d=" + miles , success: function(result){
                    ReloadShop();
                }});
                $('input[name=deliveryPC]', form).val(zipcode);
                $('input[name=deliveryPostCode]', form).val(zipcode);
                   
            }

            )
				
				
				
                     
                      
            $('div.beforeorder').css('border-color', '#E9EAEB');
            $('.delivery_info').removeClass('alert-danger');
            $('.delivery_info').addClass('alert-success');
        } else {
            $("#missingPostcodeAlert").hide();
            $("#missingPostcodeAlert3").hide();
            $("#missingPostcodeAlert2").show();	
        }
    } else {
        $("#missingPostcodeAlert").hide();
        $("#missingPostcodeAlert2").hide();
        $("#missingPostcodeAlert3").show();	
    }
			
			
			
						
			
    <%end if%>
                                       
    }
		
function CheckCollectionTime() {
    var dt = $("#DeliveryTime");
    var _sTime = $("select[name=p_hour]", dt).val() + ":";
    boxdate2=("0" + ($("select[name=p_minute]", dt).val())).slice(-2)
    _sTime  += boxdate2;
    _time = Date.parse('01/01/2011 ' + _sTime);
    var parts = $("#OrderDate input").val().split('/');
    var _date =  new Date(parts[2], parts[1]-1, parts[0]);
    var days = _date.getDay();
    var key;
    if (days == 0) days = 7;
    isopen=0;
    nocollection=0;
    var offsetmins,OpenTime,isEarly,AcceptOrderBeforeClosing;
    isEarly = 0;
    if ($('input[name=orderTypePicker]:checked').val() == 'd') {
    offsetmins=$('#deliverydelay').val();
    } else {
    offsetmins=$('#collectiondelay').val();
    }
    for (key in jsDate) {
    if (jsDate[key].d==days) {
    if (jsDate[key].max<jsDate[key].min) {
     if ((_time >= jsDate[key].min  && _time <= Date.parse('01/01/2011 23:59')) || (_time >= Date.parse('01/01/2011 00:00') && _time <= (jsDate[key].max +  ( (jsDate[key].minacceptorderbeforeclose == -1 ? 0 :(offsetmins - jsDate[key].minacceptorderbeforeclose)  ) * 60000 ) ) )) {
       if((_time >= jsDate[key].min && _time <= Date.parse('01/01/2011 23:59')) && (jsDate[key].min + offsetmins * 60000) > _time){
             OpenTime = new Date(jsDate[key].min + offsetmins * 60000);
            isEarly = 1;
    }
        if (jsDate[key].collection=='n') {
            nodelivery=1;
    }
     isopen=1;
    }
    } else {
			
    if (jsDate[key].min <= _time && ( jsDate[key].max + ( (jsDate[key].minacceptorderbeforeclose == -1 ? 0 :(offsetmins - jsDate[key].minacceptorderbeforeclose)  ) * 60000 ) ) >= _time) {
        if((jsDate[key].min + offsetmins * 60000) > _time){
            OpenTime = new Date(jsDate[key].min + offsetmins * 60000);
            isEarly = 1;
    }
            if (jsDate[key].collection=='n') {
                nocollection=1;
    }
    isopen=1;
    }
    }
    }
    }
        //second check
    if (isopen==0 && _time <= Date.parse('01/01/2011 12:00')) {
    dayprev=days-1;
    if (daysprev=0) {
    dayprev=7;
    }
    for (key2 in jsDate) {
    if (jsDate[key2].d==dayprev) {
                if ( jsDate[key2].max<jsDate[key2].min ) {
                    if ( _time <= (jsDate[key2].max + + ( (jsDate[key].minacceptorderbeforeclose == -1 ? 0 :(offsetmins - jsDate[key].minacceptorderbeforeclose)  ) * 60000 ) )) {
                    if (jsDate[key2].collection=='n') {
                        nocollection=1;

    }
                    isopen=1;
    }
    }				
    }
    }			
    }
    var delivery_type  = $('input[name=orderTypePicker]:checked').val();
    if (nocollection==1 && delivery_type=='c' ) {

        $("#timeslotModal2").modal();
	
    return false;
    }	
if(!jsDate[days])
    {
			
        $("#ClosedModal div.modal-body").html('Sorry, On ' + myDays[days-1] + ' we are closed.');
        $("#ClosedModal").modal();
        return false;
    } 
    else if(isopen==0)
    {
        $("#ClosedModal div.modal-body").html('Sorry, On ' + myDays[days-1] + ' at ' + ("0" + _sTime).slice(-5) + '  we are closed.');
        $("#ClosedModal").modal();
        return false;
    }
     var form = $("#CheckOutForm"); 
    if(isEarly==1){
         $("input[name=ordertimeoverride][value=l]").attr("checked","checked");
        $("input[name=ordertimeoverride]").trigger("change");
           $("select[name=p_hour]", dt).val(OpenTime.getHours());
            $("select[name=p_minute]", dt).val(OpenTime.getMinutes());
               
        _sTime = $("select[name=p_hour]", dt).val() + ":";
        boxdate2=("0" + ($("select[name=p_minute]", dt).val())).slice(-2)
        _sTime  += boxdate2;
         $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
                
       $('input[name=deliveryType]', form).val(delivery_type);
       $('input[name=special]', form).val($("#Specialinput").val());
       $('input[name=asaporder]', form).val($('input[name=ordertimeoverride]:checked').val());
       $('input[name=deliveryLat]', form).val($("#hidLat").val());
       $('input[name=deliveryLng]', form).val($("#hidLng").val());
       $('input[name=deliveryPostCode]', form).val($("#hidPostCode").val());
       $('input[name=deliveryAddress]', form).val($("#hidFormattedAdd").val());
       alert("Your selected delivery/collection time is too near the opening time. We need to adjust it to allow enough time to prepare your order.");
        // $("#tooEarlyOrder").modal();
        return true;
    }           
    $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
    return true;
    }
        
        function CheckDeliveryTime() {
            var dt = $("#DeliveryTime");
            var _sTime = $("select[name=p_hour]", dt).val() + ":";
            boxdate2=("0" + ($("select[name=p_minute]", dt).val())).slice(-2);
            _sTime  += boxdate2;
            _time = Date.parse('01/01/2011 ' + _sTime);
            var parts = $("#OrderDate input").val().split('/');
            var _date =  new Date(parts[2], parts[1]-1, parts[0]);
            var days = _date.getDay();
            var key;
            if (days == 0) days = 7;
            isopen=0;
            nodelivery=0;
            var offsetmins,OpenTime,isEarly;
            isEarly = 0;
            if ($('input[name=orderTypePicker]:checked').val() == 'd') {
                offsetmins=$('#deliverydelay').val();
            } else {
                offsetmins=$('#collectiondelay').val();
            }
            for (key in jsDate) {
                if (jsDate[key].d==days) {
                    if (jsDate[key].max<jsDate[key].min) {
                        if ((_time >= jsDate[key].min && _time <= Date.parse('01/01/2011 23:59')) || (_time >= Date.parse('01/01/2011 00:00') && _time <= (jsDate[key].max + ( (jsDate[key].minacceptorderbeforeclose == -1 ? 0 :(offsetmins - jsDate[key].minacceptorderbeforeclose)  ) * 60000 ) ) )) {
                            if((_time >= jsDate[key].min && _time <= Date.parse('01/01/2011 23:59')) && (jsDate[key].min + offsetmins * 60000) > _time){
                                OpenTime = new Date(jsDate[key].min + offsetmins * 60000);
                                isEarly = 1;
                            }
                            if (jsDate[key].delivery=='n') {
                                nodelivery=1;
                            }
                            isopen=1;
                        }
                    } else {
			
                        if (jsDate[key].min <= _time && ( jsDate[key].max + ( (jsDate[key].minacceptorderbeforeclose == -1 ? 0 :(offsetmins - jsDate[key].minacceptorderbeforeclose)  ) * 60000 ) ) >= _time) {
                            if((jsDate[key].min + offsetmins * 60000) > _time){
                                OpenTime = new Date(jsDate[key].min + offsetmins * 60000);
                                isEarly = 1;
                            }
                            if (jsDate[key].delivery=='n') {
                                nodelivery=1;
                            }
                            isopen=1;
                        }
                    }
                }
            }
            //second check
            if (isopen==0 && _time <= Date.parse('01/01/2011 12:00')) {
                dayprev=days-1;
                if (daysprev=0) {
                    dayprev=7;
                }
                for (key2 in jsDate) {
                    if (jsDate[key2].d==dayprev) {
                        if ( jsDate[key2].max<jsDate[key2].min ) {
                            if ( _time <= ( jsDate[key2].max + + ( (jsDate[key].minacceptorderbeforeclose == -1 ? 0 :(offsetmins - jsDate[key].minacceptorderbeforeclose)  ) * 60000 ) ) ) {
                                if (jsDate[key2].delivery=='n') {
                                    nodelivery=1;

                                }
                                isopen=1;
                            }
                        }				
                    }
                }			
            }
            var delivery_type  = $('input[name=orderTypePicker]:checked').val();
            if (nodelivery==1 && delivery_type=='d' ) {

                $("#timeslotModal").modal();
	
                return false;
            }	
            if(!jsDate[days])
            {
                $("#ClosedModal div.modal-body").html('Sorry, On ' + myDays[days-1] + ' we are closed.');
                $("#ClosedModal").modal();
                return false;
            } 
            else if(isopen==0)
            {
                $("#ClosedModal div.modal-body").html('Sorry, On ' + myDays[days-1] + ' at ' + ("0" + _sTime).slice(-5) + '  we are closed.');
                $("#ClosedModal").modal();
                return false;
            } 
            
            var form = $("#CheckOutForm"); 
            if(isEarly==1){
                $("input[name=ordertimeoverride][value=l]").attr("checked","checked");
                $("input[name=ordertimeoverride]").trigger("change");
                $("select[name=p_hour]", dt).val(OpenTime.getHours());
                $("select[name=p_minute]", dt).val(OpenTime.getMinutes());
               
                _sTime = $("select[name=p_hour]", dt).val() + ":";
                boxdate2=("0" + ($("select[name=p_minute]", dt).val())).slice(-2)
                _sTime  += boxdate2;
                $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
                
                $('input[name=deliveryType]', form).val(delivery_type);
                $('input[name=special]', form).val($("#Specialinput").val());
                $('input[name=asaporder]', form).val($('input[name=ordertimeoverride]:checked').val());
                $('input[name=deliveryLat]', form).val($("#hidLat").val());
                $('input[name=deliveryLng]', form).val($("#hidLng").val());
                $('input[name=deliveryPostCode]', form).val($("#hidPostCode").val());
                $('input[name=deliveryAddress]', form).val($("#hidFormattedAdd").val());
                //$("#tooEarlyOrder").modal();
                alert("Your selected delivery/collection time is too near the opening time. We need to adjust it to allow enough time to prepare your order.");
                return true;
            }    

            $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
            return true;
        }

    function CheckOrder() {
        if($("#tablenumber").val() == "")
        {
            //alert("Please enter table number to order!");
            scrollToV2("tablenumber");
           

            $("#tablenumber").focus();
            $("#tablenumber").css("border-color","red");
            return;
        }
        setCookie("TableNumber",$("#tablenumber").val(),15);        
        $('input[name=special]', $('#CheckOutForm')).val($("#Specialinput").val());
        $('input[name=TableNumberCheckout]', form).val($("#tablenumber").val());        
       
        $('#CheckOutForm').submit();
        return true;

        if ($('input[name=ordertimeoverride]:checked').val() == 'n') { 

            if ($('input[name=orderTypePicker]:checked').val() == 'd') {
                offsetmins=$('#deliverydelay').val();
            } else {
                offsetmins=$('#collectiondelay').val();
            }
            var dt1 = new Date();
            offsetmins2 = parseInt(offsetmins)+5;

            var dt = new Date(dt1.getTime() + (offsetmins2)*60000);
            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
            $("select[name=p_hour]").val(dt.getHours());
            $("select[name=p_minute]").val(round5(dt.getMinutes()));
	
            $("#OrderDate input").val(dt.getDate()  + "/" + (dt.getMonth() +1) + "/" + dt.getFullYear());
	
	
        }
        try
        {
            var delivery_type  = $('input[name=orderTypePicker]:checked').val();
			
            if(!delivery_type)
            {
			     
                $('#beforeorder').css('border-color', 'red');
                $('#beforeorder').css('border-width', '4px');
                scrollToV2("beforeorder");
                //$("#BeforeYouOrder").modal();
                return false;
            }

            var form = $("#CheckOutForm");
            $('input[name=deliveryType]', form).val(delivery_type);
            $('input[name=special]', form).val($("#Specialinput").val());
            $('input[name=asaporder]', form).val($('input[name=ordertimeoverride]:checked').val());
            $('input[name=deliveryLat]', form).val($("#hidLat").val());
            $('input[name=deliveryLng]', form).val($("#hidLng").val());
            $('input[name=deliveryPostCode]', form).val($("#hidPostCode").val());
            $('input[name=deliveryAddress]', form).val($("#hidFormattedAdd").val());
            if(delivery_type == 'd')
            {
                var distance = $('input[name=deliveryDistance]', form).val();
                if(!distance)
                {
                    $('#beforeorder').css('border-color', 'red');
                    scrollToV2("beforeorder");
                    //$("#BeforeYouOrder").modal();
                    return false;
                }

                var min_amount = <%= sDeliveryMinAmount %>;
                var total = parseFloat($("#SubTotal").val());
                if(min_amount > 0 && total < min_amount)
                {
                    $("#DeliveryModal div.modal-body").html('Sorry. Minimum Order for Delivery is <%=CURRENCYSYMBOL%> ' + min_amount);
                    $("#DeliveryModal").modal();
                    return false;
                }
            }

               
            // check to see if current time is greater than delivery or collection time 
            var dt = $("#DeliveryTime");
            var _sTime = $("select[name=p_hour]", dt).val() + ":";
            _sTime  += $("select[name=p_minute]", dt).val();
            //alert(_sTime);
            _time = Date.parse('01/01/2011 ' + _sTime);
			
            var parts = $("#OrderDate input").val().split('/');
            var _selecteddateandtime =  new Date(parts[2], parts[1]-1, parts[0],$("select[name=p_hour]", dt).val(),$("select[name=p_minute]", dt).val());
            //alert(_selecteddateandtime);
            var currdt = new Date();
            //alert(currdt);
            if(delivery_type == 'd') {
                var newcurrdt = new Date(currdt.getTime() + <%=sAverageDeliveryTime%>*60000);
	
            } else {
                var newcurrdt = new Date(currdt.getTime() + <%=sAverageCollectionTime %>*60000);
            }

            if (_selecteddateandtime < newcurrdt) {
                alert("Delivery/Collection time selected sooner than time required to prepare an order");
                return false;
            }
				
				
            if(!CheckDeliveryTime())
            { 
				
				
		
                 
                return false;
            }
				
            if(!CheckCollectionTime())
            { 
				
				
		
                 
                return false;
            }
            $('#beforeorder').css('border-color', '#E9EAEB');

            $('#CheckOutForm').submit();
            return true;
			   
        }
        catch(ex)
        {
            return false;
        }


    }
        
    function round5(x)
    {
        x2=(x % 5) >= 2.5 ? parseInt(x / 5) * 5 + 5 : parseInt(x / 5) * 5;
        if (x2==60) { x2=0; }
        return(x2);
    }

    $(function () {
             
        var viewport_width = $( window ).width();
        //  if(viewport_width < 748)
        //  {
        //       $("div[data-spy]")
        //           .removeAttr('data-spy')
        //           .removeAttr('data-offset-top');
        //  }

        var _date = new Date();
        var hour = _date.getHours();
        var minutes = _date.getMinutes();
        var dt = $("#DeliveryTime");
			
        if (hour==23) {
			
            $("select[name=p_hour]", dt).val(0);
            _date.setDate(_date.getDate() + 1); 
            boxdate=("0" + (_date.getMonth() + 1)).slice(-2)
            boxday=("0" + (_date.getDate())).slice(-2)
            ddate20=boxday.toString() + "/" + boxdate.toString() + "/"  + _date.getFullYear().toString()
            $("#OrderDateBox").val(ddate20);
        } else {
            $("select[name=p_hour]", dt).val(hour + 1);
			
        }
        $("select[name=p_minute]", dt).val(round5(minutes));

			
        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

	
                 $("input[name=ordertimeoverride]").click(function() {
            $.ajax({url: "ajaxdelivery.asp?d=" + $('input[name=orderTypePicker]:checked').val() , success: function(result){
                ReloadShop();
            }});
	
          if ($('input[name=ordertimeoverride]:checked').val() == 'n') { 
	  
        if ($('input[name=orderTypePicker]:checked').val() == 'c') { 
        offsetmins=$('#collectiondelay').val();
        var dt1 = new Date();
        offsetmins2 = parseInt(offsetmins)+5;
        var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
        $("select[name=p_hour]", dt).val(dt.getHours());
        $("select[name=p_minute]").val(round5(dt.getMinutes()));
        }
	
        }
	
				 
          if ($('input[name=ordertimeoverride]:checked').val() == 'n') { 
	  
        if ($('input[name=orderTypePicker]:checked').val() == 'd') { 
	
        $("#DeliveryDistance").show();  $("#DeliveryTime").hide();  $("#DeliveryTime label").text("Delivery Time *"); 	} else {
        $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").hide();
	
        }
	 
	 
        } 	
	  
                if ($('input[name=ordertimeoverride]:checked').val() == 'l') { 
	  
             if ($('input[name=orderTypePicker]:checked').val() == 'd') { 
		
             $("#DeliveryDistance").show(); 
              $("#DeliveryTime").show();  
              $("#DeliveryTime label").text("Delivery Time *"); 
		 
        offsetmins=$('#deliverydelay').val();
        var dt1 = new Date();
        offsetmins2 = parseInt(offsetmins)+5;
        var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
        $("select[name=p_hour]", dt).val(dt.getHours());
        $("select[name=p_minute]").val(round5(dt.getMinutes()));
	
        } else {  
              $("#DeliveryDistance").hide();
               $("#DeliveryTime label").text("Collection Time *");
                $("#DeliveryTime").show(); 
                if ($('input[name=orderTypePicker]:checked').val() == 'c') { 
        offsetmins=$('#collectiondelay').val();
        var dt1 = new Date();
        offsetmins2 = parseInt(offsetmins)+5;
        var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
        $("select[name=p_hour]", dt).val(dt.getHours());
        $("select[name=p_minute]").val(round5(dt.getMinutes()));
        }
        }
	 
        } 	
	  
	  
	  
	  
	  
	  

			 
        });
            
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

        $("input[name=orderTypePicker]").click(function() {
			
            $("#nowlater").show();
			
            $.ajax({url: "ajaxdelivery.asp?d=" + $('input[name=orderTypePicker]:checked').val() , success: function(result){
                ReloadShop();
            }});
	
            if ($('input[name=ordertimeoverride]:checked').val() == 'n') { 
	  
                if ($('input[name=orderTypePicker]:checked').val() == 'c') { 
                    offsetmins=$('#collectiondelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins)+5;
                    var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                    $("select[name=p_hour]", dt).val(dt.getHours());
                    $("select[name=p_minute]").val(round5(dt.getMinutes()));
                }
	
            }
	
				 
            if ($('input[name=ordertimeoverride]:checked').val() == 'n') { 
	  
                if ($('input[name=orderTypePicker]:checked').val() == 'd') { 
	
                    $("#DeliveryDistance").show();  $("#DeliveryTime").hide();  $("#DeliveryTime label").text("Delivery Time *"); 	} else {
                    $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").hide();
	
                }
	 
	 
            } 	
	  
            if ($('input[name=ordertimeoverride]:checked').val() == 'l') { 
	  
                if ($('input[name=orderTypePicker]:checked').val() == 'd') { $("#DeliveryDistance").show();  $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *"); } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
                }
	 
            } 	
	  	 
				 
				 
        });

        jQuery.validator.setDefaults({
            errorPlacement: function (error, element) {
                if (element.parent().hasClass('input-prepend') || element.parent().hasClass('input-append')) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            },
            errorElement: "small", 
            wrapper: "div", 
            highlight: function (element) {
                $(element).closest('.control-group').addClass('error'); 
            },
            success: function (element) {
                $(element).closest('.control-group').removeClass('error');
            }
        });

        $("form").removeAttr("novalidate");
        $("form").validate();

        $.ajaxSetup ({
            cache: false
        });
            
        ReloadShop();            

        <% If Not sIsOpen then %>
            $("#ClosedModal").modal();
        <%if sorderonlywhenopen=1 then%>
        $("#beforeorder").hide();
        $("#noorders").show();
        <%end if%>
    <% End If %>

    });
		
		
		
    $("input[name='ordertimeoverride']").change(function(){
		
        if ($(this).val() == 'n') {
	
            if ($('input[name=orderTypePicker]:checked').val() == 'd') {
                offsetmins=$('#deliverydelay').val();
            } else {
                offsetmins=$('#collectiondelay').val();
            }
            var dt1 = new Date();
            var dt = new Date(dt1.getTime() + offsetmins*60000);
	
            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
            $("select[name=p_hour]", dt).val(dt.getHours());
            $("select[name=p_minute]").val(round5(dt.getMinutes()));
	
            if ($('input[name=orderTypePicker]:checked').val() == 'd') { $("#DeliveryDistance").show();  $("#DeliveryTime").hide();  $("#DeliveryTime label").text("Delivery Time *"); 	} else {
                $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").hide();
	
            }
        };
	
        if ($(this).val() == 'l') {
            if ($('input[name=orderTypePicker]:checked').val() == 'd') { $("#DeliveryDistance").show();  $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *"); } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
            }
   
        } 
    });
    </script>
<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
				
				
				
				<div class="navbar-header" style="float:right;">
					
					
					
					 <div class="navbar-brand" >  <span class="label label-success" id="addtobasket" style="float:left;margin-right:10px;">Added</span><button type="button" onclick="CheckOrder();" id="butcontinue" class="btn btn-primary btn-sm" style="float:right;margin-left:10px;">Checkout <span class="glyphicon glyphicon-chevron-right"></span></button>        <button type="button"  id="butbasket" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-shopping-cart"></span> <b>Basket</b> <%=CURRENCYSYMBOL%>  <span id="shoppingcart2"></span></button>

</div>
				</div>
				
				
				
			</nav>



			
    <div id="ClosedModal1" class="modal fade">
	  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
          <!--  <h3 style="color: red">
                Closed</h3>-->
        </div>
        <div class="modal-body" style="text-align: center;">
            <p>
                Sorry, <b>
                    <%=sName %></b> is closed at the moment.<br />
                However, you can place an order now for delivery at a later time.<br />
            </p>
        </div>
        <div class="modal-footer" style="text-align: center;">
            <a href="#" onclick="initIdleTimeoutReset();" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>
    </div></div></div>
     <div id="ResetSessionModal" class="modal fade">
	  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
          <!--  <h3 style="color: red">
                Closed</h3>-->
        </div>
        <div class="modal-body" style="text-align: center;">
            
        </div>
        <div class="modal-footer" style="text-align: center;">
            <a onclick="PopupRestartOnclick(false);" href="#" data-dismiss="modal" class="btn btn-primary">Yes</a>
            <a onclick="PopupRestartOnclick(true);" href="#" data-dismiss="modal" class="btn btn-primary">No</a>
        </div>
    </div></div></div>
    <div id="DeliveryModal" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
                Delivery not possible</h3>
        </div>
        <div class="modal-body">
            
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	<div id="AnnouncementModal" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Announcement</h3>
        </div>
        <div class="modal-body">
            
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	
	
	<div id="SessionTimeout" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Timeout</h3>
        </div>
        <div class="modal-body">
            An error has occured - session timeout. You must restart your order.
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	
	
	<div id="timeslotModal" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Warning</h3>
        </div>
        <div class="modal-body">
            Delivery is not available during your selected timeslot. Please check our opening times.
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	<div id="timeslotModal2" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Warning</h3>
        </div>
        <div class="modal-body">
            Collection is not available during your selected timeslot. Please check our opening times.
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	<div id="tooEarlyOrder" class="modal fade">
		  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
              Warning</h3>
        </div>
        <div class="modal-body">
            Your selected delivery/collection time is too near the opening time. We need to adjust it to allow enough time to prepare your order.
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
        </div>   </div>   </div>
    </div>
	
	
	<div id="lightbox" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="margin-top: 20px;
    margin-left: 20px;">
    <div class="modal-dialog">
        <button type="button" class="close hidden" data-dismiss="modal" aria-hidden="true">x</button>
        <div class="modal-content">
            <div class="modal-body">
                <img src="" alt="" />
            </div>
        </div>
    </div>
</div>
 <div id="FilterModal" class="modal fade">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                ×</button>
                <h4>Filter</h4>

            </div>
            <div class="modal-body">
                
      <% if StrAllergen & "" <> "" then
                    dim arrStrAllergen : arrStrAllergen = split(StrAllergen,"[**]")
                    dim indexAllergen : indexAllergen = 0
                    dim AllergenID,AllergenName,AllergenIcon,AllergenType
                  %> 
                <style>
.span-icon br {
  display: none;
}
.eicon-list.eicon-list li {
    width: auto;
    margin-bottom: 0;
    padding-top: 6px;
    padding-bottom: 6px;
    position: relative;
}

.span-icon img {
  margin-right: 3px;
}
.icon-check.glyphicon-remove {
  color: red;
}
.icon-check.glyphicon-ok {
  color: green;
}
.eicon-list .icon-check {
    top: 10px;
    left: 8px;
    right: auto;
    position: absolute;
    font-size: 18px;
    
}
/* <span class="glyphicon glyphicon-remove icon-check icon-check--remove"></span> */
t-action.list-action {
  margin-bottom: 0;
  height: 37px;
  display: inline-flex;
  align-items: center;
}
.list-action .fa {
  margin-right: 9px;
  font-size: 22px;
  color: black;
}
.mt-20 {
  margin-top: 20px;
}
.mb-5 {
  margin-bottom: 5px;
}
.list-collapse .will-hide {
  display: none;
}
.eicon-list.eicon-list {
  padding-left: 15px;
  padding-right: 15px;
  background-color: whitesmoke;
}
.bootstrap-select-wrapper.bootstrap-select-wrapper,
.dishproperties .bootstrap-select {
  padding: 0;
}
.bootstrap-select-wrapper.bootstrap-select-wrapper .dropdown-toggle,
.dishproperties .dropdown-toggle {
  width: 100%;
}

.open > .dropdown-menu {
  padding-top: 0;
}
.dropdown-menu.dropdown-menu.inner {
  position: relative;
  float: none;
  min-width: auto;
  border: 0;
  top: 100%;
  background: #ffffff;
}
.row-md-flex{
    margin-left: 0;
    margin-right: 0;
}
@media only screen and (min-width: 768px){
    .row-md-flex{
        display: flex;
        margin-left: 0;
        margin-right: 0;
        align-items: flex-start;
    }
    .flex-md-auto{
        flex: 0 0 auto;
        width: auto;
        float: none;
        width: 108px;
        padding-left: 0;
        padding-right: 0;
        padding-top: 6px;
    }
    .flex-md-expand{
        flex: 1;
        width: auto;
        float: none;
       
    }
}
@media only screen and (min-width: 768px) and (max-width: 991px){
    .flex-md-auto{
         width: 118px;
    }
}
/*task 263 */
.bootstrap-select.w-select{
width: calc(100% - 20px);
}

.tooltip .tooltip-inner{
   width: auto;
  max-width: 100%;
  padding-top:5px;
  padding-bottom: 5px;
  text-align: left;
  font-size: 12px;
}
.tip{
  color: #fec752;
} 
.tip-allergen{margin-left:10px;}

.pr-0{padding-right: 0px !important;}
.pl-0{padding-left: 0px !important;}
.d-flex{display: flex;border-bottom:1px dotted #d4d4d4;}
.mr-5{margin-right:5px}
.ml-5{margin-left:5px}
.ml-auto{margin-left: auto;}

.dishproperties .dropdown-menu.dropdown-menu.inner{
    min-width: 288px !important;
}

.dishproperties .dropdown-menu > li > a{
    padding: 3px 10px;
}

.toggle__input-main {
    -webkit-appearance: none;
    position: absolute;
    width: inherit;
    height: inherit;
    opacity: 0;
    left: 0;
    top: 0;
}

.toggle__input-main:checked+.toggle__label {
    padding-left: 33px;
}

.toggle__input-main:checked+.toggle__label:before {
    content: attr(data-on);
    left: 1px;
    top: 1px;
}

.toggle__input-main:checked+.toggle__label:after {
    margin: 1px;
}

.toggle__label {
    cursor: pointer;
    display: inline-block;
    position: relative;
    height: 25px;
    width: 58px;
    font-size: 10px;
    font-weight: 600;
    line-height: 20px;
    text-align: center;
    text-transform: uppercase;
    font-family: Helvetica,Arial,sans-serif;
    -webkit-transition: .3s ease-out;
    -moz-transition: .3s ease-out;
    -o-transition: .3s ease-out;
    transition: .3s ease-out;
    border-radius: 13px;
    margin-bottom: 0;
}

.toggle__label:before {
    width: 33px;
    content: attr(data-off);
    position: absolute;
    top: 1px;
    right: 3px;
}

.toggle__label:after {
    content: "�";
    width: 19px;
    height: 19px;
    margin: 1px;
    font: 20px/20px Times,Serif;
    display: block;
    -webkit-border-radius: 13px;
    -moz-border-radius: 13px;
    -o-border-radius: 13px;
    border-radius: 13px;
}

.toggle_transparent-white .toggle__label {
    border: 1px solid #fff;
}

.toggle_white .toggle__label {
    background: #fff;
    border: 2px solid #fff;
}

.toggle__text_red .toggle__label {
    color: #bb2021;
}

.toggle__text_pink .toggle__label {
    color: #cd0040;
}

.toggle__text_black .toggle__label {
    color: #000;
}

.toggle__after_red .toggle__label:after {
    color: #bb2021;
    background: #bb2021;
}

.toggle__after_orange .toggle__label:after {
    color: #f25c2a;
    background: #f25c2a;
}

.toggle__after_green .toggle__label:after {
    color: #018000;
    background: #018000;
}

.toggle__after_pink .toggle__label:after {
    color: #cd0040;
    background: #cd0040;
}

.toggle__after_black .toggle__label:after {
    color: #000;
    background: #000;
}

.toggle__after_white .toggle__label:after {
    color: #fff;
    background: #fff;
}

.filter-may {
    display: table;
    padding-bottom: 10px;
    padding:6px;
    margin-bottom:10px;
    background-color:#e4e3e3;
}

.filter-may__toggle {
    display: table-cell;
    vertical-align: middle;
    padding-right: 10px;
}

.filter-may__text {
    display: table-cell;
    vertical-align: middle;
    padding-right: 10px;
    font-size: 14px;
}

.filter-may_w100 {
    width: 100%;
}

.filter-may__min-width260 {
    min-width: 260px;
}
.glyphicon-filtered {
    color: orange!important;
    border: 1px dotted;
}

.w-select .caret {
  margin-left: -5px;
}

.w-select .filter-option {
text-align: left;  
overflow: hidden;  
white-space: nowrap;  
text-overflow: ellipsis;  
width: 100%;
}
@media (max-width: 767px) {
  .dishproperties__heading {
    padding-top:15px;
  }
}
.dropdown-menu > li > a:focus {
    outline: 0;
}
    </style>    
                
    <div class="row row-md-flex mt-20">
             
            <% if ucase(EnableAllergen & "") = "YES" then %>
            <div class="col-sm-3 flex-md-auto mb-5">Select without:</div>
             
            <ul class="eicon-list flex-md-expand col-sm-9 ng-scope list-inline" id="allergenlist">
                <li>
                    <div class="filter-may">
                        <div class="filter-may__text" data-bind="text:$root.staticResources().filterMayContain">Exclude dishes that "may contain" selected allergens</div>
                        <div class="toggle toggle_white toggle__after_orange toggle__text_black filter-may__toggle prn">
                            <input class="toggle__input-main"
                                    id="filter-may"
                                    name="filter-may"
                                    type="checkbox"
                                    value="true"
                                    checked="checked" data-bind="checked: includeMayValue" />
                            <label for="filter-may" data-on="YES" data-off="NO" class="toggle__label"></label>
                            <input type="hidden" value="false" name="filter-may" class="toggle__input-helper">
                        </div>
                    </div>
                </li>
                <% 
                    
                    for indexAllergen = 0 to ubound(arrStrAllergen)
                        if arrStrAllergen(indexAllergen) & "" <> "" then
                            AllergenID = split(arrStrAllergen(indexAllergen),"|")(0)
                            AllergenName = trim( split(arrStrAllergen(indexAllergen),"|")(1))
                            AllergenIcon = split(arrStrAllergen(indexAllergen),"|")(2)
                            AllergenType = split(arrStrAllergen(indexAllergen),"|")(3)
                                    if trim(AllergenType & "") = "Allergen" then    
                                        dim classwillhide  : classwillhide = ""
                                             
                                            
                            %>
                                <li <%=classwillhide %>  onclick="SearchAllergen(this,'Allergen','filter_<%=AllergenID %>')">                                    
                                    <span class="span-icon">                                        
                                        <img  id="filter_<%=AllergenID %>"  width="25" src="<%=SITE_URL %>Images/allergen/png/<%=replace(trim(AllergenIcon & ""),"amber","red") %>" alt="<%=AllergenName %>" title="  <%=AllergenName %>"/>   <br />                                  
                                        <span class="icon-name" style="color:black;"><%=AllergenName %></span>
                                    </span>
                                    
                                </li>
                            <%
                                end if
                        end if
                    next
                     %>
                        
                                
            </ul>
            <%end if %>
       
        </div>
  
     <div class="row row-md-flex"> 
                <% if ucase(EnableSuitableFor & "") = "YES" then %>
                        <div class="col-sm-3 flex-md-auto mb-5">Suitable for:</div>
                        <ul class="eicon-list flex-md-expand col-sm-9 ng-scope list-collapse list-inline" id="suitableforlist">
                <% 
                   
                    for indexAllergen = 0 to ubound(arrStrAllergen)
                        if arrStrAllergen(indexAllergen) & "" <> "" then
                            AllergenID = trim(split(arrStrAllergen(indexAllergen),"|")(0))
                            AllergenName = trim(split(arrStrAllergen(indexAllergen),"|")(1))
                            AllergenIcon = split(arrStrAllergen(indexAllergen),"|")(2)
                            AllergenType = split(arrStrAllergen(indexAllergen),"|")(3)
                                    if trim(AllergenType & "") = "SuitableFor" then      
                            %>
                                <li onclick="SearchAllergen(this,'SuitableFor','filter_<%=AllergenID %>')">
                                    <span class="span-icon">
                                        <img id="filter_<%=AllergenID %>" width="25" src="<%=SITE_URL %>Images/allergen/png/<%=trim(AllergenIcon & "")%>"  alt="<%=AllergenName %>" title="  <%=AllergenName %>" />                                        
                                          <br />    <span class="icon-name" style="color:black;"><%=AllergenName %></span>
                                    </span>
                                     
                                </li>
                            <%
                                end if
                        end if
                    next
                     %>
            </ul>
             <%end if %>
      </div>
     <% end if %>
                 <% if  announcement_Filter & "" <> "" then %>
                <div class="announmentinmenu" style="margin-bottom:20px;"><p><%=replace(replace(announcement_Filter,vbCrLf,"<BR>"),"'","\'")  %></p></div>
            <% end if %>
            </div>     
           
         
            <div class="modal-footer">

               <a href="#"  onclick="ClearFilter();" class="btn btn-primary">Clear Filters</a> 
               <a href="#" data-dismiss="modal" onclick="Filter();" class="btn btn-primary">Continue</a>
            </div>       
        </div>
    </div>
</div>
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
        $("#wholepage").show();
	
    })
</script>

<script src="<%=SITE_URL %>scripts/addtohomescreen.js"></script>
<script>
addToHomescreen();
</script>



<script type="text/javascript">
    var idleTime = 0;
    var idleInterval;
    $(document).ready(function(){  
        if( getCookie("TableNumber") != ''){
            $("#tablenumber").val(getCookie('TableNumber'));
        }

         $("#ClosedModal1 div.modal-body").html('<span style="font-weight:bold;font-size:20px;"> PLACE ORDER </span>');
        $("#ClosedModal1").modal();  
   });
  var pendingReload = 0;
  var reloadCountdownInterval ;

  function initIdleTimeoutReset(){
    //Increment the idle time counter every minute.
     idleInterval = setInterval(timerIncrement, 1000); 

    //Zero the idle timer on mouse movement.
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });
  }
  function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime > 60) { //1 min idle
        clearInterval(idleInterval);
        $("#ResetSessionModal div.modal-body").html('<span style="font-weight:bold;font-size:20px;"> Would you like to continue with your order? <br><br> Time remaining: 10 sec.</span>');
        $("#ResetSessionModal").modal();       
        reloadCountdownInterval = setInterval(resetCountDown, 1000); 
        pendingReload = 10;      
    }
 }  
     function resetCountDown(){
        if(pendingReload==1)
            window.location.href = "<%=SITE_URL %>local/resetsession.asp?r=<%=session("restaurantid") %>";
        pendingReload = pendingReload -1;
   
        $("#ResetSessionModal div.modal-body").html('<span style="font-weight:bold;font-size:20px;"> Would you like to continue with your order? <br><br> Time remaining: ' + pendingReload + ' sec. </span>');
     }
     function PopupRestartOnclick(isRestart){
        if(isRestart)
            window.location.href = "<%=SITE_URL %>local/resetsession.asp?r=<%=session("restaurantid") %>";
        else{
            idleTime = 0;
             clearInterval(reloadCountdownInterval);
            idleInterval = setInterval(timerIncrement, 1000); 

        }
      }
     function StoreToC(obj,cname)
     {
        if($(obj).val() != "" )
        setCookie(cname,$(obj).val(),15);
        
     }
    function setCookie(cname, cvalue, exmins) {
        var d = new Date();
        d.setTime(d.getTime() + (exmins*60*1000));
        var expires = "expires="+ d.toUTCString();
        document.cookie = cname + "=" + cvalue + "; " + expires + ";  path=/";
    }
    function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length,c.length);
        }
    }
    return "";
}
     


  
function createCookie(name, value, days) {
    var expires;
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }
    else expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}

function areCookiesEnabled() {
    var r = false;
    createCookie("testing", "Hello", 1);
    if (readCookie("testing") != null) {
        r = true;
        eraseCookie("testing");
    }
    return r;
}
    var isSetLatLng = false;
    $(document).ready(function(){
    if(!areCookiesEnabled()){
    alert("Your browser does not seem to accept cookies and this can affect your order.  Please ensure that your browser accepts cookies.");
    }

    $("#validate_pc").keydown(function(e) {
          if (e.keyCode == 13) {
                $("#hidLat").val('');
                $("#hidLng").val('');
               $("#updateFullPostcodeSubmit").trigger("click");
            }
          
        });     
     $("#validate_pc").change(function() {
         if(isSetLatLng) isSetLatLng =false;
        else{
             $("#hidLat").val('');
                $("#hidLng").val('');    
        }

          
        });     
    isSetLatLng
    });

    window.onunload = function(){};
</script>



<!-- Begin Login Modal -->

<div id="loginModal" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                ×</button>
                <h4>Login</h4>
                
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="input-user-name">User Name</label>
                    <input type="text" class="form-control" id="input-user-name" placeholder="User Name">
                </div>
                <div class="form-group">
                    <label for="input-password">Password</label>
                    <input type="text" class="form-control" id="input-password" placeholder="Password">
                </div>
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn btn-default">Cancel</a>
                <a href="#" data-dismiss="modal" class="btn btn-primary">Login</a>
            </div>
        </div>
    </div>
</div>
<!-- End Login Modal -->

<!-- Begin reviews Modal -->

<div id="reviewsModal" class="modal fade">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                ×</button>
                <h4>Reviews</h4>
                
            </div>
            <div class="modal-body">
                <div class="product-line "  name="437" parent="0">
                    <!--Menu Item Name-->


                    <div class="product-line__content-left" style="border-top: 0;">
                        <div class="d-flex-center d-flex-start">

                            <div class="product-line__number"> 02.</div>


                            <div class="product-line__description desc ">
                                Prawn Coctail 
                                <div class="rating" style="display:inline-block;">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                </div>


                            </div>
                        </div>
                    </div>


                    <!--Propertyname and Price-->
                    <!--<div style="width:30%;float:left;">-->
                    <!--PropertyName-->
                    <div class="product-line__content-right " style="border-top: 0;">
                        <div class="d-flex-center d-flex-end">
                            <div class="product-line__property-name"></div>

                            <div class="product-line__price"><b>£3.70</b></div>

                        </div>
                    </div>
                    <!--End Add to cart-->


                </div>

                 <div class="product-line " name="437" parent="0">
                    <!--Menu Item Name-->


                    <div class="product-line__content-left">
                        <div class="d-flex-center d-flex-start">

                            <div class="product-line__number"> 02.</div>


                            <div class="product-line__description desc ">
                                Prawn Coctail 
                                <div class="rating" style="display:inline-block;">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                </div>


                            </div>
                        </div>
                    </div>


                    <!--Propertyname and Price-->
                    <!--<div style="width:30%;float:left;">-->
                    <!--PropertyName-->
                    <div class="product-line__content-right ">
                        <div class="d-flex-center d-flex-end">
                            <div class="product-line__property-name"></div>

                            <div class="product-line__price"><b>£3.70</b></div>

                        </div>
                    </div>
                    <!--End Add to cart-->


                </div>

                 <div class="product-line " name="437" parent="0">
                    <!--Menu Item Name-->


                    <div class="product-line__content-left">
                        <div class="d-flex-center d-flex-start">

                            <div class="product-line__number"> 02.</div>


                            <div class="product-line__description desc ">
                                Prawn Coctail 
                                <div class="rating" style="display:inline-block;">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                </div>


                            </div>
                        </div>
                    </div>


                    <!--Propertyname and Price-->
                    <!--<div style="width:30%;float:left;">-->
                    <!--PropertyName-->
                    <div class="product-line__content-right ">
                        <div class="d-flex-center d-flex-end">
                            <div class="product-line__property-name"></div>

                            <div class="product-line__price"><b>£3.70</b></div>

                        </div>
                    </div>
                    <!--End Add to cart-->


                </div>

                 <div class="product-line " name="437" parent="0">
                    <!--Menu Item Name-->


                    <div class="product-line__content-left">
                        <div class="d-flex-center d-flex-start">

                            <div class="product-line__number"> 02.</div>


                            <div class="product-line__description desc ">
                                Prawn Coctail 
                                <div class="rating" style="display:inline-block;">
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                    <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                                </div>


                            </div>
                        </div>
                    </div>


                    <!--Propertyname and Price-->
                    <!--<div style="width:30%;float:left;">-->
                    <!--PropertyName-->
                    <div class="product-line__content-right ">
                        <div class="d-flex-center d-flex-end">
                            <div class="product-line__property-name"></div>

                            <div class="product-line__price"><b>£3.70</b></div>

                        </div>
                    </div>
                    <!--End Add to cart-->


                </div>
            </div>     
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn btn-primary">Close</a>
            </div>       
        </div>
    </div>
</div>
<!-- End reveiws Modal -->
    <script type="text/javascript">
        $(function() {
            var  loadedElements = 0;

            $('.lazy').lazy({
                beforeLoad: function(element){
                    console.log('image  is about to be loaded');
                },
                afterLoad: function(element) {
                    loadedElements++;
 
                    console.log('image  was '  + loadedElements+' loaded successfully');
                },
                onError: function(element) {
                    loadedElements++;             
                    console.log('image could not be ' +loadedElements+' loaded');
                },
                onFinishedAll: function() {
                    console.log('finished loading  elements ' + loadedElements);
                    console.log('lazy instance is about to be destroyed' + loadedElements)
                }
            });

            
        });
        setTimeout(function(){
            $('[data-toggle="tooltip"]').tooltip();
        },1000);
       
    </script>
</body>
</html>
