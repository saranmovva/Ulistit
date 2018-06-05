<!-- This is the modal -->
<div id="buyItNowModal${listing.id}" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <form method="get" action="/buy">
            <h2 class="uk-modal-title uk-text-center">Buy Listing <strong
                    class="uk-text-danger">${listing.name}</strong> For
                <strong class="uk-text-danger">$${listing.price}</strong></h2>
            <hr>

            <div class="uk-position-relative uk-visible-toggle uk-light uk-margin-medium" uk-slider="center: true">

                <ul class="uk-slider-items uk-grid">
                    <c:forEach items="${listing.images}" var="image" varStatus="loop">
                        <li class="uk-width-3-4">
                            <div class="uk-panel">
                                <img src="${pageContext.request.contextPath}/directory/${image.image_path}/${image.image_name}"
                                     alt="Listing" style="height: auto; width: auto">
                            </div>
                        </li>
                    </c:forEach>
                </ul>

                <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous
                   uk-slider-item="previous" style="color: black"></a>
                <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next
                   uk-slider-item="next" style="color: black"></a>

            </div>
            <div class="uk-modal-footer uk-margin-small-bottom">
                <input type="hidden" value="${listing.id}" name="l">
                <button class="uk-button uk-button-muted uk-modal-close uk-border-rounded uk-align-left"
                        type="button">Cancel
                </button>
                <button class="uk-button uk-button-primary uk-border-rounded uk-align-right" type="submit">Yes</button>
            </div>
        </form>
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