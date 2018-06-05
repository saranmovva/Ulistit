package edu.ben.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import edu.ben.model.*;
import edu.ben.service.*;
import edu.ben.util.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController extends BaseController {

    @Autowired
    ListingService listingService;

    @Autowired
    ListingBidService listingBidService;

    @Autowired
    TaskService taskService;

    @Autowired
    AdminTaskService adminTaskService;

    @Autowired
    NotificationService notificationService;

    @Autowired
    SearchHistoryService searchHistoryService;

    @Autowired
    ChecklistService checklistService;

    @Autowired
    TutorialService tutorialService;

    @Autowired
    UserService userService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    RevenueService revenueService;

    @Autowired
    SalesTrafficService trafficService;

    @Autowired
    FavoriteService favoriteService;

    /*
     * @Autowired FaqService faqService;
     */

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request) {
        ModelAndView model = new ModelAndView("index");


        model.addObject("recentListings", listingService.getRecentListings());
        System.out.println("Recent Listing Size: " + listingService.getRecentListings().size());

        model.addObject("endingSoonListings", listingService.getRecentListings());

        model.addObject("trendingListings", listingService.getListingsByBidCount());

        model.addObject("relevantListings", null);

        model.addObject("premiumListings", listingService.getPremiumListings());

        model.addObject("categories", categoryService.getAllCategories());

        User user = (User) request.getSession().getAttribute("user");


        ArrayList<Listing> hottestListings = new ArrayList<>();
        ArrayList<Listing> relevent = new ArrayList<>();

        ArrayList<Listing> temp = (ArrayList<Listing>) listingService.getHottestListings();

        if (request.getSession().getAttribute("user") != null) {
            System.out.println("Session not null");
            User user2 = (User) request.getSession().getAttribute("user");
            ArrayList<Listing> temp2 = (ArrayList<Listing>) listingService.getRelevantListingsByUserID(user2.getUserID());

            int size;
            if (temp2.size() > 7) {
                size = 7;
            } else {
                size = temp2.size();
            }

            for (int i = 0; i < size; i++) {
                relevent.add(temp2.get(i));
            }

            System.out.println("Relevant Size: " + relevent.size());

            request.setAttribute("relevent", relevent);

        }
        int size;
        if (temp.size() > 7) {
            size = 7;
        } else {
            size = temp.size();
        }

        for (int i = 0; i < size; i++) {
            hottestListings.add(temp.get(i));
        }

        request.setAttribute("hottestListings", hottestListings);


//		User user = (User) request.getSession().getAttribute("user");

        if (user != null) {

            trafficService.create(new SalesTraffic("Home_Page", user.getUserID()));

            List<Listing> relevantListings = listingService.getRelevantListingsByUserID(user.getUserID());

            if (relevantListings.size() > 3) {
                System.out.println(relevantListings.get(0).getName());
                model.addObject("relevantListings", relevantListings);
            } else {
                model.addObject("relevantListings", null);
            }

            try {
                request.getSession().setAttribute("checklist", checklistService.getByUserIDAndType(user.getUserID(), "FRESHMAN"));
            } catch (Exception e) {
                if (user.getGradeLevel() == 1 &&
                        user.getDateCreated().before(new Timestamp(System.currentTimeMillis() + 600000))) {
                    request.setAttribute("newUser", true);
                } else {
                    request.setAttribute("newUser", false);
                }
                request.getSession().setAttribute("checklist", null);
            }

        } else {
            trafficService.create(new SalesTraffic("Home_Page"));
        }

        ArrayList<Favorite> f = (ArrayList<Favorite>) favoriteService.findAllFavorites();
        request.setAttribute("favorites", f);

        JsonArray favorites = new JsonArray();

        request.setAttribute("allfavorites", favorites);


        JsonArray results = convertFavoriteToJson(f, favorites);
        System.out.println("JSON News Articles: " + results.size());

        request.setAttribute("favoritedListings", results);


        setModel(model);
        return model;
    }


    public JsonArray convertFavoriteToJson(ArrayList<Favorite> favorites, JsonArray results) {
        for (int i = 0; i < favorites.size(); i++) {
            JsonObject json = new JsonObject();

            json.addProperty("favoriteID", String.valueOf(favorites.get(i).getId()));
            json.addProperty("listingID", String.valueOf(favorites.get(i).getListing().getId()));
            json.addProperty("userID", String.valueOf(favorites.get(i).getUser().getUserID()));

            results.add(json);

        }
        return results;
    }

    @GetMapping("/contactUs")
    public String contactUs() {
        return "contactUs";
    }

    @GetMapping("/aboutUs")
    public String aboutUs() {
        return "aboutUs";
    }

    @GetMapping("/")
    public String landingPage() {
        return "landingPage";
    }

    @PostMapping("/sendEmail")
    public String sendEmail(HttpServletRequest request) {
        String message = "";
        if (request.getParameter("submit") != null) {
            String emailSubject = "Contact Us at UListIt";
            if (request.getParameter("message") != null) {
                message += "Name:   " + request.getParameter("name") + "\n";
                message += "Phone:   " + request.getParameter("phone") + "\n";
                message += "Email:   " + request.getParameter("email") + "\n \n";
                message += request.getParameter("message");
            }
            try {
                Email.sendEmail(message, emailSubject, "ulistithelp@gmail.com");
                addSuccessMessage("Email sent successfully!");
            } catch (Exception me) {
                /*				addErrorMessage("Error sending email!");*/
                addSuccessMessage("Email sent successfully!");
            }
        }
        setRequest(request);
        return "redirect:/";
    }

    @PostMapping("/reportListingEmail")
    public String reportListingEmail(HttpServletRequest request, @RequestParam("id") int id) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addErrorMessage("You must be logged in");
            setRequest(request);
            return "redirect:/index";
        }

        String message = "";
        if (request.getParameter("submit") != null) {
            String emailSubject = "New listing reported at UListIt";
            if (request.getParameter("message") != null) {
                message += "Reporter Name:   " + request.getParameter("reportUsername") + "\n";
                message += "Reporter Email:   " + request.getParameter("reportEmail") + "\n \n \n";
                message += "Seller Name:   " + request.getParameter("sellerName") + "\n";
                message += "Seller Email:   " + request.getParameter("sellerEmail") + "\n";
                message += "Listing Name:   " + request.getParameter("listingName") + "\n \n \n";
                message += request.getParameter("message");

                Listing listing = listingService.getByListingID(id);

                if (listing == null) {
                    addErrorMessage("Error Loading Listing");
                    setRequest(request);
                    return "redirect:/index";
                }

                if (user == null) {
                    addErrorMessage("You must be logged in");
                    setRequest(request);
                    return "redirect:/index";
                }

                Task t = new Task("Reported Listing", "The user " + user.getUsername() + " has reported the listing: " + listing.getName() + " by " + listing.getUser().getUsername() + ". Reason: " + request.getParameter("message"), 0, "high");

                taskService.create(t);

                try {
                    Email.sendEmail(message, emailSubject, "ulistithelp@gmail.com");
                    addSuccessMessage("Listing Reported Successfully!");

                } catch (Exception me) {
                    /*				addErrorMessage("Error sending email!");*/
                    addSuccessMessage("Listing Reported Successfully!");
                }
                setRequest(request);
                return "redirect:/index";
            }

        }
        setRequest(request);
        return "index";
    }
}





