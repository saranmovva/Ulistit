package edu.ben.controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import edu.ben.model.Image;
import edu.ben.model.Listing;
import edu.ben.service.CategoryService;
import edu.ben.service.ListingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@Transactional
public class AllViewController extends BaseController {

    @Autowired
    CategoryService categoryService;

    @Autowired
    ListingService listingService;

    @RequestMapping(value="/allView", method = RequestMethod.GET)
    public String displayListingByCategory(@RequestParam(name="categoryView", required=false) String cat, HttpServletRequest request) {
        System.out.println(cat);
        request.getSession().setAttribute("allViewCategory", cat);
        request.setAttribute("categories", categoryService.getAllCategories());
        request.setAttribute("subCategories", categoryService.getAllSubCategories());
        return "allViewPage";
    }


    @RequestMapping(value ="getAllListings", method = RequestMethod.GET, produces="application/json")
    public @ResponseBody String getAllListings(HttpServletRequest request){
        List<Listing> allListings = (List<Listing>) listingService.getAllListings();

        if(allListings != null || !allListings.isEmpty()) {
            JsonArray result = new JsonArray();
            for (int i = 0; i < allListings.size(); i++) {
                if(allListings.get(i).getActive() == 1 && allListings.get(i).getDraft() == 0) {
                    JsonObject addJson = new JsonObject();
                    List<Image> temp = allListings.get(i).getImages();
                    addJson.addProperty("listingId", allListings.get(i).getId());
                    addJson.addProperty("listingName", allListings.get(i).getName());
                    addJson.addProperty("listingCategory", allListings.get(i).getCategory());
                    addJson.addProperty("listingPrice", allListings.get(i).getPrice());
                    addJson.addProperty("listingEndTime", allListings.get(i).getEndTimestamp().toString());
                    addJson.addProperty("listingBids", allListings.get(i).getBidCount());
                    addJson.addProperty("listingHighestBids", allListings.get(i).getHighestBid());
                    addJson.addProperty("resultType", "listing");
                    for(int j = 0; j < temp.size(); j++) {
                        if (temp.get(j).getMain() == 1)
                            addJson.addProperty("listingImages", temp.get(j).getImage_path() + "/" + temp.get(j).getImage_name());
                    }

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
            }
            return result.toString();
        }

        return null;
    }



}
