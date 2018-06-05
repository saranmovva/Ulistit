<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>U-ListIt Account Unlock</title>
<link rel="stylesheet" type="text/css" href="resources/css/custom.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<%@include file="jspf/header.jsp"%>
<body>

	<%@include file="jspf/messages.jsp"%>

	<%@include file="jspf/navbar.jspf"%>


	<div style="margin: 2% 33% 5% 33%">
		<form class="form-horizontal blacktext" action="unlock" method="post">
			<input type="hidden" name="action" value="email" />
			<div style="text-align: center">
				<p class="lead">Enter Your Email to Receive the Unlock Code</p>
			</div>
			<div class="form-group blacktext">
				<label for="inputEmail" class="col-lg-2 control-label">Email</label>
				<div class="col-lg-10">
					<input type="text" class="form-control" name="email"
						value="${email}" placeholder="Email">
				</div>
			</div>
			<div class="form-group blacktext">
				<div class="col-lg-10 col-lg-offset-2 blacktext">
					<button type="submit" class="btn btn-default">Send Code</button>
					<a href="login" class="btn btn-default">Cancel</a>
				</div>
			</div>
			<div class="form-group blacktext">
				<p style="text-align: center" class="text-warning">
					<i>${message}</i>
				</p>
			</div>
		</form>
	</div>

</body>
	<%@include file="jspf/footer.jspf"%>
</html>