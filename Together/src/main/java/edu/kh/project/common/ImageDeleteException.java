package edu.kh.project.common;


// 사용자 정의 예외 만들기
// -> Exception 관련 클래스를 상속 받으면 된다.

// tip. unchecked exception을 만들고 싶으면
// RuntimeException 상속 받아서 구현

// unchecked exception: 예외 처리 선택
// checked exception : 예외 처리 필수
public class ImageDeleteException extends RuntimeException {
	
	public ImageDeleteException() {
		super("파일 업로드 중 예외 발생");
	}
	
	public ImageDeleteException(String message) {
		super(message);
	}
	
	
}
