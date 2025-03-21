package edu.kh.project.business.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.business.model.dto.Business;
import edu.kh.project.business.model.dto.Order;
import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.common.model.dto.PointUsage;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.member.model.dto.Member;

@Repository
public class BusinessDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getListCount(Map<String, Object> paramMap) {
		return sqlSession.selectOne("boardMapper.getListCount", paramMap);
	}

	public List<Business> selectBusinessList(Map<String, Object> paramMap) {
		return sqlSession.selectList("boardMapper.selectBusinessList", paramMap);
	}

	public List<Business> selectBusinessList(Map<String, Object> paramMap, Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("boardMapper.selectSearchBusinessList", paramMap, rowBounds);
	}

	public Business selectBusiness(Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.selectBusiness", map);
	}

	public int getReviewListCount(Map<String, Object> paramMap) {
		return sqlSession.selectOne("boardMapper.getReviewListCount", paramMap);
	}

	public int getReplyListCount(Map<String, Object> paramMap) {
		return sqlSession.selectOne("boardMapper.getReplyListCount", paramMap);
	}

	public List<Review> selectReviewList(Map<String, Object> paramMap, Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("boardMapper.selectReviewList", paramMap, rowBounds);
	}
	
	public List<Reply> selectReplyList(Map<String, Object> paramMap, Pagination pagination) {
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("boardMapper.selectReplyList", paramMap, rowBounds);
	}

	public int pickCheck(Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.pickCheck", map);
	}

	public int updateReadCount(int boardNo) {
		return sqlSession.update("boardMapper.updateReadCount", boardNo);
	}

	public List<Image> selectBannerList() {
		return sqlSession.selectList("boardMapper.selectBannerList");
	}

	public int insertOrder(Order order) {
		int result = sqlSession.insert("boardMapper.insertOrder", order);
		
		if (result>0) result = order.getOrderNo();
		
		return result;
	}

	public int insertPointUsage(PointUsage usage) {
		return sqlSession.insert("boardMapper.insertPointUsage", usage);
	}

	public int updatePoint(Member loginMember) {
		return sqlSession.update("boardMapper.updatePoint", loginMember);
	}
}
