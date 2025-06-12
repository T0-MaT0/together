package edu.kh.project.business.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import edu.kh.project.business.model.dto.Business;
import edu.kh.project.business.model.dto.Order;
import edu.kh.project.business.model.service.BusinessService;
import edu.kh.project.common.model.dto.Category;
import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.PointHistory;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.model.dto.Review;
import edu.kh.project.manager.model.dto.Report;
import edu.kh.project.member.model.dto.Board;
import edu.kh.project.member.model.dto.Member;

@Controller
@RequestMapping("/product")
@SessionAttributes("loginMember")
public class BusinessController {
	@Autowired
	private BusinessService service;
	
	// 사업자 메인 화면
	@GetMapping("")
	public String selectBusinessList(Model model) throws JsonProcessingException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		Map<String, Object> map = service.selectBusinessList(paramMap, 1);
		
		ObjectMapper objectMapper = new ObjectMapper();
		String bannerList = objectMapper.writeValueAsString(map.get("bannerList"));
		model.addAttribute("bannerList", bannerList);
		
		model.addAttribute("map", map);
		
		return "business/mainBusiness";
	}
	
	// 사업자 검색 화면
	@GetMapping("/search")
	public String searchBusinessList(
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			@RequestParam Map<String, Object> paramMap,
			Model model) throws JsonProcessingException {
		Map<String, Object> map = service.selectBusinessList(paramMap, cp);

		ObjectMapper objectMapper = new ObjectMapper();
		String bannerList = objectMapper.writeValueAsString(map.get("bannerList"));
		model.addAttribute("bannerList", bannerList);
		
		model.addAttribute("map", map);
		
		return "business/businessList";
	}
	
	// 게시글 작성 페이지로
	@GetMapping("/insertProduct")
	public String insertProduct(
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			Model model) throws JsonProcessingException {
		List<Category> categoryList = service.selectCategoryList();
		String permissionFl = service.selectPermissionFl(loginMember.getMemberNo());
		
		ObjectMapper objectMapper = new ObjectMapper();
		String categoryListJson = objectMapper.writeValueAsString(categoryList);
		
		model.addAttribute("categoryListJson", categoryListJson);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("permissionFl", permissionFl);
		
		return "business/businessWrite";
	}
	
	// 상품 등록
	@PostMapping("/insertProduct")
	public String insertProduct(
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			@RequestParam(value = "images", required = false) List<MultipartFile> images,
			@RequestParam(value = "optionName", required = false) List<String> optionNameList,
			@RequestParam(value = "coalitionTitle", required = false) String coalitionTitle,
			@RequestParam(value = "coalitionContent", required = false) String coalitionContent,
			@RequestParam(value = "permissionFl", required = false) String permissionFl,
			Business business, RedirectAttributes ra, HttpSession session) throws IllegalStateException, IOException {
		business.setMemberNo(loginMember.getMemberNo());
		
		Board board = new Board();
		board.setBoardTitle(coalitionTitle);
		board.setBoardContent(coalitionContent);
		board.setMemberNo(loginMember.getMemberNo());
		
		String webPath = "/resources/images/product/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		int productNo = service.insertProduct(business, optionNameList, images, webPath, filePath, board, permissionFl);
		
		String message = null;
		String path = "redirect:/product/";
		if (productNo>0) {
			message = "상품이 등록되었습니다.";
			path += productNo;
		} else {
			message = "상품 등록 실패";
			path += "insertProduct";
		}
		
		ra.addFlashAttribute("message", message);
		return path;
	}
	
	// 상품 삭제
	@GetMapping("/{productNo:[0-9]+}/delete")
	public String deleteProduct(
			@PathVariable("productNo") int productNo,
			RedirectAttributes ra) {
		Business business = new Business();
		business.setProductNo(productNo);
		int result = service.deleteProduct(business);
		
		String message = null;
		String path = "redirect:/product";
		if (result>0) {
			message = "상품 삭제를 성공했습니다.";
		} else {
			message = "상품 삭제 실패";
			path+="/"+productNo;
		}
		
		ra.addFlashAttribute("message", message);
		return path;
	}
	
	// 상품 수정 페이지
	@GetMapping("/{productNo:[0-9]+}/update")
	public String updateProduct(
			@PathVariable("productNo") int productNo,
			Model model) throws JsonProcessingException {
		Business business = service.selectBusiness(productNo);
		List<Category> categoryList = service.selectCategoryList();
		
		ObjectMapper objectMapper = new ObjectMapper();
		String categoryListJson = objectMapper.writeValueAsString(categoryList);
		
		model.addAttribute("categoryListJson", categoryListJson);
		model.addAttribute("business", business);
		model.addAttribute("categoryList", categoryList);
		
		return "business/businessWrite";
	}
	
	// 상품 수정
	@PostMapping("/{productNo:[0-9]+}/update")
	public String updateProduct(
			@PathVariable("productNo") int productNo,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			@RequestParam(value = "images", required = false) List<MultipartFile> images,
			@RequestParam(value = "deleteList", required = false) String deleteList,
			@RequestParam(value = "optionNo", required = false) List<Integer> optionNoList,
			@RequestParam(value = "optionName", required = false) List<String> optionNameList,
			Business business, RedirectAttributes ra, HttpSession session) throws IllegalStateException, IOException {
		business.setMemberNo(loginMember.getMemberNo());
		
		String webPath = "/resources/images/product/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		int result = service.updateProduct(business, optionNoList, optionNameList, images, deleteList, webPath, filePath);
		
		String message = null;
		String path = "redirect:/product/";
		if (result>0) {
			message = "상품이 수정되었습니다.";
			path += productNo;
		} else {
			message = "상품 등록 실패";
			path += "insertProduct";
		}
		
		ra.addFlashAttribute("message", message);
		return path;
	}
	
	// 게시글 상세 조회
	@GetMapping("/{productNo:[0-9]+}")
	public String businessList(
			@PathVariable("productNo") int productNo,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			Model model, RedirectAttributes ra,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			HttpServletRequest req, HttpServletResponse resp) throws ParseException {
		Business business = service.selectBusiness(productNo);
		
		String path = null;
		if (business != null) {
			if (loginMember != null) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("productNo", productNo);
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
						if (cookie.getName().equals("readProductNo")) {
							c = cookie;
							break;
						}
					}
				}
				int result = 0;
				if (c==null) {
					c=new Cookie("readProductNo", "|"+productNo+"|");
					result=service.updateReadCount(productNo);
				} else {
					if (c.getValue().indexOf("|"+productNo+"|")==-1) {
						c.setValue(c.getValue()+"|"+productNo+"|");
						result=service.updateReadCount(productNo);
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
			path = "business/businessDetail";
		} else {
			ra.addFlashAttribute("message", "해당 게시글이 존재하지 않습니다.");
			path = "redirect:/product";
		}
		
		return path;
	}
	
	// 찜히기 처리
	@PostMapping("/pick")
	@ResponseBody
	public int pick(@RequestBody Map<String, Integer> paramMap) {
		return service.pick(paramMap);
	}
	
	// 게시글 상세 화면에 리뷰 목록 조회
	@GetMapping("/{productNo:[0-9]+}/list")
	@ResponseBody
	public Map<String, Object> selectList(
			@PathVariable("productNo") int productNo,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			@RequestParam(value = "reviewCp", required = false, defaultValue = "1") int reviewCp,
			@RequestParam(value = "replyCp", required = false, defaultValue = "1") int replyCp,
			@RequestParam Map<String, Object> paramMap) {
		boolean myQNA = Boolean.parseBoolean((String)paramMap.get("myQNA"));
		boolean notSecret = Boolean.parseBoolean((String)paramMap.get("notSecret"));
		
		paramMap.put("productNo", productNo);
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
	public String selectReviewList(
			@RequestParam(value = "reviewCp", required = false, defaultValue = "1") int reviewCp,
			@RequestParam Map<String, Object> paramMap,
			Model model) throws JsonProcessingException {
		paramMap.put("key", "all");
		
		Map<String, Object> map = service.selectReviewList(paramMap, reviewCp);
		
		@SuppressWarnings("unchecked")
		List<Review> reviewList = (List<Review>)map.get("reviewList");
		for (Review review:reviewList) {
			String content = review.getReviewContent();
		    content = content.replace("\r\n", "<br>").replace("\n", "<br>");
		    review.setReviewContent(content);
	    }
		
		ObjectMapper objectMapper = new ObjectMapper();
		String reviewListJson = objectMapper.writeValueAsString(reviewList);
		model.addAttribute("reviewListJson", reviewListJson);
		
		model.addAttribute("map", map);
		
		return "business/reviewList";
	}
	
	// 회원의 최근 주문 내역 조회
	@GetMapping("/{productNo:[0-9]+}/selectOrder")
	@ResponseBody
	public Order selectOrder(
			@PathVariable("productNo")int productNo,
			@RequestParam(value = "reviewNo", required = false, defaultValue = "-1") int reviewNo,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productNo", productNo);
		map.put("memberNo", loginMember.getMemberNo());
		map.put("reviewNo", reviewNo);
		Order order = service.selectOrder(map);
		return order;
	}
	
	// 리뷰 작성 페이지
	@GetMapping("/{productNo:[0-9]+}/insertReview")
	public String insertReview(
			@PathVariable("productNo")int productNo,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			@RequestParam(value = "reviewNo", required = false, defaultValue = "-1") int reviewNo,
			Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productNo", productNo);
		map.put("reviewNo", reviewNo);
		map.put("memberNo", loginMember.getMemberNo());
		Order order = service.selectOrder(map);
		Business business = service.selectBusiness(productNo);
		if (reviewNo!=-1) {
			Review review = service.selectReview(reviewNo);
			model.addAttribute("review", review);
		}
		model.addAttribute("order", order);
		model.addAttribute("business", business);
		return "business/reviewPopup";
	}
	
	// 리뷰 등록/수정
	@PostMapping("/{productNo:[0-9]+}/insertReview")
	public String insertReview(
			@PathVariable("productNo")int productNo,
			@RequestParam(value = "images", required = false) List<MultipartFile> images,
		    @RequestParam(value = "imageNo", required = false) List<Integer> imageNo,
		    @RequestParam(value = "imageLevel", required = false) List<Integer> imageLevel,
			@RequestParam(value = "reviewUpdateNo", required = false, defaultValue = "0") int reviewUpdateNo,
			@RequestParam(value = "deleteList", required = false) String deleteList,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Model model, Review review, 
			RedirectAttributes ra, HttpSession session) throws IllegalStateException, IOException {
		review.setReviewType("PRODUCT");
		review.setReviewTypeNo(productNo);
		review.setMemberNo(loginMember.getMemberNo());
		
		String webPath = "/resources/images/review/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		List<Image> existingImages = new ArrayList<Image>();
		for(int i=0;i<imageLevel.size();i++) {
			Image img = new Image();
			img.setImageLevel(imageLevel.get(i));
			img.setImageNo(imageNo.get(i));
			existingImages.add(img);
		}
		
		int reviewNo = service.insertReview(review, images, webPath, filePath, existingImages, reviewUpdateNo, deleteList);
		
		String path = "";
		if (reviewNo>0) {
			path = "business/closePopup";
			model.addAttribute(review.getReviewNo());
		} else {
			path+="redirect:/product/"+productNo+"/insertReview";
			ra.addFlashAttribute("message", "리뷰 등록 실패");
		}
		
		return path;
	}
	
	// 리뷰 삭제
	@GetMapping("/{productNo:[0-9]+}/deleteReview")
	public String deleteReview(
			@PathVariable("productNo") int productNo, 
			@RequestParam(value = "reviewNo", required = false) int reviewNo,
			RedirectAttributes ra) {
		int result = service.deleteReview(reviewNo);
		
		String message=null;
		if (result>0) {
			message="리뷰가 삭제되었습니다.";
		} else {
			message="리뷰 삭제 실패";
		}
		ra.addFlashAttribute("message",message);
		
		return "redirect:/product/"+productNo;
	}
	
	// 리뷰 댓글 등록
	@PostMapping("/{productNo:[0-9]+}/reviewReply")
	@ResponseBody
	public Review insertReviewReply(@RequestBody Reply reply) {
		int result = service.insertReviewReply(reply);
		Review review = null;
		if (result>0) {
			review = service.selectReview(reply.getReplyTypeNo());
		}
		return review;
	}
	
	// 리뷰 댓글 수정
	@PutMapping("/{productNo:[0-9]+}/reviewReply")
	@ResponseBody
	public Review updateReviewReply(@RequestBody Reply reply) {
		int result = service.updateReviewReply(reply);
		Review review = null;
		if (result>0) {
			review = service.selectReview(reply.getReplyTypeNo());
		}
		return review;
	}
	
	// 리뷰 댓글 삭제
	@DeleteMapping("/{productNo:[0-9]+}/reviewReply")
	@ResponseBody
	public Review deleteReviewReply(
			@RequestBody Reply reply
			) {
		int result = service.deleteReviewReply(reply);
		Review review = null;
		if (result>0) {
			review = service.selectReview(reply.getReplyTypeNo());
		}
		return review;
	}
	
	// Q&A 목록 조회
	@GetMapping("/replyList")
	public String selectReplyList(
			@RequestParam(value = "replyCp", required = false, defaultValue = "1") int replyCp,
			@RequestParam Map<String, Object> paramMap,
			Model model) {
		paramMap.put("key", "all");
		
		Map<String, Object> map = service.selectReplyList(paramMap, replyCp);
		
		model.addAttribute("map", map);
		
		return "business/replyList";
	}
	
	// Q&A 목록 조회(myQ&A, notSecret)
	@GetMapping("/updateList")
	@ResponseBody
	public Map<String, Object> selectReplyList(
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			@RequestParam(value = "replyCp", required = false, defaultValue = "1") int replyCp,
			@RequestParam Map<String, Object> paramMap) {
		boolean myQNA = Boolean.parseBoolean((String)paramMap.get("myQNA"));
		boolean notSecret = Boolean.parseBoolean((String)paramMap.get("notSecret"));
		
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
	@GetMapping("/{productNo:[0-9]+}/insertReply")
	public String insertReply(@PathVariable("productNo")int productNo) {
		return "business/replyPopup";
	}
	
	// Q&A 등록
	@PostMapping("/{productNo:[0-9]+}/insertReply")
	public String insertReply(
			@PathVariable("productNo")int productNo,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Model model, Reply reply, 
			RedirectAttributes ra, HttpSession session) throws IllegalStateException, IOException {
		reply.setReplyType("PRODUCT");
		reply.setReplyTypeNo(productNo);
		reply.setMemberNo(loginMember.getMemberNo());
		
		int result = service.insertReply(reply);
		
		String path = "";
		if (result>0) {
			path = "business/closePopup";
			model.addAttribute(reply);
		} else {
			path+="redirect:/product/"+productNo+"insertReply";
			ra.addFlashAttribute("message", "Q&A 등록 실패");
		}
		
		return path;
	}
	
	// Q&A 수정
	@PutMapping("/{productNo:[0-9]+}/reply")
	@ResponseBody
	public Reply updateReply(@RequestBody Reply reply) {
		int result = service.updateReply(reply);
		if (result>0&&reply.getParentNo()!=0) {
			reply = service.selectReply(reply.getParentNo());
		}
		return reply;
	}
	
	// Q&A 삭제
	@DeleteMapping("/{productNo:[0-9]+}/reply")
	@ResponseBody
	public int deleteReply(@RequestBody Reply reply) {
		return service.deleteReply(reply);
	}
	
	// Q&A 답글 등록
	@PostMapping("/{productNo:[0-9]+}/reply")
	@ResponseBody
	public Reply insertChildReply(@RequestBody Reply reply) {
		int replyNo = reply.getParentNo();
		int result = service.insertReply(reply);
		if (result>0) {
			reply = service.selectReply(replyNo);
		}
		return reply;
	}
	
	// 주문 페이지
	@GetMapping("/{productNo:[0-9]+}/order")
	public String selectOrder(
			@PathVariable("productNo") int productNo,
			Model model) {
		Business business = service.selectBusiness(productNo);
		
		model.addAttribute("business", business);
		
		return "business/businessOrder";
	}
	
	// 주문 내역 삽입
	@PostMapping("/{productNo:[0-9]+}/order")
	public String insertOrder(
			@PathVariable("productNo") int productNo,
			@SessionAttribute(value = "loginMember", required = false) Member loginMember,
			@RequestParam Map<String, Object> paramMap,
			Order order, HttpSession session,
			RedirectAttributes ra) {
		Order recentOrder = (Order) session.getAttribute("recentOrder");
		if (recentOrder!=null&&recentOrder.equals(order)) {
			ra.addFlashAttribute("message", "이미 주문이 처리되었습니다.");
			ra.addFlashAttribute("order", recentOrder);
			return "redirect:/product/"+productNo+"/order/success";
		}
		
		String addr = paramMap.get("postCode")+"^^^ "+paramMap.get("roadAddress")+"^^^ "+paramMap.get("detailAddress");
		order.setOrderAddress(addr);
		
		paramMap.put("order", order);
		paramMap.put("loginMember", loginMember);
		
		int result = service.insertOrder(paramMap);
		
		String message=null;
		String path = "redirect:/product/"+productNo+"/order/";
		if (result>0) {
			message = "주문이 완료되었습니다.";
			path += "success";
			session.setAttribute("recentOrder", order);
			ra.addFlashAttribute("order", order);
		} else {
			message = "주문 실패";
		}
		ra.addFlashAttribute("message", message);
		
		return path;
	}
	
	// 주문 내역 페이지로 이동
	@GetMapping("/{productNo:[0-9]+}/order/success")
	public String orderSuccess(
			@PathVariable("productNo") int productNo,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Model model) {
		Business business = service.selectBusiness(productNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productNo", productNo);
		map.put("memberNo", loginMember.getMemberNo());
		map.put("reviewNo", -1);
		Order order = service.selectOrder(map);
		
		PointHistory usage = service.selectPointHistory(order.getOrderNo());
		
		model.addAttribute("business", business);
		model.addAttribute("order", order);
		model.addAttribute("usage", usage);
		
		return "business/businessOrderDetail";
	}
	
	// 신고 요청
	@PostMapping("/report/submit")
	@ResponseBody
	public Map<String, Object> submitReport(
			@RequestBody Report report,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
	    Map<String, Object> result = new HashMap<>();

	    try {
	        report.setMemberNo(loginMember.getMemberNo()); // 신고자 번호 설정
	        int rowCount = service.insertReport(report);

	        if (rowCount > 0) {
	            result.put("success", true);
	        } else {
	            result.put("success", false);
	            result.put("message", "신고 등록 실패");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	        result.put("message", "서버 오류 발생");
	    }

	    return result;
	}
}
