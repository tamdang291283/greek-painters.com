<%
   Dim IE
Dim MyDocument

Set IE = CreateObject("InternetExplorer.Application")

IE.Visible = 0

IE.navigate "www.greek-painters.com/vo/food/7-2-Dang/test/serverbrowse/write-file.asp"
'greek-painters.com/vo/food/7-2-Dang/test/serverbrowse/write-file.asp

While IE.ReadyState <> 4 : WScript.Sleep 100 : Wend


If ie.Document Is Nothing Then 'Error thrown here
MsgBox "Can't get here"
End If

set IE = nothing

%>