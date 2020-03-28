<%
   Dim CurrentURL, CurrentFilename

   If UCase(Request.ServerVariables("HTTPS")) = "ON" Then
        CurrentURL = "https://" & Request.ServerVariables("SERVER_NAME")  &  Request.ServerVariables("URL") 
    Else
        CurrentURL = "http://" & Request.ServerVariables("SERVER_NAME")  &  Request.ServerVariables("URL") 
    End If

    CurrentFilename = Right(CurrentURL, Len(CurrentURL) - InstrRev(CurrentURL,"/"))
    Response.Write(CurrentURL)
    Response.Write("<br />" & CurrentFilename)
    Response.end()
     %>


<!-- #include file="Config.asp" -->
<!-- #include file="timezone.asp" -->
<!-- #include file="restaurantsettings.asp" -->

<% response.Write(houroffset) %>