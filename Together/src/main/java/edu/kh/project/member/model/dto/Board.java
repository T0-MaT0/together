package edu.kh.project.member.model.dto;

public class Board {
	
	private int boardNo;            // 게시글 고유 번호
    private String boardTitle;      // 제목
    private String boardContent;    // 내용
    private String bCreateDate;     // 작성일
    private String bUpdateDate;     // 수정일
    private String boardDelFl;      // 삭제 여부
    private String bState;          // 문의 상태 (ex: 답변대기, 답변완료)
    private int memberNo;			// 작성자(회원 번호)
    private String isFixed;			// 공지사항 고정 여부
    private int inquiryCategoryNo;	// 문의 카테고리 번호 (1: 광고, 2: 제휴, 3: 1:1)

    private String categoryName;	// FAQ 카테고리 이름

    // 기본 생성자
    public Board() {
        super();
    }

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

	public String getIsFixed() {
		return isFixed;
	}

	public void setIsFixed(String isFixed) {
		this.isFixed = isFixed;
	}

	public int getInquiryCategoryNo() {
		return inquiryCategoryNo;
	}

	public void setInquiryCategoryNo(int inquiryCategoryNo) {
		this.inquiryCategoryNo = inquiryCategoryNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", bCreateDate=" + bCreateDate + ", bUpdateDate=" + bUpdateDate + ", boardDelFl=" + boardDelFl
				+ ", bState=" + bState + ", memberNo=" + memberNo + ", isFixed=" + isFixed + ", inquiryCategoryNo="
				+ inquiryCategoryNo + ", categoryName=" + categoryName + "]";
	}
}
