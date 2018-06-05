package edu.ben.dao;

import edu.ben.model.Tutorial;

public interface TutorialDAO {

    public int save(Tutorial tutorial);

    public void update(Tutorial tutorial);

    public Tutorial getByUserID(int id);
}
