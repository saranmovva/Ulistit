<%@include file="jspf/header.jsp" %>

<body class="uk-height-viewport uk-background-muted">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <%@include file="jspf/navbar.jspf" %>

    <%@include file="jspf/messages.jsp" %>
    <body>
    <div class="uk-align-center uk-section uk-background-muted">
        <div class="uk-margin">
            <h2 class="uk-heading-line uk-text-center"><span>Contact Us</span></h2>
        </div>
        <div class="uk-margin-top uk-align-center uk-text-center">
            <p>Send your comments, questions, and concerns through this form and we will get back to you as soon as
                possible.</p>
        </div>
        <div class="uk-tile uk-align-center uk-padding-remove-top uk-padding-remove-bottom uk-padding-remove-right uk-padding-remove-left uk-box-shadow-medium uk-box-shadow-hover-large uk-tile-default uk-width-2-3">
            <form id="form" name="contactUs" action="sendEmail" class="uk-form"
                  method="POST">
                <div class="uk-padding-small uk-form uk-align-center uk-margin-right">
                    <div class="uk-margin">
                        <input class="uk-input" type="text" placeholder="Full Name" required>
                    </div>
                    <div class="uk-margin">
                        <input class="uk-input" type="email" placeholder="Email" required>
                    </div>
                    <div class="uk-margin">
                        <input class="uk-input" type="tel" placeholder="Phone" required>
                    </div>
                    <div class="uk-margin">
							<textarea class="uk-textarea" rows="5" cols="100"
                                      placeholder="Your message here!" name="appeal"
                                      required></textarea>
                    </div>
                    <div id="mail-status"></div>
                    <input type="submit" class="uk-margin-remove-bottom uk-button-secondary uk-button uk-border-rounded"
                           name="submit"
                           value="Send Message"
                           id="send-message" style="clear: both;">
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="jspf/footer.jspf" %>
</body>

</html>