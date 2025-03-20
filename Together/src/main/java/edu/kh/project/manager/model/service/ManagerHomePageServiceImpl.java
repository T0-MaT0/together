package edu.kh.project.manager.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.manager.model.dao.ManagerHomePageDAO;

@Service
public class ManagerHomePageServiceImpl implements ManagerHomePageService{

	@Autowired
	private ManagerHomePageDAO dao;
	
	@Override
	public List<Image> bannerSelect() {
		return /* dao.bannerSelect() */ null;
	}

}
