<%@include file="jspf/header.jsp" %>
<body>
<%@include file="jspf/navbar.jspf" %>

<br>
<br>
<br>
<div class="uk-container">
    <h1 class="uk-text-center">All Articles</h1>
    <div class="uk-child-width-expand@s" uk-grid  style="overflow:auto; height:400px;">
        <div class="uk-width-1-1">
            <table class="uk-table uk-table-small uk-table-divider">
                <thead>
                <tr>
                    <th>Article Header</th>
                    <th>Description</th>
                    <th>Date Created</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach var="article" items="${allArticles}" varStatus="loop">
                    <tr>

                        <td style="color: black; font-size: 24px;"><a
                                href="${pageContext.request.contextPath}/viewNews?newsID=${article.newsID}">${article.title}</a>
                        </td>
                        <td style="color: black; font-size: 24px;">${article.description}</td>
                        <td style="color: black; font-size: 24px;">${article.getDateCreated().toString()}</td>
                    </tr>
                </c:forEach>


                </tbody>
            </table>

        </div>
    </div>
    <br>
    <br>

</div>
</body>
</html>
