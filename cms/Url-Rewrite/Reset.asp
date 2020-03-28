<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->

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
        
        result =  ReplaceSpecialCharacterURL(result)
        result = replace(result,"--","-")
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
    Dim objCon
    Set objCon = Server.CreateObject("ADODB.Connection")
        objCon.Open sConnStringcms
   
    objCon.execute("Delete from URL_REWRITE ")

    objCon.execute("Update businessdetails set EnableUrlRewrite='Yes' ")

    Dim RS_Business :  set RS_Business = Server.CreateObject("ADODB.Recordset")
    Dim SQL : SQL = " select ID,Name,PostalCode,Telephone from businessdetails "  
     RS_Business.open  SQL ,objCon
    while not RS_Business.EOF 
        Dim menuURL,checkURL,thankURL 
            menuURL = BuiltUrl(RS_Business("Name"),RS_Business("PostalCode"),RS_Business("Telephone"),"menu.asp")
            objCon.execute("Insert into URL_REWRITE(tolink,fromlink,RestaurantID,status) values('menu.asp?id_r=" & RS_Business("ID") & "','" & menuURL & "'," & RS_Business("ID")  &",'ACTIVE') ")

             checkURL = BuiltUrl(RS_Business("Name"),RS_Business("PostalCode"),RS_Business("Telephone"),"checkout.asp")
            objCon.execute("Insert into URL_REWRITE(tolink,fromlink,RestaurantID,status) values('checkout.asp?id_r=" & RS_Business("ID") & "','" & checkURL & "'," & RS_Business("ID")  &",'ACTIVE') ")
            
            thankURL = BuiltUrl(RS_Business("Name"),RS_Business("PostalCode"),RS_Business("Telephone"),"thanks.asp")
            objCon.execute("Insert into URL_REWRITE(tolink,fromlink,RestaurantID,status) values('thanks.asp?id_r=" & RS_Business("ID") & "','" & thankURL & "'," & RS_Business("ID")  &",'ACTIVE') ")

        RS_Business.movenext()
    wend
        RS_Business.close()
    set RS_Business = nothing

        objCon.close()
    set objCon = nothing
  
     Response.Write("OK")
     Response.End
     %>