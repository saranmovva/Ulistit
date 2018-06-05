package edu.ben.dao;

import edu.ben.model.Location;

import java.util.List;

public interface LocationDAO {

    public int save(Location location);

    public void update(Location location);

    public List getAllSafeZones();

    public Location getByName(String name);

    public List getAllLocations();

    public Location getByLocationID(int id);
}
