package edu.ben.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.ben.dao.OfferDAO;
import edu.ben.model.Offer;

@Service
@Transactional
public class OfferServiceImpl implements OfferService {
	
	OfferDAO offerDAO;
	
	@Autowired
	public void setOfferDAO(OfferDAO offerDAO) {
		this.offerDAO = offerDAO;
	}

	@Override
	public void createOffer(Offer offer) {
		offerDAO.createOffer(offer);
	}

	@Override
	public void saveOrUpdate(Offer offer) {
		offerDAO.saveOrUpdate(offer);
	}

	@Override
	public void deleteOffer(Offer offer) {
		offerDAO.deleteOffer(offer);
	}

	@Override
	public List<Offer> getOffersByUserId(int id) {
		return offerDAO.getOffersByUserId(id);
	}

	@Override
	public List<Offer> getOffersByListingId(int id) {
		return offerDAO.getOffersByListingId(id);
	}

	@Override
	public Offer getOfferById(int id) {
		return offerDAO.getOfferById(id);
	}

	@Override
	public Offer getOfferByUserAndListingId(int userID, int listingID) {
		return offerDAO.getOfferByUserAndListingId(userID, listingID);
	}

	@Override
	public List<Offer> getActiveOffersByUserId(int id) {
		return offerDAO.getActiveOffersByUserId(id);
	}

	@Override
	public List<Offer> getActiveOffersByListingId(int id) {
		return offerDAO.getActiveOffersByListingId(id);
	}

	@Override
	public List<Offer> getPendingOffersByUserId(int id) {
		return offerDAO.getPendingOffersByUserId(id);
	}

	@Override
	public List<Offer> getPendingOffersByListingId(int id) {
		return offerDAO.getPendingOffersByListingId(id);
	}

}
