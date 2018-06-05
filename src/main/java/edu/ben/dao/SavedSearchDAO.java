package edu.ben.dao;

import java.util.List;

import edu.ben.model.SavedSearch;

public interface SavedSearchDAO {

	public void deleteSavedSearch(int id);

	public void saveOrUpdate(SavedSearch search);

	public void create(SavedSearch search);
	
	public boolean isSaved(int userID, String search);
	
	public SavedSearch getSearch(int userID, String search);
	
	public List<SavedSearch> getAllSavedSearches();

}
