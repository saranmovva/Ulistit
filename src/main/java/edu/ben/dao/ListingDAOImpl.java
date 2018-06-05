package edu.ben.dao;

import edu.ben.model.Listing;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Transactional
@Repository
public class ListingDAOImpl implements ListingDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public void create(Listing listing) {
        getSession().save(listing);
    }

    @Override
    public int save(Listing listing) {
        return (Integer) getSession().save(listing);
    }

    public void saveOrUpdate(Listing listing) {
        getSession().saveOrUpdate(listing);
    }

    public void deleteListing(int id) {
        Listing listing = (Listing) getSession().get(Listing.class, id);
        getSession().delete(listing);

    }


    @SuppressWarnings("unchecked")
    @Override
    public List<Listing> getAllListingsByCategory(String category) {
        Query q = getSession().createQuery("FROM listing WHERE category=:category");
        q.setParameter("category", category);
        return q.list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Listing> getRecentListings() {
        Query q = getSession().createQuery("FROM listing ORDER BY date_created DESC");
        List<Listing> list = (List<Listing>) q.list();
        Iterator<Listing> it = list.iterator();
        List<Listing> recentListings = new ArrayList<>();


        while (it.hasNext()) {

            Listing listing = it.next();
            recentListings.add(listing);

        }

        return recentListings;
    }


    @SuppressWarnings("unchecked")
    @Override
    public List<Listing> getListingsByBidCount() {
        Query q = getSession().createQuery("FROM listing WHERE bid_count > 0 ORDER BY bid_count");
        return (List<Listing>) q.list();
    }

    @Override
    public Listing getByListingID(int listingID) {
        Query q = getSession().createQuery("FROM listing WHERE id=:listingID");
        q.setParameter("listingID", listingID);
        return (Listing) q.uniqueResult();
    }

    @SuppressWarnings("unchecked")
    public List<Listing> getAllListingsByUserID(int userID) {
        Query q = getSession().createSQLQuery("select * from ulistit.listing where userID = " + userID + ";")
                .addEntity(Listing.class);
        return (List<Listing>) q.list();

    }

    @Override
    public void updateListingActiveStatusByID(int active, int id) {

        Query q = getSession().createQuery("UPDATE listing SET active=:active WHERE id=:id");
        q.setParameter("active", active);
        q.setParameter("id", id);
        q.executeUpdate();

    }


    @Override
    public List getListingsInProgressUserBidOn(int userID) {
        SQLQuery q = getSession().createSQLQuery(
                "SELECT * FROM listing AS l WHERE l.ended=0 AND active=1 AND l.id IN (SELECT lb.listing_id FROM listing_bid AS lb WHERE lb.user_id=:userID AND active=1)")
                .addEntity(Listing.class);
        q.setParameter("userID", userID);
        return q.list();
    }

    @Override
    public List getListingsLost(int userID) {
        Query q = getSession().createSQLQuery(
                "SELECT * FROM listing AS l WHERE l.ended=1 AND active=1 AND l.highest_bid_userID!=:userID AND l.id IN (SELECT lb.listing_id FROM listing_bid AS lb WHERE lb.user_id=:userID)")
                .addEntity(Listing.class);
        q.setParameter("userID", userID);
        return q.list();
    }


    @Override
    public List getListingsWon(int userID) {
        SQLQuery q = getSession().createSQLQuery("SELECT * FROM listing WHERE ended=1 AND active=1 AND highest_bid_userID=:userID")
                .addEntity(Listing.class);
        q.setParameter("userID", userID);
        return q.list();
    }

    @Override
    public List getListingsSold(int userID) {
        Query q = getSession().createQuery("FROM listing WHERE ended=1 AND highest_bid>0 AND userID=:userID");
        q.setParameter("userID", userID);
        return q.list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Listing> getActiveListings() {
        return getSession().createQuery("FROM listing WHERE active=1").list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Listing> getAllListings() {
        return getSession().createQuery("FROM listing").list();
    }

    @Override
    public List<Listing> getAllWeeklyPlusListings() {
        Query q = getSession()
                .createSQLQuery("SELECT * FROM listing WHERE listing.end_timestamp > NOW() + INTERVAL 7 DAY;")
                .addEntity(Listing.class);

        return q.list();
    }

    @Override
    public List<Listing> getAllFixedListings() {
        Query q = getSession().createSQLQuery("SELECT * FROM listing WHERE listing.type = 'fixed';")
                .addEntity(Listing.class);

        return q.list();
    }

    @Override
    public List<Listing> getAllDailyListings() {
        Query q = getSession().createSQLQuery(
                "SELECT * FROM listing WHERE listing.end_timestamp >= NOW() - INTERVAL 1 DAY AND listing.end_timestamp < NOW() + INTERVAL 1 DAY;")
                .addEntity(Listing.class);

        return q.list();
    }

    @Override
    public List<Listing> getAllWeeklyListings() {
        Query q = getSession().createSQLQuery(
                "SELECT * FROM listing WHERE listing.end_timestamp >= NOW() - INTERVAL 1 DAY AND listing.end_timestamp < NOW() + INTERVAL 7 DAY;")
                .addEntity(Listing.class);

        return q.list();
    }

    @Override
    public List<Listing> listingSearch(String search) {
        Query q = getSession().createSQLQuery("SELECT * FROM ulistit.listing WHERE SOUNDEX(name)=soundex('" + search
                + "') OR SOUNDEX(category)=soundex('" + search + "') OR SOUNDEX(description)=soundex('" + search
                + "') OR name LIKE '%" + search + "%' OR category LIKE '%" + search + "%' OR description LIKE '%"
                + search + "%';").addEntity(Listing.class);
        List<Listing> l = q.list();
        return l;
    }

    @Override
    public List findAllDonatedListings() {
        return getSession().createQuery("FROM listing WHERE type='donation' AND active=1").list();
    }

    @Override
    public List findAllDonatedListingsByCategory(String category) {
        Query q = getSession()
                .createQuery("FROM listing WHERE type='donation' AND category=:cat AND active=1 ORDER BY date_created DESC");
        q.setParameter("cat", category);
        return q.list();
    }

    @Override
    public List listingsSearchDonations(String search) {
        Query q = getSession().createSQLQuery("SELECT * FROM ulistit.listing WHERE (SOUNDEX(name)=soundex('" + search
                + "') OR SOUNDEX(category)=soundex('" + search + "') OR SOUNDEX(description)=soundex('" + search
                + "') OR name LIKE '%" + search + "%' OR category LIKE '%" + search + "%' OR description LIKE '%"
                + search + "%') AND (type='donation' AND active=1);")
                .addEntity(Listing.class);

        return q.list();
    }

    @Override
    public List<Listing> listingsSearchEndingLatest(String search) {
        Query q = getSession().createSQLQuery("SELECT * FROM ulistit.listing WHERE (SOUNDEX(name)=soundex('" + search
                + "') OR SOUNDEX(category)=soundex('" + search + "') OR SOUNDEX(description)=soundex('" + search
                + "') OR name LIKE '%" + search + "%' OR category LIKE '%" + search + "%' OR description LIKE '%"
                + search + "%') AND (type='auction' AND active=1) order by end_timestamp DESC;")
                .addEntity(Listing.class);

        return (List<Listing>) q.list();
    }

    @Override
    public List<Listing> listingsSearchEndingSoonest(String search) {
        Query q = getSession().createSQLQuery("SELECT * FROM ulistit.listing WHERE (SOUNDEX(name)=soundex('" + search
                + "') OR SOUNDEX(category)=soundex('" + search + "') OR SOUNDEX(description)=soundex('" + search
                + "') OR name LIKE '%" + search + "%' OR category LIKE '%" + search + "%' OR description LIKE '%"
                + search + "%') AND (type='auction' AND active=1) order by end_timestamp ASC;")
                .addEntity(Listing.class);

        return (List<Listing>) q.list();
    }

    @Override
    public List<Listing> listingSearchMostExpensive(String search) {
        Query q = getSession()
                .createSQLQuery("SELECT * FROM ulistit.listing WHERE (SOUNDEX(name)=soundex('" + search
                        + "') OR SOUNDEX(category)=soundex('" + search + "') OR SOUNDEX(description)=soundex('" + search
                        + "') OR name LIKE '%" + search + "%' OR category LIKE '%" + search
                        + "%' OR description LIKE '%" + search + "%') AND (active=1) order by price DESC;")
                .addEntity(Listing.class);

        return (List<Listing>) q.list();
    }

    @Override
    public List<Listing> listingSearchLeastExpensive(String search) {
        Query q = getSession()
                .createSQLQuery("SELECT * FROM ulistit.listing WHERE (SOUNDEX(name)=soundex('" + search
                        + "') OR SOUNDEX(category)=soundex('" + search + "') OR SOUNDEX(description)=soundex('" + search
                        + "') OR name LIKE '%" + search + "%' OR category LIKE '%" + search
                        + "%' OR description LIKE '%" + search + "%') AND (active=1) order by price ASC;")
                .addEntity(Listing.class);

        return (List<Listing>) q.list();
    }

    @Override
    public List getRelevantListingsByUserID(int userID) {
        String sql = "SELECT * FROM listing WHERE id IN (SELECT listing.id FROM listing INNER JOIN search_history " +
                "ON description LIKE CONCAT('%' + search + '%') WHERE search_history.user_id = :userID) OR sub_category " +
                "IN (SELECT search_subcategory FROM search_history AS s1 WHERE user_id = :userID GROUP BY search_subcategory " +
                "ORDER BY search_count , date_created , (SELECT COUNT(*) FROM search_history AS s2 WHERE " +
                "s1.search_subcategory = s2.search_subcategory AND user_id = :userID)) AND active = 1 AND ended = 0 " +
                "ORDER BY end_timestamp DESC LIMIT 50;";
        SQLQuery q = getSession().createSQLQuery(sql)
                .addEntity(Listing.class);
        q.setParameter("userID", userID);
        return q.list();
    }

    @Override
    public Listing getRelevantListingsFromRecentPurchaseByUserID(int userID, String category) {

        System.out.println("User= " + userID);
        System.out.println("Category= " + category);

        String sql1 = "select DISTINCT id, userID, name, description, category, sub_category, price, type, highest_bid_userID, highest_bid, " +
                "bid_count, start_timestamp, end_timestamp, listing.date_created, listing.active, ended, premium, payment_type, draft " +
                "from listing, offer " +
                "join listing_bid on user_id !=:userID where userID !=:userID " +
                "and offer_maker_id !=:userID " +
                "and listing.category =:category and listing.active = 1 and listing.ended = 0 " +
                "and listing.date_created = (select MAX(listing.date_created) from listing);";

        String sql = "select DISTINCT id, userID, name, description, category, sub_category, price, type, highest_bid_userID, " +
                "highest_bid, bid_count, start_timestamp, end_timestamp, listing.date_created, listing.active, ended, premium, payment_type, draft " +
                "from listing, offer, listing_bid " +
                "where listing.userID !=:userID " +
                "and listing_bid.user_id !=:userID " +
                "and offer_maker_id !=:userID " +
                "and listing.category =:category and listing.active = 1 and listing.ended = 0;";

        SQLQuery q = getSession().createSQLQuery(sql)
                .addEntity(Listing.class);
        q.setParameter("userID", userID);
        q.setParameter("category", category);
        return (Listing) q.list().get(0);
    }

    @Override
    public Listing getRecentListingWithOfferOrBidByUserID(int userID) {
        String sql1 = "select DISTINCT listing.id, listing.name, listing.highest_bid, listing.type, listing.price, listing.end_timestamp, " +
                "listing.active, listing.bid_count, listing.category, listing.description, listing.draft, listing.ended, listing.highest_bid_userID, " +
                "listing.payment_type, listing.sub_category, listing.date_created, listing.premium, listing.start_timestamp, listing.userID " +
                "from listing, offer, listing_bid where listing.date_created = (select MAX(listing.date_created) from listing " +
                "where (offer.offer_maker_id=:userID or listing_bid.user_id=:userID) and ended = 0 and listing.active = 1);";

        String sql = "select DISTINCT listing.id, listing.name, listing.highest_bid, listing.type, listing.price, listing.end_timestamp, " +
                "                listing.active, listing.bid_count, listing.category, listing.description, listing.draft, " +
                "                listing.ended, listing.highest_bid_userID, listing.payment_type, listing.sub_category, " +
                "                listing.date_created, listing.premium, listing.start_timestamp, listing.userID " +
                "                from listing " +
                "                where listing.userID NOT IN (select offer_maker_id from offer where offer_maker_id =:userID) " +
                "                and listing.userID NOT IN (select user_id from listing_bid where user_id =:userID) " +
                "                and ended = 0 " +
                "                and listing.active = 1 " +
                "                order by listing.date_created limit 1;";

        SQLQuery q = getSession().createSQLQuery(sql)
                .addEntity(Listing.class);
        q.setParameter("userID", userID);

        return (Listing) q.list().get(0);
    }

    @Override
    public List<Listing> getRecentListingsWithOffersOrBidsForUserByUserID(int userID) {
        String sql = "select * from listing where listing.userID=:userID and listing.bid_count > 0;";
        SQLQuery q = getSession().createSQLQuery(sql)
                .addEntity(Listing.class);
        q.setParameter("userID", userID);

        return q.list();
    }

    @Override
    public List getPremiumListings() {
        return getSession().createQuery("FROM listing WHERE premium=1 AND active=1 AND ended=0 ORDER BY end_timestamp DESC").list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Listing> getUserDrafts(int id) {
        Query q = getSession().createQuery("FROM listing WHERE userID=:id AND draft=1");
        q.setParameter("id", id);

        return q.list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Listing> getActiveListingsByUserId(int id) {

        Query q = getSession().createQuery("FROM listing WHERE userID=:id AND active = 1");
        q.setParameter("id", id);

        return q.list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Listing> getInActiveListingsByUserId(int id) {

        Query q = getSession().createQuery("FROM listing WHERE userID=:id AND active = 0");
        q.setParameter("id", id);

        return q.list();
    }

    @Override
    public List getHottestListings() {
        Query q = getSession().createQuery("FROM listing WHERE type='auction' ORDER BY bidCount DESC");
        return q.list();
    }

    public void deleteByListingId(int id) {
        Query q = getSession().createQuery("UPDATE listing SET active=0 WHERE id=:id");
        q.setParameter("id", id);
        q.executeUpdate();
    }

    public void activateByListingId(int id) {
        Query q = getSession().createQuery("UPDATE listing SET active=1 WHERE id=:id");
        q.setParameter("id", id);
        q.executeUpdate();
    }
}
