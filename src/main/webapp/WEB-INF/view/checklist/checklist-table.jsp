<table class="uk-table uk-table-hover uk-table-middle uk-table-divider uk-text-large">
    <thead>
    <tr>
        <th class="uk-width-1-3@s uk-width-4-5@l uk-width-4-5@m">Item</th>
        <div class="uk-width-1-5@l uk-width-2-3@m">
            <th class="uk-table-shrink uk-text-center">Don't Need</th>
            <th class="uk-table-shrink uk-text-center">Already Have</th>
            <th class="uk-table-shrink uk-text-center">Bought</th>
        </div>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${checklist.items}" var="item">
        <tr>
            <c:choose>
                <c:when test="${item.status == 'STILL_NEED'}">
                    <td class="uk-table-justify">
                        <p>${item.name}</p>
                    </td>
                    <td>
                        <form action="/update-checklist" method="post" id="dontNeedForm">
                            <input type="hidden" name="newStatus" value="DONT_NEED">
                            <input type="hidden" name="itemID" value="${item.itemID}">
                            <input type="hidden" name="checklistID" value="${checklist.checklistID}">
                            <a class="uk-text-center uk-icon-button" style="color: red" title="Don't Need"
                               uk-icon="icon: close; ratio: 1.2" onclick="$('#dontNeedForm').submit();"></a>
                        </form>
                    </td>
                    <td>
                        <form action="/update-checklist" method="post" id="alreadyHaveForm">
                            <input type="hidden" name="newStatus" value="ALREADY_HAVE">
                            <input type="hidden" name="itemID" value="${item.itemID}">
                            <input type="hidden" name="checklistID" value="${checklist.checklistID}">
                            <a class="uk-text-center uk-icon-button" style="color: dodgerblue"
                               title="Already Have"
                               uk-icon="icon: check; ratio: 1.2" onclick="$('#alreadyHaveForm').submit();"></a>
                        </form>
                    </td>
                    <td>
                        <form action="/update-checklist" method="post" id="boughtForm">
                            <input type="hidden" name="newStatus" value="JUST_BOUGHT">
                            <input type="hidden" name="itemID" value="${item.itemID}">
                            <input type="hidden" name="checklistID" value="${checklist.checklistID}">
                            <a class="uk-text-center uk-icon-button" style="color: green" title="Just Bought"
                               uk-icon="icon: cart; ratio: 1.2" onclick="$('#boughtForm').submit();"></a>
                        </form>
                    </td>
                </c:when>

                <c:when test="${item.status == 'JUST_BOUGHT'}">
                    <td class="uk-table-justify">
                        <p style="text-decoration: line-through;">${item.name}</p>
                    </td>
                    <td>
                        <a class="uk-text-center uk-icon-button" style="color: lightslategray" title="Don't Need"
                           uk-icon="icon: close; ratio: 1.2"></a>
                    </td>
                    <td>
                        <a class="uk-text-center uk-icon-button" style="color: lightslategray"
                           title="Already Have"
                           uk-icon="icon: check; ratio: 1.2"></a>
                    </td>
                    <td>
                        <a class="uk-text-center uk-icon-button" style="color: lightslategray" title="Just Bought"
                           uk-icon="icon: cart; ratio: 1.2"></a>
                    </td>
                </c:when>
            </c:choose>
        </tr>
    </c:forEach>

    <tr id="createNewItem" hidden>
        <form action="/add-item" method="post" id="addItemForm">
            <td class="uk-table-justify">
                <input type="text" name="name" class="uk-input" placeholder="Create Your Own" required>
                <input type="hidden" name="checklistID" value="${checklist.checklistID}">
            </td>
            <td>
                <a class="uk-text-center" title="Create" style="color: dodgerblue"
                   uk-icon="icon: plus-circle; ratio: 1.5" onclick="$('#addItemForm').submit();"></a>
            </td>
            <td></td>
            <td></td>
        </form>
    </tr>
    </tbody>
</table>