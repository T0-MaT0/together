package edu.kh.project.member.model.dao;


import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.member.model.dto.Brand;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.Product;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

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
}
