<script>

    function showErrorMessage(message) {

        // Get message box
        var messageBox = document.getElementById("messageBox");

        // Create a new error div
        var newErrorDiv = document.createElement("DIV");

        // Add style to newErrorDiv
        newErrorDiv.style.textAlign = "center";
        newErrorDiv.style.marginTop = "40px";

        // Add uk-alert-success as a class
        var newErrorDivClass = document.createAttribute("class");
        newErrorDivClass.value = "uk-alert-danger";
        newErrorDiv.setAttributeNode(newErrorDivClass);
        newErrorDiv.setAttributeNode(document.createAttribute("uk-alert"));

        // Add alert close anchor
        var newErrorDivClose = document.createElement("A");
        var newErrorDivCloseClass = document.createAttribute("class");
        newErrorDivCloseClass.value = "uk-alert-close";
        newErrorDivClose.setAttributeNode(newErrorDivCloseClass);
        newErrorDivClose.setAttributeNode(document.createAttribute("uk-close"));

        // Add anchor to newErrorDiv
        newErrorDiv.appendChild(newErrorDivClose);

        // Add error message p to newErrorDiv
        var newErrorDivPara = document.createElement("P");
        newErrorDivPara.appendChild(document.createTextNode(message));
        newErrorDiv.appendChild(newErrorDivPara);

        // Add error div to message box
        messageBox.appendChild(newErrorDiv);

    }

    function showWarningMessage(message) {

        // Get message box
        var messageBox = document.getElementById("messageBox");

        // Create a new warning div
        var newWarningDiv = document.createElement("DIV");

        // Add style to newWarning
        newWarningDiv.style.textAlign = "center";
        newWarningDiv.style.marginTop = "40px";

        // Add uk-alert-warning as a class
        var newWarningDivClass = document.createAttribute("class");
        newWarningDivClass.value = "uk-alert-warning";
        newWarningDiv.setAttributeNode(newWarningDivClass);
        newWarningDiv.setAttributeNode(document.createAttribute("uk-alert"));

        // Add alert close anchor
        var newWarningDivClose = document.createElement("A");
        var newWarningDivCloseClass = document.createAttribute("class");
        newWarningDivCloseClass.value = "uk-alert-close";
        newWarningDivClose.setAttributeNode(newWarningDivCloseClass);
        newWarningDivClose.setAttributeNode(document.createAttribute("uk-close"));

        // Add anchor to newWarningDiv
        newWarningDiv.appendChild(newWarningDivClose);

        // Add warning message p to newErrorDiv
        var newWarningDivPara = document.createElement("P");
        newWarningDivPara.appendChild(document.createTextNode(message));
        newWarningDiv.appendChild(newErrorDivPara);

        // Add warning div to message box
        messageBox.appendChild(newWarningDiv);

    }

    function showSuccessMessage(message) {

        // Get message box
        var messageBox = document.getElementById("messageBox");

        // Create a new success div
        var newSuccessDiv = document.createElement("DIV");

        // Add style to newWarning
        newSuccessDiv.style.textAlign = "center";
        newSuccessDiv.style.marginTop = "40px";

        // Add uk-alert-warning as a class
        var newSuccessDivClass = document.createAttribute("class");
        newSuccessDivClass.value = "uk-alert-success";
        newSuccessDiv.setAttributeNode(newSuccessDivClass);
        newSuccessDiv.setAttributeNode(document.createAttribute("uk-alert"));

        // Add alert close anchor
        var newSuccessDivClose = document.createElement("A");
        var newSuccessDivCloseClass = document.createAttribute("class");
        newSuccessDivCloseClass.value = "uk-alert-close";
        newSuccessDivClose.setAttributeNode(newSuccessDivCloseClass);
        newSuccessDivClose.setAttributeNode(document.createAttribute("uk-close"));

        // Add anchor to newSuccessDiv
        newSuccessDiv.appendChild(newSuccessDivClose);

        // Add success message p to newErrorDiv
        var newSuccessDivPara = document.createElement("P");
        newSuccessDivPara.appendChild(document.createTextNode(message));
        newSuccessDiv.appendChild(newSuccessDivPara);

        // Add success div to message box
        messageBox.appendChild(newSuccessDiv);

    }

</script>