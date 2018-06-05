package edu.ben.controller;

import com.google.gson.JsonObject;
import edu.ben.model.*;
import edu.ben.service.*;
import edu.ben.util.ListingRunner;
import edu.ben.util.PickUpRunner;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import edu.ben.service.CategoryService;
import edu.ben.service.FavoriteService;
import edu.ben.service.ListingService;
import edu.ben.service.OfferService;
import edu.ben.service.NotificationService;
import edu.ben.service.SavedSearchService;
import edu.ben.service.UserService;
import edu.ben.util.Path;

@Controller
@Transactional
public class ListingController extends BaseController {

    @Autowired
    ListingService listingService;

    @Autowired
    FavoriteService favoriteService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    UserService userService;

    @Autowired
    OfferService offerService;

    @Autowired
    SavedSearchService savedSearchService;

    @Autowired
    NotificationService notificationService;

    @Autowired
    PickUpService pickUpService;

    @Autowired
    TransactionService transactionService;

    @Autowired
    private Environment environment;

    @Autowired
    ImageService imageService;

    @Autowired
    SalesTrafficService trafficService;

    @Autowired
    TutorialService tutorialService;

    /**
     * Upload single file using Spring Controller
     */
    @RequestMapping(value = "/uploadListing", method = RequestMethod.POST)
    public String uploadFileHandler(@RequestParam("title") String name, @RequestParam("category") String category,
                                    @RequestParam("subCategory") String subCategory,
                                    @RequestParam(value = "price", required = false) Integer price,
                                    @RequestParam("description") String description, @RequestParam("file") List<MultipartFile> file,
                                    @RequestParam("type") String type, @RequestParam(value = "paymentType", required = false) String paymentType,
                                    @RequestParam(value = "draft", required = false) String draft, @RequestParam(value = "endTime", required = false) String endTime,
                                    @RequestParam(value = "endDate", required = false) String endDate, HttpServletRequest request) {

        User u = (User) request.getSession().getAttribute("user");

        if (u == null) {
            addErrorMessage("Login To Create A Listing");
            setRequest(request);
            return "login";
        }

        if (price == null) {
            price = 0;
        }

        Listing temp = new Listing();
        temp.setName(name);
        temp.setCategory(category);
        temp.setSubCategory(subCategory);
        temp.setPrice(price);
        temp.setType(type);
        temp.setPaymentType(paymentType);
        temp.setDescription(description);

        if (type.equals("")) {
            addErrorMessage("Invalid Type");
            setRequest(request);
            request.setAttribute("listing", temp);
            return "listing/create-listing";
        }

        Timestamp endTimestamp = null;

        // If auction
        if (type.equals("auction")) {

            // Empty Date and Time
            if (endDate == null && endTime == null) {
                addErrorMessage("Invalid End Date & Time");
                setRequest(request);
                request.setAttribute("listing", temp);
                return "listing/create-listing";

                // Empty Time
            } else if (endTime == null) {
                addErrorMessage("Invalid End Time");
                setRequest(request);
                request.setAttribute("listing", temp);
                return "listing/create-listing";

                // Empty Date
            } else if (endDate == null) {
                addErrorMessage("Invalid End Time");
                setRequest(request);
                request.setAttribute("listing", temp);
                return "listing/create-listing";

                // Date and Time Not Empty
            } else {

                try {

                    // Get year, month, day, hour, and minutes from endDate and endTime
                    int year = Integer.parseInt(endDate.substring(0, 4));
                    // Timestamp adds an extra month
                    int day = Integer.parseInt(endDate.substring(8, 10));
                    int hours = Integer.parseInt(endTime.substring(0, 2));
                    int min = Integer.parseInt(endTime.substring(3, 5));
                    int mon = Integer.parseInt(endDate.substring(5, 7)) - 1;

                    Calendar calendar = Calendar.getInstance();
                    calendar.set(year, mon, day, hours, min, 0);
                    endTimestamp = new Timestamp((calendar.getTimeInMillis()));

                } catch (Exception e) {
                    addErrorMessage("Date & Time Error");
                    setRequest(request);
                    request.setAttribute("listing", temp);
                    request.setAttribute("endDate", endDate);
                    request.setAttribute("endTime", endTime);
                    return "listing/create-listing";
                }

            }

            // If fixed or donation
        } else {

            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.MONTH, 1);
            endTimestamp = new Timestamp(calendar.getTime().getTime());

        }

