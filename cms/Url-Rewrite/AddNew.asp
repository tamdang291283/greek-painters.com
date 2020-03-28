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
    dim sourceURL : sourceURL = Request.QueryString("srcurl") & ""
    dim resultURL : resultURL = Request.QueryString("resulturl") & ""
    resultURL  = ReplaceSpecialCharacterURL(resultURL)
    ' check srcurl and resulturl exist or not 
    Dim objCon
    Set objCon = Server.CreateObject("ADODB.Connection")
        objCon.Open sConnStringcms
    Dim RS_URLRewrite :  set RS_URLRewrite = Server.CreateObject("ADODB.Recordset")
    Dim SQL : SQL = " select top 1 1 from URL_REWRITE where fromlink='" &resultURL& "' or tolink ='" & sourceURL &  "' "  
      RS_URLRewrite.open  SQL ,objCon
      if not RS_URLRewrite.EOF then
  
          Response.Write("EXIST")
      else
            dim ResID : ResID = 0
            if instr(sourceURL,"?") > 0 then
               ResID     =  left(lcase(sourceURL),instr(sourceURL,"?"))
               ResID =  replace(sourceURL,ResID,"")
               ResID = replace(ResID,"id_r=","")
               if ResID & "" = "" then
                    ResID = 0
               end if
               if not IsNumeric(ResID) then
                   ResID = 0 
               end if
            end if 
            objCon.execute("Insert into URL_REWRITE(tolink,fromlink,RestaurantID,status) values('" &sourceURL& "','" & SITE_URL&resultURL & "'," & ResID  &",'ACTIVE') ")

          Response.Write("OK")
      end if
        RS_URLRewrite.close()
    set RS_URLRewrite = nothing

        objCon.close()
    set objCon = nothing
    Response.End
     %>