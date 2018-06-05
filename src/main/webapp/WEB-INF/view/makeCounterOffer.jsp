<%@include file="jspf/header.jsp" %>
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <body>

    <%@include file="jspf/navbar.jspf" %>

    <div style="background-color: #f2f2f2;">

        <div class="uk-section">

            <div class="uk-container">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="form-area">
                        <form method="POST" class="uk-grid-large"
                              onsubmit="return validateForm()" action="confirmCounterOffer"
                              enctype="multipart/form-data" name="uploadListingForm" uk-grid>
                            <br style="clear: both">

                            <h2>Make an offer</h2>

                            <hr class="colorgraph uk-width-1-1 uk-align-center">

                            <div class="uk-width-1-1">
                                <strong>Price</strong><input type="number" class="uk-input"
                                                             id="price" name="offer-amount"
                                                             value="${initial.offerAmount}"
                                                             placeholder="Offer" required>
                            </div>
                            <div class="uk-width-1-1">
                                <strong> Offer Message (Optional): </strong>
                                <textarea class="uk-textarea" type="textarea" name="offer-message"
                                          id="message" placeholder="Message" maxlength="140" rows="7"></textarea>
                                <span class="help-block"><p id="characterLeft"
                                                            class="help-block "></span>
                                <input type="hidden" name="initial" value="${initial.offerID}">
                            </div>

                            <hr class="colorgraph uk-width-1-1 uk-align-center">

                            <div class="uk-width-1-1">
                                <button type="submit" id="submit" name="submit"
                                        class="btn btn-primary pull-right">Submit Form
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>

    </div>

    </body>
    <%@include file="jspf/footer.jspf" %>
</div>
</html>
