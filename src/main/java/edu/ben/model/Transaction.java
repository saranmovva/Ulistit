package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity(name = "transaction")
@Table(name = "transaction")
@Transactional
public class Transaction {

    @Id
    @Column(name = "transaction_ID")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @OneToOne
    @JoinColumn(name = "listing_ID")
    private Listing listingID;

    @OneToOne
    @JoinColumn(name = "buyer_ID")
    private User buyer;

    @OneToOne
    @JoinColumn(name = "seller_ID")
    private User seller;

    @Column(name = "transaction_type")
    // @NotBlank
    private String transactionType;

    @Column(name = "completed")
    //@NotBlank
    private int completed;

    @OneToOne
    @JoinColumn(name = "offer_ID", nullable = true)
    private Offer offerID;

    @Column(name = "date_modified")
    private Timestamp dateModified;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @Column(name = "trans_rating")
    private int transRating;

    @Column(name = "trans_review")
    private String transReview;

    @Column(name = "review_rate_left")
    private int feedbackLeft;

    public Transaction() {

    }

    public Transaction(User buyer, User seller, Listing listingID, int completed, Offer offerID) {
        this.buyer = buyer;
        this.seller = seller;
        this.listingID = listingID;
        this.completed = completed;
        this.offerID = offerID;
    }

    public Transaction(Listing listingID, int completed) {
        this.buyer = listingID.getHighestBidder();
        this.seller = listingID.getUser();
        this.listingID = listingID;
        this.completed = completed;
        this.offerID = null;
    }

    public Transaction(int id, User buyer, User seller, Listing listingID, int completed, Offer offerID) {
        this.id = id;
        this.buyer = buyer;
        this.seller = seller;
        this.listingID = listingID;
        this.completed = completed;
        this.offerID = offerID;
    }

    public Transaction(int id, int buyer, int seller, Listing listingID, String transactionType, int completed,
                       Offer offerID) {
        this.id = id;
		/*this.buyerID = buyer;
		this.sellerID = seller;*/
        this.listingID = listingID;
        this.transactionType = transactionType;
        this.completed = completed;
        this.offerID = offerID;
    }

    // Getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }

    public User getSeller() {
        return seller;
    }

    public void setSeller(User seller) {
        this.seller = seller;
    }

    public Listing getListingID() {
        return listingID;
    }

    public void setListingID(Listing listingID) {
        this.listingID = listingID;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public int getCompleted() {
        return completed;
    }

    public void setCompleted(int completed) {
        this.completed = completed;
    }

    public Offer getOfferID() {
        return offerID;
    }

    public void setOfferID(Offer offerID) {
        this.offerID = offerID;
    }

    public Timestamp getDateModified() {
        return dateModified;
    }

	public void setDateModified(Timestamp dateModified) {
		this.dateModified = dateModified;
	}

	public Timestamp getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Timestamp dateCreated) {
		this.dateCreated = dateCreated;
	}

	public int getTransRating() {
		return transRating;
	}

	public void setTransRating(int transRating) {
		this.transRating = transRating;
	}

	public String getTransReview() {
		return transReview;
	}

	public void setTransReview(String transReview) {
		this.transReview = transReview;
	}

	public int getFeedbackLeft() {
		return feedbackLeft;
	}

	public void setFeedbackLeft(int feedbackLeft) {
		this.feedbackLeft = feedbackLeft;
	}



}
