<div id="offcanvas-flip" uk-offcanvas="flip: true; overlay: true">
    <div class="uk-offcanvas-bar uk-width-2-3@m uk-width-1-3@l uk-width-2-3@s">

        <button class="uk-offcanvas-close" type="button" uk-close></button>

        <h2 class="uk-text-center"><a href="/checklist">Freshman Checklist</a></h2>

        <div class="uk-margin">
            <table class="uk-table uk-table-hover uk-table-middle uk-table-divider uk-text-large">
                <thead>
                <tr>
                    <th class="uk-width-1-3@s uk-width-4-5@l uk-width-4-5@m">Item</th>
                    <div class="uk-width-1-5@l uk-width-2-3@m">
                        <th class="uk-table-shrink uk-text-center">Don't Need</th>
                        <th class="uk-table-shrink uk-text-center">Bought</th>
                    </div>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${sessionScope.checklist.items}" var="item">
                    <tr>
                        <c:if test="${item.status == 'STILL_NEED'}">
                            <td class="uk-table-justify">
                                <p>${item.name}</p>
                            </td>
                            <td>
                                <form action="/update-checklist" method="post" id="dontNeedForm">
                                    <input type="hidden" name="newStatus" value="DONT_NEED">
                                    <input type="hidden" name="itemID" value="${item.itemID}">
                                    <input type="hidden" name="checklistID"
                                           value="${sessionScope.checklist.checklistID}">
                                    <a class="uk-text-center uk-icon-button" style="color: red" title="Don't Need"
                                       uk-icon="icon: close; ratio: 1.2" onclick="$('#dontNeedForm').submit();"></a>
                                </form>
                            </td>
                            <td>
                                <form action="/update-checklist" method="post" id="boughtForm">
                                    <input type="hidden" name="newStatus" value="JUST_BOUGHT">
                                    <input type="hidden" name="itemID" value="${item.itemID}">
                                    <input type="hidden" name="checklistID"
                                           value="${sessionScope.checklist.checklistID}">
                                    <a class="uk-text-center uk-icon-button" style="color: green"
                                       title="Just Bought"
                                       uk-icon="icon: cart; ratio: 1.2" onclick="$('#boughtForm').submit();"></a>
                                </form>
                            </td>
                        </c:if>

                    </tr>
                </c:forEach>

                <c:forEach items="${sessionScope.checklist.items}" var="item">
                    <tr>
                        <c:if test="${item.status == 'JUST_BOUGHT'}">
                            <td class="uk-table-justify">
                                <p style="text-decoration: line-through;">${item.name}</p>
                            </td>
                            <td>
                                <a class="uk-text-center uk-icon-button" style="color: lightslategray"
                                   title="Don't Need"
                                   uk-icon="icon: close; ratio: 1.2"></a>
                            </td>
                            <td>
                                <a class="uk-text-center uk-icon-button" style="color: lightslategray"
                                   title="Just Bought"
                                   uk-icon="icon: cart; ratio: 1.2"></a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</div>