<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../restaurantsettings.asp" -->
<!-- #include file="../include/clsuploadv2.asp" -->

<%Server.ScriptTimeout=86400%>
<%
' *** Restrict Access To Page: Grant or deny access to this page
MM_authorizedUsers=""
MM_authFailedURL="../index.asp?e=2"
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
   Dim message
    message = ""

if LCase(Request.Form("hidAction")) = "reset" or LCase(Request.Form("hidAction")) = "compact"  Then

      If  LCase(Request.Form("hidAction")) = "reset" Then
          objCon.Open sConnStringcms
          objCon.Execute("DELETE FROM OrderItems WHERE OrderID in ( SELECT ID FROM Orders WHERE IdBusinessDetail = "&  Session("MM_id") & " ) ")
          objCon.Execute("DELETE FROM Orders WHERE IdBusinessDetail = " & Session("MM_id"))
           objCon.Execute("DELETE FROM OrderItemslocal WHERE OrderID in ( SELECT ID FROM Orderslocal WHERE IdBusinessDetail = "&  Session("MM_id") & " ) ")
          objCon.Execute("DELETE FROM Orderslocal WHERE IdBusinessDetail = " & Session("MM_id"))
           objCon.Execute("DELETE FROM Order_Receipt_tracking WHERE IdBusinessDetail = " & Session("MM_id"))
          objCon.Close
          set objCon =  nothing
            message = message & " All orders/sales data was deleted."
      End If

    


      
     

elseif LCase(Request.Form("hidAction")) = "cleanup"  Then
  
          objCon.Open sConnStringcms
          
          objCon.Execute("  delete from  OrderItems where exists(select top 1 1 from Orders WHERE   isnull(payment_status,'') = '' and isnull(PaymentType,'') <> 'Cash on Delivery'   and   IdBusinessDetail =" & Session("MM_id") &" and ID=OrderID) ")
          objCon.Execute(" DELETE FROM Orders WHERE   isnull(payment_status,'') = '' and isnull(PaymentType,'') <> 'Cash on Delivery'   and IdBusinessDetail = " &  Session("MM_id") )

            objCon.Execute("  delete from  OrderItemsLocal where exists(select top 1 1 from OrdersLocal WHERE   isnull(payment_status,'') = '' and isnull(PaymentType,'') <> 'Cash on Delivery'  and   IdBusinessDetail =" & Session("MM_id") &"  and ID=OrderID) ")
          objCon.Execute(" DELETE FROM OrdersLocal WHERE   isnull(payment_status,'') = '' and isnull(PaymentType,'') <> 'Cash on Delivery'   and IdBusinessDetail = " &  Session("MM_id") )

          'Response.Write(" DELETE FROM Orders WHERE  paymenttype <> '' AND CreationDate < Date()- 1  and IdBusinessDetail = " &  Session("MM_id"))
           objCon.Close
            set objCon = nothing
            message = message & " All incompleted data was deleted."
     

      Set objFSO = Nothing


End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Database functions</title>
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
 
 <li><a href="#">System settings</a></li>
 <li>Database functions</li>
  
</ol>
<% If message <> "" Then %>
<span style="color:red;"> <%=message %>  </span> <br /> <br />
<% end If %>
       <%
           
           '     dim fs,f
'set fs=Server.CreateObject("Scripting.FileSystemObject")
'set f=fs.GetFile(Server.MapPath("..\..\Data\Menu.mdb") )
'Response.Write("<b>The size of database file is: ")
'Response.Write(Round(f.Size/1048576,2) & " MB.</b> <br /><br />")
'set f=nothing
'set fs=nothing
            %>     
          
<span style="font-weight:bold;"> These features are for single-business setups only, with the exception of the ‘compact’ feature.  </span> <br /> <br />
            <form action="DBTasks.asp" method="post">
<!--<label for="document name">Backup DB</label>
		<p>Hit the button below to download the latest MS Access Database file.</p>
		
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Export',this.form);" class="btn btn-default">Export DB</button>
      <br />-->
             
    <br />
      <br />
     <label for="document name">Database Reset</label>
		<p>This will delete all order/sales information from the system for this store. After that the database will be 'compacted and repaired'.</p>
		
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Reset',this.form);" class="btn btn-default">Reset DB</button>
          <br />
        <br />
    <br />
     <!--<label for="document name">Database Compact </label>
		<p>This will compact and repair the Database.</p>
		
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Compact',this.form);" class="btn btn-default">Compact DB</button>
       <br />
    <br />-->
     <label for="document name">Remove incomplete orders</label>
		<p>This will remove all incompleted orders from the database for this store.</p>
		
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('CleanUp',this.form);" class="btn btn-default">CleanUp DB </button>
        
        <input type="hidden" name="hidAction" id="hidAction" />
		</form>
<!--<form method="post" name="Upload" enctype="multipart/form-data" action="ImportDB.asp" >
    <br />
     <br />
     <label for="document name">Database Import </label>
		<p>Please choose the database file you want to restore from. This will replace the current database by the one you uploaded.</p>
		<input type="file" name="dbUpload" id="dbUpload" /> <br />
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Import',this.form);" class="btn btn-default">Import DB</button>
        
</form>-->
		</div></div>

    <script>
        function SubmitForm(action,frm){
        if(action.toLowerCase() == "reset" ){
            if(confirm("This will delete all order/sales information from the system.  Do you want to proceed?"))
            {
                $("#hidAction").val(action);
                frm.submit();
            }
            else 
                return false;
        }
         
            $("#hidAction").val(action);
            frm.submit();
        }

    </script>

<!-- Modal -->




<!-- /.modal -->




</body>
</html>
