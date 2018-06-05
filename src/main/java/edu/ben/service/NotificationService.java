package edu.ben.service;

import edu.ben.model.Notification;

import java.util.List;

public interface NotificationService {

    public void save(Notification notification);

    public void save(List<Notification> notifications);

    public void update(Notification notification);

    public void deactivate(int notificationID);

    public List<Notification> getActiveByUserID(int userID);

    public List<Notification> getAllActive();

    public void markAsSent(List<Notification> notifications);

    public List<Notification> getNotDismissedByUserID(int userID);

    public int dismiss(int userID, int id);

    public int remove(int userID, int id);

    public void markAsViewed(List<Notification> notifications);
}
