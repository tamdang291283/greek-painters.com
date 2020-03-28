<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->
<!-- #include file="../timezone.asp" -->


<%


Set objCon2 = Server.CreateObject("ADODB.Connection")
    objCon2.Open sConnStringcms

 dim splitarray :  splitarray=split(request("recordsarray[]"),",")
 dim pid  : pid = Request("pid")
 dim resid : resid = Request("resid")

 Dim itable : itable =  Request("table")
 Select case itable 
    case "mi" 
             for i=0 to ubound(splitarray)
                objCon2.execute("Update menuitems set i_displaysort=" & (i+1) & " where id=" & splitarray(i) & " and  IdMenuCategory=" & pid & " and IdBusinessDetail = "  & resid )    
            next   
    case "mip" 
              for i=0 to ubound(splitarray)
                'Response.Write("Update menuitemproperties set i_displaysort=" & (i+1) & " where id=" & splitarray(i) & " and  IdMenuItem=" & pid & " and IdBusinessDetail = "  & resid & " <br/> ")
                objCon2.execute("Update menuitemproperties set i_displaysort=" & (i+1) & " where id=" & splitarray(i) & " and  IdMenuItem=" & pid  )    
            next   
    case "tp" 
              for i=0 to ubound(splitarray)
                objCon2.execute("Update Menutoppingsgroups set i_displaysort=" & (i+1) & " where id=" & splitarray(i) & " and  IdBusinessDetail = "  & resid )    
            next   
      case "dp" 
              for i=0 to ubound(splitarray)
                objCon2.execute("Update MenuDishpropertiesGroups set i_displaysort=" & (i+1) & " where id=" & splitarray(i) & " and  IdBusinessDetail = "  & resid )    
            next   
     case "dpi" 
              for i=0 to ubound(splitarray)
                objCon2.execute("Update MenuDishproperties set i_displaysort=" & (i+1) & " where id=" & splitarray(i) & " and dishpropertygroupid=" &pid& "  and  IdBusinessDetail = "  & resid )    

             
            next 
     case "topping" 
              for i=0 to ubound(splitarray)
              
                 objCon2.execute("Update menutoppings set i_displaysort=" & (i+1) & " where id=" & splitarray(i) & " and toppinggroupid =" &pid& "  and  IdBusinessDetail = "  & resid )    
            next 
     
    case else
        for i=0 to ubound(splitarray)        
             
             objCon2.execute("Update menucategories set displayorder =" & (i+1) & " where id=" & splitarray(i)  )    
        next   
 end select  

objCon2.Close



%>Saved!