<div id="offer${offer.offerID}" class="uk-flex-top" uk-modal>
    <div class="uk-modal-dialog uk-margin-auto-vertical">
        <button class="uk-modal-close-default" type="button" uk-close></button>

        <div class="uk-container uk-container-large uk-flex-middle uk-align-center">

            <div class="uk-modal-header uk-text-center">
                <h2 class="uk-modal-title"><strong>Offer details</strong></h2>
            </div>

            <div class="uk-modal-body">

                <div class="uk-grid uk-text-center" uk-grid>

                    <div class="uk-width-1-2">
                        <strong>Offer maker:</strong>
                        <p>${offer.offerMaker.username}</p>
                    </div>
                    <div class="uk-width-1-2">
                        <strong> Status:</strong>
                        <p>${offer.status}</p>
                    </div>

                    <!-- Split -->

                    <div class="uk-width-1-2">
                        <strong>Listing:</strong>
                        <p>${offer.listingID.name}</p>
                    </div>
                    <div class="uk-width-1-2">
                        <strong>Date offer was made:</strong>
                        <p>${offer.dateCreated}</p>
                    </div>

                    <!-- Split -->

                    <div class="uk-width-1-2">
                        <strong>Amount offered:</strong>
                        <p>${offer.offerAmount}</p>
                    </div>
                    <div class="uk-width-1-2">
                        <strong> Offer Message:</strong>
                        <p>${offer.offerMessage}</p>
                    </div>

                </div>

            </div>

            <div class="uk-modal-footer">
                <c:if test="${offer.status.equals('pending') && sessionScope.user.userID == offer.offerReceiver.userID}">

                    <div class="uk-float-left uk-padding-remove">
                        <button id="rejectButton" class="uk-button uk-border-rounded"
                                style="background-color: #f3565d" name="listing"
                                value="${offer.listingID.id}"><strong>Reject offer</strong>
                        </button>
                    </div>
                    <div class="uk-float-right uk-padding-remove">
                        <button id="acceptButton" class="uk-button uk-border-rounded"
                                style="background-color: #5cb85c" name="listing"
                                value="${offer.listingID.id}"><strong>Accept offer</strong>
                        </button>
                    </div>
                </c:if>

            </div>

        </div>
    </div>
</div>

