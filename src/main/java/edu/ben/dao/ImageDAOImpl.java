package edu.ben.dao;

import edu.ben.model.Image;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class ImageDAOImpl implements ImageDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession(){ return sessionFactory.getCurrentSession();}

    @Override
    public int save(Image image) {
        return (Integer) getSession().save(image);
    }

    @Override
    public void saveOrUpdate(Image image) {
        getSession().saveOrUpdate(image);
    }

    @Override
    public List<Image> getImagesByListingId(int listingId) {
        Query q = getSession().createQuery("FROM image where listing_Id=" + listingId);
        return q.list();
    }

    @Override
    public List<Image> getImagesByUserId(int userId) {
        Query q = getSession().createQuery("FROM image where user_Id=" + userId);
        return q.list();
    }

    @Override
    public void removeAllMainImages(int userId) {
        Query q = getSession().createQuery("UPDATE image SET main=0 WHERE user_Id=" + userId );
        q.executeUpdate();
    }

    @Override
    public void changeMain(int imageId, int main) {
        Query q = getSession().createQuery("UPDATE image SET main=" + main + " WHERE idimage=" + imageId );
        q.executeUpdate();
    }


}