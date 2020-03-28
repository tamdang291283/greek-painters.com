<%

' ASPMaker 12 configuration file
' - contains all web site configuration settings

Const EW_PROJECT_NAME = "z1152DAdmin" ' Project Name
Dim EW_CONFIG_FILE_FOLDER
EW_CONFIG_FILE_FOLDER = EW_PROJECT_NAME & "" ' Config file name
Const EW_PROJECT_ID = "{E9837C6B-C139-4DEF-A37B-491BE9913D3B}" ' Project ID (GUID)
Dim EW_RELATED_PROJECT_ID
Dim EW_RELATED_LANGUAGE_FOLDER
Const EW_RANDOM_KEY = "08qKraZSFRU4Ti4u"
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
EW_SESSION_LANGUAGE_FILE_CACHE = EW_PROJECT_NAME & "_LanguageFile_08qKraZSFRU4Ti4u" ' Language File Cache
Dim EW_SESSION_LANGUAGE_CACHE
EW_SESSION_LANGUAGE_CACHE = EW_PROJECT_NAME & "_Language_08qKraZSFRU4Ti4u" ' Language Cache
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

' Response.Buffer setting
Const EW_RESPONSE_BUFFER = True

' Menu
Const EW_ITEM_TEMPLATE_CLASSNAME = "ewTemplate"
Const EW_ITEM_TABLE_CLASSNAME = "ewItemTable"

' Debug flag
Const EW_DEBUG_ENABLED = False ' True to debug / False to skip

' Remove XSS
Const EW_REMOVE_XSS = True ' True to Remove XSS / False to skip

' XSS Array
Dim EW_XSS_ARRAY
EW_XSS_ARRAY = Array("javascript", "vbscript", "expression", "<applet", "<meta", "<xml", "<blink", "<link", "<style", "<script", "<embed", "<object", "<iframe", "<frame", "<frameset", "<ilayer", "<layer", "<bgsound", "<title", "<base", _
	"onabort", "onactivate", "onafterprint", "onafterupdate", "onbeforeactivate", "onbeforecopy", "onbeforecut", "onbeforedeactivate", "onbeforeeditfocus", "onbeforepaste", "onbeforeprint", "onbeforeunload", "onbeforeupdate", "onblur", "onbounce", "oncellchange", "onchange", "onclick", "oncontextmenu", "oncontrolselect", "oncopy", "oncut", "ondataavailable", "ondatasetchanged", "ondatasetcomplete", "ondblclick", "ondeactivate", "ondrag", "ondragend", "ondragenter", "ondragleave", "ondragover", "ondragstart", "ondrop", "onerror", "onerrorupdate", "onfilterchange", "onfinish", "onfocus", "onfocusin", "onfocusout", "onhelp", "onkeydown", "onkeypress", "onkeyup", "onlayoutcomplete", "onload", "onlosecapture", "onmousedown", "onmouseenter", "onmouseleave", "onmousemove", "onmouseout", "onmouseover", "onmouseup", "onmousewheel", "onmove", "onmoveend", "onmovestart", "onpaste", "onpropertychange", "onreadystatechange", "onreset", "onresize", "onresizeend", "onresizestart", "onrowenter", "onrowexit", "onrowsdelete", "onrowsinserted", "onscroll", "onselect", "onselectionchange", "onselectstart", "onstart", "onstop", "onsubmit", "onunload")

' Check Token
Const EW_CHECK_TOKEN = True ' Check post token
Const EW_TOKEN_NAME = "token"

