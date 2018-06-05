<%@include file="../jspf/header.jsp" %>

<body class="uk-height-viewport">

<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <div class="uk-section uk-background-muted">

        <div class="uk-grid uk-align-center uk-margin-remove-top" uk-grid>

            <h1 class="uk-heading uk-width-4-5@m uk-width-1-1@s uk-align-center"
                style="margin-top: 40px;">
                <span>Frequently Asked Questions</span>
            </h1>

            <div class="uk-align-right uk-visible@m uk-visible@l" style="width: 10%;">
                <div uk-sticky="offset: 50; bottom: #top">
                    <ul class="uk-nav uk-nav-default" uk-scrollspy-nav="closest: li; scroll: true; offset: 50">
                        <li class="uk-active"><a href="#selling">Selling</a></li>
                        <li><a href="#buying">Buying</a></li>
                        <li><a href="#donation">Donation</a></li>
                        <li><a href="#freshman-checklist">Freshman Checklist</a></li>
                        <li><a href="#profile">Profile</a></li>
                        <li><a href="#notifications">Notifications</a></li>
                        <li><a href="#community">Community</a></li>
                        <li><a href="#save-a-search">Save A Search</a></li>
                    </ul>
                </div>
            </div>

            <div class="uk-width-4-5@m uk-width-1-1@s uk-align-center">
                <div class="uk-tile uk-tile-default uk-width-1-1 uk-border-rounded uk-box-shadow-medium uk-box-shadow-hover-large">

                    <div id="selling">
                        <h2 class="uk-heading-bullet">Selling</h2>
                        <ul uk-accordion="multiple: true">
                            <c:forEach var="faq" items="${faqs}">
                                <c:if test="${faq.category == 'SELLING'}">
                                    <li class="uk-width-1-1 uk-align-center">
                                        <a class="uk-accordion-title uk-padding-small" href="#"
                                           style="background-color: #ff695c; border-radius: 5px; color: white">Q: ${faq.question}</a>
                                        <div class="uk-accordion-content" style="text: white">
                                            <h4 class="uk-padding-small">A: ${faq.answer}</h4>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                    <div id="buying">
                        <h2 class="uk-heading-bullet">Buying</h2>
                        <ul uk-accordion="multiple: true">
                            <c:forEach var="faq" items="${faqs}">
                                <c:if test="${faq.category == 'BUYING'}">
                                    <li class="uk-width-1-1 uk-align-center">
                                        <a class="uk-accordion-title uk-padding-small" href="#"
                                           style="background-color: #ff695c; border-radius: 5px; color: white">Q: ${faq.question}</a>
                                        <div class="uk-accordion-content" style="text: white">
                                            <h4 class="uk-padding-small">A: ${faq.answer}</h4>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                    <div id="donation">
                        <h2 class="uk-heading-bullet">Donations</h2>
                        <ul uk-accordion="multiple: true">
                            <c:forEach var="faq" items="${faqs}">
                                <c:if test="${faq.category == 'DONATION'}">
                                    <li class="uk-width-1-1 uk-align-center">
                                        <a class="uk-accordion-title uk-padding-small" href="#"
                                           style="background-color: #ff695c; border-radius: 5px; color: white">Q: ${faq.question}</a>
                                        <div class="uk-accordion-content" style="text: white">
                                            <h4 class="uk-padding-small">A: ${faq.answer}</h4>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                    <div id="freshman-checklist">
                        <h2 class="uk-heading-bullet">Freshman Checklist</h2>
                        <ul uk-accordion="multiple: true">
                            <c:forEach var="faq" items="${faqs}">
                                <c:if test="${faq.category == 'CHECKLIST'}">
                                    <li class="uk-width-1-1 uk-align-center">
                                        <a class="uk-accordion-title uk-padding-small" href="#"
                                           style="background-color: #ff695c; border-radius: 5px; color: white">Q: ${faq.question}</a>
                                        <div class="uk-accordion-content" style="text: white">
                                            <h4 class="uk-padding-small">A: ${faq.answer}</h4>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                    <div id="profile">
                        <h2 class="uk-heading-bullet">Profile</h2>
                        <ul uk-accordion="multiple: true">
                            <c:forEach var="faq" items="${faqs}">
                                <c:if test="${faq.category == 'PROFILE'}">
                                    <li class="uk-width-1-1 uk-align-center">
                                        <a class="uk-accordion-title uk-padding-small" href="#"
                                           style="background-color: #ff695c; border-radius: 5px; color: white">Q: ${faq.question}</a>
                                        <div class="uk-accordion-content" style="text: white">
                                            <h4 class="uk-padding-small">A: ${faq.answer}</h4>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                    <div id="notifications">
                        <h2 class="uk-heading-bullet">Notifications</h2>
                        <ul uk-accordion="multiple: true">
                            <c:forEach var="faq" items="${faqs}">
                                <c:if test="${faq.category == 'NOTIFICATIONS'}">
                                    <li class="uk-width-1-1 uk-align-center">
                                        <a class="uk-accordion-title uk-padding-small" href="#"
                                           style="background-color: #ff695c; border-radius: 5px; color: white">Q: ${faq.question}</a>
                                        <div class="uk-accordion-content" style="text: white">
                                            <h4 class="uk-padding-small">A: ${faq.answer}</h4>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                    <div id="community">
                        <h2 class="uk-heading-bullet">Community</h2>
                        <ul uk-accordion="multiple: true">
                            <c:forEach var="faq" items="${faqs}">
                                <c:if test="${faq.category == 'COMMUNITY'}">
                                    <li class="uk-width-1-1 uk-align-center">
                                        <a class="uk-accordion-title uk-padding-small" href="#"
                                           style="background-color: #ff695c; border-radius: 5px; color: white">Q: ${faq.question}</a>
                                        <div class="uk-accordion-content" style="text: white">
                                            <h4 class="uk-padding-small">A: ${faq.answer}</h4>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                    <div id="save-a-search">
                        <h2 class="uk-heading-bullet">Save A Search</h2>
                        <ul uk-accordion="multiple: true">
                            <c:forEach var="faq" items="${faqs}">
                                <c:if test="${faq.category == 'SAVE_SEARCH'}">
                                    <li class="uk-width-1-1 uk-align-center">
                                        <a class="uk-accordion-title uk-padding-small" href="#"
                                           style="background-color: #ff695c; border-radius: 5px; color: white">Q: ${faq.question}</a>
                                        <div class="uk-accordion-content" style="text: white">
                                            <h4 class="uk-padding-small">A: ${faq.answer}</h4>
                                        </div>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>

</div>

<%@include file="../jspf/footer.jspf" %>

</div>

</body>

</html>