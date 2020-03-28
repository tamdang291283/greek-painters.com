<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
<%Server.ScriptTimeout=86400%>


<%
     dim fs,f
    
    If Request.Form("URL") & "" <> "" Then

        Dim sqlipaddress,databasename,databaseusername,databasepassword
        Dim Constr 
        sqlipaddress  = Request.Form("sqlipaddress")
        databasename  = Request.Form("databasename")
        databaseusername  = Request.Form("databaseusername")
        databasepassword  = Request.Form("databasepassword")
        Constr = "Provider=SQLNCLI10; Data Source=" &sqlipaddress&"; Initial Catalog="&databasename&"; User ID="&databaseusername&"; Password=" &databasepassword& ";"

       set fs=Server.CreateObject("Scripting.FileSystemObject") 
        set f= fs.OpenTextFile(Server.MapPath("settings.ini"),2,true)
        f.WriteLine("<%")
        f.WriteLine("SITE_URL=""" & Request.Form("URL") & """ ' the last ""/"" is needed..")
        f.WriteLine(Replace("% >"," ",""))
        f.close
        set f=nothing

        Dim tempURL, tempDBFolder
        tempURL = Request.Form("URL")
        tempURL = Replace(tempURL,"https://","")
        tempURL = Replace(tempURL,"http://","")
        if Instr(tempURL,"/") > 0 Then
            tempDBFolder = Right(tempURL,Len(tempURL)- Instr(tempURL,"/") + 1)
        else
           tempDBFolder = "/"
        End if

        'Response.Write(Server.MapPath(tempDBFolder & "Menu.mdb"))
    'Response.end()
       ' set f= fs.OpenTextFile(Server.MapPath("../../settings.ini"),2,true)
        'f.WriteLine("<%")
        'f.WriteLine(" SITE_URL=""" & Request.Form("URL") & """  'the last ""/"" is needed.. ")
        ''f.WriteLine(" Dim sConnString, sConnStringcms " )
       ' f.WriteLine(" sConnString =  ""Provider=SQLNCLI10; Data Source=23.161.0.18,1433; Initial Catalog=k9kondop_FO2008; User ID=tam2008; Password=tam2008;"" " )
        'f.WriteLine(" sConnStringcms =  ""Provider=SQLNCLI10; Data Source=23.161.0.18,1433; Initial Catalog=k9kondop_FO2008; User ID=tam2008; Password=tam2008;""" )
        'f.WriteLine(Replace("% >"," ",""))
       ' f.close
       ' set f=nothing

        set f= fs.OpenTextFile(Server.MapPath("settings.ini"),2,true)
        f.WriteLine("<%")
        f.WriteLine(" SITE_URL=""" & Request.Form("URL") & """  'the last ""/"" is needed.. ")
        f.WriteLine(" Dim sConnString, sConnStringcms " )
        f.WriteLine(" sConnString = """ & Constr &""" " )
        f.WriteLine(" sConnStringcms = """ & Constr &""" " )
      

         f.WriteLine(" dim RootDefaultPath : RootDefaultPath = ""\vo\food\7-6-Dang"" ")
         f.WriteLine("dim setWriteLog : setWriteLog = true ")
         f.WriteLine("dim config_prefix_sql_function : config_prefix_sql_function = ""dbo."" ")
         f.WriteLine(" dim dateformatmode ") 
    f.WriteLine("  dateformatmode = 1 // dd/mm/yyyy hh:mm ") 
    f.WriteLine(" 'dateformatmode = 2 // mm/dd/yyyy hh:mm ") 
    f.WriteLine(" 'dateformatmode = 3 '// MMM dd yyyy hh:mm ") 
    f.WriteLine(" 'dateformatmode = 4 '// MMMM dd yyyy hh:mm ") 
    f.WriteLine(" 'dateformatmode = 5 '// dd MMM yyyy hh:mm ") 
    f.WriteLine(" 'dateformatmode = 6 '// dd MMMM yyyy hh:mm ") 
  f.WriteLine(" dim textreceipt : textreceipt = false ") 
   f.WriteLine("  function addZeroWithNumber(byval sNumber) ") 
	 f.WriteLine("	if sNumber < 10 then ") 
	 f.WriteLine("		sNumber = ""0"" & sNumber 	 ") 
	 f.WriteLine("	end if ") 
	 f.WriteLine("	addZeroWithNumber = sNumber ") 
    f.WriteLine(" end function ") 
   f.WriteLine(" function formatDateTimeC(byval strdate)  ")
   f.WriteLine(" dim result  ")
   f.WriteLine(" strdate = cdate(strdate) ")
   f.WriteLine(" select case cint(dateformatmode) ")
   f.WriteLine(" case 1  ")
   f.WriteLine("     result = day(strdate) & ""/"" & Month(strdate) & ""/""& Year(strdate) & "" "" & addZeroWithNumber( Hour(strdate)) & "":"" & addZeroWithNumber(Minute(strdate)) ")
   f.WriteLine(" case 2 ")
   f.WriteLine("     result = Month(strdate) & ""/"" & day(strdate) & ""/"" & Year(strdate) & "" "" & addZeroWithNumber(Hour(strdate)) & "":"" & addZeroWithNumber(Minute(strdate)) ")
   f.WriteLine(" case 3 ")
   f.WriteLine("     result = left(MonthName(Month(strdate)),3) & "" "" & day(strdate) & "" "" & Year(strdate) & "" "" & addZeroWithNumber(Hour(strdate)) & "":"" & addZeroWithNumber(Minute(strdate))  ")
   f.WriteLine(" case 4 ")
   f.WriteLine("      result = MonthName(Month(strdate))  & "" "" & day(strdate) & "" "" & Year(strdate) & "" "" & addZeroWithNumber(Hour(strdate)) & "":"" & addZeroWithNumber(Minute(strdate))  ")
   f.WriteLine(" case 5 ")
   f.WriteLine("     result = day(strdate)& "" "" &  left(MonthName(Month(strdate)),3)  & "" "" & Year(strdate) & "" "" & addZeroWithNumber(Hour(strdate)) & "":"" & addZeroWithNumber(Minute(strdate))  ")
   f.WriteLine(" case 6   ") 
   f.WriteLine("     result = day(strdate)& "" "" &  MonthName(Month(strdate))  & "" "" & Year(strdate) & "" "" & addZeroWithNumber(Hour(strdate)) & "":"" & addZeroWithNumber(Minute(strdate)) ")
  f.WriteLine("  end select  ")
	
  f.WriteLine("  formatDateTimeC = result ")
f.WriteLine(" end function ")
  f.WriteLine(Replace("% >"," ",""))
        f.close
        set f=nothing

        set fs=nothing
    End If

    If Request.Form("Name") & "" <> "" AND Request.Form("Username") & "" <> "" And Request.Form("Password") & "" <> "" _
        AND  Request.Form("sqlipaddress") & "" <> "" AND Request.Form("databasename") & "" <> "" And Request.Form("databaseusername") & "" <> "" AND Request.Form("databasepassword") & "" <> ""  Then
        

        Dim objCon, objRds
        Set objCon = Server.CreateObject("ADODB.Connection")
        Set objRds = Server.CreateObject("ADODB.Recordset") 
            objCon.Open Constr

         Dim FSO, objFile,ReadFileContent

	    Set FSO = Server.CreateObject("Scripting.FileSystemObject")
	    Set objFile = FSO.OpenTextFile(Server.MapPath("SQL.txt"), 1)
	    If NOT objFile.AtEndOfStream Then
		    ReadFileContent = objFile.ReadAll()
	    End If
	    objFile.Close()
	    Set objFile = Nothing
	    Set FSO = Nothing
         Dim strSQLAqrr :  strSQLAqrr = Split(ReadFileContent,"[GO]")
          dim i : i = 0 
         for i = 0 to ubound(strSQLAqrr) 
            if trim(strSQLAqrr(i) & "") <> ""  then
                 objCon.execute(strSQLAqrr(i))
            end if
         next 

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
	
	<link href="../cms/css/bootstrap.min.css" rel="stylesheet">
	<link href="../cms/css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../cms/js/jquery.min.js"></script>
	<script type="text/javascript" src="../cms/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../cms/js/scripts.js"></script>
	
	
</head>

<body>
<div class="container" style="max-width:1024px; position: absolute; top: 30px; left: 0; bottom: 0; right: 0; margin: auto;">
	




<div class="row clearfix">
		<div class="col-md-12 column centered">
<h1 style="text-align:center;">Installation</h1>
			
			<form method="post" action="../install/install.asp" onsubmit="return Install()" name="form1" role="form">
            
            <div class="col-md-6 column centered">

			  <div class="panel panel-default">
  <div class="panel-heading">Setup details</div>
  <div class="panel-body">
			
<div class="form-group">
<label for="document name">YOUR BUSINESS  NAME</label>
<p>This is the name of restaurant, which will be displayed on the site to the customer. You can edit it later.</p>
<input type="text" class="form-control" id="Name" name="Name" value="" required>
</div>

<div class="form-group">
<label for="document name">YOUR BUSINESS - YOUR ORDERING PAGE  URL</label>
<p>This is the URL of the ordering/menu page. This cannot  change later, and  must contain a &quot;/&quot; at the end. eg. http://www.myrestaurant.com/order/ </p>
<input type="text" class="form-control" id="URL" name="URL" value="" required placeholder="http://www.myrestaurant.com/order/">
</div>

<div class="form-group">
<label for="document name">YOUR EMAIL ADDRESS - USERNAME</label>
<p>This is the email address which you will use to login into backend system. You cannot edit it later.</p>
<input type="text" class="form-control" id="Username" name="Username" value="" required placeholder="myemail@domain.com">
</div>

  
<div class="form-group">
<label for="document name">PASSWORD</label>
<p>This is the password which you will use to login into backend system. You cannot edit it later. </p>
<input type="text" class="form-control" id="Password" name="Password" value="" required>
</div>




</div></div>
             <button type="submit"  class="btn btn-default center-block">COMPLETE SETUP</button>
                <p>&nbsp;</p>
            </div>
              <div class="col-md-6 column centered">

			  <div class="panel panel-default">
  <div class="panel-heading">DataBase details</div>
  <div class="panel-body">
			
<div class="form-group">
<label for="document name">SQL Server IP Address</label>
<!--<p>This is the name of restaurant, which will be displayed on the site to the customer. You can edit it later.</p>-->
    <p></p>
<input type="text" class="form-control" id="sqlipaddress" name="sqlipaddress" placeholder="SQL Server IP Address" value="" required>
</div>

<div class="form-group">
<label for="document name">Database Name</label>
<!--<p>This is the URL of the ordering/menu page. This cannot  change later, and  must contain a &quot;/&quot; at the end. eg. http://www.myrestaurant.com/order/ </p>-->
    <p></p>
<input type="text" class="form-control" id="databasename" name="databasename" value="" required placeholder="Database Name">
</div>

<div class="form-group">
<label for="document name">Database User Name</label>
<!--<p>This is the email address which you will use to login into backend system. You cannot edit it later.</p>-->
    <p></p>
<input type="text" class="form-control" id="databaseusername" name="databaseusername" value="" required placeholder="Database User Name">
</div>

  
<div class="form-group">
<label for="document name">Database Password</label>
<!--<p>This is the password which you will use to login into backend system. You cannot edit it later. </p>-->
    <p></p>
<input type="text" class="form-control" id="databasepassword" name="databasepassword" value="" required>
</div>




</div></div>

            </div>

 

  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="">
 
          </form>

<script>
    function Install(){
    var re =/\/$/;
    if(!re.test($("#URL").val())){
        alert("Your ordering page URL must be ending with a '/'. Please recheck!");
        $("#URL").focus();
        return false;
    }
  
    re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
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
