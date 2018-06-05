<div class="uk-grid-medium" uk-grid hidden>
    <script type="text/javascript">
        $( window ).on( "load", function() {
            $('#dangerButton').click();
            $('#warningButton').click();
            $('#successButton').click();
        });
    </script>
    <div class="uk-width-1-2 uk-align-center" id="messageBox">
        <%@ page import="java.util.ArrayList" %>
        <c:if test="${not empty successMessages}">
            <%
                String successMessage = "";
                ArrayList<String> successes = (ArrayList<String>) request.getSession().getAttribute("successMessages");
                for (String s : successes) {
                    successMessage += s;
            %>
            <button id="successButton" class="uk-button uk-button-default demo" type="button" onclick="UIkit.notification({message: '<%=successMessage%>', status: 'success'})" hidden></button>
            <%
                }
                successes.clear();
            %>
        </c:if>
        <c:if test="${not empty warningMessages}">
            <%
                String warningMessage = "";
                ArrayList<String> warnings = (ArrayList<String>) request.getSession().getAttribute("warningMessages");
                for (String w : warnings) {
                    warningMessage += w;
            %>
            <button id="warningButton" class="uk-button uk-button-default demo" type="button" onclick="UIkit.notification({message: '<%=warningMessage%>', status: 'warning'})" hidden></button>
            <%
                }
                warnings.clear();
            %>
        </c:if>
        <c:if test="${not empty errorMessages}">

            <%
                String errorMessage = "";
                ArrayList<String> errors = (ArrayList<String>) request.getSession().getAttribute("errorMessages");
                for (String e : errors) {
                    errorMessage += e;
            %>
            <button id="dangerButton" class="uk-button uk-button-default demo" type="button" onclick="UIkit.notification({message: '<%=errorMessage%>', status: 'danger'})" hidden></button>
            <%
                }
                errors.clear();
            %>
        </c:if>
    </div>
</div>
