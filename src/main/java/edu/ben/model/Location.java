package edu.ben.model;

import javax.persistence.*;
import java.sql.Timestamp;

@Table(name = "pick_up_location")
@Entity(name = "pick_up_location")
public class Location {

    @Id
    @Column(name = "location_id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int locationID;

    @Column(name = "name")
    private String name;

    @Column(name = "latitude")
    private float latitude;

    @Column(name = "longitude")
    private float longitude;

    @Column(name = "safe_zone")
    private int safeZone;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @Column(name = "active")
    private int active;

    public Location() {
    }

    public Location(String name, float latitude, float longitude) {
        this.name = name;
        this.latitude = latitude;
        this.longitude = longitude;
        this.active = 1;
    }

    public Location(float latitude, float longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.active = 1;
    }

    public int getLocationID() {
        return locationID;
    }

    public void setLocationID(int locationID) {
        this.locationID = locationID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public int getSafeZone() {
        return safeZone;
    }

    public void setSafeZone(int safeZone) {
        this.safeZone = safeZone;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }
}
