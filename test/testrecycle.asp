<% Option Explicit %>
<%
       Response.Write("Session " & Session("vartime") )

    Session("vartime")="testing "
     Const FILE_PATH="C:\Inetpub\vhosts\greek-painters.com\httpdocs\vo\food\7-4-Dang\web.config"
     '' Const FILE_PATH="D:\OutSource\v7-2\web.config"
            Dim objFSo, objFile, strData
            Set objFSO = Server.CreateObject("Scripting.FileSystemObject")         
            Set objFile = objFSO.OpenTextFile(FILE_PATH)
            strData = objFile.ReadAll
            objFile.Close
     
            Set objFile = objFSO.CreateTextFile(FILE_PATH)
            objFile.Write(strData)
            objFile.Close
          
            Set objFile = Nothing
            Set objFSO = Nothing

     %>