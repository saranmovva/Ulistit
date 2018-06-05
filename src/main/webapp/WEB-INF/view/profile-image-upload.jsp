<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="jspf/header.jsp" %>

<body class="uk-background-muted">

<%@include file="jspf/navbar.jspf" %>

<%@include file="jspf/messages.jsp" %>

<div class="uk-grid uk-margin-large-bottom" uk-grid>
    <div class="uk-width-2-5 uk-align-center">
        <div class="uk-card uk-card-default uk-card-body uk-margin-large uk-padding-large">
            <h3>Profile Image</h3>
            <form action="changeImageMain" method="post">
            <div class="uk-section-muted">
            <ul class="uk-thumbnav" uk-margin>
                <c:forEach items="${user.profileImages}" var="images">
                    <C:if test="${images.main == 0}">
                        <li><img class="uk-border-rounded" src="${pageContext.request.contextPath}/directory/${images.image_path}/${images.image_name}" width="100" alt=""> <input class="uk-radio" type="radio" name="mainImage" value="${images.id}"></li>
                    </C:if>
                    <C:if test="${images.main == 1}">
                        <li class="uk-active"><img class="uk-border-rounded" src="${pageContext.request.contextPath}/directory/${images.image_path}/${images.image_name}" width="100" alt=""> <input class="uk-radio" type="radio" name="mainImage" value="${images.id}" checked="checked"></li>
                    </C:if>
                </c:forEach>
            </ul>
            </div>
            <button type="submit" class="uk-button uk-button-primary uk-border-rounded uk-float-right">Change Image
            </button>
            </form>
            <br>
            <br>
            <br>

            <form action="profileImageUpload"
                  method="post" enctype="multipart/form-data">
                <div class="uk-width-1-1 uk-margin-small">
                    <strong>File to upload:</strong> <input id="image" type="file" name="file" required/>
                    <span class="val_error" id="image_error"></span>
                </div>
                <div class="uk-width-1-1 uk-margin-small">
                    <strong>Set as main:</strong> <input class="uk-checkbox" type="checkbox" name="imageMain" value="yes">
                </div>
                <div class="uk-width-1-1 uk-margin-small">
                    <button type="submit" class="uk-button uk-button-primary uk-border-rounded uk-float-right">Upload
                    </button>
                    <br>
                    <br>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<%@include file="jspf/footer.jspf" %>
</html>
