<%@include file="admin-header.jsp" %>

<body>

<%@include file="admin-navbar.jsp" %>

<%@include file="../jspf/messages.jsp" %>

<div class="uk-grid uk-margin-top" uk-grid>

    <div class="uk-width-1-4">
        <div class="uk-card uk-card-default uk-card-large uk-margin-small-left uk-card-body">
            <h4 class="uk-card-title uk-text-center">Disputes</h4>
            <ul class="uk-tab-left" uk-tab="connect: #component-tab-left; animation: uk-animation-fade">
                <c:forEach var="dispute" items="${disputes}">
                    <li><a
                            href="#">
                        <!-- If dispute is older than one day show icon -->
                        <c:set var="now" value="<%= new java.sql.Timestamp(System.currentTimeMillis() - 86400000)%>"/>
                        <c:if test="${now.after(dispute.dateCreated)}">
                            <span style="color: red" uk-icon="icon: warning; ratio: 1"></span>
                        </c:if>
                        Accuser: ${dispute.accuser.userID} Defender: ${dispute.defender.userID}
                    </a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="uk-width-3-4">
        <div class="uk-card uk-card-default uk-card-large uk-margin-small-right uk-card-body">
            <div class="uk-grid" uk-grid>
                <h3 class="uk-card-title uk-width-2-3 uk-text-left uk-float-left">Listing Details</h3>
                <h3 class="uk-card-title  uk-width-1-3 uk-float-right">Dispute Details</h3>
            </div>
            <ul id="component-tab-left" class="uk-switcher">
                <c:forEach var="dispute" items="${disputes}">
                    <li class="uk-grid" uk-grid>
                        <a uk-toggle="target: #editModal${dispute.disputeID}" class="uk-padding uk-position-top-right"
                           title="Edit"
                           uk-icon="icon: pencil"></a>
                        <div class="uk-width-2-3">
                            <ul class="uk-grid uk-width-1-2 uk-align-left" uk-grid>
                                <li class="uk-width-1-1"><u style="color: red">Listing ID:</u> ${dispute.listing.id}
                                </li>
                                <li class="uk-width-1-1"><u style="color: red">Defending
                                    User:</u> ${dispute.defender.firstName} ${dispute.defender.lastName}</li>
                                </li>
                                <li class="uk-width-1-1"><u style="color: red">Defending
                                    User Email:</u> ${dispute.defender.schoolEmail}</li>
                                </li>
                                <li class="uk-width-1-1"><u
                                        style="color: red">Name:</u> ${dispute.listing.name}
                                </li>
                                <li class="uk-width-1-1"><u
                                        style="color: red">Description:</u> ${dispute.listing.description}
                                </li>
                                <!--
                                <li class="uk-width-1-1"><u
                                        style="color: red">Rating:</u> Rating
                                </li>
                                -->
                            </ul>
                            <img style="max-height: 300px; max-width: 275px"
                                 src="${pageContext.request.contextPath}/resources/img/listings/${dispute.listing.image_path}"
                                 alt="Listing"/>
                        </div>
                        <div class="uk-width-1-3">
                            <ul class="uk-grid" uk-grid>
                                <li class="uk-width-1-1"><u style="color: red">Dispute ID:</u> ${dispute.disputeID}
                                </li>
                                <li class="uk-width-1-1"><u style="color: red">Accusing
                                    User:</u> ${dispute.accuser.firstName} ${dispute.accuser.lastName}</li>
                                </li>
                                <li class="uk-width-1-1"><u style="color: red">Accusing
                                    User Email:</u> ${dispute.accuser.schoolEmail}</li>
                                </li>
                                <li class="uk-width-1-1"><u
                                        style="color: red">Status:</u> ${dispute.status}
                                </li>
                                <li class="uk-width-1-1"><u
                                        style="color: red">Complaint:</u> ${dispute.complaint}
                                </li>
                            </ul>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="uk-card uk-card-default uk-card-large uk-margin-small-right uk-card-body uk-margin-top">
            <div class="uk-grid" uk-grid>
                <div class="uk-width-4-5 uk-align-center">
                    <h3>Contact Accuser/Defender</h3>
                    <form method="post" action="/contactUser" class="uk-grid" uk-grid>
                        <input class="uk-width-1-2 uk-input" type="text"
                               placeholder="Subject ('Dispute Follow Up' By Default)" name="subject">
                        <div class="uk-width-1-4">
                            <div>
                                <label><input class="uk-radio" type="radio" name="receivingUser" value="accuser"
                                              checked>
                                    Accuser</label>
                            </div>
                            <div>
                                <label><input class="uk-radio" type="radio" name="receivingUser" value="defender">
                                    Defender</label>
                            </div>
                        </div>
                        <div class="uk-width-1-4">
                            <select name="disputeID" class="uk-select" required>
                                <option value="" class="selected">Dispute ID</option>
                                <c:forEach var="dispute" items="${disputes}">
                                    <option value="${dispute.disputeID}">${dispute.disputeID}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <textarea class="uk-textarea" placeholder="Email Body" rows="8" name="message"
                                  required></textarea>
                        <button class="uk-button-large uk-button-primary uk-float-right uk-margin-top"
                                type="submit">
                            Send
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<c:forEach var="dispute" items="${disputes}">
    <div id="editModal${dispute.disputeID}" uk-modal>
        <div class="uk-modal-dialog uk-modal-body">
            <h4 class="uk-modal-title">Edit Dispute (ID ${dispute.disputeID})</h4>
            <form method="post" action="/editDispute" class="uk-grid-small" uk-grid>

                <label class="uk-form-label uk-width-1-1">Dispute Status</label>
                <select class="uk-select" name="newStatus">
                    <option class="selected" value="${dispute.status}">${dispute.status}</option>
                    <option value="IN PROGRESS">IN PROGRESS</option>
                    <option value="AWAITING USER RESPONSE">AWAITING USER RESPONSE</option>
                    <option value="RESOLVED">RESOLVED</option>
                </select>

                <label class="uk-form-label uk-width-1-1">Dispute Status</label>
                <textarea class="uk-width-1-1 uk-input" rows="5" name="newComplaint">${dispute.complaint}</textarea>

                <input type="hidden" value="${dispute.disputeID}" name="disputeID">

                <div class="uk-modal-footer uk-width-1-1">
                    <button class="uk-button uk-button-primary uk-float-right" type="submit">Submit
                    </button>
                    <button class="uk-modal-close uk-button uk-button-default uk-float-left" type="button">Close
                    </button>
                </div>
            </form>
        </div>
    </div>
</c:forEach>

</body>
</html>