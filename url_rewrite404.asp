
<%@LANGUAGE="VBScript"%>

<%
Option Explicit
Dim Config_ConnectionString, Config_DatabaseServer, m_conn, m_rs, m_sql
%>
<!-- #include file="../incfiles/SQLInject.asp" -->
<!-- #include file="../ConnString.asp" -->
<%
Public Sub PageNotFound()
    Dim FileContents 'As String
	Dim m_sfo, objFile	
	Set m_sfo = Server.CreateObject("Scripting.FileSystemObject")
	Set objFile = m_sfo.OpenTextFile(Server.MapPath("/404.htm"), 1)
	If NOT objFile.AtEndOfStream Then
		FileContents = objFile.ReadAll()
	End If
	objFile.Close
	Set objFile = Nothing
	Set m_sfo = Nothing
	if FileContents <> "" Then
		Response.Clear()
		Response.Status = "404 Not Found"
		Response.AddHeader "Location", "PageNotFound"
		Response.Write(FileContents)
		Response.End()		
	Else
		Response.Redirect("http://www.swimoutlet.com/404.htm")
	End If		
End Sub

'-----------------------------Redirect to Mobile------------------------------'
function isDetectProductdetailPage() 'SWIMOUTLET-14345
dim urlpage, result
    result =  true
    urlpage = lcase(Replace(Request.ServerVariables("QUERY_STRING"),"404;",""))
    urlpage =  Replace(urlpage,":80","")
    urlpage =  Replace(urlpage,":443","")
    if instr(urlpage,"/p/") > 0 and instr(urlpage,"utm_source=facebook&utm_medium=cpc&utm_campaign=facebook") > 0 then
        result =  false
    end if
    isDetectProductdetailPage = result
end function
function isReviewsPage() 
dim urlpage, result
    result =  false
    urlpage = lcase(Replace(Request.ServerVariables("QUERY_STRING"),"404;",""))
    urlpage =  Replace(urlpage,":80","")
    urlpage =  Replace(urlpage,":443","")
    if (instr(urlpage,"-c") > 0) and instr(urlpage,"/reviews") > 0 then
        result =  true
    end if
    isReviewsPage = result
end function
function isQuestionPage() 
dim urlpage, result
    result =  false
    urlpage = lcase(Replace(Request.ServerVariables("QUERY_STRING"),"404;",""))
    urlpage =  Replace(urlpage,":80","")
    urlpage =  Replace(urlpage,":443","")
    if (instr(urlpage,"/q/") > 0) then
        result =  true		
    end if
    isQuestionPage = result
end function
function isQuestionAnswerPage() 
dim urlpage, result
    result =  false
    urlpage = lcase(Replace(Request.ServerVariables("QUERY_STRING"),"404;",""))
    urlpage =  Replace(urlpage,":80","")
    urlpage =  Replace(urlpage,":443","")
    if (instr(urlpage,"/qa/") > 0) then
        result =  true		
    end if
    isQuestionAnswerPage = result
end function
' Tam dang update lifestyle to detect categorypage
     function isCategoryPage(byval requestUrl)
        dim isCategory : isCategory =  false
        dim urlbrandpage
        Dim reg_promotion,categoryID
	    Dim matches_promotion
	    Set reg_promotion = New RegExp
	        reg_promotion.IgnoreCase = True
	        reg_promotion.Global = True
            urlbrandpage = lcase(Replace(requestUrl,"404;",""))
            urlbrandpage =  Replace(urlbrandpage,":80","")
            urlbrandpage =  Replace(urlbrandpage,":443","")

        if InStr(requestUrl,"-c") > 0 and Ubound(split(urlbrandpage,"/")) < 7 Then
            reg_promotion.Pattern = "-c[0-9]+/?"
            Set matches_promotion = reg_promotion.Execute(requestUrl)
            
	        If matches_promotion.Count > 0 Then
                     
		        categoryID = Replace(Replace(matches_promotion.Item(0).Value, "-c",""), "/", "")
                if categoryID & "" <> "" then
                    if  IsNumeric(categoryID) then
                        isCategory =  true
                    end if
                end if
	        End If 
           
        end if
        
        isCategoryPage = isCategory
     end function
' End 
' Sta: Size Chart
Public Function FuncSizeChart_GetPS(ByVal chartID, ByVal brandSEO, ByVal catIDs, ByVal productCode, ByVal fromSite, ByVal conn)
    Dim ps : ps = Null
    On Error Resume Next
    brandSEO = brandSEO & ""
    brandSEO = Replace(brandSEO, "'", "")
    brandSEO = Replace(brandSEO, "%27", "")
    brandSEO = Replace(brandSEO, "- -", "-+-")
    If "24th---Ocean" = brandSEO Then
        brandSEO = "24th-&-Ocean"
    End If
    catIDs = catIDs & ""
    If 0 < InStrRev(catIDs, "_") Then
        catIDs = Mid(catIDs, InStrRev(catIDs, "_") + 1)
    End If
    If 0 < InStr(catIDs, "/") Then
        catIDs = Left(catIDs, InStr(catIDs, "/") - 1)
    End If
    Dim cmd, rs, sql, chart_id, chart_title, brand_seo
    Set cmd = Server.CreateObject("ADODB.Command")
    Set rs = Server.CreateObject("ADODB.Recordset")
    sql = "dbo.AQP_LOAD_SIZINGCHART_16485({$BrandSEO}, {$CatIDs}, {$ProductCode}, {$FromSite}, {$ChartID})"
    sql = Replace(sql, "{$BrandSEO}", "'" & Replace(brandSEO & "", "'", "''") & "'")
    sql = Replace(sql, "{$CatIDs}", "'" & Replace(catIDs & "", "'", "''") & "'")
    sql = Replace(sql, "{$ProductCode}", "'" & Replace(productCode & "", "", "''") & "'")
    sql = Replace(sql, "{$FromSite}", "'" & Replace(fromSite & "", "'", "''") & "'")
    sql = Replace(sql, "{$ChartID}", "'" & Replace(chartID & "", "'", "''") & "'")
    cmd.ActiveConnection = conn
    cmd.CommandTimeout = 90
    cmd.CommandType = 4 ' 1 = adCmdText | 4 = adCmdStoredProc
    cmd.CommandText = sql
    Set rs = cmd.Execute()
    If Not rs.BOF Or Not rs.EOF Then
        rs.MoveFirst()
        chart_id = rs.Fields("chartid")
        chart_title = rs.Fields("ChartTitle")
        brand_seo = rs.Fields("s_SEOBrandName")
        chart_title = GetSEOProductNameUrlRewrite(chart_title)
        ps = LCase("/size-charts/" & brand_seo & "/" & chart_title & "-sizechart_s" & chart_id & "/")
    End If
    rs.Close()
    Set rs = Nothing
    Set cmd = Nothing
    On Error GoTo 0
    FuncSizeChart_GetPS = ps
End Function

Public Function FuncSizeChart_RedirectPS(ByVal url, ByVal fromSite, ByVal conn)
    Dim ps : ps = Null
    On Error Resume Next
    Dim regex, matches, match, submatch
    Set regex = new RegExp
    regex.Pattern = "^(\/urlrewrite\.asp\?404;https?:\/\/(www\.)?[^\/]+)?(\/lifestyle)?\/sizing_chart_detail\.asp\?(?=(.*&)?manufacturer=([^\/&]*))(?=(.*&)?brand=([^\/&]*))(?=(.*&)cat=([^\/&]*))(?=(.*&)productcode=(\d+))(?=((.*&)sizechartid=(\d+))?).*$"
    regex.IgnoreCase = True
    Set matches = regex.Execute(url)
    If 0 <> matches.Count Then
        Dim chart_id : chart_id = matches(0).Submatches(13)
        Dim brand_seo : brand_seo = matches(0).Submatches(6)
        Dim cat_ids : cat_ids = matches(0).Submatches(8)
        Dim product_code : product_code = matches(0).Submatches(10)
        Dim life_style : life_style = matches(0).Submatches(2)
        ps = FuncSizeChart_GetPS(chart_id, brand_seo, cat_ids, product_code, fromSite, conn)
        If Not IsNull(ps) And Not IsNull(life_style) Then
            ps = life_style & ps
        End If
    End If
    Set regex = Nothing
    On Error GoTo 0
    FuncSizeChart_RedirectPS = ps
End Function

Public Function FuncSizeChart_Cat_GetPS(ByVal chartID, ByVal chartTitle, ByVal brandSEO, ByVal catIDs, ByVal fromSite, ByVal conn)
    Dim ps : ps = Null
    On Error Resume Next
    brandSEO = brandSEO & ""
    brandSEO = Replace(brandSEO, "'", "")
    brandSEO = Replace(brandSEO, "%27", "")
    brandSEO = Replace(brandSEO, "- -", "-+-")
    If "24th---Ocean" = brandSEO Then
        brandSEO = "24th-&-Ocean"
    End If
    Dim chart_id, chart_title, brand_seo
    chart_id = chartID : chart_title = chartTitle : brand_seo = brandSEO
    If "" = chart_id & "" Then
        Dim cmd, rs, sql
        Set cmd = Server.CreateObject("ADODB.Command")
        Set rs = Server.CreateObject("ADODB.Recordset")
        sql = "dbo.AQP_LOAD_SIZINGCHART({$BrandSEO}, {$CatIDs}, '', {$FromSite})"
        sql = Replace(sql, "{$BrandSEO}", "'" & Replace(brandSEO & "", "'", "''") & "'")
        sql = Replace(sql, "{$CatIDs}", "'" & Replace(catIDs & "", "'", "''") & "'")
        sql = Replace(sql, "{$FromSite}", "'" & Replace(fromSite & "", "'", "''") & "'")
        cmd.ActiveConnection = conn
        cmd.CommandTimeout = 90
        cmd.CommandType = 4 ' 1 = adCmdText | 4 = adCmdStoredProc
        cmd.CommandText = sql
        Set rs = cmd.Execute()
        If Not rs.BOF Or Not rs.EOF Then
            rs.MoveFirst()
            chart_id = rs.Fields("chartid")
            chart_title = rs.Fields("ChartTitle")
            brand_seo = rs.Fields("s_SEOBrandName")
        End If
        rs.Close()
        Set rs = Nothing
        Set cmd = Nothing
    End If
    If "" <> chart_id & "" Then
        Dim safe_chars : safe_chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-"
        Dim i_loop : For i_loop = 1 To Len(chart_title)
            If 0 = InStr(safe_chars, Mid(chart_title, i_loop, 1)) Then
                chart_title = Replace(chart_title, Mid(chart_title, i_loop, 1), "-")
            End If
        Next
        While 0 <> InStr(chart_title, "--")
            chart_title = Replace(chart_title, "--", "-")
        Wend
        While "-" = Left(chart_title, 1)
            chart_title = Mid(chart_title, 2, Len(chart_title) - 1)
        Wend
        While "-" = Right(chart_title, 1)
            chart_title = Mid(chart_title, 1, Len(chart_title) - 1)
        Wend
        ps = LCase("/size-charts/" & brand_seo & "/" & chart_title & "-sizechart_s" & chart_id & "/")
    End If
    On Error GoTo 0
    FuncSizeChart_Cat_GetPS = ps
End Function

Public Function FuncSizeChart_Cat_RedirectPS(ByVal url, ByVal fromSite, ByVal conn)
    Dim ps : ps = Null
    On Error Resume Next
    Dim brand_seo, cat_id
    Dim regex, matches, match, submatch
    Set regex = new RegExp
    If "" = brand_seo & "" And "" = cat_id & "" Then
        regex.Pattern = "^\/urlrewrite.asp\?404;https?:\/\/[^\/]+\/size-charts\/([^\/]+)\/[^\/]*_s_(\d+).*$"
        regex.IgnoreCase = True
        Set matches = regex.Execute(url)
        If 0 <> matches.Count Then
            brand_seo = matches(0).Submatches(0)
            cat_id = matches(0).Submatches(1)
        End If
    End If
    If "" = brand_seo & "" And "" = cat_id & "" Then
        regex.Pattern = "^(\/urlrewrite.asp\?404;https?:\/\/[^\/]+)?(\/sizing)?\/sizing_chart_detail\.asp\?(?=(.*&)?manufacturer=([^\/&]*))(?=(.*&)?brand=([^\/&]*))(?=(.*&)cat=(\d+)).*$"
        regex.IgnoreCase = True
        Set matches = regex.Execute(url)
        If 0 <> matches.Count Then
            brand_seo = matches(0).Submatches(5)
            cat_id = matches(0).Submatches(7)
        End If
    End If
    Set regex = Nothing
    ps = FuncSizeChart_Cat_GetPS(Null, Null, brand_seo, cat_id, fromSite, conn)
    On Error GoTo 0
    FuncSizeChart_Cat_RedirectPS = ps
End Function

Dim SizeChart_RedirectPS : SizeChart_RedirectPS = FuncSizeChart_RedirectPS(Request.ServerVariables("HTTP_URL"), "redesign", Config_ConnectionString)
If "" <> SizeChart_RedirectPS & "" Then
    Response.Status = "301 Moved Permanently"
    Response.AddHeader "Location", SizeChart_RedirectPS
    Response.End
End If

Dim SizeChart_Cat_RedirectPS : SizeChart_Cat_RedirectPS = FuncSizeChart_Cat_RedirectPS(Request.ServerVariables("HTTP_URL"), "redesign", Config_ConnectionString)
If "" <> SizeChart_Cat_RedirectPS & "" Then
    Response.Status = "301 Moved Permanently"
    Response.AddHeader "Location", SizeChart_Cat_RedirectPS
    Response.End
End If
' End: Size Chart
' Sta: Lifestyle
Public Function FuncLifestyle_GetPS(ByVal url)
	Dim segps : segps = Null
	
	On Error Resume Next
	Dim regEx, matches
	Set regEx = new RegExp
	regEx.Pattern = "^\/urlrewrite\.asp\?404;https?:\/\/(www\.)?[^\/]+\/lifestyle(\/.*)?$"
	regEx.IgnoreCase = True
	regEx.Global = True
	Set matches = regEx.Execute(url)
	If 0 <> matches.Count Then
		segps = matches(0).Submatches(1)
	End If
    Set regEx = Nothing
	On Error GoTo 0
	
	FuncLifestyle_GetPS = segps
End Function

Dim Lifestyle_PS : Lifestyle_PS = FuncLifestyle_GetPS(Request.ServerVariables("HTTP_URL"))
    
If Not IsNull(Lifestyle_PS) Then  
	If (InStr(Request.ServerVariables("HTTP_URL"),"lifestyle/q/") <= 0 AND InStr(Request.ServerVariables("HTTP_URL"),"lifestyle/qa/") <= 0 AND InStr(Request.ServerVariables("HTTP_URL"),"lifestyle/p/") <= 0 and isCategoryPage(Request.ServerVariables("HTTP_URL")) = false ) _
		OR InStr(Request.ServerVariables("HTTP_URL"),"/availability") > 0 OR InStr(Request.ServerVariables("HTTP_URL"),"/bulkordering") > 0 Then
		Session("Lifestyle_PS") = Lifestyle_PS
		Server.Transfer(Current_Path & "/lifestyle/transfer.asp")
	End If	
End If
' End: Lifestyle
If Request.Cookies("hung") = "test" then
	'Response.Write("HERE")
	'Response.End()
end if
If Request.Cookies("tamtest123") = "Y" then
	Response.Write("HERE")
	Response.End()
end if

'SO-33139
if Request.Cookies("IsRedirectFull") = "true" then
	Response.Cookies("IsViewFull") = "true"
	Response.Cookies("IsViewFull").Expires = dateadd("n",+1,now())
end if

