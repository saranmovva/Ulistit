<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Form</title>
</head>
<body>

<spring:url value="/User/save" var="saveURL"></spring:url>

<form:form action="${saveURL}" method="POST" modelAttribute="userForm">
	<form:hidden path="id"/>
	<table>
		
		<tr>
			<td>Username:</td>
			<td><form:input path="username"/></td>
		</tr>
		<tr>
			<td>First name:</td>
			<td><form:input path="firstName"/></td>
		</tr>
		<tr>
			<td>Last name:</td>
			<td><form:input path="lastName"/></td>
		</tr>
		<tr>
			<td>School email:</td>
			<td><form:input path="schoolEmail"/></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td><form:input path="password"/></td>
		</tr>
		<tr>
			<td>Entity#:</td>
			<td><form:input path="entityID"/></td>
		</tr>
		<tr>
			<td></td>
			<td><button type="submit">Save</button></td>
		</tr>
	</table>
</form:form>

</body>
</html>