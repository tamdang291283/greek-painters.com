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

Set objCon = Server.CreateObject("ADODB.Connection")
    Set objRds = Server.CreateObject("ADODB.Recordset") 
%>



<%
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
If (CStr(Request("MM_update")) = "form1") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = sConnStringcms
    
    Dim SQL_Update 
        SQL_Update ="UPDATE businessdetails SET [MAIL_FROM] = ?" '1
    SQL_Update= SQL_Update & ",[PAYPAL_URL] = ?" '2
    SQL_Update= SQL_Update & ",[PAYPAL_PDT] = ?" '3
    SQL_Update= SQL_Update & ",[SMTP_PASSWORD] = ?" '4
    SQL_Update= SQL_Update & ",[GMAP_API_KEY] = ?" '5
    SQL_Update= SQL_Update & ",[SMTP_USERNAME] = ?" '6
    SQL_Update= SQL_Update & ",[SMTP_USESSL] = ?" '7
    SQL_Update= SQL_Update & ",[MAIL_SUBJECT] = ?" '8
    SQL_Update= SQL_Update & ",[CURRENCYSYMBOL] = ?" '9
    SQL_Update= SQL_Update & ",[SMTP_SERVER] = ?" '10
    SQL_Update= SQL_Update & ",[CREDITCARDSURCHARGE] = ?" '11
    SQL_Update= SQL_Update & ",[SMTP_PORT] = ?" '12
    SQL_Update= SQL_Update & ",[STICK_MENU] = ?" '13
    SQL_Update= SQL_Update & ",[MAIL_CUSTOMER_SUBJECT] = ?" '14
    SQL_Update= SQL_Update & ",[CONFIRMATION_EMAIL_ADDRESS] = ?" '15
    SQL_Update= SQL_Update & ",[SEND_ORDERS_TO_PRINTER] = ?" '16
    SQL_Update= SQL_Update & ",[timezone] = ?" ' 17
    SQL_Update= SQL_Update & " ,[PAYPAL_ADDR] = ?" '18
    SQL_Update= SQL_Update & ", [nochex]=?,[nochexmerchantid]=?" '19 ' 20
    SQL_Update= SQL_Update & ",[paypal]=?" '21
    SQL_Update= SQL_Update & ",[IBT_API_KEY]=?" '22
    SQL_Update= SQL_Update & ",[IBP_API_PASSWORD]=?" '23
    SQL_Update= SQL_Update & ",[worldpay]=?" '24
    SQL_Update= SQL_Update & ",[worldpaymerchantid]=?" '25
    SQL_Update= SQL_Update & ",[googleecommercetracking]=?" '26
    SQL_Update= SQL_Update & ",[googleecommercetrackingcode]=?" '27
    SQL_Update= SQL_Update & ",[bringg]=?" '28
    SQL_Update= SQL_Update & ",[bringgurl]=?" '29
    SQL_Update= SQL_Update & ",[bringgcompanyid]=?" '30
    SQL_Update= SQL_Update & ", [worldpaylive]=?" '31
    SQL_Update= SQL_Update & ",[worldpayinstallationid]=?" '32
    SQL_Update= SQL_Update & ", [printeridlist]=?" '33
    SQL_Update= SQL_Update & ",[EPSONJsPrinterURL]=?" '34
    SQL_Update= SQL_Update & ",[SMSEnable]=?" '35
    SQL_Update= SQL_Update & ",[SMSOnDelivery]=?" '36
    SQL_Update= SQL_Update & ",[SMSSupplierDomain]=?" '37
    SQL_Update= SQL_Update & ",[SMSOnOrder]=?" '38
    SQL_Update= SQL_Update & ",[SMSOnOrderAfterMin]=?" '39
    SQL_Update= SQL_Update & ",[SMSOnOrderContent]=?" '40
    SQL_Update= SQL_Update & ",[DefaultSMSCountryCode]=?" '41
    SQL_Update= SQL_Update & ",[minimumamountforcardpayment]=?" '42
    SQL_Update= SQL_Update & ",[SMSOnAcknowledgement]=?" '43
    SQL_Update= SQL_Update & ",[LocalPrinterURL]=?" '44
    SQL_Update= SQL_Update & ",[ShowRestaurantDetailOnReceipt]=?" '45
    SQL_Update= SQL_Update & ",[PrinterFontSizeRatio]=?" '46
    SQL_Update= SQL_Update & ",[ServiceChargePercentage]=?" '47
    SQL_Update= SQL_Update & ",[InRestaurantServiceChargeOnly]=?" '48
    SQL_Update= SQL_Update & " ,[IsDualReceiptPrinting]=?" '49
    SQL_Update= SQL_Update & ",[InRestaurantEpsonPrinterIDList]=?" '50
    SQL_Update= SQL_Update & ",[BlockIPEmailList]=?" '51
    SQL_Update= SQL_Update & ",[RePrintReceiptWays]=?" '52
    SQL_Update= SQL_Update & ",[printingtype]=?" '53
    SQL_Update= SQL_Update & ",stripe=?" '54
    SQL_Update= SQL_Update & ",Stripe_Key_Secret=?" '55
    SQL_Update= SQL_Update & ",Stripe_Api_Key=?" '56
    SQL_Update= SQL_Update & ",Currency_PAYPAL=?" '57
    SQL_Update= SQL_Update & ",Currency_STRIPE=?" '58
    SQL_Update= SQL_Update & ",Currency_WOLRDPAY=?" '59
    SQL_Update= SQL_Update & ",isCheckCapcha=?" '60
    SQL_Update= SQL_Update & ",Stripe_Country=?" '61
    SQL_Update= SQL_Update & ",enable_StripePaymentButton=?" '62
    SQL_Update= SQL_Update & ",enable_CashPayment=?" '63
    SQL_Update= SQL_Update & ",EnableUrlRewrite=?" '64
    SQL_Update= SQL_Update & ",Show_Ordernumner_printer=?" '65
    SQL_Update= SQL_Update & ",Show_Ordernumner_Receipt=?" '66
    SQL_Update= SQL_Update & ",Show_Ordernumner_Dashboard=?" '67
    SQL_Update= SQL_Update & "  WHERE ID = " & MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)  
        
    'Response.Write(SQL_Update) 
    'Response.End