If Request.Cookies("IsViewFull") <> "true" and isDetectProductdetailPage() =  true and isReviewsPage() = false and isQuestionPage() = false and isQuestionAnswerPage() = false Then	
	If Request.Cookies("tptest") = "reviews" Then		
		'Response.Write("<br>URL:" & isReviewsPage())		
	End If
    Call DetectMobileBrowser()
End If
If isQuestionPage() = true Then
	'Response.Write("HERE:" & lcase(Replace(Request.ServerVariables("QUERY_STRING"),"404;","")))
	'Response.end
End If
If Request.Cookies("tptest") = "reviews" Then
	'Response.Write("URL:" & lcase(Replace(Request.ServerVariables("QUERY_STRING"),"404;","")))
	'Response.Write("<br>URL:" & isReviewsPage())
	'Response.Write("<br>ALL_RAW:" & request.ServerVariables("ALL_RAW"))
	'Response.end
End If

Public Function GetSEOProductNameUrlRewrite(ByVal ProductName)
	    Dim SEO_product_name, SafeStuff, iSELCount

    SafeStuff = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -"
    
	SEO_product_name = ""
    ProductName = LCASE(ProductName)

	For iSELCount = 1 to Len(ProductName)
		If InStr(SafeStuff,Mid(ProductName,iSELCount,1)) > 0 Then
			SEO_product_name = SEO_product_name & Mid(ProductName,iSELCount,1)
		End If
	Next
    SEO_product_name = Replace(SEO_product_name, " ", "-")

    While InStr(SEO_product_name, "--") > 0
        SEO_product_name = Replace(SEO_product_name, "--", "-")
    Wend
    If Right(SEO_product_name, 1) = "-" Then
        SEO_product_name = Mid(SEO_product_name, 1, Len(SEO_product_name) - 1)
    End If
    If Left(SEO_product_name, 1) = "-" Then
		SEO_product_name = Mid(SEO_product_name, 2, Len(SEO_product_name) - 1)
	End If

	GetSEOProductNameUrlRewrite = replace(SEO_product_name, "gcp-/","")
End Function

sub PROCESS_SEOLINK_PRODUCTDETAIL(byval productcode,byval productdetailseo,byval colorid)
    
    
	Dim RS_SEOLink, m_conn_seo,productname,productnameSEO,productdetailseoredirect
	Set m_conn_seo = Server.CreateObject("ADODB.Connection")
	set RS_SEOLink = Server.CreateObject("ADODB.Recordset")
	m_conn_seo.Open Config_ConnectionString		
    RS_SEOLink.Open "select dbo.RemoveSpecialChars_For_Sql(productname) as productname from products with(nolock) where productcode =  '"&productcode&"' ", m_conn_seo, 0, 1 
	if not RS_SEOLink.EOF then
		productname = RS_SEOLink("productname")
		productnameSEO = lcase(GetSEOProductNameUrlRewrite(productname))    
       
		if productnameSEO & "-" & productcode <> lcase(productdetailseo) then
			productdetailseoredirect = "/p/" & productnameSEO & "-" & productcode  & "/"
			if colorid & "" <> "" then
				productdetailseoredirect = productdetailseoredirect & "/" &colorid
			end if

			RS_SEOLink.close()
			set RS_SEOLink = nothing
			m_conn_seo.Close()
			Set m_conn_seo = Nothing
            if InStr(Requested_Page,"/lifestyle/") > 0 then
                productdetailseoredirect = "/lifestyle" & productdetailseoredirect
            end if
    
			 Response.Status="301 Moved Permanently"
			 Response.AddHeader "Location",  productdetailseoredirect
			 Response.End
		end if
	end if
	RS_SEOLink.close()
	set RS_SEOLink = nothing

	m_conn_seo.Close()
	Set m_conn_seo = Nothing

end sub

sub PROCESS_SEOLink_CATEGORY(byval categoryid, byval Requested_File,byval RequestedUrl) 
    
    On Error Resume Next
	if 1=1 then
		Dim RS_SEOLink, SEOLink_Page, SEOLink_ID, SEOLink_Name, TEMP_Querystring, SafeStuff, NEW_SEOLink_Name, iSELCount
		dim RS_CategorySEO_URL,s_seocategorylink,m_conn_seo
		Set m_conn_seo = Server.CreateObject("ADODB.Connection")
		set RS_CategorySEO_URL = Server.CreateObject("ADODB.Recordset")
		m_conn_seo.Open Config_ConnectionString	
		
		dim m_seo_sql
		m_seo_sql = "select top 1 seocategoryname,sUrlName as  s_defaultmetaname,CategoryName,ISNULL(s_LifeStyle,'N')s_LifeStyle  from categories with(nolock) where s_soredesign ='Y' and categoryid=" & categoryid
        'm_seo_sql = "select top 1 seocategoryname,s_defaultmetaname as  s_defaultmetaname,CategoryName  from categories with(nolock) where categoryid=" & categoryid
		
		RS_CategorySEO_URL.Open m_seo_sql, m_conn_seo, 0, 1
		s_seocategorylink = ""
		dim s_defaultmetaname,CategoryName, isLifeStyle
		if not RS_CategorySEO_URL.EOF then    
			s_defaultmetaname = RS_CategorySEO_URL("s_defaultmetaname") & ""
			CategoryName = RS_CategorySEO_URL("CategoryName") & ""
            isLifeStyle = RS_CategorySEO_URL("s_LifeStyle") & ""
		    If s_defaultmetaname & "" <> "" Then
			    s_seocategorylink = LCASE(s_defaultmetaname)
		    Else
			    s_seocategorylink = LCASE(CategoryName)
		    End If
		end if
		RS_CategorySEO_URL.close()
		set RS_CategorySEO_URL = nothing
		m_conn_seo.Close()
		Set m_conn_seo = Nothing
		
		if s_seocategorylink  <> "" then
			
			SEOLink_Name = s_seocategorylink

            SEOLink_Name = GetSEOProductNameUrlRewrite(SEOLink_Name)

			s_seocategorylink = SEOLink_Name

			if right(RequestedUrl,1) = "/" then
				RequestedUrl = left(trim(RequestedUrl),len(trim(RequestedUrl))-1)
			end if
            if InStr(RequestedUrl, "/lifestyle/") > 0 AND isLifeStyle & "" = "N" THEN
                RequestedUrl = Replace(RequestedUrl, "/lifestyle", "")
            End if
			if lcase(trim(Requested_File)) <> lcase(s_seocategorylink&"-c" & categoryid ) then
				'Response.Write("s_seocategorylink " & s_seocategorylink )
				'Response.End
				 Response.Status="301 Moved Permanently"
				 'Response.AddHeader "Location","/"&  s_seocategorylink&"-c" & categoryid & "/"
				 Response.AddHeader "Location",   replace(replace(replace(RequestedUrl,Requested_File,s_seocategorylink&"-c" & categoryid),"www.swimoutlet.com:80",""),"www.swimoutlet.com:443","")  & "/"
				 
				 Response.End
			end if                       						
		end if
	end if
    On Error GoTo 0	
End sub
'Call DetectMobileBrowser()

Function DetectMobileBrowser()
    dim b_ismobile
    b_ismobile=isMobile()  	
	dim url
	url=getCurrentUrl()      
    if b_ismobile and Instr(url,"signin.asp") <=0 then  ' Dont redirect signin on check out desktop SWIMOUTLET-35274
        
        if Instr(url,"www") > 0 Then
            url=Replace(url,"www.swimoutlet.com","m.swimoutlet.com")       
        else
            url=Replace(url,"swimoutlet.com","m.swimoutlet.com")       
        End if
        if Instr(url,"Default.asp") > 0 Then
            url=Replace(url,"Default.asp","")       
        end if
		
       Response.Redirect(url)      
    end if 
End Function

Function getCurrentUrl()
    dim url 
	'Response.Write("r:" & request.ServerVariables("ALL_RAW"))   
    if Instr(request.ServerVariables("ALL_RAW"),"current_url=") > 0 then
        url = request.ServerVariables("ALL_RAW")        
        url=Mid(url,Instr(url,"current_url="),len(url))
        if Instr(request.ServerVariables("ALL_RAW"),";") > 0 then
            url=Left(url,Instr(url,";"))
        end if
        url=Replace(url,"current_url=","")
        url=Replace(url,";","")
        'Response.Write("tutu :" & url )  
		
                              
    else
        if request.ServerVariables("QUERY_STRING") <> "" and request.ServerVariables("QUERY_FORM") <> "" then
            url="http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") & "?" & Request.Querystring & Request.Form
        else
           if request.ServerVariables("QUERY_STRING") <> "" then
                url="http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") & "?" & Request.Querystring
           else
             if request.ServerVariables("QUERY_FORM") <> "" then
                url="http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") & "?" & Request.Form
             else
                url="http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL")
             end if
           end if    
        end if
    end if   
	if Instr(url,"404") > 0 then
         	url= Mid(url,Instr(url,"404"),len(url))
         	url=Replace(url,"404","")
         	url=Replace(url,";","")
         	url = Replace(url,":80","")      
   	end if    
    getCurrentUrl=url
End Function

Function isMobile()
    dim u,b,v
    set u=Request.ServerVariables("HTTP_USER_AGENT")
    set b=new RegExp
    set v=new RegExp
    b.Pattern="android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino"
    v.Pattern="1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-"
    b.IgnoreCase=true
    v.IgnoreCase=true

    b.Global=true
    v.Global=true
'if b.test(u) or v.test(Left(u,4)) then
if (b.test(u) or v.test(Left(u,4))) and Instr(lcase(u),"ipad") <= 0 then
    isMobile=True
else
    isMobile=False
end if

End function
'-----------------------------------------------------------------------------




'-----------------------Function Send email when having error--------------------------------
%>
<!-- #include file="../incfiles/functions_SESSendmail.asp" -->
<!-- #include file="../incfiles/functions_sitereroute.asp" -->
<%

Sub SendEmailWhenError(byval IP, byval URL, byval ErrorMessage)
	If IP = "115.78.239.237" or IP = "113.161.67.199" or IP = "14.161.12.138" or IP = "103.3.249.210" or IP = "103.3.249.206" or IP = "14.161.21.32" then
		if InStr(Request.ServerVariables("HTTP_USER_AGENT")&"","sqlmap") > 0 Then
			Exit Sub
		End if		
		'If IP = "103.3.249.210" or IP = "115.78.239.237" Then
			Exit Sub
		'End If
	end if
    'If Instr(Lcase(URL),"placeorder") > 0 and Instr(Lcase(ErrorMessage),"out of memory") <= 0 and Instr(Lcase(URL),"returncustomer") <= 0 Then
	If true then
	'IF Instr(Lcase(ErrorMessage),"out of memory") <= 0 and Instr(Lcase(URL),"mailingList_subscribe.asp") <=0 and IP <> "94.23.71.80" Then
        Dim s_From, s_Sender, s_To, s_Subject, s_Content, i_HTML
        s_From = "shop@swimoutlet.com"
        s_Sender = "SwimOutlet.com"
        s_To = "an.tran@spiraledge.com;tam.phan@spiraledge.com;hai.vo@spiraledge.com;phuong.tran@spiraledge.com;kiem.nguyen@spiraledge.com"
		s_To = s_To & ";y.nguyen@spiraledge.com;firebug-team@spiraledge.com"
		if Session("www.swi/Email") & "" <> "automation-test@spiraledge.com" Then
			s_To = "phuoc.tran@spiraledge.com;" & s_To
		End if		
        s_Subject = "[REDESIGN - " & Request.ServerVariables("LOCAL_ADDR") & "] An error is happening on SwimOutlet.com"
		if Instr(LCase(ErrorMessage),"query timeout expired") > 0 Then
			s_Subject = "[DB TIMEOUT] - " & s_Subject
		end if
		if Instr(LCase(ErrorMessage),"out of memory") > 0 Then
			s_Subject = "[OOM-ERR] - " & s_Subject
		End if
		If Instr(Lcase(URL),"placeorder") > 0 Then
			s_Subject = "[PLACEORDER-ERR] - " & s_Subject
		End if
        s_Content = "Dear,<br /><br />"
        s_Content = s_Content & "User just got an error on SwimOutlet.com. See details below:<br /><br />"
        s_Content = s_Content & "IP: " & IP & "<br />"
		s_Content = s_Content & "User Agent: " & Request.ServerVariables("HTTP_USER_AGENT") & "<br />"
        s_Content = s_Content & "Email: " & Session("www.swi/Email") & "<br />" 
        s_Content = s_Content & "Customer number: " & Request.Cookies("www.swi/CustomerID") & "<br />"
        s_Content = s_Content & "Order number: " & Session("OrderID") & "<br />"
        s_Content = s_Content & "Date/time: " & now() & "<br />"
        s_Content = s_Content & "Url of error: " & URL & "<br />"
		s_Content = s_Content & "Referrer Url: " & Request.ServerVariables ("HTTP_REFERER") & "<br />"	
        s_Content = s_Content & "Error message: " & ErrorMessage & "<br /><br />"
        s_Content = s_Content & "SwimOutlet.com"
        i_HTML = true
        Call SESSendmail(s_From, s_Sender ,s_To, s_Subject, s_Content, i_HTML)
    End If
End Sub
'--------------------------------------------------------------------------------------------
'On Error Resume Next

Public Function CacheFileExists(fileName)
	CacheFileExists = false
	
	Dim fso
	SET fso = Server.CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(fileName) Then
		CacheFileExists = true
	End If
	SET fso= Nothing
End Function

Public Sub LogPageView(pageName, pageData, pageUrl)	
	Set m_conn = Server.CreateObject("ADODB.Connection")
	m_conn.Open Config_ConnectionString	

	m_sql = "INSERT INTO AQT_PAGE_VIEW_LOG (strPageName, strPageData, strURL, strMachine) VALUES "
	m_sql = m_sql & "("
	m_sql = m_sql & " '" & Replace(pageName, "'", "''") & "'"
	m_sql = m_sql & ",'" & Replace(pageData, "'", "''") & "'"
	m_sql = m_sql & ",'" & Replace(pageUrl, "'", "''") & "'"
	m_sql = m_sql & ",'" & Replace(Request.ServerVariables("REMOTE_HOST"), "'", "''") & "'"
	m_sql = m_sql & ")"
	
	m_conn.Execute(m_sql)
	m_conn.Close()
	Set m_conn = Nothing
End Sub

Public Function AppUtils_IsWhiteListedIP()
	AppUtils_IsWhiteListedIP = True	
	If Request.Cookies("AppUtils_IsWhiteListedIP") = "" Then
		Dim iIPAddress
		iIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		If iIPAddress = "" Then
		  iIPAddress = Request.ServerVariables("REMOTE_ADDR")
		Else
			If InStr(iIPAddress,",") > 0 Then
				iIPAddress = Split(iIPAddress,",")(0)
			End If
		End If
	
		Dim fv_sql 'As String
		Dim fv_conn 'As ADODB.Connection
		Dim fv_rs 'As ADODB.Recordset
	
		Set fv_conn = Server.CreateObject("ADODB.Connection")	
		Set fv_rs = Server.CreateObject("ADODB.Recordset")	
		
		fv_sql = "SELECT COUNT(*) AS intAllow FROM AQT_WHITELISTED_IPADDRESS with(nolock) WHERE strMode = 'GRANTED' AND strIP = '" & iIPAddress & "'"
		fv_conn.Open Config_ConnectionString
		fv_rs.Open fv_sql, fv_conn, 0, 1
		
		If CInt(fv_rs("intAllow")) = 0 Then
			AppUtils_IsWhiteListedIP = False
		Else
			'Response.Cookies("AppUtils_IsWhiteListedIP") = fv_rs("intAllow")
			'Replace(pageUrl, "'", "''")
			 Response.Cookies("AppUtils_IsWhiteListedIP") = Replace(fv_rs("intAllow"),"'", "''") 'Phuoc updated here
		End If
		
		fv_rs.Close()
		Set fv_rs = Nothing
		
		fv_conn.Close()
		Set fv_conn = Nothing
	End If
