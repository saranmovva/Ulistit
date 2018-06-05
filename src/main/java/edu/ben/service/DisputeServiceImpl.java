package edu.ben.service;

import edu.ben.dao.DisputeDAO;
import edu.ben.model.Dispute;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class DisputeServiceImpl implements DisputeService {

    DisputeDAO disputeDAO;

    @Autowired
    public void setDisputeDAO(DisputeDAO disputeDAO) {
        this.disputeDAO = disputeDAO;
    }

    @Override
    public void save(Dispute dispute) {
        disputeDAO.save(dispute);
    }

    @Override
    public void update(Dispute dispute) {
        disputeDAO.update(dispute);
    }

    @Override
    public Dispute getByID(int id) {
        return disputeDAO.getByID(id);
    }

    @Override
    public List getAllActive() {
        return disputeDAO.getAllActive();
    }
}
