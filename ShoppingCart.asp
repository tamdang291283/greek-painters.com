<% if session("restaurantid") & "" = "" Then
    session("restaurantid")=Request.QueryString("id_r")
        
    End If %>
<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->
<% 
    sub WriteLog(logFilePath, logContent)
          if setWriteLog = false then
                exit sub
          end if 
         On Error Resume Next
            Dim logobjFSO, logFile
            set logobjFSO = CreateObject("Scripting.FileSystemObject")
            set logFile = logobjFSO.OpenTextFile(logFilePath,8,true) ' 8 is for appending
            logFile.WriteLine(now() & ": " & logContent)
            set logFile = nothing
            set logobjFSO = nothing
        On Error GoTo 0
    End sub
     dim   DateCondition : DateCondition = cdate(DateAdd("h",houroffset,now))
                DateCondition = DatePart("m", DateCondition)&"/"&DatePart("d", DateCondition)&_
                               "/"&DatePart("yyyy", DateCondition)&" "&DatePart("h", DateCondition)&":"&_
                               DatePart("n", DateCondition)&":" & DatePart("s", DateCondition)


Set objCon = Server.CreateObject("ADODB.Connection")
Set objRds = Server.CreateObject("ADODB.Recordset") 
           
dim vOrderId
dim vRestaurantId
Dim sIsOpen
Dim sDayOfWeek
Dim sDate
Dim sHour
 dim discountValueDisCat     : discountValueDisCat  = -1       
sDayOfWeek = DatePart("w", DateAdd("h",houroffset,now), vbMonday, 1)
sDate = FormatISODate(DateAdd("h",houroffset,now))
sHour = CDate(FormatDateTime(DateAdd("h",houroffset,now), vbShortTime))
vRestaurantId = Request.QueryString("id_r")
vouchercode = Request.QueryString("vouchercode")

    objCon.Open sConnString
    objRds.Open "SELECT * from BusinessDetails  WHERE Id = " & vRestaurantId, objCon
	sPostalCode = objRds("PostalCode")
    sDeliveryMaxDistance = Cdbl(objRds("DeliveryMaxDistance"))
    sDeliveryFreeDistance= Cdbl(objRds("DeliveryFreeDistance"))
    CanEditQtyBasket = objRds("CanEditQtyBasket")
    if CanEditQtyBasket & "" = "" then
            CanEditQtyBasket = "c"
    end if

	sDeliveryChargeOverrideByOrderValue = 1000000000
    If Not Isnull(objRds("DeliveryChargeOverrideByOrderValue")) Then
	    sDeliveryChargeOverrideByOrderValue= Cdbl(objRds("DeliveryChargeOverrideByOrderValue"))
    End If
	'vOrderShipTotal = Cdbl(objRds("DeliveryFee"))
    objRds.Close
set objRds = nothing
Set objRds = Server.CreateObject("ADODB.Recordset") 
objRds.Open "SELECT bd.*,  oi.ID as IsOpen, " & _
        " convert(varchar, Hour_From, 8)  as OpenFrom, convert(varchar, Hour_To, 8)  as OpenUntil   " & _
        " FROM BusinessDetails bd  " & _
        " LEFT JOIN openingtimes oi   ON (" & _
        " (bd.ID = oi.IdBusinessDetail ) " & _
        " and (oi.DayOfWeek = " & sDayOfWeek & ") " & _        
        " ) WHERE bd.Id = " & vRestaurantId, objCon

sIsOpen = Not IsNull(objRds("IsOpen")) And ((objRds("OpenFrom") <= sHour and objRds("OpenUntil") >= sHour))
    objRds.Close
set objRds =  nothing
Set objRds = Server.CreateObject("ADODB.Recordset") 
objRds.Open "select o.* from [Orders] o   " & _
        " Where o.IdBusinessDetail = " & vRestaurantId & _
        " And o.SessionId = '" & Session.SessionID & "'", objCon
   
If Not objRds.Eof Then
    vOrderId = objRds("Id")
    vSubTotal = cdbl(objRds("SubTotal"))
	 vdeliverytype = objRds("deliverytype")
	 vdeliveryDistance = objRds("deliveryDistance")
Else
    vOrderId =  ""
End if
    
