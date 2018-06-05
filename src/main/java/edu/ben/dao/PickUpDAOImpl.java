package edu.ben.dao;

import edu.ben.model.PickUp;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PickUpDAOImpl implements PickUpDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(PickUp pickUp) {
        getSession().save(pickUp);
    }

    @Override
    public void update(PickUp pickUp) {
        getSession().update(pickUp);
    }

    @Override
    public PickUp getPickUpByListingID(int id) {
        SQLQuery q = getSession().createSQLQuery
                ("select p.* from pick_up as p inner join transaction as t on p.transaction_id=t.transaction_ID where t.listing_ID=" + id + ";").addEntity(PickUp.class);
        return (PickUp) q.uniqueResult();
    }

    @Override
    public PickUp getPickUpByPickUpID(int id) {
        Query q = getSession().createQuery("FROM pick_up WHERE pick_up_id=:id");
        q.setParameter("id", id);
        return (PickUp) q.uniqueResult();
    }

    @Override
    public List getAllActive() {
        return getSession().createQuery("FROM pick_up WHERE active=1").list();
    }

}
