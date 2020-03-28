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
    
    sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
    sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))

    objCon.Open sConnString
     objRds.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & vRestaurantId, objCon

    
'check opening times
'Set objCon2 = Server.CreateObject("ADODB.Connection")
Set objRds2 = Server.CreateObject("ADODB.Recordset") 
'objCon2.Open sConnString
objRds2.Open "SELECT convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeek & " order by DayOfWeek, Hour_From", objCon
'loop through opening time
isopen=false
Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
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
'objCon2.Close 
objRds2.Close
'if it is has found not to be open and time is early morning then check previous days time
if isopen=false and DateDiff("n",sHour,"12:00:00")>0 then
sDayOfWeekprev=sDayOfWeek-1
if sDayOfWeekprev=0 then
sDayOfWeekprev=7
end if
'objCon2.Open sConnString
objRds2.Open "SELECT convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeekprev, objCon
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
    if Not IsNull(objRds("DeliveryMaxDistance")) Then sDeliveryMaxDistance = Cdbl(objRds("DeliveryMaxDistance"))
    if Not IsNull(objRds("DeliveryFreeDistance")) Then sDeliveryFreeDistance = Cdbl(objRds("DeliveryFreeDistance"))
    if Not IsNull(objRds("DeliveryMinAmount")) Then sDeliveryMinAmount = Cdbl(objRds("DeliveryMinAmount"))
    if Not IsNull(objRds("DeliveryFee")) Then sDeliveryFee = Cdbl(objRds("DeliveryFee"))
    if Not IsNull(objRds("AverageDeliveryTime")) Then sAverageDeliveryTime = Cdbl(objRds("AverageDeliveryTime"))
    if Not IsNull(objRds("AverageCollectionTime")) Then sAverageCollectionTime = Cdbl(objRds("AverageCollectionTime"))
	
	
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

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="Scripts/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
 <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="Scripts/scripts.js"></script>
	
    <script src="Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&sensor=false"></script>

	<style media="screen" type="text/css">

<%= objRds("css")%>

</style>


</head>

<body>

<div class="container" id="wholepage" style="padding-bottom:100px;">

	
	

	<div class="row clearfix">
		<div class="col-md-12">
		
	 <%= objRds("closedtext") %>
		</div>
	</div>
	<%            
            objRds.Close
        set objRds = nothing
            objCon.Close
        set objCon =  nothing
        %>	
</body>
</html>
