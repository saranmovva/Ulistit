package edu.ben.service;

import edu.ben.model.Tutorial;

public interface TutorialService {

    public int save(Tutorial tutorial);

    public void update(Tutorial tutorial);

    public Tutorial getByUserID(int id);


}
