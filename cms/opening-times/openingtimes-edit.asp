<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!-- #include file="../timezone.asp" -->
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
   function formatIntDefault(byval val)
        dim result : result = 0
        if val & "" <> "" then
                result =  cint(val)
        end if
    formatIntDefault = result
   end function
Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
     dim Mon_Delivery,Tue_Delivery,Wed_Delivery,Thu_Delivery,Fri_Delivery,Sat_Delivery,Sun_Delivery
   dim Mon_Collection,Tue_Collection,Wed_Collection,Thu_Collection,Fri_Collection,Sat_Collection,Sun_Collection
    Dim avgDeliveryTime, avgCollectionTime
       avgDeliveryTime = "0"
    avgCollectionTime = "0"
       objCon.Open sConnStringcms
            Dim SQL_Time  : SQL_Time =  "SELECT AverageCollectionTime,AverageDeliveryTime,Mon_Delivery,Tue_Delivery,Wed_Delivery,Thu_Delivery,Fri_Delivery,Sat_Delivery,Sun_Delivery" 
                          SQL_Time = SQL_Time &  ",Mon_Collection,Tue_Collection,Wed_Collection,Thu_Collection,Fri_Collection,Sat_Collection,Sun_Collection " 
                          SQL_Time = SQL_Time & " from BusinessDetails   WHERE Id =  "    & Session("MM_id")
        objRds.Open  SQL_Time , objCon       
        If not objRds.EOF Then
            avgDeliveryTime = objRds("AverageDeliveryTime")
            avgCollectionTime = objRds("AverageCollectionTime")
            
            Mon_Delivery = formatIntDefault(objRds("Mon_Delivery") )
            Tue_Delivery = formatIntDefault(objRds("Tue_Delivery") )
            Wed_Delivery = formatIntDefault(objRds("Wed_Delivery") )
            Thu_Delivery = formatIntDefault(objRds("Thu_Delivery") )
            Fri_Delivery = formatIntDefault(objRds("Fri_Delivery") )
            Sat_Delivery = formatIntDefault(objRds("Sat_Delivery") )
            Sun_Delivery = formatIntDefault(objRds("Sun_Delivery") )
            Mon_Collection = formatIntDefault(objRds("Mon_Collection") )
            Tue_Collection = formatIntDefault(objRds("Tue_Collection") ) 
            Wed_Collection = formatIntDefault(objRds("Wed_Collection") )
            Thu_Collection = formatIntDefault(objRds("Thu_Collection") )
            Fri_Collection = formatIntDefault(objRds("Fri_Collection") )
            Sat_Collection = formatIntDefault(objRds("Sat_Collection") )
            Sun_Collection = formatIntDefault(objRds("Sun_Collection") )        

        End If
        objRds.Close()
        objCon.Close()
        if avgDeliveryTime & "" = "" then
            avgDeliveryTime = "0"
        end if
        if avgCollectionTime & "" = "" then
            avgCollectionTime = "0"
        end if
%>



<%
Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
    function ListColumnInsert(byval dayval, byval DelValue, byval ColValue)
    dim result : result = ""
    select case cint(dayval)
            case 1: result=  "Mon_Delivery = " & DelValue & ",Mon_Collection=" & ColValue
            case 2: result=  "Tue_Delivery = "  & DelValue & ",Tue_Collection=" & ColValue
            case 3: result=  "Wed_Delivery = "  & DelValue & ",Wed_Collection=" & ColValue
            case 4: result=  "Thu_Delivery = "  & DelValue & ",Thu_Collection=" & ColValue
            case 5: result=  "Fri_Delivery = "  & DelValue & ",Fri_Collection=" & ColValue
            case 6: result=  "Sat_Delivery = "  & DelValue & ",Sat_Collection=" & ColValue
            case 7: result=  "Sun_Delivery = "  & DelValue & ",Sun_Collection=" & ColValue
    end select
    ListColumnInsert = result
end function
%>
<%
If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = "UPDATE openingtimes SET [dayofweek] = ?,[Hour_From] = ?,[Hour_To] = ?, [delivery]=?, [collection]=?,[minacceptorderbeforeclose]=? WHERE ID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("dayofweek")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("Hour_From")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("Hour_To")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("delivery")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("collection")) ' adVarWChar
    If  Request.Form("minacceptorderbeforeclose") & "" <> "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 3, 1, 255, Request.Form("minacceptorderbeforeclose")) ' integer
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 3, 1, 255, "0") ' integer
    End If
    
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute

    MM_editCmd.CommandText = "Update BusinessDetails set " & ListColumnInsert(Request.Form("dayofweek"),Request.Form("AverageDeliveryTime"),Request.Form("AverageCollectionTime")) & " where ID = " &  Session("MM_id")
    MM_editCmd.Prepared = true
    MM_editCmd.Execute

    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "openingtimes.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