        System.out.println("TIMESTAMP: " + endTimestamp.toString());

        if (name == null || name.isEmpty()) {
            addErrorMessage("Please use a valid Title");
            setRequest(request);
            request.setAttribute("listing", temp);
            request.setAttribute("endDate", endDate);
            request.setAttribute("endTime", endTime);
            return "listing/create-listing";
        }

        if (price < 0) {
            addErrorMessage("Cannot have a negative price.");
            setRequest(request);
            request.setAttribute("listing", temp);
            request.setAttribute("endDate", endDate);
            request.setAttribute("endTime", endTime);
            return "listing/create-listing";
        }

        Listing listing = new Listing(name, description, price, category, paymentType);
        listing.setEndTimestamp(endTimestamp);

        if (type.equals("auction")) {
            listing.setType("auction");
            listing.setHighestBid(0);
            listing.setPrice(0);
        } else if (type.equals("fixed")) {
            listing.setType("fixed");
        } else {
            listing.setType("donation");
            listing.setPrice(0);
            listing.setPaymentType("NONE");
        }

        if (category != null) {
            listing.setCategory(category);
        } else {
            addErrorMessage("Need to select a valid category");
            setRequest(request);
            request.setAttribute("listing", temp);
            request.setAttribute("endDate", endDate);
            request.setAttribute("endTime", endTime);
            return "listing/create-listing";
        }

        if (subCategory != null) {
            listing.setSubCategory(subCategory);
        } else {
            addErrorMessage("Need to select a valid sub-category");
            setRequest(request);
            request.setAttribute("listing", temp);
            request.setAttribute("endDate", endDate);
            request.setAttribute("endTime", endTime);
            return "listing/create-listing";
        }

        if (type != null) {
            listing.setType(type);
        } else {
            addErrorMessage("Need to select a valid type");
            setRequest(request);
            request.setAttribute("listing", temp);
            request.setAttribute("endDate", endDate);
            request.setAttribute("endTime", endTime);
            return "listing/create-listing";
        }

        if (paymentType != null) {
            listing.setPaymentType(paymentType);
        } else {
            if (!type.equals("donation")) {
                addErrorMessage("Need to select a valid payment type");
                setRequest(request);
                request.setAttribute("listing", temp);
                request.setAttribute("endDate", endDate);
                request.setAttribute("endTime", endTime);
                return "listing/create-listing";
            } else {
                listing.setPaymentType("NONE");
            }
        }


        if (draft != null) {
            listing.setDraft(1);
        } else {
            listing.setDraft(0);
        }

        ArrayList<String> ignoring = new ArrayList<String>();

        // Ignore Removed Files
        String filesToIgnore = request.getParameter("filesToIgnore");
        if (!filesToIgnore.equals(""))

        {
            String[] filesToSkip = filesToIgnore.split(" ");
            for (String skip : filesToSkip) {
                ignoring.add(skip);
            }
        }

