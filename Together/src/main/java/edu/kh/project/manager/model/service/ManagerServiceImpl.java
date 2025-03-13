package edu.kh.project.manager.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.manager.model.dao.ManagerDAO;

@Service
public class ManagerServiceImpl implements ManagerService {
	
	@Autowired
	private ManagerDAO dao;
	
	@Override
	public int customerQuestionCount() {
		
		return dao.customerQuestionCount();
	}

	@Override
	public int brandQuestCount() {
		return dao.brandQuestCount();
	}

	@Override
	public int brandAdCount() {
		return dao.brandAdCount();
	}
	
	
	
	
}
