package edu.kh.project.member.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kh.project.common.model.dto.Category;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.Product;
import edu.kh.project.member.model.service.AjaxService;

@Controller 
public class AjaxController {

	@Autowired
	private AjaxService service;


	@GetMapping("/dupCheck/id")
	@ResponseBody
	public String dupCheckId(String id) {

		return service.dupCheckId(id);
	}


	@GetMapping("/dupCheck/email")
	@ResponseBody
	public String dupCheckEmail(String email) {

		return service.dupCheckEmail(email);
	}

	@GetMapping("/dupCheck/nickname")
	@ResponseBody
	public String dupCheckNickname(String nickname) {

		return service.dupCheckNickname(nickname);
	}

	@PostMapping(value = "/selectMember", produces="application/json; charset=UTF-8")
	@ResponseBody // java 데이터 -> JSON, TEXT로 변환 + 비동기 요청한 곳으로 응답
	public Member selectMember(@RequestBody Map<String, Object> paramMap) {
		// @RequestBody Map<String, Object> paramMap
		// -> 요청된 HTTP Body에 담긴 모든 데이터를 Map으로 반환

		String email = (String)paramMap.get("email");


		return service.selectMember(email);
	}

	@PostMapping(value = "/selectMemberList", produces="application/json; charset=UTF-8")
	@ResponseBody 
	public List<Member> selectMemberList(@RequestBody Map<String, Object> paramMap) {

		String email = (String)paramMap.get("email");


		return service.selectMemberList(email);
	}

	@PostMapping(value = "/searchQueryList", produces="application/json; charset=UTF-8")
	@ResponseBody 
	public List<Map<String, Object>> searchQueryList(@RequestBody Map<String, Object> paramMap) {

		String query = (String)paramMap.get("query");


		return service.searchQueryList(query);
	}

	@PostMapping(value = "/ajax/getCategory", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<Category> getCategory(@RequestBody int categoryNo) {
		List<Category> category = service.getCategory(categoryNo);
		return category;
	}

	@PostMapping(value = "/ajax/totalSearch", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<Product> totalSearch(@RequestBody Map<String, Object> paramMap) {

		String searchValue = (String)paramMap.get("searchValue");
		String categoryNo = String.join(",", (List<String>)paramMap.get("categoryNo")); // "12,13,14,15,16,17"
		int categoryNoParents = Integer.parseInt(((List<Object>)paramMap.get("categoryNoParants")).get(0).toString());
		String type = (String)paramMap.get("type");
		String minValues = (String)paramMap.get("minValue");
		String maxValues = (String)paramMap.get("maxValue");
		String location = (String)paramMap.get("location");
		if (maxValues.equals("999999~") || maxValues.equals("990000~")) {
			maxValues = "99999999";
		}
		int minValue = 0;
		int maxValue = 0;
		try {
			minValue = Integer.parseInt(minValues);
			maxValue = Integer.parseInt(maxValues);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		int boardCd = 0;
		if (type.equals("company")) {
			boardCd = 1;
		} else if (type.equals("personal")) {
			boardCd = 2;
		} else {
			boardCd = -1;
		}
		
		searchValue = "%" + searchValue + "%"; 
		location = "%" + location + "%"; 
		

		Map<String, Object> searchMap = Map.of(
				"searchValue", searchValue,
				"categoryNo", categoryNo,
				"categoryNoParents", categoryNoParents,
				"location", location,
				"boardCd", boardCd,
				"minValue", minValue,
				"maxValue", maxValue
				);
		//searchMap = {searchValue=, categoryNoParents=8, maxValue=100000, categoryNo=43,53, location=, boardCd=2, minValue=10000}
		System.out.println("searchMap = " + searchMap);
		return service.totalSearch(searchMap);
	}



}