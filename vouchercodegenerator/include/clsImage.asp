<%
' This class has been extended to include support for the following:
'	BMP, GIF, JPG, PNG
'	AVI, MOV, MPG/MPEG
'	SWF

Class clsImage
	Private mStrBinaryData
	Private mLngWidth
	Private mLngHeight
	Private mStrType
	Private mStrContentType
	Private mLngSize
	Private mStrPath

	Private Sub Class_Initialize()
		mStrBinaryData = ChrB(0)
		mLngWidth = -1
		mLngHeight = -1
		mLngSize = -1
		mStrPath = "Undefined"
		mStrType = "Unknown"
		mStrContentType = "application/octet-stream"
	End Sub
	
	Public Sub Read(ByVal pStrFilePath)
		
		' Reset
		mStrBinaryData = ""
		mLngWidth = -1
		mLngHeight = -1
		mLngSize = -1
		mStrType = "Unknown"
		mStrContentType = "application/octet-stream"
		
		If InStr(1, pStrFilePath, ":\") = 0 Then
			pStrFilePath = Server.MapPath(pStrFilePath)
		End If
		
		mStrPath = pStrFilePath
		
		Dim lObjFSO
		Dim lObjFile
		Set lObjFSO = Server.CreateObject("Scripting.FileSystemObject")
		
		If lObjFSO.FileExists(pStrFilePath) Then
			Set lObjFile = lObjFSO.OpenTextFile(pStrFilePath)
			If Not lObjFile.AtEndOfStream Then
				mStrBinaryData = ChrB(Asc(lObjFile.Read(1)))
				While Not lObjFile.AtEndOfStream
					 mStrBinaryData = mStrBinaryData & ChrB(Asc(lObjFile.Read(1)))
				Wend
			End If
			lObjFile.Close
			Call ReadDimensions()
		End If
		
		Set lObjFSO = Nothing
		
	End Sub
	
	Public Property Let DataStream(ByRef pStrBinaryData)
		mStrPath = "DataStream"
		mStrBinaryData = pStrBinaryData
		Call ReadDimensions()
	End Property
	
	Public Property Get DataStream()
		DataStream = mStrBinaryData
	End Property
	
	Public Property Get Width()
		Width = mLngWidth
	End Property
	
	Public Property Get Height()
		Height = mLngHeight
	End Property
	
	Public Property Get ImageType()
		ImageType = mStrType
	End Property
	
	Public Property Get ContentType()
		ContentType = mStrContentType
	End Property
	
	Public Property Get Size()
		Size = mLngSize
	End Property
	
	Public Property Get Path()
		Path = mStrPath
	End Property
	
	Private Sub ReadDimensions() 
		
		mLngWidth = -1
		mLngHeight = -1
		mLngSize = LenB(mStrBinaryData)
		mStrType = "Unknown"
		mStrContentType = "application/octet-stream"
		
		' I refer to Ascii data as Binary data or "BIN" in this script.
		
		Dim lBinGIF		' Signature of GIF
		Dim lBinJPG		' Signature of JPG
		Dim lBinBMP		' Signature of BMP
		Dim lBinPNG		' Signature of PNG
		Dim lBinAVI		' Signature of AVI
		Dim lBinSWF		' Signature of SWF
		
		Dim lBinMOV		' Signature of MOV
		Dim lBinMPG		' Signature of MPG
		
		lBinGIF = ChrB(Asc("G")) & ChrB(Asc("I")) & ChrB(Asc("F"))
		lBinJPG = ChrB(Asc("J")) & ChrB(Asc("F")) & ChrB(Asc("I")) & ChrB(Asc("F"))
		lBinBMP = ChrB(Asc("B")) & ChrB(Asc("M"))
		lBinPNG = ChrB(&h89) & ChrB(Asc("P")) & ChrB(Asc("N")) & ChrB(Asc("G"))
		lBinAVI = ChrB(Asc("R")) & ChrB(Asc("I")) & ChrB(Asc("F")) & ChrB(Asc("F"))
		lBinSWF = ChrB(Asc("F")) & ChrB(Asc("W")) & ChrB(Asc("S"))
		lBinMOV = ChrB(Asc("t")) & ChrB(Asc("k")) & ChrB(Asc("h")) & ChrB(Asc("d"))
		lBinMPG = ChrB(0) & ChrB(0) & ChrB(1) & ChrB(179)
		
		' GIF File
		If InStrB(1, mStrBinaryData, lBinGIF) = 1 Then
			mStrType = "GIF"
			mStrContentType = "image/gif"
			
			mLngWidth = CLng("&h" & HexAt(8) & HexAt(7))
			mLngHeight = CLng("&h" & HexAt(10) & HexAt(9))
		' JPEG file
		ElseIf InStrB(1, mStrBinaryData, lBinJPG) = 7 Then
			Dim lBinPrefix
			Dim lLngStart
		
			mStrType = "JPG"
			mStrContentType = "image/jpeg"
			
			' Prefix found before image dimensions		
			lBinPrefix = ChrB(&h00) & ChrB(&h11) & ChrB(&h08)

			' Find the last prefix (so we don't confuse it with data)		
			lLngStart = 1
			Do
				If InStrB(lLngStart, mStrBinaryData, lBinPrefix) + 3 = 3 Then Exit Do
				lLngStart = InStrB(lLngStart, mStrBinaryData, lBinPrefix) + 3
			Loop
			' If a prefix was found
			If Not lLngStart = 1 Then
				mLngWidth = CLng("&h" & HexAt(lLngStart+2) & HexAt(lLngStart+3))
				mLngHeight = CLng("&h" & HexAt(lLngStart) & HexAt(lLngStart+1))
			End If
		' Bitmap File
		ElseIf InStrB(1, mStrBinaryData, lBinBMP) = 1 Then
			mStrType = "BMP"
			mStrContentType = "image/bmp"
			mLngWidth = CLng("&h" & HexAt(22) & HexAt(21) & HexAt(20) & HexAt(19))
			mLngHeight = CLng("&h" & HexAt(26) & HexAt(25) & HexAt(24) & HexAt(23))
		' PNG File
		ElseIf InStrB(1, mStrBinaryData, lBinPNG) = 1 Then
			mStrType = "PNG"
			mStrContentType = "image/png"
			mLngWidth = CLng("&h" & HexAt(17) & HexAt(18) & HexAt(19) & HexAt(20))
			mLngHeight = CLng("&h" & HexAt(21) & HexAt(22) & HexAt(23) & HexAt(24))
		' AVI File
		ElseIf InStrB(1, mStrBinaryData, lBinAVI) = 1 Then			
			Dim lBinAVIH, bpAVIH
			lBinAVIH = ChrB(Asc("a")) & ChrB(Asc("v")) & ChrB(Asc("i")) & ChrB(Asc("h"))			
			bpAVIH = InStrB(1, mStrBinaryData, lBinAVIH)
			If bpAVIH > 1 Then
				bpAVIH = bpAVIH + 40
				mStrType = "AVI"
				mStrContentType = "video/avi"
				mLngWidth = CLng("&h" & HexAt(bpAVIH + 3) & HexAt(bpAVIH + 2) & HexAt(bpAVIH + 1) & HexAt(bpAVIH))
				mLngHeight = CLng("&h" & HexAt(bpAVIH + 7) & HexAt(bpAVIH + 6) & HexAt(bpAVIH + 5) & HexAt(bpAVIH + 4))
			End If			
		' Shockwave Flash File
		ElseIf InStrB(1, mStrBinaryData, lBinSWF) = 1 Then
			mStrType = "SWF"
			mStrContentType = "application/x-shockwave-flash"
			' Get FrameSize.  Note: According to specification, NBits will
			' always be 15.  This parser assumes that X and Y minimums are
			' always 0, or rather, b000000000000000, and that numbers are
			' expressed in 20 twips/pixel.  The FrameSize RECT utilizes 9
			' bytes, starting at position 9.
			' This segment has been coded to handle dynamic NBit values, and
			' should technically handle the max size of 31 in the future.
			Dim lBinSWFNBits
			Dim lBinSWFXMin
			Dim lBinSWFXMax
			Dim lBinSWFYMin
			Dim lBinSWFYMax
			Dim lBinSWFTBytes			
			Dim lBinSWFVal			
			' Determine NBits size (should be 15)
			lBinSWFNBits = AscB(RShift(ChrB(CLng("&h" & HexAt(9))), 3))
			lBinSWFTBytes = ((5 + lBinSWFNBits) / 8) 
			If ((5 + lBinSWFNBits) Mod 8) > 0 Then
				lBinSWFTBytes = lBinSWFTBytes + 1
			End If
			' Determine number of bytes needed to total to the bits			
			lBinSWFTBytes = fix(((lBinSWFNBits * 4) + 5) / 8)
			If (((lBinSWFNBits * 4) + 5) Mod 8) > 0 Then
				lBinSWFTBytes = lBinSWFTBytes + 1
			End If			
			' Read in all the bits needed.
			lBinSWFVal = MidB(mStrBinaryData, 9, lBinSWFTBytes)
			' Determine Y-Maximum
			lBinSWFVal = RShift(lBinSWFVal, (lBinSWFTBytes * 8) - ((lBinSWFNBits * 4) + 5))
			lBinSWFYMax = ATOI(RShift(MidB(LShift(MidB(lBinSWFVal, (LenB(lBinSWFVal) - 4) + 1, 4), 1), (LenB(LShift(MidB(lBinSWFVal, (LenB(lBinSWFVal) - 4) + 1, 4), 1)) - 4) + 1, 4), 1)) And ((2 ^ lBinSWFNBits) - 1)
			' Determine Y-Minimum
			lBinSWFVal = RShift(lBinSWFVal, lBinSWFNBits)
			lBinSWFYMin = ATOI(RShift(MidB(LShift(MidB(lBinSWFVal, (LenB(lBinSWFVal) - 4) + 1, 4), 1), (LenB(LShift(MidB(lBinSWFVal, (LenB(lBinSWFVal) - 4) + 1, 4), 1)) - 4) + 1, 4), 1)) And ((2 ^ lBinSWFNBits) - 1)
			' Determine X-Maximum
			lBinSWFVal = RShift(lBinSWFVal, lBinSWFNBits)
			lBinSWFXMax = ATOI(RShift(MidB(LShift(MidB(lBinSWFVal, (LenB(lBinSWFVal) - 4) + 1, 4), 1), (LenB(LShift(MidB(lBinSWFVal, (LenB(lBinSWFVal) - 4) + 1, 4), 1)) - 4) + 1, 4), 1)) And ((2 ^ lBinSWFNBits) - 1)
			' Determine X-Minimum
			lBinSWFVal = RShift(lBinSWFVal, lBinSWFNBits)
			lBinSWFXMin = ATOI(RShift(MidB(LShift(MidB(lBinSWFVal, (LenB(lBinSWFVal) - 4) + 1, 4), 1), (LenB(LShift(MidB(lBinSWFVal, (LenB(lBinSWFVal) - 4) + 1, 4), 1)) - 4) + 1, 4), 1)) And ((2 ^ lBinSWFNBits) - 1)
			' Now calculate the Width and Height in pixels
			mLngWidth = ((lBinSWFXMax - lBinSWFXMin) + 1) \ 20
			mLngHeight = ((lBinSWFYMax - lBinSWFYMin) + 1) \ 20			
		' MPEG File
		ElseIf InStrB(1, mStrBinaryData, lBinMPG) > 0 Then
			mStrType = "MPG"
			mStrContentType = "video/mpeg"
			Dim lBinMPGPos
			Dim lBinMPGVal
			lBinMPGPos = InStrB(1, mStrBinaryData, lBinMPG) + LenB(lBinMPG) 
			lBinMPGVal = MidB(mStrBinaryData, lBinMPGPos, 3)
			mLngHeight = ATOI(lBinMPGVal) And ((2 ^ 12) - 1)
			lBinMPGVal = RShift(lBinMPGVal, 12)
			mLngWidth = ATOI(lBinMPGVal) And ((2 ^ 12) - 1)						
		' Quicktime Movie File
		ElseIf InStrB(1, mStrBinaryData, lBinMOV) > 0 Then
			mStrType = "MOV"
			mStrContentType = "video/quicktime"
			Dim lBinMOVPos
			lBinMOVPos = InStrB(1, mStrBinaryData, lBinMov) + LenB(lBinMov) 
			mLngWidth = ATOI(ReverseB(MidB(mStrBinaryData, lBinMOVPos + 77, 4)))
			mLngHeight = ATOI(ReverseB(MidB(mStrBinaryData, lBinMOVPos + 77 + 4, 4)))
		End If
