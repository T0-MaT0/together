package edu.kh.project.manager.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.manager.model.dao.ManagerHomePageDAO;
import edu.kh.project.manager.model.exception.FileUploadException;

@Service
public class ManagerHomePageServiceImpl implements ManagerHomePageService{

	@Autowired
	private ManagerHomePageDAO dao;
	
	@Override
	public List<Image> bannerSelect(int imgNo) {
		return dao.bannerSelect(imgNo);
	}

	@Override
	public int submit(String webPath, List<MultipartFile> images, int typeNo, String filePath) {
		
		
		List<Image> uploadList = new ArrayList<Image>();

		//images에 담겨 있는 파일 중 실제로 업로드된 파일만 분류
		for(int i =0; i<images.size(); i++) { // 0~4


			//i 번재 요소에 업로드한 파일이 있다면
			if(images.get(i).getSize() > 0) {
				Image img = new Image();


				//img에 파일 정보를 담아서 uploadList에 추가
				img.setImagePath(webPath);// 웹 접근경로
				
				String fileName = images.get(i).getOriginalFilename();
				img.setImageReName(Utill.fileRename(fileName));// 파일 변경명
				img.setImageOriginal(fileName);//파일 원본명


				img.setImageLevel(i); // 이미지 순서
				img.setImageType(6);
				img.setImageTypeNo(typeNo);

				uploadList.add(img);


			}



		}

		// 분류 작업 후 uploadList가 비어있지 않는 경우
		if(!uploadList.isEmpty()) {
			//insert
			int result = dao.insertImageList(uploadList);

			// 삽입된 행의 개수와 uploadList의 개수가 같다면 전체 insert 성공
			if(result == uploadList.size()) {


				// images : 실제 파일이 담긴 객체 리스트
				//( 업로드가 안된 인덱스 빈칸)

				// uploadList :  업로드된 파일의 정보 리스트
				//(원본명, 변경명, 순서, 경로, 게시글 번호)

				// uploadList의 순서 == images 업로드된 인덱스
				for(int i =0; i<uploadList.size(); i++) {
					int index = uploadList.get(i).getImageLevel();

					// 변경명
					String rename = uploadList.get(i).getImageReName();

					try {
						images.get(index).transferTo(new File(filePath + rename));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

			}else {// 일부 또는 전체 insert 실패
				// * 웹 서비스 수행 중 1개라도 실패하면 전체 실패 *
				// -> rollback 필요

				// @Transactional(rollbackFor = Exception.class)
				// -> 예외가 발생해야만 록백함

				// 따라서 예외를 강제로 발생 시켜서 rollback 해야함!
				// -> 사용자 정의 예외 생성
				throw new FileUploadException(); // 예외 강제 발생
			}
		}

		return 0;
	}


}
