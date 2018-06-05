package edu.ben.service;

import java.util.List;

import edu.ben.model.Favorite;

public interface FavoriteService {
	
	public Favorite findFavorite(int listingID, int userID);
	
	public List findAllFavorites();
	
	public boolean isWatched(int listingID, int userID);
	
	public List<Favorite> findAllFavoritesByUser(int userID);
	
	public void delete(int id);

	public void saveOrUpdate(Favorite favorite);

	public void create(Favorite favorite);

}
