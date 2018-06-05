<div id="pickUp${pickup.pickUpID}" class="uk-flex-top" uk-modal>
    <div class="uk-modal-dialog uk-margin-auto-vertical">
        <button class="uk-modal-close-default" type="button" uk-close></button>

        <div class="uk-container uk-container-large uk-flex-middle uk-align-center">

            <div class="uk-modal-header uk-text-center">
                <h2 class="uk-modal-title"><strong>Pickup Details</strong></h2>
            </div>

            <div class="uk-modal-body">

                <div class="uk-grid uk-text-center" uk-grid>

                    <div class="uk-width-1-2">
                        <strong>Buyer: </strong>
                        <p>${pickup.transaction.buyer.username}</p>
                    </div>

                    <div class="uk-width-1-2">
                        <strong>Seller: </strong>
                        <p>${pickup.transaction.seller.username}</p>
                    </div>

                    <div class="uk-width-1-2">
                        <strong>Date: </strong>
                        <p>${pickup.dateCreated}</p>
                    </div>

                    <div class="uk-width-1-2">
                        <strong>Time: </strong>
                        <p>${pickup.pickUpTimestamp}</p>
                    </div>

                    <div class="uk-width-1-2">
                        <strong>Location: </strong>
                        <p>${pickup.location.name}</p>
                    </div>

                    <div class="uk-width-1-2">
                        <strong>Item: </strong>
                        <p>${pickup.transaction.listingID.name}</p>
                    </div>

                </div>

            </div>

            <div class="uk-modal-footer"></div>

        </div>

    </div>
</div>
<script>

    // // Fills the modal with data
    //    // function pickupClick(pickupdata) {
    //    //
    //    //     $.ajax({
    //    //         url: 'transactionDetails',
    //    //         type: 'GET',
    //    //         data: {pickupId: pickupdata},
    //    //         dataType: 'json',
    //    //         contentType: 'application/json',
    //    //         success: function (result) {
    //    //
    //    //             var pickup = result;
    //    //             var amount = window.document.getElementById('amount');
    //    //             var message = window.document.getElementById('message');
    //    //
    //    //             console.log(document.getElementById('amount').innerText);
    //    //
    //    //             amount.innerHTML = pickup['offerAmount'];
    //    //             message.textContent = pickup.offerMessage;
    //    //             console.log(pickup.offerAmount);
    //    //             console.log(pickup);
    //    //
    //    //             console.log(document.getElementById('amount').innerText);
    //    //
    //    //         }
    //    //
    //    //     });
    //    // }
</script>