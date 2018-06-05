package edu.ben.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import edu.ben.model.*;
import edu.ben.service.EventsService;
import edu.ben.service.SalesTrafficService;
import edu.ben.service.VideoService;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.model.XWPFHeaderFooterPolicy;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFFooter;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import edu.ben.model.CalendarEvent;
import edu.ben.model.News;
import edu.ben.service.NewsService;
import edu.ben.util.Path;
import edu.ben.util.Quickstart;

@Controller
public class CommunityController extends BaseController {

    @Autowired
    NewsService newsService;

    @Autowired
    EventsService eventService;

    @Autowired
    VideoService videoService;

    @Autowired
    SalesTrafficService trafficService;

    @RequestMapping(value = "/communityPage", method = RequestMethod.GET)
    public ModelAndView community(HttpServletRequest request) {
        ModelAndView model = new ModelAndView("/community3");

        ArrayList<CalendarEvent> events = (ArrayList<CalendarEvent>) eventService.getAllEvents();

        ArrayList<String> day = new ArrayList<>();
        ArrayList<String> month = new ArrayList<>();
        ArrayList<Integer> year = new ArrayList<>();
        ArrayList<Integer> date = new ArrayList<>();
        ArrayList<String> time = new ArrayList<>();
        int size = 5;
        if (events.size() <= 5) {
            size = events.size();
        }


        for (int i = 0; i < size; i++) {
            String monthString;
            String timeString;
            String hour;
            String minute;
            String am_pm;
            System.out.println("Hour: " + events.get(i).getStartTime().getHours());
            System.out.println("Minute: " + events.get(i).getStartTime().getMinutes());
            if (events.get(i).getStartTime().getHours() > 12) {
                hour = Integer.toString(events.get(i).getStartTime().getHours() - 12);
                am_pm = "PM";
            } else {
                hour = Integer.toString(events.get(i).getStartTime().getHours());
                am_pm = "AM";
            }

            if (events.get(i).getStartTime().getMinutes() <= 9) {
                minute = "0" + Integer.toString(events.get(i).getStartTime().getMinutes());
            } else {
                minute = Integer.toString(events.get(i).getStartTime().getMinutes());
            }

            timeString = hour + ":" + minute + am_pm;
            time.add(timeString);

            switch (events.get(i).getStartTime().getMonth()) {
                case 0:
                    monthString = "January";
                    month.add(monthString);
                    break;
                case 1:
                    monthString = "February";
                    month.add(monthString);
                    break;
                case 2:
                    monthString = "March";
                    month.add(monthString);
                    break;
                case 3:
                    monthString = "April";
                    month.add(monthString);
                    break;
                case 4:
                    monthString = "May";
                    month.add(monthString);
                    break;
                case 5:
                    monthString = "June";
                    month.add(monthString);
                    break;
                case 6:
                    monthString = "July";
                    month.add(monthString);
                    break;
                case 7:
                    monthString = "August";
                    month.add(monthString);
                    break;
                case 8:
                    monthString = "September";
                    month.add(monthString);
                    break;
                case 9:
                    monthString = "October";
                    month.add(monthString);
                    break;
                case 10:
                    monthString = "November";
                    month.add(monthString);
                    break;
                case 11:
                    monthString = "December";
                    month.add(monthString);
                    break;
                default:
                    monthString = "Invalid month";
                    break;
            }
            String dayString = "invalid";
            switch (events.get(i).getStartTime().getDay()) {
                case 1:
                    dayString = "Monday";
                    day.add(monthString);
                    break;
                case 2:
                    dayString = "Tuesday";
                    day.add(monthString);
                    break;
                case 3:
                    dayString = "Wednesday";
                    day.add(monthString);
                    break;
                case 4:
                    dayString = "Thursday";
                    day.add(monthString);
                    break;
                case 5:
                    dayString = "Friday";
                    day.add(monthString);
                    break;
                case 6:
                    dayString = "Saturday";
                    day.add(monthString);
                    break;
                case 7:
                    dayString = "Sunday";
                    day.add(monthString);
                    break;
            }

            Integer yearInt = events.get(i).getStartTime().getYear() + 1900;
            year.add(yearInt);

            date.add(events.get(i).getStartTime().getDate());


            System.out.println("Month: " + monthString);
            System.out.println("Day: " + dayString);
            System.out.println("Year: " + yearInt);
            System.out.println("Date: " + events.get(i).getStartTime().getDate());
            System.out.println("Time: " + timeString);


            request.setAttribute("day", day);
            request.setAttribute("month", month);
            request.setAttribute("year", year);
            request.setAttribute("date", date);
            request.setAttribute("events", events);
            request.setAttribute("time", time);
        }

//        Video newestVideo = videoService.getNewestVideo();
//        Timestamp videoDateInt = newestVideo.getDateCreated();
//        String videoDate = Integer.toString(videoDateInt.getMonth() + 1) +"/" + Integer.toString(videoDateInt.getDate()+ 1)+ "/" + Integer.toString(videoDateInt.getYear() + 1900);
//        request.setAttribute("videoDate", videoDate);
//        System.out.println("video date: " + videoDate);
//        System.out.println("Path: " + newestVideo.getVideoPath());
//        request.setAttribute("newestVideo", newestVideo);

        User user = (User) request.getSession().getAttribute("user");

        if (user != null) {
            trafficService.create(new SalesTraffic("Community_Page", user.getUserID()));
        } else {
            trafficService.create(new SalesTraffic("Community_Page"));
        }

        ArrayList<News> displayArticles = (ArrayList<News>) newsService.getAllDisplayedArticles();
        System.out.println("Display Articles: " + displayArticles.size());

        ArrayList<Video> displayVideos = (ArrayList<Video>) videoService.getDisplayVideos();
        request.setAttribute("displayVideos", displayVideos);

        request.setAttribute("displayArticles", displayArticles);
        displayArticles.get(0).getImagePath();

        return model;
    }