'		Response.Write "<UL><LI>mStrType = " & mStrType & "<LI>mStrContentType = " & mStrContentType & "<LI>mLngWidth = " & mLngWidth & "<LI>mLngHeight = " & mLngHeight & "</UL>"
	End Sub

	Private Function HexAt(ByRef pLngPosition)
		If pLngPosition > LenB(mStrBinaryData) Or pLngPosition <= 0 Then Exit Function
		HexAt = Right("0" & Hex(AscB(MidB(mStrBinaryData, pLngPosition, 1))), 2)
	End Function

' --------------------------- MOVE TO COMMON FUNCTIONS ----------------------------
	
	Private Function ReverseB(sValue)
		Dim iCur, iLen, iRes : iRes = ""
		iLen = LenB(sValue)
		If (iLen < 1) Then
			ReverseB = Null
			Exit Function
		End If
		For iCur = 1 To iLen
			iRes = iRes & MidB(sValue, iLen - iCur + 1, 1)
		Next
		ReverseB = iRes		
	End Function

	Private Function ATOI(sValue)
		Dim iCur, iLen, iVal, iRes : iRes = 0
		iLen = LenB(sValue)

		If (iLen > 4) Or (iLen < 1) Then
			ATOI = Null
			Exit Function
		End If
		For iCur = 1 To iLen
			iVal = CLng(AscB(MidB(sValue, iLen - iCur + 1, 1)))
			If iCur > 1 Then
				iVal = iVal * (256 ^ (iCur - 1))
			End If
			iRes = iRes + iVal
		Next
		ATOI = iRes
	End Function
	
	Private Function LShift(sValue, iBits)
		Dim i__BYTE : i__BYTE = 8
		Dim sResult, sHold, iPartial
		Dim iLen, iCur, sByte, iByte
		
		' Do nothing if no bit shift requested, or perform LShift.
		If iBits = 0 Then
			LShift = sValue
			Exit Function
		ElseIf iBits < 0 Then
			LShift = RShift(sValue, Abs(iBits))
			Exit Function
		ElseIf LenB(sValue) < Fix(iBits / i__BYTE) Then
			LShift = sValue
			Exit Function		
		End If

		' Add whole bytes
		iLen = Fix(iBits / i__BYTE)
		sResult = sValue
		If iLen > 0 Then
			For iCur = 1 To iLen
				sResult = sResult & ChrB(0)
			Next
		End If
		iPartial = iBits Mod i__BYTE
		If iPartial = 0 Then
			LShift = sResult
			Exit Function
		End If
		sHold = sResult
		sResult = ""

		' Byte by Byte, shift remaining bits.
		iLen = LenB(sHold)
		For iCur = 1 To iLen
			If iCur < iLen Then
				sByte = MidB(sHold, iCur, 2)
				iByte = (AscB(MidB(sByte, 1, 1)) * 256) + AscB(MidB(sByte, 2, 1))
			Else
				sByte = MidB(sHold, iCur, 1)
				iByte = (AscB(sByte) * 256)
			End If
			' Perform the shift
			iByte = Fix(CLng(iByte) * (2 ^ iPartial))
			' Convert back to string
			If iCur = 1 Then
				' 2 Left Most Bytes
				sByte = String(Len(Hex(iByte)) Mod 2, "0") & Hex(iByte) & String(6,"0")
				sByte = Left(sByte, Len(sByte) - 2)
				sResult = sResult & ChrB(CLng("&h" & String(6, "0") & Left(sByte, 2)))
				sResult = sResult & ChrB(CLng("&h" & String(6, "0") & Mid(sByte, 3, 2)))
			Else
				' Middle Byte
				sByte = Right(String(6, "0") & String(Len(Hex(iByte)) Mod 2, "0") & Hex(iByte), 6)
				sResult = sResult & ChrB(CLng("&h" & String(6, "0") & Mid(sByte, 3, 2)))
			End If
		Next
		LShift = sResult	
	End Function
	
	Private Function RShift(sValue, iBits)
		Dim i__BYTE : i__BYTE = 8
		Dim sResult, sHold, iPartial
		Dim iLen, iCur, sByte, iByte
		
		' Do nothing if no bit shift requested, or perform LShift.
		If iBits = 0 Then
			RShift = sValue
			Exit Function
		ElseIf iBits < 0 Then
			RShift = LShift(sValue, Abs(iBits))
			Exit Function
		ElseIf LenB(sValue) < Fix(iBits / i__BYTE) Then
			RShift = sValue
			Exit Function		
		End If

		' Remove whole bytes
		If Fix(iBits / i__BYTE) > 0 Then 
			sResult = MidB(sValue, 1, LenB(sValue) - Fix(iBits / i__BYTE))
		Else
			sResult = sValue
		End If
		iPartial = iBits Mod i__BYTE
		If iPartial = 0 Then
			RShift = sResult
			Exit Function
		End If
		sHold = sResult
		sResult = ""

		' Byte by Byte, shift remaining bits.
		iLen = LenB(sHold)
		For iCur = iLen To 1 Step -1
			If iCur > 1 Then
				' Get this byte (with additional byte prefix)
				sByte = MidB(sHold, iCur - 1, 2)
				iByte = (AscB(MidB(sByte, 1, 1)) * 256) + AscB(MidB(sByte, 2, 1))
			Else
				sByte = MidB(sHold, iCur, 1)
				iByte = AscB(sByte)
			End If
			' Perform the shift
			iByte = Fix(CLng(iByte) * 2 ^ (-1 * iPartial))
			' Convert back to string			
			sByte = ChrB(CLng("&h" & Right(("00" & Hex(iByte)), 2)))
			sResult = sByte & sResult
		Next
		
		' Finally, readd empty bytes as necessary
		iLen = Fix(iBits / i__BYTE)
		If iLen > 0 Then
			For iCur = 1 To iLen
				sResult = ChrB(0) & sResult
			Next
		End If
		
		RShift = sResult	
	End Function
	
	Private Function ToBinary(sVal)
		Dim iLen, iCur, iByte, iVal, iB, OUT, OUTH
		iLen = LenB(sVal)
		If iLen = 0 Then 
			ToBinary = ""
			Exit Function
		End If
		For iCur = 1 To iLen
			iByte = MidB(sVal, iCur, 1)
			iVal = AscB(iByte)
			OUTH = OUTH & Right("0" & Hex(iVal), 2)
			For iB = 7 To 1 Step -1
				If iVal >= (2 ^ iB) Then
					OUT = OUT & "1"
					iVal = iVal - (2 ^ iB)
				Else
					OUT = OUT & "0"
				End If				
			Next
			If iVal > 0 Then
				OUT = OUT & "1"
			Else
				OUT = OUT & "0"
			End If
			OUT = OUT & "."
		Next
		ToBinary = OUTH & "&nbsp;&nbsp;&nbsp;" & OUT
	End Function
	
End Class
%>