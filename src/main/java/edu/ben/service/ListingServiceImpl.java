package edu.ben.service;

import edu.ben.dao.ListingDAO;
import edu.ben.dao.UserDAO;
import edu.ben.model.Listing;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class ListingServiceImpl implements ListingService {

    ListingDAO ld;

    UserDAO ud;

    @Autowired
    public void setListingDAO(ListingDAO ld) {
        this.ld = ld;
    }

    @Autowired
    public void setUserDAO(UserDAO ud) {
        this.ud = ud;
    }

    NotificationService notificationService;

    @Autowired
    public void setNotificationService(NotificationService notificationService) {
        this.notificationService = notificationService;
    }


    ListingBidService listingBidService;

    @Autowired
    public void setListingBidService(ListingBidService listingBidService) {
        this.listingBidService = listingBidService;
    }

    @Override
    public void deleteListing(int id) {
        ld.deleteListing(id);
    }

    @Override
    public int save(Listing listing) {
        return ld.save(listing);
    }


    @Override
    public void saveOrUpdate(Listing listing) {
        ld.saveOrUpdate(listing);
    }

    @Override
    public void create(Listing listing) {
        ld.create(listing);
    }

    public List<Listing> getAllListingsByCategory(String category) {
        return ld.getAllListingsByCategory(category);
    }

    public List<Listing> getRecentListings() {
        return ld.getRecentListings();
    }

    @Override
    public List<Listing> getListingsByBidCount() {
        return ld.getListingsByBidCount();
    }

    @Override
    public Listing getByListingID(int listingID) {
        return ld.getByListingID(listingID);
    }


    @Override
    public List<Listing> getAllListingsByUserID(int userID) {
        return ld.getAllListingsByUserID(userID);
    }

    @Override
    public void updateListingActiveStatusByID(int active, int id) {
        ld.updateListingActiveStatusByID(active, id);
    }


    @Override
    public List getListingsInProgressUserBidOn(int userID) {
        return ld.getListingsInProgressUserBidOn(userID);
    }

    @Override
    public List getListingsLost(int userID) {
        return ld.getListingsLost(userID);
    }

    @Override
    public List getListingsWon(int userID) {
        return ld.getListingsWon(userID);
    }

    public List getListingsSold(int userID) {
        return ld.getListingsSold(userID);
    }

    @Override
    public List getActiveListings() {
        return ld.getActiveListings();
    }

    @Override
    public List<Listing> getAllWeeklyPlusListings() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<Listing> getAllFixedListings() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<Listing> getAllDailyListings() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List<Listing> getAllWeeklyListings() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public List getRelevantListingsByUserID(int userID) {
        return ld.getRelevantListingsByUserID(userID);
    }

    @Override
    public Listing getRelevantListingsFromRecentPurchaseByUserID(int userID, String category) {
        return ld.getRelevantListingsFromRecentPurchaseByUserID(userID, category);
    }

    public Listing getRecentListingWithOfferOrBidByUserID(int userID) {
        return ld.getRecentListingWithOfferOrBidByUserID(userID);
    }

    public List<Listing> getRecentListingsWithOffersOrBidsForUserByUserID(int userID) {
        return ld.getRecentListingsWithOffersOrBidsForUserByUserID(userID);
    }

    @Override
    public List getPremiumListings() {
        return ld.getPremiumListings();
    }

    @Override
    public List<Listing> getUserDrafts(int id) {
        return ld.getUserDrafts(id);
    }

    @Override
    public List<Listing> listingSearch(String search) {
        return ld.listingSearch(search);
    }

    @Override
    public List<Listing> findAllDonatedListings() {
        return ld.findAllDonatedListings();
    }

    @Override
    public List<Listing> findAllDonatedListingsByCategory(String category) {
        return ld.findAllDonatedListingsByCategory(category);
    }

    @Override
    public List<Listing> listingsSearchEndingLatest(String search) {
        return ld.listingsSearchEndingLatest(search);
    }

    @Override
    public List<Listing> listingsSearchEndingSoonest(String search) {
        return ld.listingsSearchEndingSoonest(search);
    }

    @Override
    public List<Listing> listingSearchMostExpensive(String search) {
        return ld.listingSearchMostExpensive(search);
    }

    @Override
    public List<Listing> listingSearchLeastExpensive(String search) {
        return ld.listingSearchLeastExpensive(search);
    }

    @Override
    public List<Listing> getAllListings() {
        return ld.getAllListings();
    }

    @Override
    public List<Listing> getActiveListingsByUserId(int id) {
        return ld.getActiveListingsByUserId(id);
    }

    @Override
    public List<Listing> getInActiveListingsByUserId(int id) {
        return ld.getInActiveListingsByUserId(id);
    }

    @Override
    public List listingsSearchDonations(String search) {
        return ld.listingsSearchDonations(search);
    }

    @Override
    public List getHottestListings() {
        return ld.getHottestListings();
    }

    public void deleteByListingId(int id) {
        ld.deleteByListingId(id);
    }

    public void activateByListingId(int id) {
        ld.activateByListingId(id);
    }
}
