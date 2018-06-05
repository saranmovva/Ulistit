<%@include file="admin-header.jsp" %>

<body class="uk-background-muted">

<%@include file="admin-navbar.jsp" %>

<%@include file="../jspf/messages.jsp" %>

<div class="uk-container">

    <div class="uk-grid">

        <div class="uk-width-5-6@m uk-width-1-1@s uk-align-center">

            <h2 class="uk-align-center">Manage Faqs</h2>

            <div class="uk-tile-default uk-tile uk-border-rounded uk-box-shadow-hover-large uk-box-shadow-medium uk-width-1-1">

                <table class="uk-table uk-table-hover uk-table-divider">

                    <!-- Table Header -->
                    <thead>
                    <tr>
                        <th class="uk-width-1-3">Question <a uk-toggle="target: #addNewFaq" uk-icon="icon: plus"
                                                             style="color: green" title="Add New Faq"></a>
                        </th>
                        <th class="uk-width-1-3">Answer</th>
                        <th class="uk-table-small">Category</th>
                        <th class="uk-table-small">Edit</th>
                        <th class="uk-table-small">Remove</th>
                    </tr>
                    </thead>

                    <tbody>

                    <!-- Add New Faq -->
                    <form action="/adminAddFaq" method="post" id="addFaq">
                        <tr id="addNewFaq" hidden>
                            <td class="uk-width-1-3">
                                <textarea class="uk-textarea" name="newFaqQuestion" required></textarea>
                            </td>
                            <td class="uk-width-1-3">
                                <textarea class="uk-textarea" name="newFaqAnswer" required></textarea>
                            </td>
                            <td class="uk-table-small">
                                <select class="uk-select" name="newFaqCategory" required>
                                    <option value="BUYING">Buying</option>
                                    <option value="SELLING">Selling</option>
                                    <option value="COMMUNITY">Community</option>
                                    <option value="CHECKLIST">Freshman Checklist</option>
                                    <option value="COMMUNITY">Community</option>
                                    <option value="NOTIFICATIONS">Notifications</option>
                                    <option value="PROFILE">Profile</option>
                                    <option value="OTHER">Other</option>
                                </select>
                            </td>
                            <td class="uk-table-small"><a uk-icon="icon: plus-circle; ratio: 1.5"
                                                          style="color: cornflowerblue" title="Add New Item"
                                                          onclick="document.getElementById('addFaq').submit()"></a>
                            </td>
                            <td></td>
                        </tr>
                    </form>

                    <!-- Table Body -->
                    <c:forEach items="${faqs}" var="faq">
                        <tr>
                            <td class="uk-table-justify">${faq.question}</td>
                            <td class="uk-table-justify">${faq.answer}</td>
                            <td class="uk-table-small">${faq.category}</td>

                            <!-- Edit Icon -->
                            <td class="uk-table-small"><a uk-icon="icon: pencil"
                                                          uk-toggle="target: #editFaqModal${faq.questionID}"></a>
                            </td>

                            <!-- Remove Icon -->
                            <form action="/adminRemoveFaq" method="post" id="adminRemoveFaq${faq.questionID}">
                                <td class="uk-table-small"><a uk-icon="icon: trash"
                                                              onclick="document.getElementById('adminRemoveFaq${faq.questionID}').submit()"></a>
                                </td>
                                <input type="hidden" name="faqID" value="${faq.questionID}">
                            </form>

                        </tr>

                        <!-- Edit Modal -->
                        <div id="editFaqModal${faq.questionID}" uk-modal>
                            <div class="uk-modal-dialog">
                                <form action="/adminEditFaq" method="post"
                                      id="removeItemForm${item.itemID}">
                                    <div class="uk-modal-body">

                                        <h2 class="uk-modal-title">Edit Faq Modal</h2>

                                        <div class="uk-grid-small" uk-grid>

                                            <label class="uk-form-label uk-width-1-1 uk-margin-small">Question
                                                <textarea class="uk-textarea"
                                                          name="newFaqQuestion"
                                                          required>${faq.question}</textarea></label>

                                            <label class="uk-form-label uk-width-1-1 uk-margin-small">Answer
                                                <textarea class="uk-textarea"
                                                          name="newFaqAnswer"
                                                          required>${faq.answer}</textarea></label>

                                            <label class="uk-form-label uk-width-1-1 uk-margin-small">Category
                                                <select class="uk-select"
                                                        name="newFaqCategory"
                                                        required>

                                                    <c:choose>
                                                        <c:when test="${faq.category == 'BUYING'}">
                                                            <option value="BUYING" selected>Buying</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="BUYING">Buying</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${faq.category == 'SELLING'}">
                                                            <option value="SELLING" selected>Selling</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="SELLING">Selling</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${faq.category == 'COMMUNITY'}">
                                                            <option value="COMMUNITY" selected>Community</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="COMMUNITY">Community</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${faq.category == 'CHECKLIST'}">
                                                            <option value="CHECKLIST" selected>Freshman Checklist
                                                            </option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="CHECKLIST">Freshman Checklist</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${faq.category == 'COMMUNITY'}">
                                                            <option value="COMMUNITY" selected>Community</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="COMMUNITY">Community</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${faq.category == 'NOTIFICATIONS'}">
                                                            <option value="NOTIFICATIONS" selected>Notifications
                                                            </option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="NOTIFICATIONS">Notifications</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${faq.category == 'PROFILE'}">
                                                            <option value="PROFILE" selected>Profile</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="PROFILE">Profile</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${faq.category == 'OTHER'}">
                                                            <option value="OTHER" selected>Other</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="OTHER">Other</option>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </select>
                                            </label>

                                            <input type="hidden" name="faqID" value="${faq.questionID}">

                                        </div>
                                    </div>

                                    <div class="uk-modal-footer">
                                        <button class="uk-button uk-button-default uk-modal-close uk-float-left uk-border-rounded"
                                                type="button">Cancel
                                        </button>
                                        <button class="uk-button uk-button-primary uk-float-right uk-border-rounded"
                                                type="submit">Save
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        </form>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>
</body>
</html>
