package edu.ben.model;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.*;
import javax.transaction.Transactional;

@Entity(name = "category")
@Table(name = "category")
@Transactional
public class Category {

    @Id
    @Column(name = "category")
    private String category;

    @OneToOne
    @JoinColumn(name = "created_by")
    private User createdBy;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @Column(name = "image_file")
    private String image;

    @OneToMany(mappedBy = "category", fetch = FetchType.EAGER)
    private List<Subcategory> subCategories;

    public Category() {
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
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

    public List<Subcategory> getSubCategories() {
        return subCategories;
    }

    public void setSubCategories(List<Subcategory> subCategories) {
        this.subCategories = subCategories;
    }


    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
