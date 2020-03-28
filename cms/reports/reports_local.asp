<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!-- #include file="../timezone.asp" -->

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
	<script type="text/javascript" src="../js/scripts.js"></script>
	

</head>

<body>
<div class="container">
	<!-- #Include file="../inc-header.inc"-->
	

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<div id="container" style="min-width: 310px; height: 300px; margin: 0 auto"></div>









<%
label=""
ccollections=""
deliveries=""
for i=29 to 0 step -1
    ccc=DateAdd("h",houroffset,now)
    ccc=DateAdd("d",-i,ccc)
    currentmonth=Month(ccc)
    currentyear=Year(ccc)
    currentday=Day(ccc)
    currentmonthname=MonthName(currentmonth)
    label=label &"'" & Day(ccc) & left(currentmonthname,3) & "',"
   ' objRds.Close
    'set objRds = nothing
    'objCon.Close
    'objCon.Open sConnStringcms
     Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    objCon.Open sConnStringcms
    objRds.Open "SELECT Day([OrderDate]) AS ddd, Month([OrderDate]) AS mmm, Year([OrderDate]) AS yyy, Orderslocal.IdBusinessDetail, Orderslocal.acknowledged, Orderslocal.DeliveryType, Count(Orderslocal.DeliveryType) AS CountOfDeliveryType FROM view_paid_orderslocal as Orderslocal GROUP BY Day([OrderDate]), Month([OrderDate]), Year([OrderDate]), Orderslocal.IdBusinessDetail, Orderslocal.acknowledged, Orderslocal.DeliveryType HAVING   (((Day([OrderDate]))=" & currentday & ") AND ((Month([OrderDate]))=" & currentmonth & ") AND ((Year([OrderDate]))=" & currentyear & ") AND ((Orderslocal.IdBusinessDetail)=" & Session("MM_id") & ") );", objCon

    if not objRds.EOF then
        ccollections=ccollections & objRds("CountOfDeliveryType") & ","
    else 
        ccollections=ccollections & "0,"
    end if

    objRds.Close
    set objRds = nothing
    'objCon.Close
    'objCon.Open sConnStringcms
    Set objRds = Server.CreateObject("ADODB.Recordset")   
    objRds.Open "SELECT Day([OrderDate]) as ddd, Month([OrderDate]) AS mmm, Year([OrderDate]) AS yyy, Orderslocal.IdBusinessDetail, Orderslocal.acknowledged, Orderslocal.DeliveryType, Count(Orderslocal.DeliveryType) AS CountOfDeliveryType FROM view_paid_orderslocal as Orderslocal GROUP BY Day([OrderDate]), Month([OrderDate]), Year([OrderDate]), Orderslocal.IdBusinessDetail, Orderslocal.acknowledged, Orderslocal.DeliveryType HAVING  (((Day([OrderDate]))=" & currentday & ") AND ((Month([OrderDate]))=" & currentmonth & ") AND ((Year([OrderDate]))=" & currentyear & ") AND ((Orderslocal.IdBusinessDetail)=" & Session("MM_id") & ")  AND ((Orderslocal.DeliveryType)='d'));", objCon


    if not objRds.EOF then
        deliveries=deliveries & objRds("CountOfDeliveryType") & ","
    else 
        deliveries=deliveries & "0,"
    end if
        objRds.close()
    set objRds = nothing
next
label=left(label,len(label)-1)
ccollections=left(ccollections,len(ccollections)-1)
deliveries=left(deliveries,len(deliveries)-1)
%>

