<%@include file="admin-header.jsp" %>

<body class="uk-height-viewport uk-background-muted">

<%@include file="admin-navbar.jsp" %>

<%@include file="../jspf/messages.jsp" %>

<div class="uk-padding-small uk-cover-container uk-background-muted uk-padding-small uk-height-viewport">
    <div class="uk-margin-bottom uk-padding-small uk-flex uk-flex-column">
        <ul uk-switcher hidden>
            <li>
                <a href="#dashboardUserTable" hidden></a>Users
            </li>
            <li>
                <a href="#dashboardListingsTable" hidden></a>Listings
            </li>
        </ul>
        <div id="dashboardUserTable"
             class="uk-tile uk-width-3-4 uk-align-center uk-padding-remove-top uk-padding-remove-bottom uk-card uk-card-large uk-padding-remove-right uk-padding-remove-left uk-box-shadow-medium uk-box-shadow-hover-large uk-tile-default">
            <div class="uk-overflow-auto">
                <div class="uk-align-center uk-padding-large uk-margin-bottom" uk-grid>
                    <div class="uk-overflow-container">
                        <a class="uk-button uk-padding-small uk-button-default uk-position-top-right"
                           href="#createUserModal" uk-toggle
                           hidden>Create
                            User</a>
                        <h2 class="uk-heading-line uk-text-center"><span>Admin User Panel</span></h2>
                        <table class="uk-table uk-table-small uk-table-hover uk-table-middle uk-table-divider uk-margin uk-margin-large uk-margin-bottom uk-padding-small">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Unlock</th>
                                <th>Edit</th>
                                <th>Ban</th>

                            </tr>
                            </thead>
                            <tbody>
                            <%
                                List<User> allUsers = (List<User>) session.getAttribute("allUsers");
                                for (int i = 0; i < allUsers.size(); i++) {
                            %>
                            <tr>
                                <td><%=allUsers.get(i).getUserID()%>
                                </td>
                                <td><%=allUsers.get(i).getSchoolEmail()%>
                                </td>
                                <td><%=allUsers.get(i).getFirstName()%>
                                </td>
                                <td><%=allUsers.get(i).getLastName()%>
                                </td>
                                <td>
                                    <%
                                        if (allUsers.get(i).getLocked() == 1) {
                                    %>
                                    <form method="Post" action="adminUnlock">
                                        <button name="lock"
                                                value="<%=allUsers.get(i).getSchoolEmail()%>"
                                                type="submit" uk-icon="icon: lock"></button>
                                    </form>
                                    <%
                                    } else {
                                    %>
                                    <form method="Post" action="adminLock">
                                        <button name="unlock"
                                                value="<%=allUsers.get(i).getSchoolEmail()%>"
                                                type="submit" uk-icon="icon: unlock"></button>
                                    </form>
                                    <%
                                        }
                                    %>
                                </td>
                                <td><a href="#<%=allUsers.get(i).getUsername()%>"
                                       uk-icon="icon: file-edit" uk-toggle></a></td>
                                <td>
                                    <%
                                        if (allUsers.get(i).getBanned() == 1) {
                                    %>
                                    <form method="Post" action="adminUnban">
                                        <button name="ban"
                                                value="<%=allUsers.get(i).getSchoolEmail()%>"
                                                type="submit" uk-tooltip="Unban this user"
                                                uk-icon="icon: close"></button>
                                    </form>
                                    <%
                                    } else {
                                    %>
                                    <form method="Post" action="adminBan">
                                        <button name="unban"
                                                value="<%=allUsers.get(i).getSchoolEmail()%>"
                                                type="submit" uk-tooltip="Ban this user"
                                                uk-icon="icon: user"></button>
                                    </form>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            </tbody>


                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--Modal !-->
        <div id="createUserModal" uk-modal>
            <div class="uk-modal-dialog">
                <button class="uk-modal-close-default" type="button" uk-close></button>
                <div class="uk-modal-header">
                    <h2 class="uk-modal-title">Create User</h2>
                </div>
                <div class="uk-modal-body">
                    <form class="uk-grid-small" uk-grid method="Post"
                          action="adminCreateUser">
                        <div class="uk-width-1-2 uk-from-controls">
                            <input name="firstName" class="uk-input" type="text"
                                   placeholder="First Name">
                        </div>
                        <div class="uk-width-1-2">
                            <label class="uk-form-label" for="lastName"> </label> <input
                                name="lastName" class="uk-input" type="text"
                                placeholder="Last Name" required>
                        </div>
                        <div class="uk-width-1-2">
                            <input name="username" class="uk-input" type="text"
                                   placeholder="Username" required>
                        </div>
                        <div class="uk-width-1-2">
                            <input name="phoneNumber" class="uk-input" type="number"
                                   placeholder="Phone Number" required>
                        </div>
                        <div class="uk-width-1-1">
                            <input name="personalEmail" class="uk-input" type="email"
                                   placeholder="Personal Email" required>
                        </div>
                        <div class="uk-width-1-1">
                            <input name="benedictineEmail" class="uk-input" type="email"
                                   placeholder="Benedictine Email" required>
                        </div>
                        <div class="uk-width-1-2">
                            <input name="password" class="uk-input" type="password"
                                   placeholder="Password" required>
                        </div>
                        <div
                                class="uk-margin uk-grid-small uk-child-width-auto uk-grid uk-width-1-1">
                            <label><input class="uk-radio" type="radio"
                                          name="accountType" value="Admin"> Admin</label> <label><input
                                class="uk-radio" type="radio" name="accountType" value="User">
                            User</label>
                        </div>
                        <button
                                class="uk-button uk-button-default uk-modal-close uk-width-1-2"
                                type="button">Close
                        </button>
                        <input class="uk-button uk-button-primary uk-width-1-2"
                               type="submit"></input>
                    </form>
                </div>
            </div>
        </div>

        <%
            for (int j = 0; j < allUsers.size(); j++) {
        %>
        <!--Edit Modal !-->
        <div id="<%=allUsers.get(j).getUsername()%>" uk-modal>
            <div class="uk-modal-dialog">
                <button class="uk-modal-close-default" type="button" uk-close></button>
                <div class="uk-modal-header">
                    <h2 class="uk-modal-title">Edit User</h2>
                </div>
                <div class="uk-modal-body">
                    <form class="uk-grid-small" uk-grid method="Post"
                          action="adminEditUser">
                        <div class="uk-width-1-2 uk-from-controls">
                            <label class="uk-form-label" for="firstNameEdit">First
                                Name</label> <input id="firstNameEdit" class="uk-input"
                                                    name="firstNameEdit" type="text"
                                                    value="<%=allUsers.get(j).getFirstName()%>">
                        </div>
                        <div class="uk-width-1-2">
                            <label class="uk-form-label" for="lastNameEdit">Last
                                Name</label> <input id="lastNameEdit" class="uk-input"
                                                    name="lastNameEdit" type="text"
                                                    value="<%=allUsers.get(j).getLastName()%>">
                        </div>
                        <div class="uk-width-1-2">
                            <label class="uk-form-label" for="usernameEdit">Username</label>
                            <input id="usernameEdit" class="uk-input" name="usernameEdit"
                                   type="text" value="<%=allUsers.get(j).getUsername()%>">
                        </div>
                        <%--   <div class="uk-width-1-2">
                    <label class="uk-form-label" for="phoneNumberEdit">Phone Number</label>
                    <input id="phoneNumberEdit" class="uk-input" name="phoneNumberEdit" type="number"
                           value="<%=allUsers.get(j).getPhoneNumber()%>">
                </div> --%>
                        <div class="uk-width-1-1">
                            <label class="uk-form-label" for="personalEmailEdit">Personal
                                Email</label> <input id="personalEmailEdit" class="uk-input"
                                                     name="personalEmailEdit" type="email"
                                                     value="<%=allUsers.get(j).getEmail()%>">
                        </div>
                        <div class="uk-width-1-1">
                            <label class="uk-form-label" for="benedictineEmailEdit">Benedictine
                                Email</label> <input id="benedictineEmailEdit" class="uk-input"
                                                     name="schoolEmailEdit" type="email"
                                                     value="<%=allUsers.get(j).getSchoolEmail()%>">
                        </div>
                        <div class="uk-width-1-1">
                            <label class="uk-form-label" for="passwordEdit">Password</label>
                            <input id="passwordEdit" class="uk-input" name="passwordEdit"
                                   type="password" value="<%=allUsers.get(j).getPassword()%>">
                        </div>
                        <div
                                class="uk-margin uk-grid-small uk-child-width-auto uk-grid uk-width-1-1">
                            <%
                                if (allUsers.get(j).getAdminLevel() == 1) {
                            %>
                            <label><input class="uk-radio" type="radio"
                                          name="accountType" value="Admin" checked="checked" required>
                                Admin</label> <label><input class="uk-radio" type="radio"
                                                            name="accountType" value="User"> User</label>
                            <%
                            } else {
                            %>
                            <label><input class="uk-radio" type="radio"
                                          name="accountType" value="Admin" required> Admin</label> <label><input
                                class="uk-radio" type="radio" name="accountType" value="User"
                                checked="checked"> User</label>
                            <%
                                }
                            %>
                        </div>
                        <button
                                class="uk-button uk-button-default uk-modal-close uk-width-1-2"
                                type="button">Close
                        </button>
                        <input class="uk-button uk-button-primary uk-width-1-2"
                               type="submit"></input>
                    </form>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>