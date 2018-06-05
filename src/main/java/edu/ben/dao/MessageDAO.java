package edu.ben.dao;

import edu.ben.model.Conversation;
import edu.ben.model.Message;
import edu.ben.model.User;

import java.util.List;

public interface MessageDAO {

    public void saveOrUpdate(Conversation conversation);

    public void createConversation(int user1, int user2);

    public int createConversation(Conversation conversation);

    public List<Conversation> getConversation(int user1);

    public List<Message> getMessages(int user1, int user2);

    public void sendMessage(int user1, int user2, String message);

    public void sendMessage(Message message);

    public Conversation getConversationByID(int conversationID);

    public Conversation getMostRecent(User u1, User u2);
}
