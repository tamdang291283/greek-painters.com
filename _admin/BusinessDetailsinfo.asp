<%

' ASPMaker configuration for Table BusinessDetails
Dim BusinessDetails

' Define table class
Class cBusinessDetails

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
		Call ew_SetArObj(Fields, "Address", Address)
		Call ew_SetArObj(Fields, "PostalCode", PostalCode)
		Call ew_SetArObj(Fields, "FoodType", FoodType)
		Call ew_SetArObj(Fields, "DeliveryMinAmount", DeliveryMinAmount)
		Call ew_SetArObj(Fields, "DeliveryMaxDistance", DeliveryMaxDistance)
		Call ew_SetArObj(Fields, "DeliveryFreeDistance", DeliveryFreeDistance)
		Call ew_SetArObj(Fields, "AverageDeliveryTime", AverageDeliveryTime)
		Call ew_SetArObj(Fields, "AverageCollectionTime", AverageCollectionTime)
		Call ew_SetArObj(Fields, "DeliveryFee", DeliveryFee)
		Call ew_SetArObj(Fields, "ImgUrl", ImgUrl)
		Call ew_SetArObj(Fields, "Telephone", Telephone)
		Call ew_SetArObj(Fields, "zEmail", zEmail)
		Call ew_SetArObj(Fields, "pswd", pswd)
		Call ew_SetArObj(Fields, "businessclosed", businessclosed)
		Call ew_SetArObj(Fields, "announcement", announcement)
		Call ew_SetArObj(Fields, "css", css)
		Call ew_SetArObj(Fields, "SMTP_AUTENTICATE", SMTP_AUTENTICATE)
		Call ew_SetArObj(Fields, "MAIL_FROM", MAIL_FROM)
		Call ew_SetArObj(Fields, "PAYPAL_URL", PAYPAL_URL)
		Call ew_SetArObj(Fields, "PAYPAL_PDT", PAYPAL_PDT)
		Call ew_SetArObj(Fields, "SMTP_PASSWORD", SMTP_PASSWORD)
		Call ew_SetArObj(Fields, "GMAP_API_KEY", GMAP_API_KEY)
		Call ew_SetArObj(Fields, "SMTP_USERNAME", SMTP_USERNAME)
		Call ew_SetArObj(Fields, "SMTP_USESSL", SMTP_USESSL)
		Call ew_SetArObj(Fields, "MAIL_SUBJECT", MAIL_SUBJECT)
		Call ew_SetArObj(Fields, "CURRENCYSYMBOL", CURRENCYSYMBOL)
		Call ew_SetArObj(Fields, "SMTP_SERVER", SMTP_SERVER)
		Call ew_SetArObj(Fields, "CREDITCARDSURCHARGE", CREDITCARDSURCHARGE)
		Call ew_SetArObj(Fields, "SMTP_PORT", SMTP_PORT)
		Call ew_SetArObj(Fields, "STICK_MENU", STICK_MENU)
		Call ew_SetArObj(Fields, "MAIL_CUSTOMER_SUBJECT", MAIL_CUSTOMER_SUBJECT)
		Call ew_SetArObj(Fields, "CONFIRMATION_EMAIL_ADDRESS", CONFIRMATION_EMAIL_ADDRESS)
		Call ew_SetArObj(Fields, "SEND_ORDERS_TO_PRINTER", SEND_ORDERS_TO_PRINTER)
		Call ew_SetArObj(Fields, "timezone", timezone)
		Call ew_SetArObj(Fields, "PAYPAL_ADDR", PAYPAL_ADDR)
		Call ew_SetArObj(Fields, "nochex", nochex)
		Call ew_SetArObj(Fields, "nochexmerchantid", nochexmerchantid)
		Call ew_SetArObj(Fields, "paypal", paypal)
		Call ew_SetArObj(Fields, "IBT_API_KEY", IBT_API_KEY)
		Call ew_SetArObj(Fields, "IBP_API_PASSWORD", IBP_API_PASSWORD)
		Call ew_SetArObj(Fields, "disable_delivery", disable_delivery)
		Call ew_SetArObj(Fields, "disable_collection", disable_collection)
		Call ew_SetArObj(Fields, "worldpay", worldpay)
		Call ew_SetArObj(Fields, "worldpaymerchantid", worldpaymerchantid)
		Call ew_SetArObj(Fields, "backtohometext", backtohometext)
		Call ew_SetArObj(Fields, "closedtext", closedtext)
		Call ew_SetArObj(Fields, "DeliveryChargeOverrideByOrderValue", DeliveryChargeOverrideByOrderValue)
		Call ew_SetArObj(Fields, "individualpostcodes", individualpostcodes)
		Call ew_SetArObj(Fields, "individualpostcodeschecking", individualpostcodeschecking)
		Call ew_SetArObj(Fields, "longitude", longitude)
		Call ew_SetArObj(Fields, "latitude", latitude)
		Call ew_SetArObj(Fields, "googleecommercetracking", googleecommercetracking)
		Call ew_SetArObj(Fields, "googleecommercetrackingcode", googleecommercetrackingcode)
		Call ew_SetArObj(Fields, "bringg", bringg)
		Call ew_SetArObj(Fields, "bringgurl", bringgurl)
		Call ew_SetArObj(Fields, "bringgcompanyid", bringgcompanyid)
		Call ew_SetArObj(Fields, "orderonlywhenopen", orderonlywhenopen)
		Call ew_SetArObj(Fields, "disablelaterdelivery", disablelaterdelivery)
		Call ew_SetArObj(Fields, "menupagetext", menupagetext)
		Call ew_SetArObj(Fields, "ordertodayonly", ordertodayonly)
		Call ew_SetArObj(Fields, "mileskm", mileskm)
		Call ew_SetArObj(Fields, "worldpaylive", worldpaylive)
		Call ew_SetArObj(Fields, "worldpayinstallationid", worldpayinstallationid)
		Call ew_SetArObj(Fields, "DistanceCalMethod", DistanceCalMethod)
		Call ew_SetArObj(Fields, "PrinterIDList", PrinterIDList)
		Call ew_SetArObj(Fields, "EpsonJSPrinterURL", EpsonJSPrinterURL)
		Call ew_SetArObj(Fields, "SMSEnable", SMSEnable)
		Call ew_SetArObj(Fields, "SMSOnDelivery", SMSOnDelivery)
		Call ew_SetArObj(Fields, "SMSSupplierDomain", SMSSupplierDomain)
		Call ew_SetArObj(Fields, "SMSOnOrder", SMSOnOrder)
		Call ew_SetArObj(Fields, "SMSOnOrderAfterMin", SMSOnOrderAfterMin)
		Call ew_SetArObj(Fields, "SMSOnOrderContent", SMSOnOrderContent)
		Call ew_SetArObj(Fields, "DefaultSMSCountryCode", DefaultSMSCountryCode)
		Call ew_SetArObj(Fields, "MinimumAmountForCardPayment", MinimumAmountForCardPayment)
		Call ew_SetArObj(Fields, "FavIconUrl", FavIconUrl)
		Call ew_SetArObj(Fields, "AddToHomeScreenURL", AddToHomeScreenURL)
		Call ew_SetArObj(Fields, "SMSOnAcknowledgement", SMSOnAcknowledgement)
		Call ew_SetArObj(Fields, "LocalPrinterURL", LocalPrinterURL)
		Call ew_SetArObj(Fields, "ShowRestaurantDetailOnReceipt", ShowRestaurantDetailOnReceipt)
		Call ew_SetArObj(Fields, "PrinterFontSizeRatio", PrinterFontSizeRatio)
		Call ew_SetArObj(Fields, "ServiceChargePercentage", ServiceChargePercentage)
		Call ew_SetArObj(Fields, "InRestaurantServiceChargeOnly", InRestaurantServiceChargeOnly)
		Call ew_SetArObj(Fields, "IsDualReceiptPrinting", IsDualReceiptPrinting)
		Call ew_SetArObj(Fields, "PrintingFontSize", PrintingFontSize)
		Call ew_SetArObj(Fields, "InRestaurantEpsonPrinterIDList", InRestaurantEpsonPrinterIDList)
		Call ew_SetArObj(Fields, "BlockIPEmailList", BlockIPEmailList)
		Call ew_SetArObj(Fields, "inmenuannouncement", inmenuannouncement)
		Call ew_SetArObj(Fields, "RePrintReceiptWays", RePrintReceiptWays)
		Call ew_SetArObj(Fields, "printingtype", printingtype)
		Call ew_SetArObj(Fields, "Stripe_Key_Secret", Stripe_Key_Secret)
		Call ew_SetArObj(Fields, "Stripe", Stripe)
		Call ew_SetArObj(Fields, "Stripe_Api_Key", Stripe_Api_Key)
		Call ew_SetArObj(Fields, "EnableBooking", EnableBooking)
		Call ew_SetArObj(Fields, "URL_Facebook", URL_Facebook)
		Call ew_SetArObj(Fields, "URL_Twitter", URL_Twitter)
		Call ew_SetArObj(Fields, "URL_Google", URL_Google)
		Call ew_SetArObj(Fields, "URL_Intagram", URL_Intagram)
		Call ew_SetArObj(Fields, "URL_YouTube", URL_YouTube)
		Call ew_SetArObj(Fields, "URL_Tripadvisor", URL_Tripadvisor)
		Call ew_SetArObj(Fields, "URL_Special_Offer", URL_Special_Offer)
		Call ew_SetArObj(Fields, "URL_Linkin", URL_Linkin)
		Call ew_SetArObj(Fields, "Currency_PAYPAL", Currency_PAYPAL)
		Call ew_SetArObj(Fields, "Currency_STRIPE", Currency_STRIPE)
		Call ew_SetArObj(Fields, "Currency_WOLRDPAY", Currency_WOLRDPAY)
		Call ew_SetArObj(Fields, "Tip_percent", Tip_percent)
		Call ew_SetArObj(Fields, "Tax_Percent", Tax_Percent)
		Call ew_SetArObj(Fields, "InRestaurantTaxChargeOnly", InRestaurantTaxChargeOnly)
		Call ew_SetArObj(Fields, "InRestaurantTipChargeOnly", InRestaurantTipChargeOnly)
		Call ew_SetArObj(Fields, "isCheckCapcha", isCheckCapcha)
		Call ew_SetArObj(Fields, "Close_StartDate", Close_StartDate)
		Call ew_SetArObj(Fields, "Close_EndDate", Close_EndDate)
		Call ew_SetArObj(Fields, "Stripe_Country", Stripe_Country)
		Call ew_SetArObj(Fields, "enable_StripePaymentButton", enable_StripePaymentButton)
		Call ew_SetArObj(Fields, "enable_CashPayment", enable_CashPayment)
		Call ew_SetArObj(Fields, "DeliveryMile", DeliveryMile)
		Call ew_SetArObj(Fields, "Mon_Delivery", Mon_Delivery)
		Call ew_SetArObj(Fields, "Mon_Collection", Mon_Collection)
		Call ew_SetArObj(Fields, "Tue_Delivery", Tue_Delivery)
		Call ew_SetArObj(Fields, "Tue_Collection", Tue_Collection)
		Call ew_SetArObj(Fields, "Wed_Delivery", Wed_Delivery)
		Call ew_SetArObj(Fields, "Wed_Collection", Wed_Collection)
		Call ew_SetArObj(Fields, "Thu_Delivery", Thu_Delivery)
		Call ew_SetArObj(Fields, "Thu_Collection", Thu_Collection)
		Call ew_SetArObj(Fields, "Fri_Delivery", Fri_Delivery)
		Call ew_SetArObj(Fields, "Fri_Collection", Fri_Collection)
		Call ew_SetArObj(Fields, "Sat_Delivery", Sat_Delivery)
		Call ew_SetArObj(Fields, "Sat_Collection", Sat_Collection)
		Call ew_SetArObj(Fields, "Sun_Delivery", Sun_Delivery)
		Call ew_SetArObj(Fields, "Sun_Collection", Sun_Collection)
		Call ew_SetArObj(Fields, "EnableUrlRewrite", EnableUrlRewrite)
		Call ew_SetArObj(Fields, "DeliveryCostUpTo", DeliveryCostUpTo)
		Call ew_SetArObj(Fields, "DeliveryUptoMile", DeliveryUptoMile)
		Call ew_SetArObj(Fields, "Show_Ordernumner_printer", Show_Ordernumner_printer)
		Call ew_SetArObj(Fields, "Show_Ordernumner_Receipt", Show_Ordernumner_Receipt)
		Call ew_SetArObj(Fields, "Show_Ordernumner_Dashboard", Show_Ordernumner_Dashboard)
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
		TableVar = "BusinessDetails"
	End Property

	' Table name
	Public Property Get TableName()
		TableName = "BusinessDetails"
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
		HighlightName = "BusinessDetails_Highlight"
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
		SqlSelect = ew_IIf(zSqlSelect & "" <> "", zSqlSelect, "SELECT * FROM [dbo].[BusinessDetails]")
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
			ReturnUrl = "BusinessDetailslist.asp"
		End If
	End Property

	' List url
	Public Function ListUrl()
		ListUrl = "BusinessDetailslist.asp"
	End Function

	' View url
	Public Function ViewUrl(parm)
		If parm <> "" Then
			ViewUrl = KeyUrl("BusinessDetailsview.asp", UrlParm(parm))
		Else
			ViewUrl = KeyUrl("BusinessDetailsview.asp", UrlParm(EW_TABLE_SHOW_DETAIL & "="))
		End If
	End Function

	' Add url
	Public Function AddUrl(parm)
		If parm <> "" Then
			AddUrl = "BusinessDetailsadd.asp?" & UrlParm(parm)
		Else
			AddUrl = "BusinessDetailsadd.asp"
		End If
	End Function

	' Edit url
	Public Function EditUrl(parm)
		EditUrl = KeyUrl("BusinessDetailsedit.asp", UrlParm(parm))
	End Function

	' Inline edit url
	Public Function InlineEditUrl()
		InlineEditUrl = KeyUrl(ew_CurrentPage, UrlParm("a=edit"))
	End Function

	' Copy url
	Public Function CopyUrl(parm)
		CopyUrl = KeyUrl("BusinessDetailsadd.asp", UrlParm(parm))
	End Function

	' Inline copy url
	Public Function InlineCopyUrl()
		InlineCopyUrl = KeyUrl(ew_CurrentPage, UrlParm("a=copy"))
	End Function

	' Delete url
	Public Function DeleteUrl()
		DeleteUrl = KeyUrl("BusinessDetailsdelete.asp", UrlParm(""))
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
			UrlParm = "t=BusinessDetails"
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
		Address.DbValue = RsRow("Address")
		PostalCode.DbValue = RsRow("PostalCode")
		FoodType.DbValue = RsRow("FoodType")
		DeliveryMinAmount.DbValue = RsRow("DeliveryMinAmount")
		DeliveryMaxDistance.DbValue = RsRow("DeliveryMaxDistance")
		DeliveryFreeDistance.DbValue = RsRow("DeliveryFreeDistance")
		AverageDeliveryTime.DbValue = RsRow("AverageDeliveryTime")
		AverageCollectionTime.DbValue = RsRow("AverageCollectionTime")
		DeliveryFee.DbValue = RsRow("DeliveryFee")
		ImgUrl.DbValue = RsRow("ImgUrl")
		Telephone.DbValue = RsRow("Telephone")
		zEmail.DbValue = RsRow("Email")
		pswd.DbValue = RsRow("pswd")
		businessclosed.DbValue = RsRow("businessclosed")
		announcement.DbValue = RsRow("announcement")
		css.DbValue = RsRow("css")
		SMTP_AUTENTICATE.DbValue = RsRow("SMTP_AUTENTICATE")
		MAIL_FROM.DbValue = RsRow("MAIL_FROM")
		PAYPAL_URL.DbValue = RsRow("PAYPAL_URL")
		PAYPAL_PDT.DbValue = RsRow("PAYPAL_PDT")
		SMTP_PASSWORD.DbValue = RsRow("SMTP_PASSWORD")
		GMAP_API_KEY.DbValue = RsRow("GMAP_API_KEY")
		SMTP_USERNAME.DbValue = RsRow("SMTP_USERNAME")
		SMTP_USESSL.DbValue = RsRow("SMTP_USESSL")
		MAIL_SUBJECT.DbValue = RsRow("MAIL_SUBJECT")
		CURRENCYSYMBOL.DbValue = RsRow("CURRENCYSYMBOL")
		SMTP_SERVER.DbValue = RsRow("SMTP_SERVER")
		CREDITCARDSURCHARGE.DbValue = RsRow("CREDITCARDSURCHARGE")
		SMTP_PORT.DbValue = RsRow("SMTP_PORT")
		STICK_MENU.DbValue = RsRow("STICK_MENU")
		MAIL_CUSTOMER_SUBJECT.DbValue = RsRow("MAIL_CUSTOMER_SUBJECT")
		CONFIRMATION_EMAIL_ADDRESS.DbValue = RsRow("CONFIRMATION_EMAIL_ADDRESS")
		SEND_ORDERS_TO_PRINTER.DbValue = RsRow("SEND_ORDERS_TO_PRINTER")
		timezone.DbValue = RsRow("timezone")
		PAYPAL_ADDR.DbValue = RsRow("PAYPAL_ADDR")
		nochex.DbValue = RsRow("nochex")
		nochexmerchantid.DbValue = RsRow("nochexmerchantid")
		paypal.DbValue = RsRow("paypal")
		IBT_API_KEY.DbValue = RsRow("IBT_API_KEY")
		IBP_API_PASSWORD.DbValue = RsRow("IBP_API_PASSWORD")
		disable_delivery.DbValue = RsRow("disable_delivery")
		disable_collection.DbValue = RsRow("disable_collection")
		worldpay.DbValue = RsRow("worldpay")
		worldpaymerchantid.DbValue = RsRow("worldpaymerchantid")
		backtohometext.DbValue = RsRow("backtohometext")
		closedtext.DbValue = RsRow("closedtext")
		DeliveryChargeOverrideByOrderValue.DbValue = RsRow("DeliveryChargeOverrideByOrderValue")
		individualpostcodes.DbValue = RsRow("individualpostcodes")
		individualpostcodeschecking.DbValue = RsRow("individualpostcodeschecking")
		longitude.DbValue = RsRow("longitude")
		latitude.DbValue = RsRow("latitude")
		googleecommercetracking.DbValue = RsRow("googleecommercetracking")
		googleecommercetrackingcode.DbValue = RsRow("googleecommercetrackingcode")
		bringg.DbValue = RsRow("bringg")
		bringgurl.DbValue = RsRow("bringgurl")
		bringgcompanyid.DbValue = RsRow("bringgcompanyid")
		orderonlywhenopen.DbValue = RsRow("orderonlywhenopen")
		disablelaterdelivery.DbValue = RsRow("disablelaterdelivery")
		menupagetext.DbValue = RsRow("menupagetext")
		ordertodayonly.DbValue = RsRow("ordertodayonly")
		mileskm.DbValue = RsRow("mileskm")
		worldpaylive.DbValue = RsRow("worldpaylive")
		worldpayinstallationid.DbValue = RsRow("worldpayinstallationid")
		DistanceCalMethod.DbValue = RsRow("DistanceCalMethod")
		PrinterIDList.DbValue = RsRow("PrinterIDList")
		EpsonJSPrinterURL.DbValue = RsRow("EpsonJSPrinterURL")
		SMSEnable.DbValue = RsRow("SMSEnable")
		SMSOnDelivery.DbValue = RsRow("SMSOnDelivery")
		SMSSupplierDomain.DbValue = RsRow("SMSSupplierDomain")
		SMSOnOrder.DbValue = RsRow("SMSOnOrder")
		SMSOnOrderAfterMin.DbValue = RsRow("SMSOnOrderAfterMin")
		SMSOnOrderContent.DbValue = RsRow("SMSOnOrderContent")
		DefaultSMSCountryCode.DbValue = RsRow("DefaultSMSCountryCode")
		MinimumAmountForCardPayment.DbValue = RsRow("MinimumAmountForCardPayment")
		FavIconUrl.DbValue = RsRow("FavIconUrl")
		AddToHomeScreenURL.DbValue = RsRow("AddToHomeScreenURL")
		SMSOnAcknowledgement.DbValue = RsRow("SMSOnAcknowledgement")
		LocalPrinterURL.DbValue = RsRow("LocalPrinterURL")
		ShowRestaurantDetailOnReceipt.DbValue = RsRow("ShowRestaurantDetailOnReceipt")
		PrinterFontSizeRatio.DbValue = RsRow("PrinterFontSizeRatio")
		ServiceChargePercentage.DbValue = RsRow("ServiceChargePercentage")
		InRestaurantServiceChargeOnly.DbValue = RsRow("InRestaurantServiceChargeOnly")
		IsDualReceiptPrinting.DbValue = RsRow("IsDualReceiptPrinting")
		PrintingFontSize.DbValue = RsRow("PrintingFontSize")
		InRestaurantEpsonPrinterIDList.DbValue = RsRow("InRestaurantEpsonPrinterIDList")
		BlockIPEmailList.DbValue = RsRow("BlockIPEmailList")
		inmenuannouncement.DbValue = RsRow("inmenuannouncement")
		RePrintReceiptWays.DbValue = RsRow("RePrintReceiptWays")
		printingtype.DbValue = RsRow("printingtype")
		Stripe_Key_Secret.DbValue = RsRow("Stripe_Key_Secret")
		Stripe.DbValue = RsRow("Stripe")
		Stripe_Api_Key.DbValue = RsRow("Stripe_Api_Key")
		EnableBooking.DbValue = RsRow("EnableBooking")
		URL_Facebook.DbValue = RsRow("URL_Facebook")
		URL_Twitter.DbValue = RsRow("URL_Twitter")
		URL_Google.DbValue = RsRow("URL_Google")
		URL_Intagram.DbValue = RsRow("URL_Intagram")
		URL_YouTube.DbValue = RsRow("URL_YouTube")
		URL_Tripadvisor.DbValue = RsRow("URL_Tripadvisor")
		URL_Special_Offer.DbValue = RsRow("URL_Special_Offer")
		URL_Linkin.DbValue = RsRow("URL_Linkin")
		Currency_PAYPAL.DbValue = RsRow("Currency_PAYPAL")
		Currency_STRIPE.DbValue = RsRow("Currency_STRIPE")
		Currency_WOLRDPAY.DbValue = RsRow("Currency_WOLRDPAY")
		Tip_percent.DbValue = RsRow("Tip_percent")
		Tax_Percent.DbValue = RsRow("Tax_Percent")
		InRestaurantTaxChargeOnly.DbValue = RsRow("InRestaurantTaxChargeOnly")
		InRestaurantTipChargeOnly.DbValue = RsRow("InRestaurantTipChargeOnly")
		isCheckCapcha.DbValue = RsRow("isCheckCapcha")
		Close_StartDate.DbValue = RsRow("Close_StartDate")
		Close_EndDate.DbValue = RsRow("Close_EndDate")
		Stripe_Country.DbValue = RsRow("Stripe_Country")
		enable_StripePaymentButton.DbValue = RsRow("enable_StripePaymentButton")
		enable_CashPayment.DbValue = RsRow("enable_CashPayment")
		DeliveryMile.DbValue = RsRow("DeliveryMile")
		Mon_Delivery.DbValue = RsRow("Mon_Delivery")
		Mon_Collection.DbValue = RsRow("Mon_Collection")
		Tue_Delivery.DbValue = RsRow("Tue_Delivery")
		Tue_Collection.DbValue = RsRow("Tue_Collection")
		Wed_Delivery.DbValue = RsRow("Wed_Delivery")
		Wed_Collection.DbValue = RsRow("Wed_Collection")
		Thu_Delivery.DbValue = RsRow("Thu_Delivery")
		Thu_Collection.DbValue = RsRow("Thu_Collection")
		Fri_Delivery.DbValue = RsRow("Fri_Delivery")
		Fri_Collection.DbValue = RsRow("Fri_Collection")
		Sat_Delivery.DbValue = RsRow("Sat_Delivery")
		Sat_Collection.DbValue = RsRow("Sat_Collection")
		Sun_Delivery.DbValue = RsRow("Sun_Delivery")
		Sun_Collection.DbValue = RsRow("Sun_Collection")
		EnableUrlRewrite.DbValue = RsRow("EnableUrlRewrite")
		DeliveryCostUpTo.DbValue = RsRow("DeliveryCostUpTo")
		DeliveryUptoMile.DbValue = RsRow("DeliveryUptoMile")
		Show_Ordernumner_printer.DbValue = RsRow("Show_Ordernumner_printer")
		Show_Ordernumner_Receipt.DbValue = RsRow("Show_Ordernumner_Receipt")
		Show_Ordernumner_Dashboard.DbValue = RsRow("Show_Ordernumner_Dashboard")
	End Sub

	' Render list row values
	Sub RenderListRow()

		'
		'  Common render codes
		'
		' ID
		' Name
		' Address
		' PostalCode
		' FoodType
		' DeliveryMinAmount
		' DeliveryMaxDistance
		' DeliveryFreeDistance
		' AverageDeliveryTime
		' AverageCollectionTime
		' DeliveryFee
		' ImgUrl
		' Telephone
		' Email
		' pswd
		' businessclosed
		' announcement
		' css
		' SMTP_AUTENTICATE
		' MAIL_FROM
		' PAYPAL_URL
		' PAYPAL_PDT
		' SMTP_PASSWORD
		' GMAP_API_KEY
		' SMTP_USERNAME
		' SMTP_USESSL
		' MAIL_SUBJECT
		' CURRENCYSYMBOL
		' SMTP_SERVER
		' CREDITCARDSURCHARGE
		' SMTP_PORT
		' STICK_MENU
		' MAIL_CUSTOMER_SUBJECT
		' CONFIRMATION_EMAIL_ADDRESS
		' SEND_ORDERS_TO_PRINTER
		' timezone
		' PAYPAL_ADDR
		' nochex
		' nochexmerchantid
		' paypal
		' IBT_API_KEY
		' IBP_API_PASSWORD
		' disable_delivery
		' disable_collection
		' worldpay
		' worldpaymerchantid
		' backtohometext
		' closedtext
		' DeliveryChargeOverrideByOrderValue
		' individualpostcodes
		' individualpostcodeschecking
		' longitude
		' latitude
		' googleecommercetracking
		' googleecommercetrackingcode
		' bringg
		' bringgurl
		' bringgcompanyid
		' orderonlywhenopen
		' disablelaterdelivery
		' menupagetext
		' ordertodayonly
		' mileskm
		' worldpaylive
		' worldpayinstallationid
		' DistanceCalMethod
		' PrinterIDList
		' EpsonJSPrinterURL
		' SMSEnable
		' SMSOnDelivery
		' SMSSupplierDomain
		' SMSOnOrder
		' SMSOnOrderAfterMin
		' SMSOnOrderContent
		' DefaultSMSCountryCode
		' MinimumAmountForCardPayment
		' FavIconUrl
		' AddToHomeScreenURL
		' SMSOnAcknowledgement
		' LocalPrinterURL
		' ShowRestaurantDetailOnReceipt
		' PrinterFontSizeRatio
		' ServiceChargePercentage
		' InRestaurantServiceChargeOnly
		' IsDualReceiptPrinting
		' PrintingFontSize
		' InRestaurantEpsonPrinterIDList
		' BlockIPEmailList
		' inmenuannouncement
		' RePrintReceiptWays
		' printingtype
		' Stripe_Key_Secret
		' Stripe
		' Stripe_Api_Key
		' EnableBooking
		' URL_Facebook
		' URL_Twitter
		' URL_Google
		' URL_Intagram
		' URL_YouTube
		' URL_Tripadvisor
		' URL_Special_Offer
		' URL_Linkin
		' Currency_PAYPAL
		' Currency_STRIPE
		' Currency_WOLRDPAY
		' Tip_percent
		' Tax_Percent
		' InRestaurantTaxChargeOnly
		' InRestaurantTipChargeOnly
		' isCheckCapcha
		' Close_StartDate
		' Close_EndDate
		' Stripe_Country
		' enable_StripePaymentButton
		' enable_CashPayment
		' DeliveryMile
		' Mon_Delivery
		' Mon_Collection
		' Tue_Delivery
		' Tue_Collection
		' Wed_Delivery
		' Wed_Collection
		' Thu_Delivery
		' Thu_Collection
		' Fri_Delivery
		' Fri_Collection
		' Sat_Delivery
		' Sat_Collection
		' Sun_Delivery
		' Sun_Collection
		' EnableUrlRewrite
		' DeliveryCostUpTo
		' DeliveryUptoMile
		' Show_Ordernumner_printer
		' Show_Ordernumner_Receipt
		' Show_Ordernumner_Dashboard
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

		' Address
		Address.ViewValue = Address.CurrentValue
		Address.ViewCustomAttributes = ""

		' PostalCode
		PostalCode.ViewValue = PostalCode.CurrentValue
		PostalCode.ViewCustomAttributes = ""

		' FoodType
		FoodType.ViewValue = FoodType.CurrentValue
		FoodType.ViewCustomAttributes = ""

		' DeliveryMinAmount
		DeliveryMinAmount.ViewValue = DeliveryMinAmount.CurrentValue
		DeliveryMinAmount.ViewCustomAttributes = ""

		' DeliveryMaxDistance
		DeliveryMaxDistance.ViewValue = DeliveryMaxDistance.CurrentValue
		DeliveryMaxDistance.ViewCustomAttributes = ""

		' DeliveryFreeDistance
		DeliveryFreeDistance.ViewValue = DeliveryFreeDistance.CurrentValue
		DeliveryFreeDistance.ViewCustomAttributes = ""

		' AverageDeliveryTime
		AverageDeliveryTime.ViewValue = AverageDeliveryTime.CurrentValue
		AverageDeliveryTime.ViewCustomAttributes = ""

		' AverageCollectionTime
		AverageCollectionTime.ViewValue = AverageCollectionTime.CurrentValue
		AverageCollectionTime.ViewCustomAttributes = ""

		' DeliveryFee
		DeliveryFee.ViewValue = DeliveryFee.CurrentValue
		DeliveryFee.ViewCustomAttributes = ""

		' ImgUrl
		ImgUrl.ViewValue = ImgUrl.CurrentValue
		ImgUrl.ViewCustomAttributes = ""

		' Telephone
		Telephone.ViewValue = Telephone.CurrentValue
		Telephone.ViewCustomAttributes = ""

		' Email
		zEmail.ViewValue = zEmail.CurrentValue
		zEmail.ViewCustomAttributes = ""

		' pswd
		pswd.ViewValue = pswd.CurrentValue
		pswd.ViewCustomAttributes = ""

		' businessclosed
		businessclosed.ViewValue = businessclosed.CurrentValue
		businessclosed.ViewCustomAttributes = ""

		' announcement
		announcement.ViewValue = announcement.CurrentValue
		announcement.ViewCustomAttributes = ""

		' css
		css.ViewValue = css.CurrentValue
		css.ViewCustomAttributes = ""

		' SMTP_AUTENTICATE
		SMTP_AUTENTICATE.ViewValue = SMTP_AUTENTICATE.CurrentValue
		SMTP_AUTENTICATE.ViewCustomAttributes = ""

		' MAIL_FROM
		MAIL_FROM.ViewValue = MAIL_FROM.CurrentValue
		MAIL_FROM.ViewCustomAttributes = ""

		' PAYPAL_URL
		PAYPAL_URL.ViewValue = PAYPAL_URL.CurrentValue
		PAYPAL_URL.ViewCustomAttributes = ""

		' PAYPAL_PDT
		PAYPAL_PDT.ViewValue = PAYPAL_PDT.CurrentValue
		PAYPAL_PDT.ViewCustomAttributes = ""

		' SMTP_PASSWORD
		SMTP_PASSWORD.ViewValue = SMTP_PASSWORD.CurrentValue
		SMTP_PASSWORD.ViewCustomAttributes = ""

		' GMAP_API_KEY
		GMAP_API_KEY.ViewValue = GMAP_API_KEY.CurrentValue
		GMAP_API_KEY.ViewCustomAttributes = ""

		' SMTP_USERNAME
		SMTP_USERNAME.ViewValue = SMTP_USERNAME.CurrentValue
		SMTP_USERNAME.ViewCustomAttributes = ""

		' SMTP_USESSL
		SMTP_USESSL.ViewValue = SMTP_USESSL.CurrentValue
		SMTP_USESSL.ViewCustomAttributes = ""

		' MAIL_SUBJECT
		MAIL_SUBJECT.ViewValue = MAIL_SUBJECT.CurrentValue
		MAIL_SUBJECT.ViewCustomAttributes = ""

		' CURRENCYSYMBOL
		CURRENCYSYMBOL.ViewValue = CURRENCYSYMBOL.CurrentValue
		CURRENCYSYMBOL.ViewCustomAttributes = ""

		' SMTP_SERVER
		SMTP_SERVER.ViewValue = SMTP_SERVER.CurrentValue
		SMTP_SERVER.ViewCustomAttributes = ""

		' CREDITCARDSURCHARGE
		CREDITCARDSURCHARGE.ViewValue = CREDITCARDSURCHARGE.CurrentValue
		CREDITCARDSURCHARGE.ViewCustomAttributes = ""

		' SMTP_PORT
		SMTP_PORT.ViewValue = SMTP_PORT.CurrentValue
		SMTP_PORT.ViewCustomAttributes = ""

		' STICK_MENU
		STICK_MENU.ViewValue = STICK_MENU.CurrentValue
		STICK_MENU.ViewCustomAttributes = ""

		' MAIL_CUSTOMER_SUBJECT
		MAIL_CUSTOMER_SUBJECT.ViewValue = MAIL_CUSTOMER_SUBJECT.CurrentValue
		MAIL_CUSTOMER_SUBJECT.ViewCustomAttributes = ""

		' CONFIRMATION_EMAIL_ADDRESS
		CONFIRMATION_EMAIL_ADDRESS.ViewValue = CONFIRMATION_EMAIL_ADDRESS.CurrentValue
		CONFIRMATION_EMAIL_ADDRESS.ViewCustomAttributes = ""

		' SEND_ORDERS_TO_PRINTER
		SEND_ORDERS_TO_PRINTER.ViewValue = SEND_ORDERS_TO_PRINTER.CurrentValue
		SEND_ORDERS_TO_PRINTER.ViewCustomAttributes = ""

		' timezone
		timezone.ViewValue = timezone.CurrentValue
		timezone.ViewCustomAttributes = ""

		' PAYPAL_ADDR
		PAYPAL_ADDR.ViewValue = PAYPAL_ADDR.CurrentValue
		PAYPAL_ADDR.ViewCustomAttributes = ""

		' nochex
		nochex.ViewValue = nochex.CurrentValue
		nochex.ViewCustomAttributes = ""

		' nochexmerchantid
		nochexmerchantid.ViewValue = nochexmerchantid.CurrentValue
		nochexmerchantid.ViewCustomAttributes = ""

		' paypal
		paypal.ViewValue = paypal.CurrentValue
		paypal.ViewCustomAttributes = ""

		' IBT_API_KEY
		IBT_API_KEY.ViewValue = IBT_API_KEY.CurrentValue
		IBT_API_KEY.ViewCustomAttributes = ""

		' IBP_API_PASSWORD
		IBP_API_PASSWORD.ViewValue = IBP_API_PASSWORD.CurrentValue
		IBP_API_PASSWORD.ViewCustomAttributes = ""

		' disable_delivery
		disable_delivery.ViewValue = disable_delivery.CurrentValue
		disable_delivery.ViewCustomAttributes = ""

		' disable_collection
		disable_collection.ViewValue = disable_collection.CurrentValue
		disable_collection.ViewCustomAttributes = ""

		' worldpay
		worldpay.ViewValue = worldpay.CurrentValue
		worldpay.ViewCustomAttributes = ""

		' worldpaymerchantid
		worldpaymerchantid.ViewValue = worldpaymerchantid.CurrentValue
		worldpaymerchantid.ViewCustomAttributes = ""

		' backtohometext
		backtohometext.ViewValue = backtohometext.CurrentValue
		backtohometext.ViewCustomAttributes = ""

		' closedtext
		closedtext.ViewValue = closedtext.CurrentValue
		closedtext.ViewCustomAttributes = ""

		' DeliveryChargeOverrideByOrderValue
		DeliveryChargeOverrideByOrderValue.ViewValue = DeliveryChargeOverrideByOrderValue.CurrentValue
		DeliveryChargeOverrideByOrderValue.ViewCustomAttributes = ""

		' individualpostcodes
		individualpostcodes.ViewValue = individualpostcodes.CurrentValue
		individualpostcodes.ViewCustomAttributes = ""

		' individualpostcodeschecking
		individualpostcodeschecking.ViewValue = individualpostcodeschecking.CurrentValue
		individualpostcodeschecking.ViewCustomAttributes = ""

		' longitude
		longitude.ViewValue = longitude.CurrentValue
		longitude.ViewCustomAttributes = ""

		' latitude
		latitude.ViewValue = latitude.CurrentValue
		latitude.ViewCustomAttributes = ""

		' googleecommercetracking
		googleecommercetracking.ViewValue = googleecommercetracking.CurrentValue
		googleecommercetracking.ViewCustomAttributes = ""

		' googleecommercetrackingcode
		googleecommercetrackingcode.ViewValue = googleecommercetrackingcode.CurrentValue
		googleecommercetrackingcode.ViewCustomAttributes = ""

		' bringg
		bringg.ViewValue = bringg.CurrentValue
		bringg.ViewCustomAttributes = ""

		' bringgurl
		bringgurl.ViewValue = bringgurl.CurrentValue
		bringgurl.ViewCustomAttributes = ""

		' bringgcompanyid
		bringgcompanyid.ViewValue = bringgcompanyid.CurrentValue
		bringgcompanyid.ViewCustomAttributes = ""

		' orderonlywhenopen
		orderonlywhenopen.ViewValue = orderonlywhenopen.CurrentValue
		orderonlywhenopen.ViewCustomAttributes = ""

		' disablelaterdelivery
		disablelaterdelivery.ViewValue = disablelaterdelivery.CurrentValue
		disablelaterdelivery.ViewCustomAttributes = ""

		' menupagetext
		menupagetext.ViewValue = menupagetext.CurrentValue
		menupagetext.ViewCustomAttributes = ""

		' ordertodayonly
		ordertodayonly.ViewValue = ordertodayonly.CurrentValue
		ordertodayonly.ViewCustomAttributes = ""

		' mileskm
		mileskm.ViewValue = mileskm.CurrentValue
		mileskm.ViewCustomAttributes = ""

		' worldpaylive
		worldpaylive.ViewValue = worldpaylive.CurrentValue
		worldpaylive.ViewCustomAttributes = ""

		' worldpayinstallationid
		worldpayinstallationid.ViewValue = worldpayinstallationid.CurrentValue
		worldpayinstallationid.ViewCustomAttributes = ""

		' DistanceCalMethod
		DistanceCalMethod.ViewValue = DistanceCalMethod.CurrentValue
		DistanceCalMethod.ViewCustomAttributes = ""

		' PrinterIDList
		PrinterIDList.ViewValue = PrinterIDList.CurrentValue
		PrinterIDList.ViewCustomAttributes = ""

		' EpsonJSPrinterURL
		EpsonJSPrinterURL.ViewValue = EpsonJSPrinterURL.CurrentValue
		EpsonJSPrinterURL.ViewCustomAttributes = ""

		' SMSEnable
		SMSEnable.ViewValue = SMSEnable.CurrentValue
		SMSEnable.ViewCustomAttributes = ""

		' SMSOnDelivery
		SMSOnDelivery.ViewValue = SMSOnDelivery.CurrentValue
		SMSOnDelivery.ViewCustomAttributes = ""

		' SMSSupplierDomain
		SMSSupplierDomain.ViewValue = SMSSupplierDomain.CurrentValue
		SMSSupplierDomain.ViewCustomAttributes = ""

		' SMSOnOrder
		SMSOnOrder.ViewValue = SMSOnOrder.CurrentValue
		SMSOnOrder.ViewCustomAttributes = ""

		' SMSOnOrderAfterMin
		SMSOnOrderAfterMin.ViewValue = SMSOnOrderAfterMin.CurrentValue
		SMSOnOrderAfterMin.ViewCustomAttributes = ""

		' SMSOnOrderContent
		SMSOnOrderContent.ViewValue = SMSOnOrderContent.CurrentValue
		SMSOnOrderContent.ViewCustomAttributes = ""

		' DefaultSMSCountryCode
		DefaultSMSCountryCode.ViewValue = DefaultSMSCountryCode.CurrentValue
		DefaultSMSCountryCode.ViewCustomAttributes = ""

		' MinimumAmountForCardPayment
		MinimumAmountForCardPayment.ViewValue = MinimumAmountForCardPayment.CurrentValue
		MinimumAmountForCardPayment.ViewCustomAttributes = ""

		' FavIconUrl
		FavIconUrl.ViewValue = FavIconUrl.CurrentValue
		FavIconUrl.ViewCustomAttributes = ""

		' AddToHomeScreenURL
		AddToHomeScreenURL.ViewValue = AddToHomeScreenURL.CurrentValue
		AddToHomeScreenURL.ViewCustomAttributes = ""

		' SMSOnAcknowledgement
		SMSOnAcknowledgement.ViewValue = SMSOnAcknowledgement.CurrentValue
		SMSOnAcknowledgement.ViewCustomAttributes = ""

		' LocalPrinterURL
		LocalPrinterURL.ViewValue = LocalPrinterURL.CurrentValue
		LocalPrinterURL.ViewCustomAttributes = ""

		' ShowRestaurantDetailOnReceipt
		ShowRestaurantDetailOnReceipt.ViewValue = ShowRestaurantDetailOnReceipt.CurrentValue
		ShowRestaurantDetailOnReceipt.ViewCustomAttributes = ""

		' PrinterFontSizeRatio
		PrinterFontSizeRatio.ViewValue = PrinterFontSizeRatio.CurrentValue
		PrinterFontSizeRatio.ViewCustomAttributes = ""

		' ServiceChargePercentage
		ServiceChargePercentage.ViewValue = ServiceChargePercentage.CurrentValue
		ServiceChargePercentage.ViewCustomAttributes = ""

		' InRestaurantServiceChargeOnly
		InRestaurantServiceChargeOnly.ViewValue = InRestaurantServiceChargeOnly.CurrentValue
		InRestaurantServiceChargeOnly.ViewCustomAttributes = ""

		' IsDualReceiptPrinting
		IsDualReceiptPrinting.ViewValue = IsDualReceiptPrinting.CurrentValue
		IsDualReceiptPrinting.ViewCustomAttributes = ""

		' PrintingFontSize
		PrintingFontSize.ViewValue = PrintingFontSize.CurrentValue
		PrintingFontSize.ViewCustomAttributes = ""

		' InRestaurantEpsonPrinterIDList
		InRestaurantEpsonPrinterIDList.ViewValue = InRestaurantEpsonPrinterIDList.CurrentValue
		InRestaurantEpsonPrinterIDList.ViewCustomAttributes = ""

		' BlockIPEmailList
		BlockIPEmailList.ViewValue = BlockIPEmailList.CurrentValue
		BlockIPEmailList.ViewCustomAttributes = ""

		' inmenuannouncement
		inmenuannouncement.ViewValue = inmenuannouncement.CurrentValue
		inmenuannouncement.ViewCustomAttributes = ""

		' RePrintReceiptWays
		RePrintReceiptWays.ViewValue = RePrintReceiptWays.CurrentValue
		RePrintReceiptWays.ViewCustomAttributes = ""

		' printingtype
		printingtype.ViewValue = printingtype.CurrentValue
		printingtype.ViewCustomAttributes = ""

		' Stripe_Key_Secret
		Stripe_Key_Secret.ViewValue = Stripe_Key_Secret.CurrentValue
		Stripe_Key_Secret.ViewCustomAttributes = ""

		' Stripe
		Stripe.ViewValue = Stripe.CurrentValue
		Stripe.ViewCustomAttributes = ""

		' Stripe_Api_Key
		Stripe_Api_Key.ViewValue = Stripe_Api_Key.CurrentValue
		Stripe_Api_Key.ViewCustomAttributes = ""

		' EnableBooking
		EnableBooking.ViewValue = EnableBooking.CurrentValue
		EnableBooking.ViewCustomAttributes = ""

		' URL_Facebook
		URL_Facebook.ViewValue = URL_Facebook.CurrentValue
		URL_Facebook.ViewCustomAttributes = ""

		' URL_Twitter
		URL_Twitter.ViewValue = URL_Twitter.CurrentValue
		URL_Twitter.ViewCustomAttributes = ""

		' URL_Google
		URL_Google.ViewValue = URL_Google.CurrentValue
		URL_Google.ViewCustomAttributes = ""

		' URL_Intagram
		URL_Intagram.ViewValue = URL_Intagram.CurrentValue
		URL_Intagram.ViewCustomAttributes = ""

		' URL_YouTube
		URL_YouTube.ViewValue = URL_YouTube.CurrentValue
		URL_YouTube.ViewCustomAttributes = ""

		' URL_Tripadvisor
		URL_Tripadvisor.ViewValue = URL_Tripadvisor.CurrentValue
		URL_Tripadvisor.ViewCustomAttributes = ""

		' URL_Special_Offer
		URL_Special_Offer.ViewValue = URL_Special_Offer.CurrentValue
		URL_Special_Offer.ViewCustomAttributes = ""

		' URL_Linkin
		URL_Linkin.ViewValue = URL_Linkin.CurrentValue
		URL_Linkin.ViewCustomAttributes = ""

		' Currency_PAYPAL
		Currency_PAYPAL.ViewValue = Currency_PAYPAL.CurrentValue
		Currency_PAYPAL.ViewCustomAttributes = ""

		' Currency_STRIPE
		Currency_STRIPE.ViewValue = Currency_STRIPE.CurrentValue
		Currency_STRIPE.ViewCustomAttributes = ""

		' Currency_WOLRDPAY
		Currency_WOLRDPAY.ViewValue = Currency_WOLRDPAY.CurrentValue
		Currency_WOLRDPAY.ViewCustomAttributes = ""

		' Tip_percent
		Tip_percent.ViewValue = Tip_percent.CurrentValue
		Tip_percent.ViewCustomAttributes = ""

		' Tax_Percent
		Tax_Percent.ViewValue = Tax_Percent.CurrentValue
		Tax_Percent.ViewCustomAttributes = ""

		' InRestaurantTaxChargeOnly
		InRestaurantTaxChargeOnly.ViewValue = InRestaurantTaxChargeOnly.CurrentValue
		InRestaurantTaxChargeOnly.ViewCustomAttributes = ""

		' InRestaurantTipChargeOnly
		InRestaurantTipChargeOnly.ViewValue = InRestaurantTipChargeOnly.CurrentValue
		InRestaurantTipChargeOnly.ViewCustomAttributes = ""

		' isCheckCapcha
		isCheckCapcha.ViewValue = isCheckCapcha.CurrentValue
		isCheckCapcha.ViewCustomAttributes = ""

		' Close_StartDate
		Close_StartDate.ViewValue = Close_StartDate.CurrentValue
		Close_StartDate.ViewCustomAttributes = ""

		' Close_EndDate
		Close_EndDate.ViewValue = Close_EndDate.CurrentValue
		Close_EndDate.ViewCustomAttributes = ""

		' Stripe_Country
		Stripe_Country.ViewValue = Stripe_Country.CurrentValue
		Stripe_Country.ViewCustomAttributes = ""

		' enable_StripePaymentButton
		enable_StripePaymentButton.ViewValue = enable_StripePaymentButton.CurrentValue
		enable_StripePaymentButton.ViewCustomAttributes = ""

		' enable_CashPayment
		enable_CashPayment.ViewValue = enable_CashPayment.CurrentValue
		enable_CashPayment.ViewCustomAttributes = ""

		' DeliveryMile
		DeliveryMile.ViewValue = DeliveryMile.CurrentValue
		DeliveryMile.ViewCustomAttributes = ""

		' Mon_Delivery
		Mon_Delivery.ViewValue = Mon_Delivery.CurrentValue
		Mon_Delivery.ViewCustomAttributes = ""

		' Mon_Collection
		Mon_Collection.ViewValue = Mon_Collection.CurrentValue
		Mon_Collection.ViewCustomAttributes = ""

		' Tue_Delivery
		Tue_Delivery.ViewValue = Tue_Delivery.CurrentValue
		Tue_Delivery.ViewCustomAttributes = ""

		' Tue_Collection
		Tue_Collection.ViewValue = Tue_Collection.CurrentValue
		Tue_Collection.ViewCustomAttributes = ""

		' Wed_Delivery
		Wed_Delivery.ViewValue = Wed_Delivery.CurrentValue
		Wed_Delivery.ViewCustomAttributes = ""

		' Wed_Collection
		Wed_Collection.ViewValue = Wed_Collection.CurrentValue
		Wed_Collection.ViewCustomAttributes = ""

		' Thu_Delivery
		Thu_Delivery.ViewValue = Thu_Delivery.CurrentValue
		Thu_Delivery.ViewCustomAttributes = ""

		' Thu_Collection
		Thu_Collection.ViewValue = Thu_Collection.CurrentValue
		Thu_Collection.ViewCustomAttributes = ""

		' Fri_Delivery
		Fri_Delivery.ViewValue = Fri_Delivery.CurrentValue
		Fri_Delivery.ViewCustomAttributes = ""

		' Fri_Collection
		Fri_Collection.ViewValue = Fri_Collection.CurrentValue
		Fri_Collection.ViewCustomAttributes = ""

		' Sat_Delivery
		Sat_Delivery.ViewValue = Sat_Delivery.CurrentValue
		Sat_Delivery.ViewCustomAttributes = ""

		' Sat_Collection
		Sat_Collection.ViewValue = Sat_Collection.CurrentValue
		Sat_Collection.ViewCustomAttributes = ""

		' Sun_Delivery
		Sun_Delivery.ViewValue = Sun_Delivery.CurrentValue
		Sun_Delivery.ViewCustomAttributes = ""

		' Sun_Collection
		Sun_Collection.ViewValue = Sun_Collection.CurrentValue
		Sun_Collection.ViewCustomAttributes = ""

		' EnableUrlRewrite
		EnableUrlRewrite.ViewValue = EnableUrlRewrite.CurrentValue
		EnableUrlRewrite.ViewCustomAttributes = ""

		' DeliveryCostUpTo
		DeliveryCostUpTo.ViewValue = DeliveryCostUpTo.CurrentValue
		DeliveryCostUpTo.ViewCustomAttributes = ""

		' DeliveryUptoMile
		DeliveryUptoMile.ViewValue = DeliveryUptoMile.CurrentValue
		DeliveryUptoMile.ViewCustomAttributes = ""

		' Show_Ordernumner_printer
		Show_Ordernumner_printer.ViewValue = Show_Ordernumner_printer.CurrentValue
		Show_Ordernumner_printer.ViewCustomAttributes = ""

		' Show_Ordernumner_Receipt
		Show_Ordernumner_Receipt.ViewValue = Show_Ordernumner_Receipt.CurrentValue
		Show_Ordernumner_Receipt.ViewCustomAttributes = ""

		' Show_Ordernumner_Dashboard
		Show_Ordernumner_Dashboard.ViewValue = Show_Ordernumner_Dashboard.CurrentValue
		Show_Ordernumner_Dashboard.ViewCustomAttributes = ""

		' ID
		ID.LinkCustomAttributes = ""
		ID.HrefValue = ""
		ID.TooltipValue = ""

		' Name
		Name.LinkCustomAttributes = ""
		Name.HrefValue = ""
		Name.TooltipValue = ""

		' Address
		Address.LinkCustomAttributes = ""
		Address.HrefValue = ""
		Address.TooltipValue = ""

		' PostalCode
		PostalCode.LinkCustomAttributes = ""
		PostalCode.HrefValue = ""
		PostalCode.TooltipValue = ""

		' FoodType
		FoodType.LinkCustomAttributes = ""
		FoodType.HrefValue = ""
		FoodType.TooltipValue = ""

		' DeliveryMinAmount
		DeliveryMinAmount.LinkCustomAttributes = ""
		DeliveryMinAmount.HrefValue = ""
		DeliveryMinAmount.TooltipValue = ""

		' DeliveryMaxDistance
		DeliveryMaxDistance.LinkCustomAttributes = ""
		DeliveryMaxDistance.HrefValue = ""
		DeliveryMaxDistance.TooltipValue = ""

		' DeliveryFreeDistance
		DeliveryFreeDistance.LinkCustomAttributes = ""
		DeliveryFreeDistance.HrefValue = ""
		DeliveryFreeDistance.TooltipValue = ""

		' AverageDeliveryTime
		AverageDeliveryTime.LinkCustomAttributes = ""
		AverageDeliveryTime.HrefValue = ""
		AverageDeliveryTime.TooltipValue = ""

		' AverageCollectionTime
		AverageCollectionTime.LinkCustomAttributes = ""
		AverageCollectionTime.HrefValue = ""
		AverageCollectionTime.TooltipValue = ""

		' DeliveryFee
		DeliveryFee.LinkCustomAttributes = ""
		DeliveryFee.HrefValue = ""
		DeliveryFee.TooltipValue = ""

		' ImgUrl
		ImgUrl.LinkCustomAttributes = ""
		ImgUrl.HrefValue = ""
		ImgUrl.TooltipValue = ""

		' Telephone
		Telephone.LinkCustomAttributes = ""
		Telephone.HrefValue = ""
		Telephone.TooltipValue = ""

		' Email
		zEmail.LinkCustomAttributes = ""
		zEmail.HrefValue = ""
		zEmail.TooltipValue = ""

		' pswd
		pswd.LinkCustomAttributes = ""
		pswd.HrefValue = ""
		pswd.TooltipValue = ""

		' businessclosed
		businessclosed.LinkCustomAttributes = ""
		businessclosed.HrefValue = ""
		businessclosed.TooltipValue = ""

		' announcement
		announcement.LinkCustomAttributes = ""
		announcement.HrefValue = ""
		announcement.TooltipValue = ""

		' css
		css.LinkCustomAttributes = ""
		css.HrefValue = ""
		css.TooltipValue = ""

		' SMTP_AUTENTICATE
		SMTP_AUTENTICATE.LinkCustomAttributes = ""
		SMTP_AUTENTICATE.HrefValue = ""
		SMTP_AUTENTICATE.TooltipValue = ""

		' MAIL_FROM
		MAIL_FROM.LinkCustomAttributes = ""
		MAIL_FROM.HrefValue = ""
		MAIL_FROM.TooltipValue = ""

		' PAYPAL_URL
		PAYPAL_URL.LinkCustomAttributes = ""
		PAYPAL_URL.HrefValue = ""
		PAYPAL_URL.TooltipValue = ""

		' PAYPAL_PDT
		PAYPAL_PDT.LinkCustomAttributes = ""
		PAYPAL_PDT.HrefValue = ""
		PAYPAL_PDT.TooltipValue = ""

		' SMTP_PASSWORD
		SMTP_PASSWORD.LinkCustomAttributes = ""
		SMTP_PASSWORD.HrefValue = ""
		SMTP_PASSWORD.TooltipValue = ""

		' GMAP_API_KEY
		GMAP_API_KEY.LinkCustomAttributes = ""
		GMAP_API_KEY.HrefValue = ""
		GMAP_API_KEY.TooltipValue = ""

		' SMTP_USERNAME
		SMTP_USERNAME.LinkCustomAttributes = ""
		SMTP_USERNAME.HrefValue = ""
		SMTP_USERNAME.TooltipValue = ""

		' SMTP_USESSL
		SMTP_USESSL.LinkCustomAttributes = ""
		SMTP_USESSL.HrefValue = ""
		SMTP_USESSL.TooltipValue = ""

		' MAIL_SUBJECT
		MAIL_SUBJECT.LinkCustomAttributes = ""
		MAIL_SUBJECT.HrefValue = ""
		MAIL_SUBJECT.TooltipValue = ""

		' CURRENCYSYMBOL
		CURRENCYSYMBOL.LinkCustomAttributes = ""
		CURRENCYSYMBOL.HrefValue = ""
		CURRENCYSYMBOL.TooltipValue = ""

		' SMTP_SERVER
		SMTP_SERVER.LinkCustomAttributes = ""
		SMTP_SERVER.HrefValue = ""
		SMTP_SERVER.TooltipValue = ""

		' CREDITCARDSURCHARGE
		CREDITCARDSURCHARGE.LinkCustomAttributes = ""
		CREDITCARDSURCHARGE.HrefValue = ""
		CREDITCARDSURCHARGE.TooltipValue = ""

		' SMTP_PORT
		SMTP_PORT.LinkCustomAttributes = ""
		SMTP_PORT.HrefValue = ""
		SMTP_PORT.TooltipValue = ""

		' STICK_MENU
		STICK_MENU.LinkCustomAttributes = ""
		STICK_MENU.HrefValue = ""
		STICK_MENU.TooltipValue = ""

		' MAIL_CUSTOMER_SUBJECT
		MAIL_CUSTOMER_SUBJECT.LinkCustomAttributes = ""
		MAIL_CUSTOMER_SUBJECT.HrefValue = ""
		MAIL_CUSTOMER_SUBJECT.TooltipValue = ""

		' CONFIRMATION_EMAIL_ADDRESS
		CONFIRMATION_EMAIL_ADDRESS.LinkCustomAttributes = ""
		CONFIRMATION_EMAIL_ADDRESS.HrefValue = ""
		CONFIRMATION_EMAIL_ADDRESS.TooltipValue = ""

		' SEND_ORDERS_TO_PRINTER
		SEND_ORDERS_TO_PRINTER.LinkCustomAttributes = ""
		SEND_ORDERS_TO_PRINTER.HrefValue = ""
		SEND_ORDERS_TO_PRINTER.TooltipValue = ""

		' timezone
		timezone.LinkCustomAttributes = ""
		timezone.HrefValue = ""
		timezone.TooltipValue = ""

		' PAYPAL_ADDR
		PAYPAL_ADDR.LinkCustomAttributes = ""
		PAYPAL_ADDR.HrefValue = ""
		PAYPAL_ADDR.TooltipValue = ""

		' nochex
		nochex.LinkCustomAttributes = ""
		nochex.HrefValue = ""
		nochex.TooltipValue = ""

		' nochexmerchantid
		nochexmerchantid.LinkCustomAttributes = ""
		nochexmerchantid.HrefValue = ""
		nochexmerchantid.TooltipValue = ""

		' paypal
		paypal.LinkCustomAttributes = ""
		paypal.HrefValue = ""
		paypal.TooltipValue = ""

		' IBT_API_KEY
		IBT_API_KEY.LinkCustomAttributes = ""
		IBT_API_KEY.HrefValue = ""
		IBT_API_KEY.TooltipValue = ""

		' IBP_API_PASSWORD
		IBP_API_PASSWORD.LinkCustomAttributes = ""
		IBP_API_PASSWORD.HrefValue = ""
		IBP_API_PASSWORD.TooltipValue = ""

		' disable_delivery
		disable_delivery.LinkCustomAttributes = ""
		disable_delivery.HrefValue = ""
		disable_delivery.TooltipValue = ""

		' disable_collection
		disable_collection.LinkCustomAttributes = ""
		disable_collection.HrefValue = ""
		disable_collection.TooltipValue = ""

		' worldpay
		worldpay.LinkCustomAttributes = ""
		worldpay.HrefValue = ""
		worldpay.TooltipValue = ""

		' worldpaymerchantid
		worldpaymerchantid.LinkCustomAttributes = ""
		worldpaymerchantid.HrefValue = ""
		worldpaymerchantid.TooltipValue = ""

		' backtohometext
		backtohometext.LinkCustomAttributes = ""
		backtohometext.HrefValue = ""
		backtohometext.TooltipValue = ""

		' closedtext
		closedtext.LinkCustomAttributes = ""
		closedtext.HrefValue = ""
		closedtext.TooltipValue = ""

		' DeliveryChargeOverrideByOrderValue
		DeliveryChargeOverrideByOrderValue.LinkCustomAttributes = ""
		DeliveryChargeOverrideByOrderValue.HrefValue = ""
		DeliveryChargeOverrideByOrderValue.TooltipValue = ""

		' individualpostcodes
		individualpostcodes.LinkCustomAttributes = ""
		individualpostcodes.HrefValue = ""
		individualpostcodes.TooltipValue = ""

		' individualpostcodeschecking
		individualpostcodeschecking.LinkCustomAttributes = ""
		individualpostcodeschecking.HrefValue = ""
		individualpostcodeschecking.TooltipValue = ""

		' longitude
		longitude.LinkCustomAttributes = ""
		longitude.HrefValue = ""
		longitude.TooltipValue = ""

		' latitude
		latitude.LinkCustomAttributes = ""
		latitude.HrefValue = ""
		latitude.TooltipValue = ""

		' googleecommercetracking
		googleecommercetracking.LinkCustomAttributes = ""
		googleecommercetracking.HrefValue = ""
		googleecommercetracking.TooltipValue = ""

		' googleecommercetrackingcode
		googleecommercetrackingcode.LinkCustomAttributes = ""
		googleecommercetrackingcode.HrefValue = ""
		googleecommercetrackingcode.TooltipValue = ""

		' bringg
		bringg.LinkCustomAttributes = ""
		bringg.HrefValue = ""
		bringg.TooltipValue = ""

		' bringgurl
		bringgurl.LinkCustomAttributes = ""
		bringgurl.HrefValue = ""
		bringgurl.TooltipValue = ""

		' bringgcompanyid
		bringgcompanyid.LinkCustomAttributes = ""
		bringgcompanyid.HrefValue = ""
		bringgcompanyid.TooltipValue = ""

		' orderonlywhenopen
		orderonlywhenopen.LinkCustomAttributes = ""
		orderonlywhenopen.HrefValue = ""
		orderonlywhenopen.TooltipValue = ""

		' disablelaterdelivery
		disablelaterdelivery.LinkCustomAttributes = ""
		disablelaterdelivery.HrefValue = ""
		disablelaterdelivery.TooltipValue = ""

		' menupagetext
		menupagetext.LinkCustomAttributes = ""
		menupagetext.HrefValue = ""
		menupagetext.TooltipValue = ""

		' ordertodayonly
		ordertodayonly.LinkCustomAttributes = ""
		ordertodayonly.HrefValue = ""
		ordertodayonly.TooltipValue = ""

		' mileskm
		mileskm.LinkCustomAttributes = ""
		mileskm.HrefValue = ""
		mileskm.TooltipValue = ""

		' worldpaylive
		worldpaylive.LinkCustomAttributes = ""
		worldpaylive.HrefValue = ""
		worldpaylive.TooltipValue = ""

		' worldpayinstallationid
		worldpayinstallationid.LinkCustomAttributes = ""
		worldpayinstallationid.HrefValue = ""
		worldpayinstallationid.TooltipValue = ""

		' DistanceCalMethod
		DistanceCalMethod.LinkCustomAttributes = ""
		DistanceCalMethod.HrefValue = ""
		DistanceCalMethod.TooltipValue = ""

		' PrinterIDList
		PrinterIDList.LinkCustomAttributes = ""
		PrinterIDList.HrefValue = ""
		PrinterIDList.TooltipValue = ""

		' EpsonJSPrinterURL
		EpsonJSPrinterURL.LinkCustomAttributes = ""
		EpsonJSPrinterURL.HrefValue = ""
		EpsonJSPrinterURL.TooltipValue = ""

		' SMSEnable
		SMSEnable.LinkCustomAttributes = ""
		SMSEnable.HrefValue = ""
		SMSEnable.TooltipValue = ""

		' SMSOnDelivery
		SMSOnDelivery.LinkCustomAttributes = ""
		SMSOnDelivery.HrefValue = ""
		SMSOnDelivery.TooltipValue = ""

		' SMSSupplierDomain
		SMSSupplierDomain.LinkCustomAttributes = ""
		SMSSupplierDomain.HrefValue = ""
		SMSSupplierDomain.TooltipValue = ""

		' SMSOnOrder
		SMSOnOrder.LinkCustomAttributes = ""
		SMSOnOrder.HrefValue = ""
		SMSOnOrder.TooltipValue = ""

		' SMSOnOrderAfterMin
		SMSOnOrderAfterMin.LinkCustomAttributes = ""
		SMSOnOrderAfterMin.HrefValue = ""
		SMSOnOrderAfterMin.TooltipValue = ""

		' SMSOnOrderContent
		SMSOnOrderContent.LinkCustomAttributes = ""
		SMSOnOrderContent.HrefValue = ""
		SMSOnOrderContent.TooltipValue = ""

		' DefaultSMSCountryCode
		DefaultSMSCountryCode.LinkCustomAttributes = ""
		DefaultSMSCountryCode.HrefValue = ""
		DefaultSMSCountryCode.TooltipValue = ""

		' MinimumAmountForCardPayment
		MinimumAmountForCardPayment.LinkCustomAttributes = ""
		MinimumAmountForCardPayment.HrefValue = ""
		MinimumAmountForCardPayment.TooltipValue = ""

		' FavIconUrl
		FavIconUrl.LinkCustomAttributes = ""
		FavIconUrl.HrefValue = ""
		FavIconUrl.TooltipValue = ""

		' AddToHomeScreenURL
		AddToHomeScreenURL.LinkCustomAttributes = ""
		AddToHomeScreenURL.HrefValue = ""
		AddToHomeScreenURL.TooltipValue = ""

		' SMSOnAcknowledgement
		SMSOnAcknowledgement.LinkCustomAttributes = ""
		SMSOnAcknowledgement.HrefValue = ""
		SMSOnAcknowledgement.TooltipValue = ""

		' LocalPrinterURL
		LocalPrinterURL.LinkCustomAttributes = ""
		LocalPrinterURL.HrefValue = ""
		LocalPrinterURL.TooltipValue = ""

		' ShowRestaurantDetailOnReceipt
		ShowRestaurantDetailOnReceipt.LinkCustomAttributes = ""
		ShowRestaurantDetailOnReceipt.HrefValue = ""
		ShowRestaurantDetailOnReceipt.TooltipValue = ""

		' PrinterFontSizeRatio
		PrinterFontSizeRatio.LinkCustomAttributes = ""
		PrinterFontSizeRatio.HrefValue = ""
		PrinterFontSizeRatio.TooltipValue = ""

		' ServiceChargePercentage
		ServiceChargePercentage.LinkCustomAttributes = ""
		ServiceChargePercentage.HrefValue = ""
		ServiceChargePercentage.TooltipValue = ""

		' InRestaurantServiceChargeOnly
		InRestaurantServiceChargeOnly.LinkCustomAttributes = ""
		InRestaurantServiceChargeOnly.HrefValue = ""
		InRestaurantServiceChargeOnly.TooltipValue = ""

		' IsDualReceiptPrinting
		IsDualReceiptPrinting.LinkCustomAttributes = ""
		IsDualReceiptPrinting.HrefValue = ""
		IsDualReceiptPrinting.TooltipValue = ""

		' PrintingFontSize
		PrintingFontSize.LinkCustomAttributes = ""
		PrintingFontSize.HrefValue = ""
		PrintingFontSize.TooltipValue = ""

		' InRestaurantEpsonPrinterIDList
		InRestaurantEpsonPrinterIDList.LinkCustomAttributes = ""
		InRestaurantEpsonPrinterIDList.HrefValue = ""
		InRestaurantEpsonPrinterIDList.TooltipValue = ""

		' BlockIPEmailList
		BlockIPEmailList.LinkCustomAttributes = ""
		BlockIPEmailList.HrefValue = ""
		BlockIPEmailList.TooltipValue = ""

		' inmenuannouncement
		inmenuannouncement.LinkCustomAttributes = ""
		inmenuannouncement.HrefValue = ""
		inmenuannouncement.TooltipValue = ""

		' RePrintReceiptWays
		RePrintReceiptWays.LinkCustomAttributes = ""
		RePrintReceiptWays.HrefValue = ""
		RePrintReceiptWays.TooltipValue = ""

		' printingtype
		printingtype.LinkCustomAttributes = ""
		printingtype.HrefValue = ""
		printingtype.TooltipValue = ""

		' Stripe_Key_Secret
		Stripe_Key_Secret.LinkCustomAttributes = ""
		Stripe_Key_Secret.HrefValue = ""
		Stripe_Key_Secret.TooltipValue = ""

		' Stripe
		Stripe.LinkCustomAttributes = ""
		Stripe.HrefValue = ""
		Stripe.TooltipValue = ""

		' Stripe_Api_Key
		Stripe_Api_Key.LinkCustomAttributes = ""
		Stripe_Api_Key.HrefValue = ""
		Stripe_Api_Key.TooltipValue = ""

		' EnableBooking
		EnableBooking.LinkCustomAttributes = ""
		EnableBooking.HrefValue = ""
		EnableBooking.TooltipValue = ""

		' URL_Facebook
		URL_Facebook.LinkCustomAttributes = ""
		URL_Facebook.HrefValue = ""
		URL_Facebook.TooltipValue = ""

		' URL_Twitter
		URL_Twitter.LinkCustomAttributes = ""
		URL_Twitter.HrefValue = ""
		URL_Twitter.TooltipValue = ""

		' URL_Google
		URL_Google.LinkCustomAttributes = ""
		URL_Google.HrefValue = ""
		URL_Google.TooltipValue = ""

		' URL_Intagram
		URL_Intagram.LinkCustomAttributes = ""
		URL_Intagram.HrefValue = ""
		URL_Intagram.TooltipValue = ""

		' URL_YouTube
		URL_YouTube.LinkCustomAttributes = ""
		URL_YouTube.HrefValue = ""
		URL_YouTube.TooltipValue = ""

		' URL_Tripadvisor
		URL_Tripadvisor.LinkCustomAttributes = ""
		URL_Tripadvisor.HrefValue = ""
		URL_Tripadvisor.TooltipValue = ""

		' URL_Special_Offer
		URL_Special_Offer.LinkCustomAttributes = ""
		URL_Special_Offer.HrefValue = ""
		URL_Special_Offer.TooltipValue = ""

		' URL_Linkin
		URL_Linkin.LinkCustomAttributes = ""
		URL_Linkin.HrefValue = ""
		URL_Linkin.TooltipValue = ""

		' Currency_PAYPAL
		Currency_PAYPAL.LinkCustomAttributes = ""
		Currency_PAYPAL.HrefValue = ""
		Currency_PAYPAL.TooltipValue = ""

		' Currency_STRIPE
		Currency_STRIPE.LinkCustomAttributes = ""
		Currency_STRIPE.HrefValue = ""
		Currency_STRIPE.TooltipValue = ""

		' Currency_WOLRDPAY
		Currency_WOLRDPAY.LinkCustomAttributes = ""
		Currency_WOLRDPAY.HrefValue = ""
		Currency_WOLRDPAY.TooltipValue = ""

		' Tip_percent
		Tip_percent.LinkCustomAttributes = ""
		Tip_percent.HrefValue = ""
		Tip_percent.TooltipValue = ""

		' Tax_Percent
		Tax_Percent.LinkCustomAttributes = ""
		Tax_Percent.HrefValue = ""
		Tax_Percent.TooltipValue = ""

		' InRestaurantTaxChargeOnly
		InRestaurantTaxChargeOnly.LinkCustomAttributes = ""
		InRestaurantTaxChargeOnly.HrefValue = ""
		InRestaurantTaxChargeOnly.TooltipValue = ""

		' InRestaurantTipChargeOnly
		InRestaurantTipChargeOnly.LinkCustomAttributes = ""
		InRestaurantTipChargeOnly.HrefValue = ""
		InRestaurantTipChargeOnly.TooltipValue = ""

		' isCheckCapcha
		isCheckCapcha.LinkCustomAttributes = ""
		isCheckCapcha.HrefValue = ""
		isCheckCapcha.TooltipValue = ""

		' Close_StartDate
		Close_StartDate.LinkCustomAttributes = ""
		Close_StartDate.HrefValue = ""
		Close_StartDate.TooltipValue = ""

		' Close_EndDate
		Close_EndDate.LinkCustomAttributes = ""
		Close_EndDate.HrefValue = ""
		Close_EndDate.TooltipValue = ""

		' Stripe_Country
		Stripe_Country.LinkCustomAttributes = ""
		Stripe_Country.HrefValue = ""
		Stripe_Country.TooltipValue = ""

		' enable_StripePaymentButton
		enable_StripePaymentButton.LinkCustomAttributes = ""
		enable_StripePaymentButton.HrefValue = ""
		enable_StripePaymentButton.TooltipValue = ""

		' enable_CashPayment
		enable_CashPayment.LinkCustomAttributes = ""
		enable_CashPayment.HrefValue = ""
		enable_CashPayment.TooltipValue = ""

		' DeliveryMile
		DeliveryMile.LinkCustomAttributes = ""
		DeliveryMile.HrefValue = ""
		DeliveryMile.TooltipValue = ""

		' Mon_Delivery
		Mon_Delivery.LinkCustomAttributes = ""
		Mon_Delivery.HrefValue = ""
		Mon_Delivery.TooltipValue = ""

		' Mon_Collection
		Mon_Collection.LinkCustomAttributes = ""
		Mon_Collection.HrefValue = ""
		Mon_Collection.TooltipValue = ""

		' Tue_Delivery
		Tue_Delivery.LinkCustomAttributes = ""
		Tue_Delivery.HrefValue = ""
		Tue_Delivery.TooltipValue = ""

		' Tue_Collection
		Tue_Collection.LinkCustomAttributes = ""
		Tue_Collection.HrefValue = ""
		Tue_Collection.TooltipValue = ""

		' Wed_Delivery
		Wed_Delivery.LinkCustomAttributes = ""
		Wed_Delivery.HrefValue = ""
		Wed_Delivery.TooltipValue = ""

		' Wed_Collection
		Wed_Collection.LinkCustomAttributes = ""
		Wed_Collection.HrefValue = ""
		Wed_Collection.TooltipValue = ""

		' Thu_Delivery
		Thu_Delivery.LinkCustomAttributes = ""
		Thu_Delivery.HrefValue = ""
		Thu_Delivery.TooltipValue = ""

		' Thu_Collection
		Thu_Collection.LinkCustomAttributes = ""
		Thu_Collection.HrefValue = ""
		Thu_Collection.TooltipValue = ""

		' Fri_Delivery
		Fri_Delivery.LinkCustomAttributes = ""
		Fri_Delivery.HrefValue = ""
		Fri_Delivery.TooltipValue = ""

		' Fri_Collection
		Fri_Collection.LinkCustomAttributes = ""
		Fri_Collection.HrefValue = ""
		Fri_Collection.TooltipValue = ""

		' Sat_Delivery
		Sat_Delivery.LinkCustomAttributes = ""
		Sat_Delivery.HrefValue = ""
		Sat_Delivery.TooltipValue = ""

		' Sat_Collection
		Sat_Collection.LinkCustomAttributes = ""
		Sat_Collection.HrefValue = ""
		Sat_Collection.TooltipValue = ""

		' Sun_Delivery
		Sun_Delivery.LinkCustomAttributes = ""
		Sun_Delivery.HrefValue = ""
		Sun_Delivery.TooltipValue = ""

		' Sun_Collection
		Sun_Collection.LinkCustomAttributes = ""
		Sun_Collection.HrefValue = ""
		Sun_Collection.TooltipValue = ""

		' EnableUrlRewrite
		EnableUrlRewrite.LinkCustomAttributes = ""
		EnableUrlRewrite.HrefValue = ""
		EnableUrlRewrite.TooltipValue = ""

		' DeliveryCostUpTo
		DeliveryCostUpTo.LinkCustomAttributes = ""
		DeliveryCostUpTo.HrefValue = ""
		DeliveryCostUpTo.TooltipValue = ""

		' DeliveryUptoMile
		DeliveryUptoMile.LinkCustomAttributes = ""
		DeliveryUptoMile.HrefValue = ""
		DeliveryUptoMile.TooltipValue = ""

		' Show_Ordernumner_printer
		Show_Ordernumner_printer.LinkCustomAttributes = ""
		Show_Ordernumner_printer.HrefValue = ""
		Show_Ordernumner_printer.TooltipValue = ""

		' Show_Ordernumner_Receipt
		Show_Ordernumner_Receipt.LinkCustomAttributes = ""
		Show_Ordernumner_Receipt.HrefValue = ""
		Show_Ordernumner_Receipt.TooltipValue = ""

		' Show_Ordernumner_Dashboard
		Show_Ordernumner_Dashboard.LinkCustomAttributes = ""
		Show_Ordernumner_Dashboard.HrefValue = ""
		Show_Ordernumner_Dashboard.TooltipValue = ""

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

		' FoodType
		FoodType.EditAttrs.UpdateAttribute "class", "form-control"
		FoodType.EditCustomAttributes = ""
		FoodType.EditValue = FoodType.CurrentValue
		FoodType.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(FoodType.FldCaption))

		' DeliveryMinAmount
		DeliveryMinAmount.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryMinAmount.EditCustomAttributes = ""
		DeliveryMinAmount.EditValue = DeliveryMinAmount.CurrentValue
		DeliveryMinAmount.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryMinAmount.FldCaption))

		' DeliveryMaxDistance
		DeliveryMaxDistance.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryMaxDistance.EditCustomAttributes = ""
		DeliveryMaxDistance.EditValue = DeliveryMaxDistance.CurrentValue
		DeliveryMaxDistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryMaxDistance.FldCaption))
		If DeliveryMaxDistance.EditValue&"" <> "" And IsNumeric(DeliveryMaxDistance.EditValue) Then DeliveryMaxDistance.EditValue = ew_FormatNumber2(DeliveryMaxDistance.EditValue, -2)

		' DeliveryFreeDistance
		DeliveryFreeDistance.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryFreeDistance.EditCustomAttributes = ""
		DeliveryFreeDistance.EditValue = DeliveryFreeDistance.CurrentValue
		DeliveryFreeDistance.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryFreeDistance.FldCaption))
		If DeliveryFreeDistance.EditValue&"" <> "" And IsNumeric(DeliveryFreeDistance.EditValue) Then DeliveryFreeDistance.EditValue = ew_FormatNumber2(DeliveryFreeDistance.EditValue, -2)

		' AverageDeliveryTime
		AverageDeliveryTime.EditAttrs.UpdateAttribute "class", "form-control"
		AverageDeliveryTime.EditCustomAttributes = ""
		AverageDeliveryTime.EditValue = AverageDeliveryTime.CurrentValue
		AverageDeliveryTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(AverageDeliveryTime.FldCaption))

		' AverageCollectionTime
		AverageCollectionTime.EditAttrs.UpdateAttribute "class", "form-control"
		AverageCollectionTime.EditCustomAttributes = ""
		AverageCollectionTime.EditValue = AverageCollectionTime.CurrentValue
		AverageCollectionTime.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(AverageCollectionTime.FldCaption))

		' DeliveryFee
		DeliveryFee.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryFee.EditCustomAttributes = ""
		DeliveryFee.EditValue = DeliveryFee.CurrentValue
		DeliveryFee.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryFee.FldCaption))
		If DeliveryFee.EditValue&"" <> "" And IsNumeric(DeliveryFee.EditValue) Then DeliveryFee.EditValue = ew_FormatNumber2(DeliveryFee.EditValue, -2)

		' ImgUrl
		ImgUrl.EditAttrs.UpdateAttribute "class", "form-control"
		ImgUrl.EditCustomAttributes = ""
		ImgUrl.EditValue = ImgUrl.CurrentValue
		ImgUrl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(ImgUrl.FldCaption))

		' Telephone
		Telephone.EditAttrs.UpdateAttribute "class", "form-control"
		Telephone.EditCustomAttributes = ""
		Telephone.EditValue = Telephone.CurrentValue
		Telephone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Telephone.FldCaption))

		' Email
		zEmail.EditAttrs.UpdateAttribute "class", "form-control"
		zEmail.EditCustomAttributes = ""
		zEmail.EditValue = zEmail.CurrentValue
		zEmail.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(zEmail.FldCaption))

		' pswd
		pswd.EditAttrs.UpdateAttribute "class", "form-control"
		pswd.EditCustomAttributes = ""
		pswd.EditValue = pswd.CurrentValue
		pswd.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(pswd.FldCaption))

		' businessclosed
		businessclosed.EditAttrs.UpdateAttribute "class", "form-control"
		businessclosed.EditCustomAttributes = ""
		businessclosed.EditValue = businessclosed.CurrentValue
		businessclosed.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(businessclosed.FldCaption))

		' announcement
		announcement.EditAttrs.UpdateAttribute "class", "form-control"
		announcement.EditCustomAttributes = ""
		announcement.EditValue = announcement.CurrentValue
		announcement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(announcement.FldCaption))

		' css
		css.EditAttrs.UpdateAttribute "class", "form-control"
		css.EditCustomAttributes = ""
		css.EditValue = css.CurrentValue
		css.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(css.FldCaption))

		' SMTP_AUTENTICATE
		SMTP_AUTENTICATE.EditAttrs.UpdateAttribute "class", "form-control"
		SMTP_AUTENTICATE.EditCustomAttributes = ""
		SMTP_AUTENTICATE.EditValue = SMTP_AUTENTICATE.CurrentValue
		SMTP_AUTENTICATE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMTP_AUTENTICATE.FldCaption))

		' MAIL_FROM
		MAIL_FROM.EditAttrs.UpdateAttribute "class", "form-control"
		MAIL_FROM.EditCustomAttributes = ""
		MAIL_FROM.EditValue = MAIL_FROM.CurrentValue
		MAIL_FROM.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MAIL_FROM.FldCaption))

		' PAYPAL_URL
		PAYPAL_URL.EditAttrs.UpdateAttribute "class", "form-control"
		PAYPAL_URL.EditCustomAttributes = ""
		PAYPAL_URL.EditValue = PAYPAL_URL.CurrentValue
		PAYPAL_URL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PAYPAL_URL.FldCaption))

		' PAYPAL_PDT
		PAYPAL_PDT.EditAttrs.UpdateAttribute "class", "form-control"
		PAYPAL_PDT.EditCustomAttributes = ""
		PAYPAL_PDT.EditValue = PAYPAL_PDT.CurrentValue
		PAYPAL_PDT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PAYPAL_PDT.FldCaption))

		' SMTP_PASSWORD
		SMTP_PASSWORD.EditAttrs.UpdateAttribute "class", "form-control"
		SMTP_PASSWORD.EditCustomAttributes = ""
		SMTP_PASSWORD.EditValue = SMTP_PASSWORD.CurrentValue
		SMTP_PASSWORD.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMTP_PASSWORD.FldCaption))

		' GMAP_API_KEY
		GMAP_API_KEY.EditAttrs.UpdateAttribute "class", "form-control"
		GMAP_API_KEY.EditCustomAttributes = ""
		GMAP_API_KEY.EditValue = GMAP_API_KEY.CurrentValue
		GMAP_API_KEY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(GMAP_API_KEY.FldCaption))

		' SMTP_USERNAME
		SMTP_USERNAME.EditAttrs.UpdateAttribute "class", "form-control"
		SMTP_USERNAME.EditCustomAttributes = ""
		SMTP_USERNAME.EditValue = SMTP_USERNAME.CurrentValue
		SMTP_USERNAME.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMTP_USERNAME.FldCaption))

		' SMTP_USESSL
		SMTP_USESSL.EditAttrs.UpdateAttribute "class", "form-control"
		SMTP_USESSL.EditCustomAttributes = ""
		SMTP_USESSL.EditValue = SMTP_USESSL.CurrentValue
		SMTP_USESSL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMTP_USESSL.FldCaption))

		' MAIL_SUBJECT
		MAIL_SUBJECT.EditAttrs.UpdateAttribute "class", "form-control"
		MAIL_SUBJECT.EditCustomAttributes = ""
		MAIL_SUBJECT.EditValue = MAIL_SUBJECT.CurrentValue
		MAIL_SUBJECT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MAIL_SUBJECT.FldCaption))

		' CURRENCYSYMBOL
		CURRENCYSYMBOL.EditAttrs.UpdateAttribute "class", "form-control"
		CURRENCYSYMBOL.EditCustomAttributes = ""
		CURRENCYSYMBOL.EditValue = CURRENCYSYMBOL.CurrentValue
		CURRENCYSYMBOL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(CURRENCYSYMBOL.FldCaption))

		' SMTP_SERVER
		SMTP_SERVER.EditAttrs.UpdateAttribute "class", "form-control"
		SMTP_SERVER.EditCustomAttributes = ""
		SMTP_SERVER.EditValue = SMTP_SERVER.CurrentValue
		SMTP_SERVER.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMTP_SERVER.FldCaption))

		' CREDITCARDSURCHARGE
		CREDITCARDSURCHARGE.EditAttrs.UpdateAttribute "class", "form-control"
		CREDITCARDSURCHARGE.EditCustomAttributes = ""
		CREDITCARDSURCHARGE.EditValue = CREDITCARDSURCHARGE.CurrentValue
		CREDITCARDSURCHARGE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(CREDITCARDSURCHARGE.FldCaption))

		' SMTP_PORT
		SMTP_PORT.EditAttrs.UpdateAttribute "class", "form-control"
		SMTP_PORT.EditCustomAttributes = ""
		SMTP_PORT.EditValue = SMTP_PORT.CurrentValue
		SMTP_PORT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMTP_PORT.FldCaption))

		' STICK_MENU
		STICK_MENU.EditAttrs.UpdateAttribute "class", "form-control"
		STICK_MENU.EditCustomAttributes = ""
		STICK_MENU.EditValue = STICK_MENU.CurrentValue
		STICK_MENU.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(STICK_MENU.FldCaption))

		' MAIL_CUSTOMER_SUBJECT
		MAIL_CUSTOMER_SUBJECT.EditAttrs.UpdateAttribute "class", "form-control"
		MAIL_CUSTOMER_SUBJECT.EditCustomAttributes = ""
		MAIL_CUSTOMER_SUBJECT.EditValue = MAIL_CUSTOMER_SUBJECT.CurrentValue
		MAIL_CUSTOMER_SUBJECT.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MAIL_CUSTOMER_SUBJECT.FldCaption))

		' CONFIRMATION_EMAIL_ADDRESS
		CONFIRMATION_EMAIL_ADDRESS.EditAttrs.UpdateAttribute "class", "form-control"
		CONFIRMATION_EMAIL_ADDRESS.EditCustomAttributes = ""
		CONFIRMATION_EMAIL_ADDRESS.EditValue = CONFIRMATION_EMAIL_ADDRESS.CurrentValue
		CONFIRMATION_EMAIL_ADDRESS.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(CONFIRMATION_EMAIL_ADDRESS.FldCaption))

		' SEND_ORDERS_TO_PRINTER
		SEND_ORDERS_TO_PRINTER.EditAttrs.UpdateAttribute "class", "form-control"
		SEND_ORDERS_TO_PRINTER.EditCustomAttributes = ""
		SEND_ORDERS_TO_PRINTER.EditValue = SEND_ORDERS_TO_PRINTER.CurrentValue
		SEND_ORDERS_TO_PRINTER.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SEND_ORDERS_TO_PRINTER.FldCaption))

		' timezone
		timezone.EditAttrs.UpdateAttribute "class", "form-control"
		timezone.EditCustomAttributes = ""
		timezone.EditValue = timezone.CurrentValue
		timezone.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(timezone.FldCaption))

		' PAYPAL_ADDR
		PAYPAL_ADDR.EditAttrs.UpdateAttribute "class", "form-control"
		PAYPAL_ADDR.EditCustomAttributes = ""
		PAYPAL_ADDR.EditValue = PAYPAL_ADDR.CurrentValue
		PAYPAL_ADDR.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PAYPAL_ADDR.FldCaption))

		' nochex
		nochex.EditAttrs.UpdateAttribute "class", "form-control"
		nochex.EditCustomAttributes = ""
		nochex.EditValue = nochex.CurrentValue
		nochex.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(nochex.FldCaption))

		' nochexmerchantid
		nochexmerchantid.EditAttrs.UpdateAttribute "class", "form-control"
		nochexmerchantid.EditCustomAttributes = ""
		nochexmerchantid.EditValue = nochexmerchantid.CurrentValue
		nochexmerchantid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(nochexmerchantid.FldCaption))

		' paypal
		paypal.EditAttrs.UpdateAttribute "class", "form-control"
		paypal.EditCustomAttributes = ""
		paypal.EditValue = paypal.CurrentValue
		paypal.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(paypal.FldCaption))

		' IBT_API_KEY
		IBT_API_KEY.EditAttrs.UpdateAttribute "class", "form-control"
		IBT_API_KEY.EditCustomAttributes = ""
		IBT_API_KEY.EditValue = IBT_API_KEY.CurrentValue
		IBT_API_KEY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(IBT_API_KEY.FldCaption))

		' IBP_API_PASSWORD
		IBP_API_PASSWORD.EditAttrs.UpdateAttribute "class", "form-control"
		IBP_API_PASSWORD.EditCustomAttributes = ""
		IBP_API_PASSWORD.EditValue = IBP_API_PASSWORD.CurrentValue
		IBP_API_PASSWORD.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(IBP_API_PASSWORD.FldCaption))

		' disable_delivery
		disable_delivery.EditAttrs.UpdateAttribute "class", "form-control"
		disable_delivery.EditCustomAttributes = ""
		disable_delivery.EditValue = disable_delivery.CurrentValue
		disable_delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(disable_delivery.FldCaption))

		' disable_collection
		disable_collection.EditAttrs.UpdateAttribute "class", "form-control"
		disable_collection.EditCustomAttributes = ""
		disable_collection.EditValue = disable_collection.CurrentValue
		disable_collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(disable_collection.FldCaption))

		' worldpay
		worldpay.EditAttrs.UpdateAttribute "class", "form-control"
		worldpay.EditCustomAttributes = ""
		worldpay.EditValue = worldpay.CurrentValue
		worldpay.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(worldpay.FldCaption))

		' worldpaymerchantid
		worldpaymerchantid.EditAttrs.UpdateAttribute "class", "form-control"
		worldpaymerchantid.EditCustomAttributes = ""
		worldpaymerchantid.EditValue = worldpaymerchantid.CurrentValue
		worldpaymerchantid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(worldpaymerchantid.FldCaption))

		' backtohometext
		backtohometext.EditAttrs.UpdateAttribute "class", "form-control"
		backtohometext.EditCustomAttributes = ""
		backtohometext.EditValue = backtohometext.CurrentValue
		backtohometext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(backtohometext.FldCaption))

		' closedtext
		closedtext.EditAttrs.UpdateAttribute "class", "form-control"
		closedtext.EditCustomAttributes = ""
		closedtext.EditValue = closedtext.CurrentValue
		closedtext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(closedtext.FldCaption))

		' DeliveryChargeOverrideByOrderValue
		DeliveryChargeOverrideByOrderValue.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryChargeOverrideByOrderValue.EditCustomAttributes = ""
		DeliveryChargeOverrideByOrderValue.EditValue = DeliveryChargeOverrideByOrderValue.CurrentValue
		DeliveryChargeOverrideByOrderValue.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryChargeOverrideByOrderValue.FldCaption))

		' individualpostcodes
		individualpostcodes.EditAttrs.UpdateAttribute "class", "form-control"
		individualpostcodes.EditCustomAttributes = ""
		individualpostcodes.EditValue = individualpostcodes.CurrentValue
		individualpostcodes.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(individualpostcodes.FldCaption))

		' individualpostcodeschecking
		individualpostcodeschecking.EditAttrs.UpdateAttribute "class", "form-control"
		individualpostcodeschecking.EditCustomAttributes = ""
		individualpostcodeschecking.EditValue = individualpostcodeschecking.CurrentValue
		individualpostcodeschecking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(individualpostcodeschecking.FldCaption))

		' longitude
		longitude.EditAttrs.UpdateAttribute "class", "form-control"
		longitude.EditCustomAttributes = ""
		longitude.EditValue = longitude.CurrentValue
		longitude.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(longitude.FldCaption))

		' latitude
		latitude.EditAttrs.UpdateAttribute "class", "form-control"
		latitude.EditCustomAttributes = ""
		latitude.EditValue = latitude.CurrentValue
		latitude.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(latitude.FldCaption))

		' googleecommercetracking
		googleecommercetracking.EditAttrs.UpdateAttribute "class", "form-control"
		googleecommercetracking.EditCustomAttributes = ""
		googleecommercetracking.EditValue = googleecommercetracking.CurrentValue
		googleecommercetracking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(googleecommercetracking.FldCaption))

		' googleecommercetrackingcode
		googleecommercetrackingcode.EditAttrs.UpdateAttribute "class", "form-control"
		googleecommercetrackingcode.EditCustomAttributes = ""
		googleecommercetrackingcode.EditValue = googleecommercetrackingcode.CurrentValue
		googleecommercetrackingcode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(googleecommercetrackingcode.FldCaption))

		' bringg
		bringg.EditAttrs.UpdateAttribute "class", "form-control"
		bringg.EditCustomAttributes = ""
		bringg.EditValue = bringg.CurrentValue
		bringg.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(bringg.FldCaption))

		' bringgurl
		bringgurl.EditAttrs.UpdateAttribute "class", "form-control"
		bringgurl.EditCustomAttributes = ""
		bringgurl.EditValue = bringgurl.CurrentValue
		bringgurl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(bringgurl.FldCaption))

		' bringgcompanyid
		bringgcompanyid.EditAttrs.UpdateAttribute "class", "form-control"
		bringgcompanyid.EditCustomAttributes = ""
		bringgcompanyid.EditValue = bringgcompanyid.CurrentValue
		bringgcompanyid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(bringgcompanyid.FldCaption))

		' orderonlywhenopen
		orderonlywhenopen.EditAttrs.UpdateAttribute "class", "form-control"
		orderonlywhenopen.EditCustomAttributes = ""
		orderonlywhenopen.EditValue = orderonlywhenopen.CurrentValue
		orderonlywhenopen.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(orderonlywhenopen.FldCaption))

		' disablelaterdelivery
		disablelaterdelivery.EditAttrs.UpdateAttribute "class", "form-control"
		disablelaterdelivery.EditCustomAttributes = ""
		disablelaterdelivery.EditValue = disablelaterdelivery.CurrentValue
		disablelaterdelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(disablelaterdelivery.FldCaption))

		' menupagetext
		menupagetext.EditAttrs.UpdateAttribute "class", "form-control"
		menupagetext.EditCustomAttributes = ""
		menupagetext.EditValue = menupagetext.CurrentValue
		menupagetext.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(menupagetext.FldCaption))

		' ordertodayonly
		ordertodayonly.EditAttrs.UpdateAttribute "class", "form-control"
		ordertodayonly.EditCustomAttributes = ""
		ordertodayonly.EditValue = ordertodayonly.CurrentValue
		ordertodayonly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(ordertodayonly.FldCaption))

		' mileskm
		mileskm.EditAttrs.UpdateAttribute "class", "form-control"
		mileskm.EditCustomAttributes = ""
		mileskm.EditValue = mileskm.CurrentValue
		mileskm.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(mileskm.FldCaption))

		' worldpaylive
		worldpaylive.EditAttrs.UpdateAttribute "class", "form-control"
		worldpaylive.EditCustomAttributes = ""
		worldpaylive.EditValue = worldpaylive.CurrentValue
		worldpaylive.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(worldpaylive.FldCaption))

		' worldpayinstallationid
		worldpayinstallationid.EditAttrs.UpdateAttribute "class", "form-control"
		worldpayinstallationid.EditCustomAttributes = ""
		worldpayinstallationid.EditValue = worldpayinstallationid.CurrentValue
		worldpayinstallationid.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(worldpayinstallationid.FldCaption))

		' DistanceCalMethod
		DistanceCalMethod.EditAttrs.UpdateAttribute "class", "form-control"
		DistanceCalMethod.EditCustomAttributes = ""
		DistanceCalMethod.EditValue = DistanceCalMethod.CurrentValue
		DistanceCalMethod.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DistanceCalMethod.FldCaption))

		' PrinterIDList
		PrinterIDList.EditAttrs.UpdateAttribute "class", "form-control"
		PrinterIDList.EditCustomAttributes = ""
		PrinterIDList.EditValue = PrinterIDList.CurrentValue
		PrinterIDList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PrinterIDList.FldCaption))

		' EpsonJSPrinterURL
		EpsonJSPrinterURL.EditAttrs.UpdateAttribute "class", "form-control"
		EpsonJSPrinterURL.EditCustomAttributes = ""
		EpsonJSPrinterURL.EditValue = EpsonJSPrinterURL.CurrentValue
		EpsonJSPrinterURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(EpsonJSPrinterURL.FldCaption))

		' SMSEnable
		SMSEnable.EditAttrs.UpdateAttribute "class", "form-control"
		SMSEnable.EditCustomAttributes = ""
		SMSEnable.EditValue = SMSEnable.CurrentValue
		SMSEnable.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSEnable.FldCaption))

		' SMSOnDelivery
		SMSOnDelivery.EditAttrs.UpdateAttribute "class", "form-control"
		SMSOnDelivery.EditCustomAttributes = ""
		SMSOnDelivery.EditValue = SMSOnDelivery.CurrentValue
		SMSOnDelivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSOnDelivery.FldCaption))

		' SMSSupplierDomain
		SMSSupplierDomain.EditAttrs.UpdateAttribute "class", "form-control"
		SMSSupplierDomain.EditCustomAttributes = ""
		SMSSupplierDomain.EditValue = SMSSupplierDomain.CurrentValue
		SMSSupplierDomain.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSSupplierDomain.FldCaption))

		' SMSOnOrder
		SMSOnOrder.EditAttrs.UpdateAttribute "class", "form-control"
		SMSOnOrder.EditCustomAttributes = ""
		SMSOnOrder.EditValue = SMSOnOrder.CurrentValue
		SMSOnOrder.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSOnOrder.FldCaption))

		' SMSOnOrderAfterMin
		SMSOnOrderAfterMin.EditAttrs.UpdateAttribute "class", "form-control"
		SMSOnOrderAfterMin.EditCustomAttributes = ""
		SMSOnOrderAfterMin.EditValue = SMSOnOrderAfterMin.CurrentValue
		SMSOnOrderAfterMin.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSOnOrderAfterMin.FldCaption))

		' SMSOnOrderContent
		SMSOnOrderContent.EditAttrs.UpdateAttribute "class", "form-control"
		SMSOnOrderContent.EditCustomAttributes = ""
		SMSOnOrderContent.EditValue = SMSOnOrderContent.CurrentValue
		SMSOnOrderContent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSOnOrderContent.FldCaption))

		' DefaultSMSCountryCode
		DefaultSMSCountryCode.EditAttrs.UpdateAttribute "class", "form-control"
		DefaultSMSCountryCode.EditCustomAttributes = ""
		DefaultSMSCountryCode.EditValue = DefaultSMSCountryCode.CurrentValue
		DefaultSMSCountryCode.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DefaultSMSCountryCode.FldCaption))

		' MinimumAmountForCardPayment
		MinimumAmountForCardPayment.EditAttrs.UpdateAttribute "class", "form-control"
		MinimumAmountForCardPayment.EditCustomAttributes = ""
		MinimumAmountForCardPayment.EditValue = MinimumAmountForCardPayment.CurrentValue
		MinimumAmountForCardPayment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(MinimumAmountForCardPayment.FldCaption))
		If MinimumAmountForCardPayment.EditValue&"" <> "" And IsNumeric(MinimumAmountForCardPayment.EditValue) Then MinimumAmountForCardPayment.EditValue = ew_FormatNumber2(MinimumAmountForCardPayment.EditValue, -2)

		' FavIconUrl
		FavIconUrl.EditAttrs.UpdateAttribute "class", "form-control"
		FavIconUrl.EditCustomAttributes = ""
		FavIconUrl.EditValue = FavIconUrl.CurrentValue
		FavIconUrl.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(FavIconUrl.FldCaption))

		' AddToHomeScreenURL
		AddToHomeScreenURL.EditAttrs.UpdateAttribute "class", "form-control"
		AddToHomeScreenURL.EditCustomAttributes = ""
		AddToHomeScreenURL.EditValue = AddToHomeScreenURL.CurrentValue
		AddToHomeScreenURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(AddToHomeScreenURL.FldCaption))

		' SMSOnAcknowledgement
		SMSOnAcknowledgement.EditAttrs.UpdateAttribute "class", "form-control"
		SMSOnAcknowledgement.EditCustomAttributes = ""
		SMSOnAcknowledgement.EditValue = SMSOnAcknowledgement.CurrentValue
		SMSOnAcknowledgement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(SMSOnAcknowledgement.FldCaption))

		' LocalPrinterURL
		LocalPrinterURL.EditAttrs.UpdateAttribute "class", "form-control"
		LocalPrinterURL.EditCustomAttributes = ""
		LocalPrinterURL.EditValue = LocalPrinterURL.CurrentValue
		LocalPrinterURL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(LocalPrinterURL.FldCaption))

		' ShowRestaurantDetailOnReceipt
		ShowRestaurantDetailOnReceipt.EditAttrs.UpdateAttribute "class", "form-control"
		ShowRestaurantDetailOnReceipt.EditCustomAttributes = ""
		ShowRestaurantDetailOnReceipt.EditValue = ShowRestaurantDetailOnReceipt.CurrentValue
		ShowRestaurantDetailOnReceipt.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(ShowRestaurantDetailOnReceipt.FldCaption))

		' PrinterFontSizeRatio
		PrinterFontSizeRatio.EditAttrs.UpdateAttribute "class", "form-control"
		PrinterFontSizeRatio.EditCustomAttributes = ""
		PrinterFontSizeRatio.EditValue = PrinterFontSizeRatio.CurrentValue
		PrinterFontSizeRatio.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PrinterFontSizeRatio.FldCaption))
		If PrinterFontSizeRatio.EditValue&"" <> "" And IsNumeric(PrinterFontSizeRatio.EditValue) Then PrinterFontSizeRatio.EditValue = ew_FormatNumber2(PrinterFontSizeRatio.EditValue, -2)

		' ServiceChargePercentage
		ServiceChargePercentage.EditAttrs.UpdateAttribute "class", "form-control"
		ServiceChargePercentage.EditCustomAttributes = ""
		ServiceChargePercentage.EditValue = ServiceChargePercentage.CurrentValue
		ServiceChargePercentage.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(ServiceChargePercentage.FldCaption))
		If ServiceChargePercentage.EditValue&"" <> "" And IsNumeric(ServiceChargePercentage.EditValue) Then ServiceChargePercentage.EditValue = ew_FormatNumber2(ServiceChargePercentage.EditValue, -2)

		' InRestaurantServiceChargeOnly
		InRestaurantServiceChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
		InRestaurantServiceChargeOnly.EditCustomAttributes = ""
		InRestaurantServiceChargeOnly.EditValue = InRestaurantServiceChargeOnly.CurrentValue
		InRestaurantServiceChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(InRestaurantServiceChargeOnly.FldCaption))

		' IsDualReceiptPrinting
		IsDualReceiptPrinting.EditAttrs.UpdateAttribute "class", "form-control"
		IsDualReceiptPrinting.EditCustomAttributes = ""
		IsDualReceiptPrinting.EditValue = IsDualReceiptPrinting.CurrentValue
		IsDualReceiptPrinting.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(IsDualReceiptPrinting.FldCaption))

		' PrintingFontSize
		PrintingFontSize.EditAttrs.UpdateAttribute "class", "form-control"
		PrintingFontSize.EditCustomAttributes = ""
		PrintingFontSize.EditValue = PrintingFontSize.CurrentValue
		PrintingFontSize.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(PrintingFontSize.FldCaption))
		If PrintingFontSize.EditValue&"" <> "" And IsNumeric(PrintingFontSize.EditValue) Then PrintingFontSize.EditValue = ew_FormatNumber2(PrintingFontSize.EditValue, -2)

		' InRestaurantEpsonPrinterIDList
		InRestaurantEpsonPrinterIDList.EditAttrs.UpdateAttribute "class", "form-control"
		InRestaurantEpsonPrinterIDList.EditCustomAttributes = ""
		InRestaurantEpsonPrinterIDList.EditValue = InRestaurantEpsonPrinterIDList.CurrentValue
		InRestaurantEpsonPrinterIDList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(InRestaurantEpsonPrinterIDList.FldCaption))

		' BlockIPEmailList
		BlockIPEmailList.EditAttrs.UpdateAttribute "class", "form-control"
		BlockIPEmailList.EditCustomAttributes = ""
		BlockIPEmailList.EditValue = BlockIPEmailList.CurrentValue
		BlockIPEmailList.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(BlockIPEmailList.FldCaption))

		' inmenuannouncement
		inmenuannouncement.EditAttrs.UpdateAttribute "class", "form-control"
		inmenuannouncement.EditCustomAttributes = ""
		inmenuannouncement.EditValue = inmenuannouncement.CurrentValue
		inmenuannouncement.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(inmenuannouncement.FldCaption))

		' RePrintReceiptWays
		RePrintReceiptWays.EditAttrs.UpdateAttribute "class", "form-control"
		RePrintReceiptWays.EditCustomAttributes = ""
		RePrintReceiptWays.EditValue = RePrintReceiptWays.CurrentValue
		RePrintReceiptWays.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(RePrintReceiptWays.FldCaption))

		' printingtype
		printingtype.EditAttrs.UpdateAttribute "class", "form-control"
		printingtype.EditCustomAttributes = ""
		printingtype.EditValue = printingtype.CurrentValue
		printingtype.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(printingtype.FldCaption))

		' Stripe_Key_Secret
		Stripe_Key_Secret.EditAttrs.UpdateAttribute "class", "form-control"
		Stripe_Key_Secret.EditCustomAttributes = ""
		Stripe_Key_Secret.EditValue = Stripe_Key_Secret.CurrentValue
		Stripe_Key_Secret.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Stripe_Key_Secret.FldCaption))

		' Stripe
		Stripe.EditAttrs.UpdateAttribute "class", "form-control"
		Stripe.EditCustomAttributes = ""
		Stripe.EditValue = Stripe.CurrentValue
		Stripe.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Stripe.FldCaption))

		' Stripe_Api_Key
		Stripe_Api_Key.EditAttrs.UpdateAttribute "class", "form-control"
		Stripe_Api_Key.EditCustomAttributes = ""
		Stripe_Api_Key.EditValue = Stripe_Api_Key.CurrentValue
		Stripe_Api_Key.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Stripe_Api_Key.FldCaption))

		' EnableBooking
		EnableBooking.EditAttrs.UpdateAttribute "class", "form-control"
		EnableBooking.EditCustomAttributes = ""
		EnableBooking.EditValue = EnableBooking.CurrentValue
		EnableBooking.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(EnableBooking.FldCaption))

		' URL_Facebook
		URL_Facebook.EditAttrs.UpdateAttribute "class", "form-control"
		URL_Facebook.EditCustomAttributes = ""
		URL_Facebook.EditValue = URL_Facebook.CurrentValue
		URL_Facebook.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_Facebook.FldCaption))

		' URL_Twitter
		URL_Twitter.EditAttrs.UpdateAttribute "class", "form-control"
		URL_Twitter.EditCustomAttributes = ""
		URL_Twitter.EditValue = URL_Twitter.CurrentValue
		URL_Twitter.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_Twitter.FldCaption))

		' URL_Google
		URL_Google.EditAttrs.UpdateAttribute "class", "form-control"
		URL_Google.EditCustomAttributes = ""
		URL_Google.EditValue = URL_Google.CurrentValue
		URL_Google.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_Google.FldCaption))

		' URL_Intagram
		URL_Intagram.EditAttrs.UpdateAttribute "class", "form-control"
		URL_Intagram.EditCustomAttributes = ""
		URL_Intagram.EditValue = URL_Intagram.CurrentValue
		URL_Intagram.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_Intagram.FldCaption))

		' URL_YouTube
		URL_YouTube.EditAttrs.UpdateAttribute "class", "form-control"
		URL_YouTube.EditCustomAttributes = ""
		URL_YouTube.EditValue = URL_YouTube.CurrentValue
		URL_YouTube.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_YouTube.FldCaption))

		' URL_Tripadvisor
		URL_Tripadvisor.EditAttrs.UpdateAttribute "class", "form-control"
		URL_Tripadvisor.EditCustomAttributes = ""
		URL_Tripadvisor.EditValue = URL_Tripadvisor.CurrentValue
		URL_Tripadvisor.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_Tripadvisor.FldCaption))

		' URL_Special_Offer
		URL_Special_Offer.EditAttrs.UpdateAttribute "class", "form-control"
		URL_Special_Offer.EditCustomAttributes = ""
		URL_Special_Offer.EditValue = URL_Special_Offer.CurrentValue
		URL_Special_Offer.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_Special_Offer.FldCaption))

		' URL_Linkin
		URL_Linkin.EditAttrs.UpdateAttribute "class", "form-control"
		URL_Linkin.EditCustomAttributes = ""
		URL_Linkin.EditValue = URL_Linkin.CurrentValue
		URL_Linkin.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(URL_Linkin.FldCaption))

		' Currency_PAYPAL
		Currency_PAYPAL.EditAttrs.UpdateAttribute "class", "form-control"
		Currency_PAYPAL.EditCustomAttributes = ""
		Currency_PAYPAL.EditValue = Currency_PAYPAL.CurrentValue
		Currency_PAYPAL.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Currency_PAYPAL.FldCaption))

		' Currency_STRIPE
		Currency_STRIPE.EditAttrs.UpdateAttribute "class", "form-control"
		Currency_STRIPE.EditCustomAttributes = ""
		Currency_STRIPE.EditValue = Currency_STRIPE.CurrentValue
		Currency_STRIPE.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Currency_STRIPE.FldCaption))

		' Currency_WOLRDPAY
		Currency_WOLRDPAY.EditAttrs.UpdateAttribute "class", "form-control"
		Currency_WOLRDPAY.EditCustomAttributes = ""
		Currency_WOLRDPAY.EditValue = Currency_WOLRDPAY.CurrentValue
		Currency_WOLRDPAY.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Currency_WOLRDPAY.FldCaption))

		' Tip_percent
		Tip_percent.EditAttrs.UpdateAttribute "class", "form-control"
		Tip_percent.EditCustomAttributes = ""
		Tip_percent.EditValue = Tip_percent.CurrentValue
		Tip_percent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Tip_percent.FldCaption))

		' Tax_Percent
		Tax_Percent.EditAttrs.UpdateAttribute "class", "form-control"
		Tax_Percent.EditCustomAttributes = ""
		Tax_Percent.EditValue = Tax_Percent.CurrentValue
		Tax_Percent.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Tax_Percent.FldCaption))

		' InRestaurantTaxChargeOnly
		InRestaurantTaxChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
		InRestaurantTaxChargeOnly.EditCustomAttributes = ""
		InRestaurantTaxChargeOnly.EditValue = InRestaurantTaxChargeOnly.CurrentValue
		InRestaurantTaxChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(InRestaurantTaxChargeOnly.FldCaption))

		' InRestaurantTipChargeOnly
		InRestaurantTipChargeOnly.EditAttrs.UpdateAttribute "class", "form-control"
		InRestaurantTipChargeOnly.EditCustomAttributes = ""
		InRestaurantTipChargeOnly.EditValue = InRestaurantTipChargeOnly.CurrentValue
		InRestaurantTipChargeOnly.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(InRestaurantTipChargeOnly.FldCaption))

		' isCheckCapcha
		isCheckCapcha.EditAttrs.UpdateAttribute "class", "form-control"
		isCheckCapcha.EditCustomAttributes = ""
		isCheckCapcha.EditValue = isCheckCapcha.CurrentValue
		isCheckCapcha.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(isCheckCapcha.FldCaption))

		' Close_StartDate
		Close_StartDate.EditAttrs.UpdateAttribute "class", "form-control"
		Close_StartDate.EditCustomAttributes = ""
		Close_StartDate.EditValue = Close_StartDate.CurrentValue
		Close_StartDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Close_StartDate.FldCaption))

		' Close_EndDate
		Close_EndDate.EditAttrs.UpdateAttribute "class", "form-control"
		Close_EndDate.EditCustomAttributes = ""
		Close_EndDate.EditValue = Close_EndDate.CurrentValue
		Close_EndDate.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Close_EndDate.FldCaption))

		' Stripe_Country
		Stripe_Country.EditAttrs.UpdateAttribute "class", "form-control"
		Stripe_Country.EditCustomAttributes = ""
		Stripe_Country.EditValue = Stripe_Country.CurrentValue
		Stripe_Country.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Stripe_Country.FldCaption))

		' enable_StripePaymentButton
		enable_StripePaymentButton.EditAttrs.UpdateAttribute "class", "form-control"
		enable_StripePaymentButton.EditCustomAttributes = ""
		enable_StripePaymentButton.EditValue = enable_StripePaymentButton.CurrentValue
		enable_StripePaymentButton.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(enable_StripePaymentButton.FldCaption))

		' enable_CashPayment
		enable_CashPayment.EditAttrs.UpdateAttribute "class", "form-control"
		enable_CashPayment.EditCustomAttributes = ""
		enable_CashPayment.EditValue = enable_CashPayment.CurrentValue
		enable_CashPayment.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(enable_CashPayment.FldCaption))

		' DeliveryMile
		DeliveryMile.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryMile.EditCustomAttributes = ""
		DeliveryMile.EditValue = DeliveryMile.CurrentValue
		DeliveryMile.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryMile.FldCaption))
		If DeliveryMile.EditValue&"" <> "" And IsNumeric(DeliveryMile.EditValue) Then DeliveryMile.EditValue = ew_FormatNumber2(DeliveryMile.EditValue, -2)

		' Mon_Delivery
		Mon_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
		Mon_Delivery.EditCustomAttributes = ""
		Mon_Delivery.EditValue = Mon_Delivery.CurrentValue
		Mon_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Mon_Delivery.FldCaption))

		' Mon_Collection
		Mon_Collection.EditAttrs.UpdateAttribute "class", "form-control"
		Mon_Collection.EditCustomAttributes = ""
		Mon_Collection.EditValue = Mon_Collection.CurrentValue
		Mon_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Mon_Collection.FldCaption))

		' Tue_Delivery
		Tue_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
		Tue_Delivery.EditCustomAttributes = ""
		Tue_Delivery.EditValue = Tue_Delivery.CurrentValue
		Tue_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Tue_Delivery.FldCaption))

		' Tue_Collection
		Tue_Collection.EditAttrs.UpdateAttribute "class", "form-control"
		Tue_Collection.EditCustomAttributes = ""
		Tue_Collection.EditValue = Tue_Collection.CurrentValue
		Tue_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Tue_Collection.FldCaption))

		' Wed_Delivery
		Wed_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
		Wed_Delivery.EditCustomAttributes = ""
		Wed_Delivery.EditValue = Wed_Delivery.CurrentValue
		Wed_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Wed_Delivery.FldCaption))

		' Wed_Collection
		Wed_Collection.EditAttrs.UpdateAttribute "class", "form-control"
		Wed_Collection.EditCustomAttributes = ""
		Wed_Collection.EditValue = Wed_Collection.CurrentValue
		Wed_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Wed_Collection.FldCaption))

		' Thu_Delivery
		Thu_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
		Thu_Delivery.EditCustomAttributes = ""
		Thu_Delivery.EditValue = Thu_Delivery.CurrentValue
		Thu_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Thu_Delivery.FldCaption))

		' Thu_Collection
		Thu_Collection.EditAttrs.UpdateAttribute "class", "form-control"
		Thu_Collection.EditCustomAttributes = ""
		Thu_Collection.EditValue = Thu_Collection.CurrentValue
		Thu_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Thu_Collection.FldCaption))

		' Fri_Delivery
		Fri_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
		Fri_Delivery.EditCustomAttributes = ""
		Fri_Delivery.EditValue = Fri_Delivery.CurrentValue
		Fri_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Fri_Delivery.FldCaption))

		' Fri_Collection
		Fri_Collection.EditAttrs.UpdateAttribute "class", "form-control"
		Fri_Collection.EditCustomAttributes = ""
		Fri_Collection.EditValue = Fri_Collection.CurrentValue
		Fri_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Fri_Collection.FldCaption))

		' Sat_Delivery
		Sat_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
		Sat_Delivery.EditCustomAttributes = ""
		Sat_Delivery.EditValue = Sat_Delivery.CurrentValue
		Sat_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Sat_Delivery.FldCaption))

		' Sat_Collection
		Sat_Collection.EditAttrs.UpdateAttribute "class", "form-control"
		Sat_Collection.EditCustomAttributes = ""
		Sat_Collection.EditValue = Sat_Collection.CurrentValue
		Sat_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Sat_Collection.FldCaption))

		' Sun_Delivery
		Sun_Delivery.EditAttrs.UpdateAttribute "class", "form-control"
		Sun_Delivery.EditCustomAttributes = ""
		Sun_Delivery.EditValue = Sun_Delivery.CurrentValue
		Sun_Delivery.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Sun_Delivery.FldCaption))

		' Sun_Collection
		Sun_Collection.EditAttrs.UpdateAttribute "class", "form-control"
		Sun_Collection.EditCustomAttributes = ""
		Sun_Collection.EditValue = Sun_Collection.CurrentValue
		Sun_Collection.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Sun_Collection.FldCaption))

		' EnableUrlRewrite
		EnableUrlRewrite.EditAttrs.UpdateAttribute "class", "form-control"
		EnableUrlRewrite.EditCustomAttributes = ""
		EnableUrlRewrite.EditValue = EnableUrlRewrite.CurrentValue
		EnableUrlRewrite.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(EnableUrlRewrite.FldCaption))

		' DeliveryCostUpTo
		DeliveryCostUpTo.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryCostUpTo.EditCustomAttributes = ""
		DeliveryCostUpTo.EditValue = DeliveryCostUpTo.CurrentValue
		DeliveryCostUpTo.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryCostUpTo.FldCaption))
		If DeliveryCostUpTo.EditValue&"" <> "" And IsNumeric(DeliveryCostUpTo.EditValue) Then DeliveryCostUpTo.EditValue = ew_FormatNumber2(DeliveryCostUpTo.EditValue, -2)

		' DeliveryUptoMile
		DeliveryUptoMile.EditAttrs.UpdateAttribute "class", "form-control"
		DeliveryUptoMile.EditCustomAttributes = ""
		DeliveryUptoMile.EditValue = DeliveryUptoMile.CurrentValue
		DeliveryUptoMile.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(DeliveryUptoMile.FldCaption))
		If DeliveryUptoMile.EditValue&"" <> "" And IsNumeric(DeliveryUptoMile.EditValue) Then DeliveryUptoMile.EditValue = ew_FormatNumber2(DeliveryUptoMile.EditValue, -2)

		' Show_Ordernumner_printer
		Show_Ordernumner_printer.EditAttrs.UpdateAttribute "class", "form-control"
		Show_Ordernumner_printer.EditCustomAttributes = ""
		Show_Ordernumner_printer.EditValue = Show_Ordernumner_printer.CurrentValue
		Show_Ordernumner_printer.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Show_Ordernumner_printer.FldCaption))

		' Show_Ordernumner_Receipt
		Show_Ordernumner_Receipt.EditAttrs.UpdateAttribute "class", "form-control"
		Show_Ordernumner_Receipt.EditCustomAttributes = ""
		Show_Ordernumner_Receipt.EditValue = Show_Ordernumner_Receipt.CurrentValue
		Show_Ordernumner_Receipt.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Show_Ordernumner_Receipt.FldCaption))

		' Show_Ordernumner_Dashboard
		Show_Ordernumner_Dashboard.EditAttrs.UpdateAttribute "class", "form-control"
		Show_Ordernumner_Dashboard.EditCustomAttributes = ""
		Show_Ordernumner_Dashboard.EditValue = Show_Ordernumner_Dashboard.CurrentValue
		Show_Ordernumner_Dashboard.PlaceHolder = ew_HtmlEncode(ew_RemoveHtml(Show_Ordernumner_Dashboard.FldCaption))

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
					Call XmlDoc.AddField("Address", Address.ExportValue(Export))
					Call XmlDoc.AddField("PostalCode", PostalCode.ExportValue(Export))
					Call XmlDoc.AddField("FoodType", FoodType.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryMinAmount", DeliveryMinAmount.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryMaxDistance", DeliveryMaxDistance.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryFreeDistance", DeliveryFreeDistance.ExportValue(Export))
					Call XmlDoc.AddField("AverageDeliveryTime", AverageDeliveryTime.ExportValue(Export))
					Call XmlDoc.AddField("AverageCollectionTime", AverageCollectionTime.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryFee", DeliveryFee.ExportValue(Export))
					Call XmlDoc.AddField("ImgUrl", ImgUrl.ExportValue(Export))
					Call XmlDoc.AddField("Telephone", Telephone.ExportValue(Export))
					Call XmlDoc.AddField("zEmail", zEmail.ExportValue(Export))
					Call XmlDoc.AddField("pswd", pswd.ExportValue(Export))
					Call XmlDoc.AddField("businessclosed", businessclosed.ExportValue(Export))
					Call XmlDoc.AddField("announcement", announcement.ExportValue(Export))
					Call XmlDoc.AddField("css", css.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_AUTENTICATE", SMTP_AUTENTICATE.ExportValue(Export))
					Call XmlDoc.AddField("MAIL_FROM", MAIL_FROM.ExportValue(Export))
					Call XmlDoc.AddField("PAYPAL_URL", PAYPAL_URL.ExportValue(Export))
					Call XmlDoc.AddField("PAYPAL_PDT", PAYPAL_PDT.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_PASSWORD", SMTP_PASSWORD.ExportValue(Export))
					Call XmlDoc.AddField("GMAP_API_KEY", GMAP_API_KEY.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_USERNAME", SMTP_USERNAME.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_USESSL", SMTP_USESSL.ExportValue(Export))
					Call XmlDoc.AddField("MAIL_SUBJECT", MAIL_SUBJECT.ExportValue(Export))
					Call XmlDoc.AddField("CURRENCYSYMBOL", CURRENCYSYMBOL.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_SERVER", SMTP_SERVER.ExportValue(Export))
					Call XmlDoc.AddField("CREDITCARDSURCHARGE", CREDITCARDSURCHARGE.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_PORT", SMTP_PORT.ExportValue(Export))
					Call XmlDoc.AddField("STICK_MENU", STICK_MENU.ExportValue(Export))
					Call XmlDoc.AddField("MAIL_CUSTOMER_SUBJECT", MAIL_CUSTOMER_SUBJECT.ExportValue(Export))
					Call XmlDoc.AddField("CONFIRMATION_EMAIL_ADDRESS", CONFIRMATION_EMAIL_ADDRESS.ExportValue(Export))
					Call XmlDoc.AddField("SEND_ORDERS_TO_PRINTER", SEND_ORDERS_TO_PRINTER.ExportValue(Export))
					Call XmlDoc.AddField("timezone", timezone.ExportValue(Export))
					Call XmlDoc.AddField("PAYPAL_ADDR", PAYPAL_ADDR.ExportValue(Export))
					Call XmlDoc.AddField("nochex", nochex.ExportValue(Export))
					Call XmlDoc.AddField("nochexmerchantid", nochexmerchantid.ExportValue(Export))
					Call XmlDoc.AddField("paypal", paypal.ExportValue(Export))
					Call XmlDoc.AddField("IBT_API_KEY", IBT_API_KEY.ExportValue(Export))
					Call XmlDoc.AddField("IBP_API_PASSWORD", IBP_API_PASSWORD.ExportValue(Export))
					Call XmlDoc.AddField("disable_delivery", disable_delivery.ExportValue(Export))
					Call XmlDoc.AddField("disable_collection", disable_collection.ExportValue(Export))
					Call XmlDoc.AddField("worldpay", worldpay.ExportValue(Export))
					Call XmlDoc.AddField("worldpaymerchantid", worldpaymerchantid.ExportValue(Export))
					Call XmlDoc.AddField("backtohometext", backtohometext.ExportValue(Export))
					Call XmlDoc.AddField("closedtext", closedtext.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryChargeOverrideByOrderValue", DeliveryChargeOverrideByOrderValue.ExportValue(Export))
					Call XmlDoc.AddField("individualpostcodes", individualpostcodes.ExportValue(Export))
					Call XmlDoc.AddField("individualpostcodeschecking", individualpostcodeschecking.ExportValue(Export))
					Call XmlDoc.AddField("longitude", longitude.ExportValue(Export))
					Call XmlDoc.AddField("latitude", latitude.ExportValue(Export))
					Call XmlDoc.AddField("googleecommercetracking", googleecommercetracking.ExportValue(Export))
					Call XmlDoc.AddField("googleecommercetrackingcode", googleecommercetrackingcode.ExportValue(Export))
					Call XmlDoc.AddField("bringg", bringg.ExportValue(Export))
					Call XmlDoc.AddField("bringgurl", bringgurl.ExportValue(Export))
					Call XmlDoc.AddField("bringgcompanyid", bringgcompanyid.ExportValue(Export))
					Call XmlDoc.AddField("orderonlywhenopen", orderonlywhenopen.ExportValue(Export))
					Call XmlDoc.AddField("disablelaterdelivery", disablelaterdelivery.ExportValue(Export))
					Call XmlDoc.AddField("menupagetext", menupagetext.ExportValue(Export))
					Call XmlDoc.AddField("ordertodayonly", ordertodayonly.ExportValue(Export))
					Call XmlDoc.AddField("mileskm", mileskm.ExportValue(Export))
					Call XmlDoc.AddField("worldpaylive", worldpaylive.ExportValue(Export))
					Call XmlDoc.AddField("worldpayinstallationid", worldpayinstallationid.ExportValue(Export))
					Call XmlDoc.AddField("DistanceCalMethod", DistanceCalMethod.ExportValue(Export))
					Call XmlDoc.AddField("PrinterIDList", PrinterIDList.ExportValue(Export))
					Call XmlDoc.AddField("EpsonJSPrinterURL", EpsonJSPrinterURL.ExportValue(Export))
					Call XmlDoc.AddField("SMSEnable", SMSEnable.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnDelivery", SMSOnDelivery.ExportValue(Export))
					Call XmlDoc.AddField("SMSSupplierDomain", SMSSupplierDomain.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnOrder", SMSOnOrder.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnOrderAfterMin", SMSOnOrderAfterMin.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnOrderContent", SMSOnOrderContent.ExportValue(Export))
					Call XmlDoc.AddField("DefaultSMSCountryCode", DefaultSMSCountryCode.ExportValue(Export))
					Call XmlDoc.AddField("MinimumAmountForCardPayment", MinimumAmountForCardPayment.ExportValue(Export))
					Call XmlDoc.AddField("FavIconUrl", FavIconUrl.ExportValue(Export))
					Call XmlDoc.AddField("AddToHomeScreenURL", AddToHomeScreenURL.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnAcknowledgement", SMSOnAcknowledgement.ExportValue(Export))
					Call XmlDoc.AddField("LocalPrinterURL", LocalPrinterURL.ExportValue(Export))
					Call XmlDoc.AddField("ShowRestaurantDetailOnReceipt", ShowRestaurantDetailOnReceipt.ExportValue(Export))
					Call XmlDoc.AddField("PrinterFontSizeRatio", PrinterFontSizeRatio.ExportValue(Export))
					Call XmlDoc.AddField("ServiceChargePercentage", ServiceChargePercentage.ExportValue(Export))
					Call XmlDoc.AddField("InRestaurantServiceChargeOnly", InRestaurantServiceChargeOnly.ExportValue(Export))
					Call XmlDoc.AddField("IsDualReceiptPrinting", IsDualReceiptPrinting.ExportValue(Export))
					Call XmlDoc.AddField("PrintingFontSize", PrintingFontSize.ExportValue(Export))
					Call XmlDoc.AddField("InRestaurantEpsonPrinterIDList", InRestaurantEpsonPrinterIDList.ExportValue(Export))
					Call XmlDoc.AddField("BlockIPEmailList", BlockIPEmailList.ExportValue(Export))
					Call XmlDoc.AddField("inmenuannouncement", inmenuannouncement.ExportValue(Export))
					Call XmlDoc.AddField("RePrintReceiptWays", RePrintReceiptWays.ExportValue(Export))
					Call XmlDoc.AddField("printingtype", printingtype.ExportValue(Export))
					Call XmlDoc.AddField("Stripe_Key_Secret", Stripe_Key_Secret.ExportValue(Export))
					Call XmlDoc.AddField("Stripe", Stripe.ExportValue(Export))
					Call XmlDoc.AddField("Stripe_Api_Key", Stripe_Api_Key.ExportValue(Export))
					Call XmlDoc.AddField("EnableBooking", EnableBooking.ExportValue(Export))
					Call XmlDoc.AddField("URL_Facebook", URL_Facebook.ExportValue(Export))
					Call XmlDoc.AddField("URL_Twitter", URL_Twitter.ExportValue(Export))
					Call XmlDoc.AddField("URL_Google", URL_Google.ExportValue(Export))
					Call XmlDoc.AddField("URL_Intagram", URL_Intagram.ExportValue(Export))
					Call XmlDoc.AddField("URL_YouTube", URL_YouTube.ExportValue(Export))
					Call XmlDoc.AddField("URL_Tripadvisor", URL_Tripadvisor.ExportValue(Export))
					Call XmlDoc.AddField("URL_Special_Offer", URL_Special_Offer.ExportValue(Export))
					Call XmlDoc.AddField("URL_Linkin", URL_Linkin.ExportValue(Export))
					Call XmlDoc.AddField("Currency_PAYPAL", Currency_PAYPAL.ExportValue(Export))
					Call XmlDoc.AddField("Currency_STRIPE", Currency_STRIPE.ExportValue(Export))
					Call XmlDoc.AddField("Currency_WOLRDPAY", Currency_WOLRDPAY.ExportValue(Export))
					Call XmlDoc.AddField("Tip_percent", Tip_percent.ExportValue(Export))
					Call XmlDoc.AddField("Tax_Percent", Tax_Percent.ExportValue(Export))
					Call XmlDoc.AddField("InRestaurantTaxChargeOnly", InRestaurantTaxChargeOnly.ExportValue(Export))
					Call XmlDoc.AddField("InRestaurantTipChargeOnly", InRestaurantTipChargeOnly.ExportValue(Export))
					Call XmlDoc.AddField("isCheckCapcha", isCheckCapcha.ExportValue(Export))
					Call XmlDoc.AddField("Close_StartDate", Close_StartDate.ExportValue(Export))
					Call XmlDoc.AddField("Close_EndDate", Close_EndDate.ExportValue(Export))
					Call XmlDoc.AddField("Stripe_Country", Stripe_Country.ExportValue(Export))
					Call XmlDoc.AddField("enable_StripePaymentButton", enable_StripePaymentButton.ExportValue(Export))
					Call XmlDoc.AddField("enable_CashPayment", enable_CashPayment.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryMile", DeliveryMile.ExportValue(Export))
					Call XmlDoc.AddField("Mon_Delivery", Mon_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Mon_Collection", Mon_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Tue_Delivery", Tue_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Tue_Collection", Tue_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Wed_Delivery", Wed_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Wed_Collection", Wed_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Thu_Delivery", Thu_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Thu_Collection", Thu_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Fri_Delivery", Fri_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Fri_Collection", Fri_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Sat_Delivery", Sat_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Sat_Collection", Sat_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Sun_Delivery", Sun_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Sun_Collection", Sun_Collection.ExportValue(Export))
					Call XmlDoc.AddField("EnableUrlRewrite", EnableUrlRewrite.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryCostUpTo", DeliveryCostUpTo.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryUptoMile", DeliveryUptoMile.ExportValue(Export))
					Call XmlDoc.AddField("Show_Ordernumner_printer", Show_Ordernumner_printer.ExportValue(Export))
					Call XmlDoc.AddField("Show_Ordernumner_Receipt", Show_Ordernumner_Receipt.ExportValue(Export))
					Call XmlDoc.AddField("Show_Ordernumner_Dashboard", Show_Ordernumner_Dashboard.ExportValue(Export))
				Else
					Call XmlDoc.AddField("ID", ID.ExportValue(Export))
					Call XmlDoc.AddField("Name", Name.ExportValue(Export))
					Call XmlDoc.AddField("Address", Address.ExportValue(Export))
					Call XmlDoc.AddField("PostalCode", PostalCode.ExportValue(Export))
					Call XmlDoc.AddField("FoodType", FoodType.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryMinAmount", DeliveryMinAmount.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryMaxDistance", DeliveryMaxDistance.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryFreeDistance", DeliveryFreeDistance.ExportValue(Export))
					Call XmlDoc.AddField("AverageDeliveryTime", AverageDeliveryTime.ExportValue(Export))
					Call XmlDoc.AddField("AverageCollectionTime", AverageCollectionTime.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryFee", DeliveryFee.ExportValue(Export))
					Call XmlDoc.AddField("ImgUrl", ImgUrl.ExportValue(Export))
					Call XmlDoc.AddField("Telephone", Telephone.ExportValue(Export))
					Call XmlDoc.AddField("zEmail", zEmail.ExportValue(Export))
					Call XmlDoc.AddField("pswd", pswd.ExportValue(Export))
					Call XmlDoc.AddField("businessclosed", businessclosed.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_AUTENTICATE", SMTP_AUTENTICATE.ExportValue(Export))
					Call XmlDoc.AddField("MAIL_FROM", MAIL_FROM.ExportValue(Export))
					Call XmlDoc.AddField("PAYPAL_URL", PAYPAL_URL.ExportValue(Export))
					Call XmlDoc.AddField("PAYPAL_PDT", PAYPAL_PDT.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_PASSWORD", SMTP_PASSWORD.ExportValue(Export))
					Call XmlDoc.AddField("GMAP_API_KEY", GMAP_API_KEY.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_USERNAME", SMTP_USERNAME.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_USESSL", SMTP_USESSL.ExportValue(Export))
					Call XmlDoc.AddField("MAIL_SUBJECT", MAIL_SUBJECT.ExportValue(Export))
					Call XmlDoc.AddField("CURRENCYSYMBOL", CURRENCYSYMBOL.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_SERVER", SMTP_SERVER.ExportValue(Export))
					Call XmlDoc.AddField("CREDITCARDSURCHARGE", CREDITCARDSURCHARGE.ExportValue(Export))
					Call XmlDoc.AddField("SMTP_PORT", SMTP_PORT.ExportValue(Export))
					Call XmlDoc.AddField("STICK_MENU", STICK_MENU.ExportValue(Export))
					Call XmlDoc.AddField("MAIL_CUSTOMER_SUBJECT", MAIL_CUSTOMER_SUBJECT.ExportValue(Export))
					Call XmlDoc.AddField("CONFIRMATION_EMAIL_ADDRESS", CONFIRMATION_EMAIL_ADDRESS.ExportValue(Export))
					Call XmlDoc.AddField("SEND_ORDERS_TO_PRINTER", SEND_ORDERS_TO_PRINTER.ExportValue(Export))
					Call XmlDoc.AddField("timezone", timezone.ExportValue(Export))
					Call XmlDoc.AddField("PAYPAL_ADDR", PAYPAL_ADDR.ExportValue(Export))
					Call XmlDoc.AddField("nochex", nochex.ExportValue(Export))
					Call XmlDoc.AddField("nochexmerchantid", nochexmerchantid.ExportValue(Export))
					Call XmlDoc.AddField("paypal", paypal.ExportValue(Export))
					Call XmlDoc.AddField("IBT_API_KEY", IBT_API_KEY.ExportValue(Export))
					Call XmlDoc.AddField("IBP_API_PASSWORD", IBP_API_PASSWORD.ExportValue(Export))
					Call XmlDoc.AddField("disable_delivery", disable_delivery.ExportValue(Export))
					Call XmlDoc.AddField("disable_collection", disable_collection.ExportValue(Export))
					Call XmlDoc.AddField("worldpay", worldpay.ExportValue(Export))
					Call XmlDoc.AddField("worldpaymerchantid", worldpaymerchantid.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryChargeOverrideByOrderValue", DeliveryChargeOverrideByOrderValue.ExportValue(Export))
					Call XmlDoc.AddField("individualpostcodeschecking", individualpostcodeschecking.ExportValue(Export))
					Call XmlDoc.AddField("longitude", longitude.ExportValue(Export))
					Call XmlDoc.AddField("latitude", latitude.ExportValue(Export))
					Call XmlDoc.AddField("googleecommercetracking", googleecommercetracking.ExportValue(Export))
					Call XmlDoc.AddField("googleecommercetrackingcode", googleecommercetrackingcode.ExportValue(Export))
					Call XmlDoc.AddField("bringg", bringg.ExportValue(Export))
					Call XmlDoc.AddField("bringgurl", bringgurl.ExportValue(Export))
					Call XmlDoc.AddField("bringgcompanyid", bringgcompanyid.ExportValue(Export))
					Call XmlDoc.AddField("orderonlywhenopen", orderonlywhenopen.ExportValue(Export))
					Call XmlDoc.AddField("disablelaterdelivery", disablelaterdelivery.ExportValue(Export))
					Call XmlDoc.AddField("ordertodayonly", ordertodayonly.ExportValue(Export))
					Call XmlDoc.AddField("mileskm", mileskm.ExportValue(Export))
					Call XmlDoc.AddField("worldpaylive", worldpaylive.ExportValue(Export))
					Call XmlDoc.AddField("worldpayinstallationid", worldpayinstallationid.ExportValue(Export))
					Call XmlDoc.AddField("DistanceCalMethod", DistanceCalMethod.ExportValue(Export))
					Call XmlDoc.AddField("PrinterIDList", PrinterIDList.ExportValue(Export))
					Call XmlDoc.AddField("EpsonJSPrinterURL", EpsonJSPrinterURL.ExportValue(Export))
					Call XmlDoc.AddField("SMSEnable", SMSEnable.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnDelivery", SMSOnDelivery.ExportValue(Export))
					Call XmlDoc.AddField("SMSSupplierDomain", SMSSupplierDomain.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnOrder", SMSOnOrder.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnOrderAfterMin", SMSOnOrderAfterMin.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnOrderContent", SMSOnOrderContent.ExportValue(Export))
					Call XmlDoc.AddField("DefaultSMSCountryCode", DefaultSMSCountryCode.ExportValue(Export))
					Call XmlDoc.AddField("MinimumAmountForCardPayment", MinimumAmountForCardPayment.ExportValue(Export))
					Call XmlDoc.AddField("FavIconUrl", FavIconUrl.ExportValue(Export))
					Call XmlDoc.AddField("AddToHomeScreenURL", AddToHomeScreenURL.ExportValue(Export))
					Call XmlDoc.AddField("SMSOnAcknowledgement", SMSOnAcknowledgement.ExportValue(Export))
					Call XmlDoc.AddField("LocalPrinterURL", LocalPrinterURL.ExportValue(Export))
					Call XmlDoc.AddField("ShowRestaurantDetailOnReceipt", ShowRestaurantDetailOnReceipt.ExportValue(Export))
					Call XmlDoc.AddField("PrinterFontSizeRatio", PrinterFontSizeRatio.ExportValue(Export))
					Call XmlDoc.AddField("ServiceChargePercentage", ServiceChargePercentage.ExportValue(Export))
					Call XmlDoc.AddField("InRestaurantServiceChargeOnly", InRestaurantServiceChargeOnly.ExportValue(Export))
					Call XmlDoc.AddField("IsDualReceiptPrinting", IsDualReceiptPrinting.ExportValue(Export))
					Call XmlDoc.AddField("PrintingFontSize", PrintingFontSize.ExportValue(Export))
					Call XmlDoc.AddField("InRestaurantEpsonPrinterIDList", InRestaurantEpsonPrinterIDList.ExportValue(Export))
					Call XmlDoc.AddField("BlockIPEmailList", BlockIPEmailList.ExportValue(Export))
					Call XmlDoc.AddField("RePrintReceiptWays", RePrintReceiptWays.ExportValue(Export))
					Call XmlDoc.AddField("printingtype", printingtype.ExportValue(Export))
					Call XmlDoc.AddField("Stripe_Key_Secret", Stripe_Key_Secret.ExportValue(Export))
					Call XmlDoc.AddField("Stripe", Stripe.ExportValue(Export))
					Call XmlDoc.AddField("Stripe_Api_Key", Stripe_Api_Key.ExportValue(Export))
					Call XmlDoc.AddField("EnableBooking", EnableBooking.ExportValue(Export))
					Call XmlDoc.AddField("URL_Facebook", URL_Facebook.ExportValue(Export))
					Call XmlDoc.AddField("URL_Twitter", URL_Twitter.ExportValue(Export))
					Call XmlDoc.AddField("URL_Google", URL_Google.ExportValue(Export))
					Call XmlDoc.AddField("URL_Intagram", URL_Intagram.ExportValue(Export))
					Call XmlDoc.AddField("URL_YouTube", URL_YouTube.ExportValue(Export))
					Call XmlDoc.AddField("URL_Tripadvisor", URL_Tripadvisor.ExportValue(Export))
					Call XmlDoc.AddField("URL_Special_Offer", URL_Special_Offer.ExportValue(Export))
					Call XmlDoc.AddField("URL_Linkin", URL_Linkin.ExportValue(Export))
					Call XmlDoc.AddField("Currency_PAYPAL", Currency_PAYPAL.ExportValue(Export))
					Call XmlDoc.AddField("Currency_STRIPE", Currency_STRIPE.ExportValue(Export))
					Call XmlDoc.AddField("Currency_WOLRDPAY", Currency_WOLRDPAY.ExportValue(Export))
					Call XmlDoc.AddField("Tip_percent", Tip_percent.ExportValue(Export))
					Call XmlDoc.AddField("Tax_Percent", Tax_Percent.ExportValue(Export))
					Call XmlDoc.AddField("InRestaurantTaxChargeOnly", InRestaurantTaxChargeOnly.ExportValue(Export))
					Call XmlDoc.AddField("InRestaurantTipChargeOnly", InRestaurantTipChargeOnly.ExportValue(Export))
					Call XmlDoc.AddField("isCheckCapcha", isCheckCapcha.ExportValue(Export))
					Call XmlDoc.AddField("Close_StartDate", Close_StartDate.ExportValue(Export))
					Call XmlDoc.AddField("Close_EndDate", Close_EndDate.ExportValue(Export))
					Call XmlDoc.AddField("Stripe_Country", Stripe_Country.ExportValue(Export))
					Call XmlDoc.AddField("enable_StripePaymentButton", enable_StripePaymentButton.ExportValue(Export))
					Call XmlDoc.AddField("enable_CashPayment", enable_CashPayment.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryMile", DeliveryMile.ExportValue(Export))
					Call XmlDoc.AddField("Mon_Delivery", Mon_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Mon_Collection", Mon_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Tue_Delivery", Tue_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Tue_Collection", Tue_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Wed_Delivery", Wed_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Wed_Collection", Wed_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Thu_Delivery", Thu_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Thu_Collection", Thu_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Fri_Delivery", Fri_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Fri_Collection", Fri_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Sat_Delivery", Sat_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Sat_Collection", Sat_Collection.ExportValue(Export))
					Call XmlDoc.AddField("Sun_Delivery", Sun_Delivery.ExportValue(Export))
					Call XmlDoc.AddField("Sun_Collection", Sun_Collection.ExportValue(Export))
					Call XmlDoc.AddField("EnableUrlRewrite", EnableUrlRewrite.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryCostUpTo", DeliveryCostUpTo.ExportValue(Export))
					Call XmlDoc.AddField("DeliveryUptoMile", DeliveryUptoMile.ExportValue(Export))
					Call XmlDoc.AddField("Show_Ordernumner_printer", Show_Ordernumner_printer.ExportValue(Export))
					Call XmlDoc.AddField("Show_Ordernumner_Receipt", Show_Ordernumner_Receipt.ExportValue(Export))
					Call XmlDoc.AddField("Show_Ordernumner_Dashboard", Show_Ordernumner_Dashboard.ExportValue(Export))
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
					If Address.Exportable Then Call Doc.ExportCaption(Address)
					If PostalCode.Exportable Then Call Doc.ExportCaption(PostalCode)
					If FoodType.Exportable Then Call Doc.ExportCaption(FoodType)
					If DeliveryMinAmount.Exportable Then Call Doc.ExportCaption(DeliveryMinAmount)
					If DeliveryMaxDistance.Exportable Then Call Doc.ExportCaption(DeliveryMaxDistance)
					If DeliveryFreeDistance.Exportable Then Call Doc.ExportCaption(DeliveryFreeDistance)
					If AverageDeliveryTime.Exportable Then Call Doc.ExportCaption(AverageDeliveryTime)
					If AverageCollectionTime.Exportable Then Call Doc.ExportCaption(AverageCollectionTime)
					If DeliveryFee.Exportable Then Call Doc.ExportCaption(DeliveryFee)
					If ImgUrl.Exportable Then Call Doc.ExportCaption(ImgUrl)
					If Telephone.Exportable Then Call Doc.ExportCaption(Telephone)
					If zEmail.Exportable Then Call Doc.ExportCaption(zEmail)
					If pswd.Exportable Then Call Doc.ExportCaption(pswd)
					If businessclosed.Exportable Then Call Doc.ExportCaption(businessclosed)
					If announcement.Exportable Then Call Doc.ExportCaption(announcement)
					If css.Exportable Then Call Doc.ExportCaption(css)
					If SMTP_AUTENTICATE.Exportable Then Call Doc.ExportCaption(SMTP_AUTENTICATE)
					If MAIL_FROM.Exportable Then Call Doc.ExportCaption(MAIL_FROM)
					If PAYPAL_URL.Exportable Then Call Doc.ExportCaption(PAYPAL_URL)
					If PAYPAL_PDT.Exportable Then Call Doc.ExportCaption(PAYPAL_PDT)
					If SMTP_PASSWORD.Exportable Then Call Doc.ExportCaption(SMTP_PASSWORD)
					If GMAP_API_KEY.Exportable Then Call Doc.ExportCaption(GMAP_API_KEY)
					If SMTP_USERNAME.Exportable Then Call Doc.ExportCaption(SMTP_USERNAME)
					If SMTP_USESSL.Exportable Then Call Doc.ExportCaption(SMTP_USESSL)
					If MAIL_SUBJECT.Exportable Then Call Doc.ExportCaption(MAIL_SUBJECT)
					If CURRENCYSYMBOL.Exportable Then Call Doc.ExportCaption(CURRENCYSYMBOL)
					If SMTP_SERVER.Exportable Then Call Doc.ExportCaption(SMTP_SERVER)
					If CREDITCARDSURCHARGE.Exportable Then Call Doc.ExportCaption(CREDITCARDSURCHARGE)
					If SMTP_PORT.Exportable Then Call Doc.ExportCaption(SMTP_PORT)
					If STICK_MENU.Exportable Then Call Doc.ExportCaption(STICK_MENU)
					If MAIL_CUSTOMER_SUBJECT.Exportable Then Call Doc.ExportCaption(MAIL_CUSTOMER_SUBJECT)
					If CONFIRMATION_EMAIL_ADDRESS.Exportable Then Call Doc.ExportCaption(CONFIRMATION_EMAIL_ADDRESS)
					If SEND_ORDERS_TO_PRINTER.Exportable Then Call Doc.ExportCaption(SEND_ORDERS_TO_PRINTER)
					If timezone.Exportable Then Call Doc.ExportCaption(timezone)
					If PAYPAL_ADDR.Exportable Then Call Doc.ExportCaption(PAYPAL_ADDR)
					If nochex.Exportable Then Call Doc.ExportCaption(nochex)
					If nochexmerchantid.Exportable Then Call Doc.ExportCaption(nochexmerchantid)
					If paypal.Exportable Then Call Doc.ExportCaption(paypal)
					If IBT_API_KEY.Exportable Then Call Doc.ExportCaption(IBT_API_KEY)
					If IBP_API_PASSWORD.Exportable Then Call Doc.ExportCaption(IBP_API_PASSWORD)
					If disable_delivery.Exportable Then Call Doc.ExportCaption(disable_delivery)
					If disable_collection.Exportable Then Call Doc.ExportCaption(disable_collection)
					If worldpay.Exportable Then Call Doc.ExportCaption(worldpay)
					If worldpaymerchantid.Exportable Then Call Doc.ExportCaption(worldpaymerchantid)
					If backtohometext.Exportable Then Call Doc.ExportCaption(backtohometext)
					If closedtext.Exportable Then Call Doc.ExportCaption(closedtext)
					If DeliveryChargeOverrideByOrderValue.Exportable Then Call Doc.ExportCaption(DeliveryChargeOverrideByOrderValue)
					If individualpostcodes.Exportable Then Call Doc.ExportCaption(individualpostcodes)
					If individualpostcodeschecking.Exportable Then Call Doc.ExportCaption(individualpostcodeschecking)
					If longitude.Exportable Then Call Doc.ExportCaption(longitude)
					If latitude.Exportable Then Call Doc.ExportCaption(latitude)
					If googleecommercetracking.Exportable Then Call Doc.ExportCaption(googleecommercetracking)
					If googleecommercetrackingcode.Exportable Then Call Doc.ExportCaption(googleecommercetrackingcode)
					If bringg.Exportable Then Call Doc.ExportCaption(bringg)
					If bringgurl.Exportable Then Call Doc.ExportCaption(bringgurl)
					If bringgcompanyid.Exportable Then Call Doc.ExportCaption(bringgcompanyid)
					If orderonlywhenopen.Exportable Then Call Doc.ExportCaption(orderonlywhenopen)
					If disablelaterdelivery.Exportable Then Call Doc.ExportCaption(disablelaterdelivery)
					If menupagetext.Exportable Then Call Doc.ExportCaption(menupagetext)
					If ordertodayonly.Exportable Then Call Doc.ExportCaption(ordertodayonly)
					If mileskm.Exportable Then Call Doc.ExportCaption(mileskm)
					If worldpaylive.Exportable Then Call Doc.ExportCaption(worldpaylive)
					If worldpayinstallationid.Exportable Then Call Doc.ExportCaption(worldpayinstallationid)
					If DistanceCalMethod.Exportable Then Call Doc.ExportCaption(DistanceCalMethod)
					If PrinterIDList.Exportable Then Call Doc.ExportCaption(PrinterIDList)
					If EpsonJSPrinterURL.Exportable Then Call Doc.ExportCaption(EpsonJSPrinterURL)
					If SMSEnable.Exportable Then Call Doc.ExportCaption(SMSEnable)
					If SMSOnDelivery.Exportable Then Call Doc.ExportCaption(SMSOnDelivery)
					If SMSSupplierDomain.Exportable Then Call Doc.ExportCaption(SMSSupplierDomain)
					If SMSOnOrder.Exportable Then Call Doc.ExportCaption(SMSOnOrder)
					If SMSOnOrderAfterMin.Exportable Then Call Doc.ExportCaption(SMSOnOrderAfterMin)
					If SMSOnOrderContent.Exportable Then Call Doc.ExportCaption(SMSOnOrderContent)
					If DefaultSMSCountryCode.Exportable Then Call Doc.ExportCaption(DefaultSMSCountryCode)
					If MinimumAmountForCardPayment.Exportable Then Call Doc.ExportCaption(MinimumAmountForCardPayment)
					If FavIconUrl.Exportable Then Call Doc.ExportCaption(FavIconUrl)
					If AddToHomeScreenURL.Exportable Then Call Doc.ExportCaption(AddToHomeScreenURL)
					If SMSOnAcknowledgement.Exportable Then Call Doc.ExportCaption(SMSOnAcknowledgement)
					If LocalPrinterURL.Exportable Then Call Doc.ExportCaption(LocalPrinterURL)
					If ShowRestaurantDetailOnReceipt.Exportable Then Call Doc.ExportCaption(ShowRestaurantDetailOnReceipt)
					If PrinterFontSizeRatio.Exportable Then Call Doc.ExportCaption(PrinterFontSizeRatio)
					If ServiceChargePercentage.Exportable Then Call Doc.ExportCaption(ServiceChargePercentage)
					If InRestaurantServiceChargeOnly.Exportable Then Call Doc.ExportCaption(InRestaurantServiceChargeOnly)
					If IsDualReceiptPrinting.Exportable Then Call Doc.ExportCaption(IsDualReceiptPrinting)
					If PrintingFontSize.Exportable Then Call Doc.ExportCaption(PrintingFontSize)
					If InRestaurantEpsonPrinterIDList.Exportable Then Call Doc.ExportCaption(InRestaurantEpsonPrinterIDList)
					If BlockIPEmailList.Exportable Then Call Doc.ExportCaption(BlockIPEmailList)
					If inmenuannouncement.Exportable Then Call Doc.ExportCaption(inmenuannouncement)
					If RePrintReceiptWays.Exportable Then Call Doc.ExportCaption(RePrintReceiptWays)
					If printingtype.Exportable Then Call Doc.ExportCaption(printingtype)
					If Stripe_Key_Secret.Exportable Then Call Doc.ExportCaption(Stripe_Key_Secret)
					If Stripe.Exportable Then Call Doc.ExportCaption(Stripe)
					If Stripe_Api_Key.Exportable Then Call Doc.ExportCaption(Stripe_Api_Key)
					If EnableBooking.Exportable Then Call Doc.ExportCaption(EnableBooking)
					If URL_Facebook.Exportable Then Call Doc.ExportCaption(URL_Facebook)
					If URL_Twitter.Exportable Then Call Doc.ExportCaption(URL_Twitter)
					If URL_Google.Exportable Then Call Doc.ExportCaption(URL_Google)
					If URL_Intagram.Exportable Then Call Doc.ExportCaption(URL_Intagram)
					If URL_YouTube.Exportable Then Call Doc.ExportCaption(URL_YouTube)
					If URL_Tripadvisor.Exportable Then Call Doc.ExportCaption(URL_Tripadvisor)
					If URL_Special_Offer.Exportable Then Call Doc.ExportCaption(URL_Special_Offer)
					If URL_Linkin.Exportable Then Call Doc.ExportCaption(URL_Linkin)
					If Currency_PAYPAL.Exportable Then Call Doc.ExportCaption(Currency_PAYPAL)
					If Currency_STRIPE.Exportable Then Call Doc.ExportCaption(Currency_STRIPE)
					If Currency_WOLRDPAY.Exportable Then Call Doc.ExportCaption(Currency_WOLRDPAY)
					If Tip_percent.Exportable Then Call Doc.ExportCaption(Tip_percent)
					If Tax_Percent.Exportable Then Call Doc.ExportCaption(Tax_Percent)
					If InRestaurantTaxChargeOnly.Exportable Then Call Doc.ExportCaption(InRestaurantTaxChargeOnly)
					If InRestaurantTipChargeOnly.Exportable Then Call Doc.ExportCaption(InRestaurantTipChargeOnly)
					If isCheckCapcha.Exportable Then Call Doc.ExportCaption(isCheckCapcha)
					If Close_StartDate.Exportable Then Call Doc.ExportCaption(Close_StartDate)
					If Close_EndDate.Exportable Then Call Doc.ExportCaption(Close_EndDate)
					If Stripe_Country.Exportable Then Call Doc.ExportCaption(Stripe_Country)
					If enable_StripePaymentButton.Exportable Then Call Doc.ExportCaption(enable_StripePaymentButton)
					If enable_CashPayment.Exportable Then Call Doc.ExportCaption(enable_CashPayment)
					If DeliveryMile.Exportable Then Call Doc.ExportCaption(DeliveryMile)
					If Mon_Delivery.Exportable Then Call Doc.ExportCaption(Mon_Delivery)
					If Mon_Collection.Exportable Then Call Doc.ExportCaption(Mon_Collection)
					If Tue_Delivery.Exportable Then Call Doc.ExportCaption(Tue_Delivery)
					If Tue_Collection.Exportable Then Call Doc.ExportCaption(Tue_Collection)
					If Wed_Delivery.Exportable Then Call Doc.ExportCaption(Wed_Delivery)
					If Wed_Collection.Exportable Then Call Doc.ExportCaption(Wed_Collection)
					If Thu_Delivery.Exportable Then Call Doc.ExportCaption(Thu_Delivery)
					If Thu_Collection.Exportable Then Call Doc.ExportCaption(Thu_Collection)
					If Fri_Delivery.Exportable Then Call Doc.ExportCaption(Fri_Delivery)
					If Fri_Collection.Exportable Then Call Doc.ExportCaption(Fri_Collection)
					If Sat_Delivery.Exportable Then Call Doc.ExportCaption(Sat_Delivery)
					If Sat_Collection.Exportable Then Call Doc.ExportCaption(Sat_Collection)
					If Sun_Delivery.Exportable Then Call Doc.ExportCaption(Sun_Delivery)
					If Sun_Collection.Exportable Then Call Doc.ExportCaption(Sun_Collection)
					If EnableUrlRewrite.Exportable Then Call Doc.ExportCaption(EnableUrlRewrite)
					If DeliveryCostUpTo.Exportable Then Call Doc.ExportCaption(DeliveryCostUpTo)
					If DeliveryUptoMile.Exportable Then Call Doc.ExportCaption(DeliveryUptoMile)
					If Show_Ordernumner_printer.Exportable Then Call Doc.ExportCaption(Show_Ordernumner_printer)
					If Show_Ordernumner_Receipt.Exportable Then Call Doc.ExportCaption(Show_Ordernumner_Receipt)
					If Show_Ordernumner_Dashboard.Exportable Then Call Doc.ExportCaption(Show_Ordernumner_Dashboard)
				Else
					If ID.Exportable Then Call Doc.ExportCaption(ID)
					If Name.Exportable Then Call Doc.ExportCaption(Name)
					If Address.Exportable Then Call Doc.ExportCaption(Address)
					If PostalCode.Exportable Then Call Doc.ExportCaption(PostalCode)
					If FoodType.Exportable Then Call Doc.ExportCaption(FoodType)
					If DeliveryMinAmount.Exportable Then Call Doc.ExportCaption(DeliveryMinAmount)
					If DeliveryMaxDistance.Exportable Then Call Doc.ExportCaption(DeliveryMaxDistance)
					If DeliveryFreeDistance.Exportable Then Call Doc.ExportCaption(DeliveryFreeDistance)
					If AverageDeliveryTime.Exportable Then Call Doc.ExportCaption(AverageDeliveryTime)
					If AverageCollectionTime.Exportable Then Call Doc.ExportCaption(AverageCollectionTime)
					If DeliveryFee.Exportable Then Call Doc.ExportCaption(DeliveryFee)
					If ImgUrl.Exportable Then Call Doc.ExportCaption(ImgUrl)
					If Telephone.Exportable Then Call Doc.ExportCaption(Telephone)
					If zEmail.Exportable Then Call Doc.ExportCaption(zEmail)
					If pswd.Exportable Then Call Doc.ExportCaption(pswd)
					If businessclosed.Exportable Then Call Doc.ExportCaption(businessclosed)
					If SMTP_AUTENTICATE.Exportable Then Call Doc.ExportCaption(SMTP_AUTENTICATE)
					If MAIL_FROM.Exportable Then Call Doc.ExportCaption(MAIL_FROM)
					If PAYPAL_URL.Exportable Then Call Doc.ExportCaption(PAYPAL_URL)
					If PAYPAL_PDT.Exportable Then Call Doc.ExportCaption(PAYPAL_PDT)
					If SMTP_PASSWORD.Exportable Then Call Doc.ExportCaption(SMTP_PASSWORD)
					If GMAP_API_KEY.Exportable Then Call Doc.ExportCaption(GMAP_API_KEY)
					If SMTP_USERNAME.Exportable Then Call Doc.ExportCaption(SMTP_USERNAME)
					If SMTP_USESSL.Exportable Then Call Doc.ExportCaption(SMTP_USESSL)
					If MAIL_SUBJECT.Exportable Then Call Doc.ExportCaption(MAIL_SUBJECT)
					If CURRENCYSYMBOL.Exportable Then Call Doc.ExportCaption(CURRENCYSYMBOL)
					If SMTP_SERVER.Exportable Then Call Doc.ExportCaption(SMTP_SERVER)
					If CREDITCARDSURCHARGE.Exportable Then Call Doc.ExportCaption(CREDITCARDSURCHARGE)
					If SMTP_PORT.Exportable Then Call Doc.ExportCaption(SMTP_PORT)
					If STICK_MENU.Exportable Then Call Doc.ExportCaption(STICK_MENU)
					If MAIL_CUSTOMER_SUBJECT.Exportable Then Call Doc.ExportCaption(MAIL_CUSTOMER_SUBJECT)
					If CONFIRMATION_EMAIL_ADDRESS.Exportable Then Call Doc.ExportCaption(CONFIRMATION_EMAIL_ADDRESS)
					If SEND_ORDERS_TO_PRINTER.Exportable Then Call Doc.ExportCaption(SEND_ORDERS_TO_PRINTER)
					If timezone.Exportable Then Call Doc.ExportCaption(timezone)
					If PAYPAL_ADDR.Exportable Then Call Doc.ExportCaption(PAYPAL_ADDR)
					If nochex.Exportable Then Call Doc.ExportCaption(nochex)
					If nochexmerchantid.Exportable Then Call Doc.ExportCaption(nochexmerchantid)
					If paypal.Exportable Then Call Doc.ExportCaption(paypal)
					If IBT_API_KEY.Exportable Then Call Doc.ExportCaption(IBT_API_KEY)
					If IBP_API_PASSWORD.Exportable Then Call Doc.ExportCaption(IBP_API_PASSWORD)
					If disable_delivery.Exportable Then Call Doc.ExportCaption(disable_delivery)
					If disable_collection.Exportable Then Call Doc.ExportCaption(disable_collection)
					If worldpay.Exportable Then Call Doc.ExportCaption(worldpay)
					If worldpaymerchantid.Exportable Then Call Doc.ExportCaption(worldpaymerchantid)
					If DeliveryChargeOverrideByOrderValue.Exportable Then Call Doc.ExportCaption(DeliveryChargeOverrideByOrderValue)
					If individualpostcodeschecking.Exportable Then Call Doc.ExportCaption(individualpostcodeschecking)
					If longitude.Exportable Then Call Doc.ExportCaption(longitude)
					If latitude.Exportable Then Call Doc.ExportCaption(latitude)
					If googleecommercetracking.Exportable Then Call Doc.ExportCaption(googleecommercetracking)
					If googleecommercetrackingcode.Exportable Then Call Doc.ExportCaption(googleecommercetrackingcode)
					If bringg.Exportable Then Call Doc.ExportCaption(bringg)
					If bringgurl.Exportable Then Call Doc.ExportCaption(bringgurl)
					If bringgcompanyid.Exportable Then Call Doc.ExportCaption(bringgcompanyid)
					If orderonlywhenopen.Exportable Then Call Doc.ExportCaption(orderonlywhenopen)
					If disablelaterdelivery.Exportable Then Call Doc.ExportCaption(disablelaterdelivery)
					If ordertodayonly.Exportable Then Call Doc.ExportCaption(ordertodayonly)
					If mileskm.Exportable Then Call Doc.ExportCaption(mileskm)
					If worldpaylive.Exportable Then Call Doc.ExportCaption(worldpaylive)
					If worldpayinstallationid.Exportable Then Call Doc.ExportCaption(worldpayinstallationid)
					If DistanceCalMethod.Exportable Then Call Doc.ExportCaption(DistanceCalMethod)
					If PrinterIDList.Exportable Then Call Doc.ExportCaption(PrinterIDList)
					If EpsonJSPrinterURL.Exportable Then Call Doc.ExportCaption(EpsonJSPrinterURL)
					If SMSEnable.Exportable Then Call Doc.ExportCaption(SMSEnable)
					If SMSOnDelivery.Exportable Then Call Doc.ExportCaption(SMSOnDelivery)
					If SMSSupplierDomain.Exportable Then Call Doc.ExportCaption(SMSSupplierDomain)
					If SMSOnOrder.Exportable Then Call Doc.ExportCaption(SMSOnOrder)
					If SMSOnOrderAfterMin.Exportable Then Call Doc.ExportCaption(SMSOnOrderAfterMin)
					If SMSOnOrderContent.Exportable Then Call Doc.ExportCaption(SMSOnOrderContent)
					If DefaultSMSCountryCode.Exportable Then Call Doc.ExportCaption(DefaultSMSCountryCode)
					If MinimumAmountForCardPayment.Exportable Then Call Doc.ExportCaption(MinimumAmountForCardPayment)
					If FavIconUrl.Exportable Then Call Doc.ExportCaption(FavIconUrl)
					If AddToHomeScreenURL.Exportable Then Call Doc.ExportCaption(AddToHomeScreenURL)
					If SMSOnAcknowledgement.Exportable Then Call Doc.ExportCaption(SMSOnAcknowledgement)
					If LocalPrinterURL.Exportable Then Call Doc.ExportCaption(LocalPrinterURL)
					If ShowRestaurantDetailOnReceipt.Exportable Then Call Doc.ExportCaption(ShowRestaurantDetailOnReceipt)
					If PrinterFontSizeRatio.Exportable Then Call Doc.ExportCaption(PrinterFontSizeRatio)
					If ServiceChargePercentage.Exportable Then Call Doc.ExportCaption(ServiceChargePercentage)
					If InRestaurantServiceChargeOnly.Exportable Then Call Doc.ExportCaption(InRestaurantServiceChargeOnly)
					If IsDualReceiptPrinting.Exportable Then Call Doc.ExportCaption(IsDualReceiptPrinting)
					If PrintingFontSize.Exportable Then Call Doc.ExportCaption(PrintingFontSize)
					If InRestaurantEpsonPrinterIDList.Exportable Then Call Doc.ExportCaption(InRestaurantEpsonPrinterIDList)
					If BlockIPEmailList.Exportable Then Call Doc.ExportCaption(BlockIPEmailList)
					If RePrintReceiptWays.Exportable Then Call Doc.ExportCaption(RePrintReceiptWays)
					If printingtype.Exportable Then Call Doc.ExportCaption(printingtype)
					If Stripe_Key_Secret.Exportable Then Call Doc.ExportCaption(Stripe_Key_Secret)
					If Stripe.Exportable Then Call Doc.ExportCaption(Stripe)
					If Stripe_Api_Key.Exportable Then Call Doc.ExportCaption(Stripe_Api_Key)
					If EnableBooking.Exportable Then Call Doc.ExportCaption(EnableBooking)
					If URL_Facebook.Exportable Then Call Doc.ExportCaption(URL_Facebook)
					If URL_Twitter.Exportable Then Call Doc.ExportCaption(URL_Twitter)
					If URL_Google.Exportable Then Call Doc.ExportCaption(URL_Google)
					If URL_Intagram.Exportable Then Call Doc.ExportCaption(URL_Intagram)
					If URL_YouTube.Exportable Then Call Doc.ExportCaption(URL_YouTube)
					If URL_Tripadvisor.Exportable Then Call Doc.ExportCaption(URL_Tripadvisor)
					If URL_Special_Offer.Exportable Then Call Doc.ExportCaption(URL_Special_Offer)
					If URL_Linkin.Exportable Then Call Doc.ExportCaption(URL_Linkin)
					If Currency_PAYPAL.Exportable Then Call Doc.ExportCaption(Currency_PAYPAL)
					If Currency_STRIPE.Exportable Then Call Doc.ExportCaption(Currency_STRIPE)
					If Currency_WOLRDPAY.Exportable Then Call Doc.ExportCaption(Currency_WOLRDPAY)
					If Tip_percent.Exportable Then Call Doc.ExportCaption(Tip_percent)
					If Tax_Percent.Exportable Then Call Doc.ExportCaption(Tax_Percent)
					If InRestaurantTaxChargeOnly.Exportable Then Call Doc.ExportCaption(InRestaurantTaxChargeOnly)
					If InRestaurantTipChargeOnly.Exportable Then Call Doc.ExportCaption(InRestaurantTipChargeOnly)
					If isCheckCapcha.Exportable Then Call Doc.ExportCaption(isCheckCapcha)
					If Close_StartDate.Exportable Then Call Doc.ExportCaption(Close_StartDate)
					If Close_EndDate.Exportable Then Call Doc.ExportCaption(Close_EndDate)
					If Stripe_Country.Exportable Then Call Doc.ExportCaption(Stripe_Country)
					If enable_StripePaymentButton.Exportable Then Call Doc.ExportCaption(enable_StripePaymentButton)
					If enable_CashPayment.Exportable Then Call Doc.ExportCaption(enable_CashPayment)
					If DeliveryMile.Exportable Then Call Doc.ExportCaption(DeliveryMile)
					If Mon_Delivery.Exportable Then Call Doc.ExportCaption(Mon_Delivery)
					If Mon_Collection.Exportable Then Call Doc.ExportCaption(Mon_Collection)
					If Tue_Delivery.Exportable Then Call Doc.ExportCaption(Tue_Delivery)
					If Tue_Collection.Exportable Then Call Doc.ExportCaption(Tue_Collection)
					If Wed_Delivery.Exportable Then Call Doc.ExportCaption(Wed_Delivery)
					If Wed_Collection.Exportable Then Call Doc.ExportCaption(Wed_Collection)
					If Thu_Delivery.Exportable Then Call Doc.ExportCaption(Thu_Delivery)
					If Thu_Collection.Exportable Then Call Doc.ExportCaption(Thu_Collection)
					If Fri_Delivery.Exportable Then Call Doc.ExportCaption(Fri_Delivery)
					If Fri_Collection.Exportable Then Call Doc.ExportCaption(Fri_Collection)
					If Sat_Delivery.Exportable Then Call Doc.ExportCaption(Sat_Delivery)
					If Sat_Collection.Exportable Then Call Doc.ExportCaption(Sat_Collection)
					If Sun_Delivery.Exportable Then Call Doc.ExportCaption(Sun_Delivery)
					If Sun_Collection.Exportable Then Call Doc.ExportCaption(Sun_Collection)
					If EnableUrlRewrite.Exportable Then Call Doc.ExportCaption(EnableUrlRewrite)
					If DeliveryCostUpTo.Exportable Then Call Doc.ExportCaption(DeliveryCostUpTo)
					If DeliveryUptoMile.Exportable Then Call Doc.ExportCaption(DeliveryUptoMile)
					If Show_Ordernumner_printer.Exportable Then Call Doc.ExportCaption(Show_Ordernumner_printer)
					If Show_Ordernumner_Receipt.Exportable Then Call Doc.ExportCaption(Show_Ordernumner_Receipt)
					If Show_Ordernumner_Dashboard.Exportable Then Call Doc.ExportCaption(Show_Ordernumner_Dashboard)
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
						If Address.Exportable Then Call Doc.ExportField(Address)
						If PostalCode.Exportable Then Call Doc.ExportField(PostalCode)
						If FoodType.Exportable Then Call Doc.ExportField(FoodType)
						If DeliveryMinAmount.Exportable Then Call Doc.ExportField(DeliveryMinAmount)
						If DeliveryMaxDistance.Exportable Then Call Doc.ExportField(DeliveryMaxDistance)
						If DeliveryFreeDistance.Exportable Then Call Doc.ExportField(DeliveryFreeDistance)
						If AverageDeliveryTime.Exportable Then Call Doc.ExportField(AverageDeliveryTime)
						If AverageCollectionTime.Exportable Then Call Doc.ExportField(AverageCollectionTime)
						If DeliveryFee.Exportable Then Call Doc.ExportField(DeliveryFee)
						If ImgUrl.Exportable Then Call Doc.ExportField(ImgUrl)
						If Telephone.Exportable Then Call Doc.ExportField(Telephone)
						If zEmail.Exportable Then Call Doc.ExportField(zEmail)
						If pswd.Exportable Then Call Doc.ExportField(pswd)
						If businessclosed.Exportable Then Call Doc.ExportField(businessclosed)
						If announcement.Exportable Then Call Doc.ExportField(announcement)
						If css.Exportable Then Call Doc.ExportField(css)
						If SMTP_AUTENTICATE.Exportable Then Call Doc.ExportField(SMTP_AUTENTICATE)
						If MAIL_FROM.Exportable Then Call Doc.ExportField(MAIL_FROM)
						If PAYPAL_URL.Exportable Then Call Doc.ExportField(PAYPAL_URL)
						If PAYPAL_PDT.Exportable Then Call Doc.ExportField(PAYPAL_PDT)
						If SMTP_PASSWORD.Exportable Then Call Doc.ExportField(SMTP_PASSWORD)
						If GMAP_API_KEY.Exportable Then Call Doc.ExportField(GMAP_API_KEY)
						If SMTP_USERNAME.Exportable Then Call Doc.ExportField(SMTP_USERNAME)
						If SMTP_USESSL.Exportable Then Call Doc.ExportField(SMTP_USESSL)
						If MAIL_SUBJECT.Exportable Then Call Doc.ExportField(MAIL_SUBJECT)
						If CURRENCYSYMBOL.Exportable Then Call Doc.ExportField(CURRENCYSYMBOL)
						If SMTP_SERVER.Exportable Then Call Doc.ExportField(SMTP_SERVER)
						If CREDITCARDSURCHARGE.Exportable Then Call Doc.ExportField(CREDITCARDSURCHARGE)
						If SMTP_PORT.Exportable Then Call Doc.ExportField(SMTP_PORT)
						If STICK_MENU.Exportable Then Call Doc.ExportField(STICK_MENU)
						If MAIL_CUSTOMER_SUBJECT.Exportable Then Call Doc.ExportField(MAIL_CUSTOMER_SUBJECT)
						If CONFIRMATION_EMAIL_ADDRESS.Exportable Then Call Doc.ExportField(CONFIRMATION_EMAIL_ADDRESS)
						If SEND_ORDERS_TO_PRINTER.Exportable Then Call Doc.ExportField(SEND_ORDERS_TO_PRINTER)
						If timezone.Exportable Then Call Doc.ExportField(timezone)
						If PAYPAL_ADDR.Exportable Then Call Doc.ExportField(PAYPAL_ADDR)
						If nochex.Exportable Then Call Doc.ExportField(nochex)
						If nochexmerchantid.Exportable Then Call Doc.ExportField(nochexmerchantid)
						If paypal.Exportable Then Call Doc.ExportField(paypal)
						If IBT_API_KEY.Exportable Then Call Doc.ExportField(IBT_API_KEY)
						If IBP_API_PASSWORD.Exportable Then Call Doc.ExportField(IBP_API_PASSWORD)
						If disable_delivery.Exportable Then Call Doc.ExportField(disable_delivery)
						If disable_collection.Exportable Then Call Doc.ExportField(disable_collection)
						If worldpay.Exportable Then Call Doc.ExportField(worldpay)
						If worldpaymerchantid.Exportable Then Call Doc.ExportField(worldpaymerchantid)
						If backtohometext.Exportable Then Call Doc.ExportField(backtohometext)
						If closedtext.Exportable Then Call Doc.ExportField(closedtext)
						If DeliveryChargeOverrideByOrderValue.Exportable Then Call Doc.ExportField(DeliveryChargeOverrideByOrderValue)
						If individualpostcodes.Exportable Then Call Doc.ExportField(individualpostcodes)
						If individualpostcodeschecking.Exportable Then Call Doc.ExportField(individualpostcodeschecking)
						If longitude.Exportable Then Call Doc.ExportField(longitude)
						If latitude.Exportable Then Call Doc.ExportField(latitude)
						If googleecommercetracking.Exportable Then Call Doc.ExportField(googleecommercetracking)
						If googleecommercetrackingcode.Exportable Then Call Doc.ExportField(googleecommercetrackingcode)
						If bringg.Exportable Then Call Doc.ExportField(bringg)
						If bringgurl.Exportable Then Call Doc.ExportField(bringgurl)
						If bringgcompanyid.Exportable Then Call Doc.ExportField(bringgcompanyid)
						If orderonlywhenopen.Exportable Then Call Doc.ExportField(orderonlywhenopen)
						If disablelaterdelivery.Exportable Then Call Doc.ExportField(disablelaterdelivery)
						If menupagetext.Exportable Then Call Doc.ExportField(menupagetext)
						If ordertodayonly.Exportable Then Call Doc.ExportField(ordertodayonly)
						If mileskm.Exportable Then Call Doc.ExportField(mileskm)
						If worldpaylive.Exportable Then Call Doc.ExportField(worldpaylive)
						If worldpayinstallationid.Exportable Then Call Doc.ExportField(worldpayinstallationid)
						If DistanceCalMethod.Exportable Then Call Doc.ExportField(DistanceCalMethod)
						If PrinterIDList.Exportable Then Call Doc.ExportField(PrinterIDList)
						If EpsonJSPrinterURL.Exportable Then Call Doc.ExportField(EpsonJSPrinterURL)
						If SMSEnable.Exportable Then Call Doc.ExportField(SMSEnable)
						If SMSOnDelivery.Exportable Then Call Doc.ExportField(SMSOnDelivery)
						If SMSSupplierDomain.Exportable Then Call Doc.ExportField(SMSSupplierDomain)
						If SMSOnOrder.Exportable Then Call Doc.ExportField(SMSOnOrder)
						If SMSOnOrderAfterMin.Exportable Then Call Doc.ExportField(SMSOnOrderAfterMin)
						If SMSOnOrderContent.Exportable Then Call Doc.ExportField(SMSOnOrderContent)
						If DefaultSMSCountryCode.Exportable Then Call Doc.ExportField(DefaultSMSCountryCode)
						If MinimumAmountForCardPayment.Exportable Then Call Doc.ExportField(MinimumAmountForCardPayment)
						If FavIconUrl.Exportable Then Call Doc.ExportField(FavIconUrl)
						If AddToHomeScreenURL.Exportable Then Call Doc.ExportField(AddToHomeScreenURL)
						If SMSOnAcknowledgement.Exportable Then Call Doc.ExportField(SMSOnAcknowledgement)
						If LocalPrinterURL.Exportable Then Call Doc.ExportField(LocalPrinterURL)
						If ShowRestaurantDetailOnReceipt.Exportable Then Call Doc.ExportField(ShowRestaurantDetailOnReceipt)
						If PrinterFontSizeRatio.Exportable Then Call Doc.ExportField(PrinterFontSizeRatio)
						If ServiceChargePercentage.Exportable Then Call Doc.ExportField(ServiceChargePercentage)
						If InRestaurantServiceChargeOnly.Exportable Then Call Doc.ExportField(InRestaurantServiceChargeOnly)
						If IsDualReceiptPrinting.Exportable Then Call Doc.ExportField(IsDualReceiptPrinting)
						If PrintingFontSize.Exportable Then Call Doc.ExportField(PrintingFontSize)
						If InRestaurantEpsonPrinterIDList.Exportable Then Call Doc.ExportField(InRestaurantEpsonPrinterIDList)
						If BlockIPEmailList.Exportable Then Call Doc.ExportField(BlockIPEmailList)
						If inmenuannouncement.Exportable Then Call Doc.ExportField(inmenuannouncement)
						If RePrintReceiptWays.Exportable Then Call Doc.ExportField(RePrintReceiptWays)
						If printingtype.Exportable Then Call Doc.ExportField(printingtype)
						If Stripe_Key_Secret.Exportable Then Call Doc.ExportField(Stripe_Key_Secret)
						If Stripe.Exportable Then Call Doc.ExportField(Stripe)
						If Stripe_Api_Key.Exportable Then Call Doc.ExportField(Stripe_Api_Key)
						If EnableBooking.Exportable Then Call Doc.ExportField(EnableBooking)
						If URL_Facebook.Exportable Then Call Doc.ExportField(URL_Facebook)
						If URL_Twitter.Exportable Then Call Doc.ExportField(URL_Twitter)
						If URL_Google.Exportable Then Call Doc.ExportField(URL_Google)
						If URL_Intagram.Exportable Then Call Doc.ExportField(URL_Intagram)
						If URL_YouTube.Exportable Then Call Doc.ExportField(URL_YouTube)
						If URL_Tripadvisor.Exportable Then Call Doc.ExportField(URL_Tripadvisor)
						If URL_Special_Offer.Exportable Then Call Doc.ExportField(URL_Special_Offer)
						If URL_Linkin.Exportable Then Call Doc.ExportField(URL_Linkin)
						If Currency_PAYPAL.Exportable Then Call Doc.ExportField(Currency_PAYPAL)
						If Currency_STRIPE.Exportable Then Call Doc.ExportField(Currency_STRIPE)
						If Currency_WOLRDPAY.Exportable Then Call Doc.ExportField(Currency_WOLRDPAY)
						If Tip_percent.Exportable Then Call Doc.ExportField(Tip_percent)
						If Tax_Percent.Exportable Then Call Doc.ExportField(Tax_Percent)
						If InRestaurantTaxChargeOnly.Exportable Then Call Doc.ExportField(InRestaurantTaxChargeOnly)
						If InRestaurantTipChargeOnly.Exportable Then Call Doc.ExportField(InRestaurantTipChargeOnly)
						If isCheckCapcha.Exportable Then Call Doc.ExportField(isCheckCapcha)
						If Close_StartDate.Exportable Then Call Doc.ExportField(Close_StartDate)
						If Close_EndDate.Exportable Then Call Doc.ExportField(Close_EndDate)
						If Stripe_Country.Exportable Then Call Doc.ExportField(Stripe_Country)
						If enable_StripePaymentButton.Exportable Then Call Doc.ExportField(enable_StripePaymentButton)
						If enable_CashPayment.Exportable Then Call Doc.ExportField(enable_CashPayment)
						If DeliveryMile.Exportable Then Call Doc.ExportField(DeliveryMile)
						If Mon_Delivery.Exportable Then Call Doc.ExportField(Mon_Delivery)
						If Mon_Collection.Exportable Then Call Doc.ExportField(Mon_Collection)
						If Tue_Delivery.Exportable Then Call Doc.ExportField(Tue_Delivery)
						If Tue_Collection.Exportable Then Call Doc.ExportField(Tue_Collection)
						If Wed_Delivery.Exportable Then Call Doc.ExportField(Wed_Delivery)
						If Wed_Collection.Exportable Then Call Doc.ExportField(Wed_Collection)
						If Thu_Delivery.Exportable Then Call Doc.ExportField(Thu_Delivery)
						If Thu_Collection.Exportable Then Call Doc.ExportField(Thu_Collection)
						If Fri_Delivery.Exportable Then Call Doc.ExportField(Fri_Delivery)
						If Fri_Collection.Exportable Then Call Doc.ExportField(Fri_Collection)
						If Sat_Delivery.Exportable Then Call Doc.ExportField(Sat_Delivery)
						If Sat_Collection.Exportable Then Call Doc.ExportField(Sat_Collection)
						If Sun_Delivery.Exportable Then Call Doc.ExportField(Sun_Delivery)
						If Sun_Collection.Exportable Then Call Doc.ExportField(Sun_Collection)
						If EnableUrlRewrite.Exportable Then Call Doc.ExportField(EnableUrlRewrite)
						If DeliveryCostUpTo.Exportable Then Call Doc.ExportField(DeliveryCostUpTo)
						If DeliveryUptoMile.Exportable Then Call Doc.ExportField(DeliveryUptoMile)
						If Show_Ordernumner_printer.Exportable Then Call Doc.ExportField(Show_Ordernumner_printer)
						If Show_Ordernumner_Receipt.Exportable Then Call Doc.ExportField(Show_Ordernumner_Receipt)
						If Show_Ordernumner_Dashboard.Exportable Then Call Doc.ExportField(Show_Ordernumner_Dashboard)
					Else
						If ID.Exportable Then Call Doc.ExportField(ID)
						If Name.Exportable Then Call Doc.ExportField(Name)
						If Address.Exportable Then Call Doc.ExportField(Address)
						If PostalCode.Exportable Then Call Doc.ExportField(PostalCode)
						If FoodType.Exportable Then Call Doc.ExportField(FoodType)
						If DeliveryMinAmount.Exportable Then Call Doc.ExportField(DeliveryMinAmount)
						If DeliveryMaxDistance.Exportable Then Call Doc.ExportField(DeliveryMaxDistance)
						If DeliveryFreeDistance.Exportable Then Call Doc.ExportField(DeliveryFreeDistance)
						If AverageDeliveryTime.Exportable Then Call Doc.ExportField(AverageDeliveryTime)
						If AverageCollectionTime.Exportable Then Call Doc.ExportField(AverageCollectionTime)
						If DeliveryFee.Exportable Then Call Doc.ExportField(DeliveryFee)
						If ImgUrl.Exportable Then Call Doc.ExportField(ImgUrl)
						If Telephone.Exportable Then Call Doc.ExportField(Telephone)
						If zEmail.Exportable Then Call Doc.ExportField(zEmail)
						If pswd.Exportable Then Call Doc.ExportField(pswd)
						If businessclosed.Exportable Then Call Doc.ExportField(businessclosed)
						If SMTP_AUTENTICATE.Exportable Then Call Doc.ExportField(SMTP_AUTENTICATE)
						If MAIL_FROM.Exportable Then Call Doc.ExportField(MAIL_FROM)
						If PAYPAL_URL.Exportable Then Call Doc.ExportField(PAYPAL_URL)
						If PAYPAL_PDT.Exportable Then Call Doc.ExportField(PAYPAL_PDT)
						If SMTP_PASSWORD.Exportable Then Call Doc.ExportField(SMTP_PASSWORD)
						If GMAP_API_KEY.Exportable Then Call Doc.ExportField(GMAP_API_KEY)
						If SMTP_USERNAME.Exportable Then Call Doc.ExportField(SMTP_USERNAME)
						If SMTP_USESSL.Exportable Then Call Doc.ExportField(SMTP_USESSL)
						If MAIL_SUBJECT.Exportable Then Call Doc.ExportField(MAIL_SUBJECT)
						If CURRENCYSYMBOL.Exportable Then Call Doc.ExportField(CURRENCYSYMBOL)
						If SMTP_SERVER.Exportable Then Call Doc.ExportField(SMTP_SERVER)
						If CREDITCARDSURCHARGE.Exportable Then Call Doc.ExportField(CREDITCARDSURCHARGE)
						If SMTP_PORT.Exportable Then Call Doc.ExportField(SMTP_PORT)
						If STICK_MENU.Exportable Then Call Doc.ExportField(STICK_MENU)
						If MAIL_CUSTOMER_SUBJECT.Exportable Then Call Doc.ExportField(MAIL_CUSTOMER_SUBJECT)
						If CONFIRMATION_EMAIL_ADDRESS.Exportable Then Call Doc.ExportField(CONFIRMATION_EMAIL_ADDRESS)
						If SEND_ORDERS_TO_PRINTER.Exportable Then Call Doc.ExportField(SEND_ORDERS_TO_PRINTER)
						If timezone.Exportable Then Call Doc.ExportField(timezone)
						If PAYPAL_ADDR.Exportable Then Call Doc.ExportField(PAYPAL_ADDR)
						If nochex.Exportable Then Call Doc.ExportField(nochex)
						If nochexmerchantid.Exportable Then Call Doc.ExportField(nochexmerchantid)
						If paypal.Exportable Then Call Doc.ExportField(paypal)
						If IBT_API_KEY.Exportable Then Call Doc.ExportField(IBT_API_KEY)
						If IBP_API_PASSWORD.Exportable Then Call Doc.ExportField(IBP_API_PASSWORD)
						If disable_delivery.Exportable Then Call Doc.ExportField(disable_delivery)
						If disable_collection.Exportable Then Call Doc.ExportField(disable_collection)
						If worldpay.Exportable Then Call Doc.ExportField(worldpay)
						If worldpaymerchantid.Exportable Then Call Doc.ExportField(worldpaymerchantid)
						If DeliveryChargeOverrideByOrderValue.Exportable Then Call Doc.ExportField(DeliveryChargeOverrideByOrderValue)
						If individualpostcodeschecking.Exportable Then Call Doc.ExportField(individualpostcodeschecking)
						If longitude.Exportable Then Call Doc.ExportField(longitude)
						If latitude.Exportable Then Call Doc.ExportField(latitude)
						If googleecommercetracking.Exportable Then Call Doc.ExportField(googleecommercetracking)
						If googleecommercetrackingcode.Exportable Then Call Doc.ExportField(googleecommercetrackingcode)
						If bringg.Exportable Then Call Doc.ExportField(bringg)
						If bringgurl.Exportable Then Call Doc.ExportField(bringgurl)
						If bringgcompanyid.Exportable Then Call Doc.ExportField(bringgcompanyid)
						If orderonlywhenopen.Exportable Then Call Doc.ExportField(orderonlywhenopen)
						If disablelaterdelivery.Exportable Then Call Doc.ExportField(disablelaterdelivery)
						If ordertodayonly.Exportable Then Call Doc.ExportField(ordertodayonly)
						If mileskm.Exportable Then Call Doc.ExportField(mileskm)
						If worldpaylive.Exportable Then Call Doc.ExportField(worldpaylive)
						If worldpayinstallationid.Exportable Then Call Doc.ExportField(worldpayinstallationid)
						If DistanceCalMethod.Exportable Then Call Doc.ExportField(DistanceCalMethod)
						If PrinterIDList.Exportable Then Call Doc.ExportField(PrinterIDList)
						If EpsonJSPrinterURL.Exportable Then Call Doc.ExportField(EpsonJSPrinterURL)
						If SMSEnable.Exportable Then Call Doc.ExportField(SMSEnable)
						If SMSOnDelivery.Exportable Then Call Doc.ExportField(SMSOnDelivery)
						If SMSSupplierDomain.Exportable Then Call Doc.ExportField(SMSSupplierDomain)
						If SMSOnOrder.Exportable Then Call Doc.ExportField(SMSOnOrder)
						If SMSOnOrderAfterMin.Exportable Then Call Doc.ExportField(SMSOnOrderAfterMin)
						If SMSOnOrderContent.Exportable Then Call Doc.ExportField(SMSOnOrderContent)
						If DefaultSMSCountryCode.Exportable Then Call Doc.ExportField(DefaultSMSCountryCode)
						If MinimumAmountForCardPayment.Exportable Then Call Doc.ExportField(MinimumAmountForCardPayment)
						If FavIconUrl.Exportable Then Call Doc.ExportField(FavIconUrl)
						If AddToHomeScreenURL.Exportable Then Call Doc.ExportField(AddToHomeScreenURL)
						If SMSOnAcknowledgement.Exportable Then Call Doc.ExportField(SMSOnAcknowledgement)
						If LocalPrinterURL.Exportable Then Call Doc.ExportField(LocalPrinterURL)
						If ShowRestaurantDetailOnReceipt.Exportable Then Call Doc.ExportField(ShowRestaurantDetailOnReceipt)
						If PrinterFontSizeRatio.Exportable Then Call Doc.ExportField(PrinterFontSizeRatio)
						If ServiceChargePercentage.Exportable Then Call Doc.ExportField(ServiceChargePercentage)
						If InRestaurantServiceChargeOnly.Exportable Then Call Doc.ExportField(InRestaurantServiceChargeOnly)
						If IsDualReceiptPrinting.Exportable Then Call Doc.ExportField(IsDualReceiptPrinting)
						If PrintingFontSize.Exportable Then Call Doc.ExportField(PrintingFontSize)
						If InRestaurantEpsonPrinterIDList.Exportable Then Call Doc.ExportField(InRestaurantEpsonPrinterIDList)
						If BlockIPEmailList.Exportable Then Call Doc.ExportField(BlockIPEmailList)
						If RePrintReceiptWays.Exportable Then Call Doc.ExportField(RePrintReceiptWays)
						If printingtype.Exportable Then Call Doc.ExportField(printingtype)
						If Stripe_Key_Secret.Exportable Then Call Doc.ExportField(Stripe_Key_Secret)
						If Stripe.Exportable Then Call Doc.ExportField(Stripe)
						If Stripe_Api_Key.Exportable Then Call Doc.ExportField(Stripe_Api_Key)
						If EnableBooking.Exportable Then Call Doc.ExportField(EnableBooking)
						If URL_Facebook.Exportable Then Call Doc.ExportField(URL_Facebook)
						If URL_Twitter.Exportable Then Call Doc.ExportField(URL_Twitter)
						If URL_Google.Exportable Then Call Doc.ExportField(URL_Google)
						If URL_Intagram.Exportable Then Call Doc.ExportField(URL_Intagram)
						If URL_YouTube.Exportable Then Call Doc.ExportField(URL_YouTube)
						If URL_Tripadvisor.Exportable Then Call Doc.ExportField(URL_Tripadvisor)
						If URL_Special_Offer.Exportable Then Call Doc.ExportField(URL_Special_Offer)
						If URL_Linkin.Exportable Then Call Doc.ExportField(URL_Linkin)
						If Currency_PAYPAL.Exportable Then Call Doc.ExportField(Currency_PAYPAL)
						If Currency_STRIPE.Exportable Then Call Doc.ExportField(Currency_STRIPE)
						If Currency_WOLRDPAY.Exportable Then Call Doc.ExportField(Currency_WOLRDPAY)
						If Tip_percent.Exportable Then Call Doc.ExportField(Tip_percent)
						If Tax_Percent.Exportable Then Call Doc.ExportField(Tax_Percent)
						If InRestaurantTaxChargeOnly.Exportable Then Call Doc.ExportField(InRestaurantTaxChargeOnly)
						If InRestaurantTipChargeOnly.Exportable Then Call Doc.ExportField(InRestaurantTipChargeOnly)
						If isCheckCapcha.Exportable Then Call Doc.ExportField(isCheckCapcha)
						If Close_StartDate.Exportable Then Call Doc.ExportField(Close_StartDate)
						If Close_EndDate.Exportable Then Call Doc.ExportField(Close_EndDate)
						If Stripe_Country.Exportable Then Call Doc.ExportField(Stripe_Country)
						If enable_StripePaymentButton.Exportable Then Call Doc.ExportField(enable_StripePaymentButton)
						If enable_CashPayment.Exportable Then Call Doc.ExportField(enable_CashPayment)
						If DeliveryMile.Exportable Then Call Doc.ExportField(DeliveryMile)
						If Mon_Delivery.Exportable Then Call Doc.ExportField(Mon_Delivery)
						If Mon_Collection.Exportable Then Call Doc.ExportField(Mon_Collection)
						If Tue_Delivery.Exportable Then Call Doc.ExportField(Tue_Delivery)
						If Tue_Collection.Exportable Then Call Doc.ExportField(Tue_Collection)
						If Wed_Delivery.Exportable Then Call Doc.ExportField(Wed_Delivery)
						If Wed_Collection.Exportable Then Call Doc.ExportField(Wed_Collection)
						If Thu_Delivery.Exportable Then Call Doc.ExportField(Thu_Delivery)
						If Thu_Collection.Exportable Then Call Doc.ExportField(Thu_Collection)
						If Fri_Delivery.Exportable Then Call Doc.ExportField(Fri_Delivery)
						If Fri_Collection.Exportable Then Call Doc.ExportField(Fri_Collection)
						If Sat_Delivery.Exportable Then Call Doc.ExportField(Sat_Delivery)
						If Sat_Collection.Exportable Then Call Doc.ExportField(Sat_Collection)
						If Sun_Delivery.Exportable Then Call Doc.ExportField(Sun_Delivery)
						If Sun_Collection.Exportable Then Call Doc.ExportField(Sun_Collection)
						If EnableUrlRewrite.Exportable Then Call Doc.ExportField(EnableUrlRewrite)
						If DeliveryCostUpTo.Exportable Then Call Doc.ExportField(DeliveryCostUpTo)
						If DeliveryUptoMile.Exportable Then Call Doc.ExportField(DeliveryUptoMile)
						If Show_Ordernumner_printer.Exportable Then Call Doc.ExportField(Show_Ordernumner_printer)
						If Show_Ordernumner_Receipt.Exportable Then Call Doc.ExportField(Show_Ordernumner_Receipt)
						If Show_Ordernumner_Dashboard.Exportable Then Call Doc.ExportField(Show_Ordernumner_Dashboard)
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
			Set m_ID = NewFldObj("BusinessDetails", "BusinessDetails", "x_ID", "ID", "[ID]", "CAST([ID] AS NVARCHAR)", 3, 0, "[ID]", False, False, FALSE, "FORMATTED TEXT")
			m_ID.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set ID = m_ID
	End Property

	' Field Name
	Private m_Name

	Public Property Get Name()
		If Not IsObject(m_Name) Then
			Set m_Name = NewFldObj("BusinessDetails", "BusinessDetails", "x_Name", "Name", "[Name]", "[Name]", 202, 0, "[Name]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Name = m_Name
	End Property

	' Field Address
	Private m_Address

	Public Property Get Address()
		If Not IsObject(m_Address) Then
			Set m_Address = NewFldObj("BusinessDetails", "BusinessDetails", "x_Address", "Address", "[Address]", "[Address]", 202, 0, "[Address]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Address = m_Address
	End Property

	' Field PostalCode
	Private m_PostalCode

	Public Property Get PostalCode()
		If Not IsObject(m_PostalCode) Then
			Set m_PostalCode = NewFldObj("BusinessDetails", "BusinessDetails", "x_PostalCode", "PostalCode", "[PostalCode]", "[PostalCode]", 202, 0, "[PostalCode]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set PostalCode = m_PostalCode
	End Property

	' Field FoodType
	Private m_FoodType

	Public Property Get FoodType()
		If Not IsObject(m_FoodType) Then
			Set m_FoodType = NewFldObj("BusinessDetails", "BusinessDetails", "x_FoodType", "FoodType", "[FoodType]", "[FoodType]", 202, 0, "[FoodType]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set FoodType = m_FoodType
	End Property

	' Field DeliveryMinAmount
	Private m_DeliveryMinAmount

	Public Property Get DeliveryMinAmount()
		If Not IsObject(m_DeliveryMinAmount) Then
			Set m_DeliveryMinAmount = NewFldObj("BusinessDetails", "BusinessDetails", "x_DeliveryMinAmount", "DeliveryMinAmount", "[DeliveryMinAmount]", "CAST([DeliveryMinAmount] AS NVARCHAR)", 3, 0, "[DeliveryMinAmount]", False, False, FALSE, "FORMATTED TEXT")
			m_DeliveryMinAmount.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set DeliveryMinAmount = m_DeliveryMinAmount
	End Property

	' Field DeliveryMaxDistance
	Private m_DeliveryMaxDistance

	Public Property Get DeliveryMaxDistance()
		If Not IsObject(m_DeliveryMaxDistance) Then
			Set m_DeliveryMaxDistance = NewFldObj("BusinessDetails", "BusinessDetails", "x_DeliveryMaxDistance", "DeliveryMaxDistance", "[DeliveryMaxDistance]", "CAST([DeliveryMaxDistance] AS NVARCHAR)", 5, 0, "[DeliveryMaxDistance]", False, False, FALSE, "FORMATTED TEXT")
			m_DeliveryMaxDistance.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set DeliveryMaxDistance = m_DeliveryMaxDistance
	End Property

	' Field DeliveryFreeDistance
	Private m_DeliveryFreeDistance

	Public Property Get DeliveryFreeDistance()
		If Not IsObject(m_DeliveryFreeDistance) Then
			Set m_DeliveryFreeDistance = NewFldObj("BusinessDetails", "BusinessDetails", "x_DeliveryFreeDistance", "DeliveryFreeDistance", "[DeliveryFreeDistance]", "CAST([DeliveryFreeDistance] AS NVARCHAR)", 5, 0, "[DeliveryFreeDistance]", False, False, FALSE, "FORMATTED TEXT")
			m_DeliveryFreeDistance.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set DeliveryFreeDistance = m_DeliveryFreeDistance
	End Property

	' Field AverageDeliveryTime
	Private m_AverageDeliveryTime

	Public Property Get AverageDeliveryTime()
		If Not IsObject(m_AverageDeliveryTime) Then
			Set m_AverageDeliveryTime = NewFldObj("BusinessDetails", "BusinessDetails", "x_AverageDeliveryTime", "AverageDeliveryTime", "[AverageDeliveryTime]", "CAST([AverageDeliveryTime] AS NVARCHAR)", 3, 0, "[AverageDeliveryTime]", False, False, FALSE, "FORMATTED TEXT")
			m_AverageDeliveryTime.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set AverageDeliveryTime = m_AverageDeliveryTime
	End Property

	' Field AverageCollectionTime
	Private m_AverageCollectionTime

	Public Property Get AverageCollectionTime()
		If Not IsObject(m_AverageCollectionTime) Then
			Set m_AverageCollectionTime = NewFldObj("BusinessDetails", "BusinessDetails", "x_AverageCollectionTime", "AverageCollectionTime", "[AverageCollectionTime]", "CAST([AverageCollectionTime] AS NVARCHAR)", 3, 0, "[AverageCollectionTime]", False, False, FALSE, "FORMATTED TEXT")
			m_AverageCollectionTime.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set AverageCollectionTime = m_AverageCollectionTime
	End Property

	' Field DeliveryFee
	Private m_DeliveryFee

	Public Property Get DeliveryFee()
		If Not IsObject(m_DeliveryFee) Then
			Set m_DeliveryFee = NewFldObj("BusinessDetails", "BusinessDetails", "x_DeliveryFee", "DeliveryFee", "[DeliveryFee]", "CAST([DeliveryFee] AS NVARCHAR)", 6, 0, "[DeliveryFee]", False, False, FALSE, "FORMATTED TEXT")
			m_DeliveryFee.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set DeliveryFee = m_DeliveryFee
	End Property

	' Field ImgUrl
	Private m_ImgUrl

	Public Property Get ImgUrl()
		If Not IsObject(m_ImgUrl) Then
			Set m_ImgUrl = NewFldObj("BusinessDetails", "BusinessDetails", "x_ImgUrl", "ImgUrl", "[ImgUrl]", "[ImgUrl]", 202, 0, "[ImgUrl]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set ImgUrl = m_ImgUrl
	End Property

	' Field Telephone
	Private m_Telephone

	Public Property Get Telephone()
		If Not IsObject(m_Telephone) Then
			Set m_Telephone = NewFldObj("BusinessDetails", "BusinessDetails", "x_Telephone", "Telephone", "[Telephone]", "[Telephone]", 202, 0, "[Telephone]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Telephone = m_Telephone
	End Property

	' Field Email
	Private m_zEmail

	Public Property Get zEmail()
		If Not IsObject(m_zEmail) Then
			Set m_zEmail = NewFldObj("BusinessDetails", "BusinessDetails", "x_zEmail", "Email", "[Email]", "[Email]", 202, 0, "[Email]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set zEmail = m_zEmail
	End Property

	' Field pswd
	Private m_pswd

	Public Property Get pswd()
		If Not IsObject(m_pswd) Then
			Set m_pswd = NewFldObj("BusinessDetails", "BusinessDetails", "x_pswd", "pswd", "[pswd]", "[pswd]", 202, 0, "[pswd]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set pswd = m_pswd
	End Property

	' Field businessclosed
	Private m_businessclosed

	Public Property Get businessclosed()
		If Not IsObject(m_businessclosed) Then
			Set m_businessclosed = NewFldObj("BusinessDetails", "BusinessDetails", "x_businessclosed", "businessclosed", "[businessclosed]", "CAST([businessclosed] AS NVARCHAR)", 3, 0, "[businessclosed]", False, False, FALSE, "FORMATTED TEXT")
			m_businessclosed.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set businessclosed = m_businessclosed
	End Property

	' Field announcement
	Private m_announcement

	Public Property Get announcement()
		If Not IsObject(m_announcement) Then
			Set m_announcement = NewFldObj("BusinessDetails", "BusinessDetails", "x_announcement", "announcement", "[announcement]", "[announcement]", 203, 0, "[announcement]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set announcement = m_announcement
	End Property

	' Field css
	Private m_css

	Public Property Get css()
		If Not IsObject(m_css) Then
			Set m_css = NewFldObj("BusinessDetails", "BusinessDetails", "x_css", "css", "[css]", "[css]", 203, 0, "[css]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set css = m_css
	End Property

	' Field SMTP_AUTENTICATE
	Private m_SMTP_AUTENTICATE

	Public Property Get SMTP_AUTENTICATE()
		If Not IsObject(m_SMTP_AUTENTICATE) Then
			Set m_SMTP_AUTENTICATE = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMTP_AUTENTICATE", "SMTP_AUTENTICATE", "[SMTP_AUTENTICATE]", "[SMTP_AUTENTICATE]", 202, 0, "[SMTP_AUTENTICATE]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SMTP_AUTENTICATE = m_SMTP_AUTENTICATE
	End Property

	' Field MAIL_FROM
	Private m_MAIL_FROM

	Public Property Get MAIL_FROM()
		If Not IsObject(m_MAIL_FROM) Then
			Set m_MAIL_FROM = NewFldObj("BusinessDetails", "BusinessDetails", "x_MAIL_FROM", "MAIL_FROM", "[MAIL_FROM]", "[MAIL_FROM]", 202, 0, "[MAIL_FROM]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set MAIL_FROM = m_MAIL_FROM
	End Property

	' Field PAYPAL_URL
	Private m_PAYPAL_URL

	Public Property Get PAYPAL_URL()
		If Not IsObject(m_PAYPAL_URL) Then
			Set m_PAYPAL_URL = NewFldObj("BusinessDetails", "BusinessDetails", "x_PAYPAL_URL", "PAYPAL_URL", "[PAYPAL_URL]", "[PAYPAL_URL]", 202, 0, "[PAYPAL_URL]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set PAYPAL_URL = m_PAYPAL_URL
	End Property

	' Field PAYPAL_PDT
	Private m_PAYPAL_PDT

	Public Property Get PAYPAL_PDT()
		If Not IsObject(m_PAYPAL_PDT) Then
			Set m_PAYPAL_PDT = NewFldObj("BusinessDetails", "BusinessDetails", "x_PAYPAL_PDT", "PAYPAL_PDT", "[PAYPAL_PDT]", "[PAYPAL_PDT]", 202, 0, "[PAYPAL_PDT]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set PAYPAL_PDT = m_PAYPAL_PDT
	End Property

	' Field SMTP_PASSWORD
	Private m_SMTP_PASSWORD

	Public Property Get SMTP_PASSWORD()
		If Not IsObject(m_SMTP_PASSWORD) Then
			Set m_SMTP_PASSWORD = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMTP_PASSWORD", "SMTP_PASSWORD", "[SMTP_PASSWORD]", "[SMTP_PASSWORD]", 202, 0, "[SMTP_PASSWORD]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SMTP_PASSWORD = m_SMTP_PASSWORD
	End Property

	' Field GMAP_API_KEY
	Private m_GMAP_API_KEY

	Public Property Get GMAP_API_KEY()
		If Not IsObject(m_GMAP_API_KEY) Then
			Set m_GMAP_API_KEY = NewFldObj("BusinessDetails", "BusinessDetails", "x_GMAP_API_KEY", "GMAP_API_KEY", "[GMAP_API_KEY]", "[GMAP_API_KEY]", 202, 0, "[GMAP_API_KEY]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set GMAP_API_KEY = m_GMAP_API_KEY
	End Property

	' Field SMTP_USERNAME
	Private m_SMTP_USERNAME

	Public Property Get SMTP_USERNAME()
		If Not IsObject(m_SMTP_USERNAME) Then
			Set m_SMTP_USERNAME = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMTP_USERNAME", "SMTP_USERNAME", "[SMTP_USERNAME]", "[SMTP_USERNAME]", 202, 0, "[SMTP_USERNAME]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SMTP_USERNAME = m_SMTP_USERNAME
	End Property

	' Field SMTP_USESSL
	Private m_SMTP_USESSL

	Public Property Get SMTP_USESSL()
		If Not IsObject(m_SMTP_USESSL) Then
			Set m_SMTP_USESSL = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMTP_USESSL", "SMTP_USESSL", "[SMTP_USESSL]", "[SMTP_USESSL]", 202, 0, "[SMTP_USESSL]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SMTP_USESSL = m_SMTP_USESSL
	End Property

	' Field MAIL_SUBJECT
	Private m_MAIL_SUBJECT

	Public Property Get MAIL_SUBJECT()
		If Not IsObject(m_MAIL_SUBJECT) Then
			Set m_MAIL_SUBJECT = NewFldObj("BusinessDetails", "BusinessDetails", "x_MAIL_SUBJECT", "MAIL_SUBJECT", "[MAIL_SUBJECT]", "[MAIL_SUBJECT]", 202, 0, "[MAIL_SUBJECT]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set MAIL_SUBJECT = m_MAIL_SUBJECT
	End Property

	' Field CURRENCYSYMBOL
	Private m_CURRENCYSYMBOL

	Public Property Get CURRENCYSYMBOL()
		If Not IsObject(m_CURRENCYSYMBOL) Then
			Set m_CURRENCYSYMBOL = NewFldObj("BusinessDetails", "BusinessDetails", "x_CURRENCYSYMBOL", "CURRENCYSYMBOL", "[CURRENCYSYMBOL]", "[CURRENCYSYMBOL]", 202, 0, "[CURRENCYSYMBOL]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set CURRENCYSYMBOL = m_CURRENCYSYMBOL
	End Property

	' Field SMTP_SERVER
	Private m_SMTP_SERVER

	Public Property Get SMTP_SERVER()
		If Not IsObject(m_SMTP_SERVER) Then
			Set m_SMTP_SERVER = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMTP_SERVER", "SMTP_SERVER", "[SMTP_SERVER]", "[SMTP_SERVER]", 202, 0, "[SMTP_SERVER]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SMTP_SERVER = m_SMTP_SERVER
	End Property

	' Field CREDITCARDSURCHARGE
	Private m_CREDITCARDSURCHARGE

	Public Property Get CREDITCARDSURCHARGE()
		If Not IsObject(m_CREDITCARDSURCHARGE) Then
			Set m_CREDITCARDSURCHARGE = NewFldObj("BusinessDetails", "BusinessDetails", "x_CREDITCARDSURCHARGE", "CREDITCARDSURCHARGE", "[CREDITCARDSURCHARGE]", "[CREDITCARDSURCHARGE]", 202, 0, "[CREDITCARDSURCHARGE]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set CREDITCARDSURCHARGE = m_CREDITCARDSURCHARGE
	End Property

	' Field SMTP_PORT
	Private m_SMTP_PORT

	Public Property Get SMTP_PORT()
		If Not IsObject(m_SMTP_PORT) Then
			Set m_SMTP_PORT = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMTP_PORT", "SMTP_PORT", "[SMTP_PORT]", "[SMTP_PORT]", 202, 0, "[SMTP_PORT]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SMTP_PORT = m_SMTP_PORT
	End Property

	' Field STICK_MENU
	Private m_STICK_MENU

	Public Property Get STICK_MENU()
		If Not IsObject(m_STICK_MENU) Then
			Set m_STICK_MENU = NewFldObj("BusinessDetails", "BusinessDetails", "x_STICK_MENU", "STICK_MENU", "[STICK_MENU]", "[STICK_MENU]", 202, 0, "[STICK_MENU]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set STICK_MENU = m_STICK_MENU
	End Property

	' Field MAIL_CUSTOMER_SUBJECT
	Private m_MAIL_CUSTOMER_SUBJECT

	Public Property Get MAIL_CUSTOMER_SUBJECT()
		If Not IsObject(m_MAIL_CUSTOMER_SUBJECT) Then
			Set m_MAIL_CUSTOMER_SUBJECT = NewFldObj("BusinessDetails", "BusinessDetails", "x_MAIL_CUSTOMER_SUBJECT", "MAIL_CUSTOMER_SUBJECT", "[MAIL_CUSTOMER_SUBJECT]", "[MAIL_CUSTOMER_SUBJECT]", 202, 0, "[MAIL_CUSTOMER_SUBJECT]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set MAIL_CUSTOMER_SUBJECT = m_MAIL_CUSTOMER_SUBJECT
	End Property

	' Field CONFIRMATION_EMAIL_ADDRESS
	Private m_CONFIRMATION_EMAIL_ADDRESS

	Public Property Get CONFIRMATION_EMAIL_ADDRESS()
		If Not IsObject(m_CONFIRMATION_EMAIL_ADDRESS) Then
			Set m_CONFIRMATION_EMAIL_ADDRESS = NewFldObj("BusinessDetails", "BusinessDetails", "x_CONFIRMATION_EMAIL_ADDRESS", "CONFIRMATION_EMAIL_ADDRESS", "[CONFIRMATION_EMAIL_ADDRESS]", "[CONFIRMATION_EMAIL_ADDRESS]", 202, 0, "[CONFIRMATION_EMAIL_ADDRESS]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set CONFIRMATION_EMAIL_ADDRESS = m_CONFIRMATION_EMAIL_ADDRESS
	End Property

	' Field SEND_ORDERS_TO_PRINTER
	Private m_SEND_ORDERS_TO_PRINTER

	Public Property Get SEND_ORDERS_TO_PRINTER()
		If Not IsObject(m_SEND_ORDERS_TO_PRINTER) Then
			Set m_SEND_ORDERS_TO_PRINTER = NewFldObj("BusinessDetails", "BusinessDetails", "x_SEND_ORDERS_TO_PRINTER", "SEND_ORDERS_TO_PRINTER", "[SEND_ORDERS_TO_PRINTER]", "[SEND_ORDERS_TO_PRINTER]", 202, 0, "[SEND_ORDERS_TO_PRINTER]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SEND_ORDERS_TO_PRINTER = m_SEND_ORDERS_TO_PRINTER
	End Property

	' Field timezone
	Private m_timezone

	Public Property Get timezone()
		If Not IsObject(m_timezone) Then
			Set m_timezone = NewFldObj("BusinessDetails", "BusinessDetails", "x_timezone", "timezone", "[timezone]", "CAST([timezone] AS NVARCHAR)", 3, 0, "[timezone]", False, False, FALSE, "FORMATTED TEXT")
			m_timezone.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set timezone = m_timezone
	End Property

	' Field PAYPAL_ADDR
	Private m_PAYPAL_ADDR

	Public Property Get PAYPAL_ADDR()
		If Not IsObject(m_PAYPAL_ADDR) Then
			Set m_PAYPAL_ADDR = NewFldObj("BusinessDetails", "BusinessDetails", "x_PAYPAL_ADDR", "PAYPAL_ADDR", "[PAYPAL_ADDR]", "[PAYPAL_ADDR]", 202, 0, "[PAYPAL_ADDR]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set PAYPAL_ADDR = m_PAYPAL_ADDR
	End Property

	' Field nochex
	Private m_nochex

	Public Property Get nochex()
		If Not IsObject(m_nochex) Then
			Set m_nochex = NewFldObj("BusinessDetails", "BusinessDetails", "x_nochex", "nochex", "[nochex]", "[nochex]", 202, 0, "[nochex]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set nochex = m_nochex
	End Property

	' Field nochexmerchantid
	Private m_nochexmerchantid

	Public Property Get nochexmerchantid()
		If Not IsObject(m_nochexmerchantid) Then
			Set m_nochexmerchantid = NewFldObj("BusinessDetails", "BusinessDetails", "x_nochexmerchantid", "nochexmerchantid", "[nochexmerchantid]", "[nochexmerchantid]", 202, 0, "[nochexmerchantid]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set nochexmerchantid = m_nochexmerchantid
	End Property

	' Field paypal
	Private m_paypal

	Public Property Get paypal()
		If Not IsObject(m_paypal) Then
			Set m_paypal = NewFldObj("BusinessDetails", "BusinessDetails", "x_paypal", "paypal", "[paypal]", "[paypal]", 202, 0, "[paypal]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set paypal = m_paypal
	End Property

	' Field IBT_API_KEY
	Private m_IBT_API_KEY

	Public Property Get IBT_API_KEY()
		If Not IsObject(m_IBT_API_KEY) Then
			Set m_IBT_API_KEY = NewFldObj("BusinessDetails", "BusinessDetails", "x_IBT_API_KEY", "IBT_API_KEY", "[IBT_API_KEY]", "[IBT_API_KEY]", 202, 0, "[IBT_API_KEY]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set IBT_API_KEY = m_IBT_API_KEY
	End Property

	' Field IBP_API_PASSWORD
	Private m_IBP_API_PASSWORD

	Public Property Get IBP_API_PASSWORD()
		If Not IsObject(m_IBP_API_PASSWORD) Then
			Set m_IBP_API_PASSWORD = NewFldObj("BusinessDetails", "BusinessDetails", "x_IBP_API_PASSWORD", "IBP_API_PASSWORD", "[IBP_API_PASSWORD]", "[IBP_API_PASSWORD]", 202, 0, "[IBP_API_PASSWORD]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set IBP_API_PASSWORD = m_IBP_API_PASSWORD
	End Property

	' Field disable_delivery
	Private m_disable_delivery

	Public Property Get disable_delivery()
		If Not IsObject(m_disable_delivery) Then
			Set m_disable_delivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_disable_delivery", "disable_delivery", "[disable_delivery]", "[disable_delivery]", 202, 0, "[disable_delivery]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set disable_delivery = m_disable_delivery
	End Property

	' Field disable_collection
	Private m_disable_collection

	Public Property Get disable_collection()
		If Not IsObject(m_disable_collection) Then
			Set m_disable_collection = NewFldObj("BusinessDetails", "BusinessDetails", "x_disable_collection", "disable_collection", "[disable_collection]", "[disable_collection]", 202, 0, "[disable_collection]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set disable_collection = m_disable_collection
	End Property

	' Field worldpay
	Private m_worldpay

	Public Property Get worldpay()
		If Not IsObject(m_worldpay) Then
			Set m_worldpay = NewFldObj("BusinessDetails", "BusinessDetails", "x_worldpay", "worldpay", "[worldpay]", "[worldpay]", 202, 0, "[worldpay]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set worldpay = m_worldpay
	End Property

	' Field worldpaymerchantid
	Private m_worldpaymerchantid

	Public Property Get worldpaymerchantid()
		If Not IsObject(m_worldpaymerchantid) Then
			Set m_worldpaymerchantid = NewFldObj("BusinessDetails", "BusinessDetails", "x_worldpaymerchantid", "worldpaymerchantid", "[worldpaymerchantid]", "[worldpaymerchantid]", 202, 0, "[worldpaymerchantid]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set worldpaymerchantid = m_worldpaymerchantid
	End Property

	' Field backtohometext
	Private m_backtohometext

	Public Property Get backtohometext()
		If Not IsObject(m_backtohometext) Then
			Set m_backtohometext = NewFldObj("BusinessDetails", "BusinessDetails", "x_backtohometext", "backtohometext", "[backtohometext]", "[backtohometext]", 203, 0, "[backtohometext]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set backtohometext = m_backtohometext
	End Property

	' Field closedtext
	Private m_closedtext

	Public Property Get closedtext()
		If Not IsObject(m_closedtext) Then
			Set m_closedtext = NewFldObj("BusinessDetails", "BusinessDetails", "x_closedtext", "closedtext", "[closedtext]", "[closedtext]", 203, 0, "[closedtext]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set closedtext = m_closedtext
	End Property

	' Field DeliveryChargeOverrideByOrderValue
	Private m_DeliveryChargeOverrideByOrderValue

	Public Property Get DeliveryChargeOverrideByOrderValue()
		If Not IsObject(m_DeliveryChargeOverrideByOrderValue) Then
			Set m_DeliveryChargeOverrideByOrderValue = NewFldObj("BusinessDetails", "BusinessDetails", "x_DeliveryChargeOverrideByOrderValue", "DeliveryChargeOverrideByOrderValue", "[DeliveryChargeOverrideByOrderValue]", "[DeliveryChargeOverrideByOrderValue]", 202, 0, "[DeliveryChargeOverrideByOrderValue]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set DeliveryChargeOverrideByOrderValue = m_DeliveryChargeOverrideByOrderValue
	End Property

	' Field individualpostcodes
	Private m_individualpostcodes

	Public Property Get individualpostcodes()
		If Not IsObject(m_individualpostcodes) Then
			Set m_individualpostcodes = NewFldObj("BusinessDetails", "BusinessDetails", "x_individualpostcodes", "individualpostcodes", "[individualpostcodes]", "[individualpostcodes]", 203, 0, "[individualpostcodes]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set individualpostcodes = m_individualpostcodes
	End Property

	' Field individualpostcodeschecking
	Private m_individualpostcodeschecking

	Public Property Get individualpostcodeschecking()
		If Not IsObject(m_individualpostcodeschecking) Then
			Set m_individualpostcodeschecking = NewFldObj("BusinessDetails", "BusinessDetails", "x_individualpostcodeschecking", "individualpostcodeschecking", "[individualpostcodeschecking]", "CAST([individualpostcodeschecking] AS NVARCHAR)", 3, 0, "[individualpostcodeschecking]", False, False, FALSE, "FORMATTED TEXT")
			m_individualpostcodeschecking.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set individualpostcodeschecking = m_individualpostcodeschecking
	End Property

	' Field longitude
	Private m_longitude

	Public Property Get longitude()
		If Not IsObject(m_longitude) Then
			Set m_longitude = NewFldObj("BusinessDetails", "BusinessDetails", "x_longitude", "longitude", "[longitude]", "[longitude]", 202, 0, "[longitude]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set longitude = m_longitude
	End Property

	' Field latitude
	Private m_latitude

	Public Property Get latitude()
		If Not IsObject(m_latitude) Then
			Set m_latitude = NewFldObj("BusinessDetails", "BusinessDetails", "x_latitude", "latitude", "[latitude]", "[latitude]", 202, 0, "[latitude]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set latitude = m_latitude
	End Property

	' Field googleecommercetracking
	Private m_googleecommercetracking

	Public Property Get googleecommercetracking()
		If Not IsObject(m_googleecommercetracking) Then
			Set m_googleecommercetracking = NewFldObj("BusinessDetails", "BusinessDetails", "x_googleecommercetracking", "googleecommercetracking", "[googleecommercetracking]", "[googleecommercetracking]", 202, 0, "[googleecommercetracking]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set googleecommercetracking = m_googleecommercetracking
	End Property

	' Field googleecommercetrackingcode
	Private m_googleecommercetrackingcode

	Public Property Get googleecommercetrackingcode()
		If Not IsObject(m_googleecommercetrackingcode) Then
			Set m_googleecommercetrackingcode = NewFldObj("BusinessDetails", "BusinessDetails", "x_googleecommercetrackingcode", "googleecommercetrackingcode", "[googleecommercetrackingcode]", "[googleecommercetrackingcode]", 202, 0, "[googleecommercetrackingcode]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set googleecommercetrackingcode = m_googleecommercetrackingcode
	End Property

	' Field bringg
	Private m_bringg

	Public Property Get bringg()
		If Not IsObject(m_bringg) Then
			Set m_bringg = NewFldObj("BusinessDetails", "BusinessDetails", "x_bringg", "bringg", "[bringg]", "[bringg]", 202, 0, "[bringg]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set bringg = m_bringg
	End Property

	' Field bringgurl
	Private m_bringgurl

	Public Property Get bringgurl()
		If Not IsObject(m_bringgurl) Then
			Set m_bringgurl = NewFldObj("BusinessDetails", "BusinessDetails", "x_bringgurl", "bringgurl", "[bringgurl]", "[bringgurl]", 202, 0, "[bringgurl]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set bringgurl = m_bringgurl
	End Property

	' Field bringgcompanyid
	Private m_bringgcompanyid

	Public Property Get bringgcompanyid()
		If Not IsObject(m_bringgcompanyid) Then
			Set m_bringgcompanyid = NewFldObj("BusinessDetails", "BusinessDetails", "x_bringgcompanyid", "bringgcompanyid", "[bringgcompanyid]", "[bringgcompanyid]", 202, 0, "[bringgcompanyid]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set bringgcompanyid = m_bringgcompanyid
	End Property

	' Field orderonlywhenopen
	Private m_orderonlywhenopen

	Public Property Get orderonlywhenopen()
		If Not IsObject(m_orderonlywhenopen) Then
			Set m_orderonlywhenopen = NewFldObj("BusinessDetails", "BusinessDetails", "x_orderonlywhenopen", "orderonlywhenopen", "[orderonlywhenopen]", "CAST([orderonlywhenopen] AS NVARCHAR)", 3, 0, "[orderonlywhenopen]", False, False, FALSE, "FORMATTED TEXT")
			m_orderonlywhenopen.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set orderonlywhenopen = m_orderonlywhenopen
	End Property

	' Field disablelaterdelivery
	Private m_disablelaterdelivery

	Public Property Get disablelaterdelivery()
		If Not IsObject(m_disablelaterdelivery) Then
			Set m_disablelaterdelivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_disablelaterdelivery", "disablelaterdelivery", "[disablelaterdelivery]", "CAST([disablelaterdelivery] AS NVARCHAR)", 3, 0, "[disablelaterdelivery]", False, False, FALSE, "FORMATTED TEXT")
			m_disablelaterdelivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set disablelaterdelivery = m_disablelaterdelivery
	End Property

	' Field menupagetext
	Private m_menupagetext

	Public Property Get menupagetext()
		If Not IsObject(m_menupagetext) Then
			Set m_menupagetext = NewFldObj("BusinessDetails", "BusinessDetails", "x_menupagetext", "menupagetext", "[menupagetext]", "[menupagetext]", 203, 0, "[menupagetext]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set menupagetext = m_menupagetext
	End Property

	' Field ordertodayonly
	Private m_ordertodayonly

	Public Property Get ordertodayonly()
		If Not IsObject(m_ordertodayonly) Then
			Set m_ordertodayonly = NewFldObj("BusinessDetails", "BusinessDetails", "x_ordertodayonly", "ordertodayonly", "[ordertodayonly]", "CAST([ordertodayonly] AS NVARCHAR)", 3, 0, "[ordertodayonly]", False, False, FALSE, "FORMATTED TEXT")
			m_ordertodayonly.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set ordertodayonly = m_ordertodayonly
	End Property

	' Field mileskm
	Private m_mileskm

	Public Property Get mileskm()
		If Not IsObject(m_mileskm) Then
			Set m_mileskm = NewFldObj("BusinessDetails", "BusinessDetails", "x_mileskm", "mileskm", "[mileskm]", "[mileskm]", 202, 0, "[mileskm]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set mileskm = m_mileskm
	End Property

	' Field worldpaylive
	Private m_worldpaylive

	Public Property Get worldpaylive()
		If Not IsObject(m_worldpaylive) Then
			Set m_worldpaylive = NewFldObj("BusinessDetails", "BusinessDetails", "x_worldpaylive", "worldpaylive", "[worldpaylive]", "CAST([worldpaylive] AS NVARCHAR)", 3, 0, "[worldpaylive]", False, False, FALSE, "FORMATTED TEXT")
			m_worldpaylive.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set worldpaylive = m_worldpaylive
	End Property

	' Field worldpayinstallationid
	Private m_worldpayinstallationid

	Public Property Get worldpayinstallationid()
		If Not IsObject(m_worldpayinstallationid) Then
			Set m_worldpayinstallationid = NewFldObj("BusinessDetails", "BusinessDetails", "x_worldpayinstallationid", "worldpayinstallationid", "[worldpayinstallationid]", "[worldpayinstallationid]", 202, 0, "[worldpayinstallationid]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set worldpayinstallationid = m_worldpayinstallationid
	End Property

	' Field DistanceCalMethod
	Private m_DistanceCalMethod

	Public Property Get DistanceCalMethod()
		If Not IsObject(m_DistanceCalMethod) Then
			Set m_DistanceCalMethod = NewFldObj("BusinessDetails", "BusinessDetails", "x_DistanceCalMethod", "DistanceCalMethod", "[DistanceCalMethod]", "[DistanceCalMethod]", 202, 0, "[DistanceCalMethod]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set DistanceCalMethod = m_DistanceCalMethod
	End Property

	' Field PrinterIDList
	Private m_PrinterIDList

	Public Property Get PrinterIDList()
		If Not IsObject(m_PrinterIDList) Then
			Set m_PrinterIDList = NewFldObj("BusinessDetails", "BusinessDetails", "x_PrinterIDList", "PrinterIDList", "[PrinterIDList]", "[PrinterIDList]", 202, 0, "[PrinterIDList]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set PrinterIDList = m_PrinterIDList
	End Property

	' Field EpsonJSPrinterURL
	Private m_EpsonJSPrinterURL

	Public Property Get EpsonJSPrinterURL()
		If Not IsObject(m_EpsonJSPrinterURL) Then
			Set m_EpsonJSPrinterURL = NewFldObj("BusinessDetails", "BusinessDetails", "x_EpsonJSPrinterURL", "EpsonJSPrinterURL", "[EpsonJSPrinterURL]", "[EpsonJSPrinterURL]", 202, 0, "[EpsonJSPrinterURL]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set EpsonJSPrinterURL = m_EpsonJSPrinterURL
	End Property

	' Field SMSEnable
	Private m_SMSEnable

	Public Property Get SMSEnable()
		If Not IsObject(m_SMSEnable) Then
			Set m_SMSEnable = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMSEnable", "SMSEnable", "[SMSEnable]", "CAST([SMSEnable] AS NVARCHAR)", 3, 0, "[SMSEnable]", False, False, FALSE, "FORMATTED TEXT")
			m_SMSEnable.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set SMSEnable = m_SMSEnable
	End Property

	' Field SMSOnDelivery
	Private m_SMSOnDelivery

	Public Property Get SMSOnDelivery()
		If Not IsObject(m_SMSOnDelivery) Then
			Set m_SMSOnDelivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMSOnDelivery", "SMSOnDelivery", "[SMSOnDelivery]", "CAST([SMSOnDelivery] AS NVARCHAR)", 3, 0, "[SMSOnDelivery]", False, False, FALSE, "FORMATTED TEXT")
			m_SMSOnDelivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set SMSOnDelivery = m_SMSOnDelivery
	End Property

	' Field SMSSupplierDomain
	Private m_SMSSupplierDomain

	Public Property Get SMSSupplierDomain()
		If Not IsObject(m_SMSSupplierDomain) Then
			Set m_SMSSupplierDomain = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMSSupplierDomain", "SMSSupplierDomain", "[SMSSupplierDomain]", "[SMSSupplierDomain]", 202, 0, "[SMSSupplierDomain]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SMSSupplierDomain = m_SMSSupplierDomain
	End Property

	' Field SMSOnOrder
	Private m_SMSOnOrder

	Public Property Get SMSOnOrder()
		If Not IsObject(m_SMSOnOrder) Then
			Set m_SMSOnOrder = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMSOnOrder", "SMSOnOrder", "[SMSOnOrder]", "CAST([SMSOnOrder] AS NVARCHAR)", 3, 0, "[SMSOnOrder]", False, False, FALSE, "FORMATTED TEXT")
			m_SMSOnOrder.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set SMSOnOrder = m_SMSOnOrder
	End Property

	' Field SMSOnOrderAfterMin
	Private m_SMSOnOrderAfterMin

	Public Property Get SMSOnOrderAfterMin()
		If Not IsObject(m_SMSOnOrderAfterMin) Then
			Set m_SMSOnOrderAfterMin = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMSOnOrderAfterMin", "SMSOnOrderAfterMin", "[SMSOnOrderAfterMin]", "CAST([SMSOnOrderAfterMin] AS NVARCHAR)", 3, 0, "[SMSOnOrderAfterMin]", False, False, FALSE, "FORMATTED TEXT")
			m_SMSOnOrderAfterMin.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set SMSOnOrderAfterMin = m_SMSOnOrderAfterMin
	End Property

	' Field SMSOnOrderContent
	Private m_SMSOnOrderContent

	Public Property Get SMSOnOrderContent()
		If Not IsObject(m_SMSOnOrderContent) Then
			Set m_SMSOnOrderContent = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMSOnOrderContent", "SMSOnOrderContent", "[SMSOnOrderContent]", "[SMSOnOrderContent]", 202, 0, "[SMSOnOrderContent]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set SMSOnOrderContent = m_SMSOnOrderContent
	End Property

	' Field DefaultSMSCountryCode
	Private m_DefaultSMSCountryCode

	Public Property Get DefaultSMSCountryCode()
		If Not IsObject(m_DefaultSMSCountryCode) Then
			Set m_DefaultSMSCountryCode = NewFldObj("BusinessDetails", "BusinessDetails", "x_DefaultSMSCountryCode", "DefaultSMSCountryCode", "[DefaultSMSCountryCode]", "[DefaultSMSCountryCode]", 202, 0, "[DefaultSMSCountryCode]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set DefaultSMSCountryCode = m_DefaultSMSCountryCode
	End Property

	' Field MinimumAmountForCardPayment
	Private m_MinimumAmountForCardPayment

	Public Property Get MinimumAmountForCardPayment()
		If Not IsObject(m_MinimumAmountForCardPayment) Then
			Set m_MinimumAmountForCardPayment = NewFldObj("BusinessDetails", "BusinessDetails", "x_MinimumAmountForCardPayment", "MinimumAmountForCardPayment", "[MinimumAmountForCardPayment]", "CAST([MinimumAmountForCardPayment] AS NVARCHAR)", 6, 0, "[MinimumAmountForCardPayment]", False, False, FALSE, "FORMATTED TEXT")
			m_MinimumAmountForCardPayment.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set MinimumAmountForCardPayment = m_MinimumAmountForCardPayment
	End Property

	' Field FavIconUrl
	Private m_FavIconUrl

	Public Property Get FavIconUrl()
		If Not IsObject(m_FavIconUrl) Then
			Set m_FavIconUrl = NewFldObj("BusinessDetails", "BusinessDetails", "x_FavIconUrl", "FavIconUrl", "[FavIconUrl]", "[FavIconUrl]", 202, 0, "[FavIconUrl]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set FavIconUrl = m_FavIconUrl
	End Property

	' Field AddToHomeScreenURL
	Private m_AddToHomeScreenURL

	Public Property Get AddToHomeScreenURL()
		If Not IsObject(m_AddToHomeScreenURL) Then
			Set m_AddToHomeScreenURL = NewFldObj("BusinessDetails", "BusinessDetails", "x_AddToHomeScreenURL", "AddToHomeScreenURL", "[AddToHomeScreenURL]", "[AddToHomeScreenURL]", 202, 0, "[AddToHomeScreenURL]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set AddToHomeScreenURL = m_AddToHomeScreenURL
	End Property

	' Field SMSOnAcknowledgement
	Private m_SMSOnAcknowledgement

	Public Property Get SMSOnAcknowledgement()
		If Not IsObject(m_SMSOnAcknowledgement) Then
			Set m_SMSOnAcknowledgement = NewFldObj("BusinessDetails", "BusinessDetails", "x_SMSOnAcknowledgement", "SMSOnAcknowledgement", "[SMSOnAcknowledgement]", "CAST([SMSOnAcknowledgement] AS NVARCHAR)", 3, 0, "[SMSOnAcknowledgement]", False, False, FALSE, "FORMATTED TEXT")
			m_SMSOnAcknowledgement.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set SMSOnAcknowledgement = m_SMSOnAcknowledgement
	End Property

	' Field LocalPrinterURL
	Private m_LocalPrinterURL

	Public Property Get LocalPrinterURL()
		If Not IsObject(m_LocalPrinterURL) Then
			Set m_LocalPrinterURL = NewFldObj("BusinessDetails", "BusinessDetails", "x_LocalPrinterURL", "LocalPrinterURL", "[LocalPrinterURL]", "[LocalPrinterURL]", 202, 0, "[LocalPrinterURL]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set LocalPrinterURL = m_LocalPrinterURL
	End Property

	' Field ShowRestaurantDetailOnReceipt
	Private m_ShowRestaurantDetailOnReceipt

	Public Property Get ShowRestaurantDetailOnReceipt()
		If Not IsObject(m_ShowRestaurantDetailOnReceipt) Then
			Set m_ShowRestaurantDetailOnReceipt = NewFldObj("BusinessDetails", "BusinessDetails", "x_ShowRestaurantDetailOnReceipt", "ShowRestaurantDetailOnReceipt", "[ShowRestaurantDetailOnReceipt]", "CAST([ShowRestaurantDetailOnReceipt] AS NVARCHAR)", 3, 0, "[ShowRestaurantDetailOnReceipt]", False, False, FALSE, "FORMATTED TEXT")
			m_ShowRestaurantDetailOnReceipt.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set ShowRestaurantDetailOnReceipt = m_ShowRestaurantDetailOnReceipt
	End Property

	' Field PrinterFontSizeRatio
	Private m_PrinterFontSizeRatio

	Public Property Get PrinterFontSizeRatio()
		If Not IsObject(m_PrinterFontSizeRatio) Then
			Set m_PrinterFontSizeRatio = NewFldObj("BusinessDetails", "BusinessDetails", "x_PrinterFontSizeRatio", "PrinterFontSizeRatio", "[PrinterFontSizeRatio]", "CAST([PrinterFontSizeRatio] AS NVARCHAR)", 5, 0, "[PrinterFontSizeRatio]", False, False, FALSE, "FORMATTED TEXT")
			m_PrinterFontSizeRatio.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set PrinterFontSizeRatio = m_PrinterFontSizeRatio
	End Property

	' Field ServiceChargePercentage
	Private m_ServiceChargePercentage

	Public Property Get ServiceChargePercentage()
		If Not IsObject(m_ServiceChargePercentage) Then
			Set m_ServiceChargePercentage = NewFldObj("BusinessDetails", "BusinessDetails", "x_ServiceChargePercentage", "ServiceChargePercentage", "[ServiceChargePercentage]", "CAST([ServiceChargePercentage] AS NVARCHAR)", 5, 0, "[ServiceChargePercentage]", False, False, FALSE, "FORMATTED TEXT")
			m_ServiceChargePercentage.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set ServiceChargePercentage = m_ServiceChargePercentage
	End Property

	' Field InRestaurantServiceChargeOnly
	Private m_InRestaurantServiceChargeOnly

	Public Property Get InRestaurantServiceChargeOnly()
		If Not IsObject(m_InRestaurantServiceChargeOnly) Then
			Set m_InRestaurantServiceChargeOnly = NewFldObj("BusinessDetails", "BusinessDetails", "x_InRestaurantServiceChargeOnly", "InRestaurantServiceChargeOnly", "[InRestaurantServiceChargeOnly]", "CAST([InRestaurantServiceChargeOnly] AS NVARCHAR)", 3, 0, "[InRestaurantServiceChargeOnly]", False, False, FALSE, "FORMATTED TEXT")
			m_InRestaurantServiceChargeOnly.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set InRestaurantServiceChargeOnly = m_InRestaurantServiceChargeOnly
	End Property

	' Field IsDualReceiptPrinting
	Private m_IsDualReceiptPrinting

	Public Property Get IsDualReceiptPrinting()
		If Not IsObject(m_IsDualReceiptPrinting) Then
			Set m_IsDualReceiptPrinting = NewFldObj("BusinessDetails", "BusinessDetails", "x_IsDualReceiptPrinting", "IsDualReceiptPrinting", "[IsDualReceiptPrinting]", "CAST([IsDualReceiptPrinting] AS NVARCHAR)", 3, 0, "[IsDualReceiptPrinting]", False, False, FALSE, "FORMATTED TEXT")
			m_IsDualReceiptPrinting.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set IsDualReceiptPrinting = m_IsDualReceiptPrinting
	End Property

	' Field PrintingFontSize
	Private m_PrintingFontSize

	Public Property Get PrintingFontSize()
		If Not IsObject(m_PrintingFontSize) Then
			Set m_PrintingFontSize = NewFldObj("BusinessDetails", "BusinessDetails", "x_PrintingFontSize", "PrintingFontSize", "[PrintingFontSize]", "CAST([PrintingFontSize] AS NVARCHAR)", 5, 0, "[PrintingFontSize]", False, False, FALSE, "FORMATTED TEXT")
			m_PrintingFontSize.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set PrintingFontSize = m_PrintingFontSize
	End Property

	' Field InRestaurantEpsonPrinterIDList
	Private m_InRestaurantEpsonPrinterIDList

	Public Property Get InRestaurantEpsonPrinterIDList()
		If Not IsObject(m_InRestaurantEpsonPrinterIDList) Then
			Set m_InRestaurantEpsonPrinterIDList = NewFldObj("BusinessDetails", "BusinessDetails", "x_InRestaurantEpsonPrinterIDList", "InRestaurantEpsonPrinterIDList", "[InRestaurantEpsonPrinterIDList]", "[InRestaurantEpsonPrinterIDList]", 202, 0, "[InRestaurantEpsonPrinterIDList]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set InRestaurantEpsonPrinterIDList = m_InRestaurantEpsonPrinterIDList
	End Property

	' Field BlockIPEmailList
	Private m_BlockIPEmailList

	Public Property Get BlockIPEmailList()
		If Not IsObject(m_BlockIPEmailList) Then
			Set m_BlockIPEmailList = NewFldObj("BusinessDetails", "BusinessDetails", "x_BlockIPEmailList", "BlockIPEmailList", "[BlockIPEmailList]", "[BlockIPEmailList]", 202, 0, "[BlockIPEmailList]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set BlockIPEmailList = m_BlockIPEmailList
	End Property

	' Field inmenuannouncement
	Private m_inmenuannouncement

	Public Property Get inmenuannouncement()
		If Not IsObject(m_inmenuannouncement) Then
			Set m_inmenuannouncement = NewFldObj("BusinessDetails", "BusinessDetails", "x_inmenuannouncement", "inmenuannouncement", "[inmenuannouncement]", "[inmenuannouncement]", 203, 0, "[inmenuannouncement]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set inmenuannouncement = m_inmenuannouncement
	End Property

	' Field RePrintReceiptWays
	Private m_RePrintReceiptWays

	Public Property Get RePrintReceiptWays()
		If Not IsObject(m_RePrintReceiptWays) Then
			Set m_RePrintReceiptWays = NewFldObj("BusinessDetails", "BusinessDetails", "x_RePrintReceiptWays", "RePrintReceiptWays", "[RePrintReceiptWays]", "[RePrintReceiptWays]", 202, 0, "[RePrintReceiptWays]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set RePrintReceiptWays = m_RePrintReceiptWays
	End Property

	' Field printingtype
	Private m_printingtype

	Public Property Get printingtype()
		If Not IsObject(m_printingtype) Then
			Set m_printingtype = NewFldObj("BusinessDetails", "BusinessDetails", "x_printingtype", "printingtype", "[printingtype]", "[printingtype]", 202, 0, "[printingtype]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set printingtype = m_printingtype
	End Property

	' Field Stripe_Key_Secret
	Private m_Stripe_Key_Secret

	Public Property Get Stripe_Key_Secret()
		If Not IsObject(m_Stripe_Key_Secret) Then
			Set m_Stripe_Key_Secret = NewFldObj("BusinessDetails", "BusinessDetails", "x_Stripe_Key_Secret", "Stripe_Key_Secret", "[Stripe_Key_Secret]", "[Stripe_Key_Secret]", 202, 0, "[Stripe_Key_Secret]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Stripe_Key_Secret = m_Stripe_Key_Secret
	End Property

	' Field Stripe
	Private m_Stripe

	Public Property Get Stripe()
		If Not IsObject(m_Stripe) Then
			Set m_Stripe = NewFldObj("BusinessDetails", "BusinessDetails", "x_Stripe", "Stripe", "[Stripe]", "[Stripe]", 202, 0, "[Stripe]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Stripe = m_Stripe
	End Property

	' Field Stripe_Api_Key
	Private m_Stripe_Api_Key

	Public Property Get Stripe_Api_Key()
		If Not IsObject(m_Stripe_Api_Key) Then
			Set m_Stripe_Api_Key = NewFldObj("BusinessDetails", "BusinessDetails", "x_Stripe_Api_Key", "Stripe_Api_Key", "[Stripe_Api_Key]", "[Stripe_Api_Key]", 202, 0, "[Stripe_Api_Key]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Stripe_Api_Key = m_Stripe_Api_Key
	End Property

	' Field EnableBooking
	Private m_EnableBooking

	Public Property Get EnableBooking()
		If Not IsObject(m_EnableBooking) Then
			Set m_EnableBooking = NewFldObj("BusinessDetails", "BusinessDetails", "x_EnableBooking", "EnableBooking", "[EnableBooking]", "[EnableBooking]", 202, 0, "[EnableBooking]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set EnableBooking = m_EnableBooking
	End Property

	' Field URL_Facebook
	Private m_URL_Facebook

	Public Property Get URL_Facebook()
		If Not IsObject(m_URL_Facebook) Then
			Set m_URL_Facebook = NewFldObj("BusinessDetails", "BusinessDetails", "x_URL_Facebook", "URL_Facebook", "[URL_Facebook]", "[URL_Facebook]", 202, 0, "[URL_Facebook]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set URL_Facebook = m_URL_Facebook
	End Property

	' Field URL_Twitter
	Private m_URL_Twitter

	Public Property Get URL_Twitter()
		If Not IsObject(m_URL_Twitter) Then
			Set m_URL_Twitter = NewFldObj("BusinessDetails", "BusinessDetails", "x_URL_Twitter", "URL_Twitter", "[URL_Twitter]", "[URL_Twitter]", 202, 0, "[URL_Twitter]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set URL_Twitter = m_URL_Twitter
	End Property

	' Field URL_Google
	Private m_URL_Google

	Public Property Get URL_Google()
		If Not IsObject(m_URL_Google) Then
			Set m_URL_Google = NewFldObj("BusinessDetails", "BusinessDetails", "x_URL_Google", "URL_Google", "[URL_Google]", "[URL_Google]", 202, 0, "[URL_Google]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set URL_Google = m_URL_Google
	End Property

	' Field URL_Intagram
	Private m_URL_Intagram

	Public Property Get URL_Intagram()
		If Not IsObject(m_URL_Intagram) Then
			Set m_URL_Intagram = NewFldObj("BusinessDetails", "BusinessDetails", "x_URL_Intagram", "URL_Intagram", "[URL_Intagram]", "[URL_Intagram]", 202, 0, "[URL_Intagram]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set URL_Intagram = m_URL_Intagram
	End Property

	' Field URL_YouTube
	Private m_URL_YouTube

	Public Property Get URL_YouTube()
		If Not IsObject(m_URL_YouTube) Then
			Set m_URL_YouTube = NewFldObj("BusinessDetails", "BusinessDetails", "x_URL_YouTube", "URL_YouTube", "[URL_YouTube]", "[URL_YouTube]", 202, 0, "[URL_YouTube]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set URL_YouTube = m_URL_YouTube
	End Property

	' Field URL_Tripadvisor
	Private m_URL_Tripadvisor

	Public Property Get URL_Tripadvisor()
		If Not IsObject(m_URL_Tripadvisor) Then
			Set m_URL_Tripadvisor = NewFldObj("BusinessDetails", "BusinessDetails", "x_URL_Tripadvisor", "URL_Tripadvisor", "[URL_Tripadvisor]", "[URL_Tripadvisor]", 202, 0, "[URL_Tripadvisor]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set URL_Tripadvisor = m_URL_Tripadvisor
	End Property

	' Field URL_Special_Offer
	Private m_URL_Special_Offer

	Public Property Get URL_Special_Offer()
		If Not IsObject(m_URL_Special_Offer) Then
			Set m_URL_Special_Offer = NewFldObj("BusinessDetails", "BusinessDetails", "x_URL_Special_Offer", "URL_Special_Offer", "[URL_Special_Offer]", "[URL_Special_Offer]", 202, 0, "[URL_Special_Offer]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set URL_Special_Offer = m_URL_Special_Offer
	End Property

	' Field URL_Linkin
	Private m_URL_Linkin

	Public Property Get URL_Linkin()
		If Not IsObject(m_URL_Linkin) Then
			Set m_URL_Linkin = NewFldObj("BusinessDetails", "BusinessDetails", "x_URL_Linkin", "URL_Linkin", "[URL_Linkin]", "[URL_Linkin]", 202, 0, "[URL_Linkin]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set URL_Linkin = m_URL_Linkin
	End Property

	' Field Currency_PAYPAL
	Private m_Currency_PAYPAL

	Public Property Get Currency_PAYPAL()
		If Not IsObject(m_Currency_PAYPAL) Then
			Set m_Currency_PAYPAL = NewFldObj("BusinessDetails", "BusinessDetails", "x_Currency_PAYPAL", "Currency_PAYPAL", "[Currency_PAYPAL]", "[Currency_PAYPAL]", 202, 0, "[Currency_PAYPAL]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Currency_PAYPAL = m_Currency_PAYPAL
	End Property

	' Field Currency_STRIPE
	Private m_Currency_STRIPE

	Public Property Get Currency_STRIPE()
		If Not IsObject(m_Currency_STRIPE) Then
			Set m_Currency_STRIPE = NewFldObj("BusinessDetails", "BusinessDetails", "x_Currency_STRIPE", "Currency_STRIPE", "[Currency_STRIPE]", "[Currency_STRIPE]", 202, 0, "[Currency_STRIPE]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Currency_STRIPE = m_Currency_STRIPE
	End Property

	' Field Currency_WOLRDPAY
	Private m_Currency_WOLRDPAY

	Public Property Get Currency_WOLRDPAY()
		If Not IsObject(m_Currency_WOLRDPAY) Then
			Set m_Currency_WOLRDPAY = NewFldObj("BusinessDetails", "BusinessDetails", "x_Currency_WOLRDPAY", "Currency_WOLRDPAY", "[Currency_WOLRDPAY]", "[Currency_WOLRDPAY]", 202, 0, "[Currency_WOLRDPAY]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Currency_WOLRDPAY = m_Currency_WOLRDPAY
	End Property

	' Field Tip_percent
	Private m_Tip_percent

	Public Property Get Tip_percent()
		If Not IsObject(m_Tip_percent) Then
			Set m_Tip_percent = NewFldObj("BusinessDetails", "BusinessDetails", "x_Tip_percent", "Tip_percent", "[Tip_percent]", "CAST([Tip_percent] AS NVARCHAR)", 3, 0, "[Tip_percent]", False, False, FALSE, "FORMATTED TEXT")
			m_Tip_percent.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Tip_percent = m_Tip_percent
	End Property

	' Field Tax_Percent
	Private m_Tax_Percent

	Public Property Get Tax_Percent()
		If Not IsObject(m_Tax_Percent) Then
			Set m_Tax_Percent = NewFldObj("BusinessDetails", "BusinessDetails", "x_Tax_Percent", "Tax_Percent", "[Tax_Percent]", "CAST([Tax_Percent] AS NVARCHAR)", 3, 0, "[Tax_Percent]", False, False, FALSE, "FORMATTED TEXT")
			m_Tax_Percent.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Tax_Percent = m_Tax_Percent
	End Property

	' Field InRestaurantTaxChargeOnly
	Private m_InRestaurantTaxChargeOnly

	Public Property Get InRestaurantTaxChargeOnly()
		If Not IsObject(m_InRestaurantTaxChargeOnly) Then
			Set m_InRestaurantTaxChargeOnly = NewFldObj("BusinessDetails", "BusinessDetails", "x_InRestaurantTaxChargeOnly", "InRestaurantTaxChargeOnly", "[InRestaurantTaxChargeOnly]", "CAST([InRestaurantTaxChargeOnly] AS NVARCHAR)", 3, 0, "[InRestaurantTaxChargeOnly]", False, False, FALSE, "FORMATTED TEXT")
			m_InRestaurantTaxChargeOnly.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set InRestaurantTaxChargeOnly = m_InRestaurantTaxChargeOnly
	End Property

	' Field InRestaurantTipChargeOnly
	Private m_InRestaurantTipChargeOnly

	Public Property Get InRestaurantTipChargeOnly()
		If Not IsObject(m_InRestaurantTipChargeOnly) Then
			Set m_InRestaurantTipChargeOnly = NewFldObj("BusinessDetails", "BusinessDetails", "x_InRestaurantTipChargeOnly", "InRestaurantTipChargeOnly", "[InRestaurantTipChargeOnly]", "CAST([InRestaurantTipChargeOnly] AS NVARCHAR)", 3, 0, "[InRestaurantTipChargeOnly]", False, False, FALSE, "FORMATTED TEXT")
			m_InRestaurantTipChargeOnly.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set InRestaurantTipChargeOnly = m_InRestaurantTipChargeOnly
	End Property

	' Field isCheckCapcha
	Private m_isCheckCapcha

	Public Property Get isCheckCapcha()
		If Not IsObject(m_isCheckCapcha) Then
			Set m_isCheckCapcha = NewFldObj("BusinessDetails", "BusinessDetails", "x_isCheckCapcha", "isCheckCapcha", "[isCheckCapcha]", "[isCheckCapcha]", 202, 0, "[isCheckCapcha]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set isCheckCapcha = m_isCheckCapcha
	End Property

	' Field Close_StartDate
	Private m_Close_StartDate

	Public Property Get Close_StartDate()
		If Not IsObject(m_Close_StartDate) Then
			Set m_Close_StartDate = NewFldObj("BusinessDetails", "BusinessDetails", "x_Close_StartDate", "Close_StartDate", "[Close_StartDate]", "[Close_StartDate]", 202, 0, "[Close_StartDate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Close_StartDate = m_Close_StartDate
	End Property

	' Field Close_EndDate
	Private m_Close_EndDate

	Public Property Get Close_EndDate()
		If Not IsObject(m_Close_EndDate) Then
			Set m_Close_EndDate = NewFldObj("BusinessDetails", "BusinessDetails", "x_Close_EndDate", "Close_EndDate", "[Close_EndDate]", "[Close_EndDate]", 202, 0, "[Close_EndDate]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Close_EndDate = m_Close_EndDate
	End Property

	' Field Stripe_Country
	Private m_Stripe_Country

	Public Property Get Stripe_Country()
		If Not IsObject(m_Stripe_Country) Then
			Set m_Stripe_Country = NewFldObj("BusinessDetails", "BusinessDetails", "x_Stripe_Country", "Stripe_Country", "[Stripe_Country]", "[Stripe_Country]", 202, 0, "[Stripe_Country]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Stripe_Country = m_Stripe_Country
	End Property

	' Field enable_StripePaymentButton
	Private m_enable_StripePaymentButton

	Public Property Get enable_StripePaymentButton()
		If Not IsObject(m_enable_StripePaymentButton) Then
			Set m_enable_StripePaymentButton = NewFldObj("BusinessDetails", "BusinessDetails", "x_enable_StripePaymentButton", "enable_StripePaymentButton", "[enable_StripePaymentButton]", "[enable_StripePaymentButton]", 202, 0, "[enable_StripePaymentButton]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set enable_StripePaymentButton = m_enable_StripePaymentButton
	End Property

	' Field enable_CashPayment
	Private m_enable_CashPayment

	Public Property Get enable_CashPayment()
		If Not IsObject(m_enable_CashPayment) Then
			Set m_enable_CashPayment = NewFldObj("BusinessDetails", "BusinessDetails", "x_enable_CashPayment", "enable_CashPayment", "[enable_CashPayment]", "[enable_CashPayment]", 202, 0, "[enable_CashPayment]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set enable_CashPayment = m_enable_CashPayment
	End Property

	' Field DeliveryMile
	Private m_DeliveryMile

	Public Property Get DeliveryMile()
		If Not IsObject(m_DeliveryMile) Then
			Set m_DeliveryMile = NewFldObj("BusinessDetails", "BusinessDetails", "x_DeliveryMile", "DeliveryMile", "[DeliveryMile]", "CAST([DeliveryMile] AS NVARCHAR)", 5, 0, "[DeliveryMile]", False, False, FALSE, "FORMATTED TEXT")
			m_DeliveryMile.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set DeliveryMile = m_DeliveryMile
	End Property

	' Field Mon_Delivery
	Private m_Mon_Delivery

	Public Property Get Mon_Delivery()
		If Not IsObject(m_Mon_Delivery) Then
			Set m_Mon_Delivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_Mon_Delivery", "Mon_Delivery", "[Mon_Delivery]", "CAST([Mon_Delivery] AS NVARCHAR)", 3, 0, "[Mon_Delivery]", False, False, FALSE, "FORMATTED TEXT")
			m_Mon_Delivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Mon_Delivery = m_Mon_Delivery
	End Property

	' Field Mon_Collection
	Private m_Mon_Collection

	Public Property Get Mon_Collection()
		If Not IsObject(m_Mon_Collection) Then
			Set m_Mon_Collection = NewFldObj("BusinessDetails", "BusinessDetails", "x_Mon_Collection", "Mon_Collection", "[Mon_Collection]", "CAST([Mon_Collection] AS NVARCHAR)", 3, 0, "[Mon_Collection]", False, False, FALSE, "FORMATTED TEXT")
			m_Mon_Collection.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Mon_Collection = m_Mon_Collection
	End Property

	' Field Tue_Delivery
	Private m_Tue_Delivery

	Public Property Get Tue_Delivery()
		If Not IsObject(m_Tue_Delivery) Then
			Set m_Tue_Delivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_Tue_Delivery", "Tue_Delivery", "[Tue_Delivery]", "CAST([Tue_Delivery] AS NVARCHAR)", 3, 0, "[Tue_Delivery]", False, False, FALSE, "FORMATTED TEXT")
			m_Tue_Delivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Tue_Delivery = m_Tue_Delivery
	End Property

	' Field Tue_Collection
	Private m_Tue_Collection

	Public Property Get Tue_Collection()
		If Not IsObject(m_Tue_Collection) Then
			Set m_Tue_Collection = NewFldObj("BusinessDetails", "BusinessDetails", "x_Tue_Collection", "Tue_Collection", "[Tue_Collection]", "CAST([Tue_Collection] AS NVARCHAR)", 3, 0, "[Tue_Collection]", False, False, FALSE, "FORMATTED TEXT")
			m_Tue_Collection.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Tue_Collection = m_Tue_Collection
	End Property

	' Field Wed_Delivery
	Private m_Wed_Delivery

	Public Property Get Wed_Delivery()
		If Not IsObject(m_Wed_Delivery) Then
			Set m_Wed_Delivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_Wed_Delivery", "Wed_Delivery", "[Wed_Delivery]", "CAST([Wed_Delivery] AS NVARCHAR)", 3, 0, "[Wed_Delivery]", False, False, FALSE, "FORMATTED TEXT")
			m_Wed_Delivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Wed_Delivery = m_Wed_Delivery
	End Property

	' Field Wed_Collection
	Private m_Wed_Collection

	Public Property Get Wed_Collection()
		If Not IsObject(m_Wed_Collection) Then
			Set m_Wed_Collection = NewFldObj("BusinessDetails", "BusinessDetails", "x_Wed_Collection", "Wed_Collection", "[Wed_Collection]", "CAST([Wed_Collection] AS NVARCHAR)", 3, 0, "[Wed_Collection]", False, False, FALSE, "FORMATTED TEXT")
			m_Wed_Collection.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Wed_Collection = m_Wed_Collection
	End Property

	' Field Thu_Delivery
	Private m_Thu_Delivery

	Public Property Get Thu_Delivery()
		If Not IsObject(m_Thu_Delivery) Then
			Set m_Thu_Delivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_Thu_Delivery", "Thu_Delivery", "[Thu_Delivery]", "CAST([Thu_Delivery] AS NVARCHAR)", 3, 0, "[Thu_Delivery]", False, False, FALSE, "FORMATTED TEXT")
			m_Thu_Delivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Thu_Delivery = m_Thu_Delivery
	End Property

	' Field Thu_Collection
	Private m_Thu_Collection

	Public Property Get Thu_Collection()
		If Not IsObject(m_Thu_Collection) Then
			Set m_Thu_Collection = NewFldObj("BusinessDetails", "BusinessDetails", "x_Thu_Collection", "Thu_Collection", "[Thu_Collection]", "CAST([Thu_Collection] AS NVARCHAR)", 3, 0, "[Thu_Collection]", False, False, FALSE, "FORMATTED TEXT")
			m_Thu_Collection.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Thu_Collection = m_Thu_Collection
	End Property

	' Field Fri_Delivery
	Private m_Fri_Delivery

	Public Property Get Fri_Delivery()
		If Not IsObject(m_Fri_Delivery) Then
			Set m_Fri_Delivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_Fri_Delivery", "Fri_Delivery", "[Fri_Delivery]", "CAST([Fri_Delivery] AS NVARCHAR)", 3, 0, "[Fri_Delivery]", False, False, FALSE, "FORMATTED TEXT")
			m_Fri_Delivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Fri_Delivery = m_Fri_Delivery
	End Property

	' Field Fri_Collection
	Private m_Fri_Collection

	Public Property Get Fri_Collection()
		If Not IsObject(m_Fri_Collection) Then
			Set m_Fri_Collection = NewFldObj("BusinessDetails", "BusinessDetails", "x_Fri_Collection", "Fri_Collection", "[Fri_Collection]", "CAST([Fri_Collection] AS NVARCHAR)", 3, 0, "[Fri_Collection]", False, False, FALSE, "FORMATTED TEXT")
			m_Fri_Collection.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Fri_Collection = m_Fri_Collection
	End Property

	' Field Sat_Delivery
	Private m_Sat_Delivery

	Public Property Get Sat_Delivery()
		If Not IsObject(m_Sat_Delivery) Then
			Set m_Sat_Delivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_Sat_Delivery", "Sat_Delivery", "[Sat_Delivery]", "CAST([Sat_Delivery] AS NVARCHAR)", 3, 0, "[Sat_Delivery]", False, False, FALSE, "FORMATTED TEXT")
			m_Sat_Delivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Sat_Delivery = m_Sat_Delivery
	End Property

	' Field Sat_Collection
	Private m_Sat_Collection

	Public Property Get Sat_Collection()
		If Not IsObject(m_Sat_Collection) Then
			Set m_Sat_Collection = NewFldObj("BusinessDetails", "BusinessDetails", "x_Sat_Collection", "Sat_Collection", "[Sat_Collection]", "CAST([Sat_Collection] AS NVARCHAR)", 3, 0, "[Sat_Collection]", False, False, FALSE, "FORMATTED TEXT")
			m_Sat_Collection.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Sat_Collection = m_Sat_Collection
	End Property

	' Field Sun_Delivery
	Private m_Sun_Delivery

	Public Property Get Sun_Delivery()
		If Not IsObject(m_Sun_Delivery) Then
			Set m_Sun_Delivery = NewFldObj("BusinessDetails", "BusinessDetails", "x_Sun_Delivery", "Sun_Delivery", "[Sun_Delivery]", "CAST([Sun_Delivery] AS NVARCHAR)", 3, 0, "[Sun_Delivery]", False, False, FALSE, "FORMATTED TEXT")
			m_Sun_Delivery.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Sun_Delivery = m_Sun_Delivery
	End Property

	' Field Sun_Collection
	Private m_Sun_Collection

	Public Property Get Sun_Collection()
		If Not IsObject(m_Sun_Collection) Then
			Set m_Sun_Collection = NewFldObj("BusinessDetails", "BusinessDetails", "x_Sun_Collection", "Sun_Collection", "[Sun_Collection]", "CAST([Sun_Collection] AS NVARCHAR)", 3, 0, "[Sun_Collection]", False, False, FALSE, "FORMATTED TEXT")
			m_Sun_Collection.FldDefaultErrMsg = Language.Phrase("IncorrectInteger")
		End If
		Set Sun_Collection = m_Sun_Collection
	End Property

	' Field EnableUrlRewrite
	Private m_EnableUrlRewrite

	Public Property Get EnableUrlRewrite()
		If Not IsObject(m_EnableUrlRewrite) Then
			Set m_EnableUrlRewrite = NewFldObj("BusinessDetails", "BusinessDetails", "x_EnableUrlRewrite", "EnableUrlRewrite", "[EnableUrlRewrite]", "[EnableUrlRewrite]", 202, 0, "[EnableUrlRewrite]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set EnableUrlRewrite = m_EnableUrlRewrite
	End Property

	' Field DeliveryCostUpTo
	Private m_DeliveryCostUpTo

	Public Property Get DeliveryCostUpTo()
		If Not IsObject(m_DeliveryCostUpTo) Then
			Set m_DeliveryCostUpTo = NewFldObj("BusinessDetails", "BusinessDetails", "x_DeliveryCostUpTo", "DeliveryCostUpTo", "[DeliveryCostUpTo]", "CAST([DeliveryCostUpTo] AS NVARCHAR)", 5, 0, "[DeliveryCostUpTo]", False, False, FALSE, "FORMATTED TEXT")
			m_DeliveryCostUpTo.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set DeliveryCostUpTo = m_DeliveryCostUpTo
	End Property

	' Field DeliveryUptoMile
	Private m_DeliveryUptoMile

	Public Property Get DeliveryUptoMile()
		If Not IsObject(m_DeliveryUptoMile) Then
			Set m_DeliveryUptoMile = NewFldObj("BusinessDetails", "BusinessDetails", "x_DeliveryUptoMile", "DeliveryUptoMile", "[DeliveryUptoMile]", "CAST([DeliveryUptoMile] AS NVARCHAR)", 5, 0, "[DeliveryUptoMile]", False, False, FALSE, "FORMATTED TEXT")
			m_DeliveryUptoMile.FldDefaultErrMsg = Language.Phrase("IncorrectFloat")
		End If
		Set DeliveryUptoMile = m_DeliveryUptoMile
	End Property

	' Field Show_Ordernumner_printer
	Private m_Show_Ordernumner_printer

	Public Property Get Show_Ordernumner_printer()
		If Not IsObject(m_Show_Ordernumner_printer) Then
			Set m_Show_Ordernumner_printer = NewFldObj("BusinessDetails", "BusinessDetails", "x_Show_Ordernumner_printer", "Show_Ordernumner_printer", "[Show_Ordernumner_printer]", "[Show_Ordernumner_printer]", 202, 0, "[Show_Ordernumner_printer]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Show_Ordernumner_printer = m_Show_Ordernumner_printer
	End Property

	' Field Show_Ordernumner_Receipt
	Private m_Show_Ordernumner_Receipt

	Public Property Get Show_Ordernumner_Receipt()
		If Not IsObject(m_Show_Ordernumner_Receipt) Then
			Set m_Show_Ordernumner_Receipt = NewFldObj("BusinessDetails", "BusinessDetails", "x_Show_Ordernumner_Receipt", "Show_Ordernumner_Receipt", "[Show_Ordernumner_Receipt]", "[Show_Ordernumner_Receipt]", 202, 0, "[Show_Ordernumner_Receipt]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Show_Ordernumner_Receipt = m_Show_Ordernumner_Receipt
	End Property

	' Field Show_Ordernumner_Dashboard
	Private m_Show_Ordernumner_Dashboard

	Public Property Get Show_Ordernumner_Dashboard()
		If Not IsObject(m_Show_Ordernumner_Dashboard) Then
			Set m_Show_Ordernumner_Dashboard = NewFldObj("BusinessDetails", "BusinessDetails", "x_Show_Ordernumner_Dashboard", "Show_Ordernumner_Dashboard", "[Show_Ordernumner_Dashboard]", "[Show_Ordernumner_Dashboard]", 202, 0, "[Show_Ordernumner_Dashboard]", False, False, FALSE, "FORMATTED TEXT")
		End If
		Set Show_Ordernumner_Dashboard = m_Show_Ordernumner_Dashboard
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
		If IsObject(m_Address) Then Set m_Address = Nothing
		If IsObject(m_PostalCode) Then Set m_PostalCode = Nothing
		If IsObject(m_FoodType) Then Set m_FoodType = Nothing
		If IsObject(m_DeliveryMinAmount) Then Set m_DeliveryMinAmount = Nothing
		If IsObject(m_DeliveryMaxDistance) Then Set m_DeliveryMaxDistance = Nothing
		If IsObject(m_DeliveryFreeDistance) Then Set m_DeliveryFreeDistance = Nothing
		If IsObject(m_AverageDeliveryTime) Then Set m_AverageDeliveryTime = Nothing
		If IsObject(m_AverageCollectionTime) Then Set m_AverageCollectionTime = Nothing
		If IsObject(m_DeliveryFee) Then Set m_DeliveryFee = Nothing
		If IsObject(m_ImgUrl) Then Set m_ImgUrl = Nothing
		If IsObject(m_Telephone) Then Set m_Telephone = Nothing
		If IsObject(m_zEmail) Then Set m_zEmail = Nothing
		If IsObject(m_pswd) Then Set m_pswd = Nothing
		If IsObject(m_businessclosed) Then Set m_businessclosed = Nothing
		If IsObject(m_announcement) Then Set m_announcement = Nothing
		If IsObject(m_css) Then Set m_css = Nothing
		If IsObject(m_SMTP_AUTENTICATE) Then Set m_SMTP_AUTENTICATE = Nothing
		If IsObject(m_MAIL_FROM) Then Set m_MAIL_FROM = Nothing
		If IsObject(m_PAYPAL_URL) Then Set m_PAYPAL_URL = Nothing
		If IsObject(m_PAYPAL_PDT) Then Set m_PAYPAL_PDT = Nothing
		If IsObject(m_SMTP_PASSWORD) Then Set m_SMTP_PASSWORD = Nothing
		If IsObject(m_GMAP_API_KEY) Then Set m_GMAP_API_KEY = Nothing
		If IsObject(m_SMTP_USERNAME) Then Set m_SMTP_USERNAME = Nothing
		If IsObject(m_SMTP_USESSL) Then Set m_SMTP_USESSL = Nothing
		If IsObject(m_MAIL_SUBJECT) Then Set m_MAIL_SUBJECT = Nothing
		If IsObject(m_CURRENCYSYMBOL) Then Set m_CURRENCYSYMBOL = Nothing
		If IsObject(m_SMTP_SERVER) Then Set m_SMTP_SERVER = Nothing
		If IsObject(m_CREDITCARDSURCHARGE) Then Set m_CREDITCARDSURCHARGE = Nothing
		If IsObject(m_SMTP_PORT) Then Set m_SMTP_PORT = Nothing
		If IsObject(m_STICK_MENU) Then Set m_STICK_MENU = Nothing
		If IsObject(m_MAIL_CUSTOMER_SUBJECT) Then Set m_MAIL_CUSTOMER_SUBJECT = Nothing
		If IsObject(m_CONFIRMATION_EMAIL_ADDRESS) Then Set m_CONFIRMATION_EMAIL_ADDRESS = Nothing
		If IsObject(m_SEND_ORDERS_TO_PRINTER) Then Set m_SEND_ORDERS_TO_PRINTER = Nothing
		If IsObject(m_timezone) Then Set m_timezone = Nothing
		If IsObject(m_PAYPAL_ADDR) Then Set m_PAYPAL_ADDR = Nothing
		If IsObject(m_nochex) Then Set m_nochex = Nothing
		If IsObject(m_nochexmerchantid) Then Set m_nochexmerchantid = Nothing
		If IsObject(m_paypal) Then Set m_paypal = Nothing
		If IsObject(m_IBT_API_KEY) Then Set m_IBT_API_KEY = Nothing
		If IsObject(m_IBP_API_PASSWORD) Then Set m_IBP_API_PASSWORD = Nothing
		If IsObject(m_disable_delivery) Then Set m_disable_delivery = Nothing
		If IsObject(m_disable_collection) Then Set m_disable_collection = Nothing
		If IsObject(m_worldpay) Then Set m_worldpay = Nothing
		If IsObject(m_worldpaymerchantid) Then Set m_worldpaymerchantid = Nothing
		If IsObject(m_backtohometext) Then Set m_backtohometext = Nothing
		If IsObject(m_closedtext) Then Set m_closedtext = Nothing
		If IsObject(m_DeliveryChargeOverrideByOrderValue) Then Set m_DeliveryChargeOverrideByOrderValue = Nothing
		If IsObject(m_individualpostcodes) Then Set m_individualpostcodes = Nothing
		If IsObject(m_individualpostcodeschecking) Then Set m_individualpostcodeschecking = Nothing
		If IsObject(m_longitude) Then Set m_longitude = Nothing
		If IsObject(m_latitude) Then Set m_latitude = Nothing
		If IsObject(m_googleecommercetracking) Then Set m_googleecommercetracking = Nothing
		If IsObject(m_googleecommercetrackingcode) Then Set m_googleecommercetrackingcode = Nothing
		If IsObject(m_bringg) Then Set m_bringg = Nothing
		If IsObject(m_bringgurl) Then Set m_bringgurl = Nothing
		If IsObject(m_bringgcompanyid) Then Set m_bringgcompanyid = Nothing
		If IsObject(m_orderonlywhenopen) Then Set m_orderonlywhenopen = Nothing
		If IsObject(m_disablelaterdelivery) Then Set m_disablelaterdelivery = Nothing
		If IsObject(m_menupagetext) Then Set m_menupagetext = Nothing
		If IsObject(m_ordertodayonly) Then Set m_ordertodayonly = Nothing
		If IsObject(m_mileskm) Then Set m_mileskm = Nothing
		If IsObject(m_worldpaylive) Then Set m_worldpaylive = Nothing
		If IsObject(m_worldpayinstallationid) Then Set m_worldpayinstallationid = Nothing
		If IsObject(m_DistanceCalMethod) Then Set m_DistanceCalMethod = Nothing
		If IsObject(m_PrinterIDList) Then Set m_PrinterIDList = Nothing
		If IsObject(m_EpsonJSPrinterURL) Then Set m_EpsonJSPrinterURL = Nothing
		If IsObject(m_SMSEnable) Then Set m_SMSEnable = Nothing
		If IsObject(m_SMSOnDelivery) Then Set m_SMSOnDelivery = Nothing
		If IsObject(m_SMSSupplierDomain) Then Set m_SMSSupplierDomain = Nothing
		If IsObject(m_SMSOnOrder) Then Set m_SMSOnOrder = Nothing
		If IsObject(m_SMSOnOrderAfterMin) Then Set m_SMSOnOrderAfterMin = Nothing
		If IsObject(m_SMSOnOrderContent) Then Set m_SMSOnOrderContent = Nothing
		If IsObject(m_DefaultSMSCountryCode) Then Set m_DefaultSMSCountryCode = Nothing
		If IsObject(m_MinimumAmountForCardPayment) Then Set m_MinimumAmountForCardPayment = Nothing
		If IsObject(m_FavIconUrl) Then Set m_FavIconUrl = Nothing
		If IsObject(m_AddToHomeScreenURL) Then Set m_AddToHomeScreenURL = Nothing
		If IsObject(m_SMSOnAcknowledgement) Then Set m_SMSOnAcknowledgement = Nothing
		If IsObject(m_LocalPrinterURL) Then Set m_LocalPrinterURL = Nothing
		If IsObject(m_ShowRestaurantDetailOnReceipt) Then Set m_ShowRestaurantDetailOnReceipt = Nothing
		If IsObject(m_PrinterFontSizeRatio) Then Set m_PrinterFontSizeRatio = Nothing
		If IsObject(m_ServiceChargePercentage) Then Set m_ServiceChargePercentage = Nothing
		If IsObject(m_InRestaurantServiceChargeOnly) Then Set m_InRestaurantServiceChargeOnly = Nothing
		If IsObject(m_IsDualReceiptPrinting) Then Set m_IsDualReceiptPrinting = Nothing
		If IsObject(m_PrintingFontSize) Then Set m_PrintingFontSize = Nothing
		If IsObject(m_InRestaurantEpsonPrinterIDList) Then Set m_InRestaurantEpsonPrinterIDList = Nothing
		If IsObject(m_BlockIPEmailList) Then Set m_BlockIPEmailList = Nothing
		If IsObject(m_inmenuannouncement) Then Set m_inmenuannouncement = Nothing
		If IsObject(m_RePrintReceiptWays) Then Set m_RePrintReceiptWays = Nothing
		If IsObject(m_printingtype) Then Set m_printingtype = Nothing
		If IsObject(m_Stripe_Key_Secret) Then Set m_Stripe_Key_Secret = Nothing
		If IsObject(m_Stripe) Then Set m_Stripe = Nothing
		If IsObject(m_Stripe_Api_Key) Then Set m_Stripe_Api_Key = Nothing
		If IsObject(m_EnableBooking) Then Set m_EnableBooking = Nothing
		If IsObject(m_URL_Facebook) Then Set m_URL_Facebook = Nothing
		If IsObject(m_URL_Twitter) Then Set m_URL_Twitter = Nothing
		If IsObject(m_URL_Google) Then Set m_URL_Google = Nothing
		If IsObject(m_URL_Intagram) Then Set m_URL_Intagram = Nothing
		If IsObject(m_URL_YouTube) Then Set m_URL_YouTube = Nothing
		If IsObject(m_URL_Tripadvisor) Then Set m_URL_Tripadvisor = Nothing
		If IsObject(m_URL_Special_Offer) Then Set m_URL_Special_Offer = Nothing
		If IsObject(m_URL_Linkin) Then Set m_URL_Linkin = Nothing
		If IsObject(m_Currency_PAYPAL) Then Set m_Currency_PAYPAL = Nothing
		If IsObject(m_Currency_STRIPE) Then Set m_Currency_STRIPE = Nothing
		If IsObject(m_Currency_WOLRDPAY) Then Set m_Currency_WOLRDPAY = Nothing
		If IsObject(m_Tip_percent) Then Set m_Tip_percent = Nothing
		If IsObject(m_Tax_Percent) Then Set m_Tax_Percent = Nothing
		If IsObject(m_InRestaurantTaxChargeOnly) Then Set m_InRestaurantTaxChargeOnly = Nothing
		If IsObject(m_InRestaurantTipChargeOnly) Then Set m_InRestaurantTipChargeOnly = Nothing
		If IsObject(m_isCheckCapcha) Then Set m_isCheckCapcha = Nothing
		If IsObject(m_Close_StartDate) Then Set m_Close_StartDate = Nothing
		If IsObject(m_Close_EndDate) Then Set m_Close_EndDate = Nothing
		If IsObject(m_Stripe_Country) Then Set m_Stripe_Country = Nothing
		If IsObject(m_enable_StripePaymentButton) Then Set m_enable_StripePaymentButton = Nothing
		If IsObject(m_enable_CashPayment) Then Set m_enable_CashPayment = Nothing
		If IsObject(m_DeliveryMile) Then Set m_DeliveryMile = Nothing
		If IsObject(m_Mon_Delivery) Then Set m_Mon_Delivery = Nothing
		If IsObject(m_Mon_Collection) Then Set m_Mon_Collection = Nothing
		If IsObject(m_Tue_Delivery) Then Set m_Tue_Delivery = Nothing
		If IsObject(m_Tue_Collection) Then Set m_Tue_Collection = Nothing
		If IsObject(m_Wed_Delivery) Then Set m_Wed_Delivery = Nothing
		If IsObject(m_Wed_Collection) Then Set m_Wed_Collection = Nothing
		If IsObject(m_Thu_Delivery) Then Set m_Thu_Delivery = Nothing
		If IsObject(m_Thu_Collection) Then Set m_Thu_Collection = Nothing
		If IsObject(m_Fri_Delivery) Then Set m_Fri_Delivery = Nothing
		If IsObject(m_Fri_Collection) Then Set m_Fri_Collection = Nothing
		If IsObject(m_Sat_Delivery) Then Set m_Sat_Delivery = Nothing
		If IsObject(m_Sat_Collection) Then Set m_Sat_Collection = Nothing
		If IsObject(m_Sun_Delivery) Then Set m_Sun_Delivery = Nothing
		If IsObject(m_Sun_Collection) Then Set m_Sun_Collection = Nothing
		If IsObject(m_EnableUrlRewrite) Then Set m_EnableUrlRewrite = Nothing
		If IsObject(m_DeliveryCostUpTo) Then Set m_DeliveryCostUpTo = Nothing
		If IsObject(m_DeliveryUptoMile) Then Set m_DeliveryUptoMile = Nothing
		If IsObject(m_Show_Ordernumner_printer) Then Set m_Show_Ordernumner_printer = Nothing
		If IsObject(m_Show_Ordernumner_Receipt) Then Set m_Show_Ordernumner_Receipt = Nothing
		If IsObject(m_Show_Ordernumner_Dashboard) Then Set m_Show_Ordernumner_Dashboard = Nothing
		Set RowAttrs = Nothing
	End Sub
End Class
%>
