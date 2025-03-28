package edu.kh.project.member.model.service;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.member.model.dto.Board;
import edu.kh.project.member.model.dto.Brand;
import edu.kh.project.member.model.dto.Member;
import edu.kh.project.member.model.dto.Product;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface MypageService {
    List<Product> getPurchaseHistory(int memberNo);

    List<Product> getCategoryPick(int categoryNo);

    List<Product> getPickProduct(int memberNo);

    List<Member> recommendBrand(int memberNo);

    List<Brand> pickBrand(int memberNo);

    List<Reply> getQnA(int memberNo);

    List<Product> getReview(int memberNo);

    int insertPromotion(Board board, Image img, MultipartFile file, String filePath);
}
