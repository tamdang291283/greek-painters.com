<%


Set WshShell = CreateObject("WScript.Shell")

'Return = WshShell.Run("iexplore.exe www.greek-painters.com/vo/food/7-2-Dang/test/serverbrowse/write-file.asp", 1)
       Return = WshShell.Run("""C:\Program Files (x86)\Internet Explorer\iexplore.exe"" www.greek-painters.com/vo/food/7-2-Dang/printers/Epson/print_t.asp?mod=dishname&id_o=2837&id_r=2&isPrint=&idlist=", 1)


response.write(return)
Set WshShell = nothing

%>