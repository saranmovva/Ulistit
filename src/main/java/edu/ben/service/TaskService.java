package edu.ben.service;

import edu.ben.model.Task;

import java.util.List;

public interface TaskService {
    public void delete(int id);

    public void saveOrUpdate(Task task);

    public void create(Task task);

    public List getAllTasks();

    public Task getAllTasksByTaskID(int id);

    public List getAllTasksPerUser(int id);

}
