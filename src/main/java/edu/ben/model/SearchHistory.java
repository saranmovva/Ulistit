package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity(name = "search_history")
@Table(name = "search_history")
@Transactional
public class SearchHistory {

    @Id
    @Column(name = "search_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int searchID;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "search")
    private String search;

    @Column(name = "date_created")
    private Timestamp dateCreatd;

    @Column(name = "search_count")
    private int searchCount;

    @OneToOne
    @JoinColumn(name = "search_category")
    private Category category;

    @OneToOne
    @JoinColumn(name = "search_subcategory")
    private Subcategory subcategory;

    public SearchHistory() {
    }

    public SearchHistory(User user, String search) {
        this.user = user;
        this.search = search;
    }

    public int getSearchID() {
        return searchID;
    }

    public void setSearchID(int searchID) {
        this.searchID = searchID;
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

    public Timestamp getDateCreatd() {
        return dateCreatd;
    }

    public void setDateCreatd(Timestamp dateCreatd) {
        this.dateCreatd = dateCreatd;
    }

    public int getSearchCount() {
        return searchCount;
    }

    public void setSearchCount(int searchCount) {
        this.searchCount = searchCount;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Subcategory getSubcategory() {
        return subcategory;
    }

    public void setSubcategory(Subcategory subcategory) {
        this.subcategory = subcategory;
    }
}
