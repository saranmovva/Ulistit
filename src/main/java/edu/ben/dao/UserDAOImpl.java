package edu.ben.dao;

import edu.ben.model.User;
import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Transactional
@Repository
public class UserDAOImpl implements UserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("unchecked")
    public List<User> getAllUsers() {
        Query q = getSession().createQuery("From user");
        return q.list();
    }

    public int save(User user) {
        return (Integer) getSession().save(user);
    }

    public void saveOrUpdate(User user) {
        getSession().saveOrUpdate(user);
    }

    public int create(User user) {
        return (int) getSession().save(user);
    }

    public void unlockByUsername(String username) {
        Query q = getSession().createQuery("UPDATE user SET locked=0 WHERE username=:username");
        q.setParameter("username", username);
        q.executeUpdate();
    }

    public void lockByUsername(String username) {
        Query q = getSession().createQuery("UPDATE user SET locked=1 WHERE username=:username");
        q.setParameter("username", username);
        q.executeUpdate();
    }

    public void unbanByUsername(String username) {
        Query q = getSession().createQuery("UPDATE user SET banned=0 WHERE username=:username");
        q.setParameter("username", username);
        q.executeUpdate();
    }

    public void banByUsername(String username) {
        Query q = getSession().createQuery("UPDATE user SET banned=1 WHERE username=:username");
        q.setParameter("username", username);
        q.executeUpdate();
    }

    public User getUserById(int id) {
        //User user = (User) getSession().get(User.class, id);
        Query q = getSession().createQuery("FROM user WHERE user_ID=:id");
        q.setParameter("id", id);

        //return user;
        return (User) q.uniqueResult();
    }

    public void update(User user) {
        getSession().update(user);
    }

    public void lockByEmail(String email) {
    }

    public void unlockByEmail(String email) {
    }

    public void lockBySchoolEmail(String email) {
    }

    public void unlockBySchoolEmail(String email) {
    }

    @Override
    public User findByEmail(String email) {
        Query q = getSession().createQuery("FROM user WHERE email=:email");
        q.setParameter("email", email);
        return (User) q.uniqueResult();
    }

    @Override
    public User findBySchoolEmail(String email) {
        Query q = getSession().createQuery("FROM user WHERE school_email=:email");
        q.setParameter("email", email);
        return (User) q.uniqueResult();
    }

    @Override
    public User findByUsername(String username) {
        Query q = getSession().createQuery("FROM user WHERE username=:username");
        q.setParameter("username", username);
        return (User) q.uniqueResult();
    }

    public void deleteUser(int id) {
        User user = (User) getSession().get(User.class, id);
        getSession().delete(user);

    }


    public void updateAttemptedLogins(int loginAttempts, String email) {
        Query q = getSession().createQuery("UPDATE user SET login_attempts=:loginAttempts WHERE email=:email");
        q.setParameter("loginAttempts", loginAttempts);
        q.setParameter("email", email);
        q.executeUpdate();
    }


    public void updateIsActive(int isActive, String email) {

        Query q = getSession().createQuery("UPDATE user SET active=:isActive WHERE email=:email");
        q.setParameter("isActive", isActive);
        q.setParameter("email", email);
        q.executeUpdate();
    }

    public void updateSellerRating(int sellerRating, String email) {

        Query q = getSession().createQuery("UPDATE user SET seller_rating=:seller_rating WHERE email=:email");
        q.setParameter("sellerRating", sellerRating);
        q.setParameter("email", email);
        q.executeUpdate();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<User> getRecentUsers() {
        Query q = getSession().createQuery("FROM user ORDER BY date_created DESC");
        List<User> list = (List<User>) q.list();
        Iterator<User> it = list.iterator();
        List<User> recentListings = new ArrayList<User>();

        while (it.hasNext()) {

            User usr = it.next();
            recentListings.add(usr);

        }

        return recentListings;
    }

    @Override
    public List searchUser(String search) {
        Query q = getSession().createQuery("FROM user WHERE SOUNDEX(first_name)=soundex('" + search + "') OR SOUNDEX(last_name)=soundex('" + search + "') OR SOUNDEX(username)=soundex('" + search + "') OR SOUNDEX(school_email)=soundex('" + search + "') OR first_name LIKE '%" + search + "%' OR last_name LIKE '%" + search + "%' OR username LIKE '%" + search + "%'");
        List l = q.list();
        return l;

    }

    @Override
    public List<User> getListingLosers(int listingID, int winnerID) {
        Query q = getSession().createQuery(
                " FROM user as u WHERE user_ID IN (SELECT l.user_id FROM listing_bid as l WHERE l.listing_id=:listingID AND l.user_id !=:winnerID)");
        q.setParameter("listingID", listingID);
        q.setParameter("winnerID", winnerID);
        return q.list();
    }

    @Override
    public List<User> getDisputeResolvingAdmins() {
        return getSession().createQuery("FROM user WHERE admin_level >= 10").list();
    }

    @Override
    public List getActiveUsers() {
        Query q = getSession().createQuery("FROM user WHERE active=1 and adminLevel < 10");

        return q.list();

    }

    @Override
    public List getAllAdmins() {
        Query q = getSession().createQuery("From user WHERE admin_level >= 10");

        return q.list();
    }
}