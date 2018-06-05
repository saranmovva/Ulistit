package edu.ben.dao;

import edu.ben.model.Video;

import java.util.List;

public interface VideoDAO {

    public List<Video> getAllVideos();

    public void deleteVideo(int id);

    public void saveOrUpdate(Video video);

    public void create(Video video);

    public Video getNewestVideo();

    public Video getVideoByID(int id);

    public Video getVideoByType(String type);


}