' Session names
Dim EW_SESSION_STATUS
EW_SESSION_STATUS = EW_PROJECT_NAME & "_Status" ' Login Status
Dim EW_SESSION_USER_NAME
EW_SESSION_USER_NAME = EW_SESSION_STATUS & "_UserName" ' User Name
Dim EW_SESSION_USER_ID
EW_SESSION_USER_ID = EW_SESSION_STATUS & "_UserID" ' User ID
Dim EW_SESSION_USER_PROFILE, EW_SESSION_USER_PROFILE_USER_NAME, EW_SESSION_USER_PROFILE_PASSWORD, EW_SESSION_USER_PROFILE_LOGIN_TYPE
EW_SESSION_USER_PROFILE = EW_SESSION_STATUS & "_UserProfile" ' User Profile
EW_SESSION_USER_PROFILE_USER_NAME = EW_SESSION_USER_PROFILE & "_UserName"
EW_SESSION_USER_PROFILE_PASSWORD = EW_SESSION_USER_PROFILE & "_Password"
EW_SESSION_USER_PROFILE_LOGIN_TYPE = EW_SESSION_USER_PROFILE & "_LoginType"
Dim EW_SESSION_USER_LEVEL_ID
EW_SESSION_USER_LEVEL_ID = EW_SESSION_STATUS & "_UserLevel" ' User Level ID
Dim EW_SESSION_USER_LEVEL
EW_SESSION_USER_LEVEL = EW_SESSION_STATUS & "_UserLevelValue" ' User Level
Dim EW_SESSION_PARENT_USER_ID
EW_SESSION_PARENT_USER_ID = EW_SESSION_STATUS & "_ParentUserID" ' Parent User ID
Dim EW_SESSION_SYS_ADMIN
EW_SESSION_SYS_ADMIN = EW_PROJECT_NAME & "_SysAdmin" ' System Admin
Dim EW_SESSION_AR_USER_LEVEL
EW_SESSION_AR_USER_LEVEL = EW_PROJECT_NAME & "_arUserLevel" ' User Level Array
Dim EW_SESSION_AR_USER_LEVEL_PRIV
EW_SESSION_AR_USER_LEVEL_PRIV = EW_PROJECT_NAME & "_arUserLevelPriv" ' User Level Privilege Array
Dim EW_SESSION_USER_LEVEL_MSG
EW_SESSION_USER_LEVEL_MSG = EW_PROJECT_NAME & "_UserLevelMessage" ' User Level Message
Dim EW_SESSION_SECURITY
EW_SESSION_SECURITY = EW_PROJECT_NAME & "_Security" ' Security Array
Dim EW_SESSION_MESSAGE
EW_SESSION_MESSAGE = EW_PROJECT_NAME & "_Message" ' System Message
Dim EW_SESSION_FAILURE_MESSAGE, EW_SESSION_SUCCESS_MESSAGE, EW_SESSION_WARNING_MESSAGE
EW_SESSION_FAILURE_MESSAGE = EW_PROJECT_NAME & "_Failure_Message" ' System error message
EW_SESSION_SUCCESS_MESSAGE = EW_PROJECT_NAME & "_Success_Message" ' System message
EW_SESSION_WARNING_MESSAGE = EW_PROJECT_NAME & "_Warning_Message" ' Warning message
Dim EW_SESSION_INLINE_MODE
EW_SESSION_INLINE_MODE = EW_PROJECT_NAME & "_InlineMode" ' Inline Mode
Dim EW_SESSION_BREADCRUMB
EW_SESSION_BREADCRUMB = EW_PROJECT_NAME & "_Breadcrumb" ' Breadcrumb
Dim EW_SESSION_TEMP_IMAGES
EW_SESSION_TEMP_IMAGES = EW_PROJECT_NAME & "_TempImages" ' Temp images
Dim EW_SESSION_TOKEN
EW_SESSION_TOKEN = EW_PROJECT_NAME & "_Token"

' Charset
Const EW_CHARSET = "utf-8" ' Project charset

' Database settings
Dim EW_DB_CONNECTION_STRING ' DB Connection String (see "ew_Connect" function in "aspfn.asp")
Const EW_DB_QUOTE_START = "["
Const EW_DB_QUOTE_END = "]"
Const EW_IS_MSACCESS = False ' Access
Const EW_IS_MSSQL = True ' MS SQL
Const EW_IS_MYSQL = False ' MySQL
Const EW_IS_ORACLE = False ' Oracle
Const EW_IS_POSTGRESQL = False ' PostgreSQL
Const EW_CURSORLOCATION = 3 ' Cursor location
Const EW_RECORDSET_LOCKTYPE = 2 ' Recordset lock type
Const EW_DATATYPE_NUMBER = 1
Const EW_DATATYPE_DATE = 2
Const EW_DATATYPE_STRING = 3
Const EW_DATATYPE_BOOLEAN = 4
Const EW_DATATYPE_MEMO = 5
Const EW_DATATYPE_BLOB = 6
Const EW_DATATYPE_TIME = 7
Const EW_DATATYPE_GUID = 8
Const EW_DATATYPE_XML = 9
Const EW_DATATYPE_OTHER = 10
Const EW_COMPOSITE_KEY_SEPARATOR = "," ' Composite key separator
Const EW_EMAIL_KEYWORD_SEPARATOR = "" ' Email keyword separator
Const EW_EMAIL_CHARSET = "utf-8" ' Email charset
Const EW_HIGHLIGHT_COMPARE = 1 ' Highlight compare mode
Const EW_ROWTYPE_HEADER = 0 ' Row type header
Const EW_ROWTYPE_VIEW = 1 ' Row type view
Const EW_ROWTYPE_ADD = 2 ' Row type add
Const EW_ROWTYPE_EDIT = 3 ' Row type edit
Const EW_ROWTYPE_SEARCH = 4 ' Row type search
Const EW_ROWTYPE_MASTER = 5 ' Row type master record
Const EW_ROWTYPE_AGGREGATEINIT = 6 ' Row type aggregate init
Const EW_ROWTYPE_AGGREGATE = 7 ' Row type aggregate

