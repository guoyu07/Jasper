<%@ page import="java.sql.*,jasper.helper.*" %> 

<%
	String errorNotification = null;
	String uname = null;
	String pass = null;

	String dbname = null;
	int dbCreateStatus = -1;
	dbname = request.getParameter("db");

	if (request.getParameter("dbCreateStatus") != null) {
		dbCreateStatus = Integer.parseInt(request.getParameter("dbCreateStatus"));
	}
	
		JasperCookie cookies = new JasperCookie(request,response);

	
	if(!cookies.exists("uname") || !cookies.exists("uname")){
		response.sendRedirect("index.jsp");
	}
	
	uname = cookies.getValue("uname");
	pass = cookies.getValue("pass");
	
%>

<html>
<head>
<title>Jasper</title>
<link rel="stylesheet" type="text/css" href="/Jasper/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/Jasper/css/template.css">
</head>
<body>
	<div class="container-fluid">
		<div class="row">
		
			<!-- Side Bar for showing databases -->
			<div class="col-xs-2 sidebar">
				<div class="row">
					<h1 class="height-70 margin-0" id="jasper">Jasper</h1>
					<div class="col-xs-12" id="navigation-list">
						<div class="row">
							<a href="home.jsp">
								<div class="col-xs-6 navigation-widget border-bottom border-right">
									<div class="row">
										<div class="col-xs-12 navigation-icon">
											<span class="glyphicon glyphicon-home"></span>
										</div>
										<div class="col-xs-12 navigation-text">
											Home
										</div>
									</div>
								</div>
							</a>
							<a href="logout.jsp">
								<div class="col-xs-6 navigation-widget border-bottom">
									<div class="row">
										<div class="col-xs-12 navigation-icon">
											<span class="glyphicon glyphicon-log-out"></span>
										</div>
										<div class="col-xs-12 navigation-text">
											Logout
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
					<div class="col-xs-12" id="db-list">
						<div class="row">
<%
JasperDb db = new JasperDb("",uname,pass);
ConnectionResult cr = db.getConnectionResult();
if(!cr.isError()){
	String query = "SHOW DATABASES";
	QueryResult qr = db.executeQuery(query);

	if(qr.isError())
		errorNotification = "<div class=\"alert alert-danger\">Cannot Find Database List</div>";
	else{
		ResultSet rs = qr.getResult();
		while(rs.next())
		{
			String data = rs.getString("Database");
%>
							<a href="table.jsp?db=<% out.print(data); %>" ><h4 class="col-xs-12 height-30 db"><% out.print(data); %></h4></a>
<%
		}
		rs.close();
	}
	db.close();
}
%>

						</div>
					</div>
					<div class="col-xs-12 " id="create-db-area">
					<form method="get" action="Createdb">
						<input type="text" name="db-name" placeholder="Enter Database Name" id="create-db-input"  required><br>
						<input type="Submit" value="Create" class="col-xs-12 btn btn-default" id="create-db-submit">
					</form>
						<button class="col-xs-12 btn btn-default" id="create-db-btn" onclick="createDB(this);">Create</button>
						<button class="col-xs-12 btn btn-default" id="cancel-db" onclick="cancelDB(this);">Cancel</button>
<% 
if(dbCreateStatus == 1) {
	out.println("Database Created successfully");
} else if (dbCreateStatus == 0) {
	out.println("Couldn't Create Database");
}


%>
					</div>
				</div>
			</div>
			
			<!-- Main View for  -->
			<div class="col-xs-10 col-xs-offset-2" id="main-view">
				<div class="row">
					<div class="col-xs-12 action-bar">
						<div class="container-fluid">
							<div class="row">
								<div class="col-xs-12" id="action-list">
									<div class="row">
										<a href="#">
											<div class="col-xs-2 action-widget border-bottom border-right">
												<div class="row">
													<div class="col-xs-12 action-icon">
														<span class="glyphicon glyphicon-plus"></span>
													</div>
													<div class="col-xs-12 action-text">
														Create Database
													</div>
												</div>
											</div>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="content">
<% if(errorNotification != null && !errorNotification.isEmpty()) {%>
						<div class="col-xs-12">
							<div id="notification">
								<% out.print(errorNotification); %>
							</div>
						</div>
					
<% } %>
						<div class="col-xs-12">
							<div  id="welcome-note">
								<h3>Welcome to Jasper</h3>
								<h5>New Way of handling your Databases</h5>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="script.js"></script>
</body>
</html>
