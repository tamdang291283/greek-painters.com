<%
    If session("restaurantid") & "" = "" AND Request.QueryString("id_r") & "" <> "" Then
        session("restaurantid")= Request.QueryString("id_r")
   
    End If

     If  Request.QueryString("id_o") & "" <> "" Then
        session("vOrderId")= Request.QueryString("id_o")
   
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
    
   'if 1= 2 then
        Dim objRds2
        Dim isPrinted
        isPrinted= false
         Set objRds2 = Server.CreateObject("ADODB.Recordset") 
        objRds2.Open "SELECT * FROM OrdersLocal WHERE Id = " &  Request.QueryString("id_o"), objCon , 1, 3      
        'objRds2("FirstName") = request.QueryString("table")
        objRds2("orderdate") = DateAdd("h",houroffsetreal,now)
        If Lcase(objRds2("printed")) =  "true"   Then
             isPrinted = true
        else 
            objRds2("printed") = true
       End if  
    
   
        'objRds2("notes") = Replace(Request.Cookies("Specialinput"),"'","''")
     
        objRds2.Update()
        objRds2.Close()
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
	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
	<link href="../css/datepicker.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="../Scripts/js.cookie.js"></script>
	<script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="../Scripts/scripts.js"></script>
	
    <script src="../Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="../Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
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
 
    <style>body{overflow:hidden;}#preloader{position:fixed;top:0;left:0;right:0;bottom:0;background-color:#000;z-index:99;}#status{width:200px;height:200px;position:absolute;left:50%;top:50%;background-image:url(<%=objRds("imgURL") %>);background-repeat:no-repeat;background-position:center;margin:-100px 0 0 -100px;}</style>

</head>
<body>
   <!--<div id="preloader">
<div id="status">&nbsp;</div>
</div>-->

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
objRds.Open "SELECT * FROM ordersLocal WHERE Id = " & Request.QueryString("id_o"), objCon       
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
Dim isDualPrint
isDualPrint = false
If LCase(IsDualReceiptPrinting & "") = "true" Then 
    isDualPrint = true
End If
%>     
   
    <!-- #include file="../local/Receipt.asp" -->


	
	
	
	
</div>

<div align="center"><br>
<br>
</div>

   	<script>
           window.print();
  setTimeout(window.close, 0);

   	</script>
	</body>


</body>
</html>
