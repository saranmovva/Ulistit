package edu.ben.dao;

import edu.ben.model.AdminTask;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class AdminTaskImpl implements AdminTaskDAO{

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void delete(int id) {
        AdminTask n = (AdminTask) getSession().get(AdminTask.class, id);
        getSession().delete(n);
    }

    @Override
    public void saveOrUpdate(AdminTask task) {
        getSession().saveOrUpdate(task);
    }

    @Override
    public void create(AdminTask task) {
        getSession().save(task);
    }

    @Override
    public List getAllTasksByUserID(int userID) {
        Query q = getSession().createQuery("FROM admin_task WHERE ID_User=:userID");
        q.setParameter("userID", userID);
        return q.list();
    }

    @Override
    public List getAlllTasksByTaskID(int taskID) {
        Query q = getSession().createQuery("FROM admin_task WHERE ID_Task=:taskID");
        q.setParameter("taskID", taskID);
        return q.list();
    }

    @Override
    public List getAllAdminTasks() {
        Query q = getSession().createQuery("FROM admin_task");
        return q.list();
    }
}
