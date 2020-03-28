<%session("restaurantid")=""%>
<!-- #include file="Config.asp" -->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Choose Restaurant</title>
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
  

	
	


</head>

<body>



<div class="container">
        <div class="row">
            <div class="span12" style="color: Red; text-align: center">
                <h1>
                    Order Online</h1>
            </div>
        </div>

        <% 

            Dim sIndex 
            Dim sDayOfWeek
            Dim sDate
            Dim sHour
            Dim sDeliveryFee
            
            Set objCon = Server.CreateObject("ADODB.Connection")
            Set objRds = Server.CreateObject("ADODB.Recordset") 
            
            sIndex = 0
    

            objCon.Open sConnString
            Dim SQL 
            SQL  = "select a.*,b.fromlink from  BusinessDetails a left join  URL_REWRITE b on  (  b.RestaurantID=a.ID and tolink  = 'menu.asp' and status ='ACTIVE' )"
            objRds.Open SQL  , objCon
			
			timezoneoffset=0
if session("restaurantid")<>"" then
Set timezone_cmd = Server.CreateObject ("ADODB.Command")
timezone_cmd.ActiveConnection = sConnString
sql = "SELECT BusinessDetails.ID, timezones.offset FROM BusinessDetails INNER JOIN timezones ON BusinessDetails.timezone = timezones.ID WHERE (((BusinessDetails.ID)=" & objRds("Id") & "));"
timezone_cmd.CommandText = sql
timezone_cmd.Prepared = true
Set timezone = timezone_cmd.Execute
timezoney = datepart("yyyy", date())
' REM EUROPEAN UNION CALCULATION:
DST_EU_SPRING = (31 - (5*timezoney/4 + 4) mod 7)
DST_EU_FALL = (31 - (5*timezoney/4 + 1) mod 7)
date1=CDate(DST_EU_SPRING & "/3/" & timezoney)
date2=CDate(DST_EU_FALL & "/10/" & timezoney)
if (DateDiff("d",date1,now)>1) and (DateDiff("d",now,date2)>1) then
'timezoneoffset=timezone.Fields.Item("offsetdst").Value
timezoneoffset=timezone.Fields.Item("offset").Value
else
timezoneoffset=timezone.Fields.Item("offset").Value
end if
timezoneoffsettime=split(timezoneoffset,":")
timezoneoffseth=timezoneoffsettime(0)
timezoneoffseth=right(timezoneoffseth,len(timezoneoffseth)-1)
if instr(timezoneoffset,"-") then
houroffset=houroffset-cint(timezoneoffseth)
else
houroffset=houroffset+cint(timezoneoffseth)
end if
end if

			
			        sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
			
            sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))
         
            Do While NOT objRds.Eof 
               if objRds("businessclosed")=0 then
                sDeliveryFee = objRds("DeliveryFee")            
            
                If sDeliveryFee <= 0 Then 
                    sDeliveryFee = "FREE"
                Else 
                    sDeliveryFee = CURRENCYSYMBOL & sDeliveryFee
                End if

                Dim URLMENU : URLMENU = "Menu.asp?id_r=" & objRds("Id")
                if objRds("fromlink") & "" <> "" and objRds("EnableUrlRewrite") = "Yes" then
                    URLMENU =   objRds("fromlink")  
                end if
            

        %>
     
           
            <div class="row shopwrapper">
        

              <div class="col-xs-5 col-md-2 ">
               
                           <div align="center"> <img class="img-rounded img-responsive" src="<%= objRds("ImgUrl") %>" alt="<%= objRds("Name") %>" /></div>
                        </div>
                            
                            
                                <div class="col-xs-7 col-md-4">
                                    <span class="shop-name">
                                        <a href="<%=URLMENU %>"><%= objRds("Name") %></a> </span>
                                    <br />
                                    <span class="shop-address"><%= objRds("Address") %></span><br>
									<%= objRds("FoodType") %>                                                                
                                </div> 
								<div class="clearfix visible-xs"></div>
								<div class="col-xs-12 col-md-4 toppad15 clearfix">
 <div align="center" class="toppad15"> 
  
 
                           <% 
'check opening times
'Set objCon2 = Server.CreateObject("ADODB.Connection")
Set objRds2 = Server.CreateObject("ADODB.Recordset") 
'objCon2.Open sConnString
objRds2.Open "SELECT convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeek, objCon
'loop through opening time
isopen=false
    Dim o_Hour_From
    Dim o_Hour_To
Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
     o_Hour_From = FormatTimeC(objRds2("Hour_From"),8)
     o_Hour_To =  FormatTimeC(objRds2("Hour_To"),8)

 if DateDiff("n",o_Hour_From,o_Hour_To)<0 then
	if (sHour >= o_Hour_From and sHour <= "23:59:00") or (sHour >= "00:00:00"  and sHour <= o_Hour_To ) Then
		isopen=true
	end if
 else
	if (o_Hour_From <= sHour and o_Hour_To >= sHour) Then
		isopen=true
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
     o_Hour_From = FormatTimeC(objRds2("Hour_From"),8)
     o_Hour_To =  FormatTimeC(objRds2("Hour_To"),8)
 if DateDiff("n",o_Hour_From,o_Hour_To)<0 then
	if (sHour <= o_Hour_To) Then
		isopen=true
	end if
end if
objRds2.MoveNext    
Loop
end if

if isopen then%>
<img src="Images/clock-green.png" alt="clock" /> <span>OPEN</span>
<%else%>
<img src="Images/clock-red.png" alt="clock" /> <span>CLOSED</span>
<%end if

%>
							<br>
							<span class="delivery-title">Delivery Fee: </span><span class="delivery-details"><%= objRds("CURRENCYSYMBOL") %><%=sDeliveryFee %></span></div>
							
</div>
                    
								
								                          
                                <div class="col-xs-12 col-md-2 toppad15">
                                <div align="center"><span class="menu-button"><a class="btn btn-success" href="<%=URLMENU %>">
                                    <span>View Menu</span></a></span></div>
                            </div>                    
                            </div>
                            

                        
 
             


            <% 
                sIndex = sIndex + 1 
                If sIndex = 2  Then sIndex = 0            
            %>

        <%end if
                objRds.MoveNext    
            Loop
            
            objRds.Close
            objCon.Close
        %>
    
    
    </div>


		<script type="text/javascript" src="Scripts/jquery.min.js"></script>
	<script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
	<script type="text/javascript" src="Scripts/scripts.js"></script>
	
    <script src="Scripts/jquery.validate.min.js" type="text/javascript"></script>

    <script src="Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&sensor=false"></script>

	
</body>
</html>
