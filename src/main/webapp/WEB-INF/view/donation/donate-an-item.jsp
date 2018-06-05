<%@include file="../jspf/header.jsp" %>

<body class="uk-height-viewport">

<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <div class="uk-section uk-background-muted donate-an-item-tutorial">

        <div class="uk-margin-small-top" uk-grid>

            <div class="uk-width-1-1 uk-margin-remove">
                <%@include file="../jspf/help-icon.jsp" %>
            </div>

            <div class="uk-width-3-4@m uk-width-1-1@s uk-align-center">
                <div class="uk-card uk-card-default uk-card-large uk-card-body uk-box-shadow-hover-large uk-border-rounded">
                    <h2 class="uk-text-center" data-intro="Just like when you are selling an item, when you list an item for donation, once someone elects to take your
            item, you will receive a notification. You and the taker will then have to coordinate a date and time to
            drop off your item. It's that easy!"
                        data-step="1">Donate An Item</h2>
                    <hr>
                    <div class="form-area">
                        <form method="POST" class="" uk-grid
                              onsubmit="return validateForm()" action="uploadListing"
                              enctype="multipart/form-data" name="uploadListingForm" uk-grid>
                            <br style="clear: both">


                            <div class="uk-width-2-3@m uk-width-1-2@s">
                                <strong>Title of Product</strong> <input type="text"
                                                                         class="uk-input" id="titleId" name="title"
                                                                         placeholder="Title">
                                <span class="val_error" id="title_error"></span>
                            </div>

                            <div class="uk-width-1-3@m uk-width-1-2@s" uk-form-custom>
                                <br>
                                <input id="image" type="file" name="file" multiple onchange="updateFile(this)"/>
                                <span class="val_error" id="image_error"></span>
                                <button class="uk-button uk-button-default uk-width-1-1" id="uploadButton" type="button"
                                        tabindex="-1">Upload Images
                                </button>
                            </div>

                            <div class="uk-width-1-1 uk-margin-remove-bottom uk-margin-remove-top">
                                <div class="uk-float-right uk-width-1-3@m  uk-width-1-3@l  uk-width-1-2@s"
                                     id="imageBadges"></div>
                            </div>

                            <div class="uk-width-1-2">
                                <strong>Category</strong><select id="category" name="category"
                                                                 class="uk-select" onchange="changeCategory(this);"
                                                                 required>
                                <option value="" disabled selected>Select Category</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.category}">${category.category}</option>
                                </c:forEach>
                            </select>
                            </div>

                            <div class="uk-width-1-2">
                                <strong>Sub-Category</strong>

                                <select id="subCategorySelect"
                                        name="subCategory" class="uk-select" disabled>
                                    <option disabled selected id="default-select">Select Sub-Category</option>

                                    <c:forEach items="${subCategories}" var="subCat">
                                        <option class="sub-category ${subCat.category.category}"
                                                value="${subCat.subCategory}"
                                                style="display: none">${subCat.subCategory}</option>
                                    </c:forEach>

                                </select>
                            </div>

                            <div class="uk-width-1-1">
                                <strong>Description </strong>
                                <textarea class="uk-textarea" type="textarea" name="description"
                                          id="message" placeholder="Description" maxlength="140" rows="7"></textarea>
                                <span class="help-block"><p id="characterLeft"
                                                            class="help-block "></span>
                            </div>

                            <div class="uk-width-1-1">
                                <button type="submit" id="submit" name="submit"
                                        class="uk-button-large uk-button-primary uk-border-rounded uk-float-right">
                                    Donate
                                </button>
                            </div>

                            <input type="hidden" name="premium" value="no">
                            <input type="hidden" name="type" value="donation">
                            <input type="hidden" name="paymentType" value="NONE">

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="../jspf/footer.jspf" %>

</div>

</body>

<script type="text/javascript">
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

        window.alert("Good shit");

    }

    function changeCategory(option) {

        var allSubCategories = document.getElementsByClassName("sub-category");

        for (var i = 0; i < allSubCategories.length; i++) {
            if (allSubCategories[i].classList.contains(option.value)) {
                allSubCategories[i].style.display = "inline";
            } else {
                allSubCategories[i].style.display = "none";
            }
            document.getElementById("default-select").selected = "true";
        }

        document.getElementById("subCategorySelect").removeAttribute("disabled");
    }

    // Start Tutorial
    window.addEventListener("load", function () {
        $.ajax({
            type: 'GET',
            url: '/checkForTutorial',
            data: {page: "checklist"},
        }).done(function (response) {
            if (response.showTutorial == 'YES') {
                setTimeout(function () {
                    startTutorial();
                }, 1500);
            }
        });
    });

    function startTutorial() {
        introJs(".donate-an-item-tutorial").start();
    }

    var uploadedFileNames = new Array();
    var fileCount = 0;

    function updateFile() {

        var files = document.getElementById('image').files;

        for (var i = 0; i < files.length; i++) {
            // If new file
            if (!uploadedFileNames.includes(files[i].name)) {
                // Add file name to array
                uploadedFileNames.push(files[i].name);
                // Add badge
                var span = '<span class="uk-badge uk-padding-small" style="background-color: lightslategray; margin: 5px;" id="image' + fileCount + '">' + files[i].name;
                span += ' <a class="uk-margin-small-left" uk-icon="icon: close; ratio: 0.75" onclick="removeImage(false, ' + fileCount + ', -1)"></a></span>';

                $('#imageBadges').prepend(span);

                fileCount++;
            }
        }
    }


</script>

</html>