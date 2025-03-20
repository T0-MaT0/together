package edu.kh.project.manager.model.service;

import java.util.List;

import edu.kh.project.common.model.dto.Image;

public interface ManagerHomePageService {

	
	// *** MAIN PAGE ***
	/** 관리자 배너
	 * @return
	 */
	List<Image> bannerSelect();

}
