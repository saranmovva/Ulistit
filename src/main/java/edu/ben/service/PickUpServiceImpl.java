package edu.ben.service;

import edu.ben.dao.PickUpDAO;
import edu.ben.model.PickUp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class PickUpServiceImpl implements PickUpService {

    PickUpDAO pickUpDAO;

    @Autowired
    public void setPickUpDAO(PickUpDAO pickUpDAO) {
        this.pickUpDAO = pickUpDAO;
    }

    @Override
    public PickUp getPickUpByListingID(int id) {
        try {
            return pickUpDAO.getPickUpByListingID(id);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    @Override
    public PickUp getPickUpByPickUpID(int id) {
        try {
            return pickUpDAO.getPickUpByPickUpID(id);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    @Override
    public void save(PickUp pickUp) {
        pickUpDAO.save(pickUp);
    }

    @Override
    public void update(PickUp pickUp) {
        pickUpDAO.update(pickUp);
    }

    @Override
    public List getAllActive() {
        return pickUpDAO.getAllActive();
    }
}
