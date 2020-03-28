<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../../Config.asp" -->

<%Server.ScriptTimeout=86400%>

<%


    Set objCon = Server.CreateObject("ADODB.Connection")
        objCon.Open sConnStringcms
    Dim RestaurantID : RestaurantID =  Request.QueryString("ID")
    
    Dim Number_Menu_Printing : Number_Menu_Printing = 0
    Dim Number_topping_group : Number_topping_group = 0
    Dim Number_topping : Number_topping = 0
    Dim Number_dishproperty_group : Number_dishproperty_group = 0
    Dim Number_dishproperty : Number_dishproperty = 0
    Dim Number_Menu_SubItem : Number_Menu_SubItem = 0

    Dim Menu_Printing : Menu_Printing = ""
    Dim topping_group : topping_group = ""
    Dim topping : topping = ""
    Dim dishproperty_group : dishproperty_group = ""
    Dim dishproperty : dishproperty = ""
    Dim SubItem : SubItem = ""

    Dim rs_menu : set rs_menu = Server.CreateObject("ADODB.Recordset")
    Dim rs_topping_group : set rs_topping_group = Server.CreateObject("ADODB.Recordset")
    Dim rs_topping : set rs_topping = Server.CreateObject("ADODB.Recordset")
    Dim rs_dishproperty_group : set rs_dishproperty_group = Server.CreateObject("ADODB.Recordset")
    Dim rs_dishproperty : set rs_dishproperty = Server.CreateObject("ADODB.Recordset")
    Dim rs_sub_menuitem : set rs_sub_menuitem  = Server.CreateObject("ADODB.Recordset")
    
    Dim SQL : SQL = ""
    dim Where : Where = ""
    if RestaurantID & "" <> "" then
       Where = " and [table].ID = " &  RestaurantID
    end if
    'SQL = "select COUNT(ID) as number from MenuItems with(nolock) where isnull(PrintingName,'') = '' " & Where 
    SQL= " select COUNT(a.ID) as number from MenuItemProperties a with(nolock) join menuitems m on a.IdMenuItem = m.Id join BusinessDetails b with(nolock) on m.IdBusinessDetail = b.ID  where isnull(a.PrintingName,'') = '' " & Replace( Where,"[table]","b")
   
    rs_sub_menuitem.Open SQL , objCon
    if not rs_sub_menuitem.EOF then
        Number_Menu_SubItem = rs_sub_menuitem("number")
    end if
        rs_sub_menuitem.close()
    set rs_sub_menuitem = nothing

    SQL =  " select COUNT(m.ID) as number  "
    SQL = SQL & " from MenuItems m with(nolock) "
    SQL = SQL & " join  menucategories mc with(nolock) on m.IdMenuCategory = mc.ID "
    SQL = SQL & " join BusinessDetails bd with(nolock) on mc.IdBusinessDetail = bd.ID "
    SQL = SQL & " where isnull(m.PrintingName,'') = '' " & Replace( Where,"[table]","bd")

    rs_menu.Open SQL , objCon
    if not rs_menu.EOF then
        Number_Menu_Printing = rs_menu("number")
    end if
        rs_menu.close()
    set rs_menu = nothing

    SQL = "select COUNT(ID) as number from Menutoppingsgroups with(nolock) where isnull(PrintingName,'') = '' " & Replace( Where,"[table]","Menutoppingsgroups") 
    rs_topping_group.Open SQL , objCon
    if not rs_topping_group.EOF then
        Number_topping_group = rs_topping_group("number")
    end if
        rs_topping_group.close()
    set rs_topping_group = nothing

    'SQL = "select COUNT(ID) as number from MenuToppings with(nolock) where isnull(PrintingName,'') = '' " & Where 
    SQL = " select COUNT( distinct m.ID ) as number "
    SQL = SQL & " from MenuToppings m with(nolock) join Menutoppingsgroups tg with(nolock)  "
    SQL = SQL & " on m.toppinggroupid =  tg.ID  "
    SQL = SQL & "  join BusinessDetails b with(nolock) on tg.IdBusinessDetail = b.id   "
    SQL = SQL & "  where isnull(m.PrintingName,'') = '' " & Replace( Where,"[table]","b")

    rs_topping.Open SQL , objCon
    if not rs_topping.EOF then
        Number_topping = rs_topping("number")
    end if
        rs_topping.close()
    set rs_topping = nothing

    ' SQL = "select COUNT(a.ID) as number from MenuDishproperties a with(nolock)   where isnull(a.PrintingName,'') = ''  " & Where 
     SQL =" select COUNT(distinct b.ID) as number"
    SQL  = SQL & " from MenuDishproperties b with(nolock)  "
    SQL  = SQL & " join MenuDishpropertiesGroups mdg with(nolock) on b.dishpropertygroupid = mdg.ID "
    SQL  = SQL & " join BusinessDetails c with(nolock) on mdg.IdBusinessDetail = c.id  where isnull(b.PrintingName,'') = '' " & Replace( Where,"[table]","c")

    rs_dishproperty.Open SQL , objCon
    if not rs_dishproperty.EOF then
        Number_dishproperty = rs_dishproperty("number")
    end if
        rs_dishproperty.close()
    set rs_dishproperty = nothing

    SQL = "select COUNT(ID) as number from MenuDishpropertiesGroups with(nolock) where isnull(PrintingName,'') = '' " & Replace( Where,"[table]","MenuDishpropertiesGroups") 
    rs_dishproperty_group.Open SQL , objCon
    if not rs_dishproperty_group.EOF then
        Number_dishproperty_group = rs_dishproperty_group("number")
    end if
        rs_dishproperty_group.close()
    set rs_dishproperty_group = nothing

    if Number_Menu_Printing = 0 then
        Menu_Printing = "OK"
    else  
        Menu_Printing = "Problems found (<span onclick=""Open('menu');"" style=""cursor:pointer;"">" & Number_Menu_Printing & "<span>)" 
    end if

    if Number_topping_group = 0 then
        topping_group = "OK"
    else  
        topping_group = "Problems found (<span onclick=""Open('topping_group');""  style=""cursor:pointer;"">" & Number_topping_group & "<span>)" 
    end if

    if Number_topping = 0 then
        topping = "OK"
    else  
        topping = "Problems found (<span onclick=""Open('topping');""  style=""cursor:pointer;"">" & Number_topping & "<span>)" 
    end if


     if Number_dishproperty_group = 0 then
        dishproperty_group = "OK"
    else  
        dishproperty_group = "Problems found (<span onclick=""Open('dishproperty_group');"" style=""cursor:pointer;"">" & Number_dishproperty_group & "<span>)" 
    end if

    if Number_dishproperty = 0 then
        dishproperty = "OK"
    else  
        dishproperty = "Problems found (<span onclick=""Open('dishproperty');"" style=""cursor:pointer;"">" & Number_dishproperty & "<span>)" 
    end if

     if Number_Menu_SubItem = 0 then
        SubItem = "OK"
    else  
        SubItem = "Problems found (<span onclick=""Open('subitem');"" style=""cursor:pointer;"">" & Number_Menu_SubItem & "<span>)" 
    end if
     
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Management Area</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="js/less-1.3.3.min.js"></script-->
	<!--append â€˜#!watchâ€™ to the browser URL, then refresh the page. -->
	
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
   <% If FAVICONURL & "" <> "" Then %> <link rel='shortcut icon' href='<%=FAVICONURL %>' type='image/x-icon'/ > <% end If %>
  
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<script type="text/javascript" src="../js/scripts.js"></script>
</head>

