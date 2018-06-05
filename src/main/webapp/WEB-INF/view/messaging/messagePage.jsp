<%--
  Created by IntelliJ IDEA.
  User: saran
  Date: 2/6/18
  Time: 9:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@include file="../jspf/header.jsp" %>
<%@include file="../jspf/navbar.jspf" %>
<%@ page import="edu.ben.model.Conversation" %>
<%@ page import="java.util.List" %>
<%@ page import="edu.ben.model.Message" %>
<%@ page import="edu.ben.model.User" %>
<body>
<div class="uk-section uk-section-muted">
    <div class="uk-container">
        <h1>Chat with: ${conversationUser.username}</h1>
        <script>
            jQuery(document).ready(function($){
                    $.ajax({
                        url: 'getMessages',
                        type: 'POST',
                        dataType: 'json',
                        data: { "user1" : "${sessionScope.user.schoolEmail}", "user2" : "${sessionScope.sendTo.schoolEmail}" },
                        success: function(){


                        }
                        }



                    )
            })
        </script>
        <div class="uk-grid uk-child-width-1-2\@l uk-position-center uk-card">
            <div class="uk-panel uk-panel-scrollable uk-overflow-auto ">
                <div class="uk-description-list uk-description-list-divider">
                    <%
                        List<Message> msgs = (List<Message>) session.getAttribute("messages");
                        User sessionUser = (User) session.getAttribute("user");
                        System.out.println(msgs.toString());
                        if (msgs == null || msgs.isEmpty()) {
                    %>
                    <dt></dt>
                    <dd>No messages to show</dd>
                    <%
                        } else {

                        for (int i = 0; i < msgs.size(); i++) {
                    %>
                    <dt><%=msgs.get(i).getUser().getUsername()%>
                    </dt>
                    <dd><%=msgs.get(i).getMessageBody()%>
                    </dd>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
            </br>
            <form method="post" action="sendMessage">
                <input class="uk-input uk-form-width-large" type="text" placeholder="Send Message" name="stringMessage">
                <button class="uk-button uk-button-primary" type="submit" value="${conversationUser.schoolEmail}" name="SubmitMessage">Send</button>
            </form>
        </div>
    </div>
</div>
</body>
