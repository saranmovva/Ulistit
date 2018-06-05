<%@include file="jspf/header.jsp" %>

<body class="uk-background-muted uk-height-viewport">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="jspf/navbar.jspf" %>

    <%@include file="jspf/messages.jsp" %>

    <div class="uk-grid uk-margin-large-bottom uk-background-muted uk-margin-small-left uk-margin-small-right" uk-grid>
        <script>
            $(document).ready(function () {
                $('#emailInput').keyup(function () {
                    $.ajax({
                        url: 'loginValidEmail',
                        type: 'POST',
                        data: 'email=' + $(this).val(),
                        success: function (valid) {
                            if (valid == false) {
                                $("#passwordInput").prop("disabled", true);
                                $("#loginSubmit").prop("disabled", true);
                                $("#emailInput").removeClass("uk-form-success").addClass("uk-form-danger")
                                $('#emailInput').attr('uk-tooltip', 'We have no account associate with that email');
                                UIkit.tooltip('#emailInput').show();

                            }
                            else {
                                $('#emailInput').attr('uk-tooltip', 'Email is valid');
                                $("#passwordInput").prop("disabled", false);
                                $("#loginSubmit").prop("disabled", false);
                                $("#emailInput").removeClass("uk-form-danger").addClass("uk-form-success")
                                $('#emailInput').attr('uk-tooltip', 'Email is valid');
                                UIkit.tooltip('#emailInput').show();
                            }
                        }
                    });
                });
            });

        </script>
        <div class="uk-width-2-5@m uk-width-2-5@l uk-width-1-1@s uk-align-center">
            <div class="uk-card uk-card-default uk-card-body uk-margin-medium-right">
                <h3 class="uk-heading-line uk-text-center"><span>Login</span></h3>
                <form action="loginUser"
                      method="post">
                    <div id="messageShow" class="uk-alert-primary" style="display:none;" uk-alert>
                        <p id="loginMessage"></p>
                    </div>
                    <p> </p>
                    <div class="uk-width-1-1 uk-margin-small">
                        <label class="uk-form-label">Email</label>
                        <input id="emailInput" class="uk-input" type="text" name="email"
                               value="${email}" placeholder="Email">
                    </div>
                    <div class="uk-width-1-1 uk-margin-small">
                        <label class="uk-form-label">Password</label>
                        <input id="passwordInput" class="uk-input" type="password" name="password"
                               placeholder="Password">

                    </div>
                    <div class="uk-width-1-1 uk-margin-small">
                        <button id="loginSubmit" type="submit"
                                class="uk-button uk-button-secondary uk-border-rounded uk-float-right">Login
                        </button>
                        <br>
                        <br>
                        <span>
                        <a href="${pageContext.request.contextPath}/resetPage" class="uk-link-text uk-float-left">Forgot
                            Password</a>
                        <a href="${pageContext.request.contextPath}/unlock"
                           class="uk-link-text uk-float-right">Unlock</a>
                    </span>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<%@include file="jspf/footer.jspf" %>
</html>