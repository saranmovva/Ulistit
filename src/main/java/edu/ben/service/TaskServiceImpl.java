package edu.ben.service;

import edu.ben.dao.TaskDAO;
import edu.ben.model.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class TaskServiceImpl implements TaskService {

    TaskDAO taskDAO;

    @Autowired
    public void setTaskDAO(TaskDAO taskDAO) {
        this.taskDAO = taskDAO;
    }


    @Override
    public void delete(int id) {
        taskDAO.delete(id);
    }

    @Override
    public void saveOrUpdate(Task task) {
        taskDAO.saveOrUpdate(task);
    }

    @Override
    public void create(Task task) {
        taskDAO.create(task);
    }

    @Override
    public List getAllTasks() {
        return taskDAO.getAllTasks();
    }

    @Override
    public Task getAllTasksByTaskID(int id) {
        return taskDAO.getAllTasksByTaskID(id);
    }

    @Override
    public List getAllTasksPerUser(int id) {
        return taskDAO.getAllTasksPerUser(id);
    }


}
