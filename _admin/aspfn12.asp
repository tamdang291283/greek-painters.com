<%

' ------------------------------------------
'  ASPMaker 12 Common classes and functions
' (C) 2001-2014 e.World Technology Limited. All rights reserved.
'
' Check ServerXMLHTTP / ASP.NET / Write Permission
Sub ew_CheckServer(ScriptName)
	On Error Resume Next
	Dim XmlHttp, Data
	Err.Clear
	Set XmlHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
	If Err.Number <> 0 Then
		If IsEmpty(gASPNETMessage) Then
			gASPNETMessage = "Warning: MSXML2.ServerXMLHTTP is required but it is not available on this server."
			If IsObject(Page) Then
				Page.FailureMessage = gASPNETMessage
			Else
				Response.Write "<div class=""alert alert-error ewAlert"" style=""display: table;""><button type=""button"" class=""close"" data-dismiss=""alert"">&times;</button><div>" & gASPNETMessage & "</div></div>"
			End If
		End If
	Else
		XmlHttp.Open "POST", ew_ConvertFullUrl(ScriptName), False
		XmlHttp.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"

		' Test if ASP.NET page set up correctly first
		Data = "t=1"
		XmlHttp.Send Data
		If XmlHttp.ResponseText <> "OK" Then
			If IsEmpty(gASPNETMessage) Then
				gASPNETMessage = "Warning: ASP.NET 2.0 or later is required but ASP.NET script is not executed properly on this server:<br><br><iframe class=""ewIframe"" width=""800"" src=""" & ScriptName & """></iframe>"
				If IsObject(Page) Then
					Page.FailureMessage = gASPNETMessage
				Else
					Response.Write "<div class=""alert alert-error ewAlert"" style=""display: table;""><button type=""button"" class=""close"" data-dismiss=""alert"">&times;</button><div>" & gASPNETMessage & "</div></div>"
				End If
			End If
		End If
	End If
	Set XmlHttp = Nothing
	Dim fso, folder, tmpfile, tmpcontent
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	tmpfile = "readme.txt"
	tmpcontent = "Important: This folder is used as the root folder of temporary folders for file upload fields during Add/Edit. It is also used as the root folder of the user files folder of CKEditor." & vbCrLf & vbCrLf & _
		"Make sure that the Web server user have read/write access to this folder." & vbCrLf & vbCrLf & _
		"See ASP Settings -> General Options -> File Upload in the help file for detail."
	folder = ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH)
	If Not fso.FileExists(folder & tmpfile) Then
		If Not ew_SaveFile(folder, tmpfile, tmpcontent) Then
			If IsEmpty(gWritePermissionMessage) Then
				gWritePermissionMessage = "Warning: Write Permission is not set up for folder '" & ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH) & "'"
				If IsObject(Page) Then
					Page.FailureMessage = gWritePermissionMessage
				Else
					Response.Write "<div class=""alert alert-error ewAlert"" style=""display: table;""><button type=""button"" class=""close"" data-dismiss=""alert"">&times;</button><div>" & gWritePermissionMessage & "</div></div>"
				End If
			End If
		End If
	End If
	Set fso = Nothing
End Sub

' ---------------------------------
'  Custom Associative Array class
'
Class cCustomArray
	Dim CustomArray

	' Class Initialize
	Private Sub Class_Initialize()
		Clear()
	End Sub

	Public Sub Clear()
		CustomArray = Array() ' Clear array
	End Sub

	Public Function Exists(Name)
		Dim i, nam
		nam = Trim(Name)
		If nam <> "" Then
			For i = 0 to UBound(CustomArray)
				If LCase(CustomArray(i)(0)) = LCase(nam) Then
					Exists = True
					Exit Function
				End If
			Next
		End If
		Exists = False
	End Function

	Public Function Item(Name)
		Dim i, nam
		nam = Trim(Name)
		If nam <> "" Then
			For i = 0 to UBound(CustomArray)
				If LCase(CustomArray(i)(0)) = LCase(nam) Then
					Item = CustomArray(i)(1)
					Exit Function
				End If
			Next
		End If
		Item = ""
	End Function

	' Add Name/Value pair
	Public Sub Add(Name, Value)
		If Not UpdateItem(Name, Value) Then
			AddItem Name, Value
		End If
	End Sub

	' Update item
	Private Function UpdateItem(Name, Value)
		Dim i, nam, val
		nam = Trim(Name)
		val = Value
		If nam <> "" And val <> "" Then
			For i = 0 to UBound(CustomArray)
				If LCase(CustomArray(i)(0)) = LCase(nam) Then
					CustomArray(i)(1) = val
					UpdateItem = True
					Exit Function
				End If
			Next
		End If
		UpdateItem = False
	End Function

	' Add item to array
	Private Function AddItem(Name, Value)
		Dim nam, val
		nam = Trim(Name)
		val = Value
		If nam <> "" And val <> "" Then
			If Ubound(CustomArray) < 0 Then
				ReDim CustomArray(0)
			Else
				ReDim Preserve CustomArray(UBound(CustomArray)+1)
			End If
			CustomArray(UBound(CustomArray)) = Array(nam, val)
		End If
	End Function
End Class

' -----------------------
'  Attributes class
'
Class cAttributes
	Dim Attributes

	' Class Initialize
	Private Sub Class_Initialize()
		Clear()
	End Sub

	Public Sub Clear()
		Attributes = Array() ' Clear attributes
	End Sub

	Public Function Exists(Attr)
		Dim i, att
		att = Trim(Attr)
		If att <> "" Then
			For i = 0 to UBound(Attributes)
				If LCase(Attributes(i)(0)) = LCase(att) Then
					Exists = True
					Exit Function
				End If
			Next
		End If
		Exists = False
	End Function

	Public Function Item(Attr)
		Dim i, att
		att = Trim(Attr)
		If att <> "" Then
			For i = 0 to UBound(Attributes)
				If LCase(Attributes(i)(0)) = LCase(att) Then
					Item = Attributes(i)(1)
					Exit Function
				End If
			Next
		End If
		Item = ""
	End Function

	' Add attributes
	Public Sub AddAttributes(Attrs)
		Dim i
		If IsArray(Attrs) Then
			For i = 0 to UBound(Attrs)
				If IsArray(Attrs(i)) Then
					If UBound(Attrs(i)) >= 1 Then
						AddAttribute Attrs(i)(0), Attrs(i)(1), True
					End If
				End If
			Next
		End If
	End Sub

	' Add attribute
	Public Sub AddAttribute(Attr, Value, Append)
		Dim opt
		opt = ew_IIf(Append, "a", "p") ' Append / Prepend
		If Not UpdateAttr(Attr, Value, opt) Then
			AddAttr Attr, Value
		End If
	End Sub

	' Update attribute
	Public Sub UpdateAttribute(Attr, Value)
		If Not UpdateAttr(Attr, Value, "u")  Then ' Update the attribute
			AddAttr Attr, Value
		End If
	End Sub

	' Append attribute
	Public Sub Append(Attr, Value)
		AddAttribute Attr, Value, True
	End Sub

	' Prepend attribute
	Public Sub Prepend(Attr, Value)
		AddAttribute Attr, Value, False
	End Sub

	' Update attribute based on option
	Private Function UpdateAttr(Attr, Value, Opt)
		Dim i, att, val
		att = Trim(Attr)
		val = Value
		If att <> "" And val <> "" Then
			For i = 0 to UBound(Attributes)
				If LCase(Attributes(i)(0)) = LCase(att) Then
					If Opt = "a" Then ' Append
						Attributes(i)(1) = Attributes(i)(1) & " " & val
					ElseIf Opt = "p" Then ' Prepend
						Attributes(i)(1) = val & " " & Attributes(i)(1)
					Else ' Assume update
						Attributes(i)(1) = val
					End If
					UpdateAttr = True
					Exit Function
				End If
			Next
		End If
		UpdateAttr = False
	End Function

	' Add attribute to array
	Private Function AddAttr(Attr, Value)
		Dim att, val
		att = Trim(Attr)
		val = Value
		If att <> "" And val <> "" Then
			If Ubound(Attributes) < 0 Then
				ReDim Attributes(0)
			Else
				ReDim Preserve Attributes(UBound(Attributes)+1)
			End If
			Attributes(UBound(Attributes)) = Array(att, val)
		End If
	End Function
End Class

' -----------------------
'  Export document class
'
Class cExportDocument
	Dim Table
	Dim Text
	Dim Line
	Dim Header
	Dim Style ' "v"(Vertical) or "h"(Horizontal)
	Dim Horizontal ' Horizontal
	Dim RowCnt
	Dim FldCnt
	Dim ExportCustom

	' Class Initialize
	Private Sub Class_Initialize()
		Text = ""
		Line = ""
		Header = ""
		Style = "h"
		Horizontal = True
		RowCnt = 0
		FldCnt = 0
		ExportCustom = False
	End Sub

	Public Sub ChangeStyle(ToStyle)
		If LCase(ToStyle) = "v" Or LCase(ToStyle) = "h" Then
			Style = LCase(ToStyle)
		End If
		Horizontal = (Table.Export <> "xml" And (Style <> "v" Or Table.Export = "csv"))
	End Sub

	' Table Header
	Public Sub ExportTableHeader()
		Select Case Table.Export
			Case "html", "email", "word", "excel"
				Text = Text & "<table class=""ewExportTable"">"
			Case "csv"

				' No action
			Case "pdf"
				Text = Text & "<table class=""ewTablePdf"">"
		End Select
	End Sub

	' Field Caption
	Public Sub ExportCaption(fld)
		FldCnt = FldCnt + 1
		Call ExportValueEx(fld, fld.ExportCaption)
	End Sub

	' Field value
	Public Sub ExportValue(fld)
		Call ExportValueEx(fld, fld.ExportValue(Table.Export))
	End Sub

	' Field aggregate
	Public Sub ExportAggregate(fld, typ)
		FldCnt = FldCnt + 1
		If Horizontal Then
			Dim val
			val = ""
			If typ = "TOTAL" Or typ = "COUNT" Or typ = "AVERAGE" Then
				val = Language.Phrase(typ) & ": " & fld.ExportValue(Table.Export)
			End If
			Call ExportValueEx(fld, val)
		End If
	End Sub

	' Export a value (caption, field value, or aggregate)
	Public Sub ExportValueEx(fld, val)
		Select Case Table.Export
			Case "html", "email", "word", "excel", "pdf"
				Text = Text & "<td" & ew_IIf(EW_EXPORT_CSS_STYLES, fld.CellStyles, "") & ">"
				If Table.Export = "excel" And fld.FldDataType = EW_DATATYPE_STRING And IsNumeric(val) Then
					Text = Text & "=""" & val & """"
				Else
					Text = Text & val
				End If
				Text = Text & "</td>"
				If Table.Export = "pdf" Then
					Line = Line & Text
				End If
			Case "csv"
				If fld.FldDataType <> EW_DATATYPE_BLOB Then
					If Line <> "" Then Line = Line & ","
					Line = Line & """" & Replace(val & "", """", """""") & """"
				End If
		End Select
	End Sub

	' Begin a row
	Public Sub BeginExportRow(cnt)
		RowCnt = RowCnt + 1
		FldCnt = 0
		If Horizontal Then
			Select Case Table.Export
				Case "html", "email", "word", "excel"
					If cnt = -1 Then
						Table.CssClass = "ewExportTableFooter"
					ElseIf cnt = 0 Then
						Table.CssClass = "ewExportTableHeader"
					Else
						Table.CssClass = ew_IIf(cnt Mod 2 = 1, "ewExportTableRow", "ewExportTableAltRow")
					End If
					Text = Text & "<tr" & ew_IIf(EW_EXPORT_CSS_STYLES, Table.RowStyles, "") & ">"
				Case "pdf"
					If cnt = -1 Then
						Table.CssClass = "ewTablePdfFooter"
					ElseIf cnt = 0 Then
						Table.CssClass = "ewTablePdfHeader"
					Else
						Table.CssClass = ew_IIf(cnt Mod 2 = 1, "ewTableRow", "ewTableAltRow")
					End If
					Line = "<tr" & ew_IIf(EW_EXPORT_CSS_STYLES, Table.RowStyles, "") & ">"
					Text = Text & Line
				Case "csv"
					Line = ""
			End Select
		End If
	End Sub

	' End a row
	Public Sub EndExportRow()
		If Horizontal Then
			Select Case Table.Export
				Case "html", "email", "word", "excel"
					Text = Text & "</tr>"
				Case "pdf"
					Line = Line & "</tr>"
					Text = Text & "</tr>"
					Header = Line
				Case "csv"
					Line = Line & vbCrLf
					Text = Text & Line
			End Select
		End If
	End Sub

	' Empty row
	Public Sub ExportEmptyRow()
		Select Case Table.Export
			Case "html", "email", "word", "excel", "pdf"
				RowCnt = RowCnt + 1
				Text = Text & "<br>"
		End Select
	End Sub

	' Page break
	Public Sub ExportPageBreak()
		Select Case Table.Export
			Case "pdf"
				If Horizontal Then
					Text = Text & "</table>" ' end current table
					Text = Text & "<p style=""page-break-after:always;"">" ' page break
					Text = Text & "<table class=""ewTablePdf ewTablePdfBorder"">" ' new page header
					Text = Text & Header
				End If
		End Select
	End Sub

	' Export a field
	Public Sub ExportField(fld)
		Dim wrkExportValue, ar, i, fn, parm
		FldCnt = FldCnt + 1
		wrkExportValue = ""
		If fld.FldViewTag = "IMAGE" Then

			'If fld.ImageResize And ew_CanResize() And Table.Export = "email" Or Table.Export = "pdf" Then
			If Table.Export = "email" Or Table.Export = "pdf" Then ' Always use image for export to pdf/email
				wrkExportValue = ew_GetFileImgTag(fld, fld.GetTempImage())
			End If
		ElseIf IsArray(fld.HrefValue2) And (Table.Export = "email" Or Table.Export = "pdf") Then ' Export custom view tag
			ar = fld.HrefValue2
			fn = ""
			parm = ""
			For i = 0 to UBound(ar)
				If IsArray(ar(i)) Then
					If UBound(ar(i)) >= 1 Then
						If ar(i)(0) = "exportfn" Then
							fn = ar(i)(1)
						Else
							If parm <> "" Then parm = parm & ", "
							parm = parm & ar(i)(1)
						End If
					End If
				End If
			Next
			If fn <> "" Then
				wrkExportValue = Eval(fn & "(" & parm & ")")
			End If
		End If
		If wrkExportValue = "" And Not IsArray(fld.HrefValue2) Then
			If fld.HrefValue2 <> "" And Table.Export <> "pdf" Then ' Upload field
				If Not ew_Empty(fld.Upload.DbValue) Then
					wrkExportValue = ew_GetFileATag(fld, fld.HrefValue2)
				End If
			End If
		End If
		If wrkExportValue = "" Then
			wrkExportValue = fld.ExportValue(Table.Export)
		End If
		If Horizontal Then
			Call ExportValueEx(fld, wrkExportValue)
		Else ' Vertical, export as a row
			RowCnt = RowCnt + 1
			Dim tdcaption, tdvalue
			tdcaption = "<td"
			Select Case Table.Export
				Case "html", "email", "word", "excel"

					'tdcaption = tdcaption & " class=""ewTableHeader"""
				Case "pdf"
					tdcaption = tdcaption & " class=""" & ew_IIf(FldCnt Mod 2 = 1, "ewTableRow", "ewTableAltRow") & """"
			End Select
			tdcaption = tdcaption & ">"
			Select Case Table.Export
				Case "pdf"
					fld.CellCssClass = ew_IIf(FldCnt Mod 2 = 1, "ewTableRow", "ewTableAltRow")
				Case Else
					fld.CellCssClass = ew_IIf(FldCnt Mod 2 = 1, "ewExportTableRow", "ewExportTableAltRow")
			End Select
			tdvalue = "<td" & ew_IIf(EW_EXPORT_CSS_STYLES, fld.CellStyles, "") & ">"
			Text = Text & "<tr>" & tdcaption & fld.ExportCaption & "</td>" & tdvalue & wrkExportValue & "</td></tr>"
		End If
	End Sub

	' Table Footer
	Public Sub ExportTableFooter()
		Select Case Table.Export
			Case "html", "email", "word", "excel", "pdf"
				Text = Text & "</table>"
		End Select
	End Sub

	' Get meta tag for charset
	Function CharsetMetaTag()
		CharsetMetaTag = "<meta http-equiv=""Content-Type"" content=""text/html; charset=" & EW_CHARSET & """>" & vbCrLf
	End Function

	Public Sub ExportHeaderAndFooter()
		Dim Header, CssFile
		Select Case Table.Export
			Case "html", "email", "word", "excel", "pdf"
				Header = "<html><head>" & vbCrLf
				Header = Header & CharsetMetaTag()
				If EW_EXPORT_CSS_STYLES Then
					If Table.Export = "pdf" And EW_PDF_STYLESHEET_FILENAME <> "" Then
						CssFile = EW_PDF_STYLESHEET_FILENAME
					Else
						CssFile = EW_PROJECT_STYLESHEET_FILENAME
					End If
					Header = Header & "<style type=""text/css"">" & ew_LoadFile(CssFile) & "</style>" & vbCrLf
				End If
				Header = Header & "</" & "head>" & vbCrLf & "<body>" & vbCrLf
				Text = Header & Text & "</body></html>"
		End Select
	End Sub
End Class

Function ew_GetFileImgTag(fld, fn)
	Dim wrkfiles, i, html
	html = ""
	If fn <> "" Then
		If fld.UploadMultiple Then
			wrkfiles = Split(fn, EW_MULTIPLE_UPLOAD_SEPARATOR)
			For i = 0 to UBound(wrkfiles)
				If wrkfiles(i) <> "" Then
					If html <> "" Then html = html & "<br>"
					html = html & "<img class=""ewImage"" src=""" & wrkfiles(i) & """ alt="""">"
				End If
			Next
		Else
			html = "<img class=""ewImage"" src=""" & fn & """ alt="""">"
		End If
	End If
	ew_GetFileImgTag = html
End Function

Function ew_GetFileATag(fld, fn)
	Dim wrkfiles, wrkpath, i, attrs, html
	wrkfiles = ""
	wrkpath = ""
	html = ""
	If fld.FldDataType = EW_DATATYPE_BLOB Then
		If Not ew_Empty(fld.Upload.DbValue) Then wrkfiles = Array(fn)
	ElseIf fld.UploadMultiple Then
		wrkfiles = Split(fn, EW_MULTIPLE_UPLOAD_SEPARATOR)
		wrkpath = Mid(wrkfiles(0), 1, InStrRev(wrkfiles(0), "/")) ' Get path from first file name
		wrkfiles(0) = Mid(wrkfiles(0), Len(wrkpath)+1)
	Else
		If Not ew_Empty(fld.Upload.DbValue) Then wrkfiles = Array(fn)
	End If
	If IsArray(wrkfiles) Then
		For i = 0 to UBound(wrkfiles)
			If wrkfiles(i) <> "" Then
				attrs = Array(Array("href", ew_ConvertFullUrl(wrkpath & wrkfiles(i))))
				If html <> "" Then html = html & "<br>"
				html = html & ew_HtmlElement("a", attrs, fld.FldCaption, True)
			End If
		Next
	End If
	ew_GetFileATag = html
End Function

Function ew_UrlEncodeFilename(fn)
	Dim path, filename
	If InStrRev(fn, "?") > 0 Then
		Dim arf, ar, i
		arf = Split(fn, "?")
		fn = arf(1)
		ar = Split(fn, "&")
		For i = 0 to UBound(ar)
			If ar(i) <> "" Then
				If Left(ar(i), 3) = "fn=" Then ' Get fn=...
					ar(i) = ew_UrlEncodeFilename(ar(i))
					Exit For
				End If
			End If
		Next
		ew_UrlEncodeFilename = arf(0) & "?" & Join(ar, "&")
		Exit Function
	ElseIf InStrRev(fn, "/") > 0 Then
		path = Mid(fn, 1, InStrRev(fn, "/"))
		filename = Mid(fn, InStrRev(fn, "/")+1) 
	Else
		path = ""
		filename = fn
	End If
	ew_UrlEncodeFilename = path & ew_Encode(filename)
End Function

