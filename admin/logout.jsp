<%@ page import = "java.io.*,java.util.*" %>
<%
  session.setAttribute("is_logged", false);
   // New location to be redirected
  String site = new String("login.jsp");
  response.setStatus(response.SC_MOVED_TEMPORARILY);
  response.setHeader("Location", site);     
%>