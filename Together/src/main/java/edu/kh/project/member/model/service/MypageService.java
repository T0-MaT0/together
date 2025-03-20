package edu.kh.project.member.model.service;

import edu.kh.project.member.model.dto.Product;

import java.util.List;

public interface MypageService {
    List<Product> getPurchaseHistory(int memberNo);

    List<Product> getCategoryPick(int categoryNo);

    List<Product> getPickProduct(int memberNo);
}
