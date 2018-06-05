<%@include file="jspf/header.jsp" %>

<body>
<%@include file="jspf/navbar.jspf" %>
<br>
<br>
<br>
<div class="uk-child-width-expand@s uk-text-center" uk-grid>
    <div class="uk-width-1-4">
        <div class="uk-card uk-card-muted uk-card-body uk-grid-margin">
            <div>
                <h3>
                    <a class="uk-link-heading" href="">Content Header</a>
                </h3>
            </div>
            <hr>
            <div>
                <a href="" class="uk-link-reset">content</a>
            </div>
            <div>
                <a href="" class="uk-link-reset">content</a>
            </div>
            <div>
                <a href="" class="uk-link-reset">content</a>
            </div>
            <br>

            <div>
                <h3>
                    <a class="uk-link-heading" href="">Content Header</a>
                </h3>
            </div>
            <hr>
            <div>
                <a href="" class="uk-link-reset">content</a>
            </div>
            <div>
                <a href="" class="uk-link-reset" swe4w property>content</a>
            </div>
            <div>
                <a href="" class="uk-link-reset">content</a>
            </div>
            <br>

            <div>
                <h3>
                    <a class="uk-link-heading" href="">Content Header</a>
                </h3>
            </div>
            <hr>
            <div>
                <a href="" class="uk-link-reset">content</a>
            </div>
            <div>
                <a href="" class="uk-link-reset">content</a>
            </div>
            <div>
                <a href="" class="uk-link-reset"> content</a>
            </div>
            <br>
        </div>
    </div>
    <div class="uk-width-3-4">
        <ul class="uk-flex-center" uk-tab>
            <li><a href="#">Your Listings</a></li>
            <li><a href="#">Your Biddings</a></li>
            <li><a href="#">Currently Watching</a></li>
        </ul>

        <ul class="uk-switcher uk-margin">
            <li>
                <div class="uk-grid-large uk-child-width-1-3 uk-text-center"
                     uk-grid>
                    <c:forEach var="listing" items="${userListings}">
                        <%@include file="listing/index-listing.jsp" %>
                    </c:forEach>

                </div>
            </li>
            <li>
                <div class="uk-grid-large uk-text-center" uk-grid>
                    <%@include file="profile-bid-section.jsp" %>
                </div>
            </li>
            <li>
                <div
                        class="uk-grid-large uk-child-width-1-3 uk-text-center" uk-grid>
                    <c:forEach var="listing" items="${userFavoriteListings}">
                        <%@include file="listing/index-listing.jsp" %>

                    </c:forEach>

                </div>
            </li>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    $(".watch-item").click(function () {
        var id = $(this).attr('id')
        $(this).toggleClass('watch-item');
        console.log("Hit Ajax")
        $.ajax({
            type: "POST",
            url: "watchListing",
            data: {
                listingID: id
            },
            success: function () {
                console.log("Complete")
            },

        });
    })
</script>
<%@include file="jspf/footer.jspf" %>
</body>
</html>