<script>

    // Fills the modal with data
    <%--function offerClick(offerdata) {--%>
    <%--$(document).ready(function () {--%>
    <%--var text = "";--%>
    <%--$.ajax({--%>
    <%--url: '/offerDetails',--%>
    <%--type: 'GET',--%>
    <%--data: {offerId: offerdata},--%>
    <%--dataType: 'json',--%>
    <%--contentType: 'application/json',--%>
    <%--success: function (result) {--%>
    <%--if (result != null) {--%>
    <%--if (result.status == 'pending') {--%>
    <%--text += '<div class="uk-modal-dialog uk-margin-auto-vertical">' +--%>
    <%--'<button class="uk-modal-close-default" type="button" uk-close></button>' +--%>
    <%--'<div class="uk-container uk-container-large uk-flex-middle uk-align-center">' +--%>
    <%--'<div class="uk-modal-header uk-text-center">' +--%>
    <%--'<h2 class="uk-modal-title"><strong>Offer details</strong></h2>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-modal-body">' +--%>
    <%--'<div class="uk-grid uk-text-center" uk-grid>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong>Offer maker:</strong>' +--%>
    <%--'<p>' + result.offerMaker + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong> Status:</strong>' +--%>
    <%--'<p>' + result.offerStatus + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong>Listing:</strong>' +--%>
    <%--'<p>' + result.listingName + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong>Date offer was made:</strong>' +--%>
    <%--'<p>' + result.offerDateCreated + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong>Amount offered:</strong>' +--%>
    <%--'<p>' + result.offerMessage + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong> Offer Message:</strong>' +--%>
    <%--'<p>' + result.offerMessage + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'</div>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-modal-footer">' +--%>
    <%--'<div class="uk-float-left uk-padding-remove">' +--%>
    <%--'<button id="rejectButton" class="uk-button uk-border-rounded"' +--%>
    <%--'style="background-color: #f3565d" name="listing"' +--%>
    <%--'value="' + result.offerListingID + '"><strong>Reject offer</strong>' +--%>
    <%--'</button>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-float-right uk-padding-remove">' +--%>
    <%--'<button id="acceptButton" class="uk-button uk-border-rounded"' +--%>
    <%--'style="background-color: #5cb85c" name="listing"' +--%>
    <%--'value="result.offerListingID"><strong>Accept offer</strong>' +--%>
    <%--'</button>' +--%>
    <%--'</div>' +--%>
    <%--'</div>' +--%>
    <%--'</div>' +--%>
    <%--'</div>';--%>
    <%--} else {--%>
    <%--text += '<div class="uk-modal-dialog uk-margin-auto-vertical">' +--%>
    <%--'<button class="uk-modal-close-default" type="button" uk-close></button>' +--%>
    <%--'<div class="uk-container uk-container-large uk-flex-middle uk-align-center">' +--%>
    <%--'<div class="uk-modal-header uk-text-center">' +--%>
    <%--'<h2 class="uk-modal-title"><strong>Offer details</strong></h2>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-modal-body">' +--%>
    <%--'<div class="uk-grid uk-text-center" uk-grid>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong>Offer maker:</strong>' +--%>
    <%--'<p>' + result.offerMaker + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong> Status:</strong>' +--%>
    <%--'<p>' + result.offerStatus + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong>Listing:</strong>' +--%>
    <%--'<p>' + result.listingName + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong>Date offer was made:</strong>' +--%>
    <%--'<p>' + result.offerDateCreated + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong>Amount offered:</strong>' +--%>
    <%--'<p>' + result.offerMessage + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-width-1-2">' +--%>
    <%--'<strong> Offer Message:</strong>' +--%>
    <%--'<p>' + result.offerMessage + '</p>' +--%>
    <%--'</div>' +--%>
    <%--'</div>' +--%>
    <%--'</div>' +--%>
    <%--'<div class="uk-modal-footer">' +--%>
    <%--'</div>' +--%>
    <%--'</div>' +--%>
    <%--'</div>';--%>
    <%--}--%>
    <%--}--%>

    <%--$("offer${offer.offerID}").empty();--%>
    <%--$("offer${offer.offerID}").append(text);--%>

    <%--setTimeout((function () {--%>
    <%--UIkit.modal('#offer${offer.offerID}').show();--%>
    <%--}), 1000)--%>
    <%--}--%>

    <%--});--%>
    <%--});--%>
    <%--}--%>

    // Calls button method within modal
    $("#acceptButton").click(function (e) {
        console.log($(this).val());
        $.ajax({
            url: 'acceptOfferAjax',
            type: 'POST',
            data: {listing: $(this).val()},
            success: function (result) {
                console.log(result);
                if (result) {
                    UIkit.modal("#offer${offer.offerID}").hide();
                    UIkit.notification({message: 'Congratulations!', status: 'success'})
                }
                else {
                    UIkit.notification({
                        message: 'An error occurred while accepting this offer. Please contact an admin.',
                        status: 'danger'
                    })
                }
            }

        });
    });

    // Calls button method within modal
    $("#rejectButton").click(function (e) {
        console.log($(this).val());
        $.ajax({
            url: 'rejectOfferAjax',
            type: 'POST',
            data: {listing: $(this).val()},
            success: function (result) {
                console.log('This is a result' + result);
                if (result) {
                    UIkit.modal("#offer${offer.offerID}").hide();
                    UIkit.notification({message: 'Offer has been rejected.', status: 'success'})
                }
                else {
                    UIkit.notification({
                        message: 'An error occurred while rejecting this offer. Please contact an admin.',
                        status: 'danger'
                    })
                }
            }
        });
    });
</script>

