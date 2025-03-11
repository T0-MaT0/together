package edu.kh.project.business.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/board")
public class BusinessController {
	// 사업자 메인 화면
	@GetMapping("/{boardCode:2}")
	public String selectBusinessList() {
		return "board/business/mainBusiness";
	}
	
	// 사업자 검색 화면
	@GetMapping("/{boardCode:2}/search")
	public String searchBusinessList(
			@RequestParam Map<String, Object> pranmMap,
			Model model) {
		if (!pranmMap.get("query").equals("지금 🔥HOT🔥한 상품들")&&!pranmMap.get("query").equals("🆕새로 올라온 상품들🆕")) {
			System.out.println("test\n\n\n");
		}
		return "board/business/businessList";
	}
}