' Table specific names
Const EW_TABLE_PREFIX = "||ASPReportMaker||"
Const EW_TABLE_REC_PER_PAGE = "recperpage" ' Records per page
Const EW_TABLE_START_REC = "start" ' Start record
Const EW_TABLE_PAGE_NO = "pageno" ' Page number
Const EW_TABLE_BASIC_SEARCH = "psearch" ' Basic search keyword
Const EW_TABLE_BASIC_SEARCH_TYPE = "psearchtype" ' Basic search type
Const EW_TABLE_ADVANCED_SEARCH = "advsrch" ' Advanced search
Const EW_TABLE_SEARCH_WHERE = "searchwhere" ' Search where clause
Const EW_TABLE_WHERE = "where" ' Table where
Const EW_TABLE_WHERE_LIST = "where_list" ' Table where (list page)
Const EW_TABLE_ORDER_BY = "orderby" ' Table order by
Const EW_TABLE_ORDER_BY_LIST = "orderby_list" ' Table order by (list page)
Const EW_TABLE_SORT = "sort" ' Table sort
Const EW_TABLE_KEY = "key" ' Table key
Const EW_TABLE_SHOW_MASTER = "showmaster" ' Table show master
Const EW_TABLE_SHOW_DETAIL = "showdetail" ' Table show detail
Const EW_TABLE_MASTER_TABLE = "mastertable" ' Master table
Const EW_TABLE_DETAIL_TABLE = "detailtable" ' Detail table
Const EW_TABLE_MASTER_FILTER = "masterfilter" ' Master filter
Const EW_TABLE_DETAIL_FILTER = "detailfilter" ' Detail filter
Const EW_TABLE_RETURN_URL = "return" ' Return url
Const EW_TABLE_EXPORT_RETURN_URL = "exportreturn" ' Export return url
Const EW_TABLE_GRID_ADD_ROW_COUNT = "gridaddcnt" ' Grid add row count

' Audit Trail
Const EW_AUDIT_TRAIL_TO_DATABASE = False ' Write audit trail to DB
Const EW_AUDIT_TRAIL_TABLE = "" ' Audit trail table
Const EW_AUDIT_TRAIL_FIELD_NAME_DATETIME = "" ' Audit trail DateTime field name
Const EW_AUDIT_TRAIL_FIELD_NAME_SCRIPT = "" ' Audit trail Script field name
Const EW_AUDIT_TRAIL_FIELD_NAME_USER = "" ' Audit trail User field name
Const EW_AUDIT_TRAIL_FIELD_NAME_ACTION = "" ' Audit trail Action field name
Const EW_AUDIT_TRAIL_FIELD_NAME_TABLE = "" ' Audit trail Table field name
Const EW_AUDIT_TRAIL_FIELD_NAME_FIELD = "" ' Audit trail Field field name
Const EW_AUDIT_TRAIL_FIELD_NAME_KEYVALUE = "" ' Audit trail Key Value field name
Const EW_AUDIT_TRAIL_FIELD_NAME_OLDVALUE = "" ' Audit trail Old Value field name
Const EW_AUDIT_TRAIL_FIELD_NAME_NEWVALUE = "" ' Audit trail New Value field name

' Security specific
Const EW_AUDIT_TRAIL_PATH = "" ' Audit trail path
Const EW_ADMIN_USER_NAME = "" ' Administrator user name
Const EW_ADMIN_PASSWORD = "" ' Administrator password
Const EW_USE_CUSTOM_LOGIN = True ' Use custom login
Const EW_ENCRYPTED_PASSWORD = False ' Use encrypted password
Const EW_CASE_SENSITIVE_PASSWORD = False ' Case Sensitive password

