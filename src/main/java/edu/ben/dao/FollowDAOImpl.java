package edu.ben.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import edu.ben.model.Follow;
import edu.ben.model.SavedSearch;

@Transactional
@Repository
public class FollowDAOImpl implements FollowDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}


	@Override
	public boolean isFollowed(int userId, int followerId) {
		Query q = getSession().createQuery("FROM follow WHERE userId=:userId AND followerId=:followerId");

		q.setParameter("followerId", followerId);
		q.setParameter("userId", userId);

		Follow f = (Follow) q.uniqueResult();

		if (f == null) {
			return false;
		}
		
		return true;
	}

	@Override
	public List<Follow> findAllFollowersByUserId(int userID) {
		Query query = getSession().createQuery("FROM follow WHERE userID=:userID");
		query.setParameter("userID", userID);

		List list = query.list();
		return list;
	}

	@Override
	public void deleteFollower(int id) {
		Follow f = (Follow) getSession().get(Follow.class, id);
		getSession().delete(f);
		
	}

	@Override
	public void saveOrUpdate(Follow follow) {
		getSession().saveOrUpdate(follow);
		
	}

	@Override
	public void create(Follow follow) {
		getSession().save(follow);
		
	}

	@Override
	public Follow findCurrent(int userID, int followerId) {
		Query q = getSession().createQuery("FROM follow WHERE userID=:userID AND followerId=:followerId");

		q.setParameter("userID", userID);
		q.setParameter("followerId", followerId);

		Follow f = (Follow) q.uniqueResult();

		return f;
	}

	@Override
	public void unfollow(int followee, int follower) {
		Query q = getSession().createQuery("delete follow where userId ="+ followee +" AND followerId=" + follower);
		q.executeUpdate();
	}


	@Override
	public List<Follow> findAllPeopleFollowingYou(int userId) {
		Query query = getSession().createQuery("FROM follow WHERE followerId=:userId");
		query.setParameter("userId", userId);

		List list = query.list();
		return list;
	}

}
