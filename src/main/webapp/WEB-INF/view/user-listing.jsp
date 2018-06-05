<%@include file="jspf/header.jsp" %>

<body>

<%@include file="jspf/navbar.jspf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
<br>
<div class="col-lg-12 col-sm-12">
    <div class="card hovercard">
        <div class="card-background">
            <img class="card-bkimg" alt=""
                 src="<%=request.getContextPath()%>/resources/img/profile-pic/default.jpeg">
        </div>
        <div class="useravatar">
            <a href="#editProfilePic${user.userID}" data-toggle="modal"
               data-target="#editProfilePic${user.userID}"><span
                    data-toggle="tooltip" data-placement="right"> <img alt=""
                                                                       src="<%=request.getContextPath()%>/resources/img/profile-pic/default.jpeg"></span></a>
        </div>
        <div class="card-info">
            <span class="card-title">${user.username}</span>

        </div>
    </div>
    <%@include file="jspf/editProfilePic.jspf" %>

    <div class="btn-pref btn-group btn-group-justified btn-group-lg"
         role="group" aria-label="...">
        <div class="btn-group" role="group">
            <button type="button" id="stars" class="btn btn-primary"
                    href="#tab1" data-toggle="tab">
                <span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                <div class="hidden-xs">Your Listings</div>
            </button>
        </div>
        <div class="btn-group" role="group">
            <button type="button" id="favorites" class="btn btn-default"
                    href="#tab2" data-toggle="tab">
                <span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                <div class="hidden-xs">Your Bids</div>
            </button>
        </div>
        <div class="btn-group" role="group">
            <button type="button" id="following" class="btn btn-default"
                    href="#tab3" data-toggle="tab">
                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                <div class="hidden-xs">Watching</div>
            </button>
        </div>
    </div>

    <div class="well">
        <div class="tab-content">
            <div class="container tab-pane fade in active" id="tab1">
                <hr>
                <div class="row row-margin-bottom">
                    <c:forEach var="listing" items="${userListings}">
                        <c:if test="${listing.active == 1}">
                            <div class="col-md-5 no-padding lib-item" data-category="view">
                                <div class="lib-panel">
                                    <div class="row box-shadow">
                                        <div class="col-md-6">
                                            <img class="lib-img-show"
                                                 src="<%=request.getContextPath()%>/resources/img/listings/DDJSR_2.jpg"
                                                 style="height: 1200; width: 1200;">
                                        </div>
                                        <div class="col-md-6">
                                            <div class="lib-row lib-header" style="font-size: 14px;">
                                                <a href="#"><strong>${listing.name}</strong></a><a
                                                    href="#editListings${listing.id}" data-toggle="modal"
                                                    data-target="#editListing${listing.id}"><span
                                                    class="pull-right glyphicon glyphicon-edit"
                                                    data-toggle="tooltip" data-placement="right"> </span></a>
                                            </div>
                                            <div class="lib-row lib-desc" style="font-size: 16px;">
                                                <strong>$${listing.price}</strong>
                                            </div>
                                            <div class="lib-row lib-desc"></div>
                                        </div>
                                    </div>
                                </div>
                                <%@include file="jspf/editListing.jspf" %>
                            </div>
                            <div class="col-md-1"></div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="tab-pane fade in" id="tab2">
                <%@include file="profile-bid-section.jsp" %>
            </div>
            <div class="tab-pane fade in" id="tab3"></div>
        </div>

    </div>
</div>
</body>

<script type="text/javascript">
    $(document).ready(
        function () {
            $(".btn-pref .btn").click(
                function () {
                    $(".btn-pref .btn").removeClass("btn-primary")
                        .addClass("btn-default");
                    // $(".tab").addClass("active"); // instead of this do the below
                    $(this).removeClass("btn-default").addClass(
                        "btn-primary");
                });
        });
</script>
<%@include file="jspf/footer.jspf" %>
</html>