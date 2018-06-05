<div class="uk-position-relative"
     style="background-color: white; margin-bottom: 10px;">
    <div class="uk-position-relativetop">
        <nav class="uk-navbar-container uk-navbar-transparent" uk-navbar>
            <div class="uk-navbar-left">
                <a class="uk-navbar-toggle" uk-navbar-toggle-icon
                   uk-toggle="target: #offcanvas-slide"></a>
            </div>
            <div class="uk-navbar-right">

                <ul class="uk-navbar-nav">


                    <!-- Notification Icon -->
                    <li><c:choose>
                        <c:when test="${unviewedNotificationCount > 0}">
                            <a uk-icon="icon: bell"><span class="badge1"
                                                          id="badge1" data-badge="${unviewedNotificationCount}"></span></a>
                        </c:when>
                        <c:otherwise>
                            <a uk-icon="icon: bell"></a>
                        </c:otherwise>
                    </c:choose>
                        <div uk-drop="mode: click" id="notificationDrop">
                            <div
                                    class="uk-card uk-card-body uk-card-default uk-padding-small"
                                    style="text-align: center">
                                <c:choose>
                                    <c:when test="${notifications != null}">
                                        <c:forEach items="${notifications}" var="notification"
                                                   varStatus="loop">
                                            <c:if test="${loop.index < 10}">
                                                <div
                                                        class="uk-tile uk-tile-muted uk-tile-small uk-margin-small uk-padding-small"
                                                        id="notification${notification.notificationID}">
                                                    <c:choose>
                                                        <c:when
                                                                test="${notification.subject == 'U-ListIt Notification'}">
                                                            <a class="uk-link-muted"
                                                               href="/listing?l=${notification.listingID}"
                                                               id="notification${notification.notificationID}"> <c:if
                                                                    test="${notification.viewed == 0}"> ${notification.message}
                                                                <span
                                                                        class="badge2" id="badge2"></span>
                                                            </c:if> <a class="uk-postion-top-right" style="color: red;"
                                                                       onclick="dismiss(${notification.notificationID});"
                                                                       uk-icon="icon: close"> </a>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a class="uk-link-muted"
                                                               href="/listing?l=${notification.listingID}"
                                                               id="notification${notification.notificationID}">${notification.subject}
                                                                <c:if test="${notification.viewed == 0}">
                                                                    <span class="badge2"></span>
                                                                </c:if> <a
                                                                        class="uk-position-top-right uk-padding-small"
                                                                        style="color: red;"
                                                                        onclick="dismiss(${notification.notificationID});"
                                                                        uk-icon="icon: close"> </a>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${notificationCount > 10}">
                                            <a style="color: darkgray;"
                                               href="${pageContext.request.contextPath}/notifications">
                                                See More</a>
                                        </c:if>
                                    </c:when>
                                    <c:when test="${notifications == null}">
                                        <c:choose>
                                            <c:when test="${user != null}">
                                                <p uk-icon="icon: happy" style="text-align: center">Nothing
                                                    To See Here</p>
                                            </c:when>
                                            <c:when test="${user == null}">
                                                <a uk-icon="icon: sign-in" href="/login"
                                                   style="text-align: center">Login To See Notifications</a>
                                            </c:when>
                                        </c:choose>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </li>
                    <c:choose>
                        <c:when test="${user != null }">
                            <li><a>Welcome ${sessionScope.user.firstName}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/login">
                                Login</a></li>
                            <li><a href="${pageContext.request.contextPath}/register">
                                Register</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </nav>
    </div>
</div>

<!--Side Nav Menu -->
<div id="offcanvas-slide" uk-offcanvas="overlay: true">
    <div class="admin-nav uk-offcanvas-bar uk-flex uk-flex-column">

        <ul
                class="uk-nav uk-nav-primary uk-nav-center uk-margin-auto-vertical">
            <li><a href="${pageContext.request.contextPath}/admin"><span
                    class="uk-margin-small-right" uk-icon="icon: home"></span>Dashboard</a></li>
            <li class="uk-nav-divider"></li>
            <li><a href="${pageContext.request.contextPath}/adminUser"><span
                    class="uk-margin-small-right" uk-icon="icon: users"></span>Manage Users</a></li>
            <c:if test="${sessionScope.user != null}">
                <li class="uk-nav-divider"></li>

                <li>
                    <a href="${pageContext.request.contextPath}/adminListing"><span
                            class="uk-margin-small-right" uk-icon="icon: user"></span>Manage Listings</a></li>
                <li class="uk-nav-divider"></li>

                <li><a href="${pageContext.request.contextPath}/adminDisputes"><span
                        class="uk-margin-small-right" uk-icon="icon: warning"></span>Manage Disputes</a></li>
                <li class="uk-nav-divider"></li>

                <li><a href="${pageContext.request.contextPath}/eventsNews"><span
                        class="uk-margin-small-right" uk-icon="icon: calendar"></span>Manage Comm. Page</a></li>
                <li class="uk-nav-divider"></li>

                <li><a href="${pageContext.request.contextPath}/adminFaqs"><span
                        class="uk-margin-small-right" uk-icon="icon: question"></span>Manage Faqs</a></li>
                <li class="uk-nav-divider"></li>

                <li><a href="${pageContext.request.contextPath}/adminLocations"><span
                        class="uk-margin-small-right" uk-icon="icon: location"></span>Manage Locations</a></li>
                <li class="uk-nav-divider"></li>

                <li><a href="${pageContext.request.contextPath}/adminDonations"><span
                        class="uk-margin-small-right" uk-icon="icon: happy"></span>Manage Donations</a></li>
                <li class="uk-nav-divider"></li>


                <li><a href="${pageContext.request.contextPath}/index"><span
                        class="uk-margin-small-right" uk-icon="icon: reply"></span>Homepage</a></li>
                <li class="uk-nav-divider"></li>

            </c:if>
        </ul>

    </div>
</div>

<%@include file="../checklist/checklist-sidenav.jsp" %>


<script>
    // Notification JS
    function dismiss(notificationID) {
        $.ajax({
            type: 'GET',
            url: '/dismiss',
            data: {n: notificationID},
        })
        document.getElementById('notification' + notificationID).style.display = "none";
    }

    function remove(notificationID) {
        $.ajax({
            type: 'GET',
            url: '/remove',
            data: {n: notificationID},
        })
        document.getElementById('notification' + notificationID).style.display = "none";
    }

    $('#notificationDrop').on("hide", function () {
        $.ajax({
            type: 'GET',
            url: '/markAsViewed',
        })

        document.getElementById('badge1').style.visibility = "hidden";

        var spans = document.getElementsByTagName('span');

        for (var i = 0; i < spans.length; i++) {
            var spanClass = spans[i].getAttribute("class");
            if (spans[i].getAttribute("class") === "badge2") {
                spans[i].style.display = "none";
            }
        }
    });
</script>