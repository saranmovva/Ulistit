<%@include file="admin-header.jsp" %>

<body onload="loadGraphs(${salesPerWeek}, ${salesPerHour}, ${salesPerMonth}, ${lastWeekSalesPerWeek}, ${lastWeekSalesPerHour}, ${lastMonthlySales}, ${yearlySale}, ${dailyCount}, ${weeklyCount}, ${monthlyCount}, ${yearlyCount})">

<%@include file="admin-navbar.jsp" %>

<%@include file="../jspf/messages.jsp" %>

<div class="uk-container">
    <h1 class="uk-heading-line uk-text-center"><span><strong>Dashboard</strong></span></h1>
</div>
<br>
<div class="uk-container">
    <div class="uk-child-width-1-3@m uk-grid-small uk-grid-match" uk-grid>
        <div>
            <div class="active-users uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body">
                <div class="uk-child-width-1-2@s uk-grid-small uk-grid-match" uk-grid>
                    <div>
                        <span uk-icon="icon: users; ratio: 4.5"></span>
                    </div>
                    <div class="uk-text-right">
                        <div class="uk-container">
                            <span class="active-users-number"><strong>${activeUsers.size()}</strong></span>
                            <div>Active Members</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="total-revenue uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body">
                <div class="uk-child-width-1-2@s uk-grid-small uk-grid-match" uk-grid>
                    <div>
                        <span uk-icon="icon: tag; ratio: 4.5"></span>
                    </div>
                    <div class="uk-text-right">
                        <div class="uk-container">
                            <span class="active-users-number"><strong>$${dailyRevenue}</strong></span>
                            <div>Today's Sales</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="active-listings uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body">
                <div class="uk-child-width-1-2@s uk-grid-small uk-grid-match" uk-grid>
                    <div>
                        <span uk-icon="icon: image; ratio: 4.5"></span>
                    </div>
                    <div class="uk-text-right">
                        <div class="uk-container" style="font-size: 16px;">
                            <span class="active-users-number"><strong>${activeListings.size()}</strong></span>
                            <div>Active Listings</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br>
<div class="uk-container">
    <div uk-grid>
        <div class="uk-width-3-5@s">
            <div class="uk-background-default uk-padding uk-panel uk-border-rounded">
                <div clas="uk-display-inline-block">
                    <div>
                        <h2>Sales Overview</h2>
                    </div>
                    <hr>
                    <div>
                        <ul class="uk-subnav uk-subnav-pill"
                            uk-switcher="animation: uk-animation-slide-left-medium, uk-animation-slide-right-medium">
                            <li><a href="#">Hourly</a></li>
                            <li><a href="#">Daily</a></li>
                            <li><a href="#">Monthy</a></li>
                            <li><a href="#">Yearly</a></li>


                        </ul>
                        <ul class="uk-switcher uk-margin">
                            <li>
                                <canvas id="hourly" width="300" height="200"></canvas>
                            </li>
                            <li>
                                <canvas id="daily" width="300" height="200"></canvas>
                            </li>
                            <li>
                                <canvas id="monthly" width="300" height="200"></canvas>
                            </li>
                            <li>
                                <canvas id="yearly" width="300" height="200"></canvas>
                            </li>
                        </ul>
                    </div>

                </div>


            </div>
        </div>
        <div class="uk-width-2-5@s">
            <div class="uk-background-default uk-padding uk-panel">
                <h2>Site Traffic </h2>
                <hr>
                <ul class="uk-subnav uk-subnav-pill"
                    uk-switcher="animation: uk-animation-slide-left-medium, uk-animation-slide-right-medium">
                    <li><a href="#">Daily</a></li>
                    <li><a href="#">Weekly</a></li>
                    <li><a href="#">Monthy</a></li>
                    <li><a href="#">Yearly</a></li>


                </ul>
                <ul class="uk-switcher uk-margin">
                    <li>
                        <canvas id="daySite" width="800" height="900"></canvas>
                    </li>
                    <li>
                        <canvas id="weeksSite" width="800" height="900"></canvas>
                    </li>
                    <li>
                        <canvas id="monthSite" width="800" height="900"></canvas>
                    </li>
                    <li>
                        <canvas id="yearSite" width="800" height="900"></canvas>
                    </li>


                </ul>

            </div>
        </div>
    </div>
