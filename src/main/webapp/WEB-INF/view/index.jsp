<%@include file="jspf/header.jsp" %>

<body onload="findFavorites()" class="uk-background-muted homepage-tutorial">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <%@include file="jspf/navbar.jspf" %>

    <%@include file="jspf/messages.jsp" %>

    <%@include file="jspf/help-icon.jsp" %>

    <div class="u-list-it-background uk-background-muted uk-inline-clip">
        <div class="uk-section-default uk-padding">
            <div class="uk-section uk-overlay-default uk-background-cover "
                 style="background-image:url('${pageContext.request.contextPath}/resources/img/index2.jpeg'); height: auto; max-height: 350px;  background-position: center;
                         background-repeat: no-repeat;
                         background-size: cover;">
                <div class="uk-overlay uk-light uk-align-center uk-border-rounded"
                     style="width:75%;background: rgba(34,34,34,0.85);"
                     data-intro="Search for listings and users here"
                     data-step="1">
                    <form class="uk-search uk-search-navbar uk-width-1-1"
                          method="POST" action="searchResults">
                        <span uk-search-icon></span>
                        <input id="search" class="uk-search-input" type="search" name="search">
                    </form>
                </div>
            </div>
        </div>

        <!-- Category Section -->
        <div class="uk-section uk-padding-large" data-intro="Click here to search listings by category."
             data-step="2">

            <ul class="uk-grid-small uk-child-width-1-2 uk-child-width-1-6@s uk-margin-small uk-text-center" uk-grid>
                <c:forEach var="category" items="${categories}" varStatus="loop">
                    <li class="item uk-animation uk-margin-small ">
                        <a href="/allView?categoryView=${category.category}"><img
                                class="category-pic uk-border-circle uk-box-shadow-hover-xlarge"
                                src="${pageContext.request.contextPath}/resources/img/category/${category.image}"></a>
                        <span class="caption">${category.category}</span>
                    </li>
                </c:forEach>
            </ul>


        </div>

        <!-- Hottest Listings -->
        <div class="uk-section-default" data-intro="Check out some of our hot listings!"
             data-step="3">

            <h1 class="uk-heading-line uk-padding"><span>Hottest Listings</span></h1>
            <div class="uk-position-relative uk-visible-toggle uk-light"
                 uk-slider="autoplay: true">

                <ul
                        class="uk-slider-items uk-child-width-1-2 uk-child-width-1-3@m uk-grid">

                    <c:forEach var="listing" items="${hottestListings}" varStatus="loop">
                        <li>
                            <div class="uk-panel">
                                <%@include file="listing/index-listing2.jsp" %>
                            </div>
                        </li>
                    </c:forEach>
                </ul>


                <a
                        class="uk-position-center-left uk-position-small uk-hidden-hover"
                        href="#" uk-slidenav-previous uk-slider-item="previous"></a> <a
                    class="uk-position-center-right uk-position-small uk-hidden-hover"
                    href="#" uk-slidenav-next uk-slider-item="next"></a>


            </div>
        </div>

        <!-- Community Section -->
        <div class="uk-section-default uk-padding"
             data-intro="Interested in events and news around your campus? Check out our community page."
             data-step="4">
            <div class="uk-tile uk-tile- uk-grid-collapse uk-child-width-1-2@s uk-margin" uk-grid>
                <div class="uk-card-media-left uk-cover-container">
                    <img src="${pageContext.request.contextPath}/resources/img/community.jpeg" alt="" uk-cover>
                    <canvas width="600" height="400"></canvas>
                </div>
                <div>
                    <div class="uk-card-body">
                        <h1 class="uk-heading-line uk-text-center uk-padding"><span>Community Page</span></h1>
                        <p class="uk-text-middle" style="font-size: 16px;">Come view our community page. Here you can
                            see all of your schools
                            latest events and news. Click here for more details.</p>

                        <br>
                        <br>
                        <a href="/communityPage">
                            <button class="uk-button uk-button-default uk-width-1-1 uk-margin-small-bottom">View Our
                                Community Page
                            </button>
                        </a>
                    </div>

                </div>
            </div>
        </div>

        <c:if test="${sessionScope.user != null}">
            <div class="uk-section-default">
                <h1 class="uk-heading-line uk-padding"><span>Suggested For You</span></h1>
                <div class="uk-position-relative uk-visible-toggle uk-light"
                     uk-slider="autoplay: true">

                    <ul
                            class="uk-slider-items uk-child-width-1-2 uk-child-width-1-3@m uk-grid">

                        <c:forEach var="listing" items="${relevent}" varStatus="loop">
                            <li>
                                <div class="uk-panel">
                                    <%@include file="listing/index-listing2.jsp" %>
                                </div>
                                <div class="uk-position-center uk-panel">
                                    <!-- Maybe use this area for something later -->
                                </div>
                            </li>
                        </c:forEach>
                    </ul>


                    <a
                            class="uk-position-center-left uk-position-small uk-hidden-hover"
                            href="#" uk-slidenav-previous uk-slider-item="previous"></a> <a
                        class="uk-position-center-right uk-position-small uk-hidden-hover"
                        href="#" uk-slidenav-next uk-slider-item="next"></a>


                </div>
            </div>
        </c:if>
        <br>
        <br>
        <br>

    </div>
