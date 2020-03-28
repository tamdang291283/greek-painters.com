<%
    Dim OrderResID : OrderResID = Request.QueryString("id_o")
  
    if Request.QueryString("id_r") & "" <>"" then 
        session("restaurantid") =  Request.QueryString("id_r")
    elseIf session("restaurantid") & "" = "" AND Session("ResID") & ""  <> "" Then
        session("restaurantid")= Session("ResID") 
   
    End If
    if Session("OrderID") & "" <> "" and  Session("OrderID") & "" <> "0"  then
        OrderResID = Session("OrderID") 
    end if
    
  
     If ( session("vOrderId")  & "" = "" AND OrderResID & "" <> "" ) OR Request.QueryString("isPrint") & "" = "Y" Then
        session("vOrderId")= OrderResID
   
    End If
  
     %>

<!-- #include file="Config.asp" -->

<!-- #include file="../timezone.asp" -->

<!-- #include file="../restaurantsettings.asp" -->

<!DOCTYPE html>
<html lang="en">
<%
 
'response.write "session(vOrderId)" & session("vOrderId") & "<BR>"
'response.write "QueryString(id_o)" & Request.QueryString("id_o") & "<BR>"
if CStr(session("vOrderId"))<>CStr(OrderResID) or session("vOrderId")=""  then
response.redirect(SITE_URL&"error.asp")
end if

%>

<% 
  
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

    objCon.Open sConnString
    objRds.Open "SELECT * FROM BusinessDetails WHERE Id = " & session("restaurantid"), objCon         
      
	backtohometext=objRds("backtohometext")
	bringgtracking=objRds("bringg")
	bringgurl=objRds("bringgurl")
	
	googleecommercetracking=objRds("googleecommercetracking")
	googleecommercetrackingcode=objRds("googleecommercetrackingcode")

     dim newWay : newWay = false
       if printingtype = "text" and UCase(SEND_ORDERS_TO_PRINTER) = "EPSON"   then
            newWay = true
       end if
      
    
   'if 1= 2 then
        Dim objRds2
        Dim isPrinted
        isPrinted= false
         Set objRds2 = Server.CreateObject("ADODB.Recordset") 
        objRds2.Open "SELECT * FROM OrdersLocal WHERE Id = " &  OrderResID, objCon , 1, 3      
        'objRds2("FirstName") = request.QueryString("table")
        objRds2("orderdate") = DateAdd("h",houroffsetreal,now)
        If Lcase(objRds2("printed")) & ""=  "1"   Then
             isPrinted = true
        'else 
        '    if newWay = false then
        '        objRds2("printed") = true
       '     end if
       End if  
    
   
        'objRds2("notes") = Replace(Request.Cookies("Specialinput"),"'","''")
     
        objRds2.Update()
        objRds2.Close()
        set objRds2 = nothing
    
   ' End if
    'objCon.Execute("UPDATE OrdersLocal set Firstname = '" & request.QueryString("table") & "', orderdate = '" & DateAdd("h",houroffsetreal,now) & "', [ordertotal]=[subtotal], [notes]= '" & Replace(Request.Cookies("Specialinput"),"'","''") & "' where ID = " &  Request.QueryString("id_o"))
      
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
	
	<link href="<%=SITE_URL%>css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=SITE_URL%>css/style.css" rel="stylesheet">
	<link href="<%=SITE_URL%>css/datepicker.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="<%=SITE_URL%>Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL%>Scripts/js.cookie.js"></script>
	<script type="text/javascript" src="<%=SITE_URL%>Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=SITE_URL%>Scripts/scripts.js"></script>
	
    <script src="<%=SITE_URL%>Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="<%=SITE_URL%>Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&sensor=false"></script>
	

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
           ' objCon.Close
        %> 
		
<% 

    voucherused=""
voucherusedtype=""
'Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
'objCon.Open sConnString
objRds.Open "SELECT * FROM ordersLocal WHERE Id = " & OrderResID, objCon       
voucherused=objRds("vouchercode")   
objRds.Close

 if Request.QueryString("isPrint") = "Y" and newWay = true  then  
            objCon.execute("Update OrdersLocal set printed = 0 where ID = " & OrderResID )
 end if 

