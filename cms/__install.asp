<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<%Server.ScriptTimeout=86400%>


<%
     dim fs,f
    
    If Request.Form("URL") & "" <> "" Then
       set fs=Server.CreateObject("Scripting.FileSystemObject") 
        set f= fs.OpenTextFile(Server.MapPath("settings.ini"),2,true)
        f.WriteLine("<%")
        f.WriteLine("SITE_URL=""" & Request.Form("URL") & """ ' the last ""/"" is needed..")
        f.WriteLine(Replace("% >"," ",""))
        f.close
        set f=nothing

        set f= fs.OpenTextFile(Server.MapPath("../settings.ini"),2,true)
        f.WriteLine("<%")
        f.WriteLine("SITE_URL=""" & Request.Form("URL") & """  'the last ""/"" is needed.. ")
        f.WriteLine(Replace("% >"," ",""))
        f.close
        set f=nothing
        set fs=nothing
    End If

    If Request.Form("Name") & "" <> "" AND Request.Form("Username") & "" <> "" And Request.Form("Password") & "" <> "" Then
        Dim objCon, objRds
        Set objCon = Server.CreateObject("ADODB.Connection")
        Set objRds = Server.CreateObject("ADODB.Recordset") 
          objCon.Open sConnStringcms
        objRds.Open "SELECT * FROM [BusinessDetails] WHERE 1 = 0", objCon, 1, 3 
        objRds.AddNew 
        objRds("Name") = Request.Form("Name")
        objRds("Email") = Request.Form("Username")
        objRds("pswd") = Request.Form("Password")
       
        objRds.Update 
        objRds.Close()
        Set objRds = nothing
        objCon.Close()
        Set objCon = nothing
        Response.Redirect("installcleanup.asp")
        Response.end()
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
	




<div class="row clearfix">
		<div class="col-md-12 column">
		<ol class="breadcrumb">
 
 <li><a href="#">Installation</a></li>

  
</ol>
			
			<form method="post" action="install.asp" onsubmit="return Install()" name="form1" role="form">
  

			  <div class="panel panel-default">
  <div class="panel-heading">Contact Details</div>
  <div class="panel-body">
			
<div class="form-group">
<label for="document name">RESTAURANT NAME</label>
<p>This is the name of restaurant, which will be displayed on the site to customer. You can edit it later in the cms system.</p>
<input type="text" class="form-control" id="Name" name="Name" value="" required>
</div>

<div class="form-group">
<label for="document name">RESTAURANT URL</label>
<p>This is the URL to access your restaurant. You can not edit it after done set up. URL must contains splash at the end. Ex: http://www.myrestaurant.com/food/ </p>
<input type="text" class="form-control" id="URL" name="URL" value="" required>
</div>

<div class="form-group">
<label for="document name">USER NAME</label>
<p>This is the email address which you will use to login into cms systems to set up your restaurant. You can not update it after done set up. </p>
<input type="text" class="form-control" id="Username" name="Username" value="" required>
</div>

  
<div class="form-group">
<label for="document name">PASSWORD</label>
<p>This is the password which you will use to login into cms systems to set up your restaurant. You can not update it after done set up. </p>
<input type="text" class="form-control" id="Password" name="Password" value="" required>
</div>




</div></div>



 

  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="">
  <button type="submit"  class="btn btn-default">Submit</button>
</form>

<script>
    function Install(){
        
  
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if( re.test($("#Username").val()) )
     return true;
    else{
        alert("Username must be a valid email address. Please recheck!");
        $("#Username").focus();
    return false;
    }
    }


</script>

		</div>
	</div>

      
</div>



<!-- Modal -->





</body>
</html>