</div>

<%@include file="jspf/footer.jspf" %>

<%@include file="checklist/checklist-modal.jsp" %>

<%@include file="checklist/checklist-sidenav.jsp" %>

</div>
</body>

<script>

    // Add something to given element placeholder
    function addToPlaceholder(toAdd, el) {
        el.attr('placeholder', el.attr('placeholder') + toAdd);
        // Delay between symbols "typing"
        return new Promise(resolve => setTimeout(resolve, 100));
    }

    // Cleare placeholder attribute in given element
    function clearPlaceholder(el) {
        el.attr("placeholder", "");
    }

    // Print one phrase
    function printPhrase(phrase, el) {
        return new Promise(resolve => {
            // Clear placeholder before typing next phrase
            clearPlaceholder(el);
            let letters = phrase.split('');
            // For each letter in phrase
            letters.reduce(
                (promise, letter, index) => promise.then(_ => {
                    // Resolve promise when all letters are typed
                    if (index === letters.length - 1) {
                        // Delay before start next phrase "typing"
                        setTimeout(resolve, 1000);
                    }
                    return addToPlaceholder(letter, el);
                }),
                Promise.resolve()
            );
        });
    }

    // Print given phrases to element
    function printPhrases(phrases, el) {
        // For each phrase
        // wait for phrase to be typed
        // before start typing next
        phrases.reduce(
            (promise, phrase) => promise.then(_ => printPhrase(phrase, el)),
            Promise.resolve()
        );
    }

    // Start typing
    function run() {
        let phrases = [
            "Looking to furnish your new place?",
            "Need books or school supplies?",
            "See what other students are selling!",
            "Search..."
        ];

        printPhrases(phrases, $('#search'));
    }

    run();

</script>

<script>

    // Start Tutorial
    window.addEventListener("load", function () {
        $.ajax({
            type: 'GET',
            url: '/checkForTutorial',
            data: {page: "home"},
        }).done(function (response) {
            if (response.showTutorial == 'YES') {
                setTimeout(function () {
                    startTutorial();
                }, 1500);
            }
        });
    });

    function startTutorial() {
        introJs(".homepage-tutorial").start();
    }
</script>

<script>

    function findFavorites() {
        var jsonArray = ${requestScope.favoritedListings};

        var userID = ${sessionScope.user.userID};
        console.log(userID);

        for (var key in jsonArray) {
            if (jsonArray[key].userID == userID) {
                console.log("Hit");
                document.getElementById(jsonArray[key].listingID + 'unwatch').style = "inline";
            }

        }
    }

    function watch(listingID) {
        console.log("Hit Watch");
        var id = listingID;

        $.ajax({
            type: 'GET',
            url: '/watch',
            data: {"listingID": id},
        })

        document.getElementById(id + 'watch').style.display = "none";
        document.getElementById(id + 'unwatch').style.display = "inline";
    }

    function unwatch(listingID) {
        console.log("Hit Watch");
        var id = listingID;

        $.ajax({
            type: 'GET',
            url: '/unwatch',
            data: {"listingID": id},
        })

        document.getElementById(id + 'watch').style.display = "inline";
        document.getElementById(id + 'unwatch').style.display = "none";
    }
</script>

</html>