<%@include file="header.jsp" %>
<%@ page import="javax.swing.JTable" %>

<div class="wrapper col5">
	<div id="container">
		<div id="respond">
		
		contact page
		
	
	<% 
	//display the table with all value contained in the DB
	out.write("<br/><br/><TABLE BORDER='1'> <tr>");
	String[] param = {"idcontact_table","name","surname","tel","mobile","mail","street","no","zip","city","date"};
	for (int i= 0; i< param.length;i++)
	{
		out.write("<th>"+ param[i] +"</th>");
	}
	
	//System.out.println("session: " +current_session_name);//debug info
	if(current_session_name != null)
	{
		// if the user is logged as admin, he can delete a contact
		if(current_session_name.toLowerCase().startsWith("admin"))
		{
			System.out.println("if");
			out.write("<th>");
			out.write("Delete");
			out.write("</th>");
		}
		// if the user is logged as admin or superuser, he can update a contact
		if((current_session_name.toLowerCase().startsWith("admin"))||(current_session_name.toLowerCase().startsWith("superuser") ))
		{
			out.write("<th>");
			out.write( "Modify");
			out.write("</th>");
		}
	}
	out.write("</tr>");
	
	
		/* load driver JDBC pour MySQL */
		try {
		  Class.forName( "com.mysql.jdbc.Driver" );
		} catch ( ClassNotFoundException e ) {
		  /* if is an error */
		  System.out.println("driver not loaded");
		}
		System.out.println("MySQL JDBC Driver Registered!");
		/* DB connection */
		String url = "jdbc:mysql://localhost:3306/contact";//DB URL
		String utilisateur = "root";//DB username
		String motDePasse = "1234";//DB password
		Connection connection = null;
		
		try {
			connection = DriverManager
			// try the connection with DB
			.getConnection("jdbc:mysql://localhost:3306/contact","root", "1234");
			

		} catch (SQLException e) {
			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;
		}
		
		if (connection != null) {
			//System.out.println("You made it, take control your database now!");//debug info
			Statement statement = connection.createStatement();
			
			//check if the modify form is completed
			if (request.getParameter("save") != null)
			{
				
				//System.out.println("formular save");//debug info
				//System.out.println("save param:" + request.getParameter("save"));//debug info
				
				//update process
				int statut = statement.executeUpdate("UPDATE contact_table SET name='"+request.getParameter("name")+"',surname='"+request.getParameter("surname")+"',tel='"+request.getParameter("tel")+"',mobile='"+request.getParameter("mobile")+"',mail='"+request.getParameter("mail")+"', street='"+request.getParameter("street")+"', no='"+request.getParameter("no")+"', zip='"+request.getParameter("zip")+"', city='"+request.getParameter("city")+"', date='"+request.getParameter("date")+"' WHERE idcontact_table="+request.getParameter("save"));
				//System.out.println("status:" + statut);//debug info
			}
			// Read the DB
			ResultSet resultat = statement.executeQuery( "SELECT *  FROM contact_table;" );
			
		  //Parse and display the result in the table
		  while ( resultat.next() ) {
		      int idUtilisateur = resultat.getInt( "idcontact_table" );
		      String[] val = new String [10];
		      out.write("<tr>");
		      out.write("<td>"+ idUtilisateur +"</td>");
		      // loop to display all the colum
		      for (int i = 0; i < val.length; i++)
		      {
		    	  val[i] = resultat.getString( param[i+1] ); 
		    	  out.write("<td>"+ val[i] +"</td>");
		    	  System.out.println (val[i]);
		      }
		      // if the user is logges as admin or superuser, the link for delete and modify are displayed
		      if(current_session_name != null)
		  	  {
			    	String get_url = "http://localhost:8080/Projet_FRM/contact.jsp";
			    	// if the user is logges as admin, the link for delete is displayed
			  		if(current_session_name.toLowerCase().startsWith("admin"))
			  		{
			  			out.write("<td>");
			  			out.write("<a href='"+get_url+"?delete="+idUtilisateur+"'>delete</a>");
			  			out.write("</td>");
			  		}
			  		 // if the user is logges as admin or superuser, the link for modify is displayed
			  		if((current_session_name.toLowerCase().startsWith("admin"))||(current_session_name.toLowerCase().startsWith("superuser") ))
			  		{
			  			out.write("<td>");
			  			out.write("<a href='"+get_url+"?modify="+idUtilisateur+"'>modify</a>");
			  			out.write("</td>");
			  		}

		  		}
		      	//if modify link is set, the formular is displayed
		  		if ((request.getParameter("modify") != null) && (Integer.parseInt(request.getParameter("modify")) == idUtilisateur))
				{
		  			out.write("</tr>");
		  			out.write("<tr>");
		  			out.write("<td>");
		  			out.write("</td>");
		  			out.write("<form  method='post' action='http://localhost:8080/Projet_FRM/contact.jsp?save="+request.getParameter("modify")+"'>");
		  			for (int i = 0; i < val.length;i++)
		  			{
			  			out.write("<td>");
			  			out.write("<label for='"+param[i+1]+"'></label><input type='text' name='"+param[i+1]+"' id ='"+param[i+1]+"' value='"+val[i]+"'/>");
			  			out.write("</td>");	
		  			}
		  			out.write("<td><input id='submit' type='submit' value='send'/></td>");
		  			out.write("</form>");
				}
		    	out.write("</tr>");    
		  	}
		  	// if the link delete is set
		  	if (request.getParameter("delete") != null)
			{

				//System.out.println("delete param: " +request.getParameter("delete"));//debug info
		  		// delete process
				int statut = statement.executeUpdate( "DELETE FROM contact_table WHERE idcontact_table="+request.getParameter("delete")+";" );
				//System.out.println("status:" + statut);//debug info
			}

		// close the DB connection		 
		  System.out.println( "Fermeture de l'objet ResultSet." );
		  if ( resultat != null ) {
		      try {
		          resultat.close();
		      } catch ( SQLException ignore ) {
		      }
		  }
		  System.out.println( "Fermeture de l'objet Statement." );
		  if ( statement != null ) {
		      try {
		          statement.close();
		      } catch ( SQLException ignore ) {
		      }
		  }
		  System.out.println( "Fermeture de l'objet Connection." );
		  if ( connection != null ) {
		      try {
		      	connection.close();
		      } catch ( SQLException ignore ) {
		      }
		  }
		} else {
			System.out.println("Failed to make connection!");
		}
		
		out.write("</TABLE>");
		
		%>
	</div>
</div>
</div>	
<%@include file="footer.jsp" %>