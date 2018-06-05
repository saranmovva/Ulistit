package edu.ben.dao;

import java.util.List;

import edu.ben.model.User;

public interface UserDAO {

    public List<User> getAllUsers();

    public User getUserById(int id);

    public void deleteUser(int id);

    public int save(User user);

    public void saveOrUpdate(User user);

    public int create(User user);

    public void unlockByUsername(String username);

    public void lockByUsername(String username);
    
    public void unbanByUsername(String username);

    public void banByUsername(String username);

    public User findByEmail(String email);

    public User findBySchoolEmail(String email);

    public User findByUsername(String username);

    public void update(User user);
    
    public void updateSellerRating(int sellerRating, String email);

    public void updateAttemptedLogins(int loginAttempts, String email);

    public void updateIsActive(int isActive, String email);

    public List<User> getRecentUsers();

    public List searchUser(String search);

    public List<User> getListingLosers(int listingID, int winnerID);

    public List<User> getDisputeResolvingAdmins();

    public List getActiveUsers();

    public List getAllAdmins();

}
