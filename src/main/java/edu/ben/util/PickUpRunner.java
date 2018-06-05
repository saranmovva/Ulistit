package edu.ben.util;

import edu.ben.model.*;
import edu.ben.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class PickUpRunner {

    private static Timer timer;

    private static PickUpService pickUpService;

    @Autowired
    public void setPickUpService(PickUpService pickUpService) {
        this.pickUpService = pickUpService;
    }

    private static NotificationService notificationService;

    private static TransactionService transactionService;

    @Autowired
    public void setTransactionService(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @Autowired
    public void setNotificationService(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    public static void run() {

        if (timer != null) {
            timer.cancel();
        }

        timer = new Timer();

        List<PickUp> pickups = pickUpService.getAllActive();

        for (final PickUp p : pickups) {
            if (p.getBuyerAccept() == 1) {
                try {
                    timer.schedule(new TimerTask() {
                        @Override
                        public void run() {
                            sendNotifications(p);
                        }
                        // Run 2 hours after pick up
                    }, p.getDelay() - 7200000);

                    // Fail safe
                } catch (IllegalArgumentException e) {
                    sendNotifications(p);
                }
            }
        }
    }

    private static void sendNotifications(PickUp p) {

        List<Notification> newNotifications = new ArrayList<Notification>(10);

        if (p.getStatus().equals("IN REVIEW")) {

            // REMIND BUYER TO ACCEPT PICK UP
            newNotifications.add(new Notification(p.getTransaction().getBuyer(), p.getTransaction().getListingID().getId(), "Pick Up Time Passed",
                    "The pick up date and time created by " + p.getTransaction().getSeller().getUsername()
                            + " has passed and was not accepted by you.\nIn order to pick up your item, " + p.getTransaction().getSeller().getUsername()
                            + " will have to create a new pick up date and time.", 1, "PICKUP"));

            // TELL SELLER TO CREATE NEW PICK UP
            newNotifications.add(new Notification(p.getTransaction().getSeller(), p.getTransaction().getListingID().getId(), "Pick Up Time Passed",
                    "The pick up date and time established has passed and was not accepted by "
                            + p.getTransaction().getBuyer().getUsername()
                            + ".\nPlease create a new pick up date and time.", 1, "PICKUP"));

            p.setStatus("PICK UP MISSED");
            p.setBuyerAccept(0);

        } else if (p.getStatus().equals("ACCEPTED")) {

            // NOTIF. TO BUYER TO MARK AS PICKED UP
            newNotifications.add(new Notification(p.getTransaction().getBuyer(), p.getTransaction().getListingID().getId(), "Pick Up Verification",
                    "Just wondering how the pick up went!\nPlease mark the pick up as completed and if everything went smoothly, leave the seller a nice review :)", 1, "PICKUP"));

            // NOTIF. TO SELLER TO MARK AS PICKED UP
            newNotifications.add(new Notification(p.getTransaction().getSeller(), p.getTransaction().getListingID().getId(), "Pick Up Verification",
                    "Just wondering how the pick up went!\nPlease mark the pick up as completed and if everything went smoothly, leave the buyer a nice review :)", 1, "PICKUP"));

            p.setStatus("PENDING VERIFICATION");

        } else if (p.getStatus().equals("PENDING VERIFICATION")) {

            if (p.getSellerVerified() == 0) {
                // NOTIF. TO SELLER TO MARK AS PICKED UP
                newNotifications.add(new Notification(p.getTransaction().getSeller(), p.getTransaction().getListingID().getId(), "Pick Up Verification",
                        "Just wondering how the pick up went!\nPlease mark the pick up as completed and if everything went smoothly, leave the buyer a nice review :)", 1, "PICKUP"));
            }

            if (p.getBuyerVerified() == 0) {
                // NOTIF. TO BUYER TO MARK AS PICKED UP
                newNotifications.add(new Notification(p.getTransaction().getBuyer(), p.getTransaction().getListingID().getId(), "Pick Up Verification",
                        "Just wondering how the pick up went!\nPlease mark the pick up as completed and if everything went smoothly, leave the seller a nice review :)", 1, "PICKUP"));
            }

        } else if (p.getStatus().equals("VERIFIED")) {

            // PROCESS PAYPAL TRANSACTION

            // END TRANSACTION
            Transaction transaction = p.getTransaction();
            transaction.setCompleted(1);
            transactionService.saveOrUpdate(transaction);

            // END PICK UP
            p.setStatus("COMPLETED");
            //p.setActive(0);

        }

        // Update pick up
        pickUpService.update(p);

        // Save new notifications
        notificationService.save(newNotifications);
    }
}
