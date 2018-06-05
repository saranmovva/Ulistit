package edu.ben.dao;

import edu.ben.model.Offer;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class OfferDAOImpl implements OfferDAO {
	
	@Autowired
	SessionFactory sessionFactory;
	
	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public void createOffer(Offer offer) {
		getSession().save(offer);
	}

	@Override
	public void saveOrUpdate(Offer offer) {
		getSession().saveOrUpdate(offer);
	}

	@Override
	public void deleteOffer(Offer offer) {
		getSession().delete(offer);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Offer> getOffersByUserId(int id) {

        Query q = getSession().createQuery("FROM offer WHERE offer_maker_id=:id OR offer_receiver_id=:id");
		q.setParameter("id", id);
		
		return q.list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Offer> getActiveOffersByUserId(int id) {

        Query q = getSession().createQuery("FROM offer WHERE offer_maker_id=:id OR offer_receiver_id=:id AND active=1");
		q.setParameter("id", id);
		
		return q.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Offer> getOffersByListingId(int id) {
		
		Query q = getSession().createQuery("FROM offer WHERE listing_id=:id");
		q.setParameter("id", id);
		
		return q.list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Offer> getActiveOffersByListingId(int id) {
		
		Query q = getSession().createQuery("FROM offer WHERE listing_id=:id AND active=1");
		q.setParameter("id", id);
		
		return q.list();
	}

	@Override
	public Offer getOfferById(int id) {
		
		Query q = getSession().createQuery("FROM offer WHERE offer_id=:id");
		q.setParameter("id", id);

        return (Offer) q.list().get(0);
	}

	@Override
	public Offer getOfferByUserAndListingId(int userID, int listingID) {

        Query q = getSession().createQuery("FROM offer WHERE (offer_maker_id=:userID OR offer_receiver_id=:userID) AND listing_id=:listingID");
		q.setParameter("userID", userID);
		q.setParameter("listingID", listingID);
		
		if (q.list().size() == 0) {
			return null;
		}
		
		return (Offer) q.list().get(0);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Offer> getPendingOffersByUserId(int id) {
		
		String status = "pending";
        Query q = getSession().createQuery("FROM offer WHERE offer_maker_id=:id OR offer_receiver_id=:id AND status=:status");
		q.setParameter("id", id);
		q.setParameter("status", status);
		
		return q.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Offer> getPendingOffersByListingId(int id) {
		
		String status = "pending";
		Query q = getSession().createQuery("FROM offer WHERE listing_id=:id AND status=:status");
		q.setParameter("id", id);
		q.setParameter("status", status);
		
		return q.list();
	}

}
