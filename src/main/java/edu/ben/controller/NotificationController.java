package edu.ben.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import edu.ben.model.Conversation;
import edu.ben.model.Notification;
import edu.ben.model.SalesTraffic;
import edu.ben.model.User;
import edu.ben.service.NotificationService;
import edu.ben.service.SalesTrafficService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class NotificationController extends BaseController {

    @Autowired
    NotificationService notificationService;

    @Autowired
    SalesTrafficService salesTrafficService;

    @GetMapping("/notifications")
    public String getNotificationsPage(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            salesTrafficService.create(new SalesTraffic("Profile_Page"));
            addWarningMessage("Login To See Notifications");
            request.getSession().setAttribute("lastPage", "/notifications");
            setRequest(request);
            return "redirect:/login";
        }

        List<Notification> activeNotifications = notificationService.getActiveByUserID(user.getUserID());
        request.setAttribute("active", activeNotifications);

        // Add site traffic record
        salesTrafficService.create(new SalesTraffic("Notification_Page", user.getUserID()));

        request.setAttribute("title", "Notifications");
        setRequest(request);
        return "notification/notifications";
    }

    @GetMapping("/dismiss")
    public String dismiss(int n, HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Dismiss Notifications");
            setRequest(request);
            return "login";
        }

        int results = notificationService.dismiss(user.getUserID(), n);

        if (results < 1) {
            addErrorMessage("Dismissal Error");
        } else {
            addSuccessMessage("Dismissed");
        }

        setRequest(request);
        return "redirect:" + request.getHeader("Referer");

    }

    @GetMapping("/remove")
    public String remove(int n, HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Remove Notifications");
            setRequest(request);
            return "login";
        }

        int results = notificationService.remove(user.getUserID(), n);

        if (results < 1) {
            addErrorMessage("Removal Error");
        } else {
            addSuccessMessage("Removed");
        }

        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }

    @RequestMapping(value = "/updateNotificationDropdown", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String updateNotificationDropdown(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        JsonArray result = new JsonArray();

        if (user != null) {
            List<Notification> notifications = notificationService.getNotDismissedByUserID(user.getUserID());

            for (Notification notification : notifications) {

                JsonObject addJson = new JsonObject();

                addJson.addProperty("notificationID", String.valueOf(notification.getNotificationID()));
                addJson.addProperty("userID", String.valueOf(notification.getUser().getUserID()));
                addJson.addProperty("listingID", String.valueOf((notification.getListingID())));
                addJson.addProperty("subject", notification.getSubject());
                addJson.addProperty("message", notification.getMessage());
                addJson.addProperty("active", String.valueOf(notification.getActive()));
                addJson.addProperty("type", notification.getType());
                addJson.addProperty("dateCreated", notification.getDateCreated().toString());
                addJson.addProperty("sendTimestamp", notification.getSendTimestamp().toString());
                addJson.addProperty("sent", String.valueOf(notification.getSent()));
                addJson.addProperty("viewed", String.valueOf(notification.getViewed()));
                addJson.addProperty("dismissed", String.valueOf(notification.getDismissed()));

                result.add(addJson);
            }
        }

        return result.toString();
    }

    @GetMapping("/removeAll")
    public String removeAll(List<Notification> n, HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Remove Notifications");
            setRequest(request);
            return "login";
        }

        for (Notification not : n) {
            notificationService.remove(user.getUserID(), not.getNotificationID());
        }

        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }

    @RequestMapping(value = "/markAsViewed", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String markAsViewed(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        JsonObject addJson = new JsonObject();

        if (user != null) {
            notificationService.markAsViewed(notificationService.getNotDismissedByUserID(user.getUserID()));
            addJson.addProperty("results", "success");
            return addJson.toString();
        }

        addJson.addProperty("results", "error");
        return addJson.toString();
    }
}
