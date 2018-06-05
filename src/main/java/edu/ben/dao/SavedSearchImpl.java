package edu.ben.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import edu.ben.model.SavedSearch;

@Transactional
@Repository
public class SavedSearchImpl implements SavedSearchDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public void deleteSavedSearch(int id) {
		SavedSearch s = (SavedSearch) getSession().get(SavedSearch.class, id);
		getSession().delete(s);

	}

	@Override
	public void saveOrUpdate(SavedSearch search) {
		getSession().saveOrUpdate(search);

	}

	@Override
	public void create(SavedSearch search) {
		getSession().save(search);

	}

	@Override
	public boolean isSaved(int userID, String search) {
		Query q = getSession().createQuery("FROM saved_searches WHERE userID=:userID AND search=:search");

		q.setParameter("userID", userID);
		q.setParameter("search", search);

		SavedSearch s = (SavedSearch) q.uniqueResult();

		if (s == null) {
			return false;
		}
		System.out.println("Saved UserID: " + s.getUser().getUserID());
		return true;
	}

	@Override
	public SavedSearch getSearch(int userID, String search) {
		Query q = getSession().createQuery("FROM saved_searches WHERE userID=:userID AND search=:search");

		q.setParameter("userID", userID);
		q.setParameter("search", search);

		SavedSearch s = (SavedSearch) q.uniqueResult();

		return s;
	}

	@Override
	public List<SavedSearch> getAllSavedSearches() {
		Query q = getSession().createSQLQuery("SELECT * FROM saved_searches").addEntity(SavedSearch.class);
		
		List<SavedSearch> results = q.list();

		return results;
	}

}