MM_editCmd.CommandText = SQL_Update    
MM_editCmd.Prepared = true
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("MAIL_FROM"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("PAYPAL_URL"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("PAYPAL_PDT"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("SMTP_PASSWORD"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("GMAP_API_KEY"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("SMTP_USERNAME"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, Request.Form("SMTP_USESSL"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, Request.Form("MAIL_SUBJECT"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 202, 1, 255, Request.Form("CURRENCYSYMBOL"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 202, 1, 255, Request.Form("SMTP_SERVER"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param11", 202, 1, 255, Request.Form("CREDITCARDSURCHARGE"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param12", 202, 1, 255, Request.Form("SMTP_PORT"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param13", 202, 1, 255, Request.Form("STICK_MENU"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param14", 202, 1, 255, Request.Form("MAIL_CUSTOMER_SUBJECT"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param15", 202, 1, 255, Request.Form("CONFIRMATION_EMAIL_ADDRESS"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param16", 202, 1, 255, Request.Form("SEND_ORDERS_TO_PRINTER"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param17", 202, 1, 255, Request.Form("timezone"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param18", 202, 1, 255, Request.Form("PAYPAL_ADDR"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param19", 202, 1, 255, Request.Form("nochex"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param20", 202, 1, 255, Request.Form("nochexmerchantid"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param21", 202, 1, 255, Request.Form("paypal"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param22", 202, 1, 255, Request.Form("IBT_API_KEY"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param23", 202, 1, 255, Request.Form("IBP_API_PASSWORD"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param24", 202, 1, 255, Request.Form("worldpay"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param25", 202, 1, 255, Request.Form("worldpaymerchantid"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param26", 202, 1, 255, Request.Form("googleecommercetracking"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param27", 202, 1, 255, Request.Form("googleecommercetrackingcode"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param28", 202, 1, 255, Request.Form("bringg"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param29", 202, 1, 255, Request.Form("bringgurl"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param30", 202, 1, 255, Request.Form("bringgcompanyid"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param31", 3, 1, -1, MM_IIF(Request.Form("worldpaylive"),Request.Form("worldpaylive"),0) ) ' adVarWChar
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param32", 202, 1, 255, Request.Form("worldpayinstallationid"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param33", 202, 1, 255, Request.Form("PrinterIDList"))
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param34", 202, 1, 255, Request.Form("EPSONJsPrinterURL"))   
If Request.Form("SMSEnable") = "" Then
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param35", 3, 1, 255, 0) 
Else
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param35", 3, 1, 255, Request.Form("SMSEnable")) 
End If 

If Request.Form("SMSOnDelivery") = "" Then
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param36", 3, 1, 255, 0) 
Else
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param36", 3, 1, 255, Request.Form("SMSOnDelivery")) 
End If 

MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param37", 202, 1, 100, Request.Form("SMSSupplierDomain")) 

If Request.Form("SMSOnOrder") = "" Then
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param38", 3, 1, 255, 0) 
Else
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param38", 3, 1, 255, Request.Form("SMSOnOrder")) 
End If 

    
If Request.Form("SMSOnOrderAfterMin") & ""= "" Then
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param39", 3, 1, 255,"0")    

Else
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param39", 3, 1, 255, Request.Form("SMSOnOrderAfterMin"))    

End If 

MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param40", 202, 1, 255, Request.Form("SMSOnOrderContent")) 

MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param41", 202, 1, 255, Request.Form("DefaultSMSCountryCode"))   
MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param42", 6, 1, 255, Request.Form("minimumamountforcardpayment"))   ' Currency

   If Request.Form("SMSOnAcknowledgement") = "" Then
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param43", 3, 1, 255, 0) 
Else
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param43", 3, 1, 255, Request.Form("SMSOnAcknowledgement")) 
End If  
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param44", 202, 1, 255, Request.Form("LocalPrinterURL"))
    
    If Request.Form("ShowRestaurantDetailOnReceipt") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param45", 3, 1, 255, 1) 
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param45", 3, 1, 255, Request.Form("ShowRestaurantDetailOnReceipt")) 
    End If  

     If Request.Form("PrinterFontSizeRatio") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param46", 5, 1, 255, 1)  'aDouble
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param46", 5, 1, 255, Request.Form("PrinterFontSizeRatio")) 
    End If  
     If Request.Form("ServiceChargePercentage") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param47", 5, 1, 255, 0)  'aDouble
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param47", 5, 1, 255, Request.Form("ServiceChargePercentage")) 
    End If   
     If Request.Form("InRestaurantServiceChargeOnly") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param48", 3, 1, 255, 0)  'bit
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param48", 3, 1, 255, Request.Form("InRestaurantServiceChargeOnly")) 
    End If  
     If Request.Form("IsDualReceiptPrinting") = "" Then
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param49", 3, 1, -1, 0)  'bit
    Else
        MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param49", 3, 1, -1, Request.Form("IsDualReceiptPrinting")) 
    End If    
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param50", 202, 1, 255, Request.Form("InRestaurantEpsonPrinterIDList"))
     MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param51", 202, 1, 255, Request.Form("BlockIPEmailList")) 
     MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param52", 202, 1, 255, Request.Form("RePrintReceiptWays"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param53", 202, 1, 255, Request.Form("printingtype"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param54", 202, 1, 255, Request.Form("stripe"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param55", 202, 1, 255, Request.Form("Stripe_Key_Secret"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param56", 202, 1, 255, Request.Form("Stripe_Api_Key"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param57", 202, 1, 255, Request.Form("Currency_PAYPAL"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param58", 202, 1, 255, Request.Form("Currency_STRIPE"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param59", 202, 1, 255, Request.Form("Currency_WOLRDPAY"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param60", 202, 1, 255, Request.Form("isCheckCapcha"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param61", 202, 1, 255, Request.Form("Stripe_Country"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param62", 202, 1, 255, Request.Form("enable_StripePaymentButton"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param63", 202, 1, 255, Request.Form("enable_CashPayment"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param64", 202, 1, 255, Request.Form("EnableUrlRewrite"))
    
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param65", 202, 1, 255, MM_IIF(Request.Form("Show_Ordernumner_printer"), Request.Form("Show_Ordernumner_printer"), "no")  )
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param66", 202, 1, 255, MM_IIF(Request.Form("Show_Ordernumner_Receipt"), Request.Form("Show_Ordernumner_Receipt"), "no"))
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param67", 202, 1, 255, MM_IIF(Request.Form("Show_Ordernumner_Dashboard"), Request.Form("Show_Ordernumner_Dashboard"), "no") )
    
    
    'MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param53", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble

    'REsponse.Write("AA" & Request.Form("SMSEnable")) 
    'Response.End()
    MM_editCmd.Execute

    if Request.Form("EnableUrlRewrite") = "Yes" then
        if Request.Form("Old_s_URLRewrite") & "" <> Request.Form("URLRewrite") & "" then
             'Delete all
             SQL_Update = "Delete from URL_REWRITE where fromlink like '%/menu' and RestaurantID=" & Session("MM_id") 
             MM_editCmd.CommandText = SQL_Update    
             MM_editCmd.Prepared = true
             MM_editCmd.Execute

             SQL_Update = "Delete from URL_REWRITE where fromlink like '%/checkout' and RestaurantID=" & Session("MM_id") 
             MM_editCmd.CommandText = SQL_Update    
             MM_editCmd.Prepared = true
             MM_editCmd.Execute
        
             SQL_Update = "Delete from URL_REWRITE where fromlink like '%/thanks' and RestaurantID=" & Session("MM_id") 
             MM_editCmd.CommandText = SQL_Update    
             MM_editCmd.Prepared = true
             MM_editCmd.Execute
              
            ' Add New
             dim urlresult : urlresult = lcase(Request.Form("URLRewrite")) 
             urlresult = replace(urlresult,"/menu","")
             urlresult = replace(urlresult,"/checkout","")
             urlresult = replace(urlresult,"/thanks","")
             urlresult  = ReplaceSpecialCharacterURL(urlresult)

             SQL_Update = "Insert into URL_REWRITE(tolink,fromlink,RestaurantID,status) values('menu.asp?id_r=" & Session("MM_id") & "','" & SITE_URL& urlresult & "/menu" & "'," &Session("MM_id") &",'ACTIVE') "
         
             MM_editCmd.CommandText = SQL_Update    
             MM_editCmd.Prepared = true
             MM_editCmd.Execute

             SQL_Update = "Insert into URL_REWRITE(tolink,fromlink,RestaurantID,status) values('checkout.asp?id_r=" & Session("MM_id") & "','" & SITE_URL & urlresult & "/checkout" & "'," &Session("MM_id") &",'ACTIVE') "
             MM_editCmd.CommandText = SQL_Update    
             MM_editCmd.Prepared = true
             MM_editCmd.Execute
        
             SQL_Update = "Insert into URL_REWRITE(tolink,fromlink,RestaurantID,status) values('thanks.asp?id_r=" & Session("MM_id") & "','" & SITE_URL & urlresult & "/thanks" & "'," &Session("MM_id") &",'ACTIVE') "
             MM_editCmd.CommandText = SQL_Update    
             MM_editCmd.Prepared = true
             MM_editCmd.Execute
            
        end if
    else
         SQL_Update = "Delete from URL_REWRITE where fromlink like '%/menu' and RestaurantID=" & Session("MM_id") 
         MM_editCmd.CommandText = SQL_Update    
         MM_editCmd.Prepared = true
         MM_editCmd.Execute

         SQL_Update = "Delete from URL_REWRITE where fromlink like '%/checkout' and RestaurantID=" & Session("MM_id") 
         MM_editCmd.CommandText = SQL_Update    
         MM_editCmd.Prepared = true
         MM_editCmd.Execute
        
         SQL_Update = "Delete from URL_REWRITE where fromlink like '%/thanks' and RestaurantID=" & Session("MM_id") 
         MM_editCmd.CommandText = SQL_Update    
         MM_editCmd.Prepared = true
         MM_editCmd.Execute

    end if
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "../../cms/dashboards/loggedin.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
   ' MM_editCmd.close()
    set MM_editCmd = nothing
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
        function ReplaceSpecialCharacterURL(byval str)    
            str =  Replace(str," ","-")
            str =  Replace(str,",","-")
            str =  Replace(str,"<","")
            str =  Replace(str,">","")
            str =  Replace(str,":","-")
            str =  Replace(str,"'","-")
            str =  Replace(str,"""","-")
            str =  Replace(str,"&","")    
            str =  Replace(str,"--","-")
            ReplaceSpecialCharacterURL = str
       end function
       function BuiltUrl(byval bName, byval pCode,byval telno,byval sto)
            dim result : result = ""
                result  =   trim(bName) & " " &  trim(pCode) & " " & telno
            result = ReplaceSpecialCharacterURL(result)
            result =SITE_URL  & result 
            select case lcase(sto) 
            case "menu.asp" 
                result =  result & "/menu"
            case "checkout.asp" 
                result =  result & "/checkout"
            case "thanks.asp" 
                result =  result & "/thanks"
            end select 
            'Response.Write( sto & " " & result & " " )
            BuiltUrl = lcase(result)
       end function


Dim Recordset1
Dim Recordset1_cmd
Dim Recordset1_numRows
Set Recordset1_cmd = Server.CreateObject ("ADODB.Command")
    Recordset1_cmd.ActiveConnection = sConnStringcms
sql = "SELECT * FROM businessdetails where id=" & Session("MM_id")
    Recordset1_cmd.CommandText = sql
    Recordset1_cmd.Prepared = true
Set Recordset1 = Recordset1_cmd.Execute
Recordset1_numRows = 0

sql = "SELECT top 1 fromlink  FROM URL_REWRITE where RestaurantID=" & Session("MM_id") & " and Status='ACTIVE' order by ID  "
 

    Recordset1_cmd.CommandText = sql
    Recordset1_cmd.Prepared = true
    dim RS_URLREWRITE : set RS_URLREWRITE  = Server.CreateObject("ADODB.Recordset")
Set RS_URLREWRITE = Recordset1_cmd.Execute

   Dim s_URLRewrite : s_URLRewrite = ""
   Dim Old_s_URLRewrite : Old_s_URLRewrite = ""
   if not RS_URLREWRITE.EOF then
        s_URLRewrite = RS_URLREWRITE("fromlink")
        Old_s_URLRewrite = replace(lcase(s_URLRewrite),lcase(SITE_URL),"") 
   end if
    RS_URLREWRITE.close()
    set RS_URLREWRITE = nothing 
    if s_URLRewrite = "" then
        s_URLRewrite = BuiltUrl(Recordset1("Name"),Recordset1("PostalCode"),Recordset1("Telephone"),"menu")
    end if
    s_URLRewrite = replace(lcase(s_URLRewrite),lcase(SITE_URL),"")
    s_URLRewrite = replace(s_URLRewrite,"/menu","")
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
 
 <li><a href="#">System Settings</a></li>
 <li>Settings</li>
  
</ol>





		
			<form method="post" action="<%=MM_editAction%>" autocomplete="off" name="form1" role="form">
  
   <ul class="nav nav-tabs">
    
    <li class="active"><a data-toggle="tab"  href="#GeneralSetting">General settings</a></li>
    <li><a data-toggle="tab"  href="#PaymentSetting">Payment settings</a></li>
    <li><a data-toggle="tab" href="#EmailSetting">Email Settings</a></li>
    <li><a data-toggle="tab" href="#PrinterSetting">Printer Settings</a></li>
    <li><a data-toggle="tab" href="#SMSSetting">SMS Settings</a></li>
       <li><a data-toggle="tab" href="#TrackingSetting">Tracking Settings</a></li>
  </ul>
<div class="tab-content">
  <div class="tab-pane fade in active" id="GeneralSetting">
  
<div class="panel panel-default">
  <div class="panel-heading">Google Maps Settings</div>
  <div class="panel-body">
  
  


<div class="form-group">
<label for="document name">GMAP API_KEY</label>    <span class="glyphicon glyphicon-question-sign" aria-hidden="true" data-toggle="popover" data-placement="right" data-content="<a href='http://developers.google.com/maps/documentation/javascript/get-api-key' target='_blank'>Link to google maps key</a>"></span>
<p>Enter your Google maps API key, this can be found in your Google Maps or Google APIs control panel.</p>
<input type="text" class="form-control" id="GMAP_API_KEY" name="GMAP_API_KEY" value="<%=(Recordset1.Fields.Item("GMAP_API_KEY").Value)%>" required>
</div>
</div></div>


<div class="panel panel-default">
  <div class="panel-heading">Time Settings</div>
  <div class="panel-body">
  

<div class="form-group">
<label for="document name">TIMEZONE OFFSET</label>
<p>Choose your timezone from the list below.</p>
<%
Dim Recordset10
Dim Recordset10_cmd
Dim Recordset10_numRows
Set Recordset10_cmd = Server.CreateObject ("ADODB.Command")
Recordset10_cmd.ActiveConnection = sConnStringcms
sql = "SELECT * FROM timezones order by id"
Recordset10_cmd.CommandText = sql
Recordset10_cmd.Prepared = true
Set Recordset10 = Recordset10_cmd.Execute
Recordset10_numRows = 0
%>

<select name="timezone" id="timezone" class="form-control">
<option value="0">--- select ---</option>
<%Do While NOT Recordset10.Eof%>
  <option value="<%=Recordset10.Fields.Item("id").Value%>" <%if cstr(Recordset10.Fields.Item("id").Value)=cstr(Recordset1.Fields.Item("timezone").Value & "") then%>SELECTED<%end if%>><%=Recordset10.Fields.Item("timezone").Value%> (<%=Recordset10.Fields.Item("offset").Value%>)</option>
 <%
                            Recordset10.MoveNext    
                        Loop
                    
    
                        %>
  </select>




</div>

</div></div>


<div class="panel panel-default">
  <div class="panel-heading">Currency Settings</div>
  <div class="panel-body">


 
<div class="form-group">
<label for="document name">CURRENCY SYMBOL</label>
<p>Enter the symbol used for your chosen currency eg. &pound;, &euro; etc.</p>
<input type="text"   class="form-control" id="CURRENCYSYMBOL" name="CURRENCYSYMBOL" value="<%=(Recordset1.Fields.Item("CURRENCYSYMBOL").Value)%>" required>
</div>
  
</div></div>



<div class="panel panel-default">
  <div class="panel-heading">Google Analytics Settings</div>
  <div class="panel-body">



<% dim googleecommercetracking : googleecommercetracking = Recordset1.Fields.Item("googleecommercetracking").Value
   if googleecommercetracking & "" = "" then
        googleecommercetracking = "No"
    end if
%>

<div class="form-group">
<label for="document name">ECOMMERCE TRACKING</label>
<p>If you would like to link to google ecommerce tracking select Yes below.</p>
<input type="radio" name="googleecommercetracking" value="Yes" <%if googleecommercetracking="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="googleecommercetracking" value="No" <%if googleecommercetracking="No" then%>checked<%end if%>> No 


</div>

<div class="form-group">
<label for="document name">TRACKING CODE</label>
<p>Enter the tracking code from google analytics.</p>
<input type="text" class="form-control" id="googleecommercetrackingcode" name="googleecommercetrackingcode" value="<%=(Recordset1.Fields.Item("googleecommercetrackingcode").Value)%>">
</div>


</div></div>

<div class="panel panel-default">
  <div class="panel-heading">Interface Settings</div>
  <div class="panel-body">



<% dim STICK_MENU : STICK_MENU = Recordset1.Fields.Item("STICK_MENU").Value 
    if   STICK_MENU  & "" = "" then
         STICK_MENU = "Yes"
    end if
 %>

<div class="form-group">
<label for="document name">STICKY MENU</label>
<p>If you would like the right-side part of the menu/order page to remain always visible even when a user scrolls down the page select Yes below.</p>
<input type="radio" name="STICK_MENU" value="Yes" <%if STICK_MENU="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="STICK_MENU" value="No" <%if STICK_MENU="No" then%>checked<%end if%>> No 


</div>

      

</div></div>

      
<div class="panel panel-default">
  <div class="panel-heading">Other Settings</div>
  <div class="panel-body">





<div class="form-group">
<label for="document name">Blocked List</label>
<p>Enter a list of IP or email addresses which you would like to be blocked, seperated by ";".  eg.  192.168.1.1;helo@yahoo.com;102.34.12.43;</p>
<input type="text" class="form-control" id="BlockIPEmailList" name="BlockIPEmailList" value="<%=(Recordset1.Fields.Item("BlockIPEmailList").Value)%>">


</div>


</div></div>

            
<div class="panel panel-default">
  <div class="panel-heading">Capcha Settings</div>
  <div class="panel-body">



      <% 
           dim enable_StripePaymentButton : enable_StripePaymentButton  =  Recordset1.Fields.Item("enable_StripePaymentButton").Value
           dim enable_CashPayment : enable_CashPayment  = Recordset1.Fields.Item("enable_CashPayment").Value
          if enable_StripePaymentButton & "" = "" then
            enable_StripePaymentButton = "Yes"
          end if
          if enable_CashPayment & "" = "" then
            enable_CashPayment = "Yes"
          end if
          dim checkcapcha : checkcapcha = Recordset1.Fields.Item("isCheckCapcha").Value & "" 
              if checkcapcha & "" = "" then
                   checkcapcha = "Yes"     
              end if

  
           %>

<div class="form-group">
<label for="document name">Enable Capcha</label>
<p>Select yes if you would like to check capcha at the checkout.</p>
<input type="radio" name="isCheckCapcha" value="Yes" <%if checkcapcha="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="isCheckCapcha" value="No" <%if checkcapcha="No" then%>checked<%end if%>> No 
</div>


</div></div>

<div class="panel panel-default">
  <div class="panel-heading">Enable URL ReWrite</div>
  <div class="panel-body">



      <% 
           dim EnableUrlRewrite : EnableUrlRewrite  =  Recordset1.Fields.Item("EnableUrlRewrite").Value
           dim sStyleShowURL : sStyleShowURL = ""
       
          if EnableUrlRewrite & "" = "" then
                    EnableUrlRewrite = "No"
                  
          end if
          if EnableUrlRewrite = "No" then
            sStyleShowURL = "display:none;"
          end if
  
           %>

<div class="form-group">
<label for="document name">Enable Url Rewrite</label>
<p>Select yes if you would like to enable Url Rewrite.</p>
<input type="radio" name="EnableUrlRewrite" onclick="EnableURLRewrite('yes');" value="Yes" <%if EnableUrlRewrite="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input onclick="EnableURLRewrite('no');" type="radio" name="EnableUrlRewrite" value="No" <%if EnableUrlRewrite="No" then%>checked<%end if%>> No  
    <br /> <br />
<input type="text" class="form-control" id="URLRewrite" style="<%=sStyleShowURL%>" name="URLRewrite" value="<%=s_URLRewrite %>">
<input type="hidden" name="Old_s_URLRewrite" value="<%=Old_s_URLRewrite %>" />
</div>

</div></div>
<div class="panel panel-default">
  <div class="panel-heading">Number of Orders</div>
  <div class="panel-body">
      <div class="form-group">
<label for="document name">Number of Orders</label>
    <p></p>
          <% dim Show_Ordernumner_printer ,Show_Ordernumner_Receipt,Show_Ordernumner_Dashboard
              Show_Ordernumner_printer =   Recordset1.Fields.Item("Show_Ordernumner_printer").Value
              Show_Ordernumner_Receipt =   Recordset1.Fields.Item("Show_Ordernumner_Receipt").Value
              Show_Ordernumner_Dashboard =   Recordset1.Fields.Item("Show_Ordernumner_Dashboard").Value
              if Show_Ordernumner_printer & "" = "" then
                Show_Ordernumner_printer = "yes"
              end if
              if Show_Ordernumner_Receipt & "" = "" then
                Show_Ordernumner_Receipt = "yes"
              end if
              if Show_Ordernumner_Dashboard & "" = "" then
                Show_Ordernumner_Dashboard = "yes"
              end if

               %>
    <input type="checkbox" name="Show_Ordernumner_printer" onclick="SelectShowNumberOrder(this);"   <%if Show_Ordernumner_printer="yes" then%>checked value="yes"<%else %> value="no" <%end if%>> Printer receipts &nbsp;&nbsp; 
    <input  type="checkbox" name="Show_Ordernumner_Receipt"  onclick="SelectShowNumberOrder(this);"  <%if Show_Ordernumner_Receipt="yes" then%>checked value="yes"<%else %> value="no" <%end if%>> Thank-you for your order  page  and emails 
    <input  type="checkbox" name="Show_Ordernumner_Dashboard" onclick="SelectShowNumberOrder(this);"  <%if Show_Ordernumner_Dashboard="yes" then%>checked value="yes"<%else %> value="no" <%end if%>> Sales Dashboards  
    <br /> <br />

</div>
</div></div>
 <script type="text/javascript">
     function SelectShowNumberOrder(obj)
     {
         if ($(obj).is(":checked"))
             $(obj).val("yes");
         else
             $(obj).val("no");
     }
 </script>
</div> 
<div class="tab-pane fade" id="PaymentSetting">

    
  <div class="panel panel-default">
  <div class="panel-heading">Card Payment Setting</div>
  <div class="panel-body">
  


<div class="form-group">
<label for="document name">Minimum amount for card payment.</label>
<p>Input the minimum order amount to accept card payment</p>
<input type="text" class="form-control" pattern="[0-9]+([\.][0-9]{0,2})?"  title="Minimum amount for card payment must be a number with up to 2 decimal places" id="minimumamountforcardpayment" name="minimumamountforcardpayment" value="<% if (Recordset1.Fields.Item("minimumamountforcardpayment").Value) & "" = "" then %><%=0 %> <%else %><%=(Recordset1.Fields.Item("minimumamountforcardpayment").Value) %><%end if %>" required>


</div>

 </div>
</div>

      <div class="panel panel-default">
  <div class="panel-heading">Cash Payment Setting</div>
  <div class="panel-body">
  


<div class="form-group">
<label for="document name">Enable cash payments:</label><br />
<input type="radio" name="enable_CashPayment" value="Yes" <%if enable_CashPayment="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="enable_CashPayment" value="No" <%if enable_CashPayment="No" then%>checked<%end if%>> No 
</div>

 </div>
</div>

    
  <div class="panel panel-default">
  <div class="panel-heading">Service Charge</div>
  <div class="panel-body">
  


<div class="form-group">

<p>Set a service charge of  [<input type="text" style="width:35px;" pattern="[0-9]+([\.][0-9]{0,2})?"  title="Service Charge must be a number with up to 2 decimal places"  name="ServiceChargePercentage" <%if Recordset1.Fields.Item("ServiceChargePercentage").Value & "" <> "" then%>value="<%=Recordset1.Fields.Item("ServiceChargePercentage").Value %>"<% else %>value="0"<%end if%> />]% for all orders.</p>
<input type="checkbox" name="InRestaurantServiceChargeOnly" value="1" <%if  LCase(Recordset1.Fields.Item("InRestaurantServiceChargeOnly").Value & "") =  "1" then  %> checked <% end if %> /> Tick this box is Service Charges apply to In-Store ordering ONLY.


</div>

 </div>
</div>



<div class="panel panel-default">
  <div class="panel-heading">Surcharge Settings</div>
  <div class="panel-body">

<div class="form-group">
<label for="document name">CREDIT CARD SURCHARGE</label>
<p>If you charge an additional fee for credit cards please enter it below.</p>
<input type="text" class="form-control"  pattern="[0-9]+([\.][0-9]{0,2})?"  title="Credit card surcharge must be a number with up to 2 decimal places"  id="CREDITCARDSURCHARGE" name="CREDITCARDSURCHARGE" value="<%=(Recordset1.Fields.Item("CREDITCARDSURCHARGE").Value)%>" required>
</div>

</div></div>

    <div class="panel panel-default">
  <div class="panel-heading">Paypal Settings</div>
  <div class="panel-body">
  

<% dim paypal : paypal = Recordset1.Fields.Item("paypal").Value 
    if paypal & ""= "" then
        paypal = "No"
    end if
    dim Currency_STRIPE,Currency_PAYPAL,Currency_WOLRDPAY, Stripe_Country
    Currency_STRIPE= Recordset1.Fields.Item("Currency_STRIPE").Value
    Currency_PAYPAL = Recordset1.Fields.Item("Currency_PAYPAL").Value
    Currency_WOLRDPAY = Recordset1.Fields.Item("Currency_WOLRDPAY").Value
    Stripe_Country = Recordset1.Fields.Item("Stripe_Country").Value
    if Currency_STRIPE & "" = "" then
        Currency_STRIPE = "GBP"
    end if
     if Currency_PAYPAL & "" = "" then
        Currency_PAYPAL = "GBP"
    end if
     if Currency_WOLRDPAY & "" = "" then
        Currency_WOLRDPAY = "GBP"
    end if
    
     %>
<div class="form-group">
<label for="document name">USE PAYPAL</label>
<p>Select yes if you would like to offer paypal as a payment option at the checkout.</p>
<input type="radio" name="paypal" value="Yes" <%if paypal="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="paypal" value="No" <%if paypal="No" then%>checked<%end if%>> No 


</div>

<div class="form-group">
<label for="document name">CURRENCY </label>
<p>Enter the currency associated with your paypal account.</p>
<input type="text"   title="Email must contain @." class="form-control" id="Currency_PAYPAL" name="Currency_PAYPAL" value="<%=Currency_PAYPAL%>" >
</div>


<div class="form-group">
<label for="document name">PAYPAL EMAIL </label>
<p>Enter the email address associated with your paypal account.</p>
<input type="text" pattern="\S+@\S+\.\S+"  title="Email must contain @." class="form-control" id="PAYPAL_ADDR" name="PAYPAL_ADDR" value="<%=(Recordset1.Fields.Item("PAYPAL_ADDR").Value)%>" >
</div>


<div class="form-group">
<label for="document name">PAYPAL URL</label>
<p>Enter the URL for your paypal payment gateway.</p>
<input type="text" class="form-control" id="PAYPAL_URL" name="PAYPAL_URL" value="<%=(Recordset1.Fields.Item("PAYPAL_URL").Value)%>" >
</div>
  
<div class="form-group">
<label for="document name">PAYPAL PDT</label> <span class="glyphicon glyphicon-question-sign" aria-hidden="true" data-toggle="popover" data-placement="right" data-content="<a href='https://developer.paypal.com/docs/classic/paypal-payments-standard/integration-guide/paymentdatatransfer/' target='_blank'>Link to paypal PDT link</a>"></span>
<p>Enter your paypal PDT code.</p>
<input type="text" class="form-control" id="PAYPAL_PDT" name="PAYPAL_PDT" value="<%=(Recordset1.Fields.Item("PAYPAL_PDT").Value)%>" >
</div>
      
<br>

Your URL for Paypal IPN is <%=SITE_URL%>payments/paypal/paypal-ipn-new.asp?r=<%=Session("MM_id") %><br>
Your Paypal return URL is <%=SITE_URL%>payments/paypal/Paypal.asp<br>
 </div>
</div>

    
<div class="panel panel-default">
  <div class="panel-heading">NoChex Settings</div>
  <div class="panel-body">





<div class="form-group">
<label for="document name">NoChex</label> 





<% dim nochex : nochex = Recordset1.Fields.Item("nochex").Value
    if nochex & "" = "" then
        nochex ="No"
    end if  %>
<P>Select Yes if you would like to offer NoChex as a payment option at the checkout.</P>
<input type="radio" name="nochex" value="Yes" <%if nochex="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="nochex" value="No" <%if nochex="No" then%>checked<%end if%>> No 


</div>

<div class="form-group">
<label for="document name">NoChex Merchant ID</label>
<p>Enter your NoChex merchant id, this can be found in your nochex control panel.</p>
<input type="text" class="form-control" id="nochexmerchantid" name="nochexmerchantid" value="<%=(Recordset1.Fields.Item("nochexmerchantid").Value)%>">
</div>

  </div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">WorldPay Settings</div>
  <div class="panel-body">
<% dim worldpay : worldpay = Recordset1.Fields.Item("worldpay").Value
  
    if worldpay & "" = "" then
        worldpay="No"
    end if
    
      %>      
<div class="form-group">
<label for="document name">Worldpay</label>
<P>Select Yes if you would like to offer Worldpay as a payment option at the checkout.</P>
<input type="radio" name="worldpay" value="Yes" <%if worldpay="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="worldpay" value="No" <%if worldpay="No" then%>checked<%end if%>> No 


</div>

 <div class="form-group">
<label for="document name">Currency</label>
<p>Enter currency for Worldpay payment.</p>
<input type="text" class="form-control" id="Currency_WOLRDPAY" name="Currency_WOLRDPAY" value="<%=Currency_WOLRDPAY%>">
</div>

<div class="form-group">
<label for="document name">Worldpay Merchant ID</label>
<p>Enter your Worldpay merchant id, this can be found in your Worldpay control panel.</p>
<input type="text" class="form-control" id="worldpaymerchantid" name="worldpaymerchantid" value="<%=(Recordset1.Fields.Item("worldpaymerchantid").Value)%>">
</div>
<div class="form-group">
<label for="document name">Worldpay Installation ID</label>
<p>Enter your Worldpay Installation id, this can be found in your Worldpay control panel.</p>
<input type="text" class="form-control" id="worldpayinstallationid" name="worldpayinstallationid" value="<%=(Recordset1.Fields.Item("worldpayinstallationid").Value)%>">
</div>

<% dim worldpaylive : worldpaylive = Recordset1.Fields.Item("worldpaylive").Value 
    if worldpaylive &"" ="" then
        worldpaylive = 1
    end if  %>
<div class="form-group">
<label for="document name">Worldpay Live/Test</label>
<p>Activate or deactivate the live worldpay system</p>

<input type="radio" name="worldpaylive" value="1" <%if worldpaylive=1 then%>checked<%end if%>> Live &nbsp;&nbsp; <input type="radio" name="worldpaylive" value="0" <%if worldpaylive=0 then%>checked<%end if%>> Test 

</div>

<br>

Your URL for worldpay callback is <%=SITE_URL%>payments/worldpay/worldpay.asp<br><br>

</div>

</div>

<div class="panel panel-default">
    <div class="panel-heading">Stripe Settings</div>
    <div class="panel-body">
        
<%
    dim stripe : stripe = Recordset1.Fields.Item("Stripe").Value
    if stripe & "" = "" then
        stripe="No"
    end if
    
     %>
<div class="form-group">
<label for="document name">Stripe</label>
<P>Select Yes if you would like to offer Stripe as a payment option at the checkout.</P>
<input type="radio" name="stripe" onclick="stripesetting('yes');" value="Yes" <%if stripe="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input onclick="stripesetting('no');" type="radio" name="stripe" value="No" <%if stripe="No" then%>checked<%end if%>> No 


</div>

 <div class="form-group">
<label for="document name">Currency</label>
<p>*Enter currency for Stripe payment.</p>
<input type="text" class="form-control" id="Currency_STRIPE" name="Currency_STRIPE" value="<%=Currency_STRIPE%>" required>
</div>
        
<div class="form-group">
<label for="document name">Strpe Country</label>
<p>*Enter country for Stripe payment. (Ex US,GB.....)</p>
<input type="text" class="form-control" id="Stripe_Country" name="Stripe_Country" value="<%=Stripe_Country%>" required>
</div>
<div class="form-group">
<label for="document name">Stripe Secret Key</label>
<input type="text" class="form-control" id="Stripe_Key_Secret" name="Stripe_Key_Secret" value="<%=(Recordset1.Fields.Item("Stripe_Key_Secret").Value)%>">
</div>

 <div class="form-group">
    <label for="document name">Stripe Publishable key</label>
    <input type="text" class="form-control" id="Stripe_Api_Key" name="Stripe_Api_Key" value="<%=(Recordset1.Fields.Item("Stripe_Api_Key").Value)%>">
</div>

<div class="form-group" id="stripebutton">
    <label for="document name">Enable Payment Request Button (ApplePay, GooglePay, MicrosoftPay) when available</label><br />
    <input type="radio" name="enable_StripePaymentButton" value="Yes" <%if enable_StripePaymentButton="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="enable_StripePaymentButton" value="No" <%if enable_StripePaymentButton="No" then%>checked<%end if%>> No 
</div>
   <script type="text/javascript">
    function stripesetting(values)
    {
        if (values == "no") {

            $("[name=enable_StripePaymentButton]:eq(1)").trigger("click");
            $("#stripebutton").hide();
        }
        else {

            $("#stripebutton").show();
        }
    }
    stripesetting('<%=lcase(enable_StripePaymentButton)%>')
</script>   
<br>

Your URL for stripe callback is <%=SITE_URL%>payments/stripe/stripeprocess.asp<br>
    </div>
</div>

    </div>
<div class="tab-pane fade" id="EmailSetting">
    

<div class="panel panel-default">
  <div class="panel-heading">Email Settings</div>
  <div class="panel-body">


<div class="form-group">
<label for="document name">MAIL FROM</label>
<p>Enter the email address that you would like emails sent from the system to appear to come from.</p>
<input type="text" pattern="\S+@\S+\.\S+"  title="Email address must contain @." class="form-control" id="MAIL_FROM" name="MAIL_FROM" value="<%=(Recordset1.Fields.Item("MAIL_FROM").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">MAIL CUSTOMER SUBJECT</label>
<p>Enter the subject line to be used on emails sent to customer.</p>
<input type="text" class="form-control" id="MAIL_CUSTOMER_SUBJECT" name="MAIL_CUSTOMER_SUBJECT" value="<%=(Recordset1.Fields.Item("MAIL_CUSTOMER_SUBJECT").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">EMAIL SUBJECT</label>
<p>Enter the subject line to be used on emails send to you.</p>
<input type="text" class="form-control" id="MAIL_SUBJECT" name="MAIL_SUBJECT" value="<%=(Recordset1.Fields.Item("MAIL_SUBJECT").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">CONFIRMATION EMAIL ADDRESS</label>
<p>This is the email address to which orders will be sent. This is the email address which will also receive printer failure notifications.</p>
<input type="text" pattern="\S+@\S+\.\S+"  title="Email address must contain @." class="form-control" id="CONFIRMATION_EMAIL_ADDRESS" name="CONFIRMATION_EMAIL_ADDRESS" value="<%=(Recordset1.Fields.Item("CONFIRMATION_EMAIL_ADDRESS").Value)%>" required>
</div>
  
  
<div class="form-group">
<label for="document name">SMTP USERNAME</label>
<p>Enter the SMTP username for your email account - your ISP should be able to provide this.</p>
<input type="text" class="form-control" id="SMTP_USERNAME" name="SMTP_USERNAME" value="<%=(Recordset1.Fields.Item("SMTP_USERNAME").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">SMTP PASSWORD</label>
<p>Enter the SMTP password for your email account - your ISP should be able to provide this.</p>
<input type="text" class="form-control" id="SMTP_PASSWORD" name="SMTP_PASSWORD" value="<%=(Recordset1.Fields.Item("SMTP_PASSWORD").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">SMTP SERVER</label>
<p>Enter the SMTP server for your email account - your ISP should be able to provide this.</p>
<input type="text" class="form-control"  id="SMTP_SERVER" name="SMTP_SERVER" value="<%=(Recordset1.Fields.Item("SMTP_SERVER").Value)%>" required>
</div>

<div class="form-group">
<label for="document name">SMTP PORT</label>
<p>Enter the SMTP port for your email account - your ISP should be able to provide this.</p>
<input type="text" class="form-control" pattern="\d+"  title="SMTP PORT must number" id="SMTP_PORT" name="SMTP_PORT" value="<%=(Recordset1.Fields.Item("SMTP_PORT").Value)%>" required>
</div>


<div class="form-group">
<label for="document name">SMTP USESSL</label>
<p>Tick this box if your email account uses SSL.</p>
<input type="text" class="form-control" id="SMTP_USESSL" name="SMTP_USESSL" value="<%=(Recordset1.Fields.Item("SMTP_USESSL").Value)%>" required>
</div>

<div class="form-group">
    <label for="document name">Test Email</label>
    <p>Please input your email to test.</p>
    <input type="search" class="form-control" spellcheck="false"  autocapitalize="off" autocomplete="off" autocorrect="off" style="width:250px;display:inline" id="txtEmail" name="txtEmail" value="">&nbsp;&nbsp;&nbsp;&nbsp;
    <button type="button" style="background-color: #f0ad4e;border-color: #eea236;" onclick="TestEmail();" class="btn btn-default">Test Email</button>
</div>

</div></div>

  </div>

<div class="tab-pane fade" id="PrinterSetting">
    
<div class="panel panel-default">
  <div class="panel-heading">Printer Settings</div>
  <div class="panel-body">

      <% dim SEND_ORDERS_TO_PRINTER : SEND_ORDERS_TO_PRINTER  = Recordset1.Fields.Item("SEND_ORDERS_TO_PRINTER").Value
          if SEND_ORDERS_TO_PRINTER & "" = "" then
            SEND_ORDERS_TO_PRINTER = "No"
          end if  %>

<div class="form-group">
<label for="document name">SEND ORDERS TO PRINTER</label>
<p>Please select which type of printer you are using.</p>
<input type="radio" name="SEND_ORDERS_TO_PRINTER" onclick="$('[name=printingmethod]').hide();" value="No" <%if SEND_ORDERS_TO_PRINTER="No" then%>checked<%end if%>> No &nbsp;&nbsp; <input type="radio" onclick="    $('[name=printingmethod]').hide();"  name="SEND_ORDERS_TO_PRINTER" value="GC" <%if SEND_ORDERS_TO_PRINTER="GC" then%>checked<%end if%>> GC Printer  &nbsp;&nbsp; <input type="radio" onclick="    $('[name=printingmethod]').hide();" name="SEND_ORDERS_TO_PRINTER" value="IBT" <%if SEND_ORDERS_TO_PRINTER="IBT" then%>checked<%end if%>> IBT Printer   &nbsp;&nbsp; <input type="radio" onclick="    $('[name=printingmethod]').show();" name="SEND_ORDERS_TO_PRINTER" value="EPSON" <%if SEND_ORDERS_TO_PRINTER="EPSON" then%>checked<%end if%>> Epson Printer   &nbsp;&nbsp; <input type="radio" name="SEND_ORDERS_TO_PRINTER" onclick="    $('[name=printingmethod]').show();" value="STAR" <%if SEND_ORDERS_TO_PRINTER="STAR" then%>checked<%end if%>> Star Printer 


</div>



      
      
</div></div>
<div class="panel panel-default">
  <div class="panel-heading">IBT Printer Settings</div>
  <div class="panel-body">
      
<div class="form-group">
<label for="document name">IBT Print API Key</label>
<p>Enter you IBT API key below - this should be shown in your control panel.</p>
<input type="text" class="form-control" id="IBT_API_KEY" name="IBT_API_KEY" value="<%=(Recordset1.Fields.Item("IBT_API_KEY").Value)%>" >
</div>


<div class="form-group">
<label for="document name">IBT Print API Password</label>
<p>Enter you IBT password below - this should be shown in your control panel.</p>
<input type="text" class="form-control" id="IBP_API_PASSWORD" name="IBP_API_PASSWORD" value="<%=(Recordset1.Fields.Item("IBP_API_PASSWORD").Value)%>" >
</div>


      </div></div>
     <% 
        dim stylePrintingType : stylePrintingType =""
        if ucase(Recordset1.Fields.Item("SEND_ORDERS_TO_PRINTER").Value)  <> "EPSON" and ucase(Recordset1.Fields.Item("SEND_ORDERS_TO_PRINTER").Value)  <> "STAR"  then
            stylePrintingType="display:none;"
        end if
         %>
   
   
    <div class="panel panel-default" name="printingmethod" style="<%=stylePrintingType%>">
        <div class="panel-heading">Epson & Star Extra Settings</div>
         <div class="panel-body">

               <div class="form-group">
<label for="document name">SHOW RESTAURANT DETAILS ON RECEIPT  (ONLY for Epson & Star printers)</label>
<p>Remove/include the restaurant details in printer receipts.</p>
<input type="radio" name="ShowRestaurantDetailOnReceipt" value="0" <%if LCase(Recordset1.Fields.Item("ShowRestaurantDetailOnReceipt").Value)="0" then%>checked<%end if%>> Remove &nbsp;&nbsp; <input type="radio" name="ShowRestaurantDetailOnReceipt" value="1" <%if Lcase(Recordset1.Fields.Item("ShowRestaurantDetailOnReceipt").Value)="1" then%>checked<%end if%>> Include


</div>


<div class="form-group">
<label for="document name">FONT SIZE ON PRINTER RECEIPTS (ONLY for Epson & Star printers)</label>
<p>Select printer font size: <input type="text" style="width:35px;" name="PrinterFontSizeRatio" <%if Recordset1.Fields.Item("PrinterFontSizeRatio").Value & "" <> "" then%>value="<%=Recordset1.Fields.Item("PrinterFontSizeRatio").Value %>"<% else %>value="1"<%end if%> />x default font size. Example: 50% less size is "0.5"</p>

</div>

<div class="form-group">
<label for="document name">PRINT SEPARATE RECEIPTS FOR DISH ‘PRINTING NAMES’ (ONLY for Epson & Star printers)</label>
<p style="font-size:13px;">‘Printing Names’ will be printed in a seperate receipt ONLY IF ALL the order items have a ‘printing name’.  Otherwise a single receipt will print out as normal.
<br /><b>EPSON:</b>  In the section ‘EPSON Printer Settings’ below, in the  ‘EPSON printer ID list’ setting enter the name of the printers you want the receipts printed to, and mark the one printing the ‘printing name’  as  PN:[printer_name].  For example if you want the same printer to print the dish name and ‘printing name’ then you can enter the same printer name as follows: local_printer;PN:local_printer
<br /><b>STAR:</b> Just enable this setting and then ensure that you update the printer URL  (see Printer URLs  section).
</p>
<input type="radio" name="IsDualReceiptPrinting" value="0" <%if LCase(Recordset1.Fields.Item("IsDualReceiptPrinting").Value)="0" then%>checked<%end if%>> Disable &nbsp;&nbsp; <input type="radio" name="IsDualReceiptPrinting" value="1" <%if Lcase(Recordset1.Fields.Item("IsDualReceiptPrinting").Value)="1" then%>checked<%end if%>> Enable


</div>

               <div class="form-group">
<label for="document name">PRINTING TYPE</label>
          <% dim printingtype : printingtype =  Recordset1.Fields.Item("printingtype").Value 
             if Recordset1.Fields.Item("printingtype").Value & "" = "" then
                printingtype = "graphic"
             end if 
               %>
                  <p>Select if receipts will be based on Text or Graphics</p>
<input type="radio" name="printingtype" onclick="$('#RePrintReceiptWays').show(); $('[name=print-text]').hide(); $('#idprintxml_v2').show(); $('[name=print-graphic]').show();" value="graphic" <%if printingtype="graphic" then%>checked<%end if%>>
                  <em>Graphics</em> (most reliable - requires own server)&nbsp;&nbsp; <br>
                  <input type="radio" onclick="    $('#RePrintReceiptWays').hide(); $('[name=print-text]').show(); $('#idprintxml_v2').hide(); $('[name=print-graphic]').hide();" name="printingtype" value="text" <%if printingtype="text" then%>checked<%end if%>>
                  <em>Text</em> (fastest - works on any hosting type)&nbsp;&nbsp; 
                </div>

      
      <div class="form-group" id="RePrintReceiptWays">
<label for="document name">Printing Type Methods</label>
                  (server-side queueing) 
                  <% dim RePrintReceiptWays : RePrintReceiptWays =  Recordset1.Fields.Item("RePrintReceiptWays").Value 
             if Recordset1.Fields.Item("RePrintReceiptWays").Value & "" = "" then
                RePrintReceiptWays = "none"
             end if 
               %>
                  <p>Receipts will be printed using these ways, and recreated 
                    in the case of non-creation.</p>
<input type="radio" name="RePrintReceiptWays" value="phantomjs" <%if RePrintReceiptWays="phantomjs" then%>checked<%end if%>>
                  PhantomJS (recommended)&nbsp;&nbsp; <br>
                  <input type="radio" name="RePrintReceiptWays" value="ie" <%if RePrintReceiptWays="ie" then%>checked<%end if%>>
                  Internet Explorer (works on all servers)&nbsp;&nbsp; <br>
                  <input type="radio" name="RePrintReceiptWays" value="plaintext" <%if RePrintReceiptWays="plaintext" then%>checked<%end if%>>
                  Plain Text (queued text-based receipts)&nbsp;&nbsp; <br>
                  <input type="radio" name="RePrintReceiptWays" value="none" <%if RePrintReceiptWays="none" then%>checked<%end if%>>
                  Client Device (uses client device for receipt generation)</div>


         </div>
    </div>
    <div class="panel panel-default">
  <div class="panel-heading">EPSON Printer Settings</div>
  <div class="panel-body">
      
<div class="form-group">
<label for="document name">EPSON printer ID list.</label>
<p>Printer ID is separated by ";". Printer ID MUST not contain "-". Ex: local_printer;local_printer;kitchen_printer;bar_printer</p>
<input type="text" class="form-control" id="PrinterIDList" name="PrinterIDList" value="<%=(Recordset1.Fields.Item("PrinterIDList").Value)%>">
    
</div>
 <div class="form-group">
<label for="document name">In-Store EPSON printer ID list.</label>
<p>Printer ID is separated by ";". Printer ID MUST not contain "-". Ex: local_printer;local_printer;kitchen_printer;bar_printer</p>
<input type="text" class="form-control" id="InRestaurantEpsonPrinterIDList" name="InRestaurantEpsonPrinterIDList" value="<%=(Recordset1.Fields.Item("InRestaurantEpsonPrinterIDList").Value)%>">
    
</div>

<div class="form-group">
<label for="document name">Reset the printer queue.</label>
<p>Hit the "Reset Printer Queue" button to delete all pending for printing receipt in queue.</p>
<input type="button" class="form-control" style="width:150px;" value="Reset Queue" id="btnResetQueueEPSON" >
    <script>
        $("#btnResetQueueEPSON").click(function(){
    $.get("ajax-resetPrintQueue.asp?printer=EPSON", function(data, status){
        if(data == "OK")
            alert("Reset Queue Successfully!");
        else 
            alert("Reset Queue unsuccessfully. Please try to log out then login and try again!");
    });
});

    </script>
</div>
<!--<div class="form-group" style="display:none;">
<label for="document name">EPSON Printer URL  for ‘Dashboard Print-button’.</label>
<p>URL to send print command to ,for EPSON printer. When user hit print button under CMS dashboard. If this URL empty, then system will print as regular print method. Format: http://{PRINTER-IP-ADDRESS}/cgi-bin/epos/service.cgi?devid={PRINTER-ID}&timeout={TIMEOUT}. Ex: http://192.168.192.168/cgi-bin/epos/service.cgi?devid=local_printer&timeout=60000 </p>
<input type="text" class="form-control" id="EPSONJsPrinterURL" name="EPSONJsPrinterURL" value="<%=(Recordset1.Fields.Item("EPSONJsPrinterURL").Value)%>">
    
</div>-->
<div class="form-group">
<label for="document name">Print-button in Dashboards to use Epson printer.</label>
<input type="radio" name="EPSONJsPrinterURL" value="Y" <%if LCase(Recordset1.Fields.Item("EPSONJsPrinterURL").Value &"") <> "" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="EPSONJsPrinterURL" value="" <%if Lcase(Recordset1.Fields.Item("EPSONJsPrinterURL").Value&"")="" then%>checked<%end if%>> No

    
</div>
    
<br />
      <div class="form-group" style="display:none;">
<label for="document name">EPSON Printer URL  for ‘In-Store ordering’</label>
<p>URL to send print command to ,for EPSON printer. When user hit Make Order button under In-Restaurant ordering page. If this URL is empty, then the system will not print the order. Format: http://{PRINTER-IP-ADDRESS}/cgi-bin/epos/service.cgi?devid={PRINTER-ID}&timeout={TIMEOUT}. Ex: http://192.168.192.168/cgi-bin/epos/service.cgi?devid=local_printer&timeout=60000 </p>
<input type="text" class="form-control" id="LocalPrinterURL" name="LocalPrinterURL" value="<%=(Recordset1.Fields.Item("LocalPrinterURL").Value)%>">
    
</div>

    

      </div>

    </div>


    <div class="panel panel-default">
  <div class="panel-heading">Star Printer Settings</div>
  <div class="panel-body">
    
<div class="form-group">
<label for="document name">Reset the printer queue.</label>
<p>Hit the "Reset Printer Queue" button to delete all pending for printing receipt in queue.</p>
<input type="button" class="form-control" style="width:150px;" value="Reset Queue" id="btnResetQueueSTAR" >
    <script>
        $("#btnResetQueueSTAR").click(function(){
    $.get("ajax-resetPrintQueue.asp?printer=STAR", function(data, status){
        if(data == "OK")
            alert("Reset Queue Successfully!");
        else 
            alert("Reset Queue unsuccessfully. Please try to log out then login and try again!");
    });
});

    </script>
</div>
        <div class="form-group">
<label for="document name">Print-button in Dashboards to use Star printer.</label> Yes
          </div>
      </div></div>



<div class="panel panel-default">
  <div class="panel-heading">Printer URLs</div>
  <div class="panel-body">
   
 
	
<strong>Settings for GC Printer</strong><br>
                Your URL for printer orders is: <%=Replace(SITE_URL,Request.ServerVariables("SERVER_NAME"),Request.ServerVariables("LOCAL_ADDR")) %>printers/GC/_printerorders.asp?id=<%= Recordset1.Fields.Item("ID").Value %><br>
                Your URL for printer callback is: <%=Replace(SITE_URL,Request.ServerVariables("SERVER_NAME"),Request.ServerVariables("LOCAL_ADDR")) %>printers/GC/_printerorderscallback.asp<br>
<br>

<strong>Settings for IBT Printer</strong><br>
                Cron job must be set for: <%=SITE_URL%>printers/IBT/_iconnect.asp<br>
<br>


<strong>Settings for Epson Printer</strong><br>
                <span id="idprintxml_v2">Printer must be set to use: <%=SITE_URL%>printers/Epson/printxml_v2.asp?id_r=<%= Recordset1.Fields.Item("ID").Value %><br></span>
<span style="margin-left:178px;" name="print-text"> <%=SITE_URL%>printers/Epson/_printerorders-epson_v2.asp?id_r=<%= Recordset1.Fields.Item("ID").Value %><br>
                </span> <span style="margin-left:178px;" name="print-graphic"> 
                <%=SITE_URL%>printers/Epson/reprintxml_order.asp?id_r=<%= Recordset1.Fields.Item("ID").Value %> 
                (Not for shared hosting)<br>
                </span>
<span style="margin-left:178px;" name="print-text"> <%=SITE_URL%>printers/Epson/_printerorders-epson_v2_local.asp?id_r=<%= Recordset1.Fields.Item("ID").Value %><br></span>
<br>
<script>
   var printingtype =  $("[name=printingtype]:checked").val();
    if(printingtype=="graphic"){
        $("#RePrintReceiptWays").show();
        $("[name=print-text]").hide();
         $("[name=print-graphic]").show();
        $("#idprintxml_v2").show();
    }
    else
    {
        $("#RePrintReceiptWays").hide();
        $("[name=print-text]").show();
        $("[name=print-graphic]").hide();
        $("#idprintxml_v2").hide();
        
    }
    function EnableURLRewrite(mode)
    {
        if(mode=="yes")
        {
            $("#URLRewrite").show();
           // $("#URLRewrite").val($("#Old_s_URLRewrite").val());
            $("#URLRewrite").attr("required","");
        }
        else
        {
            $("#URLRewrite").hide();
           /// $("#URLRewrite").val("");
            $("#URLRewrite").removeAttr("required");
        }
    }
</script>

<strong>Settings for Star Printer</strong><br>
                Printer must be set to use (not for shared hosting): <%=SITE_URL%>printers/Star/StarPrinting.asp?id_r=<%= Recordset1.Fields.Item("ID").Value %>&pt=Y<br>
                For shared hosting use: <%=SITE_URL%>printers/Star/StarPrinting.asp?id_r=<%= Recordset1.Fields.Item("ID").Value %><br>
                <br>

<strong>Settings for AnyPrint </strong><br>
                AnyPrint should use : <%=SITE_URL%>printers/WinformsApp/OrderCome.asp?id_r=<%= Recordset1.Fields.Item("ID").Value %><br>
                Note:  The receipts printed will be based on the contents of the  "EPSON printer ID list" and "In-Store EPSON printer ID list" setting above.
                <br>
</div></div>

 

</div>
<div id="SMSSetting" class="tab-pane fade">

    
<div class="panel panel-default">
  <div class="panel-heading">SMS Settings</div>
  <div class="panel-body">
   <div class="form-group">
<input type="checkbox" name="SMSEnable" <% if Lcase(Recordset1.Fields.Item("SMSEnable").Value) & "" = "1" then %> checked="checked" <% end if %> value="1">  &nbsp;Enable/Disable SMS functionality (Tick to Enable)
   <br />
<input type="checkbox" name="SMSOnDelivery" <% if Lcase(Recordset1.Fields.Item("SMSOnDelivery").Value) & "" = "1" then %> checked="checked" <% end if %> value="1"> &nbsp;Enable/Disable whether “Out for delivery” button in back-end Dashboards send an SMS or not. (Tick to Enable)
<br />
<input type="checkbox" name="SMSOnAcknowledgement" <% if Lcase(Recordset1.Fields.Item("SMSOnAcknowledgement").Value) & "" = "1" then %> checked="checked" <% end if %> value="1"> &nbsp;Enable/Disable whether “Acknowledgement” button in back-end Dashboards send an SMS or not. (Tick to Enable)
<br />
<br />
<label for="document name">SMS supplier’s domain</label>
<p>Eg: @domain.com including the @ symbol</p>
<input type="text" class="form-control" id="SMSSupplierDomain" name="SMSSupplierDomain" value="<%=(Recordset1.Fields.Item("SMSSupplierDomain").Value)%>">
 <br />
<label for="document name">Default SMS country code</label>
 <p> Eg. 84 for Vietnam, 44 for the UK This is derived from the country tel.no. code: +84 and +44 respectively.</p>
<input type="text" pattern="\d+"  title="Default SMS country code must be number" class="form-control" id="DefaultSMSCountryCode" name="DefaultSMSCountryCode" value="<%=(Recordset1.Fields.Item("DefaultSMSCountryCode").Value)%>" required>
 <br />
   <div class="panel panel-default">
  <div class="panel-heading">Send SMS after order is made</div>
  <div class="panel-body">
   <div class="form-group">
<input type="checkbox" name="SMSOnOrder" <% if Lcase(Recordset1.Fields.Item("SMSOnOrder").Value) & "" = "1" then %> checked="checked" <% end if %> value="1">  &nbsp;Enable/Disable SMS after order is made (Tick to Enable)
<br />
<br />
<label for="document name">Send SMS [x] minutes after an order is made</label><br> 
<p> (Please ensure that you use a cron-job service such as setcronjob.com and point it to URL <%=SITE_URL %>cms/sendsmsjob.asp?id_r=<%= Session("MM_id") %> every 1-5 minutes or as often as you like)</p>
<input type="text" pattern="\d+"  title="This field must be number"  class="form-control" id="SMSOnOrderAfterMin" name="SMSOnOrderAfterMin" value="<% If (Recordset1.Fields.Item("SMSOnOrderAfterMin").Value) & "" <> "" Then%><%=Recordset1.Fields.Item("SMSOnOrderAfterMin").Value %><% else %>0<%end if %>" required>
<br />
<label for="document name">SMS message content</label><br> 
<p>SMS message to send after order is made.</p>
<textarea class="form-control" name="SMSOnOrderContent"><%=(Recordset1.Fields.Item("SMSOnOrderContent").Value)%></textarea> 
       </div>
      </div>
       </div>
</div>


</div></div>

</div>

    <div class="tab-pane fade" id="TrackingSetting">
        
<div class="panel panel-default">
  <div class="panel-heading">Bringg Settings</div>
  <div class="panel-body">



<% dim bringg : bringg = Recordset1.Fields.Item("bringg").Value 
    if bringg & "" = "" then
        bringg = "No"
    end if  %>

<div class="form-group">
<label for="document name">Bringg </label>
<p>If you would like to link to your Bringg account select Yes below.</p>
<input type="radio" name="bringg" value="Yes" <%if bringg="Yes" then%>checked<%end if%>> Yes &nbsp;&nbsp; <input type="radio" name="bringg" value="No" <%if bringg="No" then%>checked<%end if%>> No 


</div>

<div class="form-group">
<label for="document name">Bringg URL</label>
<input type="text" class="form-control" id="bringgurl" name="bringgurl" value="<%=(Recordset1.Fields.Item("bringgurl").Value)%>" >
</div>

<div class="form-group">
<label for="document name">Bringg Company id</label>
<input type="text" class="form-control" id="bringgcompanyid" name="bringgcompanyid" value="<%=(Recordset1.Fields.Item("bringgcompanyid").Value)%>" >
</div>


</div></div>

    </div>
    </div>
  
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%= Recordset1.Fields.Item("ID").Value %>">
  <button type="submit" class="btn btn-default">Submit</button>
</form>



		</div>
	</div>

      
</div>



<!-- Modal -->
 
<% 
    Recordset1.close()
    set Recordset1 = nothing
   ' Recordset1_cmd.close()
    'set Recordset1_cmd = nothing
     Recordset1_cmd.ActiveConnection.Close
    set Recordset1_cmd = nothing
     %>
<script>
$(function () {
  $('[data-toggle="popover"]').popover({html:true})
})
    function validateEmail(email) 
    {
        var re = /\S+@\S+\.\S+/;
        return re.test(email);
    }
    function TestEmail()
    {
        if(validateEmail($("#txtEmail").val() ))
        {

             $.post("ajxTestEmail.asp?r" + Math.random(), { Email: $("#txtEmail").val(), SMTP_SERVER:$("[name=SMTP_SERVER]").val(), SMTP_PORT:$("[name=SMTP_PORT]").val(),SMTP_USERNAME:$("[name=SMTP_USERNAME]").val(), SMTP_PASSWORD: $("[name=SMTP_PASSWORD]").val(),SMTP_USESSL:$("[name=SMTP_USESSL]").val(),MAIL_FROM:$("[name=MAIL_FROM]").val()},
             function(data,status){
                    if(data.indexOf("Error")>-1)
                        alert(data);
                    else
                        alert("Sending Succesful");
                });

            
        }else
        {
           alert("Email is invalid!");
        }
        
    }
</script>


</body>
</html>
