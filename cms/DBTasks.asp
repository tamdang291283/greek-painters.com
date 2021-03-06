<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<!-- #include file="include/clsuploadv2.asp" -->

<%Server.ScriptTimeout=86400%>
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
   Dim message
    message = ""
If LCase(Request.Form("hidAction")) = "export" Then
        'Set the content type to the specific type that you are sending.
    Response.Clear()
    Response.ContentType = "application/x-msaccess" 'x-msacess
    Response.Charset = "UTF-8"
    Response.AddHeader "Content-transfer-encoding", "binary"
    Response.AddHeader "Content-Disposition", "attachment;filename=menu.mdb"

    Const adTypeBinary = 1
    Dim strFilePath

    strFilePath = Server.MapPath("..\Data\Menu.mdb") 'This is the path to the file on disk. 
    'Response.write(strFilePath)

    Set objStream = Server.CreateObject("ADODB.Stream")
    objStream.Open
    objStream.Type = adTypeBinary
    objStream.LoadFromFile strFilePath

    Response.BinaryWrite objStream.Read

    objStream.Close
    Set objStream = Nothing
    Response.end()
elseif LCase(Request.Form("hidAction")) = "reset" or LCase(Request.Form("hidAction")) = "compact"  Then
      oldFile = Server.MapPath("..\Data\Menu.mdb") 
      newFile =  Server.MapPath("..\Data\Menu.bk.mdb") 
      Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
      If  LCase(Request.Form("hidAction")) = "reset" Then
          objCon.Open sConnStringcms
          objCon.Execute("DELETE FROM OrderItems WHERE OrderID in ( SELECT ID FROM Orders WHERE IdBusinessDetail = "&  Session("MM_id") & " ) ")
          objCon.Execute("DELETE FROM Orders WHERE IdBusinessDetail = " & Session("MM_id"))
           objCon.Execute("DELETE FROM OrderItemslocal WHERE OrderID in ( SELECT ID FROM Orderslocal WHERE IdBusinessDetail = "&  Session("MM_id") & " ) ")
          objCon.Execute("DELETE FROM Orderslocal WHERE IdBusinessDetail = " & Session("MM_id"))
          objCon.Close
            message = message & " All orders/sales data was deleted."
      End If

      strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& oldFile
      strConnBak = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & newFile

      Set objJRO = Server.CreateObject("JRO.JetEngine")
       objJRO.CompactDatabase strConn, strConnBak
      Set objJRO = Nothing


     
      If objFSO.FileExists(newFile) And objFSO.FileExists(oldFile) Then
       objFSO.DeleteFile(oldFile)
       objFSO.MoveFile newFile, oldFile
       message = message & "Compact and Repair was successful."
      Else
       message = message & "Compact and Repair failed."
      End If

      Set objFSO = Nothing

elseif LCase(Request.Form("hidAction")) = "cleanup"  Then
  
          objCon.Open sConnStringcms
          objCon.Execute(" DELETE FROM Orders WHERE   IsNull(paymenttype) AND CreationDate < Date()- 1  and IdBusinessDetail = " &  Session("MM_id") )
          'Response.Write(" DELETE FROM Orders WHERE  paymenttype <> '' AND CreationDate < Date()- 1  and IdBusinessDetail = " &  Session("MM_id"))
           objCon.Close
            message = message & " All incompleted data was deleted."
     

      Set objFSO = Nothing

elseif LCase(Request.Form("hidAction")) = "import"  Then
    Dim objUpload 
    Dim strFile, strPath
    Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
    oldFile = Server.MapPath("..\Data\Menu.mdb") 
    newFile =  Server.MapPath("..\Data\Menu.bk.mdb") 
    objFSO.MoveFile oldFile, newFile
    ' Instantiate Upload Class '
    Set objUpload = New clsUpload
    strFile = objUpload.Fields("dbupload").FileName
    strPath = server.mappath("..\Data\Menu.mdb")
    ' Save the binary data to the file system '
    objUpload("file").SaveAs strPath
    Set objUpload = Nothing
    set objFSO = nothing
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
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	
</head>

<body>
<div class="container">
<!-- #Include file="inc-header.inc"--> 
	



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
           
                dim fs,f
set fs=Server.CreateObject("Scripting.FileSystemObject")
set f=fs.GetFile(Server.MapPath("..\Data\Menu.mdb") )
Response.Write("<b>The size of database file is: ")
Response.Write(Round(f.Size/1048576,2) & " MB.</b> <br /><br />")
set f=nothing
set fs=nothing
            %>     
          
<span style="font-weight:bold;"> These features are for single-business setups only, with the exception of the ‘compact’ feature.  </span> <br /> <br />
            <form action="dbtasks.asp" method="post">
<label for="document name">Backup DB</label>
		<p>Hit the button below to download the latest MS Access Database file.</p>
		
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Export',this.form);" class="btn btn-default">Export DB</button>
      <br />
             
    <br />
      <br />
     <label for="document name">Database Reset</label>
		<p>This will delete all order/sales information from the system. After that the database will be compact and repair</p>
		
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Reset',this.form);" class="btn btn-default">Reset DB</button>
          <br />
        <br />
    <br />
     <label for="document name">Database Compact </label>
		<p>This will compact and repair the Data base</p>
		
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Compact',this.form);" class="btn btn-default">Compact DB</button>
       <br />
    <br />
     <label for="document name">Clean up Database</label>
		<p>This will remove all incompleted orders</p>
		
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('CleanUp',this.form);" class="btn btn-default">CleanUp DB</button>
        
        <input type="hidden" name="hidAction" id="hidAction" />
		</form>
<form method="post" name="Upload" enctype="multipart/form-data" action="ImportDB.asp" >
    <br />
     <br />
     <label for="document name">Database Import </label>
		<p>Please choose the database file you want to restore from. This will replace the current database by the one you uploaded.</p>
		<input type="file" name="dbUpload" id="dbUpload" /> <br />
        
		<button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="SubmitForm('Import',this.form);" class="btn btn-default">Import DB</button>
        
</form>
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
