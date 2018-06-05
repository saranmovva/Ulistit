package edu.ben.dao;

import edu.ben.model.Checklist;
import edu.ben.model.ChecklistItem;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class ChecklistDAOImpl implements ChecklistDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(Checklist checklist) {
        getSession().save(checklist);
    }

    @Override
    public void save(ChecklistItem checklistItem) {
        getSession().save(checklistItem);
    }

    @Override
    public void update(Checklist checklist) {
        getSession().update(checklist);
    }

    @Override
    public void update(ChecklistItem checklistItem) {
        getSession().update(checklistItem);
    }

    @Override
    public List getByUserID(int userID) {
        Query q = getSession().createQuery("FROM checklist WHERE user_id=:id AND active=1 ORDER BY status ASC");
        q.setParameter("id", userID);
        return q.list();
    }

    @Override
    public Checklist getByUserIDAndType(int userID, String type) {
        Query q = getSession().createQuery("FROM checklist WHERE user_id=:id AND type=:type AND active=1 ORDER BY status ASC");
        q.setParameter("id", userID);
        q.setParameter("type", type);
        return (Checklist) q.uniqueResult();
    }

    @Override
    public void delete(ChecklistItem item) {
        getSession().delete(item);
    }

    @Override
    public Checklist getAdminChecklist() {
        return (Checklist) getSession().createQuery("FROM checklist WHERE type='admin' AND active=1 ORDER BY date_created DESC").list().get(0);
    }

    @Override
    public Checklist getByChecklistID(int id) {
        Query q = getSession().createQuery("FROM checklist WHERE checklist_id=:id AND active=1");
        q.setParameter("id", id);
        return (Checklist) q.uniqueResult();
    }
}
