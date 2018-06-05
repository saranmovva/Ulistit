<%--
  Created by IntelliJ IDEA.
  User: the king
  Date: 2/13/18
  Time: 9:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page import="edu.ben.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="edu.ben.model.Listing" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Admin Dashboard</title>
    <spring:url value="resources/css/uikit.css" var="uikitCSS"/>
    <spring:url value="resources/js/uikit.js" var="uikitJS"/>
    <spring:url value="resources/js/jquery.js" var="jquery"/>
    <spring:url value="resources/js/uikit-icons.js" var="uikiticons"/>
    <spring:url value="resources/js/Chart.js" var="chart"/>
    <spring:url value="resources/js/fontawesome-all.js" var="fontAwesomeJS"/>
    <script defer src="${fontAwesomeJS}"></script>
    <link href="${uikitCSS}" rel="stylesheet"/>
    <script type="text/javascript" src="${uikitJS}"></script>
    <script type="text/javascript" src="${jquery}"></script>
    <script type="text/javascript" src="${uikiticons}"></script>
    <script type="text/javascript" src="${chart}"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <style>
        body {
            background-color: white;
        }

        .low {
            background-color: #21D4FD;
            background-image: linear-gradient(19deg, #21D4FD 0%, #B721FF 100%);

            color: white;
        }

        .normal {
            background-color: #08AEEA;
            background-image: linear-gradient(135deg, #08AEEA 0%, #2AF598 100%);

        }

        .high {
            background-color: #FEE140;
            background-image: linear-gradient(90deg, #FEE140 0%, #FA709A 100%);

            color: white;

        }

        .critical {
            background-color: #000000;
            background-image: linear-gradient(310deg, #000000 0%, #FF2525 79%);

            color: white;

        }

        .active-users-number {
            font-size: 25px;

        }

        .active-users {
            background-color: #08AEEA;
            background-image: linear-gradient(135deg, #08AEEA 0%, #2AF598 100%);

        }

        .active-listings {
            background-color: #08AEEA;
            background-image: linear-gradient(135deg, #08AEEA 0%, #2AF598 100%);

        }

        .total-revenue {
            background-color: #08AEEA;
            background-image: linear-gradient(135deg, #08AEEA 0%, #2AF598 100%);

        }

        .add-button {
            background-color: #08AEEA;
            background-image: linear-gradient(135deg, #08AEEA 0%, #2AF598 100%);
        }

        .profile-pic {
            padding: 1px;
            border: 1px solid #08AEEA;
        }

        .uk-button {
            background-color: #a59d9d;
            background-image: linear-gradient(138deg, #a59d9d 0%, #ffffff 100%);

        }
        img {
            max-width: 100%;
            max-height: 100%;
        }
    </style>

</head>