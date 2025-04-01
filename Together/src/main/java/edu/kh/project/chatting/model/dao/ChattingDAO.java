package edu.kh.project.chatting.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.chatting.model.dto.ChatEmoji;
import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.individual.dto.Image;
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
		
		List<ChattingRoom> chattingList = sqlSession.selectList("chattingMapper.getChattingList", memberNo);
		System.out.println("chattingList : " + chattingList);
		return chattingList;
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
	public List<Object> selectChatTarget(int roomNo, int memberNo) {
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("roomNo", roomNo);
	    paramMap.put("loginMemberNo", memberNo);

	    return sqlSession.selectList("chattingMapper.selectChatTarget", paramMap);
	}

	public int deleteRoom(int roomNo) {
		return sqlSession.update("chattingMapper.deleteRoom", roomNo);
	}

	public int selectOwnerNo(int roomNo) {
		return sqlSession.selectOne("chattingMapper.selectOwnerNo", roomNo);
	}

	
	/** 채팅방 메세지 입력
	 * @param msg
	 * @return result
	 */
	public int insertMessage(Message msg) {
		return sqlSession.insert("chattingMapper.insertMessage", msg);
	}

	// 메세지 이미지 입력
	public int insertImageMessage(Message msg) {
		return sqlSession.insert("chattingMapper.insertImageMessage", msg);
	}
	
	// 메세지 이미지 입력
	public void insertChatImage(Image img) {
		sqlSession.insert("chattingMapper.insertChatImage", img);
	}

	// 메세지 큰 이모지 조회
	public List<ChatEmoji> selectBigEmojiList() {
		return sqlSession.selectList("chattingMapper.selectBigEmojiList");
	}

	// 모집하기 생성 시 채팅방 생성
	public int createGroupChatRoom(Map<String, Object> map) {
		return sqlSession.insert("chattingMapper.createGroupChatRoom", map);
	}

	// 채팅방 사용자 등록
	public void insertChatRoomUser(int roomNo, int ownerNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("roomNo", roomNo);
	    map.put("memberNo", ownerNo);
		sqlSession.insert("chattingMapper.insertChatRoomUser", map);
		
	}

	// 채팅방 삭제 시 채팅방 사용자 삭제
	public void deleteRoomUsers(int ownerNo, int memberNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("ownerNo", ownerNo);
	    map.put("memberNo", memberNo);
		sqlSession.delete("chattingMapper.deleteRoomUsers", map);
		
	}
	
	// 참가하기 시 채팅방 참여(roomName 조회)
	public String selectBoardTitle(int boardNo) {
		return sqlSession.selectOne("chattingMapper.selectBoardTitle", boardNo);
	}

	// 참가하기 시 채팅방 참여(roomNo 조회)
	public int selectRoomNoByRoomName(String roomName) {
		return sqlSession.selectOne("chattingMapper.selectRoomNoByRoomName", roomName);
	}

	// 채팅 방 나가기
	public void deleteChatRoomUser(int roomNo, int memberNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("roomNo", roomNo);
	    map.put("memberNo", memberNo);
		sqlSession.delete("chattingMapper.deleteChatRoomUser", map);
	}

	// 채팅방 참가자 조회
	public List<Member> selectRoomMemberList(int roomNo) {
		return sqlSession.selectList("chattingMapper.selectRoomMemberList", roomNo);
	}

	// 채팅방 이름
	public ChattingRoom selectRoomName(int roomNo) {
		return sqlSession.selectOne("chattingMapper.selectRoomName", roomNo);
	}

	// 참가자 추방
	public int kickMemberFromRoom(int roomNo, int targetMemberNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("roomNo", roomNo);
	    map.put("memberNo", targetMemberNo);
		return sqlSession.delete("chattingMapper.kickMemberFromRoom", map);
	}

	// 1대1 채팅방 생성
	public int insertPrivateChatRoom(Map<String, Object> map) {
		int result = sqlSession.insert("chattingMapper.insertPrivateChatRoom", map);
	    int roomNo = 0;
	    if (result > 0) roomNo = (int) map.get("roomNo");
	    return roomNo;
	}

	// 1대1 채팅방 중복 체크
	public Integer checkPrivateRoom(int myMemberNo, int targetMemberNo) {
	    Map<String, Integer> map = new HashMap<>();
	    map.put("myMemberNo", myMemberNo);
	    map.put("targetMemberNo", targetMemberNo);

	    return sqlSession.selectOne("chattingMapper.checkPrivateRoom", map);
	}

	// 그룹 채팅방 중복 체크
	public int checkDuplicateGroupChatRoom(String roomName, int ownerNo) {
		Map<String, Object> map = new HashMap<>();
	    map.put("roomName", roomName);
	    map.put("ownerNo", ownerNo);
		return sqlSession.selectOne("chattingMapper.checkDuplicateGroupChatRoom", map);
	}


	

}
