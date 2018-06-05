package edu.ben.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import edu.ben.model.Favorite;
import edu.ben.model.Listing;
import edu.ben.model.User;

@Transactional
@Repository
public class FavoriteDAOImpl implements FavoriteDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public void create(Favorite favorite) {
		getSession().save(favorite);
	}

	public void saveOrUpdate(Favorite favorite) {
		getSession().saveOrUpdate(favorite);
	}

	public void delete(int id) {
		Favorite f = (Favorite) getSession().get(Favorite.class, id);
		getSession().delete(f);

	}

	@Override
	public Favorite findFavorite(int listingID, int userID) {
		Query query = getSession().createQuery(
				"From favorite WHERE listingID=" + listingID + " AND userID=" + userID + "");
		int result = query.executeUpdate();

		return (Favorite)query.uniqueResult();
	}

	@Override
	public List findAllFavorites() {
		Query query = getSession().createQuery("From favorite");

		return query.list();
	}

	@Override
	public boolean isWatched(int listingID, int userID) {
		Query query = getSession().createQuery("FROM favorite WHERE userID=:userID AND listingID=:listingID");
		query.setParameter("userID", userID);
		query.setParameter("listingID", listingID);

		List list = query.list();

		if (list.size() == 0) {
			System.out.println("User is not watching");
			return false;
		} else {
			System.out.println("User is watching");
			return true;
		}

	}

	@Override
	public List<Favorite> findAllFavoritesByUser(int userID) {
		Query query = getSession().createQuery("FROM favorite WHERE userID=:userID");
		query.setParameter("userID", userID);

		List list = query.list();
		return list;
	}

}
