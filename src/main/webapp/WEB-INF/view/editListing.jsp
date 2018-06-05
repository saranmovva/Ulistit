<%@include file="jspf/header.jsp" %>

<body class="uk-height-viewport uk-background-muted">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <%@include file="jspf/navbar.jspf" %>


    <%@include file="jspf/messages.jsp" %>

    <div class="uk-section uk-background-muted">

        <div class="uk-margin-medium-top" uk-grid>

            <div class="uk-width-3-4@m uk-width-1-1@s uk-align-center uk-margin">
                <div class="uk-card uk-card-default uk-card-large uk-card-body uk-box-shadow-hover-large uk-border-rounded">
                <span><h2 class="uk-heading-line uk-text-center"><span>Edit Listing</span></h2>

                <div class="form-area">
                    <c:choose>
                    <c:when test="${listing != null}">
                    <form method="POST" class="" uk-grid
                          onsubmit="return validateForm()" action="editAdminListing"
                          enctype="multipart/form-data" name="uploadListingForm" uk-grid>
                        <input type="hidden" name="id" value=${listing.id}>
                        </c:when>
                        <c:otherwise>
                        <form method="POST" class="" uk-grid
                              onsubmit="return validateForm()" action="uploadListing"
                              enctype="multipart/form-data" name="uploadListingForm" uk-grid>
                            </c:otherwise>
                            </c:choose>
                            <br style="clear: both">


                            <div class="uk-width-2-3@m uk-width-1-2@s">
                                <strong>Title of Product</strong> <input type="text"
                                                                         class="uk-input" id="titleId" name="title"
                                                                         value="${listing.name}"
                                                                         placeholder="Title" required>
                                <span class="val_error" id="title_error"></span>
                            </div>

                            <div class="uk-width-1-3@m uk-width-1-2@s" uk-form-custom id="uploadDiv">
                                <br>
                                <input id="image" type="file" name="file" multiple
                                       onchange="updateFile()" required/>
                                <span class="val_error" id="image_error"></span>
                                <button class="uk-button uk-button-default uk-width-1-1" type="button"
                                        tabindex="-1" id="uploadButton">Upload Images
                                </button>
                            </div>

                            <div class="uk-width-1-2">
                                <strong>Category</strong><select id="category" name="category"
                                                                 class="uk-select"
                                                                 onchange="changeCategory(this);"
                                                                 required>
                                <c:choose>
                                    <c:when test="${listing != null}">
                                        <c:forEach var="category" items="${categories}">
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
                                    </c:when>
                                    <c:otherwise>
                                        <option value="" disabled selected>Select Category</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.category}">${category.category}</option>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                            </select>
                            </div>

                            <div class="uk-width-1-2">
                                <strong>Sub-Category</strong>
                                <c:choose>
                                <c:when test="${listing != null}">
                                <select id="subCategorySelect"
                                        name="subCategory" class="uk-select" required>
                                    <c:forEach var="subCategory" items="${subCategories}">
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
                                    </c:when>
                                    <c:otherwise>
                                    <select id="subCategorySelect"
                                            name="subCategory" class="uk-select" disabled required>
                                        <option value="" disabled selected>Select Category</option>
                                        <c:forEach var="subCategory" items="${subCategories}">
                                            <option class="sub-category ${subCategory.category.category}"
                                                    value="${subCategory.subCategory}">${subCategory.subCategory}</option>
                                        </c:forEach>
                                        </c:otherwise>
                                        </c:choose>
                                        <option id="OtherSubcat" value="Other" style="display: none">Other</option>
                                    </select>
                            </div>

                            <div class="uk-width-1-2@m uk-width-1-1@s">
                                <strong>Type</strong>
                                <select id="type" name="type"
                                        class="uk-select" onchange="typeChange(this);" required>
                                    <c:choose>
                                        <c:when test="${listing != null}">
                                            <c:choose>
                                                <c:when test="${listing.type == 'fixed'}">
                                                    <option value="${listing.type}" selected>Fixed Price
                                                    </option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${listing.type}">Fixed Price</option>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${listing.type == 'auction'}">
                                                    <option value="${listing.type}" selected>Auction</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${listing.type}">Auction</option>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${listing.type == 'donation'}">
                                                    <option value="${listing.type}" selected>Donation</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${listing.type}">Donation</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="" disabled selected>Select Listing Type</option>
                                            <option value="auction">Auction</option>
                                            <option id="donation" value="donation">Donation</option>
                                            <option value="fixed">Fixed Price</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>

                            <div class="uk-width-1-2@m uk-width-1-1@s" id="value">
                                <strong>Price</strong><input type="number" class="uk-input"
                                                             id="price" name="price" value="${listing.price}"
                                                             placeholder="
                                                         Price"> <span
                                    class="val_error" id="price_error"></span>
                            </div>

                            <div class="uk-width-1-1" id="paymentTypeDiv">
                                <strong>Payment Type</strong>
                                <select id="paymentType" name="paymentType"
                                        class="uk-select" required>
                                    <c:choose>
                                        <c:when test="${listing != null}">
                                            <c:choose>
                                                <c:when test="${listing.paymentType == 'PAYPAL'}">
                                                    <option value="${listing.paymentType}" selected>PayPal
                                                    </option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${listing.paymentType}">PayPal</option>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${listing.paymentType == 'CASH'}">
                                                    <option value="${listing.paymentType}" selected>Cash
                                                    </option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${listing.paymentType}">Cash</option>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${listing.paymentType == 'EITHER'}">
                                                    <option value="${listing.type}" selected>Doesn't Matter
                                                        (Buyer
                                                        Chooses
                                                        Cash or PayPal)
                                                    </option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${listing.type}">Doesn't Matter (Buyer
                                                        Chooses
                                                        Cash or
                                                        PayPal)
                                                    </option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="" disabled selected>Select Payment Type</option>
                                            <option value="PAYPAL">PayPal</option>
                                            <option value="CASH">Cash</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>


                            <div class="uk-width-1-2@m uk-width-1-1@s" id="dateEnd">
                                <strong>End Date</strong><input type="date"
                                                                class="uk-input" id="endDate"
                                                                value="${endDate}" name="endDate"
                                                                placeholder="End Date" disabled min="">
                            </div>

                            <div class="uk-width-1-2@m uk-width-1-1@s" id="timeEnd">
                                <strong>End Time</strong><input type="time"
                                                                class="uk-input" id="endTime"
                                                                value="${endTime}" name="endTime"
                                                                placeholder="End Time" disabled>
                            </div>

                            <div class="uk-width-1-1">
                                <strong>Description </strong>
                                <textarea class="uk-textarea" type="textarea" name="description"
                                          id="message" placeholder="Description" maxlength="140"
                                          rows="7" required>${listing.description}</textarea>
                                <span class="help-block"><p id="characterLeft"
                                                            class="help-block "></span>
                            </div>

                            <div class="uk-width-1-1">
                                <div class="uk-width-1-1">
                                    <button type="submit" id="submit" name="submit"
                                            class="uk-button-large uk-button-primary uk-border-rounded uk-float-right uk-margin-right">
                                        Edit Listing
                                    </button>
                                </div>
                            </div>
                            <input type="hidden" name="filesToIgnore" value="" id="filesToIgnore">
                        </form>
                </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
