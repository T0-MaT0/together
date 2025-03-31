package edu.kh.project.member.model.service;

import edu.kh.project.common.model.dto.Category;
import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.member.model.dao.MypageDAO;
import edu.kh.project.member.model.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@Service
public class MypageServiceImpl implements MypageService {

    @Autowired
    private MypageDAO dao;

    @Override
    public List<Product> getPurchaseHistory(int memberNo) {
        return dao.getPurchaseHistory(memberNo);
    }

    @Override
    public List<Product> getCategoryPick(int categoryNo) { return dao.getCategoryPick(categoryNo); }

    @Override
    public List<Product> getPickProduct(int memberNo) {
        return dao.getPickProduct(memberNo);
    }

    @Override
    public List<Member> recommendBrand(int memberNo) {
        return dao.recommendBrand(memberNo);
    }

    @Override
    public List<Brand> pickBrand(int memberNo) {
        return dao.pickBrand(memberNo);
    }

    @Override
    public List<Reply> getQnA(int memberNo) {
        return dao.getQnA(memberNo);
    }

    @Override
    public List<Product> getReview(int memberNo) {
        return dao.getReview(memberNo);
    }

    @Override
    public int insertPromotion(Board board, Image img, MultipartFile file, String filePath) {
        int result=0;

        result = dao.insertPromotionBoard(board);
        System.out.println("result = " + result);
        if(result>0){
            if(img != null){
                img.setImageTypeNo(result);
                result = dao.insertPromotionImage(img);
                if(result>0){
                    try {
                        file.transferTo(new File(filePath + img.getImageReName()));
                    } catch (Exception e) {
                        e.printStackTrace();
                        result = 0;
                    }
                }
            }
        }
        System.out.println("result = " + result);
        return result;
    }

    @Override
    public Company getBusinessInfo(int memberNo) {
        return dao.getBusinessInfo(memberNo);
    }

    @Override
    public List<QuestCustomer> getPromotionInfo(int memberNo) {
        return dao.getPromotionInfo(memberNo);
    }

    @Override
    public List<Category> getCategory(int categoryNo) {
        return dao.getCategory(categoryNo);
    }


}
