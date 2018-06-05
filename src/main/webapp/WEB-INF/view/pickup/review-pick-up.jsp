<%@include file="../jspf/header.jsp" %>

<body class="uk-height-viewport">

<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <div class="uk-section pickup-tutorial uk-background-muted uk-padding-remove-top">

        <!-- Help Link -->
        <div class="uk-margin-top">
            <%@include file="../jspf/help-icon.jsp" %>
        </div>

        <ul class="uk-breadcrumb uk-padding uk-padding-small-top uk-padding-remove-bottom">
            <li><a href="/">Home</a></li>
            <li><a href="/listing?l=${pickUp.transaction.listingID.id}">Listing</a></li>
            <li><span>Pick Up</span></li>
            <c:if test="${pickUp.buyerAccept == 1}">
                <li><a href="/checkout?l=${pickUp.transaction.listingID.id}">Checkout</a></li>
            </c:if>
        </ul>

        <div class="uk-grid uk-padding uk-padding-remove-bottom" uk-grid>

            <!-- Left Side -->
            <div class="uk-width-2-3@m uk-width-1-1@s uk-section uk-padding-remove-top" style="height: 100%"
                 data-intro="Here you can review the pick up info."
                 data-step="1">
                <form action="/pick-up-edit" method="post">

                    <div class="uk-width-1-1 uk-grid-small" uk-grid>
                        <div class="uk-width-1-2">
                            <h2 class="uk-heading">Pick Up Details
                                <c:if test="${sessionScope.user.userID == pickUp.transaction.seller.userID}">
                                    <a data-intro="Click here to edit the pick up date and/or time."
                                       uk-tooltip="Edit Pickup Details"
                                       data-step="2" onclick="toggleEditDetails();"
                                       uk-icon="icon: pencil; ratio: 1.7"></a>
                                </c:if>
                            </h2>
                        </div>

                        <!-- User Icon -->
                        <div class="uk-width-1-2">
                            <div class="inactive-user-icon uk-float-right uk-margin-small-bottom"
                                 id="user-icon"
                                 data-intro="This icon lets you know if the other person is on the page too."
                                 data-step="3">

                                <c:choose>
                                    <c:when test="${sessionScope.user.userID == pickUp.transaction.buyer.userID}">
                                        <!-- Seller Image -->
                                        <img class="uk-border-circle" id="user-icon-img"
                                             src="${pageContext.request.contextPath}/directory/${pickUp.transaction.seller.mainImage}"
                                             uk-tooltip="${pickUp.transaction.seller.username} Is Inactive"/>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Buyer Image -->
                                        <img class="uk-border-circle" id="user-icon-img"
                                             src="${pageContext.request.contextPath}/directory/${pickUp.transaction.buyer.mainImage}"
                                             uk-tooltip="${pickUp.transaction.buyer.username} Is Inactive"/>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </div>
                    </div>

                    <!-- Location Section -->
                    <div class="uk-card uk-card-default">
                        <div class="uk-card-body" uk-grid>
                            <div class="uk-width-1-1 uk-margin-auto-vertical">
                                <span class="uk-align-center">
                                    <span class="uk-width-1-3@m uk-width-1-1@s uk-padding-small">
                                            <span class="uk-text-large">
                                            <strong style="color: #ff695c">Location: </strong><b
                                                    id="locationName">${pickUp.location.name}</b>
                                            <c:if test="${sessionScope.user.userID == pickUp.transaction.seller.userID}">
                                                <input id="editLocationName" style="display: none;" type="text"
                                                       class="uk-input" max="20"
                                                       name="newName" value="${pickUp.location.name}">
                                            </c:if>
                                            </span>
                                        </span>
                                        <br class="uk-hidden@m uk-hidden@l">
                                        <span class="uk-width-1-3@m uk-width-1-1@s uk-padding-small">
                                            <span class="uk-text-large">
                                        <strong style="color: #ff695c">Date: </strong>
                                            <b id="pickUpDate">
                                            <c:choose>
                                                <c:when test="${pickUp.pickUpDate == null}">
                                                    TBD
                                                </c:when>
                                                <c:otherwise>
                                                    ${pickUp.pickUpDate}
                                                </c:otherwise>
                                            </c:choose>
                                            </b>
                                        </span>
                                        <c:if test="${sessionScope.user.userID == pickUp.transaction.seller.userID}">
                                            <input id="editDate" style="display: none;" type="date" class="uk-input"
                                                   name="newDate">
                                        </c:if>
                                        </span>
                                        <br class="uk-hidden@m uk-hidden@l">
                                        <span class="uk-width-1-3@m uk-width-1-1@s uk-padding-small"><span
                                                class="uk-text-large"><strong
                                                style="color: #ff695c">Time: </strong>
                                                <b id="pickUpTime">
                                                <c:choose>
                                                    <c:when test="${pickUp.pickUpTime == null}">
                                                        TBD
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${pickUp.pickUpTime}
                                                    </c:otherwise>
                                                </c:choose>
                                                </b>
                                        </span>
                                        <c:if test="${sessionScope.user.userID == pickUp.transaction.seller.userID}">
                                        <input id="editTime" style="display: none;" type="time" class="uk-input"
                                               name="newTime">
                                        </c:if>
                                        </span>
                                <input type="hidden" value="${pickUp.pickUpID}" name="pickUpID">
                                <input type="hidden" id="newPosition" value="" name="newPosition">
                                </span>
                            </div>

                            <!-- Map -->
                            <div class="uk-width-1-1">
                                <div id="map" style="width:100%;height:400px;"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Edit Button -->
                    <button id="editButton" style="display: none;" type="submit" onclick="setLatAndLong();"
                            class="uk-float-left uk-margin-medium-left uk-margin-small-top uk-button-large uk-border-rounded uk-button-primary uk-box-shadow-hover-large">
                        Save Changes
                    </button>
                </form>
            </div>

            <!-- Right Side -->
            <div class="uk-width-1-3@m uk-width-3-4@s uk-section uk-padding-remove-top">
                <h2 class="uk-heading uk-margin-medium-bottom">Messages</h2>

                <div class="uk-card uk-card-default" id="scrollCard"
                     data-intro="Here you can chat with the other person to find a pick up time that works best for both of you."
                     data-step="4">
                    <div class="uk-card-header" id="messagesHeader"></div>
                    <div class="uk-panel-scrollable uk-height-medium" id="scroll">

                        <!-- Conversation -->
                        <div class="uk-border-rounded uk-margin" id="conversation"></div>

                    </div>

                    <!-- Send Message -->
                    <div class="uk-card-footer uk-grid-small uk-background-default uk-margin-remove-left">
                        <div class="uk-grid-small" id="sendMessageDiv" uk-grid>
                            <textarea rows="1" class="uk-textarea uk-background-muted uk-border-rounded uk-width-4-5"
                                      type="text"
                                      name="message" placeholder="Send A Message" id="message"
                                      onkeypress="typingMessage(this)"></textarea>
                            <a class="uk-width-1-5" uk-tooltip="Send Message"
                               uk-icon="icon: chevron-right; ratio: 2"
                               onclick="sendMessage();"></a>
                        </div>
                    </div>
                </div>

                <!-- Display Appropriate Buttons -->
                <div class="uk-width-1-3@s uk-width-1-1@m">
                    <c:choose>

                        <c:when test="${pickUp.buyerAccept == 0 && pickUp.transaction.seller.userID == sessionScope.user.userID}">
                            <!-- Display Disabled Checkout Button -->
                            <a uk-tooltip="Buyer Must Accept Before You Can Checkout"
                               onclick="displayWarningMessage('Buyer Must Accept Before You Can Checkout');"
                               class="uk-button-default uk-button-large uk-border-rounded uk-margin-large-top uk-float-right"
                               id="checkout-button">
                                Checkout
                            </a>
                        </c:when>

                        <c:when test="${pickUp.buyerAccept == 0 && pickUp.transaction.buyer.userID == sessionScope.user.userID}">
                            <!-- Display Accept Button -->
                            <button title="Accept" uk-toggle="target: #acceptModal"
                                    class="uk-button-primary uk-button-large uk-border-rounded uk-margin-large-top uk-float-right"
                                    data-intro="Click here to accept the pick up and confirm the pick up time and location."
                                    data-step="5">
                                Accept Pick Up
                            </button>
                        </c:when>

                        <c:when test="${pickUp.buyerAccept == 1 && pickUp.transaction.transactionType == 'pending checkout'}">
                            <!-- Display Checkout Button -->
                            <form action="/checkout" method="get">
                                <input name="l" type="hidden"
                                       value="${pickUp.transaction.listingID.id}">
                                <button title="Checkout" type="submit"
                                        class="uk-button-primary uk-button-large uk-border-rounded uk-margin-large-top uk-float-right"
                                        data-intro="Click here to go to the checkout page."
                                        data-step="5">
                                    Checkout
                                </button>
                            </form>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../jspf/footer.jspf" %>

