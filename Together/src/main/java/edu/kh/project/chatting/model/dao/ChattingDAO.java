package edu.kh.project.chatting.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.member.model.dto.Member;

@Repository
public class ChattingDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	/** 채팅 목록 조회
	 * @param memberNo
	 * @return chattingList
	 */
	public List<ChattingRoom> getChattingList(int memberNo) {
		
		return sqlSession.selectList("chattingMapper.getChattingList", memberNo);
	}

//	/** 닉네임 또는 이메일로 회원 검색
//	 * @param map
//	 * @return list
//	 */
//	public List<Member> searchTargetList(Map<String, Object> map) {
//		return sqlSession.selectList("chattingMapper.searchTargetList", map);
//	}
//
//	/** 채팅방 입장 없으면 생성
//	 * @param map
//	 * @return chattingNo
//	 */
//	public int checkChattingNo(Map<String, Integer> map) {
//		return sqlSession.selectOne("chattingMapper.checkChattingNo", map);
//	}
//
//	/** 채팅방 생성
//	 * @param map
//	 * @return chattingNo
//	 */
//	public int createChattingRoom(Map<String, Integer> map) {
//		
//		int result = sqlSession.insert("chattingMapper.createChattingRoom", map);
//		int chattingNo = 0;
//		if(result > 0) chattingNo = map.get("chattingNo");
//		
//		return chattingNo;
//	}
//
//	/** 채팅방 읽음 표시
//	 * @param paramMap
//	 * @return result
//	 */
//	public int updateReadFlag(Map<String, Object> paramMap) {
//		return sqlSession.update("chattingMapper.updateReadFlag", paramMap);
//	}
//
//	/** 채팅방 메세지 목록 조회
//	 * @param object
// 	 * @return messageList
//	 */
//	public List<Message> selectMessageList(int chattingNo) {
//		return sqlSession.selectList("chattingMapper.selectMessageList", chattingNo);
//	}
//
//	/** 채팅방 메세지 입력
//	 * @param msg
//	 * @return result
//	 */
//	public int insertMessage(Message msg) {
//		return sqlSession.insert("chattingMapper.insertMessage", msg);
//	}

	
	/** 채팅방 메세지 조회
	 * @param paramMap
	 * @return messageList
	 */
	public List<Message> selectMessageList(Map<String, Object> paramMap) {
		return sqlSession.selectList("chattingMapper.selectMessageList", paramMap);
	}

	/** 상대방 프로필
	 * @param roomNo
	 * @param memberNo
	 * @return
	 */
	public Member selectChatTarget(int roomNo, int memberNo) {
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("roomNo", roomNo);
	    paramMap.put("loginMemberNo", memberNo);

	    return sqlSession.selectOne("chattingMapper.selectChatTarget", paramMap);
	}

}
