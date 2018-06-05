<%--
  Created by IntelliJ IDEA.
  User: saran
  Date: 2/5/18
  Time: 6:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@include file="../jspf/header.jsp" %>
<%@include file="../jspf/navbar.jspf" %>
<%@ page import="edu.ben.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="edu.ben.model.Conversation" %>
<body>
<div class="uk-section uk-section-muted">
    <div class="uk-container">
        <h1>Message User</h1>
        <div class="uk-grid uk-child-width-1-1\@m">
            <div>

            </div>
        </div>
    </div>
</div>
<hr class="uk-divider-icon">
<div class="uk-section uk-section-muted">
    <div class="uk-container">
        <div class="uk-child-width-expand\@s" uk-grid>
            <%
                List<User> users = (List<User>) session.getAttribute("allUsers");
                User sessionUser = (User) session.getAttribute("user");
                List<Conversation> conversations = (List<Conversation>)session.getAttribute("userConversations");
                for(int i = 0; i < users.size(); i++){
                    Conversation temp = new Conversation(sessionUser, users.get(i));
                    if(users.get(i).getUserID() != sessionUser.getUserID() && !conversations.contains(temp)){
            %>
            <div>
                <form method="post" action="addConversation">
                    <div class="uk-card uk-card-default uk-card-body">
                        <label>Username:</label><span><%=users.get(i).getUsername()%></span><p></p>
                        <label>First Name:</label><span><%=users.get(i).getFirstName()%></span><p></p>
                        <label>Last Name:</label><span><%=users.get(i).getLastName()%></span><p></p>
                        <button class="uk-button uk-button-default uk-position-right" value="<%=users.get(i).getSchoolEmail()%>" name="generateConversation"
                                type="submit">
                            Send Message
                        </button>
                    </div>
                </form>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</div>

</body>