<div id="acceptModal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <div class="uk-modal-header">
            <h2 class="uk-modal-title uk-text-center">Accept Pick Up</h2>
        </div>
        <div class="uk-modal-body uk-grid-small" uk-grid>
            <div class="uk-width-1-1"><span class="uk-text-large">
                <strong class="uk-float-left" style="color: #ff695c">Location</strong>
                <b class="uk-float-right"
                   id="modalLocationName">${pickUp.location.name}</b></span>
            </div>
            <div class="uk-width-1-1"><span class="uk-text-large">
                <strong class="uk-float-left" style="color: #ff695c">Date</strong>
                <b class="uk-float-right"
                   id="modalPickupDate">${pickUp.pickUpDate}</b></span>
            </div>
            <div class="uk-width-1-1"><span class="uk-text-large">
                <strong class="uk-float-left" style="color: #ff695c">Time</strong>
                <b class="uk-float-right"
                   id="modalPickupTime">${pickUp.pickUpTime}</b></span>
            </div>
        </div>
        <div class="uk-card-footer uk-background-default">
            <a class="uk-button-default uk-float-left uk-button-large uk-border-rounded uk-modal-close">
                Cancel
            </a>
            <form action="/pick-up-accept" method="post">
                <input name="pickUpID" type="hidden" value="${pickUp.pickUpID}">
                <button class="uk-button-primary uk-float-right uk-button-large uk-border-rounded" type="submit">
                    Accept
                </button>
            </form>
        </div>
    </div>

