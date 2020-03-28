<%session("restaurantid")=""%>
<!-- #include file="../Config.asp" -->
<%
Function GetXML(addr)
  Dim objXMLDoc, url, docXML, lat, lng, mapref

  'URL for Google Maps API - Doesn't need to stay here could be stored in a 
  'config include file or passed in as a function parameter.
  url = "https://maps.googleapis.com/maps/api/geocode/xml?address={addr}&sensor=false&key=AIzaSyAvyfg017v5c_Wi2hQykmsv8VpS6tNaQoM"
  'Inject address into the URL
  url = Replace(url, "{addr}", Server.URLEncode(addr))
  

  Set objXMLDoc = Server.CreateObject("MSXML2.ServerXMLHTTP.3.0")
  objXMLDoc.setTimeouts 30000, 30000, 30000, 30000
  objXMLDoc.Open "GET", url, False
  objXMLDoc.send()
   
  If objXMLDoc.status = 200 Then
 
    'Response.End
    Set docXML = objXMLDoc.responseXML
    'Check the response for a valid status
    If UCase(docXML.documentElement.selectSingleNode("/GeocodeResponse/status").Text) = "OK" Then
      lat = docXML.documentElement.selectSingleNode("/GeocodeResponse/result/geometry/location/lat").Text
      lng = docXML.documentElement.selectSingleNode("/GeocodeResponse/result/geometry/location/lng").Text
        
      'Create array containing lat and long
      mapref = Array(lat, lng)
    Else
      mapref = Empty
    End If
  Else
    mapref = Empty
  End If

  'Return array
  GetXML = mapref
End Function

dim resultcoderesponse : resultcoderesponse = ""
if request.querystring("searchtype") = "postcode" then
Dim coords, address

address = request.querystring("address")
coords = GetXML(address)
'Do we have a valid array?
   
If IsArray(coords) Then
 'Response.Write "The geo-coded coordinates are: " & Join(coords, ",")
Else
  'No coordinates were returned
  'Response.Write "The address could not be geocoded."
  resultcoderesponse = "The address could not be geocoded."
End If

end if




%>
<%

':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
':::                                                                         :::
':::  This routine calculates the distance between two points (given the     :::
':::  latitude/longitude of those points). It is being used to calculate     :::
':::  the distance between two location using GeoDataSource(TM)              :::
':::  products.                                                              :::
':::                                                                         :::
':::  Definitions:                                                           :::
':::    South latitudes are negative, east longitudes are positive           :::
':::                                                                         :::
':::  Passed to function:                                                    :::
':::    lat1, lon1 = Latitude and Longitude of point 1 (in decimal degrees)  :::
':::    lat2, lon2 = Latitude and Longitude of point 2 (in decimal degrees)  :::
':::    unit = the unit you desire for results                               :::
':::           where: 'M' is statute miles (default)                         :::
':::                  'K' is kilometers                                      :::
':::                  'N' is nautical miles                                  :::
':::                                                                         :::
':::  Worldwide cities and other features databases with latitude longitude  :::
':::  are available at http://www.geodatasource.com                          :::
':::                                                                         :::
':::  For enquiries, please contact sales@geodatasource.com                  :::
':::                                                                         :::
':::  Official Web site: http://www.geodatasource.com                        :::
':::                                                                         :::
':::  GeoDataSource.com (C) All Rights Reserved 2015                         :::
':::                                                                         :::
':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

const pi = 3.14159265358979323846

Function distance(lat1, lon1, lat2, lon2, unit)
  Dim theta, dist
  theta = lon1 - lon2
  dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta))
  dist = acos(dist)
  dist = rad2deg(dist)
  distance = dist * 60 * 1.1515
  Select Case ucase(unit)
    Case "K"
      distance = distance * 1.609344
    Case "N"
      distance = distance * 0.8684
  End Select
End Function


'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
':::  This function get the arccos function from arctan function    :::
'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Function acos(rad)
  If Abs(rad) <> 1 Then
    acos = pi/2 - Atn(rad / Sqr(1 - rad * rad))
  ElseIf rad = -1 Then
    acos = pi
  End If
