package edu.ben.controller;

import com.google.api.client.json.Json;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import edu.ben.model.*;
import edu.ben.service.*;
import edu.ben.util.Email;
import edu.ben.util.ListingRunner;
import edu.ben.util.PickUpRunner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

@Controller
public class AdminController extends BaseController {

    @Autowired
    UserService userService;

    @Autowired
    ListingService listingService;

    @Autowired
    DisputeService disputeService;

    @Autowired
    NotificationService notificationService;

    @Autowired
    LocationService locationService;

    @Autowired
    ChecklistService checklistService;

    @Autowired
    Environment environment;

    @Autowired
    TaskService taskService;

    @Autowired
    AdminTaskService adminTaskService;

    @Autowired
    FaqService faqService;

    @Autowired
    NewsService newsService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    RevenueService revenueService;

    @Autowired
    SalesTrafficService trafficService;

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        ListingRunner.run();

        PickUpRunner.run();

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/admin");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        trafficService.create(new SalesTraffic("Admin_Page", user.getUserID()));


        ArrayList<Integer> salesPerHour = new ArrayList<>();
        ArrayList<Integer> salesPerHourLastWeek = new ArrayList<>();
        ArrayList<Integer> salesOfTheWeek = new ArrayList<>();
        ArrayList<Integer> lastWeekSalesOfWeek = new ArrayList<>();
        ArrayList<Integer> salesPerMonth = new ArrayList<>();
        ArrayList<Integer> lastSalesPerMonth = new ArrayList<>();
        ArrayList<Integer> yearlySale = new ArrayList<>();

        ArrayList<Integer> dailyCount = new ArrayList<>();
        ArrayList<Integer> weeklyCount = new ArrayList<>();
        ArrayList<Integer> monthlyCount = new ArrayList<>();
        ArrayList<Integer> yearlyCount = new ArrayList<>();

        String[] pages = {"Community_Page", "Home_Page", "Landing_Page", "Create_Listing", "Search_Page", "Donation_Page"};

        Calendar day = Calendar.getInstance();
        Calendar month = Calendar.getInstance();
        Calendar lastMonth = Calendar.getInstance();
        Calendar week = Calendar.getInstance();
        Calendar lastWeek = Calendar.getInstance();
        Calendar lastWeekHours = Calendar.getInstance();

        Calendar year = Calendar.getInstance();

        Calendar trafficDay = Calendar.getInstance();
        Calendar trafficFirstDayWeek = Calendar.getInstance();
        Calendar trafficLastDayWeek = Calendar.getInstance();
        Calendar trafficMonth = Calendar.getInstance();


        // Set the calendar to Sunday of the current week
        week.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
        DateFormat df = new SimpleDateFormat("yyyy/MM/dd");

        // get daily sales per hour
        for (int i = 0; i < 24; i++) {

            String currentMonth = getMonth2(day.get(Calendar.MONTH));
            String currentYear = new SimpleDateFormat("YYYY").format(year.getTime());
            String currentDay = new SimpleDateFormat("dd").format(day.getTime());

            // on the first itteration, set the date to last week
            if (i == 0) {
                lastWeekHours.add(Calendar.DATE, -7);
            }

            String lastWeekByHour = new SimpleDateFormat("dd").format(lastWeekHours.getTime());


            String lastWeekDate = currentYear + "-" + currentMonth + "-" + lastWeekByHour;
            String date = currentYear + "-" + currentMonth + "-" + currentDay;

            long temp = revenueService.getDailyRevenue(i, date);
            long temp2 = revenueService.getDailyRevenue(i, lastWeekDate);


            Integer hourlySale = (int) (long) temp;
            Integer lastWeekHourlySales = (int) (long) temp2;

            salesPerHour.add(hourlySale);
            salesPerHourLastWeek.add(lastWeekHourlySales);

        }

