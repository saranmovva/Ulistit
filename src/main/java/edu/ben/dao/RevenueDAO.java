package edu.ben.dao;

import edu.ben.model.Revenue;
import edu.ben.model.SalesTraffic;

public interface RevenueDAO {

//   public int create(Revenue r);
//
//   public void saveOrUpdate(Revenue r);

   public long getDailyRevenue(int hour, String date);

   public long getWeeklyRevenue(String date);

   public long getMonthlyRevenue(String input);

   public long getYearlyRevenue(String date);

   public long getTotalRevenue();
}
