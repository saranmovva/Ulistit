<%@include file="../jspf/header.jsp" %>

<body class="uk-height-viewport">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <div class="uk-section uk-background-muted listing-tutorial">

        <div class="uk-margin-small-left">
            <button class="uk-button uk-button-default uk-border-rounded uk-text-center" onclick="goBack()"><span
                    class="uk-padding-remove-left" uk-icon="arrow-left"></span>Go Back
            </button>
        </div>

        <div class="uk-section uk-padding-small" uk-grid>

            <!-- LEFT SIDE -->
            <div class="uk-width-2-5@m uk-width-1-1@s">

                <div class="uk-margin-small-left uk-margin-small-right" uk-slideshow="animation: fade">

                    <ul class="uk-slideshow-items" style="min-height: 400px">

                        <c:forEach items="${listing.images}" var="image">
                            <li>
                                <img class="uk-align-center"
                                     src="${pageContext.request.contextPath}/directory/${image.image_path}/${image.image_name}"
                                     style="height: auto; width: auto; max-height: 100%; max-width: 100%;">
                            </li>
                        </c:forEach>

                    </ul>

                    <br>

                    <div class="uk-position-relative uk-visible-toggle uk-light uk-tile-muted uk-border-rounded uk-padding"
                         uk-slider>

                        <ul class="uk-slider-items uk-child-width-1-3">

                            <c:forEach items="${listing.images}" var="image" varStatus="loop">
                                <li uk-slideshow-item="${loop.index}" style="max-height: 50%; padding: 5px;">
                                    <a href="#">
                                        <img class="uk-align-center"
                                             src="${pageContext.request.contextPath}/directory/${image.image_path}/${image.image_name}"
                                             alt="Listing"
                                             style="height: auto; max-height: 100px; max-width: 100%; width: auto;"></a>
                                </li>
                            </c:forEach>

                        </ul>

                        <a class="uk-position-bottom-left uk-position-small uk-visible@m" href="#"
                           uk-slidenav-previous uk-slider-item="previous" style="color: black"></a>
                        <a class="uk-position-bottom-right uk-position-small uk-visible@m" href="#" uk-slidenav-next
                           uk-slider-item="next" style="color: black"></a>

                    </div>

                </div>
            </div>

            <!-- RIGHT SIDE -->
            <div class="uk-width-3-5@m uk-width-1-1@s">

                <!-- Help Link -->
                <%@include file="../jspf/help-icon.jsp" %>

                <c:if test="${listing.type.equals('fixed')}">

                    <div class="uk-card uk-card-body">

                        <h1 class="uk-article-title uk-margin-remove-top">
                                ${listing.name}
                        </h1>

                        <p class="uk-text-lead">${listing.description}</p>

                        <p class="uk-article-meta">Listed by <b><a
                                href="/viewProfile?id=${listing.user.userID}"
                                data-intro="Click see more about the seller." data-step="5">${listing.user.username}</a></b>
                            <a href="${pageContext.request.contextPath}/reportListing?listingId=${listing.id}"
                               class="uk-icon-button uk-margin-small-right" uk-icon="warning"
                               uk-tooltip="Report Listing"></a>
                        </p>

                        <div class="uk-grid-small uk-child-width-auto uk-tile-default uk-border-rounded uk-padding"
                             uk-grid>

                            <ul class="uk-grid-small uk-float-left uk-width-1-3 uk-padding-small uk-padding-remove-left"
                                uk-grid>
                                <li class="uk-width-1-1">
                                <span class="uk-float-left"><strong>Asking Price</strong>
                                    <b style="color: royalblue">$${listing.price}</b>
                                </span>
                                </li>

                            </ul>

                            <div class="uk-float-right uk-width-2-3 uk-grid-small" uk-grid>
                                <div class="uk-width-1-1">
                                    <c:choose>
                                        <c:when test="${listing.ended == 0}">
                                            <c:if test="${sessionScope.user.userID != listing.user.userID}">
                                                <!-- Make Offer -->
                                                <a class="uk-button uk-button-text uk-align-right"
                                                   style="color: green;"
                                                   onclick="UIkit.modal('#make-offer${listing.id}').show();">Make
                                                    offer</a>

                                                <!-- Buy Now -->
                                                <a class="uk-button uk-button-text uk-align-right"
                                                   onclick="UIkit.modal('#buyItNowModal${listing.id}').show()">Buy
                                                    Now</a>

                                                <%@include file="../offer-modals/make-offer.jsp" %>
                                                <%@include file="bid-buy-modals.jsp" %>

                                            </c:if>
                                        </c:when>

                                        <c:otherwise>
                                            <c:if test="${sessionScope.user.userID == transaction.buyer.userID || sessionScope.user.userID == listing.user.userID}">
                                                <c:choose>
                                                    <c:when test="${viewCheckout == true}">
                                                        <a href="/checkout?l=${listing.id}"
                                                           class="uk-button uk-button-text uk-align-right"
                                                           data-intro="Click here to checkout" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">Checkout</a>
                                                    </c:when>
                                                    <c:when test="${viewPickUp == true}">
                                                        <a href="/pick-up-review?l=${listing.id}"
                                                           class="uk-button uk-button-text uk-align-right"
                                                           data-intro="Click here view your pick up" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">View Pick
                                                            Up</a>
                                                    </c:when>
                                                    <c:when test="${viewPickUpDetails == true}">
                                                        <a href="/pick-up-review?l=${listing.id}"
                                                           class="uk-button uk-button-text uk-align-right"
                                                           data-intro="Click here view your pick up" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">View Pick Up
                                                            Details</a>
                                                    </c:when>
                                                    <c:when test="${viewVerification == true}">
                                                        <a uk-toggle="target: #verifyPickUpModal"
                                                           class="uk-button uk-button-text uk-align-right"
                                                           data-intro="Click here view your pick up" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">Verify Pick
                                                            Up</a>
                                                    </c:when>
                                                    <c:when test="${viewTransaction == true}">
                                                        <a href="/viewPurchaseHistory"
                                                           class="uk-button uk-button-text uk-align-right"
                                                           data-intro="Click here view your transaction" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">View
                                                            Transaction</a>
                                                    </c:when>
                                                </c:choose>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>


                        </div>
                    </div>
                </c:if>

                <c:if test="${listing.type.equals('donation')}">

                    <div class="uk-padding-small uk-margin-small-left uk-margin-small-right">
                        <article class="uk-article uk-margin-large">

                            <h1 class="uk-article-title uk-margin-remove-top">
                                <p>${listing.name}</p>
                            </h1>

                            <p class="uk-text-lead">${listing.description}</p>

                            <span class="uk-width-1-1">
                        <p class="uk-article-meta">Listed by <b><a
                                href="/viewProfile?id=${listing.user.userID}"
                                data-intro="Click here to see more about the seller."
                                data-step="5">${listing.user.username}</a></b>
                        <c:if test="${listing.ended == 1 && listing.highestBidder.userID ==
                                sessionScope.user.userID || listing.user.userID == sessionScope.user.userID && viewTransaction != 'true'}">
                            <a href="${pageContext.request.contextPath}/reportListing?listingId=${listing.id}"
                               class="uk-icon-button uk-margin-small-right" uk-icon="warning"
                               uk-tooltip="Report Listing"></a>
                        </c:if>
                            </p>
                    </span>

                            <!-- Bid Section -->
                            <div class="uk-grid-small uk-child-width-auto uk-tile-default uk-border-rounded uk-padding
                    uk-box-shadow-hover-large uk-box-shadow-medium"
                                 uk-grid>

                                <!-- Highest Bid Section -->
                                <ul class="uk-grid-small uk-width-1-1 uk-float-left" uk-grid>
                                    <li class="uk-width-1-1">
                                    <span class="uk-width-1-1">
                                        <h4 class="uk-float-left">Interested in taking this item?</h4>
                                        <a class="uk-button uk-button-text uk-float-right"
                                           style="color: cornflowerblue;"
                                           data-intro="Want to take this donated item? Click here!"
                                           data-step="1">Yes</a>
                                    </span>
                                    </li>
                                </ul>
                            </div>
                        </article>
                    </div>
                </c:if>


                <c:if test="${listing.type.equals('auction')}">

                    <div class="uk-padding-small uk-margin-small-left uk-margin-small-right">
                        <article class="uk-article uk-margin-large">

                            <h1 class="uk-article-title uk-margin-remove-top">
                                <p>${listing.name}</p>
                            </h1>

                            <p class="uk-text-lead">${listing.description}</p>

                            <span class="uk-width-1-1">
                        <p class="uk-article-meta">Listed by <b><a
                                href="/viewProfile?id=${listing.user.userID}"
                                data-intro="Click here to see more about the seller."
                                data-step="5">${listing.user.username}</a></b>
                        <c:if test="${listing.ended == 1 && listing.highestBidder.userID ==
                                sessionScope.user.userID || listing.user.userID == sessionScope.user.userID && viewTransaction != 'true'}">
                            <a class="uk-float-right"
                               data-intro="Having second thoughts about buying this listing? Click here to cancel your purchase."
                               data-step="4"
                               uk-toggle="target: #cancelPurchaseModal">Having Second
                                Thoughts?</a>
                            <a href="${pageContext.request.contextPath}/reportListing?listingId=${listing.id}"
                               class="uk-icon-button uk-margin-small-right" uk-icon="warning"
                               uk-tooltip="Report Listing"></a>
                        </c:if>
                                </p>
                    </span>

                            <!-- Bid Section -->
                            <div class="uk-grid-small uk-child-width-auto uk-tile-default uk-border-rounded uk-padding
                    uk-box-shadow-hover-large uk-box-shadow-medium"
                                 uk-grid>

                                <!-- Highest Bid Section -->
                                <ul class="uk-grid-small uk-width-2-3 uk-float-left" uk-grid>
                                    <li class="uk-width-1-1">
                                        <c:choose>
                                        <c:when test="${listing.ended == 0}">
                                        <span class="uk-float-left"><strong>Highest Bid:</strong>
                                        </c:when>
                                        <c:otherwise>
                                                <span class="uk-float-left"><strong>Winning Bid:</strong>
                                        </c:otherwise>
                                    </c:choose>
                                    <b style="color: royalblue" id="highestBid"> $${listing.highestBid}</b>
                                    </span>
                                    </li>
                                    <li class="uk-width-1-1">
                                    <span class="uk-float-left">
                                        <b>Highest Bidder:</b>
                                        <strong id="highestBidder">${listing.highestBidder.username}</strong>
                                    </span>
                                    </li>
                                    <li class="uk-width-1-1">
                                    <span class="uk-float-left">
                                        <b>Bid Count:</b>
                                        <strong id="bidCount">${listing.bidCount}</strong>
                                    </span>
                                    </li>
                                </ul>

                                <!-- Place Bid Button -->
                                <div class="uk-width-1-3 uk-float-right uk-text-right">
                                    <c:choose>
                                        <c:when test="${listing.ended == 0}">
                                            <c:if test="${listing.user.userID != user.userID}">

                                                <a id="placeBidButton" class="uk-button uk-button-text"
                                                   style="color: cornflowerblue;"
                                                   onclick="toggleBid();" data-intro="Click here to place a bid!"
                                                   data-step="1">Place Bid</a>

                                            </c:if>

                                            <div class="uk-margin uk-float-left" id="bidForm" style="display: none;">
                                                <div class="uk-inline">
                                                    <span class="uk-form-icon">$</span>
                                                    <a class="uk-form-icon uk-form-icon-flip"
                                                       uk-icon="icon: check; ratio: 1.5" uk-tooltip="title: Place Bid"
                                                       onclick="placeBid(parseInt(document.getElementById('bidValue').value))"></a>
                                                    <input class="uk-input" style="padding-left: 30px;" name="bidValue"
                                                           type="number"
                                                           min="${listing.highestBid}" id="bidValue">
                                                </div>
                                            </div>


                                        </c:when>

                                        <c:otherwise>
                                            <c:if test="${sessionScope.user.userID == listing.highestBidder.userID || sessionScope.user.userID == listing.user.userID}">
                                                <c:choose>
                                                    <c:when test="${viewCheckout == true}">
                                                        <a href="/checkout?l=${listing.id}"
                                                           class="uk-button uk-button-text"
                                                           data-intro="Click here to checkout" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">Checkout</a>
                                                    </c:when>
                                                    <c:when test="${viewPickUp == true}">
                                                        <a href="/pick-up-review?l=${listing.id}"
                                                           class="uk-button uk-button-text"
                                                           data-intro="Click here view your pick up" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">View Pick
                                                            Up</a>
                                                    </c:when>
                                                    <c:when test="${viewPickUpDetails == true}">
                                                        <a href="/pick-up-review?l=${listing.id}"
                                                           class="uk-button uk-button-text"
                                                           data-intro="Click here view your pick up" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">View Pick Up
                                                            Details</a>
                                                    </c:when>
                                                    <c:when test="${viewVerification == true}">
                                                        <a uk-toggle="target: #verifyPickUpModal"
                                                           class="uk-button uk-button-text"
                                                           data-intro="Click here view your pick up" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">Verify Pick
                                                            Up</a>
                                                    </c:when>
                                                    <c:when test="${viewTransaction == true}">
                                                        <a href="/viewPurchaseHistory"
                                                           class="uk-button uk-button-text"
                                                           data-intro="Click here view your transaction" data-step="1"
                                                           style="color: cornflowerblue; margin-left: 5px;">View
                                                            Transaction</a>
                                                    </c:when>
                                                </c:choose>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Countdown and Progress Bar -->
                            <div class="uk-grid-small" uk-grid data-intro="Place your bid before the time runs out!"
                                 data-step="2">
                                <div class="uk-width-1-1 uk-align-center">
                                    <strong class="uk-margin-small-bottom uk-margin-small-top uk-align-center listing-ended"
                                            style="color: red; font-size: 16px; display: none;">
                                        Listing Ended</strong>
                                    <div class="uk-grid-small uk-countdown uk-margin-remove uk-align-center" uk-grid
                                         uk-countdown="date: ${listing.endTimestamp}">
                                                <span class="uk-days">
                                                    <strong class="uk-countdown-number uk-countdown-days"
                                                            style="font-size: 22px;"></strong>
                                                    <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                                            style="font-size: 22px;">Days</strong>
                                                </span>
                                        <span class="uk-hours">
                                                        <strong class="uk-countdown-number uk-countdown-hours"
                                                                style="font-size: 22px;"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                                                style="font-size: 22px;">Hours</strong>

                                                </span>
                                        <span class="uk-minutes">
                                                        <strong class="uk-countdown-number uk-countdown-minutes"
                                                                style="font-size: 22px;"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                                                style="font-size: 22px;">Minutes</strong>
                                                </span>
                                        <span class="uk-seconds">
                                                        <strong class="uk-countdown-number uk-countdown-seconds"
                                                                style="font-size: 22px;"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                                                style="font-size: 22px;">Seconds</strong>
                                                </span>
                                        <span>
                                <strong style="font-size: 22px;">Remaining</strong>
                                </span>
                                    </div>
                                    <progress class="uk-progress uk-margin-remove-top" value="${listing.percentLeft}"
                                              max="100">
                                    </progress>
                                </div>
                            </div>
                        </article>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

