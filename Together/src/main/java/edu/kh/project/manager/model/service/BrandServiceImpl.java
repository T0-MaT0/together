package edu.kh.project.manager.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.manager.model.dao.BrandDAO;
import edu.kh.project.manager.model.dto.BrandBoard;
import edu.kh.project.manager.model.dto.BrandProfile;
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


	// Brand Profile
	@Override
	public Map<String, Object> brandProfile(int boardNo, int cp, int brandBoardCode) {
		Map<String, Object> map = new HashMap<String, Object>();

		BrandProfile brandProfile = dao.brandProfileSelect(boardNo);
		map.put("brandProfile", brandProfile);


		int listCount = dao.brandProfileBoardCount(boardNo, brandBoardCode);

		Pagination pagination = new Pagination(cp, listCount);
		map.put("pagination", pagination);


		List<BrandBoard> brandList = dao.brandProfileProducts(pagination, brandBoardCode, boardNo);

		map.put("brandList", brandList);


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



}
