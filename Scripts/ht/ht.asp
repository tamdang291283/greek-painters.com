<%
    StartTime = Timer()

Dim urlRequest
urlRequest = "https://so803w35w2-dsn.algolia.net/1/indexes/SO/query"
Dim data 
    data ="{""params"": ""query=swim,page=0,hitsPerPage=60""}"
 Function SendAlgoliaRequest(byval p_url, byval p_timout, byval Method, byval data)
    Dim xhr: Set xhr = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xhr.setTimeouts 10000, 10000, 20000, p_timout   
    
    Dim AlgoliaAPIKey, AlgoliaApplicationId
    AlgoliaAPIKey = "b1c6e8be7d8cc15ed3229cdc5c945a1b"
    AlgoliaApplicationId = "SO803W35W2"

    xhr.Open Method, p_url, False
    xhr.setRequestHeader "X-Algolia-API-Key", AlgoliaAPIKey
    xhr.setRequestHeader "X-Algolia-Application-Id", AlgoliaApplicationId
	xhr.send data
	
    If xhr.status = 200 Then		
        SendAlgoliaRequest = xhr.responseText		
        Set xhr = Nothing
    Else
	  Set xhr = Nothing		
        SendAlgoliaRequest = ""
    End If
End Function
 %>
   <script language="JScript" runat="server" src='json2.js'></script>

<%


Dim myJSON
myJSON =  SendAlgoliaRequest(urlRequest, 60000,"POST",data)
Set myJSON = JSON.parse(myJSON)  
Response.Write(myJSON.hits.length)          
EndTime = Timer()
Response.Write("<br />Seconds to 2 decimal places: " & FormatNumber(EndTime - StartTime, 2))
'Dim products
'set products = myJSON.hits
'For each p in products

'        Response.Write("<br /> Name:" & p.name )
'Next 

%>
    