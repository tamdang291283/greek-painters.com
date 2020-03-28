<!DOCTYPE html>
<%

' Responsive layout
If ew_IsResponsiveLayout() Then
	gsHeaderRowClass = "hidden-xs ewHeaderRow"
	gsMenuColumnClass = "hidden-xs ewMenuColumn"
	gsSiteTitleClass = "hidden-xs ewSiteTitle"
Else
	gsHeaderRowClass = "ewHeaderRow"
	gsMenuColumnClass = "ewMenuColumn"
	gsSiteTitleClass = "ewSiteTitle"
End If
%>
<html>
<head>
	<title><%= Language.ProjectPhrase("BodyTitle") %></title>
<meta charset="utf-8">
<% If gsExport = "" Or gsExport = "print" Then %>
<link rel="stylesheet" type="text/css" href="<%= EW_RELATIVE_PATH %>bootstrap3/css/<%= ew_CssFile("bootstrap.css") %>">
<!-- Optional theme -->
<link rel="stylesheet" type="text/css" href="<%= EW_RELATIVE_PATH %>bootstrap3/css/<%= ew_CssFile("bootstrap-theme.css") %>">
<% End If %>
<% If gsExport = "" Then %>
<link rel="stylesheet" type="text/css" href="<%= EW_RELATIVE_PATH %>css/jquery.fileupload-ui.css">
<link rel="stylesheet" type="text/css" href="<%= EW_RELATIVE_PATH %>colorbox/colorbox.css">
<% End If %>
<% If gsExport = "" Or gsExport = "print" Then %>
<% If ew_IsResponsiveLayout() Then %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<% End If %>
<link rel="stylesheet" type="text/css" href="<%= EW_RELATIVE_PATH %><%= ew_CssFile(EW_PROJECT_STYLESHEET_FILENAME) %>">
<% If gsCustomExport = "pdf" And EW_PDF_STYLESHEET_FILENAME <> "" Then ' %>
<link rel="stylesheet" type="text/css" href="<%= EW_RELATIVE_PATH %><%= EW_PDF_STYLESHEET_FILENAME %>">
<% End If %>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %><%= ew_jQueryFile("jquery-%v.min.js") %>"></script>
<% End If %>
<% If gsExport = "" Or gsExport = "print" Then %>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>js/typeahead.bundle.min.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>js/jquery.browser.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>js/jquery.iframe-auto-height.plugin.1.9.5.min.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>jqueryfileupload/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>jqueryfileupload/load-image.min.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>jqueryfileupload/jqueryfileupload.min.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>colorbox/jquery.colorbox-min.js"></script>
<script type="text/javascript">
var EW_LANGUAGE_ID = "<%= gsLanguage %>";
var EW_DATE_SEPARATOR = "/" || "/"; // Default date separator
var EW_DECIMAL_POINT = "<%= EW_DECIMAL_POINT %>";
var EW_THOUSANDS_SEP = "<%= EW_THOUSANDS_SEP %>";
var EW_FIELD_SEP = ", "; // Default field separator
// Ajax settings
var EW_LOOKUP_FILE_NAME = "ewlookup12.asp"; // Lookup file name
var EW_AUTO_SUGGEST_MAX_ENTRIES = <%= EW_AUTO_SUGGEST_MAX_ENTRIES %>; // Auto-Suggest max entries
// Common JavaScript messages
var EW_DISABLE_BUTTON_ON_SUBMIT = true;
var EW_IMAGE_FOLDER = "images/"; // Image folder
var EW_UPLOAD_URL = "<%= EW_UPLOAD_URL %>"; // Upload url
var EW_UPLOAD_THUMBNAIL_WIDTH = <%= EW_UPLOAD_THUMBNAIL_WIDTH %>; // Upload thumbnail width
var EW_UPLOAD_THUMBNAIL_HEIGHT = <%= EW_UPLOAD_THUMBNAIL_HEIGHT %>; // Upload thumbnail height
var EW_MULTIPLE_UPLOAD_SEPARATOR = "<%= EW_MULTIPLE_UPLOAD_SEPARATOR %>"; // Upload multiple separator
var EW_USE_COLORBOX = <%= ew_IIf(EW_USE_COLORBOX, "true", "false") %>;
var EW_USE_JAVASCRIPT_MESSAGE = false;
var EW_IS_MOBILE = <%= ew_IIf(ew_IsMobile, "true", "false") %>;
var EW_PROJECT_STYLESHEET_FILENAME = "<%= EW_PROJECT_STYLESHEET_FILENAME %>"; // Project style sheet
var EW_PDF_STYLESHEET_FILENAME = "<%= EW_PDF_STYLESHEET_FILENAME %>"; // Pdf style sheet
var EW_TOKEN = "<%= gsToken %>";
var EW_CSS_FLIP = <%= ew_IIf(EW_CSS_FLIP, "true", "false") %>;
</script>
<% End If %>
<% If gsExport = "" Or gsExport = "print" Then %>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>js/jsrender.min.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>js/ew12.js"></script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>js/ewvalidator.js"></script>
<% End If %>
<% If gsExport = "" Or gsExport = "print" Then %>
<script type="text/javascript">
<%= Language.ToJSON() %>
</script>
<script type="text/javascript" src="<%= EW_RELATIVE_PATH %>js/userfn12.js"></script>
<script type="text/javascript">
// Write your client script here, no need to add script tags.
</script>
<% End If %>
<meta name="generator" content="ASPMaker v12.0.5">
</head>
<body>
<% If Not gbSkipHeaderFooter Then %>
<% If gsExport = "" Then %>
<div class="ewLayout">
	<!-- header (begin) --><!-- *** Note: Only licensed users are allowed to change the logo *** -->
	<div id="ewHeaderRow" class="<%= gsHeaderRowClass %>"><img src="<%= EW_RELATIVE_PATH %>images/logo-cms.gif" alt=""></div>
