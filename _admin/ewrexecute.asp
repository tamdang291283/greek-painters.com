' Compatibility codes for ASP Report Maker
Const EW_PROJECT_NAME = "z1152DAdmin" ' Project Name
Dim EW_CONFIG_FILE_FOLDER
EW_CONFIG_FILE_FOLDER = EW_PROJECT_NAME & "" ' Config file name
Const EW_PROJECT_ID = "{E9837C6B-C139-4DEF-A37B-491BE9913D3B}" ' Project ID (GUID)
Dim EW_RELATED_PROJECT_ID
Dim EW_RELATED_LANGUAGE_FOLDER
Const EW_RANDOM_KEY = "rGxlt02F5Rxd2w2t"
Const EW_MAX_EMAIL_RECIPIENT = 3
' Auto suggest max entries
Const EW_AUTO_SUGGEST_MAX_ENTRIES = 10
' Auto fill original value
Const EW_AUTO_FILL_ORIGINAL_VALUE = false
' Upload max file size / thumbnail width and height
Const EW_MAX_FILE_SIZE = 2000000 ' Max file size
Const EW_MAX_FILE_COUNT = 0 ' Max file count
Const EW_UPLOAD_THUMBNAIL_WIDTH = 200 ' Temporary thumbnail max width
Const EW_UPLOAD_THUMBNAIL_HEIGHT = 0 ' Temporary thumbnail max height
' Language settings
Dim EW_LANGUAGE_FOLDER
EW_LANGUAGE_FOLDER = "lang/"
Dim EW_LANGUAGE_FILE(0)
EW_LANGUAGE_FILE(0) = Array("en", "", "english.xml")
Const EW_LANGUAGE_DEFAULT_ID = "en"
Dim EW_SESSION_LANGUAGE_FILE_CACHE
EW_SESSION_LANGUAGE_FILE_CACHE = EW_PROJECT_NAME & "_LanguageFile_rGxlt02F5Rxd2w2t" ' Language File Cache
Dim EW_SESSION_LANGUAGE_CACHE
EW_SESSION_LANGUAGE_CACHE = EW_PROJECT_NAME & "_Language_rGxlt02F5Rxd2w2t" ' Language Cache
Dim EW_SESSION_LANGUAGE_ID
EW_SESSION_LANGUAGE_ID = EW_PROJECT_NAME & "_LanguageId" ' Language ID
' Css file name
Const EW_PROJECT_STYLESHEET_FILENAME = "css/z1152DAdmin.css"
' Relative paths
Dim EW_RELATIVE_PATH, EW_ROOT_RELATIVE_PATH
EW_RELATIVE_PATH = ""
EW_ROOT_RELATIVE_PATH = "C:\"
' Relative paths
Dim EW_SESSION_RELATIVE_PATH, EW_SESSION_ROOT_RELATIVE_PATH
EW_SESSION_RELATIVE_PATH = EW_PROJECT_NAME & "_RelativePath"
EW_SESSION_ROOT_RELATIVE_PATH = EW_PROJECT_NAME & "_RootRelativePath"
' Use responsive layout
Dim EW_USE_RESPONSIVE_LAYOUT
EW_USE_RESPONSIVE_LAYOUT = True
' Is Mobile
Dim gIsMobile
'
' *** DO NOT CHANGE BELOW
'
' Init language object
Set Language = new cLanguage
Call Language.LoadPhrases()
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
' Check if mobile device
Function ew_IsMobile()
	ew_IsMobile = ewr_IsMobile()
End Function
' *** DO NOT CHANGE
