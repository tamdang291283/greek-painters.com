<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="aspfn12.asp"-->
<%

' Handle download file content
If Request.QueryString("download").Count > 0 Then
	Call DownloadFileContent()

' Handle delete file
ElseIf Request.QueryString("delete").Count > 0 Then
	Call DeleteFile()

' Handle download file list
ElseIf Request.QueryString("id").Count > 0 Then
	Call DownloadFileList()

' Handle upload file (multi-part)
ElseIf Request.TotalBytes > 0 Then
	Call UploadFile()
End If

' Download file content
Sub DownloadFileContent()
	Dim name, filename, value, version, folder
	name = Request.QueryString("id")
	filename = Request.QueryString(name)
	folder = ew_UploadTempPath(name)
	version = Request.QueryString("version")
	If version <> "" Then
		folder = ew_PathCombine(folder, version, True)
	End If

	' Show file content (gif/jpeg/png only)
	'If ew_RegExTest("\.(gif|jpe?g|png)$", filename) Then

		If ew_FileExists(folder, filename) Then
			value = ew_LoadBinaryFile(ew_IncludeTrailingDelimiter(folder, True) & filename) 
			Response.AddHeader "Pragma", "no-cache"
			Response.AddHeader "Cache-Control", "no-cache, no-store, must-revalidate"
			Response.AddHeader "X-Content-Type-Options", "nosniff"
			Response.ContentType = ew_ContentType(LeftB(value,11), filename)
			Response.BinaryWrite value
			Response.End
		End If

	'End If
End Sub

' Delete file
Sub DeleteFile()
	Dim name, filename, filesize, filetype, version, folder
	If Request.QueryString("id") <> "" Then
		name = Request.QueryString("id")
		filename = Request.QueryString(name)
		folder = ew_UploadTempPath(name)
		ew_DeleteFile(ew_IncludeTrailingDelimiter(folder, True) & filename)
		version = EW_UPLOAD_THUMBNAIL_FOLDER
		folder = ew_PathCombine(folder, version, True)
		ew_DeleteFile(ew_IncludeTrailingDelimiter(folder, True) & filename)
		Response.Write "{""success"":true}"
	End If
End Sub

' Download file list
Sub DownloadFileList()
	Dim name, filename, filesize, filetype, value, folder, files
	name = Request.QueryString("id")
	If name <> "" Then
		folder = ew_UploadTempPath(name)
		Dim fso, oFolder, oFiles, oFile, sFile
		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		If fso.FolderExists(folder) Then
			Set oFolder = fso.GetFolder(folder)
			Set oFiles = oFolder.Files
			For Each oFile in oFiles
				filename = oFile.Name
				sFile = ew_IncludeTrailingDelimiter(folder, True) & filename
				If fso.FileExists(sFile) Then
					value = ew_LoadBinaryFile(sFile)
					filesize = LenB(value) 
					filetype = ew_ContentType(LeftB(value,11), filename)
					If IsArray(files) Then
						ReDim Preserve files(UBound(files)+1)
					Else
						ReDim files(0)
					End If
					files(UBound(files)) = Array(name, filename, filetype, filesize)
				End If
			Next
		End If
		Set fso = Nothing
		Call OutputJSON(name, files)
	End If
End Sub

