package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

@Entity(name = "conversation")
@Table(name = "conversation")
@Transactional
public class Conversation implements Serializable {

    @Id
    @Column(name = "conversation_ID")
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userId_1")
    private User user1;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userId_2")
    private User user2;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @OneToMany(mappedBy = "conversationId", fetch = FetchType.EAGER)
    private List<Message> messages;

    public Conversation() {

    }

    public Conversation(User user1, User user2) {
        this.user1 = user1;
        this.user2 = user2;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser1() {
        return user1;
    }

    public void setUser1(User user1) {
        this.user1 = user1;
    }

    public User getUser2() {
        return user2;
    }

    public void setUser2(User user2) {
        this.user2 = user2;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
    }

    @Override
    public boolean equals(Object o) {
        Conversation con = (Conversation) o;
        return con.getUser1().getUserID() == this.getUser1().getUserID() && con.getUser2().getUserID() == this.getUser2().getUserID();
    }
}