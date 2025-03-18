package edu.kh.project.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import edu.kh.project.member.model.dao.CustomerDAO;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired
	private CustomerDAO dao;
	
	@Autowired 
	private BCryptPasswordEncoder bcrypt;

}
