package edu.kh.project.business.model.service;

import java.util.Map;

public interface BusinessService {
	Map<String, Object> selectBusinessList(Map<String, Object> paramMap, int cp);
}
