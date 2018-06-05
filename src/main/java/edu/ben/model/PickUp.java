package edu.ben.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Table(name = "pick_up")
@Entity(name = "pick_up")
public class PickUp {

    @Id
    @Column(name = "pick_up_id")
    private int pickUpID;

    @OneToOne
    @JoinColumn(name = "transaction_id")
    private Transaction transaction;

    @OneToOne
    @JoinColumn(name = "location_id")
    private Location location;

    @Column(name = "pick_up_timestamp")
    private Timestamp pickUpTimestamp;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @Column(name = "active")
    private int active;

    @Column(name = "buyer_accept")
    private int buyerAccept;

    @Column(name = "seller_verified")
    private int sellerVerified;

    @Column(name = "buyer_verified")
    private int buyerVerified;

    @Column(name = "status")
    private String status;

    @OneToOne
    @JoinColumn(name = "conversation_id")
    private Conversation conversation;

    public PickUp() {
    }

    public PickUp(Transaction transaction, Location location, Conversation conversation) {
        this.transaction = transaction;
        this.location = location;
        this.conversation = conversation;
        this.status = "CREATED";
        this.active = 1;
    }

    public int getPickUpID() {
        return pickUpID;
    }

    public void setPickUpID(int pickUpID) {
        this.pickUpID = pickUpID;
    }

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public Timestamp getPickUpTimestamp() {
        return pickUpTimestamp;
    }

    public void setPickUpTimestamp(Timestamp pickUpTimestamp) {
        this.pickUpTimestamp = pickUpTimestamp;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getPickUpDate() {
        if (pickUpTimestamp != null) {
            Date date = new Date(pickUpTimestamp.getTime());
            return new SimpleDateFormat("MM/dd/yyyy").format(date);
        }
        return null;
    }

    public String getPickUpTime() {
        if (pickUpTimestamp != null) {
            Date date = new Date(pickUpTimestamp.getTime());
            return new SimpleDateFormat("hh:mm a").format(date);
        }
        return null;
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

    public Conversation getConversation() {
        return conversation;
    }

    public void setConversation(Conversation conversation) {
        this.conversation = conversation;
    }

    public int getBuyerAccept() {
        return buyerAccept;
    }

    public void setBuyerAccept(int buyerAccept) {
        this.buyerAccept = buyerAccept;
    }

    public long getDelay() {
        return pickUpTimestamp.getTime() - System.currentTimeMillis();
    }

    public int getSellerVerified() {
        return sellerVerified;
    }

    public void setSellerVerified(int sellerVerified) {
        this.sellerVerified = sellerVerified;
    }

    public int getBuyerVerified() {
        return buyerVerified;
    }

    public void setBuyerVerified(int buyerVerified) {
        this.buyerVerified = buyerVerified;
    }
}
