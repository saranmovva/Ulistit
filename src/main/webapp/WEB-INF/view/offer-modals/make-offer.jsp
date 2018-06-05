<div id="make-offer${listing.id}" class="uk-flex-top" uk-modal>
    <div class="uk-modal-dialog uk-margin-auto-vertical">
        <button class="uk-modal-close-default" type="button" uk-close></button>

        <div class="uk-container uk-container-large uk-flex-middle uk-align-center">

            <div class="uk-modal-header uk-text-center">
                <h2 class="uk-modal-title"><strong>Make an offer</strong></h2>
            </div>

            <div class="uk-modal-body">

                <div class="uk-width-1-1 uk-align-center">
                    <strong>Offer amount</strong><input type="number" min="1" class="uk-input"
                                                        id="price" name="offer-amount" placeholder="$1"
                                                        required>
                </div>
                <div class="uk-width-1-1 uk-align-center">
                    <strong> Offer Message (Optional): </strong>
                    <textarea class="uk-textarea" type="textarea" name="offer-message"
                              id="message" placeholder="I can thrown in a slide rule to go with the money."
                              maxlength="140" rows="7"></textarea>
                    <span class="help-block"><p id="characterLeft"
                                                class="help-block "></span>
                    <input type="hidden" id="listing" name="listing" value="${listing.id}">
                </div>

            </div>

            <div class="uk-modal-footer">
                <button id="offerButton" class="uk-button-primary uk-border-rounded uk-button-large uk-float-right"
                        value="${listing.id}">Confirm offer
                </button>
            </div>

        </div>
    </div>
</div>

<script>

    $(document).ready(function () {
        $('#price').keyup(function () {
            console.log($(this).val());
            if ($(this).val() > 0) {
                $("#offerButton").prop("disabled", false);
                $("#price").removeClass("uk-form-danger").addClass("uk-form-success")
                $('#price').attr('uk-tooltip', 'Offer amount is valid');
            }
            else {
                $("#offerButton").prop("disabled", true);
                $("#price").removeClass("uk-form-success").addClass("uk-form-danger")
                $('#price').attr('uk-tooltip', 'Offer amount is invalid');
            }
        });
    });

    $("#offerButton").click(function (e) {
        console.log($(this).val());
        $.ajax({
            url: 'makeOfferAjax',
            type: 'POST',
            data: {listing: $(this).val(), offerAmount: $("#price").val(), offerMessage: $("#message").val()},
            success: function (result) {
                console.log(result);
                if (result) {
                    UIkit.modal("#make-offer${listing.id}").hide();
                    UIkit.notification({message: 'Your offer has been sent!', status: 'success'})
                }
                else {
                    UIkit.notification({
                        message: 'An error occurred while sending your offer. Please contact an admin.',
                        status: 'danger'
                    })
                }
            }

        });
    });
</script>