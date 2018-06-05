package edu.ben.dao;

import edu.ben.model.AdminTask;

import java.util.List;

public interface AdminTaskDAO {
    public void delete(int id);

    public void saveOrUpdate(AdminTask task);

    public void create(AdminTask task);

    public List getAllTasksByUserID(int userID);

    public List getAllAdminTasks();

    public List getAlllTasksByTaskID(int taskID);
}
