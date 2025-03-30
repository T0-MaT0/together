package edu.kh.project.business.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.business.model.dao.BusinessDao;
import edu.kh.project.business.model.dto.Business;
import edu.kh.project.business.model.dto.BusinessOption;
import edu.kh.project.business.model.dto.Order;
import edu.kh.project.common.ImageDeleteException;
import edu.kh.project.common.model.dto.Category;
import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.common.model.dto.PointUsage;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.manager.model.exception.FileUploadException;
import edu.kh.project.member.model.dto.Member;

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

	@Override
	public int insertOrder(Map<String, Object> paramMap) {
		int result = dao.insertOrder((Order)paramMap.get("order"));
		
		if (result>0) {
			Member loginMember = (Member) paramMap.get("loginMember");
			int totalPrice =  Integer.parseInt(String.valueOf(paramMap.get("totalPrice")));
			
			PointUsage usage = new PointUsage();
			usage.setUsageAmount(totalPrice);
			usage.setUsageTypeNo(result);
			usage.setMemberNo(loginMember.getMemberNo());
			result = dao.insertPointUsage(usage);
			
			if (result>0) {
				loginMember.setPoint(loginMember.getPoint()-totalPrice);
				result = dao.updatePoint(loginMember);
			}
		}
		
		return result;
	}

	@Override
	public PointUsage selectUsage(int orderNo) {
		return dao.selectUsage(orderNo);
	}

	@Override
	public Order selectOrder(Map<String, Object> map) {
		return dao.selectOrder(map);
	}

	@Override
	public int insertReview(Review review, List<MultipartFile> images, String webPath, String filePath,
			List<Image> existingImages, int reviewUpdateNo, String deleteList) throws IllegalStateException, IOException {
		review.setReviewContent(Utill.XSSHandling(review.getReviewContent()));
		
		int reviewNo = 0;
		if (reviewUpdateNo==0) {
			reviewNo = dao.insertReview(review);
		} else {
			review.setReviewNo(reviewUpdateNo);
			reviewNo = dao.updateReview(review);
		}
		
		if (reviewNo>0) {
			List<Image> uploadList = new ArrayList<Image>();
			if (reviewUpdateNo==0) {
				for (int i=0;i<images.size();i++) {
					if (images.get(i).getSize()>0) {
						Image img = new Image();
						String fileName = images.get(i).getOriginalFilename();
						img.setImagePath(webPath);
						img.setImageReName(Utill.fileRename(fileName));
						img.setImageOriginal(fileName);
						img.setImageLevel(i);
						img.setImageType(3);
						img.setImageTypeNo(reviewNo);
						
						uploadList.add(img);
					}
				}
				
				if (!uploadList.isEmpty()) {
					int result = dao.insertImageList(uploadList);
					if (result==uploadList.size()) {
						for (Image img:uploadList) {
							int i = img.getImageLevel();
							String rename = img.getImageReName();
							images.get(i).transferTo(new File(filePath+rename));
						}
					} else {
						throw new  FileUploadException();
					}
				}
			} else {
				int result = 0;
				List<Image> imageList = dao.selectReviewImageList(reviewUpdateNo);
				
				if (!deleteList.isEmpty()) {
				    String[] deleteArr = deleteList.split(",");
				    for (String del : deleteArr) {
				        int levelToDelete = Integer.parseInt(del);
				        for (Image img : imageList) {
				            if (img.getImageLevel() == levelToDelete) {
				                result = dao.deleteImage(img.getImageNo());
				                if (result <= 0) {
				                    throw new RuntimeException("이미지 삭제 실패: 이미지 번호 " + img.getImageNo());
				                }
				            }
				        }
				    }
				}
				
				for (int i = 0; i < existingImages.size(); i++) {
				    Image existingImage = existingImages.get(i);
				    for (Image img : imageList) {
				        // 기존 이미지 번호와 레벨이 일치하지 않으면 수정
				        if (img.getImageNo() == existingImage.getImageNo() && img.getImageLevel() != existingImage.getImageLevel()) {
				            Image image = new Image();
				            image.setImageLevel(i);  // 새로 받은 레벨로 설정
				            image.setImageNo(img.getImageNo());
				            result = dao.updateImageLevel(image);
				            if (result <= 0) {
				                throw new RuntimeException("이미지 레벨 수정 실패: 이미지 번호 " + img.getImageNo());
				            }
				        }
				    }
				}
				
				for (int i = 0; i < images.size(); i++) {
				    if (images.get(i).getSize() > 0) {
				        Image img = new Image();
				        String fileName = images.get(i).getOriginalFilename();
				        img.setImagePath(webPath);
				        img.setImageReName(Utill.fileRename(fileName));
				        img.setImageOriginal(fileName);
				        img.setImageLevel(i);  // 레벨 설정
				        img.setImageType(3);   // 리뷰 이미지 타입
				        img.setImageTypeNo(reviewUpdateNo);

				        uploadList.add(img);
				    }
				}
				if (!uploadList.isEmpty()) {
				    result = dao.insertImageList(uploadList);
				    if (result == uploadList.size()) {
				        for (Image img : uploadList) {
				            int i = img.getImageLevel();
				            String rename = img.getImageReName();
				            images.get(i).transferTo(new File(filePath + rename));
				        }
				    } else {
				        throw new FileUploadException();
				    }
				}
			}
		}
		return reviewNo;
	}

	@Override
	public int insertReply(Reply reply) {
		return dao.insertReply(reply);
	}

	@Override
	public Review selectReview(int reviewNo) {
		return dao.selectReview(reviewNo);
	}

	@Override
	public int deleteReview(int reviewNo) {
		return dao.deleteReview(reviewNo);
	}

	@Override
	public int insertReviewReply(Reply reply) {
		reply.setReplyContent(Utill.XSSHandling(reply.getReplyContent()));
		return dao.insertReviewReply(reply);
	}
	
	@Override
	public int updateReviewReply(Reply reply) {
		reply.setReplyContent(Utill.XSSHandling(reply.getReplyContent()));
		return dao.updateReviewReply(reply);
	}
	
	@Override
	public int deleteReviewReply(Reply reply) {
		return dao.deleteReviewReply(reply);
	}
	
	@Override
	public int updateReply(Reply reply) {
		reply.setReplyContent(Utill.XSSHandling(reply.getReplyContent()));
		return dao.updateReply(reply);
	}
	
	@Override
	public int deleteReply(Reply reply) {
		return dao.deleteReply(reply);
	}

	@Override
	public Reply selectReply(int replyNo) {
		return dao.selectReply(replyNo);
	}

	@Override
	public List<Category> selectCategoryList() {
		return dao.selectCategoryList();
	}

	@Override
	public String selectPermissionFl(int memberNo) {
		return dao.selectPermissionFl(memberNo);
	}

	@Override
	public int insertProduct(
			Business business, List<String> optionNameList, 
			List<MultipartFile> images, String webPath, String filePath, 
			Business board, String permissionFl) throws IllegalStateException, IOException {
		business.setBoardTitle(Utill.XSSHandling(business.getBoardTitle()));
		business.setBoardContent(Utill.XSSHandling(business.getBoardContent()));
		int boardNo = dao.insertBoard(business);
		
		if (boardNo>0) {
			int result = dao.insertProduct(business);
			if (result>0) {
				boardNo = business.getBoardNo();
				List<BusinessOption> optionList = new ArrayList<BusinessOption>();
				for(int i=0;i<optionNameList.size();i++) {
					BusinessOption option = new BusinessOption();
					option.setOptionName(Utill.XSSHandling(optionNameList.get(i)));
					option.setBoardNo(boardNo);
					optionList.add(option);
				}
				
				result = dao.insertOptionList(optionList);
				if (result>0) {
					List<Image> uploadList = new ArrayList<Image>();
					for (int i=0;i<images.size();i++) {
						if (images.get(i).getSize()>0) {
							Image img = new Image();
							String fileName = images.get(i).getOriginalFilename();
							img.setImageReName(Utill.fileRename(fileName));
							img.setImagePath(webPath);
							img.setImageOriginal(fileName);
							img.setImageLevel(i);
							img.setImageType(1);
							img.setImageTypeNo(boardNo);
							
							uploadList.add(img);
						}
					}
					
					if (!uploadList.isEmpty()) {
						result = dao.insertImageList(uploadList);
						if (result==uploadList.size()) {
							for (Image img:uploadList) {
								int i = img.getImageLevel();
								String rename = img.getImageReName();
								images.get(i).transferTo(new File(filePath+rename));
							}
							if (permissionFl.equals("N")) {
								board.setBoardTitle(Utill.XSSHandling(board.getBoardContent()));
								board.setBoardContent(Utill.XSSHandling(board.getBoardContent()));
								result = dao.insertBoard(board);
								if (result==0) {
									boardNo=0;
								}
							}
						} else {
							throw new  FileUploadException();
						}
					}
				}
			}
		}
		return boardNo;
	}

	@Override
	public int deleteProduct(Business business) {
		return dao.deleteProduct(business);
	}
	
	@Override
	public int updateProduct(
			Business business, List<Integer> optionNoList, List<String> optionNameList, List<MultipartFile> images, 
			String deleteList, String webPath, String filePath) throws IllegalStateException, IOException {
		business.setBoardTitle(Utill.XSSHandling(business.getBoardTitle()));
		business.setBoardContent(Utill.XSSHandling(business.getBoardContent()));
		int result = dao.updateBoard(business);
		
		if (result>0) {
			result = dao.updateProduct(business);
			if (result>0) {
				List<BusinessOption> existingOptions = dao.selectOptionList(business.getBoardNo());
				
				Set<Integer> existingOptionNos = new HashSet<Integer>();
				Map<Integer, String> existingOptionMap = new HashMap<Integer, String>();
				
				if (existingOptions!=null) {
					for (BusinessOption option:existingOptions) {
						existingOptionNos.add(option.getOptionNo());
						existingOptionMap.put(option.getOptionNo(), option.getOptionName());
					}
				}

				for (BusinessOption option:existingOptions) {
					if (!optionNoList.contains(option.getOptionNo())) {
						result = dao.deleteOption(option.getOptionNo());
					}
				}
				if (result>0) {
					List<BusinessOption> newOptions = new ArrayList<BusinessOption>();
					
					for (int i=0;i<optionNoList.size();i++) {
						int optionNo = optionNoList.get(i);
						String optionName = Utill.XSSHandling(optionNameList.get(i));
						
						if (existingOptionNos.contains(optionNo)) {
							if (!existingOptionMap.get(optionNo).equals(optionName)) {
								BusinessOption updateOption = new BusinessOption();
								updateOption.setOptionNo(optionNo);
								updateOption.setOptionName(optionName);
								result = dao.updateOption(updateOption);
							}
						} else {
							BusinessOption newOption = new BusinessOption();
							newOption.setOptionName(optionName);
							newOption.setBoardNo(business.getBoardNo());
							newOptions.add(newOption);
						}
					}
					
					if (result>0&&!newOptions.isEmpty()) {
						result = dao.insertOptionList(newOptions);
					}
				}
				
				if (result>0) {
					if (!deleteList.equals("")) {
						if (images.get(0).getSize()>0&&!images.get(0).getOriginalFilename().isEmpty()) {
							deleteList="0,"+deleteList;
						}
						Map<String, Object> deleteMap = new HashMap<String, Object>(); 
						deleteMap.put("imageType", 1);
						deleteMap.put("imageTypeNo", business.getBoardNo());
						deleteMap.put("deleteList", deleteList);
						
						int count = dao.checkImage(deleteMap);
						if (count>0) {
							result = dao.deleteBusinessImage(deleteMap);
							if (result==0) {
								throw new ImageDeleteException();
							}
						}
					}
					
					List<Image> uploadList = new ArrayList<Image>();
					for (int i=0;i<images.size();i++) {
						if (images.get(i).getSize()>0) {
							Image img = new Image();
							String fileName = images.get(i).getOriginalFilename();
							img.setImageReName(Utill.fileRename(fileName));
							img.setImagePath(webPath);
							img.setImageOriginal(fileName);
							img.setImageLevel(i);
							img.setImageType(1);
							img.setImageTypeNo(business.getBoardNo());
							
							uploadList.add(img);
							result = dao.updateImage(img);
							if (result==0) {
								result=dao.insertImage(img);
							}
						}
					}
					
					if (!uploadList.isEmpty()) {
						for (Image img:uploadList) {
							int i = img.getImageLevel();
							String rename = img.getImageReName();
							images.get(i).transferTo(new File(filePath+rename));
						}
					}
				}
			}
		}
		return result;
	}
}
