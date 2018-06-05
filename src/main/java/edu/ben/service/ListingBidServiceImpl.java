package edu.ben.service;

import edu.ben.dao.ListingBidDAO;
import edu.ben.dao.ListingDAO;
import edu.ben.dao.UserDAO;
import edu.ben.model.Listing;
import edu.ben.model.ListingBid;
import edu.ben.model.Notification;
import edu.ben.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class ListingBidServiceImpl implements ListingBidService {

    ListingBidDAO listingBidDAO;

    @Autowired
    public void setListingBidDAO(ListingBidDAO listingBidDAO) {
        this.listingBidDAO = listingBidDAO;
    }

    ListingDAO listingDAO;

    @Autowired
    public void setListingDAO(ListingDAO listingDAO) {
        this.listingDAO = listingDAO;
    }

    NotificationService notificationService;

    @Autowired
    public void setNotificationService(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    UserDAO ud;

    @Autowired
    public void setUserDAO(UserDAO ud) {
        this.ud = ud;
    }

    @Override
    public void save(ListingBid listingBid) {
        listingBidDAO.save(listingBid);
    }

    @Override
    public void update(ListingBid listingBid) {
        listingBidDAO.update(listingBid);
    }

    @Override
    public List getActiveByListingID(int listingID) {
        return listingBidDAO.getActiveByListingID(listingID);
    }

    @Override
    public int cancel(User user, int listingID) {

        Listing listing = listingDAO.getByListingID(listingID);

        // If listing ended
        if (listing.getEndTimestamp().before(new Timestamp(System.currentTimeMillis()))) {
            return -1;
        }

        // Set bid to inactive
        List<ListingBid> bids = listingBidDAO.getActiveByUserIDAndListingID(user.getUserID(), listingID);
        for (ListingBid bid : bids) {
            bid.setActive(0);
            listingBidDAO.update(bid);
        }

        List<Notification> newNotifications = new ArrayList<Notification>();

        // Send cancellation notification to cancelling bidder
        newNotifications.add(new Notification(user, listingID, "Bid Successfully Cancelled", "Your bid on listing " + listing.getName() + " has successfully been cancelled.", 1));

        // Bidder is the highest bidder
        if (listing.getHighestBidder().getUserID() == user.getUserID()) {

            try {
                // Set new highest bidder
                User newHighestBidder = listingBidDAO.getHighestBidderByListingID(listingID, user.getUserID());
                if (newHighestBidder != null) {
                    listing.setHighestBidder(newHighestBidder);
                } else {
                    listing.setHighestBidder(null);
                }

                // Set new highest bid
                ListingBid newListingBid = listingBidDAO.getHighestBidByListingID(listingID);
                if (newListingBid != null) {
                    listing.setHighestBid(newListingBid.getBidValue());
                } else {
                    listing.setHighestBid(0);
                }

                // Update listing
                listingDAO.saveOrUpdate(listing);

                // Send new highest bidder notification
                newNotifications.add(new Notification(newHighestBidder, listingID, "You're Now The Highest Bidder!", "Congratulations!\nThe highest bidder for listing " + listing.getName() + " cancelled his/her bid making you the new highest bidder!", 1, "HIGHEST_BIDDER"));

                // Send cancellation notification to seller
                newNotifications.add(new Notification(listing.getUser(), listingID, "Bid Cancelled On Your Listing", "The highest bid on listing " + listing.getName() + " has been cancelled.\nThe new highest bid has is ", 1, "DEFAULT"));

            } catch (Exception e) {

                listing.setHighestBidder(null);
                listing.setHighestBid(0);
                listingDAO.saveOrUpdate(listing);

                // No other bidder
                // Send cancellation notification to seller
                newNotifications.add(new Notification(listing.getUser(), listingID, "Bid Cancelled On Your Listing", "The highest bid on listing " + listing.getName() + " has been cancelled.\nThere is currently no bids on this listing.\n:(", 1));
            }
        }

        notificationService.save(newNotifications);

        return 1;
    }

    @Override
    public int placeBid(int biddingUserID, int bidValue, Listing listing) {

        if (System.currentTimeMillis() > listing.getEndTimestamp().getTime()) {
            return -1;
        } else if (bidValue <= listing.getHighestBid()) {
            ListingBid lb = new ListingBid(listing.getId(), biddingUserID, (int) bidValue);
            lb.setActive(1);
            listingBidDAO.save(lb);
            return -2;
        } else if (biddingUserID == listing.getUser().getUserID()) {
            return -3;
        }

        ListingBid lb = new ListingBid(listing.getId(), biddingUserID, (int) bidValue);
        lb.setActive(1);
        listingBidDAO.save(lb);


        // If current highest bidder is getting outbid, send notification
        if (listing.getHighestBidder() != null && biddingUserID != listing.getHighestBidder().getUserID()) {
            notificationService.save(new Notification(listing.getHighestBidder(), listing.getId(), "You've Be Outbit! Listing: " + listing.getName()));
        }

        listing.setHighestBid(bidValue);
        listing.setHighestBidder(ud.getUserById(biddingUserID));
        listing.setBidCount(listing.getBidCount() + 1);

        listingDAO.saveOrUpdate(listing);
        return 1;
    }
}
