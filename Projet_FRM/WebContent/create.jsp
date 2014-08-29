<%@include file="header.jsp" %>
<%@ page import="java.sql.Statement" %>
<div class="wrapper col5">
	<div id="container">
		<div id="respond">
		
<!--script/function use for the calendar-->
	<script>
	  $(function() {
		$( "#datepicker" ).datepicker();
	  });
  </script>		
				
<form  method="post">
		<center> <?php echo $text ?>
			<table border=0 cellpadding=20px bgcolor="#059BD8" style="border-radius:20px">
				<tr>
					<th>
						<font color="white">Enter new contact</font>
					</th>	
				</tr>
				<tr>
					<th>
						<label for="name"><font color="white">Name: </font></label>
						<input type="text" name="name" id ="name"/>
					</th>
				</tr>
				<tr>
					<th>
						<label for="surname"><font color="white">Surname : </font></label>
						<input type="text" name="surname" id ="surname"/>
					</th>
				</tr>
				<tr>
					<th>
						<label for="tel"><font color="white">Tel : </font></label>
						<input type="tel" name="tel" id ="tel"/>
					</th>
				</tr>
				<tr>
					<th>
						<label for="mobile"><font color="white">Mobile : </font></label>
						<input type="mobile" name="mobile" id ="mobile"/>
					</th>
				</tr>
				<tr>
					<th>
						<label for="mail"><font color="white">Mail : </font></label>
						<input type="mail" name="mail" id ="mail"/>
					</th>
				</tr>
				<tr>
					<th>
						<label for="street"><font color="white">Street : </font></label>
						<input type="street" name="street" id="street"/>
					</th>
					<th>
						<label for="no"><font color="white">No : </font></label>
						<input type="no" name="no" id="no"/>
					</th>
				</tr>
				<tr>
					<th>
						<label for="zip"><font color="white">Zip : </font></label>
						<input type="zip" name="zip" id="zip"/>
					</th>
					<th>
						<label for="city"><font color="white">City: </font></label>
						<input type="city" name="city" id="city"/>
					</th>
				</tr>
				<tr>
					<th>
						<label for="date"><font color="white">Date of Birth : </font></label>
						<input type="date" name="date" id="datepicker"/>
					</th>
				</tr>
				<tr>
					<th>
						<input id="submit" type="submit" value="save"/>
					</th>
				</tr>
			</table>
		</center>
	</form>

		</div>
	</div>
</div>
<%
String[] param = {"name","surname","tel","mobile","mail","street","no","zip","city","date"};
String[] input = new String[10];

