package edu.ben.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.ben.dao.FavoriteDAO;
import edu.ben.dao.FollowDAO;
import edu.ben.model.Follow;

@Service
@Transactional
public class FollowServiceImpl implements FollowService {

FollowDAO fd;
	
	@Autowired
	public void setFollowDAO(FollowDAO fd) {
		this.fd = fd;
	}
	@Override
	public boolean isFollowed(int userId, int followerId) {
		return fd.isFollowed(userId, followerId);
	}

	@Override
	public List<Follow> findAllFollowersByUserId(int userID) {
		return fd.findAllFollowersByUserId(userID);
	}

	@Override
	public void deleteFollower(int id) {
		fd.deleteFollower(id);
		
	}

	@Override
	public void saveOrUpdate(Follow follow) {
		fd.saveOrUpdate(follow);
		
	}

	@Override
	public void create(Follow follow) {
		fd.create(follow);
		
	}

	@Override
	public Follow findCurrent(int userID, int followerID) {
		return fd.findCurrent(userID, followerID);
	}

	@Override
	public void unfollow(int followee, int follower) {
		fd.unfollow(followee, follower);
	}

	@Override
	public List<Follow> findAllPeopleFollowingYou(int userId) {
		return fd.findAllPeopleFollowingYou(userId);
	}

}
