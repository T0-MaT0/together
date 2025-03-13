package edu.kh.project.common.scheduling;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ImageDeleteScheduling {
	   @Autowired
	   private ServletContext servletContext;
	
	   @Scheduled(cron = "0 0 1 1 * *")   // 매 정시(*시 0분 0초)
	   public void test() {
	      System.out.println("---------- 게시판 DB, 서버 불일치하는 파일 제거 ----------");
	      String filePath = servletContext.getRealPath("/resources/images/board");
	      File path = new File(filePath);
	      File[] imageArr = path.listFiles();
	      // C:\workspace\6_Framework\boardProject\src\main\webapp\resources\images\board
	      
	      List<File> serverImageList = Arrays.asList(imageArr);
	      // List<String> dbImageList = service.selectImageList();
	      
//	      if (!serverImageList.isEmpty()) {
//	         for(File serverImage:serverImageList) {
//	            if (dbImageList.indexOf(serverImage.getName())==-1) {
//	               System.out.println(serverImage.getName()+"삭제");
//	               serverImage.delete();
//	            }
//	         }   // for문 종료
//	         System.out.println("---------- 이미지 파일 삭제 스케줄러 종료 ----------");
//	      }
	   }
}