//regexp to check if the entry is valid
Pattern [] regexp = new Pattern[10];
regexp [0] = Pattern.compile("^[A-Z][a-z]*-[A-Z][a-z]*|[A-Z][a-z]*$");//name
regexp [1] = Pattern.compile("^[A-Z][a-z]*-[A-Z][a-z]*|[A-Z][a-z]*$");//surname
regexp [2] = Pattern.compile("^0[0-9]{9}$"); //tel
regexp [3] = Pattern.compile("^07[0-9]{8}$"); //mobile
regexp [4] = Pattern.compile("^[a-z0-9.-]+@[a-z0-9]+\\.[a-zA-Z]{2,3}$"); //mail
regexp [5] = Pattern.compile("^[A-Z][a-z-\\s]*$");;  //street
regexp [6] = Pattern.compile("^[0-9][0-9]*$"); //no
regexp [7] = Pattern.compile("^[0-9]{4}$"); //zip
regexp [8] = Pattern.compile("^[A-Z][a-z]*$"); //city
regexp [9] = Pattern.compile("^\\d{2}-\\d{2}-\\d{4}$"); //date

	//loop to check all the entry
	Map getParam=new HashMap() ;
	boolean isValid = true;
	for (int i = 0; i < param.length;i++) 
	{
		System.out.println (i + ": " + request.getParameter(param[i]));
		getParam.put(param[i], request.getParameter(param[i]));
		System.out.println("i: "+i+" param[i] : " + param[i]+" regexp[i]: "+regexp[i]+" request.getParameter(param[i]): "+request.getParameter(param[i]));
		if(request.getParameter(param[i]) == null)
		{
			out.write("<center><font color='red'>field " + param[i] + " is empty</font></center>");
		}
		else
		{
			Matcher m = regexp[i].matcher(request.getParameter(param[i]));
			if (m.matches())
			  {
				  System.out.println(param[i] +" is right");
				  //out.write("<center><font color='green'>right " + param[i]+ "</font></center>");//use for test
			  }
			  else{
				  isValid = false;
				  System.out.println(param[i] +" is wrong");
				  out.write("<center><font color='red'>wrong " + param[i] + "</font></center>");
			  }
		}
	}
	if (isValid)
	{
		for(int i=0; i<input.length; i++)
		{
			input[i] = request.getParameter(param[i]);
			System.out.println(i+" eme parametre: " +input[i]);
			if (input[i] == null)
			{
				isValid = false;
			}
		}
		try {
	  		Class.forName( "com.mysql.jdbc.Driver" );
		} catch ( ClassNotFoundException e ) 
		{
	  	/* error message */
	 	 System.out.println("driver not loaded");
		}
		System.out.println("MySQL JDBC Driver Registered!");
		/* connection with th DB */
		String url = "jdbc:mysql://localhost:3306/contact";
		String utilisateur = "root";
		String motDePasse = "1234";
		Connection connection = null;
		Statement statement = null;
		ResultSet resultat = null;
		try {
			connection = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/contact","root", "1234");

		} catch (SQLException e) {
			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;
		}
		if (connection != null) {
			System.out.println("You made it, take control your database now!");
			statement = connection.createStatement();
			resultat = statement.executeQuery( "SELECT idcontact_table FROM contact_table;" );
			int lastID = 0;
			while ( resultat.next() ) {
				// search the last ID
			      int idUtilisateur = resultat.getInt( "idcontact_table" );
			      if (idUtilisateur > lastID)
			      {
			    	  lastID = idUtilisateur;
			      }
			 }
			 //System.out.println("last Id : "+ lastID); // debug info
			 lastID = lastID + 1;
			 // insert the value into the DB
			if (isValid)
			{
				out.write("<center><font color='green'>formulaires valide</font></center>");
				int statut = statement.executeUpdate( "INSERT INTO contact_table (idcontact_table,name,surname,tel,mobile,mail, street, no, zip, city, date) VALUES ('"+lastID + "','"+input[0]+"','"+input[1]+"','"+input[2]+"','"+input[3]+"','"+input[4]+"','"+input[5]+"','"+input[6]+"','"+input[7]+"','"+input[8]+"','"+input[9]+"')");
				System.out.println("status:" + statut);
			}
			 //if form is not valid
			else
			{
				out.write("<center><font color='red'>formulaire n'est pas valide</font></center>");
			}
			
		  }
			else {
				System.out.println("Failed to make connection!");
			}
		//close the DB connection
		  //System.out.println( "Fermeture de l'objet ResultSet." ); //debug info
		  if ( resultat != null ) {
		      try {
		          resultat.close();
		      } catch ( SQLException ignore ) {
		      }
		  }
		  //System.out.println( "Fermeture de l'objet Statement." );//debug info
		  if ( statement != null ) {
		      try {
		          statement.close();
		      } catch ( SQLException ignore ) {
		      }
		  }
		  //System.out.println( "Fermeture de l'objet Connection." );//debug info
		  if ( connection != null ) {
		      try {
		      	connection.close();
		      } catch ( SQLException ignore ) {
		      }
		  }

	}
	else
	{
		out.write("<center><font color='red'>formulaire n'est pas valide</font></center>");
	}
	%>

<%@include file="footer.jsp" %>