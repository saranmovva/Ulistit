package edu.ben.dao;

import edu.ben.model.CalendarEvent;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class EventsDAOImpl implements EventsDAO {
    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void delete(int id) {
        CalendarEvent n = (CalendarEvent) getSession().get(CalendarEvent.class, id);
        getSession().delete(n);

    }

    @Override
    public void saveOrUpdate(CalendarEvent events) {
        getSession().saveOrUpdate(events);

    }

    @Override
    public void create(CalendarEvent events) {
        getSession().save(events);

    }

    @Override
    public List getAllEvents() {
        Query q = getSession().createQuery("FROM events WHERE start_date > CURRENT_TIMESTAMP order by start_date asc");

        if (q.list() != null) {
            return q.list();
        } else {
            return null;
        }

    }

    @Override
    public List getActiveAndInactiveListings() {
        Query q = getSession().createQuery("FROM events order by start_date asc");

        return q.list();

    }

    @Override
    public CalendarEvent getEventsByID(int id) {
        Query q = getSession().createQuery("FROM events WHERE eventsId=:id");

        q.setParameter("id", id);


        CalendarEvent n = (CalendarEvent) q.uniqueResult();

        return n;
    }

}