</div>
</div>
<br>
<div class="uk-container">
    <div uk-grid>
        <div class="uk-width-2-5">
            <div class="uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body" style="
                 overflow:auto; height:500px;">

                <h3 class="uk-card-title">Admin Team</h3>
                <hr>

                <table class="uk-table uk-table-hover uk-table-divider">
                    <thead>
                    <tr>
                        <th>Admin</th>
                        <th>Level</th>

                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="admin" items="${admins}" varStatus="loop">
                        <tr>
                            <td>
                                <div class="uk-grid-margin-medium uk-flex-middle" uk-grid>
                                    <div class="uk-width-auto">
                                        <script>
                                        </script>
                                        <img class="profile-pic uk-border-circle"
                                             style="height: 60px; width: 60px; overflow: hidden"
                                             src="${pageContext.request.contextPath}/directory/${admin.getMainImage()}">
                                    </div>
                                    <div>
                                        <h5 class="uk-margin-remove-bottom">${admin.firstName} ${admin.lastName}</h5>
                                        <p class="uk-text-meta  uk-margin-remove-top">
                                            <time datetime="2016-04-01T19:00">${admin.username}</time>
                                        </p>
                                    </div>
                                </div>
                            </td>
                            <td>${status.get(loop.index)}</td>

                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
        <div class="uk-width-1-5">

        </div>
        <div class="uk-width-2-5">
            <div class="uk-card-small uk-card-default uk-card-hover uk-border-rounded uk-card-body"
                 style="overflow: auto;">
                <h3 class="uk-card-title">Task Manager
                    <span class="uk-inline">
                        <a href="${pageContext.request.contextPath}/taskManager" class="uk-icon-link"
                           uk-icon="icon:  plus-circle; ratio: 2"></a>
                    </span>
                </h3>
                <hr>
                <table class="uk-table uk-table-hover uk-table-divider">

                    <thead>

                    </thead>
                    <tbody>
                    <c:forEach var="task" items="${tasks}" varStatus="loop">
                        <tr>

                            <td>
                                <div uk-grid>
                                    <c:choose>
                                        <c:when test="${task.priority == 'low'}">
                                            <div class="uk-width-4-5">
                                                <c:choose>
                                                    <c:when test="${task.status == 0}">
                                                        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                            <label><input id="task${task.taskID}"
                                                                          onchange="checkTask(${task.taskID});"
                                                                          class="uk-checkbox" type="checkbox"><span
                                                                    class="low uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                <span id="name${task.taskID}">${task.name}</span>
                                                            </label>

                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                            <label><input id="task${task.taskID}"
                                                                          onchange="checkTask(${task.taskID});"
                                                                          class="uk-checkbox" type="checkbox"
                                                                          checked><span
                                                                    class="low uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                <span id="name${task.taskID}"
                                                                      style="text-decoration: line-through;">${task.name}</span>
                                                            </label>

                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:when>
                                        <c:when test="${task.priority == 'normal'}">
                                            <div class="uk-width-4-5">
                                                <c:choose>
                                                    <c:when test="${task.status == 0}">
                                                        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                            <label><input id="task${task.taskID}"
                                                                          onchange="checkTask(${task.taskID});"
                                                                          class="uk-checkbox" type="checkbox"><span
                                                                    class="normal uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                <span id="name${task.taskID}">${task.name}</span>
                                                            </label>

                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                            <label><input id="task${task.taskID}"
                                                                          onchange="checkTask(${task.taskID});"
                                                                          class="uk-checkbox" type="checkbox"
                                                                          checked><span
                                                                    class="normal uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                <span id="name${task.taskID}"
                                                                      style="text-decoration: line-through;">${task.name}</span>
                                                            </label>

                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:when>
                                        <c:when test="${task.priority == 'high'}">
                                            <div class="uk-width-4-5">
                                                <c:choose>
                                                    <c:when test="${task.status == 0}">
                                                        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                            <label><input id="task${task.taskID}"
                                                                          onchange="checkTask(${task.taskID});"
                                                                          class="uk-checkbox" type="checkbox"><span
                                                                    class="high uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                <span id="name${task.taskID}">${task.name}</span>
                                                            </label>

                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                            <label><input id="task${task.taskID}"
                                                                          onchange="checkTask(${task.taskID});"
                                                                          class="uk-checkbox" type="checkbox"
                                                                          checked><span
                                                                    class="high uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                <span id="name${task.taskID}"
                                                                      style="text-decoration: line-through;">${task.name}</span>
                                                            </label>

                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:when>
                                        <c:when test="${task.priority == 'critical'}">
                                            <div class="uk-width-4-5">
                                                <c:choose>
                                                    <c:when test="${task.status == 0}">
                                                        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                            <label><input id="task${task.taskID}"
                                                                          onchange="checkTask(${task.taskID});"
                                                                          class="uk-checkbox" type="checkbox"><span
                                                                    class="critical uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                <span id="name${task.taskID}">${task.name}</span>
                                                            </label>

                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="uk-margin uk-grid-small uk-child-width-auto uk-grid">
                                                            <label><input id="task${task.taskID}"
                                                                          onchange="checkTask(${task.taskID});"
                                                                          class="uk-checkbox" type="checkbox"
                                                                          checked><span
                                                                    class="critical uk-badge uk-padding-small uk-margin-left"> ${task.priority}</span>
                                                                <span id="name${task.taskID}"
                                                                      style="text-decoration: line-through;">${task.name}</span>
                                                            </label>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:when>
                                        <c:otherwise>Error</c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>



    </div>
