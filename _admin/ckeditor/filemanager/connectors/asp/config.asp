<%

' *** DO NOT CHANGE
' ASPMaker parameters and functions

Const EW_ROOT_RELATIVE_PATH = "C:\" ' Relative path of app root
Const EW_UPLOAD_DEST_PATH = "" ' Upload destination path

' Return path of the uploaded file
'	Parameter: If PhyPath is true(1), return physical path on the server;
'	           If PhyPath is false(0), return relative URL
Function ew_UploadPathEx(PhyPath, DestPath)
	Dim Pos, Path
	If PhyPath Then
		Path = Server.MapPath(".")
		Path = ew_PathCombine(Path, EW_ROOT_RELATIVE_PATH, True)
		ew_UploadPathEx = ew_PathCombine(ew_IncludeTrailingDelimiter(Path, True), Replace(DestPath, "/", "\"), PhyPath)
	Else
		Path = ew_ScriptName()
		Path = Mid(Path, 1, InStrRev(Path, "/"))
		Path = ew_PathCombine(Path, EW_ROOT_RELATIVE_PATH, False)
		ew_UploadPathEx = ew_PathCombine(ew_IncludeTrailingDelimiter(Path, False), DestPath, False)
	End If
	ew_UploadPathEx = ew_IncludeTrailingDelimiter(ew_UploadPathEx, PhyPath)
End Function

' Get current script name
Function ew_ScriptName()
	ew_ScriptName = Request.ServerVariables("SCRIPT_NAME")
End Function

' Get path relative to a base path
Function ew_PathCombine(ByVal BasePath, ByVal RelPath, ByVal PhyPath)
	Dim Path, Path2, p1, p2, Delimiter

	'***If ew_RegExTest("^(http|ftp)s?\:\/\/", RelPath) Then ' Allow remote file
	'***	ew_PathCombine = RelPath
	'***	Exit Function
	'***End If

	BasePath = ew_RemoveTrailingDelimiter(BasePath, PhyPath)
	If PhyPath Then
		Delimiter = "\"
		RelPath = Replace(RelPath, "/", "\")
	Else
		Delimiter = "/"
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
			If p2 > 0 Then BasePath = Left(BasePath, p2-1)
		Else
			Path2 = Path2 & Path
		End If
		RelPath = Mid(RelPath, p1+1)
		p1 = InStr(RelPath, Delimiter)
	Wend
	ew_PathCombine = ew_IncludeTrailingDelimiter(BasePath, PhyPath) & Path2 & RelPath
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

' *** DO NOT CHANGE
%>
<%

 ' FCKeditor - The text editor for Internet - http://www.fckeditor.net
 ' Copyright (C) 2003-2010 Frederico Caldeira Knabben
 '
 ' == BEGIN LICENSE ==
 '
 ' Licensed under the terms of any of the following licenses at your
 ' choice:
 '
 '  - GNU General Public License Version 2 or later (the "GPL")
 '    http://www.gnu.org/licenses/gpl.html
 '
 '  - GNU Lesser General Public License Version 2.1 or later (the "LGPL")
 '    http://www.gnu.org/licenses/lgpl.html
 '
 '  - Mozilla Public License Version 1.1 or later (the "MPL")
 '    http://www.mozilla.org/MPL/MPL-1.1.html
 '
 ' == END LICENSE ==
 '
 ' Configuration file for the File Manager Connector for ASP.

%>
<%

' SECURITY: You must explicitly enable this "connector" (set it to "True").
' WARNING: don't just set "ConfigIsEnabled = true", you must be sure that only
'		authenticated users can access this file or use some kind of session checking.

Dim ConfigIsEnabled
ConfigIsEnabled = True

' Path to user files relative to the document root.
' This setting is preserved only for backward compatibility.
' You should look at the settings for each resource type to get the full potential

Dim ConfigUserFilesPath
ConfigUserFilesPath = ew_UploadPathEx(False, "../../../../") ' Application root
ConfigUserFilesPath = ew_PathCombine(ConfigUserFilesPath, EW_UPLOAD_DEST_PATH, False) ' Global upload folder
ConfigUserFilesPath = ew_PathCombine(ConfigUserFilesPath, "userfiles/", False) ' User files folder under global upload folder

' Fill the following value it you prefer to specify the absolute path for the
'   user files directory. Useful if you are using a virtual directory, symbolic
'   link or alias. Examples: 'C:\\MySite\\userfiles\\' or '/root/mysite/userfiles/'.
' Attention: The above 'UserFilesPath' must point to the same directory.

Dim ConfigUserFilesAbsolutePath
ConfigUserFilesAbsolutePath = ew_UploadPathEx(True, "../../../../") ' Application root
ConfigUserFilesAbsolutePath = ew_PathCombine(ConfigUserFilesAbsolutePath, EW_UPLOAD_DEST_PATH, True) ' Global upload folder
ConfigUserFilesAbsolutePath = ew_PathCombine(ConfigUserFilesAbsolutePath, "userfiles/", True) ' User files folder under global upload folder

' Due to security issues with Apache modules, it is recommended to leave the
' following setting enabled.

Dim ConfigForceSingleExtension
ConfigForceSingleExtension = true

' What the user can do with this connector
Dim ConfigAllowedCommands
ConfigAllowedCommands = "QuickUpload|FileUpload|GetFolders|GetFoldersAndFiles|CreateFolder"

' Allowed Resource Types
Dim ConfigAllowedTypes
ConfigAllowedTypes = "File|Image|Flash|Media"

' For security, HTML is allowed in the first Kb of data for files having the
' following extensions only.

Dim ConfigHtmlExtensions
ConfigHtmlExtensions = "html|htm|xml|xsd|txt|js"

'
'	Configuration settings for each Resource Type
'
'	- AllowedExtensions: the possible extensions that can be allowed.
'		If it is empty then any file type can be uploaded.
'
'	- DeniedExtensions: The extensions that won't be allowed.
'		If it is empty then no restrictions are done here.
'
'	For a file to be uploaded it has to fulfill both the AllowedExtensions
'	and DeniedExtensions (that's it: not being denied) conditions.
'
'	- FileTypesPath: the virtual folder relative to the document root where
'		these resources will be located.
'		Attention: It must start and end with a slash: '/'
'
'	- FileTypesAbsolutePath: the physical path to the above folder. It must be
'		an absolute path.
'		If it's an empty string then it will be autocalculated.
'		Useful if you are using a virtual directory, symbolic link or alias.
'		Examples: 'C:\\MySite\\userfiles\\' or '/root/mysite/userfiles/'.
'		Attention: The above 'FileTypesPath' must point to the same directory.
'		Attention: It must end with a slash: '/'
'
' - QuickUploadPath: the virtual folder relative to the document root where
'		these resources will be uploaded using the Upload tab in the resources
'		dialogs.
'		Attention: It must start and end with a slash: '/'
'
'	 - QuickUploadAbsolutePath: the physical path to the above folder. It must be
'		an absolute path.
'		If it's an empty string then it will be autocalculated.
'		Useful if you are using a virtual directory, symbolic link or alias.
'		Examples: 'C:\\MySite\\userfiles\\' or '/root/mysite/userfiles/'.
'		Attention: The above 'QuickUploadPath' must point to the same directory.
'		Attention: It must end with a slash: '/'
'

Dim ConfigAllowedExtensions, ConfigDeniedExtensions, ConfigFileTypesPath, ConfigFileTypesAbsolutePath, ConfigQuickUploadPath, ConfigQuickUploadAbsolutePath
Set ConfigAllowedExtensions	= CreateObject( "Scripting.Dictionary" )
Set ConfigDeniedExtensions	= CreateObject( "Scripting.Dictionary" )
Set ConfigFileTypesPath	= CreateObject( "Scripting.Dictionary" )
Set ConfigFileTypesAbsolutePath	= CreateObject( "Scripting.Dictionary" )
Set ConfigQuickUploadPath	= CreateObject( "Scripting.Dictionary" )
Set ConfigQuickUploadAbsolutePath	= CreateObject( "Scripting.Dictionary" )
ConfigAllowedExtensions.Add	"File", "7z|aiff|asf|avi|bmp|csv|doc|fla|flv|gif|gz|gzip|jpeg|jpg|mid|mov|mp3|mp4|mpc|mpeg|mpg|ods|odt|pdf|png|ppt|pxd|qt|ram|rar|rm|rmi|rmvb|rtf|sdc|sitd|swf|sxc|sxw|tar|tgz|tif|tiff|txt|vsd|wav|wma|wmv|xls|xml|zip"
ConfigDeniedExtensions.Add	"File", ""
ConfigFileTypesPath.Add "File", ConfigUserFilesPath & "file/"
If ConfigUserFilesAbsolutePath = "" Then
	ConfigFileTypesAbsolutePath.Add "File", ""
Else
	ConfigFileTypesAbsolutePath.Add "File", ConfigUserFilesAbsolutePath & "file/"
End If
ConfigQuickUploadPath.Add "File", ConfigFileTypesPath.Item("File")
ConfigQuickUploadAbsolutePath.Add "File", ConfigFileTypesAbsolutePath.Item("File")
ConfigAllowedExtensions.Add	"Image", "bmp|gif|jpeg|jpg|png"
ConfigDeniedExtensions.Add	"Image", ""
ConfigFileTypesPath.Add "Image", ConfigUserFilesPath & "image/"
If ConfigUserFilesAbsolutePath = "" Then
	ConfigFileTypesAbsolutePath.Add "Image", ""
Else
	ConfigFileTypesAbsolutePath.Add "Image", ConfigUserFilesAbsolutePath & "image/"
End If
ConfigQuickUploadPath.Add "Image", ConfigFileTypesPath.Item("Image")
ConfigQuickUploadAbsolutePath.Add "Image", ConfigFileTypesAbsolutePath.Item("Image")
ConfigAllowedExtensions.Add	"Flash", "swf|flv"
ConfigDeniedExtensions.Add	"Flash", ""
ConfigFileTypesPath.Add "Flash", ConfigUserFilesPath & "flash/"
If ConfigUserFilesAbsolutePath = "" Then
	ConfigFileTypesAbsolutePath.Add "Flash", ""
Else
	ConfigFileTypesAbsolutePath.Add "Flash", ConfigUserFilesAbsolutePath & "flash/"
End If
ConfigQuickUploadPath.Add "Flash", ConfigFileTypesPath.Item("Flash")
ConfigQuickUploadAbsolutePath.Add "Flash", ConfigFileTypesAbsolutePath.Item("Flash")
ConfigAllowedExtensions.Add	"Media", "aiff|asf|avi|bmp|fla|flv|gif|jpeg|jpg|mid|mov|mp3|mp4|mpc|mpeg|mpg|png|qt|ram|rm|rmi|rmvb|swf|tif|tiff|wav|wma|wmv"
ConfigDeniedExtensions.Add	"Media", ""
ConfigFileTypesPath.Add "Media", ConfigUserFilesPath & "media/"
If ConfigUserFilesAbsolutePath = "" Then
	ConfigFileTypesAbsolutePath.Add "Media", ""
Else
	ConfigFileTypesAbsolutePath.Add "Media", ConfigUserFilesAbsolutePath & "media/"
End If
ConfigQuickUploadPath.Add "Media", ConfigFileTypesPath.Item("Media")
ConfigQuickUploadAbsolutePath.Add "Media", ConfigFileTypesAbsolutePath.Item("Media")
%>
