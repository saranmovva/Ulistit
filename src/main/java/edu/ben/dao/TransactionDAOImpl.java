package edu.ben.dao;

import edu.ben.model.Transaction;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public class TransactionDAOImpl implements TransactionDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Transaction getTransaction(int id) {
        Query q = getSession().createQuery("FROM transaction WHERE transaction_ID=:id");
        q.setParameter("id", id);
        return (Transaction) q.uniqueResult();
    }

    @Override
    public void createTransaction(Transaction transaction) {
        getSession().save(transaction);
    }

    @Override
    public void saveOrUpdate(Transaction transaction) {
        getSession().saveOrUpdate(transaction);
    }

    @Override
    public void deleteTransaction(Transaction transaction) {
        getSession().delete(transaction);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Transaction> getTransactionsByBuyerID(int buyerID) {

        Query q = getSession().createQuery("FROM transaction WHERE buyer_ID=:buyerID");
        q.setParameter("buyerID", buyerID);

        return q.list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Transaction> getTransactionsBySellerID(int sellerID) {

        Query q = getSession().createQuery("FROM transaction WHERE seller_ID=:sellerID");
        q.setParameter("sellerID", sellerID);

        return q.list();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Transaction> getTransactionsByUserID(int id) {

        Query q = getSession().createQuery("FROM transaction WHERE buyer_ID=:id OR seller_ID=:id");
        q.setParameter("id", id);

        return q.list();
    }

    @Override
    public Transaction getTransactionsByListingID(int id) {
        Query q = getSession().createQuery("SELECT * FROM transaction WHERE listingID=" + id + " LIMIT 1");
        return (Transaction) q.uniqueResult();
    }

}

