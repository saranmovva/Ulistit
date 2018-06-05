package edu.ben.dao;

import edu.ben.model.Dispute;

import java.util.List;

public interface DisputeDAO {

    public void save(Dispute dispute);

    public void update(Dispute dispute);

    public Dispute getByID(int id);

    public List getAllActive();

}
