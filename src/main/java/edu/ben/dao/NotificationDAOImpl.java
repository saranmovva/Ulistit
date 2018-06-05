package edu.ben.dao;

import edu.ben.model.Notification;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class NotificationDAOImpl implements NotificationDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(Notification notification) {
        getSession().save(notification);
    }

    @Override
    public void update(Notification notification) {
        getSession().update(notification);
    }

    @Override
    public void deactivate(int notificationID) {
        SQLQuery q = getSession().createSQLQuery("UPDATE notification SET active=0 WHERE notification_id=:id").addEntity(Notification.class);
        q.setParameter("id", notificationID);
        q.executeUpdate();
    }

    @Override
    public List<Notification> getActiveByUserID(int userID) {
        Query q = getSession().createQuery("FROM notification WHERE active=1 AND user_id=:userID ORDER BY date_created desc");
        q.setParameter("userID", userID);
        return (List<Notification>) q.list();
    }

    @Override
    public List<Notification> getNotDismissedByUserID(int userID) {
        Query q = getSession().createQuery("FROM notification WHERE active=1 AND dismissed=0 AND user_id=:userID ORDER BY date_created desc");
        q.setParameter("userID", userID);
        return (List<Notification>) q.list();
    }

    @Override
    public void dismiss(int id) {
        SQLQuery q = getSession().createSQLQuery("UPDATE notification SET dismissed=1 WHERE notification_id=:id").addEntity(Notification.class);
        q.setParameter("id", id);
        q.executeUpdate();
    }

    @Override
    public Notification getByNotificationID(int id) {
        Query q = getSession().createQuery("FROM notification WHERE notification_id=:id");
        q.setParameter("id", id);
        return (Notification) q.uniqueResult();
    }

    @Override
    public List<Notification> getAllActive() {
        return (List<Notification>) getSession().createQuery("FROM notification WHERE active=1").list();
    }
}
