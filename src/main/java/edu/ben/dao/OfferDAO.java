package edu.ben.dao;

import java.util.List;

import edu.ben.model.Offer;

public interface OfferDAO {

	public void createOffer(Offer offer);

	public void saveOrUpdate(Offer offer);

	public void deleteOffer(Offer offer);

	public List<Offer> getOffersByUserId(int id);
	
	public List<Offer> getActiveOffersByUserId(int id);
	
	public List<Offer> getPendingOffersByUserId(int id);

	public List<Offer> getOffersByListingId(int id);
	
	public List<Offer> getActiveOffersByListingId(int id);
	
	public List<Offer> getPendingOffersByListingId(int id);
	
	public Offer getOfferById(int id);
	
	public Offer getOfferByUserAndListingId(int userID, int listingID);
	
}