</div>

<br>
<div id="dashboardUserTable"
     class="uk-tile uk-width-3-4 uk-align-center uk-padding-remove-top uk-padding-remove-bottom uk-card uk-card-large uk-padding-remove-right uk-padding-remove-left uk-box-shadow-medium uk-box-shadow-hover-large uk-tile-default">
    <div class="uk-overflow-auto" >
        <div class="uk-align-center uk-padding-small uk-margin-bottom" uk-grid>
            <div class="uk-overflow-container" style="overflow:auto; height:800px;">
                <a class="uk-button uk-padding-small uk-button-default uk-position-top-right"
                   href="#createUserModal" uk-toggle
                   hidden>Create
                    User</a>
                <h2 class="uk-heading-line uk-text-center"><span>User Overview</span></h2>
                <table class="uk-table uk-table-small uk-table-hover uk-table-middle uk-table-divider uk-margin uk-margin-large uk-margin-bottom uk-padding-small">
                    <thead>
                    <tr>
                        <th>Member</th>
                        <th>Email</th>
                        <th>Seller Rating</th>
                        <th>Active</th>
                        <th>Date Joined</th>

                    </tr>
                    </thead>

                    <tbody >
                    <c:forEach var="member" items="${members}" varStatus="loop">
                        <tr>
                            <td><div class="uk-grid-margin-medium uk-flex-middle" uk-grid >
                                    <div class="uk-width-auto">
                                        <img class="profile-pic uk-border-circle"
                                             style="height: 60px; width: 60px; overflow: hidden"
                                             src="${pageContext.request.contextPath}/directory/${member.getMainImage()}">
                                    </div>
                                    <div>
                                        <h5 class="uk-margin-remove-bottom">${member.firstName} ${member.lastName}</h5>
                                        <p class="uk-text-meta  uk-margin-remove-top">
                                            <time datetime="2016-04-01T19:00">${member.username}</time>
                                        </p>
                                    </div>
                                </div>
                            </td>
                            <td><div style="color: blue;">
                                    ${member.schoolEmail}
                            </div>
                            </td>
                            <c:choose>
                                <c:when
                                        test="${user.sellerRating == null || user.sellerRating == 0}">
                                    <th><h5>none</h5></th>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${user.sellerRating == 1}">
                                            <th class="uk-text-center"><span uk-icon="star"></span></th>
                                        </c:when>
                                        <c:when test="${user.sellerRating == 2}">
                                            <th class="uk-text-center"><span uk-icon="star"></span><span
                                                    uk-icon="star"></span></th>
                                        </c:when>
                                        <c:when test="${user.sellerRating == 3}">
                                            <th class="uk-text-center"><span uk-icon="star"></span><span
                                                    uk-icon="star"></span><span
                                                    uk-icon="star"></span></th>
                                        </c:when>
                                        <c:when test="${user.sellerRating == 4}">
                                            <th class="uk-text-center"><span uk-icon="star"></span><span
                                                    uk-icon="star"></span><span
                                                    uk-icon="star"></span><span uk-icon="star"></span></th>
                                        </c:when>
                                        <c:when test="${user.sellerRating == 5}">
                                            <th class="uk-text-center"><span uk-icon="star"></span><span
                                                    uk-icon="star"></span><span
                                                    uk-icon="star"></span><span uk-icon="star"></span><span
                                                    uk-icon="star"></span></th>
                                        </c:when>
                                    </c:choose>
                                    <dd></dd>
                                    <dd class="uk-margin-top">
                                        <a
                                                href="${pageContext.request.contextPath}/sellerReviews?id=${user.userID}"
                                                class="uk-button uk-button-small uk-button-primary">View
                                            Seller Reviews</a>
                                    </dd>
                                </c:otherwise>
                            </c:choose>
                            <th class="uk-align-center">
                                <c:choose>
                                    <c:when test="${user.active == 1}">
                                        <i class="fas fa-check" style="color: green; font-size: 24px;"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="far fa-times" style="color: red; font-size: 24px;"></i>
                                    </c:otherwise>
                                </c:choose></th>
                            <td>${userDate.get(loop.index)}</td>

                        </tr>
                    </c:forEach>
                    </tbody>


                </table>
            </div>
        </div>
    </div>
