<%@include file="jspf/header.jsp" %>
<body>
<%@include file="jspf/navbar.jspf" %>

<br>
<br>
<br>
<div class="uk-container">
    <legend class="uk-legend uk-text-primary uk-text-bold">All Videos</legend>

    <div class="uk-child-width-expand@s" uk-grid>
        <c:forEach var="videos" items="${allVideos}" varStatus="loop">
            <div class="uk-width-1-3">
                <div id="main">
                    <div id="headlines">
                        <div id="main-headline">
                            <div class="video">
                                <iframe width="380" height="250" src="${videos.videoPath}" frameborder="0"
                                        allow="autoplay; encrypted-media" allowfullscreen></iframe>
                            </div>
                            <h2><a href="#">${videos.title}</a></h2>
                            <p class="author"><span>${allDates.get(loop.index)}</span></p>
                        </div>
                    </div>
                </div>


            </div>
        </c:forEach>
    </div>

</div>
</body>
</html>
