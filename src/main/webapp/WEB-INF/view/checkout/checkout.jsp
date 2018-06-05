<%@include file="../jspf/header.jsp" %>
<script src="https://www.paypalobjects.com/api/checkout.js"></script>

<body class="uk-height-viewport">

<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <div class="uk-section uk-background-muted">

        <div class="uk-padding uk-padding-remove-top">

            <ul class="uk-breadcrumb uk-margin-medium-bottom">
                <li><a href="/">Home</a></li>
                <li><a href="/listing?l=${listing.id}">Listing</a></li>
                <li><a href="/pick-up-review?l=${listing.id}">Pick Up</a></li>
                <li><span>Checkout</span></li>
            </ul>

            <div class="uk-grid-large" uk-grid>

                <!-- Left side -->
                <div class="uk-width-2-3@m uk-width-1-1@s">

                    <!-- Listing Details -->
                    <h2>Listing Details</h2>
                    <div class="uk-card uk-card-default uk-box-shadow-hover-large uk-border-rounded">
                        <div class="uk-card-body uk-grid" uk-grid>

                            <div class="uk-width-1-2@m">
                                <span class="uk-width-1-1 uk-text-large uk-padding"><b
                                        class="uk-float-left">${listing.name}</b>
                                    <c:choose>
                                        <c:when test="${listing.type == 'auction'}">
                                            <b class="uk-float-right">$${listing.highestBid}</b>
                                        </c:when>
                                        <c:when test="${listing.type == 'fixed'}">
                                            <b class="uk-float-right">$${listing.price}</b>
                                        </c:when>
                                        <c:otherwise>
                                            <b class="uk-float-right">Free</b>
                                        </c:otherwise>
                                    </c:choose>
                                </span>

                                <div class="uk-width-1-1 uk-padding-small uk-margin-small-top">
                                    <p>${listing.description}</p>
                                </div>


                                <div uk-slideshow="autoplay: true" uk-slideshow>

                                    <ul class="uk-slideshow-items">
                                        <c:forEach items="${listing.images}" var="listingImages">
                                            <div uk-lightbox>
                                                <li>
                                                    <a href="
                                        ${pageContext.request.contextPath}/directory/${listingImages.image_path}/${listingImages.image_name}"
                                                       title="Image">
                                                        <img class="uk-align-center uk-cover"
                                                             src="${pageContext.request.contextPath}/directory/${listingImages.image_path}/${listingImages.image_name}"
                                                             alt="Listing" style="height: auto; width: auto;">
                                                    </a>
                                                </li>
                                            </div>
                                        </c:forEach>
                                    </ul>

                                </div>
                            </div>

                            <!-- Seller Information -->
                            <div class="uk-width-1-2@m uk-text-center">
                                <c:choose>
                                    <c:when test="${pickUp.transaction.buyer.userID == sessionScope.user.userID}">
                                        <b style="font-size: 22px;">Seller
                                            - ${pickUp.transaction.seller.firstName} ${pickUp.transaction.seller.lastName}</b>
                                        <img class="uk-border-circle uk-align-center"
                                             style="width: 150px; height: 150px;"
                                             src="${pageContext.request.contextPath}/directory/${pickUp.transaction.seller.mainImage}"
                                             uk-tooltip="${pickUp.transaction.seller.username}"/>
                                        <span style="font-size: 22px;"><strong style="color: #ff695c">
                                            Email: </strong>${pickUp.transaction.seller.schoolEmail}
                                        </span>
                                        <br>
                                        <span style="font-size: 22px;"><strong style="color: #ff695c">
                                            Phone: </strong>${pickUp.transaction.seller.phoneNumber}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <b style="font-size: 22px;">Buyer
                                            - ${pickUp.transaction.buyer.firstName} ${pickUp.transaction.buyer.lastName}</b>
                                        <img class="uk-border-circle uk-align-center"
                                             style="width: 150px; height: 150px;"
                                             src="${pageContext.request.contextPath}/directory/${pickUp.transaction.buyer.mainImage}"
                                             uk-tooltip="${pickUp.transaction.buyer.username}"/>
                                        <span style="font-size: 22px;"><strong style="color: #ff695c">
                                            Email: </strong>${pickUp.transaction.buyer.schoolEmail}
                                        </span>
                                        <br>
                                        <span style="font-size: 22px;"><strong style="color: #ff695c">
                                            Phone: </strong>${pickUp.transaction.buyer.phoneNumber}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Pick Up Details -->
                    <h2>Pickup Details <a onclick="addToGoogleCalendar()"
                                          style="background-color: #ff695c; color: white; width: 45px; height: 45px;"
                                          class="uk-icon-button uk-float-right uk-box-shadow-medium uk-box-shadow-hover-large"
                                          uk-icon="google" uk-tooltip="Add To Google Calendar" id="google-icon"
                                          hidden></a>
                    </h2>
                    <div class="uk-card uk-card-default uk-box-shadow-hover-large uk-border-rounded">
                        <div class="uk-card-body uk-grid-small" uk-grid>
                            <div class="uk-width-1-1 uk-padding-remove">
                                <span class="uk-text-center">
                                    <span class="uk-width-1-3@m uk-width-1-1@s uk-padding-small"><span
                                            class="uk-text-large"><strong
                                            style="color: #ff695c">Location: </strong>${pickUp.location.name}</span>
                                    </span>
                                    <span class="uk-width-1-3@m uk-width-1-1@s uk-padding-small"><span
                                            class="uk-text-large"><strong
                                            style="color: #ff695c">Date: </strong>${pickUp.pickUpDate}</span>
                                    </span>
                                    <span class="uk-width-1-3@m uk-width-1-1@s uk-padding-small"><span
                                            class="uk-text-large"><strong
                                            style="color: #ff695c">Time: </strong>${pickUp.pickUpTime}</span>
                                    </span>
                                </span>

                                <div id="map" class="uk-align-center" style="width:95%;height:300px;"></div>

                            </div>
                        </div>
                    </div>
                    <br>
                </div>

                <!-- Right side -->
                <div class="uk-width-1-3@m uk-width-1-1@s">

                    <div uk-sticky="offset: 50; bottom: #footer">

                        <h2>Transaction Details</h2>
                        <div class="uk-card uk-card-default uk-box-shadow-hover-large uk-border-rounded">
                            <c:set var="total" value="0"/>
                            <c:choose>
                                <c:when test="${sessionScope.user.userID == pickUp.transaction.buyer.userID}">
                                    <div class="uk-card-header">
                                        <h4 class="uk-margin-remove-bottom uk-text-center">Cost
                                            <c:choose>
                                                <c:when test="${listing.paymentType == 'CASH'}">
                                                    (Paid In Person)
                                                </c:when>
                                                <c:otherwise>
                                                    (Paid Via PayPal)
                                                </c:otherwise>
                                            </c:choose>
                                        </h4>
                                    </div>
                                    <!-- Buyer Transaction Details -->
                                    <div class="uk-card-body">
                                        <table class="uk-table">
                                            <tbody>
                                            <c:choose>
                                                <c:when test="${listing.type == 'auction'}">
                                                    <tr>
                                                        <td class="uk-float-left">Winning Bid</td>
                                                        <td class="uk-float-right">$${listing.highestBid}</td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td class="uk-float-left">Price</td>
                                                        <td class="uk-float-right">$${listing.price}</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="uk-card-footer uk-background-default">
                                        <table class="uk-table">
                                            <tbody>
                                            <c:choose>
                                                <c:when test="${listing.type == 'auction'}">
                                                    <tr>
                                                        <td class="uk-float-left">Total</td>
                                                        <td class="uk-float-right">
                                                <span class="uk-badge"
                                                      style="background-color: red; color: white;">$${listing.highestBid}</span>
                                                        </td>
                                                    </tr>
                                                    <c:set var="total" value="${listing.highestBid}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td class="uk-float-left">Total</td>
                                                        <td class="uk-float-right">$${listing.price}</td>
                                                    </tr>
                                                    <c:set var="total" value="${listing.price}"/>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="uk-card-header">
                                        <h4 class="uk-margin-remove-bottom uk-text-center">Earnings
                                            <c:if test="${listing.type != 'donation'}">
                                                <c:choose>
                                                    <c:when test="${pickUp.transaction.listingID.paymentType == 'CASH'}">
                                                        (In Person)
                                                    </c:when>
                                                    <c:otherwise>
                                                        (Via PayPal After Pickup)
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </h4>
                                    </div>
                                    <div class="uk-card-body">
                                        <table class="uk-table">
                                            <tbody>
                                            <c:choose>
                                                <c:when test="${listing.type == 'auction'}">
                                                    <tr>
                                                        <td class="uk-float-left">Winning Bid</td>
                                                        <td class="uk-float-right">+$${listing.highestBid}</td>
                                                    </tr>
                                                    <c:if test="${listing.premium == 1}">
                                                        <tr>
                                                            <td class="uk-float-left">Premium</td>
                                                            <td class="uk-float-right">
                                                                -$${listing.highestBid * 0.05}</td>
                                                        </tr>
                                                    </c:if>
                                                    <tr>
                                                        <td class="uk-float-left">Listing Cost</td>
                                                        <td class="uk-float-right">
                                                            -$${listing.highestBid * 0.05}</td>
                                                    </tr>
                                                </c:when>
                                                <c:when test="${listing.type == 'fixed'}">
                                                    <tr>
                                                        <td class="uk-float-left">Price</td>
                                                        <td class="uk-float-right">+$${listing.price}</td>
                                                    </tr>
                                                    <c:if test="${listing.premium == 1}">
                                                        <tr>
                                                            <td class="uk-float-left">Premium</td>
                                                            <td class="uk-float-right">
                                                                -$${listing.highestBid * 0.05}</td>
                                                        </tr>
                                                    </c:if>
                                                    <tr>
                                                        <td class="uk-float-left">Listing Cost</td>
                                                        <td class="uk-float-right">
                                                            -$${listing.highestBid * 0.05}</td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td class="uk-float-left">Price</td>
                                                        <td class="uk-float-right">Free</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="uk-card-footer uk-background-default">
                                        <table class="uk-table">
                                            <tbody>
                                            <c:choose>
                                                <c:when test="${listing.type == 'auction'}">
                                                    <tr>
                                                        <td class="uk-float-left">Total</td>
                                                        <c:choose>
                                                            <c:when test="${listing.premium == 1}">
                                                                <td class="uk-float-right">
                                                <span class="uk-badge uk-padding-small uk-text-center"
                                                      style="background-color: green; color: white;">+$${listing.highestBid - (listing.highestBid * 0.05) - (listing.highestBid * 0.05)}</span>
                                                                </td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td class="uk-float-right">
                                                <span class="uk-badge uk-padding-small uk-text-center"
                                                      style="background-color: green; color: white;">+$${listing.highestBid - (listing.highestBid * 0.05)}</span>
                                                                </td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </tr>
                                                </c:when>
                                                <c:when test="${listing.type == 'fixed'}">
                                                    <tr>
                                                        <td class="uk-float-left">Total</td>
                                                        <c:choose>
                                                            <c:when test="${listing.premium == 1}">
                                                                <td class="uk-float-right">
                                                <span class="uk-badge uk-padding-small uk-text-center"
                                                      style="background-color: green; color: white;">+$${listing.price - (listing.price * 0.05) - (listing.price * 0.05)}</span>
                                                                </td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td class="uk-float-right">
                                                <span class="uk-badge uk-padding-small uk-text-center"
                                                      style="background-color: green; color: white;">+$${listing.price - (listing.price * 0.05)}</span>
                                                                </td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td class="uk-float-left">Total</td>
                                                        <td class="uk-float-right">Free</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </div>

                        <c:choose>
                            <c:when test="${listing.paymentType == 'CASH' && sessionScope.user.userID == pickUp.transaction.buyer.userID}">
                                <a class="uk-button-large uk-border-rounded uk-button-primary uk-float-right uk-margin-large-top uk-box-shadow-hover-large"
                                   href="/finish-checkout?l=${listing.id}">
                                    I Agree To Pay $${total}
                                </a>
                                <div id="paypal-button" hidden></div>
                            </c:when>

                            <c:when test="${listing.paymentType == 'PAYPAL' && sessionScope.user.userID == pickUp.transaction.buyer.userID}">
                                <div class="uk-margin-medium-top uk-float-right" id="paypal-button"></div>
                            </c:when>

                            <c:otherwise>
                                <a class="uk-button-large uk-border-rounded uk-button-primary uk-float-right uk-margin-large-top uk-box-shadow-hover-large"
                                   href="/finish-checkout?l=${listing.id}">Finish</a>
                                <div id="paypal-button" hidden></div>
                            </c:otherwise>
                        </c:choose>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<%@include file="../jspf/footer.jspf" %>

