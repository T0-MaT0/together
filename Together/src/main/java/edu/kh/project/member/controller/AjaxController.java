package edu.kh.project.member.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;


import edu.kh.project.member.model.dto.Member;
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
	

}