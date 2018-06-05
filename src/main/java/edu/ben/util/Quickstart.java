package edu.ben.util;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.calendar.CalendarScopes;
import com.google.api.services.calendar.model.*;
import edu.ben.model.CalendarEvent;
import edu.ben.model.PickUp;
import edu.ben.model.User;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;

public class Quickstart {
    /**
     * Application name.
     */
    private static final String APPLICATION_NAME =
            "Google Calendar API Java Quickstart";

    /**
     * Directory to store user credentials for this application.
     */
    private static final java.io.File DATA_STORE_DIR = new java.io.File(
            System.getProperty("user.home"), ".credentials/calendar-java-quickstart");

    /**
     * Global instance of the {@link FileDataStoreFactory}.
     */
    private static FileDataStoreFactory DATA_STORE_FACTORY;

    /**
     * Global instance of the JSON factory.
     */
    private static final JsonFactory JSON_FACTORY =
            JacksonFactory.getDefaultInstance();

    /**
     * Global instance of the HTTP transport.
     */
    private static HttpTransport HTTP_TRANSPORT;

    private static com.google.api.services.calendar.Calendar service;

    /**
     * Global instance of the scopes required by this quickstart.
     * <p>
     * If modifying these scopes, delete your previously saved credentials
     * at ~/.credentials/calendar-java-quickstart
     */
    private static final List<String> SCOPES =
            Arrays.asList(CalendarScopes.CALENDAR);

    static {
        try {
            HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
            DATA_STORE_FACTORY = new FileDataStoreFactory(DATA_STORE_DIR);
        } catch (Throwable t) {
            t.printStackTrace();
            System.exit(1);
        }
    }

    /**
     * Creates an authorized Credential object.
     *
     * @return an authorized Credential object.
     * @throws IOException
     */
    public static Credential authorize() throws IOException {
        // Load client secrets.
        InputStream in =
                Quickstart.class.getResourceAsStream("/client_secret.json");

        GoogleClientSecrets clientSecrets =
                GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

        // Build flow and trigger user authorization request.
        GoogleAuthorizationCodeFlow flow =
                new GoogleAuthorizationCodeFlow.Builder(
                        HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                        .setDataStoreFactory(DATA_STORE_FACTORY)
                        .setAccessType("offline")
                        .build();
        Credential credential = new AuthorizationCodeInstalledApp(
                flow, new LocalServerReceiver()).authorize("user");
        System.out.println(
                "Credentials saved to " + DATA_STORE_DIR.getAbsolutePath());
        return credential;
    }

    /**
     * Build and return an authorized Calendar client service.
     *
     * @return an authorized Calendar client service
     * @throws IOException
     */
    public static com.google.api.services.calendar.Calendar
    getCalendarService() throws IOException {
        Credential credential = authorize();
        return new com.google.api.services.calendar.Calendar.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, credential)
                .setApplicationName(APPLICATION_NAME)
                .build();
    }

    public static void main(String[] args) throws IOException {
        // Build a new authorized API client service.
        // Note: Do not confuse this class with the
        //   com.google.api.services.calendar.model.Calendar class.
        service = getCalendarService();

        // List the next 10 events from the primary calendar.
        DateTime now = new DateTime(System.currentTimeMillis());
        Events events = service.events().list("primary")
                .setMaxResults(10)
                .setTimeMin(now)
                .setOrderBy("startTime")
                .setSingleEvents(true)
                .execute();
        List<Event> items = events.getItems();
        if (items.size() == 0) {
            System.out.println("No upcoming events found.");
        } else {
            System.out.println("Upcoming events");
            for (Event event : items) {
                DateTime start = event.getStart().getDateTime();
                if (start == null) {
                    start = event.getStart().getDate();
                }
                System.out.printf("%s (%s)\n", event.getSummary(), start);
            }
        }

    }

