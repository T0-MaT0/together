package edu.kh.project.individual.service;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import edu.kh.project.common.model.dto.PointHistory;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.individual.dao.RecruitmentDAO;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.member.model.dto.Member;

@Service
public class RecruitmentServiceImpl implements RecruitmentService{

	@Autowired
	private RecruitmentDAO dao;

	// 공동구매 모집방 목록 조회.
	@Override
	public List<Recruitment> selectRecruitmentList(int memberNo) {
	    List<Recruitment> recruitments = dao.selectRecruitmentList(memberNo);
	    List<Image> bannerImages = dao.selectAllBannerImages();

	    // 메인 배너 조회 
	    List<Image> mainBannerList = new ArrayList<>();
	    for (Image img : bannerImages) {
	        if ("AD_BANNER".equals(img.getImageType()) && img.getImageTypeNo() == 2) {
	            mainBannerList.add(img);
	        }
	    }

	    // 참가자 수 조회
	    for (Recruitment recruitment : recruitments) {
	        int currentParticipants = dao.countParticipants(recruitment.getRecruitmentNo());
	        recruitment.setCurrentParticipants(currentParticipants);
	        recruitment.setImageList(bannerImages);
	        recruitment.setMainBannerList(mainBannerList);
	    }
	    return recruitments;
	}

	// 개인 공동구매 모집방 페이지(조회수순).
	@Override
	public List<Recruitment> selectRecruitmentListByViewCount(int memberNo) {
	    List<Recruitment> recruitments = dao.selectRecruitmentListByViewCount(memberNo);
	    List<Image> bannerImages = dao.selectAllBannerImages();
	      
	    // 메인 배너 조회 
	    List<Image> mainBannerList = new ArrayList<>();
	    for (Image img : bannerImages) {
	        if ("AD_BANNER".equals(img.getImageType()) && img.getImageTypeNo() == 2) {
	            mainBannerList.add(img);
	        }
	    }
	      
	    // 참가자 수 설정
	    for (Recruitment recruitment : recruitments) {
	        int currentParticipants = dao.countParticipants(recruitment.getRecruitmentNo());
	        recruitment.setCurrentParticipants(currentParticipants);
	        recruitment.setImageList(bannerImages);
	        recruitment.setMainBannerList(mainBannerList);
	    }

	    return recruitments;
	}

