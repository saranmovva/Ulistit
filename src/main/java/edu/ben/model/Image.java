package edu.ben.model;


import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;

@Entity(name = "image")
@Table(name = "image")
@Transactional
public class Image {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idimage")
    private int id;

    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinColumn(name = "user_Id", nullable = true)
    private User user;

    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinColumn(name = "listing_Id")
    private Listing listingId;

    @Column(name = "image_path")
    private String image_path;

    @Column(name = "image_name")
    private String image_name;

    @Column(name = "main")
    private int main;

    public Image() {

    }

    public Image(User user, String image_path, String image_name, int main) {
        this.user = user;
        this.image_path = image_path;
        this.image_name = image_name;
        this.main = main;
    }

    public Image(Listing listing, String image_path, String image_name, int main) {
        this.listingId = listing;
        this.image_path = image_path;
        this.image_name = image_name;
        this.main = main;
    }

    public Image(User user, Listing listing, String image_path, String image_name, int main) {
        this.user = user;
        this.listingId = listing;
        this.image_path = image_path;
        this.image_name = image_name;
        this.main = main;
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

    public Listing getListing() {
        return listingId;
    }

    public void setListing(Listing listing) {
        this.listingId = listing;
    }

    public String getImage_path() {
        return image_path;
    }

    public void setImage_path(String image_path) {
        this.image_path = image_path;
    }

    public String getImage_name() {
        return image_name;
    }

    public void setImage_name(String image_name) {
        this.image_name = image_name;
    }

    public int getMain() {
        return main;
    }

    public void setMain(int main) {
        this.main = main;
    }

    @Override
    public String toString(){
        return image_path+ "/" + image_name;
    }
}
