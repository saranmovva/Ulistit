package edu.ben.service;

import edu.ben.model.AdminTask;
import org.springframework.stereotype.Service;

import java.beans.Transient;
import java.util.List;


public interface AdminTaskService {

    public void delete(int id);

    public void saveOrUpdate(AdminTask task);

    public void create(AdminTask task);

    public List getAllTasksByUserID(int userID);

    public List getAllAdminTasks();

    public List getAlllTasksByTaskID(int taskID);
}
