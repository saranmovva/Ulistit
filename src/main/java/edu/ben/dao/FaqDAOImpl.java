package edu.ben.dao;

import edu.ben.model.Faq;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class FaqDAOImpl implements FaqDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List getAllFaqs() {
        return getSession().createQuery("FROM faq ORDER BY category").list();
    }

    @Override
    public int save(Faq faq) {
        return (int) getSession().save(faq);
    }

    @Override
    public void update(Faq faq) {
        getSession().update(faq);
    }

    @Override
    public void remove(Faq faq) {
        getSession().delete(faq);
    }

    @Override
    public Faq getByFaqID(int id) {
        return (Faq) getSession().createQuery("FROM faq WHERE question_id=" + id).uniqueResult();
    }
}
