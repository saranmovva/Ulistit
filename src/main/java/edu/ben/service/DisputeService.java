package edu.ben.service;

import edu.ben.model.Dispute;

import java.util.List;

public interface DisputeService {

    public void save(Dispute dispute);

    public void update(Dispute dispute);

    public Dispute getByID(int id);

    public List getAllActive();
}
