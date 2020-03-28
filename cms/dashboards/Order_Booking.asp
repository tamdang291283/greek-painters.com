<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->
<!-- #include file="../restaurantsettings.asp" -->

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
<link href="../css/bootstrap-datepicker.min.css" rel="stylesheet">
  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script src="../js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
	
	
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->
	 
	 
<%if request.querystring("startDate")="" then
 sd=date()
else
 sd=request.querystring("startDate")
end if
if request.querystring("endDate")="" then
 ed=date()
else
 ed=request.querystring("endDate")
end if
%>
	
<form class="form-inline mt20" id="searchform" action="Order_Booking.asp">
<div class="row clearfix">
<div class="col-md-3"><input type="text" class="form-control datepicker" id="startDate" name="startDate" placeholder="Start date" value="<%=sd%>" size="10">
</div>
<div class="col-md-3"><input type="text" class="form-control datepicker" id="endDate" name="endDate" placeholder="End date" value="<%=ed%>" size="10">
</div>
<div class="col-md-4"> <input type="text" class="form-control" id="freetext" name="freetext" placeholder="Free text" value="<%=request.querystring("freetext")%>" size="30" data-toggle="tooltip" data-placement="left" title="This field searches for full/partial content in fields: name, tel.no, email, comment, food selected">
</div>
<div class="col-md-2">    <button type="submit" class="btn btn-default btn-block">Lookup</button>
</div>
</div>
	
        </form>
<br>

<div class="row clearfix">


		<div class="col-md-12 column">
				<% 
				totalorder=0
				totalorderdelivery=0
				totalordercollection=0
				totalordercash=0
				totalordercard=0
				totalordercancelled=0
				totalordercancelleddelivery=0
				totalordercancelledcollection=0 
				totalordercancelledcash=0
				totalordercancelledcard=0
   ' objRds.close()
   objCon.Open sConnStringcms
Set objRds = Server.CreateObject("ADODB.Recordset") 
sql="SELECT ID,Name,Phone,bookdate,Email,numberpeople,comment,s_contentemail,createddate FROM Customer_Book_Table  where IdBusinessDetail=" & Session("MM_id") 
if sd<>"" then

sss=split(sd,"/")
startdate_day=sss(0)
startdate_month=sss(1)
startdate_year=sss(2)
startdate_sql= startdate_month   & "/" & startdate_day & "/" & startdate_year
'startdate_sql=DateAdd("d",-1,startdate_sql) 
sql=sql & " AND  createddate >='" & startdate_sql & " 00:00:01" & "'"

end if

if ed<>"" then

sss=split(ed,"/")
enddate_day=sss(0)
enddate_month=sss(1)
enddate_year=sss(2)
enddate_sql= enddate_month   & "/" & enddate_day & "/" & enddate_year
'enddate_sql=DateAdd("d",1,enddate_sql) 
sql=sql & " AND  createddate  <='" & enddate_sql & " 23:59:59" & "'"

end if


if request.querystring("freetext")<>"" then

sql=sql & " AND  (Name like '%" & Request.QueryString("freetext") &  "%' " 
sql=sql & "        or comment like '%" & Request.QueryString("freetext") & "%' " 
sql=sql & "        or email like    '%" & Request.QueryString("freetext") & "%' "
sql=sql & "        or Phone  like    '%" & Request.QueryString("freetext") & "%'                           )"

end if

sql = sql & " ORDER BY bookdate desc"
	' Response.Write(sql)
    ' Response.End
objRds.Open sql , objCon,1


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
ordersonpage=0
orders=0

                         '(Fields: Booking RequestID, date/time of request,  name, tel.no, email, date/time, number of people, comments, food selected)
                    %>
            	<table class="table table-hover table-condensed table-striped">
				<thead>
					<tr>
					    <th>Booking RequestID</th>
						<th>Date/Time of request</th>
						<th>Name</th>
						<th>Tel.no</th>
						<th>Email</th>
                        <th>Date/Time</th>
                        <th>Number of people</th>
                        <th>Comments</th>
                        <th>Food selected</th>
                </tr>
				</thead>
				<tbody>
            <%
                        Do While NOT objRds.Eof
						orders=orders+1
						if cnt>=startrecord and cnt<=endrecord then
						ordersonpage=ordersonpage+1
                        %>
                       <tr>
                        <td><%=objRds("ID") %></td>
                             <% if objRds("createddate") & "" <> "" then  %>
                                <td><%=formatDateTimeC(objRds("createddate")) %></td>
                              <% else %>
                                 <td><%=objRds("createddate") & "" %></td>
                            <% end if %>
                        <td><%=objRds("Name") %></td>
                        <td><%=objRds("Phone") %></td>
                        <td><%=objRds("Email") %></td>
					    <td> <%=formatDateTimeC(objRds("bookdate"))%></td>
						<td><%=objRds("numberpeople") %></td>
					    <td><%=objRds("comment") %></td>
						<td>
                         
                             <%if  trim( objRds("s_contentemail") & "" ) <> "" then%>
                               <a href="javascript:;"  data-toggle="modal" data-target="#myModalorder" data-remote="<%=replace(SITE_URL,"http:","") & "TableBooking/BookingTableDetails.asp?b_id=" & objRds("ID") & "&id_r=" & Session("MM_id") %>">
                                     View Order
                                </a>	
                            <%end if%>
                         </td>
						
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

   
<div class="pagingboxnumbers">
<nav>
  <ul class="pagination">

