package edu.ben.controller;

import edu.ben.model.*;
import edu.ben.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class DisputeController extends BaseController {

    @Autowired
    DisputeService disputeService;

    @Autowired
    NotificationService notificationService;

    @Autowired
    UserService userService;

    @Autowired
    ListingService listingService;

    @Autowired
    TransactionService transactionService;

    @Autowired
    TaskService service;

    @PostMapping("/submit-dispute")
    public String fileDispute(HttpServletRequest request, @RequestParam("complaint") String complaint,
                              @RequestParam("listingID") int listingID) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Please Login To File A Dispute");
            request.getSession().setAttribute("lastPage", "/file-dispute?l=" + listingID);
            setRequest(request);
            return "redirect:/login";

        } else {

            Listing disputeListing = listingService.getByListingID(listingID);

            if (disputeListing == null) {

                addErrorMessage("Dispute Error, Try Again");
                setRequest(request);
                return "redirect:" + request.getHeader("Referer");

            } else {

                Dispute dispute = new Dispute(disputeListing, user, disputeListing.getUser(), complaint);

                disputeService.save(dispute);

                // Send notification to accuser
                notificationService.save(new Notification(user, dispute.getListing().getId(), "Dispute Has Been Filed", "Dispute has been successfully filed.\n\nListing: " + dispute.getListing().getName() + "\nDispute: '" + dispute.getComplaint() + "'\nAn administrator will review the dispute and respond via within 48 hours.", 1));

                // Send notification to defendant
                notificationService.save(new Notification(dispute.getDefender(), dispute.getListing().getId(), "Dispute Has Been Filed Against You", "Dispute has been filed against you.\n\nListing: " + dispute.getListing().getName() + "\nDispute: '" + dispute.getComplaint() + "'\nAn administrator will review the dispute and respond via within 48 hours.", 1));

                // Send notification to admins
                List<User> disputeResolvingAdmins = userService.getDisputeResolvingAdmins();
                List<Notification> adminNotifications = new ArrayList<Notification>();

                for (User u : disputeResolvingAdmins) {
                    adminNotifications.add(new Notification(u, dispute.getListing().getId(), "New Dispute Has Been Filed", "New Dispute has been filed.\n\nListing: " + dispute.getListing().getName() + "\nAccuser: " + dispute.getAccuser().getFirstName() + " " + dispute.getAccuser().getLastName() +
                            "\nDispute: '" + dispute.getComplaint(), 1));
                }

                notificationService.save(adminNotifications);


                Task task = new Task("File Dispute", dispute.getAccuser().getFirstName() + " " + dispute.getAccuser().getLastName() + "is filing a dispute against " + dispute.getDefender().getFirstName() + " " + dispute.getDefender().getLastName() + ". Complaint: " + dispute.getComplaint(), 0, "normal");
                service.create(task);
            }
            addSuccessMessage("Dispute Successfully Filed. An Administrator Will Review Your Complaint.");
            return "redirect:/";
        }
    }


    @GetMapping("/file-dispute")
    public String getDispute(HttpServletRequest request, int l) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To File A Dispute");
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/file-dispute?l=" + l);
            return "redirect:/login";
        }

        try {

            Listing listing = listingService.getByListingID(l);

            if (listing.getEnded() == 0) {
                addWarningMessage("Listing Is Still Active");
                setRequest(request);
                return "redirect:/" + request.getHeader("Referer");
            }

            Transaction transaction = transactionService.getTransactionsByListingID(l);

            if (transaction.getBuyer().getUserID() != user.getUserID() && transaction.getSeller().getUserID() != user.getUserID()) {
                addErrorMessage("Only Buyer or Seller Can Dispute A Listing");
                setRequest(request);
                return "redirect:/" + request.getHeader("Referer");
            }

            request.getSession().setAttribute("disputeListing", listing);

            // If listing doesn't exist
        } catch (IndexOutOfBoundsException e) {
            addErrorMessage("No Active Listings Under ID " + l);
            setRequest(request);
            return "redirect:/";
        }

        request.setAttribute("title", "File Dispute");
        setRequest(request);
        return "dispute/file-dispute";
    }

}