Function ew_GetFileViewTag(fld, fn)
	Dim url, name
	If Not ew_EmptyStr(fn) Then
		If fld.IsBlobImage Or ew_IsImageFile(fn) Then
			If fld.FldDataType = EW_DATATYPE_BLOB Then
				url = fn
			Else
				url = ew_UrlEncodeFilename(fn)
				fld.HrefValue = ew_UrlEncodeFilename(fld.HrefValue)
			End If
			If fld.HrefValue = "" Then
				ew_GetFileViewTag = "<img class=""ewImage"" data-name=""" & ew_HtmlEncode(fld.FldCaption) & """ src=""" & url & """ alt=""""" & fld.ViewAttributes & ">"
			Else
				ew_GetFileViewTag = "<a" & fld.LinkAttributes & "><img class=""ewImage"" data-name=""" & ew_HtmlEncode(fld.FldCaption) & """ src=""" & url & """ alt=""""" & fld.ViewAttributes & "></a>"
			End If
		Else
			If fld.FldDataType = EW_DATATYPE_BLOB Then
				url = fn
				name = ew_IIf(fld.Upload.FileName <> "", fld.Upload.FileName, fld.FldCaption)
			Else
				url = ew_ImageNameFromUrl(fn)
				name = Mid(url, InStrRev(url, "/")+1)
				url = ew_UrlEncodeFilename(url)
			End If
			ew_GetFileViewTag = "<div><a href=""" & url & """>" & name & "</a></div>"
		End If
	Else
		ew_GetFileViewTag = ""
	End If
End Function

' Check if image file
Function ew_IsImageFile(fn)
	If Trim(fn & "") = "" Then
		ew_IsImageFile = False
		Exit Function
	End If
	Dim wrkfn
	wrkfn = ew_ImageNameFromUrl(fn)
	Dim Ext, Pos, arExt, FileExt
	arExt = Split(EW_IMAGE_ALLOWED_FILE_EXT & "", ",")
	Ext = ""
	Pos = InStrRev(wrkfn, ".")
	If Pos > 0 Then	Ext = Mid(wrkfn, Pos+1)
	ew_IsImageFile = False
	For Each FileExt in arExt
		If LCase(Trim(FileExt)) = LCase(Ext) Then
			ew_IsImageFile = True
			Exit For
		End If
	Next
End Function

' Get image file name
Function ew_ImageNameFromUrl(fn)
	Dim wrkfn, ar, ar1, i
	wrkfn = fn
	If InStr(wrkfn, "?") > 0 Then
		wrkfn = Mid(wrkfn, InStr(wrkfn, "?")+1) ' Get querystring
		ar = Split(wrkfn, "&")
		For i = 0 to UBound(ar)
			If ar(i) <> "" Then
				ar1 = Split(ar(i), "=")
				If UBound(ar1) >= 1 Then
					If ar1(0) = "fn" Then ' Get fn=...
						wrkfn = ew_Decode(ar1(1))
						Exit For
					End If
				End If
			End If
		Next
	End If
	ew_ImageNameFromUrl = wrkfn
End Function

' --------------------
'  XML document class
'
Class cXMLDocument
	Dim Encoding
	Dim RootTagName
	Dim SubTblName
	Dim RowTagName
	Dim XmlDoc
	Dim XmlTbl
	Dim XmlSubTbl
	Dim XmlRow
	Dim XmlFld

	' Class Initialize
	Private Sub Class_Initialize()
		Encoding = ""
		RootTagName = "table"
		RowTagName = "row"
		Set XmlDoc = ew_CreateXmlDom()
	End Sub

	Public Sub AddRoot(rootname)
		If rootname <> "" Then
			RootTagName = ew_XmlTagName(rootname)
		End If
		Set XmlTbl = XmlDoc.CreateElement(RootTagName)
		XmlDoc.AppendChild(XmlTbl)
	End Sub

	' Add row
	Public Sub AddRow(tablename, rowname)
		If rowname <> "" Then
			RowTagName = ew_XmlTagName(rowname)
		End If
		Set XmlRow = XmlDoc.CreateElement(RowTagName)
		If tablename = "" Then
			If Not IsEmpty(XmlTbl) Then
				XmlTbl.AppendChild(XmlRow)
			End If
		Else
			If SubTblName = "" Or SubTblName <> tablename Then
				SubTblName = ew_XmlTagName(tablename)
				Set XmlSubTbl = XmlDoc.CreateElement(SubTblName)
				XmlTbl.AppendChild(XmlSubTbl)
			End If
			If Not IsEmpty(XmlSubTbl) Then
				XmlSubTbl.AppendChild(XmlRow)
			End If
		End If
	End Sub

	' Add field
	Public Sub AddField(Name, Value)
		Set XmlFld = XmlDoc.CreateElement(ew_XmlTagName(Name))
		Call XmlRow.AppendChild(XmlFld)
		Call XmlFld.AppendChild(XmlDoc.CreateTextNode(Value & ""))
	End Sub

	' XML
	Public Function XML()
		XML = XmlDoc.XML
	End Function

	' Output
	Public Sub Output()
		Dim PI
		If Response.Buffer Then Response.Clear
		Response.ContentType = "text/xml"
		PI = "<?xml version=""1.0"""
		If Encoding <> "" Then PI = PI & " encoding=""" & Encoding & """"
		PI = PI & " ?>"
		Response.Write PI & XmlDoc.XML
	End Sub

	' Output XML for debug
	Public Sub Print()
		If Response.Buffer Then Response.Clear
		Response.ContentType = "text/plain"
		Response.Write Server.HTMLEncode(XmlDoc.XML)
	End Sub

	' Terminate
	Private Sub Class_Terminate()
		Set XmlFld = Nothing
		Set XmlRow = Nothing
		Set XmlTbl = Nothing
		Set XmlDoc = Nothing
	End Sub
End Class 

'
'  XML document class (end)
' --------------------------
'
' ---------------------
'  Email class (begin)
'
Class cEmail

	' Class properties
	Dim Sender ' Sender
	Dim Recipient ' Recipient
	Dim Cc ' Cc
	Dim Bcc ' Bcc
	Dim Subject ' Subject
	Dim Format ' Format
	Dim Content ' Content
	Dim Attachments ' Attachments
	Dim EmbeddedImages ' Embedded images
	Dim Charset ' Charset
	Dim SendErrNumber ' Send error number
	Dim SendErrDescription ' Send error description
	Dim SmtpSecure ' Send secure option

	' Class Initialize
	Private Sub Class_Initialize()
		SmtpSecure = EW_SMTP_SECURE_OPTION
	End Sub

	' Method to load email from template
	Public Sub Load(fn)
		Dim sWrk, sHeader, arrHeader
		Dim sName, sValue
		Dim i, j

		'sWrk = ew_LoadTxt(fn) ' Load text file content
		sWrk = ew_LoadFile(fn) ' Load file content
		sWrk = Replace(sWrk, vbCrLf, vbLf) ' Convert to Lf
		sWrk = Replace(sWrk, vbCr, vbLf) ' Convert to Lf
		If sWrk <> "" Then

			' Locate Header & Mail Content
			i = InStr(sWrk, vbLf&vbLf)
			If i > 0 Then
				sHeader = Mid(sWrk, 1, i)
				Content = Mid(sWrk, i+2)
				arrHeader = Split(sHeader, vbLf)
				For j = 0 to UBound(arrHeader)
					i = InStr(arrHeader(j), ":")
					If i > 0 Then
						sName = Trim(Mid(arrHeader(j), 1, i-1))
						sValue = Trim(Mid(arrHeader(j), i+1))
						Select Case LCase(sName)
							Case "subject"
								Subject = sValue
							Case "from"
								Sender = sValue
							Case "to"
								Recipient = sValue
							Case "cc"
								Cc = sValue
							Case "bcc"
								Bcc = sValue
							Case "format"
								Format = sValue
						End Select
					End If
				Next
			End If
		End If
	End Sub

	' Method to replace sender
	Public Sub ReplaceSender(ASender)
		Sender = Replace(Sender, "<!--$From-->", ASender)
	End Sub

	' Method to replace recipient
	Public Sub ReplaceRecipient(ARecipient)
		Recipient = Replace(Recipient, "<!--$To-->", ARecipient)
	End Sub

	' Method to add Cc email
	Public Sub AddCc(ACc)
		If ACc <> "" Then
			If Cc <> "" Then Cc = Cc & ";"
			Cc = Cc & ACc
		End If
	End Sub

	' Method to add Bcc email
	Public Sub AddBcc(ABcc)
		If ABcc <> "" Then
			If Bcc <> "" Then Bcc = Bcc & ";"
			Bcc = Bcc & ABcc
		End If
	End Sub

	' Method to replace subject
	Public Sub ReplaceSubject(ASubject)
		Subject = Replace(Subject, "<!--$Subject-->", ASubject)
	End Sub

	' Method to replace content
	Public Sub ReplaceContent(Find, ReplaceWith)
		Content = Replace(Content, Find, ReplaceWith)
	End Sub

	' Method to add embedded image
	Public Sub AddEmbeddedImage(image)
		If image <> "" Then
			If Not IsArray(EmbeddedImages) Then
				ReDim EmbeddedImages(0)
			Else
				ReDim Preserve EmbeddedImages(UBound(EmbeddedImages)+1)
			End If
			EmbeddedImages(UBound(EmbeddedImages)) = image
		End If
	End Sub

	' Method to add attachment
	Public Sub AddAttachment(filename)
		If filename <> "" Then
			If Not IsArray(Attachments) Then
				ReDim Attachments(0)
			Else
				ReDim Preserve Attachments(UBound(Attachments)+1)
			End If
			Attachments(UBound(Attachments)) = filename
		End If
	End Sub

	' Method to send email
	Public Function Send
		Send = ew_SendEmail(Sender, Recipient, Cc, Bcc, Subject, Content, Format, Charset, SmtpSecure, Attachments, EmbeddedImages)
		If Not Send Then
			SendErrNumber = Hex(gsEmailErrNo) ' Send error number
			SendErrDescription = gsEmailErrDesc ' Send error description
		Else
			SendErrNumber = 0
			SendErrDescription = ""
		End If
	End Function

	' Show object as string
	Public Function AsString()
		AsString = "{" & _
			"Sender: " & Sender & ", " & _
			"Recipient: " & Recipient & ", " & _
			"Cc: " & Cc & ", " & _
			"Bcc: " & Bcc & ", " & _
			"Subject: " & Subject & ", " & _
			"Format: " & Format & ", " & _
			"Content: " & Content & ", " & _
			"Charset: " & Charset & _
			"}"
	End Function
End Class

'
'  Email class (end)
' -------------------
'
' -------------------------------------
'  Pager classes and functions (begin)
'
' Function to create numeric pager
Function ew_NewNumericPager(FromIndex, PageSize, RecordCount, Range)
	Set ew_NewNumericPager = New cNumericPager
	ew_NewNumericPager.FromIndex = CLng(FromIndex)
	ew_NewNumericPager.PageSize = CLng(PageSize)
	ew_NewNumericPager.RecordCount = CLng(RecordCount)
	ew_NewNumericPager.Range = CLng(Range)
	ew_NewNumericPager.Init
End Function

' Function to create next prev pager
Function ew_NewPrevNextPager(FromIndex, PageSize, RecordCount)
	Set ew_NewPrevNextPager = New cPrevNextPager
	ew_NewPrevNextPager.FromIndex = CLng(FromIndex)
	ew_NewPrevNextPager.PageSize = CLng(PageSize)
	ew_NewPrevNextPager.RecordCount = CLng(RecordCount)
	ew_NewPrevNextPager.Init
End Function

' Class for Pager item
Class cPagerItem
	Dim Start, Text, Enabled
End Class

' Class for Numeric pager
Class cNumericPager
	Dim Items()
	Dim Count, FromIndex, ToIndex, RecordCount, PageSize, Range
	Dim FirstButton, PrevButton, NextButton, LastButton, ButtonCount
	Dim Visible

	' Class Initialize
	Private Sub Class_Initialize()
		Set FirstButton = New cPagerItem
		Set PrevButton = New cPagerItem
		Set NextButton = New cPagerItem
		Set LastButton = New cPagerItem
		Visible = True
	End Sub

	' Method to init pager
	Public Sub Init()
		If FromIndex > RecordCount Then FromIndex = RecordCount
		ToIndex = FromIndex + PageSize - 1
		If ToIndex > RecordCount Then ToIndex = RecordCount
		Count = -1
		ReDim Items(0)
		SetupNumericPager()
		Redim Preserve Items(Count)

		' Update button count
		ButtonCount = Count + 1
		If FirstButton.Enabled Then ButtonCount = ButtonCount + 1
		If PrevButton.Enabled Then ButtonCount = ButtonCount + 1
		If NextButton.Enabled Then ButtonCount = ButtonCount + 1
		If LastButton.Enabled Then ButtonCount = ButtonCount + 1
	End Sub

	' Add pager item
	Private Sub AddPagerItem(StartIndex, Text, Enabled)
		Count = Count + 1
		If Count > UBound(Items) Then
			Redim Preserve Items(UBound(Items)+10)
		End If
		Dim Item
		Set Item = New cPagerItem
		Item.Start = StartIndex
		Item.Text = Text
		Item.Enabled = Enabled
		Set Items(Count) = Item
	End Sub

	' Setup pager items
	Private Sub SetupNumericPager()
		Dim Eof, x, y, dx1, dx2, dy1, dy2, ny, HasPrev, TempIndex
		If RecordCount > PageSize Then
			Eof = (RecordCount < (FromIndex + PageSize))
			HasPrev = (FromIndex > 1)

			' First Button
			TempIndex = 1
			FirstButton.Start = TempIndex
			FirstButton.Enabled = (FromIndex > TempIndex)

			' Prev Button
			TempIndex = FromIndex - PageSize
			If TempIndex < 1 Then TempIndex = 1
			PrevButton.Start = TempIndex
			PrevButton.Enabled = HasPrev

			' Page links
			If HasPrev Or Not Eof Then
				x = 1
				y = 1
				dx1 = ((FromIndex-1)\(PageSize*Range))*PageSize*Range + 1
				dy1 = ((FromIndex-1)\(PageSize*Range))*Range + 1
				If (dx1+PageSize*Range-1) > RecordCount Then
					dx2 = (RecordCount\PageSize)*PageSize + 1
					dy2 = (RecordCount\PageSize) + 1
				Else
					dx2 = dx1 + PageSize*Range - 1
					dy2 = dy1 + Range - 1
				End If
				While x <= RecordCount
					If x >= dx1 And x <= dx2 Then
						Call AddPagerItem(x, y, FromIndex<>x)
						x = x + PageSize
						y = y + 1
					ElseIf x >= (dx1-PageSize*Range) And x <= (dx2+PageSize*Range) Then
						If x+Range*PageSize < RecordCount Then
							Call AddPagerItem(x, y & "-" & (y+Range-1), True)
						Else
							ny = (RecordCount-1)\PageSize + 1
							If ny = y Then
								Call AddPagerItem(x, y, True)
							Else
								Call AddPagerItem(x, y & "-" & ny, True)
							End If
						End If
						x = x + Range*PageSize
						y = y + Range
					Else
						x = x + Range*PageSize
						y = y + Range
					End If
				Wend
			End If

			' Next Button
			NextButton.Start = FromIndex + PageSize
			TempIndex = FromIndex + PageSize
			NextButton.Start = TempIndex
			NextButton.Enabled = Not Eof

			' Last Button
			TempIndex = ((RecordCount-1)\PageSize)*PageSize + 1
			LastButton.Start = TempIndex
			LastButton.Enabled = (FromIndex < TempIndex)
		End If
	End Sub

    ' Terminate
	Private Sub Class_Terminate()
		Set FirstButton = Nothing
		Set PrevButton = Nothing
		Set NextButton = Nothing
		Set LastButton = Nothing
		For Each Item In Items
			Set Item = Nothing
		Next
		Erase Items
	End Sub
End Class

' Class for PrevNext pager
Class cPrevNextPager
	Dim FirstButton, PrevButton, NextButton, LastButton
	Dim CurrentPage, PageSize, PageCount, FromIndex, ToIndex, RecordCount
	Dim Visible

	' Class Initialize
	Private Sub Class_Initialize()
		Set FirstButton = New cPagerItem
		Set PrevButton = New cPagerItem
		Set NextButton = New cPagerItem
		Set LastButton = New cPagerItem
		Visible = True
	End Sub

	' Method to init pager
	Public Sub Init()
		Dim TempIndex
		If PageSize > 0 Then
			CurrentPage = (FromIndex-1)\PageSize + 1
			PageCount = (RecordCount-1)\PageSize + 1
			If FromIndex > RecordCount Then FromIndex = RecordCount
			ToIndex = FromIndex + PageSize - 1
			If ToIndex > RecordCount Then ToIndex = RecordCount

			' First Button
			TempIndex = 1
			FirstButton.Start = TempIndex
			FirstButton.Enabled = (TempIndex <> FromIndex)

			' Prev Button
			TempIndex = FromIndex - PageSize
			If TempIndex < 1 Then TempIndex = 1
			PrevButton.Start = TempIndex
			PrevButton.Enabled = (TempIndex <> FromIndex)

			' Next Button
			TempIndex = FromIndex + PageSize
			If TempIndex > RecordCount Then TempIndex = FromIndex
			NextButton.Start = TempIndex
			NextButton.Enabled = (TempIndex <> FromIndex)

			' Last Button
			TempIndex = ((RecordCount-1)\PageSize)*PageSize + 1
			LastButton.Start = TempIndex
			LastButton.Enabled = (TempIndex <> FromIndex)
		End If
	End Sub

	' Terminate
	Private Sub Class_Terminate()
	Set FirstButton = Nothing
		Set PrevButton = Nothing
		Set NextButton = Nothing
		Set LastButton = Nothing
	End Sub
End Class

'
'  Pager classes and functions (end)
' -----------------------------------
'
' ------------------
'  Breadcrumb class
'
Class cBreadcrumb
	Dim Links
	Dim SessionLinks
	Dim Visible

	' Class Initialize
	Private Sub Class_Initialize()
		ReDim Links(0)
		Links(0) = Array("home", "HomePage", "default.asp", "ewHome", "", False) ' Home
		Visible = True
	End Sub

	' Check if an item exists
	Public Function Exists(pageid, table, pageurl)
		Dim i, cnt, id, title, url, tbl, cur
		If IsArray(Links) Then
			cnt = UBound(Links) + 1
			For i = 0 to cnt - 1
				If IsArray(Links(i)) Then
					If UBound(Links(i)) >= 4 Then
						id = Links(i)(0)
						title = Links(i)(1)
						url = Links(i)(2)
						tbl = Links(i)(3)
						cur = Links(i)(4)
						If pageid = id And table = tbl And pageurl = url Then
							Exists = True
							Exit Function
						End If
					End If
				End If
			Next
		End If
		Exists = False
	End Function

	' Add breadcrumb
	Public Sub Add(pageid, pagetitle, pageurl, pageurlclass, table, current)
		Dim i, cnt, id, title, url, urlclass, tbl, cur

		' Load session links
		LoadSession()

		' Get list of master tables
		Dim mastertable, tablevar
		If table <> "" Then
			tablevar = table
			Do While Session(EW_PROJECT_NAME & "_" & tablevar & "_" & EW_TABLE_MASTER_TABLE) & "" <> ""
				tablevar = Session(EW_PROJECT_NAME & "_" & tablevar & "_" & EW_TABLE_MASTER_TABLE)
				If ew_InArray(tablevar, mastertable) Then
					Exit Do
				End If
				If IsArray(mastertable) Then
					ReDim Preserve mastertable(UBound(mastertable)+1)
				Else
					ReDim mastertable(0)
				End If
				mastertable(UBound(mastertable)) = tablevar
			Loop
		End If

		' Add master links first
		If IsArray(SessionLinks) Then
			cnt = UBound(SessionLinks) + 1
			For i = 0 to cnt - 1
				If UBound(SessionLinks(i)) >= 5 Then
					id = SessionLinks(i)(0)
					title = SessionLinks(i)(1)
					url = SessionLinks(i)(2)
					urlclass = SessionLinks(i)(3)
					tbl = SessionLinks(i)(4)
					cur = SessionLinks(i)(5)
					If ew_InArray(tbl, mastertable) And id = "list" Then
						If url = pageurl Then
							Exit For
						End If
						If Not Exists(id, tbl, url) Then
							ReDim Preserve Links(UBound(Links)+1)
							Links(UBound(Links)) = Array(id, title, url, urlclass, tbl, False)
						End If
					End If
				End If
			Next
		End If

		' Add this link
		If Not Exists(pageid, table, pageurl) Then
			ReDim Preserve Links(UBound(Links)+1)
			Links(UBound(Links)) = Array(pageid, pagetitle, pageurl, pageurlclass, table, current)
		End If

		' Save session links
		SaveSession()
	End Sub

	' Save links to Session
	Private Sub SaveSession()
		Session(EW_SESSION_BREADCRUMB) = Links
	End sub

	' Load links from Session
	Private Sub LoadSession()
		If IsArray(Session(EW_SESSION_BREADCRUMB)) Then
			SessionLinks = Session(EW_SESSION_BREADCRUMB)
		End If
	End Sub

	' Load language phrase
	Private Function LanguagePhrase(title, table, current)
		Dim wrktitle
		wrktitle = ew_IIf(title = table, Language.TablePhrase(title, "TblCaption"), Language.Phrase(title))
		If current Then
			wrktitle = "<span id=""ewPageCaption"">" & wrktitle & "</span>"
		End If
		LanguagePhrase = wrktitle
	End Function

	' Render
	Public Sub Render()
		Dim nav, i, cnt, id, text, title, url, urlclass, tbl, cur
		If Not Visible Then Exit Sub
		nav = "<ul class=""breadcrumb"">"
		If IsArray(Links) Then
			cnt = UBound(Links) + 1
			For i = 0 to cnt - 1
				If UBound(Links(i)) >= 5 Then
					id = Links(i)(0)
					title = Links(i)(1)
					url = Links(i)(2)
					urlclass = Links(i)(3)
					tbl = Links(i)(4)
					cur = Links(i)(5)
					If i < cnt - 1 Then
						nav = nav & "<li>"
					Else
						nav = nav & "<li class=""active"">"
						url = "" ' No need to show url for current page
					End If
					text = LanguagePhrase(title, tbl, cur)
					title = ew_HtmlTitle(text)
					If url <> "" Then
						nav = nav & "<a href=""" & ew_GetUrl(url) & """"
						If title <> "" And title <> text Then
							nav = nav & " title=""" & ew_HtmlEncode(title) & """"
						End If
						If urlclass <> "" Then
							nav = nav & " class=""" & urlclass & """"
						End If
						nav = nav & ">" & text & "</a>"
					Else
						nav = nav & text
					End If
					nav = nav & "</li>"
				End If
			Next
		End If
		nav = nav & "</ul>"
		Response.Write nav
	End Sub
End Class

'
'  Breadcrumb class (end)
' ------------------------
'
' -------------
'  Field class
'
Class cField
	Dim TblName ' Table name
	Dim TblVar ' Table var
	Dim FldName ' Field name
	Dim FldVar ' Field variable name
	Dim FldExpression ' Field expression (used in SQL)
	Dim FldBasicSearchExpression ' Field expression (used in basic search SQL)
	Dim FldIsVirtual ' Virtual field
	Dim FldVirtualExpression ' Virtual field expression (used in SelectSQL)
	Dim FldForceSelection ' Autosuggest force selection
	Dim FldVirtualSearch ' Search as virtual field
	Dim VirtualValue ' Virtual field value
	Dim TooltipValue ' Field tooltip value
	Dim TooltipWidth ' Field tooltip width
	Dim FldType ' Field type
	Dim FldDataType ' Field data type
	Dim FldBlobType ' For Oracle only
	Dim FldViewTag ' View Tag
	Dim FldIsDetailKey ' Detail key
	Dim Visible ' Visible
	Dim Disabled ' Disabled
	Dim ReadOnly ' Read only
	Dim TruncateMemoRemoveHtml ' Remove Html from Memo field
	Dim LookupFn ' Lookup table function(&$sql) for modifying SQL
	Dim DisplayValueSeparator

	' Field caption
	Dim Caption

	Public Property Let FldCaption(v)
		Caption = v
	End Property

	Public Property Get FldCaption()
		If Caption & "" <> "" Then
			FldCaption = Caption
		Else
			FldCaption = Language.FieldPhrase(TblVar, Mid(FldVar,3), "FldCaption")
		End If
	End Property

	Public Property Get FldTitle() ' Field title
		FldTitle = Language.FieldPhrase(TblVar, Mid(FldVar,3), "FldTitle")
	End Property

	Public Property Get FldAlt() ' Field alt
		FldAlt = Language.FieldPhrase(TblVar, Mid(FldVar,3), "FldAlt")
	End Property
	Dim FldDefaultErrMsg

	Public Property Get FldErrMsg() ' Field err msg
		FldErrMsg = Language.FieldPhrase(TblVar, Mid(FldVar,3), "FldErrMsg")
		If FldErrMsg = "" Then FldErrMsg = FldDefaultErrMsg & " - " & FldCaption
	End Property

	' Field tag value
	Public Function FldTagValue(i)
		FldTagValue = Language.FieldPhrase(TblVar, Mid(FldVar,3), "FldTagValue" & i)
	End Function

	' Field tag caption
	Public Function FldTagCaption(i)
		FldTagCaption = Language.FieldPhrase(TblVar, Mid(FldVar,3), "FldTagCaption" & i)
	End Function

	' Reset attributes for field object
	Public Sub ResetAttrs()
		CssStyle = ""
		CssClass = ""
		CellCssStyle = ""
		CellCssClass = ""
		CellAttrs.Clear()
		EditAttrs.Clear()
		ViewAttrs.Clear()
		LinkAttrs.Clear()
	End Sub
	Dim FldDateTimeFormat ' Date time format
	Dim CssStyle ' Css style
	Dim CssClass ' Css class
	Dim ImageAlt ' Image alt
	Dim ImageWidth ' Image width
	Dim ImageHeight ' Image height
	Dim ImageResize ' Image resize
	Dim IsBlobImage ' Is blob image
	Dim ViewCustomAttributes ' View custom attributes
	Dim CellAttrs ' Cell attributes
	Dim EditAttrs ' Edit attributes
	Dim ViewAttrs ' View attributes

	' View Attributes
	Public Property Get ViewAttributes()
		Dim sAtt, Attr, Value, i
		Dim sStyle, sClass
		sAtt = ""
		sStyle = ""
		If FldViewTag = "IMAGE" And CLng(ImageWidth) > 0 And (Not ImageResize Or (ImageResize And CLng(ImageHeight) <= 0)) Then
			sStyle = sStyle & "width: " & CInt(ImageWidth) & "px; "
		End If
		If FldViewTag = "IMAGE" And CLng(ImageHeight) > 0 And (Not ImageResize Or (ImageResize And CLng(ImageWidth) <= 0)) Then
			sStyle = sStyle & "height: " & CInt(ImageHeight) & "px; "
		End If
		sStyle = sStyle & Trim(CssStyle)
		If ViewAttrs.Exists("style") Then
			Value = ViewAttrs.Item("style")
			If Trim(Value) <> "" Then
				sStyle = sStyle & " " & Value
			End If
		End If
		sClass = CssClass
		If ViewAttrs.Exists("class") Then
			Value = ViewAttrs.Item("class")
			If Trim(Value) <> "" Then
				sClass = sClass & " " & Value
			End If
		End If
		If Trim(sStyle) <> "" Then
			sAtt = sAtt & " style=""" & Trim(sStyle) & """"
		End If
		If Trim(sClass) <> "" Then
			sAtt = sAtt & " class=""" & Trim(sClass) & """"
		End If
		If Trim(ImageAlt) <> "" Then
			sAtt = sAtt & " alt=""" & Trim(ImageAlt) & """"
		End If
		For i = 0 to UBound(ViewAttrs.Attributes)
			Attr = ViewAttrs.Attributes(i)(0)
			Value = ViewAttrs.Attributes(i)(1)
			If Attr <> "style" And Attr <> "class" And Value <> "" Then
				sAtt = sAtt & " " & Attr & "=""" & Value & """"
			End If
		Next
		If Trim(ViewCustomAttributes) <> "" Then
			sAtt = sAtt & " " & Trim(ViewCustomAttributes) 
		End If
		ViewAttributes = sAtt
	End Property
	Dim EditCustomAttributes ' Edit custom attributes

	' Edit Attributes
	Public Property Get EditAttributes()
		Dim sAtt, Attr, Value, i
		Dim sStyle, sClass
		sAtt = ""
		sStyle = CssStyle
		If EditAttrs.Exists("style") Then
			Value = EditAttrs.Item("style")
			If Trim(Value) <> "" Then
				sStyle = sStyle & " " & Value
			End If
		End If
		sClass = CssClass
		If EditAttrs.Exists("class") Then
			Value = EditAttrs.Item("class")
			If Trim(Value) <> "" Then
				sClass = sClass & " " & Value
			End If
		End If
		If Trim(sStyle) <> "" Then
			sAtt = sAtt & " style=""" & Trim(sStyle) & """"
		End If
		If Trim(sClass) <> "" Then
			sAtt = sAtt & " class=""" & Trim(sClass) & """"
		End If
		For i = 0 to UBound(EditAttrs.Attributes)
			Attr = EditAttrs.Attributes(i)(0)
			Value = EditAttrs.Attributes(i)(1)
			If Attr <> "style" And Attr <> "class" And Value <> "" Then
				sAtt = sAtt & " " & Attr & "=""" & Value & """"
			End If
		Next
		If Trim(EditCustomAttributes) <> "" Then
			sAtt = sAtt & " " & Trim(EditCustomAttributes) 
		End If
		If Not EditAttrs.Exists("disabled") And Disabled Then
			sAtt = sAtt & " disabled=""disabled"""
		End If
		If Not EditAttrs.Exists("readonly") And ReadOnly Then
			sAtt = sAtt & " readonly=""readonly"""
		End If
		EditAttributes = sAtt
	End Property
	Dim CustomMsg ' Custom message
	Dim CellCssClass ' Cell CSS class
	Dim CellCssStyle ' Cell CSS style
	Dim CellCustomAttributes ' Cell custom attributes

	' Cell Styles
	Public Property Get CellStyles()
		Dim sAtt, Value
		Dim sStyle, sClass
		sAtt = ""
		sStyle = CellCssStyle
		If CellAttrs.Exists("style") Then
			Value = CellAttrs.Item("style")
			If Trim(Value) <> "" Then
				sStyle = sStyle & " " & Value
			End If
		End If
		sClass = CellCssClass
		If CellAttrs.Exists("class") Then
			Value = CellAttrs.Item("class")
			If Trim(Value) <> "" Then
				sClass = sClass & " " & Value
			End If
		End If
		If Trim(sStyle) <> "" Then
			sAtt = sAtt & " style=""" & Trim(sStyle) & """"
		End If
		If Trim(sClass) <> "" Then
			sAtt = sAtt & " class=""" & Trim(sClass) & """"
		End If
		CellStyles = sAtt
	End Property

	' Cell Attributes
	Public Property Get CellAttributes()
		Dim sAtt, Attr, Value, i
		sAtt = CellStyles
		For i = 0 to UBound(CellAttrs.Attributes)
			Attr = CellAttrs.Attributes(i)(0)
			Value = CellAttrs.Attributes(i)(1)
			If Attr <> "style" And Attr <> "class" And Attr <> "" And Value <> "" Then
				sAtt = sAtt & " " & Attr & "=""" & Value & """"
			End If
		Next
		If Trim(CellCustomAttributes) <> "" Then
			sAtt = sAtt & " " & Trim(CellCustomAttributes) ' Cell custom attributes
		End If
		CellAttributes = sAtt
	End Property
	Dim LinkCustomAttributes ' Link custom attributes
	Dim LinkAttrs ' Link attributes

	' Link attributes
	Public Property Get LinkAttributes()
		Dim sAtt, Attr, Value, sHref, i
		sAtt = ""
		sHref = Trim(HrefValue)
		For i = 0 to UBound(LinkAttrs.Attributes)
			Attr = LinkAttrs.Attributes(i)(0)
			Value = LinkAttrs.Attributes(i)(1)
			If Trim(Value) <> "" Then
				If Attr = "href" Then
					If sHref = "" Then sHref = Value
				Else
					sAtt = sAtt & " " & Attr & "=""" & Trim(Value) & """"
				End If
			End If
		Next
		If sHref <> "" Then
			sAtt = sAtt & " href=""" & Trim(sHref) & """"
		End If
		If Trim(LinkCustomAttributes) <> "" Then
			sAtt = sAtt & " " & Trim(LinkCustomAttributes)
		End If
		LinkAttributes = sAtt
	End Property

	' Sort Attributes
	Dim Sortable

	Public Property Get Sort()
		Sort = Session(EW_PROJECT_NAME & "_" & TblVar & "_" & EW_TABLE_SORT & "_" & FldVar)
	End Property

	Public Property Let Sort(v)
		If Session(EW_PROJECT_NAME & "_" & TblVar & "_" & EW_TABLE_SORT & "_" & FldVar) <> v Then
			Session(EW_PROJECT_NAME & "_" & TblVar & "_" & EW_TABLE_SORT & "_" & FldVar) = v
		End If
	End Property

	Public Function ReverseSort()
		If Sort = "ASC" Then
			ReverseSort = "DESC"
		Else
			ReverseSort = "ASC"
		End If
	End Function

	' Advanced search
	Private Function UrlParameterName(name)
		Dim fldparm
		fldparm = Mid(FldVar, 3)
		If LCase(name) = LCase("SearchValue") Then
			fldparm = "x_" & fldparm
		ElseIf LCase(name) = LCase("SearchOperator") Then
			fldparm = "z_" & fldparm
		ElseIf LCase(name) = LCase("SearchCondition") Then
			fldparm = "v_" & fldparm
		ElseIf LCase(name) = LCase("SearchValue2") Then
			fldparm = "y_" & fldparm
		ElseIf LCase(name) = LCase("SearchOperator2") Then
			fldparm = "w_" & fldparm
		End If
		UrlParameterName = fldparm
	End Function
	Dim MultiUpdate ' Multi update
	Dim OldValue ' Old Value
	Dim ConfirmValue ' Confirm Value
	Dim CurrentValue ' Current value
	Dim ViewValue ' View value
	Dim EditValue ' Edit value
	Dim EditValue2 ' Edit value 2 (search)
	Dim HrefValue ' Href value
	Dim HrefValue2 ' Href value 2 (blob view url)

	' List View value
	Public Property Get ListViewValue()
		If FldDataType = EW_DATATYPE_XML Then
			ListViewValue = ViewValue & "&nbsp;"
		ElseIf Trim(ViewValue & "") = "" Then
			ListViewValue = "&nbsp;"
		Else
			Dim Result
			Result = ViewValue & ""

			'Result = ew_RegExReplace("<[^>]+>", Result, "") ' Remove all HTML Tags
			'Result = ew_RegExReplace("</?(b|p|span)[^>]*[^>]*?>", Result, "") ' Remove empty <b>/<p>/<span> tags

			Result = ew_RegExReplace("<[^img][^>]*>", Result, "") ' Remove all except non-empty image tag
			If Trim(Result) = "" Then
				ListViewValue = "&nbsp;"
			Else
				ListViewValue = ViewValue
			End If
		End If
	End Property
	Dim Exportable

	' Export Caption
	Public Property Get ExportCaption()
		If EW_EXPORT_FIELD_CAPTION Then
			ExportCaption = FldCaption
		Else
			ExportCaption = FldName
		End If
	End Property
	Dim ExportOriginalValue

	' Export Value
	Public Property Get ExportValue(Export)
		If ExportOriginalValue Then
			ExportValue = CurrentValue
		Else
			ExportValue = ViewValue
		End If
		If Export = "xml" Then
			If IsNull(ExportValue) Then ExportValue = "<Null>"
		End If
	End Property

	' Get temp image
	Public Function GetTempImage()
		Dim wrkdata, wrkwidth, wrkheight, wrkfile, imagefn
		GetTempImage = ""
		If FldDataType = EW_DATATYPE_BLOB Then
			wrkdata = Upload.DbValue
			If Not ew_Empty(wrkdata) Then
				If ImageResize Then
					wrkwidth = ImageWidth
					wrkheight = ImageHeight
					Call ew_ResizeBinary(wrkdata, wrkwidth, wrkheight, EW_THUMBNAIL_DEFAULT_INTERPOLATION)
				End If
				GetTempImage = ew_TmpImage(wrkdata)
			End If
		Else
			wrkfile = Upload.DbValue
			If ew_Empty(wrkfile) Then wrkfile = CurrentValue
			If Not ew_Empty(wrkfile) Then
				If Not UploadMultiple Then
					imagefn = ew_UploadPathEx(True, UploadPath) & wrkfile
					If ImageResize Then
						wrkwidth = ImageWidth
						wrkheight = ImageHeight
						wrkdata = ew_ResizeFileToBinary(imagefn, wrkwidth, wrkheight, EW_THUMBNAIL_DEFAULT_INTERPOLATION)
						GetTempImage = ew_TmpImage(wrkdata)
					Else
						GetTempImage = ew_ConvertFullUrl(ew_UploadPathEx(False, UploadPath) & wrkfile)
					End If
				Else
					Dim tmpfiles, i
					tmpfiles = Split(wrkfile, EW_MULTIPLE_UPLOAD_SEPARATOR)
					For i = 0 to UBound(tmpfiles)
						If tmpfiles(i) <> "" Then
							imagefn = ew_UploadPathEx(True, UploadPath) & tmpfiles(i)
							If ImageResize Then
								wrkwidth = ImageWidth
								wrkheight = ImageHeight
								wrkdata = ew_ResizeFileToBinary(imagefn, wrkwidth, wrkheight, EW_THUMBNAIL_DEFAULT_INTERPOLATION)
								If GetTempImage <> "" Then GetTempImage = GetTempImage & EW_MULTIPLE_UPLOAD_SEPARATOR
								GetTempImage = GetTempImage & ew_TmpImage(wrkdata)
							Else
								If GetTempImage <> "" Then GetTempImage = GetTempImage & EW_MULTIPLE_UPLOAD_SEPARATOR
								GetTempImage = GetTempImage & ew_ConvertFullUrl(ew_UploadPathEx(False, UploadPath) & tmpfiles(i))
							End If
						End If
					Next
				End If
			End If
		End If
	End Function

	' Form value
	Private m_FormValue

	Public Property Get FormValue()
		FormValue = m_FormValue
	End Property

	Public Property Let FormValue(v)
		m_FormValue = v
		CurrentValue = m_FormValue
	End Property

	' QueryString value
	Private m_QueryStringValue

	Public Property Get QueryStringValue()
		QueryStringValue = m_QueryStringValue
	End Property

	Public Property Let QueryStringValue(v)
		m_QueryStringValue = v
		CurrentValue = m_QueryStringValue
	End Property

	' Database Value
	Dim m_DbValue

	Public Property Get DbValue()
		DbValue = m_DbValue
	End Property

	Public Property Let DbValue(v)
		m_DbValue = v
		CurrentValue = m_DbValue
	End Property

	' Set up database value
	Public Sub SetDbValue(rs, value, default, skip)
		Dim bSkipUpdate
		bSkipUpdate = skip Or Not Visible Or Disabled
		If bSkipUpdate Then Exit Sub
		Select Case FldType
			Case 2, 3, 16, 17, 18, 19, 21 ' Int
				If IsNumeric(value) Then
					m_DbValue = CLng(value)
				Else
					m_DbValue = default
				End If
			Case 20 ' Big Int
				If IsNumeric(value) Then
					m_DbValue = value ' Use original value, CLng may overflow
				Else
					m_DbValue = default
				End If
			Case 5, 6, 14, 131, 139 ' Double
				value = ew_StrToFloat(value)
				If IsNumeric(value) Then
					m_DbValue = CDbl(value)
				Else
					m_DbValue = default
				End If
			Case 4 ' Single
				value = ew_StrToFloat(value)
				If IsNumeric(value) Then
					m_DbValue = CSng(value)
				Else
					m_DbValue = default
				End If
			Case 7, 133, 134, 135, 145, 146 ' Date
				If IsDate(value) Then
					m_DbValue = CDate(value)
				ElseIf ew_IsDate(value) Then
					m_DbValue = value
				Else
					m_DbValue = default
				End If
			Case 201, 203, 129, 130, 200, 202 ' String
				m_DbValue = Trim(value)
				If EW_REMOVE_XSS Then m_DbValue = ew_RemoveXSS(m_DbValue)
				If m_DbValue = "" Then m_DbValue = default
			Case 128, 204, 205 ' Binary
				If IsNull(value) Then
					m_DbValue = default
				Else
					m_DbValue = value
				End If
			Case 72 ' GUID
				If ew_RegExTest("^(\{{1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{1})$", Trim(value)) Then
					m_DbValue = Trim(value)
				Else
					m_DbValue = default
				End If
			Case Else
				m_DbValue = value
		End Select
		rs(FldName) = m_DbValue
	End Sub

	' Session Value
	Public Property Get SessionValue()
		SessionValue = Session(EW_PROJECT_NAME & "_" & TblVar & "_" & FldVar & "_SessionValue")
	End Property

	Public Property Let SessionValue(v)
		Session(EW_PROJECT_NAME & "_" & TblVar & "_" & FldVar & "_SessionValue") = v
	End Property
	Dim Count ' Count
	Dim Total ' Total
	Dim TrueValue
	Dim FalseValue

	' AdvancedSearch Object
	Private m_AdvancedSearch

	Public Property Get AdvancedSearch()
		If Not IsObject(m_AdvancedSearch) Then
			Set m_AdvancedSearch = New cAdvancedSearch
		End If
		Set AdvancedSearch = m_AdvancedSearch
	End Property

	' Upload Object
	Private m_Upload

	Public Property Get Upload()
		If Not IsObject(m_Upload) Then
			Set m_Upload = New cUpload
			m_Upload.TblVar = TblVar
			m_Upload.FldVar = FldVar
			m_Upload.UploadMultiple = UploadMultiple
		End If
		Set Upload = m_Upload
	End Property
	Dim UploadPath ' Upload path
	Dim OldUploadPath ' Old upload path (for deleting old image)
	Dim UploadAllowedFileExt ' Allowed file extensions
	Dim UploadMaxFileSize ' Upload max file size
	Dim UploadMaxFileCount ' Upload max file count
	Dim UploadMultiple ' Multiple Upload
	Dim UseColorbox ' Use Colorbox
	Dim PlaceHolder ' Place holder
	Dim AutoFillOriginalValue
	Dim ReqErrMsg

	' Show object as string
	Public Function AsString()
		Dim AdvancedSearchAsString, UploadAsString
		If IsObject(m_AdvancedSearch) Then
			AdvancedSearchAsString = m_AdvancedSearch.AsString
		Else
			AdvancedSearchAsString = "{Null}"
		End If
		If IsObject(m_Upload) Then
			UploadAsString = m_Upload.AsString
		Else
			UploadAsString = "{Null}"
		End If
		AsString = "{" & _
			"FldName: " & FldName & ", " & _
			"FldVar: " & FldVar & ", " & _
			"FldExpression: " & FldExpression & ", " & _
			"FldType: " & FldType & ", " & _
			"FldDateTimeFormat: " & FldDateTimeFormat & ", " & _
			"CssStyle: " & CssStyle & ", " & _
			"CssClass: " & CssClass & ", " & _
			"ImageAlt: " & ImageAlt & ", " & _
			"ImageWidth: " & ImageWidth & ", " & _
			"ImageHeight: " & ImageHeight & ", " & _
			"ImageResize: " & ImageResize & ", " & _
			"ViewCustomAttributes: " & ViewCustomAttributes & ", " & _
			"EditCustomAttributes: " & EditCustomAttributes & ", " & _
			"CellCssStyle: " & CellCssStyle & ", " & _
			"CellCssClass: " & CellCssClass & ", " & _
			"Sort: " & Sort & ", " & _
			"MultiUpdate: " & MultiUpdate & ", " & _
			"CurrentValue: " & CurrentValue & ", " & _
			"ViewValue: " & ViewValue & ", " & _
			"EditValue: " & ValueToString(EditValue) & ", " & _
			"EditValue2: " & ValueToString(EditValue2) & ", " & _
			"HrefValue: " & HrefValue & ", " & _
			"HrefValue2: " & HrefValue2 & ", " & _
			"FormValue: " & m_FormValue & ", " & _
			"QueryStringValue: " & m_QueryStringValue & ", " & _
			"DbValue: " & m_DbValue & ", " & _
			"SessionValue: " & SessionValue & ", " & _
			"Count: " & Count & ", " & _
			"Total: " & Total & ", " & _
			"AdvancedSearch: " & AdvancedSearchAsString & ", " & _
			"Upload: " & UploadAsString & _
			"}"
	End Function

	' Value to string
	Private Function ValueToString(value)
		If IsArray(value) Then
			ValueToString = "[Array]"
		Else
			ValueToString = value
		End If
	End Function

	' Class Initialize
	Private Sub Class_Initialize()
		Count = 0
		Total = 0
		TrueValue = "1"
		FalseValue = "0"
		ImageWidth = 0
		ImageHeight = 0
		ImageResize = False
		UploadPath = EW_UPLOAD_DEST_PATH
		OldUploadPath = EW_UPLOAD_DEST_PATH
		UploadAllowedFileExt = EW_UPLOAD_ALLOWED_FILE_EXT ' Allowed file extensions
		UploadMaxFileSize = EW_MAX_FILE_SIZE ' Upload max file size
		UploadMaxFileCount = EW_MAX_FILE_COUNT ' Upload max file count
		UploadMultiple = False
		UseColorbox = EW_USE_COLORBOX ' Use Colorbox
		Visible = True
		Disabled = False
		Sortable = True
		TruncateMemoRemoveHtml = False
		TooltipWidth = 0
		FldIsVirtual = False
		FldIsDetailKey = False
		Exportable = True
		ExportOriginalValue = EW_EXPORT_ORIGINAL_VALUE
		DisplayValueSeparator = ", "
		PlaceHolder = ""
		AutoFillOriginalValue = EW_AUTO_FILL_ORIGINAL_VALUE
		ReqErrMsg = Language.Phrase("EnterRequiredField")
		Set CellAttrs = New cAttributes ' Cell attributes
		Set EditAttrs = New cAttributes ' Cell attributes
		Set ViewAttrs = New cAttributes ' Cell attributes
		Set LinkAttrs = New cAttributes ' Cell attributes
	End Sub

	' Class terminate
	Private Sub Class_Terminate
		If IsObject(m_AdvancedSearch) Then
			Set m_AdvancedSearch = Nothing
		End If
		If IsObject(m_Upload) Then
			Set m_Upload = Nothing
		End If
		Set CellAttrs = Nothing
		Set EditAttrs = Nothing
		Set ViewAttrs = Nothing
		Set LinkAttrs = Nothing
	End Sub
End Class

'
'  Field class (end)
' -------------------
' --------------------------------------
'  List option collection class (begin)
'
Class cListOptions
	Dim Items
	Dim CustomItem
	Dim Tag
	Dim TagClassName
	Dim TableVar
	Dim RowCnt
	Dim ScriptType
	Dim ScriptId
	Dim ScriptClassName
	Dim JavaScript
	Dim RowSpan
	Dim UseDropDownButton
	Dim UseButtonGroup
	Dim ButtonClass
	Dim GroupOptionName
	Dim DropDownButtonPhrase
	Dim UseImageAndText

	' Class initialize
	Private Sub Class_Initialize
		Set Items = Server.CreateObject("Scripting.Dictionary")
		Tag = "td"
		TagClassName = ""
		TableVar = ""
		RowCnt = ""
		ScriptType = "block"
		ScriptId = ""
		ScriptClassName = ""
		JavaScript = ""
		RowSpan = 1
		UseDropDownButton = False
		UseButtonGroup = False
		ButtonClass = ""
		GroupOptionName = "button"
		DropDownButtonPhrase = ""
		UseImageAndText = False
	End Sub

	' Check visible
	Function Visible()
		Dim i
		For i = 0 to Items.Count - 1
			If Items(i).Visible Then
				Visible = True
				Exit Function
			End If
		Next
		Visible = False
	End Function

	' Check group option visible
	Function GroupOptionVisible()
		Dim i, cnt
		cnt = 0
		For i = 0 To Items.Count - 1
			If Items(i).Name <> GroupOptionName And _
				((Items(i).Visible And Items(i).ShowInDropDown And UseDropDownButton) Or _
				(Items(i).Visible And Items(i).ShowInButtonGroup And UseButtonGroup)) Then
				cnt = cnt + 1
				If UseDropDownButton And cnt > 1 Then
					GroupOptionVisible = True
					Exit Function
				ElseIf UseButtonGroup Then
					GroupOptionVisible = True
					Exit Function
				End If
			End If
		Next
		GroupOptionVisible = False
	End Function

	' Add and return a new option
	Public Function Add(Name)
		Set Add = New cListOption
		Add.Name = Name
		Set Add.Parent = Me
		Items.Add Items.Count, Add
	End Function

	' Load default settings
	Public Sub LoadDefault()
		Dim i
		CustomItem = ""
		For i = 0 to Items.Count - 1
			Items(i).Body = ""
		Next
	End Sub

	' Hide all options
	Public Sub HideAllOptions(Ar)
		Dim i
		For i = 0 to Items.Count - 1
			If IsArray(Ar) Then
				If Not ew_InArray(Items(i).Name, Ar) Then
					Items(i).Visible = False
				End If
			Else
				Items(i).Visible = False
			End If
		Next
	End Sub

	' Show all options
	Public Sub ShowAllOptions()
		Dim i
		For i = 0 to Items.Count - 1
			Items(i).Visible = True
		Next
	End Sub

	' Item count
	Public Function Count()
		Count = Items.Count
	End Function

	' Get item by name
	Public Function GetItem(Name)
		Dim i
		For i = 0 To Items.Count - 1
			If Items.Item(i).Name = Name Then
				Set GetItem = Items.Item(i)
				Exit Function
			End If
		Next
		Set GetItem = Nothing
	End Function

	' Get item position
	Public Function ItemPos(Name)
		Dim pos, i
		pos = 0
		For i = 0 To Items.Count - 1
			If Items(i).Name = Name Then
				ItemPos = pos
				Exit Function
			End If
			pos = pos + 1
		Next
		ItemPos = -1
	End Function

	' Move item to position
	Public Sub MoveItem(Name, Pos)
		Dim i, oldpos, bfound
		If Pos < 0 Then ' If negative, count from the end
			Pos = Items.Count + Pos
		End If
		If Pos < 0 Then Pos = 0
		If Pos >= Items.Count Then
			Pos = Items.Count - 1
		End If
		bfound = False
		For i = 0 To Items.Count - 1
			If Items.Item(i).Name = Name Then
				bfound = True
				oldpos = i
				Exit For
			End If
		Next
		If bfound And Pos <> oldpos Then
			Items.Key(oldpos) = Items.Count ' Move out of position first
			If oldpos < Pos Then ' Shuffle backward
				For i = oldpos+1 to Pos
					Items.Key(i) = i-1
				Next
			Else ' Shuffle forward
				For i = oldpos-1 to Pos Step -1
					Items.Key(i) = i+1
				Next
			End If
			Items.Key(Items.Count) = Pos ' Move to position
		End If
	End Sub

	' Render list options
	Public Sub Render(Part, Pos, OptRowCnt, OptScriptType, OptScriptId, OptScriptClassName)
		Dim groupitem, buttonvalue, buttongroups, cnt, i
		If CustomItem = "" Then
			Set groupitem = GetItem(GroupOptionName)
			If Not groupitem Is Nothing Then
				If ShowPos(groupitem.OnLeft, Pos) Then
					If UseDropDownButton Then ' Render dropdown
						buttonvalue = ""
						cnt = 0
						For i = 0 To Items.Count - 1
							If Items(i).Name <> GroupOptionName And Items(i).Visible And Items(i).ShowInDropDown Then
								buttonvalue = buttonvalue & Items(i).Body
								cnt = cnt + 1
							End If
						Next
						If cnt <= 1 Then
							UseDropDownButton = False ' No need to use drop down button
						Else
							groupitem.Body = RenderDropDownButton(buttonvalue, Pos)
							groupitem.Visible = True
						End If
					End If
					If Not UseDropDownButton And UseButtonGroup Then ' Render button group
						Dim IsVisible
						IsVisible = False
						Set buttongroups = New cCustomArray
						For i = 0 To Items.Count - 1
							If Items(i).Name <> GroupOptionName And Items(i).Visible And Items(i).ShowInButtonGroup And Items(i).Body <> "" Then
								IsVisible = True
								buttonvalue = ew_IIf(UseImageAndText, Items(i).GetImageAndText(Items(i).Body), Items(i).Body)
								If Not buttongroups.Exists(Items(i).ButtonGroupName) Then
									buttongroups.Add Items(i).ButtonGroupName, ""
								End If
								buttonvalue = buttongroups.Item(Items(i).ButtonGroupName) & buttonvalue
								buttongroups.Add Items(i).ButtonGroupName, buttonvalue
							End If
						Next
						groupitem.Body = ""
						For i = 0 to UBound(buttongroups.CustomArray)
							groupitem.Body = groupitem.Body & RenderButtonGroup(buttongroups.CustomArray(i)(1))
						Next
						If IsVisible Then
							groupitem.Visible = True
						End If
					End If
				End If
			End If
		End If
		If ScriptId <> "" Then
			Call RenderEx(Part, Pos, OptRowCnt, "block", OptScriptId, OptScriptClassName) ' Original block for ew_ShowTemplates
			Call RenderEx(Part, Pos, OptRowCnt, "blocknotd", OptScriptId, "")
			Call RenderEx(Part, Pos, OptRowCnt, "single", OptScriptId, "")
		Else
			Call RenderEx(Part, Pos, OptRowCnt, OptScriptType, OptScriptId, OptScriptClassName)
		End If
	End Sub

	Private Sub RenderEx(Part, Pos, OptRowCnt, OptScriptType, OptScriptId, OptScriptClassName)
		RowCnt = OptRowCnt
		ScriptType = OptScriptType
		ScriptId = OptScriptId
		ScriptClassName = OptScriptClassName
		JavaScript = ""
		If ScriptId <> "" Then
			Tag = ew_IIf(ScriptType = "block", "td", "span")
			If ScriptType = "block" Then
				If Part = "header" Then
					Response.Write "<script id=""tpoh_" & ScriptId & """ class=""" & ScriptClassName & """ type=""text/html"">"
				ElseIf Part = "body" Then
					Response.Write "<script id=""tpob" & RowCnt & "_" & ScriptId & """ class=""" & ScriptClassName & """ type=""text/html"">"
				ElseIf Part = "footer" Then
					Response.Write "<script id=""tpof_" & ScriptId & """ class=""" & ScriptClassName & """ type=""text/html"">"
				End If
			ElseIf ScriptType = "blocknotd" Then
				If Part = "header" Then
					Response.Write "<script id=""tpo2h_" & ScriptId & """ class=""" & ScriptClassName & """ type=""text/html"">"
				ElseIf Part = "body" Then
					Response.Write "<script id=""tpo2b" & RowCnt & "_" & ScriptId & """ class=""" & ScriptClassName & """ type=""text/html"">"
				ElseIf Part = "footer" Then
					Response.Write "<script id=""tpo2f_" & ScriptId & """ class=""" & ScriptClassName & """ type=""text/html"">"
				End If
				Response.Write "<span>"
			End If
		Else

			'Tag = ew_IIf(Pos <> "" And Pos <> "bottom", "td", "span")
			Tag = ew_IIf(Pos <> "" And Pos <> "bottom", "td", "div")
		End If
		If CustomItem <> "" Then
			Dim cnt, opt
			cnt = 0
			Set opt = Nothing
			For i = 0 to Items.Count - 1
				If ShowItem(Items(i), ScriptId,  Pos) Then cnt = cnt + 1
				If Items(i).Name = CustomItem Then Set opt = Items(i)
			Next
			Dim bUseButtonGroup, bUseImageAndText
			bUseButtonGroup = UseButtonGroup ' Backup options
			bUseImageAndText = UseImageAndText
			UseButtonGroup = True ' Show button group for custom item
			UseImageAndText = True ' Use image and text for custom item
			If IsObject(opt) And cnt > 0 Then
				If ScriptId <> "" Or ShowPos(opt.OnLeft, Pos) Then
					Response.Write opt.Render(Part, cnt)
				Else
					Response.Write opt.Render("", cnt)
				End If
			End If
			UseButtonGroup = bUseButtonGroup ' Restore options
			UseImageAndText = bUseImageAndText
		Else
			For i = 0 to Items.Count - 1
				If ShowItem(Items(i), ScriptId,  Pos) Then Response.Write Items(i).Render(Part, 1)
			Next
		End If
		If (ScriptType = "block" Or ScriptType = "blocknotd") And ScriptId <> "" Then
			If ScriptType = "blocknotd" Then Response.Write "</span>"
			Response.Write "</scr" + "ipt>"
			If JavaScript <> "" Then Response.Write JavaScript
		End If
	End Sub

	Private Function ShowItem(Item, ScriptId, Pos)
		Dim show
		show = Item.Visible And (ScriptId <> "" Or ShowPos(Item.OnLeft, Pos))
		If show Then
			If UseDropDownButton Then
				show = (Item.Name = GroupOptionName Or Not Item.ShowInDropDown)
			ElseIf UseButtonGroup Then
				show = (Item.Name = GroupOptionName Or Not Item.ShowInButtonGroup)
			End If
		End If
		ShowItem = show
	End Function

	Private Function ShowPos(OnLeft, Pos)
		ShowPos = (OnLeft And Pos = "left") Or (Not OnLeft And Pos = "right") Or (Pos = "") Or (Pos = "bottom")
	End Function

	' Concat options and return concatenated HTML
	' - pattern - regular expression pattern for matching the option names, e.g. '/^detail_/'
	Public Function Concat(pattern, separator)
		Dim sWrk, i
		sWrk = ""
		For i = 0 to Items.Count - 1
			If ew_RegExTest(pattern, Items(i).Name) And Items(i).Body <> "" Then
				If sWrk <> "" Then sWrk = sWrk & separator
				sWrk = sWrk & Items(i).Body
			End If
		Next
		Concat = sWrk
	End Function

	' Merge options to the first option and return it
	' - pattern - regular expression pattern for matching the option names, e.g. "^detail_"
	Public Function Merge(pattern, separator)
		Dim sWrk, i, first
		sWrk = ""
		Set first = Nothing
		For i = 0 to Items.Count - 1
			If ew_RegExTest(pattern, Items(i).Name) Then
				If first Is Nothing Then
					Set first = Items(i)
					first.Body = Concat(pattern, separator)
				Else
					Items(i).Visible = False
				End If
			End If
		Next
		Set Merge = first
	End Function

	' Get button group link
	Public Function RenderButtonGroup(body)

		' Get all hidden inputs
		' format: <input type="hidden" ...>

		Dim inputs, inputmatches, i
		inputs = ""
		If ew_RegExMatch("<input\s+([^>]*)>", body, inputmatches) Then
			For i = 0 to inputmatches.Count - 1
				body = Replace(body, inputmatches(i), "", 1, 1)
				If ew_RegExTest("type\s*=\s*[\'""]hidden[\'""]", inputmatches(i).SubMatches(0)) Then
					If IsArray(inputs) Then
						ReDim Preserve inputs(UBound(inputs)+1)
					Else
						ReDim inputs(0)
					End If
					inputs(UBound(inputs)) = inputmatches(i)
				End If
			Next
		End If

		' Get all buttons
		' format: <div class="btn-group">...</div>

		Dim btns, btnmatches
		btns = ""
		If ew_RegExMatch("<div\s+class\s*=\s*[\'""]btn-group[\'""]([^>]*)>([\s\S]*?)<\/div\s*>", body, btnmatches) Then
			For i = 0 to btnmatches.Count - 1
				body = Replace(body, btnmatches(i), "", 1, 1)
				If IsArray(btns) Then
					ReDim Preserve btns(UBound(btns)+1)
				Else
					ReDim btns(0)
				End If
				btns(UBound(btns)) = btnmatches(i)
			Next
		End If
		Dim link, links, matches, submatches, tag, classname, attrs, caption, btngroup
		links = ""

		' Get all links/buttons
		' format: <a ...>...</a> / <button ...>...</button>

		If ew_RegExMatch("<(a|button)([^>]*)>([\s\S]*?)<\/(a|button)\s*>", body, matches) Then
			For i = 0 to matches.Count - 1
				tag = matches(i).SubMatches(0)
				If ew_RegExMatch("\s+class\s*=\s*[\'""]([\s\S]*?)[\'""]", matches(i).SubMatches(1), submatches) Then ' Match class='class'
					classname = submatches(0).SubMatches(0)
					attrs = Replace(matches(i).SubMatches(1), submatches(0), "", 1, 1)
				Else
					classname = ""
					attrs = matches(i).SubMatches(1)
				End If
				caption = matches(i).SubMatches(2)
				If InStr(classname, "btn btn-default") <= 0 Then ' Prepend button classes
					Call ew_PrependClass(classname, "btn btn-default")
				End If
				If ButtonClass <> "" Then
					Call ew_AppendClass(classname, ButtonClass)
				End If
				attrs = " class=""" & classname & """ " & attrs
 				link = "<" & tag & attrs & ">" & caption & "</" & tag & ">"
				links = links & link
			Next
		End If
		If links <> "" Then
			btngroup = "<div class=""btn-group ewButtonGroup"">" & links & "</div>"
		Else
			btngroup = ""
		End If
		If IsArray(btns) Then
			For i = 0 to UBound(btns)
				btngroup = btngroup & btns(i)
			Next
		End If
		If IsArray(inputs) Then
			For i = 0 to UBound(inputs)
				btngroup = btngroup & inputs(i)
			Next
		End If
		RenderButtonGroup = btngroup
	End Function

	' Render drop down button
	Public Function RenderDropDownButton(body, pos)

		' Get all hidden inputs
		' format: <input type="hidden" ...>

		Dim inputs, btnmatches, inputmatches, i, previewlinks
		inputs = ""
		If ew_RegExMatch("<input\s+([^>]*)>", body, inputmatches) Then
			For i = 0 to inputmatches.Count - 1
				body = Replace(body, inputmatches(i), "", 1, 1)
				If ew_RegExTest("type\s*=\s*[\'""]hidden[\'""]", inputmatches(i).SubMatches(0)) Then
					If IsArray(inputs) Then
						ReDim Preserve inputs(UBound(inputs)+1)
					Else
						ReDim inputs(0)
					End If
					inputs(UBound(inputs)) = inputmatches(i)
				End If
			Next
		End If

		' Remove all <div class="hide ewPreview">...</div>
		previewlinks = ""
		If ew_RegExMatch("<div\s+class\s*=\s*[\'""]hide\s+ewPreview[\'""]>([\s\S]*?)(<div([^>]*)>([\s\S]*?)<\/div\s*>)+([\s\S]*?)<\/div\s*>", body, inputmatches) Then
			For i = 0 to inputmatches.Count - 1
				body = Replace(body, inputmatches(i), "", 1, 1)
				previewlinks = previewlinks & inputmatches(i)
			Next
		End If

		' Remove toggle button first <button ... data-toggle="dropdown">...</button>
		If ew_RegExMatch("<button\s+([\s\S]*?)data-toggle\s*=\s*[\'""]dropdown[\'""]\s*>([\s\S]*?)<\/button\s*>", body, btnmatches) Then
			For i = 0 to btnmatches.Count - 1
				body = Replace(body, btnmatches(i), "", 1, 1)
			Next
		End If

		' Get all links/buttons <a ...>...</a> / <button ...>...</button>
		Dim matches, actionmatches, submatches, link, links, submenu, submenulink, submenulinks, action, classname, attrs, caption
		If ew_RegExMatch("<(a|button)([^>]*)>([\s\S]*?)<\/(a|button)\s*>", body, matches) Then
			links = ""
			submenu = False
			submenulink = ""
			submenulinks = ""
			For i = 0 to matches.Count - 1
				tag = matches(i).SubMatches(0)
				If ew_RegExMatch("\s+data-action\s*=\s*[\'""]([\s\S]*?)[\'""]", matches(i).SubMatches(1), actionmatches) Then ' Match data-action='action'
					action = actionmatches(0).SubMatches(0)
				Else
					action = ""
				End If
				If ew_RegExMatch("\s+class\s*=\s*[\'""]([\s\S]*?)[\'""]", matches(i).SubMatches(1), submatches) Then ' Match class='class'
					classname = ew_RegExReplace("btn[\S]*\s+", submatches(0).SubMatches(0), "")
					attrs = Replace(matches(i).SubMatches(1), submatches(0), "", 1, 1)
				Else
					classname = ""
					attrs = matches(i).SubMatches(1)
				End If
				attrs = ew_RegExReplace("\s+title\s*=\s*[\'""]([\s\S]*?)[\'""]", attrs, "") ' Remove title='title'
				If ew_RegExMatch("\s+data-caption\s*=\s*[\'""]([\s\S]*?)[\'""]", attrs, submatches) Then ' Match data-caption='caption'
					caption = submatches(0).SubMatches(0)
				Else
					caption = ""
				End If
				attrs = " class=""" & classname & """ " & attrs
				If LCase(tag) = "button" Then ' Add href for button
					attrs = attrs & " href=""javascript:void(0);"""
				End If
				If UseImageAndText Then ' Image and text
					If ew_RegExMatch("<img([^>]*)>", matches(i).SubMatches(2), submatches) Then ' <img> tag
						caption = submatches(0) & "&nbsp;&nbsp;" & caption
					ElseIf ew_RegExMatch("<span([^>]*)>([\s\S]*?)<\/span\s*>", matches(i).SubMatches(2), submatches) Then ' <span class='class'></span> tag
						If ew_RegExTest("\s+class\s*=\s*[\'""]([\s\S]*?)[\'""]", submatches(0)) Then ' Match class='class'
							caption = submatches(0) & "&nbsp;&nbsp;" & caption
						End If
					End If
				End If
				If caption = "" Then
					caption = matches(i).SubMatches(2)
				End If
				link = "<a" & attrs & ">" & caption & "</a>"
				If action = "list" Then ' Start new submenu
					If submenu Then ' End previous submenu
						If submenulinks <> "" Then ' Set up submenu
							links = links & "<li class=""dropdown-submenu"">" & submenulink & "<ul class=""dropdown-menu"">" & submenulinks & "</ul></li>"
						Else
							links = links & "<li>" & submenulink & "</li>"
						End If
					End If
					submenu = True
					submenulink = link
					submenulinks = ""
				Else
					If action = "" And submenu Then ' End previous submenu
						If submenulinks <> "" Then ' Set up submenu
							links = links & "<li class=""dropdown-submenu"">" & submenulink & "<ul class=""dropdown-menu"">" & submenulinks & "</ul></li>"
						Else
							links = links & "<li>" & submenulink & "</li>"
						End If
						submenu = False
					End If
					If submenu Then
						submenulinks = submenulinks & "<li>" & link & "</li>"
					Else
						links = links & "<li>" & link & "</li>"
					End If
				End If
			Next
			Dim btnclass, button, btndropdown, btntitle
			If links <> "" Then
				If submenu Then ' End previous submenu
					If submenulinks <> "" Then ' Set up submenu
						links = links & "<li class=""dropdown-submenu"">" & submenulink & "<ul class=""dropdown-menu"">" & submenulinks & "</ul></li>"
					Else
						links = links & "<li>" & submenulink & "</li>"
					End If
				End If
				btnclass = "dropdown-toggle btn btn-default"
				If ButtonClass <> "" Then
					Call ew_AppendClass(btnclass, ButtonClass)
				End If
				btntitle = ew_HtmlTitle(DropDownButtonPhrase)
				btntitle = ew_IIf(DropDownButtonPhrase <> btntitle, " title=""" & btntitle & """", "")
				button = "<button class=""" & btnclass & """" & btntitle & " data-toggle=""dropdown"">" & DropDownButtonPhrase & "<b class=""caret""></b></button><ul class=""dropdown-menu ewMenu"">" & links & "</ul>"
				If pos = "bottom" Then ' Use dropup
					btndropdown = "<div class=""btn-group dropup ewButtonDropdown"">" & button & "</div>"
				Else
					btndropdown = "<div class=""btn-group ewButtonDropdown"">" & button & "</div>"
				End If
			Else
				btndropdown = ""
			End If
			If IsArray(inputs) Then
				For i = 0 to UBound(inputs)
					btndropdown = btndropdown & inputs(i)
				Next
			End If
			btndropdown = btndropdown & previewlinks
			RenderDropDownButton = btndropdown
		Else
			RenderDropDownButton = ""
		End If
	End Function

	' Class terminate
	Private Sub Class_Terminate
		Dim i
		For i = 0 To Items.Count - 1
			Set Items.Item(i) = Nothing
		Next
	End Sub
End Class

'
'  List option collection class (end)
' ------------------------------------
'
' ---------------------------
'  List option class (begin)
'
Class cListOption
	Dim Name
	Dim OnLeft
	Dim CssStyle
	Dim CssClass
	Dim Visible
	Dim Header
	Dim Body
	Dim Footer
	Dim Parent
	Dim ShowInButtonGroup
	Dim ShowInDropDown
	Dim ButtonGroupName

	' Class initialize
	Private Sub Class_Initialize
		OnLeft = False
		Visible = True
		ShowInButtonGroup = True
		ShowInDropDown = True
		ButtonGroupName = "_default"
	End Sub

	Public Sub MoveTo(Pos)
		Parent.MoveItem Name, Pos
	End Sub

	Public Function Render(Part, ColSpan)
		Dim value, res, tag, tagname, tagclass, attrs, js
		tagclass = Parent.TagClassName
		If Part = "header" Then
			If tagclass = "" Then tagclass = "ewListOptionHeader"
			value = Header
		ElseIf Part = "body" Then
			If tagclass = "" Then tagclass = "ewListOptionBody"
			If Parent.Tag <> "td" Then
				Call ew_AppendClass(tagclass, "ewListOptionSeparator")
			End If
			value = Body
		ElseIf Part = "footer" Then
			If tagclass = "" Then tagclass = "ewListOptionFooter"
			value = Footer
		Else
			value = Part
		End If
		If value = "" And Parent.Tag = "span" And Parent.ScriptId = "" Then
			Render = ""
			Exit Function
		End If
		res = ew_IIf(value <> "", value, "&nbsp;")
		Call ew_AppendClass(tagclass, CssClass)
		attrs = Array(Array("class", tagclass), Array("style", CssStyle), Array("data-name", Name))
		If LCase(Parent.Tag) = "td" And Parent.RowSpan > 1 Then
			attrs = ew_MergeAttrs(attrs, Array(Array("rowspan", Parent.RowSpan)))
		End If
		If LCase(Parent.Tag) = "td" And ColSpan > 1 Then
			attrs = ew_MergeAttrs(attrs, Array(Array("colspan", ColSpan)))
		End If
		tagname = Parent.TableVar & "_" & Name
		If Name <> Parent.GroupOptionName Then
			If Not ew_InArray(Name, Array("checkbox", "rowcnt")) Then
				If Parent.UseImageAndText Then
					res = GetImageAndText(res)
				End If
				If Parent.UseButtonGroup And ShowInButtonGroup Then
					res = Parent.RenderButtonGroup(res)
					If OnLeft And LCase(Parent.Tag) = "td" And ColSpan > 1 Then
						res = "<div style=""text-align: right"">" & res & "</div>"
					End If
				End If
			End If
			If Part = "header" Then
				res = "<span id=""elh_" & tagname & """ class=""" & tagname & """>" & res & "</span>"
			ElseIf Part = "body" Then
				res = "<span id=""el" & Parent.RowCnt & "_" & tagname & """ class=""" & tagname & """>" & res & "</span>"
			ElseIf Part = "footer" Then
				res = "<span id=""elf_" & tagname & """ class=""" & tagname & """>" & res & "</span>"
			End If
		End If
		tag = ew_IIf(Parent.Tag = "td" And Part = "header", "th", Parent.Tag)
		If Parent.UseButtonGroup And ShowInButtonGroup Then
			attrs = ew_MergeAttrs(attrs, Array(Array("style", "white-space: nowrap;")))
		End If
		res = ew_HtmlElement(tag, attrs, res, True)
		If Parent.ScriptId <> "" Then
			js = ew_ExtractScript(res, Parent.ScriptClassName & "_js")
			If Parent.ScriptType = "single" Then
				If Part = "header" Then
					res = "<scr" & "ipt id=""tpoh_" & Parent.ScriptId & "_" & Name & """ type=""text/html"">" & res & "</scr" & "ipt>"
				ElseIf Part = "body" Then
					res = "<scr" & "ipt id=""tpob" & Parent.RowCnt & "_" & Parent.ScriptId & "_" & Name & """ type=""text/html"">" & res & "</scr" & "ipt>"
				ElseIf Part = "footer" Then
					res = "<scr" & "ipt id=""tpof_" & Parent.ScriptId & "_" & Name & """ type=""text/html"">" & res & "</scr" & "ipt>"
				End If
			End If
			If js <> "" Then
				If Parent.ScriptType = "single" Then
					res = res & js
				Else
					Parent.JavaScript = Parent.JavaScript & js
				End If
			End If
		End If
		Render = res
	End Function

	' Get image and text link
	Function GetImageAndText(body)
		Dim matches, submatches, i, caption
		If ew_RegExMatch("<a([^>]*)>([\s\S]*?)<\/a\s*>", body, matches) Then
			For i = 0 to matches.Count - 1
				If ew_RegExMatch("\s+data-caption\s*=\s*[\'""]([\s\S]*?)[\'""]", matches(i).SubMatches(0), submatches) Then ' Match data-caption='caption'
					caption = submatches(0).SubMatches(0)
					If ew_RegExTest("<img([^>]*)>", matches(i).SubMatches(1)) Then ' Image and text
						body = Replace(body, matches(i).SubMatches(1), matches(i).SubMatches(1) & "&nbsp;&nbsp;" & caption, 1, 1)
					End If
				End If
			Next
		End If
		GetImageAndText = body
	End Function

	' Convert to string
	Public Function AsString
		AsString = "{" & _
			"Name: " & Name & ", " & _
			"OnLeft: " & OnLeft & ", " & _
			"CssStyle: " & CssStyle & ", " & _
			"CssClass: " & CssClass & ", " & _
			"Visible: " & Visible & ", " & _
			"Header: " & Server.HTMLEncode(Header) & ", " & _
			"Body: " & Server.HTMLEncode(Body) & ", " & _
			"Footer: " & Server.HTMLEncode(Footer) & _
			"}"
	End Function
End Class

'
'  List option class (end)
' -------------------------
' Output SCRIPT tag
Sub ew_AddClientScript(src)
	ew_AddClientScriptEx src, Null
End Sub

' Output SCRIPT tag
Sub ew_AddClientScriptEx(src, attrs)
	Dim atts
	atts = Array(Array("type", "text/javascript"), Array("src", src))
	If IsArray(attrs) Then
		atts = ew_MergeAttrs(atts, attrs)
	End If
	Response.Write ew_HtmlElement("script", atts, "", True) & vbCrLf
End Sub

' Output LINK tag
Sub ew_AddStylesheet(href)
	ew_AddStylesheetEx href, Null
End Sub

' Output LINK tag
Sub ew_AddStylesheetEx(href, attrs)
	Dim atts
	atts = Array(Array("rel", "stylesheet"), Array("type", "text/css"), Array("href", href))
	If IsArray(attrs) Then
		atts = ew_MergeAttrs(atts, attrs)
	End If
	Response.Write ew_HtmlElement("link", atts, "", False) & vbCrLf
End Sub

Function ew_MergeAttrs(attrs1, attrs2)
	Dim attrs, i, cnt, idx
	cnt = 0
	If IsArray(attrs1) Then cnt = cnt + UBound(attrs1) + 1
	If IsArray(attrs2) Then cnt = cnt + UBound(attrs1) + 1
	If cnt > 0 Then
		ReDim attrs(cnt-1)
		idx = 0
		If IsArray(attrs1) Then
			For i = 0 to UBound(attrs1)
				attrs(idx) = attrs1(i)
				idx = idx + 1
			Next
		End If
		If IsArray(attrs2) Then
			For i = 0 to UBound(attrs2)
				attrs(idx) = attrs2(i)
				idx = idx + 1
			Next
		End If
	End If
	ew_MergeAttrs = attrs
End Function

' XML tag name
Function ew_XmlTagName(name)
	Dim wrkname
	wrkname = Trim(name)

	'If Not ew_RegExTest("\A(?!XML)[a-z][\w0-9-]*", wrkname) Then
	If Not ew_RegExTest("[a-z][\w0-9-]*", wrkname) Then
		wrkname = "_" & wrkname
	End If
	ew_XmlTagName = wrkname
End Function

' Generate random number
Function ew_Random()
	Randomize()
	ew_Random = ew_ZeroPad(CLng(1000000 * Rnd()),6)
End Function

' Load embedded images from content
' - format for email: <img src="cid:..." ...>
' - format for pdf: <img src="...ew_tmp_nnnnnn.*" ...>
Sub ew_LoadEmbeddedImages(content)
	Dim m, m1, i, j, src, fn, sid, valid
	sid = "s" & Session.SessionID
	If ew_RegExMatch("<img([^>]*)>", content, m) Then
		For i = 0 to m.Count - 1
			If ew_RegExMatch("\s+src\s*=\s*[\'""]([\s\S]*?)[\'""]", m(i).SubMatches(0), m1) Then
				src = m1(0).SubMatches(0)
				If Left(src, 4) = "cid:" Then
					fn = Mid(src, 5)
					valid = True
				Else
					fn = src
					If InStrRev(fn, "/") > 0 Then fn = Mid(fn, InStrRev(fn, "/")+1)
					valid = (Left(fn,Len(sid)) = sid)
				End If
				If valid Then
					If IsArray(gTmpImages) Then
						ReDim Preserve gTmpImages(UBound(gTmpImages)+1)
					Else
						ReDim gTmpImages(0)
					End If
					gTmpImages(UBound(gTmpImages)) = fn
				End If
			End If
		Next
	End If
End Sub

' Save text data to file
Function ew_SaveTextFile(folder, fn, filedata)
	On Error Resume Next
	Dim oStream
	ew_SaveTextFile = False
	If ew_CreateFolder(folder) Then
		Set oStream = Server.CreateObject("ADODB.Stream")
		oStream.Type = 2 ' 2=adTypeText
		oStream.Open
		oStream.Charset = "UTF-8"
		oStream.WriteText = filedata
		oStream.SaveToFile folder & fn, 2 ' 2=adSaveCreateOverwrite
		oStream.Close
		Set oStream = Nothing
		If Err.Number = 0 Then ew_SaveTextFile = True
	End If
End Function

' Load binary file
Function ew_LoadBinaryFile(FilePath)
	On Error Resume Next
	Dim objStream
	Set objStream = Server.CreateObject("ADODB.Stream")
	With objStream
		.Type = 1 ' adTypeBinary
		.Open
		.LoadFromFile FilePath
		ew_LoadBinaryFile = .Read
		.Close
	End With
End Function

' Create temp image file from binary data
Function ew_TmpImage(filedata)
	Dim export, tmpimage
	export = ""
	If Request.QueryString("export").Count > 0 Then
		export = Request.QueryString("export")
	ElseIf ew_IsHttpPost() Then
		If Request.Form("export").Count > 0 Then
			export = Request.Form("export")
		ElseIf Request.Form("exporttype").Count > 0 Then
			export = Request.Form("exporttype")
		End If
	End If
	tmpimage = ew_CreateTmpImage(filedata)
	If tmpimage <> "" Then
		If IsArray(gTmpImages) Then
			ReDim Preserve gTmpImages(UBound(gTmpImages)+1)
		Else
			ReDim gTmpImages(0)
		End If
		gTmpImages(UBound(gTmpImages)) = tmpimage
		ew_TmpImage = ew_TmpImageLnk(tmpimage, export)
	Else
		ew_TmpImage = ""
	End If
End Function

' Create temp image
Function ew_CreateTmpImage(filedata)
	Dim tmpimage, imageext, folder
	imageext = ew_ContentExt(filedata)
	tmpimage = ew_TmpImageFileName(imageext)
	folder = ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH)
	If ew_SaveFile(folder, tmpimage, filedata) Then
		ew_CreateTmpImage = tmpimage
	Else
		ew_CreateTmpImage = ""
	End If
End Function

' Get temp image file name
Function ew_TmpImageFileName(ext)
	Dim fn, folder, fso
	If Left(ext, 1) <> "." Then ext = "." & ext
	fn = "s" & Session.SessionID & ew_Random() & ext
	folder = ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH)
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	Do While fso.FileExists(folder & fn)
		fn = "s" & Session.SessionID & ew_Random() & ext
	Loop
	Set fso = Nothing
	ew_TmpImageFileName = fn
End Function

' Delete temp images
Sub ew_DeleteTmpImages()
	Dim i, fso, f
	If IsArray(gTmpImages) Then
		Set fso = CreateObject("Scripting.FileSystemObject")
		For i = 0 to UBound(gTmpImages)
			f = ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH) & gTmpImages(i)
			If fso.FileExists(f) Then
				fso.DeleteFile(f)
			End If
		Next
		Set fso = Nothing
	End If
End Sub

' Get temp image link
Function ew_TmpImageLnk(file, lnktype)
	Dim ar, i, lnk, path
	path = EW_UPLOAD_DEST_PATH
	If file = "" Then
		ew_TmpImageLnk = ""
	ElseIf lnktype = "email" Or lnktype = "cid" Then
		lnk = file
		If lnktype = "email" Then lnk = "cid:" & lnk
		ew_TmpImageLnk = lnk
	ElseIf lnktype = "pdf" Then ' Use full url
		If EW_ROOT_RELATIVE_PATH <> "." Then path = ew_PathCombine(ew_IncludeTrailingDelimiter(EW_ROOT_RELATIVE_PATH, False), ew_IncludeTrailingDelimiter(path, False), False)
		ew_TmpImageLnk = ew_ConvertFullUrl(ew_IncludeTrailingDelimiter(path, False) & file)
	Else
		ew_TmpImageLnk = ew_IncludeTrailingDelimiter(path, False) & file
	End If
End Function

' Get Hash Url
Function ew_GetHashUrl(url, hash)
	ew_GetHashUrl = url & "#" & hash
End Function
%>
<%

' ----------------------------
'  Basic Search class (begin)
'
Class cBasicSearch
	Dim TblVar
	Dim Keyword
	Dim KeywordDefault
	Dim SearchType
	Dim SearchTypeDefault

	Private Property Get Prefix()
		Prefix = EW_PROJECT_NAME & "_" & TblVar & "_"
	End Property

	' Session variable name
	Private Function GetSessionName(suffix)
		GetSessionName = Prefix & suffix
	End Function

	' Load default
	Sub LoadDefault()
		Keyword = KeywordDefault
		SearchType = SearchTypeDefault
	End Sub

	' Unset session
	Sub UnsetSession()
		Session.Contents.Remove(GetSessionName(EW_TABLE_BASIC_SEARCH_TYPE))
		Session.Contents.Remove(GetSessionName(EW_TABLE_BASIC_SEARCH))
	End Sub

	' Isset session
	Function IssetSession()
		IssetSession = Not IsEmpty(Session(GetSessionName(EW_TABLE_BASIC_SEARCH)))
	End Function

	' Save to session
	Sub setKeyword(v)
		Keyword = v
		Session(GetSessionName(EW_TABLE_BASIC_SEARCH)) = v
	End Sub

	Sub setSearchType(v)
		SearchType = v
		Session(GetSessionName(EW_TABLE_BASIC_SEARCH_TYPE)) = v
	End Sub

	Sub Save()
		Session(GetSessionName(EW_TABLE_BASIC_SEARCH)) = Keyword
		Session(GetSessionName(EW_TABLE_BASIC_SEARCH_TYPE)) = SearchType
	End Sub

	' Load from session
	Function getKeyword()
		getKeyword = Session(GetSessionName(EW_TABLE_BASIC_SEARCH))
	End Function

	Function getSearchType()
		getSearchType = Session(GetSessionName(EW_TABLE_BASIC_SEARCH_TYPE))
	End Function

	Function getSearchTypeName()
		Dim typ, typname
		typ = getSearchType()
		Select Case typ
			Case "=":   typname = Language.Phrase("QuickSearchExact")
			Case "AND": typname = Language.Phrase("QuickSearchAll")
			Case "OR":  typname = Language.Phrase("QuickSearchAny")
			Case Else:  typname = Language.Phrase("QuickSearchAuto")
		End Select
		getSearchTypeName = typname
	End Function

	Function getSearchTypeNameShort()
		Dim typ, typname
		typ = getSearchType()
		Select Case typ
			Case "=":   typname = Language.Phrase("QuickSearchExactShort")
			Case "AND": typname = Language.Phrase("QuickSearchAllShort")
			Case "OR":  typname = Language.Phrase("QuickSearchAnyShort")
			Case Else:  typname = Language.Phrase("QuickSearchAutoShort")
		End Select
		If typname <> "" Then typname = typname & "&nbsp;"
		getSearchTypeNameShort = typname
	End Function

	Sub Load()
		Keyword = getKeyword()
		SearchType = getSearchType()
	End Sub

	' Class initialize
	Private Sub Class_Initialize
		Keyword = ""
		KeywordDefault = ""
		SearchType = ""
		SearchTypeDefault = ""
	End Sub
End Class

'
'  Basic Search class (end)
' --------------------------
' -------------------------------
'  Advanced Search class (begin)
'
Class cAdvancedSearch
	Dim TblVar
	Dim FldVar
	Dim SearchValue ' Search value
	Dim SearchOperator ' Search operator
	Dim SearchCondition ' Search condition
	Dim SearchValue2 ' Search value 2
	Dim SearchOperator2 ' Search operator 2
	Dim SearchValueDefault ' Search value default
	Dim SearchOperatorDefault ' Search operator default
	Dim SearchConditionDefault ' Search condition default
	Dim SearchValue2Default ' Search value 2 default
	Dim SearchOperator2Default ' Search operator 2 default

	Private Property Get Prefix()
		Prefix = EW_PROJECT_NAME & "_" & TblVar & "_" & EW_TABLE_ADVANCED_SEARCH & "_"
	End Property

	Private Property Get Suffix()
		Suffix = "_" & Mid(FldVar, 3)
	End Property

	' Session variable name
	Private Function GetSessionName(infix)
		GetSessionName = Prefix & infix & Suffix
	End Function

	' Unset session
	Sub UnsetSession()
		Session.Contents.Remove(GetSessionName("x"))
		Session.Contents.Remove(GetSessionName("z"))
		Session.Contents.Remove(GetSessionName("v"))
		Session.Contents.Remove(GetSessionName("y"))
		Session.Contents.Remove(GetSessionName("w"))
	End Sub

	' Isset session
	Function IssetSession()
		IssetSession = Not IsEmpty(Session(GetSessionName("x"))) Or _
			Not IsEmpty(Session(GetSessionName("y")))
	End Function

	' Save to session
	Sub Save()
		If Session(GetSessionName("x")) <> SearchValue Then
			Session(GetSessionName("x")) = SearchValue
		End If
		If Session(GetSessionName("y")) <> SearchValue2 Then
			Session(GetSessionName("y")) = SearchValue2
		End If
		If Session(GetSessionName("z")) <> SearchOperator Then
			Session(GetSessionName("z")) = SearchOperator
		End If
		If Session(GetSessionName("v")) <> SearchCondition Then
			Session(GetSessionName("v")) = SearchCondition
		End If
		If Session(GetSessionName("w")) <> SearchOperator2 Then
			Session(GetSessionName("w")) = SearchOperator2
		End If
	End Sub

	' Load from session
	Sub Load()
		SearchValue = Session(GetSessionName("x"))
		SearchOperator = Session(GetSessionName("z"))
		SearchCondition = Session(GetSessionName("v"))
		SearchValue2 = Session(GetSessionName("y"))
		SearchOperator2 = Session(GetSessionName("w"))
	End Sub

	Function getValue(infix)
		getValue = Session(GetSessionName(infix))
	End Function

	' Load default values
	Sub LoadDefault()
		If SearchValueDefault <> "" Then SearchValue = SearchValueDefault
		If SearchOperatorDefault <> "" Then SearchOperator = SearchOperatorDefault
		If SearchConditionDefault <> "" Then SearchCondition = SearchConditionDefault
		If SearchValue2Default <> "" Then SearchValue2 = SearchValue2Default
		If SearchOperator2Default <> "" Then SearchOperator2 = SearchOperator2Default
	End Sub

	' Class initialize
	Private Sub Class_Initialize
		SearchValueDefault = ""
		SearchOperatorDefault = ""
		SearchConditionDefault = ""
		SearchValue2Default = ""
		SearchOperator2Default = ""
	End Sub

	' Show object as string
	Public Function AsString()
		AsString = "{" & _
			"SearchValue: " & SearchValue & ", " & _
			"SearchOperator: " & SearchOperator & ", " & _
			"SearchCondition: " & SearchCondition & ", " & _
			"SearchValue2: " & SearchValue2 & ", " & _
			"SearchOperator2: " & SearchOperator2 & _
			"}"
	End Function
End Class

'
'  Advanced Search class (end)
' -----------------------------

%>
<%

' ----------------------
'  Upload class (begin)
'
Class cUpload
	Dim Index ' Index to handle multiple form elements
	Dim TblVar ' Table variable
	Dim FldVar ' Field variable
	Dim Message ' Error message
	Dim DbValue ' Value from database
	Dim Value ' Upload value
	Dim FileName ' Upload file name
	Dim FileSize ' Upload file size
	Dim ContentType ' File content type
	Dim ImageWidth ' Image width
	Dim ImageHeight ' Image height
	Dim UploadMultiple ' Multiple upload
	Dim KeepFile ' Keep old file

	' Class initialize
	Private Sub Class_Initialize
		Index = -1
		UploadMultiple = False ' Multiple upload
		KeepFile = False ' Keep old file
	End Sub

	' Function to check the file type of the uploaded file
	Private Function UploadAllowedFileExt(FileName)
		If Trim(FileName & "") = "" Then
			UploadAllowedFileExt = True
			Exit Function
		End If
		Dim Ext, Pos, arExt, FileExt
		arExt = Split(EW_UPLOAD_ALLOWED_FILE_EXT & "", ",")
		Ext = ""
		Pos = InStrRev(FileName, ".")
		If Pos > 0 Then	Ext = Mid(FileName, Pos+1)
		UploadAllowedFileExt = False
		For Each FileExt in arExt
	 		If LCase(Trim(FileExt)) = LCase(Ext) Then
				UploadAllowedFileExt = True
				Exit For
			End If
		Next
	End Function

	' Get upload file
	Public Function UploadFile()

		' Initialize upload value
		Value = Null
		Dim fvar, wrkvar, f, fso
		fvar = ew_IIf(Index < 0, FldVar, Mid(FldVar, 1, 1) & Index & Mid(FldVar, 2))
		wrkvar = "fn_" & fvar
		FileName = Request.Form(wrkvar) ' Get file name
		wrkvar = "fa_" & fvar
		KeepFile = (Request.Form(wrkvar) = "1") ' Check if keep old file
		If Not KeepFile And FileName <> "" And Not UploadMultiple Then
			f = ew_IncludeTrailingDelimiter(ew_UploadTempPath(fvar), True) & FileName
			Set fso = Server.CreateObject("Scripting.FileSystemObject")
			If fso.FileExists(f) Then
				Value = ew_LoadBinaryFile(f)
				FileSize = LenB(Value)
				ContentType = ew_ContentType(LeftB(Value, 11), f)
				Call ew_GetImageDimension(Value, ImageWidth, ImageHeight)
			End If
		End If
		UploadFile = True ' Normal return
	End Function

	' Resize image
	Public Function Resize(Width, Height, Interpolation)
		Dim wrkWidth, wrkHeight
		If Not IsNull(Value) Then
			wrkWidth = Width
			wrkHeight = Height
			If ew_ResizeBinary(Value, wrkWidth, wrkHeight, Interpolation) Then
				If wrkWidth > 0 And wrkHeight > 0 Then
					ImageWidth = wrkWidth
					ImageHeight = wrkHeight
				End If
				FileSize = LenB(Value)
			End If
		End If
	End Function

	' Save uploaded data to file (Path relative to application root)
	Public Function SaveToFile(Path, NewFileName, Overwrite)
		SaveToFile = False
		If Not IsNull(Value) Then
			Path = ew_UploadPathEx(True, Path)
			If Trim(NewFileName & "") = "" Then NewFileName = FileName
			If Not OverWrite Then
				NewFileName = ew_UploadFileNameEx(Path, NewFileName)
			End If
			FileName = NewFileName
			SaveToFile = ew_SaveFile(Path, NewFileName, Value)
		End If
	End Function

	' Resize and save uploaded data to file (Path relative to application root)
	Public Function ResizeAndSaveToFile(Width, Height, Interpolation, Path, NewFileName, Overwrite)
		Dim OldValue, OldWidth, OldHeight, OldFileSize
		ResizeAndSaveToFile = False
		If Not IsNull(Value) Then
			OldValue = Value: OldWidth = ImageWidth: OldHeight = ImageHeight: OldFileSize = FileSize ' Save old values
			Call Resize(Width, Height, Interpolation)
			ResizeAndSaveToFile = SaveToFile(Path, NewFileName, Overwrite)
			Value = OldValue: ImageWidth = OldWidth: ImageHeight = OldHeight: FileSize = OldFileSize ' Restore old values
		End If
	End Function

	' Show object as string
	Public Function AsString()
		AsString = "{" & _
			"Index: " & Index & ", " & _
			"Message: " & m_Message & ", " & _
			"FileName: " & m_FileName & ", " & _
			"FileSize: " & m_FileSize & ", " & _
			"ContentType: " & m_ContentType & ", " & _
			"ImageWidth: " & m_ImageWidth & ", " & _
			"ImageHeight: " & m_ImageHeight & _
			"}"
	End Function
End Class

'
'  Upload class (end)
' --------------------

%>
<%

' ---------------------------------
'  Advanced Security class (begin)
'
Class cAdvancedSecurity
	Dim m_ArUserLevel
	Dim m_ArUserLevelPriv
	Dim m_ArUserLevelID

	' Current user level id / user level
	Dim CurrentUserLevelID
	Dim CurrentUserLevel

	' Current user id / parent user id / user id array
	Dim CurrentUserID
	Dim CurrentParentUserID
	Dim m_ArUserID

	' Class Initialize
	Private Sub Class_Initialize()

		' Init User Level
		CurrentUserLevelID = SessionUserLevelID
		If IsNumeric(CurrentUserLevelID) Then
			If CurrentUserLevelID >= -1 Then
				ReDim m_ArUserLevelID(0)
				m_ArUserLevelID(0) = CurrentUserLevelID
			End If
		End If

		' Init User ID
		CurrentUserID = SessionUserID
		CurrentParentUserID = SessionParentUserID

		' Load user level (for TablePermission_Loading event)
		Call LoadUserLevel()
	End Sub

	' Session user id
	Public Property Get SessionUserID()
		SessionUserID = Session(EW_SESSION_USER_ID) & ""
	End Property

	Public Property Let SessionUserID(v)
		Session(EW_SESSION_USER_ID) = Trim(v & "")
		CurrentUserID = Trim(v & "")
	End Property

	' Session parent user id
	Public Property Get SessionParentUserID()
		SessionParentUserID = Session(EW_SESSION_PARENT_USER_ID) & ""
	End Property

	Public Property Let SessionParentUserID(v)
		Session(EW_SESSION_PARENT_USER_ID) = Trim(v & "")
		CurrentParentUserID = Trim(v & "")
	End Property

	' Current user name
	Public Property Get CurrentUserName()
		CurrentUserName = Session(EW_SESSION_USER_NAME) & ""
	End Property

	Public Property Let CurrentUserName(v)
		Session(EW_SESSION_USER_NAME) = v
	End Property

	' Session user level id
	Public Property Get SessionUserLevelID()
		SessionUserLevelID = Session(EW_SESSION_USER_LEVEL_ID)
	End Property

	Public Property Let SessionUserLevelID(v)
		Session(EW_SESSION_USER_LEVEL_ID) = v
		CurrentUserLevelID = v
		If IsNumeric(CurrentUserLevelID) Then
			If CurrentUserLevelID >= -1 Then
				ReDim m_ArUserLevelID(0)
				m_ArUserLevelID(0) = CurrentUserLevelID
			End If
		End If
	End Property

	' Session user level value
	Public Property Get SessionUserLevel()
		SessionUserLevel = Session(EW_SESSION_USER_LEVEL)
	End Property

	Public Property Let SessionUserLevel(v)
		Session(EW_SESSION_USER_LEVEL) = v
		CurrentUserLevel = v
	End Property

	' Can add
	Public Property Get CanAdd()
		CanAdd = ((CurrentUserLevel And EW_ALLOW_ADD) = EW_ALLOW_ADD)
	End Property

	Public Property Let CanAdd(b)
		If (b) Then
			CurrentUserLevel = (CurrentUserLevel Or EW_ALLOW_ADD)
		Else
			CurrentUserLevel = (CurrentUserLevel And (Not EW_ALLOW_ADD))
		End If
	End Property

	' Can delete
	Public Property Get CanDelete()
		CanDelete = ((CurrentUserLevel And EW_ALLOW_DELETE) = EW_ALLOW_DELETE)
	End Property

	Public Property Let CanDelete(b)
		If (b) Then
			CurrentUserLevel = (CurrentUserLevel Or EW_ALLOW_DELETE)
		Else
			CurrentUserLevel = (CurrentUserLevel And (Not EW_ALLOW_DELETE))
		End If
	End Property

	' Can edit
	Public Property Get CanEdit()
		CanEdit = ((CurrentUserLevel And EW_ALLOW_EDIT) = EW_ALLOW_EDIT)
	End Property

	Public Property Let CanEdit(b)
		If (b) Then
			CurrentUserLevel = (CurrentUserLevel Or EW_ALLOW_EDIT)
		Else
			CurrentUserLevel = (CurrentUserLevel And (Not EW_ALLOW_EDIT))
		End If
	End Property

	' Can view
	Public Property Get CanView()
		CanView = ((CurrentUserLevel And EW_ALLOW_VIEW) = EW_ALLOW_VIEW)
	End Property

	Public Property Let CanView(b)
		If (b) Then
			CurrentUserLevel = (CurrentUserLevel Or EW_ALLOW_VIEW)
		Else
			CurrentUserLevel = (CurrentUserLevel And (Not EW_ALLOW_VIEW))
		End If
	End Property

	' Can list
	Public Property Get CanList()
		CanList = ((CurrentUserLevel And EW_ALLOW_LIST) = EW_ALLOW_LIST)
	End Property

	Public Property Let CanList(b)
		If (b) Then
			CurrentUserLevel = (CurrentUserLevel Or EW_ALLOW_LIST)
		Else
			CurrentUserLevel = (CurrentUserLevel And (Not EW_ALLOW_LIST))
		End If
	End Property

	' Can report
	Public Property Get CanReport()
		CanReport = ((CurrentUserLevel And EW_ALLOW_REPORT) = EW_ALLOW_REPORT)
	End Property

	Public Property Let CanReport(b)
		If (b) Then
			CurrentUserLevel = (CurrentUserLevel Or EW_ALLOW_REPORT)
		Else
			CurrentUserLevel = (CurrentUserLevel And (Not EW_ALLOW_REPORT))
		End If
	End Property

	' Can search
	Public Property Get CanSearch()
		CanSearch = ((CurrentUserLevel And EW_ALLOW_SEARCH) = EW_ALLOW_SEARCH)
	End Property

	Public Property Let CanSearch(b)
		If (b) Then
			CurrentUserLevel = (CurrentUserLevel Or EW_ALLOW_SEARCH)
		Else
			CurrentUserLevel = (CurrentUserLevel And (Not EW_ALLOW_SEARCH))
		End If
	End Property

	' Can admin
	Public Property Get CanAdmin()
		CanAdmin = ((CurrentUserLevel And EW_ALLOW_ADMIN) = EW_ALLOW_ADMIN)
	End Property

	Public Property Let CanAdmin(b)
		If (b) Then
			CurrentUserLevel = (CurrentUserLevel Or EW_ALLOW_ADMIN)
		Else
			CurrentUserLevel = (CurrentUserLevel And (Not EW_ALLOW_ADMIN))
		End If
	End Property

	' Last url
	Public Property Get LastUrl()
		LastUrl = Request.Cookies(EW_PROJECT_NAME)("lasturl")
	End Property

	' Save last url
	Public Sub SaveLastUrl()
		Dim s, q
		s = ew_ScriptName()
		q = Request.ServerVariables("QUERY_STRING")
		If q <> "" Then s = s & "?" & q
		If LastUrl = s Then s = ""
		Response.Cookies(EW_PROJECT_NAME)("lasturl") = s
	End Sub

	' Auto login
	Public Function AutoLogin()
		Dim sUsr, sPwd
		If Request.Cookies(EW_PROJECT_NAME)("autologin") = "autologin" Then
			sUsr = Request.Cookies(EW_PROJECT_NAME)("username")
			sPwd = Request.Cookies(EW_PROJECT_NAME)("password")
			sPwd = ew_Decrypt(ew_Decode(sPwd))
			AutoLogin = ValidateUser(sUsr, sPwd, True)
		Else
			AutoLogin = False
		End If
	End Function

	' Validate user
	Public Function ValidateUser(usr, pwd, autologin)
		Dim RsUser, sFilter, sSql
		Dim CustomValidateUser
		ValidateUser = False
		CustomValidateUser = False

		' Call User Custom Validate event
		If EW_USE_CUSTOM_LOGIN Then
			CustomValidateUser = User_CustomValidate(usr, pwd)
			If CustomValidateUser Then
				Session(EW_SESSION_STATUS) = "login"
				CurrentUserName = usr ' Load user name
			End If
		End If
		If Not CustomValidateUser And Not ValidateUser And Not IsPasswordExpired() Then Session(EW_SESSION_STATUS) = "" ' Clear login status
	End Function

	' No user level security
	Public Sub SetUpUserLevel()
	End Sub

	' Add user permission
	Public Sub AddUserPermission(UserLevelName, TableName, UserPermission)
		Dim UserLevelID, i

		' Get user level id from user name
		UserLevelID = ""
		If IsArray(m_ArUserLevel) Then
			For i = 0 To UBound(m_ArUserLevel, 2)
				If UserLevelName & "" = m_ArUserLevel(1, i) & "" Then
					UserLevelID = m_ArUserLevel(0, i)
					Exit For
				End If
			Next
		End If
		If IsArray(m_ArUserLevelPriv) And UserLevelID <> "" Then
			For i = 0 To UBound(m_ArUserLevelPriv, 2)
				If m_ArUserLevelPriv(0, i) & "" = EW_PROJECT_ID & TableName And _
				   m_ArUserLevelPriv(1, i) & "" = UserLevelID & "" Then
					m_ArUserLevelPriv(2, i) = m_ArUserLevelPriv(2, i) Or UserPermission ' Add permission
					Exit For
				End If
			Next
		End If
	End Sub

	' Delete user permission
	Public Sub DeleteUserPermission(UserLevelName, TableName, UserPermission)
		Dim UserLevelID, i

		' Get user level id from user name
		UserLevelID = ""
		If IsArray(m_ArUserLevel) Then
			For i = 0 To UBound(m_ArUserLevel, 2)
				If UserLevelName & "" = m_ArUserLevel(1, i) & "" Then
					UserLevelID = m_ArUserLevel(0, i)
					Exit For
				End If
			Next
		End If
		If IsArray(m_ArUserLevelPriv) And UserLevelID <> "" Then
			For i = 0 To UBound(m_ArUserLevelPriv, 2)
				If m_ArUserLevelPriv(0, i) & "" = EW_PROJECT_ID & TableName And _
				   m_ArUserLevelPriv(1, i) & "" = UserLevelID & "" Then
					m_ArUserLevelPriv(2, i) = m_ArUserLevelPriv(2, i) And (127-UserPermission) ' Remove permission
					Exit For
				End If
			Next
		End If
	End Sub

	' Load current user level
	Public Sub LoadCurrentUserLevel(Table)
		Call LoadUserLevel()
		SessionUserLevel = CurrentUserLevelPriv(Table)
	End Sub

	' Get current user privilege
	Private Function CurrentUserLevelPriv(TableName)
		If IsLoggedIn() Then
		Else
			CurrentUserLevelPriv = 0
		End If
	End Function

	' Get user level ID by user level name
	Public Function GetUserLevelID(UserLevelName)
		GetUserLevelID = -2
		If CStr(UserLevelName) = "Administrator" Then
			GetUserLevelID = -1
		ElseIf UserLevelName <> "" Then
			If IsArray(m_ArUserLevel) Then
				Dim i
				For i = 0 to UBound(m_ArUserLevel, 2)
					If CStr(m_ArUserLevel(1, i)) = CStr(UserLevelName) Then
						GetUserLevelID = m_ArUserLevel(0, i)
						Exit For
					End If
				Next
			End If
		End If
	End Function

	' Add user level (for use with UserLevel_Loading event)
	Sub AddUserLevel(UserLevelName)
		Dim UserLevelID
		If UserLevelName = "" Or IsNull(UserLevelName) Then Exit Sub
		UserLevelID = GetUserLevelID(UserLevelName)
		Call AddUserLevelID(UserLevelID)
	End Sub

	' Add user level by ID
	Sub AddUserLevelID(UserLevelID)
		Dim bFound, i
		If Not IsNumeric(UserLevelID) Then Exit Sub
		If UserLevelID < -1 Then Exit Sub
		bFound = False
		If Not IsArray(m_ArUserLevelID) Then
			ReDim m_ArUserLevelID(0)
		Else
			For i = 0 to UBound(m_ArUserLevelID)
				If m_ArUserLevelID(i) = UserLevelID Then
					bFound = True
					Exit For
				End If
			Next
			If Not bFound Then ReDim Preserve m_ArUserLevelID(UBound(m_ArUserLevelID)+1)
		End If
		If Not bFound Then
			m_ArUserLevelID(UBound(m_ArUserLevelID)) = UserLevelID
		End If
	End Sub

	' Delete user level (for use with UserLevel_Loading event)
	Sub DeleteUserLevel(UserLevelName)
		Dim UserLevelID
		If UserLevelName = "" Or IsNull(UserLevelName) Then Exit Sub
		UserLevelID = GetUserLevelID(UserLevelName)
		Call DeleteUserLevelID(UserLevelID)
	End Sub

	' Delete user level by ID
	Sub DeleteUserLevelID(UserLevelID)
		Dim i, j
		If Not IsNumeric(UserLevelID) Then Exit Sub
		If UserLevelID < -1 Then Exit Sub
		If IsArray(m_ArUserLevelID) Then
			For i = 0 to UBound(m_ArUserLevelID)
				If m_ArUserLevelID(i) = UserLevelID Then
					For j = i+1 to UBound(m_ArUserLevelID)
						m_ArUserLevelID(j-1) = m_ArUserLevelID(j)
					Next
					If UBound(m_ArUserLevelID) = 0 Then
						m_ArUserLevelID = ""
					Else
						ReDim Preserve m_ArUserLevelID(UBound(m_ArUserLevelID)-1)
					End If
					Exit Sub
				End If
			Next
		End If
	End Sub

	' User level list
	Function UserLevelList()
		Dim i
		UserLevelList = ""
		If IsArray(m_ArUserLevelID) Then
			For i = 0 to UBound(m_ArUserLevelID)
				If UserLevelList <> "" Then UserLevelList = UserLevelList & ", "
				UserLevelList = UserLevelList & m_ArUserLevelID(i)
			Next
		End If
	End Function

	' User level name list
	Function UserLevelNameList()
		Dim i
		UserLevelNameList = ""
		If IsArray(m_ArUserLevelID) Then
			For i = 0 to UBound(m_ArUserLevelID)
				If UserLevelNameList <> "" Then UserLevelNameList = UserLevelNameList & ", "
				UserLevelNameList = UserLevelNameList & ew_QuotedValue(GetUserLevelName(m_ArUserLevelID(i)), EW_DATATYPE_STRING)
			Next
		End If
	End Function

	' Get user privilege based on table name and user level
	Public Function GetUserLevelPrivEx(TableName, UserLevelID)
		GetUserLevelPrivEx = 0
		If CStr(UserLevelID) = "-1" Then ' System Administrator
			If EW_USER_LEVEL_COMPAT Then
				GetUserLevelPrivEx = 31 ' Use old user level values
			Else
				GetUserLevelPrivEx = 127 ' Use new user level values (separate View/Search)
			End If
		ElseIf UserLevelID >= 0 Then
			If IsArray(m_ArUserLevelPriv) Then
				Dim i
				For i = 0 to UBound(m_ArUserLevelPriv, 2)
					If CStr(m_ArUserLevelPriv(0, i)) = CStr(TableName) And _
						CStr(m_ArUserLevelPriv(1, i)) = CStr(UserLevelID) Then
						GetUserLevelPrivEx = m_ArUserLevelPriv(2, i)
						If IsNull(GetUserLevelPrivEx) Then GetUserLevelPrivEx = 0
						If Not IsNumeric(GetUserLevelPrivEx) Then GetUserLevelPrivEx = 0
						GetUserLevelPrivEx = CLng(GetUserLevelPrivEx)
						Exit For
					End If
				Next
			End If
		End If
	End Function

	' Get current user level name
	Public Function CurrentUserLevelName()
		CurrentUserLevelName = GetUserLevelName(CurrentUserLevelID)
	End Function

	' Get user level name based on user level
	Public Function GetUserLevelName(UserLevelID)
		GetUserLevelName = ""
		If CStr(UserLevelID) = "-1" Then
			GetUserLevelName = "Administrator"
		ElseIf UserLevelID >= 0 Then
			If IsArray(m_ArUserLevel) Then
				Dim i
				For i = 0 to UBound(m_ArUserLevel, 2)
					If CStr(m_ArUserLevel(0, i)) = CStr(UserLevelID) Then
						GetUserLevelName = m_ArUserLevel(1, i)
						Exit For
					End If
				Next
			End If
		End If
	End Function

	' Sub to display all the User Level settings (for debug only)
	Public Sub ShowUserLevelInfo()
		Dim i
		If IsArray(m_ArUserLevel) Then
			Response.Write "User Levels:<br>"
			Response.Write "UserLevelId, UserLevelName<br>"
			For i = 0 To UBound(m_ArUserLevel, 2)
				Response.Write "&nbsp;&nbsp;" & m_ArUserLevel(0, i) & ", " & _
					m_ArUserLevel(1, i) & "<br>"
			Next
		Else
			Response.Write "No User Level definitions." & "<br>"
		End If
		If IsArray(m_ArUserLevelPriv) Then
			Response.Write "User Level Privs:<br>"
			Response.Write "TableName, UserLevelId, UserLevelPriv<br>"
			For i = 0 To UBound(m_ArUserLevelPriv, 2)
				Response.Write "&nbsp;&nbsp;" & m_ArUserLevelPriv(0, i) & ", " & _
					m_ArUserLevelPriv(1, i) & ", " & m_ArUserLevelPriv(2, i) & "<br>"
			Next
		Else
			Response.Write "No User Level privilege settings." & "<br>"
		End If
		Response.Write "Current User Level ID = " & CurrentUserLevelID & "<br>"
	End Sub

	' Function to check privilege for List page (for menu items)
	Public Function AllowList(TableName)
		AllowList = CBool(CurrentUserLevelPriv(TableName) And EW_ALLOW_LIST)
	End Function

	' Function to check privilege for View page (for Allow-View / Detail-View)
	Public Function AllowView(TableName)
		AllowView = CBool(CurrentUserLevelPriv(TableName) And EW_ALLOW_VIEW)
	End Function

	' Function to check privilege for Add / Detail-Add
	Public Function AllowAdd(TableName)
		AllowAdd = CBool(CurrentUserLevelPriv(TableName) And EW_ALLOW_ADD)
	End Function

	' Check privilege for Edit page (for Detail-Edit)
	Public Function AllowEdit(TableName)
		AllowEdit = CBool(CurrentUserLevelPriv(TableName) And EW_ALLOW_EDIT)
	End Function

	' Check if user password expired
	Public Function IsPasswordExpired()
		IsPasswordExpired = (Session(EW_SESSION_STATUS) = "passwordexpired")
	End Function

	' Check if user is logging in (after changing password)
	Public Function IsLoggingIn()
		IsLoggingIn = (Session(EW_SESSION_STATUS) = "loggingin")
	End Function

	' Check if user is logged in
	Public Function IsLoggedIn()
		IsLoggedIn = (Session(EW_SESSION_STATUS) = "login")
	End Function

	' Check if user is system administrator
	Public Function IsSysAdmin()
		IsSysAdmin = (Session(EW_SESSION_SYS_ADMIN) = 1)
	End Function

	' Check if user is administrator
	Function IsAdmin()
		Dim i
		IsAdmin = IsSysAdmin
	End Function

	' Save user level to session
	Public Sub SaveUserLevel()

		'Session(EW_SESSION_PROJECT_ID) = CurrentProjectID ' Save project id
		Session(EW_SESSION_AR_USER_LEVEL) = m_ArUserLevel
		Session(EW_SESSION_AR_USER_LEVEL_PRIV) = m_ArUserLevelPriv
	End Sub

	' Load user level from session
	Public Sub LoadUserLevel()

		'Dim ProjectID
		'ProjectID = CurrentProjectID
		'If Not IsArray(Session(EW_SESSION_AR_USER_LEVEL)) Or Not IsArray(Session(EW_SESSION_AR_USER_LEVEL_PRIV)) Or ProjectID <> Session(EW_SESSION_PROJECT_ID) Then ' Reload if different project

		If Not IsArray(Session(EW_SESSION_AR_USER_LEVEL)) Or Not IsArray(Session(EW_SESSION_AR_USER_LEVEL_PRIV)) Then
			Call SetupUserLevel()
			Call SaveUserLevel()
		Else
			m_ArUserLevel = Session(EW_SESSION_AR_USER_LEVEL)
			m_ArUserLevelPriv = Session(EW_SESSION_AR_USER_LEVEL_PRIV)
		End If
	End Sub

	' Function to get user info
	Public Function CurrentUserInfo(fieldname)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		CurrentUserInfo = Null
	End Function

	' UserID Loading event
	Sub UserID_Loading()

		'Response.Write "UserID Loading: " & CurrentUserID & "<br>"
	End Sub

	' UserID Loaded event
	Sub UserID_Loaded()

		'Response.Write "UserID Loaded: " & UserIDList & "<br>"
	End Sub

	' User Level Loaded event
	Sub UserLevel_Loaded()

		'AddUserPermission <UserLevelName>, <TableName>, <UserPermission>
		'DeleteUserPermission <UserLevelName>, <TableName>, <UserPermission>

	End Sub

	' Table Permission Loading event
	Sub TablePermission_Loading()

		'Response.Write "Table Permission Loading: " & CurrentUserLevelID & "<br>"
	End Sub

	' Table Permission Loaded event
	Sub TablePermission_Loaded()

		'Response.Write "Table Permission Loaded: " & CurrentUserLevel & "<br>"
	End Sub

	' User Custom Validate event
	Function User_CustomValidate(usr, pwd)

		' Enter your custom code to validate user, return TRUE if valid.
		User_CustomValidate = False
	End Function

	' User Validated event
	Sub User_Validated(rs)

		'Session("UserEmail") = rs("Email")
	End Sub

	' User PasswordExpired event
	Sub User_PasswordExpired(rs)

	  'Response.Write "User_PasswordExpired"
	End Sub
End Class

'
'  Advanced Security class (end)
' -------------------------------

%>
<%

' -------------------------------------------
'  Default Request Form Object Class (begin)
'
Class cFormObj
	Dim Index ' Index to handle multiple form elements
	Dim FormName

	' Class Initialize
	Private Sub Class_Initialize
		Index = -1
		FormName = ""
	End Sub

	' Get form element name based on index
	Function GetIndexedName(name)
		If Index < 0 Then
			GetIndexedName = name
		Else
			GetIndexedName = Mid(name, 1, 1) & Index & Mid(name, 2)
		End If
	End Function

	' Has value for form element
	Function HasValue(name)
		Dim wrkname, wrkname2
		wrkname = GetIndexedName(name)
		If FormName <> "" Then
			wrkname2 = FormName & "$" & wrkname
			HasValue = (Request.Form(wrkname2).Count > 0)
			If Not HasValue Then HasValue = (Request.Form(wrkname).Count > 0)
		Else
			HasValue = (Request.Form(wrkname).Count > 0)
		End If
	End Function

	' Get value for form element
	Function GetValue(name)
		Dim wrkname, wrkname2
		wrkname = GetIndexedName(name)
		GetValue = Null
		If FormName <> "" Then
			wrkname2 = FormName & "$" & wrkname
			If Request.Form(wrkname2).Count > 0 Then
				GetValue = Request.Form(wrkname2)
			End If
		End If
		If IsNull(GetValue) Then
			If Request.Form(wrkname).Count > 0 Then

				' Special handling for key_m
				If wrkname = "key_m" Then
					If Request.Form(wrkname).Count = 1 Then
						GetValue = Request.Form(wrkname)
					Else
						Dim i, cnt, ar
						cnt = Request.Form(wrkname).Count
						Redim ar(cnt-1)
						For i = 1 to cnt
							ar(i-1) = Request.Form(wrkname)(i)
						Next
						GetValue = ar
					End If
				Else
					GetValue = Request.Form(wrkname)
				End If
			End If
		End If
	End Function
End Class

'
'  Default Request Form Object Class (end)
' -----------------------------------------

%>
<%

' -------------------------------------
'  Default Upload Object Class (begin)
'
Class cUploadObj
	Dim rawData, separator, lenSeparator, dict
	Dim currentPos, inStrByte, tempValue, mValue, value
	Dim intDict, begPos, endPos
	Dim nameN, isValid, nameValue, midValue
	Dim rawStream
	Dim Index
	Dim hdr, hdrEndPos

	' Class Inialize
	Private Sub Class_Initialize
		Index = -1
		If Request.TotalBytes > 0 Then
			Set rawStream = Server.CreateObject("ADODB.Stream")
			rawStream.Type = 1 'adTypeBinary
			rawStream.Mode = 3 'adModeReadWrite
			rawStream.Open
			rawStream.Write Request.BinaryRead(Request.TotalBytes)
			rawStream.Position = 0
			rawData = rawStream.Read
			separator = MidB(rawData, 1, InStrB(1, rawData, ChrB(13)) - 1)
			lenSeparator = LenB(separator)
			Set dict = Server.CreateObject("Scripting.Dictionary")
			currentPos = 1
			inStrByte = 1
			tempValue = ""
			While inStrByte > 0
				inStrByte = InStrB(currentPos, rawData, separator)
				mValue = inStrByte - currentPos
				If mValue > 1 Then
					value = MidB(rawData, currentPos, mValue)
					Set intDict = Server.CreateObject("Scripting.Dictionary")
					begPos = 1 + InStrB(1, value, ChrB(34))
					endPos = InStrB(begPos + 1, value, ChrB(34))
					nameN = MidB(value, begPos, endPos - begPos)
					isValid = True
					hdrEndPos = InStrB(1, value, ChrB(13) & ChrB(10) & ChrB(13) & ChrB(10))
					hdr = MidB(value, 1, hdrEndPos - 1)
					If InStrB(1, hdr, StringToByte("Content-Type:")) > 1 Or InStrB(1, hdr, StringToByte("filename=")) > 1 Then
						begPos = 1 + InStrB(endPos + 1, value, ChrB(34))
						endPos = InStrB(begPos + 1, value, ChrB(34))
						If endPos > 0 Then
							intDict.Add "FileName", ConvertToText(rawStream, currentPos + begPos - 2, endPos - begPos, MidB(value, begPos, endPos - begPos))
							begPos = 14 + InStrB(endPos + 1, value, StringToByte("Content-Type:"))
							endPos = InStrB(begPos, value, ChrB(13))
							intDict.Add "ContentType", ConvertToText(rawStream, currentPos + begPos - 2, endPos - begPos, MidB(value, begPos, endPos - begPos))
							begPos = endPos + 4
							endPos = LenB(value)
							nameValue = MidB(value, begPos, ((endPos - begPos) - 1))
						Else
							endPos = begPos + 1
							isValid = False
						End If
					Else
						nameValue = ConvertToText(rawStream, currentPos + endPos + 3, mValue - endPos - 4, MidB(value, endPos + 5))
					End If
					If isValid = True Then
						Dim wrkname
						wrkname = ByteToString(nameN)
						If dict.Exists(wrkname) Then
							Set intDict = dict.Item(wrkname)

							' Special handling for key_m, just append to end
							If wrkname = "key_m" Then
								intDict.Item("Value") = intDict.Item("Value") & nameValue
							Else
								If Right(intDict.Item("Value"), 2) = vbCrLf Then
									intDict.Item("Value") = Left(intDict.Item("Value"), Len(intDict.Item("Value"))-2)
								End If
								intDict.Item("Value") = intDict.Item("Value") & ", " & nameValue
							End If
						Else
							intDict.Add "Value", nameValue
							intDict.Add "Name", nameN
							dict.Add wrkname, intDict
						End If
					End If
				End If
				currentPos = lenSeparator + inStrByte
			Wend
			rawStream.Close
			Set rawStream = Nothing
		End If
	End Sub

	' Get form element name based on index
	Function GetIndexedName(name)
		If Index < 0 Then
			GetIndexedName = name
		Else
			GetIndexedName = Mid(name, 1, 1) & Index & Mid(name, 2)
		End If
	End Function

	' Has value for form element
	Function HasValue(name)
		Dim wrkname
		wrkname = GetIndexedName(name)
		If Not IsObject(dict) Then
			HasValue = False
		Else
			HasValue = dict.Exists(wrkname)
		End If
	End Function

	' Get value for form element
	Function GetValue(name)
		Dim wrkname
		Dim gv
		GetValue = Null ' default return Null
		If IsObject(dict) Then
			wrkname = GetIndexedName(name)
			If dict.Exists(wrkname) Then
				gv = CStr(dict(wrkname).Item("Value"))
				gv = Left(gv, Len(gv)-2)
				GetValue = gv

				' Special handling for key_m
				If wrkname = "key_m" Then
					If InStr(GetValue, vbCrLf) > 0 Then
						GetValue = Split(GetValue, vbCrLf)
					End If
				End If
			End If
		End If
	End Function

	' Get upload file size
	Function GetUploadFileSize(name)
		Dim wrkname
		wrkname = GetIndexedName(name)
		If dict.Exists(wrkname) Then
			GetUploadFileSize = LenB(dict(wrkname).Item("Value"))
		Else
			GetUploadFileSize = 0
		End If
	End Function

	' Get upload file name
	Function GetUploadFileName(name)
		Dim wrkname, temp, tempPos
		wrkname = GetIndexedName(name)
		If dict.Exists(wrkname) Then
			temp = dict(wrkname).Item("FileName")
			tempPos = 1 + InStrRev(temp, "\")
			GetUploadFileName = Mid(temp, tempPos)
		Else
			GetUploadFileName = ""
		End If
	End Function

	' Get file content type
	Function GetUploadFileContentType(name)
		Dim wrkname
		wrkname = GetIndexedName(name)
		If dict.Exists(wrkname) Then
			GetUploadFileContentType = dict(wrkname).Item("ContentType")
		Else
			GetUploadFileContentType = ""
		End If
	End Function

	' Get upload file data
	Function GetUploadFileData(name)
		Dim wrkname
		wrkname = GetIndexedName(name)
		If dict.Exists(wrkname) Then
			GetUploadFileData = dict(wrkname).Item("Value")
		Else
			GetUploadFileData = Null
		End If
	End Function

	' Get file image width
	Function GetUploadImageWidth(name)
		Dim wrkname
		wrkname = GetIndexedName(name)
		Dim ImageHeight
		Call ew_GetImageDimension(GetUploadFileData(name), GetUploadImageWidth, ImageHeight)
	End Function

	' Get file image height
	Function GetUploadImageHeight(name)
		Dim wrkname
		wrkname = GetIndexedName(name)
		Dim ImageWidth
		Call ew_GetImageDimension(GetUploadFileData(name), ImageWidth, GetUploadImageHeight)
	End Function

	' Convert string to byte
	Function StringToByte(toConv)
		Dim i, tempChar
		For i = 1 to Len(toConv)
			tempChar = Mid(toConv, i, 1)
			StringToByte = StringToByte & ChrB(AscB(tempChar))
		Next
	End Function

	' Convert byte to string
	Private Function ByteToString(ToConv)
		Dim i
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		For i = 1 to LenB(ToConv)
			ByteToString = ByteToString & Chr(AscB(MidB(ToConv,i,1)))
		Next
	End Function

	' Convert to text
	Function ConvertToText(objStream, iStart, iLength, binData)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		If EW_UPLOAD_CHARSET <> "" Then
			Dim tmpStream
			Set tmpStream = Server.CreateObject("ADODB.Stream")
			tmpStream.Type = 1 'adTypeBinary
			tmpStream.Mode = 3 'adModeReadWrite
			tmpStream.Open
			objStream.Position = iStart
			objStream.CopyTo tmpStream, iLength
			tmpStream.Position = 0
			tmpStream.Type = 2 'adTypeText
			tmpStream.Charset = EW_UPLOAD_CHARSET
			ConvertToText = tmpStream.ReadText
			tmpStream.Close
			Set tmpStream = Nothing
		Else
			ConvertToText = ByteToString(binData)
		End If
		ConvertToText = Trim(ConvertToText & "")
	End Function

	' Class terminate
	Private Sub Class_Terminate

		' Dispose dictionary
		If IsObject(intDict) Then
			intDict.RemoveAll
			Set intDict = Nothing
		End If
		If IsObject(dict) Then
			dict.RemoveAll
			Set dict = Nothing
		End If
	End Sub
End Class

'
'  Default Upload Object Class (end)
' -----------------------------------

%>
<%

' --------------------------
'  Common functions (begin)
'
' Write HTTP header
Sub ew_Header(cache, charset)
	Dim export
	export = Request.QueryString("export") & ""
	If (cache) Or (Not cache And ew_IsHttps() And export <> "" And export <> "print") Then ' Allow cache
		Response.AddHeader "Cache-Control", "private, must-revalidate"
		Response.AddHeader "Pragma", "public"
	Else ' No cache
		Response.AddHeader "Cache-Control", "private, no-cache, no-store, must-revalidate"
		Response.AddHeader "Cache-Control", "post-check=0, pre-check=0"
		Response.AddHeader "Pragma", "no-cache"
	End If
	Response.ContentType = "text/html"
	Response.AddHeader "X-UA-Compatible", "IE=edge"
	If charset <> "" Then
		Response.Charset = charset ' Charset
	End If
End Sub

' Connect to database
Sub ew_Connect()
	EW_DB_CONNECTION_STRING = "Provider=SQLNCLI11;Persist Security Info=False;Data Source=23.161.0.18,1433;Initial Catalog=115115;User Id=suwen;Password=suwen321;DataTypeCompatibility=80"

	' Open connection to the database
	Set Conn = Server.CreateObject("ADODB.Connection")

	' Database connecting event
	Call Database_Connecting(EW_DB_CONNECTION_STRING)
	Conn.Open EW_DB_CONNECTION_STRING

	' Set date format
	If EW_DEFAULT_DATE_FORMAT > 0 Then
		Conn.Execute("SET DATEFORMAT ymd")
	End If

	' Database connected event
	Call Database_Connected(Conn)
End Sub

' Database Connecting event
Sub Database_Connecting(Connstr)

	'Response.Write "Database Connecting"
End Sub

' Database Connected event
Sub Database_Connected(Conn)

	' Example:
	' Conn.Execute("Your SQL")

End Sub

' Check if allow add/delete row
Function ew_AllowAddDeleteRow()
	ew_AllowAddDeleteRow  = True
End Function

' Append like operator
Function ew_Like(pat)
	If EW_LIKE_COLLATION_FOR_MSSQL <> "" Then
		ew_Like = " COLLATE " & EW_LIKE_COLLATION_FOR_MSSQL & " LIKE " & pat
	Else
		ew_Like = " LIKE " & pat
	End If
End Function

' Return multi-value search sql
Function ew_GetMultiSearchSql(Fld, FldOpr, FldVal)
	Dim arVal, i, sVal, sSql, sWrk
	If FldOpr = "IS NULL" Or FldOpr = "IS NOT NULL" Then
        ew_GetMultiSearchSql = Fld.FldExpression & " " & FldOpr
	Else
		sWrk = ""
		arVal = Split(FldVal, ",")
		For i = 0 to UBound(arVal)
			sVal = Trim(arVal(i))
			If sVal = EW_NULL_VALUE Then
				sSql = Fld.FldExpression & " IS NULL"
			ElseIf sVal = EW_NOT_NULL_VALUE Then
				sSql = Fld.FldExpression & " IS NOT NULL"
			ElseIf UBound(arVal) = 0 Or EW_SEARCH_MULTI_VALUE_OPTION = 3 Then
				sSql = Fld.FldExpression & " = '" & ew_AdjustSql(sVal) & "' OR " & ew_GetMultiSearchSqlPart(Fld, sVal)
			Else
				sSql = ew_GetMultiSearchSqlPart(Fld, sVal)
			End If
			If sWrk <> "" Then
				If EW_SEARCH_MULTI_VALUE_OPTION = 2 Then
					sWrk = sWrk & " AND "
				ElseIf EW_SEARCH_MULTI_VALUE_OPTION = 3 Then
					sWrk = sWrk & " OR "
				End If
			End If
			sWrk = sWrk & "(" & sSql & ")"
		Next
		ew_GetMultiSearchSql = sWrk
	End If
End Function

' Get multi search sql part
Function ew_GetMultiSearchSqlPart(Fld, FldVal)
	ew_GetMultiSearchSqlPart = Fld.FldExpression & ew_Like("'" & ew_AdjustSql(FldVal) & ", %'") & " OR " & _
		Fld.FldExpression & ew_Like("'%, " & ew_AdjustSql(FldVal) & ",%'") & " OR " & _
		Fld.FldExpression & ew_Like("'%, " & ew_AdjustSql(FldVal) & "'")
End Function

' Check if float format
Function ew_IsFloatFormat(FldType)
	ew_IsFloatFormat = (FldType = 4 Or FldType = 5 Or FldType = 131 Or FldType = 6)
End Function

' Get search sql
Function ew_GetSearchSql(Fld, FldVal, FldOpr, FldCond, FldVal2, FldOpr2)
	Dim IsValidValue
	ew_GetSearchSql = ""
	Dim sFldExpression, lFldDataType, virtual
	virtual = Fld.FldIsVirtual And Fld.FldVirtualSearch
	sFldExpression = ew_IIf(virtual, Fld.FldVirtualExpression, Fld.FldExpression)
	lFldDataType = Fld.FldDataType
	If virtual Then lFldDataType = EW_DATATYPE_STRING
	If ew_IsFloatFormat(Fld.FldType) Then
		FldVal = ew_StrToFloat(FldVal)
		FldVal2 = ew_StrToFloat(FldVal2)
	End If
	If lFldDataType = EW_DATATYPE_NUMBER Then ' Fix wrong operator
		If FldOpr = "LIKE" Or FldOpr = "STARTS WITH" Or FldOpr = "ENDS WITH" Then
			FldOpr = "="
		ElseIf FldOpr = "NOT LIKE" Then
			FldOpr = "<>"
		End If
		If FldOpr2 = "LIKE" Or FldOpr2 = "STARTS WITH" Or FldOpr = "ENDS WITH" Then
			FldOpr2 = "="
		ElseIf FldOpr2 = "NOT LIKE" Then
			FldOpr2 = "<>"
		End If
	End If
	If FldOpr = "BETWEEN" Then
		IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
			(lFldDataType = EW_DATATYPE_NUMBER And IsNumeric(FldVal) And IsNumeric(FldVal2))
		If FldVal <> "" And FldVal2 <> "" And IsValidValue Then
			ew_GetSearchSql = sFldExpression & " BETWEEN " & ew_QuotedValue(FldVal, lFldDataType) & _
				" AND " & ew_QuotedValue(FldVal2, lFldDataType)
		End If
	Else

		' Handle first value
		If FldVal = EW_NULL_VALUE Or FldOpr = "IS NULL" Then
			ew_GetSearchSql = Fld.FldExpression & " IS NULL"
		ElseIf FldVal = EW_NOT_NULL_VALUE Or FldOpr = "IS NOT NULL" Then
			ew_GetSearchSql = Fld.FldExpression & " IS NOT NULL"
		Else
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And IsNumeric(FldVal))
			If FldVal <> "" And IsValidValue And ew_IsValidOpr(FldOpr, lFldDataType) Then
				ew_GetSearchSql = sFldExpression & ew_SearchString(FldOpr, FldVal, lFldDataType)
				If Fld.FldDataType = EW_DATATYPE_BOOLEAN And FldVal = Fld.FalseValue And FldOpr = "=" Then
					ew_GetSearchSql = "(" & ew_GetSearchSql & " OR " & sFldExpression & " IS NULL)"
				End If
			End If
		End If

		' Handle second value
		Dim sSql2
		sSql2 = ""
		If FldVal2 = EW_NULL_VALUE Or FldOpr2 = "IS NULL" Then
			sSql2 = Fld.FldExpression & " IS NULL"
		ElseIf FldVal2 = EW_NOT_NULL_VALUE Or FldOpr2 = "IS NOT NULL" Then
			sSql2 = Fld.FldExpression & " IS NOT NULL"
		Else
			IsValidValue = (lFldDataType <> EW_DATATYPE_NUMBER) Or _
				(lFldDataType = EW_DATATYPE_NUMBER And IsNumeric(FldVal2))
			If FldVal2 <> "" And IsValidValue And ew_IsValidOpr(FldOpr2, lFldDataType) Then
				sSql2 = sFldExpression & ew_SearchString(FldOpr2, FldVal2, lFldDataType)
				If Fld.FldDataType = EW_DATATYPE_BOOLEAN And FldVal2 = Fld.FalseValue And FldOpr2 = "=" Then
					sSql2 = "(" & sSql2 & " OR " & sFldExpression & " IS NULL)"
				End If
			End If
		End If

		' Combine SQL
		If sSql2 <> "" Then
			If ew_GetSearchSql <> "" Then
				ew_GetSearchSql = "(" & ew_GetSearchSql & " " & ew_IIf(FldCond = "OR", "OR", "AND") & " " & sSql2 & ")"
			Else
				ew_GetSearchSql = sSql2
			End If
		End If
	End If
End Function

' Return search string
Function ew_SearchString(FldOpr, FldVal, FldType)
	Dim sValue
	sValue = CStr(FldVal&"")
	If sValue = EW_NULL_VALUE Or FldOpr = "IS NULL" Then
		ew_SearchString = " IS NULL"
	ElseIf sValue = EW_NOT_NULL_VALUE Or FldOpr = "IS NOT NULL" Then
		ew_SearchString = " IS NOT NULL"
	ElseIf FldOpr = "LIKE" Then
		ew_SearchString = ew_Like(ew_QuotedValue("%" & sValue & "%", FldType))
	ElseIf FldOpr = "NOT LIKE" Then
		ew_SearchString = " NOT " & ew_Like(ew_QuotedValue("%" & sValue & "%", FldType))
	ElseIf FldOpr = "STARTS WITH" Then
		ew_SearchString = ew_Like(ew_QuotedValue(sValue & "%", FldType))
	ElseIf FldOpr = "ENDS WITH" Then
		ew_SearchString = ew_Like(ew_QuotedValue("%" & sValue, FldType))
	Else
		ew_SearchString = " " & FldOpr & " " & ew_QuotedValue(sValue, FldType)
	End If
End Function

' Check if valid operator
Function ew_IsValidOpr(Opr, FldType)
	ew_IsValidOpr = (Opr = "=" Or Opr = "<" Or Opr = "<=" Or _
		Opr = ">" Or Opr = ">=" Or Opr = "<>")
	If FldType = EW_DATATYPE_STRING Or FldType = EW_DATATYPE_MEMO Then
		ew_IsValidOpr = ew_IsValidOpr Or Opr = "LIKE" Or Opr = "NOT LIKE" Or Opr = "STARTS WITH" Or Opr = "ENDS WITH"
	End If
End Function

' Quoted name for table/field
Function ew_QuotedName(Name)
	ew_QuotedName = EW_DB_QUOTE_START & Replace(Name, EW_DB_QUOTE_END, EW_DB_QUOTE_END & EW_DB_QUOTE_END) & EW_DB_QUOTE_END
End Function

' Double quote value
Function ew_DoubleQuotedValue(Value)
	ew_DoubleQuotedValue = """" & Replace(Value & "", """", """""") & """"
End Function

' Quoted value for field type
Function ew_QuotedValue(Value, FldType) 
	Select Case FldType
	Case EW_DATATYPE_STRING, EW_DATATYPE_MEMO
		ew_QuotedValue = "'" & ew_AdjustSql(Value) & "'"
	Case EW_DATATYPE_GUID
		If EW_IS_MSACCESS Then
			ew_QuotedValue = "{guid " & ew_AdjustSql(Value) & "}"
		Else
			ew_QuotedValue = "'" & ew_AdjustSql(Value) & "'"
		End If
	Case EW_DATATYPE_DATE, EW_DATATYPE_TIME
		If EW_IS_MSACCESS Then
			ew_QuotedValue = "#" & ew_AdjustSql(Value) & "#"
		ElseIf EW_IS_ORACLE Then
			ew_QuotedValue = "TO_DATE('" & ew_AdjustSql(Value) & "', 'YYYY/MM/DD HH24:MI:SS')"
		Else
			ew_QuotedValue = "'" & ew_AdjustSql(Value) & "'"
		End If
	Case EW_DATATYPE_BOOLEAN
		ew_QuotedValue = Value
	Case Else
		ew_QuotedValue = Value
	End Select
End Function

' Pad zeros before number
Function ew_ZeroPad(m, t)
	ew_ZeroPad = String(t - Len(m), "0") & m
End Function

' Convert different data type value
Function ew_Conv(v, t)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	Select Case t

	' If adBigInt/adUnsignedBigInt
	Case 20, 21
		If IsNull(v) Then
			ew_Conv = Null
		Else
			ew_Conv = CLng(v)
		End If

	' If adSmallInt/adInteger/adTinyInt/adUnsignedTinyInt/adUnsignedSmallInt/adUnsignedInt/adBinary
	Case 2, 3, 16, 17, 18, 19, 128
		If IsNull(v) Then
			ew_Conv = Null
		Else
			ew_Conv = CLng(v)
		End If

	' If adSingle
	Case 4
		If IsNull(v) Then
			ew_Conv = Null
		Else
			ew_Conv = CSng(v)
		End If

	' If adDouble/adCurrency/adNumeric/adVarNumeric
	Case 5, 6, 131, 139
		If IsNull(v) Then
			ew_Conv = Null
		Else
			ew_Conv = CDbl(v)
		End If
	Case Else
		ew_Conv = v
	End Select
End Function

' Function for debug
Sub ew_Trace(pfx, aMsg)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	Dim fso, ts
	Dim sFolder, sFn
	sFolder = EW_AUDIT_TRAIL_PATH
	sFn = pfx & ".txt"
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	Set ts = fso.OpenTextFile(ew_UploadPathEx(True, sFolder) & sFn, 8, True)
	ts.writeline(Date & vbTab & Time & vbTab & aMsg)
	ts.Close
	Set ts = Nothing
	Set fso = Nothing
End Sub

' Display elapsed time (in seconds)
Function ew_CalcElapsedTime(tm)
	Dim endTimer
	endTimer = Timer
	ew_CalcElapsedTime = "<div>page processing time: " & FormatNumber((endTimer-tm),2) & " seconds</div>"
End Function

' Function to compare values with special handling for null values
Function ew_CompareValue(v1, v2)
	If IsNull(v1) And IsNull(v2) Then
		ew_CompareValue = True
	ElseIf IsNull(v1) Or IsNull(v2) Then
		ew_CompareValue = False
	ElseIf VarType(v1) = 14 Or VarType(v2) = 14 Then
		ew_CompareValue = (CDbl(v1) = CDbl(v2))
	Else
		ew_CompareValue = (v1 = v2)
	End If
End Function

' Check if boolean value is TRUE
Function ew_ConvertToBool(value)
	ew_ConvertToBool = (value & "" = "1" Or LCase(value & "") = "true" Or LCase(value & "") = "y" Or LCase(value & "") = "t")
End Function

' Add message
Sub ew_AddMessage(msg, msgtoadd)
	If msgtoadd <> "" Then
		If msg <> "" Then
			msg = msg & "<br>"
		End If
		msg = msg & msgtoadd
	End If
End Sub

' Add filter
Sub ew_AddFilter(filter, newfilter)
	If Trim(newfilter) = "" Then Exit Sub
	If Trim(filter) <> "" Then
		filter = "(" & filter & ") AND (" & newfilter & ")"
	Else
		filter = newfilter
	End If
End Sub

' Adjust sql for special characters
Function ew_AdjustSql(str)
	Dim sWrk
	sWrk = Trim(str & "")
	sWrk = Replace(sWrk, "'", "''") ' Adjust for Single Quote
	sWrk = Replace(sWrk, "[", "[[]") ' Adjust for Open Square Bracket
	ew_AdjustSql = sWrk
End Function

' Build select sql based on different sql part
Function ew_BuildSelectSql(sSelect, sWhere, sGroupBy, sHaving, sOrderBy, sFilter, sSort)
	Dim sSql, sDbWhere, sDbOrderBy
	sDbWhere = sWhere
	Call ew_AddFilter(sDbWhere, sFilter)
	sDbOrderBy = sOrderBy
	If sSort <> "" Then
		sDbOrderBy = sSort
	End If
	sSql = sSelect
	If sDbWhere <> "" Then
		sSql = sSql & " WHERE " & sDbWhere
	End If
	If sGroupBy <> "" Then
		sSql = sSql & " GROUP BY " & sGroupBy
	End If
	If sHaving <> "" Then
		sSql = sSql & " HAVING " & sHaving
	End If
	If sDbOrderBy <> "" Then
		sSql = sSql & " ORDER BY " & sDbOrderBy
	End If
	ew_BuildSelectSql = sSql
End Function

' Load recordset
Function ew_LoadRecordset(SQL)
	On Error Resume Next
	Err.Clear
	Dim RsSet
	Set RsSet = Server.CreateObject("ADODB.Recordset")
	RsSet.CursorLocation = EW_CURSORLOCATION

	'RsSet.Open SQL, Conn, 1, EW_RECORDSET_LOCKTYPE
	RsSet.Open SQL, Conn, 3, 1, 1 ' adOpenStatic, adLockReadOnly, adCmdText
	If Err.Number <> 0 Then
		Response.Write "Load recordset error. SQL: '" & SQL & "'. Description: " & Err.Description
		Response.End
	Else
		Set ew_LoadRecordset = RsSet
	End If
End Function

' Load row
Function ew_LoadRow(SQL)
	On Error Resume Next
	Err.Clear
	Dim RsRow
	Set RsRow = Server.CreateObject("ADODB.Recordset")
	RsRow.Open SQL, Conn
	If Err.Number <> 0 Then
		Response.Write "Load row error. SQL: '" & SQL & "'. Description: " & Err.Description
		Response.End
	Else
		Set ew_LoadRow = RsRow
	End If
End Function

' Execute UPDATE, INSERT, or DELETE statements
Function ew_Execute(SQL)
	ew_Execute = Conn.Execute(SQL)
End Function

' Note: Object "Conn" is required
' Return sql scalar value
Function ew_ExecuteScalar(SQL)
	On Error Resume Next
	Err.Clear
	ew_ExecuteScalar = Null
	If Trim(SQL & "") = "" Then Exit Function
	Dim RsExec
	Set RsExec = Conn.Execute(SQL)
	If Err.Number <> 0 Then
		Response.Write "Execute scalar error. SQL: '" & SQL & "'. Description: " & Err.Description
		Response.End
	Else
		If Not RsExec.Eof Then ew_ExecuteScalar = RsExec(0)
	End If
	RsExec.Close
	Set RsExec = Nothing
End Function

' Get result in HTML table
' options: 0:fieldcaption(bool|array), 1:horizontal(bool), 2:tablename(string|array), 3:tableclass(string)
Function ew_ExecuteHtml(SQL, options)
	On Error Resume Next
	Dim ar, horizontal, html, tblclass, TableClass
	Dim rs, cnt, fldcnt, rowcnt, i, key, val
	TableClass = "table table-bordered table-striped ewDbTable" ' Table CSS class name
	If IsArray(options) Then
		ar = options
	Else
		ar = Array()
	End If
	If UBound(ar) >= 1 Then
		horizontal = CBool(ar(1))
	Else
		horizontal = False
	End If
	html = ""
	If UBound(ar) >= 3 Then
		tblclass = ar(3)
	Else
		tblclass = TableClass
	End If
		Set rs = ew_LoadRecordset(SQL)
		cnt = rs.RecordCount
		If cnt > 1 Or horizontal Then ' Horizontal table
			html = "<table class=""" & tblclass & """>"
			html = html & "<thead><tr>"
			fldcnt = rs.Fields.Count
			For i = 0 to fldcnt - 1
				key = rs.Fields(i).Name
				val = rs.Fields(i).Value
				html = html & "<th>" & ew_GetFieldCaption(key, ar) & "</th>"
			Next
			html = html & "</tr></thead>"
			html = html & "<tbody>"
			rowcnt = 0
			Do While Not rs.EOF
				html = html & "<tr>"
				For i = 0 to fldcnt - 1
					key = rs.Fields(i).Name
					val = rs.Fields(i).Value
					html = html & "<td>" & val & "</td>"
				Next
				html = html & "</tr>"
				rs.MoveNext
			Loop
			html = html & "</tbody></table>"
		Else ' Single row, vertical table
			If Not rs.EOF Then
				html = "<table class=""" & tblclass & """><tbody>"
				fldcnt = rs.Fields.Count
				For i = 0 to fldcnt - 1
					key = rs.Fields(i).Name
					val = rs.Fields(i).Value
					html = html & "<tr>"
					html = html & "<td>" & ew_GetFieldCaption(key, ar) & "</td>"
					html = html & "<td>" & val & "</td></tr>"
				Next
				html = html & "</tbody></table>"
			End If
		End If
		rs.Close
		Set rs = Nothing
		ew_ExecuteHtml = html
	End Function

	' Get field caption
	' ar: 0:fieldcaption(bool|array), 1:horizontal(bool), 2:tablename(string|array), 3:tableclass(string)
	Function ew_GetFieldCaption(key, ar)
		On Error Resume Next
		Dim caption, tblname, usecaption, arcaptions, i
		caption = ""
		If Not IsArray(ar) Then
			ew_GetFieldCaption = key
			Exit Function
		End If
		If UBound(ar) >= 2 Then
			tblname = ar(2)
		Else
			tblname = ""
		End If
		If UBound(ar) >= 0 Then
			If IsArray(ar(0)) Then
				usecaption = True
				arcaptions = ar(0)
			Else
				usecaption = CBool(ar(0))
				arcaptions = ""
			End If
			If usecaption Then
				If IsArray(arcaptions) Then
					For i = 0 to UBound(arcaptions)
						If IsArray(arcaptions(i)) Then
							If UBound(arcaptions(i)) >= 1 Then
								If arcaptions(i)(0) = key Then
									caption = arcaptions(i)(1)
									Exit For
								End If
							End If
						End If
					Next
				Else
					If IsArray(tblname) Then
						For i = 0 to UBound(tblname)
							caption = Language.FieldPhrase(tblname(i), key, "FldCaption")
							If caption <> "" Then
								Exit For
							End If
						Next
					ElseIf tblname <> "" Then
						caption = Language.FieldPhrase(tblname, key, "FldCaption")
					End If
				End If
			End If
		End If
		If caption <> "" Then
			ew_GetFieldCaption = caption
		Else
			ew_GetFieldCaption = key
		End If
	End Function

' Clone recordset
Function ew_CloneRs(RsOld)
	Dim Stream
	Dim RsClone

	' Save the recordset to the stream object
	Set Stream = Server.CreateObject("ADODB.Stream")
	RsOld.Save Stream

	' Open the stream object into a new recordset
	Set RsClone = Server.CreateObject("ADODB.Recordset")
	RsClone.Open Stream, , , 2

	' Return the cloned recordset
	Set ew_CloneRs = RsClone

	' Release the reference
	Set RsClone = Nothing
End Function

' Function to dynamically include a file
Function ew_Include(fn)
	On Error Resume Next
	Dim sIncludeText
	sIncludeText = ew_LoadFile(fn)
	If sIncludeText <> "" Then
		sIncludeText = Replace(sIncludeText, "<" & "%", "")
		sIncludeText = Replace(sIncludeText, "%" & ">", "")
		Execute sIncludeText
		ew_Include = True
	Else
		ew_Include = False
	End If
End Function

' Function to Load a Text File
Function ew_LoadTxt(fn)
	Dim fso, fobj

	' Get text file content
	ew_LoadTxt = ""
	If Trim(fn) <> "" Then
		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		If fso.FileExists(Server.MapPath(fn)) Then
			Set fobj = fso.OpenTextFile(Server.MapPath(fn))
			ew_LoadTxt = fobj.ReadAll ' Read all Content
			fobj.Close
			Set fobj = Nothing
		End If
		Set fso = Nothing
	End If
End Function

' Load file content (both ASCII and UTF-8)
Function ew_LoadFile(FileName)
	On Error Resume Next
	Dim fso, FilePath
	ew_LoadFile = ""
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If Trim(FileName) <> "" Then
		If fso.FileExists(FileName) Then
			FilePath = FileName
		Else
			FilePath = Server.MapPath(FileName)
		End If
		If fso.FileExists(FilePath) Then
			If ew_GetFileCharset(FilePath) = "UTF-8" Then
				ew_LoadFile = ew_LoadUTF8File(FilePath)
			Else
				Dim iFile, iData
				Set iFile = fso.GetFile(FilePath)
				Set iData = iFile.OpenAsTextStream
				ew_LoadFile = iData.ReadAll
				iData.Close
				Set iData = Nothing
				Set iFile = Nothing
			End If
		End If
	End If
	Set fso = Nothing
End Function

' Open UTF8 file
Function ew_LoadUTF8File(FilePath)
	On Error Resume Next
	Dim objStream
	Set objStream = Server.CreateObject("ADODB.Stream")
	With objStream
		.Type = 2
		.Mode = 3
		.Open
		.CharSet = "UTF-8"
		.LoadFromFile FilePath
		ew_LoadUTF8File = .ReadText
		.Close
	End With
End Function

' Get file charset (UTF-8 and UNICODE)
Function ew_GetFileCharset(FilePath)
	On Error Resume Next
	Dim objStream, LoadBytes
	Set objStream = Server.CreateObject("ADODB.Stream")
	With objStream
		.Type = 1
		.Mode = 3
		.Open
		.LoadFromFile FilePath
		LoadBytes = .Read(3) ' Get first 3 bytes as BOM
		.Close
	End With
	Set objStream = Nothing
	Dim FileCharset, strFileHead

	' Get hex values
	strFileHead = ew_BinToHex(LoadBytes)

	' UTF-8
	If strFileHead = "EFBBBF" Then
		ew_GetFileCharset = "UTF-8" ' UTF-8
	Else
		ew_GetFileCharset = "" ' Non UTF-8
	End If
End Function

' Get hex values
Function ew_BinToHex(vStream)
	Dim reVal, i
	reVal = 0
	For i = 1 To LenB(vStream)
		reVal = reVal * 256 + AscB(MidB(vStream, i, 1))
	Next
	ew_BinToHex = Hex(reVal)
End Function

' Write Audit Trail (insert/update/delete)
Sub ew_WriteAuditTrail(pfx, curDateTime, script, user, action, table, field, keyvalue, oldvalue, newvalue)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	Dim fso, ts, sMsg, sFn, sFolder
	Dim bWriteHeader, sHeader
	Dim userwrk
	userwrk = user
	If userwrk = "" Then userwrk = "-1" ' assume Administrator if no user
	If Not EW_AUDIT_TRAIL_TO_DATABASE Then

		' Write audit trail to log file
		sHeader = "date/time" & vbTab & _
			"script" & vbTab & _
			"user" & vbTab & _
			"action" & vbTab & _
			"table" & vbTab & _
			"field" & vbTab & _
			"key value" & vbTab & _
			"old value" & vbTab & _
			"new value"
		sMsg = curDateTime & vbTab & _
			script & vbTab & _
			userwrk & vbTab & _
			action & vbTab & _
			table & vbTab & _
			field & vbTab & _
			keyvalue & vbTab & _
			oldvalue & vbTab & _
			newvalue
		sFolder = EW_AUDIT_TRAIL_PATH
		sFn = pfx & "_" & ew_ZeroPad(Year(Date), 4) & ew_ZeroPad(Month(Date), 2) & ew_ZeroPad(Day(Date), 2) & ".txt"
		Set fso = Server.Createobject("Scripting.FileSystemObject")
		bWriteHeader = Not fso.FileExists(ew_UploadPathEx(True, sFolder) & sFn)
		Set ts = fso.OpenTextFile(ew_UploadPathEx(True, sFolder) & sFn, 8, True)
		If bWriteHeader Then
			ts.writeline(sHeader)
		End If
		ts.writeline(sMsg)
		ts.Close
		Set ts = Nothing
		Set fso = Nothing
	Else
		Dim sAuditSql
		sAuditSql = "INSERT INTO " & EW_AUDIT_TRAIL_TABLE & _
			" (" & ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_DATETIME) & ", " & _
			ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_SCRIPT) & ", " & _
			ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_USER) & ", " & _
			ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_ACTION) & ", " & _
			ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_TABLE) & ", " & _
			ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_FIELD) & ", " & _
			ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_KEYVALUE) & ", " & _
			ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_OLDVALUE) & ", " & _
			ew_QuotedName(EW_AUDIT_TRAIL_FIELD_NAME_NEWVALUE) & ") " & _
			" VALUES (" & _
			ew_QuotedValue(curDateTime, EW_DATATYPE_DATE) & ", " & _
			ew_QuotedValue(script, EW_DATATYPE_STRING) & ", " & _
			ew_QuotedValue(userwrk, EW_DATATYPE_STRING) & ", " & _
			ew_QuotedValue(action, EW_DATATYPE_STRING) & ", " & _
			ew_QuotedValue(table, EW_DATATYPE_STRING) & ", " & _
			ew_QuotedValue(field, EW_DATATYPE_STRING) & ", " & _
			ew_QuotedValue(keyvalue, EW_DATATYPE_STRING) & ", " & _
			ew_QuotedValue(oldvalue, EW_DATATYPE_STRING) & ", " & _
			ew_QuotedValue(newvalue, EW_DATATYPE_STRING) & ")"

		' Response.Write sAuditSql ' uncomment to debug
		Conn.Execute(sAuditSql)
	End If
End Sub

' Function to check date format "yyyy-MM-dd HH:mm:ss.fffffff zzz"
Function ew_IsDate(ADate)
	If ADate & "" = "" Then
		ew_IsDate = False
	Else
		ew_IsDate = IsDate(ew_GetDateTimePart(ADate))
	End If
End Function

' Function to get DateTime part (remove ".fffffff zzz" from format "yyyy-MM-dd HH:mm:ss.fffffff zzz")
Function ew_GetDateTimePart(ADate)
	If IsNull(ADate) Then
		ew_GetDateTimePart = ADate
	ElseIf InStrRev(ADate,".") > 0 And InStr(ADate,":") > 0 Then
		ew_GetDateTimePart = Mid(ADate, 1, InStrRev(ADate,".")-1)
		If Not IsDate(ew_GetDateTimePart) Or InStr(ew_GetDateTimePart,":") <= 0 Then ew_GetDateTimePart = ADate
	Else
		ew_GetDateTimePart = ADate
	End If
End Function

'-------------------------------------------------------------------------------
' Functions for default date format
' ANamedFormat = 0-8, where 0-4 same as VBScript
' 5 = "yyyymmdd"
' 6 = "mmddyyyy"
' 7 = "ddmmyyyy"
' 8 = Short Date + Short Time
' 9 = "yyyymmdd HH:MM:SS"
' 10 = "mmddyyyy HH:MM:SS"
' 11 = "ddmmyyyy HH:MM:SS"
' 12 - Short Date - 2 digit year (yy/mm/dd)
' 13 - Short Date - 2 digit year (mm/dd/yy)
' 14 - Short Date - 2 digit year (dd/mm/yy)
' 15 - Short Date - 2 digit year (yy/mm/dd) + Short Time (hh:mm:ss)
' 16 - Short Date (mm/dd/yyyy) + Short Time (hh:mm:ss)
' 17 - Short Date (dd/mm/yyyy) + Short Time (hh:mm:ss)
' 99 - "HH:MM:SS"
' Format date time based on format type
Function ew_FormatDateTime(ADate, ANamedFormat)
	Dim sDate
	sDate = ew_GetDateTimePart(ADate)
	If IsDate(sDate) Then
		If ANamedFormat >= 0 And ANamedFormat <= 4 Then
			ew_FormatDateTime = FormatDateTime(sDate, ANamedFormat)
		ElseIf ANamedFormat = 5 Or ANamedFormat = 9 Then
			ew_FormatDateTime = Year(sDate) & EW_DATE_SEPARATOR & Month(sDate) & EW_DATE_SEPARATOR & Day(sDate)
		ElseIf ANamedFormat = 6 Or ANamedFormat = 10 Then
			ew_FormatDateTime = Month(sDate) & EW_DATE_SEPARATOR & Day(sDate) & EW_DATE_SEPARATOR & Year(sDate)
		ElseIf ANamedFormat = 7 Or ANamedFormat = 11 Then
			ew_FormatDateTime = Day(sDate) & EW_DATE_SEPARATOR & Month(sDate) & EW_DATE_SEPARATOR & Year(sDate)
		ElseIf ANamedFormat = 8 Then
			ew_FormatDateTime = FormatDateTime(sDate, 2)
			If Hour(sDate) <> 0 Or Minute(sDate) <> 0 Or Second(sDate) <> 0 Then
				ew_FormatDateTime = ew_FormatDateTime & " " & FormatDateTime(sDate, 4) & ":" & ew_ZeroPad(Second(sDate), 2)
			End If
		ElseIf ANamedFormat = 99 Then
			ew_FormatDateTime = ew_ZeroPad(Hour(sDate), 2) & ":" & ew_ZeroPad(Minute(sDate), 2) & ":" & ew_ZeroPad(Second(sDate), 2)
		ElseIf ANamedFormat = 12 Or ANamedFormat = 15 Then
			ew_FormatDateTime = Right(Year(sDate),2) & EW_DATE_SEPARATOR & Month(sDate) & EW_DATE_SEPARATOR & Day(sDate)
		ElseIf ANamedFormat = 13 Or ANamedFormat = 16 Then
			ew_FormatDateTime = Month(sDate) & EW_DATE_SEPARATOR & Day(sDate) & EW_DATE_SEPARATOR & Right(Year(sDate),2)
		ElseIf ANamedFormat = 14 Or ANamedFormat = 17 Then
			ew_FormatDateTime = Day(sDate) & EW_DATE_SEPARATOR & Month(sDate) & EW_DATE_SEPARATOR & Right(Year(sDate),2)
		Else
			ew_FormatDateTime = sDate
		End If
		If (ANamedFormat >= 9 And ANamedFormat <= 11) Or (ANamedFormat >= 15 And ANamedFormat <= 17) Then
				ew_FormatDateTime = ew_FormatDateTime & " " & ew_ZeroPad(Hour(sDate), 2) & ":" & ew_ZeroPad(Minute(sDate), 2) & ":" & ew_ZeroPad(Second(sDate), 2)
				If Len(ADate) > Len(sDate) Then ew_FormatDateTime = ew_FormatDateTime & Mid(ADate, Len(sDate)+1)
		End If
	Else
		ew_FormatDateTime = ADate
	End If
End Function

' Unformat date time based on format type
Function ew_UnFormatDateTime(ADate, ANamedFormat)
	ew_UnFormatDateTime = ADate ' Default return date
	Dim arDateTime, arDate, i
	ADate = Trim(ADate & "")
	While Instr(ADate, "  ") > 0
		ADate = Replace(ADate, "  ", " ")
	Wend
	arDateTime = Split(ADate, " ")
	If UBound(arDateTime) < 0 Then
		ew_UnFormatDateTime = ADate
		Exit Function
	End If
	If ANamedFormat = 0 And IsDate(ADate) Then
		ew_UnFormatDateTime = Year(arDateTime(0)) & "/" & Month(arDateTime(0)) & "/" & Day(arDateTime(0))
		If UBound(arDateTime) > 0 Then
			For i = 1 to UBound(arDateTime)
				ew_UnFormatDateTime = ew_UnFormatDateTime & " " & arDateTime(i)
			Next
		End If
	Else
		arDate = Split(arDateTime(0), EW_DATE_SEPARATOR)
		If UBound(arDate) = 2 Then
			ew_UnFormatDateTime = arDateTime(0)
			If ANamedFormat = 6 Or ANamedFormat = 10 Then ' mmddyyyy
				If ew_CheckUSDate(arDateTime(0)) Then
					ew_UnFormatDateTime = arDate(2) & "/" & arDate(0) & "/" & arDate(1)
				End If
			ElseIf (ANamedFormat = 7 Or ANamedFormat = 11) Then ' ddmmyyyy
				If ew_CheckEuroDate(arDateTime(0)) Then
					ew_UnFormatDateTime = arDate(2) & "/" & arDate(1) & "/" & arDate(0)
				End If
			ElseIf ANamedFormat = 5 Or ANamedFormat = 9 Then ' yyyymmdd
				If ew_CheckDate(arDateTime(0)) Then
					ew_UnFormatDateTime = arDate(0) & "/" & arDate(1) & "/" & arDate(2)
				End If
			ElseIf ANamedFormat = 12 Or ANamedFormat = 15 Then ' yymmdd
				If ew_CheckShortDate(arDateTime(0)) Then
					ew_UnFormatDateTime = ew_UnformatYear(arDate(0)) & "/" & arDate(1) & "/" & arDate(2)
				End If
			ElseIf ANamedFormat = 13 Or ANamedFormat = 16 Then ' mmddyy
				If ew_CheckShortUSDate(arDateTime(0)) Then
					ew_UnFormatDateTime = ew_UnformatYear(arDate(2)) & "/" & arDate(0) & "/" & arDate(1)
				End If
			ElseIf ANamedFormat = 14 Or ANamedFormat = 17 Then ' ddmmyy
				If ew_CheckShortEuroDate(arDateTime(0)) Then
					ew_UnFormatDateTime = ew_UnformatYear(arDate(2)) & "/" & arDate(1) & "/" & arDate(0)
				End If
			End If
			If UBound(arDateTime) > 0 Then
				For i = 1 to UBound(arDateTime)
					ew_UnFormatDateTime = ew_UnFormatDateTime & " " & arDateTime(i)
				Next
			End If
		Else
			ew_UnFormatDateTime = ADate
		End If
	End If
End Function

' Unformat 2 digit year to 4 digit year
Function ew_UnformatYear(yr)
	ew_UnformatYear = yr
	If Len(yr) = 2 Then
		If IsNumeric(yr) Then
			If CLng(yr) > EW_UNFORMAT_YEAR Then
				ew_UnformatYear = "19" & yr
			Else
				ew_UnformatYear = "20" & yr
			End If
		End If
	End If
End Function

' Format currency
Function ew_FormatCurrency(Expression, NumDigitsAfterDecimal, IncludeLeadingDigit, UseParensForNegativeNumbers, GroupDigits)
	On Error Resume Next
	Dim curLocale
	If EW_USE_SYSTEM_LOCALE Then
		If EW_LOCALE_ID <> 0 Then
			curLocale = GetLocale() ' Save locale
			SetLocale(EW_LOCALE_ID)
		End If
		ew_FormatCurrency = FormatCurrency(Expression, NumDigitsAfterDecimal, IncludeLeadingDigit, UseParensForNegativeNumbers, GroupDigits)
		If EW_LOCALE_ID <> 0 Then
			SetLocale(curLocale) ' Restore locale
		End If
	Else
		Dim val, pos
		curLocale = GetLocale()
		SetLocale("en-us")
		val = FormatNumber(Expression, NumDigitsAfterDecimal, -1, 0, -1)
		pos = InStrRev(val, ".")
		If pos > 0 Then ' Has decimal place
			val = Replace(Mid(val,1,pos-1), ",", EW_THOUSANDS_SEP) & EW_DECIMAL_POINT & Mid(val,pos+1)
		Else
			val = Replace(val, ",", EW_THOUSANDS_SEP)
		End If
		SetLocale(curLocale)
		ew_FormatCurrency = EW_CURRENCY_SYMBOL & val
	End If
	If Err.Number <> 0 Then
		Err.Clear
		ew_FormatCurrency = Expression
	End If
End Function

' Format number for edit
' Expression in format 999999.999 or 999999,999
Function ew_FormatNumber2(Expression, NumDigitsAfterDecimal)
	On Error Resume Next
	If Not IsNumeric(Expression) Then
		ew_FormatNumber2 = Expression
		Exit Function
	End If
	Dim dp, thousandsep, grpdgt
	Dim curLocale, val, pos
	dp = "."
	Expression = Replace(Expression, ",", ".") ' Change 999999,99 to 999999.99
	If NumDigitsAfterDecimal = -2 Then
		If InStrRev(Expression, dp) > 0 Then
			NumDigitsAfterDecimal = Len(Expression) - InStrRev(Expression, dp)
		Else
			NumDigitsAfterDecimal = 0
		End If
	End If
	grpdgt = 0
	curLocale = GetLocale()
	SetLocale("en-us")
	val = FormatNumber(Expression, NumDigitsAfterDecimal, -1, 0, 0)
	pos = InStrRev(val, ".")
	If pos > 0 Then ' Has decimal place
		val = Mid(val,1,pos-1) & EW_DECIMAL_POINT & Mid(val,pos+1)
	End If
	SetLocale(curLocale)
	ew_FormatNumber2 = val
	If Err.Number <> 0 Then
		Err.Clear
		ew_FormatNumber2 = Expression
	End If
End Function

' Format number
Function ew_FormatNumber(Expression, NumDigitsAfterDecimal, IncludeLeadingDigit, UseParensForNegativeNumbers, GroupDigits)
	On Error Resume Next
	If Not IsNumeric(Expression) Then
		ew_FormatNumber = Expression
		Exit Function
	End If
	Dim curLocale, thousandsep, grpdgt
	thousandsep = EW_THOUSANDS_SEP
	grpdgt = GroupDigits

	' Number in format 999999.999 or 999999,999
	If NumDigitsAfterDecimal = -2 Then ' Use all values after decimal point
		Dim dp

		'dp = Mid(FormatNumber(0.1,1,-1),2,1) ' Get decimal point symbol
		dp = "."
		Expression = Replace(Expression, ",", ".") ' Change 999999,99 to 999999.99
		If InStrRev(Expression, dp) > 0 Then
			NumDigitsAfterDecimal = Len(Expression) - InStrRev(Expression, dp)
		Else
			NumDigitsAfterDecimal = 0
		End If
		thousandsep = ""
		grpdgt = 0
	End If
	If EW_USE_SYSTEM_LOCALE Then
		If EW_LOCALE_ID <> 0 Then
			curLocale = GetLocale() ' Save locale
			SetLocale(EW_LOCALE_ID)
		End If
		ew_FormatNumber = FormatNumber(Expression, NumDigitsAfterDecimal, IncludeLeadingDigit, UseParensForNegativeNumbers, grpdgt)
		If EW_LOCALE_ID <> 0 Then
			SetLocale(curLocale) ' Restore locale
		End If
	Else
		Dim val, pos
		If NumDigitsAfterDecimal = -2 Then thousandsep = ""
		curLocale = GetLocale()
		SetLocale("en-us")
		val = FormatNumber(Expression, NumDigitsAfterDecimal, -1, 0, -1)
		pos = InStrRev(val, ".")
		If pos > 0 Then ' Has decimal place
			val = Replace(Mid(val,1,pos-1), ",", thousandsep) & EW_DECIMAL_POINT & Mid(val,pos+1)
		Else
			val = Replace(val, ",", thousandsep)
		End If
		SetLocale(curLocale)
		ew_FormatNumber = val
	End If
	If Err.Number <> 0 Then
		Err.Clear
		ew_FormatNumber = Expression
	End If
End Function

' Format percent
Function ew_FormatPercent(Expression, NumDigitsAfterDecimal, IncludeLeadingDigit, UseParensForNegativeNumbers, GroupDigits)
	On Error Resume Next
	Dim curLocale
	If EW_USE_SYSTEM_LOCALE Then
		If EW_LOCALE_ID <> 0 Then
			curLocale = GetLocale() ' Save locale
			SetLocale(EW_LOCALE_ID)
		End If
		ew_FormatPercent = FormatPercent(Expression, NumDigitsAfterDecimal, IncludeLeadingDigit, UseParensForNegativeNumbers, GroupDigits)
		If EW_LOCALE_ID <> 0 Then
			SetLocale(curLocale) ' Restore locale
		End If
	Else
		Dim val, pos
		curLocale = GetLocale()
		SetLocale("en-us")
		val = FormatNumber(Expression*100, NumDigitsAfterDecimal, -1, 0, -1)
		pos = InStrRev(val, ".")
		If pos > 0 Then ' Has decimal place
			val = Replace(Mid(val,1,pos-1), ",", EW_THOUSANDS_SEP) & EW_DECIMAL_POINT & Mid(val,pos+1)
		Else
			val = Replace(val, ",", EW_THOUSANDS_SEP)
		End If
		SetLocale(curLocale)
		ew_FormatPercent = val & "%"
	End If
	If Err.Number <> 0 Then
		Err.Clear
		ew_FormatPercent = FormatNumber(Expression*100, NumDigitsAfterDecimal, IncludeLeadingDigit, UseParensForNegativeNumbers, GroupDigits) & "%"
		If Err.Number <> 0 Then
			Err.Clear
			ew_FormatPercent = Expression
		End If
	End If
End Function

' Get title
Function ew_HtmlTitle(Name)
	Dim m
	If ew_RegExMatch("\s+title\s*=\s*[\'""]([\s\S]*?)[\'""]", Name, m) Then
		ew_HtmlTitle = m(0).SubMatches(0)
	ElseIf ew_RegExMatch("\s+data-caption\s*=\s*[\'""]([\s\S]*?)[\'""]", Name, m) Then ' Match data-caption='caption'
		ew_HtmlTitle = m(0).SubMatches(0)
	Else
		ew_HtmlTitle = Name
	End If
End Function

' Get title and image
Function ew_HtmlImageAndText(Name)
	Dim title
	If ew_RegExTest("<span([^>]*)>([\s\S]*?)<\/span\s*>", Name) Or ew_RegExTest("<img([^>]*)>", Name) Then
		title = ew_HtmlTitle(Name)
	Else
		title = Name
	End If
	If title <> Name Then
		ew_HtmlImageAndText = Name & "&nbsp;" & title
	Else
		ew_HtmlImageAndText = Name
	End If
End Function

' Get key value
Function ew_GetKeyValue(Key)
	If IsNull(Key) Then
		ew_GetKeyValue = ""
	ElseIf IsArray(Key) Then
		ew_GetKeyValue = Join(Key, EW_COMPOSITE_KEY_SEPARATOR)
	Else
		ew_GetKeyValue = Key
	End If
End Function

' Convert a value to JSON value
' typ: string/boolean
Function ew_VarToJson(val, typ)
	typ = LCase(typ)
	If IsNull(val) Then ' Null
		ew_VarToJson = "null"
	ElseIf val & "" = "" Then ' Empty string
		ew_VarToJson = """"""
	ElseIf typ = "boolean" Or TypeName(val) = "Boolean" Then ' Boolean
		ew_VarToJson = ew_IIf(val, "true", "false")
	ElseIf typ = "date" Or TypeName(val) = "Date" Then
		ew_VarToJson = """" & ew_JsEncode2(val) & """"
	ElseIf typ = "string" Or TypeName(val) = "String" Then ' Default, encode as string
		ew_VarToJson = """" & ew_JsEncode2(val) & """"
	Else
		ew_VarToJson = val
	End If
End Function

' Convert array to JSON
Function ew_ArrayToJson(Ar, Offset)
	Dim arout, arwrk, jsonobject, key, val, i, j
	arout = ""
	If IsArray(Ar) Then
		jsonobject = IsArray(Ar(0,0))
		For j = 0 To UBound(Ar,2)
			If j >= Offset Then
				arwrk = ""
				For i = 0 To UBound(Ar,1)
					key = Null
					val = Null
					If IsArray(Ar(i,j)) And jsonobject Then
						If UBound(Ar(i,j)) >= 1 Then
							key = """" & ew_JsEncode2(Ar(i,j)(0)) & """:"
							val = Ar(i,j)(1)
						End If
					ElseIf Not IsArray(Ar(i,j)) And Not jsonobject Then
						key = ""
						val = Ar(i,j)
					End If
					If Not IsNull(key) And Not IsNull(val) Then
						If Not IsArray(arwrk) Then
							ReDim arwrk(0)
						Else
							ReDim Preserve arwrk(UBound(arwrk)+1)
						End If
						If VarType(val) = 14 Then val = cDbl(val) ' Convert decimal value
						arwrk(UBound(arwrk)) = key & ew_VarToJson(val, "")
					End If
				Next
				If Not IsArray(arout) Then
					ReDim arout(0)
				Else
					ReDim Preserve arout(UBound(arout)+1)
				End If
				If jsonobject Then ' Object
					arout(UBound(arout)) = "{" & Join(arwrk, ",") & "}"
				Else ' Array
					arout(UBound(arout)) = "[" & Join(arwrk, ",") & "]"
				End If
			End If
		Next
	End If
	If IsArray(arout) Then
		ew_ArrayToJson = "[" & Join(arout, ",") & "]"
	Else
		ew_ArrayToJson = ""
	End If
End Function

' Convert dictionary to JSON for HTML attributes
Function ew_ArrayToJsonAttr(Ar)
	Dim str, name, value, i
	str = "{"
	If IsArray(Ar) Then
		For i = 0 to UBound(Ar)
			If IsArray(Ar(i)) Then
				If UBound(Ar(i)) >= 1 Then
					name = Ar(i)(0)
					value = Ar(i)(1)
					str = str & name & ":'" & ew_JsEncode3(value) & "',"
				End If
			End If
		Next
	End If
	If Right(str,1) = "," Then str = Mid(str,1,Len(str)-1)
	str = str & "}"
	ew_ArrayToJsonAttr = str
End Function

' Generate Value Separator based on current row count
' - dispidx - zero based display index
' - fld - field object
Function ew_ValueSeparator(dispidx, fld)
	Dim sep
	If IsObject(fld) Then
		sep = fld.DisplayValueSeparator
	Else
		sep = ", "
	End If
	If IsArray(sep) Then
		ew_ValueSeparator = sep(dispidx-1)
	Else
		ew_ValueSeparator = sep
	End If
End Function

' Generate View Option Separator based on current option count (Multi-Select / CheckBox)
' - optidx - zero based option index
Function ew_ViewOptionSeparator(optidx)
	ew_ViewOptionSeparator = ", "
End Function

' Render repeat column table
' rowcnt - zero based row count
Function ew_RepeatColumnTable(totcnt, rowcnt, repeatcnt, rendertype)
	Dim sWrk, i
	sWrk = ""

	' Render control start
	If rendertype = 1 Then
		If rowcnt = 0 Then sWrk = sWrk & "<table class=""" & EW_ITEM_TABLE_CLASSNAME & """>"
		If (rowcnt mod repeatcnt = 0) Then sWrk = sWrk & "<tr>"
		sWrk = sWrk & "<td>"

	' Render control end
	ElseIf rendertype = 2 Then
		sWrk = sWrk & "</td>"
		If (rowcnt mod repeatcnt = repeatcnt -1) Then
			sWrk = sWrk & "</tr>"
		ElseIf rowcnt = totcnt Then
			For i = ((rowcnt mod repeatcnt) + 1) to repeatcnt - 1
				sWrk = sWrk & "<td>&nbsp;</td>"
			Next
			sWrk = sWrk & "</tr>"
		End If
		If rowcnt = totcnt Then sWrk = sWrk & "</table>"
	End If
	ew_RepeatColumnTable = sWrk
End Function

' Truncate Memo Field based on specified length, string truncated to nearest space or CrLf
Function ew_TruncateMemo(memostr, ln, removeHtml)
	Dim i, j, k
	Dim str
	If removeHtml Then
		str = ew_RemoveHtml(memostr) ' Remove Html
	Else
		str = memostr
	End If
	If Len(str) > 0 And Len(str) > ln Then
		k = 1
		Do While k > 0 And k < Len(str)
			i = InStr(k, str, " ", 1)
			j = InStr(k, str, vbCrLf, 1)
			If i < 0 And j < 0 Then ' Not able to truncate
				ew_TruncateMemo = str
				Exit Function
			Else

				' Get nearest space or CrLf
				If i > 0 And j > 0 Then
					If i < j Then
						k = i
					Else
						k = j
					End If
				ElseIf i > 0 Then
					k = i
				ElseIf j > 0 Then
					k = j
				End If

				' Get truncated text
				If k >= ln Then
					ew_TruncateMemo = Mid(str, 1, k-1) & "..."
					Exit Function
				Else
					k = k + 1
				End If
			End If
		Loop
	Else
		ew_TruncateMemo = str
	End If
End Function

' Remove Html tags from text
Function ew_RemoveHtml(str)
	ew_RemoveHtml = ew_RegExReplace("<[^>]*>", str & "", "")
End Function

' Extract JavaScript from HTML and return converted script
Function ew_ExtractScript(html, cssclass)
	Dim Match, Matches, scripts
	scripts = ""
	If ew_RegExMatch("<script([^>]*)>([\s\S]*?)<\/script\s*>", html, Matches) Then
		For Each Match in Matches
			If ew_RegExTest("(\s+type\s*=\s*[\'""]*(text|application)\/(java|ecma)script[\'""]*)|^((?!\s+type\s*=).)*$", Match.SubMatches(0)) Then ' JavaScript
				html = Replace(html, Match, "", 1, 1) ' Remove the script from HTML
				scripts = scripts & ew_HtmlElement("script", Array(Array("type", "text/html"), Array("class", cssclass)), Match.SubMatches(1)) ' Convert script type and add CSS class, if specified
			End If
		Next
	End If
	ew_ExtractScript = scripts
End Function

' Send email by template
Function ew_SendTemplateEmail(sTemplate, sSender, sRecipient, sCcEmail, sBccEmail, sSubject, arContent)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If sSender <> "" And sRecipient <> "" Then
		Dim Email, i, cnt
		Set Email = New cEmail
		Email.Load(sTemplate)
		Email.ReplaceSender(sSender) ' Replace Sender
		Email.ReplaceRecipient(sRecipient) ' Replace Recipient
		If sCcEmail <> "" Then Email.AddCc sCcEmail ' Add Cc
		If sBccEmail <> "" Then Email.AddBcc sBccEmail ' Add Bcc
		If sSubject <> "" Then Email.ReplaceSubject(sSubject) ' Replace subject
		If IsArray(arContent) Then
			cnt = UBound(arContent) - 1
			If cnt Mod 2 = 1 Then cnt = cnt - 1
			For i = 0 to cnt Step 2
				Email.ReplaceContent arContent(i), arContent(i+1)
			Next
		End If
		ew_SendTemplateEmail = Email.Send()
		Set Email = Nothing
	Else
		ew_SendTemplateEmail = False
	End If
End Function

' Function to Send out Email
' Supports CDO, w3JMail and ASPEmail
Function ew_SendEmail(sFrEmail, sToEmail, sCcEmail, sBccEmail, sSubject, sMail, sFormat, sCharset, sSmtpSecure, arAttachments, arImages)

	'If Not EW_DEBUG_ENABLED Then On Error Resume Next
	On Error Resume Next
	Dim i, objMail, sServerVersion, sIISVer, EmailComponent, arrEmail, sEmail
	Dim arCDO, arASPEmail, arw3JMail, arEmailComponent
	sServerVersion = Request.ServerVariables("SERVER_SOFTWARE")
	If InStr(sServerVersion, "Microsoft-IIS") > 0 Then
		i = InStr(sServerVersion, "/")
		If i > 0 Then
			sIISVer = Trim(Mid(sServerVersion, i+1))
		End If
	End If
	arw3JMail = Array("w3JMail", "JMail.Message")
	arASPEmail = Array("ASPEmail", "Persits.MailSender")
	If sIISVer < "5.0" Then ' NT using CDONTS
		arCDO = Array("CDO", "CDONTS.NewMail")
	Else ' 2000 / XP / 2003 using CDO
		arCDO = Array("CDO", "CDO.Message")
	End If

	' Change your precedence here
	'arEmailComponent = Array(arCDO, arw3JMail, arASPEmail) ' Use CDO as default

	arEmailComponent = Array(arCDO) ' Use CDO only for embedded images
	EmailComponent = ""
	For i = 0 to UBound(arEmailComponent)
		Err.Clear
		Set objMail = Server.CreateObject(arEmailComponent(i)(1))
		If Err.Number = 0 Then
			EmailComponent = arEmailComponent(i)(0)
			Exit For
		End If
	Next
	If EmailComponent = "" Then
		ew_SendEmail = False
		Call ew_Trace("email_err", "Unable to create email component. Error Number: " & Hex(Err.Number))
		Exit Function
	End If
	If EmailComponent = "w3JMail" Then

		' Set objMail = Server.CreateObject("JMail.Message")
		If sCharset <> "" Then objMail.Charset = sCharset

		'*** Do not support SSL
		objMail.Logging = True
		objMail.Silent = True
		objMail.From = sFrEmail
		arrEmail = Split(Replace(sToEmail, ",", ";"), ";")
		For i = 0 to UBound(arrEmail)
			sEmail = Trim(arrEmail(i))
			If sEmail <> "" Then
				objMail.AddRecipient sEmail
			End If
		Next
		arrEmail = Split(Replace(sCcEmail, ",", ";"), ";")
		For i = 0 to UBound(arrEmail)
			sEmail = Trim(arrEmail(i))
			If sEmail <> "" Then
				objMail.AddRecipientCC sEmail
			End If
		Next
		arrEmail = Split(Replace(sBccEmail, ",", ";"), ";")
		For i = 0 to UBound(arrEmail)
			sEmail = Trim(arrEmail(i))
			If sEmail <> "" Then
				objMail.AddRecipientBCC sEmail
			End If
		Next
		objMail.Subject = sSubject
		If LCase(sFormat) = "html" Then
			objMail.HTMLBody = sMail
		Else
			objMail.Body = sMail
		End If
		If IsArray(arAttachments) Then
			For i = 0 to UBound(arAttachments)
				If Trim(arAttachments(i)) <> "" Then
					objMail.AddAttachment Trim(arAttachments(i))
				End If
			Next
		End If
		If EW_SMTP_SERVER_USERNAME <> "" And EW_SMTP_SERVER_PASSWORD <> "" Then
			objMail.MailServerUserName = EW_SMTP_SERVER_USERNAME
			objMail.MailServerPassword = EW_SMTP_SERVER_PASSWORD
		End If
		ew_SendEmail = objMail.Send(EW_SMTP_SERVER)
		If Not ew_SendEmail Then
			Err.Raise vbObjectError + 1, EmailComponent, objMail.Log
		End If
		Set objMail = nothing
	ElseIf EmailComponent = "ASPEmail" Then

		' Set objMail = Server.CreateObject("Persits.MailSender")
		If sCharset <> "" Then objMail.CharSet = sCharset
		objMail.From = sFrEmail
		arrEmail = Split(Replace(sToEmail, ",", ";"), ";")
		For i = 0 to UBound(arrEmail)
			sEmail = Trim(arrEmail(i))
			If sEmail <> "" Then
				objMail.AddAddress sEmail
			End If
		Next
		arrEmail = split(Replace(sCcEmail, ",", ";"), ";")
		For i = 0 to UBound(arrEmail)
			sEmail = Trim(arrEmail(i))
			If sEmail <> "" Then
				objMail.AddCC sEmail
			End If
		Next
		arrEmail = split(Replace(sBccEmail, ",", ";"), ";")
		For i = 0 to UBound(arrEmail)
			sEmail = Trim(arrEmail(i))
			If sEmail <> "" Then
				objMail.AddBcc sEmail
			End If
		Next
		If LCase(sFormat) = "html" Then
			objMail.IsHTML = True ' html
		Else
			objMail.IsHTML = False ' text
		End If
		objMail.Subject = sSubject
		objMail.Body = sMail
		objMail.Host = EW_SMTP_SERVER
		If LCase(sSmtpSecure&"") = "ssl" Then ' ssl
			objMail.TLS = True ' Use TLS
		End If
		If IsArray(arAttachments) Then
			For i = 0 to UBound(arAttachments)
				If Trim(arAttachments(i)) <> "" Then
					objMail.AddAttachment Trim(arAttachments(i))
				End If
			Next
		End If
		If EW_SMTP_SERVER_USERNAME <> "" And EW_SMTP_SERVER_PASSWORD <> "" Then
			objMail.Username = EW_SMTP_SERVER_USERNAME
			objMail.Password = EW_SMTP_SERVER_PASSWORD
		End If
		ew_SendEmail = objMail.Send
		Set objMail = Nothing
	ElseIf EmailComponent = "CDO" Then
		Dim objConfig, sSmtpServer, iSmtpServerPort
		If sIISVer < "5.0" Then ' NT using CDONTS

			' Set objMail = Server.CreateObject("CDONTS.NewMail")
			'***If sCharset <> "" Then objMail.BodyPart.Charset = sCharset ' Do not support charset, ignore
			'*** ' Do not support SSL, ignore

			objMail.From = sFrEmail
			objMail.To = Replace(sToEmail, ",", ";")
			If sCcEmail <> "" Then
				objMail.Cc = Replace(sCcEmail, ",", ";")
			End If
			If sBccEmail <> "" Then
				objMail.Bcc = Replace(sBccEmail, ",", ";")
			End If
			If LCase(sFormat) = "html" Then
				objMail.BodyFormat = 0 ' 0 means HTML format, 1 means text
				objMail.MailFormat = 0 ' 0 means MIME, 1 means text
			End If
			objMail.Subject = sSubject
			objMail.Body = sMail
			If IsArray(arAttachments) Then
				For i = 0 to UBound(arAttachments)
					If Trim(arAttachments(i)) <> "" Then
						objMail.AttachFile Trim(arAttachments(i))
					End If
				Next
			End If
			objMail.Send
			Set objMail = Nothing
		Else ' 2000 / XP / 2003 using CDO

			' Set up Configuration
			Set objConfig = Server.CreateObject("CDO.Configuration")
			objConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = EW_SMTP_SERVER ' cdoSMTPServer
			objConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = EW_SMTP_SERVER_PORT ' cdoSMTPServerPort
			objConfig.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
			If LCase(sSmtpSecure&"") = "ssl" Then
				objConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = True ' Use SSL
			End If
			If EW_SMTP_SERVER_USERNAME <> "" And EW_SMTP_SERVER_PASSWORD <> "" Then
				objConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'cdoBasic (clear text)
				objConfig.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername") = EW_SMTP_SERVER_USERNAME
				objConfig.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword") = EW_SMTP_SERVER_PASSWORD
			End If
			objConfig.Fields.Update

			' Set up Mail
			'Set objMail = Server.CreateObject("CDO.Message")

			objMail.From = sFrEmail
			objMail.To = Replace(sToEmail, ",", ";")
			If sCcEmail <> "" Then
				objMail.Cc = Replace(sCcEmail, ",", ";")
			End If
			If sBccEmail <> "" Then
				objMail.Bcc = Replace(sBccEmail, ",", ";")
			End If
			If sCharset <> "" Then objMail.BodyPart.Charset = sCharset
			If LCase(sFormat) = "html" Then
				objMail.HtmlBody = sMail
				If sCharset <> "" Then objMail.HtmlBodyPart.Charset = sCharset
			Else
				objMail.TextBody = sMail
				If sCharset <> "" Then objMail.TextBodyPart.Charset = sCharset
			End If
			objMail.Subject = sSubject
			If IsArray(arAttachments) Then
				For i = 0 to UBound(arAttachments)
					If Trim(arAttachments(i)) <> "" Then
						objMail.AddAttachment Trim(arAttachments(i))
					End If
				Next
			End If
			Dim imgfile, cid, objBP
			If IsArray(arImages) Then
				For i = 0 to UBound(arImages)
					imgfile = ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH) & arImages(i)
					cid = ew_TmpImageLnk(arImages(i), "cid")
					Set objBP = objMail.AddRelatedBodyPart(imgfile, cid, 0) ' cdoRefTypeId = 0
					objBP.Fields.Item("urn:schemas:mailheader:Content-ID") = "<" & cid & ">"
					objBP.Fields.Update
				Next
			End If
			If EW_SMTP_SERVER <> "" And LCase(EW_SMTP_SERVER) <> "localhost" Then
				Set objMail.Configuration = objConfig ' Use Configuration
				objMail.Send
			Else
				objMail.Send ' Send without Configuration
				If Err.Number <> 0 Then
					If Hex(Err.Number) = "80040220" Then ' Requires Configuration
						Set objMail.Configuration = objConfig
						Err.Clear
						objMail.Send
					End If
				End If
			End If
			Set objMail = Nothing
			Set objConfig = Nothing
		End If
		ew_SendEmail = (Err.Number = 0)
	End If

	' Send email failed, write error to log
	If Not ew_SendEmail Then
		gsEmailErrNo = Err.Number
		gsEmailErrDesc = Err.Description
		Call ew_Trace("email_err", "***Send email failed***")
		Call ew_Trace("email_err", "Email component: " & EmailComponent)
		Call ew_Trace("email_err", "Error Number: " & Hex(gsEmailErrNo))
		Call ew_Trace("email_err", "Error Description: " & gsEmailErrDesc)
		Call ew_Trace("email_err", "From: " & sFrEmail)
		Call ew_Trace("email_err", "To: " & sToEmail)
		Call ew_Trace("email_err", "Cc: " & sCcEmail)
		Call ew_Trace("email_err", "Bcc: " & sToEmail)
		Call ew_Trace("email_err", "Subject: " & sSubject)
	End If
End Function 

' Clean email content
Function ew_CleanEmailContent(Content)
	Content = Replace(Content, "class=""ewGrid""", "")
	Content = Replace(Content, "class=""table-responsive ewGridMiddlePanel""", "")
	Content = Replace(Content, "table ewTable", "ewExportTable")
	Content = Replace(Content, "</td>", "</td>" & vbCrLf)
	ew_CleanEmailContent = Content
