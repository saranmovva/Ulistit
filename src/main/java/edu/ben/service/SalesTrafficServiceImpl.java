package edu.ben.service;

import edu.ben.dao.SalesTrafficDAO;
import edu.ben.model.SalesTraffic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class SalesTrafficServiceImpl implements SalesTrafficService {

    SalesTrafficDAO sd;

    @Autowired
    public void setSd(SalesTrafficDAO sd) {
        this.sd = sd;
    }

    @Override
    public int create(SalesTraffic s) {
        return sd.create(s);
    }

    @Override
    public void saveOrUpdate(SalesTraffic s) {
        sd.saveOrUpdate(s);
    }

    @Override
    public long getCountByPageByDay(String pageName, String date) {
        return sd.getCountByPageByDay(pageName, date);
    }

    @Override
    public long getCountByPageByWeek(String pageName, String date1, String date2) {
        return sd.getCountByPageByWeek(pageName, date1, date2);
    }

    @Override
    public long getCountByPageByMonth(String pageName, String date) {
        return sd.getCountByPageByMonth(pageName, date);
    }

    @Override
    public long getCountByPageByYear(String pageName, String date) {
        return sd.getCountByPageByYear(pageName, date);
    }

    @Override
    public List<String> getMostRecentPage(int userID) {
        return sd.getMostRecentPage(userID);
    }
}
