package edu.kh.project.common.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reply {
	  private int replyNo;                // 댓글 고유 번호
	  private String replyCreatedDate;    // 댓글 작성일
	  private String replyDelFlag;        // 삭제 여부
	  private String replyContent;        // 댓글 내용
	  private String secretReplyStatus;   // 비밀글 여부
	  private int memberNo;               // 작성자 회원 번호
	  private int replyType;              // 댓글 유형 (1: 게시판, 2: 리뷰)
	  private int replyTypeNo;            // 댓글이 달린 대상 번호 (BOARD_NO 또는 REVIEW_NO)
	  private int parentNo;               // 부모 댓글 번호 (대댓글일 경우)
	
	  private String boardTitle;          // 댓글이 달린 게시글 제목 (JOIN BOARD)
	  private int boardNo;                // 댓글이 속한 게시글 번호
	  private int replyCount;			  // 대댓글 개수 추가
	  private String profileImg;		  // 댓글 맴버 프로필이미지
	  private String memberNick;		  // 댓글 맴버 닉네임
  	
	  private String memberNickname;

	  private String thumbnail;
	
	  private List<Reply> commentList;
}
