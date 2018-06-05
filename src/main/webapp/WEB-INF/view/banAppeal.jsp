<%@include file="jspf/header.jsp" %>

<body class="uk-height-viewport uk-background-muted">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <%@include file="jspf/navbar.jspf" %>

    <%@include file="jspf/messages.jsp" %>
    <div class="uk-align-center uk-section uk-background-muted">
        <div class="uk-margin">
            <h2 class="uk-heading-line uk-text-center"><span>User Ban Appeal</span></h2>
        </div>
        <div class="uk-margin-top uk-align-center uk-text-center">
            <p>If your account is currently banned and you wish to rejoin the site, please file your appeal below.</p>
        </div>
        <div class="uk-tile uk-align-center uk-padding-remove-top uk-padding-remove-bottom uk-padding-remove-right uk-padding-remove-left uk-box-shadow-medium uk-box-shadow-hover-large uk-tile-default uk-width-2-3">
            <form id="form" name="banAppeal" action="sendEmail" class="uk-form"
                  method="POST">
                <div class="uk-padding-small uk-form uk-align-center uk-margin-right">
                    <div class="uk-margin">
                        <input class="uk-input" type="text" placeholder="Full Name" required>
                    </div>
                    <div class="uk-margin">
                        <input class="uk-input" type="email" placeholder="U-List It Email" required>
                    </div>
                    <div class="uk-margin uk-margin-top">
							<textarea class="uk-textarea" rows="5" cols="100"
                                      placeholder="Your reason for appealing your ban" name="appeal"
                                      required></textarea>
                    </div>
                    <div id="mail-status"></div>
                    <input type="submit" class="uk-button uk-button-secondary uk-border-rounded" name="submit"
                           value="Send Appeal"
                           id="send-message" style="clear: both;">
                    <%@include file="jspf/messages.jsp" %>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="jspf/footer.jspf" %>
</body>

</html>