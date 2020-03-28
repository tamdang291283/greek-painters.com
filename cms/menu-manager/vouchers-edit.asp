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
function WriteChecked(byval svalue, byval values, byval check)
    dim result : result  = ""
    if check & "" <> "" and svalue & "" <> "" then
        svalue =  "," & svalue 
     '  Response.Write("svalue " & svalue & "  " &  InStr(svalue , values )   & "<br/>")
        if InStr(svalue , values ) > 0 then
           result = "checked" 
         
        end if
    end if
    WriteChecked =  result
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
 function FormatValue(byval svalue)
    dim result : result= ""
    if trim(svalue) & "" <> "" then
        dim index : index = 0
        dim arrValue : arrValue = split(svalue,",")
        for index = 0 to ubound(arrValue)
            if  trim(arrValue(index) & "") <> ""  then
                result = result & trim(arrValue(index) & "")  & ","
            end if
        next 
    end if
    FormatValue = result
 end function

    dim ApplyTo : ApplyTo = Request.Form("ApplyTo")
  
    dim VoucherMainType : VoucherMainType =  Request.Form("VoucherMainType")
    dim ListID : ListID = ""
    if VoucherMainType & "" <> "Dishes" and VoucherMainType & "" <> "Categories" then
        ApplyTo = "Both"
    elseif VoucherMainType = "Dishes" then
        ListID = FormatValue(Request.Form("selectedDishes"))
    elseif VoucherMainType = "Categories" then
        ListID = FormatValue(Request.Form("selectedCategories"))
    end if
	

If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = "UPDATE vouchercodes SET [vouchercode] = ?,[vouchercodediscount] = ?,[vouchertype] = ?,[startdate] = convert(varchar(10), ?, 105) ,[enddate] =convert(varchar(10), ?, 105) , [minimumamount] = ?,MenuItemID=?,VoucherMainType=?,ApplyTo=?,ListID=?  WHERE ID = ?" 
    MM_editCmd.Prepared = true
 
	 MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("vouchercode")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, MM_IIF(Request.Form("vouchercodediscount"), Request.Form("vouchercodediscount"), null))

	
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255,Request.Form("vouchertype") ) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255,MM_IIF(Request.Form("startdate"), Request.Form("startdate"), "") ) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255,MM_IIF(Request.Form("enddate"), Request.Form("enddate"), "") ) ' adVarWChar
    If Request.Form("minimumamount") & "" <> "" Then
	    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("minimumamount")) ' adVarWChar
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, 0) ' adVarWChar
    End If
    
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255,  MM_IIF(Request.Form("drproduct"), Request.Form("drproduct"), null)) 	
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255,Request.Form("VoucherMainType") ) ' adVarWChar

    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 202, 1, 255,  MM_IIF(ApplyTo, ApplyTo, "")) 	
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param11", 202, 1, 255,ListID ) ' adVarWChar

    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close
	
	
	

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "vouchers.asp"
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
sql = "SELECT *, convert(varchar(10), startdate, 105) as StartDateF,convert(varchar(10), enddate, 105)   as EndDateF FROM vouchercodes where id=" & request.querystring("catid")



Recordset1_cmd.CommandText = sql
Recordset1_cmd.Prepared = true
Set Recordset1 = Recordset1_cmd.Execute
Recordset1_numRows = 0
   ' Response.Write("Start:" & Recordset1.Fields.Item("startdatef").Value)
   ' Response.Write("End:" & Recordset1.Fields.Item("EndDateF").Value)

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
    <link href="../css/datepicker.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	<script type="text/javascript">
      jQuery(function () {
          $('.datepicker').datepicker({
              format: 'dd/mm/yyyy',
              showOtherMonths : false,
		  autoclose: true
		  })
      });
  </script>
    <style>
        .treeList {
        }

            .treeList li {
                display: block;
            }

        .item {
        }

        .treeList span {
            width: 18px;
            height: 18px;
            display: inline-block;
            font-weight: bold;
            text-align: center;
            color: #000;
            font-size: 10px;
            line-height: 1;
            vertical-align: middle;
        }

            .treeList span:before {
                display: inline-block;
            }

            .treeList span.glyphicon {
                cursor: pointer;
            }

                .treeList span.plus:before {
                    content: '+';
                }

                .treeList span.minus:before {
                    content: '-';
                }
    </style>
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
	




