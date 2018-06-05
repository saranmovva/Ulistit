var userIsThere;

window.addEventListener("load", function () {

    messageBox = document.getElementById("conversation");

    checkForUser();

    setInterval(function () {

        checkForUser();
        if (userIsThere) {
            checkForUpdates();
        }

    }, 2000);

});

function checkForUser() {
    $.get('/checkForUser').done(function (response) {

    });
}

function checkForUpdates() {
    $.get('/checkForUser').done(function (response) {

    });
}

function sendMessage(message, pickUpID) {
    $.ajax({
        type: 'GET',
        url: '/sendPickupMessage',
        data: {message: message, pickUpID: pickUpID}
    }).done(function () {
        updateMessages();
    });
}

var messageBox;

function updateMessages() {
    $.ajax({
        type: 'GET',
        url: '/updatePickupMessages',
        data: {pickUpID: pickUpID},
    }).done(function (response) {

        for (var key in response) {

            if (!document.getElementById("message" + response[key].messageID)) {

            }
        }

    });
}

//     <div>
//     <div class="uk-float-left uk-width-3-4 uk-text-left uk-background-primary uk-border-rounded uk-padding-small"
// style="color: white;">${message.messageBody}
//     </div>
//     <p class="uk-align-left uk-margin-remove-top uk-margin-small-left"
// style="font-size: 12px;">${message.dateSent}</p>
//     </div>
//     <div>
//     <div class="uk-float-right uk-width-3-4 uk-background-muted uk-border-rounded uk-padding-small"
// style="border-style: solid; border-width: 2px; border-color: darkgray">
//     ${message.messageBody}
//     </div>
//     <p class="uk-align-right uk-margin-remove-top uk-margin-small-right"
// style="font-size: 12px;">${message.dateSent}</p>
//     </div>