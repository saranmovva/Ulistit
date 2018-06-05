<%@include file="jspf/header.jsp" %>
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <body class="uk-background-muted uk-height-viewport">

    <%@include file="jspf/navbar.jspf" %>

    <%@include file="jspf/messages.jsp" %>

    <div class="uk-align-center uk-section uk-background-muted">
        <div class="uk-margin">
            <h2 class="uk-heading-line uk-text-center"><span>Listing Drafts</span></h2>
        </div>
        <div class="uk-width-5-6 uk-align-center">
            <h3>You have <strong
                    class="uk-text-danger uk-text-large"> ${userDrafts.size()}</strong> draft(s)</h3>
            <div class="uk-tile uk-padding-remove-top uk-padding-remove-bottom uk-padding-remove-right uk-padding-remove-left uk-box-shadow-medium uk-box-shadow-hover-large uk-tile-default">
                <table
                        class="uk-table uk-margin-remove-top uk-table-hover uk-table-striped">
                    <table
                            class="uk-table uk-table-hover uk-table-striped uk-table-condensed">
                        <thead>
                        <tr>
                            <th>Item Name</th>
                            <th>Item Description</th>
                            <th>Category</th>
                            <th>Sub Category</th>
                            <th>Auction Type</th>
                            <th>Price</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="draft" items="${userDrafts}">
                            <tr>
                                <td>${draft.name}</td>
                                <td>${draft.description}</td>
                                <td>${draft.category}</td>
                                <td>${draft.subCategory}</td>
                                <td>${draft.type}</td>
                                <td>$${draft.price}</td>
                                <td><a class="uk-button uk-button-secondary uk-border-rounded"
                                       href="${pageContext.request.contextPath}/createListingDraft?id=${draft.id}">Edit
                                    & Publish</a></td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="jspf/footer.jspf" %>
</body>

</div>

</html>
