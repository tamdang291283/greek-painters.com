<%session("restaurantid")=Request.QueryString("id_r")%>
<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<% 
   
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
 
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
    sRestaurantLat = ""
    sRestaurantLng = ""
   
    sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
    sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))

    objCon.Open sConnString
     objRds.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & vRestaurantId, objCon

    
'check opening times
Set objCon2 = Server.CreateObject("ADODB.Connection")
Set objRds2 = Server.CreateObject("ADODB.Recordset") 
objCon2.Open sConnString
objRds2.Open "SELECT *  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeek & " order by DayOfWeek, Hour_From", objCon
'loop through opening time
isopen=false
Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
'response.write sHour
 if DateDiff("n",objRds2("Hour_From"),objRds2("Hour_To"))<0 then
	if (sHour >= objRds2("Hour_From") and sHour <= "23:59:00") or (sHour >= "00:00:00"  and sHour <= objRds2("Hour_To") ) Then
		sisopen=true
	end if
 else
	if (objRds2("Hour_From") <= sHour and objRds2("Hour_To") >= sHour) Then
		sisopen=true
	end if
end if
objRds2.MoveNext    
Loop
objCon2.Close 
objRds2.Close
'if it is has found not to be open and time is early morning then check previous days time
if isopen=false and DateDiff("n",sHour,"12:00:00")>0 then
sDayOfWeekprev=sDayOfWeek-1
if sDayOfWeekprev=0 then
sDayOfWeekprev=7
end if
objCon2.Open sConnString
objRds2.Open "SELECT *  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeekprev, objCon
Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
 if DateDiff("n",objRds2("Hour_From"),objRds2("Hour_To"))<0 then
	if (sHour <= objRds2("Hour_To")) Then
		sisopen=true
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
 
	 if objRds("businessclosed")=-1 then
	 response.redirect "closed.asp?id_r=" & vRestaurantId
	 end if
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Menu - <%= objRds("Name")%></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  
  
	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="Scripts/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/datepicker.css" rel="stylesheet">
	<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/addtohomescreen.css">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <link rel='shortcut icon' href='images-icons/favicon.ico' type='image/x-icon'/ >
 
 

<meta name="apple-mobile-web-app-title" content="<%= objRds("Name")%>">

<link rel="shortcut icon" sizes="16x16" href="images-icons/icon-16x16.png">
<link rel="shortcut icon" sizes="196x196" href="images-icons/icon-196x196.png">
<!--link rel="apple-touch-icon-precomposed" sizes="152x152" href="images-icons/icon-152x152.png">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="images-icons/icon-144x144.png">
<link rel="apple-touch-icon-precomposed" sizes="120x120" href="images-icons/icon-120x120.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="images-icons/icon-114x114.png">
<link rel="apple-touch-icon-precomposed" sizes="76x76" href="images-icons/icon-76x76.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="images-icons/icon-72x72.png"-->
<link rel="apple-touch-icon-precomposed" href="images-icons/icon-152x152.png">

  
	<script type="text/javascript" src="Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="Scripts/js.cookie.js"></script>
	
	
	<script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="Scripts/scripts.js"></script>
	
    <script src="Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&libraries=places"></script>
	
	
	<link rel="stylesheet" href="scripts/fancybox/jquery.fancybox.css?v=2.1.5" type="text/css" media="screen" />
    <script type="text/javascript" src="scripts/fancybox/jquery.fancybox.pack.js?v=2.1.5"></script>	
    <script src="scripts/Locationpicker.js?_=121"></script>

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
.pac-container {z-index:10000;}
</style>

<script>


    
function scrollToV2(id)
{
  // Scroll
  $('html,body').animate({scrollTop: $("#"+id).offset().top-160},'slow');
}
   
