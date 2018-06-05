<%@include file="jspf/header.jsp" %>
<body class="uk-height-viewport uk-background-muted">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <%@include file="jspf/navbar.jspf" %>

    <%@include file="jspf/messages.jsp" %>

    <div class="uk-align-center uk-section uk-background-muted">
        <div class="uk-margin">
            <h2 class="uk-heading-line uk-text-center"><span>Seller Reviews</span></h2>
        </div>
        <div class="uk-width-3-4 uk-align-center">
            <h3><strong class="uk-text-danger uk-text-large"> ${user.username}</strong> has sold <strong
                    class="uk-text-danger"> ${sellerTransactions.size()}</strong> item(s)</h3>
            <div class="uk-tile uk-padding-remove-top uk-padding-remove-bottom uk-padding-remove-right uk-padding-remove-left uk-box-shadow-medium uk-box-shadow-hover-large uk-tile-default">
                <table
                        class="uk-table uk-margin-remove-top uk-table-hover uk-table-striped">
                    <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Buyer</th>
                        <th>Transaction Rating</th>
                        <th>Transaction Review</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="transaction" items="${sellerTransactions}">
                        <tr>
                            <td>${transaction.listingID.name}</td>
                            <td><a href="${pageContext.request.contextPath}/viewProfile?id=${transaction.buyer.userID}">${transaction.buyer.username}</a></td>
                            <c:choose>
                                <c:when test="${transaction.transRating < 1}">
                                    <td><i>The buyer has not yet rated this transaction!</i></td>
                                </c:when>
                                <c:when test="${transaction.transRating == 1}">
                                    <td><i class="fas fa-star"></i><i class="far fa-star"></i><i
                                            class="far fa-star"></i><i class="far fa-star"></i><i
                                            class="far fa-star"></i></td>
                                </c:when>
                                <c:when test="${transaction.transRating == 2}">
                                    <td><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="far fa-star"></i><i
                                            class="far fa-star"></i><i class="far fa-star"></i></td>
                                </c:when>
                                <c:when test="${transaction.transRating == 3}">
                                    <td><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i><i class="far fa-star"></i><i
                                            class="far fa-star"></i>
                                    </td>
                                </c:when>
                                <c:when test="${transaction.transRating == 4}">
                                    <td><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="far fa-star"></i></td>
                                </c:when>
                                <c:when test="${transaction.transRating == 5}">
                                    <td><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i></td>
                                </c:when>
                            </c:choose>
                            <td>${transaction.transReview}</td>
                            <td></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="jspf/footer.jspf" %>
</body>


</html>
