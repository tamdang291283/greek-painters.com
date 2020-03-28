<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->


<%Server.ScriptTimeout=86400%>
<%


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
	<!--append â€˜#!watchâ€™ to the browser URL, then refresh the page. -->
	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
<link href="../css/bootstrap-datepicker.min.css" rel="stylesheet">
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js?v=1"></script>
	<script src="../js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	<style>
     @media (max-width: 1250px) {
            body{font-size:14px;}
            .lead {
               font-size:21px;
            }
            
        }

    @media (max-width: 992px) {
         body{font-size:unset;}
        .lead {
           font-size:13px;
        }
    }

	</style>
</head>

<body>
<div class="container">

<%
    Dim frmURL :  frmURL = Request.form("freetext")
    if Request.QueryString("frmURL") & "" <> "" then
        frmURL =  Request.QueryString("frmURL")
    end if
   

%>
<style>
    .lb-form {width:200px;margin-top:10px;}
</style>	
<form class="form-inline mt20" id="searchform" method="post" action="<%=SITE_URL %>cms/url-rewrite/default.asp">
<div class="row clearfix">
<div class="col-md-4">
    <input type="text" class="form-control" id="freetext" name="freetext" placeholder="Free text" value="<%=frmURL%>" size="30" data-toggle="tooltip" data-placement="left" title="This field searches for full/partial content in fields: order no, customer name, customer address, customer postcode">
</div>
<div class="col-md-2"><button type="submit" class="btn btn-default btn-block">Lookup</button></div>
<div class="col-md-3"><button type="button" class="btn btn-default btn-block" onclick="Reset();">Reset/Autogenerateentries</button></div>
<div class="col-md-3"></div>
</div>
<div class="row clearfix" style="height:10px;"></div>

<div class="row clearfix">
    <div class="col-md-5" >
       <label class="lb-form">Source URL:</label>
         <input type="text" class="form-control" id="sourceurl" name="sourceurl" placeholder="Source URL" value="" size="30" data-toggle="tooltip" data-placement="left" title="Source URL">
    </div>

    <div class="col-md-5">
         <label class="lb-form" > Resulting URL:</label>
           <input type="text" class="form-control" id="resultingurl" name="resultingurl" placeholder="Resulting URL" value="" size="30" data-toggle="tooltip" data-placement="left" title="Resulting URL">
    </div>
 
       <!--<div class="col-md-2">
         <label class="lb-form" style="width:80px"> Pages:</label>
            <select name="slPage">
                <option value="menu.asp">Menu</option>
                <option value="checkout.asp">Check Out</option>
                <option value="thanks.asp">Thanks</option>
            </select>
        </div>-->
  
    <div class="col-md-2">
        <label class="lb-form" style="width:80px"> &nbsp;</label>
        <button type="button" class="btn btn-default btn-block" onclick="AddUrl();">Add New</button></div>
</div>
</form>
 
<br>
<div class="row clearfix" style="height:10px;"></div>
<div class="row clearfix">
		<div class="col-md-12 column">
			<table  class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
				
						<th style="width:20%">Source URL<br /><%=SITE_URL %></th>
						<th  style="width:60%">Resulting URL<br /><%=SITE_URL %></th>            
                        <th  style="width:10%">Status</th>
						<th  style="width:10%">Update</th>                        
					</tr>
				</thead>
				<tbody>
				<% 
				  objCon.Open sConnStringcms
sql="SELECT ID,FromLink,ToLink,RestaurantID,Status FROM URL_REWRITE "



                '    Response.Write("freetext " & freetext & "<br/>")
if frmURL & "" <>"" then
    sql=sql & " where   ( [fromlink] LIKE '%" & frmURL& "%' or [tolink] LIKE '%" & frmURL& "%'  )"
end if


function WriteSelected(byval val1, byval val2)
        dim result :  result = ""
        if val1 = val2 then
            result = "selected"            
        end if  
    WriteSelected =   result
end function
  
'	 response.write sql 
objRds.Open sql   , objCon,1


if request.querystring("page")<>"" then
	page=request.querystring("page")
	else
	page=1
