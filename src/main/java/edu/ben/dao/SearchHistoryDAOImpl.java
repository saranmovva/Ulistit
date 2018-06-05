package edu.ben.dao;

import edu.ben.model.SearchHistory;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class SearchHistoryDAOImpl implements SearchHistoryDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(SearchHistory searchHistory) {
        getSession().save(searchHistory);
    }

    @Override
    public void update(SearchHistory searchHistory) {
        getSession().update(searchHistory);
    }

    @Override
    public List getAllSearchesByUserID(int userID) {
        Query q = getSession().createQuery("FROM search_history WHERE user_id=:userID ORDER BY date_created DESC");
        q.setParameter("userID", userID);
        return q.list();
    }

    @Override
    public SearchHistory exists(SearchHistory searchHistory) {
        Query q = getSession().createQuery("FROM search_history WHERE user_id=:userID AND search=:search");
        q.setParameter("userID", searchHistory.getUser().getUserID());
        q.setParameter("search", searchHistory.getSearch());
        return (SearchHistory) q.uniqueResult();
    }
}
