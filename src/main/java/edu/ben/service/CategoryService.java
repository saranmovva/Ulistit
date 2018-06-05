package edu.ben.service;

import java.util.List;

import edu.ben.model.Category;
import edu.ben.model.Subcategory;

public interface CategoryService {

    public void save(Category category);

    public void saveOrUpdate(Category category);

    public void deleteCategory(String category);

    List getSubCategoriesByCategory(String cat);

    public void save(Subcategory subcategory);

    public List getAllCategories();

    public List getAllSubCategories();

}
