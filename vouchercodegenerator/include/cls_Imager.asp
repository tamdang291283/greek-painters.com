<%
  class cls_Imager
    public ImagerPath
    public Image
    public Width
    public Height
    public Compression
    public Output
    public OriginalWidth
    public OriginalHeight
    public Autorotate
    public Whitespace
    public Rotation
    public ProcessExif
    public ProcessBinary
    public UseQueryString
    public ErrorCode
    public ErrorText
    public xmlDom
    private xmlHTTP
    private sURL

    public sub Class_Initialize()
      ImagerPath = ""
      Image = ""
      Width = -1
      Height = -1
      Compression = 80
      Output = ""
      OriginalWidth = -1
      OriginalHeight = -1
      Autorotate = true
      Whitespace = false
      Rotation = 0
      ProcessExif = true
      ProcessBinary = true
      UseQueryString = false
      sURL = ""
      ErrorCode = 0
      ErrorText = ""
    end sub

    public sub Class_Terminate()
      set xmlDom = nothing
      set XMLHTTP = nothing
    end sub

    public sub Go()

      dim xmlNode

      if UseQueryString then
        sURL = ImagerPath & "/xml?" & Request.ServerVariables("QUERY_STRING")
      else
        sURL = ImagerPath & "/xml?Image=" & Image & "&Width=" & Width & "&Height=" & Height & "&Autorotate=" & Autorotate & "&Whitespace=" & Whitespace & "&Rotation=" & Rotation & "&Compression=" & Compression & "&Output=" & Output & "&ProcessExif=" & ProcessExif & "&ProcessBinary=" & ProcessBinary
      end if
      set xmlHTTP = Server.CreateObject("Microsoft.XMLHTTP")
      xmlHTTP.Open "GET", sURL, false
      xmlHTTP.Send()

      set xmlDom = xmlHTTP.ResponseXML
      set xmlHTTP = nothing

      if xmlDom.parseError <> 0 then
        xmlDom.loadXML("<root><errorcode>" & xmlDom.parseError & "</errorcode><errortext>" & xmlDom.parseError.reason & "</errortext></root>")
      end if

      if xmlDom.documentElement is nothing then
        xmlDom.loadXML("<root><errorcode>-1</errorcode><errortext>Invalid XML returned. Check your parameters. (" & sURL & ")</errortext></root>")
      end if

      set xmlNode = xmlDom.selectSingleNode("/root/errorcode")
      if not xmlNode is nothing then
        ErrorCode = xmlNode.text
      end if
      set xmlNode = xmlDom.selectSingleNode("/root/errortext")
      if not xmlNode is nothing then
        ErrorText = xmlNode.text
      end if

      set xmlNode = xmlDom.selectSingleNode("/root/imageinfo/originalwidth")
      if not xmlNode is nothing then
        OriginalWidth = xmlNode.text
      end if
      set xmlNode = xmlDom.selectSingleNode("/root/imageinfo/originalheight")
      if not xmlNode is nothing then
        OriginalHeight = xmlNode.text
      end if
    end sub

    public function SaveToFile(sSavePath, bOverWrite)
      dim oStream, xmlNode, iOverWrite
      set xmlNode = xmlDom.selectSingleNode("/root/imageinfo/imagedata")

      if not xmlNode is nothing then
        set oStream = Server.CreateObject("ADODB.Stream")
        oStream.type = 1 'adTypeBinary
        oStream.mode = 3 'adModeReadWrite
        oStream.open
        oStream.write xmlNode.nodeTypedValue
        oStream.Position = 0

        if(bOverWrite) then
          iOverWrite = 2
        else
          iOverWrite = 1
        end if

        on error resume next
        call oStream.SaveToFile(Server.MapPath(sSavePath), iOverWrite)

        if(Err <> 0) then
          oStream.Close
          set oStream = nothing
          ErrorCode = -2
          ErrorText = "Imager Class failed: #" & Err.Number & " " & Err.Description
          SaveToFile = false
          on error goto 0
          exit function
        end if
        on error goto 0

        oStream.Close
        set oStream = Nothing
        SaveToFile = true
      else
        SaveToFile = false
      end if
    end function

    public function getEXIF()
      dim xmlNode, xmlCol, oDict
      set xmlCol = xmlDom.selectSingleNode("/root/exifdata")
      set oDict = Server.CreateObject("Scripting.Dictionary")

      if not xmlCol is nothing then
        for each xmlNode in xmlCol.childNodes
          call oDict.Add(xmlNode.nodeName, xmlNode.text)
        next
      end if

      set getEXIF = oDict
    end function

    public function getBinary()
      dim xmlNode
      set xmlNode = xmlDom.selectSingleNode("/root/imageinfo/imagedata")

      if not xmlNode is nothing then
        getBinary = xmlNode.nodeTypedValue
      else
        getBinary = ""
      end if
    end function

    public function getMime()
      dim xmlNode
      set xmlNode = xmlDom.selectSingleNode("/root/imageinfo/mime")

      if not xmlNode is nothing then
        getMime = xmlNode.text
      else
        getMime = ""
      end if
    end function

    public function getFilename()
      dim xmlNode
      set xmlNode = xmlDom.selectSingleNode("/root/imageinfo/filename")

      if not xmlNode is nothing then
        getFilename = xmlNode.text
      else
        getFilename = ""
      end if
    end function
  end class
%>
