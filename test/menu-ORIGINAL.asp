<%session("restaurantid")=Request.QueryString("id_r")%>
<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<% 
   



    Dim CurrentURL, CurrentFilename

   If UCase(Request.ServerVariables("HTTPS")) = "ON" Then
        CurrentURL = "https://" & Request.ServerVariables("SERVER_NAME")  &  Request.ServerVariables("URL") 
    Else
        CurrentURL = "http://" & Request.ServerVariables("SERVER_NAME")  &  Request.ServerVariables("URL") 
    End If
    

    CurrentFilename = Right(CurrentURL, Len(CurrentURL) - InstrRev(CurrentURL,"/"))
   
    If UCASE(SITE_URL & CurrentFilename) <> UCASE(CurrentURL) Then
        if Request.ServerVariables("QUERY_STRING")  & "" <> "" then
            CurrentFilename  = CurrentFilename & "?"&  Request.ServerVariables("QUERY_STRING")
        end if
        Response.Redirect(SITE_URL & CurrentFilename)
    End If
   
   
    Set objCon = Server.CreateObject("ADODB.Connection")
        objCon.Open sConnString
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    dim objRdsMainCategory
    Set objRdsMainCategory = Server.CreateObject("ADODB.Recordset") 
    
    Dim vRestaurantId
    vRestaurantId = Request.QueryString("id_r")
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
    dim inmenuannouncement
    sRestaurantLat = ""
    sRestaurantLng = ""
   
    sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
   
    sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))
  
     
     objRds.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & vRestaurantId, objCon


'check opening times
Set objRds2 = Server.CreateObject("ADODB.Recordset") 
objRds2.Open "SELECT *  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeek & " order by DayOfWeek, Hour_From", objCon
'loop through opening time
isopen=false
     dim PreDeliveryOpen 
     PreDeliveryOpen = "false"
dim PreCollectionOpen 
     PreCollectionOpen = "false"
dim Hour_To : Hour_To = 0 
dim PrevStillOpen : PrevStillOpen = false
dim PrevStillLasttime : PrevStillLasttime = 0
    dim googleecommercetrackingcode 
Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
'response.write sHour
   
 if DateDiff("n",objRds2("Hour_From"),objRds2("Hour_To"))<0 then
	if (sHour >= objRds2("Hour_From") and sHour <= "23:59:00")  Then
		isopen=true
          
	end if
 else
	if (objRds2("Hour_From") <= sHour and objRds2("Hour_To") >= sHour) Then
		isopen=true
       
	end if
end if
objRds2.MoveNext    
Loop
 
objRds2.Close
'if it is has found not to be open and time is early morning then check previous days time
if isopen=false and DateDiff("n",sHour,"12:00:00")>0 then

sDayOfWeekprev=sDayOfWeek-1
if sDayOfWeekprev=0 then
sDayOfWeekprev=7
end if

objRds2.Open "SELECT *  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeekprev, objCon
Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
    



 if DateDiff("n",objRds2("Hour_From"),objRds2("Hour_To"))<0 then
   
	if (sHour <= objRds2("Hour_To")) Then
         
		isopen=true
        PrevStillOpen =  true
        if lcase(objRds2("delivery")) = "y" then
           PreDeliveryOpen = "true"
        end if
        if lcase(objRds2("collection")) = "y" then
           PreCollectionOpen = "true"
        end if
        PrevStillLasttime = objRds2("Hour_To")
        
	end if
end if
objRds2.MoveNext    
Loop
end if
   
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
    googleecommercetrackingcode = objRds("googleecommercetrackingcode")
    inmenuannouncement = objRds("inmenuannouncement")
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
	 if objRds("businessclosed")=-1 then
	 response.redirect "closed.asp?id_r=" & vRestaurantId
	 end if
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Menu - <%= objRds("Name")%></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta name="description" content="">
  <meta name="author" content="">
  
  
	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="Scripts/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<!--<link href="css/bootstrap.min.css" rel="stylesheet">-->
    <link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/style.css?v=1.3" rel="stylesheet">
    <link href="css/product.css?v=2.9" rel="stylesheet">
	<link href="css/datepicker.css" rel="stylesheet">
	<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/addtohomescreen.css">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel="shortcut icon" href="<%=FAVICONURL %>" type="image/x-icon" /> <% end If %>
 
 

<meta name="apple-mobile-web-app-title" content="<%= objRds("Name")%>">

<% If ADDTOHOMESCREENURL & "" <> "" Then %>
<link rel="apple-touch-icon-precomposed" sizes="152x152" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="120x120" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="76x76" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=ADDTOHOMESCREENURL %>"
<link rel="apple-touch-icon-precomposed" href="<%=ADDTOHOMESCREENURL %>">

<link rel="apple-touch-icon" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon" sizes="180x180" href="<%=ADDTOHOMESCREENURL %>">
<link rel="apple-touch-icon" sizes="167x167" href="<%=ADDTOHOMESCREENURL %>">

<% end if %>

  <script>
   var alertTime =  false; 
   var individualpostcodeschecking ;
     <% if individualpostcodeschecking = 0 then %>  
      individualpostcodeschecking = false;
      <% else %>
     individualpostcodeschecking = true;

      <% end if %>

  </script>
	<script type="text/javascript" src="Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="Scripts/js.cookie.js"></script>
	
	
	<script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="Scripts/scripts.js"></script>
	
    <script src="Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="Scripts/bootstrap-datepicker.js?v=1" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&libraries=places&language=en-GB&types=address"></script>
	
	
	<link rel="stylesheet" href="scripts/fancybox/jquery.fancybox.css?v=2.1.5" type="text/css" media="screen" />
    <script type="text/javascript" src="scripts/fancybox/jquery.fancybox.pack.js?v=2.1.5"></script>	
        <%' if individualpostcodeschecking = 0 then %>  
    <script src="scripts/Locationpicker.js?v=1.4"></script>
    <%' end if %>
  
	<style media="screen" type="text/css">

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


#modalDivOrderType .modal-dialog
{
    width: 600px !important;
}

#modalDivOrderType .delblock + .delblock
{
    float: right;
}
#modalDivOrderType .delblock
{
    margin-right: 0;
    margin-bottom: 12px;
    margin-left: 0;
    padding: 6px;
    padding-left: 18px;
    padding-left: 20px;
}



#modalDivOrderType #DeliveryDistance,
#modalDivOrderType #DeliveryTime
{
    margin-top: 8px;
}

#modalDivOrderType  #placeOrderContinue
{
    margin-right: 10px;
}

#modalDivOrderType .input-group-btn > .btn
{
    border: 1px solid #999;
    border-left: 0;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}
#modalDivOrderType #fancyBoxMap
{
    padding-top: 12px !important;
    padding-bottom: 8px;
}

#modalDivOrderType #DeliveryTime::after,
#modalDivOrderType .delblock::after
{
    display: block;
    clear: both;

    content: '';
}

#modalDivOrderType #DeliveryTime > .input-group
{
    width: 47% !important;
    margin-right: 15px;
}
#modalDivOrderType #nowlater
{
    margin: 0;
    padding: 3px;
    font-size: 14px;
    padding-bottom: 6px;
}

#modalDivOrderType input[type='radio'],
#modalDivOrderType input[type='checkbox']
{
    position: relative;
    top: 6px;
    width: 18px;
    height: 18px;
    top: 3px;
}


#modalDivOrderType  #ordertimeoverride{
    margin-left:10px;
}
#modalDivOrderType .fa-user,
#modalDivOrderType  .fa-truck{
    margin-right: 10px;
}

</style>

<script>


    
function scrollToV2(id)
{
  // Scroll
  $('html,body').animate({scrollTop: $("#"+id).offset().top-60},'slow');
}
function scrollToV3(id,farTop)
{
  // Scroll
  $('html,body').animate({scrollTop: $("."+id).offset().top - farTop },'slow');
}

  var affixWidth ;
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
    if($("#beforeorder").html() !="")
        scrollToV2("beforeorder");
    else if($("#modalDivOrderTypeBody").html() !="")
        scrollToV2("modalDivOrderTypeBody");
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
        $(window).bind("pageshow", function(event) {
        if (event.originalEvent.persisted) {
          
            window.location.reload() 
        }
    });
    //responsive();
    $(window).resize(function() { responsive(); });
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

<%if  objRds("announcement")<>"" then%>

$("#AnnouncementModal div.modal-body").html('<%=replace(replace(objRds("announcement"),vbCrLf,"<BR>"),"'","\'")%>');
                $("#AnnouncementModal").modal();
				
<%end if%>
	
});


	


function responsive(){
   var winWidth = $(window).width();
     //var winHeight = $(window).height();
   if(winWidth < 992 ) { 

   	//$("#header").addClass("navbar-fixed-top");
  //$("body").css( "padding-top", "80px" );
   $("#divShoppingCartSroll").removeClass("shoppingCartScroll");
  
    }  else {
	//$("#header").removeClass("navbar-fixed-top");
	// $("body").css( "padding-top", "0px" );
     $("#divShoppingCartSroll").addClass("shoppingCartScroll");
	}

    
}




</script>
	
	
	<script>
var nua = navigator.userAgent;
var is_android = ((nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1) && !(nua.indexOf('Chrome') > -1));
if(is_android) {
        $('#bs-example-navbar-collapse-1').removeClass("scrollable-menu");
		

}

</script>

</head>
 <%
     Dim AddressRestaurant : AddressRestaurant =  objRds("Name") & "<br/>" & objRds("Address") &"<br/>Tel. " & objRds("Telephone")
      %>
<body>
  
<input type="hidden" value="<%= lcase(PrevStillOpen & "") %>" name="PrevStillOpen" />
<input type="hidden" value="<%=PrevStillLasttime %>" name="PrevStillLasttime" />
 <input type="hidden" value="<%= lcase(PreDeliveryOpen & "") %>" name="PreDeliveryOpen" />
<input type="hidden" value="<%=lcase( PreCollectionOpen & "")  %>" name="PreCollectionOpen" />
<div class="fake-header" style="display:none;"></div>
<div class="loader"></div>
<div class="container" id="wholepage" style="padding-bottom:100px;display:none;">

	<div class="row clearfix headerbox" id="header">
		<div class="col-md-12 col-xs-12" style="padding-bottom:10px;" id="topmenumobile">
			<div class="media">
				 <a href="#" class="pull-left"><img src="<%= objRds("ImgUrl") %>" width=70 class="media-object" alt="<%= objRds("Name") %>"></a>
				<div class="media-body">
					<h4 class="media-heading">
				
				<div style="float:right;">
				
				<div class="hidden-xs u-display-block">
				<span class="glyphicon glyphicon glyphicon-earphone"></span> <%= objRds("Telephone") %> 
<span class="glyphicon glyphicon glyphicon-envelope"></span>  <%= objRds("Email") %></div>

<div class="visible-xs">


<a href="https://www.google.co.uk/maps?q=<%= objRds("Address") %>" target="_blank"><span class="glyphicon glyphicon-map-marker"></span></a>
<a href="tel:<%= objRds("Telephone") %>"><span class="glyphicon glyphicon-earphone"></span></a>
<a href="mailto:<%= objRds("Email") %>"><span class="glyphicon glyphicon-envelope"></span></a></div>
<div class="block-search-top hidden-xs">
<a class="link-login" data-toggle="modal" data-target="#loginModal" href="!#">Login</a> 

</div>
</div>	
						 <%= objRds("Name") %>
                           <div class="rating" style="display:inline-block;">
                                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                                <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
                            </div>

					</h4><div class="hidden-xs">
                            <b><%= objRds("Address") %> </b><br>
                        </div>


<%= objRds("FoodType") %>
					
			</div>
			</div>
		</div>
		 <%            
            objRds.Close
            
        %>	

	</div>
	<div class="row clearfix">
		<div class="col-md-2" id="categories">
		
		<div data-spy="affix" data-offset-top="60" data-offset-bottom="200">
			<div style="width:165px; height : 450px; overflow : auto; " class="hidden-xs hidden-sm"><ul class="nav nav-stacked nav-pills navdesktop" style="width:155px;overflow : auto;    height: 80vh;">
				<li class="active">
					<a href="#"><b>Categories</b></a>
				</li>
				  <%
                  'objCon.Open sConnString
                objRdsMainCategory.Open "SELECT DISTINCT mc.ID,mc.Name,mc.Description,displayorder FROM MenuCategories AS mc INNER JOIN MenuItems AS mi ON mc.Id = mi.IdMenuCategory WHERE  mc.IdBusinessDetail=" & vRestaurantId & " and (((mi.idbusinessdetail)=" & vRestaurantId & ")) and mi.hidedish<>-1 ORDER BY mc.displayorder;", objCon
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
		<div class="col-md-6half column" id="mainmenu">
			    <ul class="nav nav-stacked nav-pills">
			
				</ul>

<script>
    function SelectLeftategory(ID)
    {
        $("#categroup-" + ID ).hide();
        $("#categroup-" + ID ).show();
        document.location.href = document.location.href.replace(document.location.hash,"") + "#menucat_" +  ID;
    }
</script>
<!-- Begin update html menu bar -->

<div class="menu-bar-wrapper">
<div class="menu-bar">
    <div class="menu-bar__item menu-bar__menu active" onclick="$('#navbar-menu-mobile').slideToggle();$('.js-menu-custom-item').slideUp();">
        <span class="glyphicon glyphicon-align-justify"></span> <span class="menu-text hidden-xs"> Menu</span>
    </div>
    <div class="menu-bar__item menu-bar__search" onclick="$('.js-menu-custom-item').slideToggle('fast');$('#navbar-menu-mobile').slideUp();">
        <span class=" glyphicon glyphicon-search"></span>
        <span class="menu-text hidden-xs">Search</span>
    </div>
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
    <div class="input-group">
    <input type="text" class="search-query form-control" placeholder="Search" />
    <span class="input-group-btn">
        <button class="btn btn-primary" type="button">Search</button>
      </span>
    </div>
</div>

</div>

