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

Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 

%>



<%

    dim IdBusinessDetail : IdBusinessDetail =""
    function DayMapping(byval dayValue)
        Dim Result : Result = ""
        Select case cint(dayValue)
             case 1 
                   Result = "Monday"
             case 2 
                   Result = "Tuesday" 
            case 3 
                   Result = "Wednesday"
            case 4 
                   Result = "Thursday"
            case 5 
                   Result = "Friday"
            case 6 
                   Result = "Saturday"
            case 7 
                   Result = "Sunday"
        end select
        DayMapping = Result
    end function
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
%>
<%
     
   
    objCon.Open sConnStringcms
    function AddCategoryOpenTime(byval categoryid,byval resid,byval dayvale, byval dayname, byval hour_from, byval hour_to,byval status)
             
                 Dim objCon1 : set objCon1 = Server.CreateObject("ADODB.Connection")
                    objCon1.Open sConnStringcms
                    Dim SQLInsert  
                    SQLInsert= "Insert into Category_Openning_Time(CategoryID,IdBusinessDetail,DayValue,DayName,Hour_From,Hour_To,Status) "
                    SQLInsert = SQLInsert & " values("&categoryid&","&resid&","&dayvale&",'"&dayname&"','" &hour_from& "','"&hour_to&"','" &Status&  "'); "
        
                    objCon1.Execute(SQLInsert)
                    objCon1.close()
                    set objCon1 = nothing
                

                
    end function 
    function UpdateCategoryOpenTime( byval hour_from, byval hour_to, byval status, byval dayvalue,byval cateID)
        Dim MM_editCmd1
        Set MM_editCmd1 = Server.CreateObject ("ADODB.Command")
        MM_editCmd1.ActiveConnection = sConnStringcms
        MM_editCmd1.CommandText = "UPDATE Category_Openning_Time SET [Hour_From] = ?, [Hour_To]=?, [status] = ? WHERE dayvalue = " &  dayvalue & " and categoryid=" & cateID 
        MM_editCmd1.Prepared = true
        MM_editCmd1.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, hour_from) ' adVarWChar
        MM_editCmd1.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, hour_to) ' adVarWChar
        MM_editCmd1.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, status ) ' adDouble
       'Response.Write("<br/>UPDATE Category_Openning_Time SET [Hour_From] = ?, [Hour_To]=? WHERE dayvalue = " &  dayvalue & " and categoryid=" & cateID & "<br/>")
        MM_editCmd1.Execute
        MM_editCmd1.ActiveConnection.Close
    end function 

