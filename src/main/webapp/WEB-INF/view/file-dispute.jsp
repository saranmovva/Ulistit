<%@include file="jspf/header.jsp" %>

<body class="uk-background-muted">

<%@include file="jspf/navbar.jspf" %>

<%@include file="jspf/messages.jsp" %>

<div class="uk-grid-medium uk-margin-medium" ukgrid>

    <div class="uk-width-1-2@m uk-width-3-4@s uk-align-center uk-card uk-card-default uk-padding-small uk-border-rounded">
        <div class="uk-card-header">
            <h1>File A Dispute
                <a href="#disputeInfoModal" uk-toggle title="Hint"
                   uk-icon="icon: question"></a></h1>
        </div>
        <div class="uk-card-body">
            <form action="/dispute" method="post">
                <label class="uk-form-label uk-text-large">What's the problem?</label>
                <select class="uk-select uk-margin-bottom" required>
                    <option value="BROKEN">Product isn't working as advertised</option>
                    <option value="MISLEADING">Seller was misleading about the product</option>
                    <option value="OTHER">Other</option>
                </select>
                <span class="uk-badge uk-float-right" id="remainingCharacters">Remaining Characters: 1000</span>
                <textarea class="uk-textarea" placeholder="Enter Complaint" name="complaint" id="" cols="30"
                          rows="10" maxlength="1000"></textarea>
                <br>
                <br>
                <button type="submit" class="uk-button-primary uk-button-large uk-border-rounded">Submit</button>
            </form>
        </div>
    </div>
</div>

<div id="disputeInfoModal" uk-modal>
    <div class="uk-modal-dialog">
        <h2 class="uk-modal-header uk-text-center">How It Works</h2>
        <div class="uk-modal-body">
            <ul class="uk-list uk-grid-small" uk-grid>
                <li class="uk-width-1-1">You should file a dispute when you have a problem with the product you
                    received.
                </li>
                <li class="uk-width-1-1">Once filed, an administrator will review your dispute and contact via
                    your school email on what the next step is.
                </li>
                <li class="uk-width-1-1">You can expect an email within 48 hours of filing your dispute.</li>
            </ul>
        </div>
        <div class="uk-modal-footer">
            <p class="uk-text-right">
                <button class="uk-button uk-button-default uk-modal-close" type="button">Close</button>
            </p>
        </div>
    </div>
</div>

<script>

    $('textarea').keypress(function () {
        if (this.value.length > 999) {
            $('#remainingCharacters').textContent = "Remaining Characters: 0";
        } else {
            document.getElementById("remainingCharacters").textContent = "Remaining Characters: " + (999 - this.value.length);
        }
    })

</script>

</body>
<%@include file="jspf/footer.jspf" %>
</html>