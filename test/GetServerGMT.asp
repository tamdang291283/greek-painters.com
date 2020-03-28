<%@language="jscript"%>
<%
    var od = new Date();
    var nd = od.toUTCString();
    Session("ServerGMT") = nd;
%> 