objRds.Close
set objRds = nothing

    function HaveDiscount(byval OrderID,byval listID,byval mode)
        dim result : result =  true
        if lcase( mode & "") = "dishes" or lcase(mode & "") = "categories"  then
                if ( lcase( mode & "") = "dishes" and listID & "" = "" ) or (lcase( mode & "") = "categories" and listID & "" = "") then
                    result =  false
                else
                    result = false
                    dim SQL : SQL = "" 
                        SQL = "select  MenuItemId,Total,IdMenuCategory from  OrderItems oi with(nolock)   " 
			            SQL= SQL & "  join MenuItems mi with(nolock) on oi.MenuItemId = mi.id "
			            SQL= SQL & " where oi.orderid  = " & orderID
                         dim RS_OrderTotal : set RS_OrderTotal = Server.CreateObject("ADODB.Recordset")
                             RS_OrderTotal.Open SQL , objCon
                         while not RS_OrderTotal.EOF
                            if lcase(mode) = "dishes" then        
                                if  instr("," & ListID,"," &  RS_OrderTotal("MenuItemId") & ",") > 0 then                            
                                    result =  true                                           
                                end if
                            elseif lcase(mode) = "categories" then
                                 if  instr("," & ListID,RS_OrderTotal("IdMenuCategory")) > 0 then
                                     result =  true                     
                                end if
                            end if
                            RS_OrderTotal.movenext()
                        wend
                           RS_OrderTotal.close()
                           set RS_OrderTotal = nothing   
                end if
        end if
         HaveDiscount = result
    end function
    function CalculateSubtotalWithDiscount( byval orderID, byval discountvalue,byval VoucherMainType, byval ListID)
        dim result : result = 0
       
        if ( VoucherMainType = "Dishes" or VoucherMainType ="Categories" )  then
                result = 0 
            dim SQL : SQL = "" 
                SQL = "select  MenuItemId,Total,IdMenuCategory from  OrderItems oi with(nolock)   " 
			    SQL= SQL & "  join MenuItems mi with(nolock) on oi.MenuItemId = mi.id "
			    SQL= SQL & " where oi.orderid  = " & orderID
             '   Response.Write(SQL & " ListID " & ListID  )
             '   Response.End
            
                dim RS_OrderTotal : set RS_OrderTotal = Server.CreateObject("ADODB.Recordset")
                RS_OrderTotal.Open SQL , objCon
                while not RS_OrderTotal.EOF
                    if VoucherMainType = "Dishes" then
        
                        if  instr("," & ListID,"," &  RS_OrderTotal("MenuItemId") & ",") > 0 then                            
                             result = result +  0.01 * cdbl(RS_OrderTotal("Total")) *  discountvalue    
                                        
                        end if
                    elseif VoucherMainType = "Categories" then
                         if  instr("," & ListID,RS_OrderTotal("IdMenuCategory")) > 0 then
                             result = result + 0.01*  cdbl(RS_OrderTotal("Total")) *  discountvalue 
                               
                        end if
                    end if
                    RS_OrderTotal.movenext()
                wend
                   RS_OrderTotal.close()
                   set RS_OrderTotal = nothing   
        end if
      CalculateSubtotalWithDiscount =   result
    end function 

If vOrderId = "" AND LCase(Request.QueryString("op")) = "add" then
    vSubTotal = 0
    'objCon.Open sConnString
    Set objRds = Server.CreateObject("ADODB.Recordset") 
    objRds.Open "SELECT * FROM [Orders] WHERE 1 = 0", objCon, 1, 3 
    objRds.AddNew 
    objRds("CreationDate") = DateAdd("h",houroffset,now)
    objRds("IdBusinessDetail") = vRestaurantId
   ' objRds("PaymentSurcharge") = 0
    objRds("SessionId") = Session.SessionID
    objRds("SubTotal") = vSubTotal
    objRds("FromIp") = Request.ServerVariables("REMOTE_ADDR")
    objRds("OrderType") = Request.QueryString("ot")
    objRds.Update 
    vOrderId = objRds("Id") 
     objRds.Close
    set objRds = nothing
elseif LCase(Request.QueryString("op")) = "reorder" then
    '' Delete old Order
    objCon.execute("delete from orderitems where orderID in (select ID from orders with(nolock) where  SessionId=" & Session.SessionID & " ) " )
    objCon.execute("delete from orders where SessionId=" & Session.SessionID )
    ' Create new order
        Dim ReorderID  : ReorderID = request.QueryString("RID")
        Set objRds = Server.CreateObject("ADODB.Recordset") 
            objRds.Open "SELECT * FROM [Orders] WHERE 1 = 0 ", objCon, 1, 3 
            objRds.AddNew 
            objRds("CreationDate") = DateAdd("h",houroffset,now)
            objRds("IdBusinessDetail") = vRestaurantId           
            objRds("SessionId") = Session.SessionID
            objRds("SubTotal") = vSubTotal
            objRds("FromIp") = Request.ServerVariables("REMOTE_ADDR")
            objRds("OrderType") = Request.QueryString("ot")
            objRds.Update 
            vOrderId = objRds("Id") 
            objRds.Close
            set objRds = nothing

    '' insert into OrderItems(OrderId,MenuItemId,MenuItemPropertyId,Qta,Price,Total,toppingids,dishpropertiesids) 
''select OrderId,MenuItemId,MenuItemPropertyId,Qta,Price,Total,toppingids,dishpropertiesids from OrderItems where ID=2
        Dim RS_orderItems : set RS_orderItems = Server.CreateObject("ADODB.Recordset")
              
            RS_orderItems.Open "select ID from OrderItems with(nolock) where orderid = " & ReorderID, objCon
            Dim SQL_Clone
        while not RS_orderItems.EOF
            SQL_Clone = "insert into OrderItems(OrderId,MenuItemId,MenuItemPropertyId,Qta,Price,Total,toppingids,dishpropertiesids) "
            SQL_Clone =  SQL_Clone & " select "&vOrderId&",MenuItemId,MenuItemPropertyId,Qta,Price,Total,toppingids,dishpropertiesids from OrderItems where ID=  " &  RS_orderItems("ID")
            objCon.execute(SQL_Clone)
            RS_orderItems.movenext
        wend
            RS_orderItems.close()
        set RS_orderItems  =  nothing 
   '  objCon.Close    
ElseIf vOrderId = "" Then
    vOrderId = "0"

end if


Dim vOperator
Dim vMenuItemId
dim vMenuItemPrice
Dim vMenuItemPropertyId  
Dim IncludeDishes_Categories : IncludeDishes_Categories  = ""
Dim IncludeDelivery_Collection : IncludeDelivery_Collection = ""
Dim ListIncludeID  : ListIncludeID = ""
dim VoucherDiscontType  : VoucherDiscontType = ""
vOperator = Request.QueryString("op")
    dim vouchertype : vouchertype = "" 