    public void CreateEvent(CalendarEvent calendarEvent) throws IOException {
        // Refer to the Java quickstart on how to setup the environment:
        // https://developers.google.com/google-apps/calendar/quickstart/java
        // Change the scope to CalendarScopes.CALENDAR and delete any stored
        // credentials.

        service = getCalendarService();

        String startTime = calendarEvent.getStartTime().toString().replace(' ', 'T');
        String endTime = calendarEvent.getEndTime().toString().replace(' ', 'T');

        System.out.println("Start: " + startTime);
        Event event = new Event()
                .setSummary(calendarEvent.getTitle())
                .setLocation("Krasa Student Center, Lisle, IL")
                .setDescription(calendarEvent.getDescription());

        DateTime startDateTime = new DateTime(startTime + "-06:00");
        EventDateTime start = new EventDateTime()
                .setDateTime(startDateTime)
                .setTimeZone("America/Los_Angeles");
        event.setStart(start);

        DateTime endDateTime = new DateTime(endTime + "-06:00");
        EventDateTime end = new EventDateTime()
                .setDateTime(endDateTime)
                .setTimeZone("America/Los_Angeles");
        event.setEnd(end);

//    	String[] recurrence = new String[] {"RRULE:FREQ=DAILY;COUNT=2"};
//    	event.setRecurrence(Arrays.asList(recurrence));

        EventAttendee[] attendees = new EventAttendee[]{
                new EventAttendee().setEmail("lpage@example.com"),
                new EventAttendee().setEmail("sbrin@example.com"),
        };
        event.setAttendees(Arrays.asList(attendees));

        EventReminder[] reminderOverrides = new EventReminder[]{
                new EventReminder().setMethod("email").setMinutes(24 * 60),
                new EventReminder().setMethod("popup").setMinutes(10),
        };
        Event.Reminders reminders = new Event.Reminders()
                .setUseDefault(false)
                .setOverrides(Arrays.asList(reminderOverrides));
        event.setReminders(reminders);

        String calendarId = "primary";
        event = service.events().insert(calendarId, event).execute();
        System.out.printf("Event created: %s\n", event.getHtmlLink());
    }

    public void pickupEvent(User u, PickUp p) throws IOException {
        // Refer to the Java quickstart on how to setup the environment:
        // https://developers.google.com/google-apps/calendar/quickstart/java
        // Change the scope to CalendarScopes.CALENDAR and delete any stored
        // credentials.

        String latatude = Float.toString(p.getLocation().getLatitude());
        String longitide = Float.toString(p.getLocation().getLongitude());
        String location = latatude + ", " + longitide;

        service = getCalendarService();

        System.out.println("Start: " + p.getPickUpTime());
        String startTime = p.getPickUpTimestamp().toString().replace(' ', 'T');
        String endTime = p.getPickUpTimestamp().toString().replace(' ', 'T');

        Event event = null;

        // Buyer
        if (u.getUserID() == p.getTransaction().getBuyer().getUserID()) {
            event = new Event()
                    .setSummary("Pickup " + p.getTransaction().getListingID().getName())
                    .setLocation(location)
                    .setDescription("Pickup '" + p.getTransaction().getListingID().getName() + "' with " +
                            p.getTransaction().getSeller().getFirstName() + " " + p.getTransaction().getSeller().getLastName() +
                            " (Phone Number: " + p.getTransaction().getSeller().getPhoneNumber() + ").");

            // Seller
        } else {
            event = new Event()
                    .setSummary("Pickup " + p.getTransaction().getListingID().getName())
                    .setLocation(location)
                    .setDescription("Pickup '" + p.getTransaction().getListingID().getName() + "' with " +
                            p.getTransaction().getBuyer().getFirstName() + " " + p.getTransaction().getBuyer().getLastName() +
                            " (Phone Number: " + p.getTransaction().getBuyer().getPhoneNumber() + ").");

        }

        if (event != null) {

            DateTime startDateTime = new DateTime(startTime + "-06:00");
            EventDateTime start = new EventDateTime()
                    .setDateTime(startDateTime)
                    .setTimeZone("America/Los_Angeles");
            event.setStart(start);

            DateTime endDateTime = new DateTime(endTime + "-06:00");
            EventDateTime end = new EventDateTime()
                    .setDateTime(endDateTime)
                    .setTimeZone("America/Los_Angeles");
            event.setEnd(end);

            EventAttendee[] attendees = new EventAttendee[]{
                    new EventAttendee().setEmail(u.getEmail()),
            };
            event.setAttendees(Arrays.asList(attendees));

            EventReminder[] reminderOverrides = new EventReminder[]{
                    new EventReminder().setMethod("email").setMinutes(24 * 60),
                    new EventReminder().setMethod("popup").setMinutes(10),
            };
            Event.Reminders reminders = new Event.Reminders()
                    .setUseDefault(false)
                    .setOverrides(Arrays.asList(reminderOverrides));
            event.setReminders(reminders);

            String calendarId = "primary";
            event = service.events().insert(calendarId, event).execute();
            System.out.printf("Event created: %s\n", event.getHtmlLink());

        }
    }
}