package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Entity(name = "listing")
@Table(name = "listing")
@Transactional
public class Listing implements java.io.Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @OneToOne
    @JoinColumn(name = "userID")
    private User user;

    @Column(name = "name")
    @NotBlank
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "category")
    private String category;

    @Column(name = "sub_category")
    private String subCategory;

    @Column(name = "price")
    private int price;

    @Column(name = "date_created")
    private Date dateCreated;

    @Column(name = "type")
    public String type;

    @OneToOne
    @JoinColumn(name = "highest_bid_userID")
    private User highestBidder;

    @Column(name = "highest_bid")
    private Integer highestBid;

    @Column(name = "bid_count")
    private int bidCount;

    @Column(name = "start_timestamp")
    private Timestamp startTimestamp;

    @Column(name = "end_timestamp")
    private Timestamp endTimestamp;

    @Column(name = "ended")
    private int ended;

    @Column(name = "active")
    private int active;

    @Column(name = "premium")
    private int premium;

    @Column(name = "draft")
    private int draft;

    @OneToMany(mappedBy = "listingId",  fetch = FetchType.EAGER)
    private List<Image> images;

    @Column(name = "payment_type")
    public String paymentType;


    // Constructors

    public Listing() {
        this.highestBid = 0;
        this.bidCount = 0;
    }

    public Listing(int id, String name, int highestBid, String type, int price, Timestamp endTimeStamp, int active) {
        this.id = id;
        this.name = name;
        this.highestBid = highestBid;
        this.type = type;
        this.price = price;
        this.endTimestamp = endTimeStamp;
        this.active = active;
    }

    public Listing(@NotBlank int id, @NotBlank String name, String description, @NotBlank int price, @NotBlank String paymentType) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        // this.category = category;
        this.paymentType = paymentType;
        this.highestBid = 0;
        this.bidCount = 0;
        this.active = 1;
    }

    public Listing(@NotBlank int id, @NotBlank String name, String description, @NotBlank int price, String category, @NotBlank String paymentType) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.paymentType = paymentType;
        this.highestBid = 0;
        this.bidCount = 0;
        this.active = 1;
    }

    public Listing(@NotBlank int id, @NotBlank String name, String description, @NotBlank int price, String category, @NotBlank String paymentType, int draft) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.paymentType = paymentType;
        this.highestBid = 0;
        this.bidCount = 0;
        this.active = 1;
        this.draft = 1;
    }

    public Listing(@NotBlank String name, String description, @NotBlank int price, @NotBlank String paymentType) {
        super();
        this.name = name;
        this.description = description;
        this.price = price;
        this.paymentType = paymentType;
        this.highestBid = 0;
        this.bidCount = 0;
        this.active = 1;
    }

    public Listing(@NotBlank String name, String description, @NotBlank int price, @NotBlank String category,
                   @NotBlank String paymentType) {
        super();
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
        this.paymentType = paymentType;
        this.highestBid = 0;
        this.bidCount = 0;
        this.active = 1;
    }

    // Getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Listing{" +
                "id=" + id +
                ", user=" + user +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", category='" + category + '\'' +
                ", subCategory='" + subCategory + '\'' +
                ", price=" + price +
                ", dateCreated=" + dateCreated +
                ", type='" + type + '\'' +
                ", highestBidder=" + highestBidder +
                ", highestBid=" + highestBid +
                ", bidCount=" + bidCount +
                ", startTimestamp=" + startTimestamp +
                ", endTimestamp=" + endTimestamp +
                ", ended=" + ended +
                ", active=" + active +
                ", premium=" + premium +
                ", draft=" + draft +
                ", images=" + images +
                ", paymentType='" + paymentType + '\'' +
                '}';
    }

    public String getEndDate() {
        java.sql.Date date = new java.sql.Date(endTimestamp.getTime());
        return new SimpleDateFormat("MM/dd/yyyy").format(date);
    }

    public String getEndTime() {
        java.sql.Date date = new java.sql.Date(endTimestamp.getTime());
        return new SimpleDateFormat("hh:mm a").format(date);
    }


    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public User getHighestBidder() {
        return highestBidder;
    }

    public void setHighestBidder(User highestBidder) {
        this.highestBidder = highestBidder;
    }

    public int getHighestBid() {
        return highestBid;
    }

    public void setHighestBid(int highestBid) {
        this.highestBid = highestBid;
    }

    public int getBidCount() {
        return bidCount;
    }

    public void setBidCount(int bidCount) {
        this.bidCount = bidCount;
    }

    public Timestamp getStartTimestamp() {
        return startTimestamp;
    }

    public void setStartTimestamp(Timestamp startTimestamp) {
        this.startTimestamp = startTimestamp;
    }

    public Timestamp getEndTimestamp() {
        return endTimestamp;
    }

    public void setEndTimestamp(Timestamp endTimestamp) {
        this.endTimestamp = endTimestamp;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public int getEnded() {
        return ended;
    }

    public void setEnded(int ended) {
        this.ended = ended;
    }

    public long getDelay() {
        return endTimestamp.getTime() - System.currentTimeMillis();
    }

    public long getSecondsRemaining() {
        return (long) Math.floor(getDelay() / 1000);
    }

    public long getMinutesRemaining() {
        return (long) Math.floor(getDelay() / (60 * 1000));
    }

    public long getHoursRemaining() {
        return (long) Math.floor(getDelay() / (60 * 60 * 1000));
    }

    public long getDaysRemaining() {
        return (long) Math.floor(getDelay() / (24 * 60 * 60 * 1000));
    }

    public long getEndTimestampAsLong() {
        return endTimestamp.getTime();
    }

    public long getStartTimestampAsLong() {
        return startTimestamp.getTime();
    }

    public int getPremium() {
        return premium;
    }

    public void setPremium(int premium) {
        this.premium = premium;
    }

    public int getDraft() {
        return draft;
    }

    public void setDraft(int draft) {
        this.draft = draft;
    }

	public String getPercentLeft() {

        long now = System.currentTimeMillis();
        long start = startTimestamp.getTime();
        long end = endTimestamp.getTime();

        if (start >= end || now >= end) {
            return "0";
        }
        if (now <= start) {
            return "100";
        }
        return String.valueOf((int) ((end - now) * 100 / (end - start)));
    }

    public List<Image> getImages() { return images; }

    public void setImages(List<Image> images) {
        this.images = images;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }

    public void setHighestBid(Integer highestBid) {
        this.highestBid = highestBid;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }
}
