<!-- #include file="../Config.asp" -->
<!-- #include file="../timezone.asp" -->

<%
   
    dim vRestaurantId : vRestaurantId = request.QueryString("id_r")
    dim bookingid : bookingid = request.QueryString("b_id")
    dim  username ,telno,bookdate,comment,cartitemhtml,numberpeople,createddate,email
   
    dim objCon,objRds,objRds12
    Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds12 = Server.CreateObject("ADODB.Recordset") 
    'Response.Write("cartitemhtml " & cartitemhtml)
    'Response.End
    objCon.Open sConnString

   
     objRds12.Open  " SELECT email,createddate,Name,Phone,bookdate,numberpeople,comment,s_contentemail  FROM Customer_Book_Table  WHERE Id = " & bookingid ,objCon
      if not objRds12.EOF then
            username = objRds12("Name")
            telno = objRds12("Phone")
            bookdate = objRds12("bookdate")
            numberpeople = objRds12("numberpeople")
            comment = replace(objRds12("comment"),"\n","<br/>")
            cartitemhtml = objRds12("s_contentemail")
            if objRds12("createddate") & "" <> "" then
                createddate = formatDateTimeC(objRds12("createddate"))
            else
                createddate=""
            end if
            email = objRds12("email")
      end if
      objRds12.close()
    set objRds12 = nothing
     set objRds = Server.CreateObject("ADODB.Recordset") 
    dim  CURRENCYSYMBOL
    objRds.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & vRestaurantId, objCon
    dim resName,resEmail,telephone,address
    if not objRds.EOF then
        resName = objRds("Name")
        resEmail = objRds("Email")
        address = objRds("address")
        telephone  = objRds("telephone")
        CURRENCYSYMBOL   = objRds("CURRENCYSYMBOL") 
    end if
    objRds.close()
    set objRds = nothing

    objCon.close()
    set objCon = nothing

     
    
%>
<div class="container">
    <div class="row">
		<div class="col-md-4 col-md-offset-4"><br>
		<br>
		
    		<div class="panel panel-default">
			  	<div class="panel-heading"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			    	<h3 class="panel-title" style="text-align:center;font-size:23px;"><p>Table Booking Request </p></h3>
            
                     <div style="text-align:center;"><%=createddate %></div>   
			 	</div>
			  	<div class="panel-body">
                    
	            <div style="width: 300px;margin-left:auto;margin-right:auto;">
                    <div class="">
                       <div class="shop-info">
                            <span class="shop-name"><strong><%=resName %></strong></span><br>
                            <span class="shop-address"><strong><%=address %></strong></span><br>
                            <span class="shop-name">Tel. <%=telephone %></span><br>                       
                            <span class="shop-address">Email: <%=resEmail %></span><br><br>
				
                        </div>
                    </div>
                </div>

             <div style="width: 300px;margin-left:auto;margin-right:auto;">
                <fieldset>
                        <legend>Customer Details</legend>
	                        Name: <%=username %><br />
                            Tel: <%=telno %><br />
                            Email: <%=email %><br />
                            <br/>
                </fieldset>		                
	            </div>
            <div style="width: 300px;margin-left:auto;margin-right:auto;">
                <fieldset>
                        <legend>Table booking request:</legend>                            
	                         Booking for:&nbsp;<%=formatDateTimeC(bookdate) %><br />
                             Number of people: <%=numberpeople %>
                            <br />
                            <br />
                </fieldset>		                
	       </div>

           <div style="width: 300px;margin-left:auto;margin-right:auto;">
                <fieldset>
                        <legend>Comments</legend>
	                          <%=comment %> 
                            <br />
                            <br />
                </fieldset>		                
	       </div>

           <div style="width: 300px;margin-left:auto;margin-right:auto;">
                <fieldset>
                        <legend>Order Details</legend>
	                           <%
                                dim arrcartitemhtml : arrcartitemhtml =  Split(cartitemhtml,"[**]")
                                dim index : index = 0
                                dim htmlItem : htmlItem = "" 
                                dim totalPrice : totalPrice = 0
                              
                                for index = 0 to ubound(arrcartitemhtml)
                                    if arrcartitemhtml(index) & "" <> "" then
                                        dim ItemName : ItemName = Split(arrcartitemhtml(index),"[*]")(0)
                                        dim ItemPrice : ItemPrice =  Split(arrcartitemhtml(index),"[*]")(1)
                                        htmlItem = htmlItem &  "<tr>" 
                                        htmlItem = htmlItem &  "<td>" & ItemName & "</td>"
                                        htmlItem = htmlItem &  "<td style=""vertical-align:top"">" & ItemPrice & "</td>"
                                        htmlItem = htmlItem &  "</tr>" 
                                        totalPrice = totalPrice + cdbl(Replace( ItemPrice,CURRENCYSYMBOL,"") )
                                    end if
                                next
                                
                                if totalPrice > 0 then
                                        htmlItem = htmlItem &  "<tr>" 
                                        htmlItem = htmlItem &  "<td style=""padding-top: 5px; border-top: 1px dotted black;"">Total</td>"
                                        htmlItem = htmlItem &  "<td style=""padding-top: 5px; border-top: 1px dotted black;vertical-align:top"">" & CURRENCYSYMBOL & FormatNumber(totalPrice,2) & "</td>"
                                        htmlItem = htmlItem &  "</tr>" 
                                end if
                                 if htmlItem & "" <> "" then
                                    htmlItem = "<table style=""width: 100%""><tbody>" & htmlItem & "</tbody></table>"
                                end if
                                if htmlItem & "" <> "" then
                                %>
                                    <%=htmlItem %>     
                                <%
                                end if
                                 %>
                </fieldset>		                
	       </div>
	                  <br/>
                      <br/>
                      <br/>
			    </div>
			</div>
		</div>
	</div>
</div>