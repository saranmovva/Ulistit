<%--
  Created by IntelliJ IDEA.
  User: saran
  Date: 2/4/18
  Time: 9:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@include file="../jspf/header.jsp" %>
<%@include file="../jspf/navbar.jspf" %>
<%@ page import="edu.ben.model.Conversation" %>
<%@ page import="edu.ben.model.User" %>
<%@ page import="java.util.List" %>
<body>
<div class="uk-section uk-section-muted">
    <div class="uk-container">
        <h1>Messages</h1>
        <div class="uk-grid uk-child-width-1-1\@m">
            <div>
                <button id="chatModal" class="uk-button uk-button-default" type="button" uk-toggle="target: #chat-offcanvas">Side Chat</button>
            </div>
        </div>
    </div>
</div>
<script>

    var refreshConversation;

    refreshConversation = setInterval(function () {
        $('#chat-offcanvas').empty();
        updateConversation();
    }, 10000);

    jQuery(document).ready(updateConversation());

    function updateConversation(){
        $.ajax({
            url: 'getConversation',
            type: 'GET',
            dataType: 'json',
            contentType: 'application/json',
            success: function(result){
                var sessionUser = ${sessionScope.user.userID};
                var text = "";
                text += '<div class="uk-offcanvas-bar">'+
                    '<ul class="uk-nav uk-nav-default">'+
                    '<li>'+
                    '<form class="uk-search uk-search-default">'+
                    '<input class="uk-search-input uk-border-rounded" style="width:100%;" type="search" placeholder="Search Users">'+
                    '<a href="" uk-search-icon></a>'+
                    '</form>'+
                    '</li>'+
                    '<hr class="uk-divider">';
                for(var key in result){
                    text +=  '<li>'+
                        '<div class="uk-card uk-card-default uk-width-1-3\@l" style="background: rgba(34,34,34,0.85);">' +
                        '<div class="uk-card-header">' +
                        '<div class="uk-grid-small uk-flex-middle" uk-grid>' +
                        '<div class="uk-width-auto">' +
                        '<img class="uk-border-rounded" width="40" height="40" src="">' +
                        '</div>' +
                        '<div class="uk-width-expand"> ';

                    if(sessionUser == result[key].user1Id ){
                        text += '<h4 class="uk-card-title uk-margin-remove-bottom uk-text-muted">' + result[key].user2Username + '</h4>'+
                            '<p class="uk-text-meta uk-margin-remove-top uk-text-muted">' + result[key].user2FirstName + ' ' + result[key].user2LastName +'</p>'+
                            '</div>'+
                            '<div>'+
                            '<button uk-icon="icon: comment" value="' + result[key].user2SchoolEmail + '" onClick="getMessage(this.value)"></button>';
                    }
                    else{
                        text += '<h4 class="uk-card-title uk-margin-remove-bottom uk-text-muted">' + result[key].user1Username +'</h4>'+
                            '<p class="uk-text-meta uk-margin-remove-top uk-text-muted">'+ result[key].user1FirstName + ' ' + result[key].user1LastName +'</p>'+
                            '</div>'+
                            '<div>'+
                            '<button  uk-icon="icon: comment" value="'+ result[key].user1SchoolEmail + '" onClick="getMessage(this.value)"></button>';
                    }
                    text +=
                        '</div>'+
                        '</div>'+
                        '</div>'+
                        '</div>'+

                        '</li>'+
                        '<hr class="uk-divider">';
                }
                text += '</ul>' + '</div>';
                $('#chat-offcanvas').append(text);
            }
        });
    }



    function getMessage(email){
        console.log(email);
        $.ajax({
            url: 'getMessages',
            type: 'GET',
            data:{schoolEmail:email},
            dataType: 'json',
            contentType: 'application/json',
            success: function (result) {
                var sessionUser = ${sessionScope.user.userID};
                var text = "";
                text +=  '<div class="uk-offcanvas-bar">'+
                    '<a onClick="updateConversation();"><span uk-icon="icon: reply"></span></a>'+
                    '<div class="uk-card uk-card-default uk-border-rounded uk-margin-large-top uk-panel-scrollable uk-margin-small-left uk-margin-small-right uk-height-max-large" style="height:100%;">'+
                    '<div class="uk-card-body uk-padding-small">';
                if(result == null || result == ""){
                    text = '<p> No Messages have been sent between you two</p>';
                }else{

                    for (var key in result) {
                        console.log(result[key]);
                        if(sessionUser == result[key].UserId){
                            text += '<div class="me uk-grid-small uk-flex-bottom uk-flex-right uk-text-right" uk-grid>'+
                                '<div class="uk-width-auto uk-margin-remove">'+
                                '<div class="uk-card uk-card-body uk-card-small uk-card-primary uk-border-rounded">'+
                                '<div class="uk-panel uk-panel-box uk-text-break uk-margin-remove">'+ result[key].messageBody +'</div>'+
                                '</div>'+
                                '<div class="uk-text-small">'+ result[key].dateSent +'</div>'+
                                '<div class="uk-width-auto">'+
                                '<img class="uk-border-circle" width="32" height="32" src="https://getuikit.com/docs/images/avatar.jpg">'+
                                '</div>'+
                                '</div>'+
                                '</div>';
                        }else{
                            text+= '<div class="guest uk-grid-small uk-flex-bottom uk-flex-left" uk-grid>'+
                                '<div class="uk-width-auto">'+
                                '<div class="uk-width-auto uk-margin-remove">'+
                                '<img class="uk-border-circle" width="32" height="32" src="https://getuikit.com/docs/images/avatar.jpg">'+
                                '</div>'+
                                '<div class="uk-card uk-card-body uk-card-small uk-card-default uk-border-rounded">'+
                                '<div class="uk-panel uk-panel-box uk-text-break uk-margin-remove">'+ result[key].messageBody +'</div>'+
                                '</div>'+
                                '<div class="uk-text-small">'+ result[key].dateSent +'</div>'+
                                '</div>'+
                                '</div>';
                        }
                    }
                }
                text += '</div>'+ '</div>'+
                    '<div class="uk-card-footer uk-padding-remove">'+
                    '<form id="messageSend" method="POST" action="sendMessages">'+
                    '<div class="uk-grid-small uk-flex-middle" uk-grid>'+
                    '<div class="uk-width-expand">'+
                    '<div class="uk-padding-small uk-padding-remove-horizontal">'+
                    '<input name="messageBody" class="uk-input uk-width-1-1 uk-padding-remove uk-border-remove" rows="1" placeholder="Send a Message"></input>'+
                    '<input name="sendEmail" value="'+ email +'" hidden></input>'+
                    '</div>'+
                    '</div>'+
                    '<div class="uk-width-auto">'+
                    '<button name="sendMessage" class="uk-button-primary" type="submit" >Send</button>'+
                    '</div>'+
                    '</div>'+
                    '</form>'+
                    '</div>'+
                    '</div>'+
                    '</div>';

                $('#chat-offcanvas').empty();
                $('#chat-offcanvas').append(text);
                clearInterval(refreshConversation);
            }

        });
    }


    $('#messageSend').submit(function(event) {
        event.preventDefault();
        var data =.serialize();
        console.log(form.serialize());
        $.ajax({
            type: 'POST',
            url: 'sendMessages',
            data: JSON.stringify(data),
            contentType: 'application/json'
        }).done(function(data) {

        }).fail(function(data) {

        });
        return false;
    });



