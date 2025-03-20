package edu.kh.project.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String mainPage() {
		
		// 관리자 배너, 
		List<Image> imgList = service.bannerSelect();
		return "/manager/home/mainPage";
	}
	
	@GetMapping("/privatePage")
	public String privatePage() {
		return "/manager/home/privatePage";
	}
	
	@GetMapping("/brandPage")
	public String brandPage() {
		return "/manager/home/brandPage";
	}
}
