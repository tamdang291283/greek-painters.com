<%
    If session("restaurantid") & "" = "" AND Request.QueryString("id_r") & "" <> "" Then
        session("restaurantid")= Request.QueryString("id_r")
   
    End If

     If session("vOrderId")  & "" = "" AND Request.QueryString("id_o") & "" <> "" Then
        session("vOrderId")= Request.QueryString("id_o")
   
    End If
  
     %>

<!-- #include file="Config.asp" -->

<!-- #include file="timezone.asp" -->

<!-- #include file="restaurantsettings.asp" -->

<!DOCTYPE html>
<html lang="en">
<%
'response.write "session(vOrderId)" & session("vOrderId") & "<BR>"
'response.write "QueryString(id_o)" & Request.QueryString("id_o") & "<BR>"
if CStr(session("vOrderId"))<>CStr(Request.QueryString("id_o")) or session("vOrderId")=""  then
response.redirect("error.asp")
end if

%>

<% 
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    objCon.Open sConnString
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & Request.QueryString("id_r"), objCon       
	backtohometext=objRds("backtohometext")
	bringgtracking=objRds("bringg")
	bringgurl=objRds("bringgurl")
	
	googleecommercetracking=objRds("googleecommercetracking")
	googleecommercetrackingcode=objRds("googleecommercetrackingcode")
%>

<head>
  <meta charset="utf-8">
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

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <link rel='shortcut icon' href='images-icons/favicon.ico' type='image/x-icon'/ >
  
	<script type="text/javascript" src="Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="Scripts/js.cookie.js"></script>
	<script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="Scripts/scripts.js"></script>
	
    <script src="Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&sensor=false"></script>
	
	<script>
$.cookie("Specialinput", ""); 
</script>
	 <style type="text/css">
        small.error 
        {
            display: inline;    
            color: #B94A48; 
        }
		#wholepage {
padding-top:0px !important;
}
    </style>
    <script type="text/javascript">
    //<![CDATA[
        $(window).load(function() { // makes sure the whole site is loaded
            $('#status').fadeOut(); // will first fade out the loading animation
            $('#preloader').delay(350).fadeOut('slow'); // will fade out the white DIV that covers the website.
            $('body').delay(350).css({'overflow':'visible'});
        })
    //]]>
</script>
    <style>body{overflow:hidden;}#preloader{position:fixed;top:0;left:0;right:0;bottom:0;background-color:#000;z-index:99;}#status{width:200px;height:200px;position:absolute;left:50%;top:50%;background-image:url(<%=objRds("imgURL") %>);background-repeat:no-repeat;background-position:center;margin:-100px 0 0 -100px;}</style>

</head>
<body>
   <div id="preloader">
<div id="status">&nbsp;</div>
</div>

<div class="container" id="wholepage" style="padding-bottom:100px;">

	
	

  <div class="container">
  

   
	
		 <%            
            objRds.Close
            objCon.Close
        %> 
		
<% voucherused=""
voucherusedtype=""
Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
objCon.Open sConnString
objRds.Open "SELECT * FROM orders WHERE Id = " & Request.QueryString("id_o"), objCon       
voucherused=objRds("vouchercode")   
objRds.Close
objCon.Close
if voucherused<>"" then

Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
objCon.Open sConnString
objRds.Open "SELECT * FROM vouchercodes WHERE IdBusinessDetail=" & Request.QueryString("id_r") & " and vouchercode = '" & voucherused & "'", objCon 
if not  objRds.EOF then 
voucherusedtype=objRds("vouchertype")   
end if
objRds.Close
objCon.Close
end if

if voucherusedtype="once" then


Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
mySQL="DELETE from vouchercodes  WHERE IdBusinessDetail=" & Request.QueryString("id_r") & " and vouchercode = '" & voucherused & "'"
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open(sConnString)
Conn.Execute(mySQL)
Conn.Close


end if
%>     
   
    <!-- #include file="Receipt.asp" -->


	
	
	
	
</div>

<div align="center"><br>
<br>
</div>

<div align="center">  Please check your email for confirmation of your order, including potential delivery time changes
  <br />
<br />
<%if backtohometext<>"" then
response.write backtohometext
else%>  
<a style="display:none;" href="Menu.asp?id_r=<%=Request.QueryString("id_r")%>">Click here to return to the homepage</a>
<a href="Menu.asp?id_r=<%=Request.QueryString("id_r")%>"  class="btn btn-primary" style="width: 280px; padding: 8px"><span class="
glyphicon glyphicon-chevron-left" aria-hidden="true"></span> Click here to return to the homepage</a>
<%end if%>

<br>
  <br></div>
  <script>

      function deleteAllCookies() {
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++) {
    	var cookie = cookies[i];
    	var eqPos = cookie.indexOf("=");
    	var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
    	document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
}
      deleteAllCookies() ;
  </script>

<%if googleecommercetracking="Yes" then%>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', '<%=googleecommercetrackingcode%>', 'auto');
  ga('send', 'pageview');
  ga('require', 'ecommerce');
  
ga('ecommerce:addTransaction', {
  'id': '<%=Request.QueryString("id_o")%>',                     // Transaction ID. Required.
  'affiliation': '<%=vdeliverytype%>',   // Affiliation or store name.
  'revenue': '<%=FormatNumber(vOrderTotal, 2)%>',               // Grand Total.
  'shipping': '<%=FormatNumber(vShippingFee, 2)%>'                  // Shipping.

});

<%=analyticsitems%>

ga('ecommerce:send');

</script>
<%end if%>

<%if bringgtracking="Yes" and vdeliverytype="delivery" then
set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP") 
xmlhttp.open "POST", bringgurl, false 
xmlhttp.setRequestHeader "Content-type","application/json"
xmlhttp.setRequestHeader "Accept","application/json"
xmlhttp.send bringg
'response.write bringg
vAnswer = xmlhttp.responseText  
'   Response.Write("<br />Bringg:"& vAnswer)
end if%>
  <% If UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" Then  %>
<iframe style="visibility:hidden;position:absolute;" id='ifPrint'  src="printers/print_t.asp?id_o=<%=Request.QueryString("id_o") %>&id_r=<%=Request.QueryString("id_r") %>" ></iframe>
    <% end if %>
    <script>
   /*
var isFirefox = typeof InstallTrigger !== 'undefined';
   
    if (isFirefox)
        {
            $("#ifPrint").attr("style","visibility:hidden;position:absolute;");
            $("#ifPrint").attr("src","printers/print_t.asp?id_o=<%=Request.QueryString("id_o") %>&id_r=<%=Request.QueryString("id_r") %>");

        }
    else {
         $("#ifPrint").attr("style","display:none;");
            $("#ifPrint").attr("src","printers/print_t.asp?id_o=<%=Request.QueryString("id_o") %>&id_r=<%=Request.QueryString("id_r") %>");
        }
        */
    </script>

</body>
</html>
<%
Session.Abandon

%>