</script>
<hr class="uk-divider-icon">
<div class="uk-section uk-section-muted">
    <div class="uk-container">
        <div class="uk-child-width-expand@s" uk-grid>
            <div>
                <%
                    List<Conversation> conversations = (List<Conversation>) session.getAttribute("userConversations");
                    User usr = (User) session.getAttribute("user");
                    if (conversations != null && !conversations.isEmpty()) {
                        for (int i = 0; i < conversations.size(); i++) {
                %>

                </html>
                <form method="post" action="viewConversation">
                    <div class="uk-card uk-card-default uk-card-body">
                        <span uk-icon="icon: user; ratio: 1.5"></span>
                        <%
                            if (conversations.get(i).getUser1().getUserID() == usr.getUserID()) {
                        %>
                        <span><%=conversations.get(i).getUser2().getUsername()%></span>
                        <button class="uk-button uk-button-default uk-position-right"
                                value="<%=conversations.get(i).getUser2().getSchoolEmail()%>" name="UserConversation"
                                type="submit">
                            Message
                        </button>
                        <%
                        }else if (conversations.get(i).getUser2().getUserID() == usr.getUserID()) {
                        %>
                        <span><%=conversations.get(i).getUser2().getUsername()%></span>
                        <button class="uk-button uk-button-default uk-position-right"
                                value="<%=conversations.get(i).getUser1().getSchoolEmail()%>" name="UserConversation"
                                type="submit">
                            Message
                        </button>
                        <%
                            }
                        %>
                    </div>
                </form>

                <%
                        }

                    }
                %>
            </div>
            <div>
                <div class="uk-card uk-card-default uk-card-body">
                    <button class="uk-button uk-position-center"
                            href="${pageContext.request.contextPath}/generateConversation">
                        <span uk-icon="icon: plus-circle; ratio: 2" class="uk-position-center"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="chat-offcanvas" uk-offcanvas="flip: true" class="uk-background-muted">

