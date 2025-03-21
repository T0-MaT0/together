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
		return sqlSession.insert("imageMapper.insertImageList", uploadList);
	}
}