End function


'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
':::  This function converts decimal degrees to radians             :::
'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Function deg2rad(Deg)
	deg2rad = cdbl(Deg * pi / 180)
End Function

'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
':::  This function converts radians to decimal degrees             :::
'::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Function rad2deg(Rad)
	rad2deg = cdbl(Rad * 180 / pi)
End Function



%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Search</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="js/less-1.3.3.min.js"></script-->
	<!--append �#!watch� to the browser URL, then refresh the page. -->
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
  <link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/apple-touch-icon-144-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/apple-touch-icon-114-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/apple-touch-icon-72-precomposed.png">
  <link rel="apple-touch-icon-precomposed" href="img/apple-touch-icon-57-precomposed.png">
  <link rel="shortcut icon" href="img/favicon.png">
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/html5-dataset.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">	
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAvyfg017v5c_Wi2hQykmsv8VpS6tNaQoM&v=3.exp&signed_in=true&libraries=places"></script>
    <script>
// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

var placeSearch, autocomplete;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initialize() {
  // Create the autocomplete object, restricting the search
  // to geographical location types.
  autocomplete = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('autocomplete')),
      { types: ['geocode'] });
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    fillInAddress();
  });
}

// [START region_fillform]
function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();

  for (var component in componentForm) {
    document.getElementById(component).value = '';
    document.getElementById(component).disabled = false;
  }

  // Get each component of the address from the place details
  // and fill the corresponding field on the form.
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    if (componentForm[addressType]) {
      var val = place.address_components[i][componentForm[addressType]];
      document.getElementById(addressType).value = val;
    }
  }
}
// [END region_fillform]

// [START region_geolocation]
// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}
// [END region_geolocation]

    </script>
</head>


<body onload="initialize()">

<div class="container-fluid" style="background-color:#CE0B10;color:#fff;font-size:20px;padding:20px;">
<div class="container">
	<div class="row clearfix">
	<div class="col-md-6">Restaurant Search
	</div>	</div>	</div></div>
	
	<div class="container-fluid boxshadow" style="background-color:#FEC752;color:#fff;font-size:20px;padding:20px;">
<div class="container">
	<div class="row clearfix">
	<div class="col-md-3"></div>	<div class="col-md-6"><form action="searchresults.asp" method="get"><div class="input-group custom-search-form">
	<div id="locationField">

	<%if request.querystring("searchtype") = "postcode" then%>
<input id="autocomplete" placeholder="Enter your postcode or address"  name="address"   onFocus="geolocate()" type="text" class="form-control" value="<%=request.querystring("address")%>" required> 
<input id="autocomplete2" placeholder="Enter your search term"  name="searchterm"  type="text" class="form-control"  value="<%=request.querystring("searchterm")%>" style="display:none;">	
<%else%>
<input id="autocomplete" placeholder="Enter your postcode or address"  name="address"   onFocus="geolocate()" type="text" class="form-control" value="<%=request.querystring("address")%>" style="display:none;" required> 
<input id="autocomplete2" placeholder="Enter your search term"  name="searchterm"  type="text" class="form-control"  value="<%=request.querystring("searchterm")%>">	
<%end if%>
</div>
              
		
              <span class="input-group-btn">
              <button class="btn btn-default" type="submit">
              <span class="glyphicon glyphicon-search"></span>
             </button>
             </span>
	
             </div>		 
	</div>	</div>	<div class="row clearfix">
	<div class="col-md-3"></div>	<div class="col-md-6"><div class="input-group custom-search-form searchoptions">
	
         <label class="radio-inline">
  <input type="radio" name="searchtype" id="searchtype" value="postcode" <%if request.querystring("searchtype") = "postcode" then%>checked<%end if%>> search by postcode
</label>
<label class="radio-inline">
  <input type="radio" name="searchtype" id="searchtypename" value="name" <%if request.querystring("searchtype") = "name" then%>checked<%end if%>> search by restaurant name
</label>
<label class="radio-inline">
  <input type="radio" name="searchtype" id="searchtypedish" value="dish" <%if request.querystring("searchtype") = "dish" then%>checked<%end if%>> search by dish name
