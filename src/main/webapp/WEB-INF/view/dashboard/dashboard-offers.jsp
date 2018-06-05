<div>
    <div class="uk-card uk-card-small uk-card-default uk-border-rounded">
        <%@include file="tableHeaders/offer-table-header.jsp" %>
        <div class="uk-card-body">
                <table
                        class="uk-table uk-table-hover uk-table-middle uk-table-divider">
                    <thead>
                    <tr>
                        <th>Listing</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="offer" items="${offers}">
                        <tr>
                            <td class="uk-text-truncate">${offer.listingID.name}</td>
                            <td class="uk-preserve-width">${offer.offerAmount}</td>
                            <td class="uk-text-nowrap">${offer.status}</td>
                            <td class="uk-text-nowrap">
                                <div class="uk-text-right uk-float-right uk-flex-right"
                                     uk-tooltip="title: More info">
                                    <a onclick="UIkit.modal('#offer${offer.offerID}').show()"><i
                                            class="fas fa-ellipsis-v"></i></a>
                                </div>
                            </td>
                        </tr>
                        <%@include file="tableModals/offer-details-modal.jsp" %>
                    </c:forEach>
                    </tbody>
                </table>
        </div>
    </div>
</div>