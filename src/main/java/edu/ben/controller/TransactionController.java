package edu.ben.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import edu.ben.model.*;
import edu.ben.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import edu.ben.model.Listing;
import edu.ben.model.Transaction;
import edu.ben.model.User;
import edu.ben.service.ListingService;
import edu.ben.service.TransactionService;
import edu.ben.service.UserService;
import edu.ben.util.Email;

@Controller
public class TransactionController extends BaseController {

    @Autowired
    ListingService listingService;

    @Autowired
    UserService userService;

    @Autowired
    TransactionService transactionService;

    @Autowired
	TutorialService tutorialService;

    @Autowired
    SalesTrafficService salesTrafficService;

    @RequestMapping(value = "/button", method = RequestMethod.GET)
    public ModelAndView checkoutTest(@RequestParam("listing") int listingID, HttpServletRequest request) {

		Listing listing = listingService.getByListingID(listingID);
		User user = (User) request.getSession().getAttribute("user");

		listing.setActive(0);
		listingService.saveOrUpdate(listing);
		Email.sendEmail("Hello, From U-ListIt.com! Your listing: " + listing.getName() + " has been purchased.",
				"Your listing was purchased!", user.getSchoolEmail());
		addSuccessMessage("Congratulations, your purchase was a success!");

		return new ModelAndView("redirect:/");
	}

	@RequestMapping(value = "buyerTransactions", method = RequestMethod.GET)
	public ModelAndView currentTransactionsForBuyer() {

		ModelAndView model = new ModelAndView("transactions");

		List<Transaction> transactions = transactionService.getTransactionsByBuyerID(1);

		model.addObject("buyerTransactions", transactions);

		return model;
	}

	@RequestMapping(value = "sellerTransactions", method = RequestMethod.GET)
	public ModelAndView currentTransactionsForSeller() {

		ModelAndView model = new ModelAndView("transactions");

		List<Transaction> transactions = transactionService.getTransactionsBySellerID(1);

		model.addObject("sellerTransactions", transactions);

		return model;
	}

	@GetMapping("/purchaseHistory")
	public String purchaseHistory() {
		return "purchaseHistory";
	}

	@RequestMapping(value = "/sellerReviews", method = RequestMethod.GET)
	public String sellerReviews(HttpServletRequest request, @RequestParam("id") int id) {
	        // user transactions
	        List<Transaction> buyerTransactions = transactionService.getTransactionsByBuyerID(id);
	        List<Transaction> sellerTransactions = transactionService.getTransactionsBySellerID(id);
	        System.out.println("size " + sellerTransactions.size());
	        request.setAttribute("user", userService.getUserById(id));
	        request.setAttribute("buyerTransactions", buyerTransactions);
	        request.setAttribute("sellerTransactions", sellerTransactions);

		return "sellerReviews";
	}

    @RequestMapping(value = "/viewPurchaseHistory", method = RequestMethod.GET)
    public String viewPurchaseHistory(HttpServletRequest request) {
        User session = (User) request.getSession().getAttribute("user");

        if (session == null) {
            addWarningMessage("Login To View Purchase History");
            salesTrafficService.create(new SalesTraffic("Purchase_History_Page"));
            setRequest(request);
            return "login";
        }

        salesTrafficService.create(new SalesTraffic("Purchase_History_Page", session.getUserID()));

        List<Transaction> userTransactions = transactionService.getTransactionsByBuyerID(session.getUserID());
        System.out.println("size " + userTransactions.size());
        request.setAttribute("user", session);
        request.setAttribute("userTransactions", userTransactions);

        return "purchaseHistory";
    }

	@GetMapping("/rateReview")
	public String rateReview(HttpServletRequest request) {
		int id = Integer.parseInt(request.getParameter("id"));
		request.setAttribute("id", id);
		return "rateReview";
	}

	@PostMapping("/reviewRateSeller")
	public String reviewRateSeller(@RequestParam("id") int id, HttpServletRequest request) {




		Transaction transaction = transactionService.getTransaction(id);
		int transRating = Integer.parseInt(request.getParameter("transRating"));
		String transReview = request.getParameter("transReview");

		if (transaction.getFeedbackLeft() == 1) {
			addErrorMessage("Feedback has already been left for this transaction!");
			setRequest(request);
			return "redirect:/viewPurchaseHistory";
		}

		transactionService.updateTransRating(transRating, transaction);
		transactionService.updateTransReview(transReview, transaction);
		transactionService.updateFeedbackLeft(1, transaction);

		System.out.println(transactionService.getTransaction(id).getId());
		System.out.println(transRating);
		System.out.println(transReview);

		addSuccessMessage("Feedback successfully left!");

		setRequest(request);

		return "redirect:/viewPurchaseHistory";
	}

}