If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = "UPDATE menucategories SET [name] = ?, [description]=? WHERE ID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("name")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 1000, Request.Form("description")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
    '' Update Openning Time
   Dim ListDayOfWeekfrm : ListDayOfWeekfrm = Request.Form("ListDayOfWeek") & ""
   'Update
   IdBusinessDetail = Request.Form("IdBusinessDetail")
   Dim ArrListDayOfWeekfrm 
   dim iL : iL = 0 
   dim iDay 
   Dim DayNameForm : DayNameForm = Request.Form("dayname") 
   if ListDayOfWeekfrm & "" <> "" then

      ArrListDayOfWeekfrm = split(ListDayOfWeekfrm,",")       
      for iL = 0  to ubound(ArrListDayOfWeekfrm) 
          if ArrListDayOfWeekfrm(iL) & "" <> "" then
             iDay =   ArrListDayOfWeekfrm(iL)
            
             if instr(DayNameForm, iDay & ",")  > 0 then 
               '  Response.Write("DayNameForm " & DayNameForm & " " & iDay & ",<br/>")
                Call UpdateCategoryOpenTime(Request.Form("Hour_From" & iDay),Request.Form("Hour_To" & iDay),"ACTIVE",iDay,MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null))
             else
                     
                Call UpdateCategoryOpenTime(Request.Form("Hour_From" & iDay),Request.Form("Hour_To" & iDay),"DELETED",iDay,MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null))    
             end if
          end if
      next
   'Add New
   else
     ListDayOfWeekfrm = "1,2,3,4,5,6,7,"
     ArrListDayOfWeekfrm = split(ListDayOfWeekfrm,",")       
      for iL = 0  to ubound(ArrListDayOfWeekfrm) 
          if ArrListDayOfWeekfrm(iL) & "" <> "" then
             iDay =   ArrListDayOfWeekfrm(iL)
          
             if instr(DayNameForm,iDay & ",")  > 0 then 
                Call AddCategoryOpenTime(MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null),IdBusinessDetail,iDay,DayMapping(iDay), Request.Form("Hour_From" & iDay),Request.Form("Hour_To" & iDay),"ACTIVE")
             else
                Call AddCategoryOpenTime(MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null),IdBusinessDetail,iDay,DayMapping(iDay), Request.Form("Hour_From" & iDay),Request.Form("Hour_To" & iDay),"DELETED")
             end if
          end if
      next
   end if
   
    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "menu.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    'Response.End
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
sql = "SELECT * FROM menucategories where id=" & request.querystring("id")



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
	
    <% 
            function writeChecked(byval listofday, byval dayvalue)
                    dim result : result = ""
                if instr(listofday, dayvalue & ",") then
                    result = "checked=""checked"" "
                end if
                writeChecked = result
          end function 
       
          objRds.Open "select DayValue,status,convert(varchar, Hour_From, 8)  as hour_from, convert(varchar, Hour_To, 8)  as hour_to from Category_Openning_Time where CategoryID = " & Recordset1.Fields.Item("ID").Value  & " order by DayValue " , objCon  
          Dim listofday : listofday = ""
          Dim ListDayOfWeek : ListDayOfWeek = ""
          Dim ArrOpeningTime(7,3)
          Dim x : x = 0 
          While not objRds.EOF
                if objRds("status") = "ACTIVE" then
                    listofday = listofday  & objRds("DayValue") & ","
                end if
                ListDayOfWeek =  ListDayOfWeek & objRds("DayValue") & ","
                ArrOpeningTime(x,0) = objRds("DayValue")
                ArrOpeningTime(x,1) = left(objRds("hour_from"),5)
                ArrOpeningTime(x,2) = left(objRds("hour_to"),5)
                x  = x + 1
            objRds.movenext
          wend
         function GetHour_Time(byval dayvalue,byval mode)
            Dim Result : Result = "00:00"
            if mode = "to" then
               Result = "23:59" 
            end if
            if IsArray(ArrOpeningTime) then
               dim x1 : x1 = 0
               for x1 = 0 to ubound(ArrOpeningTime,1)

                   if ArrOpeningTime(x1,0) & "" =  dayvalue & "" then
                        if mode = "from" then
                            Result =  ArrOpeningTime(x1,1)
                        elseif mode = "to" then
                            Result =  ArrOpeningTime(x1,2)
                        end if
                   end if
               next 
            end if
         GetHour_Time = Result
         end function
         %>



<div class="row clearfix">
		<div class="col-md-12 column">
		<ol class="breadcrumb">
<li><a href="menu.asp">Main Menu</a></li>
  <li>Edit Category</li>
  
