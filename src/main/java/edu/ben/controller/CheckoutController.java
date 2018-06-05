package edu.ben.controller;

import edu.ben.model.PickUp;
import edu.ben.model.SalesTraffic;
import edu.ben.model.Transaction;
import edu.ben.model.User;
import edu.ben.service.ListingService;
import edu.ben.service.PickUpService;
import edu.ben.service.SalesTrafficService;
import edu.ben.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@Transactional
public class CheckoutController extends BaseController {

    @Autowired
    TransactionService transactionService;

    @Autowired
    PickUpService pickUpService;

    @Autowired
    Environment environment;

    @Autowired
    ListingService listingService;

    @Autowired
    SalesTrafficService salesTrafficService;

    @GetMapping("/checkout")
    public String checkoutPageGet(HttpServletRequest request, @RequestParam("l") int listingID) {

        try {
            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {

                salesTrafficService.create(new SalesTraffic("Checkout_Page"));

                addWarningMessage("Login To Checkout");
                setRequest(request);
                request.getSession().setAttribute("lastPage", "/checkout?l=" + listingID);
                return "redirect:/login";
            }

            salesTrafficService.create(new SalesTraffic("Checkout_Page", user.getUserID()));

            Transaction transaction = null;

            List<Transaction> transactions = transactionService.getTransactionsByUserID(user.getUserID());
            if (transactions != null && transactions.size() > 0) {
                for (Transaction t : transactions) {
                    if (t.getListingID().getId() == listingID) {
                        transaction = t;
                    }
                }
            }

            // Verify transaction was created
            if (transaction == null) {
                addErrorMessage("Error Loading Transaction");
                setRequest(request);
                return "redirect:/";
            }

            // Verify user
            if (user.getUserID() != transaction.getBuyer().getUserID() && user.getUserID() != transaction.getSeller().getUserID()) {
                addWarningMessage("Access Denied");
                setRequest(request);
                return "redirect:/";
            }


            PickUp pickUp = pickUpService.getPickUpByListingID(listingID);

            if (pickUp == null) {
                addErrorMessage("Error Loading Pick Up");
                setRequest(request);
                return "redirect:" + request.getHeader("Referer");
            }

            if (pickUp.getBuyerAccept() == 0 && user.getUserID() == transaction.getBuyer().getUserID()) {
                addWarningMessage("Pick Up Must Be Accepted Before Checkout");
                setRequest(request);
                return "redirect:" + request.getHeader("Referer");
            }

            if (pickUp.getBuyerAccept() == 0 && user.getUserID() == transaction.getSeller().getUserID()) {
                addWarningMessage("Pick Up Must Be Accepted By The Buyer Before Checkout");
                setRequest(request);
                return "redirect:" + request.getHeader("Referer");
            }

            request.setAttribute("title", "Checkout");
            request.setAttribute("listing", pickUp.getTransaction().getListingID());
            request.setAttribute("pickUp", pickUp);
            setRequest(request);
            return "checkout/checkout";

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/";
    }

    @GetMapping("/finish-checkout")
    public String finishCheckout(HttpServletRequest request, @RequestParam("l") int listingID) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Checkout");
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/checkout?l=" + listingID);
            return "redirect:/login";
        }

        Transaction transaction = null;

        List<Transaction> transactions = transactionService.getTransactionsByUserID(user.getUserID());
        if (transactions != null && transactions.size() > 0) {
            for (Transaction t : transactions) {
                if (t.getListingID().getId() == listingID) {
                    transaction = t;
                }
            }
        }

        // Verify transaction was created
        if (transaction == null) {
            addErrorMessage("Error Loading Transaction");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        // Verify user
        if (user.getUserID() != transaction.getBuyer().getUserID() && user.getUserID() != transaction.getSeller().getUserID()) {
            addWarningMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }


        PickUp pickUp = pickUpService.getPickUpByListingID(listingID);

        if (pickUp == null) {
            addErrorMessage("Error Loading Pickup");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (pickUp.getBuyerAccept() == 0 && user.getUserID() == transaction.getBuyer().getUserID()) {
            addWarningMessage("Pick Up Must Be Accepted Before Checkout");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (pickUp.getBuyerAccept() == 0 && user.getUserID() == transaction.getSeller().getUserID()) {
            addWarningMessage("Pick Up Must Be Accepted By The Buyer Before Checkout");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        // If buyer finishes checkout first, adjust status to 'buyer_finished'
        if (transaction.getTransactionType().equals("pending") && user.getUserID() == transaction.getBuyer().getUserID()) {
            transaction.setTransactionType("buyer_finished");
            // If seller finishes checkout first, adjust status to 'seller_finished'
        } else if (transaction.getTransactionType().equals("pending") && user.getUserID() == transaction.getSeller().getUserID()) {
            transaction.setTransactionType("seller_finished");
            // If buyer finishes checkout first, adjust status to 'fully_finished'
        } else if (transaction.getTransactionType().equals("seller_finished") && user.getUserID() == transaction.getBuyer().getUserID()) {
            transaction.setTransactionType("fully_finished");
            // If seller finishes checkout first, adjust status to 'fully_finished'
        } else if (transaction.getTransactionType().equals("buyer_finished") && user.getUserID() == transaction.getSeller().getUserID()) {
            transaction.setTransactionType("fully_finished");
        }

        transactionService.saveOrUpdate(transaction);

        addSuccessMessage("Checkout Complete");
        setRequest(request);
        return "redirect:/dashboard";

    }
}
