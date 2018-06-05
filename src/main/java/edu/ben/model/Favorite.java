package edu.ben.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.transaction.annotation.Transactional;

@Entity(name = "favorite")
@Table(name = "favorite")
@Transactional
public class Favorite {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "favoriteID")
	private int id;

	@OneToOne
	@JoinColumn(name = "userID")
	private User user;

	@OneToOne
	@JoinColumn(name = "listingID")
	private Listing listing;
	
	@Column(name = "userWatching")
	private int favorited;
	
	public Favorite () {

	}

//	public Favorite (int userID, int listingID) {
//		listing.setId(listingID);
//	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Listing getListing() {
		return listing;
	}

	public void setListing(Listing listing) {
		this.listing = listing;
	}
	
	public int getFavorited() {
		return favorited;
	}
	public void setFavorited(int favorited) {
		this.favorited = favorited;
	}

}
