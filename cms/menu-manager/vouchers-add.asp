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

 function FormatValue(byval svalue)
    dim result : result = ""
    if trim(svalue) & "" <> "" then
        dim index : index = 0
        dim arrValue : arrValue = split(svalue,",")
        for index = 0 to ubound(arrValue)
            if  trim(arrValue(index) & "") <> "" and lcase(trim(arrValue(index) & "")) <> "on"  then
                result = result & trim(arrValue(index) & "")  & ","
            end if
        next 
    end if
    FormatValue = result
 end function

Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 

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
If (CStr(Request("MM_insert")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    MM_editCmd.CommandText = "INSERT INTO vouchercodes (vouchercode, vouchercodediscount, vouchertype, startdate,enddate,IdBusinessDetail,minimumamount,MenuItemID,VoucherMainType,ApplyTo,ListID,IncludeDishes_Categories,IncludeDelivery_Collection) VALUES (?,?,?,convert(varchar(10), ?, 105) ,convert(varchar(10), ?, 105),?,?,?,?,?,?,?,?)" 
    MM_editCmd.Prepared = true
    
    dim ApplyTo : ApplyTo = Request.Form("ApplyTo")

    dim VoucherMainType : VoucherMainType =  Request.Form("VoucherMainType")
    dim ListID : ListID = ""
    dim IncludeDishes_Categories : IncludeDishes_Categories  = Request.Form("IncludeDishes_Categories")
    dim IncludeDelivery_Collection : IncludeDelivery_Collection = Request.Form("IncludeDelivery_Collection")
    if IncludeDishes_Categories = "Dishes" then
        ListID = FormatValue(Request.Form("selectedDishes"))
    elseif IncludeDishes_Categories = "Categories" then
        ListID = FormatValue(Request.Form("selectedCategories"))
    end if
	
	
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("vouchercode")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, MM_IIF(Request.Form("vouchercodediscount"), Request.Form("vouchercodediscount"), null))
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("vouchertype")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, MM_IIF(Request.Form("startdate"), Request.Form("startdate"), "")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, MM_IIF(Request.Form("enddate"), Request.Form("enddate"), "")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Session("MM_id")) ' adVarWChar
	MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, MM_IIF(Request.Form("minimumamount"), Request.Form("minimumamount"), 0) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, MM_IIF(Request.Form("drproduct"), Request.Form("drproduct"), null) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 202, 1, 255, MM_IIF(VoucherMainType,VoucherMainType, null) ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 202, 1, 255, MM_IIF(ApplyTo,ApplyTo, "") ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param11", 202, 1, 255, MM_IIF(ListID,ListID, "") ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param11", 202, 1, 255, MM_IIF(IncludeDishes_Categories,IncludeDishes_Categories, "") ) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param12", 202, 1, 255, MM_IIF(IncludeDelivery_Collection,IncludeDelivery_Collection, "") ) ' adVarWChar
	
	
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
  '  dim datedefault : datedefault = day(now()) & "/" & Month(now()) & "/" & year(now()) 
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
              showOtherMonths: false,
	      autoclose: true
	      })
      });
  </script>
    <style>
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
			<h1>Add Voucher</h1>
			<form method="post" action="<%=MM_editAction%>" name="form1" role="form">
  
  <div class="form-group">
    <label for="vouchercode">Code</label>
	<p>Enter a unique voucher code.</p>
    <input type="text" class="form-control" id="vouchercode" name="vouchercode" value="" required>
  </div>
  
    <div class="form-group">
    <label for="vouchertype">Discount</label><br/>
	<input type="radio" name="VoucherMainType" value="Percentage" onclick="selectMainType();" checked="checked"> Percentage&nbsp;&nbsp;
    <input type="radio" name="VoucherMainType" value="Product" onclick="selectMainType();"> Product   (ie. free dish)
    <input type="radio" name="VoucherMainType" value="Amount" onclick="selectMainType();"> Amount
   
  </div>

   

    <div class="form-group" style="margin-left:30px;" id="divpercentage">
    <label for="vouchercodediscount" id="DiscountTypeText">Percentage</label>
	<p id="DiscountTypeTextp">Enter the percentage discount offered when using this voucher.</p>
    <input type="text" pattern="\d+"  title="Discount (%) must be number" class="form-control" id="vouchercodediscount" name="vouchercodediscount" value="" required>
  </div>
  <div class="form-group"  style="margin-left:30px;" id="divproduct"> 
      <label for="name">Product</label>      
  <p>&nbsp;</p>
  <select name="drproduct" id="drproduct" title="Please choose product below." class="form-control" required>
      <option value="">Please select</option>
      <%
          dim objCon2,objRds2 ,SQL
        Set objCon2 = Server.CreateObject("ADODB.Connection")
        objCon2.Open sConnStringcms   
      SQL = "SELECT  ID, Name  FROM menuitems where IdBusinessDetail=" & Session("MM_id")  & " and hidedish  = 1  "    
      
      Set objRds2 = Server.CreateObject("ADODB.Recordset") 
       objRds2.Open SQL , objCon2    
      while not objRds2.EOF 
        dim ID,Name
            ID = objRds2("ID")
            Name = objRds2("Name") 
          %>
            <option value="<%=ID %>"><%=Name %></option>
          <%
           objRds2.movenext 
      wend
      objRds2.close()
      set objRds2 = nothing     
      
      %>
       
  </select>  
  </div>
  

  
  <div class="form-group">
    <label for="vouchertype">Type</label>
	
	<p>Choose if this voucher has to be used by a specific date or is a one off voucher which when used will become unavailable.</p>
   
	<input type="radio" name="vouchertype" value="date" checked="checked" onclick="constrainsValidate();"> Date &nbsp;&nbsp; 
    <input type="radio" name="vouchertype" value="once" onclick="constrainsValidate();"> One off
  </div>
  
  
  
   <div class="form-group" id ="divstartdate">
    <label for="startdate">Start Date</label>
		<p>Select the date this voucher is valid from.</p>
    <input type="text" class="form-control datepicker" id="startdate" name="startdate" value=""  data-date-weekStart="1" data-date-format="dd/mm/yyyy" required>
  </div>
  
  
   <div class="form-group" id ="divenddate">
    <label for="enddate">End Date</label>
		<p>Select the date this voucher is valid until.</p>
    <input type="text" class="form-control datepicker" id="enddate" name="enddate" value=""  data-date-weekStart="1" data-date-format="dd/mm/yyyy" required>
  </div>
  
  
  
   <div class="form-group">
    <label for="minimumamount">Minimum Amount</label>
		<p>Enter the minimum amount of orders that can apply the voucher code.</p>
    <input type="text" pattern="\d+"  title="Minimum Amount must be number" class="form-control" id="minimumamount" name="minimumamount" value="" required>
  </div>
  

    <%
        
        dim rs_category : set rs_category = Server.CreateObject("ADODB.Recordset")
             dim SQL_s : SQL_s = ""
             SQL_s  =  "SELECT ID,Name,displayorder " 
             SQL_s = SQL_s & " , ( select COUNT(ID) from Category_Openning_Time with(nolock) where CategoryID=mc.ID and status='ACTIVE' ) as dayactive " 
             SQL_s = SQL_s & "  FROM menucategories mc with(nolock) where IdBusinessDetail=" &  Session("MM_id") & " order by displayorder "  

            rs_category.Open SQL_s , objCon2 

    %>
 <div class="form-group"  id="divApplyto">
    <label for="vouchertype">Apply to</label><br/>
     <input type="radio" name="ApplyTo" value="Both" checked="checked" checked="checked" onclick="selectapplyto();"> Both&nbsp;&nbsp;
	<input type="radio" name="ApplyTo" value="Online"  onclick="selectapplyto();"> Online&nbsp;&nbsp;
    <input type="radio" name="ApplyTo" value="Local"  onclick="selectapplyto();"> Local&nbsp;&nbsp;
    
 
  </div>
      <div class="form-group" id="divIncludeDishes_Categories">
           <label for="vouchertype">Include Dishes, Categories</label><br/>
           <input type="radio" name="IncludeDishes_Categories" value="" checked="checked" onclick="selectDishesCategories();"> All &nbsp; 
            <input type="radio" name="IncludeDishes_Categories" value="Dishes" onclick="selectDishesCategories();"> Dishes&nbsp; 
           <input type="radio" name="IncludeDishes_Categories" value="Categories" onclick="selectDishesCategories();"> Categories   
     </div>
  <div class="form-group" style="margin-left:30px;display:none;" id="divCategories">
    <label for="vouchercodediscount">Categories</label>
	<p>Select Categories for discount</p>
     <% if not rs_category.EOF then %>  
      <ul id="treeList" class="treeList" >  
    <li>  
        <div class="item"><span class="glyphicon glyphicon-minus" style="cursor:pointer;" onclick="parentclick(this, 'cateRoot')" ></span>
              <input type="checkbox" name="selectedCategories"> Categories  
        </div>
        <ul id="cateRoot">  
            <%
                 dim TextHidden : TextHidden ="Hidden"
                dim sDisplay : sDisplay ="display:none"
                 while not rs_category.EOF
                        TextHidden ="Hidden"
                        sDisplay ="display:none"
                     if  cint( rs_category("dayactive") & "") >  0 and  cint( rs_category("dayactive") & "") < 7 then
                            TextHidden = "Part-Hidden" 
                            sDisplay = ""
                     elseif  cint( rs_category("dayactive") & "") = 0 then
                            TextHidden ="Hidden"
                            sDisplay = ""
                     end if
                 %>
            <li>  
                 <div class="item"><span></span>
                     <input type="checkbox" value="<%=rs_category("ID") %>" name="selectedCategories"> <%=rs_category("Name") %>  
                       <label class="label label-warning" style="<%=sDisplay%>" id="lb1<%=rs_category("id") %>"><%=TextHidden %></label>
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

           
        </script>
        <% end if
          
             %>
  </div>

   <div class="form-group" style="margin-left:30px;display:none;" id="divDishes">
    <label for="vouchercodediscount">Dishes</label>
	<p>Select Categories for discount</p>
     <% if not rs_category.EOF then %>  
      <ul id="treeListDishes" class="treeList">  
    <li>  
         <div class="item"><span class="glyphicon glyphicon-minus" onclick="parentclick(this, 'cateRoot1')" ></span>
            <input type="checkbox" name="selectedDishes" value=""> Categories  
         </div>
        <ul id="cateRoot1">  
            <% while not rs_category.EOF
                        TextHidden ="Hidden"
                        sDisplay ="display:none"
                     if  cint( rs_category("dayactive") & "") >  0 and  cint( rs_category("dayactive") & "") < 7 then
                            TextHidden = "Part-Hidden" 
                            sDisplay = ""
                     elseif  cint( rs_category("dayactive") & "") = 0 then
                            TextHidden ="Hidden"
                            sDisplay = ""
                     end if

                 %>
            <li>  
                 <div class="item"><span class="glyphicon glyphicon-plus" style="cursor:pointer;"  onclick="parentclick(this, 'cate<%=rs_category("id")%>')"></span>
                    <input type="checkbox" value="" name="selectedDishes"> <%=rs_category("Name") %>  
                       <label class="label label-warning" style="<%=sDisplay%>" id="lb<%=rs_category("id") %>"><%=TextHidden %></label>
                </div>
                 <% SQL = "SELECT id,name,i_displaysort,hidedish FROM menuitems with(nolock) where IdMenuCategory=" & rs_category("id") & " and IdBusinessDetail=" & Session("MM_id") & " order by i_displaysort,id " 
                    dim RS_Menu :  set RS_Menu = Server.CreateObject("ADODB.Recordset")
                        RS_Menu.Open SQL , objCon2 
                     if not RS_Menu.EOF then
                            dim isHideDish : isHideDish =  false
                 %> 
                <ul id="cate<%=rs_category("id") %>" style="display:none;">  
                    <% while not RS_Menu.EOF   %>
                    <li>  
                         <div class="item"><span></span>
                            <input type="checkbox" name="selectedDishes" value="<%=RS_Menu("id") %>"><%=RS_Menu("name") %>
                               <%if RS_Menu("hidedish")=1 then
                                    '  isHideDish =  true
                                      %>
                                        &nbsp;<label class="label label-warning">Hidden</label>
                                  <%end if%>
                        </div>
                    </li>  
                    <%
                        RS_Menu.movenext()
                        wend
                        RS_Menu.close()
                        set RS_Menu = nothing
                            if isHideDish = true then
                            %>
                                 <script type="text/javascript">
                                     $('#lb<%=rs_category("id") %>').show();
                                     $('#lb1<%=rs_category("id") %>').show();
                                 </script>
                            <%
                            end if
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
                    $("#" + id).slideDown("slow", function () {
                        $(obj).attr("class", $(obj).attr("class").replace("plus", "minus"));
                    });

                }
                else {
                    $("#" + id).slideUp("slow", function () {
                        $(obj).attr("class", $(obj).attr("class").replace("minus", "plus"));
                    });
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

           

        </script>
        <% end if
            rs_category.close()
            set rs_category = nothing
             %>
  </div>
  
    <div class="form-group" id="divIncludeDelivery_Collection">
            <label for="vouchertype">Include Delivery, Collection</label><br/>
           <input type="radio" name="IncludeDelivery_Collection" checked="checked" value=""> All &nbsp; 
            <input type="radio" name="IncludeDelivery_Collection" value="Delivery"> Delivery&nbsp; 
           <input type="radio" name="IncludeDelivery_Collection" value="Collection"> Collection   
     </div>
  
  
  
  
  
  <input type="hidden" name="MM_insert" value="form1">

  <button type="submit" class="btn btn-default">Submit</button>
</form>
		</div>
	</div>

      
</div>



<!-- Modal -->


    <script type="text/javascript">
        function selectapplyto() {
            var val = $("[name=ApplyTo]:checked").val();
            if (val == "Local") {
                $("[name=IncludeDelivery_Collection]").each(function () {
                    if ($(this).val() != "Collection") {
                        $(this).attr('disabled', 'disabled');
                    } else {
                        $('[name=IncludeDelivery_Collection][value="Collection"]').prop('checked', true);
                    }
                });

            } else {
                $("[name=IncludeDelivery_Collection]").each(function () {
                    $(this).removeAttr('disabled');
                });
                //  $('[name=IncludeDelivery_Collection][value=""]').prop('checked', true);
            }
        }
        function selectDishesCategories()
        {
            if ($("[name=IncludeDishes_Categories]:checked").val() == "") {              
                $("#divDishes").hide();
                $("#divCategories").hide();
            }
            else if ($("[name=IncludeDishes_Categories]:checked").val() == "Dishes") {           
                $("#divDishes").show();
                $("#divCategories").hide();
        
            }
            else if ($("[name=IncludeDishes_Categories]:checked").val() == "Categories") {              
                $("#divDishes").hide();
                $("#divCategories").show();
      
            }
           
        }
         function selectMainType()
         {
             if ($("[name=VoucherMainType]:checked").val() == "Percentage" || $("[name=VoucherMainType]:checked").val() == "Amount") {
                 
                 if ($("[name=VoucherMainType]:checked").val() == "Percentage") {
                     $("#DiscountTypeText").html("Percentage");
                     $("#DiscountTypeTextp").html($("#DiscountTypeTextp").html().replace("amount", "percentage"));
                 }
                 else {
                     $("#DiscountTypeText").html("Amount");
                     $("#DiscountTypeTextp").html($("#DiscountTypeTextp").html().replace("percentage", "amount"));
                 }

                $("#divpercentage").show();
                $("#divproduct").hide();
                
            }           
            else {
                    $("#divproduct").show();
                    $("#divpercentage").hide();                   
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
