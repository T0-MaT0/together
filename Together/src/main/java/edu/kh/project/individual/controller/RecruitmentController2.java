package edu.kh.project.individual.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import aj.org.objectweb.asm.Type;
import edu.kh.project.individual.service.RecruitmentService2;

@RestController
public class RecruitmentController2 {

	@Autowired
	private RecruitmentService2 service;
	
	// 모집글 상태 변경
	@PostMapping("/updateRecruitmentStatus")
	public ResponseEntity<Map<String, Object>> updateRecruitmentStatus(@RequestBody Map<String, Integer> requestData) {
        int boardNo = requestData.get("boardNo");
        int loginMemberNo = requestData.get("loginMemberNo");

        Map<String, Object> response = new HashMap<>();

        int hostMemberNo = service.getHostMemberNo(boardNo); // 모집글 방장 ID 가져오기

        if (hostMemberNo != loginMemberNo) {
            response.put("success", false);
            response.put("message", "방장만 모집을 마감할 수 있습니다.");
            return ResponseEntity.ok(response);
        }

        service.updateRecruitmentStatus(boardNo); // 모집 마감 처리

        response.put("success", true);
        return ResponseEntity.ok(response);
    }
}
