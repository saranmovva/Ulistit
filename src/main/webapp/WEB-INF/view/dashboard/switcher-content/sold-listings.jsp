<li>
    <script>
        function soldListingsDashboardLoad(){
            $("#soldListingsLoad:hidden").show();
            var text="";
            $.ajax({
                url: 'dashboardSoldListings',
                type: 'GET',
                dataType: 'json',
                contentType: 'application/json',
                success: function (result) {
                    var text = "";
                    var sessionUsr = ${sessionScope.user.userID};
                    if(Object.keys(result).length == 0){
                        text += '<li class="uk-position-center"><h2>You have no listings you sold</h2></li>';
                    }else{
                        for (var key in result) {
                            text += '<li class="uk-padding-small uk-first-column">'+
                                '<div>' +
                                '    <div class="uk-float-left">' +
                                '        <ul class="uk-iconnav uk-iconnav-vertical">' +
                                '            <li><a href="#" uk-icon="icon: plus"></a></li>' +
                                '            <li uk-tooltip="title: Edit; pos: left"><a href="edit?listing='+ result[key].listingId + '" uk-icon="icon: file-edit"></a>' +
                                '            </li>' +
                                '            <li><a href="#" uk-icon="icon: copy"></a></li>' +
                                '            <li uk-tooltip="title: Cancel; pos: left"><a onclick="UIkit.modal("#cancel-auction").show();"' +
                                '                                                         uk-icon="icon: close"></a></li>' +
                                '            <li><a href="#" uk-icon="icon: trash"></a></li>';
                            if(result[key].listingType == "Auction") {
                                text += '<li><button uk-toggle="target: #modal" uk-icon="icon: refresh" type="button"></button></li>';
                            }
                            text += '</ul>' +
                                '    </div>' +
                                '    <div class="uk-card uk-card-default uk-float-left uk-box-shadow-hover-large" style="height: auto; width: 80%">' +
                                '        <div class="uk-card-media-top">' +
                                '            <div uk-slideshow="autoplay-interval: 2000" uk-slideshow>' +
                                '                <ul class="uk-slideshow-items">' +
                                '                        <div uk-lightbox>';
                            var imgListing = JSON.parse(result[key].listingImages);
                            console.log(imgListing);
                            for (var i = 0; i < imgListing.length; i++) {
                                text += '<li>' +
                                    '<div class="uk-position-center uk-dark">' +
                                    '<img src="${pageContext.request.contextPath}/directory/'+imgListing[i].image+'" alt="Listing">' +
                                    '<div class="uk-visible-toggle">' +
                                    '<div class="uk-invisible-hover uk-overlay-default uk-position-cover">' +
                                    '<div class="uk-position-center">' +
                                    '<a href="${pageContext.request.contextPath}/directory/'+imgListing[i].image+'"' +
                                    'title="Image"><span uk-tooltip="title: View Image"' +
                                    'uk-icon="icon: search; ratio: 2"></span></a>' +
                                    '</div></div></div>' +
                                    '<input class="timestamp" data-timestamp="'+ result[key].listingCreatedTime + '" type="hidden">' +
                                    '</div>' +
                                    '</li>';
                            }
                            text += '</div>' +
                                '</ul>' +
                                '<a class="uk-position-top-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous uk-slideshow-item="previous"></a>' +
                                '<a class="uk-position-top-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next uk-slideshow-item="next"></a>' +
                                '</div>' +
                                '</div>' +
                                '<div class="uk-card-body">' +
                                '<!-- Name -->' +
                                '<h3 class="uk-card-title" style="font-size: 100%"><a href="/listing?l='+ result[key].listingId +'"' +
                                '                                                                 class="uk-text-danger">'+ result[key].listingName +'</a></h3>';

                            if(result[key].listingId != sessionUsr){
                                text+='<div class="watch-item color1 uk-position-medium uk-position-top-right" id="'+ result[key].listingId +'>' +
                                    '<a uk-icon="icon: star; ratio: 1"></a></div>' +
                                    '<div class="watch-item color2 uk-position-medium uk-position-top-right" id="'+ result[key].listingId +'" style="display: none;">' +
                                    '<a uk-icon="icon: star; ratio: 2"></a></div>';
                            }

                            switch(result[key].listingType) {
                                case "Auction":
                                    text +='<!-- Shows the highest bid for a listing that is an auction -->' +
                                        '                    <div class="price" style="font-size: 80%;">' +
                                        '                        <span class="uk-badge" style="font-size: 90%;">Highest Bid: $'+ result[key].listingHighestBids +'</span>' +
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
                                        '                                 uk-countdown="date: '+ result[key].listingEndTime +'">' +
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
                                    text +='';
                                    break;
                                case "Fixed Price":
                                    text += '<div class="price" style="font-size: 80%;"><span class="uk-badge" id="currentBid'+ result[key].listingId +'" style="font-size: 90%;">Price: $'+ result[key].listingPrice +'</span></div>';
                                    break;

                            }

                            text += '        </div>' +
                                '    </div>' +
                                '</div></li>';
                        }
                    }
                    $("#soldListings").empty();
                    $("#soldListingsLoad").hide();
                    $("#soldListings").append(text);
                }
            });
        }
    </script>
    <div
            class="uk-panel uk-panel-scrollable uk-resize-vertical uk-height-large uk-padding-remove uk-background-muted uk-border-rounded">
        <div id="soldListingsLoad" class="uk-position-center" uk-spinner="ratio: 3"></div>
        <a class="uk-icon-button uk-position-top-right" onclick="soldListingsDashboardLoad()"><span uk-icon="refresh" ></span></a>
        <ul id="soldListings" class="uk-nav uk-nav-default uk-child-width-1-4@m uk-grid-small uk-grid-match list" uk-grid>

        </ul>
    </div>
</li>


