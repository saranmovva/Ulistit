<%@include file="jspf/header.jsp" %>
<body>
<div class="homepage-tutorial" style="border: 20px solid white;
            margin: 0 auto;
            background: white;">
    <%@include file="jspf/navbar.jspf" %>

    <div class="uk-cover-container uk-height-large uk-border-rounded">
        <img src="${pageContext.request.contextPath}/resources/img/community-header.jpg"
             uk-cover>
        <div class="uk-overlay-primary uk-position-cover"></div>
        <div class="uk-position-center">
            <h1 class="uk-text-uppercase" style="color: white;">Welcome To Our Community Page</h1>
        </div>
    </div>
    <div class="community-main">
        <div uk-grid>
            <div class="uk-width-2-3@s">
                <div class="uk-section-default uk-padding-small">
                    <h2 class="uk-heading-bullet">Headline Stories</h2>
                    <hr>

                    <div class="uk-position-relative uk-visible-toggle uk-light"
                         uk-slideshow="animation: scale">
                        <ul class="uk-slideshow-items">
                            <c:forEach var="i" items="${displayArticles}" begin="0" end="2" step="1" varStatus="loop">

                                <li class="uk-border-rounded">
                                    <img alt=""
                                         src="${pageContext.request.contextPath}/directory/${i.imagePath}"
                                         uk-cover>
                                    <div class="uk-overlay uk-overlay-primary uk-position-top">
                                        <p class="uk-text-center">${displayArticles.get(loop.index).description} ... <a
                                                href="${pageContext.request.contextPath}/viewNews?newsID=${i.newsID}">View
                                            more</a></p>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>

                        <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#"
                           uk-slidenav-previous uk-slideshow-item="previous"></a>
                        <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#"
                           uk-slidenav-next
                           uk-slideshow-item="next"></a>

                    </div>

                </div>
            </div>
            <div class="uk-width-1-3@s">
                <div class="uk-section-default uk-padding-small">
                    <h3 class="uk-heading-bullet">Benedictine Tweets</h3>
                    <hr>

                    <div class="uk-background-default uk-panel uk-border-rounded">
                        <div clas="uk-display-inline-block">
                            <div id="" style="overflow:auto; height:400px;">
                                <a class="twitter-timeline"
                                   href="https://twitter.com/benu1887">
                                    Tweets by @BenU1887
                                </a>
                                <a class="twitter-timeline" href="https://twitter.com/BenU1887?ref_src=twsrc%5Etfw">Tweets
                                    by
                                    BenU1887</a>
                                <script async src="https://platform.twitter.com/widgets.js"
                                        charset="utf-8"></script>
                            </div>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- BEGIN CONTENT WRAPPER -->
    <div class="community-sub1">
        <div uk-grid>
            <div class="uk-width-2-3@s">
                <h3 class="uk-heading-bullet">Featured Stories  <span style="font-size: 14px;"><a href="${pageContext.request.contextPath}/allArticles"> View All</a></span></h3></h3>
                <hr>
                <div uk-grid>
                    <c:forEach var="i" items="${displayArticles}" begin="3" end="4" step="1" varStatus="loop">

                        <div class="uk-width-1-2@s">
                            <div class="uk-container uk-inline">
                                <div class="uk-border-rounded uk-display-inline"
                                     style="height: 250px; width: 320px; overflow: hidden">
                                    <img alt=""
                                         src="${pageContext.request.contextPath}/directory/${i.imagePath}">
                                </div>
                                <p class="uk-text-center">${displayArticles.get(loop.index).description} ... <a href="${pageContext.request.contextPath}/viewNews?newsID=${i.newsID}">View
                                    more</a></p>
                            </div>
                        </div>
                    </c:forEach>

                </div>

                <br>
                <div uk-grid>
                    <c:forEach var="i" items="${displayArticles}" begin="5" end="6" step="1" varStatus="loop">
                        <div class="uk-width-1-2@s ">
                            <div class="uk-container uk-inline">
                                <div class="uk-border-rounded uk-display-inline"
                                     style="height: 250px; width: 320px; overflow: hidden">
                                    <img alt=""
                                         src="${pageContext.request.contextPath}/directory/${i.imagePath}">
                                </div>
                                <p class="uk-text-center">${displayArticles.get(loop.index).description} ... <a href="${pageContext.request.contextPath}/viewNews?newsID=${i.newsID}">View
                                    more</a></p>

                            </div>
                        </div>
                    </c:forEach>
                </div>

            </div>
            <div class="uk-width-1-3@s">
                <div class="uk-background-default uk-panel uk-border-rounded" style="">
                    <div clas="uk-display-inline-block">
                        <h3 class="uk-heading-bullet">Benedictine Events</h3>
                        <hr>
                        <div class="uk-card uk-card-default uk-card-body uk-background-muted">
                            <c:forEach var="events" items="${events}" varStatus="loop">

                                <div uk-grid>
                                    <div class="uk-width-2-5">
                                        <time datetime="2014-09-24" class="date-as-calendar position-em size1x">
                                            <span class="weekday">${day.get(loop.index)}</span>
                                            <span class="day">${date.get(loop.index)}</span>
                                            <span class="month">${month.get(loop.index)}</span>
                                            <span class="year">${year.get(loop.index)}</span>
                                        </time>
                                    </div>
                                    <div class="uk-width-3-5">
                                        <div style="font-weight: 300; font-size: 1.00rem"
                                             class="uk-text-lead uk-text-bold">${events.title}
                                        </div>
                                        <div style="font-weight: 300; font-size: 0.75rem">${events.location}</div>

                                        <div style="font-weight: 300; font-size: 0.80rem">${time.get(loop.index)}</div>
                                    </div>
                                </div>
                            </c:forEach>
                            <br>
                        </div>
                        <br>
                    </div>
                </div>
            </div>
        </div>
        <div class="videos">
            <h3 class="uk-heading-bullet">Videos <span style="font-size: 14px;"><a href="${pageContext.request.contextPath}/allVideos"> View All</a></span></h3>
            <hr>

            <div class="uk-child-width-1-2@m uk-grid-small uk-grid-match" uk-grid>
                <div>
                    <iframe width="560" height="315" src="${displayVideos.get(0).getVideoPath()}" frameborder="0"
                            allow="autoplay; encrypted-media" allowfullscreen></iframe>
                    <br>
                    <h2><a href="#">${newestVideo.title}</a></h2>
                    <p class="author"><span>${videoDate}</span></p>
                </div>
                <div>
                    <iframe width="560" height="315" src="${displayVideos.get(1).getVideoPath()}" frameborder="0"
                            allow="autoplay; encrypted-media" allowfullscreen></iframe>

                    <br>
                    <h2><a href="#">${newestVideo.title}</a></h2>
                    <p class="author"><span>${videoDate}</span></p>
                </div>
            </div>
        </div>
    </div>

    <%@include file="jspf/footer.jspf" %>
</div>

</body>
</html>