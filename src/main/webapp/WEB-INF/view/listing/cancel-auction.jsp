<div id="cancel-auction${listing.id}" uk-modal>
    <div class="uk-modal-dialog">
        <button class="uk-modal-close-default" type="button" uk-close></button>

        <div class="uk-container">
            <div class="uk-grid uk-margin-medium-bottom uk-align-center" uk-grid>

                <div class="uk-modal-header">
                    <h2>Cancel this auction?</h2>
                </div>
                <div class="uk-width-1-1 uk-margin-large-bottom uk-margin-small-top uk-padding-remove uk-float-right uk-modal-body">
                    <button id="cancelButton" value="${listing.id}"
                            class="uk-button-primary uk-border-rounded uk-button-large uk-float-right">Yes, cancel
                    </button>
                </div>

            </div>
        </div>
    </div>
</div>
<script>
    $("#cancelButton").click(function (e) {
        console.log($(this).val());
        $.ajax({
            url: 'cancelAuction',
            type: 'POST',
            data: {listing: $(this).val()},
            success: function (result) {
                console.log(result);
                console.log("cancel method")
                if (result) {
                    UIkit.modal("#cancel-auction${listing.id}").hide();
                    UIkit.notification({message: 'Auction has successfully been cancelled', status: 'success'})
                }
                else {
                    UIkit.notification({
                        message: 'An error occurred. Please contact an admin.',
                        status: 'danger'
                    })
                }
            }

        });
    });
</script>
