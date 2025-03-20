package edu.kh.project.member.model.service;

import edu.kh.project.member.model.dao.MypageDAO;
import edu.kh.project.member.model.dto.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
