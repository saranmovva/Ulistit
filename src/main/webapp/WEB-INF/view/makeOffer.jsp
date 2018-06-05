<%@include file="jspf/header.jsp" %>
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <body>

    <!-- max-width: 1350px; -->

    <%@include file="jspf/navbar.jspf" %>

    <!--<div style="background-color: #f2f2f2;">-->

    <div class="uk-section uk-background-muted uk-padding-remove">

        <div class="uk-container">

            <div class="uk-grid uk-margin-medium-bottom uk-align-center" uk-grid>

                <div class="uk-width-2-3@m uk-width-1-1@s uk-align-center uk-card-body">

                    <form role="form" data-toggle="validator" method="POST" class="uk-form uk-grid"
                          action="confirmOffer" enctype="multipart/form-data" name="uploadListingForm" uk-grid>

                        <h2>Make an offer</h2>

                        <!--<hr class="colorgraph uk-width-1-1 uk-align-center">-->

                        <div class="uk-card uk-card-body uk-card-hover uk-card-large uk-card-default uk-width-1-1 uk-border-rounded uk-align-center">

                            <div class="uk-width-1-1 uk-align-center">
                                <strong>Price</strong><input type="number" class="uk-input"
                                                             id="price" name="offer-amount" placeholder="Offer"
                                                             required>
                            </div>
                            <div class="uk-width-1-1 uk-align-center">
                                <strong> Offer Message (Optional): </strong>
                                <textarea class="uk-textarea" type="textarea" name="offer-message"
                                          id="message" placeholder="Message" maxlength="140" rows="7"></textarea>
                                <span class="help-block"><p id="characterLeft"
                                                            class="help-block "></span>
                                <input type="hidden" name="listing" value="${listing.id}">
                            </div>

                        </div>

                        <!--<hr class="colorgraph uk-width-1-1 uk-align-center">-->

                        <div class="uk-width-1-1 uk-margin-large-bottom uk-margin-small-top uk-padding-remove uk-align-center">
                            <button type="submit" value="confirmOffer" name="submit"
                                    class="uk-button-primary uk-border-rounded uk-button-large uk-float-right"
                                    tabindex="7">Confirm offer
                            </button>

                            <a href="" class="uk-button-large uk-border-rounded uk-button-secondary uk-float-left">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </body>
</div>
<%@include file="jspf/footer.jspf" %>
</html>