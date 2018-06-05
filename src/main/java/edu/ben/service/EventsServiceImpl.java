package edu.ben.service;

import edu.ben.dao.EventsDAO;
import edu.ben.model.CalendarEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class EventsServiceImpl implements EventsService {

    EventsDAO eventsDAO;

    @Autowired
    public void setEventsDAO(EventsDAO eventsDAO) {
        this.eventsDAO = eventsDAO;
    }

    @Override
    public void delete(int id) {
        eventsDAO.delete(id);

    }

    @Override
    public void saveOrUpdate(CalendarEvent events) {
        eventsDAO.saveOrUpdate(events);

    }

    @Override
    public void create(CalendarEvent events) {
        eventsDAO.create(events);

    }

    @Override
    public List getAllEvents() {
        return eventsDAO.getAllEvents();
    }

    @Override
    public List getActiveAndInactiveListings() {
        return eventsDAO.getActiveAndInactiveListings();
    }

    @Override
    public CalendarEvent getEventsByID(int id) {
        return eventsDAO.getEventsByID(id);
    }

}
