<!DOCTYPE html>
<html>
<head>
    <title></title>
	<meta charset="utf-8" />
</head>
<body>
<%

   

	Dim lineData
		Set fso = Server.CreateObject("Scripting.FileSystemObject") 
		

		   Dim logobjFSO, logFile
           'set logobjFSO = CreateObject("Scripting.FileSystemObject")
           'set logFile = logobjFSO.OpenTextFile(Server.MapPath("/printers/epson/EpsonPostTextV2.xml"),8,true) ' 8 is for appending
           'logFile.WriteLine(scontent)
			set fso = nothing 
			set fs = nothing
			
			
	 Dim tXMLDoc, joborderid , isprinted
        isprinted = true
	set tXMLDoc =Server.createObject("MSXML2.DomDocument")
        tXMLDoc.validateOnParse = False
        tXMLDoc.async = False
        'tXMLDoc.setProperty "ServerHTTPRequest", true	
    Response.Write(Server.MapPath("printerresponse.xml"))
        tXMLDoc.load( Server.MapPath("printerresponse.xml") )  
		set logFile = nothing
		'if logobjFSO.FileExists(Server.MapPath("/printers/epson/EpsonPostTextV2.xml")) then
		 ' logobjFSO.DeleteFile(Server.MapPath("/printers/epson/EpsonPostTextV2.xml"))
		'end if		 
        set logobjFSO = nothing

    set nodes = tXMLDoc.selectNodes("//ePOSPrint")    
         Response.Write("nodes.length  " & nodes.length  & "<br/>")
        for i = 0 to nodes.length -1
            dim  devid : devid  =  nodes.item(i).selectNodes("//devid").item(0).text
            dim  jobid : jobid  =  nodes.item(i).selectNodes("//printjobid").item(0).text
                    joborderid = split(jobid,"-")(1)
            set responseattribute =  nodes.item(i).selectNodes("//response")
            dim text1 : text1 =   responseattribute.item(0).getAttribute("success")
          
            response.write("ok " & text1 & "<br/>")
        next

    set tXMLDoc = nothing
		
		

%>
</body>
</html>