<script>
    var map;
    var marker;

    var listingType = '${listing.type}';

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: ${pickUp.location.latitude}, lng: ${pickUp.location.longitude}},
            zoom: 18,
            mapTypeId: google.maps.MapTypeId.HYBRID
        });

        marker = new google.maps.Marker({
            position: {lat: ${pickUp.location.latitude}, lng: ${pickUp.location.longitude}},
            map: map,
            animation: google.maps.Animation.DROP,
            title: 'Meeting Location'
        });
    }

    function addToGoogleCalendar() {
        $.ajax({

            type: 'GET',
            url: '/addToGoogleCalendar',
            data: {pickUpID: ${pickUp.pickUpID}},

        }).done(function (response) {
            if (response.result == 'USER NULL' || response.result == 'PICKUP NULL' || response.result == 'ERROR') {
                UIkit.notification({message: "Error Adding To Google Calendar", status: 'danger'});
                $('#dangerButton').click();
            } else {
                document.getElementById("google-icon").hidden = true;
                UIkit.notification({message: "Added To Google Calendar", status: 'success'});
                $('#successButton').click();
            }
        });
    }

    window.addEventListener("load", function () {
        var userPersonalEmail = '${sessionScope.user.email}';
        if (userPersonalEmail.includes('@gmail.com')) {
            document.getElementById("google-icon").hidden = false;
        }
    });

