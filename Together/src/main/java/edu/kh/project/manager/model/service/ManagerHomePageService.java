package edu.kh.project.manager.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.common.model.dto.Image;

public interface ManagerHomePageService {

	
	// *** MAIN PAGE ***
	/** 관리자 배너
	 * @param imgNo 
	 * @return
	 */
	List<Image> bannerSelect(int imgNo);

	/** 배너 이미지 제출
	 * @param webPath 
	 * @param images 
	 * @param typeNo 
	 * @param filePath 
	 * @return
	 */
	int submit(String webPath, List<MultipartFile> images, int typeNo, String filePath);

}
