package edu.ben.service;

import edu.ben.model.CalendarEvent;

import java.util.List;

public interface EventsService {
    public void delete(int id);

    public void saveOrUpdate(CalendarEvent events);

    public void create(CalendarEvent events);

    public List getAllEvents();

    public List getActiveAndInactiveListings();


    public CalendarEvent getEventsByID(int id);
}
