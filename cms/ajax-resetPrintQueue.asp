<!-- #include file="../../Config.asp" --> 
<% 
      
     If Session("MM_id") & "" <> "" AND Request.QueryString("printer") & "" <> "" Then

            
          Dim objFSO, rID
          Set objFSO=CreateObject("Scripting.FileSystemObject")
          rID = Session("MM_id")
          
          Dim imgFolder, fo, objFile, strContent, printingFolder, pfo, isPrinting

          If UCase( Request.QueryString("printer")  & "" ) = "EPSON" Then
              imgFolder = Server.MapPath("..\..\printers\epson\ReceiptImage\")
              printingFolder = Server.MapPath("..\..\printers\epson\ReceiptImage\Printing\")

              set pfo = objFSO.GetFolder(imgFolder)
              for each f in pfo.files
                If InStr(f.Name, rID & "-") = 1 Then
                    objFSO.DeleteFile imgFolder & "/" & f.Name , true
                End If
              Next

              Set pfo = nothing
              set pfo = objFSO.GetFolder(printingFolder)
              for each f in pfo.files
                If InStr(f.Name, rID & "-") = 1 Then
                    objFSO.DeleteFile printingFolder & "/" & f.Name , true
                End IF
              Next
          ElseIf  UCase( Request.QueryString("printer")  & "" ) = "STAR" Then
              imgFolder = Server.MapPath("..\..\printers\star\ReceiptImage\")
              printingFolder = Server.MapPath("..\..\printers\star\ReceiptImage\Printing\")

              set pfo = objFSO.GetFolder(imgFolder)
              for each f in pfo.files
                If InStr(f.Name, rID & "-") = 1 Then
                    objFSO.DeleteFile imgFolder & "/" & f.Name , true
                End If
              Next

              Set pfo = nothing
              set pfo = objFSO.GetFolder(printingFolder)
              for each f in pfo.files
                If InStr(f.Name, rID & "-") = 1 Then
                    objFSO.DeleteFile printingFolder & "/" & f.Name , true
                End IF
              Next
          End If
          set pfo = nothing

          Dim objCon2
          Set objCon2 = Server.CreateObject("ADODB.Connection")
          objCon2.Open sConnStringcms
          objCon2.Execute " Update [Orders] set [printed] = 1 where [printed] = false and  (paymenttype='Stripe-Paid' or paymenttype='Paypal-Paid' or paymenttype='NoChex-Paid' or paymenttype='Worldpay-Paid'  or paymenttype='Cash on Delivery' or payment_status  = 'Paid' ) AND [IdBusinessDetail] = " & rID
          objCon2.Close()
          set objCon2 = nothing
          Response.Write("OK")
     Else 
        Response.Write("-1")
    End If
 %>