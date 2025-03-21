package edu.kh.project.business.model.service;

import java.util.Map;

import edu.kh.project.business.model.dto.Business;

public interface BusinessService {
	Map<String, Object> selectBusinessList(Map<String, Object> paramMap, int cp);

	Business selectBusiness(Map<String, Object> map);

	Map<String, Object> selectList(Map<String, Object> paramMap, int reviewCp, int replyCp);

	int pickCheck(Map<String, Object> map);

	int updateReadCount(int boardNo);

	Map<String, Object> selectReviewList(Map<String, Object> paramMap, int reviewCp);

	Map<String, Object> selectReplyList(Map<String, Object> paramMap, int replyCp);

	int insertOrder(Map<String, Object> paramMap);
}