</label>
<input type="hidden" name="long" value="<%=request.querystring("long")%>">
<input type="hidden" name="lat" value="<%=request.querystring("lat")%>">

	
             </div>		 </form>
	</div>	</div></div></div>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-3 column"><div class="row ">
		
	
 
<ul class="nav nav-stacked nav-pills" style="margin-top:10px;">
				<li class="active">
					<a href="javascript:;" id="cusinesearchshow"><span class="glyphicon glyphicon-chevron-down pull-right visible-sm visible-xs" aria-hidden="true"></span> <b>Type of cuisine</b></a>
<a href="javascript:;" id="cusinesearchhide"><span class="glyphicon glyphicon-chevron-up pull-right visible-sm visible-xs" aria-hidden="true"></span> <b>Type of cuisine</b></a>
				</li>

</ul>
<ul class="nav nav-stacked nav-pills" style="margin-top:10px;" id="cuisinesearch">

				
			 <li><a href="javascript:;" class="filterclear" data-foodtype="ALL">
                           ALL</a> </li>
<%
listoffoodtypes="|"
Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
sIndex = 0
objCon.Open sConnStringcms
objRds.Open "SELECT foodtype  FROM BusinessDetails "  , objCon
Do While NOT objRds.Eof
    If objRds("foodtype") & "" <> "" Then
        foodtypes=objRds("foodtype")
        foodtypes=replace(foodtypes," ,",",")
        foodtypes=replace(foodtypes,", ",",")
        splitarray = split(foodtypes, ",")

        for i=0 to ubound(splitarray)
	        if instr(listoffoodtypes,"|" &  trim(splitarray(i) & "") & "|" ) then
	        else
	        listoffoodtypes= listoffoodtypes & trim(splitarray(i) & "") & "|"
	        end if
        next
    End IF
    objRds.MoveNext    
Loop
objRds.close()
set objRds = nothing

'objCon.Close 
listoffoodtypes = right(listoffoodtypes,len(listoffoodtypes)-1)
listoffoodtypes = left(listoffoodtypes,len(listoffoodtypes)-1)
splitarrayfoodtypes = split(listoffoodtypes, "|")

max=ubound(splitarrayfoodtypes)

For i=0 to max  
   For j=i  to max  
      if splitarrayfoodtypes(i)>splitarrayfoodtypes(j) then 
          TemporalVariable=splitarrayfoodtypes(i) 
          splitarrayfoodtypes(i)=splitarrayfoodtypes(j) 
          splitarrayfoodtypes(j)=TemporalVariable 
     end if 
   next  
next 



For i=0 to max  
%>
 <li><a href="javascript:;" class="filter" data-foodtype="<%=splitarrayfoodtypes(i)%>">
                            <%=splitarrayfoodtypes(i)%></a> </li>
							<%

next

%>

               
                        
                    
                        
				
			</ul>
 

		
		
		</div></div>
		<div class="col-md-9 column">
		
		<div class="row">
		<div class="col-sm-10 col-xs-12">
		<div class="btn-group btn-breadcrumb" style="padding-top:10px;padding-left:10px;">
            <a href="index2.asp" class="btn btn-danger"><i class="glyphicon glyphicon-home"></i></a>
           
            <a href="#" class="btn btn-danger">
<%if request.querystring("searchtype")="postcode" then
response.write request.querystring("address")
else
response.write request.querystring("searchterm")
if request.querystring("searchterm")="" then
response.write "No search term entered"
end if
end if%></a>
        
			
			</div></div>
			<div class="col-sm-2  col-xs-12">
			<div class="dropdown pull-right">
  <div class="btn-group" style="padding-top:10px;padding-right:10px;">
				