    @RequestMapping(value = "/feedback", method = RequestMethod.POST)
    public ModelAndView feedback() {

        return new ModelAndView("redirect:/community");
    }

    @RequestMapping(value = "/uploadNews", method = RequestMethod.POST)
    public String viewEventsNews(HttpServletRequest request, @RequestParam("title") String title, @RequestParam("doc") MultipartFile doc,
                                 @RequestParam("image") MultipartFile image, @RequestParam("description") String description) throws IOException {

        if (!doc.isEmpty()) {
            try {
                String extension = FilenameUtils.getExtension(doc.getOriginalFilename());
                System.out.println("Doc Extension: " + extension);
                String imageExtension = FilenameUtils.getExtension(image.getOriginalFilename());
                System.out.println("Image Extension: " + imageExtension);

                if (!(imageExtension.equals("jpg") || imageExtension.equals("png") || imageExtension.equals("jpeg"))) {
                    addErrorMessage("You did not upload an image.");
                    setRequest(request);
                }

                if (!(extension.equals("docx"))) {
                    addErrorMessage("Please upload a word document.");
                    setRequest(request);
                }

                if ((extension.equals("docx"))) {
                    if ((imageExtension.equals("jpg") || imageExtension.equals("png") || imageExtension.equals("jpeg"))) {
                        News news = new News(title, doc.getOriginalFilename(), image.getOriginalFilename(), description);
                        System.out.println("News: " + news.getTitle());
                        int id = newsService.save(news);

                        byte[] bytes = doc.getBytes();
                        byte[] bytes2 = image.getBytes();

                        File dir = new File(System.getProperty("user.home") + File.separator + "ulistitNews" + File.separator + id );
                        File dir2 = new File(System.getProperty("user.home") + File.separator + "ulistitNews" + File.separator + id);


                        if (!dir.exists())
                            dir.mkdirs();

                        if (!dir2.exists())
                            dir.mkdirs();

                        news.setFilePath("ulistitNews" + File.separator + id + File.separator + doc.getOriginalFilename());
                        news.setImagePath("ulistitNews" + File.separator + id + File.separator + image.getOriginalFilename());
                        newsService.saveOrUpdate(news);

                        File serverFile = new File(System.getProperty("user.home") + File.separator + "ulistitNews" + File.separator + id + File.separator + doc.getOriginalFilename());
                        File serverFile2 = new File(System.getProperty("user.home") + File.separator + "ulistitNews" + File.separator + id + File.separator + image.getOriginalFilename());

                        try {
                            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
                            stream.write(bytes);
                            BufferedOutputStream stream2 = new BufferedOutputStream(new FileOutputStream(serverFile2));
                            stream2.write(bytes2);
                            stream.close();
                            stream2.close();
                        } catch (FileNotFoundException e) {
                            e.printStackTrace();
                        }
                    }
                }

                System.out.println("File Uploaded");


            } catch (Exception e) {
                e.printStackTrace();
                return "You failed to upload " + doc.getOriginalFilename() + " => " + e.getMessage();

            }
        }
        return "admin/events-news";
    }

