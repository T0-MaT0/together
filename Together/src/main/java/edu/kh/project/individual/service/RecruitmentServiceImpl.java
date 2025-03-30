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

import edu.kh.project.common.model.dto.PointUsage;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.individual.dao.RecruitmentDAO;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.individual.dto.Recruitment;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.member.model.dto.Board;
import edu.kh.project.member.model.dto.Member;

@Service
public class RecruitmentServiceImpl implements RecruitmentService{

	@Autowired
	private RecruitmentDAO dao;

	// 공동구매 모집방 목록 조회 (BOARD_CD = 1인 경우만)
    @Override
    public List<Recruitment> selectRecruitmentList(int boardCode, int memberNo) {
    	Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardCode", boardCode);
        paramMap.put("memberNo", memberNo);

        List<Recruitment> recruitments = dao.selectRecruitmentList(paramMap);
        List<Image> bannerImages = dao.selectAllBannerImages();
        
        List<Image> mainBannerList = new ArrayList<>();
        for (Image img : bannerImages) {
            if (img.getImageType() == 6 && img.getImageTypeNo() == 2) { // 메인 배너 조건
                mainBannerList.add(img); // 리스트에 추가
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

    // 개인 공동구매 모집방 상세 조회
    @Override
    public Recruitment selectRecruitmentDetail(int recruitmentNo) {
        return dao.selectRecruitmentDetail(recruitmentNo);
    }

    // 조회순 목록 조회
	@Override
	public List<Recruitment> selectRecruitmentListByViewCount(int boardCode, int memberNo) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardCode", boardCode);
        paramMap.put("memberNo", memberNo);

        List<Recruitment> recruitments = dao.selectRecruitmentListByViewCount(paramMap);
        List<Image> bannerImages = dao.selectAllBannerImages();
        
        List<Image> mainBannerList = new ArrayList<>();
        for (Image img : bannerImages) {
            if (img.getImageType() == 6 && img.getImageLevel() == 2) { // 메인 배너 조건
                mainBannerList.add(img); // 리스트에 추가
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

	// 내 모집 중 현황 조회
	@Override
	public List<Recruitment> getMyRecruitmentList(Integer memberNo, String key) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("member_no", memberNo);
	    paramMap.put("key", key);
		return dao.selectMyRecruitmentList(paramMap);
	}

	// 내 댓글 조회
	@Override
	public List<Reply> getMyRecruitmentComments(int memberNo) {
		return dao.selectMyRecruitmentComments(memberNo);
	}

	// 내가 쓴 리뷰 조회
	@Override
	public List<Review> getMyRecruitmentReviews(int memberNo) {
		return dao.selectMyRecruitmentReviews(memberNo);
	}

	// 모집방 상세 내용 조회 
	@Override
	public Recruitment selectRecruitmentRoomDetail(int recruitmentNo ,int boardNo, int memberNo) {
		  // 모집 상세 정보 조회
	    Recruitment recruitment = dao.selectRecruitmentRoomDetail(recruitmentNo, boardNo,memberNo);

	    if (recruitment != null) {
	        // 참가자 수 조회
	        int currentParticipants = dao.countParticipants(recruitmentNo);
	        recruitment.setCurrentParticipants(currentParticipants);
	        
	        // 내가 차지한 수량 조회
	        int myCount = dao.selectMyParticipationCount(recruitmentNo, memberNo);
	        recruitment.setMyParticipationCount(myCount);
	    }

	    return recruitment;
	}

	// 모집글 작성
	@Override
	@Transactional(rollbackFor=Exception.class)
	public int createRecruitment(Recruitment dto, List<MultipartFile> images, int memberNo, String webPath,
			String filePath) throws Exception{
		
		// 1) BOARD 테이블 INSERT
        Board board = new Board();
        board.setBoardTitle(dto.getBoardTitle());
        board.setBoardContent(dto.getBoardContent());
        board.setMemberNo(memberNo);     // 작성자
        board.setBoardCd(1);            // 예: 1=개인모집 게시판
        // board_del_fl='N', b_create_date=SYSDATE (기본값)

        int boardNo = dao.insertBoard(board);
        if(boardNo <= 0) throw new Exception("Board 삽입 실패");

        // 2) PRODUCT 테이블 INSERT
        Recruitment product = new Recruitment();
        product.setBoardNo(boardNo);           // FK = boardNo
        product.setProductPrice(dto.getProductPrice());
        product.setProductCount(dto.getProductCount());
        product.setDeliveryFee(dto.getDeliveryFee());
        product.setCategoryNo(dto.getCategoryNo());
        // read_count=0 default
        int productResult = dao.insertProduct(product);
        if(productResult <= 0) throw new Exception("Product 삽입 실패");

        // 3) RECRUITMENT_ROOM 테이블 INSERT
        Recruitment room = new Recruitment();
        // PK: recruitmentNo -> selectKey 방식
        room.setMaxParticipants(dto.getMaxParticipants());
        room.setRegion(dto.getRegion());
        room.setProductUrl(dto.getProductUrl());
        room.setRecEndDate(dto.getRecEndDate()); 
        room.setMemberNo(memberNo);  
        room.setBoardNo(boardNo);    
        int recruitNo = dao.insertRecruitmentRoom(room);
        if(recruitNo <= 0) throw new Exception("RecruitmentRoom 삽입 실패");

        // 4) 방장도 recruitment_participant INSERT
        Recruitment part = new Recruitment();
        part.setMemberNo(memberNo);
        part.setRecruitmentNo(recruitNo);
        part.setMyQuantity(dto.getMyQuantity());
        // joinDate=sysdate default
        int partResult = dao.insertParticipant(part);
        if(partResult <= 0) throw new Exception("Participant 삽입 실패");

        // 5) 이미지 업로드 -> IMG 테이블
        if(images != null && !images.isEmpty()){
            List<Image> uploadList = new ArrayList<>();

            for(int i=0; i<images.size(); i++){
                MultipartFile file = images.get(i);
                if(file != null && file.getSize()>0){
                    // rename
                    String original = file.getOriginalFilename();
                    String rename = Utill.fileRename(original);

                    Image img = new Image();
                    img.setImagePath(webPath); 
                    img.setImageOriginal(original);
                    img.setImageReName(rename);
                    img.setImageType(2);    // 2=개인 모집
                    img.setImageTypeNo(boardNo); // boardNo

                    // 대표 이미지(0) vs 추가 이미지(1)
                    // 첫 파일이 대표, 나머지는 1 (등등 로직)
                    img.setImageLevel(i==0 ? 0 : 1);

                    uploadList.add(img);
                }
            }
            System.out.println("uploadList : " + uploadList);
            if(!uploadList.isEmpty()){
                int insertCount = dao.insertImgList(uploadList);
                System.out.println("insertCount : " + insertCount);
                System.out.println("uploadList.size() : " + uploadList.size());
                if(insertCount != uploadList.size()){
                    throw new Exception("이미지 일부 삽입 실패");
                }
                
                File directory = new File(filePath);
                if (!directory.exists()) {
                    directory.mkdirs();
                }

                // 실제 파일 서버에 저장
                for(int i=0; i<uploadList.size(); i++){
                    int idx = uploadList.get(i).getImageLevel()==0? 0 : i; 
                    // ↑ 예시는 단순
                    // better approach: track the image order 
                    System.out.println("저장 경로: " + filePath + uploadList.get(i).getImageReName());
                    images.get(idx).transferTo(
                        new File(filePath + uploadList.get(i).getImageReName())
                    );
                }
            }
        }

        // 모든 insert 성공 -> return recruitmentNo
        return recruitNo;
    }

	// 모집글 수정
	@Override
    @Transactional(rollbackFor = Exception.class)
	public int updateRecruitment(Map<String, Object> paramMap, List<MultipartFile> imageList) throws Exception{
		int boardNo = Integer.parseInt(paramMap.get("boardNo").toString());
        int recruitmentNo = Integer.parseInt(paramMap.get("recruitmentNo").toString());
        int memberNo = Integer.parseInt(paramMap.get("memberNo").toString()); 

        // 1. 게시글 (BOARD) 테이블 업데이트
        int result = dao.updateBoard(paramMap);
        if (result <= 0) {
            throw new Exception("BOARD 테이블 업데이트 실패");
        }

        // 2. 모집방 (RECRUITMENT_ROOM) 테이블 업데이트
        result = dao.updateRecruitment(paramMap);
        if (result <= 0) {
            throw new Exception("RECRUITMENT_ROOM 테이블 업데이트 실패");
        }
        
        result = dao.updateProduct(paramMap);
        if (result <= 0) {
            throw new Exception("PRODUCT 테이블 업데이트 실패");
        }
        
        // 3. 참여 수량 업데이트
        result = dao.updateMyQuantity(paramMap);
        if (result <= 0){
            throw new Exception("RECRUITMENT_PARTICIPANT 테이블 업데이트 실패");
        }

        // 4. 기존 이미지 삭제
        String deleteList = (String) paramMap.get("deleteList");
        if (deleteList != null && !deleteList.isEmpty()) {
            String[] deleteImgNos = deleteList.split(",");
            for (String imgNoStr : deleteImgNos) {
                int imgNo = Integer.parseInt(imgNoStr.trim());

                // 1. DB에서 이미지 경로 조회
                Image img = dao.selectImageInfo(imgNo);
                if (img != null) {
                    // 2. 실제 파일 삭제
                    String filePath = "C:/finalProject/Together/src/main/webapp" + img.getImagePath() + img.getImageReName();
                    File file = new File(filePath);
                    if (file.exists()) file.delete(); // 삭제 실행
                }

                // 3. DB 삭제
                dao.deleteImage(imgNo);
            }
        }

        // 5. 새로운 이미지 삽입
        if (imageList != null && !imageList.isEmpty()) {
            String webPath = "/resources/images/recruitment/";
            String filePath = "C:/finalProject/Together/src/main/webapp/resources/images/recruitment/";
            File directory = new File(filePath);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            for (int i = 0; i < imageList.size(); i++) {
                MultipartFile file = imageList.get(i);
                if (file != null && file.getSize() > 0) {
                    String originalFileName = file.getOriginalFilename();
                    String renamedFileName = Utill.fileRename(originalFileName);

                    // Image 객체 생성 및 데이터 설정
                    Image image = new Image();
                    image.setImageReName(renamedFileName);
                    image.setImagePath(webPath);
                    image.setImageOriginal(originalFileName);
                    image.setImageLevel(i == 0 ? 0 : 1); // 대표 이미지 여부 설정
                    image.setImageType(2); // 모집 게시글 이미지 타입
                    image.setImageTypeNo(boardNo); // 해당 게시글 번호

                    dao.insertImage(image);

                    // 파일 저장
                    File dest = new File(filePath + renamedFileName);
                    file.transferTo(dest);
                }
            }
        }
		return result;
	}

	// 참여 폼 제출
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
	    System.out.println("currentParticipants : " + currentParticipants);
	    // 4. 최대 인원 조회
	    int maxParticipants = dao.selectMaxParticipants(recruitmentNo);
	    System.out.println("maxParticipants : " + maxParticipants);
	    // 5. 마감 조건 확인
	    if (currentParticipants >= maxParticipants) {
	        dao.updateRecruitmentStatusToClosed(recruitmentNo);
	    }
	    
	    // 6. 포인트 사용 내역 기록
	    Map<String, Object> usageMap = new HashMap<>();
	    usageMap.put("usedAmount", paymentAmount);
	    usageMap.put("usageType", "2"); // 공동구매
	    usageMap.put("usageTypeNo", recruitmentNo);
	    usageMap.put("status", "대기");
	    usageMap.put("memberNo", memberNo);

	    dao.insertPointUsage(usageMap);

	    return 1;
	}

	
	// 현재 포인트 조회
	@Override
	public int selectMemberPoint(int memberNo) {
		return dao.selectMemberPoint(memberNo);
	}

	// 참가 취소
	@Override
	public int deleteParticipation(int memberNo, int recruitmentNo) {
		return dao.deleteRecruitmentParticipant(memberNo, recruitmentNo);
	}

	// 모집글 삭제
	@Override
	public int softDeleteBoard(int boardNo) {
		return dao.updateBoardDelFl(boardNo);
	}

	// 모집 마감시키기
	@Override
	public int updateRecruitmentStatusToClosed(int recruitmentNo) {
		return dao.updateRecruitmentStatus(recruitmentNo);
	}


	
	// 모집 인증 폼 만들기
	@Override
	public int registerVerificationFormWithQr(int recruitmentNo, String trackingNumber, String deliveryExpected,
			String memberReceiveDate, String realPath, String webPath, int boardNo) throws Exception {
		// 1. 토큰 생성
	    String token = UUID.randomUUID().toString();

	    // 2. QR URL 생성
//	    String qrUrl = "https://www.to-gether.store/recruit/verify?recruitmentNo=" + recruitmentNo + "&token=" + token;
	    String qrUrl = "http://localhost/recruit/verify?recruitmentNo=" + recruitmentNo + "&boardNo=" + boardNo + "&token=" + token;

	    // 3. QR 이미지 생성 및 저장
	    String fileName = "qr_" + recruitmentNo + "_" + System.currentTimeMillis() + ".png";
	    String imagePath = webPath + fileName;
	    String fullSavePath = realPath + fileName;

	    QRCodeWriter qrCodeWriter = new QRCodeWriter();
	    BitMatrix bitMatrix = qrCodeWriter.encode(qrUrl, BarcodeFormat.QR_CODE, 200, 200);
	    Path path = Paths.get(fullSavePath);
	    MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

	    // 4. DB에 저장
	    Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("trackingNumber", trackingNumber);
	    map.put("deliveryExpected", deliveryExpected);
	    map.put("memberReceiveDate", memberReceiveDate);
	    map.put("qrToken", token);
	    map.put("qrImagePath", imagePath); // ← JSP에서 출력할 경로

	    return dao.updateVerificationFormWithQr(map);
	}

	// 모집 인증 폼 수정
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

	// 신고제출
	@Override
	public int insertReport(Report report) {
		return dao.insertReport(report);
	}

	// 모집장 정보 조회
	@Override
	public Member selectHostInfo(int recruitmentNo) {
		return dao.selectHostInfo(recruitmentNo);
	}

	// 리뷰 작성
	@Override
	public int insertReview(Review review) {
		return dao.insertReview(review);
	}

	// 후기 작성 여부
	@Override
	public boolean checkIfUserReviewed(int recruitmentNo, int memberNo) {
		
		Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("memberNo", memberNo);
	    
		return dao.checkIfUserReviewed(map);
	}

	// 맴버 등급 업데이트
	@Override
	public void updateMemberGradeByReview(int memberNo) {
		dao.updateMemberGradeByReview(memberNo);
		
	}

	// 구매 확정
	@Override
	public int updatePointUsageToComplete(int recruitmentNo, int memberNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("memberNo", memberNo);
		return dao.updatePointUsageToComplete(map);
	}

	// 모집방 상태 변경 및 중복체크
	@Override
	public void checkAndUpdateRecruitmentComplete(int recruitmentNo) {
		int incompleteCount = dao.selectIncompletePointUsageCount(recruitmentNo);

        if (incompleteCount == 0) {
            dao.updateRecruitmentStatusToComplete(recruitmentNo);
        }
		
	}

	// 포인트 수정
	@Override
	public void updateMemberPoint(int memberNo, int updatedPoint) {
		Map<String, Object> map = new HashMap<>();
	    map.put("updatedPoint", updatedPoint);
	    map.put("memberNo", memberNo);
		dao.updateMemberPoint2(map);
		
	}

	// 포인트 사용 내역 인서트
	@Override
	public void insertPointUsage(PointUsage pointUsage) {
		dao.insertPointUsage(pointUsage);		
	}

	// 포인트 사용 내역 조회
	@Override
	public int selectUsedAmount(int recruitmentNo, int memberNo, int usageType) {
		Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("memberNo", memberNo);
	    map.put("usageType", usageType);
		return dao.selectUsedAmount(map);
	}
	
	// POINT_USAGE 상태 '취소'로 변경
	@Override
	public void updatePointUsageStatusToCancel(int recruitmentNo, int memberNo, int usageType) {
		Map<String, Object> map = new HashMap<>();
	    map.put("recruitmentNo", recruitmentNo);
	    map.put("memberNo", memberNo);
	    map.put("usageType", usageType);
		
	    dao.updatePointUsageStatusToCancel(map);
	}


	
	
}