<button id="dLabel" class="btn btn-default" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
SORT <span class="caret"></span></button>

				<ul class="dropdown-menu">
					<li>
						<a href="#" id="sortpriceasc">Distance: Ascending</a>
					</li>
					<li>
						<a href="#" id="sortpricedsc">Distance: Descending</a>
					</li>
					<li class="divider">
					</li>
					<li>
						<a href="#" id="sortnameasc">Name: Ascending </a>
					</li>
					<li>
						<a href="#" id="sortnamedsc">Name: Descending </a>
					</li>
					<li class="divider">
					</li>
					<li>
						<a href="#" id="sortopen">Show only open </a>
					</li>
					<li>
						<a href="#" id="sortopenclosed">Show all </a>
					</li>
				</ul>
			</div>
</div>
            </div>     </div>
		
		<div class="searchresults">
		  <% 

            Dim sIndex 
            Dim sDayOfWeek
            Dim sDate
            Dim sHour
            Dim sDeliveryFee
            
           ' Set objCon = Server.CreateObject("ADODB.Connection")
            Set objRds = Server.CreateObject("ADODB.Recordset") 
            
            sIndex = 0
			dishids = ""
			if request.querystring("searchtype") = "dish" then
			
			'accessdb=server.mappath("..\data\menu.mdb")
           ' strconn="PROVIDER=Microsoft.Jet.OLEDB.4.0;DATA SOURCE="
           ' MM_menu_STRING=strconn & accessDB & ";"
            Set objRds_cmd = Server.CreateObject ("ADODB.Command")
            objRds_cmd.ActiveConnection = sConnStringcms

			
			'Set objCon3 = Server.CreateObject("ADODB.Connection")
			'Set objRds3 = Server.CreateObject("ADODB.Recordset") 
			'objCon3.Open sConnStringcms
			objRds_cmd.CommandText = "SELECT *  FROM menuitems where name LIKE '%" & request.querystring("searchterm") & "%'"
			objRds_cmd.Prepared = true
			
            Set objRds = objRds_cmd.Execute
			Do While NOT objRds.Eof
			dishids = dishids & objRds("IdBusinessDetail") & ","
			objRds.MoveNext    
			Loop
                objRds.close()
            set objRds = nothing
            objRds_cmd.ActiveConnection.Close
            set objRds_cmd = nothing
			if dishids<>"" then
			dishids=left(dishids,len(dishids)-1)
			end if
			'response.write dishids
			end if
    
	
'accessdb=server.mappath("..\data\menu.mdb")
'strconn="PROVIDER=Microsoft.Jet.OLEDB.4.0;DATA SOURCE="
'MM_menu_STRING=strconn & accessDB & ";"
Set objRds_cmd = Server.CreateObject ("ADODB.Command")
    objRds_cmd.ActiveConnection = sConnStringcms



           ' objCon.Open sConnStringcms
			if request.querystring("searchtype") = "postcode"  then
                objRds_cmd.CommandText =  "SELECT *  FROM BusinessDetails " 
			end if
			if request.querystring("searchtype") = "dish"  then
			    if dishids<>"" then
                    objRds_cmd.CommandText =  "SELECT *  FROM BusinessDetails where id IN (" & dishids & ")"  
			    else
			        objRds_cmd.CommandText =  "SELECT *  FROM BusinessDetails where id=-1" 
			    end if
			end if
			if request.querystring("searchtype") = "name" then
                objRds_cmd.CommandText =  "SELECT *  FROM BusinessDetails where name LIKE '%" & request.querystring("searchterm") & "%'"  
			end if
			objRds_cmd.Prepared = true
			set objRds = Server.CreateObject("ADODB.Recordset")
            Set objRds = objRds_cmd.Execute

			timezoneoffset=0
if session("restaurantid")<>"" then
    Set timezone_cmd = Server.CreateObject ("ADODB.Command")
        set timezone = Server.CreateObject("ADODB.Recordset")
        timezone_cmd.ActiveConnection = sConnStringcms
        sql = "SELECT BusinessDetails.ID, timezones.offset FROM BusinessDetails INNER JOIN timezones ON BusinessDetails.timezone = timezones.ID WHERE (((BusinessDetails.ID)=" & objRds("Id") & "));"
        timezone_cmd.CommandText = sql
        timezone_cmd.Prepared = true
        Set timezone = timezone_cmd.Execute
            timezoney = datepart("yyyy", date())
