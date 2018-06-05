package edu.ben.dao;

import edu.ben.model.CalendarEvent;
import edu.ben.model.Video;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class VideoDAOImpl implements VideoDAO  {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List getAllVideos() {
        Query q = getSession().createQuery("FROM video order by date_created desc");

        return q.list();
    }

    @Override
    public void deleteVideo(int id) {
        Video v = (Video) getSession().get(Video.class, id);
        getSession().delete(v);
    }

    @Override
    public void saveOrUpdate(Video video) {
        getSession().saveOrUpdate(video);
    }

    @Override
    public void create(Video video) {
        getSession().save(video);
    }

    @Override
    public Video getNewestVideo() {
        Query q = getSession().createQuery("FROM video order by date_created desc");

        return (Video) q.uniqueResult();
    }

    @Override
    public Video getVideoByID(int id) {
        Query q = getSession().createQuery("FROM video WHERE videoID=" + id);

        return (Video) q.uniqueResult();
    }

    @Override
    public Video getVideoByType(String type) {
        Query q = getSession().createQuery("FROM video WHERE type='" + type +"'");

        return (Video) q.uniqueResult();
    }
}
