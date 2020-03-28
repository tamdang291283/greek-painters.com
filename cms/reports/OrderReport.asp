<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->

<%Server.ScriptTimeout=86400%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="../../cms/index.asp?e=2"
MM_grantAccess=false
If Session("MM_Username") <> "" Then
  If (true Or CStr(Session("MM_UserAuthorization"))="") Or _
         (InStr(1,MM_authorizedUsers,Session("MM_UserAuthorization"))>=1) Then
    MM_grantAccess = true
  End If
End If
If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If

Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Management Area</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

		<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="js/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script src="../js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	 <style>
         /* Always set the map height explicitly to define the size of the div
        * element that contains the map. */
         #map {
             height: 100%;
         }
         /* Optional: Makes the sample page fill the window. */
         html, body {
             height: 100%;
           
         }
    </style>
</head>

<body>


<div class="container">
    
	 <!-- #Include file="../inc-header.inc"-->   
        <form class="form-inline">
              <h1>Order Report</h1><br />
            <%
                dim filterYear, filterMonth, filterMap
                filterYear = year(now)
                filterMonth = month(now)
                filterMap = 1
                If Request.Form("year") & "" <> "" Then
                    filterYear = Request.Form("year")
                Elseif Request.QueryString("year") & "" <> "" Then
                    filterYear = Request.QueryString("year")
                End If
                If Request.Form("month") & "" <> "" Then
                    filterMonth = Request.Form("month")
                Elseif Request.QueryString("month") & "" <> "" Then
                    filterMonth = Request.QueryString("month")
                End If
                If Request.Form("slmap") & "" <> "" Then
                    filterMap = Request.Form("slmap")
                Elseif Request.QueryString("slmap") & "" <> "" Then
                    filterMap = Request.QueryString("slmap")
                End If
  
            %>
                <div class="col-lg-12">
                
             
                      
             
                  
                
            
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            
  <tr>

	<td>
     Map: <br>
                  <select id="slmap" name="slmap" class="form-control"  style="width:90px;" onchange="this.form.submit()">
                      <option value="1">Clusters</option>
                      <option value="2">Heat Map</option>          
                    </select>
    </td>


  
    <td>    Year: <br>
                    <select id="slyear" name="year" class="form-control"  style="width:90px;"  onchange="this.form.submit()">
                    <%
                        objCon.Open sConnStringcms                  
                        sql = "select distinct  year(OrderDate) as yearOrder FROM  view_paid_orders WHERE year(OrderDate) <> '' and IdBusinessDetail =" &  Session("MM_id")  
                        sql = sql & " and    cancelled<>1 "
                        sql = sql & "  ORDER BY  year(OrderDate) asc "
                        objRds.Open  sql , objCon,1 
                        Do While NOT objRds.Eof  
                            %>
                                <option value="<%=objRds("yearOrder") %>"><%= objRds("yearOrder") %></option>
                            <%
                            objRds.MoveNext    
                        Loop                   
                       
                        objRds.Close
                        set objRds = nothing
                        objCon.Close
                        set objCon = nothing
                                
                    %>
                
                </select></td>
                
                
                
                
    <td>Month: <br>
                    <select id="slmonth" name="month" class="form-control" style="width:120px;float:left;" onchange="this.form.submit()">
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">Septemper</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                </select></td>
                
                
    <td valign="bottom">   <button type="button" style="float:left;" class="btn" onclick="ChangeMonth('u',this.form);">
                    <span class="glyphicon glyphicon-chevron-up"></span>
              </button>
              <button style="float:left;" type="button" class="btn" onclick="ChangeMonth('d',this.form);">
                    <span class="glyphicon glyphicon-chevron-down"></span>
              </button>  </td>
  </tr>