<!-- End update menu bar -->
            <% if  inmenuannouncement & "" <>"" then %>
            <div class="announmentinmenu"><p><%=inmenuannouncement %></p></div>
            <%end if %>

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
                    SQL =SQL & " mip.allowtoppings AS mipallowtoppings  "
                    SQL =SQL & " FROM  MenuItems AS mi "
                    SQL =SQL & " LEFT JOIN MenuItemProperties AS mip ON mi.Id = mip.IdMenuItem "
                    SQL =SQL & "WHERE    mi.idbusinessdetail =  " & vRestaurantId & "  AND mi.hidedish<>-1 "
                    SQL =SQL & " ORDER BY mi.code,mi.Name,mip.Name; "
                objRds_MenuItem.Open SQL, objCon 
                dim categoryID,CategoryName,CategoryDescription
                
                while not objRdsMainCategory.EOF
                        categoryID = objRdsMainCategory("ID")
                        CategoryName = objRdsMainCategory("Name")
                        CategoryDescription = objRdsMainCategory("Description")
                        %>
                            <div class="categroup-<%=categoryID %> "></div>
                            <div class="product-line-heading clearfix" onclick="ShowdishpropertiesV2('categroup-<%=categoryID %>')">
                            <h4 class="product-line-heading__cat pull-left" >
                            <a id="menucat_<%=categoryID %>" name="menucat_<%=categoryID %>" ></a>
                            <%= CategoryName%>   
                            </h4>
                            
                            <div class="product-line-heading__icon-wrapper is-vertical-center">
                                <img class="product-line-heading__icon" src="images/menu-category-collapse--retina.png" alt="" id="imgcategroup-<%=categoryID %>">
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
                                   Vegetarian = objRds_MenuItem("Vegetarian")
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

                              
                                <div class="product-line <%=class_noborder %>" name="<%=vMenuItemId %>" <%=parent %>>
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
                                                        <img src="Images/<%=vRestaurantId %>/<%= objRds_MenuItem("Photo")%>" class="img-rounded" alt="<%= MenuItemName%>" style="vertical-align: top;width:30px;max-width:40px;" /> 
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
                                             

                                            <div class="product-line__description desc ">
                                            <%=MenuItemName %>
                                            <%If Vegetarian Then %>
                                                <img src="Images/veggie_small.png" alt="veggie" />
                                            <%End If %>

                                            

                                            <%If Spicyness> 0 Then %>
                                                <img src="<%= "Images/spicy_" & Spicyness & ".png"%>" alt="spicy" />
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
                                        <div class="product-line__content-right ">
                                        <div class="d-flex-center d-flex-end">
                                        <div class="product-line__property-name"><%=PropertyName %></div> 

                                         <% donotshowprice="n"
								            dishpropertiestext=""
								            pricefrom=0
								        ' code to check if other dish properties are applicable to this product
								        if dishpropertygroupid & "" <>"" then%>
								        <%
								        'Set objCon_properties = Server.CreateObject("ADODB.Connection")
								        Set objRds_properties = Server.CreateObject("ADODB.Recordset") 
          
								        'objCon_properties.Open sConnString
                                            objRds_properties.Open "SELECT * FROM MenuDishpropertiesGroups where id in (" & dishpropertygroupid & ")", objCon
				                            While NOT objRds_properties.Eof 
                                                dishpropertiestext =  dishpropertiestext & "<div class=""dishproperties__title"">" & objRds_properties("dishpropertygroup") & " </div> <select name=""" & objRds_properties("id") & """ id=""" & objRds_properties("id") & """ class=""form-control"" data-group=""dishproperties" & vMenuItemId & "-" & PropertyId & """"
                                            if objRds_properties("dishpropertyrequired")<>-1  then
                                                dishpropertiestext = dishpropertiestext & " data-required=""n"">"
                                                dishpropertiestext = dishpropertiestext & "><option value=""0"">-- select --</option>"
                                            else
                                                dishpropertiestext = dishpropertiestext & " data-required=""y"" data-caption=""Please choose " & replace(objRds_properties("dishpropertygroup"),"""","") & """>"
                                                dishpropertiestext = dishpropertiestext & "><option value=""0"">-- select --</option>"
                                            end if
						
								                'Set objCon_propertiesitems = Server.CreateObject("ADODB.Connection")
								                Set objRds_propertiesitems = Server.CreateObject("ADODB.Recordset") 
								                'objCon_propertiesitems.Open sConnString
                                                SQL = "SELECT * FROM MenuDishproperties where dishpropertygroupid=" & objRds_properties("id") & " order by dishpropertyprice"
                                                objRds_propertiesitems.Open SQL, objCon
				                               
				                                While NOT objRds_propertiesitems.Eof 
				                                    add=""
				                                    if objRds_properties("dishpropertypricetype")="add" then
				                                        add=" - add "
				                                    else
				                                        donotshowprice="y"
				                                        if pricefrom & "" = "0" or pricefrom & "" = ""  then
					                                        pricefrom=objRds_propertiesitems("dishpropertyprice")
				                                        end if
				                                    end if
				                                    dishpropertiestext = dishpropertiestext & "<option value=""" & objRds_propertiesitems("id") & """>" & objRds_propertiesitems("dishproperty") & add & " " &  CURRENCYSYMBOL & FormatNumber(objRds_propertiesitems("dishpropertyprice"),2) & "</option>"
				    		                        objRds_propertiesitems.MoveNext
							                    wend 
                                            dishpropertiestext = dishpropertiestext & "</select><br>"
						                    objRds_properties.MoveNext
                                            wend 
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
                                          '  Response.Write("miallowtoppings " & miallowtoppings & " mipallowtoppings " & mipallowtoppings)
                                        Set objRds_toppings_Group = Server.CreateObject("ADODB.Recordset")  
                                            SQL = "select ID,toppingsgroup from Menutoppingsgroups where IdBusinessDetail = " &   vRestaurantId & " and ID in (" &listtoppinggroupid& ")"       
                                            
                                            objRds_toppings_Group.Open SQL, objCon
                                        while not objRds_toppings_Group.EOF 
                                                Set objRds_toppings = Server.CreateObject("ADODB.Recordset")           
                                                    SQL = "SELECT id,topping,toppingprice FROM MenuToppings where  IdBusinessDetail=" & vRestaurantId                                               
                                                    SQL =SQL & " and toppinggroupid=" & objRds_toppings_Group("ID")                                               
                                                objRds_toppings.Open SQL, objCon
                                                dishtoppingstext =  "<div class=""dishproperties__title"">" & objRds_toppings_Group("toppingsgroup") & " </div> "
                                                While NOT objRds_toppings.Eof 
                                                    dishtoppingstext = dishtoppingstext &  "<input type=""checkbox"" class=""topping"" name=""" & objRds_toppings("topping") & """ value=""" & objRds_toppings("id") & """ data-group=""toppings" & vMenuItemId & "-" & PropertyId & """> " & objRds_toppings("topping") & " - " & CURRENCYSYMBOL & FormatNumber(objRds_toppings("toppingprice"),2) & "<BR>"
								                    objRds_toppings.MoveNext
                                                wend 
                                                    objRds_toppings.close()
                                                set objRds_toppings = nothing
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
                                        <div  class="col-md-6 col-sm-6 desc">
					                    <%if dishpropertiestext<>"" then%>
                                            <div class="dishproperties__heading">
					                            <b>Dish Options</b>
                                            </div>
					                        <%=dishpropertiestext%>
					                    <%end if%>
					                    </div>
					                    <div  class="col-md-5  col-sm-5 desc">
					                        <%if dishtoppingstext<>"" then%>
                                                    <div class="dishproperties__heading">    
					                                <b>Toppings</b>
                                                    </div>
					                                <%=dishtoppingstext%>
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
		
	

	<div id="rightaffix" <%if STICK_MENU="Yes" then%>data-spy="affix" data-offset-top="300" data-offset-bottom="200"<%end if%>>
<div class="panel panel-primary"  id="basket"  >
  <div class="panel-heading">
    <h3 class="panel-title"><span class="glyphicon glyphicon glyphicon-shopping-cart"></span> Your Order</h3>
  </div>
  <div class="panel-body" style="padding:15px 8px 15px 8px;" id="footerbasket">
   
                         

                        <form id="CheckOutForm" action="CheckOut.asp?id_r=<%=vRestaurantId%>" method="post">                
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
                        <input type="hidden" id="isChangeExistingAddress"  name="isChangeExistingAddress" value="N" />
                   </form>
                        <div id="shoppingcart"></div>                        
          

                                   
                    
  </div>

    <div id="divVoucherCode" style="display:none;padding:0px 8px 15px 8px;">
     <button type="button" class="btn btn-xs btn-block" id="vouchercodeshow" style="background-color:#eeeeee;color:#7d7c7c  ;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Voucher Code</button>
	<button type="button" class="btn  btn-xs btn-block" id="vouchercodehide"  style="display:none;background-color: #eeeeee;color:#7d7c7c  ;"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span> Close</button>
	
    <div class="panel panel-default" style="display:none;" id="divVoucherCode1" >
  <!--<div class="panel-heading"  >
          <h3 class="panel-title" style="font-size:15px;">Voucher code</h3>
  </div>-->
        <div class="panel-body">           
                        
						
						
						<div class="row">
  <div class="col-xs-7">
  
    <label class="sr-only" for="vouchercode">Enter Code</label>
    <input type="text" class="form-control noSubmit" id="vouchercode" name="vouchercode" placeholder="Enter code">
  </div> <div class="col-xs-3">
  
   
  
   <button  class="btn btn-default" onclick="VoucherCode();">Submit</button>
 </div>
 
 <div class="col-xs-1">&nbsp;</div>
 
              
                    </div>
    </div>
    <div id="divVoucherCodeAlert" style="margin: 1px auto;text-align: center;color:red;"> </div>
 </div>
        </div>
      <div id="divFancyMap" style="width:100%; height:80%; display:none; position: absolute;">
                <fieldset class="gllpLatlonPicker" id="gllpLatlonPicker1">
                    <p style="display:block;text-align:center">Type a location name or mark it on the map:</p>
           
                    <input type="text" style="display:block;margin:3px auto;width:80%;max-width:400px;" class="gllpSearchField pac-input" id="txtFancySearch" />
                    <input type="button" style="display:block;margin:10px auto;background-color:#FEC752;border-color:#FEC752;" class="btn btn-default gllpSearchButton" value="Search" />            
            
                    <div class="gllpMap">Google Maps</div>
                    <div style="width:100%;text-align:center;">
                    <span style="display:block;" id="spnLocationAddress"></span>
                    <input type="button" style="margin:10px auto;background-color:#FEC752;border-color:#FEC752;" class="btn btn-default" value="Mark my coordinates" onclick="CloseMap(true);" />
                    <input type="button" style="margin:10px auto;background-color:#fedf9a;border-color:#fedf9a;" class="btn btn-default" value="Cancel" onclick="CloseMap(false);" />
                        </div>
                    <input type="hidden" readonly class="gllpLatitude" value="20" />
                    <input type="hidden" readonly  class="gllpLongitude" value="20" />
                    <input type="hidden" readonly  class="gllpZoom" value="3" />
            
                </fieldset>


             </div>   
    <div class="panel panel-default" id="beforeorder" >
          <div class="panel-heading" style="color: #fff;background-color: #94b604;border-color: #94b604;">
            <h3 class="panel-title"><span class="glyphicon glyphicon-time"></span> Order Type</h3>
          </div>
          <div class="panel-body" style="padding:10px;">
						        <div class="delblock" <%if disabledelivery="Yes" then%>style="visibility:hidden;"<%end if%>>						
						         <div style="float:left;padding:5px 3px 0 3px;"> <i class="fa fa-truck fa-2x"></i></div>
						 
						         <div style="line-height: 14px;">
						
						
                                  <input type="radio" name="orderTypePicker" value="d" <%if disabledelivery="Yes" then%>disabled<%end if%>  <%if disablecollection="Yes" and disabledelivery<>"Yes" then%> checked<%end if%>/> Delivery<br>
						  
						          <span style="font-size:0.8em;">Approx: <span style="color: red"><%= sAverageDeliveryTime%>min</span></span>
                           </div>
						
						        </div><div class="delblock" <%if disablecollection="Yes" then%>style="visibility:hidden;"<%end if%>>
						
						        <div style="float:left;padding:5px 3px 0 3px;"> <i class="fa fa-user fa-2x"></i></div>
						
						
						         <div style="line-height: 14px;"><input type="radio" name="orderTypePicker" value="c"  <%if disablecollection="Yes" then%>disabled<%end if%> <%if disabledelivery="Yes" and disablecollection<>"Yes" then%> checked<%end if%>/> Collection<br>

						          <span style="font-size:0.8em;"> Approx:&nbsp;<span style="color: red"><%= sAverageCollectionTime%>min</span>
                           </div>
						        </div>
						
                       
					         <div class="hidepanel" id="nowlater"> 
					          <div align="center">  <input type="radio" name="ordertimeoverride" id="ordertimeoverride" value="n" checked> Now /   <input type="radio" id="ordertimeoverride" name="ordertimeoverride" value="l" <%if sorderdisablelater=-1 then%>disabled<%end if%>> Later </div>

                                  </div>
					            <div id="DeliveryTimeNowD" class="hidepanel alert alert-warning" style="text-align:center;display:none;padding:7px;" >
                                </div>
                                <div id="DeliveryTimeNowC" class="hidepanel alert alert-warning" style="text-align:center;display:none;padding:7px;" >
                                </div>
                                 <div id="DeliveryTime" class="form-group hidepanel" style="text-align:center;" >
                                    <label for="control-label">
                                        <%if disabledelivery="Yes" then%>Collection<%else%>Delivery<%end if%> Time *</label>
									        <div class="clearfix"></div>
									        <div class="input-group" style="width:130px;float:left;">
	                                        <%if ordertodayonly=-1 then%>
                                                <div id="OrderDate"  data-date="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" data-date-weekStart="1" data-date-format="dd/mm/yyyy">
                                                <div class="input-group">
                                             <input size="11" type="text"  value="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" id="OrderDateBox" class="  form-control" style="padding-left:3px;" disabled="disabled" onload="javascript:document.getElementById('OrderDateBox').disabled = true;" />
  
                                               </div>
                                            <%else%>
                                              <div id="OrderDate"  data-date="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" data-date-weekStart="1" data-date-format="dd/mm/yyyy">
                                                <div class="input-group">
                                                 <input size="11" type="text"  value="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" id="OrderDateBox" class="  form-control" style="padding-left:3px;"/>
                                                   <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                   </div>
                                           <%end if%>
                                                </div>
                                              </div>
									
                                    
                          	        <div class="visible-md"><br><br></div>       
                                        <select name="p_hour" style="padding: 0; width: 51px;float:left;vertical-align:middle;" class="form-control">
                                            <option value="0">00</option>
                                            <option value="1">01</option>
                                            <option value="2">02</option>
                                            <option value="3">03</option>
                                            <option value="4">04</option>
                                            <option value="5">05</option>
                                            <option value="6">06</option>
                                            <option value="7">07</option>
                                            <option value="8">08</option>
                                            <option value="9">09</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                            <option value="13">13</option>
                                            <option value="14">14</option>
                                            <option value="15">15</option>
                                            <option value="16">16</option>
                                            <option value="17">17</option>
                                            <option value="18">18</option>
                                            <option value="19">19</option>
                                            <option value="20">20</option>
                                            <option value="21">21</option>
                                            <option value="22">22</option>
                                            <option value="23">23</option>
                                        </select>
                                        <select name="p_minute" style="padding: 0; width: 51px;float:left;vertical-align:middle;" class="form-control">
                                            <option value="0">00</option>
                                            <option value="5">05</option>
                                            <option value="10">10</option>
                                            <option value="15">15</option>
                                            <option value="20">20</option>
                                            <option value="25">25</option>
                                            <option value="30">30</option>
                                            <option value="35">35</option>
                                            <option value="40">40</option>
                                            <option value="45">45</option>
                                            <option value="50">50</option>
                                            <option value="55">55</option>
                                        </select>                           
                                    </div>
						
						        <div id="DeliveryDistance" class="control-group row-fluid hidepanel">
                                     <div id="PreFillDistance" class="hidepanel alert alert-success" style="text-align:center;display:none;padding:7px;font-size: 11px;" >
                                         Last Delivery Address: <%= Request.Cookies("validate_pc") %> If you use the same address please continue.
                                         Otherwise Change Address.
                                </div>
                                    <form id="updateFullPostcode" class="">													
                                    <p class="delPostcodeLabel text-centered">
                                        <strong>Delivery Postcode:</strong>
                                    </p>
                                    <p style="margin-left: 33px;" class="text-centered">
							
							    <div class="input-group" id="input-group-pc">    
                                <%  dim UserAddress
                                        UserAddress = ""
                                    %>
                                <input type="text" class="form-control clearable" value="" name="validate_pc" id="validate_pc">
                                <input type="hidden" readonly name="hidLat" id="hidLat" />
                                <input type="hidden" readonly name="hidLng" id="hidLng" />
                                <input type="hidden" readonly name="hidFormattedAdd" id="hidFormattedAdd" />
                                <input type="hidden" readonly name="hidPostCode" id="hidPostCode" />                                          
	                            <span class="input-group-btn"><button class="btn btn-default btngreen" type="button" onclick="CheckDistance();" data-placement="top" title="Remember to Check your address" id="updateFullPostcodeSubmit" >Check</button></span>
                                <script>
                                <% if UserAddress & "" <> "" Then %>
                                    $(document).ready(function(){
                                     var geocoder = new google.maps.Geocoder();
                                        geocoder.geocode({"address":'<%=Replace(UserAddress ,"'","")%>' }, function(results, status) {
                                            if (status == google.maps.GeocoderStatus.OK && results[0]) {
                                                //do nothing
                                            }
                                            else { 
                                               if('<%= Request.Cookies("Postcode") %>' != '' )
                                                    $("#validate_pc").val('<%= Request.Cookies("Postcode") %>' );
                                                } 
                                    });
                                    });
                            <% end if %>
                                // CLEARABLE INPUT
                        function tog(v){return v?'addClass':'removeClass';} 

                        $(document).on('input', '.clearable', function(){
                            $(this)[tog(this.value)]('x');
                        }).on('mousemove', '.x', function( e ){
                            $(this)[tog(this.offsetWidth-18 < e.clientX-this.getBoundingClientRect().left)]('onX');
                        }).on('touchstart click', '.onX', function( ev ){
                            ev.preventDefault();
                            $(this).removeClass('x onX').val('').change();
                        });

                                    $(".clearable").trigger("input");
                            </script>
                                </div>
                                <div class="pick-a-location">
                 <a id="aUseCurrentLoc" style="display:none;padding-top:5px;" class="text-centered"  href="#"><img src="images/current-position.png" style="height: 15px;">Use current location</a>
                 <% if individualpostcodeschecking = 0 then %>    <a id="fancyBoxMap" style="display:block;padding-top:5px;" class="fancybox text-centered"  data-popup="#divFancyMap" href="#divFancyMap"><img src="images/picklocation.png" style="height: 15px;"> Pick a Location </a> <% End If %>
          
            </div>
		                        <div id="showdistance" align="center" style="clear:both;"></div>					
			                    <div class="delivery_info alert alert-danger" style="display:visible;" id="delivery-info">    
                                        <span id="df">Delivery Charge: <%=CURRENCYSYMBOL%><span id="delivery_fee"><%=sDeliveryFee%><%if sDeliveryFreeDistance>0 then%> for over <%=sDeliveryFreeDistance%> <%=mileskm%>.<%end if%></span></span><br />
								        Max. delivery distance: <%=sDeliveryMaxDistance%> <%=mileskm%><br>
								        <%if sDeliveryFreeDistance>0 then%>Free delivery up to: <%=sDeliveryFreeDistance %> <%=mileskm%><br><%end if%>
								        <% if sDeliveryChargeOverrideByOrderValue <> 1000000000 Then %>Free delivery for orders over <%=CURRENCYSYMBOL%><%=sDeliveryChargeOverrideByOrderValue%><br> <%end if %> 
				                        Minimum Order: <%=CURRENCYSYMBOL%><%= sDeliveryMinAmount %>		
                                    </div>
                                </form>
                                   <div class="alert alert-danger" id="missingPostcodeAlert" style="display:none;margin: 2px 8px 2px 2px;"><span style="color:#49cb29;font-weight:bold;">Check</span> delivery is available, then click <span style="color:#49cb29;font-weight:bold;">Checkout</span> to continue</strong><br></div>
                                   <div class="alert alert-danger" style="margin: 2px 8px 2px 2px;" id="missingPostcodeAlert2">We don't deliver to that postcode.</div>
                                   <div class="alert alert-danger" id="missingPostcodeAlert3" style="margin: 2px 8px 2px 2px;">Postcode must contain a space.</div>
                                </div>
						        <div class="clear-both"></div>
                      <div id="CollectionAddress" class="hidepanel alert alert-success" style="clear:both;text-align:center; padding: 7px; font-size: 11px; display: none;margin: 8px 8px 2px 2px;" data-original-title="" title=""><span style="font-weight: bold;"><span style="color:red;">Collect from:</span><br/> <%=AddressRestaurant %></span></div>
                                                                              
                     
          </div>
                                
        </div>
         <p class="text-centered" id="btnPlaceOrder" style="display:none;">
        <button type="button" onclick="CheckOrder('confirm');" class="btn btn-success" style="width: 160px; padding: 8px">
        Checkout</button><br>
		<br>
    </p>
</div>
<div class="panel panel-danger" >
  <div class="panel-heading"  >
          <h3 class="panel-title">Opening Hours</h3>
  </div>
        <div class="panel-body">           
                        <table border="0" width="100%" id="openninghours">
                            <% 
                        
                        objRds.Open "SELECT oi.* " & _
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
                             
                            if jsDate <> "" Then jsDate = jsDate & ","
                            jsDate = jsDate & jscnt & ": { min:Date.parse('01/01/2011 " & FormatDateTime(objRds("Hour_From"), vbShortTime) & "'),  max: Date.parse('01/01/2011 " & FormatDateTime(objRds("Hour_To"), vbShortTime) & "'), d:'" & objRds("DayOfWeek") & "', delivery:'" & objRds("delivery") & "', collection:'" & objRds("collection") & "',minacceptorderbeforeclose:" & tempminacceptorderbeforeclose &"}"
                                dim isavailable : isavailable ="y"
                                if objRds("collection")="n" and objRds("delivery")="n" then
                                            isavailable = "n"
                                end if
                          %>
                            <tr name="nameopentime" <% if objRds("DayOfWeek") = Weekday(DateAdd("h",houroffset,now), vbMonday)  then %> style="font-weight:bold;" <% end if %> nameopentime="<%=objRds("DayOfWeek") %>" available="<%=isavailable %>">
                                <td style="width: 30px">
								<%if currentdayofweek<>objRds("DayOfWeek") then%>
                                    <%= WeekdayName(objRds("DayOfWeek"), false, vbMonday) %>
									<%end if%>
                                </td>
                                <td>
                                  <div align="right"> <%if objRds("collection")="n" then%><img src="Images/no-collection.gif" width="18" data-toggle="tooltip" data-placement="left" title="Collection is not available during this time slot"></i> <%end if%> <%if objRds("delivery")="n" then%><img src="Images/no-delivery.gif" width="18" data-toggle="tooltip" data-placement="left" title="Delivery is not available during this time slot"></i> <%end if%> <%= FormatDateTime(objRds("Hour_From"), vbShortTime) %>
                                    - <%= FormatDateTime(objRds("Hour_To"), vbShortTime)  %></div>  <%' objRds("minacceptorderbeforeclose") & "|" & ISNULL(objRds("minacceptorderbeforeclose")) & "|" & (objRds("minacceptorderbeforeclose") & "" = "") & "|" & tempminacceptorderbeforeclose %>
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
                        objCon.Close
						
                            %>
                        </table>
                    </div>
    </div>
	<%=menupagetext%>
	
</div>
	</div>
	</div>
	
</div>

 

<script type="text/javascript">
   
        // process for product line no border 
    $(".no-border").each(function(){
        $("[name='" +$(this).attr("name")+ "']").addClass("no-border");
    });
    $(".no-border").filter("[parent='0']").each(function(){
        var obj =   $(this).find(".product-line__content-right").clone();
        var newline = '<div class="product-line  no-border" fishversion="true">';
                
                $(newline +  $(obj).wrapAll('<div class="abc">').parent().html() + "</div>").insertAfter(this);
                $(this).find(".product-line__content-right").remove();
                $(this).find(".product-line__content-left").removeClass("product-line__content-left").addClass("product-line__content");
    });
    $("[fishversion=true]").find(".product-line__content-right").css("border-top","none");
    function CategorySelection(ID)
    {
        $("[data-type='group-cate']").each(function(){
            $(this).hide();
            $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
        });
        $("#" + ID).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
        //  scrollToV2(ID);
        $("#" + ID).slideDown("slow");

    }
    $("#vouchercodeshow").click(function(){
        $("#divVoucherCode1").show();
        $("#vouchercodeshow").hide();
        $("#vouchercodehide").show();
    });

    $("#vouchercodehide").click(function(){
        $("#divVoucherCode1").hide();
        $("#vouchercodeshow").show();
        $("#vouchercodehide").hide();
    });
    $(function(){
        $("input.noSubmit").keypress(function(e){
            var k=e.keyCode || e.which;
            if(k==13){
                e.preventDefault();
            }
        });
    });
    var ExpectedtimeD ="";
    var ExpectedtimeC ="";
    var currenttime  =  new Date();

    currenttime = currenttime.getHours() + ":" + currenttime.getMinutes();
    //currenttime = Date.parse('01/01/2011 ' + currenttime) + <%=(houroffset * 60) - Application("ServerGMTOffset") - DSTMinute%>  * 60000;    
    currenttime = Date.parse('01/01/2011 ' + currenttime) ; 
    var CurrentDate = 1;
    var jsDate = {
        <%=jsDate %>
        };
    var myDays= ["Monday","Tuesday","Wednesday",
        "Thursday","Friday","Saturday","Sunday"]

    function ReloadShop() {
		
        $("#shoppingcart").load("ShoppingCart.asp?id_r=<%= vRestaurantId %>"); 
	                
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
            $("#shoppingcart").load("ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=add&mi=" + mi + "&mip=" + mip + "&toppingids=" + toppingschosen + "&dishproperties=" + dishproperties,function(){
               
                $(obj).find("span:eq(1)").hide();
                $(obj).find("span:eq(0)").show();
            });
        }
 
    }
		
	

    function Del(itemId) {
	
        $("#shoppingcart").load("ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=del&id=" + itemId);

    }
		
    function Showdishproperties(itemtoshow) {
	
        $("#" + itemtoshow).slideToggle();
           
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
		   

    function VoucherCode() {
	
	
        $("#shoppingcart").load("ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=vouchercode&vouchercode=" + $('#vouchercode').val());
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
                if(response.rows[0].elements[0].status == "OK")
                    CheckDistanceLatLng( parseFloat(response.rows[0].elements[0].distance.value/1000).toFixed(2) );
                else
                    CheckDistanceLatLng(100000);
                
        });        
           
    }

    function CheckDistance() {
           
        $("#updateFullPostcodeSubmit").tooltip("destroy");  
        $('#beforeorder').css('border-color', '#E9EAEB');

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
                    $("#delivery-info").html("Great! Continue ordering");
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
                $("#delivery-info").html("Great! Continue ordering");
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
    zipcode =  zipcode.replace(/\+/gi, " ");
    $('.delivery_info').hide();
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
            $("#delivery-info").html("Great! Continue ordering");
            $('.delivery_info').addClass('alert-success');
        } else {
            $('input[name=deliveryDistance]').val("");
            $("#missingPostcodeAlert").hide();
            $("#missingPostcodeAlert3").hide();
            $("#missingPostcodeAlert2").show();	
        }
    } else {
        $('input[name=deliveryDistance]').val("");
        $("#missingPostcodeAlert").hide();
        $("#missingPostcodeAlert2").hide();
        $("#missingPostcodeAlert3").show();	
    }
			
			
			
						
			
    <%end if%>
                                       
    }
	function CheckCollectionTime() {
         var offsetmins,OpenTime,isEarly,AcceptOrderBeforeClosing;
    isEarly = 0;
    
    if ($("input[name='orderTypePicker']:checked").val() == 'd') {
        $("#CollectionAddress").hide();
        offsetmins=$('#deliverydelay').val();
    } else {
        offsetmins=$('#collectiondelay').val();
    }
        var CurrentDate, PlaceOrderDate;
        CurrentDate = new Date();
    var curDay,curMonth,curYear;
        curDay = CurrentDate.getDate();
        curMonth = CurrentDate.getMonth() ;
        curYear = CurrentDate.getFullYear();
     var currentDatetime  =  Date.parse('01/01/2011 ' + CurrentDate.getHours() + ':' + round5(CurrentDate.getMinutes()))

    var s_time1;
    var dt = $("#DeliveryTime");
        var isAcceptOrder = false;
         if(GetOrderAcceptFor(currenttime,CurrentDate.getDay(),"c") >= 0 && $("input[name='ordertimeoverride']:checked").val() =="n")
    {
                $("select[name=p_hour]", dt).val(CurrentDate.getHours());
                $("select[name=p_minute]", dt).val(round5(CurrentDate.getMinutes()));
             var HourCurrent = CurrentDate.getHours();
                var MinuteCurrent = CurrentDate.getMinutes();
                if(MinuteCurrent>57){
                    HourCurrent = HourCurrent  + 1;
                }
                MinuteCurrent =  round5(MinuteCurrent);    
                $("select[name=p_hour]", dt).val(HourCurrent);
                $("select[name=p_minute]", dt).val(MinuteCurrent);

            isAcceptOrder =  true;
    }
    var _sTime = $("select[name=p_hour]", dt).val() + ":";
    boxdate2=("0" + ($("select[name=p_minute]", dt).val())).slice(-2)
    _sTime  += boxdate2;
    s_time1 = _sTime;
    _time = Date.parse('01/01/2011 ' + _sTime);
         if(_time - currentDatetime == 0)
    {
                minuteCDefault = 0;
    }
    /*else if(_time - currentDatetime <= offsetmins)
                minuteCDefault = offsetmins;
                */

    var parts = $("#OrderDate input").val().split('/');
    var _date =  new Date(parts[2], parts[1]-1, parts[0]);
        CurrentDate = new Date(curYear,curMonth,curDay);
        PlaceOrderDate = _date;
    var days = _date.getDay();
        //if($("input[name='orderTypePicker']:checked").val() == "c" && $("[name=PreCollectionOpen]").val()=="true"){
            if(days==0) days=7;
        //days = days -1    
        // }
    var key;
    if (days == 0) days = 7;
    isopen=0;
    nocollection=0;
   
   // if($("[name=PreCollectionOpen]").val()=="false"){
            for (key in jsDate) {
                if (jsDate[key].d==days ) {
        /* if (jsDate[key].max<jsDate[key].min) {
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
} else {*/
			                        var maxTime1 = jsDate[key].max;
                                    if(maxTime1 < jsDate[key].min)
                                        maxTime1 = jsDate[key].max + 24 * 60 * 60000;
                                    if(nocollection == 0 && jsDate[key].min <= _time &&  maxTime1  >= _time && CurrentDate.getTime() <  PlaceOrderDate.getTime() )
                                    {
                                                    if((jsDate[key].min + offsetmins * 60000) > _time){
                                                           OpenTime = new Date();
                                                            OpenTime.setTime(jsDate[key].min + offsetmins * 60000); 
                                                            isEarly = 1;   
                                                        }else{
                                                                OpenTime = new Date();
                                                                OpenTime.setTime(_time ); 
                                                        }
                                                    
                                                    //isEarly = 1;
                                                    if (jsDate[key].collection=='n') 
                                                       nocollection=1;
                                                    isopen = 1;
                                    }    
                                    else if(nocollection == 0 && currenttime <  jsDate[key].min && jsDate[key].min <= _time &&  maxTime1 >=_time && _time >= jsDate[key].min + offsetmins * 60000 )
                                    {
                                                      OpenTime = new Date();
                                                      OpenTime.setTime(_time ); 
                                                      if (jsDate[key].collection=='n') 
                                                          nocollection=1;
                                                      isopen = 1;
                                    }
                                    else if (nocollection == 0 && jsDate[key].min <= _time &&  maxTime1  >= (_time + (offsetmins * 60000) - minuteCDefault) ) {
                                                if((jsDate[key].min + offsetmins * 60000 - minuteCDefault) > _time){
                                                            OpenTime = new Date();
                                                            OpenTime.setTime(jsDate[key].min + offsetmins * 60000 - minuteCDefault); 
                                                            isEarly = 1;
                                                 }
                                                    if (jsDate[key].collection=='n') {
                                                        nocollection=1;
                                                    }
                                                isopen=1;
                                    }
                                    else if(nocollection ==0 && jsDate[key].minacceptorderbeforeclose >= 0  )
                                    {
                                                        if((maxTime1 - jsDate[key].minacceptorderbeforeclose * 60000) >= _time && jsDate[key].min < _time){
                                                            if (jsDate[key].collection=='n') {
                                                                nocollection=1;
                                                            }
                                                            isopen = 1;  
                                                        }
                                    }
        // }
    }
    }
   // }
        //second check
    if (isopen==0 && _time <= Date.parse('01/01/2011 12:00')) {
            dayprev=days-1;
            if (dayprev==0) {
            dayprev=7;
    }
            for (key2 in jsDate) {
                    if (jsDate[key2].d==dayprev && jsDate[key2].collection=="y") {
                                    if ( jsDate[key2].max<jsDate[key2].min ) {
                                            
                                         var maxTime1 = jsDate[key2].max;
                                        if(maxTime1 < jsDate[key2].min){
                                            maxTime1 = jsDate[key2].max + 24 * 60 * 60000;
                                            var maxdatetime = new Date();
                                                maxdatetime.setTime(maxTime1);
                                                var maxday = maxdatetime.getDate();
                                                var maxMonth = maxdatetime.getMonth()+1;
                                                var maxYear = maxdatetime.getFullYear();
                                                var _timeMew = new Date();
                                                _timeMew.setTime(_time);
                                                var timeHour = _timeMew.getHours();
                                                var timeminute = _timeMew.getMinutes();
                                                _time = Date.parse(maxMonth  + '/' +maxday+ '/' +maxYear+ ' ' + timeHour+':' + timeminute);
                                         }
                                        if(CurrentDate.getTime() <  PlaceOrderDate.getTime() && _time <= maxTime1  )
                                        {
                                                                    if (jsDate[key2].collection=='n') {
                                                                        nocollection=1;

                                        }
                                                                    isopen=1;
                                        }
                                        else  if ( (_time + (offsetmins *60000) - minuteCDefault) <= maxTime1) {
                                                if (jsDate[key2].collection=='n') {
                                                    nocollection=1;

                                                    }
                                            isopen=1;
                                        }
                                         else if(nocollection ==0 && jsDate[key2].minacceptorderbeforeclose >= 0  )
                                        {
                                            if((maxTime1 - jsDate[key2].minacceptorderbeforeclose * 60000) >= _time && jsDate[key2].min < _time){
                                                if (jsDate[key2].collection=='n') {
                                                     nocollection=1;
                                                }
                                                isopen = 1;  
                                            }
                                        }
                                    }				
                    }
            }			
    }
   
    var delivery_type  = $("input[name='orderTypePicker']:checked").val();
    if (nocollection==1 && delivery_type=='c' ) {

        $("#timeslotModal2").modal();
	
    return false;
    }	
        //if(!jsDate[days])
    if(!lookupdayinarray(jsDate,days))
    {
			
        $("#ClosedModal div.modal-body").html('Sorry, On ' + myDays[days-1] + ' we are closed.');
        $("#ClosedModal").modal();
        return false;
    } 
    else if(isopen==0)
    {
        if(isAcceptOrder == true)
        {
                    var date1 = new Date("01/01/2011 " + _sTime);
                    var s_date1 = date1.getTime() + offsetmins * 60000;
                    var dt2 =  new Date();
                    dt2.setTime(s_date1);
                    _sTime = dt2.getHours() + ":" + dt2.getMinutes();
        }
        $("#ClosedModal div.modal-body").html('Sorry, On ' + myDays[days-1] + ' at ' + ("0" + _sTime).slice(-5) + '  we are closed.');
        $("#ClosedModal").modal();
        return false;
    }
     var form = $("#CheckOutForm"); 
    if(isEarly==1){
             
        // Check current time greater that opntime time or not
           // var RealOpentime  = OpenTime - offsetmins *60000;
           //if(currenttime > RealOpentime )
           //     OpenTime.setTime(currenttime + offsetmins *60000);
        // End 
                var earlyDate = OpenTime.getDate();
                if(earlyDate==2)
                {
                    var parts = $("#OrderDate input").val().split('/');
                    var _date =  new Date(parts[2], parts[1]-1, parts[0]);
                    _date.setDate(_date.getDate()+1);
                    $("#OrderDate input").val(_date.getDate() +"/" + (_date.getMonth()+1) + "/" + _date.getFullYear());           
                 }
         $("input[name='ordertimeoverride'][value=l]").attr("checked","checked");
        $("input[name='ordertimeoverride']").trigger("change");
           $("select[name=p_hour]", dt).val(OpenTime.getHours());
            $("select[name=p_minute]", dt).val(round5(OpenTime.getMinutes()));
               
        _sTime = $("select[name=p_hour]", dt).val() + ":";
        boxdate2=("0" + ($("select[name=p_minute]", dt).val())).slice(-2)
        _sTime  += boxdate2;
         $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
                
       $('input[name=deliveryType]', form).val(delivery_type);
       $('input[name=special]', form).val($("#Specialinput").val());
       $('input[name=asaporder]', form).val($("input[name='ordertimeoverride']:checked").val());
       if(delivery_type == 'd'){
           if(isSetLatLng){
               $('input[name=deliveryLat]', form).val($("#hidLat").val());
               $('input[name=deliveryLng]', form).val($("#hidLng").val());
    }else{
        $('input[name=deliveryLat]', form).val('');
           $('input[name=deliveryLng]', form).val('');
    }
           $('input[name=deliveryPostCode]', form).val($("#hidPostCode").val());
           $('input[name=deliveryAddress]', form).val($("#hidFormattedAdd").val());
    }
    else{
           $('input[name=deliveryLat]', form).val('');
           $('input[name=deliveryLng]', form).val('');
           $('input[name=deliveryPostCode]', form).val('');
           $('input[name=deliveryAddress]', form).val('');
    }
			 
       alert("Your selected delivery/collection time is too near the opening time. We need to adjust it to allow enough time to prepare your order.");
        // $("#tooEarlyOrder").modal();
        return true;
    }           
    $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
    return true;
    }
        
        function CheckDeliveryTime() {
            var offsetmins,OpenTime,isEarly;
            if ($("input[name='orderTypePicker']:checked").val() == 'd') {
                offsetmins=$('#deliverydelay').val();
            } else {
                offsetmins=$('#collectiondelay').val();
            }
            var CurrentDate, PlaceOrderDate;
                CurrentDate = new Date();
            var curDay,curMonth,curYear;
                curDay = CurrentDate.getDate();
                curMonth = CurrentDate.getMonth() ;
                curYear = CurrentDate.getFullYear();
                var currentDatetime  =  Date.parse('01/01/2011 ' + CurrentDate.getHours() + ':' + round5(CurrentDate.getMinutes()))
            var s_time1;
            var dt = $("#DeliveryTime").val();
            var isAcceptOrder =  false;
            if(GetOrderAcceptFor(currenttime,CurrentDate.getDay(),"d") >= 0 && $("input[name='ordertimeoverride']:checked").val() =="n")
            {
                var HourCurrent = CurrentDate.getHours();
                var MinuteCurrent = CurrentDate.getMinutes();
                if(MinuteCurrent>57){
                    HourCurrent = HourCurrent  + 1;
                }
                MinuteCurrent =  round5(MinuteCurrent);    
                $("select[name=p_hour]", dt).val(HourCurrent);
                $("select[name=p_minute]", dt).val(MinuteCurrent);
                isAcceptOrder =  true;
            }

           
            var _sTime = $("select[name=p_hour]", dt).val() + ":";
            boxdate2=("0" + ($("select[name=p_minute]", dt).val())).slice(-2);
            _sTime  += boxdate2;
            s_time1 = _sTime;
            _time = Date.parse('01/01/2011 ' + _sTime);
            if(_time - currentDatetime == 0)
            {
                minuteDDefault = 0;
            }
                /*
            else if(_time - currentDatetime <= offsetmins)
                minuteDDefault = offsetmins;
                */
            var parts = $("#OrderDate input").val().split('/');
            var _date =  new Date(parts[2], parts[1]-1, parts[0]);
                CurrentDate = new Date(curYear,curMonth,curDay);
                PlaceOrderDate = _date;
            var days = _date.getDay();
            
            //if($("input[name='orderTypePicker']:checked").val() == "d" && $("[name=PreDeliveryOpen]").val()=="true"){
            if(days==0) days=7;
            //days = days -1    
            // }
            var key;
            if (days == 0) days = 7;
            isopen=0;
            nodelivery=0;
            
                
            isEarly = 0;
            
            for (key in jsDate) {

                if (jsDate[key].d==days ) {
                    /*if (jsDate[key].max<jsDate[key].min) {
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
                    } else {*/
                    var maxTime1 = jsDate[key].max;
                    if(maxTime1 < jsDate[key].min)
                        maxTime1 = jsDate[key].max + 24 * 60 * 60000;
                    /*var data  = new Date();
                    data.setTime(maxTime1)
                    console.log( data);
                    console.log("current select time ");
                    data.setTime(_time +  (offsetmins * 60000) - minuteDDefault )
                    console.log(data);*/

                  if(nodelivery == 0 && jsDate[key].min <= _time &&  maxTime1  >= _time && CurrentDate.getTime() <  PlaceOrderDate.getTime() )                  
                    {
                        if((jsDate[key].min + offsetmins * 60000) > _time){
                            OpenTime = new Date();
                            OpenTime.setTime(jsDate[key].min + offsetmins * 60000); 
                            isEarly = 1;   
                        }else{
                            OpenTime = new Date();
                            OpenTime.setTime(_time ); 
                        }
                                                    
                        if (jsDate[key].delivery=='n') 
                            nodelivery=1;
                        isopen = 1;
                  }    
                  else if(nodelivery == 0 && currenttime <  jsDate[key].min && jsDate[key].min <= _time &&  maxTime1 >=_time && _time >= jsDate[key].min + offsetmins * 60000  )
                  {
                      OpenTime = new Date();
                      OpenTime.setTime(_time ); 
                      if (jsDate[key].delivery=='n') 
                          nodelivery=1;
                      isopen = 1;
                  }
                  else if (nodelivery ==0 && jsDate[key].min <= _time &&  maxTime1 >= ( _time +  (offsetmins * 60000) - minuteDDefault ) ) {
                      if((jsDate[key].min + offsetmins * 60000 - minuteDDefault) > _time){
                          OpenTime = new Date();
                          OpenTime.setTime(jsDate[key].min + offsetmins * 60000 - minuteDDefault); 
                          isEarly = 1;
                      }
                      if (jsDate[key].delivery=='n') {
                          nodelivery=1;
                      }
                      isopen=1;
                  }
                  else if(nodelivery ==0 && jsDate[key].minacceptorderbeforeclose >= 0  )
                  {
                      if((maxTime1 - jsDate[key].minacceptorderbeforeclose * 60000) >= _time && jsDate[key].min < _time){
                          if (jsDate[key].delivery=='n') {
                              nodelivery=1;
                          }
                          isopen = 1;  
                      }
                  }
                    //}
                }

            }
            //second check
            if (isopen==0 && _time <= Date.parse('01/01/2011 12:00')) {
                dayprev=days-1;
                if (dayprev==0) {
                    dayprev=7;
                }
                for (key2 in jsDate) {
                    if (jsDate[key2].d==dayprev && jsDate[key].delivery =="y" ) {

                        if ( jsDate[key2].max<jsDate[key2].min ) {
                            var maxTime1 = jsDate[key2].max;
                            if(maxTime1 < jsDate[key2].min){
                                maxTime1 = jsDate[key2].max + 24 * 60 * 60000;
                                var maxdatetime = new Date();
                                maxdatetime.setTime(maxTime1);
                                var maxday = maxdatetime.getDate();
                                var maxMonth = maxdatetime.getMonth()+1;
                                var maxYear = maxdatetime.getFullYear();
                                var _timeMew = new Date();
                                _timeMew.setTime(_time);
                                var timeHour = _timeMew.getHours();
                                var timeminute = _timeMew.getMinutes();
                                _time = Date.parse(maxMonth  + '/' +maxday+ '/' +maxYear+ ' ' + timeHour+':' + timeminute);
                             
                            }
                            if(CurrentDate.getTime() <  PlaceOrderDate.getTime() && _time <= maxTime1  )
                            {
                                if (jsDate[key2].delivery=='n') {
                                    nodelivery=1;

                                }
                                isopen=1;
                            }
                            else if((_time +  (offsetmins * 60000) - minuteDDefault )   <=  maxTime1 ) {
                                if (jsDate[key2].delivery=='n') {
                                    nodelivery=1;

                                }
                                isopen=1;
                            }
                            else if(nodelivery ==0 && jsDate[key2].minacceptorderbeforeclose >= 0  )
                            {
                                if((maxTime1 - jsDate[key2].minacceptorderbeforeclose * 60000) >= _time && jsDate[key2].min < _time ){
                                    if (jsDate[key].delivery=='n') {
                                        nodelivery=1;
                                    }
                                    isopen = 1;  
                                }
                            }
                        }				
                    }
                }			
            }
            var delivery_type  = $("input[name='orderTypePicker']:checked").val();
            if (nodelivery==1 && delivery_type=='d' ) {

                $("#timeslotModal").modal();
	
                return false;
            }	
            // if(!jsDate[days])
            if(!lookupdayinarray(jsDate,days))
            {
                $("#ClosedModal div.modal-body").html('Sorry, On ' + myDays[days-1] + ' we are closed.');
                $("#ClosedModal").modal();
                return false;
            } 
            else if(isopen==0)
            {
                if(isAcceptOrder == true)
                {
                    var date1 = new Date("01/01/2011 " + _sTime);
                    var s_date1 = date1.getTime() + offsetmins * 60000;
                    var dt2 =  new Date();
                    dt2.setTime(s_date1);
                    _sTime = dt2.getHours() + ":" + dt2.getMinutes();
                }
                $("#ClosedModal div.modal-body").html('Sorry, On ' + myDays[days-1] + ' at ' + ("0" + _sTime).slice(-5) + '  we are closed.');
                $("#ClosedModal").modal();
                return false;
            } 
            
            var form = $("#CheckOutForm"); 
            if(isEarly==1){
                // Check current time greater that opntime time or not
                //var RealOpentime  = OpenTime - offsetmins *60000;
                //if(currenttime > RealOpentime ){
                //    OpenTime.setTime(currenttime + offsetmins *60000);
                //    }
                   
                // End 

                var earlyDate = OpenTime.getDate();
                if(earlyDate==2)
                {
                    var parts = $("#OrderDate input").val().split('/');
                    var _date =  new Date(parts[2], parts[1]-1, parts[0]);
                    _date.setDate(_date.getDate()+1);
                    $("#OrderDate input").val(_date.getDate() +"/" + (_date.getMonth()+1) + "/" + _date.getFullYear());           
                }
                $("input[name='ordertimeoverride'][value=l]").attr("checked","checked");
                $("input[name='ordertimeoverride']").trigger("change");
                $("select[name=p_hour]", dt).val(OpenTime.getHours());
                $("select[name=p_minute]", dt).val(round5(OpenTime.getMinutes()));
               
                _sTime = $("select[name=p_hour]", dt).val() + ":";
                boxdate2=("0" + ($("select[name=p_minute]", dt).val())).slice(-2)
                _sTime  += boxdate2;
                $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
                
                $('input[name=deliveryType]', form).val(delivery_type);
                $('input[name=special]', form).val($("#Specialinput").val());
                $('input[name=asaporder]', form).val($("input[name='ordertimeoverride']:checked").val());
                if(delivery_type == 'd'){
          
                    if(isSetLatLng){
                        $('input[name=deliveryLat]', form).val($("#hidLat").val());
                        $('input[name=deliveryLng]', form).val($("#hidLng").val());
                    }else{
                        $('input[name=deliveryLat]', form).val('');
                        $('input[name=deliveryLng]', form).val('');
                    }
       
                    $('input[name=deliveryPostCode]', form).val($("#hidPostCode").val());
                    $('input[name=deliveryAddress]', form).val($("#hidFormattedAdd").val());
                }
                else{
                    $('input[name=deliveryLat]', form).val('');
                    $('input[name=deliveryLng]', form).val('');
       
                    $('input[name=deliveryPostCode]', form).val('');
                    $('input[name=deliveryAddress]', form).val('');
                }
                //$("#tooEarlyOrder").modal();
                alert("Your selected delivery/collection time is too near the opening time. We need to adjust it to allow enough time to prepare your order.");
                return true;
            }    

            $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
            return true;
        }
    function lookupdayinarray(Json,day)
    {
        var result = false; 
        for (key in jsDate) {
            if (jsDate[key].d==day) {
                result = true; 
            }
        }       
        return result;
    }
    function CheckOrder(mode) {
        if(mode=="confirm")
        {
            if( $.trim($("#modalDivOrderTypeBody").html()) !=""){
                $("#modalDivOrderType").modal("show");
                $("[name='orderTypePicker']:checked").trigger("click");
                //InitCollectionDelivery();    
                //InitCollectionDelivery2();
            }
            return false;
        }   
        var delivery_type  = $("input[name='orderTypePicker']:checked").val();
        var AcceptFor = 0;
        var offsetmins,offsetmins2;
        if (delivery_type == 'd') {
            offsetmins=$('#deliverydelay').val();
        } else {
            offsetmins=$('#collectiondelay').val();
        }
        offsetmins2 = parseInt(offsetmins) ; //parseInt(offsetmins)+5;
        if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 

           
            var dt1 = new Date();
           

            var dt1Day = dt1.getDay();
            var nextOpeningTime = new Date();
            if (dt1Day == 0) dt1Day = 7;
            //for (key in jsDate) {
            //    if (jsDate[key].d==dt1Day) {
            //        nextOpeningTime.setTime(jsDate[key].min); 
            //    }
            //}
            
         
            
                    if(delivery_type == "d" && $("[name=PreDeliveryOpen]").val()=="true"){
                        var datemin =Date.parse('01/01/2011 00:00') ; 
                            nextOpeningTime.setTime(datemin);
                    }
                    else if(delivery_type == "c" && $("[name=PreCollectionOpen]").val()=="true"){
                            
                    }
                    else 
                        nextOpeningTime = GetOpeningTimeExt(currenttime,dt1Day,delivery_type);
               
                    var OrderBeforeTime = false;     
            if(nextOpeningTime !=null && ( dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())) ){
                dt1.setHours(nextOpeningTime.getHours());
                dt1.setMinutes(nextOpeningTime.getMinutes());
                $("input[name='ordertimeoverride'][value=l]").prop('checked',true);
                OrderBeforeTime =  true;
            }                
            AcceptFor = GetOrderAcceptFor(currenttime,dt1Day,delivery_type)
            if(AcceptFor >= 0)
                AcceptFor =   offsetmins2;
            else
                AcceptFor=0;  

            var dt = new Date(dt1.getTime() + (offsetmins2 - AcceptFor)*60000);
            //var dt = new Date(dt1.getTime() + (offsetmins2 )*60000);
            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
            if(round5(dt.getMinutes()) == 0 && dt.getMinutes() > 50){
                if(dt.getHours() == 23)
                    $("select[name=p_hour]").val(0);
                else
                    $("select[name=p_hour]").val(dt.getHours() + 1);
            }
            else
                $("select[name=p_hour]").val(dt.getHours());
            $("select[name=p_hour]").trigger("change");
            //$("select[name=p_minute]").val(round5(dt.getMinutes() + 3));
            $("select[name=p_minute]").val(round5(dt.getMinutes()));
            $("select[name=p_minute]").trigger("change");

            $("#OrderDate input").val(dt.getDate()  + "/" + (dt.getMonth() +1) + "/" + dt.getFullYear());
	
	
        }
        try
        {
            
            
            if(!delivery_type)
            {
			     
                
                if($("#beforeorder").html() !=""){
                    $('#beforeorder').css('border-color', 'red');
                    $('#beforeorder').css('border-width', '4px');
                    scrollToV2("beforeorder");
                }
                else if($("#modalDivOrderTypeBody").html() !=""){
                    $('#modalDivOrderTypeBody #input-group-pc').css('border', 'solid 1px red');
                    
                    scrollToV2("modalDivOrderTypeBody");
                }
                //scrollToV2("beforeorder");
                //$("#modalDivOrderType").modal();
                //$("#BeforeYouOrder").modal();
                return false;
            }

            var form = $("#CheckOutForm");
            $('input[name=deliveryType]', form).val(delivery_type);
            $('input[name=special]', form).val($("#Specialinput").val());
            $('input[name=asaporder]', form).val($("input[name='ordertimeoverride']:checked").val());
            if(delivery_type == 'd'){
                if(isSetLatLng){
                    $('input[name=deliveryLat]', form).val($("#hidLat").val());
                    $('input[name=deliveryLng]', form).val($("#hidLng").val());
                }else{
                    $('input[name=deliveryLat]', form).val('');
                    $('input[name=deliveryLng]', form).val('');
                }
                $('input[name=deliveryPostCode]', form).val($("#hidPostCode").val());
                $('input[name=deliveryAddress]', form).val($("#hidFormattedAdd").val());
            }
            else{
                $('input[name=deliveryLat]', form).val('');
                $('input[name=deliveryLng]', form).val('');
                $('input[name=deliveryPostCode]', form).val('');
                $('input[name=deliveryAddress]', form).val('');
            }
			 
            if(delivery_type == 'd')
            {
                //CheckDistance();
                var distance = $('input[name=deliveryDistance]', form).val();
                if(!distance)
                {
               
                    if($("#beforeorder").html() !=""){
                        $('#beforeorder').css('border-color', 'red');
                    
                        scrollToV2("beforeorder");
                    }
                    else if($("#modalDivOrderTypeBody").html() !=""){
                        $('#modalDivOrderTypeBody #input-group-pc').css('border', 'solid 1px red');
                        scrollToV2("modalDivOrderTypeBody");
                    }

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
			
            _time = Date.parse('01/01/2011 ' + _sTime);
			
            var parts = $("#OrderDate input").val().split('/');
            var _selecteddateandtime =  new Date(parts[2], parts[1]-1, parts[0],$("select[name=p_hour]", dt).val(),$("select[name=p_minute]", dt).val());
			
            var currdt = new Date();
		
            if(delivery_type == 'd') {
                var newcurrdt = new Date(currdt.getTime() + (offsetmins2-AcceptFor)*60000 - 5 * 60000); //-2 min to make sure curent date will less than the time we set at p_hour
	
            } else {
                var newcurrdt = new Date(currdt.getTime() + (offsetmins2 -AcceptFor) *60000  - 5 * 60000 ); //-2 min to make sure curent date will less than the time we set at p_hour
            }
            
            if (_selecteddateandtime < newcurrdt) {
                alert("Delivery/Collection time selected sooner than time required to prepare an order.  Please select a later time.");
                return false;
            }
				
				
            if($("input[name='orderTypePicker']:checked").val()  =="d" &&  !CheckDeliveryTime())
            { 
				
				
		
                 
                return false;
            }
				
            if($("input[name='orderTypePicker']:checked").val() == "c" && !CheckCollectionTime())
            { 
				
				
		
                 
                return false;
            }
            $('#beforeorder').css('border-color', '#E9EAEB');
            StoreCookieDelivery();
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


        <%if ordertodayonly<>-1 then%>
                var checkout = $('#OrderDate').datepicker({
			
                    onRender: function(date) {
                        return date.valueOf() < now.valueOf() ? 'disabled' : '';
                    }
			
			
                }).on('changeDate', function (ev) {
                    ddate=ev.date;
                    pickeddate=("0" + (ddate.getMonth() + 1)).slice(-2)
                    pickedday=("0" + (ddate.getDate())).slice(-2)
                    ddate2=pickedday.toString() + "/" + pickeddate.toString() + "/"  + ddate.getFullYear().toString()
			
                    $("#OrderDateBox").val(ddate2);
                    StoreToC($("#OrderDateBox"),"OrderDate"); <% ' Store value to cookie for back button remember value%>
                    checkout.hide();
                }).data('datepicker');
        <%end if	%>
                 $("input[name='ordertimeoverride']").click(function() {
                 $.ajax({url: "ajaxdelivery.asp?d=" + $("input[name='orderTypePicker']:checked").val() , success: function(result){
                 ReloadShop();
        }});
	
          if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 	  
            if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                offsetmins=$('#collectiondelay').val();
                var dt1 = new Date();
                offsetmins2 = parseInt(offsetmins) ; //parseInt(offsetmins)+5;
                var dt = new Date(dt1.getTime() + offsetmins2*60000);
                var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                $("select[name=p_hour]", dt).val(dt.getHours());
                $("select[name=p_minute]").val(round5(dt.getMinutes()));
            }
        } 
          if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 	  
                    if ($("input[name='orderTypePicker']:checked").val() == 'd') { 	
                        $("#DeliveryDistance").show();  
                        $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                            setTimeout(function () {
                            $("#PreFillDistance").tooltip('hide');
                        }, 3000);
                        $("#DeliveryTime").hide();     
                        $("#DeliveryTime label").text("Delivery Time *");
                        $('#DeliveryTimeNowD').show();
                        $('#DeliveryTimeNowC').hide(); 
                        $('#CollectionAddress').hide();    
                        console.log("hide 1");
                    } else {
                        $("#DeliveryDistance").hide(); 
                        $("#DeliveryTime label").text("Collection Time *");
                        $("#DeliveryTime").hide();
                        $('#DeliveryTimeNowC').show();
                        $('#CollectionAddress').show();
                        console.log("Show 1");
                        $('#DeliveryTimeNowD').hide();
	
                    }
        } 	
                if ($("input[name='ordertimeoverride']:checked").val() == 'l') { 
                $('#DeliveryTimeNowD').hide();
                $('#DeliveryTimeNowC').hide();
               // $('#CollectionAddress').hide();
             if ($("input[name='orderTypePicker']:checked").val() == 'd') { 
		        $('#CollectionAddress').hide();
                console.log("hide 2");
             $("#DeliveryDistance").show();               
            $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
             setTimeout(function () {
                    $("#PreFillDistance").tooltip('hide');
        }, 3000);
              $("#DeliveryTime").show();  
              $("#DeliveryTime label").text("Delivery Time *"); 		  
        offsetmins=$('#deliverydelay').val();
        var dt1 = new Date();
        offsetmins2 = parseInt(offsetmins);//parseInt(offsetmins)+5;
        var dt = new Date(dt1.getTime() + offsetmins2*60000);	
        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
        $("select[name=p_hour]", dt).val(dt.getHours());
        $("select[name=p_minute]").val(round5(dt.getMinutes()));
	
        } else {  
              $("#DeliveryDistance").hide();
               $("#DeliveryTime label").text("Collection Time *");
                $("#DeliveryTime").show(); 
                if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
        offsetmins=$('#collectiondelay').val();
        var dt1 = new Date();
        offsetmins2 = parseInt(offsetmins) ;// parseInt(offsetmins)+5;
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
			
            $.ajax({url: "ajaxdelivery.asp?d=" + $("input[name='orderTypePicker']:checked").val() , success: function(result){
                ReloadShop();
            }});
	
            if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 	  
                if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                    offsetmins=$('#collectiondelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins); //parseInt(offsetmins)+5;
                    var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                    $("select[name=p_hour]", dt).val(dt.getHours());
                    $("select[name=p_minute]").val(round5(dt.getMinutes()));
                }
	
            }
            if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { 
	
                    $("#DeliveryDistance").show();  
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                    setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").hide();  
                    $("#DeliveryTime label").text("Delivery Time *");
                    $('#DeliveryTimeNowD').show();
                    $('#DeliveryTimeNowC').hide();
                    $('#CollectionAddress').hide();
                    console.log("hide 3");
                } else {
                    $("#DeliveryDistance").hide(); 
                    $("#DeliveryTime label").text("Collection Time *"); 
                    $("#DeliveryTime").hide();
                    $('#DeliveryTimeNowC').show();
                    $('#CollectionAddress').show();
                    console.log("show 3");
                    $('#DeliveryTimeNowD').hide();
                }
	 
	 
            } 	
	  
            if ($("input[name='ordertimeoverride']:checked").val() == 'l') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show(); 
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                    setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *");    } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
                }
	 
            } 	
	  	 
            if ($("input[name='orderTypePicker']:checked").val() == 'c') {
                console.log("show 4");
                $('#CollectionAddress').show();
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

        <% If Not isopen then %>
            $("#ClosedModal").modal();
        <%if sorderonlywhenopen=-1 then%>
         $("#butcontinue").unbind("click");
        $("#butcontinue").bind("click",function(){
                  
            return false; 
        });
        $("#butcontinue").hide();
       $("#basket").hide();
        $("#idOpenHour").hide();    
        $("#beforeorder").hide();
        $("#noorders").show();
        <%end if%>
    <% End If %>

    });
		
		
		
    $("input[name='ordertimeoverride']").change(function(){
		
        if ($(this).val() == 'n') {	
            if ($("input[name='orderTypePicker']:checked").val() == 'd') {
                $('#CollectionAddress').hide();
                console.log("hide 5");
                offsetmins=$('#deliverydelay').val();
            } else {
                offsetmins=$('#collectiondelay').val();
                $('#CollectionAddress').show();
                console.log("show 5");    
            }
            var dt1 = new Date();
            var dt = new Date(dt1.getTime() + offsetmins*60000);
	
            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
            $("select[name=p_hour]", dt).val(dt.getHours());
            $("select[name=p_minute]").val(round5(dt.getMinutes()));
	
            if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show();  
                $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                setTimeout(function () {
                    $("#PreFillDistance").tooltip('hide');
                }, 3000);
                $("#DeliveryTime").hide();  $("#DeliveryTime label").text("Delivery Time *");  	} else {
                $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").hide();
	
            }
        };
	
        if ($(this).val() == 'l') {
            if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show(); 
                $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                setTimeout(function () {
                    $("#PreFillDistance").tooltip('hide');
                }, 3000);
                $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *");   } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
            }
   
        } 
    });
