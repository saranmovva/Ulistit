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
            <div class="uk-margin-bottom">
                <div class="uk-align-center uk-padding-large uk-margin-bottom" uk-grid>
                    <a class="uk-button uk-button-default uk-margin uk-padding-small uk-position-top-right"
                       href="#createUserModal" uk-toggle
                       hidden>Create
                        User</a>
                    <h2 class="uk-heading-line uk-text-center"><span>Admin Listings Panel</span></h2>
                    <table class="uk-table uk-table-small uk-table-hover uk-table-middle uk-table-divider uk-margin uk-margin-large uk-margin-bottom uk-padding-small">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Delete/Activate</th>
                            <th>Edit</th>

                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Listing> allListings = (List<Listing>) session.getAttribute("allListings");
                            for (int i = 0; i < allListings.size(); i++) {
                        %>
                        <tr>
                            <td><%=allListings.get(i).getId()%>
                            </td>
                            <td><%=allListings.get(i).getName()%>
                            </td>
                            <td><%=allListings.get(i).getUser().getUsername()%>
                            </td>
                            <td><%=allListings.get(i).getCategory()%>
                            </td>
                            <td><%=allListings.get(i).getPrice()%>
                            </td>
                            <td>
                                <%
                                    if (allListings.get(i).getActive() == 1) {
                                %>
                                <form method="Post" action="adminInactivateListing">
                                    <button name="adminInactivateListing" value="<%=allListings.get(i).getId()%>"
                                            type="submit"
                                            uk-icon="icon: trash" uk-tooltip="Delete this listing"></button>
                                </form>
                                <%
                                } else {
                                %>
                                <form method="Post" action="adminActivateListing">
                                    <button name="adminActivateListing" value="<%=allListings.get(i).getId()%>"
                                            type="submit" uk-icon="icon: check"
                                            uk-tooltip="Activate this listing"></button>
                                        <%
                                        }
                                    %>
                            </td>
                            <td>
                                <a href="/editListing?id=<%=allListings.get(i).getId()%>" uk-icon="icon: file-edit"
                                   uk-toggle></a>
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
</div>
</body>
</html>