<%@ CodePage="65001" EnableSessionState="False" %>
<% Option Explicit %>
<%
Response.Buffer = EW_RESPONSE_BUFFER
%>
<!--#include file="ewcfg12.asp"-->
<!--#include file="aspfn12.asp"-->
<!--#include file="md5.asp"-->
<%
Call ew_Header(False, "utf-8")
Dim lookup
Set lookup = New clookup
Set Page = lookup
lookup.Page_Main()
Set lookup = Nothing

' Page class for lookup
Class clookup

	' Page ID
	Public Property Get PageID()
		PageID = "lookup"
	End Property

	' Page Object Name
	Public Property Get PageObjName()
		PageObjName = "lookup"
	End Property

	' Page Name
	Public Property Get PageName()
		PageName = ew_CurrentPage()
	End Property

	' Page Url
	Public Property Get PageUrl()
		PageUrl = ew_CurrentPage() & "?"
	End Property

	' Main
	Sub Page_Main()
		On Error Resume Next
		Dim sql, value, arValue
		Dim filters, filter, i, j, fldtype
		Dim bPostBack
		bPostBack = (Request.Form <> "")
		If Not bPostBack Then
			Response.Write "Missing post data."
			Response.End
		End If
		sql = Request.Form("s") & ""
		sql = ew_Decrypt(ew_Decode(sql))
		If InStr(sql, "{filter}") > 0 Then
			filters = ""
			For i = 0 to 4

				' Get the filter values (for "IN")
				filter = Request.Form("f" & i) & ""
				filter = ew_Decrypt(ew_Decode(filter))
				If filter <> "" Then
					value = Request.Form("v" & i) & ""
					If value = "" Then
						If i > 0 Then ' Empty parent field

							'Do nothing ' Allow
							Call ew_AddFilter(filters, "1=0") ' Disallow
						End If
					Else
						arValue = Split(value, ",")
						fldtype = Request.Form("t" & i) & ""
						For j = 0 to UBound(arValue)
							arValue(j) = ew_QuotedValue(arValue(j), ew_FieldDataType(fldtype))
						Next
						filter = Replace(filter, "{filter_value}", Join(arValue, ","))
						Call ew_AddFilter(filters, filter)
					End If
				End If
			Next
			sql = Replace(sql, "{filter}", ew_IIf(filters <> "", filters, "1=1"))
		End If

		' Get the query value (for "LIKE" or "=")
		value = ew_AdjustSql(Request.QueryString("q")) ' Get the query value from querystring
		If value = "" Then value = ew_AdjustSql(Request.Form("q"))
		If value & "" <> "" Then
			sql = Replace(sql, " LIKE '%{query_value}%'", ew_Like("'%{query_value}%'"))
			sql = Replace(sql, " LIKE '{query_value}%'", ew_Like("'{query_value}%'"))
			sql = Replace(sql, "{query_value}", value)
		End If

		' Replace {query_value_n}
		Dim pattern, Match, Matches, v
		pattern = "\{query_value_(\d+)\}"
		If ew_RegExMatch(pattern, sql, Matches) Then
			For Each Match in Matches
				j = Match.SubMatches(0)
				v = ew_AdjustSql(Request.Form("q" & j))
				sql = Replace(sql, Match, v)
			Next
		End If
		GetLookupValues(sql)
	End Sub

	' Get values from database
	Sub GetLookupValues(Sql)
		On Error Resume Next

		' Connect to database
		Dim rs, rsArr, str, i, j
		Call ew_Connect()
		Set rs = Conn.Execute(Sql)
		If Not rs.EOF Then
			rsArr = rs.GetRows
		End If

		' Close database
		rs.Close
		Set rs = Nothing
		Conn.Close
		Set Conn = Nothing

		' Output
		If IsArray(rsArr) Then
			For j = 0 To UBound(rsArr, 2)
				For i = 0 To UBound(rsArr, 1)
					str = rsArr(i, j) & ""
					If Request.Form("keepCRLF").Count > 0 Then
						str = Replace(str, vbCr, "\\r")
						str = Replace(str, vbLf, "\\n")
					Else
						str = Replace(str, vbCr, " ")
						str = Replace(str, vbLf, " ")
					End If
					rsArr(i, j) = str
				Next
			Next
		End If
		Response.Write ew_ArrayToJson(rsArr, 0)
	End Sub
End Class
%>