End Function


'Ruud added to change url rewrite 301
Function ChangeUrlRewrite301(strFullURL)
	strFullURL = Replace(strFullUrl, "gcp-www", "www")
	'strFullURL = Replace(strFullUrl, "gcp-m", "m")
	strFullURL=replace(strFullURL,":80/","/")
    strFullURL=replace(strFullURL,"https:","http:")
	strFullURL=replace(strFullURL,":443","")
   	
    '------Fixed SQL injection
    strFullURL = Replace(UCase(strFullURL), "%28", "(")
    strFullURL = Replace(UCase(strFullURL), "%29", ")")
    strFullURL = Replace(UCase(strFullURL), "'", "")
	strFullURL = Replace(UCase(strFullURL), """", "")
	strFullURL = Replace(UCase(strFullURL), ")", "")
	strFullURL = Replace(UCase(strFullURL), "(", "")
	strFullURL = Replace(UCase(strFullURL), ";", "")		
	strFullURL = Replace(UCase(strFullURL), "|", "")
	
	dim parameter
    parameter = ""
    if instr(strFullURL,"?")>0 then
        parameter = right(strFullURL,len(strFullURL)-instr(strFullURL,"?") + 1)
        strFullURL = Replace(strFullURL,parameter,"")
    end if
	If Right(strFullURL,1) = "/" AND Len(strFullURL) > 1 Then
		strFullURL = Left(strFullURL, Len(strFullURL) - 1)
	End if
	dim strFullURL_Original
	strFullURL_Original = strFullURL
	
    'if instr(lcase( strFullURL),"/guides/") > 0 then
        ''strFullURL = Replace(UCase(strFullURL), "new.swimoutlet.com", "www.swimoutlet.com")
        strFullURL = Replace(UCase(strFullURL), Ucase("new.swimoutlet.com"), Ucase("www.swimoutlet.com"))
    'end if
    '----End
    if instr(lcase( strFullURL),"/guide/") > 0 then
            Response.Clear()
            Response.Status="301 Moved Permanently"
            strFullURL = replace(strFullURL,"/GUIDE/","/GUIDES/")
            Response.AddHeader "Location", lcase(strFullURL)
            Response.End    
    end if
	'Response.Write(strFullURL)
	'Response.end
	
    dim m_rs,m_command,sql
    Set m_conn = Server.CreateObject("ADODB.Connection")	
    Set m_command = Server.CreateObject("ADODB.Command")    
    m_command.CommandTimeout = 0
    m_conn.ConnectionTimeout = 0
    	
    m_conn.Open Config_ConnectionString
    m_command.ActiveConnection = m_conn 
	
	
	'sql = "select s_Type,s_RedirectType,s_SessionID,s_SessionValue,s_ToLink,s_FromLink from AQT_301_REDIRECT with(nolock) where (replace(replace(s_FromLink,'(',''),')','') = '"&Replace(LCase(strFullURL_Original),"www.swimoutlet.com","new.swimoutlet.com") &"' or RTRIM(replace(replace(s_FromLink,'(',''),')','')) + '/' = '"& Replace(LCase(strFullURL_Original),"www.swimoutlet.com","new.swimoutlet.com") &"') and s_Status <> 'DELETED' and isnull(s_fromsite,'SWIMOUTLET') = 'SOREDESIGN' "
    ' Remove replace function on s-fromlink 
    sql = "select s_Type,s_RedirectType,s_SessionID,s_SessionValue,s_ToLink,s_FromLink from AQT_301_REDIRECT with(nolock) where s_FromLink='"& Replace(LCase(strFullURL_Original),"www.swimoutlet.com","new.swimoutlet.com")  &"'  and s_Status <> 'DELETED' and isnull(s_fromsite,'SWIMOUTLET') = 'SOREDESIGN' "
	m_command.CommandText = sql
    set m_rs = m_command.Execute()
	'If Request.ServerVariables("HTTP_True-Client-IP") = "115.78.239.237" then
'			Response.Write("PX: " & sql) 							
'			Response.End()
'	End IF
	'Response.Write(sql)
	'Response.End()
	If m_rs.EOF then
		
        'sql = "select s_Type,s_RedirectType,s_SessionID,s_SessionValue,s_ToLink,s_FromLink from AQT_301_REDIRECT with(nolock) where (replace(replace(s_FromLink,'(',''),')','') = '"&strFullURL&"' or RTRIM(replace(replace(s_FromLink,'(',''),')','')) + '/' = '"&strFullURL&"') and s_Status <> 'DELETED'  "
        sql = "select s_Type,s_RedirectType,s_SessionID,s_SessionValue,s_ToLink,s_FromLink , 1 as QueryNum from AQT_301_REDIRECT with(nolock) where s_FromLink='"  & strFullURL & "' and s_Status <> 'DELETED'  "
		if instr(lcase( strFullURL),"/guides") <= 0 then
			sql = sql &  "    and isnull(s_fromsite,'SWIMOUTLET') = 'SWIMOUTLET' "  
			
			'This for redirect all sub URL of brand ( which was set redirect to another brands ) SWIMOUTLET-32020
		   sql = sql & "union all select s_Type,s_RedirectType,s_SessionID,s_SessionValue,s_ToLink,s_FromLink, 2 as QueryNum from AQT_301_REDIRECT with(nolock) where '"&strFullURL&"' like s_FromLink +'/%' and s_type = 'Brand' and s_Status <> 'DELETED' and isnull(s_fromsite,'SWIMOUTLET') = 'SWIMOUTLET'  "
		   sql = sql &  "order by QueryNum asc "
		end if
'If Request.ServerVariables("HTTP_True-Client-IP") = "113.161.67.199" then'
	'Response.Write(sql)
			'Response.End()
'	End IF
		Set m_command = Server.CreateObject("ADODB.Command") 
		m_command.CommandTimeout = 0
		m_command.ActiveConnection = m_conn 
		m_command.CommandText = sql
    	set m_rs = m_command.Execute()
	end if
	                         	
	If not m_rs.EOF then
        
	    if Lcase(trim(m_rs("s_RedirectType")))="transfer" and trim(m_rs("s_SessionID")) <> "" then
	        Session(m_rs("s_SessionID")) = m_rs("s_SessionValue")   
			
	        'Tam Update for suburl	        	    
	        if Lcase(trim(m_rs("s_Type")))   = "affiliatesuburl" then				
				'Server.Transfer (Current_Path & Trim(m_rs("s_ToLink")))
                'Response.Cookies("AffiliateID") = m_rs("s_SessionValue")  
				Server.Transfer (Current_Path & "Default.asp")
            end if
			If trim(m_rs("s_Type"))="Category" then	            
	            dim mr_click,arr_click,strSubURL
	            arr_click=split(strFullURL,"/")	        	            
	            
	            if ubound(arr_click) > 0 and trim(arr_click(ubound(arr_click)))="" then
	                strSubURL=arr_click(ubound(arr_click)-1)
	            else
	                strSubURL=arr_click(ubound(arr_click))
	            end if            	                        
                
	            sql = "select top 1 customerid from customers with (nolock) where strSubURL='"&strSubURL&"'"	            
                m_command.CommandText = sql
                set mr_click = m_command.Execute()
	            
	            If Not mr_click.EOF then	            
                   
	                response.Cookies("AffiliateID")=mr_click("customerid")	    	                           
	            End If      
	        End If
	        
	        If Instr(lcase(m_rs("s_ToLink")),"runoutlet.com") >0 then
                Server.Transfer(mid(m_rs("s_ToLink"),Instr(lcase(m_rs("s_ToLink")),"runoutlet.com") + 14,len(m_rs("s_ToLink"))))
	        Else
                'Response.Write(Current_Path & Trim(m_rs("s_ToLink")))
				'Response.End()
                if lcase(m_rs("s_FromLink")) = "http://new.swimoutlet.com/guides" then
                    Server.Transfer(Current_Path & "guide.asp")
                else		
                     Server.Transfer(Current_Path & Trim(m_rs("s_ToLink")))
                end if
                
	            
	        End If    	
	    elseif Lcase(trim(m_rs("s_RedirectType")))="301" then
	        'Response.Status="301 Moved Permanently"
            'Response.AddHeader "Location",trim(Replace(m_rs("s_ToLink")&lcase(parameter), "new.swimoutlet.com", "www.swimoutlet.com"))
            'Response.End
            Dim URL301
            URL301 = trim(Replace(m_rs("s_ToLink") & lcase(parameter), "new.swimoutlet.com", "www.swimoutlet.com"))
            URL301 = Replace(URL301, "http://", "https://")
            If InStr(URL301,"https://") < 1 Then
                URL301 = "https://" & URL301
            End If
	        Response.Status="301 Moved Permanently"
            Response.AddHeader "Location", URL301
            Response.End
	    elseif Lcase(trim(m_rs("s_RedirectType")))="302" then
	        Response.Redirect(trim(m_rs("s_ToLink")&lcase(parameter)))
	    end if    
	Else
		if instr(lcase( strFullURL),"/guides/") > 0 then 'SWIMOUTLET-26979
			Response.Clear()
			Response.Status="301 Moved Permanently"			
			Response.AddHeader "Location", "//www.swimoutlet.com/guides"
			Response.End    
		end if
	End If
	Set m_command = Nothing
	m_rs.Close()
	Set m_rs = Nothing	
	m_conn.Close()	
End Function
'Ruud end 

If Request.ServerVariables("HTTP_True-Client-IP") = "113.161.67.199" then
			'Response.Write("PX: " & Trim(Request.Cookies("AffiliateID"))) 							
	End IF


'========================================
' URL Rewrite
'========================================
Dim Current_Path, Requested_Page, Requested_File, urw_Split, ASPErr
	
'Grab the current info we need...
Current_Path = Replace(Request.ServerVariables("SCRIPT_NAME"),"URLrewrite.asp","",1,-1,vbTextCompare)
Requested_Page = Replace(Request.ServerVariables("QUERY_STRING"),"404;","")
Requested_Page = Replace(Requested_Page,"403;","")
If Right(Requested_Page,1) = "/" Then
    Requested_Page = left(Requested_Page,len(Requested_Page) - 1)
End If
'Requested_Page = Trim(Requested_Page)

'If Request.ServerVariables("HTTP_True-Client-IP") = "125.234.0.10" then
'	Response.Write("P: " & Current_Path) 				
'End IF

If LCase(Right(Requested_Page, 20)) = "promotions_s/529.htm" Then
	Response.Redirect("http://new.swimoutlet.com")
End If
'' Tam Dang update for SEO redirest
'Response.Write(Requested_Page)
'Response.End


call ProcessSEOLegacyRedesign(Requested_Page)


'An added for keep track all URL access
On Error Resume Next
Dim m_connURL, m_sqlURL, iBrowserURL, iScriptNameURL,iIPAddressURL
Set m_connURL = Server.CreateObject("ADODB.Connection")
m_connURL.Open Config_ConnectionStringServer16Extended

iIPAddressURL = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
	If iIPAddressURL = "" Then
	  iIPAddressURL = Request.ServerVariables("REMOTE_ADDR")
	Else
		If InStr(iIPAddressURL,",") > 0 Then
			iIPAddressURL = Split(iIPAddressURL,",")(0)
		End If
	End If
	
iBrowserURL    = Request.ServerVariables("HTTP_USER_AGENT")	
iScriptNameURL = Replace( Replace(GetFullCurrentPath(),"'",""),"new.swimoutlet.com/URLRewrite.asp?404;","") 'replace(Requested_Page,":80","")	
m_sqlURL = "INSERT INTO AQT_APPLICATION_ERROR(t_Timestamp, s_Machine, s_Program, s_Url,s_Error,s_OtherInfo,t_CreatedDate,s_Status) VALUES "
m_sqlURL = m_sqlURL & "(" &"'" & now()  & "'" & "," & "'" & iIPAddressURL & "'" & "," & "'" & iBrowserURL & "'" & "," & "'" & iScriptNameURL & "'" & "," & "'Keep track URL'" & "," & "'"  & "'" & "," & "'" & now() & "'" & "," & "'" & "NEW" & "'"  & ")"	
m_connURL.Execute(m_sqlURL)
m_connURL.Close()
Set m_connURL = Nothing
On Error GoTo 0	
'End An added for keep track all URL access

'---------------------------------------------------------------------
'Check for Affiliate/Vendor Sub URL

	'Response.End()
If LCase(Right(Requested_Page, 4)) <> ".htm" Then
	Dim m_request_uri, m_uri_parts
	m_request_uri = Requested_Page	
	' Vinh.Nguyen add for sizing chart
    If(InStr(m_request_uri,"/size-charts/")>0) Then
        'Dim strbrand
        'strbrand =RIGHT(m_request_uri,InStr(StrReverse(m_request_uri), StrReverse("/"))-1)
        'Session("ThisBrandDetail") = strbrand
		'Server.Transfer(Current_Path & "sizingchartdetail.asp")
		
		Dim strbrand, ArrParts, strPart2, strCat
        ArrParts = Split(m_request_uri,"/size-charts/")
        strPart2 = ArrParts(1)
		If Instr(strPart2, "?") <> 0 Then
            strPart2 = Left(strPart2, Instr(strPart2, "?") - 1)
        End If
        If (InStr(strPart2,"/") > 0) Then
            strbrand = LEFT(strPart2,InStr(strPart2,"/")-1)
            strCat = MID(strPart2,InStr(strPart2,"/")+1)
        Else
            strbrand = strPart2
            strCat = ""
        End If
        Session("ThisBrandDetail") = strbrand
        Session("ThisCatDetail") = strCat		
		if strCat <> "" then
            Server.Transfer("/sizing_chart_detail.asp")
        else
			
		    Server.Transfer(Current_Path & "sizingchartdetail.asp")
        End If
	ElseIf(InStr(m_request_uri,"/sizing/")>0) and (InStr(m_request_uri,".asp")>0) Then '=====>>>>> SWIMOUTLET-31729
        Dim sizingbrandseo
		sizingbrandseo	= Replace(Replace(m_request_uri, "https://www.swimoutlet.com:443/sizing/",""),"-sizing.asp","")
		Response.Status = "301 Moved Permanently"
		Response.AddHeader "Location", "https://www.swimoutlet.com/size-charts/" & sizingbrandseo
		Response.End
	ElseIf UCase(Right(m_request_uri, 4)) = "/MP3" Or UCase(Right(m_request_uri, 5)) = "/MP3/" Then
		Response.Redirect("http://new.swimoutlet.com/SearchResults.asp?Click=334186&Cat=542")
	ElseIf LCase(Right(m_request_uri, 4)) = "/whf" Or LCase(Right(m_request_uri, 5)) = "/whf/" Then
		Response.Redirect("http://new.swimoutlet.com/SearchResults.asp?Cat=203&Click=358523")
	
	'ElseIf LCase(Right(m_request_uri, 11)) = "/waquadawgs" Or LCase(Right(m_request_uri, 12)) = "/aquadawgs/" Then
	'	Response.Redirect("http://new.swimoutlet.com/SearchResults.asp?Cat=1698&Click=1713770")

	ElseIf LCase(Right(m_request_uri, 10)) = "/angelfish" Or LCase(Right(m_request_uri, 11)) = "/angelfish/" Then
		Response.Redirect("http://new.swimoutlet.com/SearchResults.asp?Cat=1487&Click=1830726")
		
	'An comment out 03102012
	'ElseIf LCase(Right(m_request_uri, 8)) = "/returns" Or LCase(Right(m_request_uri, 9)) = "/returns/" Then
		'Check to see if directing to returns page
		'Response.Redirect("http://new.swimoutlet.com/returns.asp")
	'	Server.Transfer(Current_Path & "returns.asp")
	
	'ElseIf LCase(Right(m_request_uri, 10)) = "/lifeguard" Or LCase(Right(m_request_uri, 11)) = "/lifeguard/" Then
	'	Session("ThisCat") = "207"
	'	Server.Transfer(Current_Path & "SearchResults.asp")
		'Response.Redirect("http://new.swimoutlet.com/Lifeguard_s/207.htm")
	'ElseIf LCase(Right(m_request_uri, 11)) = "/water-polo" Or LCase(Right(m_request_uri, 12)) = "/water-polo/" Then
	'	Session("ThisCat") = "208"
	'	Server.Transfer(Current_Path & "SearchResults.asp")
		
	'ElseIf LCase(Right(m_request_uri, 10)) = "/surf-shop" Or LCase(Right(m_request_uri, 11)) = "/surf-shop/" Then
	'	Session("ThisCat") = "734"
	'	Server.Transfer(Current_Path & "SearchResults.asp")
	
	'ElseIf LCase(Right(m_request_uri, 13)) = "/surf-shop-ab" Or LCase(Right(m_request_uri, 14)) = "/surf-shop-ab/" Then
	'	Session("ThisCat") = ""
	'	Server.Transfer(Current_Path & "htmlcached/category_s/734-abtest.htm")	
				
	'ElseIf LCase(Right(m_request_uri, 6)) = "/beach" Or LCase(Right(m_request_uri, 7)) = "/beach/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Beach_s/719.htm")
	'ElseIf LCase(Right(m_request_uri, 8)) = "/intouch" Or LCase(Right(m_request_uri, 9)) = "/intouch/" Then
	'	Response.Redirect("http://new.swimoutlet.com?Click=671345")
	
	'ElseIf LCase(Right(m_request_uri, 6)) = "/usawp" Or LCase(Right(m_request_uri, 7)) = "/usawp/" Then
	'	Response.Redirect("http://new.swimoutlet.com/searchresults.asp?cat=208&Click=1876601")	
		
	'ElseIf LCase(Right(m_request_uri, 5)) = "/nike" Or LCase(Right(m_request_uri, 6)) = "/nike/" Then
		'Response.Redirect("http://new.swimoutlet.com/ProductBrand.asp?Brand=1095")
	
	'ElseIf LCase(Right(m_request_uri, 5)) = "/ussc" Or LCase(Right(m_request_uri, 6)) = "/ussc/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Nike_Swim_Camp_s/1358.htm")
	
	ElseIf LCase(Right(m_request_uri, 17)) = "/survey/teamsales" Or LCase(Right(m_request_uri, 18)) = "/survey/teamsales/" Then
		Response.Redirect("http://clubswim.wufoo.com/forms/team-sales-customer-satisfaction-survey/")
		
	ElseIf LCase(Right(m_request_uri, 16)) = "/shipping-survey" Or LCase(Right(m_request_uri, 17)) = "/shipping-survey/" Then
		Response.Redirect("https://clubswim.wufoo.com/forms/swimoutletcom-survey/")
	'Affiliate
	'ElseIf LCase(Right(m_request_uri, 7)) = "/medina" Or LCase(Right(m_request_uri, 8)) = "/medina/" Then
	'	Response.Redirect("http://new.swimoutlet.com/SearchResults.asp?Cat=1443&Click=1263414")
	
	'ElseIf LCase(Right(m_request_uri, 10)) = "/mwmarlins" Or LCase(Right(m_request_uri, 11)) = "/mwmarlins/" Then
	'	Response.Redirect("http://new.swimoutlet.com/SearchResults.asp?Cat=1455&Click=990597")
	
	'ElseIf LCase(Right(m_request_uri, 11)) = "/splashball" Or LCase(Right(m_request_uri, 12)) = "/splashball/" Then
	'	Response.Redirect("http://new.swimoutlet.com/USA_Water_Polo_Splashball_Products_s/1536.htm")
		
	'Affiliate	
	'ElseIf LCase(Right(m_request_uri, 3)) = "/rs" Or LCase(Right(m_request_uri, 4)) = "/rs/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Running_s/1389.htm?Click=1509946")		
		
	'ElseIf LCase(Right(m_request_uri, 7)) = "/brands" Or LCase(Right(m_request_uri, 8)) = "/brands/" Then
		'Response.Redirect("http://new.swimoutlet.com/Articles.asp?ID=111")
		'Server.Transfer(Current_Path & "htmlcached/help.htm")
	'	Server.Transfer(Current_Path & "ProductBrands.asp")			
	'ElseIf LCase(Right(m_request_uri, 10)) = "/mantarays" Or LCase(Right(m_request_uri, 11)) = "/mantarays/" Then
	'	Response.Redirect("http://new.swimoutlet.com/SearchResults.asp?Cat=1608&click=1954721")
				
	ElseIf LCase(Right(m_request_uri, 17)) = "/donation-request" Or LCase(Right(m_request_uri, 18)) = "/donation-request/" Then
		'Response.Redirect("http://new.swimoutlet.com/help_answer.asp?id=143")
		Server.Transfer(Current_Path & "htmlcached/donationrequest.htm")
		'Session("ArticleID") = 143
		'Server.Transfer(Current_Path & "Articles.asp")	
		
	'An comment to make it work as Article			
	'ElseIf LCase(Right(m_request_uri, 11)) = "/contact-us" Or LCase(Right(m_request_uri, 12)) = "/contact-us/" Then
		'Response.Redirect("http://new.swimoutlet.com/help_answer.asp?id=143")
				
		'If Application("Application_Phone_System_Down") = "OFF" then		
		'	Server.Transfer(Current_Path & "htmlcached/contactus_withphoneissue.htm")
		'else
		'	Server.Transfer(Current_Path & "htmlcached/contactus.htm")
		'end if 
		'End An comment to make it work as Article
		
		'Server.Transfer("http://new.swimoutlet.com/Articles.asp?ID=111")
	'ElseIf LCase(Right(m_request_uri, 10)) = "/waterpolo" Or LCase(Right(m_request_uri, 11)) = "/waterpolo/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Water_Polo_s/208.htm")
		'Server.Transfer(Current_Path & "Articles.asp?ID=111")

	'ElseIf LCase(Right(m_request_uri, 17)) = "/swimming-watches" Or LCase(Right(m_request_uri, 18)) = "/swimming-watches/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Searchresults.asp?Cat=378")
		'Server.Transfer(Current_Path & "Articles.asp?ID=111")

	'ElseIf LCase(Right(m_request_uri, 10)) = "/triathlon" Or LCase(Right(m_request_uri, 11)) = "/triathlon/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Searchresults.asp?Cat=266")
		'Server.Transfer("http://new.swimoutlet.com/Searchresults.asp?Cat=226")

	'ElseIf LCase(Right(m_request_uri, 12)) = "/swim-parkas" Or LCase(Right(m_request_uri, 13)) = "/swim-parkas/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Searchresults.asp?Cat=226")
		'Server.Transfer("http://new.swimoutlet.com/Searchresults.asp?Cat=226")

	'ElseIf LCase(Right(m_request_uri, 12)) = "/water-shoes" Or LCase(Right(m_request_uri, 13)) = "/water-shoes/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Searchresults.asp?Cat=356")
		'Server.Transfer("http://new.swimoutlet.com/Searchresults.asp?Cat=226")

	'ElseIf LCase(Right(m_request_uri, 10)) = "/swim-caps" Or LCase(Right(m_request_uri, 11)) = "/swim-caps/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Searchresults.asp?Cat=288")
		'Server.Transfer("http://new.swimoutlet.com/Searchresults.asp?Cat=226")

	'ElseIf LCase(Right(m_request_uri, 12)) = "/rash-guards" Or LCase(Right(m_request_uri, 13)) = "/rash-guards/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Searchresults.asp?Cat=393")
		
	'ElseIf LCase(Right(m_request_uri, 15)) = "/water-aerobics" Or LCase(Right(m_request_uri, 16)) = "/water-aerobics/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Searchresults.asp?Cat=209")
		
	'ElseIf LCase(Right(m_request_uri, 15)) = "/sahara-dry-ear" Or LCase(Right(m_request_uri, 16)) = "/sahara-dry-ear/" Then
	'	Response.Redirect("http://new.swimoutlet.com/Ear_Nose_Plugs_s/333.htm")
	
	'ElseIf LCase(Right(m_request_uri, 18)) = "/affiliate-program" Or LCase(Right(m_request_uri, 19)) = "/affiliate-program/" Then
		'Response.Redirect("http://new.swimoutlet.com/affiliate_info.asp")
	'	Server.Transfer(Current_Path & "affiliate_info.asp")
	
	ElseIf LCase(Right(m_request_uri, 18)) = "/goldmedaldelivery" Or LCase(Right(m_request_uri, 19)) = "/goldmedaldelivery/" Or InStr(LCase(m_request_uri), "goldmedaldelivery?sms_ss") > 0   Then
	'InStr(LCase(m_request_uri), "sms_ss") > 0
		'Response.Redirect("http://new.swimoutlet.com/affiliate_info.asp")
		'Server.Transfer(Current_Path & "affiliate_info.asp")
		Server.Transfer(Current_Path & "goldmedaldelivery.asp")
	
	ElseIf LCase(Right(m_request_uri, 26)) = "/nutrition-for-performance" Or LCase(Right(m_request_uri, 27)) = "/nutrition-for-performance/" Or InStr(LCase(m_request_uri), "nutrition-for-performance?sms_ss") > 0   Then
	'InStr(LCase(m_request_uri), "sms_ss") > 0
		'Response.Redirect("http://new.swimoutlet.com/affiliate_info.asp")
		'Server.Transfer(Current_Path & "affiliate_info.asp")
		Server.Transfer(Current_Path & "nutrition-for-performance.asp")
			
	'ElseIf LCase(Right(m_request_uri, 9)) = "/rip-curl" Or LCase(Right(m_request_uri, 10)) = "/rip-curl/" Then
		'Response.Redirect("http://new.swimoutlet.com/Articles.asp?ID=111")
		'Server.Transfer(Current_Path & "htmlcached/category_s/1288_brand.htm")	
	'	Response.Redirect(Current_Path & "ProductBrand.asp?Brand=1585")	
 
	ElseIf LCase(Right(m_request_uri, 19)) = "/i-heart-swimoutlet" Or LCase(Right(m_request_uri, 20)) = "/i-heart-swimoutlet/" Then
		'Response.Redirect("http://new.swimoutlet.com/Articles.asp?ID=111")
		Server.Transfer(Current_Path & "BragPage.asp")		
	'Ruud added to change old to new url
	ElseIf InStr(Lcase(m_request_uri),"/ab/juniors-swimwear-swimsuits-c9393") > 0 Then
		Session("ThisCat") = "9393"
		Server.Transfer(Current_Path & "searchresultsnew.asp")	
	ElseIf INSTR(LCase(m_request_uri),"/style-showcase") > 0 Or INSTR(LCase(m_request_uri),"/style-showcase/") > 0 Or INSTR(LCase(m_request_uri),"/what-the-pros-wear") > 0 Then
		m_request_uri = "http://new.swimoutlet.com/style-showcase"
		Call ChangeUrlRewrite301(m_request_uri)
	ElseIf INSTR(LCase(m_request_uri),"/helpcenter") > 0 Or INSTR(LCase(m_request_uri),"/helpcenter/") > 0  Then
		m_request_uri = "http://new.swimoutlet.com/helpcenter"
		Call ChangeUrlRewrite301(m_request_uri)
    ElseIf INSTR(LCase(m_request_uri),"/international-store") > 0 Or INSTR(LCase(m_request_uri),"/international-store/") > 0  Then
        m_request_uri = "http://new.swimoutlet.com/international-store"
		Call ChangeUrlRewrite301(m_request_uri)
	Else	    
	    'Call ChangeUrlRewrite301(m_request_uri,"transfer")	
		
		 If Instr(LCASE(m_request_uri),".gif")<=0 and  Instr(LCASE(m_request_uri),".jpg")<=0 and Instr(LCASE(m_request_uri),".png")<=0 and Instr(LCASE(m_request_uri),".css")<=0 and Instr(LCASE(m_request_uri),".js")<=0 and Instr(LCASE(m_request_uri),".ico")<=0   Then
		    Call ChangeUrlRewrite301(m_request_uri)		
		End if
			
		'Call ChangeUrlRewrite301(m_request_uri)		
	'Ruud end added
	End If
	'Response.End()
	If Right(m_request_uri, 1) = "/" Then
		m_request_uri = m_request_uri & "default.asp"
	ElseIf InStrRev(m_request_uri, ".") < Len(m_request_uri) - 5 Then
		m_request_uri = m_request_uri & "/default.asp"
	End If
	
	m_uri_parts = Split(m_request_uri, "/")	
	
    
	'Phuoc move code here for friendly with .html Brand/category-----------
'Phuoc updated here for enhancement friendly brand with categories
	Dim fullBrandCategoryURL, parsedSEOBrand, m_request_uri_temp
	Dim m_uri_parts_temp
	
	'If Ubound(m_uri_parts) > 3 then
		'Response.Write(m_request_uri)
	'	fullBrandCategoryURL = m_request_uri
	'	fullBrandCategoryURL = Replace(lCase(fullBrandCategoryURL),"http://new.swimoutlet.com:80/","")
	'	fullBrandCategoryURL = Replace(lCase(fullBrandCategoryURL),"https://new.swimoutlet.com:80/","")
	'	fullBrandCategoryURL = Replace(lCase(fullBrandCategoryURL),"/default.asp","")
	'	parsedSEOBrand = Split(fullBrandCategoryURL, "/")(0)	
	'	fullBrandCategoryURL = Replace(lCase(fullBrandCategoryURL),parsedSEOBrand & "/","")
	'	Response.Redirect("http://new.swimoutlet.com/aboutus1.asp?a=" & fullBrandCategoryURL & "&b=" & parsedSEOBrand)
		
		'Response.Write(m_request_uri)
	'End If
	'Add multi level without .htm here
	m_request_uri_temp = Requested_Page
	If Right(m_request_uri_temp, 1) = "/" Then
		m_request_uri_temp = m_request_uri_temp & "default.asp"
	ElseIf InStrRev(m_request_uri_temp, ".") < Len(m_request_uri_temp) - 5 Then
		m_request_uri_temp = m_request_uri_temp & "/default.asp"
	End If
	
	m_uri_parts_temp = Split(m_request_uri_temp, "/")	

    ''Process Category and Product Detail Here
        
    '' End
    Dim strURLBrand
   
    dim isNeedCheckBrand
        isNeedCheckBrand = true
	If Ubound(m_uri_parts_temp) > 4 and instr( lcase(m_request_uri_temp),"/p/")=0 Then
		Dim strURLCategory
		
		fullBrandCategoryURL = m_request_uri_temp
		fullBrandCategoryURL = Replace(lCase(fullBrandCategoryURL),"http://www.swimoutlet.com:80/","")
		fullBrandCategoryURL = Replace(lCase(fullBrandCategoryURL),"https://www.swimoutlet.com:443/","")
		fullBrandCategoryURL = Replace(lCase(fullBrandCategoryURL),"/default.asp","")
		parsedSEOBrand = Split(fullBrandCategoryURL, "/")(0)	
		fullBrandCategoryURL = Replace(lCase(fullBrandCategoryURL),parsedSEOBrand & "/","")
		'fullBrandCategoryURL = Split(m_uri_parts_temp(UBound(m_uri_parts_temp)),".")(0)
		
		'Response.Redirect("http://new.swimoutlet.com/aboutus1.asp?a=" & fullBrandCategoryURL & "&b=" & parsedSEOBrand)
		'strURLBrand = Trim(m_uri_parts(Ubound(m_uri_parts)-2))
		'strURLCategory = Trim(m_uri_parts(Ubound(m_uri_parts)-1))		
		
		strURLBrand = parsedSEOBrand
		strURLCategory = fullBrandCategoryURL
		
		'------Fixed SQL injection
		strURLBrand = Replace(UCase(strURLBrand), "'", "")
		strURLBrand = Replace(UCase(strURLBrand), """", "")
		strURLBrand = Replace(UCase(strURLBrand), ")", "")
		strURLBrand = Replace(UCase(strURLBrand), "(", "")
		strURLBrand = Replace(UCase(strURLBrand), ";", "")
		'fixedRequest_Uri = Replace(UCase(fixedRequest_Uri), "-", "")
		strURLBrand = Replace(UCase(strURLBrand), "|", "")       
		
		'------Fixed SQL injection
		if Instr(strURLCategory,"?") > 0 then
			strURLCategory = Left(strURLCategory, Instr(strURLCategory,"?") -1 )
		end if
        
		
		strURLCategory = Replace(UCase(strURLCategory), "'", "")
		strURLCategory = Replace(UCase(strURLCategory), """", "")
		strURLCategory = Replace(UCase(strURLCategory), ")", "")
		strURLCategory = Replace(UCase(strURLCategory), "(", "")
		strURLCategory = Replace(UCase(strURLCategory), ";", "")
		'fixedRequest_Uri = Replace(UCase(fixedRequest_Uri), "-", "")
		strURLCategory = Replace(UCase(strURLCategory), "|", "")
		If Instr(strURLCategory,"-") > 0 Then
			dim urw_SplitBrandc
			urw_SplitBrandc = Split(strURLCategory,"-")
			
			category_id = mid(urw_SplitBrandc(ubound(urw_SplitBrandc)),2,len(urw_SplitBrandc(ubound(urw_SplitBrandc)))-1)
			category_id = Replace(category_id,"/","")
		End if

        if instr(lcase(Requested_Page),"/p/") > 0 then
                isNeedCheckBrand = false
        end if
        if isNeedCheckBrand = true AND fullBrandCategoryURL & "" <> "" then
            Dim reg_meta_404 
                Dim matches_meta_404
                Set reg_meta_404 = New RegExp
                reg_meta_404.IgnoreCase = True
                reg_meta_404.Global = True
                 reg_meta_404.Pattern = ".*-c[0-9]+.*" ' category page
                 'IF trim(Lcase(strURLBrand)) = "speedo" or trim(Lcase(strURLBrand)) = "tyr" or trim(Lcase(strURLBrand)) = "arena" then
                    if  reg_meta_404.Test(fullBrandCategoryURL) = false then
                        category_id = ""
                     end if
                ' elseif  reg_meta_404.Test(fullBrandCategoryURL) = true then
                    'isNeedCheckBrand = false
                 'end if
        end if

		
		'if Right(strURLCategory,1) = "/" then
		'	strURLCategory = Left(strURLCategory, Len(strURLCategory) -1 )
		'end if
		'strURLCategory = split(strURLCategory,"/")(0)
		
		dim strURLCategoryAfterProcess
		strURLCategoryAfterProcess = ""
		if Ubound(split(strURLCategory,"/")) >= 1 Then
			dim strURLCategoryPart
			For Each strURLCategoryPart In split(strURLCategory,"/") 				
				if strURLCategoryPart & "" <> "" AND instr(strURLCategoryPart,"PAGE=") = 0 and instr(strURLCategoryPart,"COLOR=") = 0 and instr(strURLCategoryPart,"SIZE=") = 0 and instr(strURLCategoryPart,"PATTERN=") = 0 _
				and instr(strURLCategoryPart,"MATERIAL=") = 0  and instr(strURLCategoryPart,"SHORTCUT=") = 0  and instr(strURLCategoryPart,"TREND=") = 0  and instr(strURLCategoryPart,"BODYTYPE=") = 0 _
				and instr(strURLCategoryPart,"BACKSTYLE=") = 0  and instr(strURLCategoryPart,"PRICE=") = 0  and instr(strURLCategoryPart,"FEA=") = 0 and instr(strURLCategoryPart,"PERCENTOFF=") = 0 _
				and instr(strURLCategoryPart,"GENDER=") = 0	and instr(strURLCategoryPart,"BOTTOMCOVERAGE=") = 0				then
					strURLCategoryAfterProcess = strURLCategoryAfterProcess & strURLCategoryPart & "/"
				end if
			Next
			
			If Replace(lcase(strURLCategoryAfterProcess),"/","") <> replace(lcase(strURLCategory),"/","")  Then
				Response.Clear()
				Response.Status="301 Moved Permanently"
				Response.AddHeader "Location", "https://www.swimoutlet.com/" & lcase(strURLBrand) & "/" & lcase(strURLCategoryAfterProcess)
				Response.End
			end if
		end if
		
		if strURLCategoryAfterProcess <> "" then
			strURLCategoryAfterProcess = Left(strURLCategoryAfterProcess, Len(strURLCategoryAfterProcess) -1 )
		end if
		
		if strURLCategoryAfterProcess <> "" then
			strURLCategory = strURLCategoryAfterProcess
		end if

        dim ishaveURLConvention
        ishaveURLConvention =  false

        if category_id & "" = "" then
            ishaveURLConvention =  true        
        elseif instr(strURLCategory,"-S-") > 0 then
		    strURLCategory = replace(strURLCategory,"-S-","S-")
            ishaveURLConvention =  true
        end if
        
        if IsNumeric(category_id) = false then
            category_id = ""
        end if		

        if isNeedCheckBrand = true then
		        Dim temp_m_conn, LinkCate
		        Dim temp_m_rs_brand, temp_m_rs_category
		        Set temp_m_conn = Server.CreateObject("ADODB.Connection")
		        temp_m_conn.Open Config_ConnectionString	
		        Set temp_m_rs_brand = Server.CreateObject("ADODB.Recordset")
		        Dim temp_sql
		        temp_sql = "SELECT intID,strSEOName FROM AQT_MANUFACTURER with(nolock) WHERE strSEOName = '" & strURLBrand & "' AND strStatus = 'ACTIVE' and s_soredesign='Y' "	
    
		        temp_m_rs_brand.Open temp_sql, temp_m_conn, 0, 1 '//same as adOpenForwardOnly, adLockReadOnly
		        If NOT temp_m_rs_brand.EOF Then
			        Set temp_m_rs_category = Server.CreateObject("ADODB.Recordset")
			        'temp_sql = "SELECT  * FROM Categories with(nolock) WHERE SEOCategoryName = '" & strURLCategory & "' AND ISNULL(s_SORedesign,'N') = 'Y'  "	
			        temp_sql = " SELECT B.CATEGORY_ID as Categoryid, ISNULL(c.sURLName,c.categoryname) as sURLName FROM AQT_PRODUCTCATEGORY_FOR_BRAND B WITH(NOLOCK) join Categories c with(nolock) on b.Category_ID = c.categoryid "
                    if category_id <> "" and category_id <> "0" Then
                        temp_sql = temp_sql & "WHERE strSEOName = '" & strURLBrand & "' and Categoryid =" & category_id
                    else
                        temp_sql = temp_sql & "WHERE strSEOName = '" & strURLBrand & "' and (CATEGORY_SEONAME='" & strURLCategory & "' or CATEGORY_SEONAME_2 = '" & strURLCategory & "' or CATEGORY_SEONAME = '" & replace(strURLCategory,"-","_") & "' or CATEGORY_SEONAME_2 = '" & replace(strURLCategory,"-","_") & "') AND ISNULL(c.s_SORedesign,'N') = 'Y' ORDER BY PRODUCT_COUNT DESC"
                    end if
			        temp_m_rs_category.Open temp_sql, temp_m_conn, 0, 1 '//same as adOpenForwardOnly, adLockReadOnly                           
                    'Process for URL Name Convention
                    if not temp_m_rs_category.EOF then
                        if ishaveURLConvention = true or (InStr(strURLCategory, "/") > 0 and category_id <> "" and category_id <> "0") then 
                            if temp_m_rs_brand("intID") = "1129" or temp_m_rs_brand("intID") = "1010" or temp_m_rs_brand("intID") = "1157" or 1=1 then
                                LinkCate = Replace(temp_m_rs_category("sURLName"), " ", "-")

	                            'If we ended up with any double underscores, remove them...
	                            LinkCate = Replace(LinkCate, "--", "-")
	                            LinkCate = Replace(LinkCate, "--", "-")
	                            LinkCate = Replace(LinkCate, "--", "-")
	                            LinkCate = Replace(LinkCate, "--", "-")
	                            LinkCate = Replace(LinkCate, "--", "-")

	                            'Remove beginning or trailing underscores
	                            If Right(LinkCate, 1) = "-" Then
		                            LinkCate = Mid(LinkCate,1,Len(LinkCate)-1)
	                            End If
	                            If Left(LinkCate, 1) = "-" Then
		                            LinkCate = Mid(LinkCate,2)
	                            End If
    
                                If InStr(lcase(m_request_uri_temp),lcase(LinkCate) & "-c" & temp_m_rs_category("Categoryid") & "/") = 0 Then
                                    Response.Clear()                                  
                                    Response.Status="301 Moved Permanently"                                    
						            Response.AddHeader "Location", "http://www.swimoutlet.com/" & lcase(strURLBrand) & "/" & lcase(LinkCate) & "-c" & temp_m_rs_category("Categoryid") & "/"
						            Response.End   
                                End If
                            else
                                Response.Clear()
                                Response.Status="301 Moved Permanently"
						        Response.AddHeader "Location", "http://www.swimoutlet.com/" & lcase(strURLBrand) & "/" & lcase(strURLCategory)
						        Response.End
                            end if
                        end if
                    end if
    
                    ' Check Brand Category
			        If temp_m_rs_category.EOF Then
				        temp_m_rs_category.Close
				        Set temp_m_rs_category = Nothing
				        Set temp_m_rs_category = Server.CreateObject("ADODB.Recordset")
                        if category_id <> "" and category_id <> "0" Then
                            temp_sql = "SELECT * FROM Categories with (nolock) where Categoryid =" & category_id
                        else
                            temp_sql = "SELECT * FROM Categories with (nolock) WHERE (SEOCategoryName = '" & strURLCategory & "' or SEOCategoryName='" & replace(strURLCategory,"-","_") & "') and isnull(s_SORedesign,'N') = 'Y'"
                        end if
				        temp_m_rs_category.Open temp_sql, temp_m_conn, 0, 1 '//same as adOpenForwardOnly, adLockReadOnly

					    if  temp_m_rs_category.EOF then
                            temp_m_rs_category.Close
				            Set temp_m_rs_category = Nothing
				            Set temp_m_rs_category = Server.CreateObject("ADODB.Recordset")
                            temp_sql = "   select  distinct top 1 isnull(a.redesignid,'0') as Categoryid,b.categoryid as categoryidlegacy,ISNULL(s_SORedesign,'N') ,isnull((select top 1 SEOCategoryName from categories with(nolock) where  categoryid =  a.redesignid),'')  as SEOCategoryName, ISNULL(b.sURLName,b.CategoryName)sURLName  "
				            temp_sql = temp_sql  & " from AQT_RedesignURLMapping_ALL  a with(nolock) right join  categories b with(nolock) on a.legacyid = b.categoryid  and pagename in ('CategoryYoga','Category')   "
                            if category_id <> "" and category_id <> "0" Then
				                temp_sql = temp_sql  & " where  redesignid=  " & category_id
                            else
                                temp_sql = temp_sql  & " where  (SEOCategoryName = '" & strURLCategory & "' or SEOCategoryName='" & replace(strURLCategory,"-","_") & "' )  "
                            End if
                            temp_m_rs_category.Open temp_sql, temp_m_conn, 0, 1 '//same as adOpenForwardOnly, adLockReadOnly

					        if not  temp_m_rs_category.EOF then
                                   
                                if temp_m_rs_category("Categoryid") & "" = "0" then
							        temp_m_rs_category.close()
							        set temp_m_rs_category = nothing							
							        Response.Clear()
							        Response.Status="301 Moved Permanently"
							        Response.AddHeader "Location", "http://www.swimoutlet.com/" & lcase(strURLBrand)
							        Response.End   
						        elseif trim( temp_m_rs_category("Categoryid")&"") <> trim( temp_m_rs_category("categoryidlegacy")&"") then
                                    if temp_m_rs_brand("intID") = "1129" or temp_m_rs_brand("intID") = "1010" or temp_m_rs_brand("intID") = "1157" or 1=1 then
                                        LinkCate = Replace(Lcase(temp_m_rs_category("sURLName")), " ", "-")

	                                    'If we ended up with any double underscores, remove them...
	                                    LinkCate = Replace(LinkCate, "--", "-")
	                                    LinkCate = Replace(LinkCate, "--", "-")
	                                    LinkCate = Replace(LinkCate, "--", "-")
	                                    LinkCate = Replace(LinkCate, "--", "-")
	                                    LinkCate = Replace(LinkCate, "--", "-")

	                                    'Remove beginning or trailing underscores
	                                    If Right(LinkCate, 1) = "-" Then
		                                    LinkCate = Mid(LinkCate,1,Len(LinkCate)-1)
	                                    End If
	                                    If Left(LinkCate, 1) = "-" Then
		                                    LinkCate = Mid(LinkCate,2)
	                                    End If
							            Response.Clear()
							            Response.Status="301 Moved Permanently"
                                        
							            Response.AddHeader "Location", "http://www.swimoutlet.com/" & lcase(LinkCate) & "-c" & temp_m_rs_category("Categoryid") & "/"
							            Response.End  
                                    else
                                        Response.Clear()
							            Response.Status="301 Moved Permanently"
                                        
							            Response.AddHeader "Location", "http://www.swimoutlet.com/" & lcase(strURLBrand) & "/" & lcase(temp_m_rs_category("SEOCategoryName"))
							            Response.End
                                    end if
						        end if 
                            end if
				        end if                            
			        End If ' End Brand Category

			        'if of leagcy => link redesign
			        If NOT temp_m_rs_category.EOF and strURLCategory & "" <> "" Then
			        'Response.Write("1:" & temp_m_rs_category("Categoryid"))	
				        'It's ok to transfer to
				        Dim transfertoURL, cachedfile
				        transfertoURL = Current_Path & "ProductBrand.asp?Brand=" & temp_m_rs_brand("intID") & "&cat=" & temp_m_rs_category("Categoryid")
				                            
				        Session("SEOBrand")  = temp_m_rs_brand("strSEOName")
				        Session("SEOBrandID") = temp_m_rs_brand("intID")
				        Session("SEOCategory")  = temp_m_rs_category("Categoryid")
				        temp_m_rs_category.Close
				        temp_m_rs_brand.Close
				        temp_m_conn.Close
				        Set temp_m_rs_category = Nothing
				        Set temp_m_rs_brand = Nothing
				        Set temp_m_conn = Nothing								
				        Server.Transfer(Current_Path & "ProductBrand.asp")	
			        End If

			        temp_m_rs_brand.Close
			        temp_m_conn.Close
			        Set temp_m_rs_brand = Nothing
			        Set temp_m_conn = Nothing
		        End If
		      end if
		End If    
'-------------------End of enhancement-------------------------------
'----------------------------------------------------------------------
		
'	Response.Write(m_request_uri)
'	Response.End()
	If Ubound(m_uri_parts) > 1 AND INStr(Lcase(m_request_uri),"/reviews") <= 0 and instr(lcase(m_request_uri),"/p/") = 0 Then
			m_request_uri = replace(m_request_uri,"HTTP://","")
			m_request_uri = replace(m_request_uri,"HTTPS://","")
			m_request_uri = Trim(split(m_request_uri,"/")(1))
		'An end update 20130605 RUNOUTLET-550
			
		Set m_conn = Server.CreateObject("ADODB.Connection")
		m_conn.Open Config_ConnectionString	
		Set m_rs = Server.CreateObject("ADODB.Recordset")

		Dim fixedRequest_Uri
		fixedRequest_Uri = Replace(UCase(m_request_uri), "'", "")
		fixedRequest_Uri = Replace(UCase(fixedRequest_Uri), """", "")
		fixedRequest_Uri = Replace(UCase(fixedRequest_Uri), ")", "")
		fixedRequest_Uri = Replace(UCase(fixedRequest_Uri), "(", "")
		fixedRequest_Uri = Replace(UCase(fixedRequest_Uri), ";", "")
		'fixedRequest_Uri = Replace(UCase(fixedRequest_Uri), "-", "")
		fixedRequest_Uri = Replace(UCase(fixedRequest_Uri), "|", "")
			'Response.Write(fixedRequest_Uri)
	'Response.End()
		'm_sql = "SELECT * FROM AQT_MANUFACTURER WHERE strSEOName = '" & Replace(UCase(m_request_uri), "'", "''") & "'"	
		'Ruud updated to not run bellow query if request is image
		'Response.Write("<input type='hidden' value='" & fixedRequest_Uri & "' name='test_uri' />")
		If UCase(fixedRequest_Uri) <> "IMAGES"  and isNeedCheckBrand = true  then
		    m_sql = "SELECT intId, strstatus, isnull(s_soredesign,'N') as s_soredesign FROM AQT_MANUFACTURER with(nolock) WHERE strSEOName = '" & fixedRequest_Uri & "' "	
            'm_sql = "SELECT a.intId,a.strSEOName,isnull(b.brands,'') as brands FROM AQT_MANUFACTURER a with(nolock) left join  [SO-ARCHIVED].dbo.AQT_BRANDS_YO_MAPPING b with(nolock) on a.strmanufacturer = b.brands  WHERE a.strSEOName = '" & fixedRequest_Uri & "' AND a.strStatus = 'ACTIVE'"	
		    m_rs.Open m_sql, m_conn, 0, 1 '//same as adOpenForwardOnly, adLockReadOnly
    				
              if Session("sessiontamtest")="Y" then
                   Response.Write("temp_sql 2 " & fixedRequest_Uri )
                    Response.End()
           end if
		    If NOT m_rs.EOF Then
                   '' Tam Dang Update SEO Legacy Yoga
                'if  trim(m_rs("brands")) <> "" then
                '    call Redirect_301("http://www.yogaoutlet.com/" & lcase(m_rs("strSEOName")) )
                'end if
				If Lcase(m_rs("strStatus") & "") = "inactive" OR Lcase(m_rs("s_soredesign") & "") = "N" Then
					m_rs.Close
					m_conn.Close
					Set m_rs = Nothing
					Set m_conn = Nothing			  
					Response.Redirect("/brands/")
					Response.end()
				End If

			    Dim brandpage_url
			    brandpage_url = Current_Path & "ProductBrand.asp?Brand=" + m_request_uri
				
				'AnTran add here before transfer it should store BrandId to session
				Session("SEOBrand") = m_rs("intId")
    			 
			    m_rs.Close
			    m_conn.Close
			    Set m_rs = Nothing
			    Set m_conn = Nothing			  
			    Server.Transfer(Current_Path & "ProductBrand.asp")
		    End If
		    m_rs.Close
        End If
			

		'If Request.ServerVariables("REMOTE_ADDR") = "222.253.82.182" then
		'	Response.Write("Last Part: " & m_request_uri)
		'End If
						
		'm_sql = "SELECT CustomerID, WebSiteAddress FROM dbo.Customers WHERE strSubUrl = '" & Replace(UCase(m_request_uri), "'", "''") & "'"
		'Ruud updated to not run bellow query if request is image
		'Response.Write("<input name='strSubURL' type='hidden' value='" & fixedRequest_Uri & "' />")
		'We add 1=2 to make sure it does not call again for Affiliate URL because we import to 301 on 10122014
		If 1=2 and UCase(fixedRequest_Uri) <> "IMAGES" AND fixedRequest_Uri & "" <> "" AND UCase(fixedRequest_Uri) & "" <> "PHOTOS"  then
		    m_sql = "SELECT CustomerID, WebSiteAddress FROM dbo.Customers with(nolock) WHERE strSubUrl = '" & fixedRequest_Uri  & "'"
		    m_rs.Open m_sql, m_conn, 0, 1
    	
		    If NOT m_rs.EOF Then
		        Dim click_id
		        click_id = m_rs("CustomerID")
    		
			    m_rs.Close
			    m_conn.Close
			    Set m_rs = Nothing
			    Set m_conn = Nothing
    			'Response.Cookies("AffiliateID")=click_id	
				
			    If LCase(m_request_uri) = "polo" Then
		            Response.Redirect("http://www.swimoutlet.com/SearchResults.asp?Cat=208&clickid=" & click_id)
				elseif LCase(m_request_uri) = "aquadawgs" then
					Response.Redirect("http://www.swimoutlet.com/SearchResults.asp?Cat=1698&clickid=" & click_id)											
		        Else				
		            Server.Transfer (Current_Path & "Default.asp")
		        End If
		    End If		
		    m_rs.Close()
		End If
		Set m_rs = Nothing
		
		m_conn.Close()
		Set m_conn = Nothing
	End If
Else 'incase files is .htm	
	If Instr(Requested_Page, "abtesting") > 0 Then
		Response.Status="301 Moved Permanently"
		Response.AddHeader "Location", "https://www.swimoutlet.com"
		Response.End
	End if	
End If
'End Custom Sub URI
'---------------------------------------------------------------------
Dim qrString : qrString = ""
If InStr(Requested_Page, "?") Then
	qrString = Mid(Requested_Page, Instr(Requested_Page, "?") + 1)
	Requested_Page = Left(Requested_Page, InStr(Requested_Page, "?") - 1)
End If

Dim category_id
'New url for category review
dim iscategoryreview 
iscategoryreview =  false
   
'Response.Write(( instr(Requested_Page,"-c") > 0 and instr(lcase(Requested_Page),"/reviews") > 0) and instr(lcase(Requested_Page),"/p/") <= 0)
'Response.End()
if ( instr(Requested_Page,"-c") > 0 and instr(lcase(Requested_Page),"/reviews") > 0) and instr(lcase(Requested_Page),"/p/") <= 0 and instr(lcase(Requested_Page),"/p-ab/") <= 0 and instr(lcase(Requested_Page),"/q/") <= 0 and instr(lcase(Requested_Page),"/qa/") <= 0 then  		
	
	iscategoryreview =  true
	dim paramcategoryreview
	paramcategoryreview = Mid(Requested_Page, InStrRev(Requested_Page, "/")+1,len(Requested_Page) - InStrRev(Requested_Page, "/")+1)
	Requested_Page =  Replace(lcase(Requested_Page),"/" & paramcategoryreview,"")
	Session("categoryreviewall") = ""
	Session("categoryreviewpaging") = ""
	if instr(paramcategoryreview,"-page") > 0 then
		paramcategoryreview = Replace(paramcategoryreview,"reviews-page","")
		Session("categoryreviewpaging") = paramcategoryreview
	elseif  instr(paramcategoryreview,"-all") > 0 then
		Session("categoryreviewall") = "all"	
	else
		Session("categoryreviewpaging") = ""
	end if
	if instr(paramcategoryreview,"reviews0") >0 then ' invalid page
		Response.Redirect("http://www.swimoutlet.com/404.htm")
	end if
 'Elseif ( instr(Requested_Page,"-c") <= 0 and instr(lcase(Requested_Page),"/reviews") > 0) and instr(lcase(Requested_Page),"/p/") <= 0 then  	
Elseif ( instr(Requested_Page,"-c") <= 0 and ( Right(lcase(Requested_Page),8) = "/reviews" OR Instr(lcase(Requested_Page),"/reviews-page") > 0  )) and instr(lcase(Requested_Page),"/p/") <= 0 and instr(lcase(Requested_Page),"/p-ab/") <= 0 then  	
	dim brandSEOReview, Requested_Page_BReview
	Requested_Page_BReview = Requested_Page	
	brandSEOReview = Mid(Requested_Page_BReview, InStrRev(Requested_Page_BReview, "/")+1,len(Requested_Page_BReview) - InStrRev(Requested_Page_BReview, "/")+1)
	if instr(brandSEOReview,"-page") > 0 then		
		Session("brandreviewpaging") = Replace(brandSEOReview,"reviews-page","")
	elseif  instr(paramcategoryreview,"-all") > 0 then
		Session("categoryreviewall") = "all"	
	else
		Session("brandreviewpaging") = ""
	end if
	'Response.Write("1"&brandSEOReview)
	'Response.End()
	Requested_Page_BReview = Replace(Requested_Page_BReview,"/" & brandSEOReview,"")
	brandSEOReview = Mid(Requested_Page_BReview, InStrRev(Requested_Page_BReview, "/")+1,len(Requested_Page_BReview) - InStrRev(Requested_Page_BReview, "/")+1)	
	
    Session("BrandReviewSEO") = brandSEOReview         

    Server.Transfer (Current_Path&"BrandReview.asp")	      
end if

Dim Requested_Page_NoHttp
Requested_Page_NoHttp = replace(replace(Requested_Page,"http://",""),"https://","")

if instr(Requested_Page_NoHttp,"?") > 0 then
	Requested_Page_NoHttp =  left(Requested_Page_NoHttp,instr(Requested_Page_NoHttp,"?") -1)
end if
'Response.Write("<input type=""hidden"" value =""" &Requested_Page& """ name=""testurl"" ")
'urw_Split = Split(Requested_Page,"/")

Dim isTopReviewCategory
	isTopReviewCategory = false
'If Request.Cookies("tptest") = "BBB" Then
	If instr(lcase(Requested_Page_NoHttp),"/top-reviewed") > 0 and instr(lcase(Requested_Page_NoHttp),"-c") > 0 then
		Requested_Page_NoHttp = Replace(Requested_Page_NoHttp,"/top-reviewed/","")
		Requested_Page_NoHttp = Replace(Requested_Page_NoHttp,"/top-reviewed","")
		'Response.Write("Requested_Page_NoHttp:" & Requested_Page_NoHttp)
		isTopReviewCategory = true
	End If
'End If 

urw_Split = Split(Requested_Page_NoHttp,"/")
	
If Ubound(urw_Split) >= 1 Then	
    if isCategoryPage(urw_Split(1)) = true or InStr(Requested_Page,"/lifestyle/") > 0 then
	    'Requested_File = urw_Split(Ubound(urw_Split)-1)
        Requested_File = urw_Split(1)
		
        '''' Tam dang Process for Url Category
        '''' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        dim RequestedUrl,urw_Splitc
        RequestedUrl = urw_Split(Ubound(urw_Split))	
	    If RequestedUrl = "" Then
		    RequestedUrl = urw_Split(Ubound(urw_Split)-1)
	    End If	
	    Dim isVirtualPaging
	    isVirtualPaging = false
		    if instr(RequestedUrl,"page=") > 0 and isnumeric(replace(lcase(RequestedUrl),"page=","")) then
			    if Ubound(urw_Split) >= 2 then
				    RequestedUrl = urw_Split(1)
				    isVirtualPaging = true
			    end if
		    end if
	    If Request.Cookies("tptest") = "BBB" Then
		    'Response.Write("RequestedUrl:" & RequestedUrl)		
	    End If 	
        if instr(RequestedUrl,"-c") > 0 and InStr(LCase(Requested_Page),"/qa/") <= 0 and InStr(LCase(Requested_Page),"/q/") <= 0 and InStr(LCase(Requested_Page),"/p/") <= 0 and InStr(LCase(Requested_Page),"/p-ab/") <= 0 then  								
            urw_Splitc = Split(RequestedUrl,"-")
        
            category_id = mid(urw_Splitc(ubound(urw_Splitc)),2,len(urw_Splitc(ubound(urw_Splitc)))-1)
		    'IF Request.ServerVariables("HTTP_True-Client-IP") = "113.161.67.199" Then
		    '	Response.Write("AAAA" & category_id)
		    '	Response.End()
		    'End If		
		    'If Request.Cookies("tptest") = "BBB" Then			
			    If isTopReviewCategory then
				    Session("CategoryReviewID") = category_id				
				    'Response.Write("category_id:" & category_id)
				    'Response.Write("<br>isTopReviewCategory:" & isTopReviewCategory)
				    'Response.Write("<br>URL:" & Current_Path&"topreview.asp")
				    'Response.End()
				    Server.Transfer (Current_Path&"TopReview.asp")	
				    'Response.Redirect(Current_Path&"TopReview.asp")	
				    'Response.End()
			    End If
		    'End If
		
            if IsNumeric(category_id) then
                'Response.Write("AAA" & category_id & "BBB")
                'category_id = Replace(category_id,"/","")
			
			    ' Tam Dang Update url categoryreview
			    if iscategoryreview =  true then
				    Session("CategoryReviewID") = category_id				
				    If InStr(Requested_Page,"/lifestyle/") > 0 Then
					    'Response.Write("go here:"&Current_Path & "lifestyle/CategoryReview.asp")
					    'Response.End	
					    Server.Transfer(Current_Path & "lifestyle/CategoryReview.asp")
				    Else
					    'Response.Write("go here:"&Current_Path & "CategoryReview.asp")
					    'Response.End	
					    Server.Transfer(Current_Path & "CategoryReview.asp")
				    End If
			    end if
				    call PROCESS_SEOLink_CATEGORY(category_id,Requested_File,Requested_Page_NoHttp)					
	            '----------------------------------------------------
	            If 1=2 and CacheFileExists(Server.MapPath(Current_Path & "htmlcached/category_s/" & category_id & ".htm")) and not isVirtualPaging Then
		            Session("ThisCat") = category_id
		            Server.Transfer(Current_Path & "htmlcached/category_s/" & category_id & ".htm")	        		   
			    End If	
        	    Session("NONEEDFANCYCSS") = "TRUE"
			
	            If InStr(LCASE(Request.ServerVariables("QUERY_STRING")),"lifestyle") > 0 Then
				    Server.Transfer (Current_Path&"lifestyle/SearchResults.asp")	
			    Else
				    Server.Transfer (Current_Path&"SearchResults.asp")	
			    End If
            end if
	    elseif Instr(LCase(RequestedUrl),"new-arrivals-") = 1 AND InStr(LCase(Requested_Page),"/p/") <= 0 and InStr(LCase(Requested_Page),"/p-ab/") <= 0 Then
            category_id = Replace(Lcase(RequestedUrl),"new-arrivals-","")
            category_id  = Replace(category_id, "/","")
            Session("ThisCat") = category_id		
            Session("clrcid") = "480"
            Server.Transfer (Current_Path&"SearchResults.asp")	
        end if
        '''' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        '''' End
    end if
End If


'Redirect to the real page...
SELECT CASE Right(Requested_File,2)
CASE "_s"
	If InStrRev(Requested_Page, ".") > InStrRev(Requested_Page, "/") Then
		Dim category_id_paging
		category_id = Mid(Requested_Page, InStrRev(Requested_Page, "/")+1, InStrRev(Requested_Page, ".")-InStrRev(Requested_Page, "/")-1)
		If category_id  = "220" or category_id  = "288" then		
				Session("ThisCat") = category_id
		'	Session("Config_SearchResultsRows") = 25	
		End If
		category_id_paging = category_id
		
		'Phuoc Update here to show up the banner-------------
		If (category_id = "200" OR category_id = "327" OR category_id = "205" OR category_id = "300" OR category_id = "1083" OR category_id = "211" OR category_id = "203" OR category_id = "204" OR category_id = "208") Then

			Dim customerIdFromSession  
			customerIdFromSession =	Session("www.swi/CustomerID")
		   If customerIdFromSession <> "" Then
		   'If 1 = 2 then	
			Dim sqlCheckShowBanner
			Dim rsBanner
			Set rsBanner = Server.CreateObject("ADODB.Recordset")
			Dim m_conn1 
			Set m_conn1 = Server.CreateObject("ADODB.Connection")
			m_conn1.Open Config_ConnectionString
			sqlCheckShowBanner = "SELECT * FROM AQT_CUSTOMER_BANNER with(nolock) WHERE intCustomerID = " & customerIdFromSession & " AND intCategoryid = " & category_id
			rsBanner.Open sqlCheckShowBanner, m_conn1, 0, 1
			   If NOT rsBanner.EOF Then
				Response.Cookies("SHOWBANNER")= "OFF" 
					   End If
			
			rsBanner.Close()
			Set rsBanner = Nothing
			
			m_conn1.Close()
			Set m_conn1 = Nothing

		   End If
				
		End If	

		'----------------------------------------------------
		If CacheFileExists(Server.MapPath(Current_Path & "htmlcached/category_s/" & category_id & ".htm")) Then
			Session("ThisCat") = category_id
			'Call LogPageView("Category", category_id, "/htmlcached/category_s/" & category_id & ".htm")
			Server.Transfer(Current_Path & "htmlcached/category_s/" & category_id & ".htm")
		End If
		Server.Transfer (Current_Path&"SearchResults.asp")	
	End If
CASE "_p"
	Dim product_code
	
CASE "_a"
	Server.Transfer (Current_Path&"Articles.asp")	
CASE "-b" 'View By Brand
	Server.Transfer (Current_Path&"ProductBrand.asp")	
END SELECT

Dim product_code_reskin, Requested_Page_Reskin
If Right(Requested_File,5) = "_p-ab" Then	
	Requested_Page_Reskin = Replace(Requested_Page,"_p-ab","_p")
	product_code_reskin = Mid(Requested_Page_Reskin, InStrRev(Requested_Page_Reskin, "/")+1, InStrRev(Requested_Page_Reskin, ".")-InStrRev(Requested_Page_Reskin, "/")-1)
			
	If CacheFileExists(Server.MapPath(Current_Path & "htmlcached/product_p-ab/" & product_code_reskin & ".htm")) Then
		'Call LogPageView("Product", product_code, "/htmlcached/product_p/" & product_code & ".htm")		
		Server.Transfer(Current_Path & "htmlcached/product_p-ab/" & product_code_reskin & ".htm")
	End If    
	Server.Transfer(Current_Path & "ProductDetails_ab.asp")	
End If

On Error Resume Next
'If Request.Cookies("tptest") = "redesign" Then
	'Response.Write("Requested_File:" & Requested_File)
	'Response.End()
	If Requested_File = "p-ab" Or InStr(Requested_Page, "/p-ab/") > 0 Then
		'Response.Write("Requested_Page:" & Requested_Page)
		'Response.End()
		'Session("ThisCat") = ""
		Requested_Page_Reskin = Replace(Requested_Page,"/p-ab/","/p/")	
		
		Dim iTemp_Split_p, fv_Requested_Page_p, fv_urw_Split_p, fv_Requested_File_p, Requested_Color_p,iTemp_SplitColor_p, fv_ColorID_p
		fv_Requested_Page_p = Requested_Page_Reskin 
		
		Requested_Color_p = fv_Requested_Page_p
		
		If Right(fv_Requested_Page_p,1) = "/" Then
			fv_Requested_Page_p = left(fv_Requested_Page_p,len(fv_Requested_Page_p) - 1)
		End If
			 
		
		fv_urw_Split_p = Split(fv_Requested_Page_p,"/")
		If Ubound(fv_urw_Split_p) > 1 Then
			fv_Requested_File_p = fv_urw_Split_p(Ubound(fv_urw_Split_p)-1)
		End If
		if (fv_Requested_File_p ="p") then
		iTemp_Split_p = Split(fv_Requested_Page_p,"-")	
		else
		iTemp_Split_p = Split(fv_Requested_File_p,"-")
		iTemp_SplitColor_p = Split(Requested_Color_p,"/")
		fv_ColorID_p = iTemp_SplitColor_p(Ubound(iTemp_SplitColor_p))
		end if	
			
		
		product_code_reskin = iTemp_Split_p(Ubound(iTemp_Split_p))	
		product_code_reskin = Replace(product_code_reskin,"%20"," ")	
		If Instr(product_code_reskin,"?") > 0 Then
			dim arr_product_code_reskin
			arr_product_code_reskin = split(product_code_reskin,"?")
			product_code_reskin = arr_product_code_reskin(0)
		End if
		Session("ThisProductCode")	= 	product_code_reskin
		If Request.Cookies("tptest") = "1234" Then
		'Response.Write("product_code_reskin:" & product_code_reskin)
		'Response.End()
		End If
				
		If CacheFileExists(Server.MapPath(Current_Path & "htmlcached/product_p-ab/" & product_code_reskin & ".htm")) Then
			'Call LogPageView("Product", product_code, "/htmlcached/product_p/" & product_code & ".htm")		
			Server.Transfer(Current_Path & "htmlcached/product_p-ab/" & product_code_reskin & ".htm")
		End If    
		'Server.Transfer(Current_Path & "ProductDetails-reskin.asp")	
        Session("ThisProductCode")	= 	product_code_reskin
		Server.Transfer(Current_Path & "ProductDetails_ab.asp")	
	
	End If
	
'End If
On Error Goto 0

Dim iTemp_Split, ihtm_spot, fv_Requested_Page, fv_urw_Split, fv_Requested_File, Requested_Color,iTemp_SplitColor, fv_ColorID
dim productdetailSEO
'If Request.Cookies("tptest") = "QA" Then
	If InStr(Requested_Page,"/q/") > 0 Then
		Dim questionid
		fv_Requested_Page = Requested_Page
		If Right(fv_Requested_Page,1) = "/" Then
			fv_Requested_Page = left(fv_Requested_Page,len(fv_Requested_Page) - 1)
		End If			 
		
		fv_urw_Split = Split(fv_Requested_Page,"/")
		If Ubound(fv_urw_Split) > 1 Then
			fv_Requested_File = fv_urw_Split(Ubound(fv_urw_Split)-1)
		End If
		
		if (fv_Requested_File ="q") then
			iTemp_Split = Split(fv_Requested_Page,"-")			
			productdetailSEO = Split(fv_Requested_Page,"/")(ubound(Split(fv_Requested_Page,"/")))	
		else			
			productdetailSEO = fv_Requested_File
			iTemp_Split = Split(fv_Requested_File,"-")			
		end if	
					
		questionid = iTemp_Split(Ubound(iTemp_Split))	
		questionid = Replace(questionid,"%20"," ")
	
		if instr(questionid,"?") > 0 then
			questionid = left(questionid,instr(questionid,"?")-1)
		end if
		'response.write("questionid:" & questionid)
		'response.end
		Session("questionid")	= 	questionid				
		
		If InStr(Requested_Page,"lifestyle/q/") > 0 Then
			Server.Transfer(Current_Path & "lifestyle/qanswer.asp")
		Else			
			Server.Transfer(Current_Path & "qanswer.asp")
		End If
	End If
	If InStr(Requested_Page,"/qa/") > 0 Then
		Dim questionproductcode
		fv_Requested_Page = Requested_Page
		If Right(fv_Requested_Page,1) = "/" Then
			fv_Requested_Page = left(fv_Requested_Page,len(fv_Requested_Page) - 1)
		End If			 
		
		fv_urw_Split = Split(fv_Requested_Page,"/")
		If Ubound(fv_urw_Split) > 1 Then
			fv_Requested_File = fv_urw_Split(Ubound(fv_urw_Split)-1)
		End If
		
		if (fv_Requested_File ="qa") then
			iTemp_Split = Split(fv_Requested_Page,"-")			
			productdetailSEO = Split(fv_Requested_Page,"/")(ubound(Split(fv_Requested_Page,"/")))	
		else			
			productdetailSEO = fv_Requested_File
			iTemp_Split = Split(fv_Requested_File,"-")			
		end if	
					
		questionproductcode = iTemp_Split(Ubound(iTemp_Split))	
		questionproductcode = Replace(questionproductcode,"%20"," ")
	
		if instr(questionproductcode,"?") > 0 then
			questionproductcode = left(questionproductcode,instr(questionproductcode,"?")-1)
		end if
		'response.write("questionproductcode:" & questionproductcode)
		'response.end
		Session("questionproductcode")	= 	questionproductcode				

		'If InStr(Requested_Page,"lifestyle/qa/") > 0 Then
			'Server.Transfer(Current_Path & "lifestyle/productquestions.asp")
		'Else
			Server.Transfer(Current_Path & "productquestions.asp")
		'End If
	End If
'End If

If InStr(Requested_Page,"/p/") > 0 Then
	if instr(Requested_Page,"ReviewDetails.asp") > 0 then ' Invalid, set 301 redirect
		Requested_Page = Replace(Requested_Page,"/ReviewDetails.asp","/reviews")
		Response.Status = "301 Moved Permanently"
	    Response.AddHeader "Location", Requested_Page
	    Response.End
	end if
	
	'' Tam dang update for product avaibility
	dim isproductavaibility,productreviewcode,productreviewpage,isproductreview,productreviewparam ,Requested_Page_Temp
	isproductavaibility =  false
	dim isproductbulkordering
	if instr(Requested_Page,"availability") > 0  then 
	
		isproductavaibility = true
		Requested_Page =  Replace(Requested_Page,"/availability","")
	elseif instr(Requested_Page,"bulkordering") > 0  then 	
		isproductbulkordering = true
		Requested_Page =  Replace(Requested_Page,"/bulkordering","")
	elseif instr(Requested_Page,"/reviews") > 0 AND instr(lcase(Requested_Page),"gift-card") > 0 then
		Response.Redirect("/giftcards")	
	elseif instr(Requested_Page,"/reviews") > 0  then
		Requested_Page_Temp = Requested_Page
		productreviewparam = left(Requested_Page,InStr(Requested_Page,"/reviews") )
		Requested_Page = productreviewparam
		productreviewparam =  Replace(Requested_Page_Temp,Requested_Page,"")
		isproductreview = true
		'Requested_Page =  Replace(Requested_Page,"/availability","")
	end if	
			    
    fv_Requested_Page = Requested_Page 
    
    Requested_Color = fv_Requested_Page
    
    If Right(fv_Requested_Page,1) = "/" Then
        fv_Requested_Page = left(fv_Requested_Page,len(fv_Requested_Page) - 1)
    End If
         
    
	fv_urw_Split = Split(fv_Requested_Page,"/")
    If Ubound(fv_urw_Split) > 1 Then
	    fv_Requested_File = fv_urw_Split(Ubound(fv_urw_Split)-1)
    End If
	
	'16656	
    if (fv_Requested_File ="p") then
		iTemp_Split = Split(fv_Requested_Page,"-")	
		 '16656
        productdetailSEO = Split(fv_Requested_Page,"/")(ubound(Split(fv_Requested_Page,"/")))	
	else
		 '16656
        productdetailSEO = fv_Requested_File
		iTemp_Split = Split(fv_Requested_File,"-")
		iTemp_SplitColor = Split(Requested_Color,"/")
		fv_ColorID = iTemp_SplitColor(Ubound(iTemp_SplitColor))
	end if	
		
	
	product_code = iTemp_Split(Ubound(iTemp_Split))	
	product_code = Replace(product_code,"%20"," ")
	
	if instr(product_code,"?") > 0 then
		product_code = left(product_code,instr(product_code,"?")-1)
	end if
	'Response.Write(product_code)
	'Response.End()
	
	'' Tam dang update for product avaibility
	if isproductavaibility  =  true then		
		Session("ProductCodeAvailability") = product_code ' I fixed spelling
		Session("ProductSKUAvailability") = FuncGetUrlParameter("r", qrString) ' I added to get SKU
		Server.Transfer(Current_Path & "productavailability.asp")
	elseif isproductbulkordering  =  true then		
		Session("ProductCodeBulkOrdering") = product_code ' I fixed spelling
		Session("ProductSKUBulkOrdering") = FuncGetUrlParameter("r", qrString) ' I added to get SKU
		Server.Transfer(Current_Path & "bulkordering.asp")
	elseif isproductreview =  true then
		Session("productcodereview")	= 	product_code
		if productreviewparam <> "" then
			productreviewparam = Replace(productreviewparam,"reviews-page","")
			productreviewparam = Replace(productreviewparam,"reviews","")
			Session("pageproductreview") = productreviewparam
		else
			Session("pageproductreview") = ""
		end if
		'If Request.Cookies("tptest") = "reviewlist" Then
			'Response.Write("Requested_Page:" & Requested_Page)
			'Response.Write("<br>product_code:" & product_code)
			'Response.Write("<br>isproductreview:" & isproductreview)
			'Response.Write("<br>productreviewparam:" & productreviewparam)
			'Response.End
		'End If	
		'Server.Transfer (Current_Path&"ReviewList.asp")	
		If InStr(Requested_Page,"/lifestyle/") > 0 Then
			Server.Transfer(Current_Path & "lifestyle/ReviewList.asp")
		Else
			Server.Transfer(Current_Path & "ReviewList.asp")
		End If
	end if
	Session("ThisProductCode")	= 	product_code
	
	If instr(Requested_Page,"/&rec=") > 0 Then
		Requested_Page =  Replace(Requested_Page,"/&rec=","/?rec=")
		Response.Redirect(Requested_Page)
	End If
	If instr(product_code,"&rec=") > 0 Then
		Requested_Page =  Replace(Requested_Page,"&rec=","/?rec=")
		Response.Redirect(Requested_Page)
	End If

	if product_code & "" = "" or IsNumeric(product_code) =  false then
        call PageNotFound()
    end if
	'  '16656
    call PROCESS_SEOLINK_PRODUCTDETAIL(product_code,productdetailSEO,fv_ColorID)
	If InStr(Requested_Page,"lifestyle/p/") > 0 Then
		Server.Transfer(Current_Path & "lifestyle/ProductDetails.asp")
	Else
		Server.Transfer(Current_Path & "ProductDetails.asp")
	End If	
End if
'33296
If InStr(Requested_Page,"/signin.asp") > 0 Then
	Session("SessionPage") = "signin"
	Server.Transfer(Current_Path & "placeorder.asp")
End If
If InStr(Requested_Page,"/signin_TFD_35532_AfterPay.asp") > 0 Then
	Session("SessionPage") = "signin"
	Server.Transfer(Current_Path & "placeorder_TFD_35532_AfterPay.asp")
End If

'========================================
' Display the REAL error
'========================================
Set ASPErr = Server.GetLastError()

If ASPErr.Description <> "" Then
%>

	<%
		If AppUtils_IsWhiteListedIP() Then
			Dim errormsg
			errormsg = "<li>"
			errormsg = errormsg & "<div class=""so_error_view_more"">"			
			errormsg = errormsg & "Click here to view <b>Advanced Error Details</b><label></label>"
			errormsg = errormsg & "</div>"
			errormsg = errormsg & "<div class=""clear""></div>"
			errormsg = errormsg & "<div id=""error"" style=""color:Red"">"
			errormsg = errormsg & "<b>Advanced Error Details:</b> <br><br>"
				
			errormsg = errormsg & "<b>From : Server " & Request.ServerVariables("LOCAL_ADDR") & "</b> at " & Now() & "<br><br>"			
			errormsg = errormsg & Server.HTMLEncode(ASPErr.Category) & " error '" & Server.HTMLEncode(ASPErr.ASPCode) & Server.HTMLEncode(LCase(Hex(ASPErr.Number))) & "'<br><br>"
			errormsg = errormsg & Server.HTMLEncode(ASPErr.Description) & "<br><br>"
			errormsg = errormsg & Server.HTMLEncode(ASPErr.File) & ", line " & Server.HTMLEncode(ASPErr.Line) & "<br>"
			errormsg = errormsg & "</div>"
			errormsg = errormsg & "</li>"
			Session("ErrorMsg") = errormsg	
			
			
		End If		
		'An move to here
		Call AddTo500Log()	
		Response.Redirect("/ErrorPage.asp")
		'Server.Transfer("/ErrorPage.asp")
	%>	
<%
	'Log this event...PHUOC DISABLE HERE
	'Call AddTo500Log()	
'========================================
' Display a 404
'========================================
Else
	'Log this event...PHUOC DISABLE HERE
	AddTo404Log(Requested_File)

	'Redirect to root od domain...
	If InStr(Requested_File,"blank.html") > 0 Then
		'We DO NOT want to redirect if the missing file was "blank.html" because our milonic javascript popout menu
		'uses this page (which doesn't exist) within itself for an unknown reason, and this will cause
		'the page to refresh the browser unlimited times due to this... Which crashes the browser.
	Else
		'If Request.ServerVariables("REMOTE_HOST") <> "210.245.33.185" Then
			'Response.Redirect("/")
			'Response.Redirect("/404.asp")
			'Server.Transfer(Current_Path & "404.asp")
			
			Dim FileContents 'As String
			Dim m_sfo, objFile
			
			Set m_sfo = Server.CreateObject("Scripting.FileSystemObject")
			Set objFile = m_sfo.OpenTextFile(Server.MapPath("/404.htm"), 1)
			If NOT objFile.AtEndOfStream Then
				FileContents = objFile.ReadAll()
			End If
			objFile.Close
			Set objFile = Nothing
			Set m_sfo = Nothing
			if FileContents <> "" Then
				Response.Status = "404 Not Found"
				Response.AddHeader "Location", "PageNotFound"
				Response.Write(FileContents)
				Response.End()		
			Else
				Response.Redirect("http://www.swimoutlet.com/404.htm")
			End If		
		'End If
	End If

	'Response.Status = "404 Not Found"
%>

	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
	<HTML><HEAD><TITLE>The page cannot be found</TITLE>
	<META HTTP-EQUIV="Content-Type" Content="text/html; charset=Windows-1252">
	<STYLE type="text/css">
	  BODY { font: 8pt/12pt verdana }
	  H1 { font: 13pt/15pt verdana }
	  H2 { font: 8pt/12pt verdana }
	  A:link { color: red }
	  A:visited { color: maroon }
	</STYLE>
	</HEAD><BODY><TABLE width=500 border=0 cellspacing=10><TR><TD>
	
	<h1>The page cannot be found</h1>
	The page you are looking for might have been removed, had its name changed, 
	or is temporarily unavailable.
	<hr>
	<p>Please try the following:</p>
	<ul>
	<li>Make sure that the Web site address displayed in the address bar of your 
	browser is spelled and formatted correctly.</li>
	<li>If you reached this page by clicking a link, contact the Web site 
	administrator to alert them that the link is incorrectly formatted.                                                                                                                                                                                                         
	</li>
	
	<li>Click the <a href="javascript:history.back(1)">Back</a> button to try 
	another link.</li>
	</ul>
	<h2>HTTP Error 404 - File or directory not found.<br>Internet Information 
	Services (IIS)</h2>
	<hr>
	<p>Technical Information (for support personnel)</p>
	<ul>
	<li>Go to <a href="http://go.microsoft.com/fwlink/?linkid=8180">Microsoft 
	Product Support Services</a> and perform a title search for the words <b>
	HTTP</b> 
	and <b>404</b>.</li>
	<li>Open <b>IIS Help</b>, which is accessible in IIS Manager (inetmgr), and 
	search for topics titled <b>Web Site Setup</b>, <b>Common Administrative 
	Tasks</b>, and <b>About Custom Error Messages</b>.</li>
	</ul>
	
	</TD></TR></TABLE></BODY>
	</HTML>
<%
End If

'If Request.ServerVariables("REMOTE_HOST") = "210.245.33.185" Then
'	Response.End
'End If

' :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
' AddTo404Log() - Adds a line of text to the log file
' NOTE: Uses "Current_Path" variable form above
' :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Public Sub AddTo404Log_Backup(ByVal Text_Passed)

	Dim fso, ilogpath, filetxt, Where_When, iTEMP
	
	iTEMP = DatePart("M",date()) & Right(DatePart("YYYY",date()),2)
	If Len(iTEMP) = 3 Then
		iTEMP = "0" & iTEMP
	End If
	
	ilogpath = (Server.MapPath(Replace(Current_Path,"/","\") & "logs\404Log" & iTEMP & ".txt"))
	Set fso = CreateObject("Scripting.FileSystemObject")

	'Create the new log file for this month if necessary...
	If NOT fso.fileexists(ilogpath) Then
		fso.CreateTextFile(ilogpath)
	End If

	'Open the log file and write this new line...
	Set filetxt = fso.OpenTextFile(ilogpath, 8, True) 
	Where_When = Now() & "(:)" & Request.ServerVariables("SCRIPT_NAME") & "?" & Cstr(Request.Querystring()) & "(:)"
	filetxt.WriteLine(Where_When & Replace(Text_Passed,"(:)"," : ") & "(:)")
	filetxt.Close
	Set filetxt = Nothing
	Set fso = Nothing

End Sub



Public Sub AddTo404Log(ByVal Text_Passed)	
	Dim  itxt
	Dim iBrowser, iIPAddress, iScriptName	, s_Referer, logCustomerId, cartIdClient
	
    On Error Resume Next
	'---------------------------------------
	cartIdClient = Replace(Replace(Request.Cookies("www.swi/CartID"),"'","")," ","")
	iBrowser    = Request.ServerVariables("HTTP_USER_AGENT")
	'iIPAddress  = Request.ServerVariables("REMOTE_HOST")	
	iIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
	If iIPAddress = "" Then
	  iIPAddress = Request.ServerVariables("REMOTE_ADDR")
	Else
		If InStr(iIPAddress,",") > 0 Then
			iIPAddress = Split(iIPAddress,",")(0)
		End If
	End If
	iScriptName = replace(Requested_Page,":80","")
	s_Referer = Request.ServerVariables ("HTTP_REFERER")
	If Request.Cookies("www.swi/CustomerID") & "" <> "" then
		logCustomerId = Request.Cookies("www.swi/CustomerID")
	else
		logCustomerId = 0
	end if
	'---------------------------------------    
    If Instr(LCASE(iScriptName),"akamai/test-object.html")<=0 and Instr(LCASE(iScriptName),".gif")<=0 and  Instr(LCASE(iScriptName),".jpg")<=0 and Instr(LCASE(iScriptName),".png")<=0 and Instr(LCASE(iScriptName),".png")<=0 and Instr(LCASE(iScriptName),".css")<=0 and Instr(LCASE(iScriptName),".js")<=0 and Instr(LCASE(iScriptName),".ico")<=0   Then
	    '========================================================================
	    ' Grab the important error details...
	    '========================================================================
	    itxt = "Error: can not found page"
	    '========================================================================	    
            
        Set m_conn = Server.CreateObject("ADODB.Connection")
	    'm_conn.Open Config_ConnectionString	
		m_conn.Open Config_ConnectionStringServer16Extended	

        iBrowser=Replace(iBrowser,"'","''")
        iScriptName=Replace(iScriptName,"'","''")
        itxt=Replace(itxt,"'","''")
	   m_sql = "INSERT INTO AQT_ERROR_LOG(t_Timestamp, s_Machine, s_Program, s_Url,s_Error,s_OtherInfo,t_CreatedDate,s_Status, l_CustomerId, s_FromSite, s_FromServer, s_Referer) VALUES "
	    m_sql = m_sql & "(" &"'" & now()  & "'" & "," & "'" & iIPAddress  & "'" & "," & "'" & iBrowser & "'" & "," & "'" & iScriptName & "'" & "," & "'" & itxt & "'" & "," & "'" & cartIdClient & "'" & "," & "'" & now() & "'" & "," & "'" & "NEW" & "'"  & "," & logCustomerId & ",'SOREDESIGN','SERVER " & Request.ServerVariables("LOCAL_ADDR") & "','" & s_Referer & "')"		
	    m_conn.Execute(m_sql)
	    m_conn.Close()
	    Set m_conn = Nothing				    
	End If 
	On Error GoTo 0	
End Sub


' :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
' AddTo500Log() - Adds a line of text to the log file
' NOTE: Uses "Current_Path" variable form above
' :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Sub AddTo500Log_Backup()

	Dim fso, ilogpath, filetxt, Where_When, iTEMP, itxt
	Dim iBrowser, iIPAddress, iScriptName

	iTEMP = DatePart("M",date()) & Right(DatePart("YYYY",date()),2)
	If Len(iTEMP) = 3 Then
		iTEMP = "0" & iTEMP
	End If

	ilogpath = (Server.MapPath("logs\500Log" & iTEMP & ".txt"))
	Set fso = CreateObject("Scripting.FileSystemObject")

	'Create the new log file for this month if necessary...
	If NOT fso.fileexists(ilogpath) Then
		'Response.Write("PH" & ilogpath)
		fso.CreateTextFile(ilogpath)
	End If

	'---------------------------------------
	iBrowser    = Request.ServerVariables("HTTP_USER_AGENT")
	iIPAddress  = Request.ServerVariables("REMOTE_HOST")
	iScriptName = Request.ServerVariables("SCRIPT_NAME")
	'---------------------------------------

	'========================================================================
	' Grab the important error details...
	'========================================================================
	itxt = (AspErr.Category) & " error '" & (AspErr.ASPCode & LCase(Hex(ASPErr.Number))) & "' "
	itxt = itxt & (AspErr.Description) & " " & AspErr.File & ", line " & (AspErr.Line)
	'========================================================================

	'Open the log file and write this new line...
	Set filetxt = fso.OpenTextFile(ilogpath, 8, True) 
	Where_When = Now() & "(:)" & iIPAddress & "(:)" & iBrowser & "(:)" & iScriptName & "?" & Cstr(Request.Querystring()) & "(:)"
	filetxt.WriteLine(Where_When & Replace(itxt,"(:)"," : ") & "(:)")
	filetxt.Close
	Set filetxt = Nothing
	Set fso = Nothing

End Sub


' :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
' AddTo500Log() - Adds a line of text to the log file
' NOTE: Uses "Current_Path" variable form above
' :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Sub AddTo500Log()    
	'Dim fso, ilogpath, filetxt, Where_When, iTEMP, itxt
	Dim  itxt
	Dim iBrowser, iIPAddress, iScriptName, s_Referer, logCustomerId, cartIdClient
    
    On Error Resume Next
	'---------------------------------------
	cartIdClient = Replace(Replace(Request.Cookies("www.swi/CartID"),"'","")," ","")
	iBrowser    = Request.ServerVariables("HTTP_USER_AGENT")
	'iIPAddress  = Request.ServerVariables("REMOTE_HOST")
	iIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
	If iIPAddress = "" Then
	  iIPAddress = Request.ServerVariables("REMOTE_ADDR")
	Else
		If InStr(iIPAddress,",") > 0 Then
			iIPAddress = Split(iIPAddress,",")(0)
		End If
	End If
	iScriptName =  GetFullCurrentPath()
	
	s_Referer = Request.ServerVariables ("HTTP_REFERER")
	If Request.Cookies("www.swi/CustomerID") & "" <> "" then
		logCustomerId = Request.Cookies("www.swi/CustomerID")
	else
		logCustomerId = 0
	end if
	'---------------------------------------

	'========================================================================
	' Grab the important error details...
	'========================================================================
	itxt = (AspErr.Category) & " error '" & (AspErr.ASPCode & LCase(Hex(ASPErr.Number))) & "' "
	itxt = itxt & (AspErr.Description) & " " & AspErr.File & ", line " & (AspErr.Line)
	'========================================================================

	'Open the log file and write this new line...
	'Set filetxt = fso.OpenTextFile(ilogpath, 8, True) 
	'Where_When = Now() & "(:)" & iIPAddress & "(:)" & iBrowser & "(:)" & iScriptName & "?" & Cstr(Request.Querystring()) & "(:)"
	'filetxt.WriteLine(Where_When & Replace(itxt,"(:)"," : ") & "(:)")
	'filetxt.Close
	'Set filetxt = Nothing
	'Set fso = Nothing
    
    'Ruud updated here to insert error to db        
    Set m_conn = Server.CreateObject("ADODB.Connection")
	'm_conn.Open Config_ConnectionString	
	m_conn.Open Config_ConnectionStringServer16Extended

    iBrowser=Replace(iBrowser,"'","''")
    iScriptName=Replace(iScriptName,"'","''")
    itxt=Replace(itxt,"'","''")
	m_sql = "INSERT INTO AQT_ERROR_LOG(t_Timestamp, s_Machine, s_Program, s_Url,s_Error,s_OtherInfo,t_CreatedDate,s_Status, l_CustomerId, s_FromSite, s_FromServer, s_Referer) VALUES "
	m_sql = m_sql & "(" &"'" & now()  & "'" & "," & "'" & iIPAddress  & "'" & "," & "'" & iBrowser & "'" & "," & "'" & iScriptName & "'" & "," & "'" & itxt & "'" & "," & "'" & cartIdClient & "'" & "," & "'" & now() & "'" & "," & "'" & "NEW" & "'"  & "," & logCustomerId & ",'SOREDESIGN','SERVER " & Request.ServerVariables("LOCAL_ADDR") & "','" & s_Referer & "')"		
	
	'An add send email when having error
	Call SendEmailWhenError(iIPAddress, iScriptName, itxt)
	
	m_conn.Execute(m_sql)
	m_conn.Close()
	Set m_conn = Nothing
    'Ruud end updated
	On Error GoTo 0	
	
End Sub

Function GetFullCurrentPath()
	 GetFullCurrentPath = "www.swimoutlet.com" & Request.ServerVariables("HTTP_URL") 
End function
Function GetFullCurrentPath404()    
	 GetFullCurrentPath = Request.ServerVariables("HTTP_URL")
End function
Function URLDecode(sConvert)
    Dim aSplit
    Dim sOutput
    Dim I
    If IsNull(sConvert) OR sConvert&"" = "" Then
       URLDecode = ""
       Exit Function
    End If

    ' convert all pluses to spaces
    sOutput = REPLACE(sConvert, "+", " ")

    ' next convert %hexdigits to the character
    aSplit = Split(sOutput, "%")

    If IsArray(aSplit) Then
      sOutput = aSplit(0)
      For I = 0 to UBound(aSplit) - 1
        sOutput = sOutput & _
          Chr("&H" & Left(aSplit(i + 1), 2)) &_
          Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
      Next
    End If

    URLDecode = sOutput
End Function
Function FuncGetUrlParameter(ByVal name, ByVal query)
	Dim val, idx
	name = LCase(name & "")
	If query & "" = "" Then query = Request.QueryString() End If
	If Instr(query, "://") <> 0 Then
		idx = Instr(query, "?")
		query = Mid(query, idx + 1, Len(query) - idx)
		If idx = 0 Then query = "" End If
	End If
	Dim arr1 : arr1 = Split(query, "&")
	For idx = LBound(arr1) To UBound(arr1)
		Dim arr2 : arr2 = Split(arr1(idx), "=")
		If LCase(arr2(0)) = name And UBound(arr2) > 0 Then
			If val & "" <> "" Then val = val & "," End If
			val = val & arr2(1)
		End If
	Next
	FuncGetUrlParameter = URLDecode(val)
End Function


%>