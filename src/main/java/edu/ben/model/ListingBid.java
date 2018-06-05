package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;

@Entity(name = "listing_bid")
@Table(name = "listing_bid")
@Transactional
public class ListingBid {

    @Id
    @Column(name = "bid_id")
    private int bidID;

    @Column(name = "listing_id")
    private int listing_id;

    @Column(name = "user_id")
    private int user_id;

    @Column(name = "bid_value")
    private int bid_value;

    @Column(name = "active")
    private int active;

    public ListingBid() {
    }

    public ListingBid(int listingID, int userID, int bidValue) {
        this.listing_id = listingID;
        this.user_id = userID;
        this.bid_value = bidValue;
    }

    public int getListingID() {
        return listing_id;
    }

    public void setListingID(int listingID) {
        this.listing_id = listingID;
    }

    public int getUserID() {
        return user_id;
    }

    public void setUserID(int userID) {
        this.user_id = userID;
    }

    public int getBidID() {
        return bidID;
    }

    public void setBidID(int bidID) {
        this.bidID = bidID;
    }

    public int getBidValue() {
        return bid_value;
    }

    public void setBidValue(int bidValue) {
        this.bid_value = bidValue;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }
}
