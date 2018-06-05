package edu.ben.service;

import edu.ben.dao.UserDAO;
import edu.ben.model.User;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Collection;
import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService{

	UserDAO userDAO;

	@Autowired
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public List<User> getAllUsers() {
		return userDAO.getAllUsers();
	}

	public User getUserById(int id) {
		try {
			return userDAO.getUserById(id);
		} catch (IndexOutOfBoundsException e) {
            System.out.println("User doesn't exist.");
			return null;
		}
	}

	public void deleteUser(int id) {
		userDAO.deleteUser(id);
	}

	@Override
	public int save(User user) {
		return userDAO.save(user);
	}

	public void saveOrUpdate(User user) {
		userDAO.saveOrUpdate(user);
	}

	public int create(User user) {
		return userDAO.create(user);
	}

	public void lockByUsername(String username) {
		userDAO.lockByUsername(username);
	}

	public void unlockByUsername(String username) {
		userDAO.unlockByUsername(username);
	}
	
	public void banByUsername(String username) {
		userDAO.banByUsername(username);
	}

	public void unbanByUsername(String username) {
		userDAO.unbanByUsername(username);
	}

	@Override
	public User findByEmail(String email) {
		try {
			return userDAO.findByEmail(email);
		} catch (IndexOutOfBoundsException e) {
			return null;
		}
	}

	@Override
	public User findBySchoolEmail(String email) {
		try {
			return userDAO.findBySchoolEmail(email);
		} catch (IndexOutOfBoundsException e) {
			return null;
		}
	}

	@Override
	public User findByUsername(String username) {
		return userDAO.findByUsername(username);
	}

	@Override
	public void update(User user) {
		userDAO.update(user);
	}

	@Override
	public void updateAttemptedLogins(int loginAttempts, User user) {
		user.setLoginAttempts(loginAttempts);
		userDAO.update(user);
	}

	@Override
	public void updateIsActive(int isActive, String email) {
		userDAO.updateIsActive(isActive, email);
	}

	@Override
	public List<User> getRecentUsers() {
		return userDAO.getRecentUsers();
	}

	@Override
	public List<User> getListingLosers(int listingID, int winnerID) {
		return userDAO.getListingLosers(listingID, winnerID);
	}

	@Override
	public List<User> getDisputeResolvingAdmins() {
		return userDAO.getDisputeResolvingAdmins();
	}

	@Override
	public List getActiveUsers() {
		return userDAO.getActiveUsers();
	}

	@Override
	public List searchUser(String search) {
		return userDAO.searchUser(search);
	}

	public void updateSellerRating(int sellerRating, User user) {
		user.setSellerRating(sellerRating);
		userDAO.update(user);
	}

	@Override
	public List getAllAdmins() {
		return userDAO.getAllAdmins();
	}
}
