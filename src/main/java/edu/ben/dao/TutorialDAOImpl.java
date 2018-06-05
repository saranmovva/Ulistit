package edu.ben.dao;

import edu.ben.model.Tutorial;
import org.hibernate.NonUniqueObjectException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Transactional
@Repository
public class TutorialDAOImpl implements TutorialDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public int save(Tutorial tutorial) {
        return (int) getSession().save(tutorial);
    }

    @Override
    public void update(Tutorial tutorial) {
        try {
            getSession().saveOrUpdate(tutorial);
        } catch (NonUniqueObjectException e) {
            getSession().clear();
            getSession().update(tutorial);
        }
    }

    @Override
    public Tutorial getByUserID(int id) {
        return (Tutorial) getSession().createQuery("FROM tutorial WHERE user_id=" + id).uniqueResult();
    }
}
