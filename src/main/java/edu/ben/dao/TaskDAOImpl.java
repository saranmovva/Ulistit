package edu.ben.dao;

import edu.ben.model.Task;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.OneToOne;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Repository
public class TaskDAOImpl implements TaskDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void delete(int i) {
        Task t = (Task) getSession().get(Task.class, i);
        getSession().delete(t);
    }

    @Override
    public void saveOrUpdate(Task task) {
        getSession().saveOrUpdate(task);
    }

    @Override
    public void create(Task task) {
        getSession().save(task);
    }

    @Override
    public List getAllTasks() {
        Query q = getSession().createQuery("FROM task_manager");
        return q.list();

    }

    @Override
    public Task getAllTasksByTaskID(int id) {
        Query q = getSession().createQuery("FROM task_manager WHERE task_ID=:id");
        q.setParameter("id", id);
        return (Task) q.uniqueResult();
    }

    @Override
    public List getAllTasksPerUser(int id) {
        Query q = getSession().createQuery("FROM admin_task WHERE userID=" + id +")");
        return q.list();
    }

}