        // get the daily sale per week
        for (int i = 0; i < 7; i++) {

            if (i == 0) {
                lastWeek.set(Calendar.DAY_OF_WEEK, week.getFirstDayOfWeek());
                lastWeek.add(Calendar.DATE, -7);
                week.set(Calendar.DAY_OF_WEEK, week.getFirstDayOfWeek());
            } else {
                lastWeek.add(Calendar.DATE, 1);
                week.add(Calendar.DATE, 1);
            }

            String currentMonth = getMonth2(week.get(Calendar.MONTH));
            String currentYear = new SimpleDateFormat("YYYY").format(year.getTime());
            String firstDayString = new SimpleDateFormat("dd").format(week.getTime());
            String lastFirstDay = new SimpleDateFormat("dd").format(lastWeek.getTime());

            String currentWeek = currentYear + "-" + currentMonth + "-" + firstDayString;
            String lastWeekDate = currentYear + "-" + currentMonth + "-" + lastFirstDay;

            long temp = revenueService.getWeeklyRevenue(currentWeek);
            long temp2 = revenueService.getWeeklyRevenue(lastWeekDate);


            Integer dailySale = (int) (long) temp;
            Integer lastWeekDailySale = (int) (long) temp2;

            salesOfTheWeek.add(dailySale);
            lastWeekSalesOfWeek.add(lastWeekDailySale);

        }

        for (int i = 1; i <= 12; i++) {

            if (i == 1) {
                lastMonth.add(Calendar.YEAR, -1);
            }

            String currentMonth = getMonth(i);

            String currentYear = new SimpleDateFormat("YYYY").format(year.getTime());
            String lastYear = new SimpleDateFormat("YYYY").format(lastMonth.getTime());

            String input = currentYear + "-" + currentMonth;
            String lastYearInput = lastYear + "-" + currentMonth;


            long monthlyRevenue = revenueService.getMonthlyRevenue(input);
            long lastYearMonthlyRevenue = revenueService.getMonthlyRevenue(lastYearInput);

            Integer monthlySale = (int) (long) monthlyRevenue;
            Integer lastYearMonthlySale = (int) (long) lastYearMonthlyRevenue;

            lastSalesPerMonth.add(lastYearMonthlySale);
            salesPerMonth.add(monthlySale);

        }

        for (int i = 0; i < 2; i++) {

            if (i == 0) {
                year.add(Calendar.YEAR, -1);
            } else {
                year.add(Calendar.YEAR, 1);
            }

            String currentYear = new SimpleDateFormat("YYYY").format(year.getTime());

            long temp = revenueService.getYearlyRevenue(currentYear);

            Integer yearSale = (int) (long) temp;

            System.out.println("year: " + currentYear);

            yearlySale.add(yearSale);
        }

        String currentDay = new SimpleDateFormat("dd").format(trafficDay.getTime());

        trafficFirstDayWeek.set(Calendar.DAY_OF_WEEK, week.getFirstDayOfWeek());
        trafficLastDayWeek.set(Calendar.DAY_OF_WEEK, week.getFirstDayOfWeek());
        trafficLastDayWeek.add(Calendar.DATE, 6);

        String beginningOfWeek = new SimpleDateFormat("dd").format(trafficFirstDayWeek.getTime());
        String endOfWeek = new SimpleDateFormat("dd").format(trafficLastDayWeek.getTime());
        String currentMonth = getMonth2(trafficMonth.get(Calendar.MONTH));
        String currentYear = new SimpleDateFormat("YYYY").format(year.getTime());


        for (int i = 0; i < pages.length; i++) {

            String currentDayFormat = currentYear + "-" + currentMonth + "-" + currentDay;
            String beginningOfWeekFormat = currentYear + "-" + currentMonth + "-" + beginningOfWeek;
            String endOfWeekFormat = currentYear + "-" + currentMonth + "-" + endOfWeek;
            String monthFormat = currentYear + "-" + currentMonth;

            long trafficDayCount = trafficService.getCountByPageByDay(pages[i], currentDayFormat);
            long trafficWeekCount = trafficService.getCountByPageByWeek(pages[i], beginningOfWeekFormat, endOfWeekFormat);
            long trafficMonthCount = trafficService.getCountByPageByMonth(pages[i], monthFormat);
            long trafficYearCount = trafficService.getCountByPageByYear(pages[i], currentYear);

            Integer dayCount = (int) (long) trafficDayCount;
            dailyCount.add(dayCount);
            Integer weekCount = (int) (long) trafficWeekCount;
            weeklyCount.add(weekCount);
            Integer monthCount = (int) (long) trafficMonthCount;
            monthlyCount.add(monthCount);
            Integer yearCount = (int) (long) trafficYearCount;
            yearlyCount.add(yearCount);

        }

        request.setAttribute("salesPerHour", salesPerHour);
        request.setAttribute("salesPerWeek", salesOfTheWeek);
        request.setAttribute("salesPerMonth", salesPerMonth);
        request.setAttribute("lastWeekSalesPerWeek", lastWeekSalesOfWeek);
        request.setAttribute("lastWeekSalesPerHour", salesPerHourLastWeek);
        request.setAttribute("lastMonthlySales", lastSalesPerMonth);
        request.setAttribute("yearlySale", yearlySale);

