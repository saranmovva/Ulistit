package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity(name = "checklist_item")
@Table(name = "checklist_item")
@Transactional
public class ChecklistItem {

    public static final int STILL_NEED = 0;
    public static final int OWN = 1;
    public static final int BOUGHT_FROM_ULISTIT = 2;
    public static final int DONT_NEED = -1;

    @Id
    @Column(name = "item_id")
    private int itemID;

    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinColumn(name = "checklist_id")
    private Checklist checklist;

    @Column(name = "name")
    private String name;

    @Column(name = "active")
    private int active = 1;

    @Column(name = "status")
    private String status;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    public ChecklistItem() {
    }

    public ChecklistItem(Checklist checklist, String name) {
        this.checklist = checklist;
        this.name = name;
        this.active = 1;
        this.status = "STILL_NEED";
    }

    public int getItemID() {
        return itemID;
    }

    public void setItemID(int itemID) {
        this.itemID = itemID;
    }

    public Checklist getChecklist() {
        return checklist;
    }

    public void setChecklist(Checklist checklist) {
        this.checklist = checklist;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }
}