</script>
<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
				
				
				
				<div class="navbar-header" style="float:right;">
					
					
					
					 <div class="navbar-brand" >  <span class="label label-success" id="addtobasket" style="float:left;margin-right:10px;">Added</span>
                          <% 
                              dim ishowPlaceOrder : ishowPlaceOrder = true
                              dim messageClose : messageClose = " However, you can place an order now for delivery at a later time."
                                 If isopen=false then 
                                    if sorderonlywhenopen=true  then
                                        ishowPlaceOrder = false
                                        messageClose = "Ordering available during opening hours only."
                                    end if
                                 end if
                          
                                
                            if ishowPlaceOrder=true then
                              
                               %>
                                <button type="button" id="butcontinue" class="btn btn-primary btn-sm" style="float:right;margin-left:10px;">Checkout <span class="glyphicon glyphicon-chevron-right"></span></button>  
                             
            
                         <button type="button"  id="butbasket" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-shopping-cart"></span> <b>Basket</b> <%=CURRENCYSYMBOL%>  <span id="shoppingcart2"></span></button>
                         <%end if %>

</div>
				</div>
				
				
				
			</nav>



			
    <div id="ClosedModal" class="modal fade">
	  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3 style="color: red">
                Closed</h3>
        </div>
        <div class="modal-body">
            <p id="msgclose" style="display:none;">Sorry, we are closed today</p>
            <p id="msgcurrent">
                Sorry, <b>
                    <%=sName %></b> is closed at the moment.<br />
               <%=messageClose %><br />
            </p>
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn btn-primary">Ok!</a>
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
            Sorry, Your session has expired. Please click OK to restart.
        </div>
        <div class="modal-footer">
            <a href="javascript:void(0);" onclick="location.href='<%="menu.asp?id_r=" & request.querystring("id_r") %>'" data-dismiss="modal" class="btn btn-primary">Ok!</a>
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
<div id="modalDivOrderType" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="margin-top: 20px;
    margin-left: 20px;z-index:1045;">
    <div class="modal-dialog">
        <button type="button" class="close hidden" data-dismiss="modal" aria-hidden="true">x</button>
        <div class="modal-content">
            <div class="modal-body" id="modalDivOrderTypeBody">
                
            </div>
        </div>
    </div>
