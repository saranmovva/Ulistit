package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.jdo.annotations.Join;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity(name = "admin_task")
@Table(name = "admin_task")
@Transactional
public class AdminTask {

    @Id
    @Column(name = "admin_ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int adminID;

    @OneToOne
    @JoinColumn(name = "ID_User")
    private User user;

    @OneToOne
    @JoinColumn(name = "ID_Task")
    private Task task;

    public AdminTask() {

    }

    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public int getTaskID() {
        return task.getTaskID();
    }

    public void setTaskID(int taskID) {
        this.task.setTaskID(taskID);
    }

//    public int getTaskID(ArrayList<AdminTask> a, int index) {
//       return a.get(index).getTask().getTaskID();
//    }
}
