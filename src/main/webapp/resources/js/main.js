function cancelBid(listingID) {
    alert("Works");
    $.ajax({
        type: "GET",
        url: "/cancelBid",
        data: {
            l: listingID
        },
    });

    $('#cancelBidModal + listingID').modal('hide');
}

function displayErrorMessage(message) {
    UIkit.notification({message: message, status: 'danger'});
    $('#dangerButton').click();
}

function displayWarningMessage(message) {
    UIkit.notification({message: message, status: 'warning'});
    $('#warningButton').click();
}

function displaySuccessMessage(message) {
    UIkit.notification({message: message, status: 'success'});
    $('#successButton').click();
}