<%@include file="jspf/footer.jspf" %>
</body>
<%--<script type="text/javascript">
    function validateForm() {
        var title_error = document.getElementById("title_error");
        var title = document.getElementById("titleId").value;

        var file = document.forms["uploadListingForm"]["file"].value;
        var fileArray = file.split(".");
        var extension = fileArray[1];

        var priceString = document.forms["uploadListingForm"]["price"].value;
        var price = parseInt(priceString);

        // Name checking
        if (title == "" || title == null) {
            console.log(title);
            document.getElementById("titleId").style.borderColor = "red";
            document.getElementById('title_error').textContent = "* Field Cannot Be empty";
            document.getElementById('title_error').style.color = "red";
            document.getElementById('titleId').focus();
            return false;
        } else {
            document.getElementById("titleId").style.borderColor = "black";
            document.getElementById('title_error').textContent = "";
        }
        // Image Checking
        if (extension != "jpeg" && extension != "png" && extension != "jpg") {
            document.getElementById('image_error').textContent = "* Must upload an image file.";
            document.getElementById('image_error').style.color = "red";
            document.getElementById('image').focus();
            return false;
        } else if (file == "" || file == null) {
            document.getElementById('image_error').textContent = "* Field Cannot Be Empty.";
            document.getElementById('image_error').style.color = "red";
            document.getElementById('image').focus();
        } else {
            document.getElementById('image_error').textContent = "";

            // Price Checking
        }
        if (price < 0) {
            document.getElementById("price").style.borderColor = "red";
            document.getElementById('price_error').textContent = "*Price cannot be negative.";
            document.getElementById('price_error').style.color = "red";
            document.getElementById('price').focus();
            return false;
        } else {
            document.getElementById("price").style.borderColor = "black";
            document.getElementById('price_error').textContent = "";
        }

        window.alert("Edit successful!");

    }

    function titleVerify() {
        if (titleId != "") {
            titleId.style.border = "1px solid black";
            title_error.innterHTML = "";
            return true;
        }
    }

    function changeCategory(option) {

        if (option.value == "apparel") {
            document.getElementById('apparelSub').style.display = 'inline';
            document.getElementById('technologySub').style.display = 'none';
            document.getElementById('furnatureSub').style.display = 'none';
            document.getElementById('suppliesSub').style.display = 'none';
            document.getElementById('placeholder').style.display = 'none';

        } else if (option.value == "technology") {
            document.getElementById('apparelSub').style.display = 'none';
            document.getElementById('technologySub').style.display = 'inline';
            document.getElementById('furnatureSub').style.display = 'none';
            document.getElementById('suppliesSub').style.display = 'none';
            document.getElementById('placeholder').style.display = 'none';

        } else if (option.value == "furnature") {
            document.getElementById('apparelSub').style.display = 'none';
            document.getElementById('technologySub').style.display = 'none';
            document.getElementById('furnatureSub').style.display = 'inline';
            document.getElementById('suppliesSub').style.display = 'none';
            document.getElementById('placeholder').style.display = 'none';

        } else if (option.value == "supplies") {
            document.getElementById('apparelSub').style.display = 'none';
            document.getElementById('technologySub').style.display = 'none';
            document.getElementById('furnatureSub').style.display = 'none';
            document.getElementById('suppliesSub').style.display = 'inline';
            document.getElementById('placeholder').style.display = 'none';
        }
    }

    function typeChange(type) {
        if (type.value == "auction") {
            document.getElementById("endDate").disabled = false;
            document.getElementById("price").disabled = true;
        } else if (type.value == "fixed") {
            document.getElementById("endDate").disabled = true;
            document.getElementById("price").disabled = false;
        } else if (type.value == "donation") {
            document.getElementById("endDate").disabled = true;
            document.getElementById("price").disabled = true;
        }
    }
</script>--%>
</html>