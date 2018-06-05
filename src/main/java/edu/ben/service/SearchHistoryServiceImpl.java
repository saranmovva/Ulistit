package edu.ben.service;

import edu.ben.dao.CategoryDAO;
import edu.ben.dao.SearchHistoryDAO;
import edu.ben.model.SearchHistory;
import edu.ben.model.Subcategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.UnexpectedRollbackException;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class SearchHistoryServiceImpl implements SearchHistoryService {

    SearchHistoryDAO searchHistoryDAO;

    @Autowired
    public void setSearchHistoryDAO(SearchHistoryDAO searchHistoryDAO) {
        this.searchHistoryDAO = searchHistoryDAO;
    }

    CategoryDAO categoryDAO;

    @Autowired
    public void setCategoryDAO(CategoryDAO categoryDAO) {
        this.categoryDAO = categoryDAO;
    }

    @Override
    public void save(SearchHistory searchHistory) {

        // If search already exists, update search count
        SearchHistory existingSearch = searchHistoryDAO.exists(searchHistory);
        if (existingSearch != null) {
            existingSearch.setSearchCount(existingSearch.getSearchCount() + 1);
            searchHistoryDAO.update(existingSearch);

        } else {

            // Get all words in search
            char[] searchArray = searchHistory.getSearch().toCharArray();
            List<String> searchWords = new ArrayList<String>(searchArray.length);

            String currentWord = "";
            for (int i = 0; i < searchArray.length; i++) {
                if (searchArray[i] == ' ' && currentWord.length() > 0) {
                    searchWords.add(currentWord.toUpperCase());
                    currentWord = "";
                } else {
                    currentWord += searchArray[i];
                }

                if (i == searchArray.length - 1) {
                    searchWords.add(currentWord.toUpperCase());
                    currentWord = "";
                }
            }

            // BUG: check for more than one word
            // Check if search contains categories or subcategories
            List<Subcategory> subs = categoryDAO.getAllSubCategories();
            for (Subcategory s : subs) {
                if (searchWords.contains(s.getSubCategory().toUpperCase())) {
                    searchHistory.setSubcategory(s);
                }

                if (searchWords.contains(s.getCategory().getCategory().toUpperCase())) {
                    searchHistory.setCategory(s.getCategory());
                }
            }

            searchHistoryDAO.save(searchHistory);

        }
    }

    @Override
    public List getAllSearchesByUserID(int userID) {
        return searchHistoryDAO.getAllSearchesByUserID(userID);
    }
}