        // Uploading File
        if (!file.isEmpty()) {
            try {
                listing.setUser(u);
                listingService.save(listing);
                List<Listing> list = listingService.getAllListingsByUserID(u.getUserID());

                Listing lst = null;

                for (Listing l : list) {
                    if (l.getName().equals(listing.getName()) && l.getCategory().equals(listing.getCategory())) {
                        lst = l;
                    }
                }

                if (lst != null) {

                    int listingId = lst.getId();

                    String directory = System.getProperty("user.home");
                    for (int i = 0; i < file.size(); i++) {
                        String fileType = FilenameUtils.getExtension(file.get(i).getOriginalFilename());
                        String fileName = FilenameUtils.getBaseName(file.get(i).getOriginalFilename());

                        if (!ignoring.contains(fileName + "." + fileType)) {
                            if (fileType.equals("jpg") || fileType.equals("png") || fileType.equals("jpeg")) {
                                Image imgImport = new Image();
                                try {
                                    byte[] bytes = file.get(i).getBytes();
                                    System.out.println("File Directory:   " + System.getProperty("user.home") + File.separator + "ulistitUsers" + File.separator + u.getUserID() + "@" + u.getSchoolEmail() + File.separator + "listings" + File.separator + listingId);
                                    File dir = new File(System.getProperty("user.home") + File.separator + "ulistitUsers" + File.separator + u.getUserID() + "@" + u.getSchoolEmail() + File.separator + "listings" + File.separator + listingId);
                                    if (!dir.exists())
                                        dir.mkdirs();
                                    System.out.println("Image Path:     " + "ulistitUsers" + "/" + u.getUserID() + "@" + u.getSchoolEmail() + "/" + "listings" + "/" + listingId);
                                    imgImport.setImage_path("ulistitUsers" + "/" + u.getUserID() + "@" + u.getSchoolEmail() + "/" + "listings" + "/" + listingId);
                                    imgImport.setListing(lst);
                                    imgImport.setImage_name(fileName + "." + fileType);
                                    if (i == 0)
                                        imgImport.setMain(1);
                                    imageService.save(imgImport);
                                    System.out.println("Full File path:     " + System.getProperty("user.home") + File.separator + "ulistitUsers" + File.separator + u.getUserID() + "@" + u.getSchoolEmail() + File.separator + "listings" + File.separator + listingId + File.separator + file.get(i).getOriginalFilename());
                                    File serverFile = new File(System.getProperty("user.home") + File.separator + "ulistitUsers" + File.separator + u.getUserID() + "@" + u.getSchoolEmail() + File.separator + "listings" + File.separator + listingId + File.separator + file.get(i).getOriginalFilename());
                                    try {
                                        BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
                                        stream.write(bytes);
                                    } catch (FileNotFoundException e) {
                                        e.printStackTrace();
                                    }

                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                        } else {
                            System.out.println("Skipped A Image " + fileName + "." + fileType);
                        }
                    }

                } else {
                    addErrorMessage("Error Loading Listing Details");
                    request.setAttribute("listing", temp);
                    request.setAttribute("endDate", endDate);
                    request.setAttribute("endTime", endTime);
                    setRequest(request);
                    return "listing/create-listing";
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("listing", temp);
                request.setAttribute("endDate", endDate);
                request.setAttribute("endTime", endTime);
                return "listing/create-listing";
            }

            ArrayList<SavedSearch> allSavedSearches = (ArrayList<SavedSearch>) savedSearchService
                    .getAllSavedSearches();

            System.out.println("Saved Search size: " + allSavedSearches.size());

            if (allSavedSearches != null) {
                for (int i = 0; i < allSavedSearches.size(); i++) {
                    if (description.toLowerCase().contains(allSavedSearches.get(i).getSearch().toLowerCase())
                            || name.toLowerCase().contains(allSavedSearches.get(i).getSearch().toLowerCase())) {
                        if (allSavedSearches.get(i).getUser().getUserID() != u.getUserID()) {
                            notificationService.save(new Notification(
                                    userService.getUserById(allSavedSearches.get(i).getUser().getUserID()),
                                    listing.getId(), "New Listing Posted",
                                    u.getUsername() + " has posting a listing\n\n pertaining to "
                                            + allSavedSearches.get(i).getSearch() + ".",
                                    1, "SAVED_SEARCH"));
                        }
                    }
                }
            }

            // LEAVE THIS LINE ALONE
            ListingRunner.run();

            request.getSession().removeAttribute("listing");
            addSuccessMessage("Listing Uploaded Successfully");
            setRequest(request);
            return "redirect:/";

        } else

        {
            addErrorMessage("File Upload Failed. Try Again.");
            setRequest(request);
            request.setAttribute("listing", temp);
            request.setAttribute("endDate", endDate);
            request.setAttribute("endTime", endTime);
            return "listing/create-listing";
        }

    }

    @RequestMapping(value = "/uploadListingDraft", method = RequestMethod.POST)
    public String uploadFileHandlerDraft(@RequestParam("title") String name, @RequestParam("category") String category,
                                         @RequestParam("subCategory") String subCategory,
                                         @RequestParam(value = "price", required = false) int price,
                                         @RequestParam("description") String description,
                                         @RequestParam("type") String type, @RequestParam(value = "paymentType") String paymentType, @RequestParam("id") int id, Model model,
                                         HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Publish A Listing");
            setRequest(request);
            return "redirect:/login";
        }

        Listing listing = listingService.getByListingID(id);

        if (listing == null) {
            addWarningMessage("Error Loading Listing");
            setRequest(request);
            return "redirect:/index";
        }

        listing.setCategory(category);
        listing.setDescription(description);
        listing.setName(name);
        listing.setSubCategory(subCategory);
        listing.setPaymentType(paymentType);
        listing.setType(type);
        listing.setPrice(price);
        listing.setDraft(0);
        listing.setActive(1);

        listingService.saveOrUpdate(listing);

        addSuccessMessage("Listing Successful!");
        setRequest(request);
        return "redirect:/index";
    }


    @RequestMapping("/createListing")
    public String listingPage(HttpServletRequest request) {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            addErrorMessage("Login To Create A Listing");
            setRequest(request);
            return "login";
        }
        setRequest(request);

        if (request.getParameter("t") != null && request.getParameter("t").equals("donation")) {
            request.setAttribute("isDonation", true);
        }

        request.setAttribute("categories", categoryService.getAllCategories());
        request.setAttribute("subCategories", categoryService.getAllSubCategories());

        SalesTraffic s = new SalesTraffic("Create_Listing");

        trafficService.create(s);

        return "listing/create-listing";
    }

