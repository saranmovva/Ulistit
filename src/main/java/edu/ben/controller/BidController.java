package edu.ben.controller;

import com.google.appengine.repackaged.com.google.gson.JsonObject;
import edu.ben.model.Listing;
import edu.ben.model.User;
import edu.ben.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class BidController extends BaseController {

    @Autowired
    ListingService listingService;

    @Autowired
    ListingBidService listingBidService;

    @Autowired
    FavoriteService favoriteService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    UserService userService;


    @RequestMapping(value = "/bid", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String bid(HttpServletRequest request, @RequestParam("bidValue") int bidValue, @RequestParam("listingID") int listingID) {

        User user = (User) request.getSession().getAttribute("user");

        JsonObject json = new JsonObject();

        if (user == null) {
            json.addProperty("result", "LOGIN");
            return json.toString();
        }

        int results = listingBidService.placeBid(user.getUserID(), bidValue, listingService.getByListingID(listingID));

        if (results == -2) {
            json.addProperty("result", "TOO SMALL");
        } else if (results == -1) {
            json.addProperty("result", "OVER");
        } else {
            json.addProperty("result", "WINNING");
        }

        return json.toString();
    }

    @GetMapping("/placeBid")
    public String placeBid(@RequestParam("b") int bidValue, @RequestParam("l") int l, HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addErrorMessage("Login To Place A Bid");
            setRequest(request);
            return "redirect:/login";
        }

        Listing listing = listingService.getByListingID(l);

        if (listing == null) {
            addErrorMessage("Error Loading");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        int results = listingBidService.placeBid(user.getUserID(), bidValue, listing);

        if (results == -2) {
            addErrorMessage("Bid Value Too Small");
        } else if (results == -1) {
            addWarningMessage("Didn't Get You Bid In On Time");
        } else {
            addSuccessMessage("You're Winning");
        }

        setRequest(request);
        return "redirect:/index";

    }

    @GetMapping("/cancelBid")
    public String bid(@RequestParam int l,
                      HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addErrorMessage("Login To Cancel A Bid");
            request.getSession().setAttribute("lastPage", "/listing?l=" + l);
            setRequest(request);
            return "redirect:/login";
        }

        int results = listingBidService.cancel(user, l);

        if (results == -1) {
            System.out.println("Listing Over");
            addErrorMessage("Listing Has Already Ended");
        } else {
            System.out.println("Bid Successfully Cancelled");
            addSuccessMessage("Bid Successfully Cancelled");
        }

        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }
}
