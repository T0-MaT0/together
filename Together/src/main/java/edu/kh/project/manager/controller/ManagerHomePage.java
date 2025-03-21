package edu.kh.project.manager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String imageSubmit(@PathVariable String sectionPage
			,@RequestParam(value="images", required=false)List<MultipartFile> images
			,HttpSession session) {

		String webPath = "/resources/images/image-manager/";
		String filePath = session.getServletContext().getRealPath(webPath);

		int typeNo = 0;
		switch(sectionPage) {
			case "mainPage" : typeNo = 1; break;
			case "privatePage" : typeNo = 2; break;
			case "brandPage" : typeNo = 3; break;
		}

		int result = service.submit(webPath, images, typeNo, filePath);


		return "redirect:/manageHome/"+sectionPage;
	}
}
