package edu.ben.controller;

import com.google.api.client.json.Json;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import edu.ben.model.Conversation;
import edu.ben.model.Message;
import edu.ben.model.PickUp;
import edu.ben.model.User;
import edu.ben.service.MessageService;
import edu.ben.service.PickUpService;
import edu.ben.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpOutputMessage;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class MessageController extends BaseController {
    @Autowired
    MessageService messageService;

    @Autowired
    UserService userService;

    @Autowired
    PickUpService pickUpService;

    @RequestMapping(value = "/message", method = RequestMethod.GET)
    public String messageDashboard(HttpServletRequest request) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        List<Conversation> conversations = messageService.getConversation(sessionUser);
        request.getSession().setAttribute("userConversations", conversations);
        return "messaging/messageDashboard";
    }

    @RequestMapping(value = "/generateConversation", method = RequestMethod.GET)
    public String generateConversation(HttpServletRequest request) {
        List<User> allUsers = userService.getRecentUsers();
        User sessionUser = (User) request.getSession().getAttribute("user");
        allUsers.remove(sessionUser);
        request.getSession().setAttribute("allUsers", allUsers);
        return "messaging/createConversation";
    }

    @RequestMapping(value = "/addConversation", method = RequestMethod.POST)
    public String addConversation(HttpServletRequest request) {
        User sendBy = (User) request.getSession().getAttribute("user");
        User sendTo = userService.findBySchoolEmail(request.getParameter("generateConversation"));
        System.out.println(sendBy.getUserID());
        System.out.println(sendTo.getUserID());
        Conversation input = new Conversation(sendBy, sendTo);
        messageService.saveOrUpdate(input);
        return "redirect:/message";
    }

    @RequestMapping(value = "viewConversation", method = RequestMethod.POST)
    public String viewConversation(HttpServletRequest request) {
        User sendBy = (User) request.getSession().getAttribute("user");
        User sendTo = userService.findBySchoolEmail(request.getParameter("UserConversation"));
        List<Message> messages = messageService.getMessages(sendBy, sendTo);
        request.getSession().setAttribute("messages", messages);
        request.getSession().setAttribute("conversationUser", sendTo);
        return "messaging/messagePage";
    }
    /*
    @RequestMapping(value = "sendMessage", method = RequestMethod.POST)
    public String sendMessage(HttpServletRequest request) {
        User sendBy = (User) request.getSession().getAttribute("user");
        User sendTo = userService.findBySchoolEmail(request.getParameter("SubmitMessage"));
        String message = request.getParameter("stringMessage");
        messageService.sendMessage(sendBy, sendTo, message);
        List<Message> messages = messageService.getMessages(sendBy, sendTo);
        request.getSession().setAttribute("messages", messages);
        request.getSession().setAttribute("conversationUser", sendTo);
        return "messaging/messagePage";
    }
    */

    @RequestMapping(value = "getConversation", method = RequestMethod.GET, produces="application/json")
    public @ResponseBody String getConversation(HttpServletRequest request) {
        User sessionUser = (User) request.getSession().getAttribute("user");
        List<Conversation> conversations = messageService.getConversation(sessionUser);

        JsonArray result = new JsonArray();
        for(int i =0; i < conversations.size(); i++){
            JsonObject addJson = new JsonObject();
            addJson.addProperty("conversationId", String.valueOf(conversations.get(i).getId()));
            addJson.addProperty("user1Id", String.valueOf(conversations.get(i).getUser1().getUserID()));
            addJson.addProperty("user1FirstName", (conversations.get(i).getUser1().getFirstName()));
            addJson.addProperty("user1LastName", (conversations.get(i).getUser1().getLastName()));
            addJson.addProperty("user1Username", (conversations.get(i).getUser1().getUsername()));
            addJson.addProperty("user1SchoolEmail", (conversations.get(i).getUser1().getSchoolEmail()));
           // addJson.addProperty("user1ProfilePic", (conversations.get(i).getUser1().getMainImage().toString()));

            addJson.addProperty("user2Id", String.valueOf(conversations.get(i).getUser2().getUserID()));
            addJson.addProperty("user2FirstName", (conversations.get(i).getUser2().getFirstName()));
            addJson.addProperty("user2LastName", (conversations.get(i).getUser2().getLastName()));
            addJson.addProperty("user2Username", (conversations.get(i).getUser2().getUsername()));
            addJson.addProperty("user2SchoolEmail", (conversations.get(i).getUser2().getSchoolEmail()));
            //addJson.addProperty("user2ProfilePic", (conversations.get(i).getUser2().getMainImage().toString()));

            addJson.addProperty("timestamp", conversations.get(i).getDateCreated().toString());
            result.add(addJson);
        }
        return result.toString();
    }

    @RequestMapping(value="getMessages", method = RequestMethod.GET, produces="application/json")
    public @ResponseBody String getMessages(HttpServletRequest request, @RequestParam("schoolEmail") String email){
        System.out.println(email);
        User sendBy = (User) request.getSession().getAttribute("user");
        User sendTo = userService.findBySchoolEmail(email);
        List<Message> messages = messageService.getMessages(sendBy, sendTo);
        if(messages != null || !messages.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < messages.size(); i++) {
                JsonObject addJson = new JsonObject();
                addJson.addProperty("Username", (messages.get(i).getUser().getUsername()));
                addJson.addProperty("UserFirstName", (messages.get(i).getUser().getFirstName()));
                addJson.addProperty("UserLastName", (messages.get(i).getUser().getLastName()));
                addJson.addProperty("UserId", String.valueOf(messages.get(i).getUser().getUserID()));
                addJson.addProperty("messageBody", (messages.get(i).getMessageBody()));
                addJson.addProperty("dateSent", String.valueOf(messages.get(i).getDateSent()));
                addJson.addProperty("conversationId", String.valueOf(messages.get(i).getConversationId()));
                result.add(addJson);
            }
            return result.toString();
        }
        return null;
    }

    @RequestMapping(value="sendMessages", method= RequestMethod.POST, consumes={MediaType.APPLICATION_JSON_VALUE})
    public String sendMessages(HttpServletRequest request, @RequestBody String data){
        System.out.println(data);
        System.out.println("Hit Send message controller");
        return"redirect:/message";
    }

}