    @RequestMapping(value = "/viewNews")
    public String viewNews(HttpServletRequest request, @RequestParam("newsID") String id) {
        int newsID = Integer.parseInt(id);
        News n = newsService.getArticleByID(newsID);
        try {
            FileInputStream fis = new FileInputStream(System.getProperty("user.home") + File.separator + n.getFilePath());
            XWPFDocument xdoc = new XWPFDocument(OPCPackage.open(fis));

            List<XWPFParagraph> paragraphList = xdoc.getParagraphs();
            XWPFHeaderFooterPolicy policy = new XWPFHeaderFooterPolicy(xdoc);

            XWPFHeader header = policy.getDefaultHeader();
            if (header != null) {
                request.setAttribute("header", header);
                System.out.println(header.getText());
            }

            XWPFFooter footer = policy.getDefaultFooter();
            if (footer != null) {
                request.setAttribute("footer", footer);
                System.out.println(footer.getText());
            }

            for (XWPFParagraph paragraph : paragraphList) {

                System.out.println(paragraph.getText());
                System.out.println(paragraph.getAlignment());
                System.out.print(paragraph.getRuns().size());
                System.out.println(paragraph.getStyle());

                // Returns numbering format for this paragraph, eg bullet or lowerLetter.
                System.out.println(paragraph.getNumFmt());
                System.out.println(paragraph.getAlignment());

                System.out.println(paragraph.isWordWrapped());

                System.out.println("********************************************************************");
            }
            request.setAttribute("paragraphList", paragraphList);
            request.setAttribute("n", n);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "newsPage";
    }

    @RequestMapping(value = "/createEvent")
    public String createEvent(@RequestParam("title") String title, @RequestParam("location") String location,
                              @RequestParam("description") String description, HttpServletRequest request) throws IOException {
        System.out.println("Hit Servlet");

        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate").replace('T', ' ') + ":00");

        System.out.println(currentTime.getTime());
        System.out.println(startDate.getTime());


        if (startDate.getTime() < currentTime.getTime()) {
            addErrorMessage("Cannot select date that already happened.");
            setRequest(request);
            return "admin/events-news";
        }
        Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate").replace('T', ' ') + ":00");

        System.out.println(endDate.getTime());
        if (endDate.getTime() < currentTime.getTime()) {
            addErrorMessage("Cannot select date that already happened.");
            setRequest(request);
            return "admin/events-news";
        }

        if (endDate.getTime() < startDate.getTime()) {
            addErrorMessage("End date cannot happen before the start date");
            setRequest(request);
            return "admin/events-news";
        }

        CalendarEvent event = new CalendarEvent(title, location, startDate, endDate, description, 0);

//        Quickstart q = new Quickstart();
//
//        System.out.println(startDate.toString());
//
//        q.CreateEvent(event);

        eventService.create(event);

        return "admin/events-news";
    }

    @RequestMapping(value = "/editEvent")
    public String editEvent(@RequestParam("eventId") String id, @RequestParam("title") String title, @RequestParam("location") String location,
                              @RequestParam("description") String description, HttpServletRequest request) throws IOException {
        System.out.println("Hit Servlet");

        int eventID = Integer.parseInt(id);

        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate").replace('T', ' ') + ":00");

        System.out.println(currentTime.getTime());
        System.out.println(startDate.getTime());


        if (startDate.getTime() < currentTime.getTime()) {
            addErrorMessage("Cannot select date that already happened.");
            setRequest(request);
            return "admin/events-news";
        }
        Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate").replace('T', ' ') + ":00");

        System.out.println(endDate.getTime());
        if (endDate.getTime() < currentTime.getTime()) {
            addErrorMessage("Cannot select date that already happened.");
            setRequest(request);
            return "admin/events-news";
        }

        if (endDate.getTime() < startDate.getTime()) {
            addErrorMessage("End date cannot happen before the start date");
            setRequest(request);
            return "admin/events-news";
        }

        CalendarEvent event = eventService.getEventsByID(eventID);
        event.setTitle(title);
        event.setStartTime(startDate);
        event.setEndTime(endDate);
        event.setLocation(location);
        event.setActive(1);

        System.out.println(startDate.toString());

        eventService.saveOrUpdate(event);

        return "admin/events-news";
    }

    @RequestMapping(value = "/searchNews")
    public String searchNews(HttpServletRequest request, @RequestParam("Seaerch") String search) {
        System.out.println(search);
        ArrayList<News> news = (ArrayList<News>) newsService.getAllArticles();
        ArrayList<News> searchResults = new ArrayList<>();


        for (int i = 0; i < news.size(); i++) {
            boolean searchFound = false;
            Resource resource = new ClassPathResource(news.get(i).getFilePath());

            System.out.println("Please dont fail " + resource.getFilename());
            //
            // System.out.println(file.getAbsolutePath());
            // String name = doc.getOriginalFilename();
            // File resource = new File("C:" + request.getContextPath() +
            // "/src/main/webapp/resources/docs/" + name);
            // System.out.println("Resource " + resource.getPath());

            try {
                FileInputStream fis = new FileInputStream(resource.getFile());
                XWPFDocument xdoc = new XWPFDocument(OPCPackage.open(fis));

                List<XWPFParagraph> paragraphList = xdoc.getParagraphs();
                XWPFHeaderFooterPolicy policy = new XWPFHeaderFooterPolicy(xdoc);

                XWPFHeader header = policy.getDefaultHeader();
                if (header != null) {
                    request.setAttribute("header", header);
                    System.out.println(header.getText());

                    if (header.getText().toLowerCase().contains(search)) {
                        System.out.println("Search found in header");
                        searchResults.add(news.get(i));
                        searchFound = true;
                    }
                }

                XWPFFooter footer = policy.getDefaultFooter();
                if (footer != null) {
                    request.setAttribute("footer", footer);
                    System.out.println(footer.getText());

                    if (footer.getText().toLowerCase().contains(search) && (searchFound = false)) {
                        System.out.println("Search found in footer");
                        searchResults.add(news.get(i));
                        searchFound = true;
                    }
                }

                for (XWPFParagraph paragraph : paragraphList) {
                    if (paragraph.getText().toLowerCase().contains(search) && (searchFound = false)) {
                        System.out.println("Search Result found");
                        searchResults.add(news.get(i));
                    }
                    System.out.println(paragraph.getText());
                    System.out.println(paragraph.getAlignment());
                    System.out.print(paragraph.getRuns().size());
                    System.out.println(paragraph.getStyle());

                    // Returns numbering format for this paragraph, eg bullet or lowerLetter.
                    System.out.println(paragraph.getNumFmt());
                    System.out.println(paragraph.getAlignment());

                    System.out.println(paragraph.isWordWrapped());

                    System.out.println("********************************************************************");
                }
                request.setAttribute("paragraphList", paragraphList);
                request.setAttribute("newsSearchResults", searchResults);
                System.out.println("search size: " + searchResults.size());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        return "community2";
    }

    @RequestMapping(value = "/eventsNews", method = RequestMethod.GET)
    public ModelAndView viewEventsNews(HttpServletRequest request) {
        ModelAndView model = new ModelAndView("admin/events-news");

        ArrayList<News> news = (ArrayList<News>) newsService.getAllArticles();

        int count = 0;
        for (int i = 0; i < 8; i++) {
            if (news.get(i).getDisplayType() == null) {
                count++;
            }
            System.out.println(news.get(i).getTitle());
        }
        System.out.println("Count :" + count);

        if (count >= 7) {
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

        request.setAttribute("allArticles", news);


        JsonArray results = convertNewsToJson(news, newsArticles);
        System.out.println("JSON News Articles: " + results.size());

        request.setAttribute("newsArticlesJson", results);

        ArrayList<Video> video = (ArrayList<Video>) videoService.getAllVideos();

        JsonArray allVideos = new JsonArray();

        request.setAttribute("allVideos", video);


        JsonArray results2 = convertVideoToJson(video, allVideos);
        System.out.println("JSON videos: " + results.size());

        request.setAttribute("videosJson", results2);

        ArrayList<String> startTime = new ArrayList<>();
        ArrayList<String> endTime = new ArrayList<>();

        ArrayList<CalendarEvent> events = (ArrayList<CalendarEvent>) eventService.getActiveAndInactiveListings();
        System.out.println("Event Size: " + events.size());

        for (int i =0; i < events.size(); i++) {
            String start = events.get(i).getStartTime().toString().substring(0, 16).replace(' ','T');
            String end = events.get(i).getEndTime().toString().substring(0, 16).replace(' ','T');

            startTime.add(start);
            endTime.add(end);
            System.out.println(start);
        }

        request.setAttribute("startTime", startTime);
        request.setAttribute("endTime", endTime);
        request.setAttribute("events", events);

        return model;

    }

    public JsonArray convertNewsToJson(ArrayList<News> news, JsonArray results) {
        for (int i = 0; i < news.size(); i++) {
            JsonObject json = new JsonObject();

            json.addProperty("newsID", String.valueOf(news.get(i).getNewsID()));
            json.addProperty("title", String.valueOf(news.get(i).getTitle()));
            json.addProperty("description", String.valueOf(news.get(i).getDescription()));
            json.addProperty("displayType", String.valueOf(news.get(i).getDisplayType()));
            json.addProperty("date", String.valueOf(news.get(i).getDateCreated()));

            results.add(json);

        }
        return results;
    }

    public JsonArray convertVideoToJson(ArrayList<Video> videos, JsonArray results) {
        for (int i = 0; i < videos.size(); i++) {
            JsonObject json = new JsonObject();

            json.addProperty("videoID", String.valueOf(videos.get(i).getVideoID()));
            json.addProperty("title", String.valueOf(videos.get(i).getTitle()));
            json.addProperty("url", String.valueOf(videos.get(i).getVideoPath()));
            json.addProperty("type", String.valueOf(videos.get(i).getType()));
            json.addProperty("date", String.valueOf(videos.get(i).getDateCreated()));

            results.add(json);

        }
        return results;
    }

    @RequestMapping(value = "/updateNews", method = RequestMethod.GET)
    public String updateNews(HttpServletRequest request, @RequestParam("newsID") String newsID, @RequestParam("type") String type) {
        int id = Integer.parseInt(newsID);
        System.out.println("Hit update News");

        News n = newsService.getArticleByID(id);
        ArrayList<News> allArticles = (ArrayList<News>) newsService.getAllArticles();

        for (int i = 0; i < allArticles.size(); i++) {
            if (allArticles.get(i).getDisplayType().equals(type)) {
                allArticles.get(i).setDisplayType("none");
                n.setDisplayType(type);
                newsService.saveOrUpdate(n);
                newsService.saveOrUpdate(allArticles.get(i));
            }
        }

        n.setDisplayType(type);

        newsService.saveOrUpdate(n);

        return "admin/events-news";
    }

    @RequestMapping(value = "allArticles", method = RequestMethod.GET)
    public String allArticles(HttpServletRequest request) {
        ArrayList<News> allArticles = (ArrayList<News>) newsService.getAllArticles();


        request.setAttribute("allArticles", allArticles);
        return "all-articles";
    }

}
