package edu.ben.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.ben.dao.FavoriteDAO;
import edu.ben.model.Favorite;

@Service
@Transactional
public class FavoriteServiceImpl implements FavoriteService {
	
	FavoriteDAO fd;
	
	@Autowired
	public void setListingDAO(FavoriteDAO fd) {
		this.fd = fd;
	}

	@Override
	public Favorite findFavorite(int listingID, int userID) {
		return fd.findFavorite(listingID, userID);
	}

	@Override
	public List findAllFavorites() {
		return fd.findAllFavorites();
	}

	@Override
	public boolean isWatched(int listingID, int userID) {
		return fd.isWatched(listingID, userID);
		
	}

	@Override
	public void delete(int id) {
		fd.delete(id);
		
	}

	@Override
	public void saveOrUpdate(Favorite favorite) {
		fd.saveOrUpdate(favorite);
		
	}

	@Override
	public void create(Favorite favorite) {
		fd.create(favorite);
		
	}

	@Override
	public List<Favorite> findAllFavoritesByUser(int userID) {
		return fd.findAllFavoritesByUser(userID);
	}

}
