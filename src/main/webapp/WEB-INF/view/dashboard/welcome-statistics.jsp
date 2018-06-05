<div class="uk-container">
    <h1 class="uk-heading-line uk-text-center"><span>${user.firstName}'s Dashboard</span></h1>

    <div class="uk-grid" style="padding-top: 5%" uk-grid>
        <div class="uk-width-4-5">
            <div class="uk-child-width-1-2 uk-grid-match uk-grid-large" uk-grid>
                <h4>Listings I've Bid On</h4>
                <h4>Listings Of Mine With Bids</h4>
            </div>
        </div>
        <div class="uk-width-1-5">
            <h4>Relevant Posts For Me</h4>
        </div>
    </div>

    <div class="uk-padding-small">

        <!-- Grid for first section content -->
        <div class="uk-grid-divider uk-grid-match uk-padding-small uk-margin-small-top" uk-grid>

            <div class="uk-width-4-5@m uk-width-1-1@s uk-first-column">
                <div class="uk-child-width-1-2@m uk-child-width-1-1@s uk-grid-match uk-grid-large">

                    <div class="uk-float-left uk-padding-remove-left">

                        <!-- Begin slider -->
                        <div class="uk-position-relative uk-visible-toggle uk-light"
                             uk-slider="clsActivated: uk-transition-active; center: true"
                             style="width: 85%; height: 80%;">
                            <ul id="listingsIBidOnCard" class="uk-slider-items uk-grid">
                                <!-- Ajax replaces this -->
                                <li>

                                    <div><strong>You have no bids</strong></div>

                                </li>
                                <!-- Ajax replaces this end -->
                            </ul>

                            <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#"
                               uk-slidenav-previous uk-slider-item="previous" style="color: black"></a>
                            <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#"
                               uk-slidenav-next uk-slider-item="next" style="color: black"></a>

                        </div>
                        <!-- End slider -->

                    </div>

                    <div class="uk-padding-remove-right">

                        <!-- Begin slider -->
                        <div class="uk-position-relative uk-visible-toggle uk-light"
                             uk-slider="clsActivated: uk-transition-active; center: true"
                             style="width: 85%; height: 80%;">
                            <ul id="bidsOnMyListingCard" class="uk-slider-items uk-grid">
                                <!-- Ajax replaces this -->
                                <li>

                                    <div><strong>No current bids</strong></div>

                                </li>
                                <!-- Ajax replaces this end -->
                            </ul>

                            <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#"
                               uk-slidenav-previous uk-slider-item="previous" style="color: black"></a>
                            <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#"
                               uk-slidenav-next uk-slider-item="next" style="color: black"></a>
                        </div>
                        <!-- End slider -->

                    </div>

                </div>
            </div>
            <div class="uk-width-1-5@m uk-width-1-1@s uk-float-right">

                <div id="relevantListingCard">

                    <div>

                        <div><strong>No recommendations</strong></div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<script>

    // My bids on listings
    $(document).ready(function () {
        var text = "";
        $.ajax({
            url: 'listingsIBidOn',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            success: function (result) {
                console.log(result);
                for (var key in result) {
                    text += '<li class="uk-width-1-1">' +
                        '<div class="uk-card uk-card-default" style="height: 320px; width: auto;">' +
                        '<div class="uk-card-media-top" style="height: auto; max-height: 100%; width: auto; max-width: 100%;">' +
                        '<img style="height: auto; max-height: 100%; width: auto; max-width: 100%" src="directory/' + result[key].listingImage + '" + alt="">' +
                        '</div>' +
                        '<div class="uk-card-body">' +
                        '<h3 class="uk-card-title">' + result[key].listingName + '</h3>' +
                        '</div>' +
                        '</div>' +
                        '</li>';
                }

                $('#listingsIBidOnCard').empty();
                $('#listingsIBidOnCard').append(text);
            }
        });
    });

    // Bids on my listings
    $(document).ready(function () {
        var text = "";
        $.ajax({
            url: 'bidsOnMyListings',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            success: function (result) {
                console.log(result);
                for (var key in result) {
                    text += '<li class="uk-width-1-1">' +
                        '<div class="uk-card uk-card-default" style="height: 320px; width: auto;">' +
                        '<div class="uk-card-media-top" style="height: auto; max-height: 100%; width: auto; max-width: 100%;">' +
                        '<img style="height: auto; max-height: 100%; width: auto; max-width: 100%;" src="directory/' + result[key].listingImage + '" + alt="">' +
                        '</div>' +
                        '<div class="uk-card-body">' +
                        '<h3 class="uk-card-title">' + result[key].listingName + '</h3>' +
                        '</div>' +
                        '</div>' +
                        '</li>';
                }

                $('#bidsOnMyListingCard').empty();
                $('#bidsOnMyListingCard').append(text);
            }
        });
    });

    // Relevant listing
    $(document).ready(function () {
        var text = "";
        $.ajax({
            url: 'getRelevantListing',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            success: function (result) {
                console.log(result);

                var sessionUsr = ${sessionScope.user.userID};
                if (Object.keys(result).length == 0) {
                    text += '<li class="uk-position-center"><h2>You have no active listings</h2></li>';
                } else {
                    text += '    <div class="uk-card uk-card-default uk-float-left uk-box-shadow-hover-large" style="height: auto; width: 100%">' +
                        '        <div class="uk-card-media-top">' +
                        '            <div uk-slideshow="autoplay-interval: 2000" uk-slideshow>' +
                        '                <ul class="uk-slideshow-items">' +
                        '                        <div uk-lightbox>';

                    text += '<li>' +
                        '<div class="uk-position-center uk-dark">' +
                        '<img src="${pageContext.request.contextPath}/directory/' + result.listingImage + '" alt="Listing">' +
                        '<div class="uk-visible-toggle">' +
                        '<div class="uk-invisible-hover uk-overlay-default uk-position-cover">' +
                        '<div class="uk-position-center">' +
                        '<a href="${pageContext.request.contextPath}/directory/' + result.listingImage + '"' +
                        'title="Image"><span uk-tooltip="title: View Image"' +
                        'uk-icon="icon: search; ratio: 2"></span></a>' +
                        '</div></div></div>' +
                        '<input class="timestamp" data-timestamp="' + result.listingEndTimestamp + '" type="hidden">' +
                        '</div>' +
                        '</li>';

                    text += '</div>' +
                        '</ul>' +
                        '<a class="uk-position-top-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous uk-slideshow-item="previous"></a>' +
                        '<a class="uk-position-top-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next uk-slideshow-item="next"></a>' +
                        '</div>' +
                        '</div>' +
                        '<div class="uk-card-body">' +
                        '<!-- Name -->' +
                        '<h3 class="uk-card-title" style="font-size: 100%"><a href="/listing?l=' + result.listingId + '"' +
                        '                                                                 class="uk-text-danger">' + result.listingName + '</a></h3>';

                    if (result.listingId != sessionUsr) {
                        text += '<div class="watch-item color1 uk-position-medium uk-position-top-right" id="' + result.listingId + '>' +
                            '<a uk-icon="icon: star; ratio: 1"></a></div>' +
                            '<div class="watch-item color2 uk-position-medium uk-position-top-right" id="' + result.listingId + '" style="display: none;">' +
                            '<a uk-icon="icon: star; ratio: 2"></a></div>';
                    }

                    switch (result.listingType) {
                        case "Auction":
                            text += '<!-- Shows the highest bid for a listing that is an auction -->' +
                                '                    <div class="price" style="font-size: 80%;">' +
                                '                        <span class="uk-badge" style="font-size: 90%;">Highest Bid: $' + result.listingHighestBid + '</span>' +
                                '                    </div>' +
                                '                    <!-- Countdown for auctions -->' +
                                '                    <div class="uk-grid-small" uk-grid>' +
                                '                        <div class=" uk-width-1-1 uk-align-center uk-margin-remove-bottom">' +
                                '                            <p class="uk-margin-medium-top uk-align-center listing-ended"' +
                                '                               style="color: red; font-size: 90%; display: none;">' +
                                '                                <br>' +
                                '                                Listing Ended</p>' +
                                '                            <div class="uk-grid uk-countdown uk-margin-remove uk-float-left uk-padding-remove-left uk-align-center"' +
                                '                                 uk-grid' +
                                '                                 uk-countdown="date: ' + result.listingEndTime + '">' +
                                '                        <span class="uk-days">' +
                                '                            <strong class="uk-countdown-number uk-countdown-days" style="font-size: 80%"></strong>' +
                                '                            <strong class="uk-countdown-label uk-margin-small-top "' +
                                '                                    style="font-size: 70%">Days</strong>' +
                                '                        </span>' +
                                '                                <span class="uk-hours">' +
                                '                            <strong class="uk-countdown-number uk-countdown-hours" style="font-size: 80%"></strong>' +
                                '                            <strong class="uk-countdown-label uk-margin-small-top "' +
                                '                                    style="font-size: 70%">Hours</strong>' +
                                '                        </span>' +
                                '                                <span class="uk-minutes">' +
                                '                            <strong class="uk-countdown-number uk-countdown-minutes" style="font-size: 80%"></strong>' +
                                '                            <strong class="uk-countdown-label uk-margin-small-top "' +
                                '                                    style="font-size: 70%">Minutes</strong>' +
                                '                        </span>' +
                                '                                <span class="uk-seconds">' +
                                '                            <strong class="uk-countdown-number uk-countdown-seconds" style="font-size: 80%"></strong>' +
                                '                            <strong class="uk-countdown-label uk-margin-small-top "' +
                                '                                    style="font-size: 70%">Seconds</strong></strong>' +
                                '                        </span>' +
                                '                            </div>' +
                                '                        </div>' +
                                '                    </div>';
                            break;
                        case "Donation":
                            text += '';
                            break;
                        case "Fixed Price":
                            text += '<div class="price" style="font-size: 80%;"><span class="uk-badge" id="currentBid' + result.listingId + '" style="font-size: 90%;">Price: $' + result.listingPrice + '</span></div>';
                            break;

                    }

                    text += '        </div>' +
                        '    </div>' +
                        '</div>';
                }

                // old code

                $('#relevantListingCard').empty();
                $('#relevantListingCard').append(text);
            }
        });
    });


</script>