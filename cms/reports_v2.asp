<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<!-- #include file="timezone.asp" -->

<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="index.asp?e=2"
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
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <link rel='shortcut icon' href='../images-icons/favicon.ico' type='image/x-icon'/ >
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	

</head>

<body>
<div class="container">
	<!-- #Include file="inc-header.inc"-->
	

<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>
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
objRds.Close
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT Day([OrderDate]) AS ddd, Month([OrderDate]) AS mmm, Year([OrderDate]) AS yyy, Orders.IdBusinessDetail, Orders.acknowledged, Orders.DeliveryType, Count(Orders.DeliveryType) AS CountOfDeliveryType FROM Orders GROUP BY Day([OrderDate]), Month([OrderDate]), Year([OrderDate]), Orders.IdBusinessDetail, Orders.acknowledged, Orders.DeliveryType HAVING   (((Day([OrderDate]))=" & currentday & ") AND ((Month([OrderDate]))=" & currentmonth & ") AND ((Year([OrderDate]))=" & currentyear & ") AND ((Orders.IdBusinessDetail)=" & Session("MM_id") & ")  AND ((Orders.DeliveryType)='c'));", objCon

if not objRds.EOF then
ccollections=ccollections & objRds("CountOfDeliveryType") & ","
else 
ccollections=ccollections & "0,"
end if

objRds.Close
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT Day([OrderDate]) as ddd, Month([OrderDate]) AS mmm, Year([OrderDate]) AS yyy, Orders.IdBusinessDetail, Orders.acknowledged, Orders.DeliveryType, Count(Orders.DeliveryType) AS CountOfDeliveryType FROM Orders GROUP BY Day([OrderDate]), Month([OrderDate]), Year([OrderDate]), Orders.IdBusinessDetail, Orders.acknowledged, Orders.DeliveryType HAVING  (((Day([OrderDate]))=" & currentday & ") AND ((Month([OrderDate]))=" & currentmonth & ") AND ((Year([OrderDate]))=" & currentyear & ") AND ((Orders.IdBusinessDetail)=" & Session("MM_id") & ")  AND ((Orders.DeliveryType)='d'));", objCon


if not objRds.EOF then
deliveries=deliveries & objRds("CountOfDeliveryType") & ","
else 
deliveries=deliveries & "0,"
end if


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
objRds.Close
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT Month([OrderDate]) AS mmm, Year([OrderDate]) AS yyy, Orders.IdBusinessDetail, Orders.acknowledged, Orders.DeliveryType, Count(Orders.DeliveryType) AS CountOfDeliveryType FROM Orders GROUP BY Month([OrderDate]), Year([OrderDate]), Orders.IdBusinessDetail, Orders.acknowledged, Orders.DeliveryType HAVING   (((Month([OrderDate]))=" & currentmonth & ") AND ((Year([OrderDate]))=" & currentyear & ") AND ((Orders.IdBusinessDetail)=" & Session("MM_id") & ")  AND ((Orders.DeliveryType)='c'));", objCon

if not objRds.EOF then
ccollections=ccollections & objRds("CountOfDeliveryType") & ","
else 
ccollections=ccollections & "0,"
end if

objRds.Close
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT Month([OrderDate]) AS mmm, Year([OrderDate]) AS yyy, Orders.IdBusinessDetail, Orders.acknowledged, Orders.DeliveryType, Count(Orders.DeliveryType) AS CountOfDeliveryType FROM Orders GROUP BY Month([OrderDate]), Year([OrderDate]), Orders.IdBusinessDetail, Orders.acknowledged, Orders.DeliveryType HAVING   (((Month([OrderDate]))=" & currentmonth & ") AND ((Year([OrderDate]))=" & currentyear & ") AND ((Orders.IdBusinessDetail)=" & Session("MM_id") & ")  AND ((Orders.DeliveryType)='d'));", objCon


if not objRds.EOF then
deliveries=deliveries & objRds("CountOfDeliveryType") & ","
else 
deliveries=deliveries & "0,"
end if


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



      <div class="row clearfix">
<div class="col-md-6 column">
          <h3>Top Customers <small>(Last 3 months)</small></h3>
     
   <div class="table-responsive">
  <table class="table table-bordered table-hover table-striped" id="topcustomers">
  <thead>
  <tr>
    <th>Name</th>
    <th>Surname</th>
    <th>Address</th>
    <th>Postcode</th>
    <th>Telephone No</th>
    <th>Orders </th>
    </thead></tr>
