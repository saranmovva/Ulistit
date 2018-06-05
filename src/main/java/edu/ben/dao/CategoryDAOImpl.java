package edu.ben.dao;

import java.util.List;

import edu.ben.model.Subcategory;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import edu.ben.model.Category;

@Transactional
@Repository
public class CategoryDAOImpl implements CategoryDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(Category category) {
        getSession().save(category);
    }

    @Override
    public void save(Subcategory subcategory) {
        getSession().save(subcategory);
    }

    @Override
    public void saveOrUpdate(Category category) {
        getSession().saveOrUpdate(category);
    }

    @Override
    public void deleteCategory(String category) {
        getSession().delete(category);
    }

    @Override
    public List getSubCategoriesByCategory(String cat) {
        Query q = getSession().createQuery("FROM sub_category WHERE category=:cat");
        q.setParameter("cat", cat);
        return q.list();
    }

    @Override
    public List getAllCategories() {
        Query q = getSession().createQuery("FROM category");
        return q.list();
    }

    @Override
    public List getAllSubCategories() {
        Query q = getSession().createQuery("FROM sub_category");
        return q.list();
    }

}