<% If ew_IsResponsiveLayout() Then %>
<nav id="ewMobileMenu" role="navigation" class="navbar navbar-default visible-xs hidden-print">
	<div class="container-fluid"><!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button data-target="#ewMenu" data-toggle="collapse" class="navbar-toggle" type="button">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<%= ew_IIf(EW_MENUBAR_BRAND_HYPERLINK <> "", EW_MENUBAR_BRAND_HYPERLINK, "#") %>"><%= ew_IIf(EW_MENUBAR_BRAND <> "", EW_MENUBAR_BRAND, Language.ProjectPhrase("BodyTitle")) %></a>
		</div>
		<div id="ewMenu" class="collapse navbar-collapse" style="height: auto;"><!-- Begin Main Menu -->
<%
	Set RootMenu = new cMenu
	RootMenu.Id = "MobileMenu"
	RootMenu.MenuBarClassName = ""
	RootMenu.MenuClassName = "nav navbar-nav"
	RootMenu.SubMenuClassName = "dropdown-menu"
	RootMenu.SubMenuDropdownImage = ""
	RootMenu.SubMenuDropdownIconClassName = "icon-arrow-down"
	RootMenu.MenuDividerClassName = "divider"
	RootMenu.MenuItemClassName = "dropdown"
	RootMenu.SubMenuItemClassName = "dropdown"
	RootMenu.MenuActiveItemClassName = "active"
	RootMenu.SubMenuActiveItemClassName = "active"
	RootMenu.MenuRootGroupTitleAsSubMenu = True
	RootMenu.MenuLinkDropdownClass = "ewDropdown"
	RootMenu.MenuLinkClassName = "icon-arrow-right"
%>
<!--#include file="ewmobilemenu.asp"-->
		</div><!-- /.navbar-collapse -->
	</div><!-- /.container-fluid -->
</nav>
<% End If %>
	<!-- header (end) -->
	<!-- content (begin) -->
	<div id="ewContentTable" class="ewContentTable">
		<div id="ewContentRow">
			<div id="ewMenuColumn" class="<%= gsMenuColumnClass %>">
				<!-- left column (begin) -->
				<div class="ewMenu">
<% Session(EW_SESSION_RELATIVE_PATH) = EW_RELATIVE_PATH ' Save relative path %>
<% Session(EW_SESSION_ROOT_RELATIVE_PATH) = EW_ROOT_RELATIVE_PATH ' Save root relative path %>
<% Server.Execute(EW_RELATIVE_PATH & "ewmenu.asp") %>
				</div>
				<!-- left column (end) -->
			</div>
			<div id="ewContentColumn" class="ewContentColumn">
				<!-- right column (begin) -->
				<h4 class="<%= gsSiteTitleClass %>"><%= Language.ProjectPhrase("BodyTitle") %></h4>
<% End If %>
<% End If %>