<div class="row clearfix">
		<div class="col-md-12 column">
		<ol class="breadcrumb">
 
  <li><a href="vouchers.asp">Voucher Code</a></li>
 <li>Edit Voucher</li>
  
</ol>
			<h1>Edit Voucher</h1>
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  
  <div class="form-group">
    <label for="vouchercode">Code</label>
	<p>Enter a unique voucher code.</p>
    <input type="text" class="form-control" id="vouchercode" name="vouchercode" value="<%=(Recordset1.Fields.Item("vouchercode").Value)%>" required>
  </div>
  
                <% 
                       VoucherMainType = Recordset1.Fields.Item("VoucherMainType").Value & "" 
                    if VoucherMainType = "" then
                        VoucherMainType = "Percentage"
                    end if
                    ListID = Recordset1.Fields.Item("ListID").Value & ""
                     ApplyTo =  Recordset1.Fields.Item("ApplyTo").Value & "" 
                    if ApplyTo = "" then
                       ApplyTo = "Both"
                    end if
                %>
  
    <div class="form-group">
    <label for="vouchertype">Discount</label><br/>
	<input type="radio" name="VoucherMainType" value="Percentage" <%if VoucherMainType="Percentage" then%>checked<%end if%>  onclick="selectMainType();"> Percentage&nbsp;&nbsp;
    <input type="radio" name="VoucherMainType" value="Product" <%if VoucherMainType="Product" then%>checked<%end if%> onclick="selectMainType();"> Product   (ie. free dish)
    <input type="radio" name="VoucherMainType" value="Dishes" <%if VoucherMainType="Dishes" then%>checked<%end if%>  onclick="selectMainType();"> Dishes 
    <input type="radio" name="VoucherMainType" value="Categories" <%if VoucherMainType="Categories" then%>checked<%end if%>  onclick="selectMainType();"> Categories   
  </div>

   <div class="form-group" style="margin-left:30px;" id="divpercentage">
    <label for="vouchercodediscount">Percentage</label>
	<p>Enter the percentage discount offered when using this voucher.</p>
    <input type="text" pattern="\d+"  title="Discount (%) must be number" class="form-control" id="vouchercodediscount" name="vouchercodediscount" value="<%=Recordset1.Fields.Item("vouchercodediscount").Value %>" required>
  </div>
                  <%
        dim objCon2,objRds2 ,SQL
        Set objCon2 = Server.CreateObject("ADODB.Connection")
        objCon2.Open sConnStringcms   
        dim rs_category : set rs_category = Server.CreateObject("ADODB.Recordset")
            rs_category.Open "SELECT ID,Name,displayorder FROM menucategories where IdBusinessDetail=" &  Session("MM_id") & " order by displayorder" , objCon2 

    %>
 <div class="form-group" style="display:none;" id="divApplyto">
    <label for="applyto">Apply to</label><br/>
	<input type="radio" name="ApplyTo"  <%if ApplyTo="Online" then%>checked<%end if%>  value="Online"> Online&nbsp;&nbsp;
    <input type="radio" name="ApplyTo"  <%if ApplyTo="Local" then%>checked<%end if%>  value="Local"> Local&nbsp;&nbsp;
    <input type="radio" name="ApplyTo"  <%if ApplyTo="Both" then%>checked<%end if%>  value="Both"> Both 
 
  </div>

  <div class="form-group" style="margin-left:30px;display:none;" id="divCategories">
    <label for="vouchercodediscount">Categories</label>
	<p>Select Categories for discount</p>
     <% if not rs_category.EOF then %>  
      <ul id="treeList" class="treeList">  
    <li>   
        <div class="item"><span class="glyphicon glyphicon-minus" style="cursor:pointer;" onclick="parentclick(this, 'cateRoot')" ></span>
            <input type="checkbox" name="selectedCategories"> Categories 
        </div> 
        <ul>  
            <% 
                dim scheck : scheck = "" 
                if  VoucherMainType = "Categories" then
                    scheck = "categories"
                 end if
                while not rs_category.EOF %>
            <li>  
                <div class="item"><span></span>
                    <input type="checkbox" <%=WriteChecked(ListID,"," & rs_category("ID") & ",",scheck) %> value="<%=rs_category("ID") %>" name="selectedCategories"> <%=rs_category("Name") %>  
                </div>
            </li>  
            <%
                 rs_category.movenext()
                wend
                rs_category.movefirst()
                 %>
        </ul> 
        <script type="text/javascript">
            $('#treeList :checkbox').change(function () {
                $(this).parent().siblings('ul').find(':checkbox').prop('checked', this.checked);
                if (this.checked) {
                    $(this).parentsUntil('#treeList', 'ul').siblings("div").find(':checkbox').prop('checked', true);
                } else {
                    $(this).parentsUntil('#treeList', 'ul').each(function () {
                        var $this = $(this);
                        var childSelected = $this.find(':checkbox:checked').length;
                        if (!childSelected) {
                            $this.prev(':checkbox').prop('checked', false);
                        }
                    });
                }
            });
            $('#treeList :checkbox').each(function () {
                
                if (this.checked) {
                    $(this).parentsUntil('#treeList', 'ul').siblings("div").find(':checkbox').prop('checked', true);
                } else {
                    $(this).parentsUntil('#treeList', 'ul').each(function () {
                        var $this = $(this);
                        var childSelected = $this.find(':checkbox:checked').length;
                        if (!childSelected) {
                            $this.prev(':checkbox').prop('checked', false);
                        }
                    });
                }
            });
        </script>
        <% end if
          
             %>
  </div>

   <div class="form-group" style="margin-left:30px;display:none;" id="divDishes">
    <label for="vouchercodediscount">Dishes</label>
	<p>Select Categories for discount</p>
     <% if not rs_category.EOF then %>  
      <ul id="treeListDishes" class="treeList" >  
    <li>  
        <div class="item"><span class="glyphicon glyphicon-minus"></span>
            <input type="checkbox" name="selectedDishes" value=""> Categories  
        </div>
        <ul>  
            <%
                scheck = "" 
                if  VoucherMainType = "Dishes" then
                    scheck = "Dishes"
                 end if

                 while not rs_category.EOF %>
            <li>  
                 <div class="item"><span class="glyphicon glyphicon-plus" style="cursor:pointer;"  onclick="parentclick(this, 'cate<%=rs_category("id")%>')"></span>
                    <input type="checkbox" value="" name="selectedDishes" onclick="parentclick(this, 'cate<%=rs_category("id")%>')"> <%=rs_category("Name") %>  
                 </div>
                 <% SQL = "SELECT id,name,i_displaysort FROM menuitems where IdMenuCategory=" & rs_category("id") & " and IdBusinessDetail=" & Session("MM_id") & " order by i_displaysort,id " 
                    dim RS_Menu :  set RS_Menu = Server.CreateObject("ADODB.Recordset")
                        RS_Menu.Open SQL , objCon2 
                     if not RS_Menu.EOF then
                 %> 
                <ul id="cate<%=rs_category("id") %>" style="display:none;">  
                    <% while not RS_Menu.EOF   %>
                    <li>  
                        <div class="item"><span></span>
                            <input type="checkbox" <%=WriteChecked(ListID,"," & RS_Menu("id") & ",",scheck) %>  name="selectedDishes"  value="<%=RS_Menu("id") %>"><%=RS_Menu("name") %>
                        </div>
                    </li>  
                    <%
                        RS_Menu.movenext()
                        wend
                        RS_Menu.close()
                        set RS_Menu = nothing
                          %>
                </ul>  
                <%end if %>
            </li>  
            <%
                 rs_category.movenext()
                wend
             
                 %>
        </ul> 
        <script type="text/javascript">
            function parentclick(obj, id) {


                if ($(obj).attr("class").indexOf("plus") > -1) {
                    $("#" + id).show();
                    $(obj).attr("class", $(obj).attr("class").replace("plus", "minus"));
                }
                else {
                    $("#" + id).hide();
                    $(obj).attr("class", $(obj).attr("class").replace("minus", "plus"));
                }



            }
            $('#treeListDishes :checkbox').change(function () {
                $(this).parent().siblings('ul').find(':checkbox').prop('checked', this.checked);
                if (this.checked) {
                    $(this).parentsUntil('#treeListDishes', 'ul').siblings("div").find(':checkbox').prop('checked', true);
                    $(this).parentsUntil('#treeListDishes', 'ul').show();
                } else {
                    $(this).parentsUntil('#treeListDishes', 'ul').each(function () {
                        var $this = $(this);
                        var childSelected = $this.find(':checkbox:checked').length;
                        if (!childSelected) {
                            $this.prev(':checkbox').prop('checked', false);

                        }
                    });
                }
            });
            $('#treeListDishes :checkbox').each(function () {
                if (this.checked) {
                    $(this).parentsUntil('#treeListDishes', 'ul').siblings("div").find(':checkbox').prop('checked', true);
                    $(this).parentsUntil('#treeListDishes', 'ul').siblings("div").find("span").attr("class", "glyphicon glyphicon-minus")
                    $(this).parentsUntil('#treeListDishes', 'ul').show();
                } else {
                    $(this).parentsUntil('#treeListDishes', 'ul').each(function () {
                        var $this = $(this);
                        var childSelected = $this.find(':checkbox:checked').length;
                        if (!childSelected) {
                            $this.prev(':checkbox').prop('checked', false);

                        }
                    });
                }
            });
        </script>
        <% end if
            rs_category.close()
            set rs_category = nothing
             %>
  </div>

  <div class="form-group"  style="margin-left:30px;" id="divproduct"> 
      <label for="name">Product</label>      
  <p>A product will be added to the basket at the specified price. eg. Free. Please choose one of the products below.   Note that the list of these products is a list of all the Hidden dishes from the menu.</p>
  <select name="drproduct" id="drproduct" title="Please choose product below." class="form-control" required>
      <option value="">Please select</option>
      <%
      SQL = "SELECT  ID, Name  FROM menuitems where IdBusinessDetail=" & Session("MM_id")  & " and hidedish  = 1  " 

      Set objRds2 = Server.CreateObject("ADODB.Recordset") 
          objCon.Open sConnStringcms
       objRds2.Open SQL , objCon   
      while not objRds2.EOF 
        dim ID,Name
            ID = objRds2("ID")
            Name = objRds2("Name") 
          %>
            <option value="<%=ID %>" <%if Recordset1.Fields.Item("MenuItemID").Value & "" = ID&"" then%>selected<%end if%>  ><%=Name %></option>
          <%
           objRds2.movenext 
      wend
      objRds2.close()
      set objRds2 = nothing     
        
      %>
       
  </select>  
  </div>
  
  

  <% 
      dim vouchertype : vouchertype = Recordset1.Fields.Item("vouchertype").Value & "" 
      if vouchertype  <>  "date" and vouchertype  <>  "once"  then 
         vouchertype = "date"
      end if %>
  <div class="form-group">
    <label for="vouchertype">Type</label>
	
	<p>Choose if this voucher has to be used by a specific date or is a one off voucher which when used will become unavailable.</p>
   
	<input type="radio" name="vouchertype" onclick="constrainsValidate();" value="date" <%if vouchertype="date" then%>checked<%end if%>> Date &nbsp;&nbsp; 
    <input type="radio" name="vouchertype" value="once" <%if vouchertype="once" then%>checked<%end if%>  onclick="constrainsValidate();" > One off 
     
  </div>
  
                
  
  
   <div class="form-group" id="divstartdate">
    <label for="startdate">Start Date</label>
	<p>Select the date this voucher is valid from.</p>
    <input type="text" class="form-control datepicker" id="startdate" name="startdate" value="<%=(Recordset1.Fields.Item("startdatef").Value)%>"  data-date-weekStart="1" data-date-format="dd/mm/yyyy" required>
  </div>
  
  
   <div class="form-group" id="divenddate">
    <label for="enddate">End Date</label>
		<p>Select the date this voucher is valid until.</p>
    <input type="text" class="form-control datepicker" id="enddate" name="enddate" value="<%=(Recordset1.Fields.Item("enddatef").Value)%>"  data-date-weekStart="1" data-date-format="dd/mm/yyyy" required>
  </div>
  
  
  <div class="form-group">
    <label for="minimumamount">Minimum Amount</label>
		<p>Enter the minimum amount of orders that can apply the voucher code.</p>
    <input type="text" pattern="\d+"  title="Minimum Amount must be number" class="form-control" id="minimumamount" name="minimumamount" value="<%=(Recordset1.Fields.Item("minimumamount").Value)%>" required>
  </div>
  
  
  
  
  
  
  
  
  
  
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%= Recordset1.Fields.Item("ID").Value %>">
  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>

      
