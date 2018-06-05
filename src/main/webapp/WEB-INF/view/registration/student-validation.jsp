<%@ include file="../jspf/header.jsp" %>

<body class="uk-background-muted uk-height-viewport">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <div class="uk-container">

        <div class="uk-grid uk-margin-medium-top" uk-grid>

            <div class="uk-width-1-2@m uk-width-1-1@s uk-align-center">

                <h1>Student Validation</h1>

                <div class="uk-tile uk-tile-default uk-border-rounded uk-box-shadow-medium uk-box-shadow-hover-large">

                    <hr class="colorgraph">

                    <form role="form"
                          class="uk-grid-small uk-margin-large-top uk-margin-large-bottom"
                          method="get" action="/code" uk-grid>

                        <label class="uk-form-label uk-width-1-1">Enter Your Verification Code
                            <input type="number" name="userCode" id="userCode"
                                   class="uk-input" placeholder="Enter Your Code"
                                   tabindex="1" data-minlength="6" data-minlength="6" required>
                        </label>

                        <div class="uk-width-1-1">
                            <button type="submit"
                                    class="uk-button uk-button-primary uk-border-rounded uk-align-right">
                                Validate
                            </button>
                        </div>

                    </form>

                    <hr class="colorgraph">

                </div>
            </div>
        </div>
    </div>
</div>

</body>
<%@include file="../jspf/footer.jspf" %>
</html>