    @RequestMapping(value = "/editAdminListing", method = RequestMethod.POST)
    public String uploadFileHandlerListing(@RequestParam("title") String name, @RequestParam("category") String category,
                                           @RequestParam("subCategory") String subCategory,
                                           @RequestParam(value = "price", required = false) int price,
                                           @RequestParam("description") String description,
                                           @RequestParam("type") String type, @RequestParam(value = "paymentType") String paymentType, @RequestParam("id") int id, Model model,
                                           HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Publish A Listing");
            setRequest(request);
            return "redirect:/login";
        }

        Listing listing = listingService.getByListingID(id);

        if (listing == null) {
            addWarningMessage("Error Loading Listing");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        listing.setCategory(category);
        listing.setDescription(description);
        listing.setName(name);
        listing.setSubCategory(subCategory);
        listing.setPaymentType(paymentType);
        listing.setType(type);
        listing.setPrice(price);

        listingService.saveOrUpdate(listing);

        addSuccessMessage("Listing Successful!");
        setRequest(request);
        return "redirect:/adminListing";
    }

    @GetMapping("/createListingDraft")
    public String createListingDraft(HttpServletRequest request, @RequestParam("id") int id) {
        User u = (User) request.getSession().getAttribute("user");
        if (u == null) {
            addErrorMessage("Login To Create A Listing");
            setRequest(request);
            return "login";
        }
        setRequest(request);

        request.setAttribute("categories", categoryService.getAllCategories());
        request.setAttribute("subCategories", categoryService.getAllSubCategories());
        System.out.println(id);
        request.setAttribute("listing", listingService.getByListingID(id));
        request.setAttribute("isDraft", true);
        return "listing/create-listing";
    }


    @RequestMapping("/displayListing")
    public String displayListing(HttpServletRequest request) {
        setRequest(request);
        return "displayListing";
    }

    @RequestMapping("/listingDrafts")
    public String listingDrafts(HttpServletRequest request) {
        setRequest(request);
        return "listingDrafts";
    }

    @RequestMapping(value = "/viewListingDrafts", method = RequestMethod.GET)
    public String viewListingDrafts(HttpServletRequest request) {
        User session = (User) request.getSession().getAttribute("user");

        if (session == null) {
            addWarningMessage("Login To View Your Drafts");
            setRequest(request);
            return "login";
        }

        List<Listing> userDrafts = listingService.getUserDrafts(session.getUserID());
        System.out.println("size " + userDrafts.size());
        request.setAttribute("user", session);
        request.setAttribute("userDrafts", userDrafts);

        return "listingDrafts";
    }

    @RequestMapping("/displayListingByCategory")
    public String displayListingByCategory(@RequestParam("category") String category, HttpServletRequest
            request,
                                           Model model) {

        System.out.println("Listing Category for display: " + category);
        List<Listing> listings = listingService.getAllListingsByCategory(category);
        System.out.println("List size = " + listings.size());
        //System.out.println(listings.get(0).getImage_path());
        User user = (User) request.getSession().getAttribute("user");

        // System.out.println("User attribute: " + user.getUsername());
        model.addAttribute("user", user);
        model.addAttribute("category", category);
        model.addAttribute("listings", listings);

        return "displayListing";
    }

    @RequestMapping(value = "/updateListingInfo", method = RequestMethod.POST)
    public String updateListingInfo(HttpServletRequest request,
                                    @RequestParam(value = "name") String name,
                                    @RequestParam(value = "description") String description,
                                    @RequestParam(value = "category") String category,
                                    @RequestParam(value = "id") int id)

