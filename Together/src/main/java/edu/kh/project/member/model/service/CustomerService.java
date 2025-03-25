package edu.kh.project.member.model.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileUploadException;
import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.member.model.dto.Board;

public interface CustomerService {

	Map<String, Object> selectBoardList();

	Map<String, Object> noticeBoardList(int cp);

	Map<String, Object> FAQBoardList(int boardCode, int cp);

	Map<String, Object> noticeBoardDetail(int boardNo);

	int boardInsert(Board board, List<MultipartFile> images, String webPath, String filePath) throws IllegalStateException, IOException, FileUploadException;

	Map<String, Object> searchFAQ(String query, int cp);

	Map<String, Object> searchNoticeList(String query, int cp);


}
