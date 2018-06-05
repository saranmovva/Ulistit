package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.sql.Timestamp;

@Entity(name = "offer")
@Table(name = "offer")
@Transactional
public class Offer {

    @Id
    @Column(name = "offer_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int offerID;

    @Column(name = "offer_amount")
    private int offerAmount;

    @Column(name = "offer_message")
    private String offerMessage;

    @OneToOne
    @JoinColumn(name = "offer_maker_id")
    private User offerMaker;

    @OneToOne
    @JoinColumn(name = "offer_receiver_id")
    private User offerReceiver;

    @OneToOne
    @JoinColumn(name = "listing_id")
    private Listing listingID;

    @Column(name = "status")
    private String status;

    @Column(name = "active")
    private int active;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    public Offer() {

    }

    public Offer(int offerAmount, String offerMessage, User offerMaker, User offerReceiver, Listing listingID) {
        this.offerAmount = offerAmount;
        this.offerMessage = offerMessage;
        this.offerMaker = offerMaker;
        this.offerReceiver = offerReceiver;
        this.listingID = listingID;
        this.status = "pending";
        this.active = 1;
    }

    public Offer(int offerAmount, String offerMessage, User offerMaker, User offerReceiver, Listing listingID, @NotBlank String status) {
        this.offerAmount = offerAmount;
        this.offerMessage = offerMessage;
        this.offerMaker = offerMaker;
        this.offerReceiver = offerReceiver;
        this.listingID = listingID;
        this.status = status;
        this.active = 1;
    }

    public Offer(int offerID, int offerAmount, String offerMessage, User offerMaker, User offerReceiver, Listing listingID, @NotBlank String status, Timestamp dateCreated) {
        this.offerID = offerID;
        this.offerAmount = offerAmount;
        this.offerMessage = offerMessage;
        this.offerMaker = offerMaker;
        this.offerReceiver = offerReceiver;
        this.listingID = listingID;
        this.status = status;
        this.active = 1;
        this.dateCreated = dateCreated;
    }

    // Getters and setters

    public int getOfferID() {
        return offerID;
    }

    public void setOfferID(int offerID) {
        this.offerID = offerID;
    }

    public int getOfferAmount() {
        return offerAmount;
    }

    public void setOfferAmount(int offerAmount) {
        this.offerAmount = offerAmount;
    }

    public String getOfferMessage() {
        return offerMessage;
    }

    public void setOfferMessage(String offerMessage) {
        this.offerMessage = offerMessage;
    }

    public Listing getListingID() {
        return listingID;
    }

    public void setListingID(Listing listingID) {
        this.listingID = listingID;
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

    public User getOfferMaker() {
        return offerMaker;
    }

    public void setOfferMaker(User offerMaker) {
        this.offerMaker = offerMaker;
    }

    public User getOfferReceiver() {
        return offerReceiver;
    }

    public void setOfferReceiver(User offerReceiver) {
        this.offerReceiver = offerReceiver;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    @Override
    public String toString() {
        return "Offer:" +
                "offerID=" + offerID +
                ", offerAmount=" + offerAmount +
                ", offerMessage='" + offerMessage + '\'' +
                ", offerMaker=" + offerMaker +
                ", offerReceiver=" + offerReceiver +
                ", listingID=" + listingID +
                ", status='" + status + '\'' +
                ", active=" + active;
    }
}