</ol>
		
		
			<h1>Edit Category</h1>
			<p>Enter a name and description for the category below.</p>
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  <div class="form-group">
    <label for="name">Name</label>
    <input type="text" class="form-control" id="name" name="name" value="<%=(Recordset1.Fields.Item("name").Value)%>" required>
  </div>
  
     <div class="form-group">
    <label for="Description">Description</label>
	<textarea class="form-control" id="Description" name="Description" rows="3"><%=(Recordset1.Fields.Item("Description").Value)%></textarea>
   
  </div>
   <div class="form-group">
        <label for="OpenningTime">Show during the following days/ times</label>
        <input type="hidden" value="<%=listofday %>" name="dayname" />
        <input type="hidden" value="<%=ListDayOfWeek %>" name ="ListDayOfWeek" />
        <input type="hidden" name="IdBusinessDetail" value="<%=Recordset1.Fields.Item("IdBusinessDetail").Value %>" />
       <div class="row clearfix">
      
           	<div class="col-md-2 column">       
                   <div class="form-check">
                    <input type="checkbox" class="form-check-input" value="1" <%=writeChecked(listofday,"1") %> name="ckdayname" onclick="GetValueOpenTime(1);">
                    <label class="form-check-label" for="exampleCheck1">Monday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                    <span class="input-group-addon">From</span>
                     <input type="text" class="form-control" onblur="validateTime(this,'from');" value="<%=GetHour_Time("1","from") %>"  id="Hour_From1" name="Hour_From1">
                    
                    </div>
                  
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                        <span class="input-group-addon">To</span>
                       <input type="text" class="form-control" onblur="validateTime(this,'to');" value="<%=GetHour_Time("1","to") %>"  id="Hour_To1" name="Hour_To1">
                    
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
        <div class="row clearfix">
           	<div class="col-md-2 column">
                    <div class="form-check">
                    <input type="checkbox" class="form-check-input" value="2" <%=writeChecked(listofday,"2") %> name="ckdayname" onclick="GetValueOpenTime(2);">
                    <label class="form-check-label" for="exampleCheck1">Tuesday</label>
                  </div>
                  
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'from');" value="<%=GetHour_Time("2","from") %>"  id="Hour_From2" name="Hour_From2">
                    
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'to');" value="<%=GetHour_Time("2","to") %>"  id="Hour_To2" name="Hour_To2">
                    
                    </div>
           	</div>
            <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">
                   <div class="form-check">
                    <input type="checkbox" class="form-check-input" value="3" <%=writeChecked(listofday,"3") %> name="ckdayname" onclick="GetValueOpenTime(3);">
                    <label class="form-check-label" for="exampleCheck1">Wednesday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                    <span class="input-group-addon">From</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'from');" value="<%=GetHour_Time("3","from") %>"  id="Hour_From3" name="Hour_From3">
                   
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'to');" value="<%=GetHour_Time("3","to") %>"  id="Hour_To3" name="Hour_To3">
                    
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">
                   
                  <div class="form-check">
                    <input type="checkbox" class="form-check-input" value="4" <%=writeChecked(listofday,"4") %> name="ckdayname" onclick="GetValueOpenTime(4);">
                    <label class="form-check-label" for="exampleCheck1">Thursday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'from');" value="<%=GetHour_Time("4","from") %>"  id="Hour_From4" name="Hour_From4">
                  
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'to');" value="<%=GetHour_Time("4","to") %>"  id="Hour_To4" name="Hour_To4">
                   
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">                   
                  <div class="form-check">
                    <input type="checkbox" class="form-check-input" value="5" <%=writeChecked(listofday,"5") %> name="ckdayname" onclick="GetValueOpenTime(5);">
                    <label class="form-check-label" for="exampleCheck1">Friday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'from');" value="<%=GetHour_Time("5","from") %>"  id="Hour_From5" name="Hour_From5">
                   
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'to');"  value="<%=GetHour_Time("5","to") %>"  id="Hour_To5" name="Hour_To5">
                   
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">
                   <div class="form-check">
                    <input type="checkbox" class="form-check-input" value="6" <%=writeChecked(listofday,"6") %> name="ckdayname" onclick="GetValueOpenTime(6);">
                    <label class="form-check-label" for="exampleCheck1">Saturday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'from');" value="<%=GetHour_Time("6","from") %>"  id="Hour_From6" name="Hour_From6">
                   
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'to');" value="<%=GetHour_Time("6","to") %>"  id="Hour_To6" name="Hour_To6">
                   
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">
                   
                   <div class="form-check">
                    <input type="checkbox" class="form-check-input" value="7" <%=writeChecked(listofday,"7") %> name="ckdayname" onclick="GetValueOpenTime(7);">
                    <label class="form-check-label" for="exampleCheck1">Sunday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'from');" value="<%=GetHour_Time("7","from") %>"  id="Hour_From7" name="Hour_From7">
                    
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'to');" value="<%=GetHour_Time("7","to") %>"  id="Hour_To7" name="Hour_To7">
                   
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
    </div>
 
  </div>
  <script type="text/javascript">
      function validateTime(obj, time) {
          var timevalue = $.trim($(obj).val());
          if (time == "from") {
              if (!formatTime(timevalue)) {
                  $(obj).val("00:00");
                  $(obj).focus();
              }
          } else {
              if (!formatTime(timevalue)) {
                  $(obj).val("23:59");
                  $(obj).focus();
              }
          }
      }
      function formatTime(val) {
          return /^([0-1]\d|2[0-3]):[0-5]\d/.test(val);
      }
      function GetValueOpenTime(dayvalue)
      {
          var result = "";
          $("[name=ckdayname]").each(function () {
              if ($(this).is(":checked"))
              {
                   result += $(this).val() + ",";
                    
              }
          });
          $("[name=dayname]").val(result);
      }
  </script>
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%= Recordset1.Fields.Item("ID").Value %>">
  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>

      
</div>



<!-- Modal -->





</body>
</html>
