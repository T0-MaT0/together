package edu.kh.project.business.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.kh.project.business.model.dto.Business;
import edu.kh.project.business.model.service.BusinessService;
import edu.kh.project.member.model.dto.Member;

@Controller
@RequestMapping("/board")
@SessionAttributes("loginMember")
public class BusinessController {
	@Autowired
	private BusinessService service;
	
	// 사업자 메인 화면
	@GetMapping("/{boardCode:2}")
	public String selectBusinessList(
			@PathVariable("boardCode") int boardCode,
			Model model) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("boardCode", boardCode);
		
		Map<String, Object> map = service.selectBusinessList(paramMap, 1);
		
		model.addAttribute("map", map);
		
		return "board/business/mainBusiness";
	}
	
	// 사업자 검색 화면
	@GetMapping("/{boardCode:2}/search")
	public String searchBusinessList(
			@PathVariable("boardCode") int boardCode,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			@RequestParam Map<String, Object> paramMap,
			Model model) {
		paramMap.put("boardCode", boardCode);
		
		Map<String, Object> map = service.selectBusinessList(paramMap, cp);
		
		model.addAttribute("map", map);
		
		return "board/business/businessList";
	}
	
	// 게시글 상세 조회
	@GetMapping("/{boardCode:2}/{boardNo:[0-9]+}")
	public String businessList(@PathVariable("boardCode") int boardCode,
			@PathVariable("boardNo") int boardNo,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			Model model,
			RedirectAttributes ra,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", boardCode);
		map.put("boardNo", boardNo);
		
		Business business = service.selectBusiness(map);
		
		String path = null;
		if (business != null) {
			if (loginMember != null) {
				map.put("memberNo", loginMember.getMemberNo());
				
			}
			model.addAttribute("business", business);
			path = "board/business/businessDetail";
		} else {
			ra.addFlashAttribute("message", "해당 게시글이 존재하지 않습니다.");
			path = "redirect:/board/"+boardCode;
		}
		
		return path;
	}
	
	// 게시글 상세 화면에 리뷰 목록 조회
	@GetMapping("/{boardCode:2}/{boardNo:[0-9]+}/list")
	@ResponseBody
	public Map<String, Object> selectList(@PathVariable("boardCode") int boardCode,
			@PathVariable("boardNo") int boardNo,
			@RequestParam(value = "reviewCp", required = false, defaultValue = "1") int reviewCp,
			@RequestParam(value = "replyCp", required = false, defaultValue = "1") int replyCp,
			@RequestParam Map<String, Object> paramMap) {
		paramMap.put("boardCode", boardCode);
		paramMap.put("boardNo", boardNo);
		
		Map<String, Object> map = service.selectList(paramMap, reviewCp, replyCp);
		
		return map;
	}
}