<script language="javascript">
$(function () {
    $('#container').highcharts({
        title: {
            text: 'Sales Trends and Monitoring',
            x: -20 //center
        },
        subtitle: {
            text: 'Sales in the last 30 days',
            x: -20
        },
        xAxis: {
            categories: [<%=label%>]
        },
        yAxis: {
            title: {
                text: 'Orders'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: ' orders'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
		 credits: {
      enabled: false
  },
        series: [{
            name: 'Deliveries',
            data: [<%=deliveries%>]
        }, {
            name: 'Collections',
            data: [<%=ccollections%>]
        
        }]
    });
});
</script>


<br><br>






<div id="containermain2" style="min-width: 310px; height: 300px; margin: 0 auto"></div>





<%
label=""
ccollections=""
deliveries=""
for i=11 to 0 step -1
    ccc=DateAdd("h",houroffset,now)
    ccc=DateAdd("m",-i,ccc)
    currentmonth=Month(ccc)
    currentyear=Year(ccc)

    currentmonthname=MonthName(currentmonth)
    label=label &"'" & left(currentmonthname,3) & "',"
    'objRds.Close
    'set objRds =  nothing
    'objCon.Close
    'objCon.Open sConnStringcms
    Set objRds = Server.CreateObject("ADODB.Recordset")   
    objRds.Open "SELECT Month([OrderDate]) AS mmm, Year([OrderDate]) AS yyy, Orderslocal.IdBusinessDetail, Orderslocal.acknowledged, Orderslocal.DeliveryType, Count(Orderslocal.DeliveryType) AS CountOfDeliveryType FROM view_paid_orderslocal Orderslocal GROUP BY Month([OrderDate]), Year([OrderDate]), Orderslocal.IdBusinessDetail, Orderslocal.acknowledged, Orderslocal.DeliveryType HAVING   (((Month([OrderDate]))=" & currentmonth & ") AND ((Year([OrderDate]))=" & currentyear & ") AND ((Orderslocal.IdBusinessDetail)=" & Session("MM_id") & ")  );", objCon

    if not objRds.EOF then
        ccollections=ccollections & objRds("CountOfDeliveryType") & ","
    else 
        ccollections=ccollections & "0,"
    end if

    objRds.Close
    set objRds = nothing
    'objCon.Close
    'objCon.Open sConnStringcms
    Set objRds = Server.CreateObject("ADODB.Recordset")   
    objRds.Open "SELECT Month([OrderDate]) AS mmm, Year([OrderDate]) AS yyy, Orderslocal.IdBusinessDetail, Orderslocal.acknowledged, Orderslocal.DeliveryType, Count(Orderslocal.DeliveryType) AS CountOfDeliveryType FROM view_paid_orderslocal  Orderslocal GROUP BY Month([OrderDate]), Year([OrderDate]), Orderslocal.IdBusinessDetail, Orderslocal.acknowledged, Orderslocal.DeliveryType HAVING   (((Month([OrderDate]))=" & currentmonth & ") AND ((Year([OrderDate]))=" & currentyear & ") AND ((Orderslocal.IdBusinessDetail)=" & Session("MM_id") & ")  AND ((Orderslocal.DeliveryType)='d'));", objCon


    if not objRds.EOF then
        deliveries=deliveries & objRds("CountOfDeliveryType") & ","
    else 
        deliveries=deliveries & "0,"
    end if
    objRds.close()
    set objRds = nothing

next
label=left(label,len(label)-1)
ccollections=left(ccollections,len(ccollections)-1)
deliveries=left(deliveries,len(deliveries)-1)
%>

<script language="javascript">
$(function () {
    $('#containermain2').highcharts({
        title: {
            text: 'Sales Trends and Monitoring',
            x: -20 //center
        },
        subtitle: {
            text: 'Sales in the last 12 months',
            x: -20
        },
        xAxis: {
            categories: [<%=label%>]
        },
        yAxis: {
            title: {
                text: 'Orders'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: ' orders'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
		 credits: {
      enabled: false
  },
        series: [{
            name: 'Deliveries',
            data: [<%=deliveries%>]
        }, {
            name: 'Collections',
            data: [<%=ccollections%>]
        
        }]
    });
});
</script>


    <br><br>
    <br><br>
     <div class="row clearfix">
        <div class="col-md-12 column">
        <h3>Top Selling Menu Items<small>(Last 3 months)</small></h3>

		  <%
		  Dim itempercentages() 'Dynamic size array

		  
		  'objRds.Close
          'set objRds = nothng
'objCon.Close
'objCon.Open sConnStringcms
Set objRds = Server.CreateObject("ADODB.Recordset")  
objRds.Open "SELECT TOP 20 OrderItemslocal.MenuItemId, MenuItems.Name, Orderslocal.acknowledged, Count(MenuItems.Name) AS CountOfName FROM MenuItems    INNER JOIN (OrderItemslocal    INNER JOIN view_paid_orderslocal Orderslocal ON OrderItemslocal.OrderId = Orderslocal.ID) ON MenuItems.Id = OrderItemslocal.MenuItemId GROUP BY OrderItemslocal.MenuItemId, MenuItems.Name, Orderslocal.IdBusinessDetail, (((DateDiff(minute,[orderdate],getdate())))), Orderslocal.acknowledged HAVING (((Orderslocal.IdBusinessDetail)=" & Session("MM_id") & ") AND (((((DateDiff(minute,[orderdate],getdate())))))<=3) ) ORDER BY OrderItemslocal.MenuItemId;", objCon
atleast1=0
cntsame=0
cntitem=0
cntitemname=""
itemcnt=0

Do While NOT objRds.Eof
itemcnt=itemcnt+objRds("CountOfName")
 objRds.MoveNext    
Loop

if itemcnt>0 then
     objRds.MoveFirst
    sss=""

    Do While NOT objRds.Eof

        x=formatnumber((objRds("CountOfName")/itemcnt)*100,2)

        sss = sss & "['" & objRds("Name") & "'," & x & "],"
        itemcnt=itemcnt+1
         objRds.MoveNext    
    Loop
    objRds.close()
    set objRds = nothing

    sss=left(sss,len(sss)-1)
end if
%>

<div id="container2" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
<script language="javascript">
$(function () {
    	
    	// Radialize the colors
		Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function(color) {
		    return {
		        radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
		        stops: [
		            [0, color],
		            [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
		        ]
		    };
		});
		
		// Build the chart
        $('#container2').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'Most popular menu items'
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name +'</b>: '+ this.percentage.toFixed(1) +' %';
                        }
                    }
                }
            },
			 credits: {
      enabled: false
  },
            series: [{
                type: 'pie',
                name: 'Most popular dishes',
                data: [
                   <%=sss%>
                ]
            }]
        });
    });
