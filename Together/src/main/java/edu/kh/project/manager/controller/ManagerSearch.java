package edu.kh.project.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kh.project.manager.model.service.ManagerService;
import edu.kh.project.member.model.dto.Member;

@Controller
public class ManagerSearch {
	@Autowired
	private ManagerService service;
	
	
	@GetMapping(value="/managerSearch", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<Member> managerSearch(String query) {
		
		List<Member> listMember = service.managerSearchMember(query);
	
		
		return listMember;
	}
	
	
}
