package edu.ben.dao;

import java.util.List;

import edu.ben.model.Category;
import edu.ben.model.Subcategory;

public interface CategoryDAO {

    public void save(Category category);

    public void save(Subcategory subCategory);

    public void saveOrUpdate(Category category);

    public void deleteCategory(String category);

    List getSubCategoriesByCategory(String cat);

    public List getAllSubCategories();

    public List getAllCategories();

}
