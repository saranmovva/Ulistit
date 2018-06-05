<%@include file="../jspf/header.jsp" %>

<body class="uk-height-viewport">

<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <!-- Search Bar -->
    <nav class="uk-navbar-container" uk-navbar>
        <div class="uk-navbar-left">
            <div class="uk-navbar-item">
                <form class="uk-search uk-search-navbar" action="/search-donations" method="get">
                    <span uk-search-icon></span>
                    <input class="uk-search-input" type="search" name="s" placeholder="Search Donations...">
                </form>
            </div>
        </div>
    </nav>

    <!-- For Desktop Version -->
    <div class="uk-inline uk-width-1-1 uk-visible@m uk-margin-remove-top">

        <img src="${pageContext.request.contextPath}/resources/img/donation.jpg" style="height: auto; max-height: 425px;  background-position: center;
                 background-repeat: no-repeat;
                 background-size: cover; width: 100%;">

        <div class="uk-overlay uk-position-large uk-position-top-left uk-width-1-2">

            <h2 style="color: white; background-color: #404040; padding: 5px;"
                class="uk-width-1-1 uk-align-left uk-text-bold uk-border-rounded">Want to
                get rid of your stuff but
                don't think it's
                worth much?</h2>
            <h3 style="color: white; background-color: #404040; padding: 5px;"
                class="uk-width-3-4 uk-align-left uk-text-bold uk-border-rounded">Donate it to one of your
                classmates!</h3>
            <h4 style="color: white; background-color: #404040; padding: 5px;"
                class="uk-width-1-2 uk-align-left uk-text-bold uk-border-rounded">More information below.</h4>

        </div>

        <div class="uk-overlay uk-position-large uk-position-top-right uk-width-1-2" style="height: 275px">

            <a href="/createListing?t=donation"
               class="uk-button uk-button-large uk-border-rounded uk-button-danger uk-width-1-2 uk-position-bottom-right">
                Donate An Item
            </a>

        </div>

    </div>

    <!-- For Mobile Version -->
    <div class="uk-width-1-1 uk-hidden@m">

        <div class="uk-width-1-1 uk-padding-large">
            <a href="/donate-an-item"
               class="uk-button uk-button-large uk-border-rounded uk-button-danger uk-width-3-4 uk-align-center uk-margin-auto-vertical">
                Donate
                An Item
            </a>
        </div>

    </div>


    <div class="uk-align-center uk-background-muted uk-section uk-padding">


        <h1 class="uk-heading-line uk-text-center"><span>How Donating Works</span></h1>

        <div id="how-it-works"
             class="uk-tile uk-tile-default uk-width-1-1 uk-border-rounded uk-box-shadow-medium uk-box-shadow-hover-large uk-align-center uk-grid"
             uk-grid>

            <div class="uk-width-1-2@m uk-width-1-1@s uk-align-left uk-padding-remove-left uk-margin-remove">
                <h3>Have something you want to get rid of but don't think it's worth much?</h3>
                <h3>Click the button above and create a listing as a donation!</h3>
                <h3>When someone decides they want to take your item off your hands, you and the taker will
                    decide on a time and place that works best to meet.</h3>
                <h3>Once the pick up time comes around, just drop your item off to the taker!</h3>
                <h3>It's that easy!</h3>
            </div>

            <div class="uk-width-1-2@m uk-align-right uk-margin-remove uk-visible@m">
                <img src="${pageContext.request.contextPath}/resources/img/donation2.jpg" style="height: auto;
                        background-position: center; background-repeat: no-repeat; background-size: cover; width: 100%; height: 100%"
                     class="uk-border-rounded">
            </div>

        </div>
    </div>

    <div class="uk-align-center uk-background-muted uk-section uk-padding">
        <h1 class="uk-heading-line uk-text-center"><span>Recently Donated Items</span>
        </h1>

        <c:if test="${fn:length(donations) > 0}">
            <ul class="uk-slider-items uk-child-width-1-3@s uk-grid" uk-grid>
                <c:forEach var="listing" items="${donations}">
                    <div class="uk-margin-small-left uk-margin-small-right">
                        <%@include file="../listing/index-listing.jsp" %>
                    </div>
                </c:forEach>
            </ul>
        </c:if>
    </div>

    <div class="uk-align-center uk-background-muted uk-section uk-padding">
        <h1 class="uk-heading-line uk-text-center">
            <span>Search Donated Items By Category</span></h1>

        <div id="search-by-category" class="uk-width-1-1 uk-align-right">

            <div class="uk-align-center uk-width-1-1 uk-grid" uk-grid>
                <c:forEach var="category" items="${categories}" varStatus="loop">

                    <div class="item">
                        <a href="/search-donation-by-category?c=${category.category}"><img
                                class="category-pic uk-border-circle uk-box-shadow-hover-large"
                                src="${pageContext.request.contextPath}/resources/img/category/${category.image}"></a>
                        <span class="caption">${category.category}</span>
                    </div>

                </c:forEach>
            </div>

        </div>
    </div>

</div>

<%@include file="../jspf/footer.jspf" %>

</div>

</body>
</html>