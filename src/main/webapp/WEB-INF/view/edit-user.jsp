<%@include file="jspf/header.jsp" %>
<%@include file="jspf/messages.jsp" %>

<body class="uk-height-viewport uk-background-muted">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="jspf/navbar.jspf" %>
    <div uk-grid>
        <div class="uk-width-1-4"></div>
        <div class="uk-margin uk-width-1-2">

            <div class="uk-margin uk-card uk-box-shadow-large uk-box-shadow-hover-large uk-card-default uk-card-large uk-card-body">
                <h2 class="uk-heading-line uk-text-center"><span>Update Profile Information</span></h2>
                <hr>
                <h4 class="uk-heading-line uk-text-center"><span>Select Profile Image</span></h4>
                <form action="changeImageMain" method="post">
                    <div class="uk-section-muted">
                        <ul class="uk-thumbnav" uk-margin>
                            <c:forEach items="${user.profileImages}" var="images">
                                <c:if test="${images.main == 0}">
                                    <li><img class="uk-border-rounded"
                                             src="${pageContext.request.contextPath}/directory/${images.image_path}/${images.image_name}"
                                             width="100" alt=""> <input class="uk-radio" type="radio" name="mainImage"
                                                                        onchange="imgToggle()"
                                                                        value="${images.id}">
                                    </li>
                                </c:if>
                                <c:if test="${images.main == 1}">
                                    <li class="uk-active"><img class="uk-border-rounded"
                                                               src="${pageContext.request.contextPath}/directory/${images.image_path}/${images.image_name}"
                                                               width="100" alt=""> <input class="uk-radio" type="radio"
                                                                                          name="mainImage"
                                                                                          onchange="imgToggle()"
                                                                                          value="${images.id}"
                                                                                          checked="checked"></li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>
                    <button type="submit" id="changeImage"
                            class="uk-margin uk-button uk-button-primary uk-border-rounded uk-float-left" disabled>
                        Change Image
                    </button>
                </form>
                <br>
                <br>
                <br>
                <hr>
                <h4 class="uk-heading-line uk-text-center"><span>Upload New Image</span></h4>
                <i><h6 class="uk-text-center">Note: Preferred profile image size is 180 x 180 px</h6></i>
                <form action="profileImageUpload"
                      method="post" enctype="multipart/form-data">
                    <div class="uk-width-1-1 uk-margin-small js-upload" uk-form-custom>
                        <button class="uk-button uk-button-default" type="button" tabindex="-1">Choose Image</button>
                        <input id="image" onchange="updateProfileImage()" type="file" name="file" required/>
                        <span class="val_error" id="image_error"></span>
                    </div>
                    <div class="uk-width-1-1" id="imageBadges"></div>
                    <div class="uk-width-1-1 uk-margin-small">
                        <strong>Set as main profile image:</strong> <input class="uk-checkbox" type="checkbox"
                                                                           name="imageMain" value="yes">
                    </div>
                    <div class="uk-width-1-1 uk-margin-small">
                        <button type="submit" id="saveButton"
                                class="uk-button uk-button-secondary uk-border-rounded uk-float-left" disabled>Save
                        </button>
                        <br>
                        <br>
                    </div>
                </form>
                <form method="post" action="updateUser"
                      onsubmit="return validateForm()" name="updateUser"
                      enctype="multipart/form-data">

                    <div uk-grid>
                        <div class="uk-width-1-3"></div>
                        <div class="uk-width-1-3">

                        </div>

                    </div>
                    <hr>
                    <h4 class="uk-heading-line uk-text-center"><span>Edit User Information</span></h4>
                    <div uk-grid>
                        <div class="uk-width-1-2">
                            <strong>First Name:</strong> <input type="text" class="uk-input"
                                                                id="firstName" name="firstName"
                                                                value="${sessionScope.user.firstName}"
                                                                required>
                        </div>
                        <div class="uk-width-1-2">
                            <strong>Last Name: </strong> <input type="text" class="uk-input"
                                                                id="last Name" name="lastName"
                                                                value="${sessionScope.user.lastName}" required>
                        </div>
                        <div class="uk-width-1-3">
                            <strong>Username:</strong> <input type="text" class="uk-input"
                                                              id="username" name="username"
                                                              value="${sessionScope.user.username}" required>
                        </div>
                        <div class="uk-width-1-2">
                            <strong>E-Mail:</strong> <input type="email" class="uk-input"
                                                            id="email" name="email"
                                                            value="${sessionScope.user.schoolEmail}"
                                                            disabled>
                        </div>
                    </div>
                    <button class="uk-margin uk-border-rounded uk-button uk-button-secondary" type="submit">Update
                    </button>

                    <div class="uk-width-1-2"></div>
                </form>
            </div>
        </div>
    </div>
    <div class="uk-width-1-4"></div>
</div>
<script type="text/javascript">
    function validateForm() {
        var file = document.forms["updateUser"]["file"].value;
        var fileArray = file.split(".");
        var extension = fileArray[1];

        var firstName = document.forms["updateUser"]["firstName"].value;
        var lastName = document.forms["updateUser"]["lastName"].value;
        var username = document.forms["updateUser"]["username"].value;

        var password = document.forms["updateUser"]["password"].value;
        var confirm = document.forms["updateUser"]["confirmPassword"].value;

        var email = document.forms["updateUser"]["email"].value;

        var phoneNumber = document.forms["updateUser"]["phoneNumber"].value;


        if (extension != "jpeg" && extension != "png" && extension != "jpg") {
            alert.("You must upload an image file.");
            return false;
        } else if (/\d/.test(firstName) == true) {
            alert.("First Name cannot have letters");
            return false;
        }
    }
</script>
<script>
    var uploadedFileNames = new Array();
    var fileCount = 0;

    function updateProfileImage() {
        document.getElementById("saveButton").disabled = false;

        var files = document.getElementById('image').files;

        for (var i = 0; i < files.length; i++) {
            // If new file
            if (!uploadedFileNames.includes(files[i].name)) {
                // Add file name to array
                uploadedFileNames.push(files[i].name);
                // Add badge
                var span = '<span class="uk-badge uk-padding-small" style="background-color: lightslategray; margin: 5px;" id="image' + fileCount + '">' + files[i].name;
                span += ' <a class="uk-margin-small-left" uk-icon="icon: close; ratio: 0.75" onclick="removeImage(' + fileCount + ')"></a></span>';

                $('#imageBadges').prepend(span);

                fileCount++;
            }
        }
    }

    function removeImage(imageID) {
        document.getElementById("saveButton").disabled = true;
        // If draft remove from existing listing
        // Remove Badge
        document.getElementById("image" + imageID).style.display = "none";
        document.getElementById("image").value = "";

        // Remove From Array
        var index = uploadedFileNames.indexOf(document.getElementById("image" + imageID).innerText);
        uploadedFileNames.splice(index, 1);

    }

    function imgToggle() {
        document.getElementById("changeImage").disabled = false;

    }


</script>

</body>
<%@include file="jspf/footer.jspf" %>
</html>