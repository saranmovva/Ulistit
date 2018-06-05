package edu.ben.service;

import edu.ben.model.Listing;
import edu.ben.model.ListingBid;
import edu.ben.model.User;

import java.util.List;

public interface ListingBidService {

    public void save(ListingBid listingBid);

    public void update(ListingBid listingBid);

    public List getActiveByListingID(int listingID);

    public int cancel(User user, int listingID);

    public int placeBid(int biddingUserID, int bidValue, Listing listing);

}