</div>

<% Recordset1.close()
   set Recordset1 = nothing
    objCon.close()
    set objCon = nothing
     Recordset1_cmd.ActiveConnection.Close
    set Recordset1_cmd = nothing
     %>

<!-- Modal -->


     <script type="text/javascript">

         function selectMainType()
         {
            if($("[name=VoucherMainType]:checked").val() == "Percentage"){
                $("#divpercentage").show();
                $("#divproduct").hide();
                $("#divDishes").hide();
                $("#divCategories").hide();
                $("#divApplyto").hide();
               // $("#drproduct").val("");
            }
            else if ($("[name=VoucherMainType]:checked").val() == "Dishes")
            {
                $("#divpercentage").show();
                $("#divproduct").hide();
                $("#divDishes").show();
                $("#divCategories").hide();
                $("#divApplyto").show();
            }
            else if ($("[name=VoucherMainType]:checked").val() == "Categories") {
                $("#divpercentage").show();
                $("#divproduct").hide();
                $("#divDishes").hide();
                $("#divCategories").show();
                $("#divApplyto").show();
            }
            else {
                    $("#divproduct").show();
                    $("#divpercentage").hide();             
                    $("#divDishes").hide();
                    $("#divCategories").hide();
                    $("#divApplyto").hide();
                }
            constrainsValidate();
         }
         selectMainType();

        function constrainsValidate()
        {             
            if($("[name=vouchertype]:checked").val()=="once")
            {
                $("#divstartdate").hide();
                $("#divenddate").hide();       
                $("#minimumamount").removeAttr("required");
                $("#vouchertype_product").hide();
            }
            else
            {

                $("#divstartdate").show();
                $("#divenddate").show(); 
                $("#minimumamount").attr("required","");               
                $("#vouchertype_product").hide();
            }

            if($("#drproduct").is(":visible"))
                $("#drproduct").attr("required",""); 
             else
                $("#drproduct").removeAttr("required");  
            
             if($("#vouchercodediscount").is(":visible"))
                $("#vouchercodediscount").attr("required",""); 
             else{
                    if($("#vouchercodediscount").val()=="")
                        $("#vouchercodediscount").val("0");
                    $("#vouchercodediscount").removeAttr("required"); 
                }

            if($("#startdate").is(":visible"))
                $("#startdate").attr("required",""); 
             else
                $("#startdate").removeAttr("required"); 

            if($("#enddate").is(":visible"))
                $("#enddate").attr("required",""); 
             else
                $("#enddate").removeAttr("required"); 
            
        }
        constrainsValidate();
    </script>


</body>
</html>
