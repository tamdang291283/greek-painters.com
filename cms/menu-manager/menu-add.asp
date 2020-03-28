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
    function AddCategory(byval Name,byval Desc,byval displayorder, byval IdBusinessDetail)
               Dim objCon1 : set objCon1 = Server.CreateObject("ADODB.Connection")
                   objCon1.Open sConnStringcms
                 Dim rs_1
	            SET rs_1 = Server.CreateObject("ADODB.Recordset")
                dim CateID ,SQL
                SQL = "SET NOCOUNT ON; INSERT INTO menucategories (Name,Description,displayorder,IdBusinessDetail) "
                SQL = SQL & "VALUES('"& Name &"', '"& Desc &"',"&displayorder&", " &IdBusinessDetail& ") ; SELECT SCOPE_IDENTITY() as ID SET NOCOUNT OFF;"  
            
                CateID = ""
                set rs_1 = Server.CreateObject("ADODB.Recordset")
                    rs_1.Open SQL, objCon1, 0, 1
                if not rs_1.EOF then
	                    CateID = rs_1("ID")&""
                end if
                'Remember the RMA Number
                rs_1.Close()
                set rs_1 = nothing
             
                objCon1.close()
            set objCon1 = nothing
        AddCategory = CateID
    end function 
If (CStr(Request("MM_insert")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

	
	Dim Recordset1
Dim Recordset1_cmd
Dim Recordset1_numRows
Set Recordset1_cmd = Server.CreateObject ("ADODB.Command")
Recordset1_cmd.ActiveConnection = sConnStringcms
sql = "SELECT * FROM menucategories where IdBusinessDetail=" & Session("MM_id") &  "  order by displayorder desc"
Recordset1_cmd.CommandText = sql
Recordset1_cmd.Prepared = true
Set Recordset1 = Recordset1_cmd.Execute
Recordset1_numRows = 0
    if Recordset1.EOF then
	    ddd=1
	else
	    ddd=Recordset1.Fields.Item("displayorder").Value+1
	end if
	
   ' Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    ''MM_editCmd.ActiveConnection = sConnStringcms
    'MM_editCmd.CommandText = "INSERT INTO menucategories (name, description,IdBusinessDetail,displayorder) VALUES (?,?,?,?)" 
   ' MM_editCmd.Prepared = true
   ' MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("name")) ' adVarWChar
	'MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("description")) ' adVarWChar
	'MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Session("MM_id")) ' adVarWChar
	'MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, ddd) ' adVarWChar
   ' MM_editCmd.Execute
   ' MM_editCmd.ActiveConnection.Close
    Dim CategoryID : CategoryID = AddCategory(Request.Form("name"),Request.Form("description"),ddd,Session("MM_id"))
    Dim ListDayOfWeekfrm : ListDayOfWeekfrm = "1,2,3,4,5,6,7,"
    dim  ArrListDayOfWeekfrm : ArrListDayOfWeekfrm = split(ListDayOfWeekfrm,",")   
    Dim iL : iL = 0  
       Dim DayNameForm : DayNameForm = Request.Form("dayname") 
    Dim iDay    
      for iL = 0  to ubound(ArrListDayOfWeekfrm) 
          if ArrListDayOfWeekfrm(iL) & "" <> "" then
             iDay =   ArrListDayOfWeekfrm(iL)
               '    Response.Write("DayNameForm " & DayNameForm & " iDay " & iDay & "," & "<br/>")
             if instr(DayNameForm,iDay & ",")  > 0 then 
                 
                Call AddCategoryOpenTime(CategoryID,Session("MM_id"),iDay,DayMapping(iDay), Request.Form("Hour_From" & iDay),Request.Form("Hour_To" & iDay),"ACTIVE")
             else
               Call AddCategoryOpenTime(CategoryID,Session("MM_id"),iDay,DayMapping(iDay), Request.Form("Hour_From" & iDay),Request.Form("Hour_To" & iDay),"DELETED")
             end if
          end if
      next

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
            Recordset1_cmd.ActiveConnection.Close
        set Recordset1_cmd = nothing
    Response.Redirect(MM_editRedirectUrl)
  End If
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

<div class="row clearfix">
		<div class="col-md-12 column">
		
		<ol class="breadcrumb">
<li><a href="menu.asp">Main Menu</a></li>
  <li>Add Category</li>
  
</ol>
		
			<H1>Add Category</H1>
			<p>Enter the name and description of the new category below.</p>
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  <div class="form-group">
    <label for="name">Name</label>
    <input type="text" class="form-control" id="Name" name="Name" value="" required>
  </div>
  
     <div class="form-group">
    <label for="Description">Description</label>
	<textarea class="form-control" id="Description" name="Description" rows="3"></textarea>
    
  </div>
  
   <div class="form-group">
        <label for="OpenningTime">Show during the following days/ times</label>
      
        <input type="hidden" value="" name="dayname" />
       <div class="row clearfix">
      
           	<div class="col-md-2 column">                   
                   <div class="form-check">
                    <input type="checkbox" checked="checked" class="form-check-input" value="1" name="ckdayname" onclick="GetValueOpenTime(1);">
                    <label class="form-check-label" for="exampleCheck1">Monday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'from');" maxlength="5" value="00:00" id="Hour_From1" name="Hour_From1">
                    
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'to');" maxlength="5" value="23:59" id="Hour_To1" name="Hour_To1">
                      
                    </div>
           	</div>
           <div class="col-md-6 column"></div>

        </div>
        <div class="row clearfix">
           	<div class="col-md-2 column">
                  <div class="form-check">
                    <input type="checkbox" checked="checked" class="form-check-input"  value="2" name="ckdayname" onclick="GetValueOpenTime(2);">
                    <label class="form-check-label" for="exampleCheck1">Tuesday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'from');" value="00:00" maxlength="5" id="Hour_From2" name="Hour_From2">
                  
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                    <span class="input-group-addon">To</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'to');" value="23:59" maxlength="5" id="Hour_To2" name="Hour_To2">
                    </div>
           	</div>
              <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">
                   <div class="form-check">
                    <input type="checkbox" checked="checked" class="form-check-input" value="3" name="ckdayname" onclick="GetValueOpenTime(3);">
                    <label class="form-check-label" for="exampleCheck1">Wednesday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                   <span class="input-group-addon">From</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'from');" value="00:00" maxlength="5" id="Hour_From3" name="Hour_From3">
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                  <span class="input-group-addon">To</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'to');" value="23:59" maxlength="5"  id="Hour_To3" name="Hour_To3">
                    
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">
                  <div class="form-check">
                    <input type="checkbox" checked="checked" class="form-check-input" value="4" name="ckdayname" onclick="GetValueOpenTime(4);">
                    <label class="form-check-label" for="exampleCheck1">Thursday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'from');" value="00:00" maxlength="5"  id="Hour_From4" name="Hour_From4">
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                    <span class="input-group-addon">To</span>

                    <input type="text" class="form-control"  onblur="validateTime(this,'to');" value="23:59" maxlength="5"  id="Hour_To4" name="Hour_To4">
                   
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">                   
                     <div class="form-check">
                    <input type="checkbox" checked="checked" class="form-check-input" value="5" name="ckdayname" onclick="GetValueOpenTime(5);">
                    <label class="form-check-label" for="exampleCheck1">Friday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'from');" value="00:00" maxlength="5"  id="Hour_From5" name="Hour_From5">
                   
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'to');" value="23:59"  maxlength="5" id="Hour_To5" name="Hour_To5">
                   
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">
                  <div class="form-check">
                    <input type="checkbox" checked="checked" class="form-check-input" value="6" name="ckdayname" onclick="GetValueOpenTime(6);">
                    <label class="form-check-label" for="exampleCheck1">Saturday</label>
                  </div>
                 
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'from');" value="00:00" maxlength="5"  id="Hour_From6" name="Hour_From6">
                   
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'to');" value="23:59" maxlength="5"  id="Hour_To6" name="Hour_To6">
                   
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
       <div class="row clearfix">
           	<div class="col-md-2 column">
                     <div class="form-check">
                    <input type="checkbox" checked="checked" class="form-check-input" value="7" name="ckdayname" onclick="GetValueOpenTime(7);">
                    <label class="form-check-label" for="exampleCheck1">Sunday</label>
                  </div>
           	</div>
             <div class="col-md-2 column">
                    <div class="input-group clockpicker">
                        <span class="input-group-addon">From</span>
                    <input type="text" class="form-control"  onblur="validateTime(this,'from');" value="00:00" maxlength="5"  id="Hour_From7" name="Hour_From7">
                   
                    </div>
             </div>
           	<div class="col-md-2 column">
                   <div class="input-group clockpicker">
                       <span class="input-group-addon">To</span>
                    <input type="text" class="form-control" onblur="validateTime(this,'to');" value="23:59" maxlength="5"  id="Hour_To7" name="Hour_To7">
                   
                    </div>
           	</div>
           <div class="col-md-6 column"></div>
        </div>
    </div>

  </div>
  <script type="text/javascript">
      function validateTime(obj,time)
      {
          var timevalue = $.trim( $(obj).val());
          if (time == "from") {
              if (!formatTime(timevalue))
              {
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
      function formatTime(val)
      {
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
      GetValueOpenTime("");
  </script>
  <input type="hidden" name="MM_insert" value="form1">

  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>

      
</div>



<!-- Modal -->





</body>
</html>
