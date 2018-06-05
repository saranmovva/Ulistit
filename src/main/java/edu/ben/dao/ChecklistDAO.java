package edu.ben.dao;

import edu.ben.model.Checklist;
import edu.ben.model.ChecklistItem;

import java.util.List;

public interface ChecklistDAO {

    public void save(Checklist checklist);

    public void update(Checklist checklist);

    public void save(ChecklistItem checklistItem);

    public void update(ChecklistItem checklistItem);

    public List getByUserID(int userID);

    public Checklist getByUserIDAndType(int userID, String type);

    public Checklist getAdminChecklist();

    public Checklist getByChecklistID(int id);

    public void delete(ChecklistItem item);
}
