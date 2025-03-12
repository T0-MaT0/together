package edu.kh.project.business.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.business.model.dao.BusinessDao;
import edu.kh.project.business.model.dto.Business;
import edu.kh.project.common.model.dto.Pagination;

@Service
public class BusinessServiceIml implements BusinessService {
	@Autowired
	private BusinessDao dao;

	@Override
	public Map<String, Object> selectBusinessList(Map<String, Object> paramMap, int cp) {
		Map<String, Object> map = new HashMap<String, Object>();
		
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
}
