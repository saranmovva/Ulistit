package edu.ben.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.sql.Timestamp;

@Table(name = "revenue")
@Entity(name = "revenue")
@Transactional
public class Revenue {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "revenue_ID")
    private int revenueID;

    @Column(name = "transaction_price")
    private int transactionPrice;

    @Column(name = "transaction_date")
    private Timestamp transactionDate;


    public Revenue() {
    }

    public int getRevenueID() {
        return revenueID;
    }

    public void setRevenueID(int revenueID) {
        this.revenueID = revenueID;
    }

    public int getTransactionPrice() {
        return transactionPrice;
    }

    public void setTransactionPrice(int transactionPrice) {
        this.transactionPrice = transactionPrice;
    }

    public Timestamp getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Timestamp transactionDate) {
        this.transactionDate = transactionDate;
    }
}