<%
  
if abs(page)>10 then%>
<li><a href="Order_Booking.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=1%>" class="">1</a>.....</li>
<%end if%>


<%
for g=1 to round(abs((totalrecords/pagesize))+0.5)%>
<%if abs(page)>abs(g)-10 and abs(page)<abs(g)+10 then%>
<li class="<%if abs(page)=abs(g) then%>active<%else%><%end if%>"><a href="Order_Booking.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=g%>" ><%=g%></a></li><%end if%><%next%><%
if abs(page)<round(abs((totalrecords/pagesize))+0.5)-10 then%>
<li>...<a href="Order_Booking.asp?freetext=<%=request.querystring("freetext")%>&startDate=<%=sd%>&endDate=<%=ed%>&page=<%=round(abs((totalrecords/pagesize))+0.5)%>" class=""><%=round(abs((totalrecords/pagesize))+0.5)%></a></li>
<%end if%>
  </ul>
</nav>

<br>
<br>

		
</div>
      

</div>

<div class="modal fade" id="myModalorder" tabindex="-1" role="dialog" aria-labelledby="myModalLabelorder" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <div class="modal-body">
     </div>
      
    </div>
  </div>
</div>	


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<form role="form" action="../exe.asp" method="get">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Cancel Order</h4>

            </div>
            <div class="modal-body"><div class="te">
			
			
  <div class="form-group">
    <label for="exampleInputEmail1">Cancelled by:</label>
  <label class="radio-inline">
  <input type="radio" id="cancelledby" name="cancelledby" value="Restaurant" checked> Restaurant
</label>
<label class="radio-inline">
  <input type="radio" id="cancelledby" name="cancelledby" value="Customer"> Customer
</label>

  </div>
  			
  <div class="form-group">
    <label for="exampleInputEmail1">Cancelled reason:</label>
   <textarea class="form-control" name="cancelledreason" id="cancelledreason" rows="3"></textarea>
  </div>
			</div></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Save changes</button>
				<input type="hidden" name="action" value="cancel">
				<input type="hidden" name="id" id="id" value="">
				<input type="hidden" name="email" id="email" value="">
				<input type="hidden" name="page" id="page" value="history">
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
	</form>
</div>







<div class="modal fade" id="myModalack" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<form role="form" action="../exe.asp" method="get">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Acknowledge Order</h4>

            </div>
            <div class="modal-body"><div class="te">
			
			
  <div class="form-group">
    <label for="exampleInputEmail1">Send Email:</label>
  <label class="radio-inline">
  <input type="radio" id="cancelledby" name="sendemail" value="yes" checked> Yes
</label>
<label class="radio-inline">
  <input type="radio" id="cancelledby" name="sendemail" value="no"> No
</label>

  </div>
  			
  
			</div></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Save changes</button>
				<input type="hidden" name="action" value="acknowledge">
				<input type="hidden" name="id" id="ackid" value="">
				<input type="hidden" name="email" id="ackemail" value="">
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
	</form>
</div>


<!-- /.modal -->


<script>

$(document).ready(function(){

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

$('.datepicker').datepicker({
format: 'dd/mm/yyyy',
    autoclose: true
});



   $(".cancel").click(function(){ // Click to only happen on announce links

     $("#id").val($(this).data('id'));
 $("#email").val($(this).data('email'));
   });
   
   $(document.body).on('hidden.bs.modal', function () {
    $('#myModalorder').removeData('bs.modal')
});

//Edit SL: more universal
$(document).on('hidden.bs.modal', function (e) {
    $(e.target).removeData('bs.modal');
});
   
      
});

</script>

</body>
</html>
