<div class="uk-card uk-card-default ">
    <div class="uk-card-media-top">
        <div uk-slideshow="autoplay-interval: 2000" uk-slideshow>
            <ul class="uk-slideshow-items">
                <c:forEach items="${listing.images}" var="listingImages">
                    <div class="uk-border-rounded" uk-lightbox>
                        <li>
                            <a href="${pageContext.request.contextPath}/directory/${listingImages.image_path}/${listingImages.image_name}"
                               title="Image" class="thumbnail">
                                <img class="uk-align-center"
                                     src="${pageContext.request.contextPath}/directory/${listingImages.image_path}/${listingImages.image_name}"
                                     alt="Listing">
                            </a>
                        </li>
                    </div>
                </c:forEach>
            </ul>
            <a class="uk-position-center-left uk-position-small uk-hidden-hover"
               href="#" uk-slidenav-previous
               uk-slideshow-item="previous"></a>
            <a class="uk-position-center-right uk-position-small uk-hidden-hover"
               href="#" uk-slidenav-next
               uk-slideshow-item="next"></a>

        </div>
    </div>

    <div class="uk-card-body uk-padding-small">
        <div class="name uk-margin-remove-top uk-margin-small-bottom" style="font-size: 22px;">
            <c:if test="${sessionScope.user.userID != null}">
                <c:if test="${listing.user.getUserID() != sessionScope.user.userID }">


                    <div class="uk-padding-small uk-position-top-right"
                         id="${listing.id}watch">
                        <a onclick="watch(${listing.id})"> <i style="color: red;" class="far fa-heart"></i></a>


                    </div>
                    <div class="uk-padding-small uk-position-top-right"
                         id="${listing.id}unwatch" style="display: none;">
                        <a onclick="unwatch(${listing.id})"> <i style="font-size: 1.5em; color: red;"
                                                                class="fas fa-heart"></i></a>
                    </div>
                </c:if>
            </c:if>
        </div>

        <div class="name uk-margin-remove-top" style="font-size:
                                    18px;">
            <a href="/listing?l=${listing.id}"><p
                    class="uk-text-danger uk-text-uppercase">${listing.name}</p></a>
        </div>
        <div class="uk-child-width-1-2@s uk-grid-small uk-grid-match" uk-grid>
            <c:if test="${listing.type == 'fixed'}">
                <div>
                    <p style="font-size:
                                    24px;"><strong>$${listing.price}.00</strong></p>
                </div>
                <div>
                    <button class="uk-button uk-button-danger">Buy Now</button>
                </div>
            </c:if>
        </div>

        <c:if test="${listing.type == 'auction'}">
            <div class="uk-child-width-1-2@s uk-grid-small uk-grid-match uk-margin-remove-top"
                 uk-grid>
                <div>
                    <p style="font-size:
                                    24px;"><strong>$${listing.price}.00</strong><span
                            class="uk-text-meta uk-margin-small-left" style="color:
                                                   black;"> ${listing.bidCount} bids</span></p>
                </div>

                <div class="uk-margin-small-top uk-magin-small-left">
                    <a id="placeBidButton" class="uk-button uk-button-text"
                       style="color: cornflowerblue;" uk-toggle="target: #bidForm${listing.id}Div">Place Bid</a>

                    <div class="uk-margin uk-float-left" id="bidForm${listing.id}Div" hidden>
                        <form action="/placeBid" method="get" id="bidForm${listing.id}">
                            <div class="uk-inline">
                                <span class="uk-form-icon" style="color: black">$</span>
                                <a class="uk-form-icon uk-form-icon-flip"
                                   uk-icon="icon: check; ratio: 1.5" uk-tooltip="title: Place Bid"
                                   onclick="document.getElementById('bidForm${listing.id}').submit()"
                                   style="color: royalblue"></a>
                                <input class="uk-input"
                                       style="padding-left: 30px; background-color: whitesmoke; color: black"
                                       name="b"
                                       type="number"
                                       min="${listing.highestBid}" id="bidValue" required>
                                <input type="hidden" name="l" value="${listing.id}">
                            </div>
                        </form>
                    </div>

                </div>
            </div>

            <p class="uk-margin-remove-top uk-align-top listing-ended"
               style="color: red; font-size: 16px; display: none;">
                <br>
                Listing Ended</p>
            <div class="uk-grid-small uk-countdown uk-margin-remove-top uk-margin-remove-adjacent uk-align-top"
                 uk-grid
                 uk-countdown="date: ${listing.endTimestamp}">
                        <span class="uk-days">
                            <strong class="uk-countdown-number uk-countdown-days" style="font-size: 14px"></strong>
                            <strong class="uk-countdown-label uk-margin-left"
                                    style="font-size: 14px">Days</strong>
                        </span>
                <span class="uk-hours">
                            <strong class="uk-countdown-number uk-countdown-hours" style="font-size: 14px"></strong>
                            <strong class="uk-countdown-label uk-margin-left"
                                    style="font-size: 14px">Hours</strong>
                        </span>
                <span class="uk-minutes">
                            <strong class="uk-countdown-number uk-countdown-minutes" style="font-size: 14px"></strong>
                            <strong class="uk-countdown-label uk-margin-left"
                                    style="font-size: 14px">Minutes</strong>
                        </span>
                <span class="uk-seconds">
                            <strong class="uk-countdown-number uk-countdown-seconds" style="font-size: 14px"></strong>
                            <strong class="uk-countdown-label uk-margin-left"
                                    style="font-size: 14px">Seconds</strong></strong>
                        </span>
            </div>

        </c:if>
    </div>
</div>
