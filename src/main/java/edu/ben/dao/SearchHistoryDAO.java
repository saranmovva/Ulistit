package edu.ben.dao;

import edu.ben.model.SearchHistory;

import java.util.List;

public interface SearchHistoryDAO {

    public void save(SearchHistory searchHistory);

    public void update(SearchHistory searchHistory);

    public List getAllSearchesByUserID(int userID);

    public SearchHistory exists(SearchHistory searchHistory);
}
