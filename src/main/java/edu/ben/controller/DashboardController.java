package edu.ben.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import edu.ben.model.*;
import edu.ben.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class DashboardController extends BaseController {

    @Autowired
    UserService userService;

    @Autowired
    FollowService followService;

    @Autowired
    ListingService listingService;

    @Autowired
    OfferService offerService;

    @Autowired
    TransactionService transactionService;

    @Autowired
    ImageService imageService;

    @Autowired
    PickUpService pickUpService;

    @Autowired
    SalesTrafficService salesTrafficService;

    @Autowired
    FavoriteService favoriteService;

    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public ModelAndView showDashboard(HttpServletRequest request, HttpSession session) {

        if (request.getSession(false) == null || session.getAttribute("user") == null) {

            salesTrafficService.create(new SalesTraffic("Dashboard_Page"));

            addErrorMessage("Please log in or sign up");
            setModel(new ModelAndView("redirect:login"));
            return new ModelAndView("redirect:login");

        } else {

            ModelAndView model = new ModelAndView("dashboard2");

            session = request.getSession();
            User user = (User) session.getAttribute("user");

            // Switcher content
            List<Listing> listings = listingService.getAllListingsByUserID(user.getUserID());
            List<Listing> activeListings = listingService.getActiveListingsByUserId(user.getUserID());
            List<Listing> inactiveListings = listingService.getInActiveListingsByUserId(user.getUserID());
            List<Listing> wonListings = listingService.getListingsWon(user.getUserID());
            List<Listing> lostListings = listingService.getListingsLost(user.getUserID());
            List<Listing> currentBidListings = listingService.getListingsInProgressUserBidOn(user.getUserID());
            List<Listing> soldListings = listingService.getListingsSold(user.getUserID());

            // Tables
            List<Offer> offers = offerService.getOffersByUserId(user.getUserID());
            List<Transaction> transactions = transactionService.getTransactionsByUserID(user.getUserID());
            List<PickUp> pickUps = pickUpService.getAllActive();

            model.addObject("title", "Dashboard");

            model.addObject("allListings", listings);
            model.addObject("activeListings", activeListings);
            model.addObject("inactiveListings", inactiveListings);
            model.addObject("wonListings", wonListings);
            model.addObject("lostListings", lostListings);
            model.addObject("currentBidListings", currentBidListings);
            model.addObject("soldListings", soldListings);

            model.addObject("offers", offers);
            model.addObject("pickUps", pickUps);
            model.addObject("transactions", transactions);

            salesTrafficService.create(new SalesTraffic("Dashboard_Page", user.getUserID()));

            return model;
        }
    }

    @RequestMapping(value = "/listingsIBidOn", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String showListingsIBidOn(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        List<Listing> listingsIBidOn = listingService.getListingsInProgressUserBidOn(user.getUserID());
        JsonArray result = new JsonArray();
        for (int i = 0; i < listingsIBidOn.size(); i++) {
            JsonObject json = new JsonObject();

            json.addProperty("listingHighestBid", listingsIBidOn.get(i).getHighestBid());
            json.addProperty("listingName", listingsIBidOn.get(i).getName());
            json.addProperty("listingPrice", listingsIBidOn.get(i).getPrice());
            json.addProperty("listingEndTimestamp", listingsIBidOn.get(i).getEndTimestamp().toString());
            json.addProperty("listingType", listingsIBidOn.get(i).getType());
            json.addProperty("listingId", listingsIBidOn.get(i).getId());
            json.addProperty("listingImage", listingsIBidOn.get(i).getImages().get(0).getImage_path() + "/" + listingsIBidOn.get(i).getImages().get(0).getImage_name());

            result.add(json);
        }

        return result.toString();
    }

    @RequestMapping(value = "/bidsOnMyListings", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String showBidsOnMyListings(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        List<Listing> bidsOnMyListings = listingService.getRecentListingsWithOffersOrBidsForUserByUserID(user.getUserID());
        JsonArray result = new JsonArray();
        for (int i = 0; i < bidsOnMyListings.size(); i++) {

            JsonObject json = new JsonObject();

            json.addProperty("listingHighestBid", bidsOnMyListings.get(i).getHighestBid());
            json.addProperty("listingName", bidsOnMyListings.get(i).getName());
            json.addProperty("listingPrice", bidsOnMyListings.get(i).getPrice());
            json.addProperty("listingEndTimestamp", bidsOnMyListings.get(i).getEndTimestamp().toString());
            json.addProperty("listingType", bidsOnMyListings.get(i).getType());
            json.addProperty("listingId", bidsOnMyListings.get(i).getId());
            json.addProperty("listingImage", bidsOnMyListings.get(i).getImages().get(0).getImage_path() + "/" + bidsOnMyListings.get(i).getImages().get(0).getImage_name());

            result.add(json);

        }

        return result.toString();
    }

    @RequestMapping(value = "/getRelevantListing", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String showRelevantRecommendations(HttpServletRequest request) {

        //System.out.println("Trying to get relevant");

        User user = (User) request.getSession().getAttribute("user");

        Listing recentListing = listingService.getRecentListingWithOfferOrBidByUserID(user.getUserID());
        System.out.println("Recent: " + recentListing);
        Listing relevantListing = listingService.getRelevantListingsFromRecentPurchaseByUserID(user.getUserID(), recentListing.getCategory());
        System.out.println("Relevant: " + relevantListing);

        JsonObject json = new JsonObject();

        json.addProperty("listingHighestBid", String.valueOf(relevantListing.getHighestBid()));
        json.addProperty("listingName", relevantListing.getName());
        json.addProperty("listingPrice", relevantListing.getPrice());
        json.addProperty("listingEndTimestamp", relevantListing.getEndTimestamp().toString());
        json.addProperty("listingType", relevantListing.getType());
        json.addProperty("listingId", relevantListing.getId());

        System.out.println("Listing images: " + relevantListing.getImages().get(0).getImage_name());
        json.addProperty("listingImage", relevantListing.getImages().get(0).getImage_path() + "/" + relevantListing.getImages().get(0).getImage_name());

        return json.toString();
    }

    @RequestMapping(value = "/offerDetails", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String showOfferDetails(HttpServletRequest request, @RequestParam("offerId") int offerid) {

        System.out.println("Offer id from details: " + offerid);

        User user = (User) request.getSession().getAttribute("user");
        Offer offer = offerService.getOfferById(offerid);

        JsonObject json = new JsonObject();

        json.addProperty("offerId", offer.getOfferID());
        json.addProperty("offerAmount", offer.getOfferAmount());
        json.addProperty("offerMessage", String.valueOf(offer.getOfferMessage()));
        json.addProperty("offerMaker", offer.getOfferMaker().getUsername());
        json.addProperty("offerListing", offer.getListingID().getName());
        json.addProperty("offerListingID", offer.getListingID().getId());
        System.out.println("Listing: " + offer.getListingID().getName());
        json.addProperty("offerReceiver", offer.getOfferReceiver().getUserID());
        json.addProperty("offerDateCreated", offer.getDateCreated().toString());
        json.addProperty("offerStatus", offer.getStatus());
        json.addProperty("offerActive", offer.getActive());

        return json.toString();
    }

    @RequestMapping(value = "/pickUpDetails", method = RequestMethod.GET)
    public String showPickUpDetails(HttpServletRequest request, @RequestParam("pickupId") int pickupId) {

        System.out.println("Pickup id: " + pickupId);
        User user = (User) request.getSession().getAttribute("user");

        JsonObject json = new JsonObject();

        // Set json properties

        return json.toString();
    }

    @RequestMapping(value = "/transactionDetails", method = RequestMethod.GET)
    public String showTransactionDetails(HttpServletRequest request, @RequestParam("transactionId") int transactionId) {

        System.out.println("Transaction id: " + transactionId);
        User user = (User) request.getSession().getAttribute("user");

        JsonObject json = new JsonObject();

        // Set json properties

        return json.toString();
    }

    @RequestMapping(value = "cancelAuction", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody
    boolean cancelAuctionAjax(HttpServletRequest request, @RequestParam("listing") int id) {

        User user = (User) request.getSession().getAttribute("user");

        Listing listing = listingService.getByListingID(id);

        try {
            System.out.println("trying");
            if (listing == null) {
                System.out.println("checking");
                if (listing.getBidCount() > 0) {
                    return false;
                }
                System.out.println("setting");
                listing.setActive(0);
                listing.setEnded(1);
                listingService.saveOrUpdate(listing);

                return true;

            } else {
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    @RequestMapping(value = "dashboardAllListings", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody String dashboardAllListings(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        List<Listing> allListings = listingService.getAllListingsByUserID(user.getUserID());

        if(allListings != null || !allListings.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < allListings.size(); i++) {
                if(allListings.get(i).getDraft() == 0) {
                    JsonObject addJson = new JsonObject();
                    List<Image> temp = allListings.get(i).getImages();
                    addJson.addProperty("listingId", allListings.get(i).getId());
                    addJson.addProperty("listingName", allListings.get(i).getName());
                    addJson.addProperty("listingCategory", allListings.get(i).getCategory());
                    addJson.addProperty("listingPrice", allListings.get(i).getPrice());
                    addJson.addProperty("listingEndTime", allListings.get(i).getEndTimestamp().toString());
                    addJson.addProperty("listingCreatedTime", allListings.get(i).getDateCreated().toString());
                    addJson.addProperty("listingBids", allListings.get(i).getBidCount());
                    addJson.addProperty("listingHighestBids", allListings.get(i).getHighestBid());
                    JsonArray images = new JsonArray();
                    for(int j = 0; j < temp.size(); j++) {
                        JsonObject image = new JsonObject();
                        image.addProperty("image", temp.get(j).getImage_path() + "/" + temp.get(j).getImage_name());
                        images.add(image);
                    }

                    addJson.addProperty("listingImages", images.toString());

                    if(allListings.get(i).getEndTimestamp() == null) {
                        addJson.addProperty("listingType", "Auction");
                    } else if(allListings.get(i).getPrice() == 0){
                        addJson.addProperty("listingType", "Donation");
                    } else{
                        addJson.addProperty("listingType", "Fixed Price");
                    }
                    result.add(addJson);
                }
            }
            return result.toString();
        }

        return null;

    }

    @RequestMapping(value = "dashboardActiveListings", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody String dashboardActiveListings(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        List<Listing> allListings = listingService.getAllListingsByUserID(user.getUserID());

        if(allListings != null || !allListings.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < allListings.size(); i++) {
                if(allListings.get(i).getDraft() == 0 && allListings.get(i).getActive() == 1) {
                    JsonObject addJson = new JsonObject();
                    List<Image> temp = allListings.get(i).getImages();
                    addJson.addProperty("listingId", allListings.get(i).getId());
                    addJson.addProperty("listingName", allListings.get(i).getName());
                    addJson.addProperty("listingCategory", allListings.get(i).getCategory());
                    addJson.addProperty("listingPrice", allListings.get(i).getPrice());
                    addJson.addProperty("listingEndTime", allListings.get(i).getEndTimestamp().toString());
                    addJson.addProperty("listingCreatedTime", allListings.get(i).getDateCreated().toString());
                    addJson.addProperty("listingBids", allListings.get(i).getBidCount());
                    addJson.addProperty("listingHighestBids", allListings.get(i).getHighestBid());
                    JsonArray images = new JsonArray();
                    for(int j = 0; j < temp.size(); j++) {
                        JsonObject image = new JsonObject();
                        image.addProperty("image", temp.get(j).getImage_path() + "/" + temp.get(j).getImage_name());
                        images.add(image);
                    }

                    addJson.addProperty("listingImages", images.toString());

                    if(allListings.get(i).getEndTimestamp() == null) {
                        addJson.addProperty("listingType", "Auction");
                    } else if(allListings.get(i).getPrice() == 0){
                        addJson.addProperty("listingType", "Donation");
                    } else{
                        addJson.addProperty("listingType", "Fixed Price");
                    }
                    result.add(addJson);
                }
            }
            return result.toString();
        }

        return null;

    }

    @RequestMapping(value = "dashboardInactiveListings", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody String dashboardInactiveListings(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        List<Listing> allListings = listingService.getAllListingsByUserID(user.getUserID());

        if(allListings != null || !allListings.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < allListings.size(); i++) {
                if(allListings.get(i).getDraft() == 0 && allListings.get(i).getActive() == 0) {
                    JsonObject addJson = new JsonObject();
                    List<Image> temp = allListings.get(i).getImages();
                    addJson.addProperty("listingId", allListings.get(i).getId());
                    addJson.addProperty("listingName", allListings.get(i).getName());
                    addJson.addProperty("listingCategory", allListings.get(i).getCategory());
                    addJson.addProperty("listingPrice", allListings.get(i).getPrice());
                    addJson.addProperty("listingEndTime", allListings.get(i).getEndTimestamp().toString());
                    addJson.addProperty("listingCreatedTime", allListings.get(i).getDateCreated().toString());
                    addJson.addProperty("listingBids", allListings.get(i).getBidCount());
                    addJson.addProperty("listingHighestBids", allListings.get(i).getHighestBid());
                    JsonArray images = new JsonArray();
                    for(int j = 0; j < temp.size(); j++) {
                        JsonObject image = new JsonObject();
                        image.addProperty("image", temp.get(j).getImage_path() + "/" + temp.get(j).getImage_name());
                        images.add(image);
                    }

                    addJson.addProperty("listingImages", images.toString());

                    if(allListings.get(i).getEndTimestamp() == null) {
                        addJson.addProperty("listingType", "Auction");
                    } else if(allListings.get(i).getPrice() == 0){
                        addJson.addProperty("listingType", "Donation");
                    } else{
                        addJson.addProperty("listingType", "Fixed Price");
                    }
                    result.add(addJson);
                }
            }
            return result.toString();
        }


        return null;

    }

    @RequestMapping(value = "dashboardWonListings", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody String dashboardWonListings(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        List<Listing> allListings = listingService.getListingsWon(user.getUserID());

        if(allListings != null || !allListings.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < allListings.size(); i++) {

                JsonObject addJson = new JsonObject();
                List<Image> temp = allListings.get(i).getImages();
                addJson.addProperty("listingId", allListings.get(i).getId());
                addJson.addProperty("listingName", allListings.get(i).getName());
                addJson.addProperty("listingCategory", allListings.get(i).getCategory());
                addJson.addProperty("listingPrice", allListings.get(i).getPrice());
                addJson.addProperty("listingEndTime", allListings.get(i).getEndTimestamp().toString());
                addJson.addProperty("listingCreatedTime", allListings.get(i).getDateCreated().toString());
                addJson.addProperty("listingBids", allListings.get(i).getBidCount());
                addJson.addProperty("listingHighestBids", allListings.get(i).getHighestBid());
                JsonArray images = new JsonArray();
                for (int j = 0; j < temp.size(); j++) {
                    JsonObject image = new JsonObject();
                    image.addProperty("image", temp.get(j).getImage_path() + "/" + temp.get(j).getImage_name());
                    images.add(image);
                }

                addJson.addProperty("listingImages", images.toString());

                if (allListings.get(i).getEndTimestamp() == null) {
                    addJson.addProperty("listingType", "Auction");
                } else if (allListings.get(i).getPrice() == 0) {
                    addJson.addProperty("listingType", "Donation");
                } else {
                    addJson.addProperty("listingType", "Fixed Price");
                }
                result.add(addJson);

            }
            return result.toString();
        }

        return null;

    }

    @RequestMapping(value = "dashboardLostListings", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody String dashboardLostListings(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        List<Listing> allListings = listingService.getListingsLost(user.getUserID());

        if(allListings != null || !allListings.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < allListings.size(); i++) {

                JsonObject addJson = new JsonObject();
                List<Image> temp = allListings.get(i).getImages();
                addJson.addProperty("listingId", allListings.get(i).getId());
                addJson.addProperty("listingName", allListings.get(i).getName());
                addJson.addProperty("listingCategory", allListings.get(i).getCategory());
                addJson.addProperty("listingPrice", allListings.get(i).getPrice());
                addJson.addProperty("listingEndTime", allListings.get(i).getEndTimestamp().toString());
                addJson.addProperty("listingCreatedTime", allListings.get(i).getDateCreated().toString());
                addJson.addProperty("listingBids", allListings.get(i).getBidCount());
                addJson.addProperty("listingHighestBids", allListings.get(i).getHighestBid());
                JsonArray images = new JsonArray();
                for(int j = 0; j < temp.size(); j++) {
                    JsonObject image = new JsonObject();
                    image.addProperty("image", temp.get(j).getImage_path() + "/" + temp.get(j).getImage_name());
                    images.add(image);
                }

                addJson.addProperty("listingImages", images.toString());

                if(allListings.get(i).getEndTimestamp() == null) {
                    addJson.addProperty("listingType", "Auction");
                }
                else if(allListings.get(i).getPrice() == 0){
                    addJson.addProperty("listingType", "Donation");
                }
                else{
                    addJson.addProperty("listingType", "Fixed Price");
                }
                result.add(addJson);

            }
            return result.toString();
        }

        return null;

    }

    @RequestMapping(value = "dashboardSoldListings", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody String dashboardSoldListings(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        List<Listing> allListings = listingService.getListingsSold(user.getUserID());

        if(allListings != null || !allListings.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < allListings.size(); i++) {

                JsonObject addJson = new JsonObject();
                List<Image> temp = allListings.get(i).getImages();
                addJson.addProperty("listingId", allListings.get(i).getId());
                addJson.addProperty("listingName", allListings.get(i).getName());
                addJson.addProperty("listingCategory", allListings.get(i).getCategory());
                addJson.addProperty("listingPrice", allListings.get(i).getPrice());
                addJson.addProperty("listingEndTime", allListings.get(i).getEndTimestamp().toString());
                addJson.addProperty("listingCreatedTime", allListings.get(i).getDateCreated().toString());
                addJson.addProperty("listingBids", allListings.get(i).getBidCount());
                addJson.addProperty("listingHighestBids", allListings.get(i).getHighestBid());
                JsonArray images = new JsonArray();
                for(int j = 0; j < temp.size(); j++) {
                    JsonObject image = new JsonObject();
                    image.addProperty("image", temp.get(j).getImage_path() + "/" + temp.get(j).getImage_name());
                    images.add(image);
                }

                addJson.addProperty("listingImages", images.toString());

                if(allListings.get(i).getEndTimestamp() == null) {
                    addJson.addProperty("listingType", "Auction");
                }
                else if(allListings.get(i).getPrice() == 0){
                    addJson.addProperty("listingType", "Donation");
                }
                else{
                    addJson.addProperty("listingType", "Fixed Price");
                }
                result.add(addJson);

            }
            return result.toString();
        }

        return null;

    }

    @RequestMapping(value = "dashboardFavoriteListings", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody String dashboardFavoriteListings(HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        List<Favorite> fav = favoriteService.findAllFavoritesByUser(user.getUserID());
        ArrayList<Listing> favListing = new ArrayList<>();
        for(int j =0; j < fav.size(); j++){
            favListing.add(fav.get(j).getListing());
        }
        List<Listing> allListings = favListing.subList(0,favListing.size());

        if(allListings != null || !allListings.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < allListings.size(); i++) {

                JsonObject addJson = new JsonObject();
                List<Image> temp = allListings.get(i).getImages();
                addJson.addProperty("listingId", allListings.get(i).getId());
                addJson.addProperty("listingName", allListings.get(i).getName());
                addJson.addProperty("listingCategory", allListings.get(i).getCategory());
                addJson.addProperty("listingPrice", allListings.get(i).getPrice());
                addJson.addProperty("listingEndTime", allListings.get(i).getEndTimestamp().toString());
                addJson.addProperty("listingCreatedTime", allListings.get(i).getDateCreated().toString());
                addJson.addProperty("listingBids", allListings.get(i).getBidCount());
                addJson.addProperty("listingHighestBids", allListings.get(i).getHighestBid());
                JsonArray images = new JsonArray();
                for(int j = 0; j < temp.size(); j++) {
                    JsonObject image = new JsonObject();
                    image.addProperty("image", temp.get(j).getImage_path() + "/" + temp.get(j).getImage_name());
                    images.add(image);
                }

                addJson.addProperty("listingImages", images.toString());

                if(allListings.get(i).getEndTimestamp() == null) {
                    addJson.addProperty("listingType", "Auction");
                }
                else if(allListings.get(i).getPrice() == 0){
                    addJson.addProperty("listingType", "Donation");
                }
                else{
                    addJson.addProperty("listingType", "Fixed Price");
                }
                result.add(addJson);

            }
            return result.toString();
        }

        return null;

    }

}