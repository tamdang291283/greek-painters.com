<%

'
' ASPMaker 12 database helper class
'
Class czMENU_db

	' Debug
	Dim Debug

	' Language
	Dim Lang
	Dim LangFolder
	Dim LangId

	' Database settings
	Dim Connection
	Dim ConnectionString ' DB Connection String
	Dim Schema
	Dim StartQuote
	Dim EndQuote
	Dim CursorLocation
	Dim RecordsetLockType

	' Table CSS class name
	Dim TableClass

	' Class Initialize
	Private Sub Class_Initialize()
		Debug = False
		TableClass = "table table-bordered table-striped ewDbTable"
		ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & ew_ServerMapPath("../../Data/menu.mdb") & ";"
		Schema = ""
		StartQuote = "["
		EndQuote = "]"
		CursorLocation = 2
		RecordsetLockType = 2
	End Sub

	' Connect to database
	Public Sub Connect(ConnStr)

		' Open connection to the database
		Set Connection = Server.CreateObject("ADODB.Connection")
		Connection.Open ConnStr
		Call InitializeConnection()
	End Sub

	' Connect to database with default connection string
	Public Sub Open()

		' Open connection to the database
		Set Connection = Server.CreateObject("ADODB.Connection")
		Connection.Open ConnectionString
		Call InitializeConnection()
	End Sub

	' Initialize connection
	Private Sub InitializeConnection()
	End Sub

	' Quoted name for table/field
	Private Function QuotedName(Name)
		QuotedName = StartQuote & Replace(Name, EndQuote, EndQuote & EndQuote) & EndQuote
	End Function

	' Execute UPDATE, INSERT, or DELETE statements
	Function Execute(SQL)
		On Error Resume Next
		If IsEmpty(Connection) Then Call Open()
		Execute = Connection.Execute(SQL)
	End Function

	' Return sql scalar value
	Function ExecuteScalar(SQL)
		On Error Resume Next
		Err.Clear
		ExecuteScalar = Null
		If Trim(SQL & "") = "" Then Exit Function
		Dim RsExec
		If IsEmpty(Connection) Then Call Open()
		Set RsExec = Connection.Execute(SQL)
		If Err.Number <> 0 Then
			Response.Write "Execute scalar error. SQL: '" & SQL & "'. Description: " & Err.Description
			Response.End
		Else
			If Not RsExec.Eof Then ExecuteScalar = RsExec(0)
		End If
		RsExec.Close
		Set RsExec = Nothing
	End Function

	' Load row
	Function LoadRow(SQL)
		On Error Resume Next
		Err.Clear
		Dim RsRow
		If IsEmpty(Connection) Then Call Open()
		Set RsRow = Server.CreateObject("ADODB.Recordset")
		RsRow.Open SQL, Connection
		If Err.Number <> 0 Then
			Response.Write "Load row error. SQL: '" & SQL & "'. Description: " & Err.Description
			Response.End
		Else
			Set LoadRow = RsRow
		End If
	End Function

	' Load recordset
	Function LoadRecordset(SQL)
		On Error Resume Next
		Err.Clear
		Dim RsSet
		If IsEmpty(Connection) Then Call Open()
		Set RsSet = Server.CreateObject("ADODB.Recordset")
		RsSet.CursorLocation = CursorLocation

		'RsSet.Open SQL, Connection, 1, RecordsetLockType
		RsSet.Open SQL, Connection, 3, 1, 1
		If Err.Number <> 0 Then
			Response.Write "Load recordset error. SQL: '" & SQL & "'. Description: " & Err.Description
			Response.End
		Else
			Set LoadRecordset = RsSet
		End If
	End Function

	' Get result in HTML table
	' options: 0:fieldcaption(bool|array), 1:horizontal(bool), 2:tablename(string|array), 3:tableclass(string)
	Function ExecuteHtml(SQL, options)
		On Error Resume Next
		Dim ar, horizontal, html, tblclass
		Dim rs, cnt, fldcnt, rowcnt, i, key, val
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
		Set rs = LoadRecordset(SQL)
		cnt = rs.RecordCount
		If cnt > 1 Or horizontal Then ' Horizontal table
			html = "<table class=""" & tblclass & """>"
			html = html & "<thead><tr>"
			fldcnt = rs.Fields.Count
			For i = 0 to fldcnt - 1
				key = rs.Fields(i).Name
				val = rs.Fields(i).Value
				html = html & "<th>" & GetFieldCaption(key, ar) & "</th>"
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
					html = html & "<td>" & GetFieldCaption(key, ar) & "</td>"
					html = html & "<td>" & val & "</td></tr>"
				Next
				html = html & "</tbody></table>"
			End If
		End If
		rs.Close
		Set rs = Nothing
		ExecuteHtml = html
	End Function

	' Get field caption
	' ar: 0:fieldcaption(bool|array), 1:horizontal(bool), 2:tablename(string|array), 3:tableclass(string)
	Private Function GetFieldCaption(key, ar)
		On Error Resume Next
		Dim caption, tblname, usecaption, arcaptions, i
		caption = ""
		If Not IsArray(ar) Then
			GetFieldCaption = key
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
					If IsEmpty(Lang) Then
						If LangFolder <> "" Then
							Set Lang = New cLanguage
							Lang.LanguageFolder = LangFolder
							Call Lang.LoadPhrases()
						Else
							Set Lang = Language
						End If
					End If
					If IsObject(Lang) Then
						If IsArray(tblname) Then
							For i = 0 to UBound(tblname)
								caption = Lang.FieldPhrase(tblname(i), key, "FldCaption")
								If caption <> "" Then
									Exit For
								End If
							Next
						ElseIf tblname <> "" Then
							caption = Lang.FieldPhrase(tblname, key, "FldCaption")
						End If
					End If
				End If
			End If
		End If
		If caption <> "" Then
			GetFieldCaption = caption
		Else
			GetFieldCaption = key
		End If
	End Function
End Class
%>
