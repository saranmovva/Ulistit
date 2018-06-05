<%--
 <%--
  Created by IntelliJ IDEA.
  User: saran
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
    <title>Task Manager</title>
    <spring:url value="resources/css/uikit.css" var="uikitCSS"/>
    <spring:url value="resources/js/uikit.js" var="uikitJS"/>
    <spring:url value="resources/js/jquery.js" var="jquery"/>
    <spring:url value="resources/js/uikit-icons.js" var="uikiticons"/>
    <spring:url value="resources/js/Chart.js" var="chart"/>


    <link href="${uikitCSS}" rel="stylesheet"/>
    <script type="text/javascript" src="${uikitJS}"></script>
    <script type="text/javascript" src="${jquery}"></script>
    <script type="text/javascript" src="${uikiticons}"></script>
    <script type="text/javascript" src="${chart}"></script>

    <link rel="stylesheet" type="text/css" href="resources/css/loading-bar.css"/>
    <script type="text/javascript" src="resources/js/loading-bar.js"></script>

    <style>
        .submit-button {
            background-color: #08AEEA;
            background-image: linear-gradient(135deg, #08AEEA 0%, #2AF598 100%);

            color: white;
        }

        .description {
            float: right;
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

        .profile-pic {
            height: auto;
            width: auto;
            max-height: 40px;
            max-width: 40px;

            padding: 1px;
            border: 1px solid #08AEEA;

        }

    </style>
</head>
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <body onload="adminTasks()">
    <%@include file="admin/admin-navbar.jsp" %>
    <div class="uk-container">
        <h1 class="uk-heading-line uk-text-center"><span>Task Manager</span></h1>
        <br>
        <div uk-grid>
            <div class="uk-width-2-5">
                <div class="uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body">
                    <h3>Create and Assign Tasks</h3>
                    <hr>
                    <form method="POST" class="task-manager"
                          onsubmit="return validateForm()" action="createTask"
                          name="createTaskForm">
                        <fieldset class="uk-fieldset">
                            <div class="uk-margin">
                                <strong>Enter Name:</strong> <input class="uk-input" type="text" placeholder="Input"
                                                                    name="name">
                            </div>

                            <div class="uk-margin">
                                <strong>Enter Description:</strong> <textarea class="uk-textarea" rows="5"
                                                                              placeholder="Textarea"
                                                                              name="description"></textarea>
                            </div>
                            <div class="uk-margin">
                                <strong>Assign an Admin:</strong>
                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid" name="admin">
                                    <c:forEach var="admin" items="${admins}" varStatus="loop">
                                        <label><input class="uk-checkbox" name="admin" value="${admin.schoolEmail}"
                                                      type="checkbox"> ${admin.firstName} ${admin.lastName}</label>

                                    </c:forEach>
                                </div>
                            </div>
                            <div class="uk-margin">
                                <label class="uk-form-label" for="form-horizontal-select2"></label>
                                <div class="uk-form-controls">
                                    <strong>Select Priority Level:</strong> <select class="uk-select"
                                                                                    id="form-horizontal-select2"
                                                                                    name="priority">
                                    <option value="low">Low</option>
                                    <option value="normal">Normal</option>
                                    <option value="high">High</option>
                                    <option value="critical">Critical</option>
                                </select>
                                </div>
                            </div>
                            <br>
                            <button class="submit-button uk-button uk-button-default">Create</button>
                        </fieldset>
                    </form>

                </div>
            </div>
            <div class="uk-width-3-5">
                <div class="uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body"
                     style="overflow: auto;">
                    <div class="uk-child-width-1-5@s uk-grid-small uk-grid-match" uk-grid>
                        <div>
                            <h3>Task List </h3>
                        </div>
                        <div class="uk-margin-small uk-padding-remove uk-grid-small uk-child-width-auto uk-grid">
                            <label><input class="uk-checkbox" type="checkbox" id="check"
                                          onchange="toggleCheckbox()"> Your Tasks</label></span>
                        </div>
                    </div>
                    <div class="temp" id="allTasks">
                        <table class="uk-table uk-table-hover uk-table-divider">

                            <tbody>

                            <c:forEach var="task" items="${tasks}" varStatus="loop">
                                <tr>

                                    <td>
                                        <div uk-grid>
                                            <c:choose>
                                                <c:when test="${task.priority == 'low'}">
                                                    <div class="uk-width-4-5">
                                                        <c:choose>
                                                            <c:when test="${task.status == 0}">
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox"
                                                                                  type="checkbox"><span
                                                                            class="low uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox" type="checkbox"
                                                                                  checked><span
                                                                            class="low uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}"
                                                                              style="text-decoration: line-through;">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:when test="${task.priority == 'normal'}">
                                                    <div class="uk-width-4-5">
                                                        <c:choose>
                                                            <c:when test="${task.status == 0}">
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox"
                                                                                  type="checkbox"><span
                                                                            class="normal uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox" type="checkbox"
                                                                                  checked><span
                                                                            class="normal uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}"
                                                                              style="text-decoration: line-through;">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:when test="${task.priority == 'high'}">
                                                    <div class="uk-width-4-5">
                                                        <c:choose>
                                                            <c:when test="${task.status == 0}">
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox"
                                                                                  type="checkbox"><span
                                                                            class="high uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox" type="checkbox"
                                                                                  checked><span
                                                                            class="high uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}"
                                                                              style="text-decoration: line-through;">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:when test="${task.priority == 'critical'}">
                                                    <div class="uk-width-4-5">
                                                        <c:choose>
                                                            <c:when test="${task.status == 0}">
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox"
                                                                                  type="checkbox"><span
                                                                            class="critical uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox" type="checkbox"
                                                                                  checked><span
                                                                            class="critical uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}"
                                                                              style="text-decoration: line-through;">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>Error</c:otherwise>
                                            </c:choose>

                                            <div class="uk-width-1-5">

<span class=" description uk-margin-small-right" uk-icon="icon: more; ratio: 1"
      uk-toggle="target: #toggle-usage${task.taskID}">
      </span>


                                            </div>

                                        </div>
                                        <div hidden id="toggle-usage${task.taskID}">
                                            <br>
                                            <div uk-grid>

                                                <div class="uk-width-2-5"><h6 class="uk-text-center">
                                                    <strong>Developers</strong>
                                                </h6>
                                                    <hr>

                                                    <div class="uk-container">
                                                        <div class="uk-child-width-1-2@m uk-grid-small uk-grid-match"
                                                             uk-grid>

                                                            <c:forEach var="admin" items="${adminTasks}"
                                                                       varStatus="loop">

                                                                <c:if test="${task.taskID == admin.getTask().getTaskID()}">
                                                                    <img class="profile-pic uk-border-circle uk-padding-small uk-margin-left"
                                                                         uk-tooltip="${admin.getUser().getFirstName()} ${admin.getUser().getLastName()}"
                                                                         src="${pageContext.request.contextPath}/directory/${admin.getUser().getMainImage()}">
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="uk-width-3-5"><h6 class="uk-text-center">
                                                    <strong>Description</strong></h6>
                                                    <hr>
                                                    <p class="uk-text-center">${task.description}</p>
                                                </div>

                                            </div>
                                        </div>

                                        <div id="modal-sections${task.taskID}" uk-modal>
                                            <div class="uk-modal-dialog">
                                                <button class="uk-modal-close-default" type="button" uk-close></button>
                                                <div class="uk-modal-header">
                                                    <h2 class="uk-modal-title">Edit ${task.name}</h2>
                                                </div>
                                                <div class="uk-modal-body">
                                                    <div class="uk-child-width-1-1@s uk-grid-small uk-grid-match"
                                                         uk-grid>
                                                        <div class="uk-text-center">
                                                            <h5>Developers</h5>
                                                            <c:forEach var="adminTask" items="${adminTasks}"
                                                                       varStatus="loop">
                                                                <c:forEach var="admin" items="${admins}"
                                                                           varStatus="loop">
                                                                    <c:if test="${adminTask.taskID == task.taskID}">
                                                                        <h6>${adminTask.getUser().getUserID()}</h6>
                                                                        <c:if test="${adminTask.getUser().getUserID() == admin.userID}">
                                                                            <label><input class="uk-checkbox" checked

                                                                                          name="admin"        value="${admin.schoolEmail}"
                                                                                          type="checkbox"> ${admin.firstName} ${admin.lastName}
                                                                            </label>
                                                                        </c:if>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:forEach>
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="uk-modal-footer uk-text-right">
                                                    <button class="uk-button uk-button-danger" type="button">Remove Task
                                                    </button>
                                                    <button class="uk-button uk-button-primary" type="button">Save
                                                    </button>
                                                </div>
                                            </div>
                                        </div>


                                    </td>


                                </tr>
                            </c:forEach>
                            </tbody>

                        </table>
                    </div>
                    <div class="temp" id="yourTasks" style="display: none;">
                        <table class="uk-table uk-table-hover uk-table-divider">

                            <tbody>

                            <c:forEach var="task" items="${yourTasks}" varStatus="loop">
                                <tr>

                                    <td>
                                        <div uk-grid>
                                            <c:choose>
                                                <c:when test="${task.priority == 'low'}">
                                                    <div class="uk-width-4-5">
                                                        <c:choose>
                                                            <c:when test="${task.status == 0}">
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox"
                                                                                  type="checkbox"><span
                                                                            class="low uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox" type="checkbox"
                                                                                  checked><span
                                                                            class="low uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}"
                                                                              style="text-decoration: line-through;">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:when test="${task.priority == 'normal'}">
                                                    <div class="uk-width-4-5">
                                                        <c:choose>
                                                            <c:when test="${task.status == 0}">
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox"
                                                                                  type="checkbox"><span
                                                                            class="normal uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox" type="checkbox"
                                                                                  checked><span
                                                                            class="normal uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}"
                                                                              style="text-decoration: line-through;">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:when test="${task.priority == 'high'}">
                                                    <div class="uk-width-4-5">
                                                        <c:choose>
                                                            <c:when test="${task.status == 0}">
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox"
                                                                                  type="checkbox"><span
                                                                            class="high uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox" type="checkbox"
                                                                                  checked><span
                                                                            class="high uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}"
                                                                              style="text-decoration: line-through;">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:when test="${task.priority == 'critical'}">
                                                    <div class="uk-width-4-5">
                                                        <c:choose>
                                                            <c:when test="${task.status == 0}">
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox"
                                                                                  type="checkbox"><span
                                                                            class="critical uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                                    <label><input id="task${task.taskID}"
                                                                                  onchange="checkTask(${task.taskID});"
                                                                                  class="uk-checkbox" type="checkbox"
                                                                                  checked><span
                                                                            class="critical uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                        <span id="name${task.taskID}"
                                                                              style="text-decoration: line-through;">${task.name}</span>
                                                                    </label>

                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>Error</c:otherwise>
                                            </c:choose>

                                            <div class="uk-width-1-5">

<span class=" description uk-margin-small-right" uk-icon="icon: more; ratio: 1"
      uk-toggle="target: #toggle-usage${task.taskID}">
      </span>


                                                <span class=" description uk-margin-small-right"
                                                      uk-icon="icon:  file-edit; ratio: 1"
                                                      href="#modal-sections${task.taskID}" uk-toggle>
                                                  </span>


                                            </div>

                                        </div>
                                        <div hidden id="toggle-usage${task.taskID}">
                                            <br>
                                            <div uk-grid>

                                                <div class="uk-width-2-5"><h6 class="uk-text-center">
                                                    <strong>Developersfffff</strong>
                                                </h6>
                                                    <hr>

                                                    <div class="uk-container">
                                                        <div class="uk-child-width-1-2@m uk-grid-small uk-grid-match"
                                                             uk-grid>

                                                            <c:forEach var="admin" items="${adminTasks}"
                                                                       varStatus="loop">
                                                                <c:if test="${task.taskID == admin.getTask().getTaskID()}">
                                                                    <img class="profile-pic uk-border-circle uk-padding-small uk-margin-left"
                                                                         uk-tooltip="${admin.getUser().getFirstName()} ${admin.getUser().getLastName()}"
                                                                         src="${pageContext.request.contextPath}/directory/${admin.getUser().getMainImage()}">
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="uk-width-3-5"><h6 class="uk-text-center">
                                                    <strong>Description</strong></h6>
                                                    <hr>
                                                    <p class="uk-text-center">${task.description}</p>
                                                </div>

                                            </div>
                                        </div>

                                        <div id="modal-sections${task.taskID}" uk-modal>
                                            <div class="uk-modal-dialog">
                                                <button class="uk-modal-close-default" type="button" uk-close></button>
                                                <div class="uk-modal-header">
                                                    <h2 class="uk-modal-title">Edit ${task.name}</h2>
                                                </div>
                                                <div class="uk-modal-body">
                                                    <div class="uk-child-width-1-1@s uk-grid-small uk-grid-match"
                                                         uk-grid>
                                                        <div class="uk-text-center">
                                                            <h5>Developersss</h5>
                                                            <c:forEach var="admin" items="${admins}"
                                                                       varStatus="loop">

                                                                <label><input class="uk-checkbox"
                                                                              name="admin"
                                                                              value="${adminTask.schoolEmail()}"
                                                                              type="checkbox"> ${adminTask.firstName()} ${adminTask.lastName()}
                                                                </label>
                                                            </c:forEach>
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="uk-modal-footer uk-text-right">
                                                    <button class="uk-button uk-button-danger" type="button">Remove Task
                                                    </button>
                                                    <button class="uk-button uk-button-primary" type="button">Save
                                                    </button>
                                                </div>
                                            </div>
                                        </div>


                                    </td>


                                </tr>
                            </c:forEach>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        function checkTask(taskID) {
            console.log("Hit Function");
            $.ajax({
                type: 'GET',
                url: '/taskCompleted',
                data: {"taskID": taskID},
            })
            if (document.getElementById('task' + taskID).checked) {
                document.getElementById('name' + taskID).style.textDecoration = "line-through";
            } else {
                document.getElementById('name' + taskID).style.textDecoration = "none"
            }
        }

        function toggleCheckbox() {
            console.log("Checkbox clicked");

            if (document.getElementById("check").checked == true) {
                console.log("Hit Checked");
                document.getElementById("allTasks").style.display = 'none';
                document.getElementById("yourTasks").style.display = 'inline';
            } else {
                console.log("Hit Not Checked");
                document.getElementById("allTasks").style.display = 'inline';
                document.getElementById("yourTasks").style.display = 'none';
            }

        }
    </script>

    </body>
</div>
</html>
