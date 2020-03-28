<div class="row clearfix">
		<div class="col-md-12 column">
			<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
				<div class="navbar-header">
				
				
				
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="#"><%=Session("MM_Business")%></a>
				</div>
				
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav" style="">
        
       
   
   <li> 
	<a data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-th-list"></span> Sales Dashboard</a>
  <ul class="dropdown-menu " role="menu" aria-labelledby="dLabel">
  

  
  <li><a  href="#"><strong>General Dashboards</strong></a></li>
   
      <li><a href="../../cms/dashboards/today.asp">Orders Today</a></li>
    <li>
      <a href="../../cms/dashboards/outstanding-without-acknowledgement.asp">Orders - Next to go Out</a>
    </li>
    
    <li><a href="../../cms/dashboards/history.asp">Orders history - Combined</a></li>
      <li><a href="../../cms/dashboards/history_v2.asp">Orders history</a></li>
     <li><a href="../../cms/dashboards/history_v2_cancellation.asp">Orders history - Cancelled</a></li>
        <li><a href="../../cms/dashboards/order_booking.asp">Table Booking</a></li>
    <li>
      <a href="#"><strong> NorthAmerican Dashboards</strong></a>
      <li><a href="../../cms/NorthAmerican-Dashboards/history_taxtip.asp">History</a></li>
     <li><a href="../../cms/NorthAmerican-Dashboards/history_taxtip_Edit.asp">History Edit</a></li>
    </li>
    <li>
      <a href="#">
        <strong>In-Store Orders</strong>
      </a>
    </li>
    <li>
      <a href="../../cms/dashboards/today_local.asp" >Orders Today</a>
      <li>
        <a href="../../cms/dashboards/history_v2_local.asp">Orders history</a>
      </li>
    </li>

    <li>
      <a href="../../cms/dashboards/raworderreport.asp">
        <strong>Raw Order Report</strong>
      </a>
    </li>

  </ul>
     
	</li>
   
   <li> 
	<a data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-stats"></span> Reports</a>
  <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
   <li><a href="../../cms/reports/reports_without_acknowledge.asp" >Report</a></li>
    <li>
      <a href="../../cms/reports/reports_local.asp" >In-Store Report</a>
    </li>
    <li>
      <a href="../../cms/reports/customerlist.asp" >Customer Lists</a>
    </li>
 <li><a href="../../cms/reports/customerexport.asp" >Customer Download</a></li>
    <li>
      <a href="../../cms/reports/SMSEMailMarketing.asp" >SMS/Email Marketing</a>
    </li>
    <li>
      <a href="../../cms/reports/OrderReport.asp" >Orders Map</a>
    </li>
    <li>
      <a href="../../cms/reports/OrderMonthlyReport.asp" >Monthly Orders</a>
    </li>
    <li>
      <a href="../../cms/reports/OrderWeeklyReport.asp" >Weekly Orders</a>
    </li>
    
    <li>
      <a href="#">
        <strong>Acknowledgement Required</strong>
      </a>
    </li>


    <li>
      <a href="../../cms/reports/reports.asp" >Report</a>
    </li>
    
  </ul>
	</li>
   
				
   
     
	   <li><a href="../../cms/opening-times/openingtimes.asp" ><span class="glyphicon glyphicon-dashboard"></span> Opening Times</a></li>
    <li> 
	<a data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-folder-open"></span> Menu Manager</a>
  <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
   <li><a href="../../cms/menu-manager/menu.asp" >Main menu</a></li>
 <li><a href="../../cms/menu-manager/toppingsgroup.asp" >Toppings</a></li>
  <li><a href="../../cms/menu-manager/dishproperties.asp" >Dish properties</a></li>
  <li><a href="../../cms/menu-manager/vouchers.asp" >Voucher Codes</a></li>
    <li><a href="../../cms/menu-manager/allergens.asp" >Allergen</a></li>
    <li>
      <a href="../../cms/menu-manager/healthcheck.asp?ID=<%=Session("MM_id")%>" >Health Check</a>
    </li>
    <!--<li><a href="../vouchercodegenerator/index.asp" target="blank" >Voucher Code Generator</a></li>-->
  </ul>
	</li>
          
	 <li>  <a data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-wrench"></span> System Settings</a>
	 <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
	 <li><a href="../../cms/system-settings/restaurant.asp" >Edit Restaurant Info</a></li>
   <li><a href="../../cms/system-settings/announcement.asp" >Edit Announcements</a></li>
   <li><a href="../../cms/system-settings/deliveryinfo.asp" >Edit Delivery/Collection Info</a></li>
 <li><a href="../../cms/system-settings/settings.asp" >Settings</a></li>
     <li><a href="../../cms/system-settings/changepassword.asp" >User Profile</a></li>
     <li><a href="../../cms/system-settings/Setting_North_America_Extend.asp" >North American settings</a></li>
 <li><a href="../../cms/system-settings/css.asp" >Custom CSS</a></li>
     <li>
       <a href="../../cms/system-settings/DBTasks.asp" >Database functions</a>
     </li>
  </ul>
	 
	 </li>
          <!--<li>
            <a href="../../cms/Url-Rewrite" >
              <span class="glyphicon "></span> URL Rewrite
            </a>
          </li>-->
          
          
          <li>
            <a data-toggle="dropdown" href="#">
              <span class="glyphicon glyphicon-folder-open" style="margin-right:8px;"></span>Close Business
            </a>
            <ul  class="dropdown-menu" role="menu" aria-labelledby="dLabel">     
  <%
                        dim objCon1,objRds1
                        dim s_ID : s_ID =Session("MM_id")
                        if s_ID & "" = "" then
                        s_ID = 0
                        end if
                        Set objCon1 = Server.CreateObject("ADODB.Connection")
                        objCon1.Open sConnStringcms
                        Set objRds1 = Server.CreateObject("ADODB.Recordset")
                        objRds1.Open "SELECT * FROM BusinessDetails where id=" & s_ID, objCon1

    %>
              <% if not objRds1.eof then %>
              <%if objRds1("businessclosed")=1 then%>
							 <li><a href="../../cms/exe.asp?action=close" > Open Permanently
               </a></li>
							<%else%>
							 <li><a href="../../cms/exe.asp?action=open"  onclick="return confirm('Are you sure you want to close your business?')"> Close Permanently</a></li>
							<%end if
                  objRds1.close()
                  set objCon1 = nothing
                %>
                <%else%>
                  <li>
                    <a href="../../cms/exe.asp?action=close" >
                      Open Permanently
                      <%end if %>
                </li>
                <li>
                  <a href="../../cms/system-settings/Planned-Closure.asp">Planned Closure</a>
                </li>
                  </ul>
 <li><a href="../../cms/logout.asp" ><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                <li>
                  <a href="<%=SITE_URL%>" >v.7.24</a>
                </li>

   </ul>
					
					
				</div>
				
			</nav>
			
		</div>
	</div>