if vOperator <> "" or 1=1 Then 

    Select Case vOperator

        Case "add"
        
            vMenuItemId = Request.QueryString("mi")
            vMenuItemPrice = 0
            vMenuItemPropertyId = Request.QueryString("mip")
            if vMenuItemPropertyId = "" then
                    vMenuItemPropertyId = 0
            end if
			toppingids = Request.QueryString("toppingids")
            dishpropertiesids = Request.QueryString("dishproperties")
            Set objRds = Server.CreateObject("ADODB.Recordset") 
            if(vMenuItemPropertyId >= 0) then
                objRds.Open "SELECT mi.Price as mPrice, mip.Price as pPrice FROM MenuItems mi    " & _
                    "LEFT JOIN ( SELECT  * FROM   MenuItemProperties    Where ID = " & vMenuItemPropertyId & ") as mip " & _
                    " ON mip.IdMenuItem = mi.Id " & _
                    " WHERE mi.Id = " & vMenuItemId, objCon
                If Not objRds.Eof Then
                    vMenuItemPrice = objRds("mPrice")
                    if objRds("pPrice") <> "" then vMenuItemPrice = objRds("pPrice")
                End If
            else 
                objRds.Open "SELECT * FROM MenuItems mi   " & _
                    " WHERE mi.Id = " & vMenuItemId, objCon
                If Not objRds.Eof Then vMenuItemPrice = objRds("Price")
            end if
    
                objRds.Close
            set objRds = nothing
             Set objRds = Server.CreateObject("ADODB.Recordset") 
            If(vMenuItemPropertyId >= 0) Then 
			    sql = "SELECT * FROM [OrderItems]  WHERE OrderId = " & vOrderId & " And MenuItemId = " &  vMenuItemId & " And MenuItemPropertyId = " & vMenuItemPropertyId
            Else 
               sql= "SELECT * FROM [OrderItems] WHERE OrderId = " & vOrderId & " And MenuItemId = " &  vMenuItemId & " And MenuItemPropertyId Is Null"
            End If
			
			if toppingids & "" <>"" then
			    sql = sql & " And toppingids = '" &  toppingids & "'"
            else
                sql = sql & " And ( toppingids is null or toppingids = '')   "
			end if
			
			if dishpropertiesids & "" <>"" then
			    sql = sql & " And dishpropertiesids = '" &  dishpropertiesids & "'"
            else
                sql = sql & " And (dishpropertiesids is null or dishpropertiesids = '')  "
			end if
			
		
			
			objRds.Open sql, objCon, 2, 3 
			toppingprice=0
				if toppingids<>"" then  
					
					Set objRds_toppingprice = Server.CreateObject("ADODB.Recordset") 
					
	                objRds_toppingprice.Open "SELECT * FROM MenuToppings   where id in (" & toppingids & ")", objCon
                    WriteLog Server.MapPath("trackingtopping.txt"),"PageName = shoppingcart.asp OrderID = " & vOrderId & " toppingid list  " & toppingids &  " ItemID " & vMenuItemId 
					Do While NOT objRds_toppingprice.Eof 
					    toppingprice=toppingprice+objRds_toppingprice("toppingprice") 
                        WriteLog Server.MapPath("trackingtopping.txt"),"PageName = shoppingcart.asp OrderID = " & vOrderId & " toppingid ID  " & objRds_toppingprice("ID") &  " toppingprice " & objRds_toppingprice("toppingprice")   
					objRds_toppingprice.MoveNext
					loop
                        objRds_toppingprice.close()
                    set objRds_toppingprice = nothing
				end if
				' it item has properties loop through them and calc price
				dishpropertyprice=0
				dishpropertypriceaddons=0
				    if dishpropertiesids<>"" then  
					
					    dishpropertiessplit=split(dishpropertiesids,",")
					
					    for i=0 to ubound(dishpropertiessplit)
					    dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					        if dishpropertiessplit2(1)<>0 then
					        Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 
	                        objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype FROM MenuDishproperties   INNER JOIN MenuDishpropertiesGroups   ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
					
					            if objRds_dishpropertiesprice("dishpropertypricetype")="price" then
					                vMenuItemPrice=objRds_dishpropertiesprice("dishpropertyprice")
					            else
					                dishpropertypriceaddons=dishpropertypriceaddons+objRds_dishpropertiesprice("dishpropertyprice")
					            end if
                                objRds_dishpropertiesprice.close()
                                set objRds_dishpropertiesprice = nothing
					        end if
					    next
				    end if
        
                    If objRds.BOF AND objRds.EOF Then
                        objRds.AddNew
                        objRds("OrderId") = vOrderId
                        objRds("MenuItemId") = vMenuItemId
				        objRds("toppingids") = toppingids
				        objRds("dishpropertiesids") = dishpropertiesids
                        if vMenuItemPropertyId >= 0 then objRds("MenuItemPropertyId") = vMenuItemPropertyId
				        ' if item has toppings then calculate price
                        objRds("Price") = cdbl(vMenuItemPrice) + cdbl(toppingprice) + cdbl(dishpropertypriceaddons)
                        objRds("Qta") = 0
                    End If 
                    if Request.QueryString("Qta") & "" = "" then
                        objRds("Qta") = objRds("Qta") + 1
                    else
                        objRds("Qta") = objRds("Qta") + cint(Request.QueryString("Qta"))
                    end if
                    WriteLog Server.MapPath("trackingtopping.txt"),"PageName = shoppingcart.asp OrderID = " & vOrderId & " vMenuItemPrice  " &vMenuItemPrice&  " toppingprice " & toppingprice & " dishpropertypriceaddons " &    dishpropertypriceaddons & " of item " & vMenuItemId
                    objRds("Total") = cdbl(objRds("Qta")) * (cdbl(vMenuItemPrice) + toppingprice + dishpropertypriceaddons)
                    objRds.Update 
                    'objCon.execute("update Orders set PaymentSurcharge = 0 where ID=" & vOrderId )
                    objRds.Close
                   set objRds = nothing
             
    
         Case "del"

            dim vId
            vId = Request.QueryString("id")
            WriteLog Server.MapPath("trackingtopping.txt"),"PageName = shoppingcart.asp OrderID = " & vOrderId & " request delete id  " & vId 
            'objCon.Open sConnString
            Set objRds = Server.CreateObject("ADODB.Recordset") 
            objRds.Open "SELECT * FROM [OrderItems] WHERE Id = " & vId, objCon, 1, 3         
			Dim UpdateQty : UpdateQty =  Request.QueryString("qty") & ""
            if not objRds.EOF then
                currentqta= objRds("qta")
                if UpdateQty <> "" then
                    if cint(UpdateQty) = 0 then
                        WriteLog Server.MapPath("trackingtopping.txt"),"PageName = shoppingcart.asp OrderID = " & vOrderId & " delete id  " & vId 
			            'objRds.delete
                        objCon.execute("Delete OrderItems where id=" & vId)
                    else
                        ppp=(cdbl(objRds("total"))/cint(currentqta))*(cint(UpdateQty))
                        objRds("qta") = UpdateQty
			            objRds("total")=ppp
                        objRds.Update 
                    end if
                else
			            if cint(currentqta)>1 then                    
                                objRds("qta") = currentqta-1
			                    ppp=(cdbl(objRds("total"))/cdbl(currentqta))*(cdbl(currentqta)-1)
			                    objRds("total")=ppp                    
	                            objRds.Update 
			            else
                            WriteLog Server.MapPath("trackingtopping.txt"),"PageName = shoppingcart.asp OrderID = " & vOrderId & " delete id  " & vId 
			               ' objRds.delete
                            objCon.execute("Delete OrderItems where id=" & vId)
			            end if
                end if
            end if
             ' objCon.execute("update Orders set PaymentSurcharge = 0 where ID=" & vOrderId )
            objRds.Close
           set objRds = nothing
			
		' code to hadle vouchers
		Case "vouchercode"
            dim sqlDelete : sqlDelete = ""
                'sqlDelete =  " delete from [OrderItems] WHERE OrderId = " & vOrderId & "  And Price = 0 And MenuItemPropertyId Is Null "
                sqlDelete =  " delete from [OrderItems] WHERE OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems where hidedish  = 1 ) "
            
            'Response.Write(sqlDelete)
            objCon.execute(sqlDelete)
			validvouchercode=0
            voucherminimumamount = 0
             Set objRds = Server.CreateObject("ADODB.Recordset") 
          	objRds.Open "SELECT *, convert(varchar(10), startdate, 105) as StartDateF, convert(varchar(10), enddate, 105)   as enddatef,isnull(applyto,'both') as applyto,isnull(ListID,'') as ListID,isnull(IncludeDishes_Categories,'') as IncludeDishes_Categories,isnull(IncludeDelivery_Collection,'') as IncludeDelivery_Collection  FROM vouchercodes with(nolock)  where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & vouchercode & "' ", objCon, 1, 3 
           ' Response.Write("SELECT *, convert(varchar(10), startdate, 105) as StartDateF, convert(varchar(10), enddate, 105)   as enddatef FROM vouchercodes   where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & vouchercode & "' and isnull(applyto,'both') in ('online','both')")
           ' Response.End()
			if not objRds.EOF then

                 if  lcase(objRds("applyto")& "") = "local" then
                      validvouchercode = 2
                 end if
                IncludeDelivery_Collection =  objRds("IncludeDelivery_Collection")
                ListIncludeID = objRds("ListID")
                IncludeDishes_Categories = objRds("IncludeDishes_Categories")
               if validvouchercode  <> 2 then 
			           if objRds("MenuItemID")& "" <> "" and  objRds("MenuItemID")& "" <> "0" then
                                vouchertype = "product"
                               vMenuItemId = objRds("MenuItemID")
                               dim objRds1 : set objRds1 = Server.CreateObject("ADODB.Recordset")
                                dim SQL
                                    SQL = "SELECT * FROM MenuItems mi    WHERE mi.Id = " & vMenuItemId
                                objRds1.Open SQL , objCon
                                If Not objRds1.Eof Then 
                                    vMenuItemPrice = objRds1("Price")
                                end if
                                'Response.Write("vMenuItemPrice " & vMenuItemPrice & "<br/>")
                                objRds1.Close
                                set objRds1 = nothing
                              '  objCon.Close 
     
                               'vMenuItemPrice = 0  
                        end if
                        '' validvouchercode 1 OK 
                        '' validvouchercode 2 Invalid Online
                    
                        If objRds("vouchertype")="once" Then
                            validvouchercode=1
			                vouchercodediscount=objRds("vouchercodediscount")
                            If Not IsNull(objRds("minimumamount"))  AND objRds("minimumamount") & "" <> "" Then
                                voucherminimumamount = objRds("minimumamount")
                            End if
                        elseif objRds("vouchertype")="date"   then
                            If  DateDiff("d", objRds("StartDateF"), date())>= 0 and DateDiff("d",date(), objRds("enddatef"))>= 0 Then
			                    validvouchercode=1
			                    vouchercodediscount=objRds("vouchercodediscount") 
                        
                                If Not IsNull(objRds("minimumamount"))  AND objRds("minimumamount") & "" <> "" Then
                                    voucherminimumamount = objRds("minimumamount")
                                End if
                            End If
			            end if
                end if
			end if

          
			objRds.Close
            set objRds = nothing
    
            if Cdbl(voucherminimumamount) > 0 AND validvouchercode Then
                set objRds = Server.CreateObject("ADODB.Recordset")
                objRds.Open "Select Sum(Total) As Total from [OrderItems]    " & _
                        " Where OrderId = " & vOrderId, objCon
                If Not objRds.Eof and Not IsNull(objRds("Total")) Then
                    vtemsubtotal = cdbl(objRds("Total"))
                Else
                    vtemsubtotal  = 0
                End if
    
                objRds.Close
                set objRds = nothing
                If vtemsubtotal < Cdbl(voucherminimumamount) Then
                    validvouchercode = 0
                End If
            End if

               dim havediscountproduct 
               if validvouchercode = 1 then 
                     havediscountproduct =  HaveDiscount(vOrderId,ListIncludeID,IncludeDishes_Categories)                      
                  if havediscountproduct = false then                      
                        if IncludeDishes_Categories & "" = "Dishes" then
                            validvouchercode = 3
                        else
                            validvouchercode = 4
                        end if                          
                  end if  
              end if
			  if validvouchercode=1 then   
                                   
                  if vouchertype = "product" then                      
                     if havediscountproduct = true then
                        dim objRdsUpdate : set objRdsUpdate = Server.CreateObject("ADODB.Recordset")
                            sql= "SELECT * FROM [OrderItems]   WHERE OrderId = " & vOrderId & " And MenuItemId = " &  vMenuItemId & " And MenuItemPropertyId Is Null"
                          'Response.Write("vMenuItemPrice [123] " & vMenuItemPrice & "<br/>")
                        objRdsUpdate.Open sql, objCon, 2, 3 
                         If objRdsUpdate.BOF AND objRdsUpdate.EOF Then
                            objRdsUpdate.AddNew
                            objRdsUpdate("OrderId") = vOrderId
                            objRdsUpdate("MenuItemId") = vMenuItemId
				            objRdsUpdate("toppingids") = toppingids
				            objRdsUpdate("dishpropertiesids") = dishpropertiesids
                            objRdsUpdate("Price") = vMenuItemPrice
                            objRdsUpdate("Total") = vMenuItemPrice    
                            objRdsUpdate("Qta") = 1
                        End If 
                        objRdsUpdate.Update     
                        objRdsUpdate.close()
                        set objRdsUpdate = nothing
                     end if
                  end if
                 
                       
                   if validvouchercode  = 1 then
			          set objRds = Server.CreateObject("ADODB.Recordset")
			          objRds.Open "SELECT * FROM orders   where id=" & vOrderId, objCon, 1, 3    			
			          objRds("vouchercode") = vouchercode
			          objRds("vouchercodediscount") = vouchercodediscount
                      objRds("DiscountType") = VoucherDiscontType
    		          objRds.Update
			          objRds.Close
                      set objRds = nothing
                  end if
            %>
            <script>
                    $("#divVoucherCodeAlert").html("");
                    scrollToV2("basket");
                </script>
            <%
            elseif validvouchercode = 2 then
                %>
                  <script>
                    $("#divVoucherCodeAlert").html("This voucher is for in-store use only.");
                </script>
                <%
            elseif validvouchercode = 3 then
                    %>
                     <script>
                    $("#divVoucherCodeAlert").html("This voucher cannot be applied.");
                </script>
                    <%
            elseif validvouchercode = 4 then
                    %>
                    <script>
                        $("#divVoucherCodeAlert").html("This voucher cannot be applied.");
                    </script> 
                    <%
            elseif vtemsubtotal < Cdbl(voucherminimumamount) AND Cdbl(voucherminimumamount)  > 0 Then
                %>
                <script>
                    $("#divVoucherCodeAlert").html("The order must be at least <%=CURRENCYSYMBOL%><%= FormatNumber(voucherminimumamount, 2) %> to apply this voucher code!");
                </script>
            <%
            else 'voucher code not valid 
            %>
                <script>
                    $("#divVoucherCodeAlert").html("Invalid Voucher Code");
                </script>
            <%
			end if
              
                 
    End select 
              
     set objRds = Server.CreateObject("ADODB.Recordset")
    objRds.Open "Select Sum(Total) As Total from [OrderItems]    " & _
            " Where OrderId = " & vOrderId, objCon
   
    If Not objRds.Eof and Not IsNull(objRds("Total")) Then
        vSubTotal = cdbl(objRds("Total"))
    Else
        vSubTotal  = 0
    End if
    
    objRds.Close
    set objRds = nothing
     
     set objRds = Server.CreateObject("ADODB.Recordset")
    objRds.Open "SELECT * FROM [Orders]  WHERE Id = " & vOrderId, objCon, 1, 3 
	discountcodeused=""
    vouchercodediscount = 0
             
    'Response.Write("vSubTotal " & vSubTotal)
    if not objRds.eof then
	        if ( objRds("vouchercodediscount") & "" <> "" and   objRds("vouchercodediscount") <> 0) or objRds("Vouchercode") & "" <> ""  then
                
	            Dim objRdsV
                Set objRdsV = Server.CreateObject("ADODB.Recordset") 
                objRdsV.Open "SELECT *,convert(varchar(10), startdate, 105)   as StartDateF, convert(varchar(10), enddate, 105)   as enddatef FROM vouchercodes   where IdBusinessDetail=" & vRestaurantId & " and vouchercode='" & objRds("Vouchercode") & "'", objCon, 1, 3 
                IncludeDelivery_Collection = objRdsV("IncludeDelivery_Collection")& ""
                 
                If Not IsNull(objRdsV("minimumamount"))  AND objRdsV("minimumamount") & "" <> ""  Then
                    if Cdbl( objRdsV("minimumamount")) > vSubTotal or HaveDiscount(vOrderId,objRdsV("ListID") & "" ,objRdsV("IncludeDishes_Categories") & "" ) = false Then
                         IncludeDelivery_Collection = ""
                         objRds("vouchercodediscount") = 0
                         objRds("Vouchercode")  = "" 
                         objRds("DiscountType") = ""
                          dim RS_OrderItem : set  RS_OrderItem = Server.CreateObject("ADODB.Recordset")
                         RS_OrderItem.Open "Select Sum(Total) As Total from [OrderItems]     " & _
                        " Where OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems   where hidedish  = 1 )  ", objCon
                           if vSubTotal & "" <> "" and RS_OrderItem("Total")  & "" <> "" then
                                vSubTotal  = CDbl(vSubTotal) - CDbl(RS_OrderItem("Total") )
                           end if
                        RS_OrderItem.close()
                    set RS_OrderItem = nothing
                        objCon.execute(" delete from [OrderItems]  WHERE OrderId = " & vOrderId & " And MenuItemPropertyId Is Null and  MenuItemId in (select Id from MenuItems where hidedish  = 1 ) ")
                    Else
                         vouchercode = objRds("Vouchercode")
                         VoucherDiscontType = objRds("DiscountType")
                             
                                ListIncludeID = objRdsV("ListID")
                                IncludeDishes_Categories = objRdsV("IncludeDishes_Categories")
                                      
                                 if (IncludeDishes_Categories = "Dishes" or IncludeDishes_Categories = "Categories") and ListIncludeID & "" <> ""  then
                                        discountValueDisCat  = CalculateSubtotalWithDiscount(vOrderId,objRds("vouchercodediscount"),IncludeDishes_Categories,ListIncludeID)
                                        
                                    if cdbl(discountValueDisCat) > 0  then 
                                        if VoucherDiscontType = "Amount" then
                                            vSubTotal = vSubTotal - cdbl( objRds("vouchercodediscount") )                                          
                                        else
                                            vSubTotal = vSubTotal - cdbl(discountValueDisCat)
                                        end if                                                                          
                                    end if
                                 else
                                    if VoucherDiscontType = "Amount" then
                                            vSubTotal = vSubTotal - cdbl( objRds("vouchercodediscount") )
                                    else
                                            vSubTotal = vSubTotal - ((vSubTotal/100)*objRds("vouchercodediscount"))
                                    end if
                                 end if
                       
                                

                         discountcodeused= "-" & objRds("vouchercodediscount") & "%"
	                    ' vSubTotal=vSubTotal-((vSubTotal/100)*objRds("vouchercodediscount"))
                         vouchercodediscount = objRds("vouchercodediscount")  
                         VoucherDiscontType = objRds("DiscountType") 
                    End If             
                End if
	            objRdsV.Close
                set objRdsV = nothing
	        end if

            objRds("SubTotal") = vSubTotal
            objRds.Update 
    end if
    objRds.Close
    set objRds = nothing
     