'objCon.Close
if voucherused<>"" then

'Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
'objCon.Open sConnString
objRds.Open "SELECT * FROM vouchercodes WHERE IdBusinessDetail=" & session("restaurantid") & " and vouchercode = '" & voucherused & "'", objCon 
if not  objRds.EOF then 
voucherusedtype=objRds("vouchertype")   
end if
objRds.Close
'objCon.Close
end if



if voucherusedtype="once" then


'Set objCon = Server.CreateObject("ADODB.Connection")
    
mySQL="DELETE from vouchercodes  WHERE IdBusinessDetail=" & session("restaurantid") & " and vouchercode = '" & voucherused & "'"
'Set Conn = Server.CreateObject("ADODB.Connection")
    objCon.Execute(mySQL)
end if
Dim isDualPrint
isDualPrint = false
If LCase(IsDualReceiptPrinting & "") = "1" Then 
    isDualPrint = true
End If

    set objRds = nothing
objCon.close()
set objCon = nothing
    
%>   
    <!-- #include file="Receipt.asp" -->
   
</div>

<div align="center"> <br>

   Thank you for your custom，please take a seat, we will call you when it is ready.
    <br>
<br>
</div>

<div align="center"> 
<a style="display:none;" href="<%=SITE_URL %>local/Menu.asp?id_r=<%=session("restaurantid")%>">Click here to return to the homepage</a>
<a href="<%=SITE_URL %>local/Menu.asp?id_r=<%=session("restaurantid")%>"  class="btn btn-primary" style="width: 280px; padding: 8px"><span class="
glyphicon glyphicon-chevron-left" aria-hidden="true"></span>Make another order</a>


<br>
  <br></div>
  <script>
            function setCookie(cname, cvalue, exmins) {
                var d = new Date();
                d.setTime(d.getTime() + (exmins*60*1000));
                var expires = "expires="+ d.toUTCString();
                document.cookie = cname + "=" + cvalue + "; " + expires + ";  path=/";
            }
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
         setCookie("TableNumber","",15);   
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


  <% 'If UCase(SEND_ORDERS_TO_PRINTER) = "EPSON" OR 1=1 Then  %>
<% 
      
    if newWay = false then
            If isDualPrint AND ( isPrinted = false OR  UCase(Request.QueryString("isPrint"))  = "Y"  ) Then %>
            <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint'  src="<%=SITE_URL %>printers/epson/print_local.asp?isPrint=<%=Request.QueryString("isPrint") %>&mod=dishname&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid") %>&table=<%=Request.QueryString("table") %>&idlist=<%=Request.QueryString("idlist") %>" ></iframe>
            <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint'  src="<%=SITE_URL %>printers/epson/print_local.asp?isPrint=<%=Request.QueryString("isPrint") %>&mod=printingname&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid") %>&table=<%=Request.QueryString("table") %>&idlist=<%=Request.QueryString("idlist") %>" ></iframe>
            <% elseif ( isPrinted = false OR  UCase(Request.QueryString("isPrint"))  = "Y"  ) then %>
        <iframe style="visibility:hidden;position:absolute;opacity:0;" id='ifPrint'  src="<%=SITE_URL %>printers/epson/print_local.asp?isPrint=<%=Request.QueryString("isPrint") %>&id_o=<%=OrderResID %>&id_r=<%=session("restaurantid") %>&table=<%=Request.QueryString("table") %>&idlist=<%=Request.QueryString("idlist") %>" ></iframe>
            <% end if 
    End if    
     %>
    <script>  
        <% if UCase(Request.QueryString("isPrint"))  = "Y" Then  %>
         setTimeout("window.close()", 5000);
        <% else
            Session.Abandon %>
        setTimeout(function(){ window.location.href ="<%=SITE_URL %>local/Menu.asp?id_r=<%=session("restaurantid")%>" }, 15000);
        <% end if %>
    </script>

</body>
</html>

