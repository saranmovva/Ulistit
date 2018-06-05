package edu.ben.dao;

import edu.ben.model.ListingBid;
import edu.ben.model.User;

import java.util.List;

public interface ListingBidDAO {

    public void save(ListingBid listingBid);

    public void update(ListingBid listingBid);

    public List getActiveByListingID(int listingID);

    public User getHighestBidderByListingID(int listingID, int userID);

    public ListingBid getHighestBidByListingID(int listingID);

    public List getActiveByUserIDAndListingID(int userID, int listingID);

}
