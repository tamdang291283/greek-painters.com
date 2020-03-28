<%session("restaurantid")=Request.QueryString("id_r")%>
<!-- #include file="../Config.asp" -->
<%

    
Function URLDecode(ByVal What)
'URL decode Function
'2001 Antonin Foller, PSTRUH Software, http://www.motobit.com
  Dim Pos, pPos

  'replace + To Space
  What = Replace(What, "+", " ")

  on error resume Next
  Dim Stream: Set Stream = CreateObject("ADODB.Stream")
  If err = 0 Then 'URLDecode using ADODB.Stream, If possible
    on error goto 0
    Stream.Type = 2 'String
    Stream.Open

    'replace all %XX To character
    Pos = InStr(1, What, "%")
    pPos = 1
    Do While Pos > 0
      Stream.WriteText Mid(What, pPos, Pos - pPos) + _
        Chr(CLng("&H" & Mid(What, Pos + 1, 2)))
      pPos = Pos + 3
      Pos = InStr(pPos, What, "%")
    Loop
    Stream.WriteText Mid(What, pPos)

    'Read the text stream
    Stream.Position = 0
    URLDecode = Stream.ReadText

    'Free resources
    Stream.Close
  Else 'URL decode using string concentation
    on error goto 0
    'UfUf, this is a little slow method. 
    'Do Not use it For data length over 100k
    Pos = InStr(1, What, "%")
    Do While Pos>0 
      What = Left(What, Pos-1) + _
        Chr(Clng("&H" & Mid(What, Pos+1, 2))) + _
        Mid(What, Pos+3)
      Pos = InStr(Pos+1, What, "%")
    Loop
    URLDecode = What
  End If
End Function

    Set objConconfig = Server.CreateObject("ADODB.Connection")
    Set objRdsconfig = Server.CreateObject("ADODB.Recordset") 
    objConconfig.Open sConnString
    objRdsconfig.Open "SELECT *  FROM BusinessDetails  WHERE Id = " & session("restaurantid"), objConconfig
    if not objRdsconfig.eof then
        Response.Write("IP FROM DataBase " & objRdsconfig("BlockIPEmailList") & "<br/>")
        Response.Write("IP from Customer " & Request.ServerVariables("REMOTE_ADDR") & "<br/>")
        Response.Write("Email cookie " &  Lcase( URLDecode(Request.Cookies("Email"))) & "<br/>")
        if LCase(objRdsconfig("BlockIPEmailList") & "") <> "" then
            dim isCompare : isCompare =     Instr(";" &LCase(objRdsconfig("BlockIPEmailList") & "") & ";",";" & Request.ServerVariables("REMOTE_ADDR") & ";") > 0 OR Instr(";" &LCase(objRdsconfig("BlockIPEmailList")) & ";",";" & Lcase( URLDecode(Request.Cookies("Email"))  ) & ";") > 0 
        'Response.Write("Compare result " & isCompare & "<br/>")
            if isCompare then
            
                Response.Write("IP matches - BLOCKED <br/>")
            else
                Response.Write("Not Matched <br/>")
            end if
        else
                 Response.Write("Not Matched <br/>")
        end if
    end if
    objRdsconfig.close()
    set objRdsconfig = nothing
        objConconfig.close()
    set objConconfig = nothing
     %>