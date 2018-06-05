package edu.ben.dao;

import edu.ben.model.SalesTraffic;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class SalesTrafficDAOImpl implements SalesTrafficDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }


    @Override
    public int create(SalesTraffic s) {
       return (int) getSession().save(s);
    }

    @Override
    public void saveOrUpdate(SalesTraffic s) {
        getSession().saveOrUpdate(s);
    }

    @Override
    public long getCountByPageByDay(String pageName, String date) {
        try {
            Query q = getSession().createQuery("SELECT Count(pageVisited) FROM sales_traffic WHERE pageVisited='" + pageName + "' AND DATE_FORMAT(dateCreated, '%Y-%M-%d') = '" + date + "'");
            return (long) q.uniqueResult();

        } catch (NullPointerException e) {
            return 0;
        }


    }

    @Override
    public long getCountByPageByWeek(String pageName, String date1, String date2) {
        try {
            Query q = getSession().createQuery("SELECT Count(pageVisited) FROM sales_traffic WHERE pageVisited='" + pageName + "' AND DATE_FORMAT(dateCreated, '%Y-%M-%d') BETWEEN '" + date1 + "' AND '" + date2 + "'");
            return (long) q.uniqueResult();

        } catch (NullPointerException e) {
            return 0;
        }
    }

    @Override
    public long getCountByPageByMonth(String pageName, String date) {
        try {
            Query q = getSession().createQuery("SELECT Count(pageVisited) FROM sales_traffic WHERE pageVisited='" + pageName + "' AND DATE_FORMAT(dateCreated, '%Y-%M') = '" + date + "'");
            return (long) q.uniqueResult();

        } catch (NullPointerException e) {
            return 0;
        }
    }

    @Override
    public long getCountByPageByYear(String pageName, String date) {
        try {
            Query q = getSession().createQuery("SELECT Count(pageVisited) FROM sales_traffic WHERE pageVisited='" + pageName + "' AND DATE_FORMAT(dateCreated, '%Y') = '" + date + "'");
            return (long) q.uniqueResult();

        } catch (NullPointerException e) {
            return 0;
        }
    }

    @Override
    public List<String> getMostRecentPage(int userID) {
        return (List<String>) getSession().createQuery("SELECT pageVisited FROM sales_traffic WHERE userID=" + userID +
        " ORDER BY dateCreated DESC").list();
    }
}
