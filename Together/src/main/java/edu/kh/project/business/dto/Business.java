package edu.kh.project.business.dto;

public class Business {
	private int boardNo;
	private String boardName;
	private String boardTitle;
	private String boardContent;
	private String boardCreateDate;
	private String boardUpdateDate;
	private int readCount;
	private int boardCode;

	// 서브쿼리
	private int commentCount; // 댓글 수
	private int likeCount; // 좋아요 수

	// 회원 join
	private String memberNickname;
	private int memberNo;
	private String profileImage;
	private String thumbnail;

	// 이미지 목록
	//private List<BoardImage> imageList;

	// 댓글 목록
	//private List<Comment> commentList;
}
