package edu.ben.service;

import edu.ben.dao.ChecklistDAO;
import edu.ben.model.Checklist;
import edu.ben.model.ChecklistItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.UnexpectedRollbackException;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ChecklistServiceImpl implements ChecklistService {

    ChecklistDAO checklistDAO;

    @Autowired
    public void setChecklistDAO(ChecklistDAO checklistDAO) {
        this.checklistDAO = checklistDAO;
    }

    @Override
    public void save(Checklist checklist) {
        checklistDAO.save(checklist);
    }

    @Override
    public void update(Checklist checklist) {
        checklistDAO.update(checklist);
    }

    @Override
    public void save(ChecklistItem checklistItem) {
        checklistDAO.save(checklistItem);
    }

    @Override
    public void update(ChecklistItem checklistItem) {
        checklistDAO.update(checklistItem);
    }

    @Override
    public Checklist getByChecklistID(int id) {
        try {
            return checklistDAO.getByChecklistID(id);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    @Override
    public List getByUserID(int userID) {
        return checklistDAO.getByUserID(userID);
    }

    @Override
    public Checklist getByUserIDAndType(int userID, String type) {
        try {
            return checklistDAO.getByUserIDAndType(userID, type);
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    @Override
    public Checklist getAdminChecklist() {
        try {
            return checklistDAO.getAdminChecklist();
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
    }

    @Override
    public void delete(ChecklistItem item) {
        checklistDAO.delete(item);
    }
}