</div>


<script>

    function loadGraphs(salesPerWeek, salesPerHour, salesPerMonth, salesPerWeekLastWeek, lastWeekSalesPerHour, lastMontlySales, yearlySale, dailyCount, weeklyCount, monthlyCount, yearlyCount) {
        var week = salesPerWeek;
        var lastWeek = salesPerWeekLastWeek;
        var hour = salesPerHour;
        var lastHour = lastWeekSalesPerHour;
        var month = salesPerMonth;
        var lastMonth = lastMontlySales;
        var year = yearlySale;

        var dCount = dailyCount;
        var wCount = weeklyCount;
        var mCount = monthlyCount;
        var yCount = yearlyCount;
        console.log("Year Count: " + yCount[0]);

        new Chart(document.getElementById("yearly"), {
            type: 'line',
            data: {
                labels: ["2017", "2018", "2019",],
                datasets: [{
                    data: [year[0], year[1], 0],
                    label: "2018",
                    borderColor: "#2AF598",
                    fill: false
                },
                ]
            },
            options: {
                title: {
                    display: true,
                    text: 'Timeframe (Yearly)'
                }
            }
        });


        new Chart(document.getElementById("monthly"), {
            type: 'line',
            data: {
                labels: ["Jenuary", "February", "March", "April", "May", "June", " July", "August", "September", "October", "November", "December"],
                datasets: [{
                    data: [month[0], month[1], month[2], month[3], month[4], month[5], month[6], month[7], month[8], month[9], month[10], month[11]],
                    label: "2018",
                    borderColor: "#2AF598",
                    fill: false
                }, {
                    data: [lastMonth[0], lastMonth[1], lastMonth[2], lastMonth[3], lastMonth[4], lastMonth[5], lastMonth[6], lastMonth[7], lastMonth[8], lastMonth[9], lastMonth[10], lastMonth[11]],
                    label: "2017",
                    borderColor: "#08AEEA",
                    fill: false
                }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: 'Timeframe (Monthly)'
                }
            }
        });

        new Chart(document.getElementById("daily"), {
            type: 'line',
            data: {
                labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", " Saturday"],
                datasets: [{
                    data: [week[0], week[1], week[2], week[3], week[4], week[5], week[6]],
                    label: "This Week",
                    borderColor: "#2AF598",
                    fill: false
                },
                    {
                        data: [lastWeek[0], lastWeek[1], lastWeek[2], lastWeek[3], lastWeek[4], lastWeek[5], lastWeek[6]],
                        label: "Last Week",
                        borderColor: "#08AEEA",
                        fill: false
                    }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: 'Timeframe (Daily)'
                }
            }
        });

        new Chart(document.getElementById("hourly"), {
            type: 'line',
            data: {
                labels: ["1AM", "2AM", "3AM", "4AM", "5AM", "6AM", " 7AM", "8AM", "9AM", "10AM", "11AM", "12AM", "1PM", "2PM", "3PM", "4PM", "5PM", "6PM", " 7PM", "8PM", "9PM", "10PM", "11PM", "12PM"],
                datasets: [{
                    data: [hour[0], hour[1], hour[2], hour[3], hour[4], hour[5], hour[6], hour[7], hour[8], hour[9], hour[10], hour[11], hour[12], hour[13], hour[14], hour[15], hour[16], hour[17], hour[18], hour[19], hour[20], hour[21], hour[22], hour[23]],
                    label: "Today",
                    borderColor: "#2AF598",
                    fill: false
                }, {
                    data: [lastHour[0], lastHour[1], lastHour[2], lastHour[3], lastHour[4], lastHour[5], lastHour[6], lastHour[7], lastHour[8], lastHour[9], lastHour[10], lastHour[11], lastHour[12], lastHour[13], lastHour[14], lastHour[15], lastHour[16], lastHour[17], lastHour[18], lastHour[19], lastHour[20], lastHour[21], lastHour[22], lastHour[23]],
                    label: "Last Week",
                    borderColor: "#08AEEA",
                    fill: false
                }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: 'Timeframe (Today)'
                }
            }
        });

        new Chart(document.getElementById("yearSite"), {
            type: 'doughnut',
            data: {
                labels: ["Community Page", "Home Page", "Landing Page", "Create a Listing", "Search Page", "Donation Page"],
                datasets: [
                    {
                        label: "Population (millions)",
                        backgroundColor: ["#B721FF", "#2AF598", "#F3FF21", "#FF0000", "#52ACFF", "#FF3CAC"],
                        data: [yCount[0], yCount[1], yCount[2], yCount[3], yCount[4], yCount[5]]
                    }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: 'Timeframe(This Year)'
                }
            }
        });

        new Chart(document.getElementById("monthSite"), {
            type: 'doughnut',
            data: {
                labels: ["Community Page", "Home Page", "Landing Page", "Create a Listing", "Search Page", "Donation Page"],
                datasets: [
                    {
                        label: "Population (millions)",
                        backgroundColor: ["#B721FF", "#2AF598", "#F3FF21", "#FF0000", "#52ACFF", "#FF3CAC"],
                        data: [mCount[0], mCount[1], mCount[2], mCount[3], mCount[4], mCount[5]]
                    }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: 'Timeframe(This Month)'
                }
            }
        });
        new Chart(document.getElementById("weeksSite"), {
            type: 'doughnut',
            data: {
                labels: ["Community Page", "Home Page", "Landing Page", "Create a Listing", "Search Page", "Donation Page"],
                datasets: [
                    {
                        label: "Population (millions)",
                        backgroundColor: ["#B721FF", "#2AF598", "#F3FF21", "#FF0000", "#52ACFF", "#FF3CAC"],
                        data: [wCount[0], wCount[1], wCount[2], wCount[3], wCount[4], wCount[5]]
                    }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: 'Timeframe(This Week)'
                }
            }
        });
        new Chart(document.getElementById("daySite"), {
            type: 'doughnut',
            data: {
                labels: ["Community Page", "Home Page", "Landing Page", "Create a Listing", "Search Page", "Donation Page"],
                datasets: [
                    {
                        label: "Population (millions)",
                        backgroundColor: ["#B721FF", "#2AF598", "#F3FF21", "#FF0000", "#52ACFF", "#FF3CAC"],
                        data: [dCount[0], dCount[1], dCount[2], dCount[3], dCount[4], dCount[5]]
                    }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: 'Timeframe(Today)'
                }
            }
        });
    }

    function checkTask(taskID) {
        console.log("Hit Function");
        $.ajax({
            type: 'GET',
            url: '/taskCompleted',
            data: {"taskID": taskID},
        })
        if (document.getElementById('task' + taskID).checked) {
            document.getElementById('name' + taskID).style.textDecoration = "line-through";
        } else {
            document.getElementById('name' + taskID).style.textDecoration = "none"
        }
    }
</script>

</body>
</html>
