package edu.kh.project.individual.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ApiController {

    // 카카오 지도 팝업 페이지 이동
    @GetMapping("/kakaoAPI")
    public String showKakaoApiPage() {
        return "Individual/kakaoAPI"; 
    }
}
