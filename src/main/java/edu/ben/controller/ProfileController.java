package edu.ben.controller;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import edu.ben.model.*;

import edu.ben.service.*;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProfileController extends BaseController {
	@Autowired
	UserService userService;

	@Autowired
	ListingService listingService;

	@Autowired
	FollowService followService;
	
	@Autowired
	TransactionService transactionService;
	
	@Autowired
	OfferService offerService;

	@Autowired
    ImageService imageService;

    @Autowired
    SalesTrafficService salesTrafficService;

    @RequestMapping(value = "/viewProfile", method = RequestMethod.GET)
    public String viewProfile(HttpServletRequest request, @RequestParam("id") int id) {

        List<Listing> userListings = listingService.getAllListingsByUserID(id);
        // user offers
        List<Offer> offers = offerService.getPendingOffersByUserId(id);
        // user transactions
        List<Transaction> buyerTransactions = transactionService.getTransactionsByBuyerID(id);
        List<Transaction> sellerTransactions = transactionService.getTransactionsBySellerID(id);
        
        List<Offer> myOffers = offerService.getPendingOffersByListingId(id);
        
        request.setAttribute("user", userService.getUserById(id));
        
        request.setAttribute("userListings", userListings);
        request.setAttribute("myOffers", offers);
        request.setAttribute("transactions", buyerTransactions);
        request.setAttribute("transactions", sellerTransactions);
        request.setAttribute("offers", myOffers);

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            // Add site traffic record
            salesTrafficService.create(new SalesTraffic("Profile_Page"));
        } else {
            // Add site traffic record
            salesTrafficService.create(new SalesTraffic("Profile_Page", user.getUserID()));
        }

        return "profile-page";
    }

    @RequestMapping(value = "/viewUserListings", method = RequestMethod.GET)
    public String viewUserListing(HttpServletRequest request) {
        User session = (User) request.getSession().getAttribute("user");

        List<Listing> userListings = listingService.getAllListingsByUserID(session.getUserID());

        List<Listing> listingsWon = listingService.getListingsWon(session.getUserID());
        List<Listing> listingsLost = listingService.getListingsLost(session.getUserID());
        List<Listing> listingsActive = listingService.getListingsInProgressUserBidOn(session.getUserID());

        request.setAttribute("user", session);
        request.setAttribute("userListings", userListings);

        request.setAttribute("listingsWon", listingsWon);
        if (listingsWon != null) {
            request.setAttribute("wonCount", listingsWon.size());
        } else {
            request.setAttribute("wonCount", 0);
        }

        request.setAttribute("listingsActive", listingsActive);
        if (listingsActive != null) {
            request.setAttribute("activeCount", listingsActive.size());
        } else {
            request.setAttribute("activeCount", 0);
        }

        request.setAttribute("listingsLost", listingsLost);
        if (listingsLost != null) {
            request.setAttribute("lostCount", listingsLost.size());
        } else {
            request.setAttribute("lostCount", 0);
        }

        return "listing-profile";
    }
    
    @RequestMapping(value="/editListing", method=RequestMethod.POST)
    public String editListing(@RequestParam("listing") int id, @RequestParam("price") int price) {
    	
    	Listing listing = listingService.getByListingID(id);
    	listing.setPrice(price);
    	listingService.saveOrUpdate(listing);
    	addSuccessMessage("Price successfully updated!");
    	
    	return "redirect:/viewProfile";
    }

    @RequestMapping(value="/profileImageUpload", method=RequestMethod.GET)
    public String profileImageUpload(HttpServletRequest request){
	    User user = (User) request.getSession().getAttribute("user");
	    if(user == null){
	        return "index";
        }
	    return "profile-image-upload";
    }

    @RequestMapping(value="/profileImageUpload", method=RequestMethod.POST)
    public String profileImageUploadPost(@RequestParam("file") MultipartFile file,@RequestParam(value ="imageMain", required = false) String imageMain, HttpServletRequest request){
        User u = (User) request.getSession().getAttribute("user");
	    String fileType = FilenameUtils.getExtension(file.getOriginalFilename());
        String fileName = FilenameUtils.getBaseName(file.getOriginalFilename());

        if(fileType.equals("jpg") || fileType.equals("png") || fileType.equals("jpeg")){
            Image imgImport = new Image();
            try {
                byte[] bytes = file.getBytes();
                System.out.println("File Directory:   " +System.getProperty("user.home")+ File.separator + "ulistitUsers" + File.separator + u.getUserID()+"@"+u.getSchoolEmail() + File.separator + "profile");
                File dir = new File( System.getProperty("user.home")+ File.separator + "ulistitUsers" + File.separator + u.getUserID()+"@"+u.getSchoolEmail() + File.separator + "profile");
                if (!dir.exists())
                    dir.mkdirs();
                System.out.println("Image Path:     "+ "ulistitUsers" + "/" + u.getUserID()+"@"+u.getSchoolEmail() + "/" + "profile");
                imgImport.setImage_path("ulistitUsers" + "/" + u.getUserID()+"@"+u.getSchoolEmail() + "/" + "profile");
                imgImport.setUser(u);
                imgImport.setImage_name(fileName + "." + fileType);
                if (imageMain != null) {
                    imageService.removeAllMainImages(u.getUserID());
                    imgImport.setMain(1);
                } else {
                    imgImport.setMain(0);
                }
                imageService.save(imgImport);
                System.out.println("Full File path:     "+ System.getProperty("user.home")+ File.separator + "ulistitUsers" + File.separator + u.getUserID()+"@"+u.getSchoolEmail() + File.separator + "profile" + File.separator + file.getOriginalFilename());
                File serverFile = new File(System.getProperty("user.home")+ File.separator + "ulistitUsers" + File.separator + u.getUserID()+"@"+u.getSchoolEmail() + File.separator + "profile" + File.separator + file.getOriginalFilename());
                try {
                    BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
                    stream.write(bytes);
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            request.getSession().setAttribute("user",(User) userService.getUserById(u.getUserID()));
        }
        addSuccessMessage("Profile image uploaded successfully!");
        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }

    @RequestMapping(value="/changeImageMain", method=RequestMethod.POST)
    public String profileImageUploadPost(@RequestParam("mainImage") int mainImage, HttpServletRequest request){
        User u = (User) request.getSession().getAttribute("user");
        imageService.removeAllMainImages(u.getUserID());
        imageService.changeMain(mainImage, 1);
        request.getSession().setAttribute("user",(User) userService.getUserById(u.getUserID()));
        addSuccessMessage("Main profile picture changed!");
        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }

    @RequestMapping(value ="getFollowing", method = RequestMethod.GET, produces="application/json")
    public @ResponseBody String getFollowing(HttpServletRequest request){
        User u = (User) request.getSession().getAttribute("user");
        List<Follow> followers = (List<Follow>) followService.findAllFollowersByUserId(u.getUserID());

        if(followers != null || !followers.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < followers.size(); i++) {
                if(followers.get(i).getUser().getActive() == 1) {
                    JsonObject addJson = new JsonObject();
                    addJson.addProperty("followerId", followers.get(i).getFollower().getUserID());
                    addJson.addProperty("followerUsername", followers.get(i).getFollower().getUsername());
                    addJson.addProperty("followerFirstName", followers.get(i).getFollower().getUsername());
                    addJson.addProperty("followerLastName", followers.get(i).getFollower().getLastName());
                    addJson.addProperty("followerImage", followers.get(i).getFollower().getMainImage());
                    result.add(addJson);
                }
            }
            return result.toString();
        }
        return null;
    }

    @RequestMapping(value ="getFollowers", method = RequestMethod.GET, produces="application/json")
    public @ResponseBody String getFollowers(HttpServletRequest request){
        User u = (User) request.getSession().getAttribute("user");
        List<Follow> followers = (List<Follow>) followService.findAllPeopleFollowingYou(u.getUserID());

        if(followers != null || !followers.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < followers.size(); i++) {
                if(followers.get(i).getUser().getActive() == 1) {
                    JsonObject addJson = new JsonObject();
                    addJson.addProperty("followerId", followers.get(i).getUser().getUserID());
                    addJson.addProperty("followerUsername", followers.get(i).getUser().getUsername());
                    addJson.addProperty("followerFirstName", followers.get(i).getUser().getUsername());
                    addJson.addProperty("followerLastName", followers.get(i).getUser().getLastName());
                    addJson.addProperty("followerImage", followers.get(i).getUser().getMainImage());
                    result.add(addJson);
                }
            }
            return result.toString();
        }

        return null;
    }


    @RequestMapping(value ="unfollowUser", method = RequestMethod.POST, produces="application/json")
    public @ResponseBody Boolean unfollowUser(HttpServletRequest request, @RequestParam("unfollowId") int id){
        User u = (User) request.getSession().getAttribute("user");
        System.out.println(id);
        followService.unfollow(u.getUserID(), id);
        return true;
    }
}