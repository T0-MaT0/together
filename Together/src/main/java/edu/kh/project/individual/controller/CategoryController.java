package edu.kh.project.individual.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kh.project.common.model.dto.Category;
import edu.kh.project.individual.service.CategoryService;

@Controller
@RequestMapping("/category")
public class CategoryController {

	@Autowired
    private CategoryService categoryService;


    // 2) 자식 카테고리 조회 (AJAX)
    @ResponseBody
    @GetMapping("/children")
    public List<Category> getChildCategories(@RequestParam("parentNo") int parentNo) {
        return categoryService.getChildCategories(parentNo);
    }
}
