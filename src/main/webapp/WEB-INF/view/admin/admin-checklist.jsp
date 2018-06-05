<%@include file="admin-header.jsp" %>

<body class="uk-background-muted">

<%@include file="admin-navbar.jsp" %>

<%@include file="../jspf/messages.jsp" %>

<div class="uk-container">

    <div class="uk-grid">

        <h2 class="uk-align-center">Manage Default Freshman Checklist</h2>

        <div class="uk-tile-default uk-border-rounded uk-box-shadow-hover-large uk-box-shadow-medium uk-width-4-5@m uk-width-1-1@s uk-align-center">

            <table class="uk-table uk-table-hover uk-table-divider uk-text-large">
                <thead>
                <tr>
                    <th class="uk-table-expand">Item <a uk-toggle="target: #addNewItem" uk-icon="icon: plus"
                                                        style="color: green" title="Add New Item"></a>
                    </th>
                    <th></th>
                    <th class="uk-table-small">Remove</th>
                </tr>
                </thead>
                <tbody>
                <form action="/adminAddChecklistItem" method="post" id="addItemForm">
                    <tr id="addNewItem" hidden>
                        <td class="uk-table-expand">
                            <input class="uk-input" name="newItemName" required>
                        </td>
                        <td class="uk-table-small"><a uk-icon="icon: plus-circle; ratio: 1.5"
                                                      style="color: cornflowerblue" title="Add New Item"
                                                      onclick="document.getElementById('addItemForm').submit()"></a>
                        </td>
                        <td class="uk-table-small"></td>
                    </tr>
                </form>
                <c:forEach items="${defaultChecklist.items}" var="item">
                    <form action="/adminRemoveChecklistItem" method="post" id="removeItemForm${item.itemID}">
                        <input type="hidden" name="itemID" value="${item.itemID}">
                        <tr>
                            <td class="uk-table-expand">${item.name}</td>
                            <td></td>
                            <td class="uk-table-small"><a uk-icon="icon: trash"
                                                          onclick="document.getElementById('removeItemForm${item.itemID}').submit()"></a>
                            </td>
                        </tr>
                    </form>
                </c:forEach>
                </tbody>
            </table>

        </div>

    </div>

</div>

</body>
</html>
