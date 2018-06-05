package edu.ben.service;

import edu.ben.model.Location;

import java.util.List;

public interface LocationService {

    public int save(Location location);

    public Location getByName(String name);

    public Location getByLocationID(int id);

    public void update(Location location);

    public List getAllLocations();

    public List getAllSafeZones();

}
