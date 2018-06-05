<%--
  Created by IntelliJ IDEA.
  User: saran
  Date: 4/22/18
  Time: 8:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@include file="jspf/header.jsp" %>

<body class="uk-background-muted">

<%@include file="jspf/navbar.jspf" %>

<%@include file="jspf/messages.jsp" %>

<div class="uk-grid uk-margin-large-bottom" uk-grid>
    <div class="uk-width-1-1 uk-align-center">
        <form class="uk-align-center uk-margin-small-top .uk-form-controls-text" style="width:50%;">
            <div class="uk-search uk-search-default uk-width-1-1">
                <span class="uk-search-icon-flip" uk-search-icon></span>
                <input id="search" class="uk-search-input uk-box-shadow-hover-xlarge" style="border-radius:15px;" type="search" placeholder="Search...">
            </div>
            <div class="uk-align-center uk-margin-small-top">

                <div uk-form-custom="target: > * > span:first-child" class="uk-margin-small-left">
                    <select id="sortCriteria">
                        <option value="">Sort By </option>
                        <option id="AlphabeticalAscending" value="AlphabeticalAscending">Alphabetical Ascending</option>
                        <option id="AlphabeticalDescending" value="AlphabeticalDescending">Alphabetical Descending</option>
                        <option id="PriceAscending" value="PriceAscending">Price Ascending</option>
                        <option id="PriceDescending" value="PriceDescending">Price Descending</option>
                    </select>
                    <button class="uk-button uk-button-default" type="button" tabindex="-1">
                        <span></span>
                        <span uk-icon="icon: chevron-down"></span>
                    </button>
                </div>

                <div uk-form-custom="target: > * > span:first-child" class="uk-margin-small-left">
                    <select id="categoryCriteria">
                        <option value="">Category</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.category}">${category.category}</option>
                        </c:forEach>
                    </select>

                    <button class="uk-button uk-button-default" type="button" tabindex="-1">
                        <span></span>
                        <span uk-icon="icon: chevron-down"></span>
                    </button>
                </div>

                <label class="uk-margin-small-left"><input class="uk-checkbox" type="checkbox" checked> Auctions</label>
                <label class="uk-margin-small-left"><input class="uk-checkbox" type="checkbox" checked> Fixed Price</label>
                <label class="uk-margin-small-left"><input class="uk-checkbox" type="checkbox" checked> Donations</label>

                <label><input class="uk-radio uk-margin-small-left" type="radio" name="radio1" checked> Listings</label>
                <label><input class="uk-radio uk-margin-small-left" type="radio" name="radio1"> Users</label>


            </div>
        </form>
    </div>
</div>
<div class="uk-grid-large uk-child-width-expand@s uk-margin-top-large uk-margin-large-left uk-margin-large-right uk-text-center" uk-grid>

    <div id="allListings"
         class="uk-panel uk-panel-scrollable uk-resize-vertical uk-height-1-1 uk-padding-remove uk-background-muted uk-border-rounded uk-margin-large-bottom">
        <ul id="printCards" class="uk-nav uk-nav-default uk-child-width-1-4@m uk-grid-small uk-grid-match list" uk-grid>
        </ul>
    </div>
