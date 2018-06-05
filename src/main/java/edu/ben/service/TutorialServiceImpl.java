package edu.ben.service;

import edu.ben.dao.TutorialDAO;
import edu.ben.dao.UserDAO;
import edu.ben.model.Tutorial;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TutorialServiceImpl implements TutorialService {

    TutorialDAO tutorialDAO;

    @Autowired
    public void setUserDAO(TutorialDAO tutorialDAO) {
        this.tutorialDAO = tutorialDAO;
    }

    @Override
    public int save(Tutorial tutorial) {
        return tutorialDAO.save(tutorial);
    }

    @Override
    public void update(Tutorial tutorial) {
        tutorialDAO.update(tutorial);
    }

    @Override
    public Tutorial getByUserID(int id) {
        return tutorialDAO.getByUserID(id);
    }
}
