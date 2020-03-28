<script language="jscript" runat="server">
//
// Huge thanks to Vic Sowers for contributing this JavaScript API for Imager Reiszer! You rock!
// / Karl-Johan Sjögren
//
// Imager.dll JavaScript API
//
// imager = new Imager(sPath);  creates the Imager object. 'sPath' is the URL of Imager.dll and
//                              defaults to http://localhost/cgi-bin/Imager.dll
//
// The following functions are exposed:
//
//   imager.Go({args,...});  calls Imager.dll to process an image file. 'args' are any of (default):
//     Image:<absolute image path> ("")
//     Width:<desired width in pixels> (-1)
//     Height:<desired height in pixels> (-1)
//     Autorotate:<true|false> (false)
//     Whitespace:<true|false> (false)
//     Rotation:<desired rotation in degrees> (0)
//     ProcessBinary:<true|false> (true)
//     ProcessExif:<true|false> (true)
//     UseQueryString:<true|false> (false)
//     Compression:<compression width> (-1 [=80])
//     Output:<output file type> ("" [=same as image])
//
//     For a full explanation of the above parameters, pease see the Imager.dll documentation
//
//   imager.SaveToFile(sSavePath,bOverwrite);  saves the new image as 'sSavePath', overwrites if bOverwrite==true
//   imager.getEXIF();  returns a structure of EXIF data: {<name>:<value>,...}
//   imager.getBinary();  returns a binary string of the new image
//   imager.getMime();  returns a text string of mime data
//   imager.getFilename();  returns the original file name (no path info)
//
// The following variables are exposed:
//
//   imager.ErrorCode;  contains the error code for the last operation. 0(zero) == Success
//   imager.ErrorText;  contains a description of the status of the last operation 'Success' == Success
//   imager.OriginalWidth;  contains the width in pixels of the original image
//   imager.OriginalHeight;  contains the height in pixels of the original image

var adTypeBinary=1, adModeReadWrite=3, adSaveCreateNotExist=1, adSaveCreateOverwrite=2;

function Imager(sPath) {
	this.ImagerPath = sPath?sPath:"http://localhost/cgi-bin/Imager.dll";

	this.defaults = {
		Image:"",Width:-1,Height:-1,Autorotate:true,Whitespace:false,Rotation:0,ProcessBinary:true,
		ProcessExif:true,UseQueryString:false, Compression:-1, Output:""
		}
	for (var d in this.defaults) this[d] = this.defaults[d];

	this.ErrorCode = 0;
	this.ErrorText = "";
	this.sURL = "";
	this.xmlDom = null;
	this.XMLHTTP = null;
	}

function Imager.prototype.setStatus(ret,num,txt) { // internally used to set the Imager error codes
	this.ErrorCode = num;
	if (num==0) this.ErrorText = "Success"
	else {
		var name = /(\w+?)\(/.exec(Imager.prototype.setStatus.caller.toString())[1];
		this.ErrorText = "Imager/"+name+" failed: "+txt;
		}
	return ret;
	}

function Imager.prototype.Go(args) { // args = {ArgName:value,...} where ArgName is in 'defaults' above.
	for (var a in this.defaults) this[a] = args&&typeof(args[a])!="undefined"?args[a]:this.defaults[a];
	var xmlNode,errCode,errText;

	if (this.UseQueryString) {
		this.sURL = this.ImagerPath+"/xml?"+Request.ServerVariables("QUERY_STRING");
		} else {
		this.sURL = this.ImagerPath+"/xml?Image="+this.Image
			+"&Width="+this.Width
			+"&Height="+this.Height
			+"&Autorotate="+this.Autorotate
			+"&Whitespace="+this.Whitespace
			+"&Rotation="+this.Rotation
			+"&ProcessExif="+this.ProcessExif
			+"&ProcessBinary="+this.ProcessBinary
			+(this.Compression>-1?("&Compression="+this.Compression):"")
			+(this.Output?("&Output="+this.Output):"");
		}
	this.XMLHTTP = Server.CreateObject("Microsoft.XMLHTTP");
	this.XMLHTTP.Open("GET",this.sURL,false);
	this.XMLHTTP.Send();
	this.xmlDom = this.XMLHTTP.ResponseXML;
	if (this.xmlDom.parseError!=0)
		this.xmlDom.loadXML("<root><errorcode>"+this.xmlDom.parseError+"</errorcode>"
												 +"<errortext>" +this.xmlDom.parseError.reason+"</errortext></root>");

	if (this.xmlDom.documentElement==null)
		return this.setStatus(false,-1,"Invalid XML returned. Check your parameters. ("+this.sURL+")");

	xmlNode = this.xmlDom.selectSingleNode("/root/imageinfo/originalwidth")
	this.OriginalWidth = xmlNode!=null?xmlNode.text:null;
	xmlNode = this.xmlDom.selectSingleNode("/root/imageinfo/originalheight")
	this.OriginalHeight = xmlNode!=null?xmlNode.text:null;

	xmlNode = this.xmlDom.selectSingleNode("/root/errorcode");
	errCode = xmlNode!=null?Number(xmlNode.text):-100;
	xmlNode = this.xmlDom.selectSingleNode("/root/errortext");
	errText = xmlNode!=null?xmlNode.text:"no status information available";
	return this.setStatus(true,errCode,errText);
	}

function Imager.prototype.SaveToFile(sSavePath, bOverWrite) { // Saves the new image to file sSavePath.
	var oStream,xmlNode,iOverWrite

	xmlNode = this.xmlDom.selectSingleNode("/root/imageinfo/imagedata");
	if (xmlNode==null) return this.setStatus(false, -100, "no image data");
	oStream = Server.CreateObject("ADODB.Stream")
	oStream.Type = adTypeBinary;
	oStream.Mode = adModeReadWrite;
	oStream.Open();
	oStream.Write(xmlNode.nodeTypedValue);
	oStream.Position = 0;

	iOverWrite = bOverWrite?adSaveCreateOverwrite:adSaveCreateNotExist;
	try {
		oStream.SaveToFile(sSavePath,iOverWrite);
		} catch(e) {
		oStream.Close();
		return this.setStatus(false, -2, "#"+e.number+" "+e.description);
		}

	oStream.Close();
	return this.setStatus(true, 0);
	}

function Imager.prototype.getEXIF() {
	var xmlNode, xmlCol, oExif;
	xmlCol = this.xmlDom.selectSingleNode("/root/exifdata");
	oExif = {};

	if (xmlCol && xmlCol.childNodes) {
		for (var c=0; c<xmlCol.childNodes.length; c++) {
			xmlNode = xmlCol.childNodes(c);
			oExif[xmlNode.nodeName] = xmlNode.text;
			}
		return this.setStatus(oExif, 0);
		}
	else return this.setStatus("", -101, "no EXIF data");
	}

function Imager.prototype.getBinary() {
	var xmlNode = this.xmlDom.selectSingleNode("/root/imageinfo/imagedata");
	if (xmlNode) return this.setStatus(xmlNode.nodeTypedValue, 0);
	return this.setStatus("", -102, "no binary data");
	}

function Imager.prototype.getMime() {
	var xmlNode = this.xmlDom.selectSingleNode("/root/imageinfo/mime");
	if (xmlNode) return this.setStatus(xmlNode.text, 0);
	return this.setStatus("", -103, "no mime data");
	}

function Imager.prototype.getFilename() {
	var xmlNode = this.xmlDom.selectSingleNode("/root/imageinfo/filename");
	if (xmlNode) return this.setStatus(xmlNode.text, 0);
	return this.setStatus("", -104, "no filename");
	}
</script>