package edu.ben.controller;

import edu.ben.model.*;
import edu.ben.service.ChecklistService;
import edu.ben.service.SalesTrafficService;
import edu.ben.service.TutorialService;
import edu.ben.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.UnexpectedRollbackException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ChecklistController extends BaseController {

    @Autowired
    ChecklistService checklistService;

    @Autowired
    TutorialService tutorialService;

    @Autowired
    UserService userService;

    @Autowired
    SalesTrafficService salesTrafficService;

    @GetMapping("/checklist")
    public String createChecklist(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            salesTrafficService.create(new SalesTraffic("Checklist_Page"));
            addWarningMessage("Login To Create A Checklist");
            request.getSession().setAttribute("lastPage", "/checklist");
            setRequest(request);
            return "redirect:/login";
        }

        if (user.getGradeLevel() != 1) {
            addWarningMessage("Freshman Only!");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        Checklist checklist = null;

        try {

            checklist = checklistService.getByUserIDAndType(user.getUserID(), "FRESHMAN");

            // Checklist doesn't exist
        } catch (UnexpectedRollbackException e) {

            if (checklist == null) {

                Checklist adminChecklist = checklistService.getAdminChecklist();

                if (adminChecklist == null) {
                    addErrorMessage("Checklist Creation Error");
                    setRequest(request);
                    return "redirect:" + request.getHeader("Referer");
                }

                checklistService.save(new Checklist(user, "FRESHMAN"));

                checklist = checklistService.getByUserIDAndType(user.getUserID(), "FRESHMAN");

                // Create set of checklist items matching the admin checklist
                for (ChecklistItem item : adminChecklist.getItems()) {
                    ChecklistItem newItem = new ChecklistItem();
                    newItem.setChecklist(checklist);
                    newItem.setName(item.getName());
                    newItem.setStatus("STILL_NEED");
                    checklistService.save(newItem);
                }
            }
        }

        salesTrafficService.create(new SalesTraffic("Checkout_Page", user.getUserID()));

        request.setAttribute("title", "Checklist");
        request.setAttribute("checklist", checklist);
        return "checklist/freshman-checklist";
    }

    @PostMapping("/update-checklist")
    public String updateChecklist(HttpServletRequest request, @RequestParam("checklistID") int checklistID,
                                  @RequestParam("itemID") int itemID, @RequestParam("newStatus") String newStatus) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To View Your Checklist");
            setRequest(request);
            request.getSession().setAttribute("lastPage", "/checklist");
            return "redirect:/login";
        }

        Checklist checklist = checklistService.getByChecklistID(checklistID);

        if (checklist == null) {
            addErrorMessage("Error Loading Checklist");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        for (ChecklistItem item : checklist.getItems()) {
            if (item.getItemID() == itemID) {
                item.setStatus(newStatus);
                checklistService.update(item);
                break;
            }
        }

        request.getSession().setAttribute("checklist", checklistService.getByChecklistID(checklistID));

        addSuccessMessage("Checklist Updated");
        setRequest(request);
        return "redirect:" + request.getHeader("Referer");
    }

    @PostMapping("/add-item")
    public String addItem(HttpServletRequest request, @RequestParam("checklistID") int checklistID,
                          @RequestParam("name") String name) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            addWarningMessage("Login To View Your Checklist");
            request.getSession().setAttribute("lastPage", "/checklist");
            setRequest(request);
            return "redirect:/login";
        }

        Checklist checklist = checklistService.getByChecklistID(checklistID);

        if (checklist == null) {
            addErrorMessage("Error Loading Checklist");
            setRequest(request);
            return "redirect:" + request.getHeader("Referer");
        }

        checklistService.save(new ChecklistItem(checklist, name));

        request.getSession().setAttribute("checklist", checklistService.getByChecklistID(checklistID));

        addSuccessMessage(name + " Created");
        setRequest(request);
        return "redirect:/checklist";
    }
}