' Upload file
Sub UploadFile()
	Dim name, filename, filesize, filetype, value, version, folder, files
	Dim exts, filetypes, maxsize, maxfilecount, filecount, fileerror
	On Error Resume Next

	' Handle upload file
	If Request.TotalBytes > 0 Then

		' Load language
		Set Language = New cLanguage
		Call Language.LoadPhrases()
		Set ObjForm = ew_GetUploadObj()
		name = ObjForm.GetValue("id")&""
		exts = ObjForm.GetValue("exts")&""
		If exts = "" Then
			filetypes = ".+$"
		Else
			filetypes = ".(" & Replace(exts, ",", "|") & ")$"
		End If
		maxsize = ObjForm.GetValue("maxsize")&""
		maxfilecount = ObjForm.GetValue("maxfilecount")&""
		folder = ew_UploadTempPath(name)
		filename = ObjForm.GetUploadFileName(name)
		filetype = ObjForm.GetUploadFileContentType(name)
		filesize = ObjForm.GetUploadFileSize(name)
		value = ObjForm.GetUploadFileData(name)

		' Check file types
		If Not ew_RegExTest(filetypes, filename) Then
			fileerror = Language.Phrase("UploadErrMsgAcceptFileTypes")
			files = Array(Array(name, filename, filetype, filesize, fileerror))
			Call OutputJSON("files", files)
			Exit Sub
		End If

		' Check file size
		If IsNumeric(maxsize) Then
			If CLng(maxsize) < CLng(filesize) Then
				fileerror = Language.Phrase("UploadErrMsgMaxFileSize")
				files = Array(Array(name, filename, filetype, filesize, fileerror))
				Call OutputJSON("files", files)
				Exit Sub
			End If
		End If

		' Check max file count
		If IsNumeric(maxfilecount) Then
			filecount = ew_FolderFileCount(folder)
			If CLng(maxfilecount) > 0 And CLng(maxfilecount) <= CLng(filecount) Then
				fileerror = Language.Phrase("UploadErrMsgMaxNumberOfFiles")
				files = Array(Array(name, filename, filetype, filesize, fileerror))
				Call OutputJSON("files", files)
				Exit Sub
			End If
		End If

		' Delete all files in directory if replace
		If ObjForm.GetValue("replace")&"" = "1" Then
			Call ew_CleanPath(folder, False)
		End If
		If LenB(value) mod 2 = 1 Then value = value & ChrB(0) ' Handle odd bytes
		Call ew_SaveFile(folder, filename, value)
		version = EW_UPLOAD_THUMBNAIL_FOLDER
		folder = ew_PathCombine(folder, version, True)
		Call ew_ResizeBinary(value, EW_UPLOAD_THUMBNAIL_WIDTH, EW_UPLOAD_THUMBNAIL_HEIGHT, EW_THUMBNAIL_DEFAULT_INTERPOLATION)
		If LenB(value) mod 2 = 1 Then value = value & ChrB(0) ' Handle odd bytes
		Call ew_SaveFile(folder, filename, value)
		files = Array(Array(name, filename, filetype, filesize))
		Call OutputJSON("files", files)
	End If
End Sub

' Output JSON
Sub OutputJSON(id, files)
	Dim ar, cnt, name, filename, filetype, filesize, fileerror, version
	Dim baseurl, url, thumbnail_url, delete_url
	baseurl = ew_ConvertFullUrl(ew_CurrentPage)
	If IsArray(files) Then
		For i = 0 to UBound(files)
			If IsArray(files(i)) Then
				If UBound(files(i)) >= 3 Then
					name = files(i)(0)
					filename = files(i)(1)
					filetype = files(i)(2)
					filesize = files(i)(3)
					If UBound(files(i)) >= 4 Then
						fileerror = files(i)(4)
					Else
						fileerror = ""
					End If
					url = baseurl & "?id=" & name & "&" & name & "=" & ew_Encode(filename) & "&download=1&rnd=" & ew_Random()
					version = EW_UPLOAD_THUMBNAIL_FOLDER
					thumbnail_url = baseurl & "?id=" & name & "&" & name & "=" & ew_Encode(filename) & "&version=" & version & "&download=1&rnd=" & ew_Random()
					delete_url = baseurl & "?id=" & name & "&" & name & "=" & ew_Encode(filename) & "&delete=1&rnd=" & ew_Random()
					If IsArray(ar) Then
						cnt = UBound(ar,2) + 1
						ReDim Preserve ar(6,cnt)
					Else
						cnt = 0
						ReDim ar(6,0)
					End If
					ar(0,cnt) = Array("name", filename)
					ar(1,cnt) = Array("size", filesize)
					ar(2,cnt) = Array("type", filetype)
					ar(3,cnt) = Array("url", url)
					If fileerror <> "" Then
						ar(4,cnt) = Array("error", fileerror)
					Else
						ar(4,cnt) = Array(version & "Url", thumbnail_url)
					End If
					ar(5,cnt) = Array("deleteUrl", delete_url)

					'ar(6,cnt) = Array("deleteType", "DELETE")
					ar(6,cnt) = Array("deleteType", "GET") ' Use GET
				End If
			End If
		Next
	End If

	' Set file header / content type
	Response.AddHeader "Pragma", "no-cache"
	Response.AddHeader "Cache-Control", "no-cache, no-store, must-revalidate"
	Response.AddHeader "Content-Disposition", "inline; filename=files.json"
	Response.AddHeader "X-Content-Type-Options", "nosniff"

	'Response.ContentType = "application/json" ' Not work in IE9
	Response.ContentType = "text/plain"

	' Output json
	Dim out
	out = ew_ArrayToJson(ar, 0)
	Response.Write "{""" & id & """:" & out & "}"
End Sub
%>
