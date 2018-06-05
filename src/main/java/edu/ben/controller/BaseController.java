package edu.ben.controller;

import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

public class BaseController {

    private ArrayList<String> successMessages;
    private ArrayList<String> warningMessages;
    private ArrayList<String> errorMessages;

    public void addSuccessMessage(String m) {
        if (successMessages == null) {
            successMessages = new ArrayList<String>();
        }
        successMessages.add(m);
    }

    public void addWarningMessage(String m) {
        if (warningMessages == null) {
            warningMessages = new ArrayList<String>();
        }
        warningMessages.add(m);
    }

    public void addErrorMessage(String m) {
        if (errorMessages == null) {
            errorMessages = new ArrayList<String>();
        }
        errorMessages.add(m);
    }

    public void setRequest(HttpServletRequest m) {
        m.getSession().setAttribute("errorMessages", errorMessages);
        m.getSession().setAttribute("warningMessages", warningMessages);
        m.getSession().setAttribute("successMessages", successMessages);
    }

    public void setModel(ModelAndView m) {
        m.addObject("errorMessages", errorMessages);
        m.addObject("warningMessages", warningMessages);
        m.addObject("successMessages", successMessages);
    }

    public ArrayList<String> getSuccessMessages() {
        return successMessages;
    }

    public void setSuccessMessages(ArrayList<String> successMessages) {
        this.successMessages = successMessages;
    }

    public ArrayList<String> getWarningMessages() {
        return warningMessages;
    }

    public void setWarningMessages(ArrayList<String> warningMessages) {
        this.warningMessages = warningMessages;
    }

    public ArrayList<String> getErrorMessages() {
        return errorMessages;
    }

    public void setErrorMessages(ArrayList<String> errorMessages) {
        this.errorMessages = errorMessages;
    }
}