End Function

' Load content at url using xmlhttp
Function ew_LoadContentFromUrl(url)

	'On Error Resume Next
	Dim http
	Set http = Server.CreateObject("MSXML2.ServerXMLHTTP")
	http.setTimeouts 20000,20000,20000,30000
	http.Open "GET", url, False
	http.send
	ew_LoadContentFromUrl = http.responseText
End Function

Function ew_FieldDataType(FldType) ' Field data type
	Select Case FldType
		Case 20, 3, 2, 16, 4, 5, 131, 139, 6, 17, 18, 19, 21 ' Numeric
			ew_FieldDataType = EW_DATATYPE_NUMBER
		Case 7, 133, 135, 146 ' Date
			ew_FieldDataType = EW_DATATYPE_DATE
		Case 134, 145 ' Time
			ew_FieldDataType = EW_DATATYPE_TIME
		Case 201, 203 ' Memo
			ew_FieldDataType = EW_DATATYPE_MEMO
		Case 129, 130, 200, 202 ' String
			ew_FieldDataType = EW_DATATYPE_STRING
		Case 11 ' Boolean
			ew_FieldDataType = EW_DATATYPE_BOOLEAN
		Case 72 ' GUID
			ew_FieldDataType = EW_DATATYPE_GUID
		Case 128, 204, 205 ' Binary
			ew_FieldDataType = EW_DATATYPE_BLOB
		Case 141 ' Xml
			ew_FieldDataType = EW_DATATYPE_XML
		Case Else
			ew_FieldDataType = EW_DATATYPE_OTHER
		End Select