Dim Recordset1
Dim Recordset1_cmd
Dim Recordset1_numRows
Set Recordset1_cmd = Server.CreateObject ("ADODB.Command")
Recordset1_cmd.ActiveConnection = sConnStringcms
sql = "SELECT convert(varchar, Hour_From, 8)  as Hour_From, convert(varchar, Hour_To, 8)  as Hour_To,dayofweek,delivery,collection,minacceptorderbeforeclose,ID FROM openingtimes  where id=" & request.querystring("id")



Recordset1_cmd.CommandText = sql
Recordset1_cmd.Prepared = true
Set Recordset1 = Recordset1_cmd.Execute
Recordset1_numRows = 0
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
	<link href="../css/bootstrap-clockpicker.min.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	<script type="text/javascript" src="../js/bootstrap-clockpicker.js"></script>
	<script type="text/javascript">
        var DayObj = function(dayname, delvalue, colvalue)
        {
            this.DayName = dayname;
            this.DelValue = delvalue;
            this.ColValue = colvalue;
        }
        
        var objDay = new Array();
        objDay.push(new DayObj(1, <%=Mon_Delivery%>, <%=Mon_Collection%>));
        objDay.push(new DayObj(2,  <%=Tue_Delivery%>, <%=Tue_Collection%>));
        objDay.push(new DayObj(3,  <%=Wed_Delivery%>, <%=Wed_Collection%>));
        objDay.push(new DayObj(4,  <%=Thu_Delivery%>, <%=Thu_Collection%>));
        objDay.push(new DayObj(5,  <%=Fri_Delivery%>, <%=Fri_Collection%>));
        objDay.push(new DayObj(6,  <%=Sat_Delivery%>, <%=Sat_Collection%>));
        objDay.push(new DayObj(7,  <%=Sun_Delivery%>, <%=Sun_Collection%>));
        
    </script>
	
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
	




<div class="row clearfix">
		<div class="col-md-12 column">
		<ol class="breadcrumb">
 
  <li><a href="openingtimes.asp">Opening Times</a></li>
 <li>Edit Time Slot</li>
  
</ol>
			<h1>Edit Time Slot</h1>
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
 <div class="form-group">
    <label for="document name">Day of week</label>
		<p>Select a day of the week.</p>
   <select class="form-control" name="dayofweek" id="dayofweek" onchange="findDayObj($(this).val());">
   
  <option value="1" <%if Recordset1.Fields.Item("dayofweek").Value=1 then%>selected<%end if%>>Monday</option>
  <option value="2" <%if Recordset1.Fields.Item("dayofweek").Value=2 then%>selected<%end if%>>Tuesday</option>
  <option value="3" <%if Recordset1.Fields.Item("dayofweek").Value=3 then%>selected<%end if%>>Wednesday</option>
  <option value="4" <%if Recordset1.Fields.Item("dayofweek").Value=4 then%>selected<%end if%>>Thursday</option>
  <option value="5" <%if Recordset1.Fields.Item("dayofweek").Value=5 then%>selected<%end if%>>Friday</option>
  <option value="6" <%if Recordset1.Fields.Item("dayofweek").Value=6 then%>selected<%end if%>>Saturday</option>
  <option value="7" <%if Recordset1.Fields.Item("dayofweek").Value=7 then%>selected<%end if%>>Sunday</option>
  

</select>
  </div>

     <div class="form-group">
    <label for="Hour_From">Open Time</label>
    <p>Choose the opening time for this slot.</p>
<div class="input-group clockpicker">
    <input type="text" class="form-control" value="<%= FormatTimeC( Recordset1.Fields.Item("Hour_From").Value,5) %>" required id="Hour_From" name="Hour_From">
    <span class="input-group-addon">
        <span class="glyphicon glyphicon-time"></span>
    </span>
</div>

  </div>
  
 <div class="form-group">
    <label for="Hour_To">Closing Time</label>
  <p>Choose the closing time for this slot.</p>
	<div class="input-group clockpicker">
    <input type="text" class="form-control" value="<%= FormatTimeC(Recordset1.Fields.Item("Hour_To").Value,5) %>"  id="Hour_To" name="Hour_To" required>
    <span class="input-group-addon">
        <span class="glyphicon glyphicon-time"></span>
    </span>
