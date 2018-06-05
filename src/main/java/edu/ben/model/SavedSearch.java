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

@Entity(name = "saved_searches")
@Table(name = "saved_searches")
@Transactional
public class SavedSearch {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	int id;

	@OneToOne
	@JoinColumn(name = "userID")
	User user;

	@Column(name = "search")
	String search;

	public SavedSearch() {

	}

	public SavedSearch(String search) {
		this.search = search;
	}

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

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

}
