package edu.kh.project.member.controller;

import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.member.model.dto.Brand;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.Product;
import edu.kh.project.member.model.service.MypageServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mypage")
public class MypageController {


    @Autowired
    private MypageServiceImpl service;


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


//  비동기

    @PostMapping(value = "/purchaseHistory", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<Product> purchaseHistory(@RequestBody int memberNo) {

        return service.getPurchaseHistory(memberNo);
    }

    @PostMapping(value = "/categoryPick", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<Product> categoryPick(@RequestBody int categoryNo) {
        return service.getCategoryPick(categoryNo);
    }

    @PostMapping(value = "/getPickProduct", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<Product> getPickProduct(@RequestBody int memberNo) {
        return service.getPickProduct(memberNo);
    }

    @PostMapping(value = "/recommendBrand", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<Member> recommendBrand(@RequestBody int memberNo) {
        return service.recommendBrand(memberNo);
    }

    @PostMapping(value = "/pickBrand", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<Brand> pickBrand(@RequestBody int memberNo) {
        return service.pickBrand(memberNo);
    }

    @PostMapping(value = "/getQnA", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<Reply> getQnA(@RequestBody int memberNo) {
        return service.getQnA(memberNo);
    }




}