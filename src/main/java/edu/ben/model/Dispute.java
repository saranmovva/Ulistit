package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.sql.Timestamp;

@Entity(name = "dispute")
@Table(name = "dispute")
@Transactional
public class Dispute {

    @Id
    @Column(name = "dispute_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int disputeID;

    @OneToOne
    @JoinColumn(name = "listing_id")
    private Listing listing;

    @OneToOne
    @JoinColumn(name = "accusing_id")
    private User accuser;

    @OneToOne
    @JoinColumn(name = "defending_id")
    private User defender;

    @Column(name = "complaint")
    @NotNull
    @Size(max = 200, message = "Complaint must be shorter than 200 characters")
    private String complaint;

    @Column(name = "status")
    private String status;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    public Dispute(Listing listing, User accuser, User defender, String complaint) {
        this.listing = listing;
        this.accuser = accuser;
        this.defender = defender;
        this.complaint = complaint;
    }

    public Dispute() {
    }

    public int getDisputeID() {
        return disputeID;
    }

    public void setDisputeID(int disputeID) {
        this.disputeID = disputeID;
    }

    public String getComplaint() {
        return complaint;
    }

    public void setComplaint(String complaint) {
        this.complaint = complaint;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Listing getListing() {
        return listing;
    }

    public void setListing(Listing listing) {
        this.listing = listing;
    }

    public User getAccuser() {
        return accuser;
    }

    public void setAccuser(User accuser) {
        this.accuser = accuser;
    }

    public User getDefender() {
        return defender;
    }

    public void setDefender(User defender) {
        this.defender = defender;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
