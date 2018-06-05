<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User</title>
</head>
<body>

	<spring:url value="/add" var="addURL"/>
	<a href="${addURL}">Add user</a>

	<table width="100%" border="1">
		<tr>
			<td>Username</td>
			<td>First Name</td>
			<td>Last Name</td>
			<td>School email</td>
			<td>Password</td>
			<td>Entity#</td>
			<td colspan="2">Action</td>
		</tr>
		<c:forEach items="${list}" var="user">
			<tr>
				<td>${user.username}</td>
				<td>${user.firstName}</td>
				<td>${user.lastName}</td>
				<td>${user.schoolEmail}</td>
				<td>${user.password}</td>
				<td>${user.entityID}</td>
				<td>
					<spring:url value="/User/update/${user.userID}" var="updateURL"/>
					<a href="${updateURL}">Update</a>
				</td>
				<td>
					<spring:url value="/User/delete/${user.userID}" var="deleteURL"/>
					<a href="${deleteURL}">Delete</a>
				</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>