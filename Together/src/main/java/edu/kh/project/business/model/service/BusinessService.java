package edu.kh.project.business.model.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.business.model.dto.Business;
import edu.kh.project.business.model.dto.Order;
import edu.kh.project.common.model.dto.Category;
import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.PointUsage;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;

public interface BusinessService {
	Map<String, Object> selectBusinessList(Map<String, Object> paramMap, int cp);

	Business selectBusiness(Map<String, Object> map);

	Map<String, Object> selectList(Map<String, Object> paramMap, int reviewCp, int replyCp);

	int pickCheck(Map<String, Object> map);

	int updateReadCount(int boardNo);

	Map<String, Object> selectReviewList(Map<String, Object> paramMap, int reviewCp);

	Map<String, Object> selectReplyList(Map<String, Object> paramMap, int replyCp);

	int insertOrder(Map<String, Object> paramMap);

	PointUsage selectUsage(int orderNo);

	Order selectOrder(Map<String, Object> map);

	int insertReview(Review review, List<MultipartFile> images, String webPath, String filePath,
			List<Image> existingImages, int reviewUpdateNo, String deleteList) throws IllegalStateException, IOException;

	int insertReply(Reply reply);

	Review selectReview(int reviewNo);

	int deleteReview(int reviewNo);

	int insertReviewReply(Reply reply);

	int updateReviewReply(Reply reply);

	int deleteReviewReply(Reply reply);

	int updateReply(Reply reply);

	int deleteReply(Reply reply);

	Reply selectReply(int replyNo);

	List<Category> selectCategoryList();

	String selectPermissionFl(int memberNo);

	int insertProduct(Business business, List<String> optionNameList, List<MultipartFile> images, String webPath, String filePath, Business board, String permissionFl) throws IllegalStateException, IOException;

	int deleteProduct(Business business);

	int updateProduct(Business business, List<Integer> optionNoList, List<String> optionNameList, List<MultipartFile> images, 
			String deleteList, String webPath, String filePath) throws IllegalStateException, IOException;

	int pick(Map<String, Integer> paramMap);
}
