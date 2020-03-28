<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="../Config.asp" -->
 <script type="text/javascript" src="../Scripts/jquery.min.js"></script>
<script type="text/javascript" src="../Scripts/js.cookie.js"></script>
<%
    Session.Abandon()
    %>
        <script>
            $(function(){
                $.cookie("TableNumber", ""); 
                location.href= '<%="menu.asp?id_r=" & Request.QueryString("r")%>';
            });
            
        </script>
