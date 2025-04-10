package edu.kh.project.manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.manager.model.service.ManagerHomePageService;

@Controller
@RequestMapping("/manageHome")
public class ManagerHomePage {

	@Autowired
	private ManagerHomePageService service;


	/**메인 페이지
	 * @return
	 */
	@GetMapping("/mainPage")
	public String mainPage(Model model) {
		int imgNo = 1;
		List<Image> imgList = service.bannerSelect(imgNo);
		model.addAttribute("imgList", imgList);
		return "/manager/home/mainPage";
	}

	/** 개인
	 * @return
	 */
	@GetMapping("/privatePage")
	public String privatePage(Model model) {
		int imgNo = 2;
		List<Image> imgList = service.bannerSelect(imgNo);
		model.addAttribute("imgList", imgList);
		return "/manager/home/privatePage";
	}

	/** 브랜드
	 * @return
	 */
	@GetMapping("/brandPage")
	public String brandPage(Model model) {
		int imgNo = 3;
		List<Image> imgList = service.bannerSelect(imgNo);
		model.addAttribute("imgList", imgList);
		return "/manager/home/brandPage";
	}


	//이미지 제출
	@PostMapping("/{sectionPage}/submit")
	public String imageSubmit  (@PathVariable String sectionPage
			,@RequestParam(value="images", required=false)List<MultipartFile> images
			,@RequestParam(value="InsertNo", required=false)List<Integer> InsertNo
			,@RequestParam(value="updateNo", required=false)List<Integer> updateNo
			,@RequestParam(value="deleteNo", required=false)List<Integer> deleteNo
			,HttpSession session) {
		
		
		String webPath = "/resources/images/image-manager/banner/upload/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		int typeNo = 0;
		switch(sectionPage) {
			case "mainPage" : typeNo = 1; break;
			case "privatePage" : typeNo = 2; break;
			case "brandPage" : typeNo = 3; break;
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("InsertNo", InsertNo);
		map.put("updateNo", updateNo);
		map.put("deleteNo", deleteNo);
		
		try {
			int result = service.submit(map, webPath, images, typeNo, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return "redirect:/manageHome/"+sectionPage;
	}
	
	
	//광고 이미지 불러오기
	@GetMapping(value="promotionSelect", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<Image> promotionSelect(int typeImg){
		return service.promotionSelect(typeImg);
	}
	
	// 광고 이미지 삭제
	@GetMapping(value="deletePromotionImage", produces="application/json; charset=UTF-8")
	@ResponseBody
	public int deletePromotionImage(int imageNo){
		return service.deletePromotionImage(imageNo);
	}
	
	
}
