package edu.ben.service;

import edu.ben.model.Conversation;
import edu.ben.model.Message;
import edu.ben.model.User;

import java.util.List;

public interface MessageService {

    public void saveOrUpdate(Conversation conversation);

    public void createConversation(User user1, User user2);

    public List<Conversation> getConversation(User user1);

    public List<Message> getMessages(User user1, User user2);

    public void sendMessage(User user, User sendTo, String message);

    public void sendMessage(User sendFrom, String message, Conversation conversation);

    public int createConversation(Conversation conversation);

    public Conversation getConversationByID(int conversationID);

    public Conversation getMostRecent(User u1, User u2);


}
