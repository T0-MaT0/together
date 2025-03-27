package edu.kh.project.manager.model.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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
	 * @param map 
	 * @param webPath 
	 * @param images 
	 * @param typeNo 
	 * @param filePath 
	 * @return
	 */
	int submit(Map<String, Object> map, String webPath, List<MultipartFile> images, int typeNo, String filePath) throws IllegalStateException, IOException;

	/** 광고 이미지 조회
	 * @param typeImg 
	 * @return
	 */
	List<Image> promotionSelect(int typeImg);

	/** 광고 이미지 삭제
	 * @param imageNo 
	 * @return
	 */
	int deletePromotionImage(int imageNo);

}