' REM EUROPEAN UNION CALCULATION:
           ' DST_EU_SPRING = (31 - (5*timezoney/4 + 4) mod 7)
           ' DST_EU_FALL = (31 - (5*timezoney/4 + 1) mod 7)
            
            DST_EU_SPRING = (31 - ((5*timezoney -5*timezoney mod 4)/4  + 4) mod 7)
            DST_EU_FALL = (31 - ((5*timezoney -5*timezoney mod 4)/4  + 1) mod 7)

            date1=CDate(DST_EU_SPRING & "/3/" & timezoney)
            date2=CDate(DST_EU_FALL & "/10/" & timezoney)
        if (DateDiff("d",date1,now)>1) and (DateDiff("d",now,date2)>1) then
            timezoneoffset=timezone.Fields.Item("offsetdst").Value
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
        
        timezone.close()
        set timezone = nothing
        timezone_cmd.ActiveConnection.Close
        set timezone_cmd = nothing
end if

			
			        sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
			
            sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))
         
            Do While NOT objRds.Eof 
			
               if objRds("businessclosed")=0 then
                sDeliveryFee = objRds("DeliveryFee")            
            
                If sDeliveryFee <= 0 Then 
                    sDeliveryFee = "FREE"
                Else 
                    sDeliveryFee = objRds("currencysymbol") & sDeliveryFee
                End if

        %>
		
		         <% 
'check opening times
'Set objCon2 = Server.CreateObject("ADODB.Connection")
Set objRds2 = Server.CreateObject("ADODB.Recordset") 
'objCon2.Open sConnStringcms
objRds2.Open "SELECT convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeek, objCon
'loop through opening time
isopen=false
Do While NOT objRds2.Eof
' check each time slot
' check is end time before the first time which indicates it is after midnight
 if DateDiff("n",objRds2("Hour_From"),objRds2("Hour_To"))<0 then
	if (sHour >= objRds2("Hour_From") and sHour <= "23:59:00") or (sHour >= "00:00:00"  and sHour <= objRds2("Hour_To") ) Then
		isopen=true
	end if
 else
	if (objRds2("Hour_From") <= sHour and objRds2("Hour_To") >= sHour) Then
		isopen=true
	end if
end if
objRds2.MoveNext    
Loop
'objCon2.Close 
    objRds2.Close
set objRds2 = nothing
'if it is has found not to be open and time is early morning then check previous days time
if isopen=false and DateDiff("n",sHour,"12:00:00")>0 then
    sDayOfWeekprev=sDayOfWeek-1
    if sDayOfWeekprev=0 then
    sDayOfWeekprev=7
    end if
'objCon2.Open sConnStringcms
        set objRds2 = Server.CreateObject("ADODB.Recordset")
        objRds2.Open "SELECT convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To  FROM openingtimes where IdBusinessDetail = " & objRds("Id") & " and DayOfWeek=" & sDayOfWeekprev, objCon
        Do While NOT objRds2.Eof
        ' check each time slot
        ' check is end time before the first time which indicates it is after midnight
         if DateDiff("n",objRds2("Hour_From"),objRds2("Hour_To"))<0 then
	        if (sHour <= objRds2("Hour_To")) Then
		        isopen=true
	        end if
        end if
        objRds2.MoveNext    
        Loop
        objRds2.close()
        set objRds2 = nothing
end if
%>
	
	<%
	
	ddd=0
if resultcoderesponse = "" then
    if request.querystring("searchtype") = "postcode" then
        If objRds("longitude") & "" <> "" AND objRds("latitude") & "" <> "" Then
           ' Response.Write("lat1 " & coords(0) & " lon1 " & coords(1) & " [] lat2 " & objRds("latitude") & "  lon2 " & objRds("longitude") & "<br/>")
       
            ddd=round(distance(coords(0), coords(1), objRds("latitude"), objRds("longitude"), "M"),1)
            'Response.Write("ddd " & ddd & "<br/>")
        End If
    else 
        if request.querystring("lat")<>"" AND request.querystring("lat")<>"0" then
            If objRds("longitude") & "" <> "" AND objRds("latitude") & "" <> "" Then
                ddd=round(distance(request.querystring("lat"), request.querystring("long"), objRds("latitude"), objRds("longitude"), "M"),1)
            End If
        else
            ddd=0
        end if
    end if