End Function

' Return path of the uploaded file
'	Parameter: If PhyPath is true(1), return physical path on the server;
'	           If PhyPath is false(0), return relative URL
Function ew_UploadPathEx(PhyPath, DestPath)
	Dim Pos, Path
	If PhyPath Then
		ew_UploadPathEx = ew_PathCombine(ew_AppRoot(), Replace(DestPath, "/", "\"), PhyPath)
	Else

		'Path = ew_ScriptName()
		'Path = Mid(Path, 1, InStrRev(Path, "/"))
		'Path = ew_PathCombine(Path, EW_ROOT_RELATIVE_PATH, False)
		'ew_UploadPathEx = ew_PathCombine(ew_IncludeTrailingDelimiter(Path, False), DestPath, False)

		ew_UploadPathEx = ew_PathCombine(EW_ROOT_RELATIVE_PATH, DestPath, False)
	End If
	ew_UploadPathEx = ew_IncludeTrailingDelimiter(ew_UploadPathEx, PhyPath)
End Function

' Change the file name of the uploaded file
Function ew_UploadFileNameEx(Folder, FileName)
	Dim OutFileName

	' By default, ewUniqueFilename() is used to get an unique file name.
	' Amend your logic here

	OutFileName = ew_UniqueFilename(Folder, FileName, False)

	' Return computed output file name
	ew_UploadFileNameEx = OutFileName
End Function

' Return path of the uploaded file
' returns global upload folder, for backward compatibility only
Function ew_UploadPath(PhyPath)
	ew_UploadPath = ew_UploadPathEx(PhyPath, EW_UPLOAD_DEST_PATH)
End Function

' Change the file name of the uploaded file
' use global upload folder, for backward compatibility only
Function ew_UploadFileName(FileName)
	ew_UploadFileName = ew_UploadFileNameEx(ew_UploadPath(True), FileName)
End Function

' Generate an unique file name (filename(n).ext)
Function ew_UniqueFilename(Folder, FileName, Indexed)
	If FileName = "" Then FileName = ew_DefaultFileName()
	If FileName = "." Then
		Response.Write "Invalid file name: " & FileName
		Response.End
		Exit Function
	End If
	If Folder = "" Then
		Response.Write "Unspecified folder"
		Response.End
		Exit Function
	End If
	Dim Name, Ext, Pos
	Name = ""
	Ext = ""
	Pos = InStrRev(FileName, ".")
	If Pos = 0 Then
		Name = FileName
		Ext = ""
	Else
		Name = Mid(FileName, 1, Pos-1)
		Ext = Mid(FileName, Pos+1)
	End If
	Folder = ew_IncludeTrailingDelimiter(Folder, True)
	Dim fso
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If Not fso.FolderExists(Folder) Then
		If Not ew_CreateFolder(Folder) Then
			Response.Write "Folder does not exist: " & Folder
			Set fso = Nothing
			Exit Function
		End If
	End If
	Dim Suffix, Index, matches
	If Indexed Then
		If ew_RegExMatch("\((\d+)\)$", Name, matches) Then
			Index = matches(0).SubMatches(0)
			Index = Index + 1
		Else
			Index = 1
		End If
		Suffix = "(" & Index & ")"
	Else
		Index = 0
		Suffix = ""
	End If

	' Check to see if filename exists
	Name = ew_RegExReplace("\(\d+\)$", Name, "") ' Remove "(n)" at the end of the file name
	While fso.FileExists(folder & Name & Suffix & "." & Ext)
		Index = Index + 1
		Suffix = "(" & Index & ")"
	Wend
	Set fso = Nothing

	' Return unique file name
	ew_UniqueFilename = Name & Suffix & "." & Ext
End Function

' Create a default file name (yyyymmddhhmmss.bin)
Function ew_DefaultFileName()
	Dim dt
	dt = Now()
	ew_DefaultFileName = ew_ZeroPad(Year(dt), 4) & ew_ZeroPad(Month(dt), 2) &  _
		ew_ZeroPad(Day(dt), 2) & ew_ZeroPad(Hour(dt), 2) & _
		ew_ZeroPad(Minute(dt), 2) & ew_ZeroPad(Second(dt), 2) & ".bin"
End Function

' Application root
Function ew_AppRoot()
	Dim Path
	Path = ""

	' 1. use root relative path
	If EW_ROOT_RELATIVE_PATH <> "" Then
		Path = ew_PathCombine(Server.MapPath("."), EW_ROOT_RELATIVE_PATH, True)
	Else
		Path = Server.MapPath(".")
	End If

	' 2. if empty, use the document root if available
	If Path = "" Then
		Path = Request.ServerVariables("APPL_PHYSICAL_PATH")
	End If

	' 3. if empty, use current folder
	If Path = "" Then
		Path = Server.MapPath(".")
	End If

	' 4. use custom path, uncomment the following line and enter your path, e.g.
	' Path = "C:\Inetpub\wwwroot\MyWebRoot"
	'Path = "enter your path here"

	If Path = "" Then
		Response.Write "Path of website root unknown."
		Response.End
	End If
	ew_AppRoot = ew_IncludeTrailingDelimiter(Path, True)
End Function

' Get path relative to application root
Function ew_ServerMapPath(Path)
	ew_ServerMapPath = ew_RemoveTrailingDelimiter(ew_PathCombine(ew_AppRoot(), Path, True), True)
End Function

' Write the paths for config/debug only
Sub ew_WritePaths()
	Response.Write "EW_ROOT_RELATIVE_PATH=" & EW_ROOT_RELATIVE_PATH & "<br>"
	Response.Write "ew_AppRoot()=" & ew_AppRoot() & "<br>"
	Response.Write "Request.ServerVariables(""APPL_PHYSICAL_PATH"")=" & Request.ServerVariables("APPL_PHYSICAL_PATH") & "<br>"
	Response.Write "Request.ServerVariables(""APPL_MD_PATH"")=" & Request.ServerVariables("APPL_MD_PATH") & "<br>"
	Response.Write "Server.MapPath(""."")=" & Server.MapPath(".") & "<br>"
End Sub

' Get refer page name
Function ew_ReferPage()
	ew_ReferPage = ew_GetPageName(Request.ServerVariables("HTTP_REFERER"))
End Function

' Check if folder exists
Function ew_FolderExists(Folder)
	Dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")
	ew_FolderExists = fso.FolderExists(Folder)
	Set fso = Nothing
End Function

' Check if file exists
Function ew_FileExists(Folder, File)
	Dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")
	ew_FileExists = fso.FileExists(ew_IncludeTrailingDelimiter(Folder, True) & File)
	Set fso = Nothing
End Function

' Delete file
Sub ew_DeleteFile(FilePath)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	Dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")
	If FilePath <> "" And fso.FileExists(FilePath) Then
		fso.DeleteFile(FilePath)
	End If
	Set fso = Nothing
End Sub

' Rename file
Sub ew_RenameFile(OldFilePath, NewFilePath)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	Dim fso
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If OldFilePath <> "" And fso.FileExists(OldFilePath) Then
		fso.MoveFile OldFilePath, NewFilePath
	End If
	Set fso = Nothing
End Sub

' Create folder
Function ew_CreateFolder(Folder)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	ew_CreateFolder = False
	If Folder & "" = "" Then ' Ignore empty folder
		ew_CreateFolder = True
		Exit Function
	End If
	Dim fso
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If Not fso.FolderExists(Folder) Then
		If ew_CreateFolder(fso.GetParentFolderName(Folder)) Then
			fso.CreateFolder(Folder)
			If Err.Number = 0 Then ew_CreateFolder = True
		End If
	Else
		ew_CreateFolder = True
	End If
	Set fso = Nothing
End Function

' Add an element to a position of an array
Function ew_AddItemToArray(ar, pos, aritem)
	Dim newar(), d1, d2, d3, p
	Dim i, j
	If not IsArray(aritem) Then
		ew_AddItemToArray = ar
		Exit Function
	End If
	d3 = UBound(aritem)
	If not IsArray(ar) Then
		Redim newar(d3,0)
		For i = 0 to d3
			newar(i,0) = aritem(i)
		Next
		ew_AddItemToArray = newar
		Exit Function
	Else
		d1 = UBound(ar,1)
		d2 = UBound(ar,2)
		p = pos
		If p < 0 Then p = 0 ' add at front
		If p > d2 Then p = d2 ' add at end
		Redim newar(d1, d2+1)

		' Copy item before p
		For j = 0 to p-1
			For i = 0 to d1
				newar(i,j) = ar(i,j)
			Next
		Next

		' Copy new item
		For i = 0 to d1
			If i <= d3 Then
				newar(i,p) = aritem(i)
			Else
				newar(i,p) = "" ' Initialize to empty string
			End If
		Next

		' Copy the rest
		For j = p to d2
			For i = 0 to d1
				newar(i,j+1) = ar(i,j)
			Next
		Next
	End If
	ew_AddItemToArray = newar
End Function

' Remove an element from a position of an array
Function ew_RemoveItemFromArray(ar, pos)
	Dim newar(), d1, d2
	Dim i, j
	ew_RemoveItemFromArray = Null
	If IsArray(ar) Then
		d1 = UBound(ar,1)
		d2 = UBound(ar,2)
		If pos < 0 Or pos > d2 Then
			ew_RemoveItemFromArray = ar
			Exit Function
		End If
		If d2 = 0 Then
			ew_RemoveItemFromArray = Null
		Else
			Redim newar(d1, d2-1)

			' Copy items before pos
			For j = 0 to pos-1
				For i = 0 to d1
					newar(i,j) = ar(i,j)
				Next
			Next

			' Copy items after pos
			For j = pos+1 to d2
				For i = 0 to d1
					newar(i,j-1) = ar(i,j)
				Next
			Next
			ew_RemoveItemFromArray = newar
		End If
	End If
End Function

' Functions for Export
Function ew_ExportHeader(ExpType)
	Select Case ExpType
		Case "html", "email"
			ew_ExportHeader = "<table class=""ewExportTable"">"
			If EW_EXPORT_CSS_STYLES Then
				ew_ExportHeader = "<style>" & ew_LoadFile(EW_PROJECT_STYLESHEET_FILENAME) & "</style>" & ew_ExportHeader
			End If
		Case "word", "excel"
			ew_ExportHeader = "<table>"
		Case "csv"
			ew_ExportHeader = ""
	End Select
End Function

Function ew_ExportFooter(ExpType)
	Select Case ExpType
		Case "html", "email", "word", "excel"
			ew_ExportFooter = "</table>"
		Case "csv"
			ew_ExportFooter = ""
	End Select
End Function

Sub ew_ExportAddValue(str, val, ExpType, Attr)
	Select Case ExpType
		Case "html", "email", "word", "excel"
			str = str & "<td"
			If Attr <> "" Then str = str & " " & Attr
			str = str & ">" & val & "</td>"
		Case "csv"
			If str <> "" Then str = str & ","
			str = str & """" & Replace(val & "", """", """""") & """"
	End Select
End Sub

Function ew_ExportLine(str, ExpType, Attr)
	Select Case ExpType
		Case "html", "email", "word", "excel"
			ew_ExportLine = "<tr"
			If Attr <> "" Then ew_ExportLine = ew_ExportLine & " " & Attr
			ew_ExportLine = ew_ExportLine & ">" & str & "</tr>"
		Case "csv"
			ew_ExportLine = str & vbCrLf
	End Select
End Function

Function ew_ExportField(cap, val, ExpType, Attr)
	Dim sTD
	sTD = "<td"
	If Attr <> "" Then sTD = sTD & " " & Attr
	sTD = sTD & ">"
	ew_ExportField = "<tr>" & sTD & cap & "</td>" & sTD & val & "</td></tr>"
End Function

' Check if field exists in recordset
Function ew_FieldExistInRs(rs, fldname)
	Dim fld
	For Each fld in rs.Fields
		If fld.name = fldname then
			ew_FieldExistInRs = True
			Exit Function
    End If
	Next
	ew_FieldExistInRs = False
End Function

' Calculate field hash
Function ew_GetFldHash(value, fldtype)
	ew_GetFldHash = MD5(ew_GetFldValueAsString(value, fldtype))
End Function

' Get field value as string
Function ew_GetFldValueAsString(value, fldtype)
	If IsNull(value) Then
		ew_GetFldValueAsString = ""
	Else
		If fldtype = 128 Or fldtype = 204 Or fldtype = 205 Then ' Binary
			If EW_BLOB_FIELD_BYTE_COUNT > 0 Then
				ew_GetFldValueAsString = ew_ByteToString(LeftB(value,EW_BLOB_FIELD_BYTE_COUNT))
			Else
				ew_GetFldValueAsString = ew_ByteToString(value)
			End If
		Else

			'ew_GetFldValueAsString = CStr(value)
			ew_GetFldValueAsString = ew_ByteToString(value) ' Avoid binary characters
		End If
	End If
End Function

' Convert byte to string
Function ew_ByteToString(b)
	Dim i
	For i = 1 to LenB(b)

		'ew_ByteToString = ew_ByteToString & Chr(AscB(MidB(b,i,1)))
		ew_ByteToString = ew_ByteToString & CStr(AscB(MidB(b,i,1))) ' Just use the ascii code to avoid Chr conversion error
	Next
End Function

' Write global debug message
Function ew_DebugMsg()
	Dim msg
	msg = ew_RegExReplace("^<br>\n", gsDebugMsg, "")
	gsDebugMsg = ""
	If msg <> "" Then
		ew_DebugMsg = "<div class=""alert alert-info ewAlert"">" & msg & "</div>"
	Else
		ew_DebugMsg = ""
	End If
End Function

' Write global debug message
Sub ew_SetDebugMsg(v)
	Call ew_AddMessage(gsDebugMsg, v)
End Sub

' Html5 file upload related (start)
Function ew_UploadTempPath(fldvar)
	If fldvar <> "" Then
		ew_UploadTempPath = ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH) & EW_UPLOAD_TEMP_FOLDER_PREFIX & Session.SessionID & "\" & fldvar
	Else
		ew_UploadTempPath = ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH) & EW_UPLOAD_TEMP_FOLDER_PREFIX & Session.SessionID
	End If
