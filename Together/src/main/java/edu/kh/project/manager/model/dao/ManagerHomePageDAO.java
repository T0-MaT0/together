package edu.kh.project.manager.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.Image;

@Repository
public class ManagerHomePageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Image> bannerSelect(int imgNo) {
		return sqlSession.selectList("imageMapper.managerBannerList", imgNo) ;
	}

	public int insertImageList(List<Image> uploadList) {
		return /* sqlSession.insert("imageMapper.insertImageList", uploadList) */ 0;
	}

	public int insertImageList(Image img) {
		return sqlSession.insert("imageMapper.insertImage", img);
	}

	public int updateImageList(Image img) {
		return sqlSession.update("imageMapper.updateImage", img);
	}

	public int deleteImageList(Image img) {
		return  sqlSession.delete("imageMapper.deleteImage", img);
	}

	
	// 모든 수락한 광고 이미지 조회
	public List<Image> promotionSelect(int typeImg) {
		return sqlSession.selectList("imageMapper.typeImageList", typeImg);
	}

	// 광고 이미지 삭제 광고 문의 종료 상태 
	public int deletePromotionImage(int imageNo) {
		return sqlSession.delete("imageMapper.deletePromotionImage", imageNo);
	}

	public int updatePromotionState(int imageNo) {
		System.out.println(imageNo);
		return sqlSession.update("imageMapper.updatePromotionState", imageNo);
	}
}
