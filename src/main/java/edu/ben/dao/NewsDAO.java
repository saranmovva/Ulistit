package edu.ben.dao;

import edu.ben.model.News;

import java.util.List;

public interface NewsDAO {
	public void delete(int id);

	public void saveOrUpdate(News news);

	public void create(News news);

	public int save(News news);

	public List sortNewsByDateASC();

	public List sortNewsByDateDESC();

	public List sortNewsArticlesByNameASC();

	public List sortNewsArticlesByNameDESC();

	public News getArticleByID(int id);

	public News getArticleByType(String type);

	public List getAllArticles();
}
