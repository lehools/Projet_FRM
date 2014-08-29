<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>   
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--link to use for the captcha-->
	<link rel="stylesheet" href="captcha/jquery.motionCaptcha.0.2.css"/>
<!--link to use for the menu bar-->
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="styles/layout.css" type="text/css" />
	<link rel="stylesheet" href="styles/navi.css" type="text/css" />
	<link rel="stylesheet" href="styles/forms.css" type="text/css" />

<!--link to use for the calendar-->
		<link rel='stylesheet' href='http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css'>
		<script src='http://code.jquery.com/jquery-1.9.1.js'></script>
		<script src='http://code.jquery.com/ui/1.10.3/jquery-ui.js'></script>
		<link rel='stylesheet' href='/resources/demos/style.css'>


<title>test Contact Book</title>
</head>

<body>
<h1>My contact book</h1>
<div class="wrapper col2">
	<div id="topbar">
		<div id="topnav">
			<ul>
<%	//read the value of the session
	HttpSession current_session = request.getSession();
	String current_session_name = (String) current_session.getAttribute( "session" );
	 if(current_session_name != null)
 	  {
			out.write("<li><a href=\"index.jsp\">login</a></li>");
			out.write("<li><a href=\"contact.jsp\">Contact</a></li>");
			// if the user is unlogged, he doesn't have access to the tab "create" to enter a new contact
			if((current_session_name.toLowerCase().startsWith("admin"))||(current_session_name.toLowerCase().startsWith("superuser") )||(current_session_name.toLowerCase().startsWith("user") ))
	  		{
				// if the user is logged as admin or superuser, he has access to the tab "create" to enter a new contact
				if((current_session_name.toLowerCase().startsWith("admin"))||(current_session_name.toLowerCase().startsWith("superuser")))
		  		{
		  			out.write("<li><a href=\"create.jsp\">Create</a></li>");		
		  		}
				else
				{
					out.write("<li><a class=\"test\">Create</a></li>");
				}
	  			
	  			out.write("<li><a href=\"help.jsp\">Help</a></li>");
	  			out.write("<li><a href=\"logout.jsp\">Logout</a></li>");
	  		}
 	  }
	// if the user is unlogged, he doesn't have access to all the tab
	 else
	 {
		 	out.write("<li><a class=\"test\">login</a></li>");
			out.write("<li><a class=\"test\">Contact</a></li>");
			out.write("<li><a class=\"test\">Create</a></li>");
			out.write("<li><a class=\"test\">Help</a></li>");
			out.write("<li><a class=\"test\">Logout</a></li>");
	 }
%>
			</ul>
		</div>
		<br class="clear" />
	</div>
</div>
