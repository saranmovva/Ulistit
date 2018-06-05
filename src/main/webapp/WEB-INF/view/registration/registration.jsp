<%@ include file="../jspf/header.jsp" %>

<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <body class="uk-background-muted">

    <%@include file="../jspf/navbar.jspf" %>

    <%@ include file="../jspf/messages.jsp" %>

    <div class="uk-container">

        <div class="uk-grid uk-margin-medium-bottom" uk-grid>

            <div class="uk-width-2-3@m uk-width-1-1@s uk-align-center">

                <form role="form" data-toggle="validator"
                      method="post" action="create" class="uk-form uk-grid-small" uk-grid>

                    <h1 class="uk-heading-line uk-text-center"><span>Registration</span></h1>

                    <hr class="colorgraph uk-width-1-1 uk-align-center">

                    <div class="uk-tile-default uk-tile-large uk-border-rounded uk-grid uk-padding" uk-grid>

                        <div class="uk-width-1-2@m uk-width-1-1@s">
                            <label class="uk-form-label uk-text-large">First Name</label>
                            <input type="text" name="firstName" id="firstName" class="uk-input" maxlength="30" required>
                        </div>

                        <div class="uk-width-1-2@m uk-width-1-1@s">
                            <label class="uk-form-label uk-text-large">Last Name</label>
                            <input type="text" name="lastName" id="lastName" class="uk-input"maxlength="30" required>
                        </div>

                        <div class="uk-width-1-1">
                            <label class="uk-form-label uk-text-large">Username</label>
                            <input type="text" name="username" id="username" class="uk-input" maxlength="20"  required>
                        </div>

                        <div class="uk-width-1-1">
                            <label class="uk-form-label uk-text-large">Phone Number</label>
                            <input type="tel" name="phoneNumber" id="phoneNumber" class="uk-input" min="9" required>
                        </div>

                        <div class="uk-width-1-2@m uk-width-1-1@s">
                            <label class="uk-form-label uk-text-large">Personal Email</label>
                            <input type="email" name="email" id="email" class="uk-input">
                        </div>

                        <div class="uk-width-1-2@m uk-width-1-1@s">
                            <label class="uk-form-label uk-text-large">School Email Address</label>
                            <input type="email" name="schoolEmail" id="schoolEmail" class="uk-input" required>
                        </div>

                        <div class="uk-width-1-1">
                            <label class="uk-form-label uk-text-large">Year In School</label>
                            <select name="gradeLevel" class="uk-select uk-input" required>
                                <option value="1">Freshman</option>
                                <option value="2">Sophomore</option>
                                <option value="3">Junior</option>
                                <option value="4">Senior</option>
                            </select>
                        </div>

                        <div class="uk-width-1-2@m uk-width-1-1@s">
                            <label class="uk-form-label uk-text-large">Password</label>
                            <input type="password" name="password" id="password" class="uk-input" required>
                        </div>

                        <div class="uk-width-1-2@m uk-width-1-1@s">
                            <label class="uk-form-label uk-text-large">Confirm Your Password</label>
                            <input type="password" name="passwordConfirm" id="passwordConfirm" class="uk-input" disabled="true" required>
                        </div>

                        <div class="uk-width-1-1 uk-position-relative uk-position-bottom">

                            <p>By clicking <span class="uk-badge uk-padding-small">Register</span>,
                                you agree to the
                                <a uk-toggle="target: #termsAndConditionsModal">Terms and Conditions</a>
                                set out by this site, including our Cookie Use.</p>

                            <br>

                            <button id="registerButton" type="submit" value="Register"
                                    class="uk-border-rounded uk-button-primary uk-button-large uk-align-right">
                                Register
                            </button>

                        </div>

                        <c:if test="${admin == true}">
                            <input type="hidden" name="adminRegistration" value="true">
                        </c:if>


                    </div>

                    <hr class="colorgraph uk-width-1-1 uk-align-center uk-margin-medium-top">

                </form>
            </div>
        </div>
    </div>

    <%@include file="terms-and-conditions.jsp" %>

    <script>
        $(document).ready(function() {

            $('#firstName').keyup(function () {
                if(validateNames($(this).val())){
                    $("#registerButton").prop("disabled",false);
                    $("#firstName").removeClass("uk-form-danger").addClass("uk-form-success")
                    $('#firstName').attr('uk-tooltip', 'First Name is valid');
                }
                else{
                    $("#registerButton").prop("disabled",true);
                    $("#firstName").removeClass("uk-form-success").addClass("uk-form-danger")
                    $('#firstName').attr('uk-tooltip', 'First Name is invalid');
                }
            });

            $('#lastName').keyup(function () {
                if(validateNames($(this).val())){
                    $("#registerButton").prop("disabled",false);
                    $("#lastName").removeClass("uk-form-danger").addClass("uk-form-success")
                    $('#lastName').attr('uk-tooltip', 'Last Name is valid');
                }
                else{
                    $("#registerButton").prop("disabled",true);
                    $("#lastName").removeClass("uk-form-success").addClass("uk-form-danger")
                    $('#lastName').attr('uk-tooltip', 'Last Name is invalid');
                }
            });

            $('#username').keyup(function () {
                var usrname = $(this).val();
                $.ajax({
                    url: 'registerValidUsername',
                    type: 'POST',
                    data: 'username=' + $(this).val(),
                    success: function (valid) {
                        if(valid == true){
                            $("#registerButton").prop("disabled",true);
                            //$("#loginSubmit").prop("disabled",true);
                            $("#username").removeClass("uk-form-success").addClass("uk-form-danger")
                            $('#username').attr('uk-tooltip', 'Username is invalid');

                        }
                        else if(usrname.length < 6 || usrname.length > 15  ){
                            $("#registerButton").prop("disabled",true);
                            //$("#loginSubmit").prop("disabled",true);
                            $("#username").removeClass("uk-form-success").removeClass("uk-form-danger").addClass("uk-form-danger")
                            $('#username').attr('uk-tooltip', 'Username must be between 6 and 15 characters');
                        }
                        else{
                            $("#registerButton").prop("disabled",false);
                            //$("#loginSubmit").prop("disabled",false);
                            $("#username").removeClass("uk-form-danger").addClass("uk-form-success")
                            $('#username').attr('uk-tooltip', 'Username is valid');
                        }
                    }
                });
            });

            $('#schoolEmail').keyup(function () {
                var email = $(this).val()
                $.ajax({
                    url: 'registerValidSchoolEmail',
                    type: 'POST',
                    data: 'email=' + $(this).val(),
                    success: function (valid) {
                        if(valid == true || validateEmail(email) == false){
                            $("#registerButton").prop("disabled",true);
                            //$("#loginSubmit").prop("disabled",true);
                            $("#schoolEmail").removeClass("uk-form-success").addClass("uk-form-danger")
                            $('#schoolEmail').attr('uk-tooltip', 'Email is already in use');
                        }
                        else{
                            $("#registerButton").prop("disabled",false);
                            //$("#loginSubmit").prop("disabled",false);
                            $("#schoolEmail").removeClass("uk-form-danger").addClass("uk-form-success")
                            $('#schoolEmail').attr('uk-tooltip', 'Email is valid');
                        }
                    }
                });
            });

            $('#email').keyup(function () {
                var email = $(this).val()
                $.ajax({
                    url: 'registerValidPersonalEmail',
                    type: 'POST',
                    data: 'email=' + $(this).val(),
                    success: function (valid) {
                        if(valid == true || validateEmail(email) == false){
                            $("#registerButton").prop("disabled",true);
                            //$("#loginSubmit").prop("disabled",true);
                            $("#email").removeClass("uk-form-success").addClass("uk-form-danger")
                            $('#email').attr('uk-tooltip', 'Email is already in use');
                        }
                        else{
                            $("#registerButton").prop("disabled",false);
                            //$("#loginSubmit").prop("disabled",false);
                            $("#email").removeClass("uk-form-danger").addClass("uk-form-success")
                            $('#email').attr('uk-tooltip', 'Email is valid');
                        }
                    }
                });
            });

            $('#phoneNumber').keyup(function () {
                if($(this).val().length == 10){
                    $("#registerButton").prop("disabled",false);
                    $("#phoneNumber").removeClass("uk-form-danger").addClass("uk-form-success")
                    $('#phoneNumber').attr('uk-tooltip', 'Phone Number is valid');
                }
                else{
                    $("#registerButton").prop("disabled",true);
                    $("#phoneNumber").removeClass("uk-form-success").addClass("uk-form-danger")
                    $('#phoneNumber').attr('uk-tooltip', 'Phone Number is invalid');
                }
            });

            $('#password').keyup(function () {
                if($(this).val().length < 5 || $(this).val().length > 20){
                    $("#registerButton").prop("disabled",true);
                    $("#password").removeClass("uk-form-success").addClass("uk-form-danger")
                    $('#password').attr('uk-tooltip', 'Password must be greater than 3 and less than 20 characters');
                }
                else{
                    $("#registerButton").prop("disabled",false);
                    $("#password").removeClass("uk-form-danger").addClass("uk-form-success")

                    $('#password').attr('uk-tooltip', 'Password is Valid');
                    $("#passwordConfirm").prop("disabled",false);
                }
            });

            $('#passwordConfirm').keyup(function () {
                if($(this).val() != $('#password').val() ){
                    $("#registerButton").prop("disabled",true);
                    $("#passwordConfirm").removeClass("uk-form-success").addClass("uk-form-danger")

                    $('#passwordConfirm').attr('uk-tooltip', 'Passwords do not match');
                }
                else{
                    $("#registerButton").prop("disabled",false);
                    $("#passwordConfirm").removeClass("uk-form-danger").addClass("uk-form-success")
                    $('#passwordConfirm').attr('uk-tooltip', 'Passwords match');
                }
            });

            function validateEmail(email) {
                var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return re.test(String(email).toLowerCase());
            }

            function validateNames(name){
                if(name.length < 2 || name == undefined || name == "" || name.length == 0 || name.length > 15 || /\d/.test(name)){
                    return false;
                }
                return true;
            }

        });
    </script>
    </body>
</div>
</html>