' User level constants
Const EW_USER_LEVEL_COMPAT = False ' Use new user level values (separate values for View/Search)
Const EW_ALLOW_ADD = 1 ' Add
Const EW_ALLOW_DELETE = 2 ' Delete
Const EW_ALLOW_EDIT = 4 ' Edit
Const EW_ALLOW_LIST = 8 ' List
Dim EW_ALLOW_VIEW, EW_ALLOW_SEARCH ' View / Search
If EW_USER_LEVEL_COMPAT Then
	EW_ALLOW_VIEW = 8 ' View
	EW_ALLOW_SEARCH = 8 ' Search
Else
	EW_ALLOW_VIEW = 32 ' View
	EW_ALLOW_SEARCH = 64 ' Search
End If
Const EW_ALLOW_REPORT = 8 ' Report
Const EW_ALLOW_ADMIN = 16 ' Admin

' Hierarchical User ID
Const EW_USER_ID_IS_HIERARCHICAL = True ' True to show all level / False to show 1 level

' Use subquery for master/detail user id checking
Const EW_USE_SUBQUERY_FOR_MASTER_USER_ID = False ' True to use subquery / False to skip
Const EW_USER_ID_ALLOW = 104

' User table filters
' User Profile Constants

Const EW_USER_PROFILE_KEY_SEPARATOR = "="
Const EW_USER_PROFILE_FIELD_SEPARATOR = ","
Const EW_USER_PROFILE_SESSION_ID = "SessionID"
Const EW_USER_PROFILE_LAST_ACCESSED_DATE_TIME = "LastAccessedDateTime"
Const EW_USER_PROFILE_CONCURRENT_SESSION_COUNT = 1 ' Maximum sessions allowed
Const EW_USER_PROFILE_SESSION_TIMEOUT = 20
Const EW_USER_PROFILE_LOGIN_RETRY_COUNT = "LoginRetryCount"
Const EW_USER_PROFILE_LAST_BAD_LOGIN_DATE_TIME = "LastBadLoginDateTime"
Const EW_USER_PROFILE_MAX_RETRY = 3
Const EW_USER_PROFILE_RETRY_LOCKOUT = 20
Const EW_USER_PROFILE_LAST_PASSWORD_CHANGED_DATE = "LastPasswordChangedDate"
Const EW_USER_PROFILE_PASSWORD_EXPIRE = 90

' Date separator / format
Const EW_DATE_SEPARATOR = "/"
Const EW_DEFAULT_DATE_FORMAT = 9
Const EW_UNFORMAT_YEAR = 50 ' Unformat year

' Email related constants
Const EW_SMTP_SERVER = "localhost" ' Smtp server
Const EW_SMTP_SERVER_PORT = 25 ' Smtp server port
Const EW_SMTP_SECURE_OPTION = ""
Const EW_SMTP_SERVER_USERNAME = "" ' Smtp server user name
Const EW_SMTP_SERVER_PASSWORD = "" ' Smtp server password
Const EW_SENDER_EMAIL = "" ' Sender email
Const EW_RECIPIENT_EMAIL = "" ' Receiver email

'Const EW_MAX_EMAIL_RECIPIENT = 3 ' already defined in shared
Const EW_MAX_EMAIL_SENT_COUNT = 3
Dim EW_EXPORT_EMAIL_COUNTER
EW_EXPORT_EMAIL_COUNTER = EW_SESSION_STATUS & "_EmailCounter"

' File upload constants
Const EW_UPLOAD_DEST_PATH = "" ' Upload destination path
Const EW_UPLOAD_URL = "ewupload12.asp" ' Upload URL
Const EW_UPLOAD_TEMP_FOLDER_PREFIX = "temp__" ' Upload temp folders prefix
Const EW_UPLOAD_TEMP_FOLDER_TIME_LIMIT = 1440 ' Upload temp folder time limit (minutes)
Const EW_UPLOAD_THUMBNAIL_FOLDER = "thumbnail" ' Temporary thumbnail folder
Const EW_UPLOAD_ALLOWED_FILE_EXT = "gif,jpg,jpeg,bmp,png,doc,xls,pdf,zip" ' Allowed file extensions
Const EW_IMAGE_ALLOWED_FILE_EXT = "gif,jpg,png,bmp" ' Allowed file extensions for images
Const EW_UPLOAD_CHARSET = "utf-8" ' Upload charset
Const EW_THUMBNAIL_DEFAULT_WIDTH = 0 ' Thumbnail default width
Const EW_THUMBNAIL_DEFAULT_HEIGHT = 0 ' Thumbnail default height
Const EW_THUMBNAIL_DEFAULT_INTERPOLATION = 1 ' Thumbnail default interpolation
Const EW_USE_COLORBOX = True ' Use Colorbox
Const EW_MULTIPLE_UPLOAD_SEPARATOR = "," ' Multiple upload separator

