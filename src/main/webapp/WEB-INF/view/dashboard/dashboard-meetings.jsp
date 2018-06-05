<div>
    <div class="uk-card uk-card-small uk-card-default uk-border-rounded">
        <%@include file="tableHeaders/meeting-table-header.jsp" %>
        <div class="uk-card-body">
            <table
                    class="uk-table uk-table-hover uk-table-middle uk-table-divider">
                <thead>
                <tr>
                    <th>User</th>
                    <th>Time</th>
                    <th>Location</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pickup" items="${pickUps}">

                    <c:if test="${user.userID == pickup.transaction.buyer.userID}">
                        <c:set var="User" scope="application" value="${pickup.transaction.seller}"/>
                    </c:if>
                    <c:if test="${user.userID == pickup.transaction.seller.userID}">
                        <c:set var="User" scope="application" value="${pickup.transaction.buyer}"/>
                    </c:if>

                    <tr>
                        <td><img class="uk-preserve-width uk-border-circle"
                        <c:if test="${user.userID == pickup.transaction.buyer.userID}">
                                 uk-tooltip="${pickup.transaction.seller.username}"
                        </c:if>
                        <c:if test="${user.userID == pickup.transaction.seller.userID}">
                                 uk-tooltip="${pickup.transaction.buyer.username}"
                        </c:if>
                                 src="${pageContext.request.contextPath}/directory/${User.getMainImage()}"
                                 height="auto" width="40" alt=""></td>
                        <td class="uk-preserve-width">${pickup.pickUpTimestamp}</td>
                        <td class="uk-preserve-width uk-table-link">${pickup.location.name}</td>
                        <td class="uk-text-nowrap">
                            <div class="uk-text-right uk-float-right uk-flex-right"
                                 uk-tooltip="title: More info">
                                <a onclick="UIkit.modal('#pickUp${pickup.pickUpID}').show();"><i
                                        class="fas fa-ellipsis-v"></i></a>
                            </div>
                        </td>
                    </tr>
                    <%@include file="tableModals/pickUp-details-modal.jsp" %>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>