</table>

            
            
                  




                  
            
                              




                  
              
       </div>    
                         
                <script type="text/javascript">
                    var filterYear = "<%=filterYear%>";
                    $("#slyear").val(filterYear);
                    var filterMonth = "<%=filterMonth%>";
                    $("#slmonth").val(filterMonth);
                    var filterMap = "<%=filterMap%>";
                        $("#slmap").val(filterMap)
                    function ChangeMonth(t, obj)
                        {
                        var yearCurrent = $("#slyear").val();
                        var m = parseInt($("#slmonth").val());
                        if (t == 'u')
                        {
                            if(m<12)
                            {
                                $("#slmonth").val(m + 1);
                            }
                            else
                            {
                                $("#slmonth").val(1);                                
                                $("#slyear").val(yearCurrent + 1);
                            }

                        }
                        else
                        {
                            if (m > 1) {
                                $("#slmonth").val(m -1);
                            }
                            else
                            {
                                $("#slmonth").val(12);
                                $("#slyear").val(yearCurrent - 1);
                            }

                        }
                        obj.submit();
                            
                    }
                </script>

                
        </form>
        <div class="row clearfix">
            
		    <div class="col-md-12 column">          
                    <%
                        Dim latInit, lngInit, lstLatLng    
                        latInit = 0
                        lngInit = 0
                        lstLatLng = ""
                        Set objCon = Server.CreateObject("ADODB.Connection")
                        Set objRds = Server.CreateObject("ADODB.Recordset") 
                        objCon.Open sConnStringcms                  
                        sql = "SELECT  lng_report as  DeliveryLng, lat_report as  DeliveryLat, OrderDate,year(OrderDate), Month(OrderDate) "
                        sql = sql & " FROM view_paid_orders " 
                        sql = sql & " WHERE  OrderDate IS NOT NULL and IdBusinessDetail =" &  Session("MM_id")  & " and lng_report <> '' and lat_report <> '' and year(OrderDate)="&filterYear&" and Month(OrderDate)="&filterMonth 
                       ' Response.Write(sql)
                        'Response.End()
                        objRds.Open  SQL , objCon,1 
                        Do While NOT objRds.Eof  
                           ' latInit = objRds("DeliveryLat")
                           ' lngInit = objRds("DeliveryLng") 
                            lstLatLng = lstLatLng & objRds("DeliveryLat") & "," & objRds("DeliveryLng") & "|"
                            objRds.MoveNext    
                        Loop                   
                        
                        objRds.Close
                        set objRds = nothing
                        sql = "Select Latitude,Longitude from BusinessDetails    where ID="  & Session("MM_id") 
                        Set objRds = Server.CreateObject("ADODB.Recordset") 
                         objRds.Open  SQL , objCon,1 
                        if not objRds.EOF then
                            latInit = objRds("Latitude")
                            lngInit = objRds("Longitude") 
                        end if
                         objRds.Close
                        set objRds = nothing
                        objCon.Close
                        set objCon = nothing
                    %>
              
             
		    </div>
	    </div>
        <script>
      function initMap() {

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 10,
          center: {lat: <%=latInit %>, lng: <%=lngInit %>}
        });
        // Create an array of alphabetical characters used to label the markers.
        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "locations" array.
        // The map() method here has nothing to do with the Google Maps API.
        var markers = locations.map(function(location, i) {
          return new google.maps.Marker({
            position: location,
            label: labels[i % labels.length]
          });
        });

        // Add a marker clusterer to manage the markers.
        var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      }
            var locations = [];
            var itemLocation = "";
            var lstLatLng = "<%=lstLatLng %>";
            var arrLatLng = lstLatLng.split("|");
            for(var i=0; i < arrLatLng.length; i++)
            {
                if(arrLatLng[i].split(",")[0]!="")
                {
                    itemLocation = {lat: parseFloat(arrLatLng[i].split(",")[0]), lng: parseFloat(arrLatLng[i].split(",")[1])};
                    locations.push(itemLocation);
                }
            }
    </script>
    <%
        if filterMap=1 Then
            %>
                <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&callback=initMap">
    </script>
            <%
        End If
    %>
    
</div>
   
            <div id="map" style=""></div>       
     

    <%
        if filterMap=2 Then
        %>
            <script type="text/javascript"
            src="https://maps.googleapis.com/maps/api/js?key=<%= GMAP_API_KEY %>&libraries=visualization">
    </script>
    <script>
        var heatmapData = [];
            var itemLocation = "";
            var lstLatLng = "<%=lstLatLng %>";
            var arrLatLng = lstLatLng.split("|");
            for(var i=0; i < arrLatLng.length; i++)
            {
                if(arrLatLng[i].split(",")[0]!="")
                {
                    itemLocation = new google.maps.LatLng(parseFloat(arrLatLng[i].split(",")[0]), parseFloat(arrLatLng[i].split(",")[1]));
                    heatmapData.push(itemLocation);
                }
            }   
        var positionDefault = new google.maps.LatLng(<%=latInit %>, <%=lngInit %>);

        map = new google.maps.Map(document.getElementById('map'), {
            center: positionDefault,
            zoom: 10,
           mapTypeId: google.maps.MapTypeId.HYBRID
        });

        var heatmap = new google.maps.visualization.HeatmapLayer({
            data: heatmapData
        });
        heatmap.setMap(map);
    </script>
        <%
        End If
    %>
</body>
</html>