</div>
</body>
<script>
    var listings;
    var tempListings;
    $(document).ready(function () {
        var text= "";
        $.ajax({
            url: 'getAllListings',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            success: function (result) {
                console.log(result);
                listings = result;
                tempListings = result;
                if (jQuery.isEmptyObject(result)) {
                    text += '<li class="uk-position-center"><h2>There are currenlty no listings</h2></li>';
                }else{
                for (var key in result) {
                    text += '<li class="uk-padding-small">' +
                        '<div class="uk-card uk-card-default">' +
                        '<div class="uk-card-media-top">' +
                        '<img class="uk-align-center" src="directory/' + result[key].listingImages + '" alt="">' +
                        '<div class="uk-card-body"> <a href="/listing?l=' + result[key].listingId + '"> <h3 class="uk-card-title">' + result[key].listingName + '</h3></a> ' +
                        '<p>Category: ' + result[key].listingCategory + '</p>' +
                        '<p>Price: ' + result[key].listingPrice + '</p>' +
                        '</div></div></li>';
                }
                }
                $('#printCards').empty();
                $('#printCards').append(text);
                <c:if test="${sessionScope.allViewCategory != '' || sessionScope.allViewCategory != null}">
                    var criteria = "${sessionScope.allViewCategory}";

                if(criteria == "Apparel" ){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Art"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Auto"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Collectibles"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Electronics"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Exotic"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Furniture"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Home Goods"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Music"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Other"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "School Supplies"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                else if(criteria == "Sporting Goods"){
                    tempListings.sort(printCardsCategory(tempListings,criteria));
                }
                </c:if>
            }
        });

        $("#sortCriteria").change(function () {
            var criteria = this.value;
            var tempListings = listings;
            if(criteria == "AlphabeticalAscending" ){
                tempListings.sort(sortAscendingAlpha("listingName"));
                console.log(tempListings);
                printCards(tempListings);
            }
            else if(criteria == "AlphabeticalDescending"){
                tempListings.sort(sortDescendingAlpha("listingName"));
                console.log(tempListings);
                printCards(tempListings);
            }
            else if(criteria == "PriceAscending"){
                tempListings.sort(sortAscendingNumber("listingPrice"));
                printCards(tempListings);
            }
            else if(criteria == "PriceDescending"){
                tempListings.sort(sortDescendingNumber("listingPrice"));
                console.log(tempListings);
                printCards(tempListings);
            }
        });

        $("#categoryCriteria").change(function () {
            var criteria = this.value;
            var tempListings = listings;
            if(criteria == "Apparel" ){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Art"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Auto"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Collectibles"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Electronics"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Exotic"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Furniture"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Home Goods"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Music"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Other"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "School Supplies"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }
            else if(criteria == "Sporting Goods"){
                tempListings.sort(printCardsCategory(tempListings,criteria));
            }

        });

    });

    function sortAscendingAlpha(prop) {
        return function(a, b) {
            if (a[prop].toLowerCase() > b[prop].toLowerCase()) {
                return 1;
            } else if (a[prop].toLowerCase() < b[prop].toLowerCase()) {
                return -1;
            }
            return 0;
        }
    }

    function sortDescendingAlpha(prop) {
        return function(a, b) {
            if (a[prop].toLowerCase() > b[prop].toLowerCase()) {
                return -1;
            } else if (a[prop].toLowerCase() < b[prop].toLowerCase()) {
                return 1;
            }
            return 0;
        }
    }

    function sortAscendingNumber(prop) {
        return function(a, b) {
            if (a[prop] > b[prop]) {
                return 1;
            } else if (a[prop] < b[prop]) {
                return -1;
            }
            return 0;
        }
    }

    function sortDescendingNumber(prop) {
        return function(a, b) {
            if (a[prop] > b[prop]) {
                return -1;
            } else if (a[prop] < b[prop]) {
                return 1;
            }
            return 0;
        }
    }

    function printCards(result){
        var text = "";
        if(jQuery.isEmptyObject(result)){
            text += '<li class="uk-position-center"><h2>There are currenlty no listings</h2></li>';
        }else {
            for (var key in result) {
                text += '<li class="uk-padding-small">' +
                    '<div class="uk-card uk-card-default">' +
                    '<div class="uk-card-media-top">' +
                    '<img class="uk-align-center" src="directory/' + result[key].listingImages + '" alt="">' +
                    '<div class="uk-card-body"> <a href="/listing?l=' + result[key].listingId + '"> <h3 class="uk-card-title">' + result[key].listingName + '</h3></a> ' +
                    '<p>Category: ' + result[key].listingCategory + '</p>' +
                    '<p>Price: ' + result[key].listingPrice + '</p>' +
                    '</div></div></li>';
            }
        }
        $('#printCards').empty();
        $('#printCards').append(text);
    }

    function printCardsCategory(result, name){
        var text = "";
        if(jQuery.isEmptyObject(result)){
            text += '<li class="uk-position-center"><h2>There are currenlty no listings for that category</h2></li>';
        }else {
            for (var key in result) {
                if (result[key].listingCategory == name) {
                    text += '<li class="uk-padding-small">' +
                        '<div class="uk-card uk-card-default">' +
                        '<div class="uk-card-media-top">' +
                        '<img class="uk-align-center" src="directory/' + result[key].listingImages + '" alt="">' +
                        '<div class="uk-card-body"> <a href="/listing?l=' + result[key].listingId + '"> <h3 class="uk-card-title">' + result[key].listingName + '</h3></a> ' +
                        '<p>Category: ' + result[key].listingCategory + '</p>' +
                        '<p>Price: ' + result[key].listingPrice + '</p>' +
                        '</div></div></li>';
                }
            }
        }
        $('#printCards').empty();
        $('#printCards').append(text);
    }
</script>
<%@include file="jspf/footer.jspf" %>
</html>
<!--

border-radius: 5%;
.uk-border-rounded
-->