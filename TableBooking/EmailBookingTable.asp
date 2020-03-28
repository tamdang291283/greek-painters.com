
<!-- #include file="../Config.asp" -->
<!-- #include file="../timezone.asp" -->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title>Order Confirmation</title>
    <style type="text/css">
        legend {
            display: block;
            width: 100%;
            padding: 0;
            margin-bottom: 3px;
            font-size: 21px;
            line-height: inherit;
            color: #333;
            border: 0;
            border-bottom: 1px solid #e5e5e5;
        }
    </style>
</head>
<body>
  
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
            createddate = formatDateTimeC(objRds12("createddate"))
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
    dim MenuURL 
     MenuURL =  SITE_URL & "menu.asp?id_r=" & vRestaurantId
    if vRestaurantId & "" <> "" then
      dim rs_url :  set rs_url = Server.CreateObject("ADODB.Recordset")
               
               rs_url.open  "SELECT FromLink FROM URL_REWRITE  a  inner join BusinessDetails   b  on (a.RestaurantID=b.ID )  where RestaurantID=" & vRestaurantId & " and EnableUrlRewrite = 'Yes' and status = 'ACTIVE' " ,objCon
    
           while not rs_url.eof 
               
               if instr(lcase(rs_url("FromLink")),"/menu") > 0 then                     
                     MenuURL = rs_url("FromLink")
               end if 
               rs_url.movenext()
           wend
            rs_url.close()
        set rs_url =  nothing
         if instr( lcase(SITE_URL) ,"https://") then
            MenuURL  = replace(MenuURL,"http://","https://")    
            
         end if  
    end if
    objCon.close()
    set objCon = nothing

     
    
%>
    <div align="center">
        <table width="300" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td>
                    <div class="container" style="width:300px;">
                        <div class="row">
                            <div class="span12">
                                <div align="center">
                                    <h2 class="hero-unit" style="margin-bottom:3px;">Table Booking Request</h2>
                                    <%=createddate %>
                                    <br />
                                </div>
                            </div>
                        </div>
                        <br /><br />
                        <div style="width: 300px;margin-left:auto;margin-right:auto;margin-bottom:15px;">
                            <div class="">
                                <div class="">
                                    <div align="center">  <span class="shop-name"></span>  </div>
                                </div>
                            </div>
                        </div>
                        <div style="width: 300px;margin-left:auto;margin-right:auto;">
                            <div class="">
                                <div class="shop-info">
                                    <span class="shop-name"><b><%=resName %></b></span><br />
                                    <span class="shop-address"><b><%=address %></b></span><br />
                                    <span class="shop-name">Tel. <%=telephone %></span><br />
                                    <span class="shop-address">Email: <%=resEmail %></span><br /><br>

                                </div>
                            </div>
                        </div>

                        <div style="width: 300px; clear:both;margin-left:auto;margin-right:auto;">
                            <div style=" display block;width 100%;padding 0;margin-bottom 3px;font-size 21px; line-height inherit;color #333;border 0; border-bottom 1px solid #e5e5e5;font-weight:bold;"><b>Customer Details</b></div>
                            Name: <%=username %><br />
                            Tel: <%=telno %><br />
                            Email: <%=email %><br />
                            <br/>
                        
                        </div>
                        <div style="width: 300px;margin-left:auto;margin-right:auto;">
                            <div style=" display block;width 100%;padding 0;margin-bottom 3px;font-size 21px; line-height inherit;color #333;border 0; border-bottom 1px solid #e5e5e5;font-weight:bold;"><b>Table booking request:</b></div>
                             Booking for:&nbsp;<%=formatDateTimeC(bookdate) %><br />
                             Number of people: <%=numberpeople %>
                            <br />
                            <br />
                        </div>
                        <div style="width: 300px; clear:both;margin-left:auto;margin-right:auto;">
                            <div style=" display=display block;width=block;width 100%;padding=100%;padding 0;margin-bottom=0;margin-bottom 3px;font-size=3px;font-size 21px;=21px; line-height=line-height inherit;color=inherit;color #333;border=#333;border 0;=0; border-bottom=border-bottom 1px=1px solid=solid #e5e5e5;"=#e5e5e5;"><b>Comments</b></div>
                            <%=comment %> 
                            <br />
                            <br />
                        </div>
                        <% if trim(cartitemhtml) & "" <> "" then  %>
                        <div style="width: 300px; clear:both;margin-left:auto;margin-right:auto;">
                            <div style=" display=display block;width=block;width 100%;padding=100%;padding 0;margin-bottom=0;margin-bottom 3px;font-size=3px;font-size 21px;=21px; line-height=line-height inherit;color=inherit;color #333;border=#333;border 0;=0; border-bottom=border-bottom 1px=1px solid=solid #e5e5e5;"=#e5e5e5;"><b>Order Details:</b></div>
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
                        </div>
                        
                        <br/>
                        <%end if %>
                     
                         <div style="width: 300px; clear:both;margin-left:auto;margin-right:auto;">
                            <div style=" display=display block;width=block;width 100%;padding=100%;padding 0;margin-bottom=0;margin-bottom 3px;font-size=3px;font-size 21px;=21px; line-height=line-height inherit;color=inherit;color #333;border=#333;border 0;=0; border-bottom=border-bottom 1px=1px solid=solid #e5e5e5;"=#e5e5e5;"><b>URL Address</b></div>
                            <%=MenuURL %> 
                            <br />
                            <br />
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>