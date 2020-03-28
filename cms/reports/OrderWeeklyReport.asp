<%@LANGUAGE="VBSCRIPT"%>
<%
    if request.QueryString("rid")&"" <> "" then
        Session("MM_id")  = request.QueryString("rid")
    elseif request.form("rid")&"" <> "" then
         Session("MM_id")  = request.form("rid")
    end if
    if request.Form("MM_Username") & "" <> "" then
        Session("MM_Username")  = request.Form("MM_Username")
    end if

    if request.Form("MM_UserAuthorization") & "" <> "" then
        Session("MM_UserAuthorization")  = request.Form("MM_UserAuthorization")
    end if

     %>
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
   ' Response.Write(MM_authFailedURL)
    'Response.End
'  Response.Redirect(MM_authFailedURL)
End If
    Dim listMonth 
    listMonth = ""
    sub GetDayName(mF, m, value)
        For i=mF to m
            if i < m Then
                Response.Write("<tr><td>")
                call GetFullDayName(i) 
                Response.Write("</td><td>No Orders.</td></tr>")                
            End If            
        Next
        Response.Write("<tr><td>")
        call GetFullDayName(m) 
        If value > 0 Then
            Response.Write("</td><td>"&value&" Orders.</td></tr>") 
        Else
            Response.Write("</td><td>No Orders.</td></tr>") 
        End If
    end sub
    sub GetDayName2(mF, m, value)
        if mF < m Then
            For i=mF to m
                if i < m Then
                    listMonth = listMonth & GetFullDayName2(i) & ",0|"  
                End If            
            Next
        End If
        listMonth = listMonth & GetFullDayName2(m) & "," & value & "|"    
    end sub
    sub GetFullDayName(m)
        Select Case m
	       
	        Case 1
		        Response.Write("Mon")
	        Case 2
		        Response.Write("Tue")
            Case 3
		        Response.Write("Web")
            Case 4
		        Response.Write("Thu")
            Case 5
		        Response.Write("Fri")
            Case 6
		        Response.Write("Sat")
            Case 7
		        Response.Write("Sun")
	        Case Else
		        Response.Write("") 
        End Select
    end sub
    
    Function GetFullDayName2(m)
        Select Case m
	        
	        Case 1
		        GetFullDayName2 = "Mon"
	        Case 2
		        GetFullDayName2 = "Tue"
            Case 3
		        GetFullDayName2 = "Web"
            Case 4
		        GetFullDayName2 = "Thu"
            Case 5
		        GetFullDayName2 = "Fri"
            Case 6
		        GetFullDayName2 = "Sat"
            Case 7
		        GetFullDayName2 = "Sun"
	        Case Else
		        GetFullDayName2 = "" 
        End Select
    End Function
    Function GetDateFormatMode()
        Select Case dateformatmode
	        Case 1
		        GetDateFormatMode = "dd/mm/yy"
	        Case 2
		        GetDateFormatMode = "mm/dd/yy"
	        Case 3
		        GetDateFormatMode = "MM dd yy"
            Case 4
		        GetDateFormatMode = "MM dd yy"
            Case 5
		        GetDateFormatMode = "dd MM yy"
            Case 6
		        GetDateFormatMode = "dd MM yy"
	        Case Else
		        GetDateFormatMode = "" 
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
    <script type="text/javascript">
        var fModeDate = "<%=GetDateFormatMode()%>";
    </script>
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
    <script src="../js/jqueryui-1.12/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="../css/jqueryui/ui/1.12.1/jquery-ui.css">
<!--     <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/flick/jquery-ui.css">-->

	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
    <script type="text/javascript" src="../js/weekPicker.js?v=12.1.0"></script>
	<!--<script src="../js/highcharts.js" type="text/javascript"></script>-->
    

	<script src="https://code.highcharts.com/highcharts.js"></script>	

    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <!-- optional -->
    <script src="https://code.highcharts.com/modules/offline-exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    
</head>

<body>


<div class="container">
	 <!-- #Include file="../inc-header.inc"-->           
        <form class="form-inline" method="post">
            <input type="hidden" name="rid" value="<%=Session("MM_id") %>" />
            <input type="hidden" name="MM_Username" value="<%=Session("MM_Username") %>" />
            <input type="hidden" name="MM_UserAuthorization" value="<%=Session("MM_UserAuthorization") %>" />
            
            <%
                
                dim filterYear, filterWeek, filterDay, filterFullDay
                filterYear = year(now)
                filterWeek = DatePart("ww",now,2)
                filterDay = ""
                filterFullDay = month(now) & "/" & day(now) & "/" & year(now)
                
                If Request.Form("year") & "" <> "" Then
                    filterYear = Request.Form("year")
                Elseif Request.QueryString("year") & "" <> "" Then
                    filterYear = Request.QueryString("year")
                End If
                
                If Request.Form("week") & "" <> "" Then
                    filterWeek = Request.Form("week")
                Elseif Request.QueryString("week") & "" <> "" Then
                    filterWeek = Request.QueryString("week")
                End If

                If Request.Form("day") & "" <> "" Then
                    filterDay = Request.Form("day")
                Elseif Request.QueryString("day") & "" <> "" Then
                    filterDay = Request.QueryString("day")
                End If

                If Request.Form("fullday") & "" <> "" Then
                    filterFullDay = Request.Form("fullday")
                Elseif Request.QueryString("fullday") & "" <> "" Then
                    filterFullDay = Request.QueryString("fullday")
                End If

                
            %>
            <h1>Weekly Orders Report</h1><br />

			<table width="340" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>                 <strong>Calendar</strong> <br>
                 <input type="text" name="day" value="<%=filterYear &"-"&filterWeek %>" style="width:120px" id="weekPicker" class="form-control week-picker"/>
                 <input type="hidden" name="fullday" value="<%=filterFullDay %>" id="fullday"/>
