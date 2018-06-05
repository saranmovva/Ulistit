package edu.ben.service;

import edu.ben.dao.FaqDAO;
import edu.ben.model.Faq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class FaqServiceImpl implements FaqService {

    FaqDAO faqDAO;

    @Autowired
    public void setFaqDAO(FaqDAO faqDAO) {
        this.faqDAO = faqDAO;
    }

    @Override
    public List getAllFaqs() {
        return faqDAO.getAllFaqs();
    }

    @Override
    public int save(Faq faq) {
        return faqDAO.save(faq);
    }

    @Override
    public void update(Faq faq) {
        faqDAO.update(faq);
    }

    @Override
    public void remove(Faq faq) {
        faqDAO.remove(faq);
    }

    @Override
    public Faq getByFaqID(int id) {
        return faqDAO.getByFaqID(id);
    }
}