end if
if (request.querystring("lat")=null or request.querystring("lat")="") and request.querystring("searchtype") <> "postcode"  then
    ddd=0
end if
  
if ddd<=objRds("DeliveryMaxDistance") and resultcoderesponse =""  then
       
%>
		
		<div class="row shopwrapper" data-distance="<%response.write ddd%>" data-name="<%= objRds("Name") %>" data-open="<%if isopen then%>open<%else%>closed<%end if%>" data-foodtype="<%= objRds("Foodtype") %> ">
        
 
							<div class="row">
              <div class="col-md-2 col-xs-2"><div align="center"> <img class="img-rounded img-responsive" src="<%= objRds("ImgUrl") %>" alt="<%= objRds("Name") %>" /></div>
			  </div>
			   <div class="col-md-10 col-xs-10">
			   
			   
			   
			   
			   
			   <div class="row">
              
                            
                            
                                <div class=" col-md-9 col-sm-8 col-xs-12">
                                    <span class="shop-name">
                                        <a href="../Menu.asp?id_r=<%= objRds("id") %>&postcode=<%=request.querystring("address")%>"><%= objRds("Name") %></a> </span>
                                    <br />
                                    <span class="shop-address"><%= objRds("Address") %></span><br>
									                                             
                                </div> 
								
								
                    
								
								                          
                                <div class="col-md-3 col-sm-4 col-xs-12 ">
                                <div align="center"><span class="menu-button"><a class="btn btn-success btn-block" href="../Menu.asp?id_r=<%= objRds("id") %>&postcode=<%=request.querystring("address")%>">
                                    <span>View Menu</span></a></span></div>
                            </div>      </div>
			   
			   
			   
			   <div class="row" style="border-top:1px dotted #c8c8c8;margin-top:10px;padding-top:10px;">
							 <div class="col-md-4 col-sm-4 col-xs-6">
               
                           <strong>Type of food</strong> <br>
						   
<%= objRds("Foodtype") %> 
                        </div><div class="col-md-3 col-sm-3 col-xs-6">
               
                           <strong>Distance</strong> <br>
				   
<%
 if resultcoderesponse =  "" then   
         if request.querystring("searchtype") = "postcode" then  
                response.write round(distance(coords(0), coords(1), objRds("latitude"), objRds("longitude"), "M"),1) & " Miles<br>"
        else
            if request.querystring("lat")=null or request.querystring("lat")="" then
                response.write "---"
            end if
        end if
end if
    
    %>
                        </div><div class="col-md-3 col-sm-3 col-xs-6">
               
                          <div> <strong>Delivery fee</strong> <br>
						   
<%=sDeliveryFee %></div>
                        </div><div class="col-md-2 col-sm-2 col-xs-6">
               
                      <div align="center">      <%

if isopen then%>
<img src="Images/clock-green.png" alt="clock" /> <span>OPEN</span>
<%else%>
<img src="Images/clock-red.png" alt="clock" /> <span>CLOSED</span>
<%end if

%></div>
                        </div>                  
                            </div>
			   
			   
			   
			  </div>
			  </div>
			  
			  
							</div>
				   <% 
                sIndex = sIndex + 1 
                If sIndex = 2  Then sIndex = 0            
            %>

        <%end if
		end if
                objRds.MoveNext    
            Loop
            
            objRds.Close
            set objRds = nothing
            objCon.Close
            set objCon = nothing
             objRds_cmd.ActiveConnection.Close  
             set objRds_cmd = nothing
            if resultcoderesponse & "" <> "" then
            %>
                <div class=" col-md-9 col-sm-8 col-xs-12">
                                 <br />
                                   <%=resultcoderesponse %>
                                 
									                                             
                                </div> 
            <%
            end if
        %>
        
    	</div>
							
							
		</div>
	</div>
</div>
</body>
</html>
