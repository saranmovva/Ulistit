package edu.ben.controller;

//import com.google.appengine.repackaged.org.joda.time.DateTime;

import edu.ben.model.Revenue;
import edu.ben.service.RevenueService;
import edu.ben.service.SalesTrafficService;
import edu.ben.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

@Controller
public class RevenueController {

    @Autowired
    UserService userService;

    @Autowired
    RevenueService revenueService;

    @Autowired
    SalesTrafficService trafficService;


    @RequestMapping(value = "getAdminSales")
    public String adminSales(HttpServletRequest request) {
        Revenue r = new Revenue();

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

            System.out.println("Hour Day: " + currentDay);

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

            System.out.println("This Week: " + currentWeek);
            System.out.println("Last Week: " + lastWeekDate);

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

            System.out.println("Last Month Sales: " + lastYearMonthlyRevenue);

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
            String beginningOfWeekFormat =  currentYear + "-" + currentMonth + "-" + beginningOfWeek;
            String endOfWeekFormat =  currentYear + "-" + currentMonth + "-" + endOfWeek;
            String monthFormat =  currentYear + "-" + currentMonth;

            long trafficDayCount = trafficService.getCountByPageByDay(pages[i], currentDayFormat);
            long trafficWeekCount = trafficService.getCountByPageByWeek(pages[i], beginningOfWeekFormat, endOfWeekFormat);
            long trafficMonthCount = trafficService.getCountByPageByMonth(pages[i], monthFormat);
            long trafficYearCount = trafficService.getCountByPageByYear(pages[i], currentYear);

            Integer dayCount = (int)(long) trafficDayCount;
            dailyCount.add(dayCount);
            Integer weekCount = (int)(long) trafficWeekCount;
            weeklyCount.add(weekCount);
            Integer monthCount = (int)(long) trafficMonthCount;
            monthlyCount.add(monthCount);
            Integer yearCount = (int)(long) trafficYearCount;
            yearlyCount.add(yearCount);

            System.out.println("current Day: " + currentDay + " - " + dayCount);
            System.out.println("Current Week: " + beginningOfWeek + "-" + endOfWeek + " - " + weekCount);
            System.out.println("current month: " + currentMonth + " - " + monthCount);
            System.out.println("current year: " + currentYear + " - " + yearCount);


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


        return "admin/adminPage";
    }

    public String getMonth(int month) {
        return new DateFormatSymbols().getMonths()[month - 1];
    }

    public String getMonth2(int month) {
        return new DateFormatSymbols().getMonths()[month];
    }

}
