package edu.kh.project.business.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.business.dao.BusinessDao;

@Service
public class BusinessServiceIml implements BusinessService {
	@Autowired
	private BusinessDao dao;
}