</div>

<div id="view-Message" uk-offcanvas="flip: true" class="uk-background-muted">
    <div class="uk-offcanvas-bar">
        <a onClick="updateConversation();"><span uk-icon="icon: reply"></span></a>
        <h2>Username</h2>
        <hr class="uk-divider">
        <div class="uk-card uk-card-default uk-border-rounded uk-margin-large-top uk-panel-scrollable uk-margin-small-left uk-margin-small-right uk-height-max-large" style="height:100%;">
            <div class="uk-card-body uk-padding-small">

                <div class="guest uk-grid-small uk-flex-bottom uk-flex-left" uk-grid>
                    <div class="uk-width-auto">
                        <div class="uk-width-auto uk-margin-remove">
                            <img class="uk-border-circle" width="32" height="32" src="https://getuikit.com/docs/images/avatar.jpg">
                        </div>
                        <div class="uk-card uk-card-body uk-card-small uk-card-default uk-border-rounded">
                            <div class="uk-panel uk-panel-box uk-text-break uk-margin-remove">Wassup whats going on Home whats up</div>
                        </div>
                        <div class="uk-text-small">10:50 AM</div>

                    </div>
                </div>

                <div class="me uk-grid-small uk-flex-bottom uk-flex-right uk-text-right" uk-grid>
                    <div class="uk-width-auto uk-margin-remove">
                        <div class="uk-card uk-card-body uk-card-small uk-card-primary uk-border-rounded">
                            <div class="uk-panel uk-panel-box uk-text-break uk-margin-remove">Hey whats going on home. What you doing? </div>
                        </div>
                        <div class="uk-text-small">10:50 AM</div>
                        <div class="uk-width-auto">
                            <img class="uk-border-circle" width="32" height="32" src="https://getuikit.com/docs/images/avatar.jpg">
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="uk-card-footer uk-padding-remove">
            <div class="uk-grid-small uk-flex-middle" uk-grid>
                <div class="uk-width-expand">
                    <div class="uk-padding-small uk-padding-remove-horizontal">
                        <input class="uk-input uk-width-1-2 uk-padding-remove uk-border-remove" rows="1" placeholder="Send a Message"></input>
                    </div>
                </div>
                <div class="uk-width-auto">
                    <button id="sendMessage" class="uk-button-primary" value="" name="">Send</button>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
