<%

' ASPMaker configuration for Table View_Paid_OrdersLocal
Dim View_Paid_OrdersLocal

' Define table class
Class cView_Paid_OrdersLocal

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
		Call ew_SetArObj(Fields, "CreationDate", CreationDate)
		Call ew_SetArObj(Fields, "OrderDate", OrderDate)
		Call ew_SetArObj(Fields, "DeliveryType", DeliveryType)
		Call ew_SetArObj(Fields, "DeliveryTime", DeliveryTime)
		Call ew_SetArObj(Fields, "PaymentType", PaymentType)
		Call ew_SetArObj(Fields, "SubTotal", SubTotal)
		Call ew_SetArObj(Fields, "ShippingFee", ShippingFee)
		Call ew_SetArObj(Fields, "OrderTotal", OrderTotal)
		Call ew_SetArObj(Fields, "IdBusinessDetail", IdBusinessDetail)
		Call ew_SetArObj(Fields, "SessionId", SessionId)
		Call ew_SetArObj(Fields, "FirstName", FirstName)
		Call ew_SetArObj(Fields, "LastName", LastName)
		Call ew_SetArObj(Fields, "zEmail", zEmail)
		Call ew_SetArObj(Fields, "Phone", Phone)
		Call ew_SetArObj(Fields, "Address", Address)
		Call ew_SetArObj(Fields, "PostalCode", PostalCode)
		Call ew_SetArObj(Fields, "Notes", Notes)
		Call ew_SetArObj(Fields, "ttest", ttest)
		Call ew_SetArObj(Fields, "cancelleddate", cancelleddate)
		Call ew_SetArObj(Fields, "cancelledby", cancelledby)
		Call ew_SetArObj(Fields, "cancelledreason", cancelledreason)
		Call ew_SetArObj(Fields, "acknowledgeddate", acknowledgeddate)
		Call ew_SetArObj(Fields, "delivereddate", delivereddate)
		Call ew_SetArObj(Fields, "cancelled", cancelled)
		Call ew_SetArObj(Fields, "acknowledged", acknowledged)
		Call ew_SetArObj(Fields, "outfordelivery", outfordelivery)
		Call ew_SetArObj(Fields, "vouchercodediscount", vouchercodediscount)
		Call ew_SetArObj(Fields, "vouchercode", vouchercode)
		Call ew_SetArObj(Fields, "printed", printed)
		Call ew_SetArObj(Fields, "deliverydistance", deliverydistance)
		Call ew_SetArObj(Fields, "asaporder", asaporder)
		Call ew_SetArObj(Fields, "DeliveryLat", DeliveryLat)
		Call ew_SetArObj(Fields, "DeliveryLng", DeliveryLng)
		Call ew_SetArObj(Fields, "ServiceCharge", ServiceCharge)
		Call ew_SetArObj(Fields, "PaymentSurcharge", PaymentSurcharge)
		Call ew_SetArObj(Fields, "Tax_Rate", Tax_Rate)
		Call ew_SetArObj(Fields, "Tax_Amount", Tax_Amount)
		Call ew_SetArObj(Fields, "Tip_Rate", Tip_Rate)
		Call ew_SetArObj(Fields, "Tip_Amount", Tip_Amount)
		Call ew_SetArObj(Fields, "Payment_Status", Payment_Status)
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
		TableVar = "View_Paid_OrdersLocal"
	End Property

	' Table name
	Public Property Get TableName()
		TableName = "View_Paid_OrdersLocal"
	End Property

	' Table type
	Public Property Get TableType()
		TableType = "VIEW"
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
		HighlightName = "View_Paid_OrdersLocal_Highlight"
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
		SqlSelect = ew_IIf(zSqlSelect & "" <> "", zSqlSelect, "SELECT * FROM [dbo].[View_Paid_OrdersLocal]")
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
		SqlKeyFilter = ""
	End Property

	' Return Key filter for table
	Public Property Get KeyFilter()
		Dim sKeyFilter
		sKeyFilter = SqlKeyFilter
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
			ReturnUrl = "View_Paid_OrdersLocallist.asp"
		End If
	End Property

	' List url
	Public Function ListUrl()
		ListUrl = "View_Paid_OrdersLocallist.asp"
	End Function

	' View url
	Public Function ViewUrl(parm)
		If parm <> "" Then
			ViewUrl = KeyUrl("View_Paid_OrdersLocalview.asp", UrlParm(parm))
		Else
			ViewUrl = KeyUrl("View_Paid_OrdersLocalview.asp", UrlParm(EW_TABLE_SHOW_DETAIL & "="))
		End If
	End Function

	' Add url
	Public Function AddUrl(parm)
		If parm <> "" Then
			AddUrl = "View_Paid_OrdersLocaladd.asp?" & UrlParm(parm)
		Else
			AddUrl = "View_Paid_OrdersLocaladd.asp"
		End If
	End Function

	' Edit url
	Public Function EditUrl(parm)
		EditUrl = KeyUrl("View_Paid_OrdersLocaledit.asp", UrlParm(parm))
	End Function

	' Inline edit url
	Public Function InlineEditUrl()
		InlineEditUrl = KeyUrl(ew_CurrentPage, UrlParm("a=edit"))
	End Function

	' Copy url
	Public Function CopyUrl(parm)
		CopyUrl = KeyUrl("View_Paid_OrdersLocaladd.asp", UrlParm(parm))
	End Function

	' Inline copy url
	Public Function InlineCopyUrl()
		InlineCopyUrl = KeyUrl(ew_CurrentPage, UrlParm("a=copy"))
	End Function

	' Delete url
	Public Function DeleteUrl()
		DeleteUrl = KeyUrl("View_Paid_OrdersLocaldelete.asp", UrlParm(""))
	End Function

	' Key url
	Public Function KeyUrl(url, parm)
		Dim sUrl: sUrl = url & "?"
		If parm <> "" Then sUrl = sUrl & parm & "&"
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
			UrlParm = "t=View_Paid_OrdersLocal"
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
		CreationDate.DbValue = RsRow("CreationDate")
		OrderDate.DbValue = RsRow("OrderDate")
		DeliveryType.DbValue = RsRow("DeliveryType")
		DeliveryTime.DbValue = RsRow("DeliveryTime")
		PaymentType.DbValue = RsRow("PaymentType")
		SubTotal.DbValue = RsRow("SubTotal")
		ShippingFee.DbValue = RsRow("ShippingFee")
		OrderTotal.DbValue = RsRow("OrderTotal")
		IdBusinessDetail.DbValue = RsRow("IdBusinessDetail")
		SessionId.DbValue = RsRow("SessionId")
		FirstName.DbValue = RsRow("FirstName")
		LastName.DbValue = RsRow("LastName")
		zEmail.DbValue = RsRow("Email")
		Phone.DbValue = RsRow("Phone")
		Address.DbValue = RsRow("Address")
		PostalCode.DbValue = RsRow("PostalCode")
		Notes.DbValue = RsRow("Notes")
		ttest.DbValue = RsRow("ttest")
		cancelleddate.DbValue = RsRow("cancelleddate")
		cancelledby.DbValue = RsRow("cancelledby")
		cancelledreason.DbValue = RsRow("cancelledreason")
		acknowledgeddate.DbValue = RsRow("acknowledgeddate")
		delivereddate.DbValue = RsRow("delivereddate")
		cancelled.DbValue = RsRow("cancelled")
		acknowledged.DbValue = RsRow("acknowledged")
		outfordelivery.DbValue = RsRow("outfordelivery")
		vouchercodediscount.DbValue = RsRow("vouchercodediscount")
		vouchercode.DbValue = RsRow("vouchercode")
		printed.DbValue = RsRow("printed")
		deliverydistance.DbValue = RsRow("deliverydistance")
		asaporder.DbValue = RsRow("asaporder")
		DeliveryLat.DbValue = RsRow("DeliveryLat")
		DeliveryLng.DbValue = RsRow("DeliveryLng")
		ServiceCharge.DbValue = RsRow("ServiceCharge")
		PaymentSurcharge.DbValue = RsRow("PaymentSurcharge")
		Tax_Rate.DbValue = RsRow("Tax_Rate")
		Tax_Amount.DbValue = RsRow("Tax_Amount")
		Tip_Rate.DbValue = RsRow("Tip_Rate")
		Tip_Amount.DbValue = RsRow("Tip_Amount")
		Payment_Status.DbValue = RsRow("Payment_Status")
	End Sub

	' Render list row values
	Sub RenderListRow()

		'
		'  Common render codes
		'
		' ID
		' CreationDate
		' OrderDate
		' DeliveryType
		' DeliveryTime
		' PaymentType
		' SubTotal
		' ShippingFee
		' OrderTotal
		' IdBusinessDetail
		' SessionId
		' FirstName
		' LastName
		' Email
		' Phone
		' Address
		' PostalCode
		' Notes
		' ttest
		' cancelleddate
		' cancelledby
		' cancelledreason
		' acknowledgeddate
		' delivereddate
		' cancelled
		' acknowledged
		' outfordelivery
		' vouchercodediscount
		' vouchercode
		' printed
		' deliverydistance
		' asaporder
		' DeliveryLat
		' DeliveryLng
		' ServiceCharge
		' PaymentSurcharge
		' Tax_Rate
		' Tax_Amount
		' Tip_Rate
		' Tip_Amount
		' Payment_Status
		' Call Row Rendering event

		Call Row_Rendering()

		'
		'  Render for View
		'
		' ID

		ID.ViewValue = ID.CurrentValue
		ID.ViewCustomAttributes = ""

		' CreationDate
		CreationDate.ViewValue = CreationDate.CurrentValue
		CreationDate.ViewCustomAttributes = ""

		' OrderDate
		OrderDate.ViewValue = OrderDate.CurrentValue
		OrderDate.ViewCustomAttributes = ""

		' DeliveryType
		DeliveryType.ViewValue = DeliveryType.CurrentValue
		DeliveryType.ViewCustomAttributes = ""

		' DeliveryTime
		DeliveryTime.ViewValue = DeliveryTime.CurrentValue
		DeliveryTime.ViewCustomAttributes = ""

		' PaymentType
		PaymentType.ViewValue = PaymentType.CurrentValue
		PaymentType.ViewCustomAttributes = ""

		' SubTotal
		SubTotal.ViewValue = SubTotal.CurrentValue
		SubTotal.ViewCustomAttributes = ""

		' ShippingFee
		ShippingFee.ViewValue = ShippingFee.CurrentValue
		ShippingFee.ViewCustomAttributes = ""

		' OrderTotal
		OrderTotal.ViewValue = OrderTotal.CurrentValue
		OrderTotal.ViewCustomAttributes = ""

		' IdBusinessDetail
		IdBusinessDetail.ViewValue = IdBusinessDetail.CurrentValue
		IdBusinessDetail.ViewCustomAttributes = ""

		' SessionId
		SessionId.ViewValue = SessionId.CurrentValue
		SessionId.ViewCustomAttributes = ""

		' FirstName
		FirstName.ViewValue = FirstName.CurrentValue
		FirstName.ViewCustomAttributes = ""

		' LastName
		LastName.ViewValue = LastName.CurrentValue
		LastName.ViewCustomAttributes = ""

		' Email
		zEmail.ViewValue = zEmail.CurrentValue
		zEmail.ViewCustomAttributes = ""

		' Phone
		Phone.ViewValue = Phone.CurrentValue
		Phone.ViewCustomAttributes = ""

		' Address
		Address.ViewValue = Address.CurrentValue
		Address.ViewCustomAttributes = ""

		' PostalCode
		PostalCode.ViewValue = PostalCode.CurrentValue
		PostalCode.ViewCustomAttributes = ""

		' Notes
		Notes.ViewValue = Notes.CurrentValue
		Notes.ViewCustomAttributes = ""

		' ttest
		ttest.ViewValue = ttest.CurrentValue
		ttest.ViewCustomAttributes = ""

		' cancelleddate
		cancelleddate.ViewValue = cancelleddate.CurrentValue
		cancelleddate.ViewCustomAttributes = ""

		' cancelledby
		cancelledby.ViewValue = cancelledby.CurrentValue
		cancelledby.ViewCustomAttributes = ""

		' cancelledreason
		cancelledreason.ViewValue = cancelledreason.CurrentValue
		cancelledreason.ViewCustomAttributes = ""

		' acknowledgeddate
		acknowledgeddate.ViewValue = acknowledgeddate.CurrentValue
		acknowledgeddate.ViewCustomAttributes = ""

		' delivereddate
		delivereddate.ViewValue = delivereddate.CurrentValue
		delivereddate.ViewCustomAttributes = ""

		' cancelled
		cancelled.ViewValue = cancelled.CurrentValue
		cancelled.ViewCustomAttributes = ""

		' acknowledged
		acknowledged.ViewValue = acknowledged.CurrentValue
		acknowledged.ViewCustomAttributes = ""

		' outfordelivery
		outfordelivery.ViewValue = outfordelivery.CurrentValue
		outfordelivery.ViewCustomAttributes = ""

		' vouchercodediscount
		vouchercodediscount.ViewValue = vouchercodediscount.CurrentValue
		vouchercodediscount.ViewCustomAttributes = ""

		' vouchercode
		vouchercode.ViewValue = vouchercode.CurrentValue
		vouchercode.ViewCustomAttributes = ""

		' printed
		printed.ViewValue = printed.CurrentValue
		printed.ViewCustomAttributes = ""

		' deliverydistance
		deliverydistance.ViewValue = deliverydistance.CurrentValue
		deliverydistance.ViewCustomAttributes = ""

		' asaporder
		asaporder.ViewValue = asaporder.CurrentValue
		asaporder.ViewCustomAttributes = ""

		' DeliveryLat
		DeliveryLat.ViewValue = DeliveryLat.CurrentValue
		DeliveryLat.ViewCustomAttributes = ""

		' DeliveryLng
		DeliveryLng.ViewValue = DeliveryLng.CurrentValue
		DeliveryLng.ViewCustomAttributes = ""

		' ServiceCharge
		ServiceCharge.ViewValue = ServiceCharge.CurrentValue
		ServiceCharge.ViewCustomAttributes = ""

		' PaymentSurcharge
		PaymentSurcharge.ViewValue = PaymentSurcharge.CurrentValue
		PaymentSurcharge.ViewCustomAttributes = ""

		' Tax_Rate
		Tax_Rate.ViewValue = Tax_Rate.CurrentValue
		Tax_Rate.ViewCustomAttributes = ""

		' Tax_Amount
		Tax_Amount.ViewValue = Tax_Amount.CurrentValue
		Tax_Amount.ViewCustomAttributes = ""

		' Tip_Rate
		Tip_Rate.ViewValue = Tip_Rate.CurrentValue
		Tip_Rate.ViewCustomAttributes = ""

		' Tip_Amount
		Tip_Amount.ViewValue = Tip_Amount.CurrentValue
		Tip_Amount.ViewCustomAttributes = ""

		' Payment_Status
		Payment_Status.ViewValue = Payment_Status.CurrentValue
		Payment_Status.ViewCustomAttributes = ""

		' ID
		ID.LinkCustomAttributes = ""
		ID.HrefValue = ""
		ID.TooltipValue = ""

		' CreationDate
		CreationDate.LinkCustomAttributes = ""
		CreationDate.HrefValue = ""
		CreationDate.TooltipValue = ""

		' OrderDate
		OrderDate.LinkCustomAttributes = ""
		OrderDate.HrefValue = ""
		OrderDate.TooltipValue = ""

		' DeliveryType
		DeliveryType.LinkCustomAttributes = ""
		DeliveryType.HrefValue = ""
		DeliveryType.TooltipValue = ""

		' DeliveryTime
		DeliveryTime.LinkCustomAttributes = ""
		DeliveryTime.HrefValue = ""
		DeliveryTime.TooltipValue = ""

		' PaymentType
		PaymentType.LinkCustomAttributes = ""
		PaymentType.HrefValue = ""
		PaymentType.TooltipValue = ""

		' SubTotal
		SubTotal.LinkCustomAttributes = ""
		SubTotal.HrefValue = ""
		SubTotal.TooltipValue = ""

		' ShippingFee
		ShippingFee.LinkCustomAttributes = ""
		ShippingFee.HrefValue = ""
		ShippingFee.TooltipValue = ""

		' OrderTotal
		OrderTotal.LinkCustomAttributes = ""
		OrderTotal.HrefValue = ""
		OrderTotal.TooltipValue = ""

		' IdBusinessDetail
		IdBusinessDetail.LinkCustomAttributes = ""
		IdBusinessDetail.HrefValue = ""
		IdBusinessDetail.TooltipValue = ""

		' SessionId
		SessionId.LinkCustomAttributes = ""
		SessionId.HrefValue = ""
		SessionId.TooltipValue = ""

		' FirstName
		FirstName.LinkCustomAttributes = ""
		FirstName.HrefValue = ""
		FirstName.TooltipValue = ""

		' LastName
		LastName.LinkCustomAttributes = ""
		LastName.HrefValue = ""
		LastName.TooltipValue = ""

		' Email
		zEmail.LinkCustomAttributes = ""
		zEmail.HrefValue = ""
		zEmail.TooltipValue = ""

		' Phone
		Phone.LinkCustomAttributes = ""
		Phone.HrefValue = ""
		Phone.TooltipValue = ""

		' Address
		Address.LinkCustomAttributes = ""
		Address.HrefValue = ""
		Address.TooltipValue = ""

		' PostalCode
		PostalCode.LinkCustomAttributes = ""
		PostalCode.HrefValue = ""
		PostalCode.TooltipValue = ""

		' Notes
		Notes.LinkCustomAttributes = ""
		Notes.HrefValue = ""
		Notes.TooltipValue = ""

		' ttest
		ttest.LinkCustomAttributes = ""
		ttest.HrefValue = ""
		ttest.TooltipValue = ""

		' cancelleddate
		cancelleddate.LinkCustomAttributes = ""
		cancelleddate.HrefValue = ""
		cancelleddate.TooltipValue = ""

		' cancelledby
		cancelledby.LinkCustomAttributes = ""
		cancelledby.HrefValue = ""
		cancelledby.TooltipValue = ""

		' cancelledreason
		cancelledreason.LinkCustomAttributes = ""
		cancelledreason.HrefValue = ""
		cancelledreason.TooltipValue = ""

		' acknowledgeddate
		acknowledgeddate.LinkCustomAttributes = ""
		acknowledgeddate.HrefValue = ""
		acknowledgeddate.TooltipValue = ""

		' delivereddate
		delivereddate.LinkCustomAttributes = ""
		delivereddate.HrefValue = ""
		delivereddate.TooltipValue = ""

		' cancelled
		cancelled.LinkCustomAttributes = ""
		cancelled.HrefValue = ""
		cancelled.TooltipValue = ""

		' acknowledged
		acknowledged.LinkCustomAttributes = ""
		acknowledged.HrefValue = ""
		acknowledged.TooltipValue = ""

		' outfordelivery
		outfordelivery.LinkCustomAttributes = ""
		outfordelivery.HrefValue = ""
		outfordelivery.TooltipValue = ""

		' vouchercodediscount
		vouchercodediscount.LinkCustomAttributes = ""
		vouchercodediscount.HrefValue = ""
		vouchercodediscount.TooltipValue = ""

		' vouchercode
		vouchercode.LinkCustomAttributes = ""
		vouchercode.HrefValue = ""
		vouchercode.TooltipValue = ""

		' printed
		printed.LinkCustomAttributes = ""
		printed.HrefValue = ""
		printed.TooltipValue = ""

		' deliverydistance
		deliverydistance.LinkCustomAttributes = ""
		deliverydistance.HrefValue = ""
		deliverydistance.TooltipValue = ""

		' asaporder
		asaporder.LinkCustomAttributes = ""
		asaporder.HrefValue = ""
		asaporder.TooltipValue = ""

		' DeliveryLat
		DeliveryLat.LinkCustomAttributes = ""
		DeliveryLat.HrefValue = ""
		DeliveryLat.TooltipValue = ""

		' DeliveryLng
		DeliveryLng.LinkCustomAttributes = ""
		DeliveryLng.HrefValue = ""
		DeliveryLng.TooltipValue = ""

		' ServiceCharge
		ServiceCharge.LinkCustomAttributes = ""
		ServiceCharge.HrefValue = ""
		ServiceCharge.TooltipValue = ""

		' PaymentSurcharge
		PaymentSurcharge.LinkCustomAttributes = ""
		PaymentSurcharge.HrefValue = ""
		PaymentSurcharge.TooltipValue = ""

		' Tax_Rate
		Tax_Rate.LinkCustomAttributes = ""
		Tax_Rate.HrefValue = ""
		Tax_Rate.TooltipValue = ""

		' Tax_Amount
		Tax_Amount.LinkCustomAttributes = ""
		Tax_Amount.HrefValue = ""
		Tax_Amount.TooltipValue = ""

		' Tip_Rate
		Tip_Rate.LinkCustomAttributes = ""
		Tip_Rate.HrefValue = ""
		Tip_Rate.TooltipValue = ""

		' Tip_Amount
		Tip_Amount.LinkCustomAttributes = ""
		Tip_Amount.HrefValue = ""
		Tip_Amount.TooltipValue = ""

		' Payment_Status
		Payment_Status.LinkCustomAttributes = ""
		Payment_Status.HrefValue = ""
		Payment_Status.TooltipValue = ""

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
		ID.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(ID.FldCaption))

		' CreationDate
		CreationDate.EditAttrs.UpdateAttribute "class", "form-control"
		CreationDate.EditCustomAttributes = ""
		CreationDate.EditValue = CreationDate.CurrentValue
		CreationDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(CreationDate.FldCaption))

		' OrderDate
		OrderDate.EditAttrs.UpdateAttribute "class", "form-control"
		OrderDate.EditCustomAttributes = ""
		OrderDate.EditValue = OrderDate.CurrentValue
		OrderDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderDate.FldCaption))

		' DeliveryType
		DeliveryType.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryType.EditCustomAttributes = ""
		DeliveryType.EditValue = DeliveryType.CurrentValue
		DeliveryType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryType.FldCaption))

		' DeliveryTime
		DeliveryTime.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryTime.EditCustomAttributes = ""
		DeliveryTime.EditValue = DeliveryTime.CurrentValue
		DeliveryTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryTime.FldCaption))

		' PaymentType
		PaymentType.EditAttrs.UpdateAttribute "class", "form-control"
		PaymentType.EditCustomAttributes = ""
		PaymentType.EditValue = PaymentType.CurrentValue
		PaymentType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PaymentType.FldCaption))

		' SubTotal
		SubTotal.EditAttrs.UpdateAttribute "class", "form-control"
		SubTotal.EditCustomAttributes = ""
		SubTotal.EditValue = SubTotal.CurrentValue
		SubTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SubTotal.FldCaption))
		If SubTotal.EditValue&"" <> "" And IsNumeric(SubTotal.EditValue) Then SubTotal.EditValue = ew_FormatNumber2(SubTotal.EditValue, -2)

		' ShippingFee
		ShippingFee.EditAttrs.UpdateAttribute "class", "form-control"
		ShippingFee.EditCustomAttributes = ""
		ShippingFee.EditValue = ShippingFee.CurrentValue
		ShippingFee.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(ShippingFee.FldCaption))
		If ShippingFee.EditValue&"" <> "" And IsNumeric(ShippingFee.EditValue) Then ShippingFee.EditValue = ew_FormatNumber2(ShippingFee.EditValue, -2)

		' OrderTotal
		OrderTotal.EditAttrs.UpdateAttribute "class", "form-control"
		OrderTotal.EditCustomAttributes = ""
		OrderTotal.EditValue = OrderTotal.CurrentValue
		OrderTotal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(OrderTotal.FldCaption))
		If OrderTotal.EditValue&"" <> "" And IsNumeric(OrderTotal.EditValue) Then OrderTotal.EditValue = ew_FormatNumber2(OrderTotal.EditValue, -2)

		' IdBusinessDetail
		IdBusinessDetail.EditAttrs.UpdateAttribute "class", "form-control"
		IdBusinessDetail.EditCustomAttributes = ""
		IdBusinessDetail.EditValue = IdBusinessDetail.CurrentValue
		IdBusinessDetail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(IdBusinessDetail.FldCaption))

		' SessionId
		SessionId.EditAttrs.UpdateAttribute "class", "form-control"
		SessionId.EditCustomAttributes = ""
		SessionId.EditValue = SessionId.CurrentValue
		SessionId.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SessionId.FldCaption))

		' FirstName
		FirstName.EditAttrs.UpdateAttribute "class", "form-control"
		FirstName.EditCustomAttributes = ""
		FirstName.EditValue = FirstName.CurrentValue
		FirstName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(FirstName.FldCaption))

		' LastName
		LastName.EditAttrs.UpdateAttribute "class", "form-control"
		LastName.EditCustomAttributes = ""
		LastName.EditValue = LastName.CurrentValue
		LastName.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(LastName.FldCaption))

		' Email
		zEmail.EditAttrs.UpdateAttribute "class", "form-control"
		zEmail.EditCustomAttributes = ""
		zEmail.EditValue = zEmail.CurrentValue
		zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(zEmail.FldCaption))

		' Phone
		Phone.EditAttrs.UpdateAttribute "class", "form-control"
		Phone.EditCustomAttributes = ""
		Phone.EditValue = Phone.CurrentValue
		Phone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Phone.FldCaption))

		' Address
		Address.EditAttrs.UpdateAttribute "class", "form-control"
		Address.EditCustomAttributes = ""
		Address.EditValue = Address.CurrentValue
		Address.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Address.FldCaption))

		' PostalCode
		PostalCode.EditAttrs.UpdateAttribute "class", "form-control"
		PostalCode.EditCustomAttributes = ""
		PostalCode.EditValue = PostalCode.CurrentValue
		PostalCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PostalCode.FldCaption))

		' Notes
		Notes.EditAttrs.UpdateAttribute "class", "form-control"
		Notes.EditCustomAttributes = ""
		Notes.EditValue = Notes.CurrentValue
		Notes.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Notes.FldCaption))

		' ttest
		ttest.EditAttrs.UpdateAttribute "class", "form-control"
		ttest.EditCustomAttributes = ""
		ttest.EditValue = ttest.CurrentValue
		ttest.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(ttest.FldCaption))

		' cancelleddate
		cancelleddate.EditAttrs.UpdateAttribute "class", "form-control"
		cancelleddate.EditCustomAttributes = ""
		cancelleddate.EditValue = cancelleddate.CurrentValue
		cancelleddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(cancelleddate.FldCaption))

		' cancelledby
		cancelledby.EditAttrs.UpdateAttribute "class", "form-control"
		cancelledby.EditCustomAttributes = ""
		cancelledby.EditValue = cancelledby.CurrentValue
		cancelledby.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(cancelledby.FldCaption))

		' cancelledreason
		cancelledreason.EditAttrs.UpdateAttribute "class", "form-control"
		cancelledreason.EditCustomAttributes = ""
		cancelledreason.EditValue = cancelledreason.CurrentValue
		cancelledreason.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(cancelledreason.FldCaption))

		' acknowledgeddate
		acknowledgeddate.EditAttrs.UpdateAttribute "class", "form-control"
		acknowledgeddate.EditCustomAttributes = ""
		acknowledgeddate.EditValue = acknowledgeddate.CurrentValue
		acknowledgeddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(acknowledgeddate.FldCaption))

		' delivereddate
		delivereddate.EditAttrs.UpdateAttribute "class", "form-control"
		delivereddate.EditCustomAttributes = ""
		delivereddate.EditValue = delivereddate.CurrentValue
		delivereddate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(delivereddate.FldCaption))

		' cancelled
		cancelled.EditAttrs.UpdateAttribute "class", "form-control"
		cancelled.EditCustomAttributes = ""
		cancelled.EditValue = cancelled.CurrentValue
		cancelled.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(cancelled.FldCaption))

		' acknowledged
		acknowledged.EditAttrs.UpdateAttribute "class", "form-control"
		acknowledged.EditCustomAttributes = ""
		acknowledged.EditValue = acknowledged.CurrentValue
		acknowledged.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(acknowledged.FldCaption))

		' outfordelivery
		outfordelivery.EditAttrs.UpdateAttribute "class", "form-control"
		outfordelivery.EditCustomAttributes = ""
		outfordelivery.EditValue = outfordelivery.CurrentValue
		outfordelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(outfordelivery.FldCaption))

		' vouchercodediscount
		vouchercodediscount.EditAttrs.UpdateAttribute "class", "form-control"
		vouchercodediscount.EditCustomAttributes = ""
		vouchercodediscount.EditValue = vouchercodediscount.CurrentValue
		vouchercodediscount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercodediscount.FldCaption))

		' vouchercode
		vouchercode.EditAttrs.UpdateAttribute "class", "form-control"
		vouchercode.EditCustomAttributes = ""
		vouchercode.EditValue = vouchercode.CurrentValue
		vouchercode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(vouchercode.FldCaption))

		' printed
		printed.EditAttrs.UpdateAttribute "class", "form-control"
		printed.EditCustomAttributes = ""
		printed.EditValue = printed.CurrentValue
		printed.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(printed.FldCaption))

		' deliverydistance
		deliverydistance.EditAttrs.UpdateAttribute "class", "form-control"
		deliverydistance.EditCustomAttributes = ""
		deliverydistance.EditValue = deliverydistance.CurrentValue
		deliverydistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(deliverydistance.FldCaption))

		' asaporder
		asaporder.EditAttrs.UpdateAttribute "class", "form-control"
		asaporder.EditCustomAttributes = ""
		asaporder.EditValue = asaporder.CurrentValue
		asaporder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(asaporder.FldCaption))

		' DeliveryLat
		DeliveryLat.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryLat.EditCustomAttributes = ""
		DeliveryLat.EditValue = DeliveryLat.CurrentValue
		DeliveryLat.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryLat.FldCaption))

		' DeliveryLng
		DeliveryLng.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryLng.EditCustomAttributes = ""
		DeliveryLng.EditValue = DeliveryLng.CurrentValue
		DeliveryLng.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryLng.FldCaption))

		' ServiceCharge
		ServiceCharge.EditAttrs.UpdateAttribute "class", "form-control"
		ServiceCharge.EditCustomAttributes = ""
		ServiceCharge.EditValue = ServiceCharge.CurrentValue
		ServiceCharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(ServiceCharge.FldCaption))
		If ServiceCharge.EditValue&"" <> "" And IsNumeric(ServiceCharge.EditValue) Then ServiceCharge.EditValue = ew_FormatNumber2(ServiceCharge.EditValue, -2)

		' PaymentSurcharge
		PaymentSurcharge.EditAttrs.UpdateAttribute "class", "form-control"
		PaymentSurcharge.EditCustomAttributes = ""
		PaymentSurcharge.EditValue = PaymentSurcharge.CurrentValue
		PaymentSurcharge.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PaymentSurcharge.FldCaption))
		If PaymentSurcharge.EditValue&"" <> "" And IsNumeric(PaymentSurcharge.EditValue) Then PaymentSurcharge.EditValue = ew_FormatNumber2(PaymentSurcharge.EditValue, -2)

		' Tax_Rate
		Tax_Rate.EditAttrs.UpdateAttribute "class", "form-control"
		Tax_Rate.EditCustomAttributes = ""
		Tax_Rate.EditValue = Tax_Rate.CurrentValue
		Tax_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Tax_Rate.FldCaption))

		' Tax_Amount
		Tax_Amount.EditAttrs.UpdateAttribute "class", "form-control"
		Tax_Amount.EditCustomAttributes = ""
		Tax_Amount.EditValue = Tax_Amount.CurrentValue
		Tax_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Tax_Amount.FldCaption))
		If Tax_Amount.EditValue&"" <> "" And IsNumeric(Tax_Amount.EditValue) Then Tax_Amount.EditValue = ew_FormatNumber2(Tax_Amount.EditValue, -2)

		' Tip_Rate
		Tip_Rate.EditAttrs.UpdateAttribute "class", "form-control"
		Tip_Rate.EditCustomAttributes = ""
		Tip_Rate.EditValue = Tip_Rate.CurrentValue
		Tip_Rate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Tip_Rate.FldCaption))

		' Tip_Amount
		Tip_Amount.EditAttrs.UpdateAttribute "class", "form-control"
		Tip_Amount.EditCustomAttributes = ""
		Tip_Amount.EditValue = Tip_Amount.CurrentValue
		Tip_Amount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Tip_Amount.FldCaption))
		If Tip_Amount.EditValue&"" <> "" And IsNumeric(Tip_Amount.EditValue) Then Tip_Amount.EditValue = ew_FormatNumber2(Tip_Amount.EditValue, -2)

		' Payment_Status
		Payment_Status.EditAttrs.UpdateAttribute "class", "form-control"
		Payment_Status.EditCustomAttributes = ""
		Payment_Status.EditValue = Payment_Status.CurrentValue
		Payment_Status.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Payment_Status.FldCaption))

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
					Call XmlDoc.AddField("CreationDate", CreationDate.ExportValue(Export))
					Call XmlDoc.AddField("OrderDate", OrderDate.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryType", DeliveryType.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryTime", DeliveryTime.ExportValue(Export))
					Call XmlDoc.AddField("PaymentType", PaymentType.ExportValue(Export))
					Call XmlDoc.AddField("SubTotal", SubTotal.ExportValue(Export))
					Call XmlDoc.AddField("ShippingFee", ShippingFee.ExportValue(Export))
					Call XmlDoc.AddField("OrderTotal", OrderTotal.ExportValue(Export))
					Call XmlDoc.AddField("IdBusinessDetail", IdBusinessDetail.ExportValue(Export))
					Call XmlDoc.AddField("SessionId", SessionId.ExportValue(Export))
					Call XmlDoc.AddField("FirstName", FirstName.ExportValue(Export))
					Call XmlDoc.AddField("LastName", LastName.ExportValue(Export))
					Call XmlDoc.AddField("zEmail", zEmail.ExportValue(Export))
					Call XmlDoc.AddField("Phone", Phone.ExportValue(Export))
					Call XmlDoc.AddField("Address", Address.ExportValue(Export))
					Call XmlDoc.AddField("PostalCode", PostalCode.ExportValue(Export))
					Call XmlDoc.AddField("Notes", Notes.ExportValue(Export))
					Call XmlDoc.AddField("ttest", ttest.ExportValue(Export))
					Call XmlDoc.AddField("cancelleddate", cancelleddate.ExportValue(Export))
					Call XmlDoc.AddField("cancelledby", cancelledby.ExportValue(Export))
					Call XmlDoc.AddField("cancelledreason", cancelledreason.ExportValue(Export))
					Call XmlDoc.AddField("acknowledgeddate", acknowledgeddate.ExportValue(Export))
					Call XmlDoc.AddField("delivereddate", delivereddate.ExportValue(Export))
					Call XmlDoc.AddField("cancelled", cancelled.ExportValue(Export))
					Call XmlDoc.AddField("acknowledged", acknowledged.ExportValue(Export))
					Call XmlDoc.AddField("outfordelivery", outfordelivery.ExportValue(Export))
					Call XmlDoc.AddField("vouchercodediscount", vouchercodediscount.ExportValue(Export))
					Call XmlDoc.AddField("vouchercode", vouchercode.ExportValue(Export))
					Call XmlDoc.AddField("printed", printed.ExportValue(Export))
					Call XmlDoc.AddField("deliverydistance", deliverydistance.ExportValue(Export))
					Call XmlDoc.AddField("asaporder", asaporder.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryLat", DeliveryLat.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryLng", DeliveryLng.ExportValue(Export))
					Call XmlDoc.AddField("ServiceCharge", ServiceCharge.ExportValue(Export))
					Call XmlDoc.AddField("PaymentSurcharge", PaymentSurcharge.ExportValue(Export))
					Call XmlDoc.AddField("Tax_Rate", Tax_Rate.ExportValue(Export))
					Call XmlDoc.AddField("Tax_Amount", Tax_Amount.ExportValue(Export))
					Call XmlDoc.AddField("Tip_Rate", Tip_Rate.ExportValue(Export))
					Call XmlDoc.AddField("Tip_Amount", Tip_Amount.ExportValue(Export))
					Call XmlDoc.AddField("Payment_Status", Payment_Status.ExportValue(Export))
				Else
					Call XmlDoc.AddField("ID", ID.ExportValue(Export))
					Call XmlDoc.AddField("CreationDate", CreationDate.ExportValue(Export))
					Call XmlDoc.AddField("OrderDate", OrderDate.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryType", DeliveryType.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryTime", DeliveryTime.ExportValue(Export))
					Call XmlDoc.AddField("PaymentType", PaymentType.ExportValue(Export))
					Call XmlDoc.AddField("SubTotal", SubTotal.ExportValue(Export))
					Call XmlDoc.AddField("ShippingFee", ShippingFee.ExportValue(Export))
					Call XmlDoc.AddField("OrderTotal", OrderTotal.ExportValue(Export))
					Call XmlDoc.AddField("IdBusinessDetail", IdBusinessDetail.ExportValue(Export))
					Call XmlDoc.AddField("SessionId", SessionId.ExportValue(Export))
					Call XmlDoc.AddField("FirstName", FirstName.ExportValue(Export))
					Call XmlDoc.AddField("LastName", LastName.ExportValue(Export))
					Call XmlDoc.AddField("zEmail", zEmail.ExportValue(Export))
					Call XmlDoc.AddField("Phone", Phone.ExportValue(Export))
					Call XmlDoc.AddField("Address", Address.ExportValue(Export))
					Call XmlDoc.AddField("PostalCode", PostalCode.ExportValue(Export))
					Call XmlDoc.AddField("Notes", Notes.ExportValue(Export))
					Call XmlDoc.AddField("ttest", ttest.ExportValue(Export))
					Call XmlDoc.AddField("cancelleddate", cancelleddate.ExportValue(Export))
					Call XmlDoc.AddField("cancelledby", cancelledby.ExportValue(Export))
					Call XmlDoc.AddField("cancelledreason", cancelledreason.ExportValue(Export))
					Call XmlDoc.AddField("acknowledgeddate", acknowledgeddate.ExportValue(Export))
					Call XmlDoc.AddField("delivereddate", delivereddate.ExportValue(Export))
					Call XmlDoc.AddField("cancelled", cancelled.ExportValue(Export))
					Call XmlDoc.AddField("acknowledged", acknowledged.ExportValue(Export))
					Call XmlDoc.AddField("outfordelivery", outfordelivery.ExportValue(Export))
					Call XmlDoc.AddField("vouchercodediscount", vouchercodediscount.ExportValue(Export))
					Call XmlDoc.AddField("vouchercode", vouchercode.ExportValue(Export))
					Call XmlDoc.AddField("printed", printed.ExportValue(Export))
					Call XmlDoc.AddField("deliverydistance", deliverydistance.ExportValue(Export))
					Call XmlDoc.AddField("asaporder", asaporder.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryLat", DeliveryLat.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryLng", DeliveryLng.ExportValue(Export))
					Call XmlDoc.AddField("ServiceCharge", ServiceCharge.ExportValue(Export))
					Call XmlDoc.AddField("PaymentSurcharge", PaymentSurcharge.ExportValue(Export))
					Call XmlDoc.AddField("Tax_Rate", Tax_Rate.ExportValue(Export))
					Call XmlDoc.AddField("Tax_Amount", Tax_Amount.ExportValue(Export))
					Call XmlDoc.AddField("Tip_Rate", Tip_Rate.ExportValue(Export))
					Call XmlDoc.AddField("Tip_Amount", Tip_Amount.ExportValue(Export))
					Call XmlDoc.AddField("Payment_Status", Payment_Status.ExportValue(Export))
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
					If CreationDate.Exportable Then Call Doc.ExportCaption(CreationDate)
					If OrderDate.Exportable Then Call Doc.ExportCaption(OrderDate)
					If DeliveryType.Exportable Then Call Doc.ExportCaption(DeliveryType)
					If DeliveryTime.Exportable Then Call Doc.ExportCaption(DeliveryTime)
					If PaymentType.Exportable Then Call Doc.ExportCaption(PaymentType)
					If SubTotal.Exportable Then Call Doc.ExportCaption(SubTotal)
					If ShippingFee.Exportable Then Call Doc.ExportCaption(ShippingFee)
					If OrderTotal.Exportable Then Call Doc.ExportCaption(OrderTotal)
					If IdBusinessDetail.Exportable Then Call Doc.ExportCaption(IdBusinessDetail)
					If SessionId.Exportable Then Call Doc.ExportCaption(SessionId)
					If FirstName.Exportable Then Call Doc.ExportCaption(FirstName)
					If LastName.Exportable Then Call Doc.ExportCaption(LastName)
					If zEmail.Exportable Then Call Doc.ExportCaption(zEmail)
					If Phone.Exportable Then Call Doc.ExportCaption(Phone)
					If Address.Exportable Then Call Doc.ExportCaption(Address)
					If PostalCode.Exportable Then Call Doc.ExportCaption(PostalCode)
					If Notes.Exportable Then Call Doc.ExportCaption(Notes)
					If ttest.Exportable Then Call Doc.ExportCaption(ttest)
					If cancelleddate.Exportable Then Call Doc.ExportCaption(cancelleddate)
					If cancelledby.Exportable Then Call Doc.ExportCaption(cancelledby)
					If cancelledreason.Exportable Then Call Doc.ExportCaption(cancelledreason)
					If acknowledgeddate.Exportable Then Call Doc.ExportCaption(acknowledgeddate)
					If delivereddate.Exportable Then Call Doc.ExportCaption(delivereddate)
					If cancelled.Exportable Then Call Doc.ExportCaption(cancelled)
					If acknowledged.Exportable Then Call Doc.ExportCaption(acknowledged)
					If outfordelivery.Exportable Then Call Doc.ExportCaption(outfordelivery)
					If vouchercodediscount.Exportable Then Call Doc.ExportCaption(vouchercodediscount)
					If vouchercode.Exportable Then Call Doc.ExportCaption(vouchercode)
					If printed.Exportable Then Call Doc.ExportCaption(printed)
					If deliverydistance.Exportable Then Call Doc.ExportCaption(deliverydistance)
					If asaporder.Exportable Then Call Doc.ExportCaption(asaporder)
					If DeliveryLat.Exportable Then Call Doc.ExportCaption(DeliveryLat)
					If DeliveryLng.Exportable Then Call Doc.ExportCaption(DeliveryLng)
					If ServiceCharge.Exportable Then Call Doc.ExportCaption(ServiceCharge)
					If PaymentSurcharge.Exportable Then Call Doc.ExportCaption(PaymentSurcharge)
					If Tax_Rate.Exportable Then Call Doc.ExportCaption(Tax_Rate)
					If Tax_Amount.Exportable Then Call Doc.ExportCaption(Tax_Amount)
					If Tip_Rate.Exportable Then Call Doc.ExportCaption(Tip_Rate)
					If Tip_Amount.Exportable Then Call Doc.ExportCaption(Tip_Amount)
					If Payment_Status.Exportable Then Call Doc.ExportCaption(Payment_Status)
				Else
					If ID.Exportable Then Call Doc.ExportCaption(ID)
					If CreationDate.Exportable Then Call Doc.ExportCaption(CreationDate)
					If OrderDate.Exportable Then Call Doc.ExportCaption(OrderDate)
					If DeliveryType.Exportable Then Call Doc.ExportCaption(DeliveryType)
					If DeliveryTime.Exportable Then Call Doc.ExportCaption(DeliveryTime)
					If PaymentType.Exportable Then Call Doc.ExportCaption(PaymentType)
					If SubTotal.Exportable Then Call Doc.ExportCaption(SubTotal)
					If ShippingFee.Exportable Then Call Doc.ExportCaption(ShippingFee)
					If OrderTotal.Exportable Then Call Doc.ExportCaption(OrderTotal)
					If IdBusinessDetail.Exportable Then Call Doc.ExportCaption(IdBusinessDetail)
					If SessionId.Exportable Then Call Doc.ExportCaption(SessionId)
					If FirstName.Exportable Then Call Doc.ExportCaption(FirstName)
					If LastName.Exportable Then Call Doc.ExportCaption(LastName)
					If zEmail.Exportable Then Call Doc.ExportCaption(zEmail)
					If Phone.Exportable Then Call Doc.ExportCaption(Phone)
					If Address.Exportable Then Call Doc.ExportCaption(Address)
					If PostalCode.Exportable Then Call Doc.ExportCaption(PostalCode)
					If Notes.Exportable Then Call Doc.ExportCaption(Notes)
					If ttest.Exportable Then Call Doc.ExportCaption(ttest)
					If cancelleddate.Exportable Then Call Doc.ExportCaption(cancelleddate)
					If cancelledby.Exportable Then Call Doc.ExportCaption(cancelledby)
					If cancelledreason.Exportable Then Call Doc.ExportCaption(cancelledreason)
					If acknowledgeddate.Exportable Then Call Doc.ExportCaption(acknowledgeddate)
					If delivereddate.Exportable Then Call Doc.ExportCaption(delivereddate)
					If cancelled.Exportable Then Call Doc.ExportCaption(cancelled)
					If acknowledged.Exportable Then Call Doc.ExportCaption(acknowledged)
					If outfordelivery.Exportable Then Call Doc.ExportCaption(outfordelivery)
					If vouchercodediscount.Exportable Then Call Doc.ExportCaption(vouchercodediscount)
					If vouchercode.Exportable Then Call Doc.ExportCaption(vouchercode)
					If printed.Exportable Then Call Doc.ExportCaption(printed)
					If deliverydistance.Exportable Then Call Doc.ExportCaption(deliverydistance)
					If asaporder.Exportable Then Call Doc.ExportCaption(asaporder)
					If DeliveryLat.Exportable Then Call Doc.ExportCaption(DeliveryLat)
					If DeliveryLng.Exportable Then Call Doc.ExportCaption(DeliveryLng)
					If ServiceCharge.Exportable Then Call Doc.ExportCaption(ServiceCharge)
					If PaymentSurcharge.Exportable Then Call Doc.ExportCaption(PaymentSurcharge)
					If Tax_Rate.Exportable Then Call Doc.ExportCaption(Tax_Rate)
					If Tax_Amount.Exportable Then Call Doc.ExportCaption(Tax_Amount)
					If Tip_Rate.Exportable Then Call Doc.ExportCaption(Tip_Rate)
					If Tip_Amount.Exportable Then Call Doc.ExportCaption(Tip_Amount)
					If Payment_Status.Exportable Then Call Doc.ExportCaption(Payment_Status)
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
						If CreationDate.Exportable Then Call Doc.ExportField(CreationDate)
						If OrderDate.Exportable Then Call Doc.ExportField(OrderDate)
						If DeliveryType.Exportable Then Call Doc.ExportField(DeliveryType)
						If DeliveryTime.Exportable Then Call Doc.ExportField(DeliveryTime)
						If PaymentType.Exportable Then Call Doc.ExportField(PaymentType)
						If SubTotal.Exportable Then Call Doc.ExportField(SubTotal)
						If ShippingFee.Exportable Then Call Doc.ExportField(ShippingFee)
						If OrderTotal.Exportable Then Call Doc.ExportField(OrderTotal)
						If IdBusinessDetail.Exportable Then Call Doc.ExportField(IdBusinessDetail)
						If SessionId.Exportable Then Call Doc.ExportField(SessionId)
						If FirstName.Exportable Then Call Doc.ExportField(FirstName)
						If LastName.Exportable Then Call Doc.ExportField(LastName)
						If zEmail.Exportable Then Call Doc.ExportField(zEmail)
						If Phone.Exportable Then Call Doc.ExportField(Phone)
						If Address.Exportable Then Call Doc.ExportField(Address)
						If PostalCode.Exportable Then Call Doc.ExportField(PostalCode)
						If Notes.Exportable Then Call Doc.ExportField(Notes)
						If ttest.Exportable Then Call Doc.ExportField(ttest)
						If cancelleddate.Exportable Then Call Doc.ExportField(cancelleddate)
						If cancelledby.Exportable Then Call Doc.ExportField(cancelledby)
						If cancelledreason.Exportable Then Call Doc.ExportField(cancelledreason)
						If acknowledgeddate.Exportable Then Call Doc.ExportField(acknowledgeddate)
						If delivereddate.Exportable Then Call Doc.ExportField(delivereddate)
						If cancelled.Exportable Then Call Doc.ExportField(cancelled)
						If acknowledged.Exportable Then Call Doc.ExportField(acknowledged)
						If outfordelivery.Exportable Then Call Doc.ExportField(outfordelivery)
						If vouchercodediscount.Exportable Then Call Doc.ExportField(vouchercodediscount)
						If vouchercode.Exportable Then Call Doc.ExportField(vouchercode)
						If printed.Exportable Then Call Doc.ExportField(printed)
						If deliverydistance.Exportable Then Call Doc.ExportField(deliverydistance)
						If asaporder.Exportable Then Call Doc.ExportField(asaporder)
						If DeliveryLat.Exportable Then Call Doc.ExportField(DeliveryLat)
						If DeliveryLng.Exportable Then Call Doc.ExportField(DeliveryLng)
						If ServiceCharge.Exportable Then Call Doc.ExportField(ServiceCharge)
						If PaymentSurcharge.Exportable Then Call Doc.ExportField(PaymentSurcharge)
						If Tax_Rate.Exportable Then Call Doc.ExportField(Tax_Rate)
						If Tax_Amount.Exportable Then Call Doc.ExportField(Tax_Amount)
						If Tip_Rate.Exportable Then Call Doc.ExportField(Tip_Rate)
						If Tip_Amount.Exportable Then Call Doc.ExportField(Tip_Amount)
						If Payment_Status.Exportable Then Call Doc.ExportField(Payment_Status)
					Else
						If ID.Exportable Then Call Doc.ExportField(ID)
						If CreationDate.Exportable Then Call Doc.ExportField(CreationDate)
						If OrderDate.Exportable Then Call Doc.ExportField(OrderDate)
						If DeliveryType.Exportable Then Call Doc.ExportField(DeliveryType)
						If DeliveryTime.Exportable Then Call Doc.ExportField(DeliveryTime)
						If PaymentType.Exportable Then Call Doc.ExportField(PaymentType)
						If SubTotal.Exportable Then Call Doc.ExportField(SubTotal)
						If ShippingFee.Exportable Then Call Doc.ExportField(ShippingFee)
						If OrderTotal.Exportable Then Call Doc.ExportField(OrderTotal)
						If IdBusinessDetail.Exportable Then Call Doc.ExportField(IdBusinessDetail)
						If SessionId.Exportable Then Call Doc.ExportField(SessionId)
						If FirstName.Exportable Then Call Doc.ExportField(FirstName)
						If LastName.Exportable Then Call Doc.ExportField(LastName)
						If zEmail.Exportable Then Call Doc.ExportField(zEmail)
						If Phone.Exportable Then Call Doc.ExportField(Phone)
						If Address.Exportable Then Call Doc.ExportField(Address)
						If PostalCode.Exportable Then Call Doc.ExportField(PostalCode)
						If Notes.Exportable Then Call Doc.ExportField(Notes)
						If ttest.Exportable Then Call Doc.ExportField(ttest)
						If cancelleddate.Exportable Then Call Doc.ExportField(cancelleddate)
						If cancelledby.Exportable Then Call Doc.ExportField(cancelledby)
						If cancelledreason.Exportable Then Call Doc.ExportField(cancelledreason)
						If acknowledgeddate.Exportable Then Call Doc.ExportField(acknowledgeddate)
						If delivereddate.Exportable Then Call Doc.ExportField(delivereddate)
						If cancelled.Exportable Then Call Doc.ExportField(cancelled)
						If acknowledged.Exportable Then Call Doc.ExportField(acknowledged)
						If outfordelivery.Exportable Then Call Doc.ExportField(outfordelivery)
						If vouchercodediscount.Exportable Then Call Doc.ExportField(vouchercodediscount)
						If vouchercode.Exportable Then Call Doc.ExportField(vouchercode)
						If printed.Exportable Then Call Doc.ExportField(printed)
						If deliverydistance.Exportable Then Call Doc.ExportField(deliverydistance)
						If asaporder.Exportable Then Call Doc.ExportField(asaporder)
						If DeliveryLat.Exportable Then Call Doc.ExportField(DeliveryLat)
						If DeliveryLng.Exportable Then Call Doc.ExportField(DeliveryLng)
						If ServiceCharge.Exportable Then Call Doc.ExportField(ServiceCharge)
						If PaymentSurcharge.Exportable Then Call Doc.ExportField(PaymentSurcharge)
						If Tax_Rate.Exportable Then Call Doc.ExportField(Tax_Rate)
						If Tax_Amount.Exportable Then Call Doc.ExportField(Tax_Amount)
						If Tip_Rate.Exportable Then Call Doc.ExportField(Tip_Rate)
						If Tip_Amount.Exportable Then Call Doc.ExportField(Tip_Amount)
						If Payment_Status.Exportable Then Call Doc.ExportField(Payment_Status)
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
			Set m_ID = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_ID", "ID", "[ID]", "CAST([ID] AS NVARCHAR)", 3, 0, "[ID]", False, False, FALSE, "FORMATTED TEXT")
			m_ID.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set ID = m_ID
	End Property

	' Field CreationDate
	Private m_CreationDate

	Public Property Get CreationDate()
		If Not IsObject(m_CreationDate) Then
			Set m_CreationDate = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_CreationDate", "CreationDate", "[CreationDate]", "(STR(YEAR([CreationDate]),4,0) + '/' + REPLACE(STR(MONTH([CreationDate]),2,0),' ','0') + '/' + REPLACE(STR(DAY([CreationDate]),2,0),' ','0'))", 135, 9, "[CreationDate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set CreationDate = m_CreationDate
	End Property

	' Field OrderDate
	Private m_OrderDate

	Public Property Get OrderDate()
		If Not IsObject(m_OrderDate) Then
			Set m_OrderDate = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_OrderDate", "OrderDate", "[OrderDate]", "(STR(YEAR([OrderDate]),4,0) + '/' + REPLACE(STR(MONTH([OrderDate]),2,0),' ','0') + '/' + REPLACE(STR(DAY([OrderDate]),2,0),' ','0'))", 135, 9, "[OrderDate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set OrderDate = m_OrderDate
	End Property

	' Field DeliveryType
	Private m_DeliveryType

	Public Property Get DeliveryType()
		If Not IsObject(m_DeliveryType) Then
			Set m_DeliveryType = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_DeliveryType", "DeliveryType", "[DeliveryType]", "[DeliveryType]", 202, 0, "[DeliveryType]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set DeliveryType = m_DeliveryType
	End Property

	' Field DeliveryTime
	Private m_DeliveryTime

	Public Property Get DeliveryTime()
		If Not IsObject(m_DeliveryTime) Then
			Set m_DeliveryTime = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_DeliveryTime", "DeliveryTime", "[DeliveryTime]", "(STR(YEAR([DeliveryTime]),4,0) + '/' + REPLACE(STR(MONTH([DeliveryTime]),2,0),' ','0') + '/' + REPLACE(STR(DAY([DeliveryTime]),2,0),' ','0'))", 135, 9, "[DeliveryTime]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set DeliveryTime = m_DeliveryTime
	End Property

	' Field PaymentType
	Private m_PaymentType

	Public Property Get PaymentType()
		If Not IsObject(m_PaymentType) Then
			Set m_PaymentType = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_PaymentType", "PaymentType", "[PaymentType]", "[PaymentType]", 202, 0, "[PaymentType]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set PaymentType = m_PaymentType
	End Property

	' Field SubTotal
	Private m_SubTotal

	Public Property Get SubTotal()
		If Not IsObject(m_SubTotal) Then
			Set m_SubTotal = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_SubTotal", "SubTotal", "[SubTotal]", "CAST([SubTotal] AS NVARCHAR)", 6, 0, "[SubTotal]", False, False, FALSE, "FORMATTED TEXT")
			m_SubTotal.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set SubTotal = m_SubTotal
	End Property

	' Field ShippingFee
	Private m_ShippingFee

	Public Property Get ShippingFee()
		If Not IsObject(m_ShippingFee) Then
			Set m_ShippingFee = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_ShippingFee", "ShippingFee", "[ShippingFee]", "CAST([ShippingFee] AS NVARCHAR)", 6, 0, "[ShippingFee]", False, False, FALSE, "FORMATTED TEXT")
			m_ShippingFee.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set ShippingFee = m_ShippingFee
	End Property

	' Field OrderTotal
	Private m_OrderTotal

	Public Property Get OrderTotal()
		If Not IsObject(m_OrderTotal) Then
			Set m_OrderTotal = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_OrderTotal", "OrderTotal", "[OrderTotal]", "CAST([OrderTotal] AS NVARCHAR)", 6, 0, "[OrderTotal]", False, False, FALSE, "FORMATTED TEXT")
			m_OrderTotal.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set OrderTotal = m_OrderTotal
	End Property

	' Field IdBusinessDetail
	Private m_IdBusinessDetail

	Public Property Get IdBusinessDetail()
		If Not IsObject(m_IdBusinessDetail) Then
			Set m_IdBusinessDetail = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_IdBusinessDetail", "IdBusinessDetail", "[IdBusinessDetail]", "CAST([IdBusinessDetail] AS NVARCHAR)", 3, 0, "[IdBusinessDetail]", False, False, FALSE, "FORMATTED TEXT")
			m_IdBusinessDetail.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set IdBusinessDetail = m_IdBusinessDetail
	End Property

	' Field SessionId
	Private m_SessionId

	Public Property Get SessionId()
		If Not IsObject(m_SessionId) Then
			Set m_SessionId = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_SessionId", "SessionId", "[SessionId]", "[SessionId]", 202, 0, "[SessionId]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SessionId = m_SessionId
	End Property

	' Field FirstName
	Private m_FirstName

	Public Property Get FirstName()
		If Not IsObject(m_FirstName) Then
			Set m_FirstName = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_FirstName", "FirstName", "[FirstName]", "[FirstName]", 202, 0, "[FirstName]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set FirstName = m_FirstName
	End Property

	' Field LastName
	Private m_LastName

	Public Property Get LastName()
		If Not IsObject(m_LastName) Then
			Set m_LastName = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_LastName", "LastName", "[LastName]", "[LastName]", 202, 0, "[LastName]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set LastName = m_LastName
	End Property

	' Field Email
	Private m_zEmail

	Public Property Get zEmail()
		If Not IsObject(m_zEmail) Then
			Set m_zEmail = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_zEmail", "Email", "[Email]", "[Email]", 202, 0, "[Email]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set zEmail = m_zEmail
	End Property

	' Field Phone
	Private m_Phone

	Public Property Get Phone()
		If Not IsObject(m_Phone) Then
			Set m_Phone = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_Phone", "Phone", "[Phone]", "[Phone]", 202, 0, "[Phone]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Phone = m_Phone
	End Property

	' Field Address
	Private m_Address

	Public Property Get Address()
		If Not IsObject(m_Address) Then
			Set m_Address = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_Address", "Address", "[Address]", "[Address]", 202, 0, "[Address]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Address = m_Address
	End Property

	' Field PostalCode
	Private m_PostalCode

	Public Property Get PostalCode()
		If Not IsObject(m_PostalCode) Then
			Set m_PostalCode = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_PostalCode", "PostalCode", "[PostalCode]", "[PostalCode]", 202, 0, "[PostalCode]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set PostalCode = m_PostalCode
	End Property

	' Field Notes
	Private m_Notes

	Public Property Get Notes()
		If Not IsObject(m_Notes) Then
			Set m_Notes = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_Notes", "Notes", "[Notes]", "[Notes]", 202, 0, "[Notes]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Notes = m_Notes
	End Property

	' Field ttest
	Private m_ttest

	Public Property Get ttest()
		If Not IsObject(m_ttest) Then
			Set m_ttest = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_ttest", "ttest", "[ttest]", "[ttest]", 202, 0, "[ttest]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set ttest = m_ttest
	End Property

	' Field cancelleddate
	Private m_cancelleddate

	Public Property Get cancelleddate()
		If Not IsObject(m_cancelleddate) Then
			Set m_cancelleddate = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_cancelleddate", "cancelleddate", "[cancelleddate]", "(STR(YEAR([cancelleddate]),4,0) + '/' + REPLACE(STR(MONTH([cancelleddate]),2,0),' ','0') + '/' + REPLACE(STR(DAY([cancelleddate]),2,0),' ','0'))", 135, 9, "[cancelleddate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set cancelleddate = m_cancelleddate
	End Property

	' Field cancelledby
	Private m_cancelledby

	Public Property Get cancelledby()
		If Not IsObject(m_cancelledby) Then
			Set m_cancelledby = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_cancelledby", "cancelledby", "[cancelledby]", "[cancelledby]", 202, 0, "[cancelledby]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set cancelledby = m_cancelledby
	End Property

	' Field cancelledreason
	Private m_cancelledreason

	Public Property Get cancelledreason()
		If Not IsObject(m_cancelledreason) Then
			Set m_cancelledreason = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_cancelledreason", "cancelledreason", "[cancelledreason]", "[cancelledreason]", 202, 0, "[cancelledreason]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set cancelledreason = m_cancelledreason
	End Property

	' Field acknowledgeddate
	Private m_acknowledgeddate

	Public Property Get acknowledgeddate()
		If Not IsObject(m_acknowledgeddate) Then
			Set m_acknowledgeddate = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_acknowledgeddate", "acknowledgeddate", "[acknowledgeddate]", "(STR(YEAR([acknowledgeddate]),4,0) + '/' + REPLACE(STR(MONTH([acknowledgeddate]),2,0),' ','0') + '/' + REPLACE(STR(DAY([acknowledgeddate]),2,0),' ','0'))", 135, 9, "[acknowledgeddate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set acknowledgeddate = m_acknowledgeddate
	End Property

	' Field delivereddate
	Private m_delivereddate

	Public Property Get delivereddate()
		If Not IsObject(m_delivereddate) Then
			Set m_delivereddate = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_delivereddate", "delivereddate", "[delivereddate]", "[delivereddate]", 202, 0, "[delivereddate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set delivereddate = m_delivereddate
	End Property

	' Field cancelled
	Private m_cancelled

	Public Property Get cancelled()
		If Not IsObject(m_cancelled) Then
			Set m_cancelled = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_cancelled", "cancelled", "[cancelled]", "CAST([cancelled] AS NVARCHAR)", 3, 0, "[cancelled]", False, False, FALSE, "FORMATTED TEXT")
			m_cancelled.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set cancelled = m_cancelled
	End Property

	' Field acknowledged
	Private m_acknowledged

	Public Property Get acknowledged()
		If Not IsObject(m_acknowledged) Then
			Set m_acknowledged = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_acknowledged", "acknowledged", "[acknowledged]", "CAST([acknowledged] AS NVARCHAR)", 3, 0, "[acknowledged]", False, False, FALSE, "FORMATTED TEXT")
			m_acknowledged.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set acknowledged = m_acknowledged
	End Property

	' Field outfordelivery
	Private m_outfordelivery

	Public Property Get outfordelivery()
		If Not IsObject(m_outfordelivery) Then
			Set m_outfordelivery = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_outfordelivery", "outfordelivery", "[outfordelivery]", "CAST([outfordelivery] AS NVARCHAR)", 3, 0, "[outfordelivery]", False, False, FALSE, "FORMATTED TEXT")
			m_outfordelivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set outfordelivery = m_outfordelivery
	End Property

	' Field vouchercodediscount
	Private m_vouchercodediscount

	Public Property Get vouchercodediscount()
		If Not IsObject(m_vouchercodediscount) Then
			Set m_vouchercodediscount = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_vouchercodediscount", "vouchercodediscount", "[vouchercodediscount]", "CAST([vouchercodediscount] AS NVARCHAR)", 3, 0, "[vouchercodediscount]", False, False, FALSE, "FORMATTED TEXT")
			m_vouchercodediscount.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set vouchercodediscount = m_vouchercodediscount
	End Property

	' Field vouchercode
	Private m_vouchercode

	Public Property Get vouchercode()
		If Not IsObject(m_vouchercode) Then
			Set m_vouchercode = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_vouchercode", "vouchercode", "[vouchercode]", "[vouchercode]", 202, 0, "[vouchercode]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set vouchercode = m_vouchercode
	End Property

	' Field printed
	Private m_printed

	Public Property Get printed()
		If Not IsObject(m_printed) Then
			Set m_printed = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_printed", "printed", "[printed]", "CAST([printed] AS NVARCHAR)", 3, 0, "[printed]", False, False, FALSE, "FORMATTED TEXT")
			m_printed.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set printed = m_printed
	End Property

	' Field deliverydistance
	Private m_deliverydistance

	Public Property Get deliverydistance()
		If Not IsObject(m_deliverydistance) Then
			Set m_deliverydistance = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_deliverydistance", "deliverydistance", "[deliverydistance]", "[deliverydistance]", 202, 0, "[deliverydistance]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set deliverydistance = m_deliverydistance
	End Property

	' Field asaporder
	Private m_asaporder

	Public Property Get asaporder()
		If Not IsObject(m_asaporder) Then
			Set m_asaporder = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_asaporder", "asaporder", "[asaporder]", "[asaporder]", 202, 0, "[asaporder]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set asaporder = m_asaporder
	End Property

	' Field DeliveryLat
	Private m_DeliveryLat

	Public Property Get DeliveryLat()
		If Not IsObject(m_DeliveryLat) Then
			Set m_DeliveryLat = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_DeliveryLat", "DeliveryLat", "[DeliveryLat]", "[DeliveryLat]", 202, 0, "[DeliveryLat]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set DeliveryLat = m_DeliveryLat
	End Property

	' Field DeliveryLng
	Private m_DeliveryLng

	Public Property Get DeliveryLng()
		If Not IsObject(m_DeliveryLng) Then
			Set m_DeliveryLng = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_DeliveryLng", "DeliveryLng", "[DeliveryLng]", "[DeliveryLng]", 202, 0, "[DeliveryLng]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set DeliveryLng = m_DeliveryLng
	End Property

	' Field ServiceCharge
	Private m_ServiceCharge

	Public Property Get ServiceCharge()
		If Not IsObject(m_ServiceCharge) Then
			Set m_ServiceCharge = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_ServiceCharge", "ServiceCharge", "[ServiceCharge]", "CAST([ServiceCharge] AS NVARCHAR)", 5, 0, "[ServiceCharge]", False, False, FALSE, "FORMATTED TEXT")
			m_ServiceCharge.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set ServiceCharge = m_ServiceCharge
	End Property

	' Field PaymentSurcharge
	Private m_PaymentSurcharge

	Public Property Get PaymentSurcharge()
		If Not IsObject(m_PaymentSurcharge) Then
			Set m_PaymentSurcharge = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_PaymentSurcharge", "PaymentSurcharge", "[PaymentSurcharge]", "CAST([PaymentSurcharge] AS NVARCHAR)", 5, 0, "[PaymentSurcharge]", False, False, FALSE, "FORMATTED TEXT")
			m_PaymentSurcharge.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set PaymentSurcharge = m_PaymentSurcharge
	End Property

	' Field Tax_Rate
	Private m_Tax_Rate

	Public Property Get Tax_Rate()
		If Not IsObject(m_Tax_Rate) Then
			Set m_Tax_Rate = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_Tax_Rate", "Tax_Rate", "[Tax_Rate]", "CAST([Tax_Rate] AS NVARCHAR)", 3, 0, "[Tax_Rate]", False, False, FALSE, "FORMATTED TEXT")
			m_Tax_Rate.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Tax_Rate = m_Tax_Rate
	End Property

	' Field Tax_Amount
	Private m_Tax_Amount

	Public Property Get Tax_Amount()
		If Not IsObject(m_Tax_Amount) Then
			Set m_Tax_Amount = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_Tax_Amount", "Tax_Amount", "[Tax_Amount]", "CAST([Tax_Amount] AS NVARCHAR)", 6, 0, "[Tax_Amount]", False, False, FALSE, "FORMATTED TEXT")
			m_Tax_Amount.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set Tax_Amount = m_Tax_Amount
	End Property

	' Field Tip_Rate
	Private m_Tip_Rate

	Public Property Get Tip_Rate()
		If Not IsObject(m_Tip_Rate) Then
			Set m_Tip_Rate = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_Tip_Rate", "Tip_Rate", "[Tip_Rate]", "[Tip_Rate]", 202, 0, "[Tip_Rate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Tip_Rate = m_Tip_Rate
	End Property

	' Field Tip_Amount
	Private m_Tip_Amount

	Public Property Get Tip_Amount()
		If Not IsObject(m_Tip_Amount) Then
			Set m_Tip_Amount = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_Tip_Amount", "Tip_Amount", "[Tip_Amount]", "CAST([Tip_Amount] AS NVARCHAR)", 6, 0, "[Tip_Amount]", False, False, FALSE, "FORMATTED TEXT")
			m_Tip_Amount.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set Tip_Amount = m_Tip_Amount
	End Property

	' Field Payment_Status
	Private m_Payment_Status

	Public Property Get Payment_Status()
		If Not IsObject(m_Payment_Status) Then
			Set m_Payment_Status = NewFldObj("View_Paid_OrdersLocal", "View_Paid_OrdersLocal", "x_Payment_Status", "Payment_Status", "[Payment_Status]", "[Payment_Status]", 202, 0, "[Payment_Status]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Payment_Status = m_Payment_Status
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
		If IsObject(m_CreationDate) Then Set m_CreationDate = Nothing
		If IsObject(m_OrderDate) Then Set m_OrderDate = Nothing
		If IsObject(m_DeliveryType) Then Set m_DeliveryType = Nothing
		If IsObject(m_DeliveryTime) Then Set m_DeliveryTime = Nothing
		If IsObject(m_PaymentType) Then Set m_PaymentType = Nothing
		If IsObject(m_SubTotal) Then Set m_SubTotal = Nothing
		If IsObject(m_ShippingFee) Then Set m_ShippingFee = Nothing
		If IsObject(m_OrderTotal) Then Set m_OrderTotal = Nothing
		If IsObject(m_IdBusinessDetail) Then Set m_IdBusinessDetail = Nothing
		If IsObject(m_SessionId) Then Set m_SessionId = Nothing
		If IsObject(m_FirstName) Then Set m_FirstName = Nothing
		If IsObject(m_LastName) Then Set m_LastName = Nothing
		If IsObject(m_zEmail) Then Set m_zEmail = Nothing
		If IsObject(m_Phone) Then Set m_Phone = Nothing
		If IsObject(m_Address) Then Set m_Address = Nothing
		If IsObject(m_PostalCode) Then Set m_PostalCode = Nothing
		If IsObject(m_Notes) Then Set m_Notes = Nothing
		If IsObject(m_ttest) Then Set m_ttest = Nothing
		If IsObject(m_cancelleddate) Then Set m_cancelleddate = Nothing
		If IsObject(m_cancelledby) Then Set m_cancelledby = Nothing
		If IsObject(m_cancelledreason) Then Set m_cancelledreason = Nothing
		If IsObject(m_acknowledgeddate) Then Set m_acknowledgeddate = Nothing
		If IsObject(m_delivereddate) Then Set m_delivereddate = Nothing
		If IsObject(m_cancelled) Then Set m_cancelled = Nothing
		If IsObject(m_acknowledged) Then Set m_acknowledged = Nothing
		If IsObject(m_outfordelivery) Then Set m_outfordelivery = Nothing
		If IsObject(m_vouchercodediscount) Then Set m_vouchercodediscount = Nothing
		If IsObject(m_vouchercode) Then Set m_vouchercode = Nothing
		If IsObject(m_printed) Then Set m_printed = Nothing
		If IsObject(m_deliverydistance) Then Set m_deliverydistance = Nothing
		If IsObject(m_asaporder) Then Set m_asaporder = Nothing
		If IsObject(m_DeliveryLat) Then Set m_DeliveryLat = Nothing
		If IsObject(m_DeliveryLng) Then Set m_DeliveryLng = Nothing
		If IsObject(m_ServiceCharge) Then Set m_ServiceCharge = Nothing
		If IsObject(m_PaymentSurcharge) Then Set m_PaymentSurcharge = Nothing
		If IsObject(m_Tax_Rate) Then Set m_Tax_Rate = Nothing
		If IsObject(m_Tax_Amount) Then Set m_Tax_Amount = Nothing
		If IsObject(m_Tip_Rate) Then Set m_Tip_Rate = Nothing
		If IsObject(m_Tip_Amount) Then Set m_Tip_Amount = Nothing
		If IsObject(m_Payment_Status) Then Set m_Payment_Status = Nothing
		Set RowAttrs = Nothing
	End Sub
End Class
%>
