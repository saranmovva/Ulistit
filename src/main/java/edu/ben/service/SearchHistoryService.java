package edu.ben.service;

import edu.ben.model.SearchHistory;

import java.util.List;

public interface SearchHistoryService {

    public void save(SearchHistory searchHistory);

    public List getAllSearchesByUserID(int userID);
}