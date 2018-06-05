package edu.ben.dao;

import edu.ben.model.SalesTraffic;

import java.util.List;

public interface SalesTrafficDAO {

    public int create(SalesTraffic s);

    public void saveOrUpdate(SalesTraffic s);

    public long getCountByPageByDay(String pageName, String date);

    public long getCountByPageByWeek(String pageName, String date1, String date2);

    public long getCountByPageByMonth(String pageName, String date);

    public long getCountByPageByYear(String pageName, String date);

    public List<String> getMostRecentPage(int userID);




}
