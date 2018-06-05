<!-- This is the modal -->
<div id="make-offer${offer.offerID}" uk-modal>
    <div class="uk-modal-dialog">
        <button class="uk-modal-close-default" type="button" uk-close></button>
        <div class="form-area">
            <form method="POST" class="uk-grid-large"
                  onsubmit="return validateForm()" action="confirmCounterOffer"
                  enctype="multipart/form-data" name="uploadListingForm" uk-grid>
                <br style="clear: both">

                <div class="uk-modal-header">
                    <h2 class="uk-modal-title">Make an offer</h2>
                </div>

                <div class="uk-modal-body">
                    <div class="uk-width-1-1">
                        <strong>Price</strong><input type="number" class="uk-input"
                                                     id="price" name="offer-amount"
                                                     value="${initial.offerAmount}"
                                                     placeholder="Offer" required>
                    </div>
                    <div class="uk-width-1-1">
                        <strong> Offer Message (Optional): </strong>
                        <textarea class="uk-textarea" type="textarea" name="offer-message"
                                  id="message" placeholder="Message" maxlength="140" rows="7"></textarea>
                        <span class="help-block"><p id="characterLeft"
                                                    class="help-block "></span>
                        <input type="hidden" name="initial" value="${initial.offerID}">
                    </div>

                    <div class="uk-modal-footer">
                        <div class="uk-text-right">
                            <button class="uk-button uk-button-default uk-modal-close" type="button">Cancel</button>
                            <button type="submit" id="submit" name="submit"
                                    class="btn btn-primary pull-right">Submit Form
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="placeBidModal${listing.id}" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <h2 class="uk-modal-title">Place A Bid</h2>
        <form method="post" action="/bid">
            <div class="uk-child-width-1-2@s" uk-grid>
                <div>
                    <h4>Name: ${listing.name}</h4>
                    <h4>Highest Bid: $${listing.highestBid}</h4>
                    <h4>Seller: <a
                            href="/viewProfile?id=${listing.user.userID}">${listing.user.username}</a>
                    </h4>
                </div>

                <div>
                    <h4>Bid</h4>
                    <input class="uk-input" name="bidValue" type="number"
                           min="${listing.highestBid}" id="bidValue${listing.id}">
                    <input name="listingID" type="hidden" value="${listing.id}">
                </div>
            </div>
            <p class="uk-text-right">
                <button class="uk-button uk-button-default uk-modal-close" type="button">Cancel
                </button>
                <button class="uk-button uk-button-primary" type="submit">Bid
                </button>
                <!--
                <button onclick="bid($('#bidValue${listing.id}').val(), ${listing.id});"
                        class="uk-button uk-button-primary" id="submit"
                        type="submit${listing.id}">Bid
                </button>
                -->
            </p>
        </form>
    </div>
</div>

<div id="cancelBid${listing.id}Modal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <h3 style="text-align: center;">Are you sure you want to cancel your bid?</h3>
        <hr>
        <div>
            <h4>Name: ${listing.name}</h4>
            <h4>Highest Bid: ${listing.highestBid}</h4>
            <h4>Seller: <a
                    href="/viewProfile?id=${listing.user.userID}">${listing.user.username}</a>
            </h4>
        </div>
        <p class="uk-text-right">
            <button class="uk-button uk-button-default uk-modal-close" type="button">Cancel</button>
            <a class="uk-button uk-button-primary"
               href="/cancelBid?l=${listing.id}">
                Yes
            </a>
        </p>
    </div>
</div>