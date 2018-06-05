package edu.ben.service;

import edu.ben.model.News;

import java.util.List;

public interface NewsService {
	public void delete(int id);

	public void saveOrUpdate(News news);

	public void create(News news);

	public int save(News news);

	public News getArticleByID(int id);

	public List getAllArticles();

	public List sortNewsByDateASC();

	public List sortNewsByDateDESC();

	public List sortNewsArticlesByNameASC();

	public List getAllDisplayedArticles();

	public List sortNewsArticlesByNameDESC();
}
