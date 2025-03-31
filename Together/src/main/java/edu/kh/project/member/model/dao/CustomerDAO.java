package edu.kh.project.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.common.model.dto.Image;
import edu.kh.project.common.model.dto.Pagination;
import edu.kh.project.common.model.dto.Reply;
import edu.kh.project.member.model.dto.Board;

@Repository
public class CustomerDAO {

	@Autowired 
	private SqlSessionTemplate sqlSession;

	public List<Board> selectNoticeBoardList() {
		return sqlSession.selectList("customerMapper.selectNoticeBoardList");
	}

	public List<Board> selectFAQBoardList(int boardCode) {
		return sqlSession.selectList("customerMapper.selectFAQBoardList", boardCode);
	}

	public int getListCount(int boardCode) {
	
		return sqlSession.selectOne("customerMapper.getListCount", boardCode);
	}


	public List<Board> selectboardList(int boardCode, Pagination pagination) {
		
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit();

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());

		return sqlSession.selectList("customerMapper.selectboardList", boardCode, rowBounds);
	}

	public int getFAQAllListCount() {
		return sqlSession.selectOne("customerMapper.getFAQAllListCount");
	}

	public List<Board> allFAQList(Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit();

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());

		// 파라미터를 전달하지 않아서 페이지네이션이 적용이 안된거
		return sqlSession.selectList("customerMapper.allFAQList", null, rowBounds);
	}

	public Board selectBoardDetail(int boardNo) {
		return sqlSession.selectOne("customerMapper.selectBoardDetail", boardNo);
	}

	public List<Board> selectBeforeAfterBoard(int boardNo) {
		return sqlSession.selectList("customerMapper.selectBeforeAfterBoard", boardNo);
	}

	public int boardInsert(Board board) {

		int result = sqlSession.insert("customerMapper.boardInsert", board);

		// 게시글 삽입 성공 시 boardNo, 실패 시 0 반환

		if(result > 0) result = board.getBoardNo();
		
		return result;
	}

	public int insertImageList(List<Image> uploadList) {
		return sqlSession.insert("customerMapper.insertImageList", uploadList);
	}

	public int getSearchListCount(String query) {
		return sqlSession.selectOne("customerMapper.getSearchListCount", query);
	}

	public List<Board> searchFAQList(String query, Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
	    return sqlSession.selectList("customerMapper.searchFAQList", query, rowBounds);
	}


	public int getSearchNoticeBoardCount(Map<String, Object> map) {
	    return sqlSession.selectOne("customerMapper.getSearchNoticeBoardCount", map);
	}

	public List<Board> selectSearchNoticeBoardList(Map<String, Object> map) {
	    Pagination pagination = (Pagination) map.get("pagination");
	    int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());

	    return sqlSession.selectList("customerMapper.selectSearchNoticeBoardList", map, rowBounds);
	}

	public int getAskListCount(Map<String, Object> map) {
		return sqlSession.selectOne("customerMapper.getAskListCount", map);
	}


	public List<Board> selectAskBoardList(Map<String, Object> map) {
		Pagination pagination = (Pagination) map.get("pagination");
	    int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());

	    return sqlSession.selectList("customerMapper.selectAskBoardList", map, rowBounds);
	}

	public Reply selectReply(int boardNo) {
		 return sqlSession.selectOne("customerMapper.selectReply", boardNo);
	}

	/** 게시글 수정(제목, 내용)
	 * @param board
	 * @return result
	 */
	public int boardUpdate(Board board) {
		return sqlSession.update("customerMapper.boardUpdate", board);
	}

	/** deleteList가 존재하는 지 확인
	 * @param deleteMap
	 * @return result
	 */
	public int checkImageOrder(Map<String, Object> deleteMap) {
		return sqlSession.selectOne("customerMapper.checkImageOrder", deleteMap);
	}

	/** 이미지 삭제
	 * @param deleteMap
	 * @return result
	 */
	public int imageDelete(Map<String, Object> deleteMap) {
		return sqlSession.delete("customerMapper.imageDelete", deleteMap);
	}

	/** 이미지 수정
	 * @param img
	 * @return result
	 */
	public int imageUpdate(Image img) {
		return sqlSession.update("customerMapper.imageUpdate", img);
	}


	/** 이미지 삽입
	 * @param img
	 * @return result
	 */
	public int imageInsert(Image img) {
		return sqlSession.insert("customerMapper.imageInsert", img);
	}

	/** 게시글 삭제
	 * @param boardNo
	 * @return result
	 */
	public int boardDelete(int boardNo) {
		return sqlSession.update("customerMapper.boardDelete", boardNo);
	}

	public int countPinned() {
		return sqlSession.selectOne("customerMapper.countPinned");
	}

	public int updateBStateS(int boardNo) {
		return sqlSession.update("customerMapper.updateBStateS", boardNo);
	}

	public int updateBStateNull(int boardNo) {
		return sqlSession.update("customerMapper.updateBStateNull", boardNo);
	}

	public List<Board> selectFixedNoticeList() {
		return sqlSession.selectList("customerMapper.selectFixedNoticeList");
	}

	public List<Image> imageList(int boardNo) {
		return sqlSession.selectList("customerMapper.imageList", boardNo);
	}



	


}
