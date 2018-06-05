package edu.ben.service;

import edu.ben.dao.AdminTaskDAO;
import edu.ben.model.AdminTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class AdminTaskServiceImpl implements AdminTaskService {

    AdminTaskDAO adminTaskDAO;

    @Autowired
    public void setAdminTaskDAO(AdminTaskDAO adminTaskDAO) {
        this.adminTaskDAO = adminTaskDAO;
    }

    @Override
    public void delete(int id) {
        adminTaskDAO.delete(id);
    }

    @Override
    public void saveOrUpdate(AdminTask task) {
        adminTaskDAO.saveOrUpdate(task);
    }

    @Override
    public void create(AdminTask task) {
        adminTaskDAO.create(task);
    }

    @Override
    public List getAllTasksByUserID(int userID) {
        return adminTaskDAO.getAllTasksByUserID(userID);
    }

    @Override
    public List getAlllTasksByTaskID(int taskID) {
        return adminTaskDAO.getAlllTasksByTaskID(taskID);
    }

    @Override
    public List getAllAdminTasks() {
        return adminTaskDAO.getAllAdminTasks();
    }
}