' Export records
Const EW_EXPORT_ALL_TIME_LIMIT = 120 ' Export all records time limit
Const EW_EXPORT_ORIGINAL_VALUE = False ' True to export original value
Const EW_EXPORT_FIELD_CAPTION = False ' True to export field caption
Const EW_EXPORT_CSS_STYLES = True ' True to export css styles
Const EW_EXPORT_MASTER_RECORD = True ' True to export master record
Const EW_EXPORT_MASTER_RECORD_FOR_CSV = False ' True to export master record for CSV
Const EW_EXPORT_DETAIL_RECORDS = True ' True to export detail records
Const EW_EXPORT_DETAIL_RECORDS_FOR_CSV = False ' True to export detail records for CSV

' MIME types
Dim EW_MIME_TYPES
EW_MIME_TYPES = Array( _
	Array("pdf", "application/pdf"), _
	Array("exe", "application/octet-stream"), _
	Array("zip", "application/zip"), _
	Array("doc", "application/msword"), _
	Array("docx", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"), _
	Array("xls", "application/vnd.ms-excel"), _
	Array("xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"), _
	Array("ppt", "application/vnd.ms-powerpoint"), _
	Array("pptx", "application/vnd.openxmlformats-officedocument.presentationml.presentation"), _
	Array("gif", "image/gif"), _
	Array("png", "image/png"), _
	Array("jpeg", "image/jpg"), _
	Array("jpg", "image/jpg"), _
	Array("mp3", "audio/mpeg"), _
	Array("wav", "audio/x-wav"), _
	Array("mpeg", "video/mpeg"), _
	Array("mpg", "video/mpeg"), _
	Array("mpe", "video/mpeg"), _
	Array("mov", "video/quicktime"), _
	Array("avi", "video/x-msvideo"), _
	Array("3gp", "video/3gpp"), _
	Array("css", "text/css"), _
	Array("js", "application/javascript"), _
	Array("htm", "text/html"), _
	Array("html", "text/html"))

' Use token in Url
Const EW_USE_TOKEN_IN_URL = False ' do not use token in url

' Const EW_USE_TOKEN_IN_URL = True ' use token in url
' Use ILIKE for PostgreSql

Const EW_USE_ILIKE_FOR_POSTGRESQL = True

' Use collation for MySQL
Const EW_LIKE_COLLATION_FOR_MYSQL = ""

' Use collation for MsSQL
Const EW_LIKE_COLLATION_FOR_MSSQL = ""

' Null / Not Null values
Const EW_NULL_VALUE = "##null##"
Const EW_NOT_NULL_VALUE = "##notnull##"

' Search multi value option
' 1 - no multi value
' 2 - AND all multi values
' 3 - OR all multi values

Const EW_SEARCH_MULTI_VALUE_OPTION = 3

' Basic search ignore special characters
Const EW_BASIC_SEARCH_IGNORE_PATTERN = "[\?,\.\^\*\(\)\[\]\\\""]"

' Use css flip
Const EW_CSS_FLIP = False

' Validate option
Const EW_CLIENT_VALIDATE = True
Const EW_SERVER_VALIDATE = True

' Blob field byte count for Hash value calculation
Const EW_BLOB_FIELD_BYTE_COUNT = 200

' Use DOM XML
Const EW_USE_DOM_XML = False

' Cookie expiry time
Const EW_COOKIE_EXPIRY_TIME = 365

'
' * Numeric and monetary formatting options
' * Note: DO NOT CHANGE THE FOLLOWING DEFAULT_* VARIABLES!
' * If you need to use custom settings, customize the language file,
' * set "use_system_locale" to "0" to override the default locale and customize the
' * phrases under the <locale> node for ew_FormatCurrency/Number/Percent functions
'

