
<%@include file="header.jsp" %>
<div class="wrapper col5">
<div id="container">
	<div id="respond">
		index page
		
		<br/><br/>
		<form  <%
				//if the user is already logged, the form is hidden
				if(current_session_name == null)
				{
				
				}
				else if((current_session_name.toLowerCase().startsWith("admin"))||(current_session_name.toLowerCase().startsWith("user"))||(current_session_name.toLowerCase().startsWith("superuser")))
				{
					out.write("hidden=''");
				}%>
				 action="#" method="post" id="mc-form">
			<center>
				<table border=0 cellpadding=20px bgcolor=#059BD8 style="border-radius:20px";>
					<tr>
						<th>
							<font color="white">Enter your username and password</font>
						</th>	
					</tr>
					<tr>
						<th>
							<label for="username"><font color="white">Username: </font></label>
							<input type="text" name="username" id ="username"/>
						</th>
					</tr>
					<tr>
						<th>
							<label for="password"><font color="white">Password : </font></label>
							<input type="password" name="password" id ="password"/>
						</th>
					</tr>
					<th>
						<div id="mc">
							<font color="white" size="1"><p>Please draw the shape in the box to submit the form: (<a onclick="window.location.reload()" href="#" title="Click for a new shape">new shape</a>)</p><br><br></font>
								<canvas id="mc-canvas">
									Your browser doesn't support the canvas element - please visit in a modern browser.
								</canvas>
								<a onclick="window.location.reload()" href="#" title="Click for a new shape"><font color="black" size="1">New shape</font></a>
						</div>

					</th>
					<tr>
						<th>
							<p><input disabled="disabled" autocomplete="false" type="submit" value="Submit"></p>
						</th>
					</tr>
				</table>
			</center>
		</form>
		
		<div class="clear"></div>

<!-- Script used for the captcha --> 
		<script src="script/jquery.min.js" type="text/javascript"></script>
		<script src="captcha/jquery.motionCaptcha.0.2.js"  type="text/javascript"></script>
		<script type="text/javascript">
		jQuery(document).ready(function($) {
			$('#mc-form').motionCaptcha({
				shapes: ['triangle', 'x', 'rectangle', 'circle', 'check', 'zigzag', 'arrow', 'delete', 'pigtail', 'star']
			});
			
			// Yep:
			$("input.placeholder").placeholder();
		});
	</script>
	</div>
</div>
</div>	

<%
//read the value of the session
String username = request.getParameter("username");
String pwd = request.getParameter("password");

//if username and password is not null
if ((username != null && pwd != null) && (username != "" && pwd != ""))
{
	//System.out.println("param non null username: "+ username + " pwd: " + pwd); //debug info
	
	//check if the username and passwordare right
	if((username.toLowerCase().startsWith("admin")) && (pwd.toLowerCase().startsWith("admin")) || (username.toLowerCase().startsWith("user")) && (pwd.toLowerCase().startsWith("user")) || (username.toLowerCase().startsWith("superuser")) && (pwd.toLowerCase().startsWith("superuser")) )
	{
		System.out.println("user: "+ username + " pwd: " + pwd);
		HttpSession my_session = request.getSession();
		// set the name of user in the session
		my_session.setAttribute( "session", username );
		String chaine = (String) my_session.getAttribute( "session" );
		System.out.println("session "+chaine);
		out.write("<center><font color='green'>connexion succesfull</font></center>");
		pageContext.forward("contact.jsp");
	}
	else
	{
		//System.out.println("else username: "+ username + " pwd: " + pwd);//debug info
		out.write("<center><font color='red'>Wrong password or username</font></center>");
	
	}
}
else
{
	//System.out.println("param null username: "+ username + " pwd: " + pwd);//debug info
}


%>
<%@include file="footer.jsp" %>
