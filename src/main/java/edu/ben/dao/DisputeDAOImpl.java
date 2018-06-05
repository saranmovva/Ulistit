package edu.ben.dao;

import edu.ben.model.Dispute;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class DisputeDAOImpl implements DisputeDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(Dispute dispute) {
        getSession().save(dispute);
    }

    @Override
    public void update(Dispute dispute) {
        getSession().update(dispute);
    }

    @Override
    public Dispute getByID(int id) {
        Query q = getSession().createQuery("FROM dispute WHERE dispute_id=:id");
        q.setParameter("id", id);
        return (Dispute) q.uniqueResult();
    }

    @Override
    public List getAllActive() {
        return getSession().createQuery("FROM dispute WHERE status != 'resolved' ORDER BY date_created DESC").list();
    }
}