End If

set  objRds = Server.CreateObject("ADODB.Recordset")
objRds.Open "select oi.*," & _
        "mi.Name, mip.Name as PropertyName ,isnull(mi.ApplyTo,'b') as ApplyTo " & _
        "from ( OrderItems oi " & _
        "inner join MenuItems mi on oi.MenuItemId = mi.Id ) " & _
        "left join MenuItemProperties mip on oi.MenuItemPropertyId = mip.Id " & _
        "where oi.OrderId = " & vOrderId & " order by oi.ID desc" , objCon

if objRds.Eof then
                
   %>
    
    No Items In Your Order.
	
	<script>

$( "#shoppingcart2" ).text( "0" );
$( "#butcontinue" ).hide();
$( "#btnPlaceOrder").hide();
  $( "#beforeorder").hide();   
  $( "#divVoucherCode").hide();    
    if(alertTime==false){
        var localTime1 = new Date();
        var clientTime = localTime1.getTime() ;
        var servertime = Date.parse('<%=DateCondition %>') ;
        var gapTime =  (localTime1 - servertime)/( 60000) ;
         if(gapTime > 10 )
            {
                alert("The server date/time seems to be different from your computer. Please check your computer settings or contact us.");   
                alertTime =  true;
            }
    }         
</script>

<% 
        objRds.Close
    set objRds = nothing

