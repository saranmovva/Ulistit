package edu.ben.service;

import edu.ben.model.Video;

import java.util.List;

public interface VideoService {

    public List<Video> getAllVideos();

    public void deleteVideo(int id);

    public void saveOrUpdate(Video video);

    public void create(Video video);

    public Video getVideoByID(int id);

    public List getDisplayVideos();

    public Video getNewestVideo();

}

