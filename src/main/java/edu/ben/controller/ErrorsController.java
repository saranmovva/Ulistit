package edu.ben.controller;
import com.google.gson.JsonObject;
import edu.ben.model.*;
import edu.ben.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
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
public class ErrorsController extends BaseController {

    @RequestMapping(value = "errors", method = RequestMethod.GET)
    public ModelAndView renderErrorPage(HttpServletRequest httpRequest) {

        ModelAndView errorPage = new ModelAndView("errorPage");
        String errorMsg = "";
        int httpErrorCode = getErrorCode(httpRequest);

        switch (httpErrorCode) {
            case 400: {
                errorMsg = "U-ListIt Http Error Code: 400. Bad Request";
                break;
            }
            case 401: {
                errorMsg = "U-ListIt Http Error Code: 401. Unauthorized";
                break;
            }
            case 404: {
                errorMsg = "U-ListIt Http Error Code: 404. Resource not found";
                break;
            }
            case 500: {
                errorMsg = "U-ListIt Http Error Code: 500. Internal Server Error";
                break;
            }
        }
        errorPage.addObject("errorMsg", errorMsg);
        return errorPage;
    }

    @RequestMapping(value = "500Error", method = RequestMethod.GET)
    public void throwRuntimeException() {
        throw new NullPointerException("Throwing a null pointer exception");
    }

    private int getErrorCode(HttpServletRequest httpRequest) {
        return (Integer) httpRequest
                .getAttribute("javax.servlet.error.status_code");
    }
}