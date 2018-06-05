package edu.ben.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import edu.ben.model.Review;

@Transactional
@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Review> getReviewsBySellerId(int id) {

		Query q = getSession().createQuery("FROM review WHERE sellerID=:id");
		q.setInteger("id", id);
		List<Review> reviews = q.list();

		return reviews;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Review> getReviewsByBuyerId(int id) {

		Query q = getSession().createQuery("FROM review WHERE buyerID=:id");
		q.setInteger("id", id);
		List<Review> reviews = q.list();

		return reviews;

	}

	@Override
	public void createReview(Review review) {
		getSession().save(review);
	}

	@Override
	public void saveOrUpdate(Review review) {
		getSession().saveOrUpdate(review);
	}

	@Override
	public void deleteReview(String review) {
		getSession().delete(review);
	}

}
