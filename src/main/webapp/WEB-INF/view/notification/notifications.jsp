<%@include file="../jspf/header.jsp" %>

<body class="uk-height-viewport">

<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <div class="uk-section uk-background-muted">

        <div class="uk-width-3-4@l uk-width-3-4@m uk-width-1-1@s uk-align-center uk-padding-small">

            <h1 class="uk-heading-line uk-text-center"><span>Notifications</span></h1>

            <div class="uk-tile uk-tile-default uk-border-rounded uk-box-shadow-medium uk-box-shadow-hover-large">

                <ul class="uk-width-1-1" uk-tab>
                    <li><a href="#">New</a></li>
                    <li><a href="#">All</a></li>
                </ul>

                <c:choose>

                    <c:when test="${active.size() > 0}">

                        <ul class="uk-switcher">

                            <!-- New Notifications -->
                            <li id="new">
                                <ul class="uk-list" uk-grid>

                                    <c:forEach items="${active}" var="notification" varStatus="loop">
                                        <c:if test="${notification.viewed == 0}">

                                            <li class="uk-width-1-1 uk-grid-small uk-margin notification"
                                                id="notification${notification.notificationID}ItemNew"
                                                style="font-size: 16px;" uk-grid>

                                                <!-- Icon Section -->
                                                <div class="uk-width-1-6@m uk-width-1-3@s">

                                                    <!-- For Mobile -->
                                                    <div class="uk-hidden@m uk-hidden@l">
                                                        <!-- Skip First Line -->
                                                        <c:if test="${loop.index != 0}">
                                                            <hr>
                                                        </c:if>
                                                        <c:if test="${notification.viewed == 0}">
                                                        <span class="uk-badge uk-align-left"
                                                              style="background-color: #ff695c;">New</span>
                                                        </c:if>
                                                        <a onclick="remove(${notification.notificationID});"
                                                           class="uk-align-right"
                                                           title="Remove"
                                                           style="color: red"
                                                           uk-icon="icon: close; ratio: 1.3"
                                                           uk-tooltip="title: Remove"></a>
                                                    </div>


                                                    <c:choose>

                                                        <c:when test="${notification.type == 'WON'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-won uk-align-center">
                                                                <div class="notification-icon-won">
                                                                    <i class="fas fa-trophy"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${notification.type == 'LOST'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-lost uk-align-center">
                                                                <div class="notification-icon-lost">
                                                                    <i class="far fa-frown"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${notification.type == 'SOLD'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-sold uk-align-center">
                                                                <div class="notification-icon-sold">
                                                                    <i class="far fa-money-bill-alt"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${notification.type == 'HIGHEST_BIDDER'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-highest-bidder uk-align-center">
                                                                <div class="notification-icon-highest-bidder">
                                                                    <i class="fas fa-thumbs-up"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${notification.type == 'NO_BIDDER'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-no-bidder uk-align-center">
                                                                <div class="notification-icon-no-bidder">
                                                                    <i class="fas fa-thumbs-down"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>


                                                        <c:when test="${notification.type == 'BID_CANCEL'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-bid-cancel uk-align-center">
                                                                <div class="notification-icon-bid-cancel">
                                                                    <i class="fas fa-ban"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${notification.type == 'DISPUTE'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-dispute uk-align-center">
                                                                <div class="notification-icon-dispute">
                                                                    <i class="fas fa-gavel"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${notification.type == 'DONATION'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-donation uk-align-center">
                                                                <div class="notification-icon-donation">
                                                                    <i class="fas fa-hand-holding-heart"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:when test="${notification.type == 'PICKUP'}">
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-pickup uk-align-center">
                                                                <div class="notification-icon-pickup">
                                                                    <i class="fas fa-people-carry"></i>
                                                                </div>
                                                            </div>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-default uk-align-center">
                                                                <div class="notification-icon-default">
                                                                    <i class="fas fa-star"></i>
                                                                </div>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </div>

                                                <!-- Title and Description Desktop Version -->
                                                <div class="uk-width-5-6@m uk-width-5-6@l uk-width-1-1@s">

                                                    <!-- Dismiss Section for Desktop -->
                                                    <a onclick="remove(${notification.notificationID});"
                                                       class="uk-align-right uk-visible@m"
                                                       title="Remove"
                                                       style="color: red"
                                                       uk-icon="icon: close; ratio: 1.3"></a>

                                                    <span>
                                                <a class="uk-link-muted"
                                                   href="/listing?l=${notification.listingID}"><strong>${notification.subject}</strong></a>

                                                <c:if test="${notification.viewed == 0}">
                                                    <span class="uk-badge uk-visible@m"
                                                          style="background-color: #ff695c;">New</span>
                                                </c:if>

                                                        <!-- For Mobile -->
                                                <br class="uk-hidden@m uk-hidden@l">

                                                <strong class="uk-float-right">${notification.formattedDate}</strong>
                                            </span>

                                                    <!-- For Mobile -->
                                                    <br class="uk-hidden@m uk-hidden@l">

                                                    <p>${notification.message}</p>

                                                </div>

                                            </li>

                                        </c:if>
                                    </c:forEach>

                                </ul>
                            </li>

                            <!-- All Notifications -->
                            <li id="all">
                                <ul class="uk-list" uk-grid>

                                    <c:forEach items="${active}" var="notification" varStatus="loop">

                                        <li class="uk-width-1-1 uk-grid-small uk-margin notification"
                                            id="notification${notification.notificationID}Item"
                                            style="font-size: 16px;" uk-grid>

                                            <!-- Icon Section -->
                                            <div class="uk-width-1-6@m uk-width-1-3@s">

                                                <!-- For Mobile -->
                                                <div class="uk-hidden@m uk-hidden@l">
                                                    <!-- Skip First Line -->
                                                    <c:if test="${loop.index != 0}">
                                                        <hr>
                                                    </c:if>
                                                    <c:if test="${notification.viewed == 0}">
                                                        <span class="uk-badge uk-align-left"
                                                              style="background-color: #ff695c;">New</span>
                                                    </c:if>
                                                    <a onclick="remove(${notification.notificationID});"
                                                       class="uk-align-right"
                                                       title="Remove"
                                                       style="color: red"
                                                       uk-icon="icon: close; ratio: 1.3"></a>
                                                </div>


                                                <c:choose>

                                                    <c:when test="${notification.type == 'WON'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-won uk-align-center">
                                                            <div class="notification-icon-won">
                                                                <i class="fas fa-trophy"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:when test="${notification.type == 'LOST'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-lost uk-align-center">
                                                            <div class="notification-icon-lost">
                                                                <i class="far fa-frown"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:when test="${notification.type == 'SOLD'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-sold uk-align-center">
                                                            <div class="notification-icon-sold">
                                                                <i class="far fa-money-bill-alt"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:when test="${notification.type == 'HIGHEST_BIDDER'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-highest-bidder uk-align-center">
                                                            <div class="notification-icon-highest-bidder">
                                                                <i class="fas fa-thumbs-up"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:when test="${notification.type == 'NO_BIDDER'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-no-bidder uk-align-center">
                                                            <div class="notification-icon-no-bidder">
                                                                <i class="fas fa-thumbs-down"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>


                                                    <c:when test="${notification.type == 'BID_CANCEL'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-bid-cancel uk-align-center">
                                                            <div class="notification-icon-bid-cancel">
                                                                <i class="fas fa-ban"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:when test="${notification.type == 'DISPUTE'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-dispute uk-align-center">
                                                            <div class="notification-icon-dispute">
                                                                <i class="fas fa-gavel"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:when test="${notification.type == 'DONATION'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-donation uk-align-center">
                                                            <div class="notification-icon-donation">
                                                                <i class="fas fa-hand-holding-heart"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:when test="${notification.type == 'PICKUP'}">
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-pickup uk-align-center">
                                                            <div class="notification-icon-pickup">
                                                                <i class="fas fa-people-carry"></i>
                                                            </div>
                                                        </div>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <div class="uk-text-center uk-iconnav-vertical uk-margin-small-top
                                                    notification-page-icon notification-icon-circle-default uk-align-center">
                                                            <div class="notification-icon-default">
                                                                <i class="fas fa-star"></i>
                                                            </div>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>

                                            <!-- Title and Description Desktop Version -->
                                            <div class="uk-width-5-6@m uk-width-5-6@l uk-width-1-1@s">

                                                <!-- Dismiss Section for Desktop -->
                                                <a onclick="remove(${notification.notificationID});"
                                                   class="uk-align-right uk-visible@m"
                                                   title="Remove"
                                                   style="color: red"
                                                   uk-icon="icon: close; ratio: 1.3"></a>

                                                <span>
                                                <a class="uk-link-muted"
                                                   href="/listing?l=${notification.listingID}"><strong>${notification.subject}</strong></a>

                                                <c:if test="${notification.viewed == 0}">
                                                    <span class="uk-badge uk-visible@m"
                                                          style="background-color: #ff695c;">New</span>
                                                </c:if>

                                                    <!-- For Mobile -->
                                                <br class="uk-hidden@m uk-hidden@l">

                                                <strong class="uk-float-right">${notification.formattedDate}</strong>
                                            </span>

                                                <!-- For Mobile -->
                                                <br class="uk-hidden@m uk-hidden@l">

                                                <p>${notification.message}</p>

                                            </div>

                                        </li>

                                    </c:forEach>

                                </ul>
                            </li>

                        </ul>

                    </c:when>

                    <c:otherwise>
                        <h3>No Notifications</h3>
                    </c:otherwise>

                </c:choose>

            </div>

        </div>

    </div>

</div>

<%@include file="../jspf/footer.jspf" %>

</body>
</html>