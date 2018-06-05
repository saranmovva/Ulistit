<%@include file="jspf/header.jsp" %>

<body class="uk-background-muted">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="jspf/navbar.jspf" %>

    <%@include file="jspf/messages.jsp" %>

    <div class="uk-section-default">
        <div class="uk-section uk-section-xlarge uk-section-overlap uk-background-fixed uk-light uk-background-cover uk-background-overlay"
             style="background-image: url(http://www.ben.edu/facilities-management-planning/images/BenU_1.jpg)">
            <div class="uk-align-center uk-card uk-card-default uk-box-shadow-hover-large uk-align-center uk-border-rounded uk-padding-small uk-width-1-2">

                <div class="uk-text-large uk-text-bold">
                    <div class="uk-heading-line uk-text-center"><span>Welcome to U-ListIt.</span></div>
                </div>

            </div>
        </div>
    </div>

    <br>
    <div class="uk-section-small uk-align-center uk-section-overlap uk-section-secondary">
        <div class="uk-container">

            <div class="uk-panel uk-align-center uk-text-center uk-light uk-margin-large">
                <span uk-icon="icon: users; ratio: 3.5"></span><h2>A unique way to buy, sell, and give back back to your college community</h2>
            </div>

            <div class="uk-grid-match uk-child-width-expand@m" uk-grid>
                <div>
                    <div class="uk-card uk-border-rounded uk-card-default uk-card-body uk-padding-large">
                        <i class="uk-align-center fas fa-shopping-cart" style="font-size: 4em"></i>
                        <p>U-ListIt is a buy, sell, and donation platform for colleges and universities around the globe.
                            Our focus is fast and easy commercial exchange.</p>
                    </div>
                </div>
                <div>
                    <div class="uk-card uk-border-rounded uk-card-default uk-card-body uk-padding-large">
                        <i class="uk-align-center fas fa-truck" style="font-size: 4em"></i>
                        <p>Forget the shipping - being on campus allows for the simple pick up of packages and items. No waiting, no worry! </p>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="uk-section-default">
        <div class="uk-section  uk-text-small uk-section-xlarge uk-section-overlap uk-background-fixed uk-light uk-background-cover uk-background-overlay"
             style="background-image: url(https://az616578.vo.msecnd.net/files/2016/04/21/635968723277050082-897173380_thumbs%20up.jpg)">
            <div class="uk-child-width-1-3@m uk-grid-small uk-padding-small uk-text-small uk-grid-match" uk-grid>
                <div>
                    <div class="uk-card uk-text-small uk-box-shadow-hover-large uk-border-rounded uk-card-default uk-card-body">
                        <i class="fas fa-home" style="font-size: 4em"></i><h4 class="uk-card-title">Moving in? Need some stuff?</h4>
                        <p>Fulfill all your dorming needs!</p>
                        <p><a class="uk-button uk-button-primary uk-border-rounded uk-button-small" href="${pageContext.request.contextPath}/index">View Listings</a></p>
                    </div>
                </div>
                <div>
                    <div class="uk-card uk-text-small uk-box-shadow-hover-large uk-border-rounded uk-card-default uk-card-body">
                        <i class="fas fa-dollar-sign" style="font-size: 4em"></i><h4 class="uk-card-title">Putting on that cap and gown?</h4>
                        <p>Make some cash before you grab that diploma!</p>
                        <p><a class="uk-button uk-button-primary uk-border-rounded uk-button-small" href="${pageContext.request.contextPath}/createListing">Create a Listing</a></p>
                    </div>
                </div>
                <div>
                    <div class="uk-card uk-text-small uk-box-shadow-hover-large uk-border-rounded uk-card-default uk-card-body">
                        <i class="fas fa-recycle" style="font-size: 4em"></i><h4 class="uk-card-title">Be kind, donate!</h4>
                        <p>Not in it for the money? Donate to the community!</p>
                        <p><a class="uk-button uk-button-primary uk-border-rounded uk-button-small" href="${pageContext.request.contextPath}/donations">Donations Page</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <br>
</div>


<%@include file="checklist/checklist-modal.jsp" %>

<%@include file="checklist/checklist-sidenav.jsp" %>

<%@include file="jspf/footer.jspf" %>
<script>
    function trendingClicked() {
        document.getElementById('trending-listings').style.display = 'inline';
        document.getElementById('ending-soon-listings').style.display = 'none';
        document.getElementById('recently-added-listings').style.display = 'none';
        document.getElementById('relevant-listings').style.display = 'none';
        document.getElementById('premium-listings').style.display = 'none';
    }

    function endingSoonClicked() {
        document.getElementById('trending-listings').style.display = 'none';
        document.getElementById('ending-soon-listings').style.display = 'inline';
        document.getElementById('recently-added-listings').style.display = 'none';
        document.getElementById('relevant-listings').style.display = 'none';
        document.getElementById('premium-listings').style.display = 'none';
    }

    function recentlyAddedClicked() {
        document.getElementById('trending-listings').style.display = 'none';
        document.getElementById('ending-soon-listings').style.display = 'none';
        document.getElementById('recently-added-listings').style.display = 'inline';
        document.getElementById('relevant-listings').style.display = 'none';
        document.getElementById('premium-listings').style.display = 'none';
    }

    function recommendedClicked() {
        document.getElementById('trending-listings').style.display = 'none';
        document.getElementById('ending-soon-listings').style.display = 'none';
        document.getElementById('recently-added-listings').style.display = 'none';
        document.getElementById('relevant-listings').style.display = 'inline';
        document.getElementById('premium-listings').style.display = 'none';
    }

    function premiumClicked() {
        document.getElementById('trending-listings').style.display = 'none';
        document.getElementById('ending-soon-listings').style.display = 'none';
        document.getElementById('recently-added-listings').style.display = 'none';
        document.getElementById('relevant-listings').style.display = 'none';
        document.getElementById('premium-listings').style.display = 'inline';
    }


</script>
</body>
</html>