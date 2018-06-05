<div class="uk-card uk-card-default uk-padding-small uk-card-body uk-margin-auto-vertical">
    <div class="uk-card-media-top">
        <div uk-slideshow="autoplay-interval: 2000" uk-slideshow>
            <ul class="uk-slideshow-items">

                <c:forEach items="${listing.images}" var="listingImages">
                    <div uk-lightbox>
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
            <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous
               uk-slideshow-item="previous"></a>
            <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next
               uk-slideshow-item="next"></a>

        </div>
    </div>

    <div class="uk-card-body">
        <!-- Name -->
        <div class="name uk-margin-remove-top uk-margin-small-bottom" style="font-size: 22px;">

            <a href="/listing?l=${listing.id}"><strong class="uk-text-danger">${listing.name}</strong></a>
            <c:if test="${listing.user.getUserID() != sessionScope.user.userID }">
                <div
                        class="watch-item color1 uk-position-medium uk-position-top-right"
                        id="${listing.id}">
                    <a uk-icon="icon: star; ratio: 1"></a>
                </div>
                <div
                        class="watch-item color2 uk-position-medium uk-position-top-right"
                        id="${listing.id}" style="display: none;">
                    <a uk-icon="icon: star; ratio: 2"></a>
                </div>
            </c:if>
        </div>

        <!-- Button & Price -->
        <c:choose>
            <c:when test="${listing.type == 'auction'}">
                <c:choose>
                    <c:when test="${listing.ended == 1}">
                        <div class="price" style="font-size: 16px;">
                            <span class="uk-badge">Current Bid: $${listing.highestBid}</span>
                            <a
                                    class="uk-button uk-button-text"
                                    style="color: red; margin-left: 5px;"
                                    id="bidButton${listing.id}">Place
                                Bid</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="price" style="font-size: 16px;">
                            <span class="uk-badge">Current Bid: $${listing.highestBid}</span>
                            <a
                                    class="uk-button uk-button-text" style="color: cornflowerblue; margin-left: 5px"
                                    uk-toggle="target: #placeBidModal${listing.id}" id="bidButton${listing.id}">Place
                                Bid</a>
                            <c:if test="${listing.highestBidder.userID == sessionScope.user.userID}">
                                <a title="Cancel Bid" uk-icon="icon: ban"
                                   uk-toggle="target: #cancelBid${listing.id}Modal"
                                   style="margin-left: 10px; color: red;"></a>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="uk-grid-small" uk-grid>
                    <div class=" uk-width-1-1 uk-align-center uk-margin-remove-bottom">
                        <p class="uk-margin-medium-top uk-align-center listing-ended"
                           style="color: red; font-size: 16px; display: none;">
                            <br>
                            Listing Ended</p>
                        <div class="uk-grid-small uk-countdown uk-margin-remove uk-align-center" uk-grid
                             uk-countdown="date: ${listing.endTimestamp}">
                        <span class="uk-days">
                            <strong class="uk-countdown-number uk-countdown-days" style="font-size: 18px"></strong>
                            <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                    style="font-size: 18px">Days</strong>
                        </span>
                            <span class="uk-hours">
                            <strong class="uk-countdown-number uk-countdown-hours" style="font-size: 18px"></strong>
                            <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                    style="font-size: 18px">Hours</strong>
                        </span>
                            <span class="uk-minutes">
                            <strong class="uk-countdown-number uk-countdown-minutes" style="font-size: 18px"></strong>
                            <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                    style="font-size: 18px">Minutes</strong>
                        </span>
                            <span class="uk-seconds">
                            <strong class="uk-countdown-number uk-countdown-seconds" style="font-size: 18px"></strong>
                            <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                    style="font-size: 18px">Seconds</strong></strong>
                        </span>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:when test="${listing.type == 'fixed'}">
                <div class="price" style="font-size: 16px;">
                            <span class="uk-badge"
                                  id="currentBid${listing.id}">Price: $${listing.price}</span>
                    <button class="uk-button uk-button-default uk-button-small" style="margin-left: 5px"
                            uk-toggle="target: #buyItNowModal${listing.id}">Buy
                    </button>
                </div>
            </c:when>
        </c:choose>
    </div>
</div>
<%@include file="bid-buy-modals.jsp" %>