package edu.ben.dao;

import edu.ben.model.ListingBid;
import edu.ben.model.User;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class ListingBidDAOImpl implements ListingBidDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(ListingBid listingBid) {
        getSession().save(listingBid);
    }

    @Override
    public void update(ListingBid listingBid) {
        getSession().update(listingBid);
    }

    @Override
    public List getActiveByListingID(int listingID) {
        Query q = getSession().createQuery("FROM listing_bid WHERE active=1 AND listing_id=:id");
        q.setParameter("id", listingID);
        return q.list();
    }

    @Override
    public List getActiveByUserIDAndListingID(int userID, int listingID) {
        Query q = getSession().createQuery("FROM listing_bid WHERE active=1 AND listing_id=:id AND user_id=:userID");
        q.setParameter("id", listingID);
        q.setParameter("userID", userID);
        return q.list();
    }

    @Override
    public User getHighestBidderByListingID(int listingID, int userID) {
        Query q = getSession().createQuery("FROM user WHERE user_ID = (SELECT user_id FROM listing_bid WHERE listing_id =:listingID AND active=1 AND bid_value = (SELECT MAX(bid_value) FROM listing_bid WHERE listing_id=:listingID AND active=1 AND user_id!=:userID))");
        q.setParameter("listingID", listingID);
        q.setParameter("userID", userID);
        return (User) q.uniqueResult();
    }

    @Override
    public ListingBid getHighestBidByListingID(int listingID) {
        Query q = getSession().createQuery("FROM listing_bid WHERE listing_id=:listingID AND bid_value = (SELECT MAX(bid_value) FROM listing_bid WHERE listing_id=:listingID AND active=1)");
        q.setParameter("listingID", listingID);
        return (ListingBid) q.uniqueResult();
    }
}