    {

        Listing listing = listingService.getByListingID(id);
        addSuccessMessage("Listing Updated!");
        setRequest(request);
        listing.setName(name);
        listing.setDescription(description);
        listing.setCategory(category);

        // LEAVE THIS LINE ALONE
        ListingRunner.run();

        listingService.saveOrUpdate(listing);
        return "redirect:/adminListing";
    }


    @RequestMapping(value = "/watch", method = RequestMethod.GET)
    public String watch(HttpServletRequest request, @RequestParam("listingID") String id) {

        int listingID = Integer.parseInt(id);
        Listing listing = listingService.getByListingID(listingID);
        User u = (User) request.getSession().getAttribute("user");

        Favorite f = new Favorite();
        f.setUser(u);
        f.setListing(listing);

        System.out.println(f.getUser().getUserID());

        favoriteService.create(f);

        return "index";
    }

    @RequestMapping(value = "/unwatch", method = RequestMethod.GET)
    public String unwatch(HttpServletRequest request, @RequestParam("listingID") String id) {
        int listingID = Integer.parseInt(id);
        Listing listing = listingService.getByListingID(listingID);
        User u = (User) request.getSession().getAttribute("user");

        ArrayList<Favorite> list = (ArrayList<Favorite>) favoriteService.findAllFavoritesByUser(u.getUserID());

        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getListing().getId() == listingID) {

                favoriteService.delete(list.get(i).getId());
            }
        }
        return "index";
    }


    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam("listing") int listingID) {

        ModelAndView model = new ModelAndView("/jspf/edit-fixed-listing");

        Listing listing = listingService.getByListingID((listingID));

        model.addObject("listingID", listingID);
        model.addObject("listing", listing);

        return model;
    }

    @GetMapping("/editListing")
    public String editListing(HttpServletRequest request, @RequestParam("id") int id) {
        request.setAttribute("categories", categoryService.getAllCategories());
        request.setAttribute("subCategories", categoryService.getAllSubCategories());
        System.out.println(id);
        request.setAttribute("listing", listingService.getByListingID(id));
        return "editListing";
    }

    @RequestMapping(value = "/sub", method = RequestMethod.GET)
    public ModelAndView viewSubcats() {

        ModelAndView model = new ModelAndView("sub-categories");

        return model;
    }

    @RequestMapping(value = "/subPost", method = RequestMethod.POST)
    public ModelAndView viewSubcategories(@RequestParam("category") String category, HttpServletRequest request) {

        ModelAndView model = new ModelAndView("sub-categories");

        // get listings
        List<Listing> listings = listingService.getAllListingsByCategory(category);

        Listing listing = listings.get(0); // temp

        // get user
        User user = (User) request.getSession().getAttribute("user");

        model.addObject("user", user);
        model.addObject("listings", listings);

        model.addObject("listing", listing); // temp

        return model;
    }

    @RequestMapping(value = "/listing", method = RequestMethod.GET)
    public String viewSelectedListing(HttpServletRequest request, @RequestParam("l") int listingID) {

        Listing listing = listingService.getByListingID(listingID);

        if (listing == null) {
            addErrorMessage("Error Loading Listing");
            setRequest(request);
            return "redirect:/";
        }

        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {

//            boolean hasOffer;
//
//            // Checks if the user already made an offer on the listing
//            if (offerService.getOfferByUserAndListingId(user.getUserID(), listingID) != null) {
//                hasOffer = true;
//            } else {
//                hasOffer = false;
//            }
//
//            model.addObject("hasOffer", hasOffer);

            if (listing.getEnded() == 1) {

                // Check if pick up was started
                PickUp pickUp = pickUpService.getPickUpByListingID(listingID);

                if (pickUp == null || pickUp.getStatus().equals("IN REVIEW") || pickUp.getStatus().equals("AWAITING PICK UP") || pickUp.getStatus().equals("CREATED")) {
                    request.setAttribute("viewPickUp", true);

                } else if (pickUp.getStatus().equals("PICK UP MISSED")) {
                    addWarningMessage("Pick Up Missed");
                    request.setAttribute("viewPickUp", true);

                } else if (pickUp.getStatus().equals("ACCEPTED")) {

                    if (user.getUserID() == pickUp.getTransaction().getBuyer().getUserID() &&
                            pickUp.getTransaction().getTransactionType().equals("buyer_finished") ||
                            pickUp.getTransaction().getTransactionType().equals("fully_finished")) {
                        request.setAttribute("viewPickUpDetails", true);

                    } else if (user.getUserID() == pickUp.getTransaction().getSeller().getUserID() &&
                            pickUp.getTransaction().getTransactionType().equals("seller_finished") ||
                            pickUp.getTransaction().getTransactionType().equals("fully_finished")) {
                        request.setAttribute("viewPickUpDetails", true);

                    } else {
                        request.setAttribute("viewCheckout", true);
                    }

                } else if (pickUp.getStatus().equals("VERIFIED") || pickUp.getStatus().equals("COMPLETED")) {
                    request.setAttribute("viewTransaction", true);

                } else if (pickUp.getStatus().equals("PENDING VERIFICATION")) {

                    // User Logged In Is Seller And Has Not Verified
                    if (pickUp.getTransaction().getSeller().getUserID() == user.getUserID() && pickUp.getSellerVerified() == 0) {
                        request.setAttribute("viewVerification", true);

                        // User Logged In Is Seller And Has Verified
                    } else if (pickUp.getTransaction().getSeller().getUserID() == user.getUserID() && pickUp.getSellerVerified() == 1) {
                        request.setAttribute("viewTransaction", true);

                        // User Logged In Is Buyer And Has Not Verified
                    } else if (pickUp.getTransaction().getBuyer().getUserID() == user.getUserID() && pickUp.getBuyerVerified() == 0) {
                        request.setAttribute("viewVerification", true);

                        // User Logged In Is Buyer And Has Verified
                    } else if (pickUp.getTransaction().getBuyer().getUserID() == user.getUserID() && pickUp.getBuyerVerified() == 1) {
                        request.setAttribute("viewTransaction", true);
                    }
                }
            }
        }

        // Transaction rollback work around
        if (!listing.getType().equals("auction") && listing.getEnded() == 1) {
            List<Transaction> transactions = transactionService.getTransactionsByBuyerID(user.getUserID());
            if (transactions != null && transactions.size() > 0) {
                for (Transaction t : transactions) {
                    if (t.getListingID().getId() == listingID) {
                        request.setAttribute("transaction", t);
                    }
                }
            }
        }

        request.setAttribute("listing", listing);
        request.setAttribute("title", "Listing");

        setRequest(request);
        return "listing/listing";

    }

    @RequestMapping(value = "/cancel-overview", method = RequestMethod.GET)
    public String cancelPurchaseOverview(@RequestParam("l") int listingID, HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Cancel A Purchase");
            request.getSession().setAttribute("lastPage", "/cancel-overview?l=" + listingID);
            setRequest(request);
            return "redirect:/login";
        }

        Listing listing;

        try {
            listing = listingService.getByListingID(listingID);
        } catch (Exception e) {
            addErrorMessage("Error Loading The Listing");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (listing == null) {
            addErrorMessage("Error Loading The Listing");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (user.getUserID() != listing.getUser().getUserID() && user.getUserID() != listing.getHighestBidder().getUserID()) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (listing.getEnded() == 0) {
            addWarningMessage("Listing Must Be Over To Cancel A Purchase");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Transaction transaction = transactionService.getTransactionsByListingID(listingID);

        if (transaction != null && transaction.getTransactionType().equals("cancelled")) {
            addWarningMessage("Listing Was Already Cancelled");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        request.setAttribute("listing", listing);
        return "listing/cancel-purchase-overview";

    }

    @RequestMapping(value = "/cancel-purchase", method = RequestMethod.POST)
    public String cancelPurchase(@RequestParam("l") int listingID, HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To Cancel A Purchase");
            request.getSession().setAttribute("lastPage", "/cancel-overview?l=" + listingID);
            setRequest(request);
            return "redirect:/login";
        }

        Listing listing = listingService.getByListingID(listingID);

        if (listing == null) {
            addErrorMessage("Error Loading The Listing");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Notification notification;

        // send notification to other user
        if (user.getUserID() == listing.getHighestBidder().getUserID()) {
            // notify the seller
            notification = new Notification(listing.getUser(), listingID, "Purchase Cancelled",
                    "The buyer for your listing: " + listing.getName() + " has cancelled the purchase.\n\nAs a result, " +
                            "if they already payed via PayPal, they received a full refund.\n\nSorry :(", 1);

        } else if (user.getUserID() == listing.getUser().getUserID()) {
            // notify the buyer
            notification = new Notification(listing.getHighestBidder(), listingID, "Purchase Cancelled",
                    "The seller for the listing: " + listing.getName() + " has cancelled the purchase.\n\nAs a result, " +
                            "if you already payed via PayPal, you will receive a full refund.\n\nSorry :(", 1);

            // unauthorized user
        } else {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (listing.getEnded() == 0) {
            addWarningMessage("Listing Must Be Over To Cancel A Purchase");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        // Cancel Transaction
        Transaction transaction = transactionService.getTransactionsByListingID(listingID);

        if (transaction == null) {
            addErrorMessage("Error Loading The Transaction: Try Again Later");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (transaction.getTransactionType().equals("cancelled")) {
            addWarningMessage("Listing Was Already Cancelled");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        transaction.setTransactionType("cancelled");
        transaction.setCompleted(1);
        transactionService.saveOrUpdate(transaction);

        // Return money

        // Cancel Pick Up
        PickUp pickUp = pickUpService.getPickUpByListingID(listingID);

        if (pickUp == null) {
            addErrorMessage("Error Loading The Pick Up: Try Again Later");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        pickUp.setStatus("CANCELLED");
        pickUp.setActive(0);
        pickUpService.update(pickUp);

        // LEAVE THIS LINE ALONE
        PickUpRunner.run();

        notificationService.save(notification);

        addSuccessMessage("Purchase Cancelled");
        return "redirect:" + request.getHeader("Referer");

    }

    @RequestMapping(value = "/cancelAuction", method = RequestMethod.GET)
    public ModelAndView cancelAuction(@RequestParam("listing") int listingID) {

        ModelAndView model = new ModelAndView("dashboard2");

        Listing listing = listingService.getByListingID(listingID);

        // if bidcount is above 0, reject auction cancel with an error message
        if (listing.getBidCount() > 0) {
            // error message
            addErrorMessage("You may not cancel an auction that has already been bid on.");
        } else {
            // popup, are you sure you want to cancel?

            // if bidcount is 0, ask if seller is sure they want to cancel the auction

            // no? - cancel popup

            // yes?

            // deactivate the listing
            listing.setActive(0);
            listing.setEnded(1);
            listingService.saveOrUpdate(listing);

            // LEAVE THIS LINE ALONE
            ListingRunner.run();

        }
        return model;
    }

    @RequestMapping(value = "/auctionRules", method = RequestMethod.GET)
    public ModelAndView auction() {

        ModelAndView model = new ModelAndView("auction-rules");

        return model;
    }

    @RequestMapping(value = "/rules", method = RequestMethod.GET)
    public ModelAndView rules() {

        ModelAndView model = new ModelAndView("rules");

        return model;
    }

//    @GetMapping("/reportListing")
//    public String reportListing(@RequestParam("listingId") int id, HttpServletRequest request) {
//        System.out.println(id);
//        Listing listing = listingService.getByListingID(id);
//        request.setAttribute("listing", listing);
//        return "reportListing";
//    }

    @GetMapping("/reportListing")
    public String reportListing(@RequestParam("listingId") int id, HttpServletRequest request) {
        User u = (User) request.getSession().getAttribute("user");
        Listing l = listingService.getByListingID(id);

        if (u == null) {
            addErrorMessage("Login To Report A Listing");
            setRequest(request);
            return "login";
        }

        if (u.getUserID() == l.getUser().getUserID()) {
            addErrorMessage("You cannot report your own listing!");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }


        System.out.println(id);
        Listing listing = listingService.getByListingID(id);
        request.setAttribute("listing", listing);
        return "reportListing";
    }

    @RequestMapping(value = "/getListingData", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String getListingData(HttpServletRequest request, @RequestParam("listingID") int listingID) {

        JsonObject json = new JsonObject();

        Listing listing = listingService.getByListingID(listingID);

        if (listing != null) {

            json.addProperty("id", listing.getId());
            json.addProperty("name", listing.getName());
            json.addProperty("description", listing.getDescription());
            json.addProperty("price", listing.getPrice());
            json.addProperty("paymentType", listing.getPaymentType());
            json.addProperty("userID", listing.getUser().getUserID());
            json.addProperty("type", listing.getType());
            json.addProperty("category", listing.getCategory());
            json.addProperty("subCategory", listing.getSubCategory());
            json.addProperty("dateCreated", listing.getDateCreated().toString());

            if (listing.getHighestBidder() == null) {
                json.addProperty("highestBidderID", "null");
                json.addProperty("highestBidderUsername", "null");
            } else {
                json.addProperty("highestBidderID", listing.getHighestBidder().getUserID());
                json.addProperty("highestBidderUsername", listing.getHighestBidder().getUsername());
            }

            json.addProperty("highestBid", listing.getHighestBid());
            json.addProperty("endTimestamp", listing.getEndTimestamp().toString());
            json.addProperty("endTimestampInMilli", listing.getEndTimestampAsLong());
            json.addProperty("bidCount", listing.getBidCount());
            json.addProperty("active", listing.getActive());
            json.addProperty("ended", listing.getEnded());
            json.addProperty("startTimestamp", listing.getStartTimestamp().toString());
            json.addProperty("startTimestampInMilli", listing.getStartTimestampAsLong());

        } else {
            json.addProperty("listing", "null");
        }

        return json.toString();
    }

    @RequestMapping(value = "/relistListing", method = RequestMethod.POST)
    public String uploadFileHandler(@RequestParam("endTime") String endTime,
                                    @RequestParam("endDate") String endDate,
                                    @RequestParam("listingId") int listingId,
                                    HttpServletRequest request) {
        User u = (User) request.getSession().getAttribute("user");
        Listing l = listingService.getByListingID(listingId);
        Timestamp endTimestamp;

        // Get year, month, day, hour, and minutes from endDate and endTime
        int year = Integer.parseInt(endDate.substring(0, 4));
        // Timestamp adds an extra month
        int mon = Integer.parseInt(endDate.substring(5, 7)) - 1;
        int day = Integer.parseInt(endDate.substring(8, 10));
        int hours = Integer.parseInt(endTime.substring(0, 2));
        int min = Integer.parseInt(endTime.substring(3, 5));

        Calendar calendar = Calendar.getInstance();
        calendar.set(year, mon, day, hours, min, 0);
        endTimestamp = new Timestamp((calendar.getTimeInMillis()));

        l.setEndTimestamp(endTimestamp);
        l.setActive(1);
        l.setStartTimestamp(null);

        listingService.saveOrUpdate(l);
        return "redirect:/dashboard";
    }

    @GetMapping("buy")
    public String buyItNow(HttpServletRequest request, @RequestParam("l") int listingID) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addErrorMessage("Login To Buy A Listing");
            setRequest(request);
            return "redirect:/login";
        }

        Listing listing = listingService.getByListingID(listingID);

        // Listing doesn't exist
        if (listing == null) {
            addErrorMessage("Error Loading Listing");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        // Listing ended already
        if (listing.getEnded() == 1) {
            addErrorMessage("This listing was already purchased, sorry.");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        // User tries to buy own listing
        if (listing.getUser().getUserID() == user.getUserID()) {
            addErrorMessage("You Can't Buy Your Own Listing");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        // Listing is not fixed
        if (!listing.getType().equals("fixed")) {
            addErrorMessage("You Can Only Buy Fixed Priced Listings");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        List<Notification> newNotifications = new ArrayList<Notification>(10);

        // Notify seller
        newNotifications.add(new Notification(listing.getUser(), listingID, "Sold", user.getUsername() +
                " has bought you listing " + listing.getName() + " for $" + listing.getPrice()
                + ". Checkout the listing page to set up a pickup date and time.", 1, "SOLD"));

        // Notify users who made offers and cancels all offers on listing
        List<Offer> offersMade = offerService.getActiveOffersByListingId(listingID);
        if (offersMade != null && offersMade.size() > 0) {
            for (Offer o : offersMade) {
                if (o.getOfferMaker().getUserID() != user.getUserID()) {
                    // Notify user who made offer
                    newNotifications.add(new Notification(o.getOfferMaker(), listingID, "Listing Sold",
                            "The listing " + listing.getName() + " has sold to another user. Better luck next time!", 1, "LOST"));
                    o.setStatus("rejected");

                } else {
                    o.setStatus("cancelled");
                }

                // Update offer status
                offerService.saveOrUpdate(o);
            }
        }

        // Mark as ended
        listing.setEnded(1);
        listingService.saveOrUpdate(listing);

        // Start transaction
        Transaction transaction = new Transaction(listing, 0);
        transaction.setSeller(listing.getUser());
        transaction.setBuyer(user);
        transaction.setTransactionType("pending");
        transactionService.createTransaction(transaction);

        // Redirect to listing page
        addSuccessMessage(listing.getName() + " is yours!");
        setRequest(request);
        return "redirect:/listing?l=" + listingID;


    }

}