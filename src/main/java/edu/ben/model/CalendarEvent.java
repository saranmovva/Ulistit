package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity(name = "events")
@Table(name = "events")
@Transactional
public class CalendarEvent {

    @Id
    @Column(name = "eventsId")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int eventId;

    @Column(name = "title")
    private String title;

    @Column(name = "location")
    private String location;

    @Column(name = "description")
    private String description;

    @Column(name = "start_date")
    private Timestamp startTime;

    @Column(name = "end_date")
    private Timestamp endTime;

    @Column(name = "active")
    private int active;

    public CalendarEvent() {

    }

    public CalendarEvent(String title, String location, Timestamp startTime, Timestamp endTime, String description, int active) {
        super();
        this.title = title;
        this.location = location;
        this.description = description;
        this.startTime = startTime;
        this.endTime = endTime;
        this.active = active;
    }

    public CalendarEvent(int eventId, String title, String location, Timestamp startTime, Timestamp endTime, String description, int active) {
        super();
        this.eventId = eventId;
        this.title = title;
        this.location = location;
        this.description = description;
        this.startTime = startTime;
        this.endTime = endTime;
        this.active = active;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }


    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }


    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }
}
