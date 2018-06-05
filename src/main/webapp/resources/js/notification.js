var notificationCount = 0;
var newNotificationCount = 0;

var notificationHeader;
var notificationList;
var notificationFooter;

var badge1;


// Navbar Notification JS
function dismissNav(notificationID) {
    $.ajax({
        type: 'GET',
        url: '/dismiss',
        data: {n: notificationID},
    });
    document.getElementById('notification' + notificationID).style.display = "none";

    var notifications = document.getElementsByClassName("notification-tile");
    var hiddenCount = 0;

    for (var i = 0; i < notifications.length; i++) {
        if (notifications[i].style.display == 'none') {
            hiddenCount++;
        }
    }

    // If All Notifications Are Hidden, Display Different Header
    if (notifications.length == hiddenCount) {
        notificationHeader.innerText = "No Notifications";
        notificationList.style.display = "none";
        notificationFooter.style.display = "none";
    }

}

function hideNotifications() {

    $.ajax({
        type: 'GET',
        url: '/markAsViewed',
    });

    badge1.style.display = "none";

    var dots = document.getElementsByClassName('badge2');

    for (var i = 0; i < dots.length; i++) {
        dots[i].style.display = "none";
    }

    newNotificationCount = 0;

}

window.addEventListener("load", function () {

    notificationHeader = document.getElementById("notificationHeader");
    notificationList = document.getElementById("notificationList");
    notificationFooter = document.getElementById("notificationFooter");

    badge1 = document.getElementById("badge1");

    // Initialize Notifications
    updateNotifications();

    // Display appropriate header, body, and footer
    if (notificationCount === 0) {
        notificationHeader.innerText = "No Notifications";
        notificationFooter.style.display = "none";
        notificationList.style.display = "none";
    } else if (notificationCount < 11) {
        notificationHeader.innerText = "Notifications";
        notificationFooter.style.display = "none";
        notificationList.style.display = "inline";
    } else {
        notificationHeader.innerText = "Notifications";
        notificationFooter.style.display = "inline";
        notificationList.style.display = "inline";
    }

    // Refresh Notifications Every 2 Seconds
    setInterval(function () {
        updateNotifications();
    }, 2000);

});

function updateNotifications() {

    // Update Notifications
    $.get('/updateNotificationDropdown').done(function (response) {

        // Loop through notifications
        for (var key in response) {

            if (notificationCount < 10) {

                var countBefore = notificationCount;
                var newCountBefore = newNotificationCount;

                // If notification isn't already displayed add to div
                if (!document.getElementById("notification" + response[key].notificationID)) {

                    var notificationHTML = '<div class="uk-padding-small uk-padding-remove-left ' +
                        'notification-tile uk-grid-small" ';
                    if (response[key].viewed == '0') {
                        notificationHTML += 'style="border-left: 6px solid #ff695c;"';
                    }
                    notificationHTML += ' id="notification' + response[key].notificationID + '" uk-grid>';

                    notificationHTML += '<div class="uk-width-1-6">';

                    // Add Icon
                    if (response[key].type == 'WON') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-won">' +
                            '<i class="fas fa-trophy"></i></div></div>';

                    } else if (response[key].type == 'LOST') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-lost">' +
                            '<i class="far fa-frown"></i></div></div>';

                    } else if (response[key].type == 'SOLD') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-sold">' +
                            '<i class="far fa-money-bill-alt"></i></div></div>';

                    } else if (response[key].type == 'HIGHEST_BIDDER') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-highest-bidder">' +
                            '<i class="fas fa-thumbs-up"></i></div></div>';

                    } else if (response[key].type == 'NO_BIDDER') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-no-bidder">' +
                            '<i class="fas fa-thumbs-down"></i></div></div>';

                    } else if (response[key].type == 'BID_CANCEL') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-bid-cancel">' +
                            '<i class="fas fa-ban"></i></div></div>';

                    } else if (response[key].type == 'DISPUTE') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-dispute">' +
                            '<i class="fas fa-gavel"></i></div></div>';

                    } else if (response[key].type == 'DONATION') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-donation">' +
                            '<i class="fas fa-hand-holding-heart"></i></div></div>'

                    } else if (response[key].type == 'PICKUP') {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-pickup">' +
                            '<i class="fas fa-people-carry"></i></div></div>';

                    } else {
                        notificationHTML += '<div class="notification-nav-icon nav-notification-icon-default">' +
                            '<i class="fas fa-star"></i></div></div>';

                    }

                    notificationHTML += '<div class="uk-width-4-5">';

                    // Add Subject w/ Dismiss Icon
                    notificationHTML += '<span><a uk-tooltip="title: Dismiss" class="uk-float-right" ' +
                        'style="color: red; margin-left: 5px;" onclick="dismissNav(' +
                        response[key].notificationID + ');" uk-icon="icon: close"></a>' +
                        '<a class="uk-link-muted uk-text-center" href="/listing?l=' + response[key].listingID
                        + '">' + response[key].subject + '</a></span></div>';


                    // Add new notification
                    $('#notificationList').prepend(notificationHTML);

                    // Log New Notification
                    console.log('Added Notification ID=' + response[key].notificationID + ' SUBJECT="' + response[key].subject) + '"';

                    // Update Count
                    notificationCount++;

                    // If New Notification, Update New Count
                    if (response[key].viewed == '0') {
                        newNotificationCount++;
                        // Display Desktop Notification
                        showDesktopNotification(response[key].subject, response[key].message, 'localhost:8080/listing?l=' + response[key].listingID);
                    }
                }

            } else {
                // Hide See More If No Remaining Notifications
                if (notificationHeader.innerText == "Notifications") {
                    notificationFooter.style.display = "inline";
                } else {
                    notificationFooter.style.display = "none";
                }
            }
        }

        // If new notifications were added
        if (notificationCount > countBefore) {

            // If body is hidden, display it
            notificationHeader.innerText = "Notifications";
            notificationList.style.display = "inline";

            if (newNotificationCount > newCountBefore) {
                // Display Badge With New Notification Count
                badge1.setAttribute('data-badge', newNotificationCount.toString());
                badge1.style.display = 'inline';
            }

            console.log('Badge Updated To ' + newNotificationCount);

        }
    });
}

// Notification Page JS
function remove(notificationID) {
    $.ajax({
        type: 'GET',
        url: '/remove',
        data: {n: notificationID},
    });

    // Remove From All
    document.getElementById("notification" + notificationID + "Item").style.display = "none";

    // Remove From New
    document.getElementById("notification" + notificationID + "ItemNew").style.display = "none";
}

// --Desktop Notification Access--
// request permission on page load
document.addEventListener('DOMContentLoaded', function () {
    if (!Notification) {
        console.log("Desktop notifications not available in this browser.");
        return;
    }

    if (Notification.permission !== "granted")
        Notification.requestPermission();
});

function showDesktopNotification(notificationTitle, notificationBody, notificationRedirect) {
    if (Notification.permission !== "granted") {
        Notification.requestPermission();
    } else {
        var notification = new Notification(notificationTitle, {
            icon: 'resources/img/logo.png',
            body: notificationBody,
        });

        notification.onclick = function () {
            window.open(notificationRedirect);
        };

        $.ajax({
            type: 'GET',
            url: '/markAsViewed',
        });
    }
}
