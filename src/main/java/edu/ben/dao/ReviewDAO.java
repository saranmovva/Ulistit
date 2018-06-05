package edu.ben.dao;

import java.util.List; 

import edu.ben.model.Review;

public interface ReviewDAO {

	public void createReview(Review review);
	
	public void saveOrUpdate(Review review);
	
	public void deleteReview(String review);

	List<Review> getReviewsBySellerId(int id);
	
	List<Review> getReviewsByBuyerId(int id);

}
