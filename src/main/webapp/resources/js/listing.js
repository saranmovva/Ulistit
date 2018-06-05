UIkit.util.ready(function () {

        refreshCountdowns();

        var interval = setInterval(function () {

            refreshCountdowns();

            var bars = document.getElementsByClassName("uk-progress");

            for (var i = 0; i < bars.length; i++) {
                bars[i].value = new Date().getTime();
            }

        }, 900);

    }
);

function refreshCountdowns() {

    var seconds = document.getElementsByClassName("uk-countdown-seconds");
    var minutes = document.getElementsByClassName("uk-countdown-minutes");
    var hours = document.getElementsByClassName("uk-countdown-hours");
    var days = document.getElementsByClassName("uk-countdown-days");

    var secondsDiv = document.getElementsByClassName("uk-seconds");
    var minutesDiv = document.getElementsByClassName("uk-minutes");
    var hoursDiv = document.getElementsByClassName("uk-hours");
    var daysDiv = document.getElementsByClassName("uk-days");

    var ended = document.getElementsByClassName("listing-ended");

    var countdowns = document.getElementsByClassName("uk-countdown");

    for (var i = 0; i < days.length; i++) {

        if (days[i].innerText != "00") {

            // Display Days & Hours
            daysDiv[i].style.display = "inline";
            hoursDiv[i].style.display = "inline";
            minutesDiv[i].style.display = "none";
            secondsDiv[i].style.display = "none";

        } else if (days[i].innerText == "00" && hours[i].innerText != "00") {

            // Display Hours & Minutes
            daysDiv[i].style.display = "none";
            hoursDiv[i].style.display = "inline";
            minutesDiv[i].style.display = "inline";
            secondsDiv[i].style.display = "none";

        } else if (days[i].innerText == "00" && hours[i].innerText == "00" && minutes[i].innerText != "00") {

            // Display Minutes & Seconds
            daysDiv[i].style.display = "none";
            hoursDiv[i].style.display = "none";
            minutesDiv[i].style.display = "inline";
            secondsDiv[i].style.display = "inline";

        } else if (days[i].innerText == "00" && hours[i].innerText == "00" && minutes[i].innerText == "00" && seconds[i].innerText != "00") {

            // Display Seconds
            daysDiv[i].style.display = "none";
            hoursDiv[i].style.display = "none";
            minutesDiv[i].style.display = "none";
            secondsDiv[i].style.display = "inline";

        } else {

            // Listing Ended
            ended[i].style.display = "inline";
            countdowns[i].style.display = "none";
            document.getElementById("placeBidButton").style.display = "none";
            document.getElementById("bidForm").style.display = "none";
            document.getElementById("pickUpForm").style.display = "inline";

        }
    }
}