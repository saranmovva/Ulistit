<%@include file="admin-header.jsp" %>

<body class="uk-background-muted">

<%@include file="admin-navbar.jsp" %>

<%@include file="../jspf/messages.jsp" %>

<div class="uk-container">

    <div class="uk-grid uk-margin-medium-top">

        <div class="uk-width-1-1 uk-align-center">

            <h2 class="uk-align-center">Manage Donated Items (${donations.size()})</h2>

            <div class="uk-tile-default uk-tile uk-border-rounded uk-box-shadow-hover-large uk-box-shadow-medium uk-width-1-1">

                <table class="uk-table uk-table-hover uk-table-divider">

                    <!-- Table Header -->
                    <thead>
                    <tr>
                        <th class="uk-width-1-4">Name</th>
                        <th class="uk-width-1-4">Description</th>
                        <th class="uk-width-1-4">Date Created</th>
                        <th class="uk-width-1-5">Category</th>
                        <th class="uk-width-1-5">Sub Category</th>
                        <th class="uk-table-small">Edit</th>
                        <th class="uk-table-small">Remove</th>
                    </tr>
                    </thead>

                    <tbody>

                    <!-- Table Body -->
                    <c:forEach items="${donations}" var="listing">
                    <tr>
                        <td class="uk-width-1-4">${listing.name}</td>
                        <td class="uk-width-1-4">${listing.description}</td>
                        <td class="uk-width-1-4">${listing.dateCreated}</td>
                        <td class="uk-width-1-5">${listing.category}</td>
                        <td class="uk-width-1-5">${listing.subCategory}</td>

                        <!-- Edit Icon -->
                        <td class="uk-table-small"><a uk-icon="icon: pencil"
                                                      uk-toggle="target: #editDonationsModal${listing.id}"></a>
                        </td>

                        <!-- Remove Icon -->
                        <td class="uk-table-small"><a uk-icon="icon: trash"
                                                      uk-toggle="target: #removeDonationsModal${listing.id}"></a>
                        </td>

                    </tr>

                    <!-- Edit Modal -->
                    <div id="editDonationsModal${listing.id}" uk-modal>
                        <div class="uk-modal-dialog">
                            <form action="/adminEditDonation" method="post"
                                  id="removeItemForm${item.itemID}">

                                <div class="uk-modal-body">

                                    <h2 class="uk-modal-title">Edit Faq Modal</h2>

                                    <div class="uk-grid-small" uk-grid>

                                        <label class="uk-form-label uk-width-1-1 uk-margin-small">Name
                                            <input class="uk-input"
                                                   name="name"
                                                   required value="${listing.name}"></label>

                                        <label class="uk-form-label uk-width-1-1 uk-margin-small">Answer
                                            <textarea class="uk-textarea"
                                                      name="description"
                                                      required>${listing.description}</textarea></label>

                                        <label class="uk-form-label uk-width-1-1 uk-margin-small">Category
                                            <select class="uk-select"
                                                    name="category"
                                                    required>

                                                <c:forEach items="${categories}" var="category">
                                                    <c:choose>
                                                        <c:when test="${listing.category == category.category}">
                                                            <option value="${category.category}"
                                                                    selected>${category.category}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${category.category}">${category.category}</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>

                                            </select>
                                        </label>

                                        <label class="uk-form-label uk-width-1-1 uk-margin-small">Sub Category
                                            <select class="uk-select"
                                                    name="subCategory"
                                                    required>

                                                <c:forEach items="${subCategories}" var="subCategory">
                                                    <c:choose>
                                                        <c:when test="${listing.subCategory == subCategory.subCategory}">
                                                            <option value="${subCategory.subCategory}"
                                                                    selected>${subCategory.subCategory}</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="${subCategory.subCategory}">${subCategory.subCategory}</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>

                                            </select>
                                        </label>

                                        <input type="hidden" name="listingID" value="${listing.id}">

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

                    <!-- Remove Modal -->
                    <div id="removeDonationsModal${listing.id}" uk-modal>
                        <div class="uk-modal-dialog">
                            <form action="/adminRemoveDonation" method="post">
                                <div class="uk-modal-body uk-grid-small" uk-grid>

                                    <h2 class="uk-modal-title">Remove Listing '${listing.name}' ?</h2>

                                    <select name="reason"
                                            class="uk-select uk-width-1-1 uk-margin-medium-top uk-margin-medium-bottom">
                                        <option disabled selected>Reason For Removal</option>
                                        <option value="inappropriate content">Inappropriate Content</option>
                                        <option value="low quality">Low Quality</option>
                                    </select>

                                    <input type="hidden" name="listingID" value="${listing.id}">

                                </div>

                                <div class="uk-modal-footer">
                                    <button class="uk-button uk-button-default uk-modal-close uk-float-left uk-border-rounded"
                                            type="button">Cancel
                                    </button>
                                    <button class="uk-button uk-button-primary uk-float-right uk-border-rounded"
                                            type="submit">Yes
                                    </button>
                                </div>
                            </form>
                        </div>

                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>
</body>
</html>
