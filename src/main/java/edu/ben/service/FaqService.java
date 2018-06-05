package edu.ben.service;

import edu.ben.model.Faq;

import java.util.List;

public interface FaqService {

    public List getAllFaqs();

    public int save(Faq faq);

    public void update(Faq faq);

    public void remove(Faq faq);

    public Faq getByFaqID(int id);

}
