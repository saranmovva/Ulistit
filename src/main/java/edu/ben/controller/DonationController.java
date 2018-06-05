package edu.ben.controller;

import edu.ben.model.*;
import edu.ben.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.UnexpectedRollbackException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class DonationController extends BaseController {

    @Autowired
    ListingService listingService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    TutorialService tutorialService;

    @Autowired
    SearchHistoryService searchHistoryService;

    @Autowired
    SalesTrafficService trafficService;

    @GetMapping("/donation")
    public String donation(HttpServletRequest request) {
        return "redirect:/donate";
    }

    @GetMapping("/donations")
    public String donations() {
        return "redirect:/donate";
    }

    @GetMapping("/donate")
    public String donate(HttpServletRequest request) {

        request.setAttribute("donations", listingService.findAllDonatedListings());
        request.setAttribute("categories", categoryService.getAllCategories());
        request.setAttribute("title", "Donate");

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            // Add site traffic record
            trafficService.create(new SalesTraffic("Donation_Page"));
        } else {
            // Add site traffic record
            trafficService.create(new SalesTraffic("Donation_Page", user.getUserID()));
        }

        return "donation/donation";

    }

    @GetMapping("/search-donation-by-category")
    public String donationByCategory(HttpServletRequest request, @RequestParam("c") String category) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {

            try {
                searchHistoryService.save(new SearchHistory(user, category));
            } catch (UnexpectedRollbackException e) {
                e.printStackTrace();
            }

        }

        request.setAttribute("listingSearch", listingService.findAllDonatedListingsByCategory(category));
        request.setAttribute("search", category + " Donations");
        request.setAttribute("donationSearch", true);

        request.setAttribute("title", "Donation Search");
        return "searchResults";

    }

    @GetMapping("/search-donations")
    public String searchDonations(HttpServletRequest request, @RequestParam("s") String search) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {

            try {
                searchHistoryService.save(new SearchHistory(user, search));
            } catch (UnexpectedRollbackException e) {
                e.printStackTrace();
            }

        }

        request.setAttribute("listingSearch", listingService.listingsSearchDonations(search));
        request.setAttribute("search", search + " Donations");
        request.setAttribute("donationSearch", true);

        request.setAttribute("title", "Donation Search");
        return "searchResults";

    }

    @GetMapping("/donate-an-item")
    public String donateAnItem(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Donate An Item");
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/donate-an-item");
            return "redirect:/login";
        }

        request.setAttribute("categories", categoryService.getAllCategories());
        request.setAttribute("subCategories", categoryService.getAllSubCategories());

        return "donation/donate-an-item";
    }

}
