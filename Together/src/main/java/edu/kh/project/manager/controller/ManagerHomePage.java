package edu.kh.project.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manageHome")
public class ManagerHomePage {
	
	@GetMapping("/mainPage")
	public String mainPage() {
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