	// 내 모집 중 현황 조회.
	@Override
	public List<Recruitment> getMyRecruitmentList(int memberNo, String key) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("member_no", memberNo);
	    paramMap.put("key", key);
	    return dao.selectMyRecruitmentList(paramMap);
	}

	// 내 댓글 조회.
	@Override
	public List<Reply> getMyRecruitmentComments(int memberNo) {
		return dao.selectMyRecruitmentComments(memberNo);
	}

	// 내 리뷰 조회.
	@Override
	public List<Review> getMyRecruitmentReviews(int memberNo) {
		return dao.selectMyRecruitmentReviews(memberNo);
	}
	
	// 조회수 증가.
	@Override
	public void increaseReadCount(int recruitmentNo) {
		dao.increaseReadCount(recruitmentNo);
		
	}

	// 모집방 상세 내용 조회.
	@Override
	public Recruitment selectRecruitmentRoomDetail(int recruitmentNo, int memberNo) {
	    Recruitment recruitment = dao.selectRecruitmentRoomDetail(recruitmentNo, memberNo);

	    if (recruitment != null) {
	    	// 현재 참가자 수 조회.
	        int currentParticipants = dao.countParticipants(recruitmentNo);
	        recruitment.setCurrentParticipants(currentParticipants);
	        
	        // 내가 차지한 수량 조회
	        int myCount = dao.selectMyParticipationCount(recruitmentNo, memberNo);
	        recruitment.setMyParticipationCount(myCount);
	    }

	    return recruitment;
	}

	// 모집글 작성.
	@Override
	@Transactional(rollbackFor=Exception.class)
	public int createRecruitment(Recruitment dto, List<MultipartFile> images, int memberNo, String webPath,
	        String filePath) throws Exception {

	    // 1) PRODUCT 테이블 INSERT
	    Recruitment product = new Recruitment();
	    product.setProductTitle(dto.getProductTitle());
	    product.setProductContent(dto.getProductContent());
	    product.setProductPrice(dto.getProductPrice());
	    product.setProductCount(dto.getProductCount());
	    product.setCategoryNo(dto.getCategoryNo());
	    product.setMemberNo(memberNo);
	    int productResult = dao.insertProduct(product);
	    if(productResult <= 0) throw new Exception("Product 삽입 실패");

	    // 2) RECRUITMENT_ROOM 테이블 INSERT
	    Recruitment room = new Recruitment();
	    room.setMaxParticipants(dto.getMaxParticipants());
	    room.setRegion(dto.getRegion());
	    room.setProductUrl(dto.getProductUrl());
	    room.setRecEndDate(dto.getRecEndDate());
	    room.setMemberNo(memberNo);
	    room.setProductNo(product.getProductNo());
	    int recruitNo = dao.insertRecruitmentRoom(room);
	    if(recruitNo <= 0) throw new Exception("RecruitmentRoom 삽입 실패");

	    // 3) 방장 참가자 등록
	    Recruitment part = new Recruitment();
	    part.setMemberNo(memberNo);
	    part.setRecruitmentNo(recruitNo);
	    part.setMyQuantity(dto.getMyQuantity());
	    int partResult = dao.insertParticipant(part);
	    if(partResult <= 0) throw new Exception("Participant 삽입 실패");

	    // 4) 이미지 업로드 -> IMG 테이블
	    if(images != null && !images.isEmpty()){
	        List<Image> uploadList = new ArrayList<>();

	        for(int i=0; i<images.size(); i++){
	            MultipartFile file = images.get(i);
	            if(file != null && file.getSize()>0){
	                String original = file.getOriginalFilename();
	                String rename = Utill.fileRename(original);

	                Image img = new Image();
	                img.setImagePath(webPath); 
	                img.setImageOriginal(original);
	                img.setImageReName(rename);
	                img.setImageType("RECRUITMENT");
	                img.setImageTypeNo(recruitNo);
	                img.setImageLevel(i == 0 ? 0 : 1);

	                uploadList.add(img);
	            }
	        }

	        if(!uploadList.isEmpty()){
	            int insertCount = dao.insertImgList(uploadList);
	            if(insertCount != uploadList.size()){
	                throw new Exception("이미지 일부 삽입 실패");
	            }

	            File directory = new File(filePath);
	            if (!directory.exists()) {
	                directory.mkdirs();
	            }

	            for(int i=0; i<uploadList.size(); i++){
	                MultipartFile file = images.get(i);
	                file.transferTo(new File(filePath + uploadList.get(i).getImageReName()));
	            }
	        }
	    }

	    return recruitNo;
	}
	
	// 포인트 수정.
	@Override
	public void updateMemberPoint(int memberNo, int updatedPoint) {
		Map<String, Object> map = new HashMap<>();
	    map.put("updatedPoint", updatedPoint);
	    map.put("memberNo", memberNo);
		dao.updateMemberPoint2(map);
		
	}
	
	// 포인트 사용 내역 인서트.
	@Override
	public void insertPointUsage(PointHistory pointHistory) {
		dao.insertPointUsage(pointHistory);		
	}

	// 모집글 수정.
	@Override
    @Transactional(rollbackFor = Exception.class)
	public int updateRecruitment(Map<String, Object> paramMap, List<MultipartFile> imageList) throws Exception{
        int recruitmentNo = Integer.parseInt(paramMap.get("recruitmentNo").toString());

        // 1. 모집방 정보 수정
        int result = dao.updateRecruitment(paramMap);
        if (result <= 0) throw new Exception("RECRUITMENT_ROOM 업데이트 실패");

        // 2. 상품 정보 수정
        result = dao.updateProduct(paramMap);
        if (result <= 0) throw new Exception("PRODUCT 업데이트 실패");

        // 3. 내 참여 수량 수정
        result = dao.updateMyQuantity(paramMap);
        if (result <= 0) throw new Exception("RECRUITMENT_PARTICIPANT 수량 수정 실패");

        // 4. 이미지 삭제
        String deleteList = (String) paramMap.get("deleteList");
        if (deleteList != null && !deleteList.isEmpty()) {
            String[] deleteImgNos = deleteList.split(",");
            for (String imgNoStr : deleteImgNos) {
                int imgNo = Integer.parseInt(imgNoStr.trim());
                Image img = dao.selectImageInfo(imgNo);
                if (img != null) {
                    File file = new File("C:/finalProject/Together/src/main/webapp" + img.getImagePath() + img.getImageReName());
                    if (file.exists()) file.delete();
                }
                dao.deleteImage(imgNo);
            }
        }

        // 5. 이미지 등록
        if (imageList != null && !imageList.isEmpty()) {
            String webPath = "/resources/images/recruitment/";
            String filePath = "C:/finalProject/Together/src/main/webapp" + webPath;

            File dir = new File(filePath);
            if (!dir.exists()) dir.mkdirs();

            for (int i = 0; i < imageList.size(); i++) {
                MultipartFile file = imageList.get(i);
                if (file != null && file.getSize() > 0) {
                    String origin = file.getOriginalFilename();
                    String rename = Utill.fileRename(origin);

                    Image image = new Image();
                    image.setImageReName(rename);
                    image.setImagePath(webPath);
                    image.setImageOriginal(origin);
                    image.setImageLevel(i == 0 ? 0 : 1);
                    image.setImageType("RECRUITMENT");
                    image.setImageTypeNo(recruitmentNo);

                    dao.insertImage(image);

                    file.transferTo(new File(filePath + rename));
                }
            }
        }

        return result;
    }

	// 참여 폼 제출.
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int participateRecruitment(int memberNo, int recruitmentNo, int myQuantity, int paymentAmount, int point) throws Exception {

	    if (point < paymentAmount) {
	        throw new IllegalArgumentException("포인트가 부족합니다."); // 예외 던져서 롤백
	    }
		
		// 1. 포인트 차감
	    Map<String, Object> pointMap = new HashMap<>();
	    pointMap.put("memberNo", memberNo);
	    pointMap.put("pointChange", -paymentAmount); 

	    int result = dao.updateMemberPoint(pointMap);
	    if (result <= 0) throw new Exception("포인트 차감 실패");

	    // 2. RECRUITMENT_PARTICIPANT 테이블에 insert
	    Map<String, Object> participantMap = new HashMap<>();
	    participantMap.put("memberNo", memberNo);
	    participantMap.put("recruitmentNo", recruitmentNo);
	    participantMap.put("myQuantity", myQuantity);

	    result = dao.insertRecruitmentParticipant(participantMap);
	    if (result <= 0) throw new Exception("참여 insert 실패");

	    // 3. 현재 총 참여 인원 조회
	    int currentParticipants = dao.countParticipants(recruitmentNo);
	    // 4. 최대 인원 조회
	    int maxParticipants = dao.selectMaxParticipants(recruitmentNo);
	    // 5. 마감 조건 확인
	    if (currentParticipants >= maxParticipants) {
	        dao.updateRecruitmentStatusToClosed(recruitmentNo);
	    }
	    
	    // 6. 포인트 사용 내역 기록
	    PointHistory history = new PointHistory();
	    history.setPointAmount(paymentAmount);
	    history.setUsageDetail("대기");
	    history.setPointType("RECRUITMENT");
	    history.setPointTypeNo(recruitmentNo);
	    history.setMemberNo(memberNo);

	    dao.insertPointUsage(history);

	    return 1;
	}
	
	// 현재 포인트 조회.
	@Override
	public int selectMemberPoint(int memberNo) {
		return dao.selectMemberPoint(memberNo);
	}
	
	// 후기 작성 여부.
	@Override
	public boolean checkIfUserReviewed(int recruitmentNo, int memberNo) {
		
		Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("memberNo", memberNo);
	    
		return dao.checkIfUserReviewed(map);
	}
	
	// 포인트 사용 내역 조회.
	@Override
	public int selectUsedAmount(int recruitmentNo, int memberNo, String usageType) {
		Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("memberNo", memberNo);
	    map.put("usageType", usageType);
		return dao.selectUsedAmount(map);
	}
	
	// POINT_USAGE 상태 '취소'로 변경.
	@Override
	public void updatePointUsageStatusToCancel(int recruitmentNo, int memberNo, String usageType) {
		Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("memberNo", memberNo);
	    map.put("usageType", usageType);
		
	    dao.updatePointUsageStatusToCancel(map);
	}

	// 모집글 삭제.
	@Override
	public int softDeleteRecruitment(int recruitmentNo) {
		return dao.softDeleteRecruitment(recruitmentNo);
	}
	
	// 모집장이 모집 마감.
	@Override
	public int updateRecruitmentStatusToClosed(int recruitmentNo) {
		return dao.updateRecruitmentStatus(recruitmentNo);
	}
	
	// 모집 인증 폼 만들기.
	@Override
	public int registerVerificationFormWithQr(int recruitmentNo, String trackingNumber, String deliveryExpected,
	                                          String memberReceiveDate, String realPath, String webPath) throws Exception {
	    // 1. 토큰 생성
	    String token = UUID.randomUUID().toString();

	    // 2. QR URL 생성
	    String qrUrl = "https://to-gether.store/recruit/verify?recruitmentNo=" + recruitmentNo + "&token=" + token;

	    // 3. QR 이미지 생성 및 저장
	    String fileName = "qr_" + recruitmentNo + "_" + System.currentTimeMillis() + ".png";
	    String imagePath = webPath + fileName;
	    String fullSavePath = realPath + fileName;

	    QRCodeWriter qrCodeWriter = new QRCodeWriter();
	    BitMatrix bitMatrix = qrCodeWriter.encode(qrUrl, BarcodeFormat.QR_CODE, 200, 200);
	    Path path = Paths.get(fullSavePath);
	    MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

	    // 4-1. 배송 정보 업데이트
	    Map<String, Object> deliveryMap = new HashMap<>();
	    deliveryMap.put("recruitmentNo", recruitmentNo);
	    deliveryMap.put("trackingNumber", trackingNumber);
	    deliveryMap.put("deliveryExpected", deliveryExpected);
	    deliveryMap.put("memberReceiveDate", memberReceiveDate);
	    int deliveryResult = dao.updateRecruitmentDelivery(deliveryMap);

	    if (deliveryResult <= 0) throw new Exception("RECRUITMENT_DELIVERY 삽입 실패");

	    // 4-2. QR 인증 테이블 업데이트
	    Map<String, Object> qrMap = new HashMap<>();
	    qrMap.put("recruitmentNo", recruitmentNo);
	    qrMap.put("qrToken", token);
	    qrMap.put("qrImagePath", imagePath);
	    int qrResult = dao.updateVerificationFormWithQr(qrMap);

	    if (qrResult <= 0) throw new Exception("QR_AUTH 삽입 실패");

	    return 1;
	}
	
	// 모집 인증 폼 수정.
	@Override
	public int updateVerificationForm(int recruitmentNo, String trackingNumber, String deliveryExpected,
			String memberReceiveDate) {
		Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("trackingNumber", trackingNumber);
	    map.put("deliveryExpected", deliveryExpected);
	    map.put("memberReceiveDate", memberReceiveDate);

	    return dao.updateVerificationForm(map);
	}
	
	// 참가 취소.
	@Override
	public int deleteParticipation(int memberNo, int recruitmentNo) {
		return dao.deleteRecruitmentParticipant(memberNo, recruitmentNo);
	}

	// 신고제출.
	@Override
	public int insertReport(Report report) {
		return dao.insertReport(report);
	}

	// 참가자 중복검사.
	@Override
	@Transactional
	public boolean verifyParticipant(int recruitmentNo, String token, int memberNo) {
		// 토큰이 유효한지 확인
        int valid = dao.checkTokenValid(recruitmentNo, token);

        if(valid > 0) {
            // 인증상태 업데이트
            dao.updateCertStatus(recruitmentNo, token, memberNo);
            return true;
        }

        return false;
    }

	// 모집장 정보 조회.
	@Override
	public Member selectHostInfo(int recruitmentNo) {
		return dao.selectHostInfo(recruitmentNo);
	}

	// 리뷰 작성.
	@Override
	public int insertReview(Review review) {
		return dao.insertReview(review);
	}

	// 구매 확정.
	@Override
	public int updatePointUsageToComplete(int recruitmentNo, int memberNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("recruitmentNo", recruitmentNo);
		map.put("memberNo", memberNo);
		return dao.updatePointUsageToComplete(map);
	}

	// 모집방 상태 변경 및 중복체크.
	@Override
	public void checkAndUpdateRecruitmentComplete(int recruitmentNo) {
		int incompleteCount = dao.selectIncompletePointUsageCount(recruitmentNo);
		
		if (incompleteCount == 0) {
			dao.updateRecruitmentStatusToComplete(recruitmentNo);
		}
		
	}

	// 맴버 등급 업데이트.
	@Override
	public void updateMemberGradeByReview(int memberNo) {
		dao.updateMemberGradeByReview(memberNo);
	}

	
}
