<%@include file="header.jsp" %>
<div class="wrapper col5">
	<div id="container">
		<div id="respond">
		
		logout page
		<%
		HttpSession kill_session = request.getSession();
		kill_session.invalidate();

        /* redirect to the main page ! */
        pageContext.forward("index.jsp");
        %>
	</div>
</div>
</div>	
<%@include file="footer.jsp" %>
        