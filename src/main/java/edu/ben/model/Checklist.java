package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Entity(name = "checklist")
@Table(name = "checklist")
public class Checklist {

    @Id
    @Column(name = "checklist_id")
    private int checklistID;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @Column(name = "type")
    private String type;

    @Column(name = "status")
    private String status;

    @Column(name = "active")
    private int active;

    @OneToMany(mappedBy = "checklist", fetch = FetchType.EAGER)
    private List<ChecklistItem> items;

    public Checklist() {
    }

    public Checklist(User user, String type) {
        this.user = user;
        this.type = type;
        this.status = "CREATED";
        this.active = 1;
    }

    public int getChecklistID() {
        return checklistID;
    }

    public void setChecklistID(int checklistID) {
        this.checklistID = checklistID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public List<ChecklistItem> getItems() {
        return items;
    }

    public void setItems(List<ChecklistItem> items) {
        this.items = items;
    }
}
