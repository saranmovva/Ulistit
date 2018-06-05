package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity(name = "video")
@Table(name = "video")
@Transactional
public class Video {
    @Id
    @Column(name = "video_ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int videoID;



    @Column(name = "title")
    private String title;

    @Column(name = "video_path")
    private String videoPath;

    @Column(name = "date_created")
    private Timestamp dateCreated;

    @Column(name = "type")
    private String type;

    public Video() {

    }

    public Video(int videoID, String title, String videoPath, Timestamp dateCreated) {
        this.videoID = videoID;
        this.title = title;
        this.videoPath = videoPath;
        this.dateCreated = dateCreated;
    }

    public Video(String title, String videoPath, Timestamp dateCreated) {
        this.title = title;
        this.videoPath = videoPath;
        this.dateCreated = dateCreated;
    }

    public Video(String title, String videoPath) {
        this.title = title;
        this.videoPath = videoPath;
    }

    public int getVideoID() {
        return videoID;
    }

    public void setVideoID(int videoID) {
        this.videoID = videoID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPath) {
        this.videoPath = videoPath;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
