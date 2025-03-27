package edu.kh.project.manager.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.manager.model.dao.BrandDAO;
import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.BrandProfile;
import edu.kh.project.manager.model.dto.BrandProfileBoard;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.manager.model.dto.Report;

@Service
public class BrandServiceImpl implements BrandService {
	@Autowired
	private BrandDAO dao;


	//상품 리스트 목록 조회
	@Override
	public Map<String, Object> goods(int cp) {
		int listCount = dao.goodsCount();

		Pagination pagination = new Pagination(cp, listCount);

		List<QuestCustomer> goodsList = dao.goodsList(pagination);

		int goodsBoardCount = dao.goodsBoardCount();
		List<Map<String, Object>> goodsStateCount = dao.goodsStateCount();


		Map<String, Object> map = new HashMap<String, Object>();
		map.put("goodsList", goodsList);
		map.put("pagination", pagination);
		map.put("goodsBoardCount", goodsBoardCount);
		map.put("goodsStateCount", goodsStateCount);

		return map;
	}

	// 신고 리스트 목록 조회
	@Override
	public Map<String, Object> report(int cp) {
		int listCount = dao.reportCount();

		Pagination pagination = new Pagination(cp, listCount);

		List<QuestCustomer> reportList = dao.reportList(pagination);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reportList", reportList);
		map.put("pagination", pagination);

		return map;
	}

	//제휴 문의 목록 조회
	@Override
	public Map<String, Object> apply(int cp) {
		int listCount = dao.applyCount();

		Pagination pagination = new Pagination(cp, listCount);

		List<QuestCustomer> applyList = dao.applyList(pagination);

		List<Map<String, Object>> applyStateCount = dao.applyStateCount();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("applyList", applyList);
		map.put("pagination", pagination);
		map.put("listCount", listCount);
		map.put("applyStateCount", applyStateCount);

		return map;
	}

	// 광고 신청 목록 조회
	@Override
	public Map<String, Object> promotion(int cp) {
		int listCount = dao.promotionCount();

		Pagination pagination = new Pagination(cp, listCount);

		List<QuestCustomer> promotionList = dao.promotionList(pagination);

		List<Map<String, Object>> promStateCount = dao.promStateCount();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("promotionList", promotionList);
		map.put("pagination", pagination);
		map.put("listCount", listCount);
		map.put("promStateCount", promStateCount);

		return map;
	}

	// 데이터 성고 목록 조회
	@Override
	public Map<String, Object> dataLook(int cp) {
		int listCount = dao.dataLookCount();

		Pagination pagination = new Pagination(cp, listCount);

		List<QuestCustomer> dataLookList = dao.dataLookList(pagination);

		List<Map<String, Object>> dataRank = dao.dataRank();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dataLookList", dataLookList);
		map.put("pagination", pagination);
		map.put("dataRank", dataRank);

		return map;
	}



	
	// report detail ajax
	@Override
	public Report reportDetailSelect(int reportNo) {
		return dao.reportDetailSelect(reportNo);
	}

	
	// 제휴 문의 상세 조회 ajax
	@Override
	public BrandBoard boardDetailSelect(Map<String, Object> map) {
		return dao.boardDetailSelect(map);
	}

	// Brand Profile
	@Override
	public BrandProfile brandProfile(int memberNo) {
		
		return dao.brandProfileSelect(memberNo);
	}
	
	//브랜드 프로필 게시판 조회
	@Override
	public Map<String, Object> profileBoardList(int cp, int boardCode, int memberNo) {
		int listCount = dao.brandProfileBoardCount(boardCode, memberNo);
		Pagination pagination = new Pagination(cp, listCount);
		
		List<BrandProfileBoard> boardList = dao.brandProfileProducts(pagination, boardCode, memberNo);
		
		System.out.println(boardList);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("boardList", boardList);
		
		
		
		return map;
	}

	
	// update insert
	
	
	// 브랜드 제휴 답변 처리
	@Override
	public int applySubmit(BrandBoard brandBoard) {
		
		brandBoard.setReply(Utill.XSSHandling(brandBoard.getReply()));
		
		int result =  dao.applyUpdate(brandBoard);
		
		if("승인".equals(brandBoard.getState())) {
			result = dao.applyAccept(brandBoard);
			System.out.println("제휴 승인 처리 result: "+ result );
		}
		
		result = dao.applyInsert(brandBoard);
		
		return result;
	}

	
	//브랜드 신고 처리
	@Override
	public int reportSubmit(Report report) {
		
		report.setReply(Utill.XSSHandling(report.getReply()));
		
		int result = 0;
			
			
		if("반려".equals(report.getReportStatus())||"경고".equals(report.getReportStatus())) { // 반려 경고
			
			result = dao.reportUpdate(report);
			
			int personWarnCount = dao.personWarnCount(report);
			
			if(personWarnCount >=4) {
				report.setReportStatus("블랙");
			}
			
		}
			
			
		if("블랙".equals(report.getReportStatus())) {
			result = dao.reportUpdate(report);
			result = dao.blackUpdate(report);
			
			result = dao.companyBlackUpdate(report);
			
		}
		
		
		return result;
	}

	//브랜드 프로필 조회
	@Override
	public BrandProfile profile(int memberNo) {
		return dao.profile(memberNo);
	}

	@Override
	public List<BrandProfile> infoList(int memberNo, int boardCode) {
		return dao.infoList(memberNo, boardCode);
	}

	@Override
	public Report infoDetail(int reportNo) {
		return dao.infoDetail(reportNo);
	}
	
	// 브랜드 광고 이미지 조회
	@Override
	public List<Image> promotionImageSelect(int no) {
		return dao.promotionImageSelect(no);
	}

	// 광고 이미지 제출 처리
	@Override
	public int promotionApproval( Map<String, Object> requestData) {
		
		int result = dao.promotionBoardUpdate(requestData);
		System.out.println("광고 성공?"+result);
		
		if(requestData.get("state").equals("승인")) {
			System.out.println("이미지 update!");
			result = dao.promotionImageUpdate(requestData);
		}
		
		
		return result;
	}


}

