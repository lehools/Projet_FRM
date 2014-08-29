<%@ page import="java.util.Date" %>
<div class="wrapper col7">
	<div id="copyright">
<font color='blue'><%= new Date() %></font> @copyright François Darbellay
<% 		
		HttpSession current_session_footer = request.getSession();
		String current_user_session = (String) current_session_footer.getAttribute( "session" );
		if(current_user_session == null)
		{
			out.write("<center><font color='red'>not loged</font></center>");
		}
		else
		{
			out.write("<center><font color='red'>loged as "+current_user_session +"</font></center>");
		}
		%>
<br class="clear" />
	</div>
</div>
</body>
</html>