</div>

<%@include file="bid-buy-modals.jsp" %>
<%@include file="cancel-purchase-modal.jsp" %>
<%@include file="../pickup/pick-up-verification-modal.jsp" %>

<%@include file="../jspf/footer.jspf" %>

</body>

<script>
    function toggleBid() {
        if (document.getElementById("bidForm").style.display == 'inline') {
            document.getElementById("bidForm").style.display = "none";
        } else {
            document.getElementById("bidForm").style.display = "inline";
        }
    }

    var listing;
    var userLoggedIn;

    var bidCountElement;
    var highestBidElement;
    var highestBidderElement;

    window.addEventListener("load", function () {

        bidCountElement = document.getElementById("bidCount");
        highestBidElement = document.getElementById("highestBid");
        highestBidderElement = document.getElementById("highestBidder");

        // Check For Tutorial
        $.ajax({
            type: 'GET',
            url: '/checkForTutorial',
            data: {page: "listing"},
        }).done(function (response) {
            if (response.showTutorial == 'YES') {
                setTimeout(function () {
                    startTutorial();
                }, 1500);
            }
        });

        userLoggedIn = ${sessionScope.user.userID};

        // Get Listing As JSON
        $.ajax({
            type: 'GET',
            url: '/getListingData',
            data: {listingID: ${listing.id}},
        }).done(function (response) {

            if (response.listing != 'NULL') {

                listing = response;

                var timeRemaining = listing.endTimestampInMilli - listing.startTimestampInMilli;

                // If listing is active
                if (timeRemaining > 0) {

                    // Create an event to run once a listing is over
                    setTimeout(function () {

                        if (listing.type == 'auction') {
                            // If user logged in created the listing
                            if (userLoggedIn == listing.userID && listing.bidCount > 0) {
                                displaySuccessMessage("Sold!");
                            } else if (userLoggedIn == listing.highestBidderID) {
                                displaySuccessMessage("You Won!")
                            }
                        }

                    }, timeRemaining + 1000);

                    if (listing.type == 'auction') {
                        // Set interval to update the data on the page every 1 second
                        var updateInterval = setInterval(function () {
                            $.ajax({
                                type: 'GET',
                                url: '/getListingData',
                                data: {listingID: ${listing.id}},
                            }).done(function (response) {
                                var oldWinner = listing.highestBidderID;
                                listing = response;

                                // If listing ended, stop updating data on page
                                if ((listing.endTimestampInMilli - listing.startTimestampInMilli) <= 0) {
                                    clearInterval(updateInterval);

                                    // Else update page with new data
                                } else {
                                    if (listing.highestBidderID != oldWinner && parseInt(${sessionScope.user.userID}) == oldWinner) {
                                        displayErrorMessage("You've Been Outbid");
                                    }
                                    updateDataOnPage();
                                }
                            });
                        }, 1000);
                    }

                    // If listing is over
                } else {

                    if (listing.type == 'auction') {
                        // If user logged in created the listing
                        if (userLoggedIn == listing.userID && listing.bidCount > 0) {
                            displaySuccessMessage("Sold!");
                        } else if (userLoggedIn == listing.userID && listing.bidCount == 0) {
                            displayWarningMessage("Listing Ended Without Any Bidders");
                        } else if (userLoggedIn == listing.highestBidderID) {
                            displaySuccessMessage("You Won!")
                        }
                    }
                }
            }
        });
    });

    function updateDataOnPage() {

        bidCountElement.innerText = listing.bidCount;
        if (listing.highestBidderID == "null") {
            highestBidderElement.innerText = "";
            highestBidElement.innerText = '$0';
        } else {
            highestBidderElement.innerText = listing.highestBidderUsername;
            highestBidElement.innerText = '$' + listing.highestBid;
        }

        if (document.getElementById("bidForm").style.display == "none") {
            document.getElementById("bidValue").value = listing.highestBid + 1;
        }
    }

    function placeBid(bidAmount) {

        document.getElementById("bidForm").style.display = "none";
        document.getElementById("bidValue").value = 0;

        if (listing.highestBidderID != "null" && bidAmount <= listing.highestBid) {
            displayWarningMessage("Your Bid Is Too Small");

        } else {
            $.ajax({
                type: 'GET',
                url: '/bid',
                data: {bidValue: bidAmount, listingID: ${listing.id}},
            }).done(function (response) {

                if (response.result == 'WINNING') {
                    highestBidElement.innerText = '$' + bidAmount;
                    highestBidderElement.innerText = '${sessionScope.user.username}';
                    displaySuccessMessage("Congrats! You're the highest bidder!");
                } else if (response.result == 'OUTBID') {
                    displayErrorMessage("You've Been Outbid");
                } else if (response.result == 'OVER') {
                    displayWarningMessage("Sorry, you didn't get your bid in on time!");
                } else if (response.result == 'LOGIN') {
                    displayWarningMessage("Login To Place A Bid");
                } else if (response.result == 'TOO SMALL') {
                    displayWarningMessage("Bid Most Be Larger Than Highest Bid");
                }
            });
        }
    }

    function displayErrorMessage(message) {
        UIkit.notification({message: message, status: 'danger'});
        $('#dangerButton').click();
    }

    function displaySuccessMessage(message) {
        UIkit.notification({message: message, status: 'success'});
        $('#successButton').click();
    }

    function displayWarningMessage(message) {
        UIkit.notification({message: message, status: 'warning'});
        $('#warningButton').click();
    }

    function startTutorial() {
        introJs(".listing-tutorial").start();
    }

    function goBack() {
        window.history.back();
    }

</script>

</html>