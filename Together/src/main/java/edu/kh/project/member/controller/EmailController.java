package edu.kh.project.member.controller;


import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;


import edu.kh.project.member.model.service.EmailService;


@Controller
@RequestMapping("/sendEmail")
@SessionAttributes("authKey")
public class EmailController {
    
    @Autowired
    private EmailService service;
    
    @GetMapping("/signUp")
    @ResponseBody
    public int signUp(String email) {
        return service.signUp(email, "회원 가입");
    }
    
    
    @GetMapping("/checkAuthKey")
    @ResponseBody
    public int checkAuthKey(@RequestParam Map<String, Object> paramMap){


    	System.out.println(paramMap); // {authKey=4NQG3s, email=이메일@kh.or.kr}
        
        return service.checkAuthKey(paramMap);
    }
    
}