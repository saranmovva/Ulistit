<%@include file="../jspf/header.jsp" %>

<body class="uk-background-muted">

<%@include file="../jspf/navbar.jspf" %>

<%@include file="../jspf/messages.jsp" %>

<div class="uk-container">

    <div class="uk-grid uk-align-center" uk-grid>

        <div class="uk-width-1-1@m uk-width-1-1@s uk-align-center">

            <ul class="uk-breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/listing?l=${listing.id}">Listing</a></li>
                <li><span>Cancel Purchase</span></li>
            </ul>

            <h2>Cancellation Confirmation</h2>

            <div class="uk-tile-default uk-tile uk-box-shadow-medium uk-box-shadow-hover-large uk-border-rounded uk-margin-remove-top">

                <div class="uk-grid-large" uk-grid>

                    <div class="uk-width-1-2@m uk-width-1-1@s">
                        <h1>${listing.name}</h1>
                        <h3>${listing.description}</h3>

                        <c:choose>
                            <c:when test="${listing.user.userID == sessionScope.user.userID}">
                                <span style="font-size: 26px;"><b
                                        style="color: #0e6dcd">Buyer:</b> ${listing.highestBidder.username}</span>
                            </c:when>
                            <c:otherwise>
                                 <span style="font-size: 26px;"><b
                                         style="color: #0e6dcd">Seller:</b> ${listing.user.username}</span>
                            </c:otherwise>
                        </c:choose>

                        <br>
                        <br>

                        <c:choose>
                            <c:when test="${listing.type == 'auction'}">
                                <span style="font-size: 26px;"><b
                                        style="color: #0e6dcd">Winning Bid:</b> $${listing.highestBid}</span>
                            </c:when>
                            <c:otherwise>
                                <span style="font-size: 26px;"><b
                                        style="color: #0e6dcd">Price:</b> $${listing.price}</span>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <div class="uk-width-1-2@m uk-width-1-1@s">
                        <img src="${pageContext.request.contextPath}/resources/img/listings/couch.jpg"
                             style="height: auto; width: auto; max-height: 100%; max-width: 100%;">
                    </div>

                    <div class="uk-width-1-1">
                        <hr>
                    </div>

                    <div class="uk-width-3-4@m uk-align-center">

                        <div class="uk-inline">

                            <span class="uk-float-left">
                                <strong style="font-size: 32px">Fee <a uk-icon="icon: question"></a></strong></span>

                            <div uk-drop="pos: right-center; mode: click">
                                <div class="uk-card uk-card-body uk-card-default uk-text-center">
                                    You will be charged a <b>cancellation fee</b> of
                                    <b>10%</b> of the listing's cost.
                                    <br>
                                    All fees <b>must</b> be paid with PayPal.

                                </div>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${listing.type == 'auction'}">
                                <strong class="uk-float-right"
                                        style="font-size: 32px; color: #C96567">$${listing.highestBid * 0.10}</strong>
                            </c:when>
                            <c:otherwise>
                                <strong class="uk-float-right"
                                        style="font-size: 32px; color: #C96567">$${listing.price * 0.10}</strong>
                            </c:otherwise>
                        </c:choose>

                    </div>

                </div>

            </div>

            <div class="uk-margin-medium">
                <form class="uk-width-1-1@s uk-align-center">
                    <a class="uk-width-1-5@m uk-width-1-2@s uk-text-center uk-button-secondary uk-button-large uk-border-rounded uk-box-shadow-medium uk-box-shadow-hover-large uk-float-left"
                       type="submit">
                        Go Back
                    </a>
                    <div class="uk-width-1-5@m uk-width-1-2@s uk-float-right"
                         id="paypal-button"></div>
                </form>
            </div>

            <br>
            <br>

        </div>
    </div>
</div>

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
                    size: 'responsive',
                    shape: 'rect',
                    label: 'pay'
                },
                payment: function (data, actions) {
                    /*
                     * Set up the payment here
                     */
                    return actions.payment.create({
                        payment: {
                            transactions: [{
                                amount: {
                                    total: ${listing.highestBid * 0.10},
                                    currency: 'USD'
                                }
                            }]
                        }
                    });
                },
                onAuthorize: function (data, actions) {
                    /*
                     * Execute the payment here
                     */
                    return actions.payment.execute().then(
                        function (payment) {
                            showSuccessMessage("Payment Complete!");
                            $.ajax({
                                type: 'POST',
                                data: {l: ${listing.id}},
                                url: '/cancel-purchase',
                            });
                        });
                },
                onCancel: function (data, actions) {
                    showWarningMessage("Payment Canceled");
                },
                onError: function (err) {
                    showErrorMessage("Error Processing Payment");
                }
            }, '#paypal-button');
</script>

<%@include file="../jspf/add-message-js.jsp" %>

</body>
