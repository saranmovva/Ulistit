<%@include file="jspf/header.jsp" %>

<body class="uk-background-muted uk-height-viewport">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="jspf/navbar.jspf" %>

    <%@include file="jspf/messages.jsp" %>

    <div class="uk-align-center uk-section uk-background-muted">
        <div class="uk-margin">
            <h2 class="uk-heading-line uk-text-center"><span>Report this Listing</span></h2>
        </div>
        <div class="uk-tile uk-width-2-3 uk-align-center uk-tile-default uk-box-shadow-medium uk-box-shadow-hover-large uk-border-rounded">

            <form id="form" name="reportListing" action="reportListingEmail" class="uk-margin-top uk-form"
                  method="POST">
                <input class="uk-input" type="hidden" name="id"
                       value="${listing.id}">
                <div class="uk-margin">
                    <h3 class="uk-heading-line uk-text-center"><span>Your Information</span></h3>
                </div>
                <div class="uk-margin">
                    <span class="uk-label uk-margin-bottom">Username</span><input class="uk-input" type="text"
                                                                                  name="reportUsername" value="${sessionScope.user.username}"
                                                                                  placeholder="${sessionScope.user.username}"
                                                                                  disabled>
                </div>
                <div class="uk-margin">
                    <span class="uk-label uk-margin-bottom">Email</span><input class="uk-input" type="email"
                                                                               name="reportEmail"
                                                                               placeholder="${sessionScope.user.schoolEmail}"
                                                                               disabled>
                </div>
                <div class="uk-margin">
                    <h3 class="uk-heading-line uk-text-center"><span>Seller Information</span></h3>
                </div>
                <div class="uk-margin">
                    <span class="uk-label uk-label-danger uk-margin-bottom">Username</span><input class="uk-input"
                                                                                                  type="text"
                                                                                                  name="sellerName"
                                                                                                  placeholder="${listing.user.username}"
                                                                                                  disabled>
                </div>
                <div class="uk-margin">
                    <span class="uk-label uk-label-danger uk-margin-bottom">Email</span><input class="uk-input"
                                                                                               type="email"
                                                                                               name="sellerEmail"
                                                                                               placeholder="${listing.user.schoolEmail}"
                                                                                               disabled>
                </div>
                <div class="uk-margin">
                    <span class="uk-label uk-label-danger uk-margin-bottom">Listing Name</span><input class="uk-input"
                                                                                                      type="text"
                                                                                                      name="listingName" value="${listing.name}"
                                                                                                      placeholder="${listing.name}"
                                                                                                      disabled>
                </div>
                <div class="uk-margin">
                    <span class="uk-label uk-label-danger uk-margin-bottom">Listing ID</span><input class="uk-input"
                                                                                                    type="text"
                                                                                                    name="id"
                                                                                                    placeholder="${listing.id}"
                                                                                                    disabled>
                </div>
                <div class="uk-margin">
                    <span class="uk-label uk-label-danger uk-margin-bottom">Category</span><input class="uk-input"
                                                                                                  type="text"
                                                                                                  name="category"
                                                                                                  placeholder="${listing.category}"
                                                                                                  disabled>
                </div>
                <div class="uk-margin">
                    <span class="uk-label uk-label-danger uk-margin-bottom">Sub Category</span><input class="uk-input"
                                                                                                      type="text"
                                                                                                      name="listingName"
                                                                                                      placeholder="${listing.subCategory}"
                                                                                                      disabled>
                </div>
                <h5 class="uk-heading-line uk-text-center"><span>Reason for Reporting this Listing</span></h5>
                <textarea class="uk-textarea" rows="5" cols="100" name="message"
                          placeholder="Please write your reason for the report here"></textarea>
                <div id="mail-status"></div>
                <input type="submit" class="uk-button uk-margin-top uk-border-rounded uk-button-secondary" name="submit"
                       value="Send Report"
                       style="clear: both;">
            </form>

        </div>

    </div>
</div>

<%@include file="jspf/footer.jspf" %>

</body>
</html>