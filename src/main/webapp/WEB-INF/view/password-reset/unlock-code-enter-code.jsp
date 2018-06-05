<%@ include file="../jspf/header.jsp" %>

<body>

<%@ include file="../jspf/navbar.jspf" %>

<div class="row">
    <div
            class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">

        <%@ include file="../jspf/messages.jsp" %>

        <form role="form" data-toggle="validator"
              method="post" action="${pageContext.request.contextPath}/unlockCode" style="margin-top: 40px;">
            <h2>Enter Your Verification Code</h2>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                    <div class="form-group">
                        <div class="input-group col-md-12" data-validate="code" data-length="8">
                            <input type="text" name="userCode" id="userCode"
                                   class="form-control input-lg" placeholder="Verification Code"
                                   tabindex="1" data-minlength="6" required>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-xs-6 col-md-6">
                    <button class="btn btn-success btn-block btn-lg">Continue</button>
                </div>
                <div class="col-xs-6 col-md-6">
                    <a href="resend" class="btn btn-primary btn-block btn-lg">Resend Code</a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>