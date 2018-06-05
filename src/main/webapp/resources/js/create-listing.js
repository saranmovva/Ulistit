function removeImage(isDraft, imageID, listingID) {

    // If draft remove from existing listing
    if (isDraft) {
        $.ajax({
            type: 'GET',
            url: '/removeImage',
            data: {listingID: listingID, imageID: imageID},
            success: function (result) {
                // Remove Badge
                document.getElementById("image" + imageID).style.display = "none";
            },
            error: function (result) {
                alert("Error Removing Image: " + result);
            },
        });

    } else {
        // Remove Badge
        document.getElementById("image" + imageID).style.display = "none";

        // Remove From Array
        var index = uploadedFileNames.indexOf(document.getElementById("image" + imageID).innerText);
        uploadedFileNames.splice(index, 1);

        // Add To Ignore List
        document.getElementById("filesToIgnore").value += document.getElementById("image" + imageID).innerText;

    }

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

function typeChange(type) {

    if (type.value == "auction") {
        document.getElementById("endDate").disabled = false;
        var required = document.createAttribute("required");
        document.getElementById("endDate").setAttributeNode(required);

        document.getElementById("endTime").disabled = false;
        required = document.createAttribute("required");
        document.getElementById("endTime").setAttributeNode(required);

        document.getElementById("price").disabled = true;
        if (document.getElementById("price").hasAttribute("required")) {
            document.getElementById("price").removeAttribute("required");
        }

        document.getElementById("paymentType").disabled = false;
        required = document.createAttribute("required");
        document.getElementById("paymentType").setAttributeNode(required);

    } else if (type.value == "fixed") {

        document.getElementById("endDate").disabled = true;
        if (document.getElementById("endDate").hasAttribute("required")) {
            document.getElementById("endDate").removeAttribute("required");
        }

        document.getElementById("endTime").disabled = true;
        if (document.getElementById("endTime").hasAttribute("required")) {
            document.getElementById("endTime").removeAttribute("required");
        }

        document.getElementById("price").disabled = false;
        required = document.createAttribute("required");
        document.getElementById("price").setAttributeNode(required);

        document.getElementById("paymentType").disabled = false;
        required = document.createAttribute("required");
        document.getElementById("paymentType").setAttributeNode(required);


    } else if (type.value == "donation") {

        document.getElementById("endDate").disabled = true;
        if (document.getElementById("endDate").hasAttribute("required")) {
            document.getElementById("endDate").removeAttribute("required");
        }

        document.getElementById("endTime").disabled = true;
        if (document.getElementById("endTime").hasAttribute("required")) {
            document.getElementById("endTime").removeAttribute("required");
        }

        document.getElementById("price").disabled = true;
        if (document.getElementById("endTime").hasAttribute("required")) {
            document.getElementById("price").removeAttribute("required");
        }

        document.getElementById("paymentType").disabled = true;
        if (document.getElementById("paymentType").hasAttribute("required")) {
            document.getElementById("paymentType").removeAttribute("required");
        }
    }
}

function changeCategory(option) {

    var allSubCategories = document.getElementsByClassName("sub-category");

    for (var i = 0; i < allSubCategories.length; i++) {
        if (allSubCategories[i].classList.contains(option.value)) {
            allSubCategories[i].style.display = "inline";
        } else {
            allSubCategories[i].style.display = "none";
        }
    }

    if (option.value != 'Other') {
        document.getElementById("OtherSubcat").style.display = "inline";
    }

    document.getElementById("subCategorySelect").removeAttribute("disabled");
}

function draftToggle(checkbox) {
    if (checkbox.checked) {
        document.getElementById("submit").classList.remove("uk-button-primary");
        document.getElementById("submit").classList.add("uk-button-secondary");
        document.getElementById("submit").innerText = "Save Draft";
    } else {
        document.getElementById("submit").classList.remove("uk-button-secondary");
        document.getElementById("submit").classList.add("uk-button-primary");
        document.getElementById("submit").innerText = "Create Listing";
    }
}

window.addEventListener("load", function () {

    // Set min date to today
    var date = new Date();
    var dd = date.getDate();
    var mm = date.getMonth() + 1; //January is 0!
    var yyyy = date.getFullYear();

    if (dd < 10) {
        dd = '0' + dd
    }

    if (mm < 10) {
        mm = '0' + mm
    }

    var curDate = yyyy + '-' + mm + '-' + dd;
    document.getElementById("endDate").value = curDate;

    // Set min time to one hour from right now
    var hh = date.getHours() + 1;
    var mm = date.getMinutes();

    if (hh < 10) {
        hh = '0' + hh;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }


    var time = hh + ':' + mm;

    document.getElementById("endTime").value = time;

});