end if
pagesize=30
totalrecords=objRds.RecordCount
startrecord=(page*pagesize)-pagesize+1
endrecord=startrecord+pagesize-1
 cnt=1

                           
                        Do While NOT objRds.Eof
                            
						orders=orders+1
						if cnt>=startrecord and cnt<=endrecord then
                        %>
                        <tr>	
                         <td style="width:40%"><input style="width:100%"  type="text" name="tolink<%=objRds("ID") %>" value="<%=objRds("ToLink") %>" /></td>			
						<td style="width:40%"><input style="width:100%"  type="text" name="fromlink<%=objRds("ID") %>" value="<%=replace( lcase(objRds("FromLink")),lcase(SITE_URL),"") %>" /></td>
					    
						<td style="width:5%"><select name="status<%=objRds("ID") %>" style="height:25px">
                                <option value="DELETED" <%=WriteSelected("DELETED",objRds("Status")) %>>DELETE</option>
                                <option value="ACTIVE" <%=WriteSelected("ACTIVE",objRds("Status")) %>>ACTIVE</option>
                            <option value="INACTIVE" <%=WriteSelected("INACTIVE",objRds("Status")) %>>INACTIVE</option>
						    </select></td>
						<td style="width:5%"><input type="button" value="Update" onclick="UpdateUrl(<%=objRds("ID")%>)" /></td>
					</tr>
                        <%end if
						cnt=cnt+1
                            objRds.MoveNext    
                        Loop
                    
                        objRds.Close
                        set objRds = nothing
                        objCon.Close
                            set objCon = nothing
                        %>
				</tbody>
			</table>
			
		</div>
	</div>
 
<script type="text/javascript">
    function replaceallspecialcharacter(str)
    {
      
        str =  str.replace(/ /g,"-");
        str =  str.replace(/,/g,"-");
        str =  str.replace(/</g,"");
        str =  str.replace(/>/g,"");
        str =  str.replace(/;/g,"-");
        str =  str.replace(/:/g,"-");
        str =  str.replace(/'/g,"-");
        str =  str.replace(/"/g,"-");
        str =  str.replace(/&/g,"-");
        str =  str.replace(/--/g,"-");
        return str;
    }
    function Reset()
    {
        if(confirm("Are you sure?"))
        {
          
                $.ajax({
                    url: "Reset.asp?r=" + Math.random()

                })
               .done(function (data) {
                   if (data == "OK") {
                       alert("Updated succesfully!");
                       location.reload();
                   }
                   else
                       alert("Updated fail!");

               });

        }
    }
    function UpdateUrl(ID) {
        var srcurl = $("[name=tolink" + ID + "]").val();
        var resulturl = $("[name=fromlink" + ID + "]").val();      
        resulturl=  replaceallspecialcharacter(resulturl);
        var status = $("[name=status" + ID + "]").val();
        
        if (srcurl == "" || resulturl == "" ) {
            alert("Source URL, Resulting URL haven't to empty");
            return false;
        }

        if(!confirm("Are you sure?"))
            return false;
        $.ajax({
            url: "Updated.asp?srcurl=" + srcurl + "&resulturl=" + resulturl  + "&status=" + status + "&ID=" + ID+ "&r=" + Math.random()

        })
        .done(function (data) {
            if (data == "OK") {
                alert("Updated succesfully!");
                location.reload();
            }

            else
                alert("Updated fail!");

        });
    }

    function AddUrl() {
        var sourceURL = $("[name=sourceurl]").val();
        var resulturl = $("[name=resultingurl]").val();
        resulturl=  replaceallspecialcharacter(resulturl);
        if (sourceURL == "" || resulturl == "" ) {
            alert("Source URL, Resulting URL haven't to empty");
            return false;
        }
        $.ajax({
            url: "AddNew.asp?srcurl=" + sourceURL + "&resulturl=" + resulturl + "&r" + Math.random()

        })
        .done(function (data) {
            if (data == "OK") {
                alert("Updated succesfully!");
                location.reload();
            }
            else if(data == "EXIST")
            {
                alert("Source URL, Resulting URL existed");
            }
            else
                alert("Updated fail!");

        });
    }
</script>

<div class="pagingboxnumbers">
    
<nav>
 
  <ul class="pagination">

<%

if abs(page)>10 then%>
<li><a href="<%=SITE_URL %>cms/url-rewrite/default.asp?frmURL=<%=frmURL%>&page=<%=1%>" class="">1</a>.....</li>
<%end if%>


<%
for g=1 to round(abs((totalrecords/pagesize))+0.5)%>
<%if abs(page)>abs(g)-10 and abs(page)<abs(g)+10 then%>
<li class="<%if abs(page)=abs(g) then%>active<%else%><%end if%>"><a href="<%=SITE_URL %>cms/url-rewrite/default.asp?frmURL=<%=frmURL%>&page=<%=g%>" ><%=g%></a></li><%end if%><%next%><%
if abs(page)<round(abs((totalrecords/pagesize))+0.5)-10 then%>
<li>...<a href="<%=SITE_URL %>cms/url-rewrite/default.asp?frmURL=<%=frmURL%>&page=<%=round(abs((totalrecords/pagesize))+0.5)%>" class=""><%=round(abs((totalrecords/pagesize))+0.5)%></a></li>
<%end if%>
  </ul>
</nav>
		
</div>
      
</div>

</body>
</html>