else %>
<% if CanEditQtyBasket = "a" then %>
<style>
  #divShoppingCartSroll .glyphicon-minus:before {
text-align: center;
padding: 9px;
display: block;
}    

#divShoppingCartSroll .glyphicon-plus:before {  

text-align: center;
padding: 9px;
display: block;
}  

   #divShoppingCartSroll .input-group{
       width:126px;
   }  

  #divShoppingCartSroll  .input-number{
      width:42px;
      border:1px #dadada solid;
      text-align:center;
      border-left: 0;
      border-right: 0;
  }  

   #divShoppingCartSroll .glyphicon-minus,#divShoppingCartSroll .glyphicon-plus{
     width: 42px;
     height: 34px;
     border: 1px #dadada solid;
      display: block; top: 0;
  }  

   #divShoppingCartSroll .itemPrice{text-align:right;}  

 #divShoppingCartSroll  .input-number:focus{
      border:1px blue solid;
  }
</style>
<%end if %>
    <div id="divShoppingCartSroll" class="shoppingCartScroll">
    <table style="width: 100%;position:relative;" >  

    <%
        Do While NOT objRds.Eof  %>
                <tr id="basket<%=objRds("Id") %>">
                    <% if CanEditQtyBasket = "a" then %>
                    <td name="itemName" colspan="3" style="text-align:left;"> 
                        <%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %>                    
                            <input type="hidden" id="menuid_<%=objRds("Id") %>" name="menuapplyto" value="<%=objRds("ApplyTo") %>" />
                    <% else %>
                        <td style="padding:5px 0 5px 5px;"><button type="button" class="btn" onclick="Delc(<%= objRds("Id") %>)" >X</button></td>
                          <td name="itemName">  <%If objRds("Qta") > 1 Then %> 
                            (x <%= objRds("Qta") %>)
                        <% End If %>
                        <%= objRds("Name") %>&nbsp;<%= objRds("PropertyName") %>         
                    <%end if %>
						<%
						'display toppings in basket area
						If objRds("dishpropertiesids") <> "" Then
						 
						dishpropertiessplit=split(objRds("dishpropertiesids"),",")
					for i=0 to ubound(dishpropertiessplit)
					
					    dishpropertiessplit2=split(dishpropertiessplit(i),"|")
					    if dishpropertiessplit2(1)<>0 then
					
					        Set objRds_dishpropertiesprice = Server.CreateObject("ADODB.Recordset") 					
	                        objRds_dishpropertiesprice.Open "SELECT MenuDishproperties.ID, MenuDishproperties.dishproperty, MenuDishproperties.dishpropertyprice, MenuDishpropertiesGroups.dishpropertypricetype, MenuDishpropertiesGroups.dishpropertygroup FROM MenuDishproperties   INNER JOIN MenuDishpropertiesGroups    ON MenuDishproperties.dishpropertygroupid = MenuDishpropertiesGroups.ID where (((MenuDishproperties.ID)=" & dishpropertiessplit2(1)  & "))", objCon
					        response.write "<BR> <small>" & objRds_dishpropertiesprice("dishpropertygroup") & ":" & objRds_dishpropertiesprice("dishproperty") & "</small>" 
					        objRds_dishpropertiesprice.close()
                            set objRds_dishpropertiesprice = nothing
					    end if
					
					next
					end if%>
						 
						 <%
						'display dish properties in basket area
						toppingtext=""
						If objRds("toppingids") <> "" Then 
								Set objRds_toppingids = Server.CreateObject("ADODB.Recordset") 
                                Dim SQLTopping 
                                SQLTopping = "SELECT m.topping,isnull(mp.toppingsgroup,'') as toppingsgroup FROM MenuToppings m "
                                SQLTopping =SQLTopping & "  left join Menutoppingsgroups mp on  m.toppinggroupid = mp.ID"
                                SQLTopping =SQLTopping & "    where m.id in ("& objRds("toppingids") &")"
                        objRds_toppingids.Open SQLTopping, objCon
				        toppingtext=""
                        Dim toppinggroup : toppinggroup = ""
				        Do While NOT objRds_toppingids.Eof 
						    toppingtext = toppingtext & objRds_toppingids("topping") & ", "
                            toppinggroup = objRds_toppingids("toppingsgroup")
						    objRds_toppingids.MoveNext
						loop
                        objRds_toppingids.close()
                        set objRds_toppingids = nothing
						if toppingtext<>"" then
							  if toppinggroup & "" = "" then
                                toppinggroup = "Toppings"
                              end if  
                             toppingtext=left(toppingtext,len(toppingtext)-2)
						    response.write "<small><br>"&toppinggroup&": " & toppingtext & "</small>"
						end if
						 End If %>
						 
                    </td>
                   <% if CanEditQtyBasket = "c" then %>
                      <td name="itemPrice"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>
                    <%end if %>
                   
                </tr>
           <% if CanEditQtyBasket = "a" then %>
                <tr>
                     <td style="padding:5px 0 5px 5px;" colspan="2">                        
                         <div class="input-group">
                              
                              <span class="input-group-btn btn-number" style=" font-size: 13px;cursor:pointer;" data-type="minus" data-field="<%=objRds("Id") %>" onclick="IconClick(this,<%=objRds("Id") %>);">
                                  <span class="glyphicon glyphicon-minus"></span>
                              </span>
                               <input type="text" name="<%=objRds("Id") %>" class="form-control input-number"  id="qty<%=objRds("Id") %>" value="<%=objRds("Qta")  %>"  min="0" max="1000">
                              <span class="input-group-btn btn-number" style="font-size: 13px;cursor:pointer;" data-type="plus" data-field="<%=objRds("Id") %>"  onclick="IconClick(this,<%=objRds("Id") %>);">                                 
                              <span class="glyphicon glyphicon-plus"></span>
                              </span>
                          </div>
                     </td>
                    <td name="itemPrice" class="itemPrice"><%=CURRENCYSYMBOL%><%= FormatNumber(objRds("Total"), 2) %></td>
                </tr>
            <%end if %>
        <%  
            objRds.MoveNext
        Loop 
       ' objCon.execute("update Orders set PaymentSurcharge = 0 where ID=" & vOrderId )
        objRds.Close
        set objRds = nothing
        objCon.Close
        set objCon = nothing
        %>
    </table>
        </div>
        <table style="width: 100%">
     
		<%if discountcodeused & "" <>"" then  %>
		<tr>
            <td style="padding-top: 5px; border-top: 1px dotted black; line-height:20px;"><b>Voucher</b>
             <br /> <%=vouchercode %><% if VoucherDiscontType & "" <> "Amount" then%> (<%=discountcodeused%>)<%end if%> 
            </td>
            <td style="padding-top: 5px; border-top: 1px dotted black;line-height:10px;">
                <% if VoucherDiscontType & "" = "Amount" then    %>
                    <span id="subtotal">-<%=CURRENCYSYMBOL%><%= FormatNumber(vouchercodediscount,2) %>   </span></td>
                <%else %>
                       <% if discountValueDisCat >=0 then  %>
                            <span id="subtotal">-<%=CURRENCYSYMBOL%><%= FormatNumber(discountValueDisCat,2) %>   </span></td>
                        <%else %>
                            <span id="subtotal">-<%=CURRENCYSYMBOL%><%= FormatNumber((( vSubTotal * 100 )/(100- vouchercodediscount) - vSubTotal ),2) %>   </span></td>
                        <% end if %>
			    <% end if %>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr>
		<%end if%>	
            	
		<% 
		If vdeliverytype <> "d" Then
            vOrderShipTotal = 0
        elseIf vdeliveryDistance <> "" and sDeliveryFreeDistance<>0 Then
            dim UserDistance
            UserDistance = cdbl(vdeliveryDistance)
            If UserDistance <= sDeliveryFreeDistance Then vOrderShipTotal = 0                              
        end if

		if vSubTotal >sDeliveryChargeOverrideByOrderValue then	
			vOrderShipTotal = 0
		end if
        vOrderShipTotal = 0
        if lcase(IncludeDelivery_Collection) = "delivery" then
                   IncludeDelivery_Collection = "d"
        elseif lcase(IncludeDelivery_Collection) = "collection" then
                     IncludeDelivery_Collection = "c"
        end if
       %>
	     <tr>
            <td class="subtotalw" style="padding-top: 5px; border-top: 1px dotted black;font-size:11px;">Subtotal</td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">
			
			
			<span id="subtotal" style="font-size:11px;"><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal, 2)  %></span></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr> 
        
		<!--  <tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;font-size:11px;">Delivery</td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">
			<span id="subtotal" style="font-size:11px;"><%=CURRENCYSYMBOL%><%= FormatNumber(vOrderShipTotal, 2)  %></span></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr> -->
		
         <tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;"><b>Total</b></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">
			
			
			<span id="subtotal"><strong><%=CURRENCYSYMBOL%><%= FormatNumber(vSubTotal + vOrderShipTotal, 2)  %></strong></span></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;">&nbsp;</td>
        </tr>   
		<tr>
            <td style="padding-top: 5px; border-top: 1px dotted black;"></td>
            <td style="padding-top: 5px; border-top: 1px dotted black;"></td>
			
			
			
            <td style="padding-top: 5px; border-top: 1px dotted black;"></td>
        </tr>    

    </table>   
	
	 <button type="button" class="btn btn-silver btn-xs btn-block" id="specialshow"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Special Instructions</button>
	<button type="button" class="btn btn-silver btn-xs btn-block" id="specialhide" style="display:none;"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span> Close</button>
	
	<div class="control-group" style="display:none;" id="specialbox">
                   
                    <div class="controls">
                        <textarea id="Specialinput" name="Specialinput" rows="4" class="form-control" ></textarea>
                    </div>
                </div>
	
    <input type="hidden" name="SubTotal" id="SubTotal" value="<%=vSubTotal %>" />
   
    
    
    </form>
