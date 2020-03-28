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
    Dim listMonth 
    listMonth = ""
    sub GetMonth(mF, m, value)
        For i=mF to m
            if i < m-1 Then
                Response.Write("<tr><td>")
                call MonthName(i) 
                Response.Write("</td><td>No Orders.</td></tr>")                
            End If            
        Next
        Response.Write("<tr><td>")
        call MonthName(m) 
        If value > 0 Then
            Response.Write("</td><td>"&value&" Orders.</td></tr>") 
        Else
            Response.Write("</td><td>No Orders.</td></tr>") 
        End If
    end sub
    sub MonthName(m)
        Select Case m
	        Case 1
		        Response.Write("Jan")
	        Case 2
		        Response.Write("Feb")
	        Case 3
		        Response.Write("Mar")
            Case 4
		        Response.Write("Apr")
            Case 5
		        Response.Write("May")
            Case 6
		        Response.Write("Jun")
            Case 7
		        Response.Write("Jul")
            Case 8
		        Response.Write("Aug")
            Case 9
		        Response.Write("Sept")
            Case 10
		        Response.Write("Oct")
            Case 11
		        Response.Write("Nov")
	        Case Else
		        Response.Write("Dec") 
        End Select
    end sub
    sub GetMonth2(mF, m, value)
    if mF < m Then
        For i=mF to m
            if i < m Then
                listMonth = listMonth & MonthName2(i) & ",0|"    
            End If            
        Next
    End If
        listMonth = listMonth & MonthName2(m) & "," & value & "|"    
    end sub
    Function MonthName2(m)
        Select Case m
	        Case 1
		        MonthName2 = "Jan"
	        Case 2
		        MonthName2 = "Feb"
	        Case 3
		        MonthName2 = "Mar"
            Case 4
		        MonthName2 = "Apr"
            Case 5
		        MonthName2 = "May"
            Case 6
		        MonthName2 = "Jun"
            Case 7
		        MonthName2 = "Jul"
            Case 8
		        MonthName2 = "Aug"
            Case 9
		        MonthName2 = "Sept"
            Case 10
		        MonthName2 = "Oct"
            Case 11
		        MonthName2 = "Nov"
	        Case Else
		        MonthName2 = "Dec" 
        End Select
    End Function
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
	<script type="text/javascript" src="../js/scripts.js"></script>
    <!--<script src="../js/highcharts.js" type="text/javascript"></script>	 -->
	<script src="../js/highcharts.js" type="text/javascript"></script>	 
    
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
	<!-- optional -->
	<script src="https://code.highcharts.com/modules/offline-exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>
    
</head>

<body>


<div class="container">
    
	 <!-- #Include file="../inc-header.inc"-->   
            <div class="row clearfix">
		<div class="col-md-12 column">
            <h1>Monthly Orders Report</h1>
            </div>
       </div>
        <form class="form-inline">
            <%
                dim filterYear
                filterYear = year(now)             
                If Request.Form("year") & "" <> "" Then
                    filterYear = Request.Form("year")
                Elseif Request.QueryString("year") & "" <> "" Then
                    filterYear = Request.QueryString("year")
                End If               
  
            %>
                <div class="col-lg-12">
                
                
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="200"><strong>Year:</strong> <br> 
                    <select id="slyear" name="year" class="form-control" style="width:120px;"  onchange="this.form.submit()">
                    <%
                        objCon.Open sConnStringcms                  
                        sql = "select distinct  year(OrderDate) as yearOrder FROM  view_paid_orders WHERE year(OrderDate) <> ''  and IdBusinessDetail =" &  Session("MM_id")
                        sql = sql & " AND  cancelled<>1 "
                        sql = sql   & "  ORDER BY  year(OrderDate) asc "
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
                
                
                
                
                
                
    <td>         <label>Total orders: </label> <br>
    			 <label id="thTotalOrder">0</label>
               </td>
  </tr>
</table>

               
                <script type="text/javascript">
                    var filterYear = "<%=filterYear%>";
                    $("#slyear").val(filterYear);
                </script>

        </form>
        <br />
        <div class="row clearfix">            
		    <div class="col-md-12 column">
                    <div class="table-responsive">
            	        <table class="table table-hover table-condensed table-striped">
				        <thead>
					        <tr>
					            <th>Months</th>						        					
					        </tr>
				        </thead>
				        <tbody>          
                    <%
                       Dim mF, mL, isData
                        mF = 1
                        mL = 12
                        isData = false
                        Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
                        objCon.Open sConnStringcms                  
                        sql = "SELECT count(id) as totalOrders,Month(OrderDate) as monthCurrent "
                        sql = sql & " FROM view_paid_orders " 
                        sql = sql & " WHERE year(OrderDate)="&filterYear 
                        sql = sql & " and IdBusinessDetail =" &  Session("MM_id") 
                        sql = sql & "  and  cancelled<>1 "
                        sql = sql & " group by Month(OrderDate) " 
                        ''Response.Write(sql)
                        sql = sql & " Order by monthCurrent asc " 
                       
                        objRds.Open  sql , objCon,1 
                        dim totalOrders
                            totalOrders = 0    
                        Do While NOT objRds.Eof  
                            isData = true
                            mL = objRds("monthCurrent") 
                            'Response.Write(mF & "<>" & objRds("monthCurrent") & "<br/>")
                            totalOrders  = totalOrders + cint(objRds("totalOrders"))
                            call GetMonth2(mF, objRds("monthCurrent"),objRds("totalOrders"))
                            mF = objRds("monthCurrent") + 1
                            objRds.MoveNext    
                        Loop                   
                       
                        objRds.Close
                        set objRds = nothing
                        objCon.Close
                        set objCon = nothing

                        if isData=false Then
                            call GetMonth2(1, 12, 0)
                        Else
                           If mL < 12 Then
                             call GetMonth2(mL+1, 12, 0)
                           End If
                        End If

                        'If mL < 12 Then
                        '   call GetMonth2(mL+1, 12, 0)
                        'End If
                        'Response.Write("ALL " & listMonth)
                        'Response.End()
                    %>      
                        </tbody>       
                    </table>
                         <div id="container" style="min-width: 310px; height: 600px; margin: 0 auto"></div>   
		    </div>
	    </div>
</div>
</div>
        <script type="text/javascript">
            $("#thTotalOrder").html("<%=totalOrders%>");
        $(document).ready(function () {
            var categories = [];
            var data = [];            
            var lstMonth = "<%=listMonth%>";
            var arrlstMonth = lstMonth.split("|");
            for (var i = 0; i < arrlstMonth.length; i++) {
                if (arrlstMonth[i].split(",")[0] != "") {
                    categories.push(arrlstMonth[i].split(",")[0]);
                    data.push(parseInt(arrlstMonth[i].split(",")[1]));
                }
            }
        Highcharts.chart('container', {
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Monthly Order Report'
            },
            xAxis: {

                categories: categories,
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: null
                },
                labels: {
                    overflow: 'justify'
                    
                }
            },
            tooltip: {
                // valueSuffix: ' millions'
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true,                        
                        formatter: function () {
                            return this.y <= 0 ? "No Orders" : (this.y <= 1 ? this.y +  " Order" : this.y + " Orders"); //Highcharts.numberFormat(this.y,2);
                        },
                        style: { "fontWeight": "normal" }
                    }
                }                
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -40,
                y: 40,
                //floating: true,
                borderWidth: 1,
                //backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: [{
                name: 'Orders',
                data: data
            }]
        });
    });
    </script> 
</body>
</html>
