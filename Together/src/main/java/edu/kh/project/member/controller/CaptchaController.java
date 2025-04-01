package edu.kh.project.member.controller;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
public class CaptchaController {
	
	@Autowired
	private DefaultKaptcha captchaProducer;
	
	@GetMapping("/captcha")
	public void getCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    response.setDateHeader("Expires", 0);
	    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
	    response.addHeader("Cache-Control", "post-check=0, pre-check=0");
	    response.setHeader("Pragma", "no-cache");
	    response.setContentType("image/jpeg");

	    String capText = captchaProducer.createText();
	    request.getSession().setAttribute("captcha", capText);

	    BufferedImage bi = captchaProducer.createImage(capText);
	    ServletOutputStream out = response.getOutputStream();
	    ImageIO.write(bi, "jpg", out);
	    try {
	        out.flush();
	    } finally {
	        out.close();
	    }
	}
	
	@GetMapping("/getCaptchaValue")
	@ResponseBody
	public String getCaptchaValue(HttpSession session) {
	    return (String) session.getAttribute("captcha");
	}

}