</div>
	
  </div>
  
    <div class="form-group">
    <label for="delivery">Delivery Available</label>
	<p>Is delivery available during this timeslot.</p>
    <input type="radio" name="delivery" onchange="changeDelivery('delivery',this);" value="y" <%if Recordset1.Fields.Item("delivery").Value="y" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="delivery" value="n" onchange="changeDelivery('delivery',this);"  <%if Recordset1.Fields.Item("delivery").Value="n" then%>checked<%end if%>> No 
  </div>
    <%
    dim deliverygroup : deliverygroup = "display:none" 
    if Recordset1.Fields.Item("delivery").Value="y" then
        deliverygroup= ""
    end if
         %>
    <div class="form-group" id="deliverygroup" style="<%=deliverygroup%>">
    <label for="delivery">Average Delivery Time</label>
	<p></p>
   <input type="text" pattern="\d+"  title="Average Delivery Time must be number" value="" name="AverageDeliveryTime"  style="width:50px;" required />
  </div>
  
   <div class="form-group">
    <label for="delivery">Collection Available</label>
	<p>Is collection available during this timeslot.</p>
    <input type="radio" name="collection" onchange="changeDelivery('collection',this);"  value="y" <%if Recordset1.Fields.Item("collection").Value="y" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="collection" onchange="changeDelivery('collection',this);" value="n"  <%if Recordset1.Fields.Item("collection").Value="n" then%>checked<%end if%>> No 
  </div>
    <%
        deliverygroup = "display:none" 
    if Recordset1.Fields.Item("collection").Value="y" then
        deliverygroup= ""
    end if
         %>

   <div class="form-group" id="collectiongroup" style="<%=deliverygroup%>">
    <label for="delivery">Average Collection Time</label>
	<p></p>
    <input type="text" pattern="\d+"  title="Average Collection Time must be number"  value="" name="AverageCollectionTime" style="width:50px;" required />
  </div>
 <div class="form-group">
    <label for="delivery">Accept order before closing</label>
	<p>Set how many min.before closing time a customer can make an order.   Eg.  Monday  5pm - 7PM . Set this value to 10, then Customer can place order until 6:50 PM. </p>
    <input type="text" pattern="-?\d+"  title="Accept order before closing must be number"  name="minacceptorderbeforeclose" id="minacceptorderbeforeclose" value="<%=Recordset1.Fields.Item("minacceptorderbeforeclose").Value %>" />
     <p style="margin-top: 10px;">*Note: (Type -1 to Disable) </p>
  </div>
  </div>
  <script type="text/javascript">
$('.clockpicker').clockpicker();
</script>
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%= Recordset1.Fields.Item("ID").Value %>">
  <button type="submit" class="btn btn-default" onclick="return minacceptorderbeforecloseValidate();">Submit</button>
</form>
		</div>
	</div>

      
</div>



<!-- Modal -->

    <%
         Recordset1.close()
        set Recordset1 = nothing   
         Recordset1_cmd.ActiveConnection.Close
    set Recordset1_cmd = nothing


         %>



</body>
    <script type="text/javascript">
        function changeDelivery(mode,obj)
        {
            if(mode=="delivery")
            {
                if($(obj).is(":checked") && $(obj).val()=="y")
                    $("#deliverygroup").show();
                else
                    $("#deliverygroup").hide();
            }else
            {
                if($(obj).is(":checked") && $(obj).val()=="y")
                    $("#collectiongroup").show();
                else
                    $("#collectiongroup").hide();
            }
        }
        var daySelected = $("#dayofweek").val();        
        function findDayObj(dayvalue)
        {
            var result = null;
            $(objDay).each(function(){
                if(this.DayName + '' ==  dayvalue + '' )
                {
                    $("[name=AverageDeliveryTime]").val(this.DelValue);
                    $("[name=AverageCollectionTime]").val(this.ColValue);
                }
            });
    
        }
        findDayObj(daySelected);
         function minacceptorderbeforecloseValidate()
        {
             var result = true;
             var obj  = $("[name='minacceptorderbeforeclose']");
             var value  = $.trim(obj.val());
             var maxvalue  = $("[name=AverageDeliveryTime]").val();
             if(value != "" )
             {
                 if($("[name='delivery']:checked").val()=="n")
                 {
                     maxvalue =   $("[name=AverageCollectionTime]").val(); 
                 }
             }
             if(maxvalue=="")
                 maxvalue = 0;
             if(!isNaN(value) && parseInt(value) > maxvalue)
             {
                 alert("The time to accept order before closing must be smaller than the average delivery time.");
                 obj.focus();
                 obj.val(-1);
                 result = false;
             }
            return result;
        }
        $("#minacceptorderbeforeclose").change(function(){
                minacceptorderbeforecloseValidate();
        
        });

    </script>
</html>