        request.setAttribute("dailyCount", dailyCount);
        request.setAttribute("weeklyCount", weeklyCount);
        request.setAttribute("monthlyCount", monthlyCount);
        request.setAttribute("yearlyCount", yearlyCount);


        List<User> recentUsers = userService.getAllUsers();
        List<User> getAllMembers = userService.getAllUsers();
        List<String> memberDateCreated = new ArrayList<>();

        for (int i = 0; i < getAllMembers.size(); i++) {
            Calendar cal = Calendar.getInstance();

            Timestamp t = (Timestamp) getAllMembers.get(i).getDateCreated();

            Date date = new Date(t.getTime());

            cal.setTime(date);

            String userMonth = getMonth2(cal.get(Calendar.MONTH));
            String userYear = new SimpleDateFormat("YYYY").format(cal.getTime());
            String userDay = new SimpleDateFormat("dd").format(cal.getTime());

            String currentUserDate = currentMonth + " " + userDay + ", " + userYear;

            memberDateCreated.add(currentUserDate);

            System.out.println("User created on: " + currentUserDate);
        }
        System.out.println("All Members: " + getAllMembers.size());
        List<Listing> recentListings = listingService.getRecentListings();
        ArrayList<User> admins = (ArrayList<User>) userService.getAllAdmins();
        ArrayList<String> status = new ArrayList<>();
        ArrayList<Task> tasks = (ArrayList<Task>) taskService.getAllTasks();


        for (int i = 0; i < admins.size(); i++) {
            System.out.println("Name: " + admins.get(i).getFirstName() + " Admin Lvel: " + admins.get(i).getAdminLevel() );
            if (admins.get(i).getAdminLevel() == 0) {
                status.add("Customer");
            } else if (admins.get(i).getAdminLevel() == 10) {
                status.add("Low-Level Admin");
            } else if (admins.get(i).getAdminLevel() == 20) {
                status.add("Mid-Level Admin");
            } else {
                status.add("High-Level Admin");
            }
        }
        request.getSession().setAttribute("recentUsers", recentUsers);
        request.getSession().setAttribute("recentListings", recentListings);
        request.getSession().setAttribute("members", getAllMembers);
        request.getSession().setAttribute("admins", admins);
        request.getSession().setAttribute("status", status);
        request.getSession().setAttribute("tasks", tasks);
        request.setAttribute("userDate", memberDateCreated);

        System.out.println("Member Size: " + getAllMembers.size());

        ArrayList<User> activeUsers = (ArrayList<User>) userService.getActiveUsers();
        request.setAttribute("activeUsers", activeUsers);

        ArrayList<Listing> activeListings = (ArrayList<Listing>) listingService.getActiveListings();
        System.out.println("Active Listings: " + activeListings.size());
        request.setAttribute("activeListings", activeListings);

        Calendar c = Calendar.getInstance();

        String d = new SimpleDateFormat("dd").format(c.getTime());
        String m = getMonth2(c.get(Calendar.MONTH));
        String y = new SimpleDateFormat("YYYY").format(c.getTime());

        String dFormat = y+"-"+ m + "-" + d;
        System.out.println(dFormat);

        long dailyRevenue = revenueService.getWeeklyRevenue(dFormat);

        Integer dRev = (int) (long) dailyRevenue;
        System.out.println("Daily Revenue: " + dRev);

        request.setAttribute("dailyRevenue", dRev);


