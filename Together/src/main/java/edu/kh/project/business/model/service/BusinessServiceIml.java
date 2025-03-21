package edu.kh.project.business.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.business.model.dao.BusinessDao;
import edu.kh.project.business.model.dto.Business;
import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;

@Service
public class BusinessServiceIml implements BusinessService {
	@Autowired
	private BusinessDao dao;

	@Override
	public Map<String, Object> selectBusinessList(Map<String, Object> paramMap, int cp) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Image> bannerList = dao.selectBannerList();
		map.put("bannerList", bannerList);
		
		if (paramMap.get("query")==null) {
			if (paramMap.get("category")==null) {
				List<Business> businessNewList = dao.selectBusinessList(paramMap);
				
				paramMap.put("category", "hot");
				List<Business> businessHotList = dao.selectBusinessList(paramMap);
				
				map.put("businessHotList", businessHotList);
				map.put("businessNewList", businessNewList);
			} else {
				int listCount = dao.getListCount(paramMap);
				
				Pagination pagination = new Pagination(cp, listCount);
				pagination.setLimit(9);
				
				List<Business> businessList = dao.selectBusinessList(paramMap, pagination);
				
				map.put("businessList", businessList);
				map.put("pagination", pagination);
			}
		}
		
		return map;
	}

	@Override
	public Business selectBusiness(Map<String, Object> map) {
		return dao.selectBusiness(map);
	}

	@Override
	public Map<String, Object> selectList(Map<String, Object> paramMap, int reviewCp, int replyCp) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int listCount = dao.getReviewListCount(paramMap);
		Pagination pagination = new Pagination(reviewCp, listCount);
		List<Review> reviewList = dao.selectReviewList(paramMap, pagination);
		
		map.put("reviewList", reviewList);
		map.put("reviewPagination", pagination);
		
		listCount = dao.getReplyListCount(paramMap);
		pagination = new Pagination(replyCp, listCount);
		List<Reply> replyList = dao.selectReplyList(paramMap, pagination);
		
		map.put("replyList", replyList);
		map.put("replyPagination", pagination);
		
		return map;
	}

	@Override
	public int pickCheck(Map<String, Object> map) {
		return dao.pickCheck(map);
	}

	@Override
	public int updateReadCount(int boardNo) {
		return dao.updateReadCount(boardNo);
	}

	@Override
	public Map<String, Object> selectReviewList(Map<String, Object> paramMap, int reviewCp) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int listCount = dao.getReviewListCount(paramMap);
		Pagination pagination = new Pagination(reviewCp, listCount);
		List<Review> reviewList = dao.selectReviewList(paramMap, pagination);
		
		map.put("reviewList", reviewList);
		map.put("reviewPagination", pagination);
		
		return map;
	}

	@Override
	public Map<String, Object> selectReplyList(Map<String, Object> paramMap, int replyCp) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int listCount = dao.getReplyListCount(paramMap);
		Pagination pagination = new Pagination(replyCp, listCount);
		List<Reply> replyList = dao.selectReplyList(paramMap, pagination);
		
		map.put("replyList", replyList);
		map.put("replyPagination", pagination);
		
		return map;
	}
}
