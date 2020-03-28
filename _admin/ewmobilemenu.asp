<!-- Begin Main Menu -->
<%
RootMenu.Id = "MobileMenu"
%>
<%

' Get Menu Text
Function GetMenuText(Id, Text)
	GetMenuText = Language.MenuPhrase(Id, "MenuText")
	If GetMenuText = "" Then GetMenuText = Text
End Function
%>
<%

' Generate all menu items
RootMenu.IsRoot = True
RootMenu.AddMenuItem 1, "mmi_BusinessDetails", GetMenuText("1", "Business Details"), "BusinessDetailslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 2, "mmi_Category_Openning_Time", GetMenuText("2", "Category Openning Time"), "Category_Openning_Timelist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 3, "mmi_Customer_Book_Table", GetMenuText("3", "Customer Book Table"), "Customer_Book_Tablelist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 4, "mmi_MenuCategories", GetMenuText("4", "Menu Categories"), "MenuCategorieslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 5, "mmi_MenuDishproperties", GetMenuText("5", "Menu Dishproperties"), "MenuDishpropertieslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 6, "mmi_MenuDishpropertiesGroups", GetMenuText("6", "Menu Dishproperties Groups"), "MenuDishpropertiesGroupslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 7, "mmi_MenuItemProperties", GetMenuText("7", "Menu Item Properties"), "MenuItemPropertieslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 8, "mmi_MenuItems", GetMenuText("8", "Menu Items"), "MenuItemslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 9, "mmi_MenuToppings", GetMenuText("9", "Menu Toppings"), "MenuToppingslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 10, "mmi_Menutoppingsgroups", GetMenuText("10", "Menutoppingsgroups"), "Menutoppingsgroupslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 11, "mmi_OpeningTimes", GetMenuText("11", "Opening Times"), "OpeningTimeslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 12, "mmi_Order_Receipt_tracking", GetMenuText("12", "Order Receipt tracking"), "Order_Receipt_trackinglist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 13, "mmi_OrderItems", GetMenuText("13", "Order Items"), "OrderItemslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 14, "mmi_OrderItemsLocal", GetMenuText("14", "Order Items Local"), "OrderItemsLocallist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 15, "mmi_Orders", GetMenuText("15", "Orders"), "Orderslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 16, "mmi_OrdersLocal", GetMenuText("16", "Orders Local"), "OrdersLocallist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 17, "mmi_SMSEmailQueue", GetMenuText("17", "SMSEmail Queue"), "SMSEmailQueuelist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 18, "mmi_timezones", GetMenuText("18", "timezones"), "timezoneslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 19, "mmi_URL_REWRITE", GetMenuText("19", "URL REWRITE"), "URL_REWRITElist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 20, "mmi_vouchercodes", GetMenuText("20", "vouchercodes"), "vouchercodeslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 21, "mmi_VIEW_Paid_Orders", GetMenuText("21", "VIEW Paid Orders"), "VIEW_Paid_Orderslist.asp", -1, "", "", True, False, False
RootMenu.AddMenuItem 22, "mmi_View_Paid_OrdersLocal", GetMenuText("22", "View Paid Orders Local"), "View_Paid_OrdersLocallist.asp", -1, "", "", True, False, False
RootMenu.Render(False)
Set RootMenu = Nothing
%>
<!-- End Main Menu -->
