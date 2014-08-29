<%@include file="header.jsp" %>
<div class="wrapper col5">
	<div id="container">
		<div id="respond">
		
		Contact me
	<!--  form to contact the webmaster -->	
	<center>
		<form  action="mailto:testmail@mail.ch" method="post" id="mc-form">
				<table border=0 cellpadding=20px bgcolor=#059BD8 style="border-radius:20px";>
					<tr>
						<th>
							<font color="white">Enter your message for the webmaster</font>
						</th>	
					</tr>
					<tr>
							<INPUT type="hidden" name="subject" value="web_monitor">
							<label for="subject"><font color="white"></font></label>
					</tr>
					<tr>
						<th>
							<label for="mail"><font color="white"></font></label>
							<textarea  cols="50" rows="10" name="email">/!\ Please enter your message here ...</textarea>
						</th>
					</tr>
					<tr>
						<th>
							<p><input autocomplete="false" type="submit" value="Submit"></p>
						</th>
					</tr>
				</table>
			</form>
		</center>
	</div>
</div>
</div>	
<%@include file="footer.jsp" %>