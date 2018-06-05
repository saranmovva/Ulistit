package edu.ben.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.transaction.Transactional;

@Entity(name = "review")
@Table(name = "review")
@Transactional
public class Review {

	@Id
	@Column(name = "review")
	private String review;

	@OneToOne
	@JoinColumn(name = "sellerID")
	private User seller;
	
	@OneToOne
	@JoinColumn(name = "buyerID")
	private User buyer;

	public Review() {

	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}


}