<script type="text/javascript">
   IncludeDelivery_Collection = "<%=IncludeDelivery_Collection %>";
    $( "#shoppingcart2" ).text( "<%= FormatNumber(vSubTotal, 2)  %>" );
    $( "#butcontinue" ).show();
    $( "#btnPlaceOrder").show();   
    $( "#beforeorder").show();  
    $( "#divVoucherCode").show();       
    $("#specialshow").click(function(){
        $("#specialbox").show();
	    $("#specialshow").hide();
	    $("#specialhide").show();
    });

    $("#specialhide").click(function(){
        $("#specialbox").hide();
	    $("#specialshow").show();
	    $("#specialhide").hide();
    });

$('#Specialinput').bind('input propertychange', function() {
      if(this.value.length){
       $.cookie("Specialinput", this.value); 
      }
});

$("textarea#Specialinput").val($.cookie("Specialinput"));
   if( $(window).width() < 992) { 

   $("#divShoppingCartSroll").removeClass("shoppingCartScroll");
    }
    if(alertTime==false){
        var localTime1 = new Date();
        var clientTime = localTime1.getTime() ;
        var servertime = Date.parse('<%=DateCondition %>') ;
        var gapTime =  (localTime1 - servertime)/( 60000) ;
         if(gapTime > 10 )
            {
                alert("The server date/time seems to be different from your computer. Please check your computer settings or contact us.");   
                 alertTime =  true;
            }
    }
    <% if Request.QueryString("id") & "" <> "" then %>
    $(function(){
        if($("#basket<%=Request.QueryString("id") %>").length > 0)
        {
          
            if(<%=Request.QueryString("top")%> > 0 )
                jQuery('#divShoppingCartSroll').scrollTop(<%=Request.QueryString("top")%>);
          
            
        }
    });
    <% end if %>
