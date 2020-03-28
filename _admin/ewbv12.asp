<%@ CodePage="65001" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<%
Dim fn
Dim resize, width, height, interpolation
Dim fso, data
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma", "no-cache"
Response.AddHeader "cache-control", "private, no-cache, no-store, must-revalidate"

' Get resize parameters
resize = Request.QueryString("resize").Count > 0
If Request.QueryString("width").Count > 0 Then
	width = Request.QueryString("width")
End If
If Request.QueryString("height").Count > 0 Then
	height = Request.QueryString("height")
End If
If Request.QueryString("width").Count <= 0 And Request.QueryString("height").Count <= 0 Then
	width = EW_THUMBNAIL_DEFAULT_WIDTH
	height = EW_THUMBNAIL_DEFAULT_HEIGHT
End If
If Request.QueryString("interpolation").Count > 0 Then
	interpolation = Request.QueryString("interpolation")
Else
	interpolation = EW_THUMBNAIL_DEFAULT_INTERPOLATION
End If

' Resize image from physical file
If Request.QueryString("fn").Count > 0 Then
	fn = Request.QueryString("fn")
	fn = ew_IncludeTrailingDelimiter(ew_AppRoot(), True) & fn
	Set fso = Server.Createobject("Scripting.FileSystemObject")
	If fso.FileExists(fn) Then
		data = ew_ResizeFileToBinary(fn, width, height, interpolation)
		Response.ContentType = ew_ContentType(LeftB(data,11), "")
		Response.BinaryWrite data
	End If
	Set fso = Nothing
	Response.End
End If
%>
