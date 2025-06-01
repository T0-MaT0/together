package edu.kh.project.member.model.dao;


import edu.kh.project.common.model.dto.Category;
import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.manager.model.dto.QuestCustomer;
import edu.kh.project.member.model.dto.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MypageDAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public List<Product> getPurchaseHistory(int memberNo) {
        return sqlSession.selectList("mypageMapper.getPurchaseHistory", memberNo);
    }

    public List<Product> getCategoryPick(int categoryNo) {
        return sqlSession.selectList("mypageMapper.getCategoryPick", categoryNo);
    }

    // 사이드바 관심상품 JSON
    public List<Product> getPickProduct(int memberNo) {
        return sqlSession.selectList("mypageMapper.getPickProduct", memberNo);
    }

    public List<Member> recommendBrand(int memberNo) {
        return sqlSession.selectList("mypageMapper.recommendBrand", memberNo);
    }

    public List<Brand> pickBrand(int memberNo) {
        return sqlSession.selectList("mypageMapper.pickBrand", memberNo);
    }

    public List<Reply> getQnA(int memberNo) {
        return sqlSession.selectList("mypageMapper.getQnA", memberNo);
    }

    public List<Product> getReview(int memberNo) {
        return sqlSession.selectList("mypageMapper.getReview", memberNo);
    }

    // 마이페이지 광고 제휴 문의(BOARD 등록)
    public int insertPromotionBoard(Board board) {
        int result = sqlSession.insert("customerMapper.boardInsert", board);
        return result == 1 ? board.getBoardNo() : 0;
    }
    
    // 마이페이지 광고 제휴 문의(이미지 등록)
    public int insertPromotionImage(Image img) {
        return sqlSession.insert("imageMapper.insertImage", img);
    }

    public Company getBusinessInfo(int memberNo) {
        return sqlSession.selectOne("mypageMapper.getBusinessInfo", memberNo);
    }

    public List<QuestCustomer> getPromotionInfo(int memberNo) {
        return sqlSession.selectList("mypageMapper.getPromotionInfo", memberNo);
    }

    // 통합 검색 자식 카테고리 JSON
    public List<Category> getCategory(int categoryNo) {
        int parentNo = categoryNo;
        return sqlSession.selectList("categoryMapper.selectChildCategories", parentNo);
    }

    public int updateProfile(Image img) {
        return sqlSession.update("mypageMapper.updateProfile", img);
    }

    // 마이페이지 광고 제휴 문의(INQUIRY 등록)
    public int insertInquiry(int boardNo, int inquiryCategoryNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardNo", boardNo);
        paramMap.put("inquiryCategoryNo", inquiryCategoryNo);

        return sqlSession.insert("customerMapper.insertInquiry", paramMap);
    }
}