End Function

' Render upload field to temp path
Sub ew_RenderUploadField(fld, idx)
	Dim fldvar, fso, folder, thumbnailfolder, filename, filepath, f, data, width, height, files, i, srcfile
	fldvar = ew_IIf(idx < 0, fld.FldVar, Mid(fld.FldVar, 1, 1) & idx & Mid(fld.FldVar, 2))
	folder = ew_UploadTempPath(fldvar)
	ew_CleanUploadTempPaths("") ' Clean all old temp folders
	Call ew_CleanPath(folder, False) ' Clean the upload folder
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	If Not fso.FolderExists(folder) Then
		If Not ew_CreateFolder(folder) Then
			Response.Write "Cannot create folder: " & folder
			Response.End
		End If
	End If
	thumbnailfolder = ew_PathCombine(folder, EW_UPLOAD_THUMBNAIL_FOLDER, True)
	If Not fso.FolderExists(thumbnailfolder) Then
		If Not ew_CreateFolder(thumbnailfolder) Then
			Response.Write "Cannot create folder: " & thumbnailfolder
			Response.End
		End If
	End If
	If fld.FldDataType = EW_DATATYPE_BLOB Then ' Blob field
		If Not ew_Empty(fld.Upload.DbValue) Then

			' Create upload file
			filename = ew_IIf(fld.Upload.FileName <> "", fld.Upload.FileName, Mid(fld.FldVar, 3))
			f = ew_IncludeTrailingDelimiter(folder, True) & filename
			Call ew_CreateUploadFile(folder, filename, fld.Upload.DbValue)

			' Create thumbnail file
			f = ew_IncludeTrailingDelimiter(thumbnailfolder, True) & filename
			data = fld.Upload.DbValue
			width = EW_UPLOAD_THUMBNAIL_WIDTH
			height = EW_UPLOAD_THUMBNAIL_HEIGHT
			Call ew_ResizeBinary(data, width, height, EW_THUMBNAIL_DEFAULT_INTERPOLATION)
			Call ew_CreateUploadFile(thumbnailfolder, filename, data)
			fld.Upload.FileName = filename ' Update file name
		End If
	Else ' Upload to folder
		fld.Upload.FileName = fld.Upload.DbValue ' Update file name
		If Not ew_Empty(fld.Upload.FileName) Then
			filepath = Mid(fld.Upload.FileName, 1, InStrRev(Replace(fld.Upload.FileName, "\", "/"), "/"))
			If filepath <> "" Then
				fld.Upload.FileName = Mid(fld.Upload.FileName, Len(filepath)+1)
				filepath = ew_IncludeTrailingDelimiter(fld.UploadPath, False) & filepath
			Else
				filepath = fld.UploadPath
			End If

			' Create upload file
			filename = fld.Upload.FileName
			If fld.UploadMultiple Then
				files = Split(filename, EW_MULTIPLE_UPLOAD_SEPARATOR)
			Else
				ReDim files(0)
				files(0) = filename
			End If
			For i = 0 to UBound(files)
				filename = files(i)
				If filename <> "" Then
					srcfile = ew_UploadPathEx(True, filepath) & filename
					f = ew_IncludeTrailingDelimiter(folder, True) & filename
					If fso.FileExists(srcfile) Then
						data = ew_LoadBinaryFile(srcfile)
						Call ew_CreateUploadFile(folder, filename, data)
					Else
						Call ew_CreateImageFromText(Language.Phrase("FileNotFound"), f, EW_UPLOAD_THUMBNAIL_WIDTH, 0, "")
						data = ew_LoadBinaryFile(f)
					End If

					' Create thumbnail file
					f = ew_IncludeTrailingDelimiter(thumbnailfolder, True) & filename
					width = EW_UPLOAD_THUMBNAIL_WIDTH
					height = EW_UPLOAD_THUMBNAIL_HEIGHT
					Call ew_ResizeBinary(data, width, height, EW_THUMBNAIL_DEFAULT_INTERPOLATION)
					Call ew_CreateUploadFile(thumbnailfolder, filename, data)
				End If
			Next
		End If
	End If
	Set fso = Nothing
End Sub

Function ew_CreateUploadFile(folder, fn, data)
	If InStrRev(fn, ".") <= 0 Then
		Dim ext
		ext = ew_ContentExt(LeftB(data,11))
		If ext <> "" Then
			fn = fn & ext
		End If
	End If
	ew_CreateUploadFile = ew_SaveFile(folder, fn, data)
End Function

Sub ew_CreateImageFromText(txt, file, width, height, font)

	' Use hard-coded image
	Dim fso, wrkfile 
	wrkfile = Server.MapPath("images/filenotfound.jpg")
	Set fso = CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(wrkfile) Then
		fso.CopyFile wrkfile, file, True
	End If
	file = wrkfile
	Set fso = Nothing
End Sub

Sub ew_CleanUploadTempPaths(sessionid)
	Dim folder, fso, oRootFolder, oFolders, oSubFolder, oFiles, oFile
	Dim subfolder, tempfolder, lastmdtime
	On Error Resume Next
	folder = ew_UploadPathEx(True, EW_UPLOAD_DEST_PATH)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If fso.FolderExists(folder) Then

		' Get root folder
		Set oRootFolder = fso.GetFolder(folder)

		' Process list of subfolders
		Set oFolders = oRootFolder.SubFolders
		For Each oSubFolder in oFolders
			subfolder = oSubFolder.Name
			tempfolder = ew_PathCombine(folder, subfolder, True)
			If EW_UPLOAD_TEMP_FOLDER_PREFIX & sessionid = subfolder Then ' Clean session folder
				Call ew_CleanPath(tempfolder, True)
			ElseIf Mid(subfolder, 1, Len(EW_UPLOAD_TEMP_FOLDER_PREFIX)) = EW_UPLOAD_TEMP_FOLDER_PREFIX Then
				If EW_UPLOAD_TEMP_FOLDER_PREFIX & Session.SessionID <> subfolder Then
					If ew_IsEmptyPath(tempfolder) Then ' Empty folder
						Call ew_CleanPath(tempfolder, True)
					Else ' Old folder
						lastmdtime = oSubFolder.DateLastModified
						If CLng(DateDiff("n", lastmdtime, Now)) > EW_UPLOAD_TEMP_FOLDER_TIME_LIMIT Then
							Call ew_CleanPath(tempfolder, True)
						End If
					End If
				End If
			End If
		Next
	End If
	Set fso = Nothing
End Sub

Sub ew_CleanUploadTempPath(fld, idx)
	Dim fldvar, folder
	On Error Resume Next
	fldvar = ew_IIf(idx < 0, fld.FldVar, Mid(fld.FldVar, 1, 1) & idx & Mid(fld.FldVar, 2))
	folder = ew_UploadTempPath(fldvar)
	Call ew_CleanPath(folder, True) ' Clean the upload folder

	' Remove complete temp folder if empty
	folder = ew_UploadTempPath("")
	If ew_IsEmptyPath(folder) Then
		Call ew_CleanPath(folder, True)
	End If
End Sub

Sub ew_CleanPath(folder, delete)
	Dim fso, oRootFolder, oFolders, oSubFolder, oFiles, oFile, tempfolder
	On Error Resume Next
	folder = ew_IncludeTrailingDelimiter(folder, True)
	Set fso = CreateObject("Scripting.FileSystemObject")
	If fso.FolderExists(folder) Then
		Set oRootFolder = fso.GetFolder(folder)
		Set oFiles = oRootFolder.Files
		For Each oFile in oFiles
			oFile.Delete
		Next

		' Clear sub folders
		Set oFolders = oRootFolder.SubFolders
		For Each oSubFolder in oFolders
			tempfolder = ew_PathCombine(folder, oSubFolder.Name, True)
			Call ew_CleanPath(tempfolder, delete)
		Next
		If delete Then oRootFolder.Delete
	End If
	Set fso = Nothing
End Sub

Function ew_IsEmptyPath(folder)
	Dim IsEmptyPath
	Dim fso, oRootFolder, oFolders, oSubFolder, oFiles, tempfolder
	On Error Resume Next
	IsEmptyPath = True
	folder = ew_IncludeTrailingDelimiter(folder, True)
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	If fso.FolderExists(folder) Then
		Set oRootFolder = fso.GetFolder(folder)
		Set oFiles = oRootFolder.Files
		If oFiles.Count > 0 Then
			ew_IsEmptyPath = False ' No need to check further
			Set fso = Nothing
			Exit Function
		End If
		Set oFolders = oRootFolder.SubFolders
		For Each oSubFolder in oFolders
			tempfolder = ew_PathCombine(folder, oSubFolder.Name, True)
			IsEmptyPath = ew_IsEmptyPath(tempfolder)
			If Not IsEmptyPath Then
				ew_IsEmptyPath = False ' No need to check further
				Set fso = Nothing
				Exit Function
			End If
		Next
	Else
		IsEmptyPath = False
	End If
	ew_IsEmptyPath = IsEmptyPath
End Function

Function ew_FolderFileCount(folder)
	Dim fso, oFolder
	On Error Resume Next
	ew_FolderFileCount = 0
	folder = ew_IncludeTrailingDelimiter(folder, True)
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If fso.FolderExists(folder) Then
		Set oFolder = fso.GetFolder(folder)
		ew_FolderFileCount = oFolder.Files.Count
	End If
	Set fso = Nothing
End Function

' Html5 file upload related (end)
'
'  Common functions (end)
' ------------------------
' Menu class
Class cMenu

	Public Id

	Public MenuBarClassName

	Public MenuClassName

	Public SubMenuClassName

	Public SubMenuDropdownImage

	Public SubMenuDropdownIconClassName

	Public MenuDividerClassName

	Public MenuItemClassName

	Public SubMenuItemClassName

	Public MenuActiveItemClassName

	Public SubMenuActiveItemClassName

	Public MenuRootGroupTitleAsSubMenu

	Public ShowRightMenu

	Public MenuLinkDropdownClass

	Public MenuLinkClassName

	Public IsMobile

	Public IsRoot

	Public ItemData

	' Init
	Private Sub Class_Initialize
		MenuBarClassName = EW_MENUBAR_CLASSNAME
		MenuClassName = EW_MENU_CLASSNAME
		SubMenuClassName = EW_SUBMENU_CLASSNAME
		SubMenuDropdownImage = EW_SUBMENU_DROPDOWN_IMAGE
		SubMenuDropdownIconClassName = EW_SUBMENU_DROPDOWN_ICON_CLASSNAME
		MenuDividerClassName = EW_MENU_DIVIDER_CLASSNAME
		MenuItemClassName = EW_MENU_ITEM_CLASSNAME
		SubMenuItemClassName = EW_SUBMENU_ITEM_CLASSNAME
		MenuActiveItemClassName = EW_MENU_ACTIVE_ITEM_CLASS
		SubMenuActiveItemClassName = EW_SUBMENU_ACTIVE_ITEM_CLASS
		MenuRootGroupTitleAsSubMenu = EW_MENU_ROOT_GROUP_TITLE_AS_SUBMENU
		ShowRightMenu = EW_SHOW_RIGHT_MENU
		MenuLinkDropdownClass = ""
		MenuLinkClassName = ""
		IsRoot = False
		IsMobile = False
		Set ItemData = Server.CreateObject("Scripting.Dictionary") ' Data type: array of cMenuItem
	End Sub

	' Terminate
	Private Sub Class_Terminate
		Set ItemData = Nothing
	End Sub

	' Get menu item count
	Function Count()
		Count = ItemData.Count
	End Function

	' Move item to position
	Sub MoveItem(Text, Pos)
		Dim i, oldpos, bfound, Items
		Set Items = ItemData
		If Pos < 0 Then
			Pos = 0
		ElseIf Pos >= Items.Count Then
			Pos = Items.Count - 1
		End If
		bfound = False
		For i = 0 To Items.Count - 1
			If Items.Item(i).Text = Text Then
				bfound = True
				oldpos = i
				Exit For
			End If
		Next
		If bfound And Pos <> oldpos Then
			Items.Key(oldpos) = Items.Count ' Move out of position first
			If oldpos < Pos Then ' Shuffle backward
				For i = oldpos+1 to Pos
					Items.Key(i) = i-1
				Next
			Else ' Shuffle forward
				For i = oldpos-1 to Pos Step -1
					Items.Key(i) = i+1
				Next
			End If
			Items.Key(Items.Count) = Pos ' Move to position
		End If
	End Sub

	' Create a menu item
	Function NewMenuItem(id, name, text, url, parentid, source, target, allowed, grouptitle, customurl)
		Set NewMenuItem = New cMenuItem
		NewMenuItem.Id = id
		NewMenuItem.Name = name
		NewMenuItem.Text = text
		NewMenuItem.Url = url
		NewMenuItem.ParentId = parentid
		NewMenuItem.Target = target
		NewMenuItem.Source = source
		NewMenuItem.Allowed = allowed
		NewMenuItem.GroupTitle = grouptitle
		NewMenuItem.IsCustomUrl = customurl
	End Function

	' Add a menu item
	Sub AddMenuItem(id, name, text, url, parentid, source, target, allowed, grouptitle, customurl)
		Dim item, oParentMenu
		Set item = NewMenuItem(id, name, text, url, parentid, source, target, allowed, grouptitle, customurl)
		Set item.Parent = Me
		If Not MenuItem_Adding(item) Then
			Exit Sub
		End If
		If item.ParentId < 0 Then
			AddItem(item)
		Else
			If FindItem(item.ParentId, oParentMenu) Then
				oParentMenu.AddItem item, IsMobile
			End If
		End If
	End Sub

	' Add item to internal dictionary
	Sub AddItem(item)
		ItemData.Add ItemData.Count, item
	End Sub

	' Clear all menu items
	Sub Clear()
		Dim i
		For i = 0 To ItemData.Count -1
			Set ItemData.Item(i) = Nothing
		Next
		ItemData.RemoveAll
	End Sub

	' Find item
	Function FindItem(id, out)
		Dim i, item
		FindItem = False
		For i = 0 To ItemData.Count -1
			If ItemData.Item(i).Id = id Then
				Set out = ItemData.Item(i)
				FindItem = True
				Exit Function
			ElseIf Not IsNull(ItemData.Item(i).SubMenu) Then
				FindItem = ItemData.Item(i).SubMenu.FindItem(id, out)
			End If
		Next
	End Function

	' Find item by menu text
	Function FindItemByText(txt, out)
		Dim i, item
		FindItemByText = False
		For i = 0 To ItemData.Count -1
			If ItemData.Item(i).Text = txt Then
				Set out = ItemData.Item(i)
				FindItemByText = True
				Exit Function
			ElseIf Not IsNull(ItemData.Item(i).SubMenu) Then
				FindItemByText = ItemData.Item(i).SubMenu.FindItemByText(txt, out)
			End If
		Next
	End Function

	' Check if sub menu should be shown
	Function RenderSubMenu(item)
		Dim i, subitem
		If Not IsNull(item.SubMenu) Then
			For i = 0 To item.SubMenu.ItemData.Count - 1
				If item.SubMenu.RenderItem(item.SubMenu.ItemData.Item(i)) Then
					RenderSubMenu = True
					Exit Function
				End If
			Next
		End If
		RenderSubMenu = False
	End Function

	' Check if a menu item should be shown
	Function RenderItem(item)
		Dim i, subitem
		If Not IsNull(item.SubMenu) Then
			For i = 0 To item.SubMenu.ItemData.Count - 1
				If item.SubMenu.RenderItem(item.SubMenu.ItemData.Item(i)) Then
					RenderItem = True
					Exit Function
				End If
			Next
		End If
		RenderItem = (item.Allowed And item.Url <> "")
	End Function

	' Check if this menu should be rendered
	Function RenderMenu()
		Dim i
		For i = 0 To ItemData.Count - 1
			If RenderItem(ItemData.Item(i)) Then
				RenderMenu = True
				Exit Function
			End If
		Next
		RenderMenu = False
	End Function

	' Render the menu
	Function Render(ret)
		Dim str, gcnt, gtitle, i, j, itemcnt, item, aclass, liclass, cururl
		Dim brandhref
		If IsRoot Then Call Menu_Rendering(Me)
		If Not RenderMenu() Then Exit Function
		If Not IsMobile Then
			If IsRoot Then
				str = "<ul"
				If Id <> "" Then
					If IsNumeric(Id) Then
						str = str & " id=""menu_" & Id & """"
					Else
						str = str & " id=""" & Id & """"
					End If
				End If
				str = str & " class=""" & MenuClassName & """>" & vbCrLf
			Else
				str = "<ul class=""" & SubMenuClassName & """ role=""menu"">" & vbCrLf
			End If
		Else
			str = ""
		End If
		gcnt = 0 ' Group count
		gtitle = False ' Last item is group title
		i = 0 ' Menu item count
		cururl = Mid(ew_CurrentUrl, InstrRev(ew_CurrentUrl, "/")+1)
		itemcnt = ItemData.Count
		For j = 0 to itemcnt - 1
			Set item = ItemData.Item(j)
			If RenderItem(item) Then
				i = i + 1
				If Not IsMobile And gtitle And (gcnt >= 1 Or IsRoot) Then ' Add divider for previous group
					str = str & "<li class=""" & MenuDividerClassName & """></li>" & vbCrLf
				End If
				If item.GroupTitle And (Not IsRoot Or Not MenuRootGroupTitleAsSubMenu) Then ' Group title
					gtitle = True
					gcnt = gcnt + 1
					If item.Text <> "" Then
						If IsMobile Then
							str = str & "<li data-role=""list-divider"">" & item.Text & "</li>" & vbCrLf
						Else
							str = str & "<li class=""dropdown-header"">" & item.Text & "</li>" & vbCrLf
						End If
					End If
					If Not IsNull(item.SubMenu) Then
						Dim subitem, subitemcnt, k
						subitemcnt = item.SubMenu.ItemData.Count
						For k = 0 to subitemcnt - 1
							Set subitem = item.SubMenu.ItemData.Item(k)
							liclass = ew_IIf(Not IsNull(subitem.SubMenu) And RenderSubMenu(subitem), SubMenuItemClassName, "")
							aclass = ""
							If Not subitem.IsCustomUrl And ew_CurrentPage = ew_GetPageName(subitem.Url) Or subitem.IsCustomUrl And cururl = subitem.Url Then
								Call ew_AppendClass(liclass, MenuActiveItemClassName)
								subitem.Url = "javascript:void(0);"
							End If
							If RenderItem(subitem) Then
								If IsMobile And item.GroupTitle Then
									Call ew_AppendClass(aclass, "ewIndent")
								End If
								str = str & subitem.Render(aclass, liclass, IsMobile) & vbCrLf ' Create <LI>
							End If
						Next
					End If
				Else
					gtitle = False
					liclass = ew_IIf(Not IsNull(item.SubMenu) And RenderSubMenu(item), ew_IIf(IsRoot, MenuItemClassName, SubMenuItemClassName), "")
					aclass = ""
					If Not item.IsCustomUrl And ew_CurrentPage = ew_GetPageName(item.Url) Or item.IsCustomUrl And cururl = item.Url Then
						If IsRoot Then
							Call ew_AppendClass(liclass, MenuActiveItemClassName)
						Else
							Call ew_AppendClass(liclass, SubMenuActiveItemClassName)
						End If
						item.Url = "javascript:void(0);"
					End If
					str = str & item.Render(aclass, liclass, IsMobile) & vbCrLf ' Create <LI>
				End If
			End If
		Next
		If IsMobile Then
			str = "<ul data-role=""listview"" data-filter=""true"">" & str & "</ul>" & vbCrLf
		ElseIf IsRoot Then
			str = str & "</ul>" & vbCrLf
			If EW_MENUBAR_BRAND <> "" Then
				brandhref = ew_IIf(EW_MENUBAR_BRAND_HYPERLINK = "", "#", EW_MENUBAR_BRAND_HYPERLINK)
				str = "<a class=""navbar-brand hidden-xs"" href=""" & ew_HtmlEncode(brandhref) & """>" & EW_MENUBAR_BRAND & "</a>" & str
			End If

			' Add right menu
			If ShowRightMenu Then
				str = str & "<ul class=""nav navbar-nav navbar-right""></ul>"
			End If
			If MenuBarClassName <> "" Then
				str = "<div class=""" & MenuBarClassName & """>" & str & "</div>"
			End If
		Else
			str = str & "</ul>" & vbCrLf
		End If
		If ret Then ' Return as string
			Render = str
		Else
			Response.Write str ' Output
		End If
	End Function
End Class

' Menu item class
Class cMenuItem

	Public Id

	Public Name

	Public Text

	Public Url

	Public ParentId

	Public Source

	Public Target

	Public Allowed

	Public GroupTitle

	Public IsCustomUrl

	Public Parent

	Public Mobile

	Public SubMenu ' Data type = cMenu

	Private Sub Class_Initialize
		Url = ""
		GroupTitle = False
		IsCustomUrl = False
		Mobile = True
		SubMenu = Null
	End Sub

	Sub AddItem(item, mobile) ' Add submenu item
		If IsNull(SubMenu) Then
			Set SubMenu = New cMenu
			SubMenu.Id = Id
			SubMenu.IsMobile = mobile
			SubMenu.MenuBarClassName = Parent.MenuBarClassName
			SubMenu.MenuClassName = Parent.MenuClassName
			SubMenu.SubMenuClassName = Parent.SubMenuClassName
			SubMenu.SubMenuDropdownImage = Parent.SubMenuDropdownImage
			SubMenu.SubMenuDropdownIconClassName = Parent.SubMenuDropdownIconClassName
			SubMenu.MenuDividerClassName = Parent.MenuDividerClassName
			SubMenu.MenuItemClassName = Parent.MenuItemClassName
			SubMenu.SubMenuItemClassName = Parent.SubMenuItemClassName
			SubMenu.MenuActiveItemClassName = Parent.MenuActiveItemClassName
			SubMenu.SubMenuActiveItemClassName = Parent.SubMenuActiveItemClassName
			SubMenu.MenuRootGroupTitleAsSubMenu = Parent.MenuRootGroupTitleAsSubMenu
			SubMenu.MenuLinkDropdownClass = Parent.MenuLinkDropdownClass
			SubMenu.MenuLinkClassName = Parent.MenuLinkClassName
		End If
		SubMenu.AddItem(item)
	End Sub

	' Render
	Function Render(aclass, liclass, mobile)

		' Create <A>
		Dim attrs, attrs2, innerhtml, wrkurl, wrktext, wrktext2, submenuhtml
		wrkurl = ew_GetUrl(Url)
		If Not IsNull(SubMenu) Then
			submenuhtml = SubMenu.Render(True)
		Else
			submenuhtml = ""
		End If
		If mobile Then
			wrkurl = Replace(Url, "#", "?chart=")
			If wrkurl = "" Then wrkurl = "#"
			attrs = Array(Array("class", aclass), Array("rel", ew_IIf(wrkurl <> "#", "external", "")), Array("href", wrkurl), Array("target", Target))
		Else
			If wrkurl = "" Then wrkurl = "#"
			If Not IsNull(SubMenu) Then
				If SubMenu.MenuLinkDropdownClass <> "" And submenuhtml <> "" Then
					Call ew_PrependClass(aclass, SubMenu.MenuLinkDropdownClass)
				End If
			End If
			attrs = Array(Array("class", aclass), Array("href", wrkurl), Array("target", Target))
		End If
		wrktext = Text
		If Not IsNull(SubMenu) And submenuhtml <> "" Then
			If Parent.SubMenuDropdownIconClassName <> "" Then
				wrktext = wrktext & "<span class=""" & Parent.SubMenuDropdownIconClassName & """></span>"
			End If
			If Parent.SubMenuDropdownImage <> "" And ParentId = -1 Then
				wrktext = wrktext & Parent.SubMenuDropdownImage
			End If
		End If
		innerhtml = ew_HtmlElement("a", attrs, wrktext, True)
		If Not IsNull(SubMenu) Then
			If wrkurl <> "#" And SubMenu.MenuLinkClassName <> "" And submenuhtml <> "" Then ' Add click link for mobile menu
				attrs2 = Array(Array("class", "ewMenuLink"), Array("href", wrkurl))
				wrktext2 = "<span class=""" & SubMenu.MenuLinkClassName & """></span>"
				innerhtml = ew_HtmlElement("a", attrs2, wrktext2, True) & innerhtml
			End If
			If mobile And wrkurl <> "#" Then
				innerhtml = innerhtml & innerhtml
			End If
			innerhtml = innerhtml & submenuhtml
		End If

		' Create <LI>
		Render = ew_HtmlElement("li", Array(Array("id", Name), Array("class", liclass)), innerhtml, True)
	End Function

	Function AsString
		AsString = "{ Id: " & Id & ", Text: " & Text & ", Url: " & Url & ", ParentId: " & ParentId & ", Target: " & Target & ", Source: " & Source & ", Allowed: " & Allowed
		If IsNull(SubMenu) Then
			AsString = AsString & ", SubMenu: (Null)"
		Else
			AsString = AsString & ", SubMenu: (Object)"
		End If
		AsString = AsString & " }" & "<br>"
	End Function
End Class

' Menu Rendering event
Sub Menu_Rendering(Menu)

	' Change menu items here
End Sub

Function MenuItem_Adding(Item)

	'Response.Write Item.AsString
	' Return False if menu item not allowed

	MenuItem_Adding = True
End Function

' ------------------------
'  Language class (begin)
'
Class cLanguage
	Dim LanguageId
	Dim objDOM
	Dim objDict
	Dim LanguageFolder
	Dim Key

	' Class initialize
	Private Sub Class_Initialize
		LanguageFolder = EW_RELATIVE_PATH & EW_LANGUAGE_FOLDER
	End Sub

	' Load phrases
	Public Sub LoadPhrases()

		' Set up file list
		LoadFileList()

		' Set up language id
		If Request.QueryString("language") <> "" Then
			LanguageId = Request.QueryString("language")
			Session(EW_SESSION_LANGUAGE_ID) = LanguageId
		ElseIf Session(EW_SESSION_LANGUAGE_ID) <> "" Then
			LanguageId = Session(EW_SESSION_LANGUAGE_ID)
		Else
			LanguageId = EW_LANGUAGE_DEFAULT_ID
		End If
		gsLanguage = LanguageId
		If EW_USE_DOM_XML Then
			Set objDOM = ew_CreateXmlDom()
			objDOM.async = False
		Else
			Set objDict = Server.CreateObject("Scripting.Dictionary")
		End If

		' Load current language
		Load(LanguageId)
	End Sub

	' Terminate
	Private Sub Class_Terminate()
		If EW_USE_DOM_XML Then
			Set objDOM = Nothing
		Else
			Set objDict = Nothing
		End If
	End Sub

	' Load language file list
	Private Sub LoadFileList()
		If IsArray(EW_LANGUAGE_FILE) Then
			For i = 0 to UBound(EW_LANGUAGE_FILE)
				EW_LANGUAGE_FILE(i)(1) = LoadFileDesc(Server.MapPath(LanguageFolder & EW_LANGUAGE_FILE(i)(2)))
			Next
		End If
	End Sub

	' Load language file description
	Private Function LoadFileDesc(File)
		LoadFileDesc = ""
		Set objDOM = ew_CreateXmlDom()
		objDOM.async = False
		objDOM.Load(File)
		If objDOM.ParseError.ErrorCode = 0 Then
			LoadFileDesc = GetNodeAtt(objDOM.documentElement, "desc")
		End If
	End Function

	' Load language file
	Private Sub Load(id)
		Dim sFileName
		sFileName = GetFileName(id)
		If sFileName = "" Then
			sFileName = GetFileName(EW_LANGUAGE_DEFAULT_ID)
		End If
		If sFileName = "" Then Exit Sub
		If EW_USE_DOM_XML Then
			objDOM.Load(sFileName)
			If objDOM.ParseError.ErrorCode = 0 Then
				objDOM.setProperty "SelectionLanguage", "XPath"
			End If
		Else
			XmlToCollection(sFileName)
		End If

		' Set up LCID from language file
		Dim langLCID
		If LocalePhrase("use_system_locale") = "1" Then
			langLCID = LocalePhrase("LCID")
			If langLCID <> "0" Then
				Dim curLocale
				curLocale = GetLocale() ' Save current locale
				SetLocale(langLCID)
				EW_DECIMAL_POINT = Mid(FormatNumber(0.0,1,0,0,0),1,1) ' Get decimal point
				EW_THOUSANDS_SEP = Mid(FormatNumber(1000,0,0,0,-2),2,1) ' Get thousands sep
				EW_LOCALE_ID = langLCID
				If IsNumeric(EW_THOUSANDS_SEP) Then EW_THOUSANDS_SEP = ""
				SetLocale(curLocale) ' Restore locale
			End If
		Else
			EW_DECIMAL_POINT = LocalePhrase("decimal_point") ' Get decimal point
			EW_THOUSANDS_SEP = LocalePhrase("thousands_sep") ' Get thousands sep
			EW_CURRENCY_SYMBOL = LocalePhrase("currency_symbol") ' Get thousands sep
			EW_USE_SYSTEM_LOCALE = False
		End If
	End Sub

	Private Sub IterateNodes(Node)
		If Node.baseName = vbNullString Then Exit Sub
		Dim Index, Id, Client, ImageUrl, ImageWidth, ImageHeight, ImageClass
		If Node.nodeType = 1 And Node.baseName <> "ew-language" Then ' NODE_ELEMENT
			Id = ""
			If Node.attributes.length > 0 Then
				Id = Node.getAttribute("id")
			End If
			If Node.hasChildNodes Then
				Key = Key & Node.baseName & "/"
				If Id <> "" Then Key = Key & Id & "/"
			End If
			If Id <> "" And Not Node.hasChildNodes Then ' phrase
				Id = Node.baseName & "/" & Id
				Client = Node.getAttribute("client") & ""
				ImageUrl = Node.getAttribute("imageurl") & ""
				ImageWidth = Node.getAttribute("imagewidth") & ""
				ImageHeight = Node.getAttribute("imageheight") & ""
				ImageClass = Node.getAttribute("class") & ""
				If Id <> "" Then 
					objDict(Key & Id & "/attr/value") = Node.getAttribute("value") & ""
					If Client <> "" Then objDict(Key & Id & "/attr/client") = Client
					If ImageUrl <> "" Then objDict(Key & Id & "/attr/imageurl") = ImageUrl
					If ImageWidth <> "" Then objDict(Key & Id & "/attr/imagewidth") = ImageWidth
					If ImageHeight <> "" Then objDict(Key & Id & "/attr/imageheight") = ImageHeight
					If ImageClass <> "" Then objDict(Key & Id & "/attr/class") = ImageClass
				End If
			End If
		End If
		If Node.hasChildNodes Then
			For Index = 0 To Node.childNodes.length - 1
				IterateNodes Node.childNodes(Index)
			Next
			Index	=	InStrRev(Key, "/"	&	Node.baseName & "/")
			If Index > 0	Then Key = Left(Key, Index)
		End If
	End Sub

	' Convert XML to Collection
	Private Sub XmlToCollection(File)
		Dim I, xmlr
		Key = "/"
		Set xmlr = ew_CreateXmlDom()
		xmlr.async = False
		xmlr.Load(File)
		For I = 0 To xmlr.childNodes.length - 1
			IterateNodes xmlr.childNodes(I)
		Next
		Set xmlr = Nothing
	End Sub

	' Get language file name
	Private Function GetFileName(Id)
		GetFileName = ""
		If IsArray(EW_LANGUAGE_FILE) Then
			For i = 0 to UBound(EW_LANGUAGE_FILE)
				If EW_LANGUAGE_FILE(i)(0) = Id Then
					GetFileName = Server.MapPath(LanguageFolder & EW_LANGUAGE_FILE(i)(2))
					Exit For
				End If
			Next
		End If
	End Function

	' Get node attribute
	Private Function GetNodeAtt(Node, Att)
		If Not (Node Is Nothing) Then
			GetNodeAtt = Node.getAttribute(Att)
		Else
			GetNodeAtt = ""
		End If
	End Function

	' Get dictionary attribute
	Private Function GetDictAtt(Att)
		If objDict.Exists(Att) Then
			GetDictAtt = objDict(Att)
		Else
			GetDictAtt = ""
		End If
	End Function

	' Get locale phrase
	Public Function LocalePhrase(Id)
		If EW_USE_DOM_XML Then
			LocalePhrase = GetNodeAtt(objDOM.SelectSingleNode("//locale/phrase[@id='" & LCase(Id) & "']"), "value")
		Else
			LocalePhrase = GetDictAtt("/locale/phrase/" & LCase(Id) & "/attr/value")
		End If  
	End Function

	' Set locale phrase
	Public Sub SetLocalePhrase(Id, Value)
		If Not EW_USE_DOM_XML Then
			objDict("/locale/phrase/" & LCase(Id) & "/attr/value") = Value
		End If
	End Sub

	' Get phrase
	Public Function Phrase(Id)
		Dim Text, ImageUrl, ImageWidth, ImageHeight, ImageClass, Style
		If EW_USE_DOM_XML Then
			ImageUrl = GetNodeAtt(objDOM.SelectSingleNode("//global/phrase[@id='" & LCase(Id) & "']"), "imageurl")
			ImageWidth = GetNodeAtt(objDOM.SelectSingleNode("//global/phrase[@id='" & LCase(Id) & "']"), "imagewidth")
			ImageHeight = GetNodeAtt(objDOM.SelectSingleNode("//global/phrase[@id='" & LCase(Id) & "']"), "imageheight")
			ImageClass = GetNodeAtt(objDOM.SelectSingleNode("//global/phrase[@id='" & LCase(Id) & "']"), "class")
			Text = GetNodeAtt(objDOM.SelectSingleNode("//global/phrase[@id='" & LCase(Id) & "']"), "value")
		Else
			ImageUrl = GetDictAtt("/global/phrase/" & LCase(Id) & "/attr/imageurl")
			ImageWidth = GetDictAtt("/global/phrase/" & LCase(Id) & "/attr/imagewidth")
			ImageHeight = GetDictAtt("/global/phrase/" & LCase(Id) & "/attr/imageheight")
			ImageClass = GetDictAtt("/global/phrase/" & LCase(Id) & "/attr/class")
			Text = GetDictAtt("/global/phrase/" & LCase(Id) & "/attr/value")
		End If
		If ImageClass <> "" Then
			Phrase = "<span data-phrase=""" & Id & """ class=""" & ImageClass & """ data-caption=""" & ew_HtmlEncode(Text) & """></span>"
		ElseIf ImageUrl <> "" Then
			Style = ew_IIf(ImageWidth <> "", " width: " & ImageWidth & "px;", "")
			Style = Style & ew_IIf(ImageHeight <> "", " height: " & ImageHeight & "px;", "")
			Phrase = "<img data-phrase=""" & Id & """ src=""" & ew_HtmlEncode(ImageUrl) & """ style=""" & Style & """ alt=""" & ew_HtmlEncode(Text) & """ title=""" & ew_HtmlEncode(Text) & """>"
		Else
			Phrase = Text
		End If
	End Function

	' Set phrase
	Public Sub SetPhrase(Id, Value)
		If Not EW_USE_DOM_XML Then
			objDict("/global/phrase/" & LCase(Id) & "/attr/value") = Value
		End If
	End Sub

	' Get project phrase
	Public Function ProjectPhrase(Id)
		If EW_USE_DOM_XML Then
			ProjectPhrase = GetNodeAtt(objDOM.SelectSingleNode("//project/phrase[@id='" & LCase(Id) & "']"), "value")
		Else
			ProjectPhrase = GetDictAtt("/project/phrase/" & LCase(Id) & "/attr/value")
		End If
	End Function

	' Set project phrase
	Public Sub SetProjectPhrase(Id, Value)
		If Not EW_USE_DOM_XML Then
			objDict("/project/phrase/" & LCase(Id) & "/attr/value") = Value
		End If
	End Sub

	' Get menu phrase
	Public Function MenuPhrase(MenuId, Id)
		If EW_USE_DOM_XML Then
			MenuPhrase = GetNodeAtt(objDOM.SelectSingleNode("//project/menu[@id='" & MenuId & "']/phrase[@id='" & LCase(Id) & "']"), "value")
		Else
			MenuPhrase = GetDictAtt("/project/menu/" & MenuId & "/phrase/" & LCase(Id) & "/attr/value")
		End If
	End Function

	' Set menu phrase
	Public Sub SetMenuPhrase(MenuId, Id, Value)
		If Not EW_USE_DOM_XML Then
			objDict("/project/menu/" & MenuId & "/phrase/" & LCase(Id) & "/attr/value") = Value
		End If
	End Sub

	' Get table phrase
	Public Function TablePhrase(TblVar, Id)
		If EW_USE_DOM_XML Then
			TablePhrase = GetNodeAtt(objDOM.SelectSingleNode("//project/table[@id='" & LCase(TblVar) & "']/phrase[@id='" & LCase(Id) & "']"), "value")
		Else
			TablePhrase = GetDictAtt("/project/table/" & LCase(TblVar) & "/phrase/" & LCase(Id) & "/attr/value")
		End If
	End Function

	' Set table phrase
	Public Sub SetTablePhrase(TblVar, Id, Value)
		If Not EW_USE_DOM_XML Then
			objDict("/project/table/" & LCase(TblVar) & "/phrase/" & LCase(Id) & "/attr/value") = Value
		End If
	End Sub

	' Get field phrase
	Public Function FieldPhrase(TblVar, FldVar, Id)
		If EW_USE_DOM_XML Then
			FieldPhrase = GetNodeAtt(objDOM.SelectSingleNode("//project/table[@id='" & LCase(TblVar) & "']/field[@id='" & LCase(FldVar) & "']/phrase[@id='" & LCase(Id) & "']"), "value")
		Else
			FieldPhrase = GetDictAtt("/project/table/" & LCase(TblVar) & "/field/" & LCase(FldVar) & "/phrase/" & LCase(Id) & "/attr/value")
		End If
	End Function

	' Set field phrase
	Public Sub SetFieldPhrase(TblVar, FldVar, Id, Value)
		If Not EW_USE_DOM_XML Then
			objDict("/project/table/" & LCase(TblVar) & "/field/" & LCase(FldVar) & "/phrase/" & LCase(Id) & "/attr/value") = Value
		End If
	End Sub

	' Output XML as JSON
	Public Function XmlToJSON(XPath)
		Dim Node, NodeList, Id, Value, Str
		Set NodeList = objDOM.selectNodes(XPath)
		Str = "{"
		For Each Node In NodeList
			Id = GetNodeAtt(Node, "id")
			Value = GetNodeAtt(Node, "value")
			Str = Str & """" & ew_JsEncode2(Id) & """:""" & ew_JsEncode2(Value) & ""","
		Next
		If Right(Str, 1) = "," Then Str = Left(Str, Len(Str)-1)
		Str = Str & "}"
		XmlToJSON = Str
	End Function

	' Output collection as JSON
	Public Function CollectionToJSON(Prefix, Client)
		Dim Name, Id, Str, Pos, Keys, I
		Dim Suffix, IsClient
		Suffix = "/attr/value"
		Str = "{"
		Keys = objDict.Keys
		For I = 0 To Ubound(Keys)
			Name = Keys(I)
			If Left(Name, Len(Prefix)) = Prefix And Right(Name, Len(Suffix)) = Suffix Then
				Pos = InStrRev(Name, Suffix)
				Id = Mid(Name, Len(Prefix) + 1, Pos - Len(Prefix) - 1)
				IsClient = (GetDictAtt(Prefix & Id & "/attr/client") = "1")
				If Not Client Or Client And IsClient Then
					Str = Str & """" & ew_JsEncode2(Id) & """:""" & ew_JsEncode2(GetDictAtt(Name)) & ""","
				End If
			End If
		Next  
		If Right(Str, 1) = "," Then Str = Left(Str, Len(Str)-1)
		Str = Str & "}"
		CollectionToJSON = Str
	End Function

	' Output all phrases as JSON
	Public Function AllToJSON()
		If EW_USE_DOM_XML Then
			AllToJSON ="var ewLanguage = new ew_Language(" & XmlToJSON("//global/phrase") & ");"
		Else
			AllToJSON = "var ewLanguage = new ew_Language(" & CollectionToJSON("/global/phrase/", False) & ");"
		End If
	End Function

	' Output client phrases as JSON
	Public Function ToJSON()
		If EW_USE_DOM_XML Then
			ToJSON = "var ewLanguage = new ew_Language(" & XmlToJSON("//global/phrase[@client='1']") & ");"
		Else
			ToJSON = "var ewLanguage = new ew_Language(" & CollectionToJSON("/global/phrase/", True) & ");"
		End If
	End Function

	' Output language selection form
	Public Function SelectionForm()
		Dim form, cnt, i, langid, langphrase, selected, wrkphrase
		form = ""
		If IsArray(EW_LANGUAGE_FILE) Then
			cnt = UBound(EW_LANGUAGE_FILE)+1
			If cnt > 1 Then
				For i = 0 to cnt-1
					langid = EW_LANGUAGE_FILE(i)(0)
					langphrase = EW_LANGUAGE_FILE(i)(1)
					selected = ew_IIf(langid = gsLanguage, " selected=""selected""", "")
					wrkphrase = Phrase(langid)
					If wrkphrase = "" Then ' Use description for button
						wrkphrase = langphrase
					End If
					form = form & "<option value=""" & langid & """" & selected & ">" & wrkphrase & "</option>"
				Next
			End If
		End If
		If form <> "" Then
			form = "<div class=""ewLanguageOption""><select class=""form-control"" id=""ewLanguage"" name=""ewLanguage"" onchange=""ew_SetLanguage(this);"">" & form & "</select></div>"
		End If
		SelectionForm = form
	End Function
End Class

'
'  Language class (end)
' ----------------------
' Format sequence number
Function ew_FormatSeqNo(seq)
	ew_FormatSeqNo =  Replace(Language.Phrase("SequenceNumber"), "%s", seq)
End Function

' Encode value for single-quoted JavaScript string
Function ew_JsEncode(val)
	val = Replace(val & "", "\", "\\")
	val = Replace(val, "'", "\'")

'	val = Replace(val, vbCrLf, "\r\n")
'	val = Replace(val, vbCr, "\r")
'	val = Replace(val, vbLf, "\n")

	val = Replace(val, vbCrLf, "<br>")
	val = Replace(val, vbCr, "<br>")
	val = Replace(val, vbLf, "<br>")
	ew_JsEncode = val
End Function

' Encode value for double-quoted Javascript string
Function ew_JsEncode2(val)
	val = Replace(val & "", "\", "\\")
	val = Replace(val, """", "\""")

'	val = Replace(val, vbCrLf, "\r\n")
'	val = Replace(val, vbCr, "\r")
'	val = Replace(val, vbLf, "\n")

	val = Replace(val, vbCrLf, "<br>")
	val = Replace(val, vbCr, "<br>")
	val = Replace(val, vbLf, "<br>")
	ew_JsEncode2 = val
End Function

' Encode value to single-quoted Javascript string for HTML attributes
Function ew_JsEncode3(val)
	val = Replace(val & "", "\", "\\")
	val = Replace(val, "'", "\'")
	val = Replace(val, """", "&quot;")
	ew_JsEncode3 = val
End Function

' Get full url
Function ew_FullUrl()
	ew_FullUrl = ew_DomainUrl() & ew_ScriptName()
End Function 

' Get current script name
Function ew_ScriptName()
	ew_ScriptName = Request.ServerVariables("SCRIPT_NAME")
End Function

' Check if HTTP POST
Function ew_IsHttpPost()
	Dim ct
	ct = Request.ServerVariables("HTTP_CONTENT_TYPE")
	If InStr(ct, "application/x-www-form-urlencoded") > 0 Then
		ew_IsHttpPost = True
	Else
		ew_IsHttpPost = False
	End If
End Function

' Get current page name
Function ew_CurrentPage()
	ew_CurrentPage = ew_GetPageName(ew_ScriptName())
End Function

' Get page name
Function ew_GetPageName(url)
	If url <> "" Then
		ew_GetPageName = url
		If InStr(ew_GetPageName, "?") > 0 Then
			ew_GetPageName = Mid(ew_GetPageName, 1, InStr(ew_GetPageName, "?")-1) ' Remove querystring first
		End If
		ew_GetPageName = Mid(ew_GetPageName, InStrRev(ew_GetPageName, "/")+1) ' Remove path
	Else
		ew_GetPageName = ""
	End If
End Function

' Get domain url
Function ew_DomainUrl()
	Dim sUrl, bSSL, sPort, defPort
	sUrl = "http"
	bSSL = ew_IsHttps()
	sPort = Request.ServerVariables("SERVER_PORT")
	If bSSL Then defPort = "443" Else defPort = "80"
	If sPort = defPort Then sPort = "" Else sPort = ":" & sPort
	If bSSL Then sUrl = sUrl & "s"
	sUrl = sUrl & "://"
	sUrl = sUrl & Request.ServerVariables("SERVER_NAME") & sPort
	ew_DomainUrl = sUrl
End Function 

' Get jQuery files host
Function ew_jQueryHost()
	ew_jQueryHost = "jquery/" ' Use local files
End Function

' jQuery version
Function ew_jQueryFile(f)
	Dim v
	v = "1.11.2" ' jQuery version
	ew_jQueryFile = Replace(ew_jQueryHost & f, "%v", v)
End Function

' Get css file
Function ew_CssFile(f)
	If EW_CSS_FLIP Then
		ew_CssFile = ew_RegExReplace("(.css)$", f, "-rtl.css")
	Else
		ew_CssFile = f
	End If
End Function

' IIf function
Function ew_IIf(cond, v1, v2)
	On Error Resume Next
	If cond & "" = "" Then
		ew_IIf = v2
	ElseIf CBool(cond) Then
		ew_IIf = v1
	Else
		ew_IIf = v2
	End If
End Function

' Check if HTTPS
Function ew_IsHttps()
	ew_IsHttps = (Request.ServerVariables("HTTPS") <> "" And Request.ServerVariables("HTTPS") <> "off")
End Function

' Get current url
Function ew_CurrentUrl()
	Dim s, q
	s = ew_ScriptName()
	q = Request.ServerVariables("QUERY_STRING")
	If q <> "" Then s = s & "?" & q
	ew_CurrentUrl = s
End Function

' Convert to full url
Function ew_ConvertFullUrl(url)
	Dim sUrl
	If url = "" Then
		ew_ConvertFullUrl = ""
	ElseIf Instr(url, "://") > 0 Then
		ew_ConvertFullUrl = url
	Else
		sUrl = ew_FullUrl
		ew_ConvertFullUrl = Mid(sUrl, 1, InStrRev(sUrl, "/")) & url
	End If
End Function

' Get relative url
Function ew_GetUrl(url)
	Dim path
	If url & "" = "" Or InStr(url, "://") > 0 Or InStr(url, "\\") > 0 Or InStr(url, "javascript:") > 0 Then
		ew_GetUrl = url
	Else
		path = ""
		If InStrRev(url, "/") > 0 Then
			path = Mid(url, 1, InStrRev(url, "/"))
			url = Mid(url, InStrRev(url, "/")+1) 
		End If
		path = ew_PathCombine(EW_RELATIVE_PATH, path, False)
		If path <> "" Then path = ew_IncludeTrailingDelimiter(path, False)
		ew_GetUrl = path & url
	End If
End Function

Function ew_RegExMatch(expr, src, m)
	Dim RE
	Set RE = New RegExp
	RE.IgnoreCase = True
	RE.Global = True
	RE.Pattern = expr
	Set m = RE.Execute(src)
	ew_RegExMatch = (m.Count > 0)
	Set RE = Nothing
End Function

Function ew_RegExTest2(expr, src)
	Dim RE
	Set RE = New RegExp
	RE.IgnoreCase = True
	RE.Global = True
	RE.Pattern = expr
	ew_RegExTest2 = RE.Test(src)
	Set RE = Nothing
End Function

' Create XML Dom object
Function ew_CreateXmlDom()
	On Error Resume Next
	Dim ProgId
	ProgId = Array("MSXML2.DOMDocument", "Microsoft.XMLDOM") ' Add other ProgID here
	Dim i
	For i = 0 To UBound(ProgId)
		Set ew_CreateXmlDom = Server.CreateObject(ProgId(i))
		If Err.Number = 0 Then Exit For
	Next
End Function

' Check if responsive layout
Function ew_IsResponsiveLayout()
	ew_IsResponsiveLayout = EW_USE_RESPONSIVE_LAYOUT
End Function

' Check if mobile device
Function ew_IsMobile()
	Dim u,b,v
	If IsEmpty(gIsMobile) Then
		Set u = Request.ServerVariables("HTTP_USER_AGENT")
		Set b = new RegExp
		Set v = new RegExp
		b.Pattern = "(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino"
		b.IgnoreCase = True
		b.Global = True
		v.Pattern = "1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-"
		v.IgnoreCase = True
		v.Global = True
		If b.test(u) Or v.test(Left(u,4)) Then
			gIsMobile = True
		Else
			gIsMobile = False
		End If
	End If
	ew_IsMobile = gIsMobile
End Function

' Get path relative to a base path
Function ew_PathCombine(ByVal BasePath, ByVal RelPath, ByVal PhyPath)
	Dim Path, Path2, p1, p2, Delimiter
	If ew_RegExTest2("^(http|ftp)s?\:\/\/", RelPath) Then ' Allow remote file
		ew_PathCombine = RelPath
		Exit Function
	End If
	Delimiter = ew_IIf(PhyPath, "\", "/")
	If BasePath <> Delimiter Then ' If BasePath = root, do not remove delimiter
		BasePath = ew_RemoveTrailingDelimiter(BasePath, PhyPath)
	End If
	If PhyPath Then
		RelPath = Replace(RelPath, "/", "\")
	Else
		RelPath = Replace(RelPath, "\", "/")
	End If
	RelPath = ew_IncludeTrailingDelimiter(RelPath, PhyPath)
	p1 = InStr(RelPath, Delimiter)
	Path2 = ""
	While p1 > 0
		Path = Left(RelPath, p1)
		If Path = Delimiter Or Path = "." & Delimiter Then

			' Skip
		ElseIf Path = ".." & Delimiter Then
			p2 = InStrRev(BasePath, Delimiter)
			If p2 = 1 Then ' BasePath = "/xxx", cannot move up
				BasePath = Delimiter
			ElseIf p2 > 0 And Right(BasePath, 2) <> ".." Then
				BasePath = Left(BasePath, p2-1)
			ElseIf BasePath <> "" And BasePath <> "." And BasePath <> ".." Then
				BasePath = ""
			Else
				Path2 = Path2 & ".." & Delimiter
			End If
		Else
			Path2 = Path2 & Path
		End If
		RelPath = Mid(RelPath, p1+1)
		p1 = InStr(RelPath, Delimiter)
	Wend
	If BasePath <> "" And BasePath <> "." Then
		ew_PathCombine = ew_IncludeTrailingDelimiter(BasePath, PhyPath) & Path2 & RelPath
	Else
		ew_PathCombine = Path2 & RelPath
	End If
End Function

' Remove the last delimiter for a path
Function ew_RemoveTrailingDelimiter(ByVal Path, ByVal PhyPath)
	Dim Delimiter
	If PhyPath Then Delimiter = "\" Else Delimiter = "/"
	While Right(Path, 1) = Delimiter
		Path = Left(Path, Len(Path)-1)
	Wend
	ew_RemoveTrailingDelimiter = Path
End Function

' Include the last delimiter for a path
Function ew_IncludeTrailingDelimiter(ByVal Path, ByVal PhyPath)
	Dim Delimiter
	Path = ew_RemoveTrailingDelimiter(Path, PhyPath)
	If PhyPath Then Delimiter = "\" Else Delimiter = "/"
	ew_IncludeTrailingDelimiter = Path & Delimiter
End Function

' Build HTML element
Function ew_HtmlElement(tagname, attrs, innerhtml, endtag)
	Dim html, i, name, attr
	html = "<" & tagname
	If IsArray(attrs) Then
		For i = 0 to UBound(attrs)
			If IsArray(attrs(i)) Then
				If UBound(attrs(i)) >= 1 Then
					name = attrs(i)(0)
					attr = attrs(i)(1)
					If attr <> "" Then
						html = html & " " & name & "=""" & ew_HtmlEncode(attr) & """"
					End If
				End If
			End If
		Next
	End If
	html = html & ">"
	If innerhtml <> "" Then
		html = html & innerhtml
	End If
	If endtag Then
		html = html & "</" & tagname & ">"
	End If
	ew_HtmlElement = html
End Function

' Encode html
Function ew_HtmlEncode(Expression)

	' *** NOTE: Server.HtmlEncode will convert accented characters to &#nnn;
	'ew_HtmlEncode = Server.HtmlEncode(Expression & "")

	Dim wrkstr
	wrkstr = Replace(Expression & "", "&", "&amp;") ' Replace &
	wrkstr = Replace(wrkstr, "<", "&lt;") ' Replace <
	wrkstr = Replace(wrkstr, ">", "&gt;") ' Replace >
	wrkstr = Replace(wrkstr, """", "&quot;") ' Replace "
	ew_HtmlEncode = wrkstr
End Function

' Prepend CSS class name
Sub ew_PrependClass(attr, classname)
	classname = Trim(classname&"")
	If classname <> "" Then
		attr = Trim(attr&"")
		If attr <> "" Then attr = " " & attr
		attr = classname & attr
	End If
End Sub

' Append CSS class name
Sub ew_AppendClass(attr, classname)
	classname = Trim(classname&"")
	If classname <> "" Then
		attr = Trim(attr&"")
		If attr <> "" Then attr = attr & " "
		attr = attr & classname
	End If
End Sub

' Highlight value based on basic search / advanced search keywords
Function ew_Highlight(name, src, bkw, bkwtype, akw, akw2)
	Dim i, x, y, outstr, kwlist, kw, kwstr
	Dim wrksrc, xx, yy
	outstr = ""
	If Len(src) > 0 And (Len(bkw) > 0 Or Len(akw) > 0 Or Len(akw2) > 0) Then
		xx = 1
		yy = InStr(xx, src, "<", 1)
		If yy <= 0 Then yy = Len(src)+1
		Do While yy > 0
			If (yy > xx) Then
				wrksrc = Mid(src, xx, yy-xx)
			kwstr = Trim(bkw)
			If Len(akw) > 0 Then
				If Len(kwstr) > 0 Then kwstr = kwstr & " "
				kwstr = kwstr & Trim(akw)
			End If
			If Len(akw2) > 0 Then
				If Len(kwstr) > 0 Then kwstr = kwstr & " "
				kwstr = kwstr & Trim(akw2)
			End If
			kwlist = Split(kwstr, " ")
			x = 1
			Call ew_GetKeyword(wrksrc, kwlist, x, y, kw)
			Do While y > 0
				outstr = outstr & Mid(wrksrc, x, y-x) & _
					"<span class=""" & name & " ewHighlightSearch"">" & _
					Mid(wrksrc, y, Len(kw)) & "</span>"
				x = y + Len(kw)
				Call ew_GetKeyword(wrksrc, kwlist, x, y, kw)
			Loop
			outstr = outstr & Mid(wrksrc, x)
				xx = xx + Len(wrksrc)
			End If
			If xx < len(src) Then
				yy = InStr(xx, src, ">", 1)
				If yy > 0 Then
					outstr = outstr & Mid(src, xx, yy-xx+1)
					xx = yy + 1
					yy = InStr(xx, src, "<", 1)
					If yy <= 0 Then yy = Len(src)+1
				Else
					outstr = outstr & Mid(src, xx)
					yy = -1
				End If
			Else
				yy = -1
			End If
		Loop
	Else
		outstr = src
	End If
	ew_Highlight = outstr
End Function

' Get keyword
Sub ew_GetKeyword(src, kwlist, x, y, kw)
	Dim i, thisy, thiskw, wrky, wrkkw
	thisy = -1
	thiskw = ""
	For i = 0 to UBound(kwlist)
		wrkkw = Trim(kwlist(i))
		If wrkkw <> "" Then
			wrky = InStr(x, src, wrkkw, EW_HIGHLIGHT_COMPARE)
			If wrky > 0 Then
				If thisy = -1 Then
					thisy = wrky
					thiskw = wrkkw
				ElseIf wrky < thisy Then
					thisy = wrky
					thiskw = wrkkw
				End If
			End If
		End If
	Next
	y = thisy
	kw = thiskw
End Sub

' Set attribute
Sub ew_SetAttr(Attrs, Key, Value)
	If Not (Attrs Is Nothing) And Key <> "" And Value <> "" Then
		Attrs.AddAttribute Key, Value, True
	End If
End Sub

' Set up key
Sub ew_AddKey(Ar, Key, Value)
	If Key & "" <> "" And Value & "" <> "" Then
		If Not IsArray(Ar) Then
			ReDim Ar(0)
		Else
			ReDim Preserve Ar(UBound(Ar)+1)
		End If
		Ar(UBound(Ar)) = Array(Key, Value)
	End If
End Sub

' Get array position
Function ew_GetArPos(Ar, Name)
	Dim i
	If IsArray(Ar) Then
		For i = 0 to UBound(Ar,2)
			If Ar(0,i) = Name Then
				ew_GetArPos = i
				Exit Function
			End If
		Next
		i = UBound(Ar,2)+1
		ReDim Preserve Ar(1,i)
	Else
		i = 0
		ReDim Ar(1,i)
	End If
	ew_GetArPos = i
End Function

' Set array value
Sub ew_SetArVal(Ar, Name, Val)
	Dim idx, wrkname
	idx = ew_GetArPos(Ar, Name)
	wrkname = Name
	If wrkname = "" Then wrkname = idx
	Ar(0,idx) = wrkname
	Ar(1,idx) = Val
End Sub

' Set array object
Sub ew_SetArObj(Ar, Name, Obj)
	Dim idx, wrkname
	idx = ew_GetArPos(Ar, Name)
	wrkname = Name
	If wrkname = "" Then wrkname = idx
	Ar(0,idx) = wrkname
	Set Ar(1,idx) = Obj
End Sub

' Encrypt password
Function ew_EncryptPassword(input)
	ew_EncryptPassword = MD5(input)
End Function

' Compare password
Function ew_ComparePassword(pwd, input)
	If EW_CASE_SENSITIVE_PASSWORD Then
		If EW_ENCRYPTED_PASSWORD Then
			ew_ComparePassword = (pwd = ew_EncryptPassword(input))
		Else
			ew_ComparePassword = (pwd = input)
		End If
	Else
		If EW_ENCRYPTED_PASSWORD Then
			ew_ComparePassword = (pwd = ew_EncryptPassword(LCase(input)))
		Else
			ew_ComparePassword = (LCase(pwd) = LCase(input))
		End If
	End If
End Function

' Check empty string
Function ew_EmptyStr(value)
	Dim str
	str = CStr(value & "")
	str = Replace(str, "&nbsp;", "")
	ew_EmptyStr = (Trim(str) = "")
End Function

' Check empty file
Function ew_Empty(value)
	ew_Empty = IsEmpty(value) Or IsNull(value)
End Function
%>
<%

' Functions for backward compatibilty
' Get current user name
Function CurrentUserName()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		CurrentUserName = Security.CurrentUserName
	Else
		CurrentUserName = Session(EW_SESSION_USER_NAME) & ""
	End If
End Function

' Get current user ID
Function CurrentUserID()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		CurrentUserID = Security.CurrentUserID
	Else
		CurrentUserID = Session(EW_SESSION_USER_ID) & ""
	End If
End Function

' Get current parent user ID
Function CurrentParentUserID()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		CurrentParentUserID = Security.CurrentParentUserID
	Else
		CurrentParentUserID = Session(EW_SESSION_PARENT_USER_ID) & ""
	End If
End Function

' Get current user level
Function CurrentUserLevel()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		CurrentUserLevel = Security.CurrentUserLevelID
	Else
		CurrentUserLevel = Session(EW_SESSION_USER_LEVEL_ID)
	End If
End Function

' Get current user level list
Function CurrentUserLevelList()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		CurrentUserLevelList = Security.UserLevelList
	Else
		CurrentUserLevelList = Session(EW_SESSION_USER_LEVEL_ID) & ""
	End If
End Function

' Get Current user info
Function CurrentUserInfo(fldname)
	If IsObject(Security) Then
		CurrentUserInfo = Security.CurrentUserInfo(fldname)
		Exit Function
	ElseIf Not IsEmpty(EW_USER_TABLE) And Not IsSysAdmin() Then
		Dim user
		user = CurrentUserName()
		If user <> "" Then
			CurrentUserInfo = ew_ExecuteScalar("SELECT " & ew_QuotedName(fldname) & " FROM " & EW_USER_TABLE & " WHERE " & Replace(EW_USER_NAME_FILTER, "%u", ew_AdjustSql(user)))
			Exit Function
		End If
	End If
	CurrentUserInfo = Null
End Function

' Get current project ID
Function CurrentProjectID()
	If Not IsEmpty(Page) Then
		CurrentProjectID = Page.ProjectID
	Else
		CurrentProjectID = "{E9837C6B-C139-4DEF-A37B-491BE9913D3B}"
	End If
End Function

' Get current page ID
Function CurrentPageID()
	If Not IsEmpty(Page) Then
		CurrentPageID = Page.PageID
		Exit Function
	ElseIf Not IsEmpty(EW_PAGE_ID) Then
		CurrentPageID = EW_PAGE_ID
		Exit Function
	End If
	CurrentPageID = ""
End Function

' Allow list
Function AllowList(TableName)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		AllowList = Security.AllowList(TableName)
	Else
		AllowList = True
	End If
End Function

' Allow add
Function AllowAdd(TableName)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		AllowAdd = Security.AllowAdd(TableName)
	Else
		AllowAdd = True
	End If
End Function

' Is Password Expired
Function IsPasswordExpired()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		IsPasswordExpired = Security.IsPasswordExpired
	Else
		IsPasswordExpired = (Session(EW_SESSION_STATUS) = "passwordexpired")
	End If
End Function

' Is Logging In
Function IsLoggingIn()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		IsLoggingIn = Security.IsLoggingIn
	Else
		IsLoggingIn = (Session(EW_SESSION_STATUS) = "loggingin")
	End If
End Function

' Is Logged In
Function IsLoggedIn()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		IsLoggedIn = Security.IsLoggedIn
	Else
		IsLoggedIn = (Session(EW_SESSION_STATUS) = "login")
	End If
End Function

' Is Admin
Function IsAdmin()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		IsAdmin = Security.IsAdmin
	Else
		IsAdmin = (Session(EW_SESSION_SYS_ADMIN) = 1)
	End If
End Function

' Is System Admin
Function IsSysAdmin()
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	If IsObject(Security) Then
		IsSysAdmin = Security.IsSysAdmin
	Else
		IsSysAdmin = (Session(EW_SESSION_SYS_ADMIN) = 1)
	End If
End Function

' Get current page object
Function CurrentPage()
	If IsObject(Page) Then
		Set CurrentPage = Page
	Else
		Set CurrentPage = Nothing
	End If
End Function

' Get current table object
Function CurrentTable()
	If IsObject(Table) Then
		Set CurrentTable = Table
	Else
		Set CurrentTable = Nothing
	End If
End Function

' Get current master table object
Function CurrentMasterTable()
	Dim tbl
	Set tbl = CurrentTable()
	If IsObject(tbl) Then
		Set CurrentMasterTable = tbl.MasterTable
	Else
		Set CurrentMasterTable = Nothing
	End If
End Function

' Get current detail table object
Function CurrentDetailTable()
	If IsObject(Grid) Then
		Set CurrentDetailTable = Grid
	Else
		Set CurrentDetailTable = Nothing
	End If
End Function
%>
<%

' Get server variable by name
Function ew_GetServerVariable(Name)
	ew_GetServerVariable = Request.ServerVariables(Name)
End Function

' Get user IP
Function ew_CurrentUserIP()
	ew_CurrentUserIP = ew_GetServerVariable("REMOTE_HOST")
End Function

' Get current host name, e.g. "www.mycompany.com"
Function ew_CurrentHost()
	ew_CurrentHost = ew_GetServerVariable("HTTP_HOST")
End Function

' Get current date in default date format
Function ew_CurrentDate()
	ew_CurrentDate = Date
	Select Case EW_DEFAULT_DATE_FORMAT
		Case 5, 9, 12, 15
			ew_CurrentDate = ew_FormatDateTime(ew_CurrentDate, 5)
		Case 6, 10, 13, 16
			ew_CurrentDate = ew_FormatDateTime(ew_CurrentDate, 6)
		Case 7, 11, 14, 17
			ew_CurrentDate = ew_FormatDateTime(ew_CurrentDate, 7)
	End Select
	If EW_DATE_SEPARATOR <> "/" Then ew_CurrentDate = Replace(ew_CurrentDate, EW_DATE_SEPARATOR, "/")
End Function

' Get current time in hh:mm:ss format
Function ew_CurrentTime()
	Dim DT
	DT = Now()
	ew_CurrentTime = ew_ZeroPad(Hour(DT), 2) & ":" & _
		ew_ZeroPad(Minute(DT), 2) & ":" & ew_ZeroPad(Second(DT), 2)
End Function

' Get current date in default date format with
' Current time in hh:mm:ss format
Function ew_CurrentDateTime()
	ew_CurrentDateTime = ew_CurrentDate() & " " & ew_CurrentTime()
End Function

' Get current date in standard format (yyyy/mm/dd)
Function ew_StdCurrentDate()
	ew_StdCurrentDate = ew_StdDate(Date)
End Function

' Get date in standard format (yyyy/mm/dd)
Function ew_StdDate(dt)
	ew_StdDate = ew_ZeroPad(Year(dt), 4) & "/" & ew_ZeroPad(Month(dt), 2) & "/" & ew_ZeroPad(Day(dt), 2)
End Function

' Get current date and time in standard format (yyyy/mm/dd hh:mm:ss)
Function ew_StdCurrentDateTime()
	ew_StdCurrentDateTime = ew_StdDateTime(Now)
End Function

' Get date/time in standard format (yyyy/mm/dd hh:mm:ss)
Function ew_StdDateTime(dt)
	ew_StdDateTime = ew_ZeroPad(Year(dt), 4) & "/" & ew_ZeroPad(Month(dt), 2) & "/" & ew_ZeroPad(Day(dt), 2) & " " & _
		ew_ZeroPad(Hour(dt), 2) & ":" & ew_ZeroPad(Minute(dt), 2) & ":" & ew_ZeroPad(Second(dt), 2)
End Function

' Check if an element is in array
Function ew_InArray(el, ar)
	If IsArray(ar) Then
		Dim i
		For i = 0 to UBound(ar)
			If Trim(el & "") = Trim(ar(i) & "") Then
				ew_InArray = True
				Exit Function
			End If
		Next
		ew_InArray = False
	Else
		ew_InArray = False
	End If
End Function

' Add item to array
Function ew_ArrayAddItem(ar, item)
	If IsArray(ar) Then
		ReDim Preserve ar(UBound(ar)+1)
	Else
		ReDim ar(0)
	End If
	ar(UBound(ar)) = item
End Function

' Merge array
Function ew_ArrayMerge(ar1, ar2)
	Dim ar, i, j, k
	ar = ar1
	If IsArray(ar) Then
		If IsArray(ar2) Then
			i = UBound(ar)
			j = UBound(ar2)
			ReDim Preserve ar(i+j+1)
			For k = 0 to j
				ar(i+1+k) = ar2(k)
			Next
		End If
	ElseIf IsArray(ar2) Then
		ar = ar2
	End If
	ew_ArrayMerge = ar
End Function

' Remove XSS
Function ew_RemoveXSS(val)
	Dim search, ra, i, j, Found, val_before, pattern, replacement

	' Handle null value
	If IsNull(val) Then
		ew_RemoveXSS = val
		Exit Function
	End If

	' Remove all non-printable characters. CR(0a) and LF(0b) and TAB(9) are allowed 
	' This prevents some character re-spacing such as <java\0script> 
	' Note that you have to handle splits with \n, \r, and \t later since they *are* allowed in some inputs

	pattern = "([\x00-\x08][\x0b-\x0c][\x0e-\x20])"
	val = ew_RegExReplace(pattern, val & "", "")

	' Straight replacements, the user should never need these since they're normal characters 
	' This prevents like <IMG SRC=&#X40&#X61&#X76&#X61&#X73&#X63&#X72&#X69&#X70&#X74&#X3A&#X61&#X6C&#X65&#X72&#X74&#X28&#X27&#X58&#X53&#X53&#X27&#X29> 

	search = "abcdefghijklmnopqrstuvwxyz"
	search = search & "ABCDEFGHIJKLMNOPQRSTUVWXYZ" 
	search = search & "1234567890!@#$%^&*()" 
	search = search & "~`"";:?+/={}[]-_|'\"
	For i = 1 To Len(search)

		' ;? matches the ;, which is optional 
		' 0{0,7} matches any padded zeros, which are optional and go up to 8 chars 
		' &#x0040 @ search for the hex values

		pattern = "(&#[x|X]0{0,8}" & Hex(Asc(Mid(search, i, 1))) & ";?)" ' With a ;
		val = ew_RegExReplace(pattern, val, Mid(search, i, 1))

		' &#00064 @ 0{0,7} matches '0' zero to seven times
		pattern = "(&#0{0,8}" & Asc(Mid(search, i, 1)) & ";?)" ' With a ;
		val = ew_RegExReplace(pattern, val, Mid(search, i, 1))
	Next

	' Now the only remaining whitespace attacks are \t, \n, and \r 
	ra = EW_XSS_ARRAY
	Found = True ' Keep replacing as long as the previous round replaced something 
	Do While Found
		val_before = val
		For i = 0 To UBound(ra)
			pattern = ""
			For j = 1 To Len(ra(i))
				If j > 1 Then
					pattern = pattern & "("
					pattern = pattern & "(&#[x|X]0{0,8}([9][a][b]);?)?"
					pattern = pattern & "|(&#0{0,8}([9][10][13]);?)?"
					pattern = pattern & ")?"
				End If
				pattern = pattern & Mid(ra(i), j, 1)
			Next
			replacement = Mid(ra(i), 1, 2) & "<x>" & Mid(ra(i), 3) ' Add in <> to nerf the tag
			val = ew_RegExReplace(pattern, val, replacement) ' Filter out the hex tags
			If val_before = val Then

				' No replacements were made, so exit the loop
				Found = False
			End If
		Next
	Loop
	ew_RemoveXSS = val
End Function

' Check token
Function ew_CheckToken(t)
	On Error Resume Next
	ew_CheckToken = (DateDiff("n", ew_Decrypt(ew_Decode(t)), ew_StdCurrentDateTime()) < Session.Timeout)
End Function

' Create token
Function ew_CreateToken()
	On Error Resume Next
	ew_CreateToken = ew_Encode(ew_Encrypt(ew_StdCurrentDateTime()))
End Function

' Copy file
Function ew_CopyFile(src, dest)
	On Error Resume Next
	Dim fso
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	If fso.FileExists(src) Then
		fso.CopyFile src, dest, True
		ew_CopyFile = (Err.Number = 0)
	Else
		ew_CopyFile = False
	End If
	Set fso = Nothing
End Function

' Get content file extension
Function ew_ContentExt(data)
	Dim ct
	ct = ew_ContentType(LeftB(data, 11), "")
	Select Case ct
		Case "image/gif": ew_ContentExt = ".gif" ' gif
		Case "image/jpeg": ew_ContentExt = ".jpg" ' jpg
		Case "image/png": ew_ContentExt = ".png" ' png
		Case "image/bmp": ew_ContentExt = ".bmp" ' bmp
		Case "application/pdf": ew_ContentExt = ".pdf" ' pdf
		Case Else: ew_ContentExt = "" ' Unknown extension
	End Select
End Function

' Get image content type
Function ew_ContentType(data, fn)
	Dim sGifHeader1, sGifHeader2, sJpgHeader1, sJpgHeader2, sPngHeader, sBmpHeader, sPdfHeader
	sGifHeader1 = ChrB(71) & ChrB(73) & ChrB(70) & ChrB(56) & ChrB(55) & ChrB(97) ' \x47\x49\x46\x38\x37\x61
	sGifHeader2 = ChrB(71) & ChrB(73) & ChrB(70) & ChrB(56) & ChrB(57) & ChrB(97) ' \x47\x49\x46\x38\x39\x61

	'sJpgHeader1 = ChrB(255) & ChrB(216) & ChrB(255) & ChrB(224) ' \xFF\xD8\xFF\xE0
	'sJpgHeader2 = ChrB(74) & ChrB(70) & ChrB(73) & ChrB(70) & ChrB(0) ' \x4A\x46\x49\x46\x00

	sJpgHeader1 = ChrB(255) & ChrB(216) ' \xFF\xD8
	sPngHeader = ChrB(137) & ChrB(80) & ChrB(78) & ChrB(71) & ChrB(13) & ChrB(10) & ChrB(26) & ChrB(10) ' \x89\x50\x4E\x47\x0D\x0A\x1A\x0A
	sBmpHeader = ChrB(66) & ChrB(77) ' \x42\x4D
	sPdfHeader = ChrB(37) & ChrB(80) & ChrB(68) & ChrB(70) ' \x25\x50\x44\x46
	If MidB(data,1,6) = sGifHeader1 Or MidB(data,1,6) = sGifHeader2 Then ' Check if gif
		ew_ContentType = "image/gif"

	'ElseIf MidB(data,1,4) = sJpgHeader1 Or MidB(data,7,5) = sJpgHeader2 Then ' Check if jpg
	ElseIf MidB(data,1,2) = sJpgHeader1 Then ' Check if jpg
		ew_ContentType = "image/jpeg"
	ElseIf MidB(data,1,8) = sPngHeader Then ' Check if png
		ew_ContentType = "image/png"
	ElseIf MidB(data,1,2) = sBmpHeader Then ' Check if bmp
		ew_ContentType = "image/bmp"
	ElseIf MidB(data,1,4) = sPdfHeader Then ' Check if pdf
		ew_ContentType = "application/pdf"
	ElseIf fn <> "" Then

		' Use file extension to get mime type
		Dim extension, i
		extension = LCase(Mid(fn, InstrRev(fn, ".") + 1))
		For i = 0 to UBound(EW_MIME_TYPES)
			If extension = EW_MIME_TYPES(i)(0) Then
				ew_ContentType = EW_MIME_TYPES(i)(1)
				Exit Function
			End If
		Next
		ew_ContentType = "images"
	Else
		ew_ContentType = "images"
	End If
End Function

' Get image dimension
Sub ew_GetImageDimension(img, wd, ht)
	Dim sPNGHeader, sGIFHeader, sBMPHeader, sJPGHeader, sHeader, sImgType
	sImgType = "(unknown)"

	' Image headers, do not changed
	sPNGHeader = ChrB(137) & ChrB(80) & ChrB(78)
	sGIFHeader = ChrB(71) & ChrB(73) & ChrB(70)
	sBMPHeader = ChrB(66) & ChrB(77)
	sJPGHeader = ChrB(255) & ChrB(216) & ChrB(255)
	sHeader = MidB(img, 1, 3)

	' Handle GIF
	If sHeader = sGIFHeader Then
		sImgType = "GIF"
		wd = ew_ConvertLength(MidB(img, 7, 2))
		ht = ew_ConvertLength(MidB(img, 9, 2))

	' Handle BMP
	ElseIf LeftB(sHeader, 2) = sBMPHeader Then
		sImgType = "BMP"
		wd = ew_ConvertLength(MidB(img, 19, 2))
		ht = ew_ConvertLength(MidB(img, 23, 2))

	' Handle PNG
	ElseIf sHeader = sPNGHeader Then
		sImgType = "PNG"
		wd = ew_ConvertLength2(MidB(img, 19, 2))
		ht = ew_ConvertLength2(MidB(img, 23, 2))

	' Handle JPG
	Else
		Dim size, markersize, pos, bEndLoop
		size = LenB(img)
		pos = InStrB(img, sJPGHeader)
		If pos <= 0 Then
			wd = -1
			ht = -1
			Exit Sub
		End If
		sImgType = "JPG"
		pos = pos + 2
		bEndLoop = False
		Do While Not bEndLoop and pos < size
			Do While AscB(MidB(img, pos, 1)) = 255 and pos < size
				pos = pos + 1
			Loop
			If AscB(MidB(img, pos, 1)) < 192 or AscB(MidB(img, pos, 1)) > 195 Then
				markersize = ew_ConvertLength2(MidB(img, pos+1, 2))
				pos = pos + markersize + 1
			Else
				bEndLoop = True
			End If
		Loop
		If Not bEndLoop Then
			wd = -1
			ht = -1
		Else
			wd = ew_ConvertLength2(MidB(img, pos+6, 2))
			ht = ew_ConvertLength2(MidB(img, pos+4, 2))
		End If
	End If
End Sub

' Convert length
Function ew_ConvertLength(b)
	ew_ConvertLength = CLng(AscB(LeftB(b, 1)) + (AscB(RightB(b, 1)) * 256))
End Function

' Convert length 2
Function ew_ConvertLength2(b)
	ew_ConvertLength2 = CLng(AscB(RightB(b, 1)) + (AscB(LeftB(b, 1)) * 256))
End Function
%>
<%

' ---------------------------
'  Get upload object (begin)
'
Function ew_GetUploadObj()
		Set ew_GetUploadObj = New cUploadObj
End Function

'
'  Get upload object (end)
' -------------------------

%>
<%

' Save binary to file
Function ew_SaveFile(folder, fn, filedata)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	Dim oStream
	ew_SaveFile = False
	If IsNull(filedata) Then Exit Function
	If Not ew_SaveFileByComponent(folder, fn, filedata) Then
		If ew_CreateFolder(folder) Then
			Set oStream = Server.CreateObject("ADODB.Stream")
			oStream.Type = 1 ' 1=adTypeBinary
			oStream.Open
			oStream.Write ew_ConvertToBinary(filedata)
			oStream.SaveToFile ew_IncludeTrailingDelimiter(folder, True) & fn, 2 ' 2=adSaveCreateOverwrite
			oStream.Close
			Set oStream = Nothing
			If Err.Number = 0 Then ew_SaveFile = True
		End If
	End If
End Function

' Convert raw to binary
Function ew_ConvertToBinary(rawdata)
	Dim oRs
	Set oRs = Server.CreateObject("ADODB.Recordset")

	' Create field in an empty RecordSet
	Call oRs.Fields.Append("Blob", 205, LenB(rawdata)) ' Add field with type adLongVarBinary
	Call oRs.Open()
	Call oRs.AddNew()

	'Call oRs.Fields("Blob").AppendChunk(rawdata & ChrB(0))
	Call oRs.Fields("Blob").AppendChunk(rawdata)
	Call oRs.Update()

	' Save Blob Data
	ew_ConvertToBinary = oRs.Fields("Blob").GetChunk(LenB(rawdata))

	' Close RecordSet
	Call oRs.Close()
	Set oRs = Nothing
End Function
%>
<%

' Can resize
Function ew_CanResize()
	ew_CanResize = False ' No resize
End Function

' Resize binary to thumbnail
Function ew_ResizeBinary(filedata, width, height, interpolation)
	ew_ResizeBinary = False ' No resize
End Function

' Resize file to thumbnail file
Function ew_ResizeFile(fn, tn, width, height, interpolation)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	Dim fso

	' Just copy across
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	If fso.FileExists(fn) Then
		fso.CopyFile fn, tn, True
	End If
	Set fso = Nothing
	ew_ResizeFile = True
End Function

' Resize file to binary
Function ew_ResizeFileToBinary(fn, width, height, interpolation)
	If Not EW_DEBUG_ENABLED Then On Error Resume Next
	Dim oStream, fso
	ew_ResizeFileToBinary = Null

	' Return file content in binary
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	If fso.FileExists(fn) Then
		Set oStream = Server.CreateObject("ADODB.Stream")
		oStream.Type = 1 ' 1=adTypeBinary
		oStream.Open
		oStream.LoadFromFile fn
		ew_ResizeFileToBinary = oStream.Read
		oStream.Close
		Set oStream = Nothing
	End If
	Set fso = Nothing
End Function

' Save file by component
Function ew_SaveFileByComponent(folder, fn, filedata)
	ew_SaveFileByComponent = False
End Function
%>
<script language="JScript" runat="server">
function ew_RegExTest(expr, src) {
	var re = new RegExp(expr, "ig");
	return re.test(src);
}
function ew_RegExReplace(expr, src, dest) {
	var re = new RegExp(expr, "ig");
	return (src == null) ? src : src.replace(re, dest);
}
function ew_Encode(str) {	
	return encodeURIComponent(str);
}
function ew_Decode(str) {	
	return decodeURIComponent(str);	
}
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/*  Block TEA (xxtea) Tiny Encryption Algorithm         (c) Chris Veness 2002-2014 / MIT Licence  */
/*   - www.movable-type.co.uk/scripts/tea-block.html                                              */
/*                                                                                                */
/*  Algorithm: David Wheeler & Roger Needham, Cambridge University Computer Lab                   */
/*             http://www.cl.cam.ac.uk/ftp/papers/djw-rmn/djw-rmn-tea.html (1994)                 */
/*             http://www.cl.cam.ac.uk/ftp/users/djw3/xtea.ps (1997)                              */
/*             http://www.cl.cam.ac.uk/ftp/users/djw3/xxtea.ps (1998)                             */
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/**
 * Tiny Encryption Algorithm
 *
 * @namespace
 */
var Tea = {};
/**
 * Encrypts text using Corrected Block TEA (xxtea) algorithm.
 *
 * @param   {string} plaintext - String to be encrypted (multi-byte safe).
 * @param   {string} password - Password to be used for encryption (1st 16 chars).
 * @returns {string} Encrypted text (encoded as base64).
 */
Tea.encrypt = function(plaintext, password) {
	plaintext = String(plaintext);
	password = String(password);
	if (plaintext.length == 0) return('');  // nothing to encrypt
	//  v is n-word data vector; converted to array of longs from UTF-8 string
	var v = Tea.strToLongs(plaintext.utf8Encode());
	//  k is 4-word key; simply convert first 16 chars of password as key
	var k = Tea.strToLongs(password.utf8Encode().slice(0,16));
	var n = v.length;
	v = Tea.encode(v, k);
	// convert array of longs to string
	var ciphertext = Tea.longsToStr(v);
	// convert binary string to base64 ascii for safe transport
	return ciphertext.base64Encode();
};
/**
 * Decrypts text using Corrected Block TEA (xxtea) algorithm.
 *
 * @param   {string} ciphertext - String to be decrypted.
 * @param   {string} password - Password to be used for decryption (1st 16 chars).
 * @returns {string} Decrypted text.
 */
Tea.decrypt = function(ciphertext, password) {
	ciphertext = String(ciphertext);
	password = String(password);
	if (ciphertext.length == 0) return('');
	//  v is n-word data vector; converted to array of longs from base64 string
	var v = Tea.strToLongs(ciphertext.base64Decode());
	//  k is 4-word key; simply convert first 16 chars of password as key
	var k = Tea.strToLongs(password.utf8Encode().slice(0,16));
	var n = v.length;
	v = Tea.decode(v, k);
	var plaintext = Tea.longsToStr(v);
	// strip trailing null chars resulting from filling 4-char blocks:
	plaintext = plaintext.replace(/\0+$/,'');
	return plaintext.utf8Decode();
};
/**
 * XXTEA: encodes array of unsigned 32-bit integers using 128-bit key.
 *
 * @param   {number[]} v - Data vector.
 * @param   {number[]} k - Key.
 * @returns {number[]} Encoded vector.
 */
Tea.encode = function(v, k) {
	if (v.length < 2) v[1] = 0;  // algorithm doesn't work for n<2 so fudge by adding a null
	var n = v.length;
	var z = v[n-1], y = v[0], delta = 0x9E3779B9;
	var mx, e, q = Math.floor(6 + 52/n), sum = 0;
	while (q-- > 0) {  // 6 + 52/n operations gives between 6 & 32 mixes on each word
	sum += delta;
	e = sum>>>2 & 3;
	for (var p = 0; p < n; p++) {
		y = v[(p+1)%n];
		mx = (z>>>5 ^ y<<2) + (y>>>3 ^ z<<4) ^ (sum^y) + (k[p&3 ^ e] ^ z);
		z = v[p] += mx;
	}
	}
	return v;
};
/**
 * XXTEA: decodes array of unsigned 32-bit integers using 128-bit key.
 *
 * @param   {number[]} v - Data vector.
 * @param   {number[]} k - Key.
 * @returns {number[]} Decoded vector.
 */
Tea.decode = function(v, k) {
	var n = v.length;
	var z = v[n-1], y = v[0], delta = 0x9E3779B9;
	var mx, e, q = Math.floor(6 + 52/n), sum = q*delta;
	while (sum != 0) {
	e = sum>>>2 & 3;
	for (var p = n-1; p >= 0; p--) {
		z = v[p>0 ? p-1 : n-1];
		mx = (z>>>5 ^ y<<2) + (y>>>3 ^ z<<4) ^ (sum^y) + (k[p&3 ^ e] ^ z);
		y = v[p] -= mx;
	}
	sum -= delta;
	}
	return v;
};
/**
 * Converts string to array of longs (each containing 4 chars).
 * @private
 */
Tea.strToLongs = function(s) {
	// note chars must be within ISO-8859-1 (Unicode code-point <= U+00FF) to fit 4/long
	var l = new Array(Math.ceil(s.length/4));
	for (var i=0; i<l.length; i++) {
	// note little-endian encoding - endianness is irrelevant as long as it matches longsToStr()
	l[i] = s.charCodeAt(i*4)        + (s.charCodeAt(i*4+1)<<8) +
		(s.charCodeAt(i*4+2)<<16) + (s.charCodeAt(i*4+3)<<24);
	}
	return l; // note running off the end of the string generates nulls since bitwise operators
};            // treat NaN as 0
/**
 * Converts array of longs to string.
 * @private
 */
Tea.longsToStr = function(l) {
	var a = new Array(l.length);
	for (var i=0; i<l.length; i++) {
	a[i] = String.fromCharCode(l[i] & 0xFF, l[i]>>>8 & 0xFF, l[i]>>>16 & 0xFF, l[i]>>>24 & 0xFF);
	}
	return a.join('');  // use Array.join() for better performance than repeated string appends
};
/** Extend String object with method to encode multi-byte string to utf8
 *  - monsur.hossa.in/2012/07/20/utf-8-in-javascript.html */
if (typeof String.prototype.utf8Encode == 'undefined') {
	String.prototype.utf8Encode = function() {
	return unescape( encodeURIComponent( this ) );
	};
}
/** Extend String object with method to decode utf8 string to multi-byte */
if (typeof String.prototype.utf8Decode == 'undefined') {
	String.prototype.utf8Decode = function() {
	try {
		return decodeURIComponent( escape( this ) );
	} catch (e) {
		return this; // invalid UTF-8? return as-is
	}
	};
}
/** Extend String object with method to encode base64
 *  - developer.mozilla.org/en-US/docs/Web/API/window.btoa, nodejs.org/api/buffer.html
 *  note: if btoa()/atob() are not available (eg IE9-), try github.com/davidchambers/Base64.js */
if (typeof String.prototype.base64Encode == 'undefined') {
	String.prototype.base64Encode = function() {
	if (typeof btoa != 'undefined') return btoa(this); // browser
	if (typeof Buffer != 'undefined') return new Buffer(this, 'utf8').toString('base64'); // Node.js
	throw new Error('No Base64 Encode');
	};
}
/** Extend String object with method to decode base64 */
if (typeof String.prototype.base64Decode == 'undefined') {
	String.prototype.base64Decode = function() {
	if (typeof atob != 'undefined') return atob(this); // browser
	if (typeof Buffer != 'undefined') return new Buffer(this, 'base64').toString('utf8'); // Node.js
	throw new Error('No Base64 Decode');
	};
}
var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
function InvalidCharacterError(message) {
	this.message = message;
}
InvalidCharacterError.prototype = new Error;
InvalidCharacterError.prototype.name = 'InvalidCharacterError';
// encoder
// [https://gist.github.com/999166] by [https://github.com/nignag]
btoa = function (input) {
	var str = String(input);
	for (
	// initialize result and counter
	var block, charCode, idx = 0, map = chars, output = '';
	// if the next str index does not exist:
	//   change the mapping table to "="
	//   check if d has no fractional digits
	str.charAt(idx | 0) || (map = '=', idx % 1);
	// "8 - idx % 1 * 8" generates the sequence 2, 4, 6, 8
	output += map.charAt(63 & block >> 8 - idx % 1 * 8)
	) {
	charCode = str.charCodeAt(idx += 3/4);
	if (charCode > 0xFF) {
	throw new InvalidCharacterError("'btoa' failed: The string to be encoded contains characters outside of the Latin1 range.");
	}
	block = block << 8 | charCode;
	}
	return output.replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '.'); //***
};
// decoder
// [https://gist.github.com/1020396] by [https://github.com/atk]
atob = function (input) {
	var str = String(input).replace(/-/g, '+').replace(/_/g, '/').replace(/\./g, '=').replace(/=+$/, ''); //***
	if (str.length % 4 == 1) {
	throw new InvalidCharacterError("'atob' failed: The string to be decoded is not correctly encoded.");
	}
	for (
	// initialize result and counters
	var bc = 0, bs, buffer, idx = 0, output = '';
	// get next character
	buffer = str.charAt(idx++);
	// character found in table? initialize bit storage and add its ascii value;
	~buffer && (bs = bc % 4 ? bs * 64 + buffer : buffer,
	// and if not first of each 4 characters,
	// convert the first 8 bits to one ascii character
	bc++ % 4) ? output += String.fromCharCode(255 & bs >> (-2 * bc & 6)) : 0
	) {
	// try to find character in table (0-63, not found => -1)
	buffer = chars.indexOf(buffer);
	}
	return output;
};
function TEAencrypt(plaintext, password) {
	return Tea.encrypt(plaintext, password);	
}
function TEAdecrypt(ciphertext, password) {
	return Tea.decrypt(ciphertext, password);	
}
function ew_Encrypt(plaintext) {
	return Tea.encrypt(plaintext, EW_RANDOM_KEY);
}
function ew_Decrypt(ciphertext) {
	return Tea.decrypt(ciphertext, EW_RANDOM_KEY);
}
</script>
<script language="JScript" src="js/ewvalidator.js" runat="server"></script>
