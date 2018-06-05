package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.List;

@Entity(name = "task_manager")
@Table(name = "task_manager")
@Transactional
public class Task {

    @Id
    @Column(name = "task_ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int taskID;

    @Column(name="name")
    private String name;

    @Column(name="description")
    private String description;

    @Column(name="status")
    private int status;

    @Column(name="priority")
    private String priority;

    public Task() {

    }

    public Task(int taskID, String name, String description, int status, String priority) {
        this.taskID = taskID;
        this.name = name;
        this.description = description;
        this.status = status;
        this.priority = priority;
    }

    public Task(String name, String description, int status, String priority) {
        this.name = name;
        this.description = description;
        this.status = status;
        this.priority = priority;
    }

    public int getTaskID() {
        return taskID;
    }

    public void setTaskID(int taskID) {
        this.taskID = taskID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

}
