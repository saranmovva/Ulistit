package edu.ben.controller;

import com.google.gson.JsonObject;
import edu.ben.model.Tutorial;
import edu.ben.model.User;
import edu.ben.service.TutorialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class TutorialController extends BaseController {

    @Autowired
    TutorialService tutorialService;

    @RequestMapping(value = "/checkForTutorial", method = RequestMethod.GET, produces = "application/json")
    public @ResponseBody
    String checkForTutorial(HttpServletRequest request, @RequestParam("page") String page) {

        User user = (User) request.getSession().getAttribute("user");

        JsonObject json = new JsonObject();

        if (user != null) {

            Tutorial tutorial = tutorialService.getByUserID(user.getUserID());

            if (page.equals("home") && tutorial.getViewedHome() == 0) {
                json.addProperty("showTutorial", "YES");
                tutorial.setViewedHome(1);

            } else if (page.equals("listing") && tutorial.getViewedListing() == 0) {
                json.addProperty("showTutorial", "YES");
                tutorial.setViewedListing(1);

            } else if (page.equals("dashboard") && tutorial.getViewedDashboard() == 0) {
                json.addProperty("showTutorial", "YES");
                tutorial.setViewedDashboard(1);

            } else if (page.equals("checklist") && tutorial.getViewedChecklist() == 0) {
                json.addProperty("showTutorial", "YES");
                tutorial.setViewedChecklist(1);

            } else if (page.equals("pickup") && tutorial.getViewedPickup() == 0) {
                json.addProperty("showTutorial", "YES");
                tutorial.setViewedPickup(1);

            } else if (page.equals("savedSearch") && tutorial.getViewedSavedSearch() == 0) {
                json.addProperty("showTutorial", "YES");
                tutorial.setViewedSavedSearch(1);

            } else if (page.equals("transactionHistory") && tutorial.getViewedTransactionHistory() == 0) {
                json.addProperty("showTutorial", "YES");
                tutorial.setViewedTransactionHistory(1);

            } else if (page.equals("donateAnItem") && tutorial.getViewedDonateAnItem() == 0) {
                json.addProperty("showTutorial", "YES");
                tutorial.setViewedDonateAnItem(1);

            } else {
                json.addProperty("showTutorial", "NO");
            }

            tutorialService.update(tutorial);

        } else {
            json.addProperty("showTutorial", "NO");
        }

        return json.toString();
    }
}
