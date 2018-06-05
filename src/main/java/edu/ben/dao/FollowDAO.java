package edu.ben.dao;

import java.util.List;

import edu.ben.model.Follow;

public interface FollowDAO {
	public boolean isFollowed(int userId, int followerId);

	public List<Follow> findAllFollowersByUserId(int userID);

	public List<Follow> findAllPeopleFollowingYou(int userId);

	public void deleteFollower(int id);

	public void saveOrUpdate(Follow follow);

	public void create(Follow follow);

	public Follow findCurrent(int userID, int followerID);

	public void unfollow(int followee, int follower);

}