</div>   
    <script>
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
        
        if($.trim($("[nameopentime="+curnumday+"] div").html()) == "Closed")
        {
            $("#msgclose").show();
            $("#msgcurrent").hide();
            
        }
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


    <input type="hidden" value="<%=isopen %>"  name ="sisopen" />
<script type="text/javascript">
    $(window).load(function() {
        $(".loader").fadeOut("slow");
        $("#wholepage").show();
	
    })
</script>

<script src="scripts/addtohomescreen.js"></script>
<script>
addToHomescreen();
</script>

	


<%if request.querystring("postcode")<>"" then%>
<script>
$(document).ready(function(){
$("#validate_pc").val("<%=request.querystring("postcode")%>");
CheckDistance();

    $("select [name='p_hour']").bind("changed",function(){StoreToC(this,"p_hour");});
    $("select [name='p_minute']").bind("changed",function(){StoreToC(this,"p_minute");});


  });


</script>
<%end if%>


  <script>
      
    var tempBeforeOrderHTML = '';
    function StoreCookieDelivery()
    {
        StoreToC($("#OrderDateBox"),"OrderDate");
        StoreToC($("[name=p_hour]"),"p_hour");
        StoreToC($("[name=p_minute]"),"p_minute");
        
    }
    function LoadDesktop()
    {
            
          if($('#beforeorder').html()!=""){
              tempBeforeOrderHTML = $('#beforeorder').html();
              tempBeforeOrderHTML += '<button type="button" id="placeOrderBack" onclick="javascript:$(\'#modalDivOrderType\').modal(\'hide\');" class="btn btn-primary" style="float:left;margin-left:10px;padding:8px;"> <span class="glyphicon glyphicon-chevron-left"></span>Back to Menu</button>';
              tempBeforeOrderHTML += '<button type="button" id="placeOrderContinue" onclick="CheckOrder(\'submit\');" class="btn btn-success" style="width: 80px; padding: 8px; float:right;">Continue</button>';
              tempBeforeOrderHTML += '<div style="clear:both;" id="placeOrdeClear"></div>';
              $("#modalDivOrderTypeBody").html(tempBeforeOrderHTML);
              $('#beforeorder').html('');
              InitCollectionDelivery();    
              InitCollectionDelivery2();
               $("#butcontinue").unbind("click");
               $("#butcontinue").bind("click",function(){
                  
                      CheckOrder('confirm');  
               });
                $("#btnPlaceOrder button").unbind("click");
                $("#btnPlaceOrder button").bind("click",function(){
                    CheckOrder('confirm');  
                });
                if(typeof AutocompleteFNC !== "undefined")
                    AutocompleteFNC();
                registerlistener();
        }
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
                scrollMobile();
               
       }else if($(window).width() > 992 && screenmode=="mobile"){
                $("[data-type='group-cate']").each(function(){
                    $(this).show();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
                });
                screenmode= "deskstop";
        }
    }
    function LoadMobile()
    {
        //$('#modalDivOrderType').modal('hide');
        if($('#beforeorder').html()=='' && $("#modalDivOrderTypeBody").html() !='')
        {
            $("#placeOrderContinue").remove();
            
            $("#placeOrderBack").remove();
            $("#placeOrderClear").remove();
            $('#beforeorder').html($("#modalDivOrderTypeBody").html());
            $("#modalDivOrderTypeBody").html('');
        }
        InitCollectionDelivery();    
        InitCollectionDelivery2();
        $("#butcontinue").unbind("click");
        $("#butcontinue").bind("click",function(){
                
                CheckOrder('submit');  
        });

        $("#btnPlaceOrder button").bind("click",function(){
                
                CheckOrder('submit');  
        });
        if(typeof AutocompleteFNC !== "undefined")
             AutocompleteFNC();
        registerlistener();
    }
   $(window).on('resize', function () {
        detechScreen();
    });     
  
    function registerlistener()
    {
         $("#validate_pc").keydown(function(e) {
            $('#modalDivOrderTypeBody #input-group-pc').css('border', 'none');
           if(!$("#DeliveryDistance").find('.tooltip').hasClass('in'))
                $("#updateFullPostcodeSubmit").tooltip({trigger: 'manual'}).tooltip('show');    
           if (e.keyCode == 13 || e.which ==13) {
                $("#hidLat").val('');
                $("#hidLng").val('');
               $("#updateFullPostcodeSubmit").trigger("click");
                 e.preventDefault();
            }
         
        });     
     $("#validate_pc").change(function() {
         $('#modalDivOrderTypeBody #input-group-pc').css('border', 'none');   
         if(isSetLatLng) isSetLatLng =false;
         else{
             $("#hidLat").val('');
             $("#hidLng").val('');    
            }
         
          
        });    
    }
      
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
      $(document).ready(function(){
        
          if($(window).width() <=992){
             scrollMobile();
             LoadMobile();
             

              $("[data-type='group-cate']").each(function(){
                    $(this).hide();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-down").removeClass("arrow-icon-up");
                });
                
                screenmode= "mobile";
            }else{
             LoadDesktop();
              $("[data-type='group-cate']").each(function(){
                    $(this).show();
                    $(this).prev().find(".product-line-heading__icon").addClass("arrow-icon-up").removeClass("arrow-icon-down");
                });
                screenmode= "deskstop";
          }
           <% If Not isopen then %>
            $("#ClosedModal").modal();
            <%if sorderonlywhenopen=-1 then%>
             $("#butcontinue").unbind("click");
            $("#butcontinue").bind("click",function(){
                  
                return false; 
            });
            $("#butcontinue").hide();
            $("#basket").hide();
            $("#idOpenHour").hide();            
            $("#noorders").show();
            <%end if%>
        <% End If %>

      });

       

      function GetOpeningTimeExt(currenttime,dt1Day,mode)
        {
            var minTime =0,maxTime=0;
            var opentime = new Date();

             for (key in jsDate) {
                    if (jsDate[key].d==dt1Day) {
                        var openMinTime = jsDate[key].min ;
                         var openMaxTime = jsDate[key].max ;
                     
                        if(openMaxTime <  openMinTime)
                                openMaxTime = openMaxTime + 24 * 60 * 60000;
                         if(mode=="d" && jsDate[key].delivery=="y" ){
                            if( currenttime < jsDate[key].min && minTime == 0  ){
                                       minTime =  jsDate[key].min;
                                       maxTime =  jsDate[key].max;
                             }
                            if(currenttime > openMinTime && currenttime < openMaxTime  )
                            {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                            }
                        }else if(mode == "c" && jsDate[key].collection=="y") 
                        {
                              if( currenttime < jsDate[key].min && minTime == 0  ){
                                       minTime =  jsDate[key].min;
                                       maxTime =  jsDate[key].max;
                             }    
                             if(currenttime > openMinTime && currenttime < openMaxTime )
                            {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                            }      
                        }
                    }
                }
        // check Previous day
        dt1Day = dt1Day -1;
        if(dt1Day==0) dt1Day = 7;
          for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                     if(openMaxTime <  openMinTime){
                        var openMinTime = jsDate[key].min ;
                        var openMaxTime = jsDate[key].max ;
                         if(mode=="d" && jsDate[key].delivery=="y" ){
                                 if(currenttime > openMinTime && currenttime < openMaxTime)
                                    {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                                     }
                         }else if(mode == "c" && jsDate[key].collection=="y") 
                        {
                                 if(currenttime > openMinTime && currenttime < openMaxTime)
                                    {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                                    }
                       }
                    }
                }
          }
        if(minTime > 0 && maxTime > 0)
             opentime.setTime(minTime);
        else 
            return null;

        return opentime;
        
        }
    
   function GetOpeningTimePrev(currenttime,dt1Day)
    {
        var minTime =0,maxTime=0;
        var opentime = new Date();
        var MinDateTime = new Date();
            MinDateTime = Date.parse('01/01/2011 ' + '00:00:01') ; 
        var MaxDateTime = new Date();
        dt1Day = dt1Day-1;
        if(dt1Day==0) dt1Day=7

        for (key in jsDate) {
            if (jsDate[key].d==dt1Day) {
                maxTime = jsDate[key].max;
                minTime = MinDateTime.getTime();
            }
        }
        

    if(minTime > 0 && maxTime > 0)
         opentime.setTime(minTime);
    else
        return null;
    return opentime;
        
    }
    function GetOpeningTime(currenttime,dt1Day)
    {
        var minTime =0,maxTime=0;
        var opentime = new Date();

         for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                    var openMinTime = jsDate[key].min ;
                     var openMaxTime = jsDate[key].max ;
                     
                    if(openMaxTime <  openMinTime)
                            openMaxTime = openMaxTime + 24 * 60 * 60000;
                     if( currenttime < jsDate[key].min && minTime == 0 
                                 && (jsDate[key].delivery=="y" ||  jsDate[key].collection=="y") ){
                                   minTime =  jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                     }
                     if(currenttime > openMinTime && currenttime < openMaxTime && (jsDate[key].delivery=="y" ||  jsDate[key].collection=="y") )
                            {
                                   minTime  = jsDate[key].min;
                                   maxTime =  jsDate[key].max;
                            }
                }
            }
        
    if(minTime > 0 && maxTime > 0)
         opentime.setTime(minTime);
    else
         return null;   
    
    return opentime;
        
    }
    function GetOrderAcceptFor(currenttime,dt1Day,delivery_type)
      {
            var offsetmins;
           if (delivery_type == 'd') {
                offsetmins=$('#deliverydelay').val();
            } else {
                offsetmins=$('#collectiondelay').val();
            }
        
      if(dt1Day==0)dt1Day=7;
        var result = -1;
         for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                            var openMinTime = jsDate[key].min ;
                     var openMaxTime = jsDate[key].max ;
                        if(openMaxTime < openMinTime)
                            openMaxTime = openMaxTime + 24 * 60 * 60000;
                        if(delivery_type=="d" && jsDate[key].delivery == "y"){
                            if(currenttime >= openMinTime + offsetmins * 60000  && currenttime <= openMaxTime )
                                result = jsDate[key].minacceptorderbeforeclose;
                        }else if(delivery_type=="c" && jsDate[key].collection == "y"){
                            if(currenttime   >= openMinTime + offsetmins * 60000 && currenttime <= openMaxTime )
                                result = jsDate[key].minacceptorderbeforeclose;
                        }
                }
        }
      // second check previous day
      dt1Day  =dt1Day -1;
      if(dt1Day==0)dt1Day=7;
      if(result==-1){
       for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                            var openMinTime = jsDate[key].min ;
                     var openMaxTime = jsDate[key].max ;
                       if(openMaxTime < openMinTime)
                        {
                            currenttime  =currenttime + 24 * 60 * 60000;
                            openMaxTime = openMaxTime + 24 * 60 * 60000;
                            if(currenttime >= openMinTime && currenttime <= openMaxTime )
                                result = jsDate[key].minacceptorderbeforeclose;
                            }
                        } 
                        
                }
         }
      

        return result;
      }
    function GetMin_Max_Expexted_Time(currenttime,mode,delay,dt1Day)
    {
        var result = "";
        var minTime = 0;
        var maxTime = 0;
        var opentime = new Date();
          for (key in jsDate) {
                if (jsDate[key].d==dt1Day) {
                     var openMinTime = jsDate[key].min ;
                     var openMaxTime = jsDate[key].max ;
                     
                        if(openMaxTime <  openMinTime)
                            openMaxTime = openMaxTime + 24 * 60 * 60000;
                        if(mode=="d"){
                            /*|| (currenttime >= openMinTime && currenttime <= openMaxTime ) */ 
                            if(( (currenttime < openMinTime) ) 
                                && jsDate[key].delivery =="y"
                                && minTime == 0){
                                   minTime =  openMinTime;
                                   maxTime =  openMaxTime;
                                   if((minTime + delay * 60000) <= maxTime)
                                       minTime =   minTime + delay * 60000  ;
                                    else {
                                       minTime = 0;
                                       maxTime = 0;
                                    } 
                                  
                            }
                        }else
                        {
                            /*|| (currenttime >= openMinTime && currenttime <= openMaxTime )*/
                           if(( (currenttime < openMinTime ) ) 
                                && jsDate[key].collection =="y"
                                && minTime == 0){
                               minTime =  openMinTime;
                               maxTime =  openMaxTime;
                               if((minTime + delay * 60000) <= maxTime)
                                   minTime =   minTime + delay * 60000  ;
                                else {
                                   minTime = 0;
                                   maxTime = 0;
                                } 
                               
                            }
                        }

                }
            }
       
        if(minTime > 0 && maxTime > 0)
            opentime.setTime(minTime);
        else
            return null;
        return opentime;
      
    }
        var minuteCDefault = 0;
      var minuteDDefault = 0;
    function InitCollectionDelivery(){
    $("select[name='p_hour']").change(function(){StoreToC(this,"p_hour");});
    $("select[name='p_minute']").change(function(){StoreToC(this,"p_minute");});
      $("#OrderDateBox").change(function(){StoreToC(this,"OrderDate");});
    $("input[name='orderTypePicker']").change(function(){
      if ($("input[name='orderTypePicker']:checked").val() == 'c') {
            console.log("show 6");
            $('#CollectionAddress').show();
        }       
      else {
                $('#CollectionAddress').hide();
                console.log("hide 6");
           }
      StoreToC($("input[name='orderTypePicker']:checked"),"orderTypePicker");
      });
    $("input[name='ordertimeoverride']").change(function(){StoreToC($("input[name='ordertimeoverride']:checked"),"ordertimeoverride");});

    if( getCookie('orderTypePicker') != '')
        { 
            $("input[name='orderTypePicker'][value='" +getCookie('orderTypePicker') + "']").attr('checked','checked');
            $("input[name='orderTypePicker'][value='" +getCookie('orderTypePicker') + "']").trigger("click");
            if (getCookie('orderTypePicker') == 'c') {
                $('#CollectionAddress').show();
                console.log("show 7");    
                }
            else {
                console.log("hide 7");
                $('#CollectionAddress').hide();
                }
    }
    if( getCookie('ordertimeoverride') != ''){
         $("input[name='ordertimeoverride'][value='" +getCookie('ordertimeoverride') + "']").attr('checked','checked');
     $("input[name='ordertimeoverride'][value='" +getCookie('ordertimeoverride') + "']").trigger("click");
    }
    if( getCookie('p_hour') != '')
         $("select[name='p_hour']").val(getCookie('p_hour'));
     if( getCookie('p_minute') != '')
         $("select[name='p_minute']").val(getCookie('p_minute'));
    if( getCookie('OrderDate') != '')
         $("#OrderDateBox").val(getCookie('OrderDate'));
    
    
    if(getCookie("validate_pc") != "" &&  ( getCookie("Address") == "" || $("#isChangeExistingAddress").val() == "Y") ){
         $("#validate_pc").val(getCookie("validate_pc") ); 
           
           $("#PreFillDistance").html('Delivery Address (<a id=\'aChangeAdress\' style=\'cursor:pointer;\' onclick="OnChangePrefillAddress()">Change</a>)<br/> <span style="font-weight: bold;">' + getCookie("validate_pc") + '.</span>');
           $("#PreFillDistance").show();
        
            CheckDistance();  
            $("#updateFullPostcode").hide();    
    }
    else if( getCookie("Address") != "" && ($("#hidLat").val() == "" || $("#hidLng").val() == "")){       
        var tempAdress = getCookie("Address");
        
        if(getCookie('HouseNumber') != '')
            tempAdress = getCookie('HouseNumber') + ' ' +  tempAdress;
        if(getCookie('Address2') != '') 
            tempAdress = tempAdress + ", " + getCookie('Address2');
        if(getCookie('Postcode') != '') 
            tempAdress = tempAdress + ", " + getCookie('Postcode');
        tempAdress = tempAdress.replace(/\+/g,' ');
        tempAdress = unescape(tempAdress);
 
        $("#validate_pc").val(getCookie('Postcode'));
    

      $("#PreFillDistance").html('Delivery Address (<a id=\'aChangeAdress\' style=\'cursor:pointer;\' onclick="OnChangePrefillAddress();">Change</a>)<br/> <span style="font-weight: bold;">' + tempAdress + '.</span>');           
            $("#PreFillDistance").show();
            CheckDistance();  
            $("#updateFullPostcode").hide();     
        }
    else{
         $("#PreFillDistance").remove();
         $("#updateFullPostcode").show();
    }
  
    
    var offsetminsD=$('#deliverydelay').val();   
    var offsetminsC=$('#collectiondelay').val();    
    var dt1 = new Date();
    offsetminsD = parseInt(offsetminsD);
    offsetminsC = parseInt(offsetminsC);
    var dt1Day = dt1.getDay();
    var nextOpeningTime = new Date();
    if (dt1Day == 0) dt1Day = 7;

            if($("[name=PrevStillOpen]").val()=="true"){
                var datemin =Date.parse('01/01/2011 00:00') ; 
                nextOpeningTime.setTime(datemin);
                }
            else
                nextOpeningTime = GetOpeningTime(currenttime,dt1Day);
//        for (key in jsDate) {
//            if (jsDate[key].d==dt1Day) {
//                nextOpeningTime.setTime(jsDate[key].min); 
//            }
//        }
    if(nextOpeningTime !=null && (dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())) ){
        
        var newTime = new Date();
        newTime.setTime(nextOpeningTime.getTime() );
        var timeString = '';
        var minStr = '';   
        newTime.setTime(nextOpeningTime.getTime());
        timeString = '';
       
        if(newTime.getMinutes() < 10)
            minStr = '0' + newTime.getMinutes();
        else
            minStr =  newTime.getMinutes();
        if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
        else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
        else
            timeString = (newTime.getHours()-12) + ":" + minStr + " PM";
        if($("#idOpenHour").length==0) {    
                $('#rightaffix').before('<div id="idOpenHour" class="hidepanel alert alert-warning" style="text-align: center; padding: 7px; display: block;"><b>Opens at: '+ timeString + '</b></div>');       
        }
    }
    var isExpected  = false; 
    // render Expected time for Delivery 
          if($("[name=PreDeliveryOpen]").val()=="true"){
                var datemin =Date.parse('01/01/2011 00:00') ; 
                nextOpeningTime.setTime(datemin);
                }
        else
                nextOpeningTime = GetMin_Max_Expexted_Time(currenttime,"d",offsetminsD,dt1Day);
        if(nextOpeningTime !=null && (CurrentDate != nextOpeningTime.getDate() || ((dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())))) ){
            isExpected = true;
            ExpectedtimeD = nextOpeningTime;
            var newTime = nextOpeningTime;
            //newTime.setTime(nextOpeningTime.getTime() + offsetminsD * 60000);
            var timeString = '';
            var minStr = '';    
            if(newTime.getMinutes() < 10)
                minStr = '0' + newTime.getMinutes();
            else
                minStr =  newTime.getMinutes();
            if(newTime.getHours() < 12)
                timeString = newTime.getHours() + ":" + minStr + " AM";
            else if(newTime.getHours() == 12)
                timeString = newTime.getHours() + ":" + minStr + " PM";
            else
                timeString = (newTime.getHours()-12) + ":" + minStr + " PM";
        
             $('#DeliveryTimeNowD').html('<b>Expected delivery time: '+ timeString +'.</b> <br />Please proceed with your order');
        }
    // End 
      if(isExpected==false)
        {
         $('#DeliveryTimeNowD').remove();
       
        }
    isExpected  =false;
    // render Expected time for Collection
          if($("[name=PreCollectionOpen]").val()=="true"){
                var datemin =Date.parse('01/01/2011 00:00') ; 
                nextOpeningTime.setTime(datemin);
                }
        else
                nextOpeningTime = GetMin_Max_Expexted_Time(currenttime,"c",offsetminsC,dt1Day);
        if(nextOpeningTime !=null && (CurrentDate != nextOpeningTime.getDate() || (dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())))  ){
        
            isExpected = true;
            ExpectedtimeC = nextOpeningTime;
            var newTime = nextOpeningTime;
            //newTime.setTime(nextOpeningTime.getTime() + offsetminsC * 60000);
            var timeString = '';
            var minStr = '';    
            if(newTime.getMinutes() < 10)
                minStr = '0' + newTime.getMinutes();
            else
                minStr =  newTime.getMinutes();

            if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
            else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
            else
            timeString = (newTime.getHours()-12) + ":" +minStr + " PM";
            $('#DeliveryTimeNowC').html('<b>Expected collection time: '+ timeString +'.</b> <br />Please proceed with your order.');
        }
    // End 
    if(isExpected==false)
    {
      
        $('#DeliveryTimeNowC').remove();
    }
    /*
    if(dt1.getHours() < nextOpeningTime.getHours() || (dt1.getHours() == nextOpeningTime.getHours() && dt1.getMinutes() < nextOpeningTime.getMinutes())){
        var newTime = new Date();
        newTime.setTime(nextOpeningTime.getTime() + offsetminsD * 60000);
        var timeString = '';
        var minStr = '';    
        if(newTime.getMinutes() < 10)
            minStr = '0' + newTime.getMinutes();
        else
            minStr =  newTime.getMinutes();
        if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
        else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
        else
            timeString = (newTime.getHours()-12) + ":" + minStr + " PM";
        
         $('#DeliveryTimeNowD').html('<b>Expected delivery time: '+ timeString +'.</b> <br />Please proceed with your order');
        
        newTime.setTime(nextOpeningTime.getTime() + offsetminsC * 60000);
         timeString = '';
         if(newTime.getMinutes() < 10)
            minStr = '0' + newTime.getMinutes();
        else
            minStr =  newTime.getMinutes();
        if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
        else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
        else
            timeString = (newTime.getHours()-12) + ":" +minStr + " PM";
         $('#DeliveryTimeNowC').html('<b>Expected collection time: '+ timeString +'.</b> <br />Please proceed with your order.');


        newTime.setTime(nextOpeningTime.getTime());
         timeString = '';
       
        if(newTime.getMinutes() < 10)
            minStr = '0' + newTime.getMinutes();
        else
            minStr =  newTime.getMinutes();
        if(newTime.getHours() < 12)
            timeString = newTime.getHours() + ":" + minStr + " AM";
        else if(newTime.getHours() == 12)
            timeString = newTime.getHours() + ":" + minStr + " PM";
        else
            timeString = (newTime.getHours()-12) + ":" + minStr + " PM";
        if($("#idOpenHour").length==0) {    
                $('#rightaffix').before('<div id="idOpenHour" class="hidepanel alert alert-warning" style="text-align: center; padding: 7px; display: block;"><b>Opens at: '+ timeString + '</b></div>');       
        }

        
    }   
    else{
        $('#DeliveryTimeNowD').remove();
        $('#DeliveryTimeNowC').remove();
    }     */        

    }
  
    function InitCollectionDelivery2() {
             
        var viewport_width = $( window ).width();
       

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
            if( getCookie("p_hour") == "" || getCookie("p_hour")==null)
           // $("select[name=p_hour]", dt).val(hour + 1);
             $("select[name=p_hour]", dt).val(hour);
			
        }

         
        if( getCookie("p_minute") == "" || getCookie("p_minute")==null)
            $("select[name=p_minute]", dt).val(round5(minutes));

			
        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);


        <%if ordertodayonly<>-1 then%>
                var checkout = $('#OrderDate').datepicker({
			
                    onRender: function(date) {
                        return date.valueOf() < now.valueOf() ? 'disabled' : '';
                    }
			
			
                }).on('changeDate', function (ev) {
                    ddate=ev.date;
                    pickeddate=("0" + (ddate.getMonth() + 1)).slice(-2)
                    pickedday=("0" + (ddate.getDate())).slice(-2)
                    ddate2=pickedday.toString() + "/" + pickeddate.toString() + "/"  + ddate.getFullYear().toString()
			
                    $("#OrderDateBox").val(ddate2);
                    StoreToC($("#OrderDateBox"),"OrderDate"); <% ' Store value to cookie for back button remember value%>
                    checkout.hide();
                }).data('datepicker');
        <%end if	%>
			
			
			
			
			
			
                 $("input[name='ordertimeoverride']").click(function() {
			            
                     $.ajax({url: "ajaxdelivery.asp?d=" + $("input[name='orderTypePicker']:checked").val() , success: function(result){
        ReloadShop();
        }});
	
          if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                    offsetmins=$('#collectiondelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins) ; //parseInt(offsetmins)+5;
                    if(ExpectedtimeC == "" || ExpectedtimeC == null ){
                       
                         var dt = new Date(dt1.getTime() + offsetmins2*60000);
                          //  minuteCDefault = offsetmins2*60000;
                        
                    }  
                    else{
                        var dt = ExpectedtimeC;
                                 minuteCDefault = 0;
                    }
	
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                   
                    
                    if(getCookie("p_hour")=="" || getCookie("p_hour") == null)
                        $("select[name=p_hour]", dt).val(dt.getHours());
                    if(getCookie("p_minute")=="" || getCookie("p_minute") == null)
                        $("select[name=p_minute]").val(round5(dt.getMinutes()));
                }
                else  if ($("input[name='orderTypePicker']:checked").val() == 'd') { 
                        
                        offsetmins=$('#deliverydelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins) ; //parseInt(offsetmins)+5;
                    if(ExpectedtimeD == "" || ExpectedtimeD == null ){
                        var dt = new Date(dt1.getTime() + offsetmins2*60000);
                           //minuteDDefault = offsetmins2*60000;
                           

                       } 
                    else{
                        var dt = ExpectedtimeD;
                        minutDDefault= 0
                   
	    }
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                    if(getCookie("p_hour")=="" || getCookie("p_hour") == null)
                        $("select[name=p_hour]", dt).val(dt.getHours());
                    if(getCookie("p_minute")=="" || getCookie("p_minute") == null)
                        $("select[name=p_minute]").val(round5(dt.getMinutes()));
                }
                
	
        }
	
				 
          if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { 	
                    $("#DeliveryDistance").show();  
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                        setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").hide();     
                    $("#DeliveryTime label").text("Delivery Time *");
                    $('#DeliveryTimeNowD').show();
                    $('#DeliveryTimeNowC').hide(); 
                    $('#CollectionAddress').hide();
                    console.log("hide 10");
                } else {
                    $("#DeliveryDistance").hide(); 
                    $("#DeliveryTime label").text("Collection Time *");
                    $("#DeliveryTime").hide();
                    $('#DeliveryTimeNowC').show();
                    $('#CollectionAddress').show();
                    $('#DeliveryTimeNowD').hide();	
                    console.log("show 10");
                }
        } 	
	  
                if ($("input[name='ordertimeoverride']:checked").val() == 'l') { 
                        $('#DeliveryTimeNowD').hide();$('#DeliveryTimeNowC').hide();
                      //  $('#CollectionAddress').hide();
                 if ($("input[name='orderTypePicker']:checked").val() == 'd') { 		
                            $("#DeliveryDistance").show(); 
                            $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                            setTimeout(function () {
                                $("#PreFillDistance").tooltip('hide');
                            }, 3000);
                            $("#DeliveryTime").show();  
                            $("#DeliveryTime label").text("Delivery Time *"); 		  
                            offsetmins=$('#deliverydelay').val();
                            var dt1 = new Date();
                            offsetmins2 = parseInt(offsetmins);//parseInt(offsetmins)+5;
                            var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                            if(getCookie("p_hour")=="" || getCookie("p_hour") == null)
                                $("select[name=p_hour]", dt).val(dt.getHours());
                            if(getCookie("p_minute")=="" || getCookie("p_minute") == null)
                                $("select[name=p_minute]").val(round5(dt.getMinutes()));
	
                } else {  
                        $("#DeliveryDistance").hide();
                        $("#DeliveryTime label").text("Collection Time *");
                        $("#DeliveryTime").show(); 
                        if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                            offsetmins=$('#collectiondelay').val();
                            var dt1 = new Date();
                            offsetmins2 = parseInt(offsetmins) ;// parseInt(offsetmins)+5;
                            var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                            $("select[name=p_hour]", dt).val(dt.getHours());
                            $("select[name=p_minute]").val(round5(dt.getMinutes()));
                        }
                }
	 
        } 	
			 
        });
            

        $("input[name='orderTypePicker']").click(function() {
			 if ($("input[name='orderTypePicker']:checked").val() == 'c') {
                $('#CollectionAddress').show();
                console.log("show 11");
             }
             else {
                $('#CollectionAddress').hide();
                console.log("hide 11");
                }
            $("#nowlater").show();
			
            $.ajax({url: "ajaxdelivery.asp?d=" + $("input[name='orderTypePicker']:checked").val() , success: function(result){
                ReloadShop();
            }});
	
            if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'c') { 
                    offsetmins=$('#collectiondelay').val();
                    var dt1 = new Date();
                    offsetmins2 = parseInt(offsetmins); //parseInt(offsetmins)+5;
                    var dt = new Date(dt1.getTime() + offsetmins2*60000);
	
                    var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                    $("select[name=p_hour]", dt).val(dt.getHours());
                    $("select[name=p_minute]").val(round5(dt.getMinutes()));
                }
	
            }
	
				 
            if ($("input[name='ordertimeoverride']:checked").val() == 'n') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { 
	
                    $("#DeliveryDistance").show();  
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                    setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").hide();  
                    $("#DeliveryTime label").text("Delivery Time *");
                    $('#DeliveryTimeNowD').show();
                    $('#DeliveryTimeNowC').hide();
	                $('#CollectionAddress').hide();
                    console.log("hide 12");
                } else {
                    $("#DeliveryDistance").hide(); 
                    $("#DeliveryTime label").text("Collection Time *"); 
                    $("#DeliveryTime").hide();
                    $('#DeliveryTimeNowC').show();
                    $('#CollectionAddress').show();
                    $('#DeliveryTimeNowD').hide();
                    console.log("show 12");
                }
	 
	 
            } 	
	  
            if ($("input[name='ordertimeoverride']:checked").val() == 'l') { 
	  
                if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show(); 
                    $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                    setTimeout(function () {
                        $("#PreFillDistance").tooltip('hide');
                    }, 3000);
                    $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *");    } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
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

       

         $("input[name='ordertimeoverride']").change(function(){
		
             if ($(this).val() == 'n') {
	
                 if ($("input[name='orderTypePicker']:checked").val() == 'd') {
                     offsetmins=$('#deliverydelay').val();
                 } else {
                     offsetmins=$('#collectiondelay').val();
                 }
                 var dt1 = new Date();
                 var dt = new Date(dt1.getTime() + offsetmins*60000);
	
                 var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                 $("select[name=p_hour]", dt).val(dt.getHours());
                 $("select[name=p_minute]").val(round5(dt.getMinutes()));
	
                 if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show();  
                     $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                     setTimeout(function () {
                         $("#PreFillDistance").tooltip('hide');
                     }, 3000);
                     $("#DeliveryTime").hide();  $("#DeliveryTime label").text("Delivery Time *");  	} else {
                     $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").hide();
	
                 }
             };
	
             if ($(this).val() == 'l') {
                 if ($("input[name='orderTypePicker']:checked").val() == 'd') { $("#DeliveryDistance").show(); 
                     $("#PreFillDistance").tooltip({trigger: 'manual'}).tooltip('show');
                     setTimeout(function () {
                         $("#PreFillDistance").tooltip('hide');
                     }, 3000);
                     $("#DeliveryTime").show();  $("#DeliveryTime label").text("Delivery Time *");   } else {  $("#DeliveryDistance").hide(); $("#DeliveryTime label").text("Collection Time *"); $("#DeliveryTime").show(); 
                 }
   
             } 
         });

    }

 function OnChangePrefillAddress(){
    $('#updateFullPostcode').show();
    $('#PreFillDistance').remove();
    $('#isChangeExistingAddress').val('Y');
    setCookie("DeliveryDistance",'');
    $('#hidLat').val('');
    $('#hidLng').val('');
      $('input[name=deliveryDistance]').val('');
    if(getCookie('Postcode') != '' && getCookie('Postcode') != null && getCookie('Postcode') != undefined){
        $("#validate_pc").val(getCookie('Postcode').replace(/\+/g,' '));
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
    var expires = "expires="+ d.toGMTString();
    document.cookie = encodeURIComponent(cname) + "=" + encodeURIComponent(cvalue) + "; " + expires + ";  path=/";
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
            return decodeURIComponent(c.substring(name.length,c.length));
        }
    }
    return "";
}
     



    function CheckDistanceLatLng(_distance) {
            _distance =_distance || -1;
//            if(getCookie("DeliveryDistance") != "" && _distance == -1)
//                _distance = parseFloat(getCookie("DeliveryDistance"));
            if(($("#hidLat").val() == "" || $("#hidLng").val() == "") && _distance < 0) {
                // var firstResult = $(".pac-container .pac-item:first").text();
                 var firstResult = $("#validate_pc").val();

                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({"address":firstResult }, function(results, status) {
                    if (status == google.maps.GeocoderStatus.OK && results[0]) {
                        var tempLat = results[0].geometry.location.lat(),
                            tempLng = results[0].geometry.location.lng();

                            //$(".pac-container .pac-item:first").addClass("pac-selected");
                           // $(".pac-container").css("display","none");
                            $("#validate_pc").val(results[0].formatted_address);
                            //$(".pac-container").css("visibility","hidden");

                        $("#hidLat").val(tempLat);
                         $("#hidLng").val(tempLng);

                        var tempStreetNumber2 = '', tempRouteName2 = '', tempLocalcity2= '';
		              
                        for (i = 0; i < results[0].address_components.length; i++)
		                {
		                    if (results[0].address_components[i].types[0] == "postal_code") {
		                        $("#hidPostCode").val(results[0].address_components[i].short_name);		                
		                    }
		                    else if (results[0].address_components[i].types[0] == "street_number") {
		                        tempStreetNumber2 = results[0].address_components[i].short_name + ' ';
		                    }
		                    else if (results[0].address_components[i].types[0] == "route") {
		                        tempRouteName2 = results[0].address_components[i].short_name;
		                    }
		                    else if (results[0].address_components[i].types[0] == "locality") {
		                        tempLocalcity2 = results[0].address_components[i].short_name;
		                    }
                            else if (results[0].address_components[i].types[0] == "postal_town") {
		                        tempLocalcity2 = results[0].address_components[i].short_name;
		                    }
                        }
                        if (tempRouteName2 != '') {
                            if(tempStreetNumber2 != '')
                                $("#hidFormattedAdd").val(tempStreetNumber2 + '[*]' + tempRouteName2 + '[*]' + tempLocalcity2);
                            else
                                $("#hidFormattedAdd").val(tempRouteName2 + '[*]' + tempLocalcity2);
                        }
                        else $("#hidFormattedAdd").val(tempLocalcity2);                      
                      
                        CheckDistanceLatLng(_distance);
                    }
                    else 
                    {
                        $('#DeliveryDistance div.delivery_info').hide();  
                        
    
                        $("#updateFullPostcode").show();
                        if($("#PreFillDistance").length > 0 ) {
                          OnChangePrefillAddress();
                        }
                        else {
                             $("#missingPostcodeAlert").show();
                        $("#missingPostcodeAlert").html('<strong>We can not find valid location with your input. Please input valid address/searches or pick your location on a map !</strong>');
                       }
                        $('input[name=distance]', form).val('');
				        $('.delivery_info').addClass('alert-danger');
						$('.delivery_info').removeClass('alert-success'); 
                        return false; 
                    }
                });  
              return ;          
            }

            var DeliveryLat = $("#hidLat").val();
            var DeliveryLng = $("#hidLng").val();    
            if((DeliveryLng == "" || DeliveryLat == '') &&  _distance < 0)
            {
                $('#DeliveryDistance div.delivery_info').hide();   
                $("#missingPostcodeAlert").show();
                $("#missingPostcodeAlert").html('<strong>Please select your deliver location or pick a location on a map!</strong>');
                $('input[name=distance]', form).val('');
				$('.delivery_info').addClass('alert-danger');
						$('.delivery_info').removeClass('alert-success'); 
                return false;
            }
			    
			<%if individualpostcodeschecking=0  then%>
            
           
                var distance;
                 <% if sDistanceCalMethod = "googleapi" then %>
                  
                if(_distance == -1)
                    {
                    GetDistanceGMLatLng(<%=sRestaurantLat %>,<%=sRestaurantLng %>, DeliveryLat, DeliveryLng);
                    return;
                   }
                else distance = _distance;
                 <% else %>
                     
                if(_distance == -1){
                distance = GetDistanceLatLng(DeliveryLat,DeliveryLng,<%=sRestaurantLat %>,<%=sRestaurantLng %>,'K');
                    }
                 else distance = _distance;
                <% end if %>            

                

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
					miles=(Math.round(miles *100) / 100);
                    $("#DeliverySpan").html("Distance: " + miles + " m");
                    //console.log(distance, free_miles, max_miles);
                    if(miles > max_miles)
                    {
                        $('.delivery_info').hide();   
                        $("#missingPostcodeAlert").show();
                        $("#missingPostcodeAlert").html('This Takeaway Only Offers <strong>Collection</strong> To Your Postcode');                       
                        $('input[name=distance]', form).val('');
                          $('input[name=deliveryDistance]', form).val('');
						$('.delivery_info').addClass('alert-danger');
						$('.delivery_info').removeClass('alert-success'); 
                    }
                    else
                    {
						var total = parseFloat($("#SubTotal").val());
					
					    //setCookie("validate_pc", $("#validate_pc").val(), 60*24);
                        //alert($("#validate_pc").val());
                        StoreToC($("#validate_pc"),"validate_pc");
                        //alert(getCookie("validate_pc"));
						if (total><%=sDeliveryChargeOverrideByOrderValue%>) {
						
						$("#missingPostcodeAlert").hide();
					
                        $('.delivery_info').show();
						$('#delivery_fee').text('0'); 
                        $('input[name=deliveryDistance]', form).val(miles);
						 $('#showdistance').html(miles + ' <%=mileskm%>');
						  $.ajax({url: "ajaxdeliverydistance.asp?d=" + miles , success: function(result){
	ReloadShop();
    }});
                       
                        $('div.beforeorder').css('border-color', '#E9EAEB');
						
						$('.delivery_info').removeClass('alert-danger');
                        $("#delivery-info").html("Great! Continue ordering");
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
                             $("#updateFullPostcodeSubmit").tooltip("destroy");  
                                 $("#updateFullPostcodeSubmit").attr("title","You can now Continue to place your order");
                              $("#updateFullPostcodeSubmit").attr("data-original-title","You can now Continue to place your order");
                              $("#updateFullPostcodeSubmit").tooltip({trigger: 'manual'}).tooltip('show');
                               setTimeout(function(){
                        
                                    $("#updateFullPostcodeSubmit").tooltip('destroy');
                                    $("#updateFullPostcodeSubmit").attr("data-original-title","Remember to Check your address");
                                }, 3000);  
	ReloadShop();
    }});
                       
                        $('div.beforeorder').css('border-color', '#E9EAEB');
						
						$('.delivery_info').removeClass('alert-danger');
                        $("#delivery-info").html("Great! Continue ordering");
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
    
           
			
			<%else%>
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
                     $("#updateFullPostcodeSubmit").tooltip("destroy");  
                              $("#updateFullPostcodeSubmit").attr("data-original-title","You can now Continue to place your order");
                              $("#updateFullPostcodeSubmit").tooltip({trigger: 'manual'}).tooltip('show');
                               setTimeout(function(){
                        
                                    $("#updateFullPostcodeSubmit").tooltip('destroy');
                                    $("#updateFullPostcodeSubmit").attr("data-original-title","Remember to Check your address");
                                }, 3000);  
	ReloadShop();
    }});
					   $('input[name=deliveryPC]', form).val(zipcode);
					
                   
}

)
				
				
				
                     
                      
                        $('div.beforeorder').css('border-color', '#E9EAEB');
						$('.delivery_info').removeClass('alert-danger');
                        $("#delivery-info").html("Great! Continue ordering");
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
    
    function GetDistanceLatLng(lat1, lon1, lat2, lon2, unit) {
	var radlat1 = Math.PI * lat1/180
	var radlat2 = Math.PI * lat2/180
	var theta = lon1-lon2
	var radtheta = Math.PI * theta/180
	var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
	dist = Math.acos(dist)
	dist = dist * 180/Math.PI
	dist = dist * 60 * 1.1515
	if (unit=="K") { dist = dist * 1.609344 }
	if (unit=="N") { dist = dist * 0.8684 }
	return dist
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
    var localTime = new Date();
   
    if(<%=(houroffset * 60) - Application("ServerGMTOffset") - DSTMinute  %> != -localTime.getTimezoneOffset()  - <%=DSTMinute %> ) {
        alertTime = true;
        alert("The server date/time seems to be different from your device. Please check your device settings or contact us.");   
    } 

    $("#validate_pc").keydown(function(e) {
           if(!$("#DeliveryDistance").find('.tooltip').hasClass('in'))
                $("#updateFullPostcodeSubmit").tooltip({trigger: 'manual'}).tooltip('show');    
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
    
    });

   window.onunload = function(){}; 
    /*! Reloads page on every visit */
    function Reload() {
        try {
        var headElement = document.getElementsByTagName("head")[0];
        if (headElement && headElement.innerHTML)
            headElement.innerHTML += " ";
        } catch (e) {}
    }

    /*! Reloads on every visit in mobile safari */
    if ((/iphone|ipod|ipad.*os 5/gi).test(navigator.appVersion)) {
        window.onpageshow = function(evt) {
            if (evt.persisted) {
                document.body.style.display = "none";
                location.reload();
            }
        };
    }
</script>

    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', '<%=googleecommercetrackingcode %>', 'auto');
  ga('send', 'pageview');

</script>
</body>
</html>