Dim EW_USE_SYSTEM_LOCALE, EW_LOCALE_ID, EW_DECIMAL_POINT, EW_THOUSANDS_SEP, EW_CURRENCY_SYMBOL
EW_USE_SYSTEM_LOCALE = True
EW_LOCALE_ID = 0
EW_DECIMAL_POINT = "."
EW_THOUSANDS_SEP = ","
EW_CURRENCY_SYMBOL = "$"

' -----------------------------------
'  ASPMaker global variables (begin)
'
' Global variables
' Common

Dim Page ' Common page object
Dim UserTable ' User table
Dim Table ' Main table
Dim Grid ' Grid page object
Dim Language ' Language object
Dim gsLanguage ' Current language
Dim gsToken ' Token
gsToken = ""
Dim EW_PAGE_ID ' Page ID
Dim EWR_PAGE_ID ' Page ID for Compatibility with Report Maker
Dim EW_TABLE_NAME ' Table name
Dim Conn, Rs, RsDtl, i
Dim Security
Dim UserProfile
Dim ObjForm
Dim PagerItem
Dim EventArgs
Dim StartTimer ' Start timer
Dim RootMenu

' Used for debug
Dim gsDebugMsg

' Used by ValidateForm/ValidateSearch
Dim gsFormError, gsSearchError

' Used by *master.asp
Dim gsMasterReturnUrl

' Used by header.asp, export checking
Dim gsExport, gsExportFile, gbSkipHeaderFooter, gbOldSkipHeaderFooter, gsHeaderRowClass, gsMenuColumnClass, gsSiteTitleClass
Dim gsCustomExport
gbSkipHeaderFooter = False
gsCustomExport = ""
gbOldSkipHeaderFooter = gbSkipHeaderFooter
Dim gsEmailSender, gsEmailRecipient, gsEmailCc, gsEmailBcc, gsEmailSubject, gsEmailContent, gsEmailContentType
Dim gsEmailErrNo, gsEmailErrDesc

' Used by system generated functions
Dim sSqlWrk, sWhereWrk, sLookupTblFilter, RsWrk, ari, arwrk, armultiwrk, rowswrk, rowcntwrk, selwrk, jswrk, emptywrk, boolwrk, wrkonchange
Dim sFilterWrk
Dim sNewFileName
Dim TmpFile, TmpFile1, TmpFiles, TmpNewFiles, TmpNewFiles2, TmpOldFiles, TmpHrefValue, TmpFileCount, TmpFldVar, TmpValue

' Keep temp images name
Dim gTmpImages

' Used by detail tab
Dim FirstActiveDetailTable, ActiveTableItemClass, ActiveTableDivClass

' Used by search panel
Dim SearchPanelClass

' Breadcrumb
Dim Breadcrumb

' ASP.NET / Write permission checking messages
Dim gASPNETMessage, gWritePermissionMessage

'
'  ASPMaker global variables (end)
' ---------------------------------

%>
<%
Const EW_ROWTYPE_PREVIEW = 11 ' Preview record
%>
<%

' Menu
Const EW_MENUBAR_ID = "RootMenu"
Const EW_MENUBAR_BRAND = ""
Const EW_MENUBAR_BRAND_HYPERLINK = ""
Const EW_MENUBAR_CLASSNAME = ""

'Const EW_MENU_CLASSNAME = "nav nav-list"
Const EW_MENU_CLASSNAME = "dropdown-menu"
Const EW_SUBMENU_CLASSNAME = "dropdown-menu"
Const EW_SUBMENU_DROPDOWN_IMAGE = ""
Const EW_SUBMENU_DROPDOWN_ICON_CLASSNAME = ""
Const EW_MENU_DIVIDER_CLASSNAME = "divider"
Const EW_MENU_ITEM_CLASSNAME = "dropdown-submenu"
Const EW_SUBMENU_ITEM_CLASSNAME = "dropdown-submenu"
Const EW_MENU_ACTIVE_ITEM_CLASS = "active"
Const EW_SUBMENU_ACTIVE_ITEM_CLASS = "active"
Const EW_MENU_ROOT_GROUP_TITLE_AS_SUBMENU = False
Const EW_SHOW_RIGHT_MENU = False
%>
<%
Const EW_PDF_STYLESHEET_FILENAME = "" ' Export PDF CSS styles
%>