</script>
    
  <% if CanEditQtyBasket = "a" then %>
<script type="text/javascript">  
    
    function IconClick(obj,id)
    {
        fieldName = id;
        type = $(obj).attr('data-type');
        var input = $("input[name='" + fieldName + "']");
        
        var currentVal = parseInt(input.val());
        if (!isNaN(currentVal)) {
            if (type == 'minus') {

                if (currentVal > input.attr('min')) {
                    input.val(currentVal - 1).change();
                }
                if (parseInt(input.val()) == input.attr('min')) {
                    $(obj).attr('disabled', true);
                }

            } else if (type == 'plus') {

                if (currentVal < input.attr('max')) {
                    input.val(currentVal + 1).change();
                }
                if (parseInt(input.val()) == input.attr('max')) {
                    $(obj).attr('disabled', true);
                }

            }
        } else {
            input.val(0);
        }

    }

    $('.input-number').unbind("focusin");
    $('.input-number').unbind("change");
    $(".input-number").unbind("keydown");
$('.input-number').focusin(function(){
   $(this).data('oldValue', $(this).val());
});

$('.input-number').change(function() {
    
    minValue =  parseInt($(this).attr('min'));
    maxValue =  parseInt($(this).attr('max'));
    valueCurrent = parseInt($(this).val());
    
    name = $(this).attr('name');
    
    if (parseInt($(this).val()) >= 0) {
        Del($(this).attr("id").replace("qty", ""), $(this).val());
    } else {
        alert('Sorry, enter number native');
        $(this).val($(this).data('oldValue'));
    }
    
});
$(".input-number").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
             // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) || 
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });	</script>
<% end if %>

<%
End If
%>   


