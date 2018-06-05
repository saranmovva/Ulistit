package edu.ben.service;

import edu.ben.dao.NotificationDAO;
import edu.ben.model.Notification;
import edu.ben.model.User;
import edu.ben.util.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;

@Service
@Transactional
public class NotificationServiceImpl implements NotificationService {

    NotificationDAO notificationDAO;

    @Autowired
    public void setListingDAO(NotificationDAO notificationDAO) {
        this.notificationDAO = notificationDAO;
    }

    @Override
    public void save(Notification notification) {
        notification.setSent(1);
        notificationDAO.save(notification);

        Timer t = new Timer();
        t.schedule(new TimerTask() {
            @Override
            public void run() {
                if (notification.getSubject() != null) {
                    Email.sendEmail(notification.getMessage(), notification.getSubject(), notification.getUser().getSchoolEmail());
                } else {
                    Email.sendEmail(notification.getMessage(), "U-ListIt Notification", notification.getUser().getSchoolEmail());
                }
            }
        }, 5000);
        t.cancel();
    }

    @Override
    public void save(List<Notification> notifications) {

        for (Notification n : notifications) {
            n.setSent(1);
            notificationDAO.save(n);
        }

        Timer t = new Timer();
        t.schedule(new TimerTask() {
            @Override
            public void run() {
                for (Notification n : notifications) {
                    if (n.getSubject() != null) {
                        Email.sendEmail(n.getMessage(), n.getSubject(), n.getUser().getSchoolEmail());
                    } else {
                        Email.sendEmail(n.getMessage(), "U-ListIt Notification", n.getUser().getSchoolEmail());
                    }
                }
            }
        }, 5000);
        t.cancel();
    }

    @Override
    public void update(Notification notification) {
        notificationDAO.update(notification);
    }

    @Override
    public List<Notification> getAllActive() {
        return notificationDAO.getAllActive();
    }

    @Override
    public void deactivate(int notificationID) {
        notificationDAO.deactivate(notificationID);
    }

    @Override
    public List<Notification> getActiveByUserID(int userID) {
        return notificationDAO.getActiveByUserID(userID);
    }

    @Override
    public List<Notification> getNotDismissedByUserID(int userID) {
        return notificationDAO.getNotDismissedByUserID(userID);
    }

    @Override
    public int dismiss(int userID, int id) {
        try {
            Notification n = notificationDAO.getByNotificationID(id);
            if (n.getUser().getUserID() != userID) {
                return -2;
            }
            n.setDismissed(1);
            notificationDAO.update(n);
            return 1;
        } catch (IndexOutOfBoundsException e) {
            return -1;
        }
    }

    @Override
    public int remove(int userID, int id) {
        try {
            Notification n = notificationDAO.getByNotificationID(id);
            if (n.getUser().getUserID() != userID) {
                return -2;
            }

            n.setActive(0);
            notificationDAO.update(n);
            return 1;
        } catch (IndexOutOfBoundsException e) {
            return -1;
        }
    }

    @Override
    public void markAsSent(List<Notification> notifications) {
        for (Notification n : notifications) {
            n.setSent(1);
            notificationDAO.update(n);
        }
    }

    @Override
    public void markAsViewed(List<Notification> notifications) {
        if (notifications != null) {
            for (Notification n : notifications) {
                n.setViewed(1);
                notificationDAO.update(n);
            }
        }
    }
}
