<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <div class="uk-float-left">
        <ul class="uk-iconnav uk-iconnav-vertical">
            <li><a href="#" uk-icon="icon: plus"></a></li>
            <li uk-tooltip="title: Edit; pos: left"><a href="edit?listing=${listing.id}" uk-icon="icon: file-edit"></a>
            </li>
            <li><a href="#" uk-icon="icon: copy"></a></li>
            <li uk-tooltip="title: Cancel; pos: left"><a onclick="UIkit.modal('#cancel-auction${listing.id}').show();"
                                                         uk-icon="icon: close"></a></li>
            <li><a href="#" uk-icon="icon: trash"></a></li>
            <c:if test="${listing.type=='auction'}">
            <li><button uk-toggle="target: #modal${listing.id}" uk-icon="icon: refresh" type="button"></button></li>
            </c:if>
        </ul>
        <%@include file="../listing/cancel-auction.jsp" %>
    </div>
    <div class="uk-card uk-card-default uk-float-left uk-box-shadow-hover-large" style="height: auto; width: 80%">
        <div class="uk-card-media-top">
            <div uk-slideshow="autoplay-interval: 2000" uk-slideshow>
                <ul class="uk-slideshow-items">
                    <c:forEach items="${listing.images}" var="listingImages">
                        <div uk-lightbox>
                            <li>
                                <div class="uk-position-center uk-dark">
                                    <img
                                         src="${pageContext.request.contextPath}/directory/${listingImages.image_path}/${listingImages.image_name}"
                                         alt="Listing">
                                    <div class="uk-visible-toggle">
                                        <div class="uk-invisible-hover uk-overlay-default uk-position-cover">
                                            <div class="uk-position-center">
                                                <a href="${pageContext.request.contextPath}/directory/${listingImages.image_path}/${listingImages.image_name}"
                                                   title="Image"><span uk-tooltip="title: View Image"
                                                                       uk-icon="icon: search; ratio: 2"></span></a>
                                            </div>
                                        </div>
                                    </div>
                                    <input class="timestamp" data-timestamp="${listing.dateCreated.getTime()}"
                                           type="hidden">

                                </div>
                            </li>
                        </div>
                    </c:forEach>
                </ul>
                <a class="uk-position-top-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous
                   uk-slideshow-item="previous"></a>
                <a class="uk-position-top-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next
                   uk-slideshow-item="next"></a>

            </div>
        </div>
        <div class="uk-card-body">
            <!-- Name -->
            <h3 class="uk-card-title" style="font-size: 100%"><a href="/listing?l=${listing.id}"
                                                                 class="uk-text-danger">${listing.name}</a></h3>
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

            <!-- Price -->
            <c:choose>
                <c:when test="${listing.type == 'auction'}">
                    <!-- Shows the highest bid for a listing that is an auction -->
                    <div class="price" style="font-size: 80%;">
                        <span class="uk-badge" style="font-size: 90%;">Highest Bid: $${listing.highestBid}</span>
                    </div>
                    <!-- Countdown for auctions -->
                    <div class="uk-grid-small" uk-grid>
                        <div class=" uk-width-1-1 uk-align-center uk-margin-remove-bottom">
                            <p class="uk-margin-medium-top uk-align-center listing-ended"
                               style="color: red; font-size: 90%; display: none;">
                                <br>
                                Listing Ended</p>
                            <div class="uk-grid uk-countdown uk-margin-remove uk-float-left uk-padding-remove-left uk-align-center"
                                 uk-grid
                                 uk-countdown="date: ${listing.endTimestamp}">
                        <span class="uk-days">
                            <strong class="uk-countdown-number uk-countdown-days" style="font-size: 80%"></strong>
                            <strong class="uk-countdown-label uk-margin-small-top "
                                    style="font-size: 70%">Days</strong>
                        </span>
                                <span class="uk-hours">
                            <strong class="uk-countdown-number uk-countdown-hours" style="font-size: 80%"></strong>
                            <strong class="uk-countdown-label uk-margin-small-top "
                                    style="font-size: 70%">Hours</strong>
                        </span>
                                <span class="uk-minutes">
                            <strong class="uk-countdown-number uk-countdown-minutes" style="font-size: 80%"></strong>
                            <strong class="uk-countdown-label uk-margin-small-top "
                                    style="font-size: 70%">Minutes</strong>
                        </span>
                                <span class="uk-seconds">
                            <strong class="uk-countdown-number uk-countdown-seconds" style="font-size: 80%"></strong>
                            <strong class="uk-countdown-label uk-margin-small-top "
                                    style="font-size: 70%">Seconds</strong></strong>
                        </span>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:when test="${listing.type == 'fixed'}">
                    <div class="price" style="font-size: 80%;">
                            <span class="uk-badge"
                                  id="currentBid${listing.id}" style="font-size: 90%;">Price: $${listing.price}</span>
                    </div>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>
<c:if test="${listing.type=='auction'}">
<div id="modal${listing.id}" uk-modal>
    <div class="uk-modal-dialog">
        <button class="uk-modal-close-default" type="button" uk-close></button>
        <div class="uk-modal-header">
            <h2 class="uk-modal-title">Relist a Listing</h2>
        </div>
        <form method="post" action="/relistListing">
        <div class="uk-modal-body">
            <div class="uk-width-1-2@m uk-width-1-1@s" id="dateEnd">
                <strong>Change End Date</strong><input type="date"
                                                class="uk-input" id="endDate"
                                                name="endDate"
                                                placeholder="End Date"  min="">
            </div>
            <div class="uk-width-1-2@m uk-width-1-1@s" id="timeEnd">
                <strong>Change End Time</strong><input type="time"
                                                class="uk-input" id="endTime"
                                                name="endTime"
                                                placeholder="End Time">
            </div>

            <input type="number" value="${listing.id}" name="listingId" hidden>

        </div>
        <div class="uk-modal-footer uk-text-right">
            <button class="uk-button uk-button-default uk-modal-close" type="button">Cancel</button>
            <button class="uk-button uk-button-primary" type="submit">Save</button>
        </div>
        </form>
    </div>
</div>
</c:if>


