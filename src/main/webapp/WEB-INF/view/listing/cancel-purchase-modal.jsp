<div id="cancelPurchaseModal" class="uk-modal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body uk-border-rounded uk-text-large uk-grid-small" uk-grid>
        <button class="uk-modal-close uk-position-large uk-position-top-right" type="button"
                uk-close></button>
        <div class="uk-text-center uk-width-1-1 uk-margin-small-bottom"><h1>Canceling A Purchase</h1></div>

        <!-- Left Side -->
        <div class="uk-tile-muted uk-tile-large uk-padding-small uk-border-rounded uk-box-shadow-medium">
            <h2 class="uk-text-center">How It Works</h2>
            <ul class="uk-list">

                <li class="uk-padding-small">Cancelling a purchase cannot be undone.</li>
                <li class="uk-padding-small">You will be charged a <b>cancellation fee</b> of <b>10%</b> of the
                    listing's
                    cost.
                </li>
                <li class="uk-padding-small">All fees <b>must</b> be paid with PayPal.</li>

                <c:choose>
                    <c:when test="${sessionScope.user.userID == listing.user.userID}">
                        <!-- If seller is canceling -->
                        <li class="uk-padding-small">Cancellation fees go directly to the buyer.</li>
                    </c:when>
                    <c:otherwise>
                        <!-- If buyer is canceling -->
                        <li class="uk-padding-small">Cancellation fees go directly to the seller</u>.</li>
                    </c:otherwise>
                </c:choose>

                <li>
                    <hr>
                </li>

                <li>
                    <span>
                        <b class="uk-padding-small uk-float-left">Cancellation Fee</b>
                        <c:choose>
                            <c:when test="${listing.type == 'auction'}">
                                <b class="uk-padding-small uk-float-right"
                                   style="color: red">$${listing.highestBid * 0.10}</b>
                            </c:when>
                            <c:otherwise>
                                <b class="uk-padding-small uk-float-right"
                                   style="color: red">$${listing.price * 0.10}</b>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </li>
            </ul>
        </div>

        <!-- Footer -->
        <div class="uk-width-1-1 uk-margin-medium-top">
            <form action="/cancel-overview" method="get">
                <input type="hidden" name="l" value="${listing.id}">
                <button class="uk-button-large uk-button-danger uk-border-rounded uk-float-right uk-box-shadow-hover-large"
                        type="submit">
                    Continue With Cancellation
                </button>
            </form>
        </div>
    </div>
</div>