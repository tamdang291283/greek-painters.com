<%

' ASPMaker configuration for Table Customer_Book_Table
Dim Customer_Book_Table

' Define table class
Class cCustomer_Book_Table

	' Class Initialize
	Private Sub Class_Initialize()
		UseTokenInUrl = EW_USE_TOKEN_IN_URL
		ExportAll = True
		ExportPageBreakCount = 0 ' Page break per every n record (PDF only)
		ExportPageOrientation = "portrait" ' Page orientation (PDF only)
		ExportPageSize = "a4" ' Page size (PDF only)
		Set RowAttrs = New cAttributes ' Row attributes
		Set CustomActions = New cCustomArray
		AllowAddDeleteRow = ew_AllowAddDeleteRow() ' Allow add/delete row
		DetailAdd = False ' Allow detail add
		DetailEdit = False ' Allow detail edit
		DetailView = False ' Allow detail view
		ShowMultipleDetails = False ' Show multiple details
		GridAddRowCount = 5 ' Grid add row count
		ValidateKey = True ' Validate key
		Visible = True
		BasicSearch.TblVar = TableVar
		BasicSearch.KeywordDefault = ""
		BasicSearch.SearchTypeDefault = ""
		UserIDAllowSecurity = 0 ' User ID Allow
		Call ew_SetArObj(Fields, "ID", ID)
		Call ew_SetArObj(Fields, "Name", Name)
		Call ew_SetArObj(Fields, "Phone", Phone)
		Call ew_SetArObj(Fields, "bookdate", bookdate)
		Call ew_SetArObj(Fields, "IdBusinessDetail", IdBusinessDetail)
		Call ew_SetArObj(Fields, "comment", comment)
		Call ew_SetArObj(Fields, "s_contentemail", s_contentemail)
		Call ew_SetArObj(Fields, "numberpeople", numberpeople)
		Call ew_SetArObj(Fields, "createddate", createddate)
		Call ew_SetArObj(Fields, "zEmail", zEmail)
	End Sub

	' Reset attributes for table object
	Public Sub ResetAttrs()
		CssClass = ""
		CssStyle = ""
		RowAttrs.Clear()
		Dim i, fld
		If IsArray(Fields) Then
			For i = 0 to UBound(Fields,2)
				Set fld = Fields(1,i)
				Call fld.ResetAttrs()
			Next
		End If
	End Sub

	' Setup field titles
	Public Sub SetupFieldTitles()
		Dim i, fld
		If IsArray(Fields) Then
			For i = 0 to UBound(Fields,2)
				Set fld = Fields(1,i)
				If fld.FldTitle <> "" Then
					fld.EditAttrs.UpdateAttribute "data-toggle", "tooltip"
					fld.EditAttrs.UpdateAttribute "title", ew_HtmlEncode(fld.FldTitle)
				End If
			Next
		End If
	End Sub

	' Define table level constants
	' Use table token in Url

	Dim UseTokenInUrl

	' Table variable
	Public Property Get TableVar()
		TableVar = "Customer_Book_Table"
	End Property

	' Table name
	Public Property Get TableName()
		TableName = "Customer_Book_Table"
	End Property

	' Table type
	Public Property Get TableType()
		TableType = "TABLE"
	End Property

	' Table caption
	Dim Caption

	Public Property Let TableCaption(v)
		Caption = v
	End Property

	Public Property Get TableCaption()
		If Caption & "" <> "" Then
			TableCaption = Caption
		Else
			TableCaption = Language.TablePhrase(TableVar, "TblCaption")
		End If
	End Property

	' Page caption
	Dim PgCaption

	Public Property Let PageCaption(Page, v)
		If Not IsArray(PgCaption) Then
			ReDim PgCaption(Page)
		ElseIf Page > UBound(PgCaption) Then
			ReDim Preserve PgCaption(Page)
		End If
		PgCaption(Page) = v
	End Property

	Public Property Get PageCaption(Page)
		PageCaption = ""
		If IsArray(PgCaption) Then
			If Page <= UBound(PgCaption) Then
				PageCaption = PgCaption(Page)
			End If
		End If
		If PageCaption = "" Then PageCaption = Language.TablePhrase(TableVar, "TblPageCaption" & Page)
		If PageCaption = "" Then PageCaption = "Page " & Page
	End Property
	Dim Visible

	' Export Return Page
	Public Property Get ExportReturnUrl()
		If Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_EXPORT_RETURN_URL) <> "" Then
			ExportReturnUrl = Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_EXPORT_RETURN_URL)
		Else
			ExportReturnUrl = ew_CurrentPage
		End If
	End Property

	Public Property Let ExportReturnUrl(v)
		Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_EXPORT_RETURN_URL) = v
	End Property

	' Records per page
	Public Property Get RecordsPerPage()
		RecordsPerPage = Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_REC_PER_PAGE)
	End Property

	Public Property Let RecordsPerPage(v)
		Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_REC_PER_PAGE) = v
	End Property

	' Start record number
	Public Property Get StartRecordNumber()
		StartRecordNumber = Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_START_REC)
	End Property

	Public Property Let StartRecordNumber(v)
		Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_START_REC) = v
	End Property

	' Search Highlight Name
	Public Property Get HighlightName()
		HighlightName = "Customer_Book_Table_Highlight"
	End Property

	' Search where clause
	Public Property Get SearchWhere()
		SearchWhere = Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_SEARCH_WHERE)
	End Property

	Public Property Let SearchWhere(v)
		Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_SEARCH_WHERE) = v
	End Property

	' Single column sort
	Public Sub UpdateSort(ofld)
		Dim sSortField, sLastSort, sThisSort
		If CurrentOrder = ofld.FldName Then
			sSortField = ofld.FldExpression
			sLastSort = ofld.Sort
			If CurrentOrderType = "ASC" Or CurrentOrderType = "DESC" Then
				sThisSort = CurrentOrderType
			Else
				If sLastSort = "ASC" Then sThisSort = "DESC" Else sThisSort = "ASC"
			End If
			ofld.Sort = sThisSort
			SessionOrderBy = sSortField & " " & sThisSort ' Save to Session
		Else
			ofld.Sort = ""
		End If
	End Sub

	' BasicSearch Object
	Private m_BasicSearch

	Public Property Get BasicSearch()
		If Not IsObject(m_BasicSearch) Then
			Set m_BasicSearch = New cBasicSearch
		End If
		Set BasicSearch = m_BasicSearch
	End Property

	' Session WHERE Clause
	Public Property Get SessionWhere()
		SessionWhere = Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_WHERE)
	End Property

	Public Property Let SessionWhere(v)
		Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_WHERE) = v
	End Property

	' Session ORDER BY
	Public Property Get SessionOrderBy()
		SessionOrderBy = Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_ORDER_BY)
	End Property

	Public Property Let SessionOrderBy(v)
		Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_ORDER_BY) = v
	End Property

	' Session Key
	Public Function GetKey(fld)
		GetKey = Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_KEY & "_" & fld)
	End Function

	Public Function SetKey(fld, v)
		Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_KEY & "_" & fld) = v
	End Function

	' Table level SQL
	' Select
	Private zSqlSelect

	Public Property Get SqlSelect()
		SqlSelect = ew_IIf(zSqlSelect & "" <> "", zSqlSelect, "SELECT * FROM [dbo].[Customer_Book_Table]")
	End Property

	Public Property Let SqlSelect(v)
		zSqlSelect = v
	End Property

	Private Property Get TableFilter()
		TableFilter = ""
	End Property

	' Where
	Private zSqlWhere

	Public Property Get SqlWhere()
		Dim sWhere
		sWhere = ew_IIf(zSqlWhere & "" <> "", zSqlWhere, "")
		Call ew_AddFilter(sWhere, TableFilter)
		SqlWhere = sWhere
	End Property

	Public Property Let SqlWhere(v)
		zSqlWhere = v
	End Property

	' Group By
	Private zSqlGroupBy

	Public Property Get SqlGroupBy()
		SqlGroupBy = ew_IIf(zSqlGroupBy & "" <> "", zSqlGroupBy, "")
	End Property

	Public Property Let SqlGroupBy(v)
		zSqlGroupBy = v
	End Property

	' Having
	Private zSqlHaving

	Public Property Get SqlHaving()
		SqlHaving = ew_IIf(zSqlHaving & "" <> "", zSqlHaving, "")
	End Property

	Public Property Let SqlHaving(v)
		zSqlHaving = v
	End Property

	' Order By
	Private zSqlOrderBy

	Public Property Get SqlOrderBy()
		SqlOrderBy = ew_IIf(zSqlOrderBy & "" <> "", zSqlOrderBy, "")
	End Property

	Public Property Let SqlOrderBy(v)
		zSqlOrderBy = v
	End Property

	' SQL variables
	Dim CurrentFilter ' Current filter
	Dim CurrentOrder ' Current order
	Dim CurrentOrderType ' Current order type

	' Get sql
	Public Function GetSQL(where, orderby)
		GetSQL = ew_BuildSelectSql(SqlSelect, SqlWhere, SqlGroupBy, SqlHaving, SqlOrderBy, where, orderby)
	End Function

	' Table sql
	Public Property Get SQL()
		Dim sFilter, sSort
		sFilter = CurrentFilter
		sSort = SessionOrderBy
		SQL = ew_BuildSelectSql(SqlSelect, SqlWhere, SqlGroupBy, SqlHaving, SqlOrderBy, sFilter, sSort)
	End Property

	' Return table sql with list page filter
	Public Property Get SelectSQL()
		Dim sFilter, sSort
		sFilter = SessionWhere
		Call ew_AddFilter(sFilter, CurrentFilter)
		Call Recordset_Selecting(sFilter)
		sSort = SessionOrderBy
		SelectSQL = ew_BuildSelectSql(SqlSelect, SqlWhere, SqlGroupBy, SqlHaving, SqlOrderBy, sFilter, sSort)
	End Property

	' Key filter for table
	Private Property Get SqlKeyFilter()
		SqlKeyFilter = "[ID] = @ID@"
	End Property

	' Return Key filter for table
	Public Property Get KeyFilter()
		Dim sKeyFilter
		sKeyFilter = SqlKeyFilter
		If Not IsNumeric(ID.CurrentValue) Then
			sKeyFilter = "0=1" ' Invalid key
		End If
		sKeyFilter = Replace(sKeyFilter, "@ID@", ew_AdjustSql(ID.CurrentValue)) ' Replace key value
		KeyFilter = sKeyFilter
	End Property

	' Return url
	Public Property Get ReturnUrl()

		' Get referer url automatically
		If Request.ServerVariables("HTTP_REFERER") <> "" Then
			If ew_ReferPage <> ew_CurrentPage And ew_ReferPage <> "login.asp" Then ' Referer not same page or login page
				Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_RETURN_URL) = Request.ServerVariables("HTTP_REFERER") ' Save to Session
			End If
		End If
		If Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_RETURN_URL) <> "" Then
			ReturnUrl = Session(EW_PROJECT_NAME & "_" & TableVar & "_" & EW_TABLE_RETURN_URL)
		Else
			ReturnUrl = "Customer_Book_Tablelist.asp"
		End If
	End Property

	' List url
	Public Function ListUrl()
		ListUrl = "Customer_Book_Tablelist.asp"
	End Function

	' View url
	Public Function ViewUrl(parm)
		If parm <> "" Then
			ViewUrl = KeyUrl("Customer_Book_Tableview.asp", UrlParm(parm))
		Else
			ViewUrl = KeyUrl("Customer_Book_Tableview.asp", UrlParm(EW_TABLE_SHOW_DETAIL & "="))
		End If
	End Function

	' Add url
	Public Function AddUrl(parm)
		If parm <> "" Then
			AddUrl = "Customer_Book_Tableadd.asp?" & UrlParm(parm)
		Else
			AddUrl = "Customer_Book_Tableadd.asp"
		End If
	End Function

	' Edit url
	Public Function EditUrl(parm)
		EditUrl = KeyUrl("Customer_Book_Tableedit.asp", UrlParm(parm))
	End Function

	' Inline edit url
	Public Function InlineEditUrl()
		InlineEditUrl = KeyUrl(ew_CurrentPage, UrlParm("a=edit"))
	End Function

	' Copy url
	Public Function CopyUrl(parm)
		CopyUrl = KeyUrl("Customer_Book_Tableadd.asp", UrlParm(parm))
	End Function

	' Inline copy url
	Public Function InlineCopyUrl()
		InlineCopyUrl = KeyUrl(ew_CurrentPage, UrlParm("a=copy"))
	End Function

	' Delete url
	Public Function DeleteUrl()
		DeleteUrl = KeyUrl("Customer_Book_Tabledelete.asp", UrlParm(""))
	End Function

	' Key url
	Public Function KeyUrl(url, parm)
		Dim sUrl: sUrl = url & "?"
		If parm <> "" Then sUrl = sUrl & parm & "&"
		If Not IsNull(ID.CurrentValue) Then
			sUrl = sUrl & "ID=" & ID.CurrentValue
		Else
			KeyUrl = "javascript:alert(ewLanguage.Phrase('InvalidRecord'));"
			Exit Function
		End If
		KeyUrl = sUrl
	End Function

	' Sort Url
	Public Property Get SortUrl(fld)
		If CurrentAction <> "" Or Export <> "" Or (fld.FldType = 201 Or fld.FldType = 203 Or fld.FldType = 205 Or fld.FldType = 141) Then
			SortUrl = ""
		ElseIf fld.Sortable Then
			SortUrl = ew_CurrentPage
			Dim sUrlParm
			sUrlParm = UrlParm("order=" & ew_Encode(fld.FldName) & "&amp;ordertype=" & fld.ReverseSort)
			SortUrl = SortUrl & "?" & sUrlParm
		Else
			SortUrl = ""
		End If
	End Property

	' Url parm
	Function UrlParm(parm)
		If UseTokenInUrl Then
			UrlParm = "t=Customer_Book_Table"
		Else
			UrlParm = ""
		End If
		If parm <> "" Then
			If UrlParm <> "" Then UrlParm = UrlParm & "&"
			UrlParm = UrlParm & parm
		End If
	End Function

	' Get record keys from Form/QueryString/Session
	Public Function GetRecordKeys()
		Dim arKeys, arKey, cnt, i, bHasKey
		bHasKey = False

		' Check ObjForm first
		If IsObject(ObjForm) And Not (ObjForm Is Nothing) Then
			ObjForm.Index = -1
			If ObjForm.HasValue("key_m") Then
				arKeys = ObjForm.GetValue("key_m")
				If Not IsArray(arKeys) Then
					arKeys = Array(arKeys)
				End If
				bHasKey = True
			End If
		End If

		' Check Form/QueryString
		If Not bHasKey Then
			If Request.Form("key_m").Count > 0 Then
				cnt = Request.Form("key_m").Count
				ReDim arKeys(cnt-1)
				For i = 1 to cnt ' Set up keys
					arKeys(i-1) = Request.Form("key_m")(i)
				Next
			ElseIf Request.QueryString("key_m").Count > 0 Then
				cnt = Request.QueryString("key_m").Count
				ReDim arKeys(cnt-1)
				For i = 1 to cnt ' Set up keys
					arKeys(i-1) = Request.QueryString("key_m")(i)
				Next
			ElseIf Request.QueryString <> "" Then
				ReDim arKeys(0)
				arKeys(0) = Request.QueryString("ID") ' ID

				'GetRecordKeys = arKeys ' Do not return yet, so the values will also be checked by the following code
			End If
		End If

		' Check keys
		Dim ar, key
		If IsArray(arKeys) Then
			For i = 0 to UBound(arKeys)
				key = arKeys(i)
						Dim skip
						skip = False
						If Not IsNumeric(key) Then skip = True
						If Not skip Then
							If IsArray(ar) Then
								ReDim Preserve ar(UBound(ar)+1)
							Else
								ReDim ar(0)
							End If
							ar(UBound(ar)) = key
						End If
			Next
		End If
		GetRecordKeys = ar
	End Function

	' Get key filter
	Public Function GetKeyFilter()
		Dim arKeys, sKeyFilter, i, key
		arKeys = GetRecordKeys()
		sKeyFilter = ""
		If IsArray(arKeys) Then
			For i = 0 to UBound(arKeys)
				key = arKeys(i)
				If sKeyFilter <> "" Then sKeyFilter = sKeyFilter & " OR "
				ID.CurrentValue = key
				sKeyFilter = sKeyFilter & "(" & KeyFilter & ")"
			Next
		End If
		GetKeyFilter = sKeyFilter
	End Function

	' Function LoadRecordCount
	' - Load record count based on filter
	Public Function LoadRecordCount(sFilter)
		Dim wrkrs
		Set wrkrs = LoadRs(sFilter)
		If Not wrkrs Is Nothing Then
			LoadRecordCount = wrkrs.RecordCount
		Else
			LoadRecordCount = 0
		End If
		Set wrkrs = Nothing
	End Function

	' Function LoadRs
	' - Load Rows based on filter
	Public Function LoadRs(sFilter)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next
		Dim RsRows, sSql

		' Set up filter (Sql Where Clause) and get Return Sql
		'CurrentFilter = sFilter
		'sSql = SQL

		sSql = GetSQL(sFilter, "")
		Err.Clear
		Set RsRows = Server.CreateObject("ADODB.Recordset")
		RsRows.CursorLocation = EW_CURSORLOCATION
		RsRows.Open sSql, Conn, 3, 1, 1 ' adOpenStatic, adLockReadOnly, adCmdText
		If Err.Number <> 0 Then
			Err.Clear
			Set LoadRs = Nothing
			RsRows.Close
			Set RsRows = Nothing
		ElseIf RsRows.Eof Then
			Set LoadRs = Nothing
			RsRows.Close
			Set RsRows = Nothing
		Else
			Set LoadRs = RsRows
		End If
	End Function

	' Load row values from recordset
	Public Sub LoadListRowValues(RsRow)
		ID.DbValue = RsRow("ID")
		Name.DbValue = RsRow("Name")
		Phone.DbValue = RsRow("Phone")
		bookdate.DbValue = RsRow("bookdate")
		IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		comment.DbValue = RsRow("comment")
		s_contentemail.DbValue = RsRow("s_contentemail")
		numberpeople.DbValue = RsRow("numberpeople")
		createddate.DbValue = RsRow("createddate")
		zEmail.DbValue = RsRow("Email")
	End Sub

	' Render list row values
	Sub RenderListRow()

		'
		'  Common render codes
		'
		' ID
		' Name
		' Phone
		' bookdate
		' IdBusinessDetail
		' comment
		' s_contentemail
		' numberpeople
		' createddate
		' Email
		' Call Row Rendering event

		Call Row_Rendering()

		'
		'  Render for View
		'
		' ID

		ID.ViewValue = ID.CurrentValue
		ID.ViewCustomAttributes = ""

		' Name
		Name.ViewValue = Name.CurrentValue
		Name.ViewCustomAttributes = ""

		' Phone
		Phone.ViewValue = Phone.CurrentValue
		Phone.ViewCustomAttributes = ""

		' bookdate
		bookdate.ViewValue = bookdate.CurrentValue
		bookdate.ViewCustomAttributes = ""

		' IdBusinessDetail
		IdBusinessDetail.ViewValue = IdBusinessDetail.CurrentValue
		IdBusinessDetail.ViewCustomAttributes = ""

		' comment
		comment.ViewValue = comment.CurrentValue
		comment.ViewCustomAttributes = ""

		' s_contentemail
		s_contentemail.ViewValue = s_contentemail.CurrentValue
		s_contentemail.ViewCustomAttributes = ""

		' numberpeople
		numberpeople.ViewValue = numberpeople.CurrentValue
		numberpeople.ViewCustomAttributes = ""

		' createddate
		createddate.ViewValue = createddate.CurrentValue
		createddate.ViewCustomAttributes = ""

		' Email
		zEmail.ViewValue = zEmail.CurrentValue
		zEmail.ViewCustomAttributes = ""

		' ID
		ID.LinkCustomAttributes = ""
		ID.HrefValue = ""
		ID.TooltipValue = ""

		' Name
		Name.LinkCustomAttributes = ""
		Name.HrefValue = ""
		Name.TooltipValue = ""

		' Phone
		Phone.LinkCustomAttributes = ""
		Phone.HrefValue = ""
		Phone.TooltipValue = ""

		' bookdate
		bookdate.LinkCustomAttributes = ""
		bookdate.HrefValue = ""
		bookdate.TooltipValue = ""

		' IdBusinessDetail
		IdBusinessDetail.LinkCustomAttributes = ""
		IdBusinessDetail.HrefValue = ""
		IdBusinessDetail.TooltipValue = ""

		' comment
		comment.LinkCustomAttributes = ""
		comment.HrefValue = ""
		comment.TooltipValue = ""

		' s_contentemail
		s_contentemail.LinkCustomAttributes = ""
		s_contentemail.HrefValue = ""
		s_contentemail.TooltipValue = ""

		' numberpeople
		numberpeople.LinkCustomAttributes = ""
		numberpeople.HrefValue = ""
		numberpeople.TooltipValue = ""

		' createddate
		createddate.LinkCustomAttributes = ""
		createddate.HrefValue = ""
		createddate.TooltipValue = ""

		' Email
		zEmail.LinkCustomAttributes = ""
		zEmail.HrefValue = ""
		zEmail.TooltipValue = ""

		' Call Row Rendered event
		If RowType <> EW_ROWTYPE_AGGREGATEINIT Then
			Call Row_Rendered()
		End If
	End Sub

	' Render edit row values
	Public Sub RenderEditRow()

		' Call Row Rendering event
		Call Row_Rendering()

		' ID
		ID.EditAttrs.UpdateAttribute "class", "form-control"
		ID.EditCustomAttributes = ""
		ID.EditValue = ID.CurrentValue
		ID.ViewCustomAttributes = ""

		' Name
		Name.EditAttrs.UpdateAttribute "class", "form-control"
		Name.EditCustomAttributes = ""
		Name.EditValue = Name.CurrentValue
		Name.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Name.FldCaption))

		' Phone
		Phone.EditAttrs.UpdateAttribute "class", "form-control"
		Phone.EditCustomAttributes = ""
		Phone.EditValue = Phone.CurrentValue
		Phone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Phone.FldCaption))

		' bookdate
		bookdate.EditAttrs.UpdateAttribute "class", "form-control"
		bookdate.EditCustomAttributes = ""
		bookdate.EditValue = bookdate.CurrentValue
		bookdate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(bookdate.FldCaption))

		' IdBusinessDetail
		IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
		IdBusinessDetail.EditCustomAttributes = ""
		IdBusinessDetail.EditValue = IdBusinessDetail.CurrentValue
		IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(IdBusinessDetail.FldCaption))

		' comment
		comment.EditAttrs.UpdateAttribute "class", "form-control"
		comment.EditCustomAttributes = ""
		comment.EditValue = comment.CurrentValue
		comment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(comment.FldCaption))

		' s_contentemail
		s_contentemail.EditAttrs.UpdateAttribute "class", "form-control"
		s_contentemail.EditCustomAttributes = ""
		s_contentemail.EditValue = s_contentemail.CurrentValue
		s_contentemail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(s_contentemail.FldCaption))

		' numberpeople
		numberpeople.EditAttrs.UpdateAttribute "class", "form-control"
		numberpeople.EditCustomAttributes = ""
		numberpeople.EditValue = numberpeople.CurrentValue
		numberpeople.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(numberpeople.FldCaption))

		' createddate
		createddate.EditAttrs.UpdateAttribute "class", "form-control"
		createddate.EditCustomAttributes = ""
		createddate.EditValue = createddate.CurrentValue
		createddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(createddate.FldCaption))

		' Email
		zEmail.EditAttrs.UpdateAttribute "class", "form-control"
		zEmail.EditCustomAttributes = ""
		zEmail.EditValue = zEmail.CurrentValue
		zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(zEmail.FldCaption))

		' Call Row Rendered event
		Call Row_Rendered()
	End Sub

	' Aggregate list row values
	Public Sub AggregateListRowValues()
	End Sub

	' Aggregate list row (for rendering)
	Sub AggregateListRow()

		' Call Row Rendered event
		Call Row_Rendered()
	End Sub

	' Update detail records
	Function UpdateDetailRecords(RsOld, RsNew)
		Dim bUpdate, sFieldList, sWhereList, sSql
		On Error Resume Next
		UpdateDetailRecords = True
	End Function

	' Delete detail records
	Function DeleteDetailRecords(Rs, Where)
		Dim sWhereList, sWhereWrk, sSql
		Dim bNullRs, RsWrk
		bNullRs = IsNull(Rs)
		On Error Resume Next
		DeleteDetailRecords = True
	End Function

	' Export data in Xml Format
	Public Sub ExportXmlDocument(XmlDoc, HasParent, Recordset, StartRec, StopRec, ExportPageType)
		If Not IsObject(Recordset) Or Not IsObject(XmlDoc) Then
			Exit Sub
		End If
		If Not HasParent Then
			Call XmlDoc.AddRoot(TableVar)
		End If

		' Move to first record
		Dim RecCnt, RowCnt
		RecCnt = StartRec - 1
		If Not Recordset.Eof Then
			Recordset.MoveFirst()
			If StartRec > 1 Then Recordset.Move(StartRec - 1)
		End If
		Do While Not Recordset.Eof And RecCnt < StopRec
			RecCnt = RecCnt + 1
			If CLng(RecCnt) >= CLng(StartRec) Then
				RowCnt = CLng(RecCnt) - CLng(StartRec) + 1
				Call LoadListRowValues(Recordset)

				' Render row
				RowType = EW_ROWTYPE_VIEW ' Render view
				Call ResetAttrs()
				Call RenderListRow()
				If HasParent Then
					Call XmlDoc.AddRow(TableVar, "")
				Else
					Call XmlDoc.AddRow("", "")
				End If
				If ExportPageType = "view" Then
					Call XmlDoc.AddField("ID", ID.ExportValue(Export))
					Call XmlDoc.AddField("Name", Name.ExportValue(Export))
					Call XmlDoc.AddField("Phone", Phone.ExportValue(Export))
					Call XmlDoc.AddField("bookdate", bookdate.ExportValue(Export))
					Call XmlDoc.AddField("IdBusinessDetail", IdBusinessDetail.ExportValue(Export))
					Call XmlDoc.AddField("comment", comment.ExportValue(Export))
					Call XmlDoc.AddField("s_contentemail", s_contentemail.ExportValue(Export))
					Call XmlDoc.AddField("numberpeople", numberpeople.ExportValue(Export))
					Call XmlDoc.AddField("createddate", createddate.ExportValue(Export))
					Call XmlDoc.AddField("zEmail", zEmail.ExportValue(Export))
				Else
					Call XmlDoc.AddField("ID", ID.ExportValue(Export))
					Call XmlDoc.AddField("Name", Name.ExportValue(Export))
					Call XmlDoc.AddField("Phone", Phone.ExportValue(Export))
					Call XmlDoc.AddField("bookdate", bookdate.ExportValue(Export))
					Call XmlDoc.AddField("IdBusinessDetail", IdBusinessDetail.ExportValue(Export))
					Call XmlDoc.AddField("numberpeople", numberpeople.ExportValue(Export))
					Call XmlDoc.AddField("createddate", createddate.ExportValue(Export))
					Call XmlDoc.AddField("zEmail", zEmail.ExportValue(Export))
				End If
			End If
			Recordset.MoveNext()
		Loop
	End Sub
	Dim ExportDoc

	' Export data in HTML/CSV/Word/Excel/Email format
	Public Sub ExportDocument(Doc, Recordset, StartRec, StopRec, ExportPageType)
		If Not IsObject(Recordset) Or Not IsObject(Doc) Then
			Exit Sub
		End If
		If Not Doc.ExportCustom Then

			' Write header
			Call Doc.ExportTableHeader()
			If Doc.Horizontal Then ' Horizontal format, write header
				Call Doc.BeginExportRow(0)
				If ExportPageType = "view" Then
					If ID.Exportable Then Call Doc.ExportCaption(ID)
					If Name.Exportable Then Call Doc.ExportCaption(Name)
					If Phone.Exportable Then Call Doc.ExportCaption(Phone)
					If bookdate.Exportable Then Call Doc.ExportCaption(bookdate)
					If IdBusinessDetail.Exportable Then Call Doc.ExportCaption(IdBusinessDetail)
					If comment.Exportable Then Call Doc.ExportCaption(comment)
					If s_contentemail.Exportable Then Call Doc.ExportCaption(s_contentemail)
					If numberpeople.Exportable Then Call Doc.ExportCaption(numberpeople)
					If createddate.Exportable Then Call Doc.ExportCaption(createddate)
					If zEmail.Exportable Then Call Doc.ExportCaption(zEmail)
				Else
					If ID.Exportable Then Call Doc.ExportCaption(ID)
					If Name.Exportable Then Call Doc.ExportCaption(Name)
					If Phone.Exportable Then Call Doc.ExportCaption(Phone)
					If bookdate.Exportable Then Call Doc.ExportCaption(bookdate)
					If IdBusinessDetail.Exportable Then Call Doc.ExportCaption(IdBusinessDetail)
					If numberpeople.Exportable Then Call Doc.ExportCaption(numberpeople)
					If createddate.Exportable Then Call Doc.ExportCaption(createddate)
					If zEmail.Exportable Then Call Doc.ExportCaption(zEmail)
				End If
				Call Doc.EndExportRow()
			End If
		End If

		' Move to first record
		Dim RecCnt, RowCnt
		RecCnt = StartRec - 1
		If Not Recordset.Eof Then
			Recordset.MoveFirst()
			If StartRec > 1 Then Recordset.Move(StartRec - 1)
		End If
		Do While Not Recordset.Eof And CLng(RecCnt) < CLng(StopRec)
			RecCnt = RecCnt + 1
			If CLng(RecCnt) >= CLng(StartRec) Then
				RowCnt = CLng(RecCnt) - CLng(StartRec) + 1

				' Page break
				If ExportPageBreakCount > 0 Then
					If RowCnt > 1 And ((RowCnt - 1) Mod ExportPageBreakCount = 0) Then
						Call Doc.ExportPageBreak()
					End If
				End If
				Call LoadListRowValues(Recordset)

				' Render row
				RowType = EW_ROWTYPE_VIEW ' Render view
				Call ResetAttrs()
				Call RenderListRow()
				If Not Doc.ExportCustom Then
					Call Doc.BeginExportRow(RowCnt)
					If ExportPageType = "view" Then
						If ID.Exportable Then Call Doc.ExportField(ID)
						If Name.Exportable Then Call Doc.ExportField(Name)
						If Phone.Exportable Then Call Doc.ExportField(Phone)
						If bookdate.Exportable Then Call Doc.ExportField(bookdate)
						If IdBusinessDetail.Exportable Then Call Doc.ExportField(IdBusinessDetail)
						If comment.Exportable Then Call Doc.ExportField(comment)
						If s_contentemail.Exportable Then Call Doc.ExportField(s_contentemail)
						If numberpeople.Exportable Then Call Doc.ExportField(numberpeople)
						If createddate.Exportable Then Call Doc.ExportField(createddate)
						If zEmail.Exportable Then Call Doc.ExportField(zEmail)
					Else
						If ID.Exportable Then Call Doc.ExportField(ID)
						If Name.Exportable Then Call Doc.ExportField(Name)
						If Phone.Exportable Then Call Doc.ExportField(Phone)
						If bookdate.Exportable Then Call Doc.ExportField(bookdate)
						If IdBusinessDetail.Exportable Then Call Doc.ExportField(IdBusinessDetail)
						If numberpeople.Exportable Then Call Doc.ExportField(numberpeople)
						If createddate.Exportable Then Call Doc.ExportField(createddate)
						If zEmail.Exportable Then Call Doc.ExportField(zEmail)
					End If
					Call Doc.EndExportRow()
				End If
			End If

			' Call Row Export server event
			If Doc.ExportCustom Then
				Call Page.Row_Export(Recordset)
			End If
			Recordset.MoveNext()
		Loop
		If Not Doc.ExportCustom Then
			Call Doc.ExportTableFooter()
		End If
	End Sub

	' Check if Anonymous User is allowed
    Private Function AllowAnonymousUser()
		Select Case EW_PAGE_ID
			Case "add", "register", "addopt"
				AllowAnonymousUser = False
			Case "edit", "update"
				AllowAnonymousUser = False
			Case "delete"
				AllowAnonymousUser = False
			Case "view"
				AllowAnonymousUser = False
			Case "search"
				AllowAnonymousUser = False
			Case Else
				AllowAnonymousUser = False
		End Select
	End Function

	Public Function ApplyUserIDFilters(Filter)

		' Add user id filter
		Dim sFilter
		sFilter = Filter
		ApplyUserIDFilters = sFilter
	End Function

	' Check if User ID security allows view all
	Dim UserIDAllowSecurity

	Function UserIDAllow(id)
		Dim allow
		allow = EW_USER_ID_ALLOW
		Select Case id
			Case "add", "copy", "gridadd", "register", "addopt"
				UserIDAllow = ((allow And EW_ALLOW_ADD) = EW_ALLOW_ADD)
			Case "edit", "gridedit", "update", "changepwd", "forgotpwd"
				UserIDAllow = ((allow And EW_ALLOW_EDIT) = EW_ALLOW_EDIT)
			Case "delete"
				UserIDAllow = ((allow And EW_ALLOW_DELETE) = EW_ALLOW_DELETE)
			Case "view"
				UserIDAllow = ((allow And EW_ALLOW_VIEW) = EW_ALLOW_VIEW)
			Case "search"
				UserIDAllow = ((allow And EW_ALLOW_SEARCH) = EW_ALLOW_SEARCH)
			Case Else
				UserIDAllow = ((allow And EW_ALLOW_LIST) = EW_ALLOW_LIST)
		End Select
	End Function

	' Get auto fill value
	Public Function GetAutoFill(id, val)
		Dim rs, rsArr, str, i, j, rowcnt
		rowcnt = 0

		' Output
		If IsArray(rsArr) And rowcnt > 0 Then
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
			GetAutoFill = ew_ArrayToJson(rsArr, 0)
		Else
			GetAutoFill = ""
		End If
	End Function
	Dim CurrentAction ' Current action
	Dim LastAction ' Last action
	Dim CurrentMode ' Current mode
	Dim UpdateConflict ' Update conflict
	Dim EventName ' Event name
	Dim EventCancelled ' Event cancelled
	Dim CancelMessage ' Cancel message
	Dim AllowAddDeleteRow ' Allow add/delete row
	Dim ValidateKey ' Validate key
	Dim DetailAdd ' Allow detail add
	Dim DetailEdit ' Allow detail edit
	Dim DetailView ' Allow detail view
	Dim ShowMultipleDetails ' Show multiple details
	Dim GridAddRowCount ' Grid add row count
	Dim CustomActions ' Custom action array

	' Check current action
	' - Add
	Public Function IsAdd()
		IsAdd = (CurrentAction = "add")
	End Function

	' - Copy
	Public Function IsCopy()
		IsCopy = (CurrentAction = "copy" Or CurrentAction = "C")
	End Function

	' - Edit
	Public Function IsEdit()
		IsEdit = (CurrentAction = "edit")
	End Function

	' - Delete
	Public Function IsDelete()
		IsDelete = (CurrentAction = "D")
	End Function

	' - Confirm
	Public Function IsConfirm()
		IsConfirm = (CurrentAction = "F")
	End Function

	' - Overwrite
	Public Function IsOverwrite()
		IsOverwrite = (CurrentAction = "overwrite")
	End Function

	' - Cancel
	Public Function IsCancel()
		IsCancel = (CurrentAction = "cancel")
	End Function

	' - Grid add
	Public Function IsGridAdd()
		IsGridAdd = (CurrentAction = "gridadd")
	End Function

	' - Grid edit
	Public Function IsGridEdit()
		IsGridEdit = (CurrentAction = "gridedit")
	End Function

	' - Add/Copy/Edit/GridAdd/GridEdit
	Public Function IsAddOrEdit()
		IsAddOrEdit = IsAdd() Or IsCopy() Or IsEdit() Or IsGridAdd() Or IsGridEdit()
	End Function

	' - Insert
	Public Function IsInsert()
		IsInsert = (CurrentAction = "insert" Or CurrentAction = "A")
	End Function

	' - Update
	Public Function IsUpdate()
		IsUpdate = (CurrentAction = "update" Or CurrentAction = "U")
	End Function

	' - Grid update
	Public Function IsGridUpdate()
		IsGridUpdate = (CurrentAction = "gridupdate")
	End Function

	' - Grid insert
	Public Function IsGridInsert()
		IsGridInsert = (CurrentAction = "gridinsert")
	End Function

	' - Grid overwrite
	Public Function IsGridOverwrite()
		IsGridOverwrite = (CurrentAction = "gridoverwrite")
	End Function

	' Check last action
	' - Cancelled
	Public Function IsCancelled()
		IsCancelled = (LastAction = "cancel" And CurrentAction = "")
	End Function

	' - Inline inserted
	Public Function IsInlineInserted()
		IsInlineInserted = (LastAction = "insert" And CurrentAction = "")
	End Function

	' - Inline updated
	Public Function IsInlineUpdated()
		IsInlineUpdated = (LastAction = "update" And CurrentAction = "")
	End Function

	' - Grid updated
	Public Function IsGridUpdated()
		IsGridUpdated = (LastAction = "gridupdate" And CurrentAction = "")
	End Function

	' - Grid inserted
	Public Function IsGridInserted()
		IsGridInserted = (LastAction = "gridinsert" And CurrentAction = "")
	End Function

	' Row Type
	Private m_RowType

	Public Property Get RowType()
		RowType = m_RowType
	End Property

	Public Property Let RowType(v)
		m_RowType = v
	End Property
	Dim CssClass ' Css class
	Dim CssStyle' Css style