<tbody>
  
  <%objRds.Close
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT DISTINCTROW Orders.Email, Count(Orders.OrderTotal) AS CountOfOrderTotal, DateDiff('m',[orderdate],Now()), Orders.IdBusinessDetail, Orders.acknowledged FROM Orders GROUP BY Orders.Email, DateDiff('m',[orderdate],Now()), Orders.IdBusinessDetail, Orders.acknowledged HAVING (((DateDiff('m',[orderdate],Now()))<=1) AND ((Orders.IdBusinessDetail)=" & Session("MM_id") & ") ) ORDER BY Count(Orders.OrderTotal) DESC;", objCon





  Do While NOT objRds.Eof
  Set objCon2 = Server.CreateObject("ADODB.Connection")
    Set objRds2 = Server.CreateObject("ADODB.Recordset") 
   objCon2.Open sConnStringcms
                        objRds2.Open "SELECT * FROM ORDERS where email='" & objRds("Email")& "'" , objCon
						if not objRds2.eof then
%>
  <tr>
  <td><%=objRds2("FirstName")%></td>
    <td><%=objRds2("LastName")%></td>
    <td><%=objRds2("Address")%></td>
    <td><%=objRds2("PostalCode")%></td>
    <td><%=objRds2("Phone")%></td>
    <td><%=objRds("CountOfOrderTotal")%></td>
    </tr>
<%
end if
 objRds.MoveNext    
                        Loop%>
  
    </tbody>

 
</table>
</div>
         
		
          
        </div>
        <div class="col-md-6 column">
        <h3>Top Selling Menu Items<small>(Last 3 months)</small></h3>

		  <%
		  Dim itempercentages() 'Dynamic size array

		  
		  objRds.Close
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT TOP 20 OrderItems.MenuItemId, MenuItems.Name, Orders.acknowledged, Count(MenuItems.Name) AS CountOfName FROM MenuItems INNER JOIN (OrderItems INNER JOIN Orders ON OrderItems.OrderId = Orders.ID) ON MenuItems.Id = OrderItems.MenuItemId GROUP BY OrderItems.MenuItemId, MenuItems.Name, Orders.IdBusinessDetail, (((DateDiff('m',[orderdate],Now())))), Orders.acknowledged HAVING (((Orders.IdBusinessDetail)=" & Session("MM_id") & ") AND (((((DateDiff('m',[orderdate],Now())))))<=3) ) ORDER BY OrderItems.MenuItemId;", objCon
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
        
		<div class="col-md-12 column">
        <h3>Top Selling Menu Items<small>(Last 1 month)</small></h3>

		  <%
		  

		  
		  objRds.Close
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT TOP 20 OrderItems.MenuItemId, MenuItems.Name, Orders.acknowledged, Count(MenuItems.Name) AS CountOfName FROM MenuItems INNER JOIN (OrderItems INNER JOIN Orders ON OrderItems.OrderId = Orders.ID) ON MenuItems.Id = OrderItems.MenuItemId GROUP BY OrderItems.MenuItemId, MenuItems.Name, Orders.IdBusinessDetail, (((DateDiff('m',[orderdate],Now())))), Orders.acknowledged HAVING (((Orders.IdBusinessDetail)=" & Session("MM_id") & ") AND (((((DateDiff('m',[orderdate],Now())))))<=1) ) ORDER BY OrderItems.MenuItemId;", objCon
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
		
		
		
		
		
		
		
		
		
		
		<div class="col-md-12 column">
        <h3>Top Selling Menu Items<small>(Last week)</small></h3>

		  <%
		  

		  
		  objRds.Close
objCon.Close
objCon.Open sConnStringcms
objRds.Open "SELECT TOP 20 OrderItems.MenuItemId, MenuItems.Name, Orders.acknowledged, Count(MenuItems.Name) AS CountOfName FROM MenuItems INNER JOIN (OrderItems INNER JOIN Orders ON OrderItems.OrderId = Orders.ID) ON MenuItems.Id = OrderItems.MenuItemId GROUP BY OrderItems.MenuItemId, MenuItems.Name, Orders.IdBusinessDetail, (((DateDiff('d',[orderdate],Now())))), Orders.acknowledged HAVING (((Orders.IdBusinessDetail)=" & Session("MM_id") & ") AND (((((DateDiff('d',[orderdate],Now())))))<=7) ) ORDER BY OrderItems.MenuItemId;", objCon
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
 

sss=left(sss,len(sss)-1)
end if
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
