package edu.kh.project.member.model.dto;



public class Board {
	
	private int boardNo;           // 게시글 고유 번호
    private String boardTitle;     // 제목
    private String boardContent;   // 내용
    private String bCreateDate;      // 작성일
    private String bUpdateDate;      // 수정일
    private String boardDelFl;     // 삭제 여부
    private String bState;         // 문의 상태
    private int memberNo;          // 회원 번호
    private int boardCd;           // 게시판 코드
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getbCreateDate() {
		return bCreateDate;
	}
	public void setbCreateDate(String bCreateDate) {
		this.bCreateDate = bCreateDate;
	}
	public String getbUpdateDate() {
		return bUpdateDate;
	}
	public void setbUpdateDate(String bUpdateDate) {
		this.bUpdateDate = bUpdateDate;
	}
	public String getBoardDelFl() {
		return boardDelFl;
	}
	public void setBoardDelFl(String boardDelFl) {
		this.boardDelFl = boardDelFl;
	}
	public String getbState() {
		return bState;
	}
	public void setbState(String bState) {
		this.bState = bState;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public int getBoardCd() {
		return boardCd;
	}
	public void setBoardCd(int boardCd) {
		this.boardCd = boardCd;
	}
	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", bCreateDate=" + bCreateDate + ", bUpdateDate=" + bUpdateDate + ", boardDelFl=" + boardDelFl
				+ ", bState=" + bState + ", memberNo=" + memberNo + ", boardCd=" + boardCd + "]";
	}
	
	
    


}