</script>


<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAYv7pVPxQ-k7yWlKPfa8ebsx7ci9q7vQ8&callback=initMap"
        type="text/javascript"></script>

<script>
    paypal.Button
        .render(
            {
                env: 'sandbox', // Or 'production',
                client: {
                    sandbox: 'AVGW1RKTj5gyUclN5wBmPk97pGaiTCsnR4AHZZ6QHsjDgraupasf1V8YbxMbKZLiBAJ-BwtkoUmIsfdf',
                    production: 'AUTi02B9WEFnsmjxP3XY2p2IljLU5HATmVK5yynF22kD3myoQhcQ7bKx2QF8CjiQRQ8-qyDJfgLwRd1u'
                },
                commit: true, // Show a 'Pay Now' button
                style: {
                    color: 'gold',
                    size: 'medium'
                },
                payment: function (data, actions) {
                    /*
                     * Set up the payment here
                     */
                    if (listingType == 'auction') {
                        return actions.payment.create({
                            payment: {
                                transactions: [{
                                    amount: {
                                        total: ${listing.highestBid},
                                        currency: 'USD'
                                    }
                                }]
                            }
                        });
                    } else if (listingType == 'fixed') {
                        return actions.payment.create({
                            payment: {
                                transactions: [{
                                    amount: {
                                        total: ${listing.price},
                                        currency: 'USD'
                                    }
                                }]
                            }
                        });
                    }
                },
                onAuthorize: function (data, actions) {
                    /*
                     * Execute the payment here
                     */
                    return actions.payment.execute().then(
                        function (payment) {

                            // Display success message

                            // Redirect to finish the checkout
                            setTimeout(function () {
                                window.location.replace("/finish-checkout?l=${listing.id}");
                            }, 2000);

                        });
                },
                onCancel: function (data, actions) {
                    showWarningMessage("Payment Cancelled");
                },
                onError: function (err) {
                    showErrorMessage("Error Processing Payment");
                }
            }, '#paypal-button');
</script>
</body>
</html>