</td>



    <td><strong>Year:</strong> <br>
                <label class="lbyear"> <%=filterYear %></label>              
                </td>
                
                
    <td><strong>Week: </strong> <br>
    	<label class="lbweek"><%=filterWeek %></label>
    </td>
    
    
    <td><strong>Total orders:</strong> <br>
    	<label id="thTotalOrder">0</label>
    
		<input type="hidden" class="clweek" name="week" value="<%=filterWeek %>" />    
        <input type="hidden" class="clyear" name="year" value="<%=filterYear %>" />  
    </td>
    
    
  </tr>
</table>




           
       
                
             

        </form>
        <div class="row clearfix"></div>
        <div class="row clearfix" style="margin-top:10px">            
		    <div class="col-md-12 column">
                    <div class="table-responsive">
                        
                    <%
                      ' Response.Write("filterWeek " & filterWeek & "<br/>")
                      Dim mF, mL, totalOrders, isData
                        mF = 1
                        mL = 7
                        totalOrders = 0
                        isData = false
                        objCon.Open sConnStringcms    
                        
                        sql = " set datefirst 1; "
                        sql = sql & " SELECT CAST(OrderDate as DATE) as fullDate, COUNT(ID) as totalOrders,  "
                        sql = sql & " DatePart(w,OrderDate) as dayName  "
                        sql = sql & " FROM view_paid_orders Where OrderDate IS NOT NULL and year(OrderDate)= " & filterYear
                        sql = sql & " and DatePart(ww,OrderDate)=" & filterWeek & " and IdBusinessDetail = " & Session("MM_id") & " and cancelled<>1  "
                        sql = sql & " GROUP BY CAST(OrderDate as DATE), DatePart(w,OrderDate) ORDER BY dayName asc "

                                      
                       
                        
                       
                        objRds.Open  sql , objCon,1 
                        
                        Do While NOT objRds.Eof  
                        isData = true
                           totalOrders = totalOrders + cint(objRds("totalOrders"))
                            mL = objRds("dayName") 
                            'Response.Write(mF & "<>" & objRds("dayName") & "<br/>")
                            call GetDayName2(mF, objRds("dayName"),objRds("totalOrders"))
                            mF = objRds("dayName") + 1
                            objRds.MoveNext    
                        Loop                   
                       
                        objRds.Close
                        set objRds = nothing
                        objCon.Close
                        set objCon = nothing

                        if isData=false Then
                            call GetDayName2(1, 7, 0)
                        Else
                           If mL < 7 Then
                             call GetDayName2(mL+1, 7, 0)
                           End If
                        End If
                        'Response.Write("ALL " & listMonth)
                        'Response.End()
                    %>      
                    <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>    
		    </div>
	    </div>
</div>
</div>

    <script type="text/javascript">
        
        $("#thTotalOrder").html("<%=totalOrders%>");
        convertToWeekPicker($("#weekPicker"));
        //ShowWeekInDesc();
        //var filterDay = "<%=filterDay %>";
        //if (filterDay == "")
        //    $(".week-picker").datepicker("setDate", new Date());
        //else
        //    $(".week-picker").datepicker("setDate", new Date(filterDay));
        function ShowWeekInDesc() {
            var datepickerValue = new Date($('#fullday').val());
            var dateObj = new Date(datepickerValue.getFullYear(), datepickerValue.getMonth(), datepickerValue.getDate());
            var weekNum = $.datepicker.iso8601Week(dateObj);
            if (weekNum < 10) {
                weekNum = "0" + weekNum;
            }
            var weekYear = datepickerValue.getFullYear();
            if (datepickerValue.getMonth() == 11 && weekNum == 01) {
                weekYear += 1;
            }
            var ywString = weekYear + '-' + weekNum;
            $("#weekPicker").val(ywString);
            //console.log(ywString);
            //$(".clweek").val(ywString);
        }
    </script>
    
    <script type="text/javascript">
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
                    text: 'Weekly Orders Report'
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
                                return this.y <= 0 ? "No Orders" : (this.y <= 1 ? this.y + " order" : this.y + " orders"); //Highcharts.numberFormat(this.y,2);
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