</div>

<script>
    var map;
    var marker;
    var markerPosition;

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: ${latitude}, lng: ${longitude}},
            zoom: 16,
            mapTypeId: google.maps.MapTypeId.HYBRID
        });

        markerPosition = new google.maps.LatLng(${pickUp.location.latitude}, ${pickUp.location.longitude});
        marker = new google.maps.Marker({
            position: markerPosition,
            map: map,
            animation: google.maps.Animation.DROP,
            title: 'Meeting Location'
        });
    }

    function sendMessage() {
        $.ajax({
            type: 'GET',
            url: '/sendPickUpMessage',
            data: {message: document.getElementById("message").value, pickUpID: ${pickUp.pickUpID}},
        }).done(function () {
            document.getElementById("sendMessageDiv").classList.add("uk-animation-slide-right-small");
            document.getElementById("message").value = "";
            updateMessages();
        });
    }

    function toggleEditDetails() {

        if (document.getElementById("editButton").style.display == "inline") {
            document.getElementById("editButton").style.display = "none";
        } else {
            document.getElementById("editButton").style.display = "inline";
        }

        if (document.getElementById('editLocationName').style.display == "inline") {
            document.getElementById("editLocationName").style.display = "none"
        } else {
            document.getElementById("editLocationName").style.display = "inline";
        }

        if (document.getElementById("editTime").style.display == "inline") {
            document.getElementById("editTime").style.display = "none";
        } else {
            document.getElementById("editTime").style.display = "inline";
        }

        if (document.getElementById("editDate").style.display == "inline") {
            document.getElementById("editDate").style.display = "none";
        } else {
            document.getElementById("editDate").style.display = "inline";
        }

        marker.setMap(null);

        marker = new google.maps.Marker({
            position: markerPosition,
            map: map,
            draggable: true,
            animation: google.maps.Animation.DROP,
            title: 'Meeting Location'
        });

        google.maps.event.addListener(marker, 'dragend', function (evt) {
            document.getElementById("newPosition").value = marker.position;
        });
    }

    function startTutorial() {
        introJs(".pickup-tutorial").start();
    }

    var currentUserID;
    var pickup;
    var otherUserIsThere;

    window.addEventListener("load", function () {

        // Check for tutorial
        $.ajax({
            type: 'GET',
            url: '/checkForTutorial',
            data: {page: "pickup"},
        }).done(function (response) {
            if (response.showTutorial == 'YES') {
                setTimeout(function () {
                    startTutorial();
                }, 1500);
            }
        });

        currentUserID = ${sessionScope.user.userID};
        otherUserIsThere = false;

        // Initialize pickup
        $.ajax({
            type: 'GET',
            url: '/checkForPickupUpdates',
            data: {pickUpID: ${pickUp.pickUpID}},
        }).done(function (response) {
            pickup = response;
        });

        // Initialize messages
        updateMessages();

        checkForUser();

        // Check for other user
        setInterval(function () {
            checkForUser();
            if (otherUserIsThere) {
                checkForUpdates();
            }
        }, 2000);

        // Check for new messages
        setInterval(function () {
            updateMessages();
        }, 2000);

    });

    function checkForUser() {
        $.ajax({
            type: 'GET',
            url: '/checkForPickupUser',
            data: {pickUpID: ${pickUp.pickUpID}},
        }).done(function (response) {

            // Other user is on page
            if (response.result == 'USER ACTIVE') {
                document.getElementById("user-icon").classList.remove("inactive-user-icon");
                document.getElementById("user-icon").classList.add("active-user-icon");
                otherUserIsThere = true;

                // Update tooltip
                if (${sessionScope.user.userID} == ${pickUp.transaction.buyer.userID}) {
                    document.getElementById("user-icon-img").setAttribute("uk-tooltip", "${pickUp.transaction.seller.username} Is Active");
                } else {
                    document.getElementById("user-icon-img").setAttribute("uk-tooltip", "${pickUp.transaction.buyer.username} Is Active");
                }

                // Other user is not on page
            } else {
                document.getElementById("user-icon").classList.remove("active-user-icon");
                document.getElementById("user-icon").classList.add("inactive-user-icon");
                otherUserIsThere = false;

                // Update tooltip
                if (${sessionScope.user.userID} == ${pickUp.transaction.buyer.userID}) {
                    document.getElementById("user-icon-img").setAttribute("uk-tooltip", "${pickUp.transaction.seller.username} Is Inactive");
                } else {
                    document.getElementById("user-icon-img").setAttribute("uk-tooltip", "${pickUp.transaction.buyer.username} Is Inactive");
                }
            }
        });
    }

    function checkForUpdates() {
        $.ajax({
            type: 'GET',
            url: '/checkForPickupUpdates',
            data: {pickUpID: ${pickUp.pickUpID}},
        }).done(function (response) {

            var changeCount = 0;

            // Lat and/or Lng Changed
            if (pickup.locationLat != response.locationLat || pickup.locationLng != response.locationLng) {
                displayWarningMessage("Pick Up Location Was Edited");
                marker.setMap(null);
                markerPosition = new google.maps.LatLng(response.locationLat, response.locationLng);
                marker = new google.maps.Marker({
                    position: markerPosition,
                    map: map,
                    animation: google.maps.Animation.DROP,
                    title: 'Meeting Location'
                });
                changeCount++;
            }

            // Location Name Changed
            if (pickup.locationName != response.locationName) {
                displayWarningMessage("Pick Up Location Name Was Edited");
                document.getElementById("locationName").innerText = response.locationName;
                document.getElementById("modalLocationName").innerText = response.locationName;
                changeCount++;
            }

            // Date and/or Time Changed
            if (pickup.pickUpTimestampAsLong != response.pickUpTimestampAsLong) {
                displayWarningMessage("Pick Up Date And Time Were Edited");
                document.getElementById("pickUpDate").innerText = response.pickUpDate;
                document.getElementById("modalPickupDate").innerText = response.pickUpDate;
                document.getElementById("pickUpTime").innerText = response.pickUpTime;
                document.getElementById("modalPickupTime").innerText = response.pickUpTime;
                changeCount++;
            }

            // Buyer Accept Changed
            if (pickup.buyerAccept != response.buyerAccept) {
                displayWarningMessage("Buyer Has Accepted The Pick Up");
                var href = document.createAttribute("href");
                href.value = 'checkout?l=${pickUp.transaction.listingID.id}';
                document.getElementById("checkout-button").setAttributeNode(href);
                document.getElementById("checkout-button").removeAttribute("uk-tooltip");
                document.getElementById("checkout-button").removeAttribute("onclick");
                document.getElementById("checkout-button").classList.remove("uk-button-default");
                document.getElementById("checkout-button").classList.add("uk-button-primary");
                changeCount++;
            }

            // Status Changed
            if (pickup.status != response.status) {
                displayWarningMessage("Pick Up Status Has Changed");
                changeCount++;
            }

            if (changeCount > 0) {
                pickup = response;
            }
        });
    }

    function updateMessages() {

        $.ajax({
            type: 'GET',
            url: '/updatePickupMessages',
            data: {pickUpID: ${pickUp.pickUpID}},
        }).done(function (response) {

            var newMessageCount = 0;

            for (var key in response) {

                if (!document.getElementById("message" + response[key].messageID)) {

                    var messageHTML = '<div id="message' + response[key].messageID + '">';

                    // Message sent from user not logged in
                    if (currentUserID != response[key].userID) {
                        messageHTML += '<div class="uk-float-left uk-width-3-4 uk-text-left uk-background-primary uk-border-rounded uk-padding-small" style="color: white;">'
                        messageHTML += response[key].messageBody + '</div>';
                        messageHTML += '<p class="uk-align-left uk-margin-remove-top uk-margin-small-left" style="font-size: 12px;">';

                        // Message sent from user logged in
                    } else {
                        messageHTML += '<div class="uk-float-right uk-width-3-4 uk-background-muted uk-border-rounded uk-padding-small" ';
                        messageHTML += 'style="border-style: solid; border-width: 2px; border-color: darkgray">';
                        messageHTML += response[key].messageBody + '</div>';
                        messageHTML += '<p class="uk-align-right uk-margin-remove-top uk-margin-small-right" style="font-size: 12px;">';
                    }

                    messageHTML += response[key].formattedDateSent + '</p></div>';

                    $('#conversation').append(messageHTML);

                    newMessageCount++;

                }

                if (newMessageCount > 0) {
                    $('#messagesHeader').innerText = 'Messages (' + newMessageCount + ')';

                    $("#scroll").animate({scrollTop: $('#scroll').prop("scrollHeight")}, 100);
                }

            }
        });
    }

    function displayErrorMessage(message) {
        UIkit.notification({message: message, status: 'danger'});
        $('#dangerButton').click();
    }

    function displayWarningMessage(message) {
        UIkit.notification({message: message, status: 'warning'});
        $('#warningButton').click();
    }

    function displaySuccessMessage(message) {
        UIkit.notification({message: message, status: 'success'});
        $('#successButton').click();
    }

    function typingMessage(textarea) {
        if (textarea.value.length > 22) {
            document.getElementById("message").rows = "2";
        } else {
            document.getElementById("message").rows = "1";
        }
    }

</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAYv7pVPxQ-k7yWlKPfa8ebsx7ci9q7vQ8&callback=initMap"
        type="text/javascript"></script>

</body>
</html>