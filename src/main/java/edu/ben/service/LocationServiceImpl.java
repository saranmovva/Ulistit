package edu.ben.service;

import edu.ben.dao.LocationDAO;
import edu.ben.model.Location;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class LocationServiceImpl implements LocationService {

    LocationDAO locationDAO;

    @Autowired
    public void setLocationDAO(LocationDAO locationDAO) {
        this.locationDAO = locationDAO;
    }

    public int save(Location location) {
        return locationDAO.save(location);
    }

    @Override
    public Location getByName(String name) {
        try {
            return locationDAO.getByName(name);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    @Override
    public Location getByLocationID(int id) {
        try {
            return locationDAO.getByLocationID(id);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    @Override
    public void update(Location location) {
        locationDAO.update(location);
    }

    @Override
    public List getAllLocations() {
        return locationDAO.getAllLocations();
    }

    @Override
    public List getAllSafeZones() {
        return locationDAO.getAllSafeZones();
    }

}