$(window).load(function() {

 if ($(window).width() <= 1000) {  

             $(window).off('.affix');
$('#rightaffix').removeData('bs.affix').removeClass('affix affix-top affix-bottom');

       }

$(window).resize(function(){

       if ($(window).width() <= 1000) {  

             $(window).off('.affix');
$('#rightaffix').removeData('bs.affix').removeClass('affix affix-top affix-bottom');

       }     

});


$('.movedown').click(function(e){
$('.navbar-collapse').collapse('hide');
scrollToV2($(this).attr('data'),{duration:'slow', offsetTop : '-100'});
   
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
    responsive();
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

$("#AnnouncementModal div.modal-body").html('<%=replace(objRds("announcement"),vbCrLf,"<BR>")%>');
                $("#AnnouncementModal").modal();
				
<%end if%>
	
});


	


function responsive(){
   var winWidth = $(window).width();
   if(winWidth < 992) { 

   	 $("#header").addClass("navbar-fixed-top");
  $("body").css( "padding-top", "80px" );
  
    }  else {
	$("#header").removeClass("navbar-fixed-top");
	 $("body").css( "padding-top", "0px" );
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

<body>
<div class="loader"></div>
<div class="container" id="wholepage" style="padding-bottom:100px;display:none;">

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


<a href="https://www.google.co.uk/maps?q=<%= objRds("Address") %>" target="_blank"><span class="glyphicon glyphicon-map-marker"></span></a>
<a href="tel:<%= objRds("Telephone") %>"><span class="glyphicon glyphicon-earphone"></span></a>
<a href="mailto:<%= objRds("Email") %>"><span class="glyphicon glyphicon-envelope"></span></a></div>


</div>	
						 <%= objRds("Name") %>

					</h4><div class="hidden-xs"><b><%= objRds("Address") %> </b><br></div>


<%= objRds("FoodType") %>
					
			</div>
			</div>
		</div>
		 <%            
            objRds.Close
            objCon.Close
        %>	
		<nav class="navbar navbar-default  navmobile" role="navigation">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Categories</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse scrollable-menu" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      <%
                        objCon.Open sConnString
                        objRds.Open "SELECT DISTINCT mc.*, mc.Name as Name FROM MenuCategories AS mc INNER JOIN MenuItems AS mi ON mc.Id = mi.IdMenuCategory WHERE  mc.IdBusinessDetail=" & vRestaurantId & " and (((mi.idbusinessdetail)=" & vRestaurantId & ")) and mi.hidedish<>-1 ORDER BY mc.displayorder;", objCon
xcnt=0
                        Do While NOT objRds.Eof
						xcnt=xcnt+1
                        %>
                        <li ><a href="javascript:;" class="movedown" data="p<%=xcnt%>">
                            <%=objRds("Name") %></a> </li>
                        <%
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        objCon.Close
                        %>
	 
	   
        
      </ul>
      
      
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
	</div>
	<div class="row clearfix">
		<div class="col-md-2" id="categories">
		
		<div data-spy="affix" data-offset-top="60" data-offset-bottom="200">
			<div style="width:165px; height : 450px; overflow : auto; " class="hidden-xs"><ul class="nav nav-stacked nav-pills navdesktop" style="width:155px;overflow : auto;    height: 80vh;">
				<li class="active">
					<a href="#"><b>Categories</b></a>
				</li>
				
			
				
			   <%
                        objCon.Open sConnString
                        objRds.Open "SELECT DISTINCT mc.*, mc.Name as Name FROM MenuCategories AS mc INNER JOIN MenuItems AS mi ON mc.Id = mi.IdMenuCategory WHERE  mc.IdBusinessDetail=" & vRestaurantId & " and (((mi.idbusinessdetail)=" & vRestaurantId & "))  and mi.hidedish<>-1 ORDER BY mc.displayorder;", objCon
xcnt=0
                        Do While NOT objRds.Eof
						xcnt=xcnt+1
                        %>
                        <li ><a href="#p<%=xcnt%>" class="catlink">
                            <%= objRds("Name") %></a> </li>
                        <%
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        objCon.Close
                        %>
				
			</ul>
			</div></div>
		</div>
		<div class="col-md-7 column" id="mainmenu">
			<ul class="nav nav-stacked nav-pills">
			
				</ul>
				
                    <% 
                
                Dim vCategoryId                
                Dim vMenuItemId
                Dim vMenuItemPrice
                Dim vMenuItemPropertyId                
                
                objCon.Open sConnString
                objRds.Open "SELECT mc.Name AS CategoryId, mc.Name AS CategoryName,mc.IdBusinessDetail , mc.Description AS CategoryDescription, mi.*, mi.Name AS Name, mip.Id AS PropertyId, mip.Name AS PropertyName, mip.Price AS PropertyPrice, mi.allowtoppings as miallowtoppings, mip.allowtoppings as mipallowtoppings, mi.dishpropertygroupid as midishpropertygroupid FROM (MenuCategories AS mc INNER JOIN MenuItems AS mi ON mc.Id = mi.IdMenuCategory) LEFT JOIN MenuItemProperties AS mip ON mi.Id = mip.IdMenuItem WHERE  mc.IdBusinessDetail=" & vRestaurantId & " and (((mi.idbusinessdetail)=" & vRestaurantId & "))  and mi.hidedish<>-1  ORDER BY mc.displayorder, mi.Name, mip.Name;", objCon
				
				
			
                
                vCategoryId = -1
                vMenuItemId = -1
                
				oldName=""
				xcnt=0
                Do While NOT objRds.Eof 
				
                         code=0
						 photo=0               
                    vMenuItemPrice = objRds("Price")
                    vMenuItemPropertyId = -1

                    If Not IsNull(objRds("PropertyId")) Then
                        vMenuItemPrice = objRds("PropertyPrice")
                        vMenuItemPropertyId = objRds("PropertyId")                        
                    End If

                    If vCategoryId <> objRds("CategoryId") Then 
					xcnt=xcnt+1
					%>
                    <h4>
                        <a id="p<%=xcnt%>" name="p<%=xcnt%>"></a>
                            <%= objRds("CategoryName")%>   
                    </h4><%= objRds("CategoryDescription")%>
                    <%
                        vCategoryId = objRds("CategoryId")
                
                    End If %>

					<%if oldName=objRds("Name") then%>

                    <div class="row margin20 clearfix ">
					<%else%>
					 <div class="row margin20 clearfix bordertop">
					<%end if%>
				
                  
                            <% If vMenuItemId <> objRds("Id") Then %>
                                
                                <%
							
								If objRds("Photo") <> "" Then 
								photo=1%>
                              <div  class="product10w photo" data-toggle="modal" data-target="#lightbox">    <img src="Images/<%=vRestaurantId %>/<%= objRds("Photo")%>" class="img-rounded" alt="<%= objRds("Name")%>"
                                    style="vertical-align: top;width:98%;max-width:40px;" /> 
									
									
									<div class="overlay">
		<a href="javascript:;"  class="magnifying-glass-icon foobox">
			<i class="fa fa-search"></i>
		</a>
	</div>
									
          
        
						</div>			
                                <%End If %>
								 
                                <%
								
								If objRds("Code") <> "" Then 
								code=1%>
                                   <div class="product10w code"> <%= objRds("Code") %>.</div>
                                <%End If %>
                  <%if photo=0 then%>
				  <%if code=0 then%>
                         <div class="product100w desc">
						 <%else%>
						  <div class="product90w desc"><%end if%>
						 <%else%>
						 <%if code=0 and photo=1 then%>
						 <div class="product90w  desc">
						 <%else%>
						    <div class="product80w desc ">
						 <%end if%> <%end if%> 
                                <%= objRds("Name") %>
                                <%If objRds("Vegetarian") Then %>
                                <img src="Images/veggie_small.png" alt="veggie" />
                                <%End If %>
                                <%If objRds("Spicyness") > 0 Then %>
                                <img src="<%= "Images/spicy_" & objRds("Spicyness") & ".png"%>" alt="spicy" />
                                <%End If %><br />
                                <i><span class="small"><%= objRds("Description") %></span></i>
								
                            </div>  
							
							
							<%if code=1 and photo=0 then%>
							<div class="product50w toppad15 desc " style="clear:both">&nbsp;</div>
							<%end if%>
							<%if code=0 and photo=1 then%>
							<div class="product50w toppad15 desc " style="clear:both">&nbsp;</div>
							<%end if%>
							<%if code=1 and photo=1 then%>
							<div class="product50w toppad15 desc " style="clear:both">&nbsp;</div>
							<%end if%>
                            <% 
                                vMenuItemId = objRds("Id")
                            End If %>
                      <%if code=0 and photo=0 then%>
					  <div class="product50w">&nbsp;</div>
					  
					  <%if oldName=objRds("Name") then%>

                    <div class="product20w toppad15 bordertop">
					<%else%>
				 <div class="product20w toppad15 ">
					<%end if%>
					  
                       
					   <%else%>
					  
						 
						   <%if oldName=objRds("Name") then%>

                    <div class="product20w toppad15 bordertop">
					<%else%>
				 <div class="product20w toppad20 ">
					<%end if%>
						 <%end if%>
                          <%= objRds("PropertyName")%>&nbsp;
						 
						 
								
								
								  <%donotshowprice="n"
								  dishpropertiestext=""
								  pricefrom=0
								' code to check if other dish properties are applicable to this product
								if objRds("dishpropertygroupid")<>"" then%>
								
								
								<%
								Set objCon_properties = Server.CreateObject("ADODB.Connection")
								Set objRds_properties = Server.CreateObject("ADODB.Recordset") 
          
								objCon_properties.Open sConnString
                objRds_properties.Open "SELECT * FROM MenuDishpropertiesGroups where id in (" & objRds("dishpropertygroupid") & ")", objCon

				Do While NOT objRds_properties.Eof 

								
dishpropertiestext =  dishpropertiestext & objRds_properties("dishpropertygroup") & ":<br> <select name=""" & objRds_properties("id") & """ id=""" & objRds_properties("id") & """ class=""dishproperty"" data-group=""dishproperties" & vMenuItemId & "-" & vMenuItemPropertyId & """"

if objRds_properties("dishpropertyrequired")<>-1  then
dishpropertiestext = dishpropertiestext & " data-required=""n"">"
dishpropertiestext = dishpropertiestext & "><option value=""0"">-- select --</option>"
else
dishpropertiestext = dishpropertiestext & " data-required=""y"" data-caption=""Please choose " & replace(objRds_properties("dishpropertygroup"),"""","") & """>"
dishpropertiestext = dishpropertiestext & "><option value=""0"">-- select --</option>"

end if
						
								Set objCon_propertiesitems = Server.CreateObject("ADODB.Connection")
								Set objRds_propertiesitems = Server.CreateObject("ADODB.Recordset") 
          
								objCon_propertiesitems.Open sConnString
                objRds_propertiesitems.Open "SELECT * FROM MenuDishproperties where dishpropertygroupid=" & objRds_properties("id") & " order by dishpropertyprice", objCon
				pricecnt=0
				
				
				
				Do While NOT objRds_propertiesitems.Eof 
				add=""
				
				if objRds_properties("dishpropertypricetype")="add" then
				add=" - add "
				
				else
				donotshowprice="y"
				if pricecnt=0 then
					pricefrom=objRds_propertiesitems("dishpropertyprice")
					'response.write "x"
				end if
				end if
				
				
				dishpropertiestext = dishpropertiestext & "<option value=""" & objRds_propertiesitems("id") & """>" & objRds_propertiesitems("dishproperty") & add & " " &  CURRENCYSYMBOL & FormatNumber(objRds_propertiesitems("dishpropertyprice"),2) & "</option>"
				
				
				
							objRds_propertiesitems.MoveNext
							pricecnt=pricecnt+1
        Loop 
								
						
							
							dishpropertiestext = dishpropertiestext & "</select><br>"
					
							
								
								objRds_properties.MoveNext
        Loop 
								end if%>
								
								 <%
								' code to check if toppings are applicable to this product
								dishtoppingstext=""
								if objRds("miallowtoppings")<>0 then%>
								
								<%
								Set objCon_toppings = Server.CreateObject("ADODB.Connection")
								Set objRds_toppings = Server.CreateObject("ADODB.Recordset") 
          
								objCon_toppings.Open sConnString
                objRds_toppings.Open "SELECT * FROM MenuToppings where toppinggroupid=" & objRds("miallowtoppings") & " and IdBusinessDetail=" & vRestaurantId, objCon
				Do While NOT objRds_toppings.Eof 
				
				dishtoppingstext = dishtoppingstext &  "<input type=""checkbox"" class=""topping"" name=""" & objRds_toppings("topping") & """ value=""" & objRds_toppings("id") & """ data-group=""toppings" & vMenuItemId & "-" & vMenuItemPropertyId & """> " & objRds_toppings("topping") & " - " & CURRENCYSYMBOL & FormatNumber(objRds_toppings("toppingprice"),2) & "<BR>"
				

								
								objRds_toppings.MoveNext
        Loop 
								end if
								
								if objRds("mipallowtoppings")<>0 then%>
								
								<%
								Set objCon_toppings = Server.CreateObject("ADODB.Connection")
								Set objRds_toppings = Server.CreateObject("ADODB.Recordset") 
          
								objCon_toppings.Open sConnString
                objRds_toppings.Open "SELECT * FROM MenuToppings where toppinggroupid=" & objRds("mipallowtoppings") & " and IdBusinessDetail=" & vRestaurantId, objCon
				Do While NOT objRds_toppings.Eof 
				
				dishtoppingstext = dishtoppingstext &  "<input type=""checkbox"" class=""topping"" name=""" & objRds_toppings("topping") & """ value=""" & objRds_toppings("id") & """ data-group=""toppings" & vMenuItemId & "-" & vMenuItemPropertyId & """> " & objRds_toppings("topping") & " - " & CURRENCYSYMBOL & FormatNumber(objRds_toppings("toppingprice"),2) & "<BR>"
				

								
								objRds_toppings.MoveNext
        Loop 
								end if
								%>
								
                        </div>
						
						  <%if oldName=objRds("Name") then%>

                   <div class="product20w toppad15 rightpad10 bordertop">
					<%else%>
				      <div class="product20w toppad15 rightpad10 ">
					<%end if%>
						
                  <%noprice=0%>
                            <% If Not IsNull(vMenuItemPrice) and donotshowprice="n" Then %>
                            <div align="right" class="toppad5"><b><%=CURRENCYSYMBOL%><%= FormatNumber(vMenuItemPrice, 2) %></b></div>
                            <% noprice=1
							End If %>
							
							<%if pricefrom<>0 then%>
								<div align="right" class="toppad5"><b>from <%=CURRENCYSYMBOL%><%=pricefrom%></b></div>
								<%noprice=1
								end if%>
								
								<%if noprice=0 then%>&nbsp;<%end if%>
                        </div>
						
									  <%if oldName=objRds("Name") then%>

                  <div class="product10w toppad10 bottompad10 rightpad10 bordertop">
					<%else%>
				        <div class="product10w toppad10 bottompad10 rightpad10 ">
					<%end if%>
						
                     
                            <% If Not IsNull(vMenuItemPrice) Then %>
							
                           <div align="right">
						   <%if dishpropertiestext="" and dishtoppingstext="" then%>
						   <button class="btn btn-success btnadd" onclick="Add(<%=vMenuItemId %>,<%=vMenuItemPropertyId%>);">
						
                                <span class="glyphicon glyphicon-plus"></span></button>
								<%else%>
								
								<a class="btn btn-success btn-xs  dishpropertiesbutton" onclick="Showdishproperties('dishproperties<%=vMenuItemId %>-<%=objRds("PropertyId")%>');" style="padding:5px;">Options</a>
								<% End If %>
								
								</div>
                            
							<% End If %>
                        </div>
                    </div>
					
					<%if dishpropertiestext<>"" or dishtoppingstext<>"" then%>
					<div class="row  clearfix dishproperties" id="dishproperties<%=vMenuItemId %>-<%=objRds("PropertyId")%>">
					
					<div  class="product50w  leftpad20 desc">
					<%if dishpropertiestext<>"" then%>
					<b>Dish Properties</b><br>
					
					<%=dishpropertiestext%>
					<%end if%>&nbsp;</div>
					<div  class="product40w  desc mobilefloat">
					<%if dishtoppingstext<>"" then%>
					<b>Toppings</b><br>
					<%=dishtoppingstext%>
					<%else%>
					<%end if%></div><div class="product10w toppad10 bottompad10 rightpad10 mobilebutton">
                            
                           <div align="left">
						   
						   <button class="btn btn-success btnadd" onclick="Add(<%=vMenuItemId %>,<%=vMenuItemPropertyId%>);">
						
                                <span class="glyphicon glyphicon-plus"></span></button></div>
                            
                        </div></div>
					
					<%end if%>
					
                    <%oldName=objRds("Name")
                    objRds.MoveNext    
                Loop
                objRds.Close
                objCon.Close
                    %>
                
				      




		</div>
		<div class="col-md-3 column" id="pricecolumn">
		
		
		<div class="panel panel-default" id="noorders" style="display:none;">
  <div class="panel-heading" >
    <h3 class="panel-title">Ordering available during opening hours only</h3>
  </div></div>
		
	
			<div class="panel panel-default" id="beforeorder" >
  
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
					   
                        
                         <div id="DeliveryTime" class="form-group hidepanel" style="text-align:center;" >
                            <label for="control-label">
                                <%if disabledelivery="Yes" then%>Collection<%else%>Delivery<%end if%> Time *</label>
                    
                              
									<div class="clearfix"></div>
									<div class="input-group" style="width:130px;float:left;">

  
	
	
	<%if ordertodayonly=-1 then%>
	

  <div id="OrderDate"  data-date="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" data-date-weekStart="1"
 data-date-format="dd/mm/yyyy">
<div class="input-group">
 <input size="11" type="text"  value="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" id="OrderDateBox" class="  form-control" style="padding-left:3px;" disabled/>
  
   </div>
<%else%>

  <div id="OrderDate"  data-date="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" data-date-weekStart="1" data-date-format="dd/mm/yyyy">
<div class="input-group">
 <input size="11" type="text"  value="<%= FormatEngDate(DateAdd("h",houroffset,now)) %>" id="OrderDateBox" class="  form-control" style="padding-left:3px;"/>
   <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
   </div>
   <%end if%>


	
</div></div>
									
                                    
                          	<div class="visible-md"><br><br>
							</div>       
                              
                                <select name="p_hour" style="padding: 0; width: 51px;float:left;" class="form-control">
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
                                <select name="p_minute" style="padding: 0; width: 51px;float:left;" class="form-control">
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
                            <form id="updateFullPostcode" class="">													
                            <p class="delPostcodeLabel text-centered">
                                <strong>Delivery Postcode:</strong>
                            </p>
                            <p style="margin-left: 33px;" class="text-centered">
							
							<div class="input-group">
    
      <input type="text" class="form-control" name="validate_pc" id="validate_pc">
         <input type="hidden" readonly="readonly" name="hidLat" id="hidLat" />
    <input type="hidden" readonly="readonly" name="hidLng" id="hidLng" />
	    <span class="input-group-btn">
        <button class="btn btn-default btngreen" type="button" onclick="CheckDistance();" id="updateFullPostcodeSubmit" >Go!</button>
      </span>
      
	
    </div>
     <div>
         <a id="fancyBoxMap" class="fancybox" data-popup="#divFancyMap" href="#divFancyMap">Show map</a>
    <div id="divFancyMap" style="width:100%; height:80%; display:none; position: absolute;">
        <fieldset class="gllpLatlonPicker" id="gllpLatlonPicker1">
            <p style="display:block;text-align:center">Type a location name or mark it on the map:</p>
           
            <input type="text" style="display:block;margin:3px auto;width:80%;max-width:400px;" class="gllpSearchField pac-input" id="txtFancySearch" />
            <input type="button" style="display:block;margin:10px auto;background-color:#FEC752;border-color:#FEC752;" class="btn btn-default gllpSearchButton" value="Search" />            
            
            <div class="gllpMap">Google Maps</div>
            <div style="width:100%;text-align:center;">
            <input type="button" style="margin:10px auto;background-color:#FEC752;border-color:#FEC752;" class="btn btn-default" value="OK" onclick="CloseMap(true);" />
            <input type="button" style="margin:10px auto;background-color:#FEC752;border-color:#FEC752;" class="btn btn-default" value="Cancel" onclick="CloseMap(false);" />
                </div>
            <input type="hidden" readonly="readonly" class="gllpLatitude" value="20" />
            <input type="hidden" readonly="readonly"  class="gllpLongitude" value="20" />
            <input type="hidden" readonly="readonly"  class="gllpZoom" value="3" />
            
        </fieldset>


     </div>   
    </div>
		 <div id="showdistance" align="center" style="clear:both;"></div>					
							
                                
                    <!--             <span id="DeliverySpan">&nbsp;</span> -->
				            </p>
                            <div class="alert alert-danger" id="missingPostcodeAlert">Enter Your <strong>Full Postcode and <span style="color:#49cb29;">press GO.</span></strong>
								<br>
</div>


           <div class="alert alert-danger" id="missingPostcodeAlert2">We don't deliver to that postcode.
</div>
   <div class="alert alert-danger" id="missingPostcodeAlert3">Postcode must contain a space.
</div>

<!-- Delivery charge: <%=CURRENCYSYMBOL%><%=sDeliveryFee%> for over <%=sDeliveryFreeDistance%> miles<br>


Max. delivery distance: <%=sDeliveryMaxDistance%> miles -->
                   
                            <div class="delivery_info alert alert-danger" style="display:visible;">    
							
						
							                                
                                <span id="df">Delivery Charge: <%=CURRENCYSYMBOL%><span id="delivery_fee"><%=sDeliveryFee%><%if sDeliveryFreeDistance>0 then%> for over <%=sDeliveryFreeDistance%> <%=mileskm%>.<%end if%></span></span><br />
								Max. delivery distance: <%=sDeliveryMaxDistance%> <%=mileskm%><br>
								<%if sDeliveryFreeDistance>0 then%>Free delivery up to: <%=sDeliveryFreeDistance %> <%=mileskm%><br><%end if%>
								<% if sDeliveryChargeOverrideByOrderValue <> 1000000000 Then %>Free delivery for orders over <%=CURRENCYSYMBOL%><%=sDeliveryChargeOverrideByOrderValue%><br> <%end if %> 
								
									
				                Minimum Order: <%=CURRENCYSYMBOL%><%= sDeliveryMinAmount %>		
                            </div>
                        </form>
                        </div>
						<div class="clear-both">
						</div>
                                                               
                    
  </div>
</div>




	<div id="rightaffix" <%if STICK_MENU="Yes" then%>data-spy="affix" data-offset-top="300" data-offset-bottom="200"<%end if%>>
<div class="panel panel-primary"  id="basket"  >
  <div class="panel-heading">
    <h3 class="panel-title"><span class="glyphicon glyphicon glyphicon-shopping-cart"></span> Your order</h3>
  </div>
  <div class="panel-body" id="footerbasket">
   
                         

                        <form id="CheckOutForm" action="CheckOut.asp?id_r=<%=vRestaurantId%>" method="post">                
                        <input type="hidden" name="deliveryDistance" id="distance" value="" />
                        <input type="hidden" name="deliveryType" value="" />
						<input type="hidden" name="deliverydelay" id="deliverydelay" value="<%=sAverageDeliveryTime%>" />
						<input type="hidden" name="collectiondelay" id="collectiondelay" value="<%=sAverageCollectionTime%>" />
                        <input type="hidden" name="deliveryPC" value="<%=request.querystring("postcode")%>" />
                        <input type="hidden" name="deliveryTime" value="" />
						<input type="hidden" name="asaporder" value="" />
						<input type="hidden" name="special" value="" />
                   </form>
                        <div id="shoppingcart"></div>                        
          

                                   
                    
  </div>
</div>



<div class="panel panel-default" >
  <div class="panel-heading"  >
          <h3 class="panel-title">Voucher code</h3>
  </div>
        <div class="panel-body">           
                        
						
						
						<div class="row">
  <div class="col-xs-7">
  
    <label class="sr-only" for="vouchercode">Enter code</label>
    <input type="text" class="form-control noSubmit" id="vouchercode" name="vouchercode" placeholder="Enter code">
  </div> <div class="col-xs-3">
  
   
  
   <button  class="btn btn-default" onclick="VoucherCode();">Submit</button>
 </div>
 
 <div class="col-xs-1">&nbsp;</div>
 
              
                    </div>
    </div>
 </div>



<div class="panel panel-danger" >
  <div class="panel-heading"  >
          <h3 class="panel-title">Opening hours</h3>
  </div>
        <div class="panel-body">           
                        <table border="0" width="100%">
                            <% 
                        objCon.Open sConnString
                        objRds.Open "SELECT oi.* " & _
                        " FROM openingtimes oi " & _
                        " where oi.IdBusinessDetail = " & vRestaurantId & _
                        " order by DayOfWeek, Hour_From", objCon
                        Dim jsDate
                        jsDate = ""
						jscnt=0
						currentdayofweek=""
                        Do While NOT objRds.Eof 
             jscnt=jscnt+1
                            if jsDate <> "" Then jsDate = jsDate & ","
                            jsDate = jsDate & jscnt & ": { min:Date.parse('01/01/2011 " & FormatDateTime(objRds("Hour_From"), vbShortTime) & "'),  max: Date.parse('01/01/2011 " & FormatDateTime(objRds("Hour_To"), vbShortTime) & "'), d:'" & objRds("DayOfWeek") & "', delivery:'" & objRds("delivery") & "', collection:'" & objRds("collection") & "'}"
                            %>
                            <tr>
                                <td style="width: 30px">
								<%if currentdayofweek<>objRds("DayOfWeek") then%>
                                    <%= WeekdayName(objRds("DayOfWeek"), true, vbMonday) %>
									<%end if%>
                                </td>
                                <td>
                                  <div align="right"> <%if objRds("collection")="n" then%><img src="Images/no-collection.gif" width="18" data-toggle="tooltip" data-placement="left" title="Collection is not available during this time slot"></i> <%end if%> <%if objRds("delivery")="n" then%><img src="Images/no-delivery.gif" width="18" data-toggle="tooltip" data-placement="left" title="Delivery is not available during this time slot"></i> <%end if%> <%= FormatDateTime(objRds("Hour_From"), vbShortTime) %>
                                    - <%= FormatDateTime(objRds("Hour_To"), vbShortTime)  %></div>
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
		
            $("#shoppingcart").load("ShoppingCart.asp?id_r=<%= vRestaurantId %>"); 
	                
        }

        function Add(mi, mip) {
		
		
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
           $("#shoppingcart").load("ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=add&mi=" + mi + "&mip=" + mip + "&toppingids=" + toppingschosen + "&dishproperties=" + dishproperties);
}
 
        }
		
	

        function Del(itemId) {
	
            $("#shoppingcart").load("ShoppingCart.asp?id_r=<%= vRestaurantId %>&op=del&id=" + itemId);

        }
		
		 function Showdishproperties(itemtoshow) {
	
            $("#" + itemtoshow).slideToggle();

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

        function CheckDistance() {
            CheckDistanceLatLng();
            return false;
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
			
			<%if individualpostcodeschecking=0 then%>
            
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
           	for (key in jsDate) {
			if (jsDate[key].d==days) {
			if (jsDate[key].max<jsDate[key].min) {
			 if ((_time >= jsDate[key].min && _time <= Date.parse('01/01/2011 23:59')) || (_time >= Date.parse('01/01/2011 00:00') && _time <=jsDate[key].max )) {
				if (jsDate[key].collection=='n') {
					nodelivery=1;
					}
			 isopen=1;
			 }
			} else {
			
			if (jsDate[key].min <= _time && jsDate[key].max >= _time) {
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
			dayprev=days;
			if (daysprev=0) {
			dayprev=7;
			}
			for (key2 in jsDate) {
   			if (jsDate[key].d==dayprev) {
						if ( jsDate[key].max<jsDate[key].min ) {
							if ( _time <= jsDate[key].max) {
							if (jsDate[key].collection=='n') {
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
           	for (key in jsDate) {
			if (jsDate[key].d==days) {
			if (jsDate[key].max<jsDate[key].min) {
			 if ((_time >= jsDate[key].min && _time <= Date.parse('01/01/2011 23:59')) || (_time >= Date.parse('01/01/2011 00:00') && _time <=jsDate[key].max )) {
				if (jsDate[key].delivery=='n') {
					nodelivery=1;
					}
			 isopen=1;
			 }
			} else {
			
			if (jsDate[key].min <= _time && jsDate[key].max >= _time) {
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
			dayprev=days;
			if (daysprev=0) {
			dayprev=7;
			}
			for (key2 in jsDate) {
   			if (jsDate[key].d==dayprev) {
						if ( jsDate[key].max<jsDate[key].min ) {
							if ( _time <= jsDate[key].max) {
							if (jsDate[key].delivery=='n') {
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
            $('input[name=deliveryTime]').val($("#OrderDate input").val() + ' ' + _sTime);
            return true;
        }

        function CheckOrder() {
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

                checkout.hide();
            }).data('datepicker');
	<%end if	%>
			
			
			
			
			
			
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
				<%if sorderonlywhenopen=-1 then%>
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
					
					
					
					 <div class="navbar-brand" >  <span class="label label-success" id="addtobasket" style="float:left;margin-right:10px;">Added</span><button type="button" onclick="CheckOrder();" id="butcontinue" class="btn btn-primary btn-sm" style="float:right;margin-left:10px;">PLACE ORDER <span class="glyphicon glyphicon-chevron-right"></span></button>        <button type="button"  id="butbasket" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-shopping-cart"></span> <b>BASKET</b> <%=CURRENCYSYMBOL%>  <span id="shoppingcart2"></span></button>

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
            <p>
                Sorry, <b>
                    <%=sName %></b> is closed at the moment.<br />
                However, you can place an order now for delivery at a later time.<br />
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

    $(document).ready(function(){
      $("select[name='p_hour']").change(function(){StoreToC(this,"p_hour");});
    $("select[name='p_minute']").change(function(){StoreToC(this,"p_minute");});
      $("#OrderDateBox").change(function(){StoreToC(this,"OrderDate");});
    $("input[name='orderTypePicker']").change(function(){StoreToC($("input[name='orderTypePicker']:checked"),"orderTypePicker");});
    $("input[name='ordertimeoverride']").change(function(){StoreToC($("input[name='orderTypePicker']:checked"),"ordertimeoverride");});

    if( getCookie('orderTypePicker') != '')
        { 
            $("input[name='orderTypePicker'][value='" +getCookie('orderTypePicker') + "']").attr('checked','checked');
        $("input[name='orderTypePicker'][value='" +getCookie('orderTypePicker') + "']").trigger("click");
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
    
  });
    
 function StoreToC(obj,cname)
 {
    if($(obj).val() != "" )
    setCookie(cname,$(obj).val(),15);
        
 }
    function setCookie(cname, cvalue, exmins) {
    var d = new Date();
    d.setTime(d.getTime() + (exmins*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
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
     



    function CheckDistanceLatLng() {
            
            var DeliveryLat = $("#hidLat").val();
            var DeliveryLng = $("#hidLng").val();    
            if(DeliveryLng == "" || DeliveryLat == '')
            {
                $('#DeliveryDistance div.delivery_info').hide();   
                $("#missingPostcodeAlert").show();
                $("#missingPostcodeAlert").html('<strong>Please select your deliver location or pick a location on a map!</strong>');
                $('input[name=distance]', form).val('');
				$('.delivery_info').addClass('alert-danger');
						$('.delivery_info').removeClass('alert-success'); 
                return false;
            }
			    
			<%if individualpostcodeschecking=0 or True then%>
            
           
                
                var distance = GetDistanceLatLng(DeliveryLat,DeliveryLng,<%=sRestaurantLat %>,<%=sRestaurantLng %>,'K');

                

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
	ReloadShop();
    }});
					   $('input[name=deliveryPC]', form).val(zipcode);
					
                   
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

    
</script>


</body>
</html>
