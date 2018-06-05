package edu.ben.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.ben.dao.SavedSearchDAO;
import edu.ben.model.SavedSearch;

@Service
@Transactional
public class SavedSearchServiceImpl implements SavedSearchService {
	
	SavedSearchDAO ssd;
	
	@Autowired
	public void setSavedSearchDAO(SavedSearchDAO ssd) {
		this.ssd = ssd;
	}

	@Override
	public void deleteSavedSearch(int id) {
		ssd.deleteSavedSearch(id);
		
	}

	@Override
	public void saveOrUpdate(SavedSearch search) {
		ssd.saveOrUpdate(search);
		
	}

	@Override
	public void create(SavedSearch search) {
		ssd.create(search);
		
	}

	@Override
	public boolean isSaved(int userID, String search) {
		return ssd.isSaved(userID, search);
	}

	@Override
	public SavedSearch getSearch(int userID, String search) {
		return ssd.getSearch(userID, search);
	}

	@Override
	public List<SavedSearch> getAllSavedSearches() {
		return ssd.getAllSavedSearches();
	}

}
