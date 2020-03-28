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
    dim srcurl : srcurl = Request.QueryString("srcurl") & "" 
    dim resulturl : resulturl = Request.QueryString("resulturl") & "" 
    resultURL  = ReplaceSpecialCharacterURL(resultURL)
    dim ID : ID  = Request.QueryString("ID")
    dim status : status  = Request.QueryString("status")
  
    if ID & "" <> "" then
        if IsNumeric(ID) then
            Dim objCon
            Set objCon = Server.CreateObject("ADODB.Connection")
                objCon.Open sConnStringcms
                resulturl = replace(resulturl,SITE_URL,"")
                 dim ResID : ResID = 0
                if instr(srcurl,"?") > 0 then
                   ResID     =  left(lcase(srcurl),instr(srcurl,"?"))
                   ResID =  replace(srcurl,ResID,"")
                   ResID = replace(ResID,"id_r=","")
                   if ResID & "" = "" then
                        ResID = 0
                   end if
                   if not IsNumeric(ResID) then
                       ResID = 0 
                   end if
                end if 
                if status <> "DELETED" then
                    objCon.execute(" update URL_REWRITE set fromlink='" &SITE_URL &  resulturl & "', tolink='" &srcurl&  "',status='" & status & "',RestaurantID=" & ResID & " where ID  = " & ID)
                else
                    objCon.execute(" delete from  URL_REWRITE where ID  = " & ID)        
                end if
                    objCon.close()
                set objCon =  nothing
                Response.Write("OK")
                Response.End
        end if
    end if
     Response.Write("FAIL")
     Response.End
     %>