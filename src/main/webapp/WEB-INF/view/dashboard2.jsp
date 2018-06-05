<%@include file="jspf/header.jsp" %>

<body>
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="jspf/navbar.jspf" %>

    <!-- 1st Section: Data/welcome/statistics -->

    <div class="uk-section uk-background-muted">

        <%@include file="dashboard/welcome-statistics.jsp" %>

    </div>

    <!-- 2nd Section: Listings/Content -->

    <div class="uk-section">

        <div class="uk-container uk-container-expand">

            <div uk-grid="" class="uk-grid">
                <div class="uk-width-auto@m uk-width-1-3@s uk-first-column">

                    <div class="uk-padding-small uk-border-rounded">
                        <ul class="uk-nav uk-nav-default"
                            uk-switcher="connect: #seller-content; animation: uk-animation-fade; toggle: > :not(.uk-nav-header)">
                            <li id="dashboardAll" aria-expanded="true" class="uk-active"><a onclick="allListingsDashboardLoad()">All</a></li>
                            <li id="dashboardActive" aria-expanded="false"><a onclick="activeListingsDashboardLoad()">Active</a></li>
                            <li id="dashboardInactive" aria-expanded="false"><a onclick="inactiveListingsDashboardLoad()">Inactive</a></li>
                            <li id="dashboardWon" aria-expanded="false"><a onclick="wonListingsDashboardLoad()">Won</a></li>
                            <li id="dashboardLost" aria-expanded="false"><a onclick="lostListingsDashboardLoad()">Lost</a></li>
                            <li id="dashboardSold" aria-expanded="false"><a onclick="soldListingsDashboardLoad()">Sold</a></li>
                            <li id="dashboardFavorite" aria-expanded="false"><a onclick="favoriteListingsDashboardLoad()">Favorited</a></li>
                        </ul>
                    </div>
                </div>
                <div class="uk-width-expand@m uk-width-2-3@s">

                    <!-- Begin content switcher -->
                    <ul id="seller-content" class="uk-switcher">

                        <!-- 1st set of content: All listings -->
                        <%@include file="dashboard/switcher-content/all-listings.jsp" %>

                        <!-- 2nd set of content: Active listings -->
                        <%@include file="dashboard/switcher-content/active-listings.jsp" %>

                        <!-- 3rd set of content: Inactive listings -->
                        <%@include file="dashboard/switcher-content/inactive-listings.jsp" %>

                        <!-- 4th set of content: Won listings -->
                        <%@include file="dashboard/switcher-content/won-listings.jsp" %>

                        <!-- 5th set of content: Lost listings -->
                        <%@include file="dashboard/switcher-content/lost-listings.jsp" %>

                        <!-- 6th set of content: Sold listings -->
                        <%@include file="dashboard/switcher-content/sold-listings.jsp" %>

                        <!-- 7th set of content: Favorited listings -->
                        <%@include file="dashboard/switcher-content/favorite-listings.jsp" %>

                    </ul>
                    <!-- End content switcher -->
                </div>
            </div>
        </div>

    </div>

    <!-- 3rd Section: Tables -->

    <div class="uk-section uk-background-muted" uk-height-viewport="min-height:300"
         style="box-sizing: border-box; min-height: 100vh; height: 100vh;">
        <div class="uk-container uk-container-expand">
            <div class="uk-grid-small uk-child-width-1-2@m uk-child-width-1-3@l uk-padding-small uk-grid-match" uk-grid>

                <%@include file="dashboard/dashboard-offers.jsp" %>
                <%@include file="dashboard/dashboard-meetings.jsp" %>
                <%@include file="dashboard/dashboard-transactions.jsp" %>

            </div>
        </div>
    </div>
</div>
<%@include file="jspf/footer.jspf" %>
</body>

<script type="text/javascript" src="resources/js/uikit.js"></script>
<script type="text/javascript" src="resources/js/uikit-icons.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js"
        integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+"
        crossorigin="anonymous"></script>
</html>