<body>
<div class="container">
	 <!-- #Include file="../inc-header.inc"-->

<div class="row clearfix"></div>
		<div class="col-md-12 column">
		
		<ol class="breadcrumb">
            <li><a href="menu.asp">Main Menu</a></li>
              <li>Health Check</li>
            </ol>
			<H1>Health Check</H1>
		        <p>
                 <div class="row clearfix">                 
           	            <div class="col-md-3 column">    
                                <span class="form-check-label" for="exampleCheck1">Dishes' Printing Name:</span>
           	            </div>
                         <div class="col-md-3 column">
                               <span class="form-check-label" for="exampleCheck1"><%=Menu_Printing %></span>
                         </div>
                       <div class="col-md6 column"></div>
                 </div> 
			</p>
            <div id="menu" style="display:none;">
                <% Dim numberline : numberline  = 0  %>
                <% if Number_Menu_Printing > 0 then %>
                    <div class="row clearfix">
                        <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">No.</label>
           	            </div>
                        <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">ID</label>
           	            </div>
           	            <div class="col-md-5 column">    
                                <label class="form-check-label" for="exampleCheck1">Name</label>
           	            </div>
                         <div class="col-md-5 column">
                               <label class="form-check-label" for="exampleCheck1">Restaurant Name</label>
                         </div>
                       
                 </div> 
                <%
                    set rs_menu = Server.CreateObject("ADODB.Recordset")
                       ' SQL = " select m.ID,m.Name,PrintingName,b.name as storename  from MenuItems m with(nolock) join BusinessDetails b with(nolock) on m.IdBusinessDetail = b.id   where isnull(PrintingName,'') = '' " & Where
                        SQL =  " select m.ID,m.Name,PrintingName,b.name as storename   "
                        SQL = SQL & " from MenuItems m with(nolock) "
                        SQL = SQL & " join  menucategories mc with(nolock) on m.IdMenuCategory = mc.ID "
                        SQL = SQL & " join BusinessDetails b with(nolock) on mc.IdBusinessDetail = b.ID "
                        SQL = SQL & " where isnull(m.PrintingName,'') = '' " & Replace( Where,"[table]","b") 

                    rs_menu.Open SQL , objCon
                    while not rs_menu.EOF 
                        numberline =  numberline + 1
                        %>
                             <div class="row clearfix">
                                <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=numberline %></span>
           	                    </div>
                                <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("ID") %></span>
           	                    </div>
           	                    <div class="col-md-5 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("Name") %></span>
           	                    </div>
                                 <div class="col-md-5 column">
                                       <span class="form-check-label" for="exampleCheck1"><%=rs_menu("storename") %></span>
                                 </div>
                               
                         </div> 
                        <%
                            rs_menu.movenext
                    wend
                                rs_menu.close()
                            set rs_menu = nothing
                     %>

                <% end if %>
                <br />
            </div>
            
            

              <p>
                 <div class="row clearfix">                 
           	            <div class="col-md-3 column">    
                                <span class="form-check-label" for="exampleCheck1">Sub Menu Item Printing Name:</span>
           	            </div>
                         <div class="col-md-3 column">
                               <span class="form-check-label" for="exampleCheck1"><%=SubItem %></span>
                         </div>
                       <div class="col-md6 column"></div>
                 </div> 
			</p>
            <div id="subitem" style="display:none;">
                <% numberline  = 0  %>
                <% if Number_Menu_SubItem > 0 then %>
                    <div class="row clearfix">
                        <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">No.</label>
           	            </div>
                        <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">ID</label>
           	            </div>
           	            <div class="col-md-5 column">    
                                <label class="form-check-label" for="exampleCheck1">Name</label>
           	            </div>
                         <div class="col-md-5 column">
                               <label class="form-check-label" for="exampleCheck1">Restaurant Name</label>
                         </div>
                       
                 </div> 
                <%
                    set rs_sub_menuitem = Server.CreateObject("ADODB.Recordset")
                       
                        SQL =  " select a.ID,a.Name,a.PrintingName,b.name as storename   "
                        SQL = SQL & " from MenuItemProperties a with(nolock) join menuitems m on a.IdMenuItem = m.Id "                        
                        SQL = SQL & " join BusinessDetails b with(nolock) on m.IdBusinessDetail = b.ID "
                        SQL = SQL & " where isnull(a.PrintingName,'') = '' " & Replace( Where,"[table]","b") 

                    rs_sub_menuitem.Open SQL , objCon
                    while not rs_sub_menuitem.EOF 
                        numberline =  numberline + 1
                        %>
                             <div class="row clearfix">
                                <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=numberline %></span>
           	                    </div>
                                <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_sub_menuitem("ID") %></span>
           	                    </div>
           	                    <div class="col-md-5 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_sub_menuitem("Name") %></span>
           	                    </div>
                                 <div class="col-md-5 column">
                                       <span class="form-check-label" for="exampleCheck1"><%=rs_sub_menuitem("storename") %></span>
                                 </div>
                               
                         </div> 
                        <%
                            rs_sub_menuitem.movenext
                    wend
                                rs_sub_menuitem.close()
                            set rs_sub_menuitem = nothing
                     %>

                <% end if %>
                <br />
            </div>


              <p>
                 <div class="row clearfix">                 
           	            <div class="col-md-3 column">    
                                <span class="form-check-label" for="exampleCheck1">Topping Groups Printing Name:</span>
           	            </div>
                         <div class="col-md-3 column">
                               <span class="form-check-label" for="exampleCheck1"><%=topping_group %></span>
                         </div>
                       <div class="col-md6 column"></div>
                 </div> 
			</p>
            <div id="topping_group" style="display:none;">
                 <% if Number_topping_group > 0 then %>
                    <div class="row clearfix">
           	            <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">No.</label>
           	            </div>
                        <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">ID</label>
           	            </div>
           	            <div class="col-md-5 column">    
                                <label class="form-check-label" for="exampleCheck1">Name</label>
           	            </div>
                         <div class="col-md-5 column">
                               <label class="form-check-label" for="exampleCheck1">Restaurant Name</label>
                         </div>
                 </div> 
                <%
                    set rs_menu = Server.CreateObject("ADODB.Recordset")
                        SQL = "select m.ID,toppingsgroup,PrintingName,b.name from Menutoppingsgroups m with(nolock) join BusinessDetails b with(nolock) on m.IdBusinessDetail = b.id   where isnull(PrintingName,'') = '' " & Replace( Where,"[table]","b") 
                    rs_menu.Open SQL , objCon
                    numberline = 0
                    while not rs_menu.EOF 
                        numberline =  numberline  + 1
                        %>
                             <div class="row clearfix">
                                 <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=numberline %></span>
           	                    </div>
                                  <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("ID") %></span>
           	                    </div>
           	                    <div class="col-md-5 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("toppingsgroup") %></span>
           	                    </div>
                              <div class="col-md-5 column">
                                       <span class="form-check-label" for="exampleCheck1"><%=rs_menu("name") %></span>
                                 </div>
                               
                         </div> 
                        <%
                            rs_menu.movenext
                    wend
                                rs_menu.close()
                            set rs_menu = nothing
                     %>

                <% end if %>
                <br />
            </div>
            
            
              <p>
                 <div class="row clearfix">                 
           	            <div class="col-md-3 column">    
                                <span class="form-check-label" for="exampleCheck1">Toppings Printing Name:</span>
           	            </div>
                         <div class="col-md-3 column">
                               <span class="form-check-label" for="exampleCheck1"><%=topping %></span>
                         </div>
                       <div class="col-md6 column"></div>
                 </div> 
			</p>
            <div id="topping" style="display:none;">
                  <% if Number_topping > 0 then %>
                    <div class="row clearfix">
           	          <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">No.</label>
           	            </div>
                        <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">ID</label>
           	            </div>
           	            <div class="col-md-5 column">    
                                <label class="form-check-label" for="exampleCheck1">Name</label>
           	            </div>
                         <div class="col-md-5 column">
                               <label class="form-check-label" for="exampleCheck1">Restaurant Name</label>
                         </div>
                 </div> 
                <%
                    set rs_menu = Server.CreateObject("ADODB.Recordset")
                        'SQL = "select m.ID,topping,PrintingName,b.name from MenuToppings m with(nolock) join BusinessDetails b with(nolock) on m.IdBusinessDetail = b.id  where isnull(PrintingName,'') = '' " & Where
                       SQL = " select distinct m.ID,topping,m.PrintingName,b.name  "
                       SQL = SQL & " from MenuToppings m with(nolock) join Menutoppingsgroups tg with(nolock)  "
                       SQL = SQL & " on m.toppinggroupid =  tg.ID  "
                       SQL = SQL & "  join BusinessDetails b with(nolock) on tg.IdBusinessDetail = b.id   "
                       SQL = SQL & "  where isnull(m.PrintingName,'') = '' " & Replace( Where,"[table]","b") 

                    rs_menu.Open SQL , objCon
                    numberline = 0
                    while not rs_menu.EOF 
                        numberline  = numberline  + 1
                        %>
                             <div class="row clearfix">
                                 <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=numberline %></span>
           	                    </div>
                                  <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("ID") %></span>
           	                    </div>
           	                    <div class="col-md-5 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("topping") %></span>
           	                    </div>
                               <div class="col-md-5 column">
                                       <span class="form-check-label" for="exampleCheck1"><%=rs_menu("name") %></span>
                                 </div>
                               
                         </div> 
                        <%
                            rs_menu.movenext
                    wend
                                rs_menu.close()
                            set rs_menu = nothing
                     %>

                <% end if %>
                <br />
            </div>            
              <p>
                 <div class="row clearfix">                 
           	            <div class="col-md-3 column">    
                                <span class="form-check-label" for="exampleCheck1">Dish Property Groups Printing Name:</span>
           	            </div>
                         <div class="col-md-3 column">
                               <span class="form-check-label" for="exampleCheck1"><%=dishproperty_group %></span>
                         </div>
                       <div class="col-md6 column"></div>
                 </div> 
			</p>
            <div id="dishproperty_group" style="display:none;">
                   <% if Number_dishproperty_group > 0 then %>
                    <div class="row clearfix">
           	          <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">No.</label>
           	            </div>
                        <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">ID</label>
           	            </div>
           	            <div class="col-md-5 column">    
                                <label class="form-check-label" for="exampleCheck1">Name</label>
           	            </div>
                         <div class="col-md-5 column">
                               <label class="form-check-label" for="exampleCheck1">Restaurant Name</label>
                         </div>
                 </div> 
                <%
                    set rs_menu = Server.CreateObject("ADODB.Recordset")
                        SQL = "select m.ID,dishpropertygroup,PrintingName,b.name from MenuDishpropertiesGroups m with(nolock) join BusinessDetails b with(nolock) on m.IdBusinessDetail = b.id  where isnull(PrintingName,'') = '' " & Replace( Where,"[table]","b") 
                    rs_menu.Open SQL , objCon
                    numberline = 0
                    while not rs_menu.EOF 
                        numberline  = numberline +1
                        %>
                             <div class="row clearfix">
                                 <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=numberline %></span>
           	                    </div>
                                <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("ID") %></span>
           	                    </div>
           	                    <div class="col-md-5 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("dishpropertygroup") %></span>
           	                    </div>
                                <div class="col-md-5 column">
                                       <span class="form-check-label" for="exampleCheck1"><%=rs_menu("name") %></span>
                                 </div>
                               
                         </div> 
                        <%
                            rs_menu.movenext
                    wend
                                rs_menu.close()
                            set rs_menu = nothing
                     %>

                <% end if %>
                <br />
            </div>
            
              <p>
                 <div class="row clearfix">                 
           	            <div class="col-md-3 column">    
                                <span class="form-check-label" for="exampleCheck1">Dish Property Printing Name:</span>
           	            </div>
                         <div class="col-md-3 column">
                               <span class="form-check-label" for="exampleCheck1"><%=dishproperty %></span>
                         </div>
                       <div class="col-md6 column"></div>
                 </div> 
			</p>
            <div id="dishproperty" style="display:none;">
                  <% if Number_dishproperty > 0 then %>
                    <div class="row clearfix">
           	            <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">No.</label>
           	            </div>
                        <div class="col-md-1 column">    
                                <label class="form-check-label" for="exampleCheck1">ID</label>
           	            </div>
           	            <div class="col-md-5 column">    
                                <label class="form-check-label" for="exampleCheck1">Name</label>
           	            </div>
                         <div class="col-md-5 column">
                               <label class="form-check-label" for="exampleCheck1">Restaurant Name</label>
                         </div>
                 </div> 
                <%
                    set rs_menu = Server.CreateObject("ADODB.Recordset")
                       ' SQL = "select b.ID,dishproperty,PrintingName,c.name from MenuDishproperties b with(nolock)  join BusinessDetails c with(nolock) on b.IdBusinessDetail = c.id  where isnull(PrintingName,'') = '' " & Where
                        SQL =" select b.ID,dishproperty,b.PrintingName,c.name "
                        SQL  = SQL & " from MenuDishproperties b with(nolock)  "
                        SQL  = SQL & " join MenuDishpropertiesGroups mdg with(nolock) on b.dishpropertygroupid = mdg.ID "
                        SQL  = SQL & " join BusinessDetails c with(nolock) on mdg.IdBusinessDetail = c.id  where isnull(b.PrintingName,'') = '' " & Replace( Where,"[table]","c") 

                    rs_menu.Open SQL , objCon
                    numberline = 0
                    while not rs_menu.EOF 
                        numberline = numberline +1
                        %>
                             <div class="row clearfix">
                                 <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=numberline %></span>
           	                    </div>
                                  <div class="col-md-1 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("ID") %></span>
           	                    </div>
           	                    <div class="col-md-5 column">    
                                        <span class="form-check-label" for="exampleCheck1"><%=rs_menu("dishproperty") %></span>
           	                    </div>
                                 <div class="col-md-5 column">
                                       <span class="form-check-label" for="exampleCheck1"><%=rs_menu("name") %></span>
                                 </div>
                               
                         </div> 
                        <%
                            rs_menu.movenext
                    wend
                                rs_menu.close()
                            set rs_menu = nothing
                     %>

                <% end if %>
                <br />
            </div>
            
		</div>
</div>
    <% 
        objCon.close()
        set objCon = nothing 
    %>
<!-- Modal -->
  <script type="text/javascript">
      function Open(id)
      {
          if ($("#" + id).is(":visible"))
              $("#" + id).hide();
          else
              $("#" + id).show();
      }
  </script>
</body>
</html>
