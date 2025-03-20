package edu.kh.project.common.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Review {
	private int reviewNo;
	private String reviewContent;
	private int reviewStar;
	private String reviewCreatedDate;
	private String reviewUpdateDate;
	private String reviewDelFleg;
	private int reviewType;
	private int reviewTypeNo;
	private int memberNo;
	
	private String memberNickname;
	private String memberProfile;
	private String businessThumbnail;
	
	private List<Image> imageList;
	private List<Reply> replyList;

  private String boardTitle;          // 댓글이 달린 게시글 제목 (JOIN BOARD)
	private int boardNo;                // 댓글이 속한 게시글 번호
}
