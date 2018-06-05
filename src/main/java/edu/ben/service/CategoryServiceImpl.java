package edu.ben.service;

import java.util.List;

import javax.transaction.Transactional;

import edu.ben.model.Subcategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.ben.dao.CategoryDAO;
import edu.ben.model.Category;

@Service
@Transactional
public class CategoryServiceImpl implements CategoryService {

    CategoryDAO categoryDAO;

    @Autowired
    public void setCategoryDAO(CategoryDAO categoryDAO) {
        this.categoryDAO = categoryDAO;
    }

    @Override
    public void save(Category category) {
        categoryDAO.save(category);
    }

    @Override
    public void save(Subcategory subcategory) {
        categoryDAO.save(subcategory);
    }

    @Override
    public List getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    @Override
    public List getAllSubCategories() {
        return categoryDAO.getAllSubCategories();
    }

    @Override
    public void saveOrUpdate(Category category) {
        categoryDAO.saveOrUpdate(category);
    }

    @Override
    public void deleteCategory(String category) {
        categoryDAO.deleteCategory(category);
    }

    @Override
    public List getSubCategoriesByCategory(String cat) {
        return categoryDAO.getSubCategoriesByCategory(cat);
    }
}
