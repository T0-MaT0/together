package edu.kh.project.business.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.business.model.dto.Business;
import edu.kh.project.business.model.dto.BusinessOption;
import edu.kh.project.business.model.dto.Order;
import edu.kh.project.common.model.dto.Category;
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

	public PointUsage selectUsage(int orderNo) {
		return sqlSession.selectOne("boardMapper.selectUsage", orderNo);
	}

	public Order selectOrder(Map<String, Object> map) {
		return sqlSession.selectOne("boardMapper.selectOrder", map);
	}

	public int insertReview(Review review) {
		int result = sqlSession.insert("boardMapper.insertReview", review);
		
		if (result>0) result=review.getReviewNo();
		
		return result;
	}

	public int insertImageList(List<Image> uploadList) {
		return sqlSession.insert("boardMapper.insertImageList", uploadList);
	}

	public int insertReply(Reply reply) {
		return sqlSession.insert("boardMapper.insertReply", reply);
	}

	public Review selectReview(int reviewNo) {
		return sqlSession.selectOne("boardMapper.selectReview", reviewNo);
	}

	public int updateReview(Review review) {
		return sqlSession.update("boardMapper.updateReview", review);
	}

	public List<Image> selectReviewImageList(int reviewUpdateNo) {
		return sqlSession.selectList("boardMapper.selectReviewImageList", reviewUpdateNo);
	}

	public int deleteImage(int imageNo) {
		return sqlSession.delete("boardMapper.deleteImage", imageNo);
	}

	public int updateImageLevel(Image img) {
		return sqlSession.update("boardMapper.updateImageLevel", img);
	}

	public int deleteReview(int reviewNo) {
		return sqlSession.update("boardMapper.deleteReview", reviewNo);
	}

	public int insertReviewReply(Reply reply) {
		return sqlSession.insert("boardMapper.insertReviewReply", reply);
	}

	public int updateReviewReply(Reply reply) {
		return sqlSession.update("boardMapper.updateReviewReply", reply);
	}
	
	public int deleteReviewReply(Reply reply) {
		return sqlSession.update("boardMapper.deleteReviewReply", reply);
	}
	
	public int updateReply(Reply reply) {
		return sqlSession.update("boardMapper.updateReply", reply);
	}
	
	public int deleteReply(Reply reply) {
		return sqlSession.update("boardMapper.deleteReply", reply);
	}

	public Reply selectReply(int replyNo) {
		return sqlSession.selectOne("boardMapper.selectReplyComment", replyNo);
	}

	public List<Category> selectCategoryList() {
		return sqlSession.selectList("boardMapper.selectCategoryList");
	}

	public String selectPermissionFl(int memberNo) {
		return sqlSession.selectOne("boardMapper.selectPermissionFl", memberNo);
	}

	public int insertBoard(Business business) {
		return sqlSession.insert("boardMapper.insertBoard", business);
	}

	public int insertProduct(Business business) {
		return sqlSession.insert("boardMapper.insertProduct", business);
	}

	public int insertOptionList(List<BusinessOption> optionList) {
		return sqlSession.insert("boardMapper.insertOptionList", optionList);
	}

	public int deleteProduct(Business business) {
		return sqlSession.update("boardMapper.deleteProduct", business);
	}

	public int updateBoard(Business business) {
		return sqlSession.update("boardMapper.updateBoard", business);
	}

	public int updateProduct(Business business) {
		return sqlSession.update("boardMapper.updateProduct", business);
	}

	public List<BusinessOption> selectOptionList(int boardNo) {
		return sqlSession.selectList("boardMapper.selectOptionList", boardNo);
	}

	public int updateOption(BusinessOption updateOption) {
		return sqlSession.update("boardMapper.updateOption", updateOption);
	}

	public int checkImage(Map<String, Object> deleteMap) {
		return sqlSession.selectOne("boardMapper.checkImage", deleteMap);
	}

	public int deleteBusinessImage(Map<String, Object> deleteMap) {
		return sqlSession.delete("boardMapper.deleteBusinessImage" ,deleteMap);
	}

	public int updateImage(Image img) {
		return sqlSession.update("boardMapper.updateImage", img);
	}

	public int insertImage(Image img) {
		return sqlSession.update("boardMapper.insertImage", img);
	}
}
