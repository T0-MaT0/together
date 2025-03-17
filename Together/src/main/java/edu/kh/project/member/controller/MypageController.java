package edu.kh.project.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageController {

    @GetMapping()
    public String mypage(){
        return "redirect:/mypage/home";
    }

    @GetMapping("/home")
    public String mypage(Model model) {
        return "member/mypage/home";
    }

    @GetMapping("/orders")
    public String orders(Model model) {
        return "member/mypage/orders";
    }

    @GetMapping("/wishlist")
    public String wishlist(Model model) {
        return "member/mypage/wishlist";
    }

    @GetMapping("/recentPurchase")
    public String recentPurchase(Model model) {
        return "member/mypage/recentPurchase";
    }

    @GetMapping("/writableReview")
    public String writableReview(Model model) {
        return "member/mypage/writableReview";
    }

    @GetMapping("/writtenReview")
    public String writtenReview(Model model) {
        return "member/mypage/writtenReview";
    }

    @GetMapping("/favoriteStore")
    public String favoriteStore(Model model) {
        return "member/mypage/favoriteStore";
    }

    @GetMapping("/QnA")
    public String QnA(Model model) {
        return "member/mypage/QnA";
    }








}