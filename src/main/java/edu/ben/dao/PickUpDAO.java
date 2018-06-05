package edu.ben.dao;

import edu.ben.model.PickUp;

import java.util.List;

public interface PickUpDAO {

    public void save(PickUp pickUp);

    public void update(PickUp pickUp);

    public PickUp getPickUpByListingID(int id);

    public PickUp getPickUpByPickUpID(int id);

    public List getAllActive();

}