</script>





        </div>
        </div>
    <br><br>
     <div class="row clearfix">
		<div class="col-md-12 column">
        <h3>Top Selling Menu Items<small>(Last 1 month)</small></h3>

		  <%
		  

		  
		  'objRds.Close
          'set objRds =  nothing
'objCon.Close
'objCon.Open sConnStringcms
Set objRds = Server.CreateObject("ADODB.Recordset")  
objRds.Open "SELECT TOP 20 OrderItemslocal.MenuItemId, MenuItems.Name, Orderslocal.acknowledged, Count(MenuItems.Name) AS CountOfName FROM MenuItems    INNER JOIN (OrderItemslocal    INNER JOIN view_paid_orderslocal Orderslocal ON OrderItemslocal.OrderId = Orderslocal.ID) ON MenuItems.Id = OrderItemslocal.MenuItemId GROUP BY OrderItemslocal.MenuItemId, MenuItems.Name, Orderslocal.IdBusinessDetail, (((DateDiff(minute,[orderdate],getdate())))), Orderslocal.acknowledged HAVING (((Orderslocal.IdBusinessDetail)=" & Session("MM_id") & ") AND (((((DateDiff(minute,[orderdate],getdate())))))<=1) ) ORDER BY OrderItemslocal.MenuItemId;", objCon
atleast1=0
cntsame=0
cntitem=0
cntitemname=""
itemcnt=0

Do While NOT objRds.Eof
itemcnt=itemcnt+objRds("CountOfName")
 objRds.MoveNext    
Loop

if itemcnt>0 then
     objRds.MoveFirst
 
 
    sss=""

    Do While NOT objRds.Eof

        x=formatnumber((objRds("CountOfName")/itemcnt)*100,2)

        sss = sss & "['" & objRds("Name") & "'," & x & "],"
        itemcnt=itemcnt+1
         objRds.MoveNext    
    Loop
    objRds.close()
    set objRds = nothing

    sss=left(sss,len(sss)-1)
end if
%>

<div id="container3" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
<script language="javascript">
$(function () {
    	
    
		
		// Build the chart
        $('#container3').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'Most popular menu items - last 30 days'
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name +'</b>: '+ this.percentage.toFixed(1) +' %';
                        }
                    }
                }
            },
			 credits: {
      enabled: false
  },
            series: [{
                type: 'pie',
                name: 'Most popular dishes',
                data: [
                   <%=sss%>
                ]
            }]
        });
    });
</script>
        </div>
		</div>
		<br><br>
		
		 <div class="row clearfix">
		
		<div class="col-md-12 column">
        <h3>Top Selling Menu Items<small>(Last week)</small></h3>

		  <%
		  

		  
		 ' objRds.Close
         'set objRds = nothing
'objCon.Close
'objCon.Open sConnStringcms
Set objRds = Server.CreateObject("ADODB.Recordset")  
objRds.Open "SELECT TOP 20 OrderItemslocal.MenuItemId, MenuItems.Name, Orderslocal.acknowledged, Count(MenuItems.Name) AS CountOfName FROM MenuItems    INNER JOIN (OrderItemslocal    INNER JOIN view_paid_orderslocal Orderslocal ON OrderItemslocal.OrderId = Orderslocal.ID) ON MenuItems.Id = OrderItemslocal.MenuItemId GROUP BY OrderItemslocal.MenuItemId, MenuItems.Name, Orderslocal.IdBusinessDetail, (((DateDiff(day,[orderdate],getdate())))), Orderslocal.acknowledged HAVING (((Orderslocal.IdBusinessDetail)=" & Session("MM_id") & ") AND (((((DateDiff(day,[orderdate],getdate())))))<=7) ) ORDER BY OrderItemslocal.MenuItemId;", objCon
atleast1=0
cntsame=0
cntitem=0
cntitemname=""
itemcnt=0

Do While NOT objRds.Eof
itemcnt=itemcnt+objRds("CountOfName")
 objRds.MoveNext    
Loop

if itemcnt>0 then
     objRds.MoveFirst
 
 
    sss=""

    Do While NOT objRds.Eof
        x=formatnumber((objRds("CountOfName")/itemcnt)*100,2)

        sss = sss & "['" & objRds("Name") & "'," & x & "],"
        itemcnt=itemcnt+1
         objRds.MoveNext    
    Loop
    objRds.close()
    set objRds = nothing

    sss=left(sss,len(sss)-1)
end if
        objCon.close()
    set objCon = nothing
%>

<div id="container4" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
<script language="javascript">
$(function () {
    	
    
		
		// Build the chart
        $('#container4').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'Most popular menu - last week'
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name +'</b>: '+ this.percentage.toFixed(1) +' %';
                        }
                    }
                }
            },
			 credits: {
      enabled: false
  },
            series: [{
                type: 'pie',
                name: 'Most popular dishes',
                data: [
                   <%=sss%>
                ]
            }]
        });
    });
</script>
        </div>
      </div>
</div>
</body>
</html>
