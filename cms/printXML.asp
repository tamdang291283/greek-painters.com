<% 
    
    
    Dim PhantomPath, ScriptPath
    PhantomPath = Server.MapPath("/vo/food/V7-1/cms/ptjs/phantomjs.exe")
    ScriptPath = Server.MapPath("/vo/food/V7-1/cms/ptjs/webtobase64.js")

    Response.Write("PhantomPath:" & PhantomPath)
    Response.Write("ScriptPath:" & ScriptPath)
   ' Response.End()
    Dim filename, fileLocation
    fileLocation = Server.MapPath("/vo/food/V7-1/cms/temp/")
    strSafeDate = DatePart("yyyy",Date) & Right("0" & DatePart("m",Date), 2) & Right("0" & DatePart("d",Date), 2)
 
    strSafeTime = Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2) & Right("0" & Second(Now), 2) 

    filename = strSafeDate & "-" & strSafeTime
    filename = fileLocation & filename & ".txt"
    Response.Write("<br /> FileName:"&  filename)
    Dim WshShell 
    Set WshShell = CreateObject("WScript.Shell") 
   WshShell.Run PhantomPath 
    WshShell.Run PhantomPath & " " & ScriptPath & " http://www.greek-painters.com/vo/food/V7-1/cms/print_t.asp?id_o=565&id_r=2 " & filename  ,5,true
    
    set WshShell = nothing

    Dim MyFile,fso, s_content, height, width
    Set fso = CreateObject("Scripting.FileSystemObject")

  ' Open the file for input.
    Set MyFile = fso.OpenTextFile(FileName, 1) ' 1: for reading , 2: writing, 8: appending
    s_content = ""
    Dim c
    c = 0
    ' Read from the file and display the results.
    Do While MyFile.AtEndOfStream <> True AND c < 3
        If c = 0 then
            height = MyFile.ReadLine
        elseif c = 1 then
            width = MyFile.ReadLine
        else
            s_content = MyFile.ReadLine
        End if       
        c = c + 1
    Loop
    
    MyFile.Close
    Set MyFile = nothing
    fso.DeleteFile filename,true
    set fso = nothing

    Dim sXML
    sXML = "<epos-print xmlns=""http://www.epson-pos.com/schemas/2011/03/epos-print"">"
    sXML =sXML & "<image width=""" & width & """ height=""" & height & """ color=""color_1"" mode=""mono"">" & s_content & "</image>"
    sXML =sXML & "</epos-print>"
    Response.Clear()
    Response.AddHeader "Content-Type","text/xml"
    Response.Write(sXML)
 %>