package edu.ben.model;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.*;
import javax.transaction.Transactional;

@Entity(name = "sub_category")
@Table(name = "sub_category")
@Transactional
public class Subcategory {

    @Id
    @Column(name = "sub_category")
    private String subCategory;

    @OneToOne
    @JoinColumn(name = "created_by")
    private User createdBy;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinColumn(name = "category")
    private Category category;

    public Subcategory() {
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }
}