        return "admin/adminPage";
    }

    @RequestMapping(value = "adminUser", method = RequestMethod.GET)
    public String adminUser(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminUser");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        List<User> allUsers = userService.getAllUsers();
        request.getSession().setAttribute("allUsers", allUsers);
        return "admin/adminUserPage";
    }

    @RequestMapping(value = "adminUnlock", method = RequestMethod.POST)
    public String adminUnlock(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminUser");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        User usr = userService.findBySchoolEmail(request.getParameter("lock"));
        userService.unlockByUsername(usr.getUsername());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminLock", method = RequestMethod.POST)
    public String adminLock(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminUser");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        User usr = userService.findBySchoolEmail(request.getParameter("unlock"));
        userService.lockByUsername(usr.getUsername());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminUnban", method = RequestMethod.POST)
    public String adminUnban(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminUser");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        User usr = userService.findBySchoolEmail(request.getParameter("ban"));
        userService.unbanByUsername(usr.getUsername());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminBan", method = RequestMethod.POST)
    public String adminBan(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminUser");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        User usr = userService.findBySchoolEmail(request.getParameter("unban"));
        userService.banByUsername(usr.getUsername());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminInactivateListing", method = RequestMethod.POST)
    public String adminInactivateListing(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminListing");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Listing listing = listingService.getByListingID(Integer.parseInt(request.getParameter("adminInactivateListing")));
        listingService.deleteByListingId(listing.getId());
        return "redirect:adminListing";
    }

    @RequestMapping(value = "adminActivateListing", method = RequestMethod.POST)
    public String adminActivateListing(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminListing");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Listing listing = listingService.getByListingID(Integer.parseInt(request.getParameter("adminActivateListing")));
        listingService.activateByListingId(listing.getId());
        return "redirect:adminListing";
    }

    @RequestMapping(value = "adminPasswordReset", method = RequestMethod.POST)
    public String adminPasswordReset(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminUser");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        System.out.println(request.getParameter("email"));
        User usr = userService.findBySchoolEmail(request.getParameter("email"));
        Email.resetPassword(usr.getSchoolEmail());
        userService.lockByUsername(usr.getUsername());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminDeleteUser", method = RequestMethod.POST)
    public String adminDelete(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminUser");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        User usr = userService.findBySchoolEmail(request.getParameter("delete"));
        userService.deleteUser(usr.getUserID());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminDeleteListing", method = RequestMethod.POST)
    public String adminDeleteListing(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminListing");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Listing listing = listingService.getByListingID(Integer.parseInt(request.getParameter("adminDeleteListing")));
        listingService.deleteListing(listing.getId());
        return "redirect:adminListing";
    }

    @RequestMapping(value = "adminCreateUser", method = RequestMethod.POST)
    public String adminCreateUser(HttpServletRequest request) {

        User u = (User) request.getSession().getAttribute("user");

        if (u == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminUser");
            return "redirect:/login";
        }

        if (u.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        User user = new User();
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setUsername(request.getParameter("username"));
        user.setEmail(request.getParameter("personalEmail"));
        user.setSchoolEmail(request.getParameter("benedictineEmail"));
        user.setPassword(request.getParameter("password"));
        if (request.getParameter("accountType") == "Admin") {
            user.setAdmin(1);
        } else {
            user.setAdmin(0);
        }
        userService.saveOrUpdate(user);
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminEditUser", method = RequestMethod.POST)
    public String adminEditUser(HttpServletRequest request) {
        User usr = userService.findBySchoolEmail(request.getParameter("schoolEmailEdit"));
        String firstName = request.getParameter("firstNameEdit");
        String lastName = request.getParameter("lastNameEdit");
        String username = request.getParameter("usernameEdit");
        String phoneNumber = request.getParameter("phoneNumberEdit");
        String email = request.getParameter("personalEmailEdit");
        String schoolEmail = request.getParameter("schoolEmailEdit");
        String password = request.getParameter("passwordEdit");

        Pattern pattern = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$",
                Pattern.CASE_INSENSITIVE);
        if (firstName.length() < 2 || firstName.length() > 30 || firstName.matches("[A-Za-z]")) {
            addErrorMessage("Incorrect value for first name");
        } else if (lastName.length() < 2 || lastName.length() > 30 || lastName.matches("[A-Za-z]")) {
            addErrorMessage("Incorrect value for first name");
        } else if (username.length() > 8) {
            addErrorMessage("Incorrect value for username");
        } else if (phoneNumber.length() != 10) {
            addErrorMessage("Incorrect value for phone number");
        } else if ((pattern.matcher(email).matches())) {
            addErrorMessage("Incorrect value for email");
        } else if ((pattern.matcher(schoolEmail).matches())) {
            addErrorMessage("Incorrect value for school email");
        } else if (password.length() > 8) {
            addErrorMessage("Incorrect value for password");
        } else {
            usr.setFirstName(firstName);
            usr.setLastName(lastName);
            usr.setUsername(username);
            usr.setEmail(email);
            usr.setSchoolEmail(schoolEmail);
            usr.setPassword(password);
            userService.saveOrUpdate(usr);
        }
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminListing", method = RequestMethod.GET)
    public String adminListing(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminListing");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        List<Listing> allListings = listingService.getRecentListings();
        request.getSession().setAttribute("allListings", allListings);
        return "admin/adminListings";

    }

    @GetMapping("/adminDisputes")
    public String disputes(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminDisputes");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        request.setAttribute("title", "Disputes");
        request.setAttribute("disputes", disputeService.getAllActive());
        return "admin/admin-disputes";
    }

    @GetMapping("/adminLocations")
    public String locations(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminLocations");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        request.setAttribute("lat", environment.getProperty("school.latitude"));
        request.setAttribute("lng", environment.getProperty("school.longitude"));

        request.setAttribute("title", "Locations");

        List<Location> locations = locationService.getAllLocations();
        request.setAttribute("locations", locations);
        request.setAttribute("locationCount", locations.size());

        request.setAttribute("safeZones", locationService.getAllSafeZones());
        return "admin/admin-locations";
    }

    @PostMapping("/createSafeZone")
    public String createSafeZone(HttpServletRequest request, @RequestParam("name") String name,
                                 @RequestParam("position") String position) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminLocations");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Location newLocation = new Location();
        newLocation.setName(name);
        newLocation.setSafeZone(1);
        newLocation.setActive(1);

        int commaIndex = position.indexOf(',');

        newLocation.setLatitude(Float.parseFloat(position.substring(1, commaIndex)));
        newLocation.setLongitude(Float.parseFloat(position.substring(commaIndex + 2, (position.length() - 1))));

        locationService.save(newLocation);

        addSuccessMessage("Safe Zone Created");
        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }

    @PostMapping("/editSafeZone")
    public String editSafeZone(HttpServletRequest request, @RequestParam("locationID") int locationID,
                               @RequestParam("newName") String newName,
                               @RequestParam("newLat") float newLat, @RequestParam("newLng") float newLng) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminLocations");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Location location = locationService.getByLocationID(locationID);

        if (!newName.equals("")) {
            location.setName(newName);
        }

        location.setLatitude(newLat);
        location.setLongitude(newLng);

        locationService.update(location);

        addSuccessMessage("Safe Zone Updated");
        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }

    @PostMapping("/deleteSafeZone")
    public String editSafeZone(HttpServletRequest request, @RequestParam("locationID") int locationID) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminLocations");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }


        Location location = locationService.getByLocationID(locationID);
        location.setActive(0);
        locationService.update(location);

        addSuccessMessage("Safe Zone Updated");
        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }

    @GetMapping("/adminFaqs")
    public String faqs(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminFaqs");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        request.setAttribute("title", "Manage Faqs");
        request.setAttribute("faqs", faqService.getAllFaqs());
        return "admin/admin-faqs";
    }

    @PostMapping("/adminAddFaq")
    public String addFaq(HttpServletRequest request, @RequestParam("newFaqQuestion") String question,
                         @RequestParam("newFaqAnswer") String answer, @RequestParam("newFaqCategory") String category) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminFaqs");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        // Error checking for question
        if (question.length() < 5 && !question.contains("?")) {
            addErrorMessage("Invalid Question");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        // Error checking for answer
        if (answer.length() < 5) {
            addErrorMessage("Invalid Answer");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        faqService.save(new Faq(question, answer, user, category));

        addSuccessMessage("Faq Created!");
        setRequest(request);

        return "redirect:" + request.getHeader("Referer");
    }

    @PostMapping("/adminEditFaq")
    public String editFaq(HttpServletRequest request, @RequestParam("newFaqQuestion") String question,
                          @RequestParam("newFaqAnswer") String answer, @RequestParam("newFaqCategory") String category, @RequestParam("faqID") int faqID) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null && user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "login";
        }

        Faq faq = faqService.getByFaqID(faqID);

        if (faq == null) {
            addErrorMessage("Error Loading Faq");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (question.length() < 5) {
            addErrorMessage("Invalid Faq Question");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (answer.length() < 5) {
            addErrorMessage("Invalid Faq Answer");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        if (!faq.getQuestion().equals(question)) {
            faq.setQuestion(question);
        }

        if (!faq.getAnswer().equals(answer)) {
            faq.setAnswer(answer);
        }

        if (!faq.getCategory().equals(category)) {
            faq.setCategory(category);
        }

        faqService.update(faq);

        addSuccessMessage("Faq Updated!");
        setRequest(request);

        return "redirect:" + request.getHeader("Referer");
    }

    @PostMapping("/adminRemoveFaq")
    public String removeFaq(HttpServletRequest request, @RequestParam("faqID") int faqID) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null && user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "login";
        }

        Faq faq = faqService.getByFaqID(faqID);

        if (faq == null) {
            addErrorMessage("Error Loading Faq");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        faqService.remove(faq);

        addSuccessMessage("Faq Removed");
        setRequest(request);
        return "redirect:" + request.getHeader("Referer");

    }

    @PostMapping("/contactUser")
    public String contactUser(HttpServletRequest request, @RequestParam("receivingUser") String receivingUser, @RequestParam("disputeID") int disputeID, @RequestParam("subject") String subject, @RequestParam("message") String message) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null && user.getAdminLevel() < 1) {
            addWarningMessage("Login");
            setRequest(request);
            return "login";
        }

        Dispute dispute = disputeService.getByID(disputeID);
        if (dispute == null) {
            addErrorMessage("Invalid Dispute ID");
            setRequest(request);
            return "admin/admin-disputes";
        }

        if (receivingUser.equals("accuser")) {

            notificationService.save(new Notification(dispute.getAccuser(), dispute.getListing().getId(), "Dispute Follow Up", "A email has been sent to your school account from an administrator following up on a dispute you have filed.", 1));

            if (subject.equals("")) {
                Email.sendEmail(message, "Dispute (" + disputeID + ") Follow Up", dispute.getAccuser().getSchoolEmail());
            } else {
                Email.sendEmail(message, subject, dispute.getAccuser().getSchoolEmail());
            }

        } else {

            notificationService.save(new Notification(dispute.getDefender(), dispute.getListing().getId(), "Dispute Follow Up", "A email has been sent to your school account from an administrator following up on a dispute filed against you.", 1));

            if (subject == null) {
                Email.sendEmail(message, "Dispute (" + disputeID + ") Follow Up", dispute.getDefender().getSchoolEmail());
            } else {
                Email.sendEmail(message, subject, dispute.getDefender().getSchoolEmail());
            }

        }

        addSuccessMessage("Follow Up Email Sent");
        setRequest(request);
        return "redirect:/adminDisputes";

    }

    @PostMapping("/editDispute")
    public String editDispute(HttpServletRequest request, @RequestParam("disputeID") int disputeID, @RequestParam("newComplaint") String newComplaint, @RequestParam("newStatus") String newStatus) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null && user.getAdminLevel() < 1) {
            addWarningMessage("Login");
            setRequest(request);
            return "login";
        }

        Dispute dispute = disputeService.getByID(disputeID);
        if (dispute == null) {
            addErrorMessage("Invalid Dispute ID");
            setRequest(request);
            return "admin/admin-disputes";
        }

        dispute.setComplaint(newComplaint);
        dispute.setStatus(newStatus);

        disputeService.update(dispute);

        addSuccessMessage("Follow Up Email Sent");
        setRequest(request);
        return "redirect:/adminDisputes";
    }

    @GetMapping("/adminChecklist")
    public String checklist(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null && user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "login";
        }

        request.setAttribute("title", "Checklist");
        request.setAttribute("defaultChecklist", checklistService.getAdminChecklist());
        return "admin/admin-checklist";

    }

    @PostMapping("/adminAddChecklistItem")
    public String addChecklistItem(HttpServletRequest request, @RequestParam("newItemName") String newItemName) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null && user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "login";
        }

        // Get admin checklist
        Checklist checklist = checklistService.getAdminChecklist();

        if (checklist == null) {
            addErrorMessage("Error Loading Checklist");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        ChecklistItem newItem = new ChecklistItem(checklist, newItemName);

        // Check if new item already exits
        for (ChecklistItem item : checklist.getItems()) {
            if (item.getName().equals(newItemName)) {
                addWarningMessage(newItemName + " Already Exists");
                setRequest(request);
                return "redirect:" + request.getHeader("Referer");
            }
        }

        checklistService.save(newItem);
        addSuccessMessage(newItemName + " Added To Default Checklist");
        setRequest(request);

        return "redirect:" + request.getHeader("Referer");

    }

    @PostMapping("/adminRemoveChecklistItem")
    public String addChecklistItem(HttpServletRequest request, @RequestParam("itemID") int itemID) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null && user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "login";
        }

        // Get admin checklist
        Checklist checklist = checklistService.getAdminChecklist();

        if (checklist == null) {
            addErrorMessage("Error Loading Checklist");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        ChecklistItem item = null;

        // Check if item exits
        for (ChecklistItem i : checklist.getItems()) {
            if (i.getItemID() == itemID) {
                item = i;
            }
        }

        if (item == null) {
            addErrorMessage("Removal Error: Item Does Not Exist");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        checklistService.delete(item);

        addSuccessMessage(item.getName() + " Removed From Default Checklist");
        setRequest(request);

        return "redirect:" + request.getHeader("Referer");

    }

    @RequestMapping(value = "taskManager", method = RequestMethod.GET)
    public String taskPage(HttpServletRequest request) {
        User u = (User) request.getSession().getAttribute("user");
        ArrayList<User> admins = (ArrayList<User>) userService.getAllAdmins();
        ArrayList<Task> tasks = (ArrayList<Task>) taskService.getAllTasks();

        ArrayList<AdminTask> adminTasks = (ArrayList<AdminTask>) adminTaskService.getAllAdminTasks();
        ArrayList<Task> getAllYourTasks = new ArrayList<>();

        for (int i = 0; i < adminTasks.size(); i++) {
            if(adminTasks.get(i).getUser().getUserID() == u.getUserID()) {
                Task t = taskService.getAllTasksByTaskID(adminTasks.get(i).getTask().getTaskID());
                getAllYourTasks.add(t);
                System.out.println("Priority: " + t.getPriority());
            }
        }
        System.out.println("All your tasks: " + getAllYourTasks.size());



        System.out.println("Task size: " + tasks.size());
        System.out.println("admins: " + admins.size());


        request.setAttribute("admins", admins);
        request.setAttribute("tasks", tasks);
        request.setAttribute("yourTasks", getAllYourTasks);
        request.setAttribute("adminTasks", adminTasks);

        return "task-manager";
    }

    @RequestMapping(value = "createTask", method = RequestMethod.POST)
    public String createTask(HttpServletRequest request, @RequestParam("name") String name, @RequestParam("description") String description, @RequestParam("admin") String[] admin, @RequestParam("priority") String priority) {
       if (admin.length == 0) {
           addErrorMessage("Must Select an Admin");
           setRequest(request);

           return "task-manager";
       }

        Task t = new Task(name, description, 0, priority);

        taskService.create(t);


        for (int i = 0; i < admin.length; i++) {
            User user = userService.findBySchoolEmail(admin[i]);
            System.out.println("userID: " + user.getUserID());

            AdminTask task = new AdminTask();

            task.setUser(user);
            task.setTask(t);

            System.out.println("User: " + task.getUser().getUserID());
            System.out.println("Task: " + task.getTaskID());

            adminTaskService.create(task);

        }

        ArrayList<User> admins = (ArrayList<User>) userService.getAllAdmins();
        ArrayList<Task> tasks = (ArrayList<Task>) taskService.getAllTasks();

        ArrayList<AdminTask> adminTasks = (ArrayList<AdminTask>) adminTaskService.getAllAdminTasks();

        request.setAttribute("admins", admins);
        request.setAttribute("tasks", tasks);
        request.setAttribute("adminTasks", adminTasks);

        return "task-manager";
    }

    @RequestMapping(value = "taskCompleted", method = RequestMethod.GET)
    public String createTask(HttpServletRequest request, @RequestParam("taskID") int taskID) {
        Task t = (Task) taskService.getAllTasksByTaskID(taskID);


        if (t.getStatus() == 0) {
            t.setStatus(1);
            taskService.saveOrUpdate(t);
            return "redirect:" + request.getHeader("Referer");
        } else {
            t.setStatus(0);
            taskService.saveOrUpdate(t);
            return "redirect:" + request.getHeader("Referer");
        }
    }

    @GetMapping("/adminDonations")
    public String donations(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminDonations");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        request.setAttribute("categories", categoryService.getAllCategories());
        request.setAttribute("subCategories", categoryService.getAllSubCategories());

        request.setAttribute("title", "Manage Donations");
        request.setAttribute("donations", listingService.findAllDonatedListings());
        return "admin/admin-donations";
    }

    @PostMapping("/adminRemoveDonation")
    public String removeDonation(HttpServletRequest request, @RequestParam("listingID") int listingID, @RequestParam("reason") String reason) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminDonations");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Listing listing = listingService.getByListingID(listingID);

        if (!listing.getType().equals("donation")) {
            addWarningMessage("Listing Not A Donation");
            setRequest(request);
            return "redirect:/adminDonations";
        }

        listing.setActive(0);
        listingService.saveOrUpdate(listing);

        // Notify seller why their donation was removed
        if (reason.equals("inappropriate content")) {
            notificationService.save(new Notification(listing.getUser(), listing.getId(), "Donated Item Removed",
                    "An item you donated was remove from the site because it was flagged as inappropriate.\n\nIf you have questions contact us at ulistithelp@gmail.com", 1,
                    "DONATION"));
        } else if (reason.equals("low quality")) {
            notificationService.save(new Notification(listing.getUser(), listing.getId(), "Donated Item Removed",
                    "An item you donated was remove from the site because it was flagged as low quality.\n\nIf you have questions contact us at ulistithelp@gmail.com", 1,
                    "DONATION"));
        }

        addSuccessMessage(listing.getName() + " Was Removed");
        setRequest(request);
        return "redirect:/adminDonations";

    }

    @PostMapping("/adminEditDonation")
    public String editDonation(HttpServletRequest request, @RequestParam("listingID") int listingID, @RequestParam("name") String name, @RequestParam("description") String description, @RequestParam("category") String category,
                               @RequestParam("subCategory") String subCategory) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/adminDonations");
            return "redirect:/login";
        }

        if (user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Listing listing = listingService.getByListingID(listingID);

        if (!listing.getType().equals("donation")) {
            addWarningMessage("Listing Not A Donation");
            setRequest(request);
            return "redirect:/adminDonations";
        }

        if (!listing.getName().equals(name) && name.length() > 0) {
            listing.setName(name);

        } else if (!listing.getDescription().equals(description) && description.length() > 0) {
            listing.setDescription(description);

        } else if (!listing.getCategory().equals(category) && category.length() > 0) {
            listing.setCategory(category);

        } else if (!listing.getSubCategory().equals(subCategory) && subCategory.length() > 0) {
            listing.setSubCategory(subCategory);
        }

        listingService.saveOrUpdate(listing);

        // Notify seller why their donation was edited
        notificationService.save(new Notification(listing.getUser(), listing.getId(), "Donated Item Edited",
                "An item you donated was edited by an administrator.\n\nIf you have questions contact us at ulistithelp@gmail.com", 1,
                "DONATION"));

        addSuccessMessage(listing.getName() + " Was Edited");
        setRequest(request);
        return "redirect:/adminDonations";

    }


    @RequestMapping(value = "updateArticleType", method = RequestMethod.GET)
    public String updateType(HttpServletRequest request, @RequestParam("displayType") String type, @RequestParam("id") int id) {

        News news = newsService.getArticleByID(id);
        news.setDisplayType(type);
        newsService.saveOrUpdate(news);

        return "redirect:" + request.getHeader("Referer");
    }

    @RequestMapping(value = "articleStatus", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String getArticleStatus(HttpServletRequest request) {
        ArrayList<News> news = (ArrayList<News>) newsService.getAllArticles();

        int count = 0;
        for (int i = 0; i < 8; i++) {
            if (news.get(i).getDisplayType() == null) {
                count++;
            }
        }
        System.out.println("Count :" + count);

        if (count >= 7 ) {
            System.out.println("Hit count");
            news.get(0).setDisplayType("main1");
            newsService.saveOrUpdate(news.get(0));
            news.get(1).setDisplayType("main2");
            newsService.saveOrUpdate(news.get(1));
            news.get(2).setDisplayType("main3");
            newsService.saveOrUpdate(news.get(2));
            news.get(3).setDisplayType("feature1");
            newsService.saveOrUpdate(news.get(3));
            news.get(4).setDisplayType("feature2");
            newsService.saveOrUpdate(news.get(4));
            news.get(5).setDisplayType("feature3");
            newsService.saveOrUpdate(news.get(5));
            news.get(6).setDisplayType("feature4");
            newsService.saveOrUpdate(news.get(6));
        }

        JsonArray newsArticles = new JsonArray();
        System.out.println("JSON News Articles3232: " + newsArticles.size());

        convertNewsToJson(news, newsArticles);



        request.setAttribute("newsArticles", newsArticles);


        return "events-news";
    }

    public void convertNewsToJson(ArrayList<News> news, JsonArray results) {
        for (int i = 0; i < news.size(); i++) {
            JsonObject json = new JsonObject();

            json.addProperty("newsID", String.valueOf(news.get(i).getNewsID()));
            json.addProperty("title", String.valueOf(news.get(i).getTitle()));
            json.addProperty("description", String.valueOf(news.get(i).getDescription()));
            json.addProperty("displayType", String.valueOf(news.get(i).getDisplayType()));
            json.addProperty("date", String.valueOf(news.get(i).getDateCreated()));

            results.add(json);


        }
    }

    public String getMonth(int month) {
        return new DateFormatSymbols().getMonths()[month - 1];
    }

    public String getMonth2(int month) {
        return new DateFormatSymbols().getMonths()[month];
    }
}
