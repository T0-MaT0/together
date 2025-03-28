package edu.kh.project.member.controller;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.member.model.dto.*;
import edu.kh.project.member.model.service.MypageServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

import javax.servlet.http.HttpSession;

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

    @GetMapping("/ask")
    public String ask(Model model) {
        return "member/mypage/ask";
    }


    @GetMapping("/promotion")
    public String promotion(Model model) {
        return "member/mypage/promotion";
    }

//    비동기

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

    @PostMapping(value = "/getReview", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<Product> getReview(@RequestBody int memberNo) {
        return service.getReview(memberNo);
    }

    @PostMapping(value = "/getBusinessInfo", produces="application/json; charset=UTF-8")
    @ResponseBody
    public Company getBusinessInfo(@RequestBody int memberNo) {
        return service.getBusinessInfo(memberNo);
    }

    @PostMapping(value = "getPromotionInfo", produces="application/json; charset=UTF-8")
    @ResponseBody
    public List<QuestCustomer> getPromotionInfo(@RequestBody int memberNo) {
        return service.getPromotionInfo(memberNo);
    }
    







// PostMapping

    @PostMapping("/promotion")
    @ResponseBody
    public int insertPromotion(
            @RequestParam("memberNo") int memberNo,
            @RequestParam("title") String title,
            @RequestParam("brandName") String brandName,
            @RequestParam("content") String content,
            @RequestParam("file") MultipartFile file,
            HttpSession session
    ) {

        if (file.isEmpty()) {
            return 0;
        }


        String webPath = "/resources/images/ad-board/";
        String filePath = session.getServletContext().getRealPath(webPath);
        Image img = new Image();
        img.setImagePath(webPath);
        img.setImageOriginal(file.getOriginalFilename());

        img.setImageReName(Utill.fileRename(file.getOriginalFilename()));

        img.setImageLevel(0);
        img.setImageType(4);


        Board board = new Board();
        board.setBoardTitle(title);
        board.setBoardContent(content);
        board.setMemberNo(memberNo);
        board.setBoardCd(7);

        return service.insertPromotion(board, img, file, filePath);

    }


}