package edu.kh.project.business.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import edu.kh.project.business.model.dto.Business;
import edu.kh.project.business.model.dto.Order;
import edu.kh.project.business.model.service.BusinessService;
import edu.kh.project.member.model.dto.Member;

@Controller
@RequestMapping("/board/{boardCode:2}")
@SessionAttributes("loginMember")
public class BusinessController {
	@Autowired
	private BusinessService service;
	
	// 사업자 메인 화면
	@GetMapping("")
	public String selectBusinessList(
			@PathVariable("boardCode") int boardCode,
			Model model) throws JsonProcessingException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("boardCode", boardCode);
		
		Map<String, Object> map = service.selectBusinessList(paramMap, 1);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String bannerList = objectMapper.writeValueAsString(map.get("bannerList"));
		model.addAttribute("bannerList", bannerList);
		
		model.addAttribute("map", map);
		
		return "board/business/mainBusiness";
	}
	
	// 사업자 검색 화면
	@GetMapping("/search")
	public String searchBusinessList(
			@PathVariable("boardCode") int boardCode,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			@RequestParam Map<String, Object> paramMap,
			Model model) throws JsonProcessingException {
		paramMap.put("boardCode", boardCode);
		
		Map<String, Object> map = service.selectBusinessList(paramMap, cp);

		ObjectMapper objectMapper = new ObjectMapper();
		String bannerList = objectMapper.writeValueAsString(map.get("bannerList"));
		model.addAttribute("bannerList", bannerList);
		
		model.addAttribute("map", map);
		
		return "board/business/businessList";
	}
	
	// 게시글 상세 조회
	@GetMapping("/{boardNo:[0-9]+}")
	public String businessList(@PathVariable("boardCode") int boardCode,
			@PathVariable("boardNo") int boardNo,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			Model model,
			RedirectAttributes ra,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			HttpServletRequest req, HttpServletResponse resp) throws ParseException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", boardCode);
		map.put("boardNo", boardNo);
		
		Business business = service.selectBusiness(map);
		
		String path = null;
		if (business != null) {
			if (loginMember != null) {
				map.put("memberNo", loginMember.getMemberNo());
				
				// 찜하기 여부 확인 서비스 호출
				int result = service.pickCheck(map);
				
				// 찜하기를 누른 적이 있을 경우
				if (result>0) {
					model.addAttribute("pickCheck", "yes");
				}
			}
			if (loginMember==null||loginMember.getMemberNo()!=business.getMemberNo()) {
				Cookie c = null;
				Cookie[] cookies = req.getCookies();
				if (cookies!=null) {
					for(Cookie cookie:cookies) {
						if (cookie.getName().equals("readBoardNo")) {
							c = cookie;
							break;
						}
					}
				}
				int result = 0;
				if (c==null) {
					c=new Cookie("readBoardNo", "|"+boardNo+"|");
					result=service.updateReadCount(boardNo);
				} else {
					if (c.getValue().indexOf("|"+boardNo+"|")==-1) {
						c.setValue(c.getValue()+"|"+boardNo+"|");
						result=service.updateReadCount(boardNo);
					}
				}
				if (result>0) {
					c.setPath("/");
					Calendar cal=Calendar.getInstance();
					cal.add(Calendar.DATE, 1);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Date current = new Date();
					Date temp = new Date(cal.getTimeInMillis());
					Date tmr = sdf.parse(sdf.format(temp));
					long diff = (tmr.getTime()-current.getTime())/1000;
					c.setMaxAge((int)diff);
					resp.addCookie(c);
				}
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
	@GetMapping("/{boardNo:[0-9]+}/list")
	@ResponseBody
	public Map<String, Object> selectList(
			@PathVariable("boardCode") int boardCode,
			@PathVariable("boardNo") int boardNo,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			@RequestParam(value = "reviewCp", required = false, defaultValue = "1") int reviewCp,
			@RequestParam(value = "replyCp", required = false, defaultValue = "1") int replyCp,
			@RequestParam Map<String, Object> paramMap) {
		boolean myQNA = Boolean.parseBoolean((String)paramMap.get("myQNA"));
		boolean notSecret = Boolean.parseBoolean((String)paramMap.get("notSecret"));
		
		paramMap.put("boardCode", boardCode);
		paramMap.put("boardNo", boardNo);
		paramMap.put("key", "not");
		paramMap.put("myQNA", myQNA);
		paramMap.put("notSecret", notSecret);
		if (loginMember!=null) {
			paramMap.put("loginMemberNo", loginMember.getMemberNo());
		}
		
		Map<String, Object> map = service.selectList(paramMap, reviewCp, replyCp);
		
		return map;
	}
	
	// 리뷰 목록 조회
	@GetMapping("/reviewList")
	public String selectReviewList(@PathVariable("boardCode") int boardCode,
			@RequestParam(value = "reviewCp", required = false, defaultValue = "1") int reviewCp,
			@RequestParam Map<String, Object> paramMap,
			Model model) throws JsonProcessingException {
		paramMap.put("boardCode", boardCode);
		paramMap.put("key", "all");
		
		Map<String, Object> map = service.selectReviewList(paramMap, reviewCp);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String reviewListJson = objectMapper.writeValueAsString(map.get("reviewList"));
		model.addAttribute("reviewListJson", reviewListJson);
		
		model.addAttribute("map", map);
		
		return "board/business/reviewList";
	}
	
	// 리뷰 작성 페이지
	@GetMapping("/{boardNo:[0-9]+}/insertReview")
	public String insertReview() {
		return "board/business/reviewPopup";
	}
	
	// Q&A 목록 조회
	@GetMapping("/replyList")
	public String selectReplyList(@PathVariable("boardCode") int boardCode,
			@RequestParam(value = "replyCp", required = false, defaultValue = "1") int replyCp,
			@RequestParam Map<String, Object> paramMap,
			Model model) {
		paramMap.put("boardCode", boardCode);
		paramMap.put("key", "all");
		
		Map<String, Object> map = service.selectReplyList(paramMap, replyCp);
		
		model.addAttribute("map", map);
		
		return "board/business/replyList";
	}
	
	// Q&A 목록 조회(myQ&A, notSecret)
	@GetMapping("/updateList")
	@ResponseBody
	public Map<String, Object> selectReplyList(@PathVariable("boardCode") int boardCode,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			@RequestParam(value = "replyCp", required = false, defaultValue = "1") int replyCp,
			@RequestParam Map<String, Object> paramMap) {
		boolean myQNA = Boolean.parseBoolean((String)paramMap.get("myQNA"));
		boolean notSecret = Boolean.parseBoolean((String)paramMap.get("notSecret"));
		
		paramMap.put("boardCode", boardCode);
		paramMap.put("key", "all");
		paramMap.put("myQNA", myQNA);
		paramMap.put("notSecret", notSecret);
		if (loginMember!=null) {
			paramMap.put("loginMemberNo", loginMember.getMemberNo());
		}
		
		Map<String, Object> map = service.selectReplyList(paramMap, replyCp);
		
		return map;
	}
	
	// Q&A 작성 페이지
	@GetMapping("/{boardNo:[0-9]+}/insertReply")
	public String insertReply() {
		return "board/business/replyPopup";
	}
	
	// 주문 페이지
	@GetMapping("/{boardNo:[0-9]+}/order")
	public String selectOrder(
			@PathVariable("boardCode") int boardCode,
			@PathVariable("boardNo") int boardNo,
			Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", boardCode);
		map.put("boardNo", boardNo);
		
		Business business = service.selectBusiness(map);
		
		model.addAttribute("business", business);
		
		return "board/business/businessOrder";
	}
	
	// 주문 완료 페이지
	@PostMapping("/{boardNo:[0-9]+}/order")
	public String OrderSuccess(
			@PathVariable("boardCode") int boardCode,
			@PathVariable("boardNo") int boardNo,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			@RequestParam Map<String, Object> paramMap,
			Order order, Model model) {
		String addr = paramMap.get("postCode")+"^^^ "+paramMap.get("roadAddress")+"^^^ "+paramMap.get("detailAddress");
		order.setOrderAddress(addr);
		
		paramMap.put("order", order);
		paramMap.put("loginMember", loginMember);
		
		int result = service.insertOrder(paramMap);
		
		String message=null;
		String path;
		if (result>0) {
			message = "주문이 완료되었습니다.";
			path = "board/business/businessOrderDetail";
			model.addAttribute("order", order);
		} else {
			message = "주문 실패";
			path = "redirect:order";
		}
		model.addAttribute("massage", message);
		
		return path;
	}
}
