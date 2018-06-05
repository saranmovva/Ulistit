<div id="transaction${transaction.id}" class="uk-flex-top" uk-modal>
    <div class="uk-modal-dialog uk-margin-auto-vertical">
        <button class="uk-modal-close-default" type="button" uk-close></button>

        <div class="uk-container uk-container-large uk-flex-middle uk-align-center">

            <div class="uk-modal-header uk-text-center">
                <h2 class="uk-modal-title"><strong>Transaction details</strong></h2>
            </div>

            <div class="uk-modal-body">

                <div class="uk-grid uk-text-center" uk-grid>

                    <div class="uk-width-1-2">
                        <strong>Buyer:</strong>
                        <p>${transaction.buyer.username}</p>
                    </div>
                    <div class="uk-width-1-2">
                        <strong>Seller:</strong>
                        <p>${transaction.seller.username}</p>
                    </div>
                    <div class="uk-width-1-2">
                        <strong>Listing:</strong>
                        <p>${transaction.listingID.name}</p>
                    </div>

                </div>

            </div>

            <div class="uk-modal-footer"></div>

        </div>

    </div>
</div>
<script>

    // // Fills the modal with data
    // function transactionClick(transactiondata) {
    //
    //     $.ajax({
    //         url: 'transactionDetails',
    //         type: 'GET',
    //         data: {transactionId: transactiondata},
    //         dataType: 'json',
    //         contentType: 'application/json',
    //         success: function (result) {
    //
    //             var transaction = result;
    //             var amount = window.document.getElementById('amount');
    //             var message = window.document.getElementById('message');
    //
    //             console.log(document.getElementById('amount').innerText);
    //
    //             amount.innerHTML = transaction['offerAmount'];
    //             message.textContent = transaction.offerMessage;
    //             console.log(transaction.offerAmount);
    //             console.log(transaction);
    //
    //             console.log(document.getElementById('amount').innerText);
    //
    //         }
    //
    //     });
    // }
</script>
