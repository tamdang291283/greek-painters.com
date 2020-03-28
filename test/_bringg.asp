<%
set xmlhttp = CreateObject("MSXML2.ServerXMLHTTP") 
xmlhttp.open "POST", "https://admin-api.bringg.com/services/6f15901b/431d3a99-8a67-45f6-b6fd-dd612330a5c5/0e012556-4442-463c-b98d-8b56ccbbfa10/", false 
xmlhttp.setRequestHeader "Content-type","application/json"
xmlhttp.setRequestHeader "Accept","application/json"
xmlhttp.send "{""title"": ""Generic Title"", ""customer"": {""name"": ""Mr. Customer4"", ""company_id"": 9454, ""address"": ""1 Wall st, New York, NY"", ""phone"": ""0545674816""}}"
vAnswer = xmlhttp.responseText  
response.write vAnswer
%>