'	Dim RowClientEvents ' Row client events
	Dim RowAttrs ' Row attributes

	' Row Styles
	Public Property Get RowStyles()
		Dim sAtt, Value
		Dim sStyle, sClass
		sAtt = ""
		sStyle = CssStyle
		If RowAttrs.Exists("style") Then
			Value = RowAttrs.Item("style")
			If Trim(Value) <> "" Then
				sStyle = sStyle & " " & Value
			End If
		End If
		sClass = CssClass
		If RowAttrs.Exists("class") Then
			Value = RowAttrs.Item("class")
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
		RowStyles = sAtt
	End Property

	' Row Attribute
	Public Property Get RowAttributes()
		Dim sAtt, Attr, Value, i
		sAtt = RowStyles
		If Export = "" Then

'			If Trim(RowClientEvents) <> "" Then
'				sAtt = sAtt & " " & Trim(RowClientEvents)
'			End If

			For i = 0 to UBound(RowAttrs.Attributes)
				Attr = RowAttrs.Attributes(i)(0)
				Value = RowAttrs.Attributes(i)(1)
				If Attr <> "style" And Attr <> "class" And Attr <> "" And Value <> "" Then
					sAtt = sAtt & " " & Attr & "=""" & Value & """"
				End If
			Next
		End If
		RowAttributes = sAtt
	End Property

	' Export
	Dim Export
	Dim CustomExport

	' Export All
	Dim ExportAll
	Dim ExportPageBreakCount ' Page break per every n record (PDF only)
	Dim ExportPageOrientation ' Page orientation (PDF only)
	Dim ExportPageSize ' Page size (PDF only)

	' Send Email
	Dim SendEmail

	' Custom Inner Html
	Dim TableCustomInnerHtml

	' ----------------
	'  Field objects
	' ----------------
	' Field ID
	Private m_ID

	Public Property Get ID()
		If Not IsObject(m_ID) Then
			Set m_ID = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_ID", "ID", "[ID]", "CAST([ID] AS NVARCHAR)", 3, 0, "[ID]", False, False, FALSE, "FORMATTED TEXT")
			m_ID.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set ID = m_ID
	End Property

	' Field Name
	Private m_Name

	Public Property Get Name()
		If Not IsObject(m_Name) Then
			Set m_Name = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_Name", "Name", "[Name]", "[Name]", 202, 0, "[Name]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Name = m_Name
	End Property

	' Field Phone
	Private m_Phone

	Public Property Get Phone()
		If Not IsObject(m_Phone) Then
			Set m_Phone = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_Phone", "Phone", "[Phone]", "[Phone]", 202, 0, "[Phone]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Phone = m_Phone
	End Property

	' Field bookdate
	Private m_bookdate

	Public Property Get bookdate()
		If Not IsObject(m_bookdate) Then
			Set m_bookdate = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_bookdate", "bookdate", "[bookdate]", "(STR(YEAR([bookdate]),4,0) + '/' + REPLACE(STR(MONTH([bookdate]),2,0),' ','0') + '/' + REPLACE(STR(DAY([bookdate]),2,0),' ','0'))", 135, 9, "[bookdate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set bookdate = m_bookdate
	End Property

	' Field IdBusinessDetail
	Private m_IdBusinessDetail

	Public Property Get IdBusinessDetail()
		If Not IsObject(m_IdBusinessDetail) Then
			Set m_IdBusinessDetail = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_IdBusinessDetail", "IdBusinessDetail", "[IdBusinessDetail]", "CAST([IdBusinessDetail] AS NVARCHAR)", 3, 0, "[IdBusinessDetail]", False, False, FALSE, "FORMATTED TEXT")
			m_IdBusinessDetail.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set IdBusinessDetail = m_IdBusinessDetail
	End Property

	' Field comment
	Private m_comment

	Public Property Get comment()
		If Not IsObject(m_comment) Then
			Set m_comment = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_comment", "comment", "[comment]", "[comment]", 203, 0, "[comment]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set comment = m_comment
	End Property

	' Field s_contentemail
	Private m_s_contentemail

	Public Property Get s_contentemail()
		If Not IsObject(m_s_contentemail) Then
			Set m_s_contentemail = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_s_contentemail", "s_contentemail", "[s_contentemail]", "[s_contentemail]", 203, 0, "[s_contentemail]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set s_contentemail = m_s_contentemail
	End Property

	' Field numberpeople
	Private m_numberpeople

	Public Property Get numberpeople()
		If Not IsObject(m_numberpeople) Then
			Set m_numberpeople = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_numberpeople", "numberpeople", "[numberpeople]", "CAST([numberpeople] AS NVARCHAR)", 3, 0, "[numberpeople]", False, False, FALSE, "FORMATTED TEXT")
			m_numberpeople.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set numberpeople = m_numberpeople
	End Property

	' Field createddate
	Private m_createddate

	Public Property Get createddate()
		If Not IsObject(m_createddate) Then
			Set m_createddate = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_createddate", "createddate", "[createddate]", "(STR(YEAR([createddate]),4,0) + '/' + REPLACE(STR(MONTH([createddate]),2,0),' ','0') + '/' + REPLACE(STR(DAY([createddate]),2,0),' ','0'))", 135, 9, "[createddate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set createddate = m_createddate
	End Property

	' Field Email
	Private m_zEmail

	Public Property Get zEmail()
		If Not IsObject(m_zEmail) Then
			Set m_zEmail = NewFldObj("Customer_Book_Table", "Customer_Book_Table", "x_zEmail", "Email", "[Email]", "[Email]", 202, 0, "[Email]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set zEmail = m_zEmail
	End Property
	Dim Fields ' Fields

	' Get field object by name
	Public Function GetField(Name)
		Dim fld, i
		Set fld = Nothing
		For i = 0 to UBound(Fields,2)
			If Fields(0,i) = Name Then
				Set fld = Fields(1,i)
				Exit For
			End If
		Next
		Set GetField = fld
	End Function

	' Create new field object
	Private Function NewFldObj(TblVar, TblName, FldVar, FldName, FldExpression, FldBasicSearchExpression, FldType, FldDtFormat, FldVirtualExp, FldVirtual, FldForceSelect, FldVirtualSearch, FldViewTag)
		Dim fld
		Set fld = New cField
		fld.TblVar = TblVar
		fld.TblName = TblName
		fld.FldVar = FldVar
		fld.FldName = FldName
		fld.FldExpression = FldExpression
		fld.FldBasicSearchExpression = FldBasicSearchExpression
		fld.FldType = FldType
		fld.FldDataType = ew_FieldDataType(FldType)
		fld.FldDateTimeFormat = FldDtFormat
		fld.FldVirtualExpression = FldVirtualExp
		fld.FldIsVirtual = FldVirtual
		fld.FldForceSelection = FldForceSelect
		fld.FldVirtualSearch = FldVirtualSearch
		fld.FldViewTag = FldViewTag
		fld.AdvancedSearch.TblVar = TblVar
		fld.AdvancedSearch.FldVar = FldVar
		Set NewFldObj = fld
	End Function

	' Table level events
	' Recordset Selecting event
	Sub Recordset_Selecting(filter)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here	
	End Sub

	' Recordset Selected event
	Sub Recordset_Selected(rs)

		'Response.Write "Recordset Selected"
	End Sub

	' Recordset Search Validated event
	Sub Recordset_SearchValidated()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here
	End Sub

	' Recordset Searching event
	Sub Recordset_Searching(filter)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here	
	End Sub

	' Row_Selecting event
	Sub Row_Selecting(filter)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here	
	End Sub

	' Row Selected event
	Sub Row_Selected(rs)

		'Response.Write "Row Selected"
	End Sub

	' Row Inserting event
	Function Row_Inserting(rsold, rsnew)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here
		' To cancel, set return value to False

		Row_Inserting = True
	End Function

	' Row Inserted event
	Sub Row_Inserted(rsold, rsnew)

		' Response.Write "Row Inserted"
	End Sub

	' Row Updating event
	Function Row_Updating(rsold, rsnew)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here
		' To cancel, set return value to False

		Row_Updating = True
	End Function

	' Row Updated event
	Sub Row_Updated(rsold, rsnew)

		' Response.Write "Row Updated"
	End Sub

	' Row Update Conflict event
	Function Row_UpdateConflict(rsold, rsnew)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here
		' To ignore conflict, set return value to False

		Row_UpdateConflict = True
	End Function

	' Grid Inserting event
	Function Grid_Inserting()

		' Enter your code here
		' To reject grid insert, set return value to False

		Grid_Inserting = True
	End Function

	' Grid Inserted event
	Sub Grid_Inserted(rsnew)

		'Response.Write "Grid Inserted"
	End sub

	' Grid Updating event
	Function Grid_Updating(rsold)

		' Enter your code here
		' To reject grid update, set return value to False

		Grid_Updating = True
	End Function

	' Grid Updated event
	Sub Grid_Updated(rsold, rsnew)

		'Response.Write "Grid Updated"
	End Sub

	' Row Deleting event
	Function Row_Deleting(rs)
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here
		' To cancel, set return value to False

		Row_Deleting = True
	End Function

	' Row Deleted event
	Sub Row_Deleted(rs)

		' Response.Write "Row Deleted"
	End Sub

	' Email Sending event
	Function Email_Sending(Email, Args)

		'Response.Write Email.AsString
		'Response.Write "Keys of Args: " & Join(Args.Keys, ", ")
		'Response.End

		Email_Sending = True
	End Function

	' Lookup Selecting event
	Sub Lookup_Selecting(fld, filter)

		' Enter your code here
	End Sub

	' Row Rendering event
	Sub Row_Rendering()
		If Not EW_DEBUG_ENABLED Then On Error Resume Next

		' Enter your code here	
	End Sub

	' Row Rendered event
	Sub Row_Rendered()

		' To view properties of field class, use:
		' Response.Write <FieldName>.AsString() 

	End Sub

	' User ID Filtering event
	Sub UserID_Filtering(filter)

		' Enter your code here
	End Sub

	' Class terminate
	Private Sub Class_Terminate
		If IsObject(m_ID) Then Set m_ID = Nothing
		If IsObject(m_Name) Then Set m_Name = Nothing
		If IsObject(m_Phone) Then Set m_Phone = Nothing
		If IsObject(m_bookdate) Then Set m_bookdate = Nothing
		If IsObject(m_IdBusinessDetail) Then Set m_IdBusinessDetail = Nothing
		If IsObject(m_comment) Then Set m_comment = Nothing
		If IsObject(m_s_contentemail) Then Set m_s_contentemail = Nothing
		If IsObject(m_numberpeople) Then Set m_numberpeople = Nothing
		If IsObject(m_createddate) Then Set m_createddate = Nothing
		If IsObject(m_zEmail) Then Set m_zEmail = Nothing
		Set RowAttrs = Nothing
	End Sub
End Class
%>
